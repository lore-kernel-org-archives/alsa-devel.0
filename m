From: Halim Sahin <halim.sahin@freenet.de>
Subject: Re: a11y: howto reduce latency with alsa's dmix plugin?
Date: Wed, 02 Sep 2009 10:56:17 +0200
Message-ID: <87ab1dg1xq.fsf@freenet.de>
References: <20090823095517.GA27741@halim> <s5hws4k2f1k.wl%tiwai@suse.de>
	<87fxb7j6pw.fsf@freenet.de> <s5hy6ozt0cd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 031BB24562
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Sep 2009 10:56:40 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1Mildv-0004pl-ET
	for alsa-devel@alsa-project.org; Wed, 02 Sep 2009 10:56:39 +0200
Received: from pd9e0f96c.dip.t-dialin.net ([217.224.249.108])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 02 Sep 2009 10:56:39 +0200
Received: from halim.sahin by pd9e0f96c.dip.t-dialin.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 02 Sep 2009 10:56:39 +0200
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

--=-=-=

On Di, Sep 01 2009, Takashi Iwai wrote:

> At best, we need a small C code that reproduces the behavior.
Ok here is a small example.
It's a modified version of pcm_min.c.
Simply press ctrl+c to reproduce the problematic behaviour.
on my machine it takes about an half sek to stop with an usb head which
uses dmix.
Using an sblive card (without dmix) stopps immediately.

--=-=-=
Content-Type: text/x-csrc
Content-Disposition: attachment; filename=pcm_min.c

/*
 *  This extra small demo sends a random samples to your speakers.
 */

#include <alsa/asoundlib.h>
#include <signal.h>
#include <unistd.h>
static char *device = "default";

snd_output_t *output = NULL;

unsigned char buffer[16 * 1024];        /* some random data */

snd_pcm_t *handle;

void suspend (int signum)
{
  int err;

  printf ("trying to stop\n");
  if ((err = snd_pcm_drop (handle)) < 0)
    printf ("cannot pause\n");

  sleep (1);
  snd_pcm_close (handle);

  exit (1);
}

int main (void)
{
  int err;

  unsigned int i;

  snd_pcm_sframes_t frames;

  signal (SIGINT, suspend);
  for (i = 0; i < sizeof (buffer); i++)
    buffer[i] = random () & 0xff;

  if ((err = snd_pcm_open (&handle, device, SND_PCM_STREAM_PLAYBACK, 0)) < 0)
   {
     printf ("Playback open error: %s\n", snd_strerror (err));
     exit (EXIT_FAILURE);
   }
  if ((err = snd_pcm_set_params (handle,
                                 SND_PCM_FORMAT_U8,
                                 SND_PCM_ACCESS_RW_INTERLEAVED,
                                 1, 48000, 1, 500000)) < 0)
   {                            /* 0.5sec */
     printf ("Playback open error: %s\n", snd_strerror (err));
     exit (EXIT_FAILURE);
   }

  for (i = 0; i < 16; i++)
   {
     frames = snd_pcm_writei (handle, buffer, sizeof (buffer));
     if (frames < 0)
       frames = snd_pcm_recover (handle, frames, 0);
     if (frames < 0)
      {
        printf ("snd_pcm_writei failed: %s\n", snd_strerror (err));
        break;
      }
     if (frames > 0 && frames < (long) sizeof (buffer))
       printf ("Short write (expected %li, wrote %li)\n",
               (long) sizeof (buffer), frames);
   }

  snd_pcm_close (handle);
  return 0;
}

--=-=-=

Hope you can help.
Kind regards
Halim

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-=-=--
