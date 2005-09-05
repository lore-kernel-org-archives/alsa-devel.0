From: Raymond <rayau@netvigator.com>
Subject: Re: Alsa mix in HW
Date: Mon, 05 Sep 2005 10:32:41 +0800
Message-ID: <431BAE49.8090300@netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030300010804030606060104"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Dino Puller <dino@e4a.it>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030300010804030606060104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

How can I link the demo.cpp (a simple openal/opengl program) with the 
openal-alsa ? (It can be executed when link with openal)

The demo.cpp is not yet completed and seem to have a bug in the 
positioning of Camera.

The Radar (The Cone) are rotated at the base instead of the vortex.


> Dino wrote:

>> Raymond wrote:
>
> >> Dino wrote:
> >>
> >
> >> But openal-alsa works for you? Did you noticed a system improvement?
> >> I've obtained 2fps in ut2004 about 5% not bad :)
> >
> >
> > NO,  I cannot link any demo using the re-compiled openal-alsa library.
>
> Why? Can you give me an output? I've tried with americas army e some
> stupids examples without problem, obviuslly it's not a complete library.
>
> >
> >> bye,
> >> Dino
> >
>



--------------030300010804030606060104
Content-Type: text/x-c++;
 name="demo.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="demo.cpp"

/**********************************************************************
	
  DEMO  OpenGL/OpenAL (3D Spatalization)

  Listener (OpenAL) - Camera (OpenGL)
  Source Helicopter - rotating about the origin.
  Source Radar      - rotating along z-axis
  Source Van        - Moving on xy plane 

  FIX ME
  1) The movment of camera seem to be wrong. 
  2) The Radar should rotate at the vertex instead of the base 

  TO DO
  1) Add control to adjust height, path and speed of the Helicopter.
  2) Add control to adjust the cone of inner/outer angle of the Radar.
  3) use joystick to move listener/camera
  4) make it conformed to OpenAL 1.1 specification.

  Function:- 
  1) Attenutation By Distance
  2) Panning Left/Right 
  3) Doppler Effect (Not completed) 
  4) Angle of Cone (Not completed)
  5) Background Music (Not yet implemented)

***********************************************************************/
#include <GL/glut.h>
#include <AL/al.h>
#include <AL/alc.h>
#include <AL/alut.h>
#include <iostream>
#include <math.h>
#include <sys/timeb.h>

#define PI 3.1415265359
#define PIdiv180 3.1415265359/180.0

int LastUpdate=0;

int GetTime()
{
	timeb t;

	ftime(&t);

	return 1000 * t.time + t.millitm;
}

void OnIdle()
{
	static int nLastTime = GetTime();
	static int nFrameCount = 0;

	if (nFrameCount++ == 100)
	{
		float fFPS = 100000.0f/static_cast<float>(GetTime() - nLastTime);
		char Title[256];

		sprintf(Title, "Demo 3D - %.2f FPS", fFPS);
		glutSetWindowTitle(Title);

		nFrameCount = 0;
		nLastTime = GetTime();
	}

	glutPostRedisplay();
}

struct SF3dVector  
{
	GLfloat x,y,z;
};
struct SF2dVector
{
	GLfloat x,y;
};

class CCamera
{
private:
	SF3dVector Position;
	SF3dVector ViewDir;		
	bool ViewDirChanged;
	GLfloat RotatedX, RotatedY, RotatedZ;	
	void GetViewDir ( void );
public:
	CCamera();		
	void Render ( void );	
				
	void Move ( SF3dVector Direction );
	void RotateX ( GLfloat Angle );
	void RotateY ( GLfloat Angle );
	void RotateZ ( GLfloat Angle );
	void RotateXYZ ( SF3dVector Angles );
	void MoveForwards ( GLfloat Distance );
	void StrafeRight ( GLfloat Distance );
};

CCamera Camera;

#define NUM_BUFFERS 5
#define NUM_SOURCES 5
#define NUM_ENVIRONMENTS 1

ALfloat listenerPos[3];
ALfloat listenerVel[3]={0.0,0.0,0.0};
ALfloat	listenerOri[]={0.0,0.0,0.0, 1.0, 0.0,0.0};

