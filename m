From: Torsten Mohr <tmohr@s.netic.de>
Subject: Code to capture a buffer
Date: Sat, 24 Jan 2004 02:26:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401240226.54832.tmohr@s.netic.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_encEA225R9TOya0"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


--Boundary-00=_encEA225R9TOya0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

i got this code constructed from an example i found googling.

What i basically want is to initialise some settings and then
i'd like to capture some PCM to a buffer.  This should be
repeatable, i want to initialise ONCE and call a capture
function whenever i need some data.
It is perfectly ok, if the data buffers that are captured are
not consecutive.

The code basically works, but whenever i try to capture the
buffer a SECOND time, the whole program crashes.


Has anybody got a hint for me on what could be wrong?


Thanks for any hints,
Torsten.

--Boundary-00=_encEA225R9TOya0
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="sound.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sound.c"

#define _GNU_SOURCE
#include <stdio.h>
#include <malloc.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <alsa/asoundlib.h>
#include <sys/signal.h>

#include "sound.h"
#include "settings.h"

#define QWE	fprintf(stderr, "File %s, Line %i\n", __FILE__, __LINE__)


snd_pcm_t *pcm_handle;
snd_pcm_stream_t stream = SND_PCM_STREAM_CAPTURE;
snd_pcm_hw_params_t* hwparams;
char *pcm_name = "default";

int rate = 44100; /* Sample rate */
int exact_rate;   /* Sample rate returned by */
                      /* snd_pcm_hw_params_set_rate_near */ 
int dir;          /* exact_rate == rate --> dir = 0 */
                      /* exact_rate < rate  --> dir = -1 */
                      /* exact_rate > rate  --> dir = 1 */
int periods = 2;       /* Number of periods */
int periodsize = 4*SAMPLES; /* Periodsize (bytes) */

unsigned char *data;
int pcmreturn, l1, l2;
short s1, s2;
int frames;

snd_pcm_state_t sss;


static void show(snd_pcm_state_t* s) {
	switch(*s) {
		case SND_PCM_STATE_OPEN:
			printf("open\n");
			break;

		case SND_PCM_STATE_SETUP:
			printf("SETUP\n");
			break;

		case SND_PCM_STATE_PREPARED:
			printf("PREPARED\n");
			break;

		case SND_PCM_STATE_RUNNING:
			printf("RUNNING\n");
			break;

		case SND_PCM_STATE_XRUN:
			printf("XRUN\n");
			break;

		case SND_PCM_STATE_DRAINING:
			printf("DRAINING\n");
			break;

		case SND_PCM_STATE_PAUSED:
			printf("PAUSED\n");
			break;

		case SND_PCM_STATE_SUSPENDED:
			printf("SUSPENDED\n");
			break;
	}
}

unsigned char* sound_get_data(void) {
	return data;
}

int sound_init(void) {
	pcm_name = strdup("plughw:0,0");
	snd_pcm_hw_params_alloca(&hwparams);

    if (snd_pcm_open(&pcm_handle, pcm_name, stream, 0) < 0) {
      fprintf(stderr, "Error opening PCM device %s\n", pcm_name);
      return(-1);
    }

    /* Init hwparams with full configuration space */
    if (snd_pcm_hw_params_any(pcm_handle, hwparams) < 0) {
      fprintf(stderr, "Can not configure this PCM device.\n");
      return(-1);
    }

    if (snd_pcm_hw_params_set_access(pcm_handle, hwparams, SND_PCM_ACCESS_RW_INTERLEAVED) < 0) {
      fprintf(stderr, "Error setting access.\n");
      return(-1);
    }
  
    /* Set sample format */
    if (snd_pcm_hw_params_set_format(pcm_handle, hwparams, SND_PCM_FORMAT_S16_LE) < 0) {
      fprintf(stderr, "Error setting format.\n");
      return(-1);
    }

    /* Set sample rate. If the exact rate is not supported */
    /* by the hardware, use nearest possible rate.         */ 
    exact_rate = snd_pcm_hw_params_set_rate_near(pcm_handle, hwparams, &rate, &dir);
    if (dir != 0) {
      fprintf(stderr, "The rate %d Hz is not supported by your hardware.\n"
                       "==> Using %d Hz instead.\n", rate, exact_rate);
    }

    /* Set number of channels */
    if (snd_pcm_hw_params_set_channels(pcm_handle, hwparams, 2) < 0) {
      fprintf(stderr, "Error setting channels.\n");
      return(-1);
    }

    /* Set number of periods. Periods used to be called fragments. */ 
    if (snd_pcm_hw_params_set_periods(pcm_handle, hwparams, periods, 0) < 0) {
      fprintf(stderr, "Error setting periods.\n");
      return(-1);
    }

    /* Set buffer size (in frames). The resulting latency is given by */
    /* latency = periodsize * periods / (rate * bytes_per_frame)     */
    if (snd_pcm_hw_params_set_buffer_size(pcm_handle, hwparams, (periodsize * periods)>>2) < 0) {
      fprintf(stderr, "Error setting buffersize.\n");
      return(-1);
    }

    /* Apply HW parameter settings to */
    /* PCM device and prepare device  */
    if (snd_pcm_hw_params(pcm_handle, hwparams) < 0) {
      fprintf(stderr, "Error setting HW params.\n");
      return(-1);
    }

    data = (unsigned char *)calloc(periodsize*periods*4, 0);
    frames = periodsize >> 2;

QWE;
//    snd_pcm_start(pcm_handle);

	sss = snd_pcm_state(pcm_handle);
	show(&sss);
}


void sound_capture(void) {
QWE;
	show(&sss);
QWE;
	while(pcmreturn = snd_pcm_readi(pcm_handle, data, frames), pcmreturn < 0) {
	    snd_pcm_prepare(pcm_handle);
		QWE;
	}
QWE;
	show(&sss);
QWE;
	snd_pcm_drop(pcm_handle);
QWE;
	show(&sss);
QWE;
	printf("pcmreturn %i\nperiodsize %i\n", pcmreturn, periodsize); // */
QWE;
	show(&sss);

}


--Boundary-00=_encEA225R9TOya0--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
