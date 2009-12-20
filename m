From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsa-util.c: snd_pcm_avail() returned a value that
	is exceptionally large: 349696 bytes (1821 ms).
Date: Sun, 20 Dec 2009 09:54:28 +0800
Message-ID: <4f3252890912191754s3536500eqc95058eac5da2ad6@mail.gmail.com>
References: <1261191766.18070.10.camel@localhost.localdomain>
	<4f3252890912191547x1996cf7es190e8dac71dacaae@mail.gmail.com>
	<1261272369.18070.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f183.google.com (mail-px0-f183.google.com
	[209.85.216.183])
	by alsa0.perex.cz (Postfix) with ESMTP id B9D371037F2
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 02:54:29 +0100 (CET)
Received: by pxi13 with SMTP id 13so2900143pxi.24
	for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2009 17:54:28 -0800 (PST)
In-Reply-To: <1261272369.18070.42.camel@localhost.localdomain>
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

if I use default period size of aplay , the pulseaudio server run quite well
when I play audio with different sample rate

May be bug in PA server when adjusting latency if you play audio at
different rate.

Another bug


I: sink-input.c: Created input 21 "ALSA Playback" on
alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 with sample spec s16le
2ch 22050Hz and channel map front-left,front-right
I: protocol-native.c: Requested tlength=500.68 ms, minreq=1.45 ms
D: protocol-native.c: Early requests mode enabled, configuring sink latency
to minreq.
D: memblockq.c: memblockq requested: maxlength=4194304, tlength=44160,
base=4, prebuf=44032, minreq=128 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=4194304, tlength=44160,
base=4, prebuf=44032, minreq=128 maxrewind=0
I: protocol-native.c: Final latency 502.13 ms = 497.78 ms + 2*1.45 ms + 1.45
ms
D: module-alsa-sink.c: latency set to 4.00ms
D: module-alsa-sink.c: hwbuf_unused_frames=1872
D: module-alsa-sink.c: setting avail_min=2225
D: module-alsa-sink.c: Requesting rewind due to latency change.
D: module-alsa-sink.c: Requested to rewind 8192 bytes.
D: module-alsa-sink.c: Limited to 7804 bytes.
D: module-alsa-sink.c: before: 1951
D: module-alsa-sink.c: after: 1951
D: module-alsa-sink.c: Rewound 7804 bytes.
D: sink.c: Processing rewind...
D: sink-input.c: Have to rewind 7804 bytes on render memblockq.
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
I: module-alsa-sink.c: Underrun!
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncq.c: q overrun, queuing locally
E: asyncmsgq.c: Assertion 'pa_asyncq_push(a->asyncq, &i, TRUE) == 0' failed
at pulsecore/asyncmsgq.c:164, function pa_asyncmsgq_send(). Aborting.
Aborted


2009/12/20 Chris <cpollock@embarqmail.com>

> On Sun, 2009-12-20 at 07:47 +0800, Raymond Yau wrote:
> > I can reproduce this bug on pulseaudio-0.9.14 by
> >
> > aplay -v --period-size=32  any_rate_not_equal_44100Hz.wav
> >
> >
> Note - I reported this as bug#
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4834 on 14
> December.
>
>
