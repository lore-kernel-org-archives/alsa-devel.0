From: Torsten Mohr <tmohr@s.netic.de>
Subject: Re: Docu:: Alsa Audio API:: A minimal capture program
Date: Wed, 28 Jan 2004 23:38:25 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401282338.25438.tmohr@s.netic.de>
References: <Pine.HPX.4.33n.0401281614420.11576-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hnDGAuBddL6myUh"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0401281614420.11576-100000@studcom.urz.uni-halle.de>
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


--Boundary-00=_hnDGAuBddL6myUh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

thanks for that hint.

But sadly, the attached program doesn't work, though
i set stop_threshold to 0.  I didn't find any functions
to set buffersize to 0, it doesn't seem to be in the
software parameters.


It would be great, if anybody had a hint.


Regards,
Torsten.



> Torsten Mohr wrote:
> > I want to write a program where some chunk of
> > data is sampled from time to time, with some delay
> > inbetween.
>
> Your program wants to ignore any buffer overruns.  To do this, you
> have to change the sw_params: set the stop_threshold to either 0 or
> the buffer size in frames (I don't remember which).
>
>
> HTH
> Clemens
>
>
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_hnDGAuBddL6myUh
Content-Type: text/x-csrc;
  charset="iso-8859-1";
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

int periodsize = 128;
int rate = 44100;
int i;
int err;
unsigned char* data;
snd_pcm_t *capture_handle;
snd_pcm_hw_params_t *hw_params;
snd_pcm_sw_params_t *sw_params;


unsigned char* sound_get_data(void) {
	return data;
}


int sound_init2(void) {

	if ((err = snd_pcm_open (&capture_handle, "plughw:0,0", SND_PCM_STREAM_CAPTURE, 0)) < 0) {
		fprintf (stderr, "cannot open audio device plughw:0,0 (%s)\n",
			 snd_strerror (err));
		exit (1);
	}
		   
	if ((err = snd_pcm_hw_params_malloc (&hw_params)) < 0) {
		fprintf (stderr, "cannot allocate hardware parameter structure (%s)\n",
			 snd_strerror (err));
		exit (1);
	}

	if ((err = snd_pcm_hw_params_any (capture_handle, hw_params)) < 0) {
		fprintf (stderr, "cannot initialize hardware parameter structure (%s)\n",
			 snd_strerror (err));
		exit (1);
	}
	
	if ((err = snd_pcm_hw_params_set_access (capture_handle, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED)) < 0) {
		fprintf (stderr, "cannot set access type (%s)\n",
			 snd_strerror (err));
		exit (1);
	}
	
	if ((err = snd_pcm_hw_params_set_format (capture_handle, hw_params, SND_PCM_FORMAT_S16_LE)) < 0) {
		fprintf (stderr, "cannot set sample format (%s)\n",
			 snd_strerror (err));
		exit (1);
	}
	
	if ((err = snd_pcm_hw_params_set_rate_near (capture_handle, hw_params, &rate, 0)) < 0) {
		fprintf (stderr, "cannot set sample rate (%s)\n",
			 snd_strerror (err));
		exit (1);
	}
	
	if ((err = snd_pcm_hw_params_set_channels (capture_handle, hw_params, 2)) < 0) {
		fprintf (stderr, "cannot set channel count (%s)\n",
			 snd_strerror (err));
		exit (1);
	}
	
	if ((err = snd_pcm_hw_params (capture_handle, hw_params)) < 0) {
		fprintf (stderr, "cannot set parameters (%s)\n",
			 snd_strerror (err));
		exit (1);
	}
	
	snd_pcm_hw_params_free (hw_params);

	if ((err = snd_pcm_sw_params_malloc (&sw_params)) < 0) {
		fprintf (stderr, "cannot allocate software parameter structure (%s)\n",
			 snd_strerror (err));
		exit (1);
	}

	if ((err = snd_pcm_sw_params_current (capture_handle, sw_params)) < 0) {
		fprintf (stderr, "cannot initialize software parameter structure (%s)\n",
			 snd_strerror (err));
		exit (1);
	}

	if ((err = snd_pcm_sw_params_set_stop_threshold (capture_handle, sw_params, 0)) < 0) {
		fprintf (stderr, "cannot set access type (%s)\n",
			 snd_strerror (err));
		exit (1);
	}

	if ((err = snd_pcm_sw_params (capture_handle, sw_params)) < 0) {
		fprintf (stderr, "cannot set sw-parameters (%s)\n",
			 snd_strerror (err));
		exit (1);
	} // */
	snd_pcm_sw_params_free (sw_params);

	
	if ((err = snd_pcm_prepare (capture_handle)) < 0) {
		fprintf (stderr, "cannot prepare audio interface for use (%s)\n",
			 snd_strerror (err));
		exit (1);
	}
}

int sound_init(void) {
    data = (unsigned char *)calloc(SAMPLES*4, 0);
	sound_init2();
}

void sound_capture(void) {
QWE;
	if ((err = snd_pcm_readi (capture_handle, data, periodsize)) != periodsize) {
		fprintf (stderr, "read from audio interface failed (%s)\n",
			 snd_strerror (err));
		exit (1);
	}
QWE;
}

int main(int argc, char** argv) {
	sound_init();
	sound_capture();
	sound_capture();
	sleep(1);
	sound_capture();

	snd_pcm_close(capture_handle);
QWE;
	return 0;
}


--Boundary-00=_hnDGAuBddL6myUh--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