struct {
	ALfloat Pos[3];
	ALfloat Vel[3];
	ALfloat rgb[3];
	ALfloat polar_distance,angle;
        ALboolean playing;
} source_3d[NUM_SOURCES];

ALuint	buffer[NUM_BUFFERS];
ALuint	source[NUM_SOURCES];
ALuint  environment[NUM_ENVIRONMENTS];
int 	GLwin;

void set_listener_pos(ALfloat x,ALfloat y,ALfloat z)
{
	listenerPos[0]=x;
	listenerPos[1]=y;
	listenerPos[2]=z;
	alListenerfv(AL_POSITION,listenerPos);
}

void set_source_pos(int idx,ALfloat x,ALfloat y,ALfloat z)
{
	source_3d[idx].Pos[0]=x;
	source_3d[idx].Pos[1]=y;
	source_3d[idx].Pos[2]=z;
}

void set_source_vel(int idx,ALfloat x,ALfloat y,ALfloat z)
{
	source_3d[idx].Vel[0]=x;
	source_3d[idx].Vel[1]=y;
	source_3d[idx].Vel[2]=z;
}

void set_source_rgb(int idx,ALfloat r,ALfloat g,ALfloat b)
{
	source_3d[idx].rgb[0]=r;
	source_3d[idx].rgb[1]=g;
	source_3d[idx].rgb[2]=b;
}

SF3dVector F3dVector ( GLfloat x, GLfloat y, GLfloat z )
{
	SF3dVector tmp;
	tmp.x = x;
	tmp.y = y;
	tmp.z = z;
	return tmp;
}
SF3dVector AddF3dVectors (SF3dVector* u, SF3dVector* v)
{
	SF3dVector result;
	result.x = u->x + v->x;
	result.y = u->y + v->y;
	result.z = u->z + v->z;
	return result;
}
void AddF3dVectorToVector ( SF3dVector * Dst, SF3dVector * V2)
{
	Dst->x += V2->x;
	Dst->y += V2->y;
	Dst->z += V2->z;
}

/***************************************************************************************/

CCamera::CCamera()
{
	//Init with standard OGL values:
	Position = F3dVector (	0.0, 2.0, 0.0);
	set_listener_pos(Position.x,Position.y,Position.z);
	ViewDir = F3dVector( 0.0, -1.0, 0.0);
	ViewDirChanged = true;
	//Only to be sure:
	RotatedX = RotatedY = RotatedZ = 0.0;
}

void CCamera::GetViewDir( void )
{
	SF3dVector Step1, Step2;
	//Rotate around Y-axis:
	Step1.x = cos( (RotatedY + 90.0) * PIdiv180);
	Step1.z = -sin( (RotatedY + 90.0) * PIdiv180);
	//Rotate around X-axis:
	double cosX = cos (RotatedX * PIdiv180);
	Step2.x = Step1.x * cosX;
	Step2.z = Step1.z * cosX;
	Step2.y = sin(RotatedX * PIdiv180);
	//Rotation around Z-axis not yet implemented, so:
	ViewDir = Step2;
}

void CCamera::Move (SF3dVector Direction)
{
	AddF3dVectorToVector(&Position, &Direction );
}


void CCamera::RotateZ (GLfloat Angle)
{
	RotatedZ += Angle;
	ViewDirChanged = true;
}

void CCamera::RotateY (GLfloat Angle)
{
	RotatedY += Angle;
	ViewDirChanged = true;
}

void CCamera::RotateX (GLfloat Angle)
{
	RotatedX += Angle;
	ViewDirChanged = true;
}

void CCamera::Render( void )
{
	glRotatef(-RotatedX , 1.0, 0.0, 0.0);
	glRotatef(-RotatedY , 0.0, 1.0, 0.0);
	glRotatef(-RotatedZ , 0.0, 0.0, 1.0);
	glTranslatef( -Position.x, -Position.y, -Position.z );
}

