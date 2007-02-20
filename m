From: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Subject: HDA-based STAC9200 soundcard loses interrupts
Date: Tue, 20 Feb 2007 20:42:56 +1100
Message-ID: <45DAC2A0.3060900@usherbrooke.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020906010606060104040304"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020906010606060104040304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I've got a laptop that has skipping problems, mainly full-duplex
programs. This happens for both native ALSA applications and those using
OSS. Digging a bit into that, I realised that it mainly happens when
using two periods. I wrote a test program (attached) to dump the time I
get the "interrupts" (from user space). The output is attached in the
"timings" file (gettimeofday() microseconds). Basically, the time
increases with near perfect regularity, except for a few cases, where
there's a skip of exactly one period. Looks a lot like lost interrupts
or something like that (at least that was James Courtier-Dutton's
interpretation when he looked at it during LCA2007).

This data was obtained on a Dell D820 laptop with a STAC9200-based
soundcard running kernel 2.6.20 and ALSA 1.0.14rc2, but I've observed
the same problem with all other versions of kernel/ALSA I've tested.
I've also seen that problem on all other HDA-based desktops I have, but
not on any of the i810-based machines I have.

The problem usually does not show up with playback-only applications
(probably because they use >2 periods or something), but it makes VoIP
apps like Ekiga (native ALSA) and OpenWengo (OSS) totally unusable as I
get several xruns per second.

Does anyone know of a fix for that?

	Jean-Marc

--------------020906010606060104040304
Content-Type: text/plain;
 name="timings"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="timings"

sched_setscheduler: Success
play 792872
play 792936
play 813210
rec 814206
play 834538
rec 835531
play 855880
rec 856874
play 877192
rec 878183
play 898540
rec 899532
play 919864
rec 920875
play 941198
rec 942205
play 962536
rec 963531
play 983863
rec 984862
play 5206
rec 6201
play 26530
rec 27527
play 47877
rec 48885
play 69203
rec 70195
play 90531
rec 91524
play 111870
rec 134185
rec 134466
play 154545
play 154612
rec 155537
play 175869
rec 176864
play 197196
rec 198204
play 218541
rec 219532
rec 240881
play 261205
play 261255
rec 262204
play 282546
rec 283544
play 303866
rec 304871
play 325205
rec 326198
play 346530
rec 347522
play 367872
rec 368866
play 389206
rec 390195
play 410547
rec 411539
play 431858
rec 432867
play 453202
rec 454205
play 474548
rec 475543
play 495869
play 517213
rec 518206
rec 518368
play 538539
rec 539529
play 559877
rec 560866
play 581217
rec 582216
play 602531
rec 603521
play 623871
rec 646212
rec 646375
play 666556
play 666625
rec 667548
play 687874
rec 688882
play 709204
rec 710203
play 751871
play 751931
rec 752866
rec 753025
play 773216
rec 774211
play 794532
rec 795532
play 815862
rec 816867
play 837202
rec 838228
play 858553
rec 859546
play 879884
rec 880883
play 901202
rec 902203
play 922539
rec 923533
play 943866
rec 944880
rec 966202
play 986550
play 986618
rec 987545
play 7877
rec 8881
rec 30203
play 50537
play 50598
rec 51532
play 71872
rec 72873
play 93195
rec 94194
play 135875
play 135941
rec 136891
rec 137056
play 157205
rec 158218
play 178538
rec 179529
play 199868

--------------020906010606060104040304
Content-Type: text/x-csrc;
 name="duplex.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="duplex.c"

/*
   Copyright (C) 2004-2006 Jean-Marc Valin
   Copyright (C) 2006 Commonwealth Scientific and Industrial Research
                      Organisation (CSIRO) Australia
   
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:

   1. Redistributions of source code must retain the above copyright notice,
   this list of conditions and the following disclaimer.

   2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

   3. The name of the author may not be used to endorse or promote products
   derived from this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
   IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
   DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
   INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
   (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
   HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
   STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
   ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
   POSSIBILITY OF SUCH DAMAGE.
*/

