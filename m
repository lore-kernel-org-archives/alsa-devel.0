From: "mahendra  sp" <mahendra_sp@rediffmail.com>
Subject: Playback underrun
Date: 5 Jul 2003 12:57:05 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030705125705.13640.qmail@webmail26.rediffmail.com>
Reply-To: "mahendra  sp" <mahendra_sp@rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
Cc: James@superbug.demon.co.uk, raphael@math.umass.edu
List-Id: alsa-devel@alsa-project.org

hi,
   i am using alsa0.9.4

   i have written an application which works fine .but there is 
buffer underun problem .but it corrects itself after some time. i 
ant to overcome this problem.

please help.

   i am here by attaching the program for verification.

i am setting :
#define PERIODSIZE 512
#define BUFSIZE 512 * 4
int format = SND_PCM_FORMAT_S16_LE
snd_pcm_uframes_t buffer_size = PERIODSIZE * 4
snd_pcm_uframes_t period_size  = PERIODSIZE
/* user buffer*/
char buf[BUFSIZE * 10];

    Can anybody please explain as i am setting period_size = 512 , 
bufsize = 512*4, am i reading(readi)  2048 bytes? or 2048 
frames?
   whts the diffrence between frames and bytes?
    while writing (writei)  do i need to convert  betwenn bytes 
and frames
   please explain whats this period_size and buffer_size. And alsa 
is it necessory to keep application buffer to collect the sound as 
buf[BUFSIZE *10]?
   if i want to read only 256 bytes with out any underrun or 
overrun to what values i must set buffer_size and period_size ? 
and also what should be the minimum size of application buf.?

   And also if i am integrating this  with RTP using sockets so 
that one program reads and another playbacks, i am getting broken 
pipe error while reading . But with out RTp it works fine. Whats 
the reason?

  thanks,
regards
**********************************************************************
#include <stdio.h>
#include <sys/time.h>
#include <time.h>
#include <sys/select.h>

/* definition to include new ALSA API */
#define ALSA_PCM_NEW_HW_PARAMS_API
#define ALSA_PCM_NEW_SW_PARAMS_API

/* include alsa library */
#include <alsa/asoundlib.h>
#include <math.h>

#define PERIODSIZE 512/* period size is 512 bytes */
#define BUFSIZE (PERIODSIZE*2) /*
 				  buffer size is given by  (periodsize *periods)
 				  if period size is in fragments , buffer size = 
(periodsize*periods)/4
 			       */

/* sampling rate */
int samplerate = 22050;

/* channels = 2 for stereo,1 for mono ie LEFT and RIGHT channels 
*/
int channels = 2;

/* access mode specifies the direction of pcm stream namely 
CATPTURE or PLAYBACK */
int accessmode = SND_PCM_ACCESS_RW_INTERLEAVED;

/* the format in which data will be written/read to/from the 
memory. This is 16 bit Little Endian for
  * intel processor */
int format = SND_PCM_FORMAT_S16_LE;

/* no of periods   also called fragments */
int  periods  = 2;



/* initializing buffer size */
snd_pcm_uframes_t buffer_size = PERIODSIZE * 4;

/* period size in bytes */
snd_pcm_uframes_t period_size  = PERIODSIZE ;

/* handle to dump the configured to the screen */
snd_output_t *output = NULL;


/* function definition for error checking */
#define checkr(r) if (r<0){ \
 	fprintf(stderr,"%s \n",snd_strerror(r));\
 			exit(-1);\
 			}


