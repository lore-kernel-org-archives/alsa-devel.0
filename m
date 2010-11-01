From: Matthew Gregan <kinetik@flim.org>
Subject: Hang in snd_pcm_writei with alsa-pulse plugin
Date: Mon, 1 Nov 2010 14:38:19 +1300
Message-ID: <20101101013819.GA22823@flim.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from flim.org (flim.org [65.99.223.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 95935243B4
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 02:38:26 +0100 (CET)
Received: from brak (unknown [121.98.132.55])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by flim.org (Postfix) with ESMTPSA id A1E2214397
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 01:37:36 +0000 (UTC)
Content-Disposition: inline
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


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I think I'm seeing a bug in the alsa-pulse plugin where the buffer
management ends up corrupt and results in a deadlock waiting for free buffer
space.  This occurs when resuming from pause using snd_pcm_pause.  After
resuming, my application tries to write a fixed block of data, expecting
snd_pcm_writei to block if the data is larger than the available buffer size
(the result of snd_pcm_avail_update).

I originally observed this in the wild in Firefox, which pauses and resumes
the sound device whenever network buffering occurs.  I'm planning to include
the workaround mentioned below in the next Firefox release (Mozilla bug
573924).

What happens is that, after resuming with snd_pcm_pause, a call to
snd_pcm_writei never returns.  This happens on the write call that would
have exceeded the available buffer size, which I would expect to block only
until sufficient buffer space became available.

It's possible to get into a similar situation using SND_PCM_NONBLOCK and
waiting on the sound device if it returns EAGAIN, except that snd_pcm_writei
always returns EAGAIN and snd_pcm_wait returns 1 immediately, resulting in a
tight loop in the calling code.

I discovered that I can reliably workaround the problem by ensuring the
first writes after resuming from pause are never larger than what
snd_pcm_avail_update returns.  After writing enough to fill (but not exceed)
the available buffer size, the code returns to the fixed buffer size per
write strategy and continues as normal.

The problem occurs with the following stack:

#0  __poll (fds=<value optimized out>, 
    nfds=<value optimized out>, timeout=<value optimized out>)
    at ../sysdeps/unix/sysv/linux/poll.c:87
#1  snd1_pcm_wait_nocheck (pcm=0x1b9a780, timeout=-1)
    at pcm.c:2367
#2  snd1_pcm_write_areas (pcm=0x1b9a780, 
    areas=0x7fff4ce9b890, offset=<value optimized out>, size=30000, 
    func=0x339ba91d10 <ioplug_priv_transfer_areas>) at pcm.c:6655
#3  snd_pcm_ioplug_writei (pcm=0x1b9a780, 
    buffer=<value optimized out>, size=30000) at pcm_ioplug.c:561
#4  bwrite (pcm=0x1b9a780, towrite=30000) at
    atest2.c:29
#5  main (argc=1, argv=0x7fff4ce9ba68) at atest2.c:86

I'm Fedora 13 x86_64 with all updates from updates-testing.  ALSA is
1.0.22-1, PulseAudio is 0.9.21-6, and the kernel is 2.6.34.7-61.  I've also
tested against the current git versions of alsa-libs and alsa-plugins and
can still reproduce the problem.

I've attached a simple test program that reproduces this problem reliably on
my machine.  It writes a period sized buffer in a loop, waiting half a
period until the next attempt.  Every few iterations, it pauses the sound
device for half a period and then resumes it.  It usually hangs within 2-3
pause/resume cycles.  Running the test with "-r" enables the recovery code I
mentioned above.  It never hangs when tested using the hardware ALSA backend
with alsa-pulse disabled, but my sound hardware doesn't seem to support
snd_pcm_pause.

Cheers,
-mjg
-- 
Matthew Gregan                     |/
                                  /|                    kinetik@flim.org

--sdtB3X0nJg68CQEu
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="atest2.c"

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <alsa/asoundlib.h>

#define RATE 48000

snd_pcm_uframes_t setup(snd_pcm_t ** pcm)
{
  snd_pcm_uframes_t bsize, psize;

  assert(snd_pcm_open(pcm, "default", SND_PCM_STREAM_PLAYBACK, 0) == 0);
  assert(snd_pcm_set_params(*pcm, SND_PCM_FORMAT_S16_LE,
                            SND_PCM_ACCESS_RW_INTERLEAVED,
                            1, RATE, 1, 250000) == 0);
  assert(snd_pcm_get_params(*pcm, &bsize, &psize) == 0);
  assert(bsize / psize >= 4);

  return psize;
}

void bwrite(snd_pcm_t * pcm, snd_pcm_sframes_t towrite)
{
  int r;
  char * garbage;

  garbage = calloc(1, towrite);
  r = snd_pcm_writei(pcm, garbage, towrite);
  free(garbage);

  if (r < 0) {
    fprintf(stderr, "bwrite error recovery\n");
    snd_pcm_recover(pcm, r, 1);
  }
}

snd_pcm_sframes_t fill(snd_pcm_t * pcm)
{
  snd_pcm_sframes_t avail;

  avail = snd_pcm_avail_update(pcm);
  if (avail < 0) {
    fprintf(stderr, "fill error recovery\n");
    snd_pcm_recover(pcm, avail, 1);
    avail = snd_pcm_avail_update(pcm);
  }
  if (avail) {
    bwrite(pcm, avail);
  }

  return avail;
}

int main(int argc, char * argv[])
{
  snd_pcm_t * pcm;
  snd_pcm_uframes_t psize;
  int pause = 0, count = 0, recovery = 0;

  if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'r') {
    recovery = 1;
  }

  /* set up a mono output device at RATE Hz with at least 4 periods */
  psize = setup(&pcm);

  /* prefill sound buffers and begin playback */
  fill(pcm);

  while (++count) {
    if (pause || count % 7 == 0) {
      fprintf(stderr, pause ? "resuming playback\n" : "pausing playback\n");
      pause = !pause;
      snd_pcm_pause(pcm, pause);

      /* if resuming playback and recovery enabled, fill sound buffers */
      if (recovery && !pause) {
        fprintf(stderr, "recovery, wrote %d frames\n", (int) fill(pcm));
      }
    }

    /* if not paused, write a period of sound data */
    if (!pause) {
      snd_pcm_sframes_t avail = snd_pcm_avail_update(pcm);
      bwrite(pcm, psize);
      fprintf(stderr, "playback, wrote %u frames (needed %d)\n", (unsigned int) psize, (int) avail);
    }

    /* sleep for half a period */
    usleep(psize * 1000000 / RATE / 2);
  }

  return 0;
}

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--sdtB3X0nJg68CQEu--
