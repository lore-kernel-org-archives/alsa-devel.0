From: "Tobias Urban" <TobiU@gmx.net>
Subject: simple capture on demand with ALSA
Date: Tue, 18 Apr 2006 17:05:36 +0200 (MEST)
Message-ID: <1927.1145372736@www094.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
List-Id: alsa-devel@alsa-project.org

Hallo,

currently I am working on sound localization an for this reason I would like
to extract
- an amount of 1024 samples (contiguous ones)
- from a never stopping ring buffer (stop threshold = boundary)
- simultanously from two different sound cards
with ALSA when I need a set of samples for further processing.

I have already tried the snd_pcm_drain() function but this did not work with
my capture stream. Now I am trying a direct MMAP access - call hesync,
receive pointer, begin, read sample data, commit. However, the official ALSA
example code does not help me a lot because it is only for playback.
Additionally I do not know how the capture works an how to properly read
from it.

I spent very much time on reading the documentations espacially the
reference. Nevertheless I stil haven't got the information whether it is
possible to demand a certain amount of samples with the simple
snd_pcm_readi() function (for just one sound card) if the ring buffer is
looping without any stop. Can I be sure that I really receive the latest -
lets say 1024 - (stereo) samples and that they have not been overwritten,
for example. Does snd_pcm_readi() require a continuous stream?


Thank you very much for your answer!


Sincerely,
TobiU


PS: This is my code I would like to use for a simpe data acquisition:

 
#include <alsa/asoundlib.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include <alsa/asoundlib.h>
#include <sched.h>
#include <errno.h>
#include <math.h>


static unsigned int buffer_time = 110000;               /* ring buffer
length in us */
static unsigned int period_time = 22000;   
static unsigned int channels = 2;
static unsigned int rate = 48000;
static unsigned int format = SND_PCM_FORMAT_S16_LE;
static snd_pcm_sframes_t period_size, buffer_size;
static snd_pcm_uframes_t wantedframes = 1024;



