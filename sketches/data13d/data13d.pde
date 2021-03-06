//Scatterplot (usare appended_data come base e modificarlo)

color[] palette = {#F5FAF6, #0E1B29, #87030B, #D9DA37, #9BC3AE};
PFont font;//aggiunta la font
int c;//colore di fill dei pallozzi relativi al mouseover

Table stateData;
int rowCount;

import controlP5.*;

ControlP5 cp5;

boolean pulsante = false;
boolean pulsante2 = false;

void setup() {
  size(630, 630);
  stateData = loadTable("gdp-f.tsv", "header");
  rowCount = stateData.getRowCount();
  println("rowCount =" + rowCount);
  font = createFont("Karla-Bold-13.vlw", 11);//aggiunta la font
  smooth();
  
  cp5 = new ControlP5(this);
  
  // creare il primo pulsante
  cp5.addToggle("pulsante")
     .setPosition(width/4*3,100)
     .setSize(20,20)
     .setColorLabel(55)
     .setLabel("Da 0 a 3")
     .setColorBackground(#D1D1D1)//colore a riposo
     .setColorForeground(#A0A0A0)//colore on hover
     .setColorActive(#545554)//colore se selezionato
     ;
     
  // create a toggle 2
  cp5.addToggle("pulsante2")
     .setPosition(width/4*3,200)
     .setSize(20,20)
     .setColorLabel(55)
     .setLabel("Da 3 a 7")
     .setColorBackground(#D1D1D1)//colore a riposo
     .setColorForeground(#A0A0A0)//colore on hover
     .setColorActive(#545554)//colore se selezionato
     ;
}

void draw() {
  background(palette[0]);
  textFont(font);
  
  //linee e label per l'asse delle X
  textAlign(CENTER);
  stroke(70);
  line(30, 600, 600, 600);//linea di base per le X
  fill(30);
  text("GDP/Fertility rate", width/2, 20);
  for(int i = 0; i < 7; i++) { //questo loop serve per i numeri di riferimento sull'asse delle x (quindi vanno inseriti i valori minimi e massimi di x)
    fill(60);
    text(i, i*(570/7)+30, 620);
  }
  
  //linee e label per l'asse delle Y
  textAlign(RIGHT);
  stroke(70);
  line(30, 30, 30, 600);//linea di base per le Y
  for(int i = 0; i < 699; i+=30) { //questo loop serve per i numeri di riferimento sull'asse delle y (i+=10 perché non voglio tutti e 133 i numeri, ma di 10 in 10)
    float y = map(i, 0, 699, 600, 30);
    fill(60);
    text(i, 25, y);
  }

  //non mi serve flippare perché uso map (vd. infra)
  //scale(1, -1);
  //translate(0, -height);
  for(int row = 0; row < rowCount; row++) {
    String state = stateData.getString(row, 0);//dammi i valori della colonna 0 (ovvero gli stati)
    float fertility = stateData.getFloat(row, 2);//dammi i valori della colonna 1 (ovvero il fertility rate)
    float gdp = stateData.getFloat(row, 1);//dammi i valori della colonna 2 (ovvero il gdp)
    float x = map(fertility, 0, 7, 0, 600);//rimappo i valori per associarli alla mia scala (cioè a size)
    float y = map(gdp, 4, 699, 600, 50);//rimappo i valori per associarli alla mia scala (cioè a size)
    noStroke();
     
  if(dist(x, y, mouseX, mouseY) < (10/2)) {//calcola la distanza tra due punti: se il mouse è vicino al centro del cerchio, allora mostra il nome del paese
      textAlign(LEFT);
      fill(30);
      text(state, x, y-10);//mostra il nome del paese in mouseover
      c=palette[1];
  } else {
      c=palette[4];
         }
         
    
  if(pulsante==true && fertility < 3) {
    c=24;
    pulsante2=false;
  } 
  
  if(pulsante2==true && fertility > 3) {
    c=24;
    pulsante=false;
  } 
  
  fill(c, 130);
  ellipse(x, y, 10, 10);//crea i pallini
  }
}