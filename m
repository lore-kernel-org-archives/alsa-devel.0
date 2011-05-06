From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Hang in snd_pcm_writei with alsa-pulse plugin
Date: Fri, 6 May 2011 21:46:05 +0800
Message-ID: <BANLkTin6Ew63SY2mYnbnEN_gbWTLAsz6OQ@mail.gmail.com>
References: <20101101013819.GA22823@flim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AF8B103AAF
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 15:46:06 +0200 (CEST)
Received: by fxm5 with SMTP id 5so2696788fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 06 May 2011 06:46:05 -0700 (PDT)
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

2010/11/1 Matthew Gregan <kinetik@flim.org>

> Hi,
>
> I think I'm seeing a bug in the alsa-pulse plugin where the buffer
> management ends up corrupt and results in a deadlock waiting for free
> buffer
> space.  This occurs when resuming from pause using snd_pcm_pause.  After
> resuming, my application tries to write a fixed block of data, expecting
> snd_pcm_writei to block if the data is larger than the available buffer
> size
> (the result of snd_pcm_avail_update).
>
> I originally observed this in the wild in Firefox, which pauses and resumes
> the sound device whenever network buffering occurs.  I'm planning to
> include
> the workaround mentioned below in the next Firefox release (Mozilla bug
> 573924).
>
> What happens is that, after resuming with snd_pcm_pause, a call to
> snd_pcm_writei never returns.  This happens on the write call that would
> have exceeded the available buffer size, which I would expect to block only
> until sufficient buffer space became available.
>
> It's possible to get into a similar situation using SND_PCM_NONBLOCK and
> waiting on the sound device if it returns EAGAIN, except that
> snd_pcm_writei
> always returns EAGAIN and snd_pcm_wait returns 1 immediately, resulting in
> a
> tight loop in the calling code.
>
> I discovered that I can reliably workaround the problem by ensuring the
> first writes after resuming from pause are never larger than what
> snd_pcm_avail_update returns.  After writing enough to fill (but not
> exceed)
> the available buffer size, the code returns to the fixed buffer size per
> write strategy and continues as normal.
>
> The problem occurs with the following stack:
>
> #0  __poll (fds=<value optimized out>,
>    nfds=<value optimized out>, timeout=<value optimized out>)
>    at ../sysdeps/unix/sysv/linux/poll.c:87
> #1  snd1_pcm_wait_nocheck (pcm=0x1b9a780, timeout=-1)
>    at pcm.c:2367
> #2  snd1_pcm_write_areas (pcm=0x1b9a780,
>    areas=0x7fff4ce9b890, offset=<value optimized out>, size=30000,
>    func=0x339ba91d10 <ioplug_priv_transfer_areas>) at pcm.c:6655
> #3  snd_pcm_ioplug_writei (pcm=0x1b9a780,
>    buffer=<value optimized out>, size=30000) at pcm_ioplug.c:561
> #4  bwrite (pcm=0x1b9a780, towrite=30000) at
>    atest2.c:29
> #5  main (argc=1, argv=0x7fff4ce9ba68) at atest2.c:86
>
> I'm Fedora 13 x86_64 with all updates from updates-testing.  ALSA is
> 1.0.22-1, PulseAudio is 0.9.21-6, and the kernel is 2.6.34.7-61.  I've also
> tested against the current git versions of alsa-libs and alsa-plugins and
> can still reproduce the problem.
>
> I've attached a simple test program that reproduces this problem reliably
> on
> my machine.  It writes a period sized buffer in a loop, waiting half a
> period until the next attempt.  Every few iterations, it pauses the sound
> device for half a period and then resumes it.  It usually hangs within 2-3
> pause/resume cycles.  Running the test with "-r" enables the recovery code
> I
> mentioned above.  It never hangs when tested using the hardware ALSA
> backend
> with alsa-pulse disabled, but my sound hardware doesn't seem to support
> snd_pcm_pause.
>
> using your test program and follow the instruction in
http://colin.guthr.ie/2010/09/compiling-and-running-pulseaudio-from-git/