/* function for setting the hardware and software parameters */
int set_hw_params(snd_pcm_t *handle)
{
 	int r;
 	/* declaration of hardware and software structures */
 	snd_pcm_hw_params_t *hwparams;
 	snd_pcm_sw_params_t *swparams;

 	/* allocationg memory for hw_params structure , and error 
checking is done by comparing the return
 	 return  value. If it is less than ZERO , function for 
displaybing the error msg is called */
 	r = snd_pcm_hw_params_malloc(&hwparams); checkr(r);

 	/*
 	  init the structure for the full configuration space of 
soundcard.Before writing any PCM data to 		  the sound card,we 
have to spcify te access type,sample format,sample rate,no.of 
channels,
 	  no. of periods and period size.
 	*/

 	r = snd_pcm_hw_params_any(handle,hwparams); checkr(r);

 	/*
 	  set the access mode:
 	 access mode specifies  the way in which multichnanel data is 
stored in the buffer.There are two
 	 types of access methods.Each frame contains the consecutive 
sample data for channels.If INTERLEAVED 	     the buffer contains 
alternating words of sample date for left and right channels.For 
NONINTERLEAVED	  each frame contains first all sample data for 
first channel followed by sample data for the second
 	 channel
 	 */
 	r = snd_pcm_hw_params_set_access(handle,hwparams,accessmode); 
checkr(r);

 	/* setting format SND_PCM_S16_LE */
 	r = snd_pcm_hw_params_set_format(handle,hwparams,format); 
checkr(r);

 	/* setting the channels for stereo mode */
 	r = snd_pcm_hw_params_set_channels(handle,hwparams,channels); 
checkr(r);

 	/* setting the sampling rate */
 	r = 
snd_pcm_hw_params_set_rate_near(handle,hwparams,&samplerate,0); 
checkr(r);

 	/* setting the no of periods */
 	r = snd_pcm_hw_params_set_periods(handle,hwparams,periods,0); 
checkr(r);

 	/* setting the buffer size  and period size*/
 	r = 
snd_pcm_hw_params_set_buffer_size_near(handle,hwparams,&buffer_size); 
checkr(r);

 	r = 
snd_pcm_hw_params_set_period_size_near(handle,hwparams,&period_size,0); 
checkr(r);

 	/* Applying the configuration to the PCM device pointed to by 
the pcm handle */
 	r = snd_pcm_hw_params(handle,hwparams); checkr(r);


 	snd_pcm_hw_params_free(hwparams);

 	/* Now configuring the software parameters */
        	// assigning  memory for the software params structure
 	r = snd_pcm_sw_params_malloc(&swparams);checkr(r);

 	/* initializing the software parameter strucure */
 	r = snd_pcm_sw_params_current(handle,swparams);checkr(r);

 	/* setting the minimum available count */
 	r = 
snd_pcm_sw_params_set_avail_min(handle,swparams,period_size);checkr(r);

 	/* Applying the configuration to the PCM device pointed to by 
the PCM handle */
 	r = snd_pcm_sw_params(handle,swparams); checkr(r);

 	/* function used to prepare the audio interface for use */
 	snd_pcm_prepare(handle);

 	return(0);
}


 	int main(void)
 	{
 		unsigned char  buf[BUFSIZE*10];
 		int r,i;
 		snd_pcm_t *pcmr;// handle for  reading
 		snd_pcm_t *pcmp;// handle for writing

          /*
 	   opening the audio device for capturing.If the device is 
specified as "plughw:0,0", then we need not worry about the 
underlying  hardware.If some parameters such as sampling 
rate,sample format are not supported by the hardare , data will be 
automatically converted to the supported format.If specified as 
"hw:0,0",explicit checking for the support is required
 	  */


 		r = 
snd_pcm_open(&pcmr,"plughw:0,0",SND_PCM_STREAM_CAPTURE,0);checkr(r);
 		set_hw_params(pcmr);

 		// opening the device for playback
 		r = 
snd_pcm_open(&pcmp,"plughw:0,0",SND_PCM_STREAM_PLAYBACK,0);checkr(r);
 		set_hw_params(pcmp);





 		snd_pcm_start(pcmr);

 	//	snd_pcm_start(pcmp);
 	//snd_pcm_start(pcmp);

 		while(1)
 		{
 			// snd_pcm_readi is used for interleave capturing. else 
snd_pcm_readn is used.             		     // the function collects 
the samples from the standard input device namely mic and			          
// puts in the buffer.
 			r = snd_pcm_readi( pcmr,buf,2048);

 			if(r == BUFSIZE )printf("record r = %d\n",r);
 			else{
 				printf( "record r =%d\n",r);
 			checkr(r);}

 			//  snd_pcm_writei takes the data from the buffer and gives to 
the speaker
 			r = snd_pcm_writei(pcmp,buf,2048);
 	        //	if(r != BUFSIZE)snd_pcm_prepare(pcmp);// printf( 
"playback r =%d\n",r);
 		//	if( r == -EPIPE)// EPIPE is the error returned if there is 
no enough data
 		//		snd_pcm_prepare(pcmp);
 		//	else checkr(r);


 			if(r == -EPIPE)
 				snd_pcm_prepare(pcmp);
 			if((r>0) && ( r != BUFSIZE))
 				 printf("playback r = %d\n",r);
 		//	if(r == -EPIPE)
 		//		snd_pcm_prepare(pcmp);
 			if(r<0) snd_pcm_prepare(pcmp);
 			else checkr(r);
 		}

 		return 0;
 	}










___________________________________________________
Click below to experience Sooraj R Barjatya's latest offering
'Main Prem Ki Diwani Hoon' starring Hrithik, Abhishek
  & Kareena http://www.mpkdh.com



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