void CCamera::MoveForwards( GLfloat Distance )
{
	if (ViewDirChanged) GetViewDir();
	SF3dVector MoveVector;
	MoveVector.x = ViewDir.x * -Distance;
	MoveVector.y = ViewDir.y * -Distance;
	MoveVector.z = ViewDir.z * -Distance;
	AddF3dVectorToVector(&Position, &MoveVector );
	set_listener_pos(Position.x,Position.y,Position.z);
}

void CCamera::StrafeRight ( GLfloat Distance )
{
	if (ViewDirChanged) GetViewDir();
	SF3dVector MoveVector;
	MoveVector.y = -ViewDir.x * -Distance;
	MoveVector.x =  ViewDir.y * -Distance;
	MoveVector.z = 0.0;
	AddF3dVectorToVector(&Position, &MoveVector );
}

void reshape(int x, int y)
{
	if (y == 0 || x == 0) return;  
	
	//Set a new projection matrix
	glMatrixMode(GL_PROJECTION);  
	glLoadIdentity();
	//Angle of view:40 degrees
	//Near clipping plane distance: 0.5
	//Far clipping plane distance: 20.0
	gluPerspective(40.0,(GLdouble)x/(GLdouble)y,0.1, 100.0);

	glMatrixMode(GL_MODELVIEW);
	glViewport(0,0,x,y);  
}