//function to set hardware parameters
static int set_hwparams(snd_pcm_t *handle,
                        snd_pcm_hw_params_t *params)
{
        unsigned int rrate, value;
        snd_pcm_uframes_t size;
        int err, dir;

        /* choose all parameters */
        err = snd_pcm_hw_params_any(handle, params);
        if (err < 0) {
                printf("Broken configuration for playback: no configurations
available: %s\n", snd_strerror(err));
                return err;
        }
        /* set hardware resampling, Restrict a configuration space to
contain only real hardware rates (1 = enabled). */
        err = snd_pcm_hw_params_set_rate_resample(handle, params, 1);
        if (err < 0) {
                printf("Resampling setup failed for playback: %s\n",
snd_strerror(err));
                return err;
        }
        /* set the interleaved read/write format */
        err = snd_pcm_hw_params_set_access(handle, params,
SND_PCM_ACCESS_RW_INTERLEAVED);
        if (err < 0) {
	  printf("Access type not available for playback: %s\n",
snd_strerror(err));
                return err;
        }
        /* set the sample format */
        err = snd_pcm_hw_params_set_format(handle, params, format);
        if (err < 0) {
                printf("Sample format not available for playback: %s\n",
snd_strerror(err));
                return err;
        }
        /* set the count of channels */
        err = snd_pcm_hw_params_set_channels(handle, params, channels);
        if (err < 0) {
                printf("Channels count 2 not available for capture: %s\n",
snd_strerror(err));
                return err;
        }
        /* set the stream rate */
				rrate = rate;
        err = snd_pcm_hw_params_set_rate_near(handle, params, &rrate, 0);
        if (err < 0) {
                printf("Rate %iHz not available for capture: %s\n", rate,
snd_strerror(err));
                return err;
        }
        if (rrate != rate) {
                printf("Rate doesn't match (requested %iHz, get %iHz)\n",
rate, err);
                return -EINVAL;
        }
        /* set the buffer size */
        value = buffer_time;
	dir = 1;
        err = snd_pcm_hw_params_set_buffer_time_near(handle, params, &value,
&dir);
        if (err < 0) {
                printf("Unable to set buffer time %i for capture: %s\n",
dir, snd_strerror(err));
                return err;
        }
        err = snd_pcm_hw_params_get_buffer_size(params, &size);
        if (err < 0) {
                printf("Unable to get buffer size for capture: %s\n",
snd_strerror(err));
                return err;
        }
	buffer_size = size;
      	printf("buffer size is: %i\n", buffer_size);
      	err = snd_pcm_hw_params_get_buffer_time(params, &value, &dir);
	if (err < 0) {
		printf("Unable to get buffer time for capture: %s\n", snd_strerror(err));
		return err;
	}
	printf("buffer time %i with direction %i\n", value, dir);
        /* set the period size */
	value = period_time;
	dir = 1;
	err = snd_pcm_hw_params_set_period_time_near(handle, params, &value, &dir);
        if (err < 0) {
                printf("Unable to set period time %i for capture: %s\n",
size, snd_strerror(err));
                return err;
        }
        err = snd_pcm_hw_params_get_period_size(params, &size, &dir);
        if (err < 0) {
                printf("Unable to get period size for capture: %s\n",
snd_strerror(err));
                return err;
        }
	period_size = size;
	printf("period size: %i\n", period_size);
	err = snd_pcm_hw_params_get_period_time(params, &value, &dir);
	if (err < 0) {
		printf("Unable to get period time for capture: %s\n", snd_strerror(err));
		return err;
	}
	printf("period time %i with direction %i\n", value, dir);
        /* write the parameters to device */
	err = snd_pcm_hw_params(handle, params);
        if (err < 0) {
                printf("Unable to set hw params for capture: %s\n",
snd_strerror(err));
                return err;
        }
        return 0;
}

//function to set software parameters
static int set_swparams(snd_pcm_t *handle, snd_pcm_sw_params_t *swparams)
{
        int err;
	unsigned int value;
	snd_pcm_uframes_t size;


        /* get the current swparams */
        err = snd_pcm_sw_params_current(handle, swparams);
        if (err < 0) {
                printf("Unable to determine current swparams for capture:
%s\n", snd_strerror(err));
                return err;
        }
        /* start the transfer when the buffer contains period_size */
        /* (buffer_size / avail_min) * avail_min */
        err = snd_pcm_sw_params_set_start_threshold(handle, swparams,
period_size);
        if (err < 0) {
                printf("Unable to set start threshold mode for capture:
%s\n", snd_strerror(err));
                return err;
        }
        /* allow the transfer when at least period_size samples can be
processed */
        err = snd_pcm_sw_params_set_avail_min(handle, swparams,
period_size);
        if (err < 0) {
                printf("Unable to set avail min for capture: %s\n",
snd_strerror(err));
                return err;
        }
        /* align all transfers period_size samples */
        err = snd_pcm_sw_params_set_xfer_align(handle, swparams,
period_size);
        if (err < 0) {
                printf("Unable to set transfer align for capture: %s\n",
snd_strerror(err));
                return err;
        }
	err = snd_pcm_sw_params_set_tstamp_mode(handle, swparams,
SND_PCM_TSTAMP_MMAP);
	if (err < 0){
                printf("Unable to set timestamp mode for capture: %s\n",
snd_strerror(err));
                return err;
        }

	/*never stopping ring buffer (automatic stop threshold = boundary)*/
	err = snd_pcm_sw_params_get_boundary(swparams, &size);
	if (err < 0){
                printf("Unable to get boundary for capture: %s\n",
snd_strerror(err));
                return err;
        }
	printf("boundary: %i frames\n", size);
	err = snd_pcm_sw_params_set_stop_threshold(handle, swparams, size);
//changed on  17 Apr
	if (err < 0){
               	printf("Unable to set stop threshold for capture: %s\n",
snd_strerror(err));
                return err;
        }
	err = snd_pcm_sw_params_get_stop_threshold(swparams, &size); //changed on 
17 Apr
	if (err < 0){
               	printf("Unable to set stop threshold for capture: %s\n",
snd_strerror(err));
                return err;
        }
	printf("stop threshold: %i\n", size);

        /* write the parameters to the capture device */
        err = snd_pcm_sw_params(handle, swparams);
        if (err < 0) {
                printf("Unable to set sw params for capture: %s\n",
snd_strerror(err));
                return err;
        }
        return 0;
}


int main() {

	//Deklaration von Variablen

  int z;
  long loops;
  int rc;
  snd_pcm_sframes_t rcsframes;
  int size;

  //unsigned char buffer
  int space;
  unsigned char *buffer;
  signed short *shortsamples;


  snd_pcm_t *handle;

  snd_pcm_hw_params_t *hwparams;
  snd_pcm_sw_params_t *swparams;
  unsigned int val;
  int dir;

  snd_pcm_access_t access = SND_PCM_ACCESS_RW_INTERLEAVED;
  
  snd_pcm_state_t state;
  

	/* Open PCM device for capture */
	rc = snd_pcm_open(&handle, "hw:0,0", SND_PCM_STREAM_CAPTURE, 0);
	if (rc < 0) {
	  fprintf(stderr, "unable to open first pcm device: %s\n",
snd_strerror(rc));
	  exit(1);
	}
    
	/* set the hardware parameters and write them to driver */
	snd_pcm_hw_params_alloca( &hwparams );
	rc = set_hwparams( handle, hwparams );
	if (rc < 0) {
	  fprintf(stderr, "unable to set hw parameters for first capture: %s\n",
snd_strerror(rc));
	  exit(1);
	}

  	/* set the software parameters and write them to driver */
	snd_pcm_sw_params_alloca( &swparams );
	rc = set_swparams( handle, swparams );
	if (rc < 0) {
	  fprintf(stderr, "unable to set sw parameters for first capture: %s\n",
snd_strerror(rc));
	  exit(1);
	}  

 	/*prepare handles for use*/
	rc = snd_pcm_prepare(handle);
 	if (rc < 0) {
	  printf("Unable to prepare first capture: %s\n", snd_strerror(rc));
	  exit(1);
	}

	/*wait for handles to be ready for use*/
	rc = snd_pcm_wait(handle, 1000);
  	if (rc < 0) {
		printf("Waiting failed for capture: %s\n", snd_strerror(rc));
		exit(1);
	}

  space = wantedframes * 4; /* 2 bytes/sample, 2 channels */
  buffer = (unsigned char *) malloc(space);

  rc = snd_pcm_start(handle);
  if (rc < 0) {
    fprintf(stderr, "Unable to stsrt capture %s\n", snd_strerror(rc));
    exit(1);
  }
	
	
  /* We want to loop for 5 seconds */
  snd_pcm_hw_params_get_period_time(hwparams, &val, &dir);
  loops = 5000000 / val;
    
  while (loops > 0) {
    loops--;

    printf("state of capture: %i\n", snd_pcm_state(handle));

    rcsframes = snd_pcm_readi(handle, buffer, wantedframes);
    /*if (rcsframes == -EPIPE) {
      /* EPIPE means overrun /
      fprintf(stderr, "overrun occurred\n");
      snd_pcm_prepare(handle);
    } else if (rcsframes < 0) {
      fprintf(stderr,"error from read: %s\n", snd_strerror(rcsframes));
    } else if (rcsframes != (int)wantedframes) {
      fprintf(stderr, "short read, read %d frames\n", rcsframes);
      }*/

    if ((int)rcsframes >= wantedframes)
      printf("number of read frames: %i\n", (int)rcsframes);
    else {
      printf("Failure at read\n");
      exit(1);
    }

    //write the sample values to stdout
    shortsamples = (signed short *) buffer;
    for ( z=0; z<(int)wantedframes; z++) {
      printf("short1: %d\n", (*(shortsamples+z)));
      printf("short2: %d\n", (*(shortsamples+z+1)));
    }
    printf("Ende eines Satzes\n");
    printf("state of capture: %i\n",snd_pcm_state(handle) );
    sleep(0.6);
  }

  snd_pcm_drain(handle);
  snd_pcm_close(handle);
  free(buffer);

  return 0;
}

-- 
Echte DSL-Flatrate dauerhaft für 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
