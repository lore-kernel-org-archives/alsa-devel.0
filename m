From: Marco De Maio - BETTINI Srl <demaio@bettinivideo.com>
Subject: Strange behaviour on audio chipset VIA VT2021 codec
Date: Thu, 16 Feb 2012 16:52:15 +0100
Message-ID: <4F3D262F.4010605@bettinivideo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from it17.anothertv.net (it17.anothertv.net [95.110.203.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FDCC24589
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 16:52:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

i need to develop for my work an audio recorder application. I have to 
develop the software on Linux OS (Ubuntu 8.04 with kernel 2.6.23.13), 
and the motherboard is Gigabyte GA-G41MT-S2P (rev. 1.3) where is 
installed the integrated audio chipset VIA VT2021 codec.

I upgraded the alsa driver to 1.0.25 version for support of audio 
chipset VIA VT2021. I downloaded the driver and compiled it with the 
following option

./configure --with-cards=hda-intel --with-sequencer=yes

and i done some experiments with the following simple application 
example with alsa lib:

#include <alsa/asoundlib.h>

int main()
{
     int rc;
     int size;
     snd_pcm_t *handle;
     snd_pcm_hw_params_t *params;
     unsigned int val;
     int dir;
     snd_pcm_uframes_t frames;
     char *buffer;

     /* Open PCM device for playback. */
     rc = snd_pcm_open(&handle, "default",
                       SND_PCM_STREAM_CAPTURE, 0);
     if (rc < 0)
     {
         fprintf(stderr,
                 "unable to open pcm device: %s\n",
                 snd_strerror(rc));
         exit(1);
     }

     /* Allocate a hardware parameters object. */
     snd_pcm_hw_params_alloca(&params);

     /* Fill it in with default values. */
     snd_pcm_hw_params_any(handle, params);

     /* Set the desired hardware parameters. */

     /* Interleaved mode */
     snd_pcm_hw_params_set_access(handle, params,
                                  SND_PCM_ACCESS_RW_INTERLEAVED);

     /* Signed 16-bit little-endian format */
     snd_pcm_hw_params_set_format(handle, params,
                                  SND_PCM_FORMAT_S16_LE);

     /* Two channels (stereo) */
     snd_pcm_hw_params_set_channels(handle, params, 2);

     /* 44100 bits/second sampling rate (CD quality) */
     val = 44100;
     snd_pcm_hw_params_set_rate_near(handle, params,
&val, &dir);

     /* Set period size to 32 frames. */
     frames = 32;
     snd_pcm_hw_params_set_period_size_near(handle,
                                            params, &frames, &dir);

     /* Write the parameters to the driver */
     rc = snd_pcm_hw_params(handle, params);
     if (rc < 0)
     {
         fprintf(stderr,
                 "unable to set hw parameters: %s\n",
                 snd_strerror(rc));
         exit(1);
     }

     /* Use a buffer large enough to hold one period */
     snd_pcm_hw_params_get_period_size(params, &frames,
&dir);
     size = frames * 4; /* 2 bytes/sample, 2 channels */
     buffer = (char *) malloc(size);

     snd_pcm_hw_params_get_period_time(params,
&val, &dir);

     while (1)
     {
         printf ("Capture data\n");
         rc = snd_pcm_readi(handle, buffer, size);

         if (rc == -EAGAIN)
         {
             fprintf(stderr, "EAGAIN occurred\n");
             snd_pcm_prepare(handle);
         }
         else if (rc == -EPIPE)
         {
             fprintf(stderr, "EPIPE occurred\n");
             snd_pcm_prepare(handle);
         }
         else if (rc == -ESTRPIPE)
         {
             fprintf(stderr, "ESTRPIPE occurred\n");
             snd_pcm_prepare(handle);
         }
         else if (rc > 0)
         {
             fprintf(stderr, "read %d ok\n", rc);
         }
         else
         {
             fprintf(stderr, "error occurred %s\n", snd_strerror(rc));
             exit (1);
         }
     }

     snd_pcm_drain(handle);
     snd_pcm_close(handle);
     free(buffer);

     return 0;
}

Running the example above, I found the following behaviors:

1) Until there is no mic plugged, the application stop on snd_pcm_readi. 
When mic is plugged, the application starts again.
So when i unplug mic the application stops on snd_pcm_readi, when i plug 
mic the application starts again, and so on.
I want to point out that i achieve the same result with a simple stand 
alone jack.

2) If i reboot my machine with mic plugged, after restart, I run the 
application but it stop immediately on snd_pcm_readi
and I need to unplug/plug the mic to stats again the application.

This behavior seems to me quite strange. Please someone could help me to 
figure out why this behavior ? Maybe something wrong with my
example ? Maybe something wrong with compiling options of the driver or 
maybe into the drivers itself ?

I tried the same application on a different mainboard with Realtek 
ALC889 codec, and the applications never stops on snd_pcm_readi
(I suppose this is the correct behavior), and run correctly.

Let me know if you need more information about.

Thank to all in advance.

Marco
