PImage image;
String filename = "ISS019-E-014918_lrg.jpg";

int row = 0;
int column = 0;
int threshold = 50;



//---------------------------------------------------
void setup()
{
  noLoop(); 
  image = loadImage( filename );
  size( image.width, image.height );
  image( image, 0, 0 );
}



//---------------------------------------------------
void draw()
{
  image.loadPixels();

  //sort columns
  for( ; column < width-1; column++ ) sortColumn();
  
  //sort rows  
  for( ; row < height-1; row++ ) sortRow();

  //SORT ALL THE THINGS!!!!!1
  //image.pixels = sort( image.pixels );
  
  image.updatePixels();   
  image( image, 0, 0 );
}



//---------------------------------------------------
void sortColumn()
{
  color[] columnArray = new color[image.height];

   
  //load column into pixel array
  for( int i = 0; i < image.height; i++ ) 
    columnArray[i] = image.pixels[ column + i * image.width ];
  
  
  //SORT
  columnArray = sort( columnArray );
  
  
  //load array into pixels
  for( int i = 0; i < image.height; i++ ) 
    image.pixels[ column + i * image.width ] = columnArray[i];
  
}



//---------------------------------------------------
void sortColumnSegment( int yStart, int sortLength )
{ 
  color[] unsorted = new color[sortLength];
  color[] sorted = new color[sortLength];
  
  
  //load image pixels into array
  for( int i = 0; i < sortLength; i++ ) 
    unsorted[i] = image.pixels[ column + ( yStart + i ) * image.width];
  
  
  //SORT
  sorted = sort( unsorted );
  
  
  //load array into pixels
  for( int i = 0; i < sortLength; i++ ) 
    image.pixels[ column + (yStart + i) * image.width ] = sorted[i];
}



//---------------------------------------------------
void sortRow()
{
  //get row
  color rowArray[] = subset( image.pixels, row * image.width, image.width );
  
  //sort row
  rowArray = sort( rowArray );
  
  //put row back
  for( int i = 0; i < image.width; i++ )
    image.pixels[ i + (row * image.width) ] = rowArray[i];
}



//---------------------------------------------------
void sortRowSegment( int xStart, int sortLength )
{
  color unsorted[] = new color[sortLength];
  color sorted[] = new color[sortLength];
  
  
  //load image pixels into array
  for( int i = 0; i < sortLength; i++ ) 
    unsorted[i] = image.pixels[ xStart + i + (row * image.width) ]; 
  
  
  //SORT
  sorted = sort( unsorted );
  
  
  //load array into pixels
  for( int i = 0; i < sortLength; i++ ) 
    image.pixels[ xStart + i + (row * image.width) ] = sorted[i];
}