void Display(void)
{
	int i;
	ALfloat direction[3];
	GLfloat polar_distance,polar_angle;
	glClear(GL_COLOR_BUFFER_BIT);
	glLoadIdentity();
	Camera.Render();
	glRotatef(-90.0, 1.0, 0.0, 0.0);

	glTranslatef(0.0, 8.0 , 1.0);
	glScalef(1.0,1.0,1.0);

/*
	Draw reference plane
*/	
	
	glColor3f(1.0,1.0,1.0);
	glPushMatrix();
	glTranslatef(0.0, 0.0 ,0.0);
	glBegin(GL_LINES);
	for (int xc = 0; xc <= 100; xc++) {
	    	glVertex3f( -50.0 + xc ,  50.0, 0.0);
	    	glVertex3f( -50.0 + xc , -50.0, 0.0);
        }
	for (int yc = 0; yc <= 100; yc++) {
		glVertex3f(  50.0, -50.0 + yc, 0.0 );
		glVertex3f( -50.0, -50.0 + yc, 0.0 );
	}
	glEnd();
	glPopMatrix();

	if ( LastUpdate != 0 ) {
		float fSecs = static_cast<float>(GetTime() - LastUpdate)/1000.0;
/*
        Calculation of 3D position of the sound source 
	Helicopter - circular path around the origin
        Radar      - rotate around the origin
        Van        - moving headon to listener 
                   - moving left/right in front of listener
                   - path around the origin

*/
	        source_3d[0].angle+= fSecs;
                if ( source_3d[0].angle > 360.0 )
			source_3d[0].angle -= 360.0;
		
		source_3d[1].angle -= fSecs*100.0;
		if ( source_3d[1].angle < -360.0 )
			source_3d[1].angle += 360.0;
	
                source_3d[2].Pos[1] += source_3d[2].Vel[1] * fSecs;	
		if ( source_3d[2].Pos[1] < -99.0 ) {
		     source_3d[2].Pos[1] =  99.0;
		};

		source_3d[3].Pos[0]+= source_3d[3].Vel[0] * fSecs;
		if ( fabs(source_3d[3].Pos[0]) > 101.0 ) {
		    if ( source_3d[3].Pos[0] > 0.0 )
                         source_3d[3].Vel[0] = -fabs(source_3d[3].Vel[0]);
		    else
		         source_3d[3].Vel[0] = fabs(source_3d[3].Vel[0]);
	        };

	        source_3d[4].angle -= fSecs * 0.01;
                if ( source_3d[4].angle < -360.0 )
			source_3d[4].angle += 360.0;

	};
	LastUpdate = GetTime();

	for (i=0; i<NUM_SOURCES; i++) {
		switch(i){
		case 0:
		    polar_distance=source_3d[i].polar_distance;
		    source_3d[i].Pos[0]=polar_distance*sin(source_3d[i].angle);
		    source_3d[i].Pos[1]=polar_distance*cos(source_3d[i].angle);
		    alSourcefv(source[i],AL_POSITION,source_3d[i].Pos);
		    break;
		case 1:
		    direction[0]=sin(source_3d[i].angle);
		    direction[1]=cos(source_3d[i].angle);
		    direction[2]=0.0;
		    alSourcefv(source[i],AL_DIRECTION,direction);
		    break;
		case 2:
		case 3:
		    alSourcefv(source[i],AL_POSITION,source_3d[i].Pos);
		    alSourcefv(source[i],AL_VELOCITY,source_3d[i].Vel);
		    break;
		case 4:
		    polar_angle=source_3d[i].angle;
		    source_3d[i].Pos[0]= 200.0*sin(polar_angle)*sin(polar_angle*2)*sin(polar_angle*4)*sin(polar_angle*8)*sin(polar_angle*16);
		    source_3d[i].Pos[1]= 200.0*cos(polar_angle)*cos(polar_angle*2)*cos(polar_angle*4)*cos(polar_angle*8)*cos(polar_angle*16);
		    alSourcefv(source[i],AL_POSITION,source_3d[i].Pos);
		    break;
		};
/*
	Draw sound sources
*/
		glPushMatrix() ;
		glTranslatef(source_3d[i].Pos[0],source_3d[i].Pos[1],source_3d[i].Pos[2]) ;
		glColor3f(source_3d[i].rgb[0],source_3d[i].rgb[1],source_3d[i].rgb[2]) ;
		switch(i){
/*
	Helicopter
*/
		case 0:
			if ( source_3d[i].playing )
				glutSolidSphere(0.5,3,3) ;
			else
				glutWireSphere(0.5,3,3) ;
			glTranslatef(0.0,0.0,0.5) ;
			glutWireCone(1.0,0.01, 16 ,0);
			break;
/*
	Radar
*/
		case 1:
			polar_angle=source_3d[i].angle;
			polar_distance=source_3d[i].polar_distance;
			glRotatef(90.0, 1.0, 0.0, 0.0) ;
			glRotatef(polar_angle,0.0, 1.0, 0.0) ;
//			if ( source_3d[i].playing )
//				glutSolidCone(polar_distance,1.0,6,0);
//			else				
				glutWireCone(polar_distance,1.0,6,0);
			break;
/*
	Van
*/
		case 2:
		case 3:
		case 4:
			if ( source_3d[i].playing )
				glutSolidCube(0.5) ;
			else
				glutWireCube(0.5) ;
			break;
		};
		glPopMatrix() ;
	};
 	

	glFlush();  
	glutSwapBuffers();

}
/*

ESC	: exit
1,2,3,4 : toggle on/off sound sources

*/
void cbKeyPressed(unsigned char key, int x, int y)
{
	int i;
	switch (key) {
	case '1':
	case '2':
	case '3':
	case '4':
		i=key-'1';
		if ( source_3d[i].playing ) {
			alSourceStop(source[i]);
			source_3d[i].playing=false;
		}
		else {
			alSourcePlay(source[i]);
			source_3d[i].playing=true;
		};
		break;
	case 27:		//ESC
		glutDestroyWindow(GLwin);
		exit(0);
		break;
	}
}

void cbSpecialKeyPressed(int key, int x, int y)
{
	switch(key) {
	case GLUT_KEY_F1:
		Camera.Move(F3dVector(0.0,-0.3,0));
		Display();
		break;
	case GLUT_KEY_F2:
		Camera.Move(F3dVector(0.0,0.3,0.0));
		Display();
		break;
        case GLUT_KEY_RIGHT:	
		Camera.RotateY(-5.0);
		Display();
                break;
        case GLUT_KEY_LEFT: 	
		Camera.RotateY(5.0);
		Display();
                break;
        case GLUT_KEY_UP: 	
		Camera.MoveForwards( -0.1 ) ;
		Display();
                break;
        case GLUT_KEY_DOWN: 	
		Camera.MoveForwards( 0.1 ) ;
		Display();
                break;
    	}
}

