From: "Pavana Sharma" <pavans@india.ti.com>
Subject: Testing Audio driver
Date: Thu, 18 Mar 2004 13:49:05 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000601c40cc1$ae444e30$f8b6a8c0@ent.ti.com>
Reply-To: <pavans@india.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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

Hi,

I am writing Alsa driver on 2.6 kernel for arm platform.
I want to test my driver with application.

I took one sample application & tried to map the functions.

******************* sample application *********************************
This program opens an audio interface for playback, configures it for
stereo, 16 bit, 44.1kHz, interleaved conventional read/write access. Then
its delivers a chunk of random data to it, and exits. It represents about
the simplest possible use of the ALSA Audio API, and isn't meant to be a
real program.
	#include <stdio.h>
	#include <stdlib.h>
	#include <alsa/asoundlib.h>

	main (int argc, char *argv[])
	{
		int i;
		int err;
		short buf[128];
		snd_pcm_t *playback_handle;
		snd_pcm_hw_params_t *hw_params;

		if ((err = snd_pcm_open (&playback_handle, argv[1],
SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
			fprintf (stderr, "cannot open audio device %s (%s)\n",
				 argv[1],
				 snd_strerror (err));
			exit (1);
		}

		if ((err = snd_pcm_hw_params_malloc (&hw_params)) < 0) {
			fprintf (stderr, "cannot allocate hardware parameter structure (%s)\n",
				 snd_strerror (err));
			exit (1);
		}

		if ((err = snd_pcm_hw_params_any (playback_handle, hw_params)) < 0) {
			fprintf (stderr, "cannot initialize hardware parameter structure (%s)\n",
				 snd_strerror (err));
			exit (1);
		}

		if ((err = snd_pcm_hw_params_set_access (playback_handle, hw_params,
SND_PCM_ACCESS_RW_INTERLEAVED)) < 0) {
			fprintf (stderr, "cannot set access type (%s)\n",
				 snd_strerror (err));
			exit (1);
		}

		if ((err = snd_pcm_hw_params_set_format (playback_handle, hw_params,
SND_PCM_FORMAT_S16_LE)) < 0) {
			fprintf (stderr, "cannot set sample format (%s)\n",
				 snd_strerror (err));
			exit (1);
		}

		if ((err = snd_pcm_hw_params_set_rate_near (playback_handle, hw_params,
44100, 0)) < 0) {
			fprintf (stderr, "cannot set sample rate (%s)\n",
				 snd_strerror (err));
			exit (1);
		}

		if ((err = snd_pcm_hw_params_set_channels (playback_handle, hw_params, 2))
< 0) {
			fprintf (stderr, "cannot set channel count (%s)\n",
				 snd_strerror (err));
			exit (1);
		}

		if ((err = snd_pcm_hw_params (playback_handle, hw_params)) < 0) {
			fprintf (stderr, "cannot set parameters (%s)\n",
				 snd_strerror (err));
			exit (1);
		}

		snd_pcm_hw_params_free (hw_params);

		if ((err = snd_pcm_prepare (playback_handle)) < 0) {
			fprintf (stderr, "cannot prepare audio interface for use (%s)\n",
				 snd_strerror (err));
			exit (1);
		}

		for (i = 0; i < 10; ++i) {
			if ((err = snd_pcm_writei (playback_handle, buf, 128)) != 128) {
				fprintf (stderr, "write to audio interface failed (%s)\n",
					 snd_strerror (err));
				exit (1);
			}
		}

		snd_pcm_close (playback_handle);
		exit (0);
	}

**************************************END***********************************
**************************************

I tried to trace back the application how i can map my driver routines with
the calls in application.
While tracing I couln't find the definition of of few functions like
	snd_pcm_sw_params_set_start_threshold()
	snd_pcm_hw_params_set_rate_near()
	snd_pcm_hw_params()
	snd_pcm_hw_params_free()

For few I could only find the prototypes.

My doubts are,
 where can I find the definitions for these functions or Alsa APIs ?
 Do i need to have any lib (alsa_lib) ?
 If not how my driver can be accessed from application layer, I mean how
calls are mapped ?

Can anybody please help me in this regard.

Thanks
Pavana S



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
