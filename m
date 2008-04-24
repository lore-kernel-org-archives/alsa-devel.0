From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Buffering issues 2
Date: Thu, 24 Apr 2008 03:18:33 +0200
Message-ID: <20080424011833.GA28905@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id EFA7E24744
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Apr 2008 03:18:34 +0200 (CEST)
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
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Heya!

In addition to the buffering issues pointed out on http://mailman.alsa-project.org/pipermail/alsa-devel/2008-April/007354.html
I now have some more issues with the way buffering works in ALSA.

This time I am pretty sure it's a bug in the HDA drivers.

PulseAudio basically does this (again, as part of the glitch-free playback
model, see http://0pointer.de/blog/projects/pulse-glitch-free.html):

for (;;) {
    for (;;) {
        snd_pcm_hwsync();
        n = snd_pcm_avail_update();
        if (!n) 
            break;
        fill_up(n);
    }
    usleep(buffer_time - 20ms);
}

The buffer time is 370ms, so we usually sleep for 350ms.

It's a lot more complex actually, due to deviating timing and some
code that we don't enter a busy loop if the CPU is slower then the
sound card and so on and so on. However, basically it's this
algorithm.

This works fine on USB. However on HDA it sometimes happens that
snd_pcm_avail_update() is not properly updated at the right
time. Instead it seems to return what was current one iteration
earlier. I.e. we fill up the hw buffer until _avail_update() returns
0. Then assuming that it is fully filled up we go to sleep for
350ms. When we wake up we query _avail_update() again and it will
immediately return 0. We thus don't write anything to the
device. Instead we go to sleep for another 350ms. Of course, when we
wake up again the buffer will already have underrun (since 700 ms
passed since the last write to the buffer and th buffer is only 370ms
long) and we have a problem. In short: _avail_update() told us that
everything was alright and we trusted it and it lied to us.

The happens to be configured to 2 periods. So even if _avail_update()
has some kind of period granularity (?) it should always have told us
after we come back from the sleeping that at least *one* period is
free. But it said 0 frames. Nada. Rien. Nichts. Kaputt.

I *am* calling snd_pcm_hwsync(). So I'd assume that _avail_update()
would be as up to date as it gets. But it isn't. :-(

This happens regardless if I open the device as "front:0" (i.e. with
softvol in line) or as "hw:0" (no plugins).

This doesn't always happen. It seems to depend on the machine how
often this happens. On one machine I can reliably reproduce this after
30 iterations.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