void init_al(void)
{
	ALsizei size,freq;
	ALenum 	format;
	ALvoid 	*data;
    	ALboolean loop;
	int 	ch;
    	int 	i;
    	
	alutInit(0, NULL);

	alListenerfv(AL_POSITION,listenerPos);
	alListenerfv(AL_VELOCITY,listenerVel);
	alListenerfv(AL_ORIENTATION,listenerOri);

	source_3d[0].polar_distance= 10.0;
	set_source_pos(0, source_3d[0].polar_distance, 0.0, 2.0);
	set_source_vel(0, 0.0, 0.1, 0.0);
	set_source_rgb(0, 0.0, 1.0, 1.0);

	source_3d[1].polar_distance=0.4;
	set_source_pos(1, 0.0, 0.0, 2.0);
	set_source_vel(1, 0.0, 0.0, 0.0);
	set_source_rgb(1, 1.0, 1.0, 0.0);

	set_source_pos(2, 0.0,  50.0,  0.0);
	set_source_vel(2, 0.0,  -5.0,  0.0);
	set_source_rgb(2, 1.0,   0.0,  0.0);

	set_source_pos(3,-20.0, 0.0, 0.0);
	set_source_vel(3, 7.0, 0.0, 0.0);
	set_source_rgb(3, 0.0,  1.0, 0.0);

	source_3d[4].polar_distance= 40.0;
	set_source_pos(4, 0.0, 0.0, 0.0);
	set_source_vel(4, 0.0, 0.0, 0.0);
	set_source_rgb(4, 0.0, 0.0, 1.0);

    	alGetError(); // clear any error messages
    
	if(alGetError() != AL_NO_ERROR) {
	        printf("- Error creating buffers !!\n");
	};
    
     	alGenBuffers(NUM_BUFFERS, buffer);

	loop=AL_TRUE;
    
	for (i=0; i<NUM_SOURCES; i++) {
		switch(i) {
		case 0:
			alutLoadWAVFile((ALbyte*)"heli.wav",&format,&data,&size,&freq,&loop);
			break;
		case 1:
			alutLoadWAVFile((ALbyte*)"radar.wav",&format,&data,&size,&freq,&loop);
			break;	
		case 2:
			alutLoadWAVFile((ALbyte*)"van.wav",&format,&data,&size,&freq,&loop);
			break;
		case 3:
			alutLoadWAVFile((ALbyte*)"van.wav",&format,&data,&size,&freq,&loop);
			break;
		case 4:
			alutLoadWAVFile((ALbyte*)"van.wav",&format,&data,&size,&freq,&loop);
			break;
		};
    		alBufferData(buffer[i],format,data,size,freq);
    		alutUnloadWAV(format,data,size,freq);
	};

	alGetError(); /* clear error */
    	alGenSources(NUM_SOURCES, source);

    	if(alGetError() != AL_NO_ERROR) {
		printf("- Error creating sources !!\n");
	};
	for (i=0; i<NUM_SOURCES; i++) {
	    alSourcef(source[i],AL_PITCH,1.0f);
	    alSourcef(source[i],AL_GAIN,1.0f);
	    alSourcefv(source[i],AL_POSITION,source_3d[i].Pos);
	    alSourcefv(source[i],AL_VELOCITY,source_3d[i].Vel);
	    alSourcei(source[i],AL_BUFFER,buffer[i]);
	    alSourcei(source[i],AL_LOOPING,AL_TRUE);
	    source_3d[i].playing=true;
	    alSourcePlay(source[i]);
	};

	alSourcef(source[1],AL_CONE_INNER_ANGLE, 90.0);
	alSourcef(source[1],AL_CONE_OUTER_ANGLE, 180.0);


}

int main(int argc, char **argv)
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
	glutInitWindowSize(640,400);

	init_al() ;

	GLwin=glutCreateWindow("Demo 3D Sound");

//	Camera.Move( F3dVector(0.0, 1.0, 0.0 ));
//	Camera.MoveForwards( -2.0 );
	glutDisplayFunc(Display);
	glutReshapeFunc(reshape);
	glutKeyboardFunc(&cbKeyPressed);
        glutSpecialFunc(&cbSpecialKeyPressed);
	glutIdleFunc(OnIdle);
	glutMainLoop();
	return 0;             
}

--------------030300010804030606060104--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
