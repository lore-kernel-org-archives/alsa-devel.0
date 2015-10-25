From: Erik de Castro Lopo <mle+la@mega-nerd.com>
Subject: Using snd_pcm_set_params() on a capture handle
Date: Sun, 25 Oct 2015 17:44:42 +1100
Message-ID: <20151025174442.b318e489f0568566a4b82908@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hendrix.mega-nerd.net (hendrix.mega-nerd.net [203.206.230.162])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F4A72605EC
 for <alsa-devel@alsa-project.org>; Sun, 25 Oct 2015 07:44:45 +0100 (CET)
Received: from rollins.mnn (pharoah-vpn [10.9.8.2])
 by hendrix.mega-nerd.net (Postfix) with SMTP id 0C30FC06BF
 for <alsa-devel@alsa-project.org>; Sun, 25 Oct 2015 17:44:42 +1100 (AEDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I've got a simple PCM capture test program below, which is basically
a slightly tweak version of something from:

    http://equalarea.com/paul/alsa-audio.html


The program uses two different methods of setting up the capture
handle; one that works (and is complex) and one that doesn't but
seems like it should (and is simple). I'm trying to figure out
why the simple one (using snd_pcm_set_params) doesn't work.

The program can be compiled and run in two ways:

    gcc -Wall -O2 -DUSE_SET_PARAMS=1 alsa_capture.c -lasound -o alsa_capture 
    ./alsa_capture

which fails with:

    Read from audio interface failed (Input/output error)

and:

    gcc -Wall -O2 -DUSE_SET_PARAMS=0 alsa_capture.c -lasound -o alsa_capture
    ./alsa_capture

which works as expected.

Questions:

* Is snd_pcm_set_params() supposed to work on capture handles (I've used
  it successfully on playback handles)?

* Is my use of snd_pcm_set_params() missing something and if so what?

* If snd_pcm_set_params() is not supposed to work on capture handles
  would it be possible to update the documentation to reflect that?

Thanks,
Erik

//---------------------------------------------
#include <stdio.h>
#include <stdlib.h>

#include <alsa/asoundlib.h>
#include <alsa/pcm.h>

int
main (int argc, char *argv[])
{
	int i;
	int err;
	char *buffer;
	int buffer_frames = 128;
	unsigned int rate = 44100;
	snd_pcm_t *capture_handle;
	snd_pcm_format_t format = SND_PCM_FORMAT_S32_LE;

	char* device = "default";
	if (argc > 1) device = argv[1];


	if ((err = snd_pcm_open (&capture_handle, device, SND_PCM_STREAM_CAPTURE, 0)) < 0) {
		printf ("Cannot open audio device %s (%s)\n", device, snd_strerror (err)); exit (1) ;
	}

	if (USE_SET_PARAMS) {
		if ((err = snd_pcm_set_params (capture_handle, format, SND_PCM_ACCESS_RW_INTERLEAVED, 2, rate, 0, 500000)) < 0) {   /* 0.5sec */
			printf ("Capture open error: %s\n", snd_strerror (err)); exit (1) ;
		}
	}
	else {
		snd_pcm_hw_params_t *hw_params;

		if ((err = snd_pcm_hw_params_malloc (&hw_params)) < 0) {
			printf ("Cannot allocate hardware parameter structure (%s)\n", snd_strerror (err)); exit (1) ;
		}

		if ((err = snd_pcm_hw_params_any (capture_handle, hw_params)) < 0) {
			printf ("Cannot initialize hardware parameter structure (%s)\n", snd_strerror (err)); exit (1) ;
		}

		if ((err = snd_pcm_hw_params_set_access (capture_handle, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED)) < 0) {
			printf ("cannot set access type (%s)\n", snd_strerror (err)); exit (1) ;
		}

		if ((err = snd_pcm_hw_params_set_format (capture_handle, hw_params, format)) < 0) {
			printf ("Cannot set sample format (%s)\n", snd_strerror (err)); exit (1) ;
		}

		if ((err = snd_pcm_hw_params_set_rate_near (capture_handle, hw_params, &rate, 0)) < 0) {
			printf ("Cannot set sample rate (%s)\n", snd_strerror (err)); exit (1) ;
		}

		if ((err = snd_pcm_hw_params_set_channels (capture_handle, hw_params, 2)) < 0) {
			printf ("cannot set channel count (%s)\n", snd_strerror (err)); exit (1) ;
		}

		if ((err = snd_pcm_hw_params (capture_handle, hw_params)) < 0) {
			printf ("cannot set parameters (%s)\n", snd_strerror (err)); exit (1) ;
		}

		snd_pcm_hw_params_free (hw_params);
	}

	buffer = malloc (buffer_frames * snd_pcm_format_width(format) / 8 * 2);

	if ((err = snd_pcm_prepare (capture_handle)) < 0) {
		printf ("cannot prepare audio interface for use (%s)\n", snd_strerror (err)); exit (1) ;
	}

	for (i = 0; i < 10; ++i) {
		if ((err = snd_pcm_readi (capture_handle, buffer, buffer_frames)) != buffer_frames) {
			printf ("Read from audio interface failed (%s)\n", snd_strerror (err)); exit (1) ;
			break;
			}
		printf("read %d done\n", i);
	}

	free(buffer);

	snd_pcm_close (capture_handle);
	puts ("Audio interface closed");

	return 0;
}

-- 
----------------------------------------------------------------------
Erik de Castro Lopo
http://www.mega-nerd.com/