It seem that PA server lost some of the audio at rewind when it resume from
cork and uncork, if you enable DEBUG_TIMING, in alsa-sink.c  PA server seem
still writing

Are there any statistics about how much data received from the client and
how much data PA server wrute to the sound card


: alsa-sink.c: Requested to rewind 352768 bytes.
D: alsa-sink.c: Limited to 351936 bytes.
D: alsa-sink.c: before: 87984
D: alsa-sink.c: after: 87984
D: alsa-sink.c: Rewound 351936 bytes.
D: sink.c: Processing rewind...
D: sink.c: latency = 2337
D: sink-input.c: Have to rewind 351936 bytes on render memblockq.
D: source.c: Processing rewind...
D: core-subscribe.c: Dropped redundant event due to change event.
D: reserve-wrap.c: Device lock status of
reserve-monitor-wrapper@Audio1changed: not busy
D: protocol-dbus.c: Interface org.PulseAudio.Core1.Stream added for object
/org/pulseaudio/core1/playback_stream0
D: protocol-native.c: Requesting rewind due to end of underrun.
D: alsa-sink.c: Requested to rewind 352768 bytes.
D: alsa-sink.c: Limited to 10032 bytes.
D: alsa-sink.c: before: 2508
D: alsa-sink.c: after: 2508
D: alsa-sink.c: Rewound 10032 bytes.
D: sink.c: Processing rewind...
D: sink.c: latency = 2259
D: sink-input.c: Have to rewind 10032 bytes on render memblockq.
D: source.c: Processing rewind...
D: sink-input.c: Requesting rewind due to corking
D: module-suspend-on-idle.c: Sink alsa_output.1.analog-stereo becomes idle,
timeout in 5 seconds.
D: sink-input.c: Requesting rewind due to uncorking
D: alsa-sink.c: Requested to rewind 352768 bytes.
D: alsa-sink.c: Limited to 10704 bytes.
D: alsa-sink.c: before: 2676
D: module-suspend-on-idle.c: Sink alsa_output.1.analog-stereo becomes busy.
D: alsa-sink.c: after: 2676
D: alsa-sink.c: Rewound 10704 bytes.
D: sink.c: Processing rewind...
D: sink.c: latency = 2012
D: source.c: Processing rewind...
D: protocol-native.c: Requesting rewind due to end of underrun.
D: alsa-sink.c: Requested to rewind 352768 bytes.
D: alsa-sink.c: Limited to 10672 bytes.
D: alsa-sink.c: before: 2668
D: alsa-sink.c: after: 2668
D: alsa-sink.c: Rewound 10672 bytes.
D: sink.c: Processing rewind...
D: sink.c: latency = 2012
D: sink-input.c: Have to rewind 10672 bytes on render memblockq.
D: source.c: Processing rewind...
D: sink-input.c: Requesting rewind due to corking
D: module-suspend-on-idle.c: Sink alsa_output.1.analog-stereo becomes idle,
timeout in 5 seconds.
D: sink-input.c: Requesting rewind due to uncorking
D: alsa-sink.c: Requested to rewind 352768 bytes.
D: module-suspend-on-idle.c: Sink alsa_output.1.analog-stereo becomes busy.
D: alsa-sink.c: Limited to 10672 bytes.
D: alsa-sink.c: before: 2668
D: alsa-sink.c: after: 2668
D: alsa-sink.c: Rewound 10672 bytes.
D: sink.c: Processing rewind...
D: sink.c: latency = 1720
D: source.c: Processing rewind...
D: protocol-native.c: Requesting rewind due to end of underrun.
D: alsa-sink.c: Requested to rewind 352768 bytes.
D: alsa-sink.c: Limited to 10672 bytes.
D: alsa-sink.c: before: 2668
D: alsa-sink.c: after: 2668
D: alsa-sink.c: Rewound 10672 bytes.
D: sink.c: Processing rewind...
D: sink.c: latency = 1690
D: sink-input.c: Have to rewind 10672 bytes on render memblockq.
D: source.c: Processing rewind...
D: sink-input.c: Requesting rewind due to corking
D: module-suspend-on-idle.c: Sink alsa_output.1.analog-stereo becomes idle,
timeout in 5 seconds.
D: protocol-native.c: Requesting rewind due to end of underrun.
D: sink-input.c: Requesting rewind due to uncorking
D: alsa-sink.c: Requested to rewind 352768 bytes.
D: module-suspend-on-idle.c: Sink alsa_output.1.analog-stereo becomes busy.
D: alsa-sink.c: Limited to 10704 bytes.
D: alsa-sink.c: before: 2676
D: alsa-sink.c: after: 2676
D: alsa-sink.c: Rewound 10704 bytes.
D: sink.c: Processing rewind...
D: sink.c: latency = 1457
D: source.c: Processing rewind...
D: sink-input.c: Requesting rewind due to corking
D: module-suspend-on-idle.c: Sink alsa_output.1.analog-stereo becomes idle,
timeout in 5 seconds.
D: sink-input.c: Requesting rewind due to uncorking
D: alsa-sink.c: Requested to rewind 352768 bytes.
D: module-suspend-on-idle.c: Sink alsa_output.1.analog-stereo becomes busy.
D: alsa-sink.c: Limited to 10672 bytes.
D: alsa-sink.c: before: 2668
D: alsa-sink.c: after: 2668
D: alsa-sink.c: Rewound 10672 bytes.
D: sink.c: Processing rewind...
D: sink.c: latency = 1369
D: source.c: Processing rewind...
D: protocol-native.c: Requesting rewind due to end of underrun.
D: alsa-sink.c: Requested to rewind 352768 bytes.
D: alsa-sink.c: Limited to 10672 bytes.
D: alsa-sink.c: before: 2668
D: alsa-sink.c: after: 2668
D: alsa-sink.c: Rewound 10672 bytes.
D: sink.c: Processing rewind...
D: sink.c: latency = 1372
D: sink-input.c: Have to rewind 10672 bytes on render memblockq.
D: source.c: Processing rewind...
D: sink-input.c: Requesting rewind due to corking
D: module-suspend-on-idle.c: Sink alsa_output.1.analog-stereo becomes idle,
timeout in 5 seconds.
D: protocol-native.c: Requesting rewind due to end of underrun.
D: sink-input.c: Requesting rewind due to uncorking
D: alsa-sink.c: Requested to rewind 352768 bytes.
D: alsa-sink.c: Limited to 10704 bytes.
D: alsa-sink.c: before: 2676
D: alsa-sink.c: after: 2676
D: alsa-sink.c: Rewound 10704 bytes.
D: sink.c: Processing rewind...
D: sink.c: latency = 1352
D: module-suspend-on-idle.c: Sink alsa_output.1.analog-stereo becomes busy.
D: source.c: Processing rewind...
D: sink-input.c: Requesting rewind due to corking
D: module-suspend-on-idle.c: Sink alsa_output.1.analog-stereo becomes idle,
timeout in 5 seconds.
D: protocol-native.c: Requesting rewind due to end of underrun.
D: sink-input.c: Requesting rewind due to uncorking
D: alsa-sink.c: Requested to rewind 352768 bytes.
D: module-suspend-on-idle.c: Sink alsa_output.1.analog-stereo becomes busy.
D: alsa-sink.c: Limited to 10704 bytes.
D: alsa-sink.c: before: 2676
D: alsa-sink.c: after: 2676
D: alsa-sink.c: Rewound 10704 bytes.
D: sink.c: Processing rewind...
D: sink.c: latency = 1409
D: source.c: Processing rewind...
D: sink-input.c: Requesting rewind due to corking