#include "alsa_device.h"
#include <stdlib.h>
#include <alsa/asoundlib.h>
#include <sched.h>
#include <sys/time.h>
#include <time.h>

struct AlsaDevice_ {
   char *device_name;
   int channels;
   int period;
   snd_pcm_t *capture_handle;
   snd_pcm_t *playback_handle;
   int readN, writeN;
   struct pollfd *read_fd, *write_fd;
};

AlsaDevice *alsa_device_open(char *device_name, unsigned int rate, int channels, int period)
{
   int dir;
   int err;
   snd_pcm_hw_params_t *hw_params;
   snd_pcm_sw_params_t *sw_params;
   snd_pcm_uframes_t period_size = period;
   snd_pcm_uframes_t buffer_size = 4*period;
   static snd_output_t *jcd_out;
   AlsaDevice *dev = malloc(sizeof(*dev));
   if (!dev)
      return NULL;
   dev->device_name = malloc(1+strlen(device_name));
   if (!dev->device_name)
   {
      free(dev);
      return NULL;
   }
   strcpy(dev->device_name, device_name);
   dev->channels = channels;
   dev->period = period;
   err = snd_output_stdio_attach(&jcd_out, stdout, 0);
   
   if ((err = snd_pcm_open (&dev->capture_handle, dev->device_name, SND_PCM_STREAM_CAPTURE, 0)) < 0) {
      fprintf (stderr, "cannot open audio device %s (%s)\n",
               dev->device_name,
               snd_strerror (err));
      assert(0);
   }

   if ((err = snd_pcm_hw_params_malloc (&hw_params)) < 0) {
      fprintf (stderr, "cannot allocate hardware parameter structure (%s)\n",
               snd_strerror (err));
      assert(0);
   }

   if ((err = snd_pcm_hw_params_any (dev->capture_handle, hw_params)) < 0) {
      fprintf (stderr, "cannot initialize hardware parameter structure (%s)\n",
               snd_strerror (err));
      assert(0);
   }

   if ((err = snd_pcm_hw_params_set_access (dev->capture_handle, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED)) < 0) {
      fprintf (stderr, "cannot set access type (%s)\n",
               snd_strerror (err));
      assert(0);
   }

   if ((err = snd_pcm_hw_params_set_format (dev->capture_handle, hw_params, SND_PCM_FORMAT_S16_LE)) < 0) {
      fprintf (stderr, "cannot set sample format (%s)\n",
               snd_strerror (err));
      assert(0);
   }

   if ((err = snd_pcm_hw_params_set_rate_near (dev->capture_handle, hw_params, &rate, 0)) < 0) {
      fprintf (stderr, "cannot set sample rate (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   /*fprintf (stderr, "rate = %d\n", rate);*/

   if ((err = snd_pcm_hw_params_set_channels (dev->capture_handle, hw_params, channels)) < 0) {
      fprintf (stderr, "cannot set channel count (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   
   period_size = period;
   dir = 0;
   if ((err = snd_pcm_hw_params_set_period_size_near (dev->capture_handle, hw_params, &period_size, &dir)) < 0) {
      fprintf (stderr, "cannot set period size (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   
   if ((err = snd_pcm_hw_params_set_periods (dev->capture_handle, hw_params, 4, 0)) < 0) {
      fprintf (stderr, "cannot set number of periods (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   
   buffer_size = period_size * 4;
   dir=0;
   if ((err = snd_pcm_hw_params_set_buffer_size_near (dev->capture_handle, hw_params, &buffer_size)) < 0) {
      fprintf (stderr, "cannot set buffer time (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   
   if ((err = snd_pcm_hw_params (dev->capture_handle, hw_params)) < 0) {
      fprintf (stderr, "cannot set capture parameters (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   snd_pcm_dump_setup(dev->capture_handle, jcd_out);
   snd_pcm_hw_params_free (hw_params);

   if ((err = snd_pcm_sw_params_malloc (&sw_params)) < 0) {
      fprintf (stderr, "cannot allocate software parameters structure (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   if ((err = snd_pcm_sw_params_current (dev->capture_handle, sw_params)) < 0) {
      fprintf (stderr, "cannot initialize software parameters structure (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   if ((err = snd_pcm_sw_params_set_avail_min (dev->capture_handle, sw_params, period)) < 0) {
      fprintf (stderr, "cannot set minimum available count (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   if ((err = snd_pcm_sw_params (dev->capture_handle, sw_params)) < 0) {
      fprintf (stderr, "cannot set software parameters (%s)\n",
               snd_strerror (err));
      assert(0);
   }   
   
   
   if ((err = snd_pcm_open (&dev->playback_handle, dev->device_name, SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
      fprintf (stderr, "cannot open audio device %s (%s)\n",
               dev->device_name,
               snd_strerror (err));
      assert(0);
   }
   
   if ((err = snd_pcm_hw_params_malloc (&hw_params)) < 0) {
      fprintf (stderr, "cannot allocate hardware parameter structure (%s)\n",
               snd_strerror (err));
      assert(0);
   }

   if ((err = snd_pcm_hw_params_any (dev->playback_handle, hw_params)) < 0) {
      fprintf (stderr, "cannot initialize hardware parameter structure (%s)\n",
               snd_strerror (err));
      assert(0);
   }

   if ((err = snd_pcm_hw_params_set_access (dev->playback_handle, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED)) < 0) {
      fprintf (stderr, "cannot set access type (%s)\n",
               snd_strerror (err));
      assert(0);
   }

   if ((err = snd_pcm_hw_params_set_format (dev->playback_handle, hw_params, SND_PCM_FORMAT_S16_LE)) < 0) {
      fprintf (stderr, "cannot set sample format (%s)\n",
               snd_strerror (err));
      assert(0);
   }

   if ((err = snd_pcm_hw_params_set_rate_near (dev->playback_handle, hw_params, &rate, 0)) < 0) {
      fprintf (stderr, "cannot set sample rate (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   /*fprintf (stderr, "rate = %d\n", rate);*/

   if ((err = snd_pcm_hw_params_set_channels (dev->playback_handle, hw_params, channels)) < 0) {
      fprintf (stderr, "cannot set channel count (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   
   period_size = period;
   dir = 0;
   if ((err = snd_pcm_hw_params_set_period_size_near (dev->playback_handle, hw_params, &period_size, &dir)) < 0) {
      fprintf (stderr, "cannot set period size (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   if ((err = snd_pcm_hw_params_set_periods (dev->playback_handle, hw_params, 4, 0)) < 0) {
      fprintf (stderr, "cannot set number of periods (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   buffer_size = period_size * 4;
   dir=0;
   if ((err = snd_pcm_hw_params_set_buffer_size_near (dev->playback_handle, hw_params, &buffer_size)) < 0) {
      fprintf (stderr, "cannot set buffer time (%s)\n",
               snd_strerror (err));
      assert(0);
   }


   if ((err = snd_pcm_hw_params (dev->playback_handle, hw_params)) < 0) {
      fprintf (stderr, "cannot set playback parameters (%s)\n",
               snd_strerror (err));
      assert(0);
   }

   snd_pcm_dump_setup(dev->playback_handle, jcd_out);
   snd_pcm_hw_params_free (hw_params);

   
   if ((err = snd_pcm_sw_params_malloc (&sw_params)) < 0) {
      fprintf (stderr, "cannot allocate software parameters structure (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   if ((err = snd_pcm_sw_params_current (dev->playback_handle, sw_params)) < 0) {
      fprintf (stderr, "cannot initialize software parameters structure (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   if ((err = snd_pcm_sw_params_set_avail_min (dev->playback_handle, sw_params, period)) < 0) {
      fprintf (stderr, "cannot set minimum available count (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   if ((err = snd_pcm_sw_params_set_start_threshold (dev->playback_handle, sw_params, period)) < 0) {
      fprintf (stderr, "cannot set start mode (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   if ((err = snd_pcm_sw_params (dev->playback_handle, sw_params)) < 0) {
      fprintf (stderr, "cannot set software parameters (%s)\n",
               snd_strerror (err));
      assert(0);
   }
  
   
   snd_pcm_link(dev->capture_handle, dev->playback_handle);
   if ((err = snd_pcm_prepare (dev->capture_handle)) < 0) {
      fprintf (stderr, "cannot prepare audio interface for use (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   if ((err = snd_pcm_prepare (dev->playback_handle)) < 0) {
      fprintf (stderr, "cannot prepare audio interface for use (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   
   dev->readN = snd_pcm_poll_descriptors_count(dev->capture_handle);
   dev->writeN = snd_pcm_poll_descriptors_count(dev->playback_handle);

   dev->read_fd = malloc(dev->readN*sizeof(*dev->read_fd));
   /*printf ("descriptors: %d %d\n", dev->readN, dev->writeN);*/
   if (snd_pcm_poll_descriptors(dev->capture_handle, dev->read_fd, dev->readN) != dev->readN)
   {
      fprintf (stderr, "cannot obtain capture file descriptors (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   
   dev->write_fd = malloc(dev->writeN*sizeof(*dev->read_fd));
   if (snd_pcm_poll_descriptors(dev->playback_handle, dev->write_fd, dev->writeN) != dev->writeN)
   {
      fprintf (stderr, "cannot obtain playback file descriptors (%s)\n",
               snd_strerror (err));
      assert(0);
   }
   return dev;
}

void alsa_device_close(AlsaDevice *dev)
{
   snd_pcm_close(dev->capture_handle);
   snd_pcm_close(dev->playback_handle);
   free(dev->device_name);
   free(dev);
}

int alsa_device_read(AlsaDevice *dev, short *pcm, int len)
{
   int err;
   /*fprintf (stderr, "-");*/
   if ((err = snd_pcm_readi (dev->capture_handle, pcm, len)) != len)
   {
      if (err<0)
      {
         //fprintf(stderr, "error %d, EPIPE = %d\n", err, EPIPE);
         if (err == -EPIPE)
         {
            fprintf (stderr, "An overrun has occured, reseting capture\n");
         } else
         {
            fprintf (stderr, "read from audio interface failed (%s)\n",
                     snd_strerror (err));
         }
         if ((err = snd_pcm_prepare (dev->capture_handle)) < 0)
         {
            fprintf (stderr, "cannot prepare audio interface for use (%s)\n",
                     snd_strerror (err));
         }
         if ((err = snd_pcm_start (dev->capture_handle)) < 0)
         {
            fprintf (stderr, "cannot prepare audio interface for use (%s)\n",
                     snd_strerror (err));
         }
         /*alsa_device_read(dev,pcm,len);*/
      } else {
         fprintf (stderr, "Couldn't read as many samples as I wanted (%d instead of %d)\n", err, len);
      }
      return 1;
   }
   //fprintf (stderr, "-");
   return 0;
}

int alsa_device_write(AlsaDevice *dev, const short *pcm, int len)
{
   int err;
   if ((err = snd_pcm_writei (dev->playback_handle, pcm, len)) != len)
   {
      if (err<0)
      {
         if (err == -EPIPE)
         {
            fprintf (stderr, "An underrun has occured, reseting playback, len=%d\n", len);
         } else
         {
            fprintf (stderr, "write to audio interface failed (%s)\n",
                     snd_strerror (err));
         }
         if ((err = snd_pcm_prepare (dev->playback_handle)) < 0)
         {
            fprintf (stderr, "cannot prepare audio interface for use (%s)\n",
                     snd_strerror (err));
         }
      } else {
         fprintf (stderr, "Couldn't write as many samples as I wanted (%d instead of %d)\n", err, len);
      }
      /*alsa_device_write(dev,pcm,len);*/
      return 1;
   }
   //fprintf (stderr, "+%d ", err);

   return 0;
}

int alsa_device_capture_ready(AlsaDevice *dev, struct pollfd *pfds, unsigned int nfds)
{
   unsigned short revents=0;
   int err;
   if ((err = snd_pcm_poll_descriptors_revents(dev->capture_handle, pfds, dev->readN, &revents)) < 0)
   {
      //cerr << "error in snd_pcm_poll_descriptors_revents for capture: " << snd_strerror (err) << endl;
      //FIXME: This is a kludge
      fprintf (stderr, "error in alsa_device_capture_ready: %s\n", snd_strerror (err));
      return pfds[0].revents & POLLIN;
   }
   //cerr << (revents & POLLERR) << endl;
   return revents & POLLIN;
}

int alsa_device_playback_ready(AlsaDevice *dev, struct pollfd *pfds, unsigned int nfds)
{
   unsigned short revents=0;
   int err;
   if ((err = snd_pcm_poll_descriptors_revents(dev->playback_handle, pfds+dev->readN, dev->writeN, &revents)) < 0)
   {
      //cerr << "error in snd_pcm_poll_descriptors_revents for playback: " << snd_strerror (err) << endl;
      //FIXME: This is a kludge
      fprintf (stderr, "error in alsa_device_playback_ready: %s\n", snd_strerror (err));
      return pfds[1].revents & POLLOUT;
   }
   //cerr << (revents & POLLERR) << endl;
   return revents & POLLOUT;
}

void alsa_device_start(AlsaDevice *dev)
{
   int i;
   short pcm[dev->period*dev->channels];
   for (i=0;i<dev->period*dev->channels;i++)
      pcm[i] = 0;
   alsa_device_write(dev, pcm, dev->period);
   alsa_device_write(dev, pcm, dev->period);
   snd_pcm_start(dev->capture_handle);
   snd_pcm_start(dev->playback_handle);
}

int alsa_device_nfds(AlsaDevice *dev)
{
   return dev->writeN+dev->readN;
}

void alsa_device_getfds(AlsaDevice *dev, struct pollfd *pfds, unsigned int nfds)
{
   int i;
   assert (nfds >= dev->writeN+dev->readN);
   for (i=0;i<dev->readN;i++)
      pfds[i] = dev->read_fd[i];
   for (i=0;i<dev->writeN;i++)
      pfds[i+dev->readN] = dev->write_fd[i];
}

#define SAMPLING_RATE 48000
#define FRAME_SIZE 1024

int main(int argc, char **argv)
{
   int i;
   int nfds;
   struct pollfd *pfds;
   AlsaDevice *audio_dev;
   struct timeval tv;
   struct sched_param param;
   param.sched_priority = sched_get_priority_max(SCHED_FIFO);
   sched_setscheduler(0,SCHED_FIFO,&param);
   perror("sched_setscheduler");

   audio_dev = alsa_device_open(argv[1], SAMPLING_RATE, 1, FRAME_SIZE);
   /* Setup all file descriptors for poll()ing */
   nfds = alsa_device_nfds(audio_dev);
   pfds = malloc(sizeof(*pfds)*(nfds));
   alsa_device_getfds(audio_dev, pfds, nfds);
   alsa_device_start(audio_dev);
   while (1)
   {
      /* Wait for either 1) capture 2) playback 3) socket data */
      poll(pfds, nfds, -1);
      if (alsa_device_playback_ready(audio_dev, pfds, nfds))
      {
         short pcm[FRAME_SIZE];
         for (i=0;i<FRAME_SIZE;i++)
            pcm[i] = 0;
         /* Playback the audio and reset the echo canceller if we got an underru
n */
         gettimeofday(&tv, NULL);
         fprintf (stderr, "play %d\n", tv.tv_usec);
         alsa_device_write(audio_dev, pcm, FRAME_SIZE);
      }
      /* Audio available from the soundcard (capture) */
      if (alsa_device_capture_ready(audio_dev, pfds, nfds))
      {
         short pcm[FRAME_SIZE];
         /* Get audio from the soundcard */
         gettimeofday(&tv, NULL);
         fprintf (stderr, "rec %d\n", tv.tv_usec);
         alsa_device_read(audio_dev, pcm, FRAME_SIZE);
      }
   }
}

--------------020906010606060104040304
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------020906010606060104040304
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------020906010606060104040304--
