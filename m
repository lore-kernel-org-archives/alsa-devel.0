From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsa-util.c: snd_pcm_avail() returned a value that
	is exceptionally large: 349696 bytes (1821 ms).
Date: Mon, 21 Dec 2009 09:45:22 +0800
Message-ID: <4f3252890912201745j386981b6v66d2c717c16e892e@mail.gmail.com>
References: <1261191766.18070.10.camel@localhost.localdomain>
	<4f3252890912191547x1996cf7es190e8dac71dacaae@mail.gmail.com>
	<1261352484.18070.47.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 433501037FF
	for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2009 02:45:27 +0100 (CET)
Received: by pwi18 with SMTP id 18so11888453pwi.32
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 17:45:26 -0800 (PST)
In-Reply-To: <1261352484.18070.47.camel@localhost.localdomain>
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

2009/12/21 Chris <cpollock@embarqmail.com>

> On Sun, 2009-12-20 at 07:47 +0800, Raymond Yau wrote:
> > I can reproduce this bug on pulseaudio-0.9.14 by
> >
> > aplay -v --period-size=32  any_rate_not_equal_44100Hz.wav
> >
> >
>
> Anyway to stop this from happening? When it does happen it's causing my
> drive to thrash for about 4-5 minutes or longer as shown below:
>
> Dec 20 14:35:50 localhost pulseaudio[4331]: ratelimit.c: 271 events
> suppressed
> Dec 20 14:35:50 localhost pulseaudio[4331]: asyncq.c: q overrun, queuing
> locally
>
> Dec 20 14:44:15 localhost pulseaudio[4331]: asyncq.c: q overrun, queuing
> locally
>
>
>
you have to provide  a test case which can reproduce this bug and a full
pulseaudio log which recorded how this bug occur

http://www.pulseaudio.org/wiki/Community#BugsPatchesTranslations

If autospawning is enabled (which it now is by default) you might have to
race against it when restarting PA, so it might be a good idea to issue
"pulseaudio -k ; pulseaudio -vvvvv" in a single command


In my case , I suspect the latency and watermark calculation did not get the
correct watermark/sleeping time when the alsa application using small period
size (128 bytes is the alsa-pulse-plugin 's minimum period size ) since the
error "asyncq.c: q overrun, queuing
locally" does not occur when using the normal period_size of those
applications (e.g. aplay , mplayer work quite well ) or rewind too much
since snd_pcm_rewind() is a new function which is only used by PA server


> D: memblockq.c: memblockq requested: maxlength=4194304, tlength=44160,
> base=4, prebuf=44032, minreq=128 maxrewind=0
> D: memblockq.c: memblockq sanitized: maxlength=4194304, tlength=44160,
> base=4, prebuf=44032, minreq=128 maxrewind=0
> I: protocol-native.c: Final latency 502.13 ms = 497.78 ms + 2*1.45 ms +
1.45
> ms
> D: module-alsa-sink.c: latency set to 4.00ms
> D: module-alsa-sink.c: hwbuf_unused_frames=1872
> D: module-alsa-sink.c: setting avail_min=2225
> D: module-alsa-sink.c: Requesting rewind due to latency change.
> D: module-alsa-sink.c: Requested to rewind 8192 bytes.
> D: module-alsa-sink.c: Limited to 7804 bytes.
> D: module-alsa-sink.c: before: 1951
> D: module-alsa-sink.c: after: 1951
> D: module-alsa-sink.c: Rewound 7804 bytes.
> D: sink.c: Processing rewind...
> D: sink-input.c: Have to rewind 7804 bytes on render memblockq.
> E: asyncq.c: q overrun, queuing locally
> E: asyncq.c: q overrun, queuing locally
> E: asyncq.c: q overrun, queuing locally
> E: asyncq.c: q overrun, queuing locally
> I: module-alsa-sink.c: Underrun!
