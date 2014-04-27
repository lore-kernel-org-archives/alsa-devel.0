From: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Subject: =?utf-8?q?Bug=3F_poll=28=29_timeout_in_alsa-jack_plu?=
	=?utf-8?q?gin?=
Date: Sun, 27 Apr 2014 07:46:57 +0400
Message-ID: <1398570417.659136189@f247.i.mail.ru>
Reply-To: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f247.i.mail.ru (f247.i.mail.ru [94.100.185.89])
 by alsa0.perex.cz (Postfix) with ESMTP id 439162615C0
 for <alsa-devel@alsa-project.org>; Sun, 27 Apr 2014 05:46:58 +0200 (CEST)
Received: from mail by f247.i.mail.ru with local (envelope-from
 <sergemp@mail.ru>) id 1WeG3N-0007ug-9V
 for alsa-devel@alsa-project.org; Sun, 27 Apr 2014 07:46:57 +0400
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

Hello.

I'm trying to debug mozilla code, which uses poll() when playing sound
and works fine with regular alsa device, but plays no sound over
alsa-jack plugin. I narrowed it down to a small sample. In that sample
poll() returns 0 even when pcm can accept data. Please, help me to fix
either a bug in that sample, or a bug in alsa-plugins.

The problem is hardware-independent. To reproduce it you need:

1. install and start jack2 daemon:
  jackd -r -dalsa -dhw:0 -r44100 -p1024 -n2

2. add to .asoundrc:
  pcm.jackplug {
    type plug
    slave { pcm "jack" }
  }
  pcm.jack {
    type jack
    playback_ports {
      0 system:playback_1
      1 system:playback_2
    }
    capture_ports {
      0 system:capture_1
      1 system:capture_2
    }
  }

3. build and run the poll() code example
  gcc -o poll-example poll-example.c -lasound
  ./poll-example

According to the common sense as long as PCM is ready to receive data
it's expected that poll() returns 1 and writei() is called.
Instead poll() returns 0 and the code plays nothing.

---------- poll() code example ---------
#include <assert.h>
#include <poll.h>
#include <alsa/asoundlib.h>

short buffer[96000];

int main()
{
  snd_pcm_t *pcm;
  assert( snd_pcm_open(&pcm, "jackplug", SND_PCM_STREAM_PLAYBACK, SND_PCM_NONBLOCK) == 0 );
  assert( snd_pcm_nonblock(pcm, 1) == 0 );
  assert( snd_pcm_set_params(pcm, SND_PCM_FORMAT_S16_LE, SND_PCM_ACCESS_RW_INTERLEAVED, 1/*channels*/, 48000/*rate*/, 1, 100000/*latency*/) == 0 );
  nfds_t nfds = snd_pcm_poll_descriptors_count(pcm);
  assert( nfds > 0 );
  struct pollfd *saved_fds = calloc(nfds, sizeof(struct pollfd));
  assert( snd_pcm_poll_descriptors(pcm, saved_fds, nfds) == nfds );

  // poll() and write(20)
  int timeout = 1000;
  int r = poll(saved_fds, nfds, timeout);
  fprintf(stderr, "poll=%d\n", r);
  if (r > 0)
  {
    unsigned short revents;
    r = snd_pcm_poll_descriptors_revents(pcm, saved_fds, nfds, &revents);
    fprintf(stderr, "snd_pcm_poll_descriptors_revents=%d\n", r);
    if (r == 0)
      fprintf(stderr, "snd_pcm_writei(20)=%d\n", snd_pcm_writei(pcm, buffer, 20));
  }

  // poll() and write(50)
  r = poll(saved_fds, nfds, timeout);
  fprintf(stderr, "poll=%d\n", r);
  if (r > 0)
  {
    unsigned short revents;
    r = snd_pcm_poll_descriptors_revents(pcm, saved_fds, nfds, &revents);
    fprintf(stderr, "snd_pcm_poll_descriptors_revents=%d\n", r);
    if (r == 0)
      fprintf(stderr, "snd_pcm_writei(50)=%d\n", snd_pcm_writei(pcm, buffer, 50));
  }

  // poll() and write(100)
  r = poll(saved_fds, nfds, timeout);
  fprintf(stderr, "poll=%d\n", r);
  if (r > 0)
  {
    unsigned short revents;
    r = snd_pcm_poll_descriptors_revents(pcm, saved_fds, nfds, &revents);
    fprintf(stderr, "snd_pcm_poll_descriptors_revents=%d\n", r);
    if (r == 0)
      fprintf(stderr, "snd_pcm_writei(100)=%d\n", snd_pcm_writei(pcm, buffer, 100));
  }

  assert( snd_pcm_close(pcm) == 0 );

  return 0;
}
---------- end of code example ---------

I tried to fix that in jack_pcm.c downloaded from
http://git.alsa-project.org/?p=alsa-plugins.git;a=blob;f=jack/pcm_jack.c

Making the first poll() return 1 was easy, I just added
  write(jack->fd, &i, 1);
to the end of snd_pcm_jack_prepare() function. But that haven't solved
the problem, because next call to snd_pcm_poll_descriptors_revents()
exhausts the socket and next poll() still returns 0.

Another guess was to define .transfer in snd_pcm_ioplug_callback_t and
handle read()s and write()s to polling socket there, but it seems that
.transfer is not called on writei() at all.

What's the correct approach?

Is there any official documentation about using poll() for ALSA? Or maybe
there're some manuals with meaning of snd_pcm_ioplug_callback_t fields?

-- 
