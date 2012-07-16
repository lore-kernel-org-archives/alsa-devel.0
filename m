From: Matthew Gregan <kinetik@flim.org>
Subject: Immediate underrun with PulseAudio ALSA plugin when PA
 and ALSA buffer sizes differ
Date: Tue, 17 Jul 2012 09:38:55 +1200
Message-ID: <20120716213855.GE7462@flim.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7iMSBzlTiPOCCT2k"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from flim.org (flim.org [65.99.223.158])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C080264EF7
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2012 23:38:59 +0200 (CEST)
Received: from brak (unknown [121.98.132.55])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by flim.org (Postfix) with ESMTPSA id F0CF21431F
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2012 21:38:59 +0000 (UTC)
Content-Disposition: inline
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


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm investigating an issue in Firefox's audio code when the PulseAudio ALSA
plugin is in use.  I posted about this on pulseaudio-discuss last week
(http://lists.freedesktop.org/archives/pulseaudio-discuss/2012-July/014091.html),
but I hoped I might have more success here.

Firefox requests a particular latency (100ms, 4410 frames at 44.1kHz) via
snd_pcm_set_params.  Inside the plugin (pcm_pulse.c:pulse_hw_params), that
value is used to set up buffer_attr.  When the PA stream is connected in
pcm_pulse.c:pulse_prepare, PA may configure the stream with larger
buffer_attr values (e.g. because the minimum sink latency has increased over
time due to underruns on the server, or because the sink hardware doesn't
support lower latency), but this isn't reflected in pcm->buffer_attr or
higher layers in ALSA (i.e. pcm->buffer_size is not updated).

The problem I'm faced with is that there doesn't appear to be a way to
detect and handle this issue at the ALSA API level, and requesting a too low
latency results in broken audio playback rather than a PCM setup failure or
a larger buffer than requested being used.

In the case of the PA server's minimum latency increasing over time, this
also means that a stream that was configured and running correctly may break
while running if PA increases the minimum latency above what the PCM was
originally configured with.

I've attached a simple testcase that uses snd_pcm_wait,
snd_pcm_avail_update, and snd_pcm_writei.  Run it with a latency argument
specified in milliseconds on the command line.  For my local machine, 55ms
works and 54ms fails immediately like so:

snd_pcm_wait wakes
snd_pcm_avail_update returns 4410
snd_pcm_writei writes 4410
snd_pcm_wait wakes immediately
snd_pcm_avail_update returns -EPIPE

(Note that when I reported this on pulseaudio-discuss, my server's minimum
latency was 45ms, and now pacmd list-sinks | grep configured\ latency
reports a minimum latency of 56ms)

I'd expect to see one of the following behaviours instead:
1. PCM setup fails due to requesting a too small buffer.
2. Buffer is silently raised during setup and snd_pcm_avail_update requests
   the correct number of frames.

Presumably this could be achieved by having the PA plugin report valid
values from pcm_pulse.c:pulse_hw_constraint, but I'm not sure how to query
the necessary values from the server.  This also wouldn't address the
problem where the buffer_attr changes over time, and I'm not sure what to do
about that case.

Thanks,
-mjg

--7iMSBzlTiPOCCT2k
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="latency.c"

#include <sys/time.h>
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <alsa/asoundlib.h>

static double
ts(void)
{
  static struct timeval last;
  struct timeval now, dt;
  if (last.tv_sec == 0) {
    gettimeofday(&last, NULL);
  }
  gettimeofday(&now, NULL);
  timersub(&now, &last, &dt);
  last = now;
  return dt.tv_sec * 1000.0 + dt.tv_usec / 1000.0;
}

int
main(int argc, char * argv[])
{
  int r;
  snd_pcm_t * pcm;
  snd_pcm_uframes_t buffer_size, period_size;
  char silence[88200] = {0};

  if (argc != 2) {
    return 1;
  }

  r = snd_pcm_open(&pcm, "default", SND_PCM_STREAM_PLAYBACK, 0);
  assert(r == 0);

  r = snd_pcm_set_params(pcm, SND_PCM_FORMAT_S16_LE,
                         SND_PCM_ACCESS_RW_INTERLEAVED, 2, 44100, 1,
                         atoi(argv[1]) * 1000);
  assert(r == 0);

  r = snd_pcm_get_params(pcm, &buffer_size, &period_size);
  assert(r == 0);
  fprintf(stderr, "%.2f: buffer_size = %u, period_size = %u\n",
          ts(), (unsigned) buffer_size, (unsigned) period_size);
  assert(buffer_size <= sizeof(silence) / 4);

  for (;;) {
    snd_pcm_sframes_t avail, wrote = 0;

    snd_pcm_wait(pcm, -1);

    avail = snd_pcm_avail_update(pcm);
    if (avail == -EPIPE) {
      snd_pcm_recover(pcm, -EPIPE, 0);
      avail = snd_pcm_avail_update(pcm);
    }
    if (avail > 0) {
      wrote = snd_pcm_writei(pcm, silence, avail);
    }
    fprintf(stderr, "%.2f: avail = %d, wrote = %d\n", ts(), (int) avail, (int) wrote);
  }

  return 0;
}

--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--7iMSBzlTiPOCCT2k--
