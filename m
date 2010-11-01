From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Hang in snd_pcm_writei with alsa-pulse plugin
Date: Mon, 01 Nov 2010 17:30:00 +0000
Message-ID: <4CCEF918.90807@colin.guthr.ie>
References: <20101101013819.GA22823@flim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 930E9103824
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 18:30:15 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PCyCy-0004yn-VF
	for alsa-devel@alsa-project.org; Mon, 01 Nov 2010 18:30:12 +0100
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 01 Nov 2010 18:30:12 +0100
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 01 Nov 2010 18:30:12 +0100
In-Reply-To: <20101101013819.GA22823@flim.org>
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

'Twas brillig, and Matthew Gregan at 01/11/10 01:38 did gyre and gimble:
> Hi,
> 
> I think I'm seeing a bug in the alsa-pulse plugin where the buffer
> management ends up corrupt and results in a deadlock waiting for free buffer
> space.  This occurs when resuming from pause using snd_pcm_pause.  After
> resuming, my application tries to write a fixed block of data, expecting
> snd_pcm_writei to block if the data is larger than the available buffer size
> (the result of snd_pcm_avail_update).
> 
> I originally observed this in the wild in Firefox, which pauses and resumes
> the sound device whenever network buffering occurs.  I'm planning to include
> the workaround mentioned below in the next Firefox release (Mozilla bug
> 573924).
> 
> What happens is that, after resuming with snd_pcm_pause, a call to
> snd_pcm_writei never returns.  This happens on the write call that would
> have exceeded the available buffer size, which I would expect to block only
> until sufficient buffer space became available.
> 
> It's possible to get into a similar situation using SND_PCM_NONBLOCK and
> waiting on the sound device if it returns EAGAIN, except that snd_pcm_writei
> always returns EAGAIN and snd_pcm_wait returns 1 immediately, resulting in a
> tight loop in the calling code.
> 
> I discovered that I can reliably workaround the problem by ensuring the
> first writes after resuming from pause are never larger than what
> snd_pcm_avail_update returns.  After writing enough to fill (but not exceed)
> the available buffer size, the code returns to the fixed buffer size per
> write strategy and continues as normal.
> 
> The problem occurs with the following stack:
> 
> #0  __poll (fds=<value optimized out>, 
>     nfds=<value optimized out>, timeout=<value optimized out>)
>     at ../sysdeps/unix/sysv/linux/poll.c:87
> #1  snd1_pcm_wait_nocheck (pcm=0x1b9a780, timeout=-1)
>     at pcm.c:2367
> #2  snd1_pcm_write_areas (pcm=0x1b9a780, 
>     areas=0x7fff4ce9b890, offset=<value optimized out>, size=30000, 
>     func=0x339ba91d10 <ioplug_priv_transfer_areas>) at pcm.c:6655
> #3  snd_pcm_ioplug_writei (pcm=0x1b9a780, 
>     buffer=<value optimized out>, size=30000) at pcm_ioplug.c:561
> #4  bwrite (pcm=0x1b9a780, towrite=30000) at
>     atest2.c:29
> #5  main (argc=1, argv=0x7fff4ce9ba68) at atest2.c:86
> 
> I'm Fedora 13 x86_64 with all updates from updates-testing.  ALSA is
> 1.0.22-1, PulseAudio is 0.9.21-6, and the kernel is 2.6.34.7-61.  I've also
> tested against the current git versions of alsa-libs and alsa-plugins and
> can still reproduce the problem.
> 
> I've attached a simple test program that reproduces this problem reliably on
> my machine.  It writes a period sized buffer in a loop, waiting half a
> period until the next attempt.  Every few iterations, it pauses the sound
> device for half a period and then resumes it.  It usually hangs within 2-3
> pause/resume cycles.  Running the test with "-r" enables the recovery code I
> mentioned above.  It never hangs when tested using the hardware ALSA backend
> with alsa-pulse disabled, but my sound hardware doesn't seem to support
> snd_pcm_pause.

Reproduced here I presume:
[colin@jimmy pulseaudio (master)]$ ./atest2
playback, wrote 3000 frames (needed 0)
playback, wrote 3000 frames (needed 1480)
playback, wrote 3000 frames (needed 2643)
playback, wrote 3000 frames (needed 3526)
playback, wrote 3000 frames (needed 526)
playback, wrote 3000 frames (needed 1313)
pausing playback
resuming playback
^C
[colin@jimmy pulseaudio (master)]$ ./atest2
playback, wrote 3000 frames (needed 0)
playback, wrote 3000 frames (needed 1584)
playback, wrote 3000 frames (needed 2764)
playback, wrote 3000 frames (needed 3648)
playback, wrote 3000 frames (needed 648)
playback, wrote 3000 frames (needed 1426)
pausing playback
resuming playback
^C

This is with latest PA from stable-queue.

Not sure whether this is "expected" or not, but it's probably worth you
posting this on PA devel list too for some further thought if this
thread doesn't garner much response here.

Cheers
Col




-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
