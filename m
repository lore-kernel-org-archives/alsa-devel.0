From: Torsten Mohr <tmohr@s.netic.de>
Subject: Re: Docu:: Alsa Audio API:: A minimal capture program
Date: Mon, 9 Feb 2004 01:18:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402090119.00259.tmohr@s.netic.de>
References: <Pine.HPX.4.33n.0401281614420.11576-100000@studcom.urz.uni-halle.de> <200401282338.25438.tmohr@s.netic.de> <Pine.LNX.4.58.0401311456180.1876@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zHtJA8GXWkeqI2l"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0401311456180.1876@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_zHtJA8GXWkeqI2l
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

> > thanks for that hint.
> >
> > But sadly, the attached program doesn't work, though
> > i set stop_threshold to 0.  I didn't find any functions
>
> This is wrong. You need to set this value to sw_params->boundary or
> greater value to eliminate the stop detection, otherwise with zero,
> the stream is immediately stopped.

thanks again.

But this doesn't seem to be the problem, the attached file is
basically the example "minimal capture program" with the
suggested additions.

The program fails badly.  It would be so very great if somebody
had a hint for me on that one.  I tried to find the source of
the problem, but i didn't succeed.


Thanks,
Torsten.

--Boundary-00=_zHtJA8GXWkeqI2l
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

//#include "sound.h"
//#include "settings.h"

#ifndef SAMPLES
#define SAMPLES 2048
#endif

#define QWE	fprintf(stderr, "File %s, Line %i\n", __FILE__, __LINE__)

int periodsize = 4096;
int rate = 44100;
int i;
int err;
unsigned char* data;
snd_pcm_t *capture_handle;
snd_pcm_hw_params_t *hw_params;
snd_pcm_sw_params_t *sw_params;

snd_pcm_uframes_t boundary;

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

	if ((err = snd_pcm_sw_params_get_boundary (sw_params, &boundary)) < 0) {
		fprintf (stderr, "cannot set access type (%s)\n",
			 snd_strerror (err));
		exit (1);
	}


	if ((err = snd_pcm_sw_params_set_stop_threshold (capture_handle, sw_params, boundary)) < 0) {
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
	sound_capture();

QWE;
	snd_pcm_drop(capture_handle);
QWE;
//	snd_pcm_drain(capture_handle);
QWE;
	snd_pcm_close(capture_handle);
QWE;
	return 0;
} // */


--Boundary-00=_zHtJA8GXWkeqI2l--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
