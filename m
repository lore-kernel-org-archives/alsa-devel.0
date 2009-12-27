From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsa-util.c: snd_pcm_avail() returned a value that
	is exceptionally large: 349696 bytes (1821 ms).
Date: Sun, 27 Dec 2009 09:39:27 +0800
Message-ID: <4f3252890912261739x372fb678yde8a8e0edb93fe6e@mail.gmail.com>
References: <1261191766.18070.10.camel@localhost.localdomain>
	<4f3252890912191547x1996cf7es190e8dac71dacaae@mail.gmail.com>
	<1261352484.18070.47.camel@localhost.localdomain>
	<1261869811.30924.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id C9F80103806
	for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2009 02:39:28 +0100 (CET)
Received: by pwi18 with SMTP id 18so23495919pwi.32
	for <alsa-devel@alsa-project.org>; Sat, 26 Dec 2009 17:39:27 -0800 (PST)
In-Reply-To: <1261869811.30924.69.camel@localhost.localdomain>
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

You have to provide the full pulseaudio log in order to find out which
application cause the problem


> > sink-input-by-application-
name:ALSA plug-in [aplay].
> > I: module-stream-restore.c: Restoring volume for sink input
> > sink-input-by-application-name:ALSA plug-in [aplay].
> > D: module-stream-restore.c: Not restoring mute state for sink input
> > sink-input-by-application-name:ALSA plug-in [aplay], because already
set.
> > D: module-suspend-on-idle.c: Sink
> > alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 becomes busy.


and pulseaudio parameters:- maxlength, tlength, base , ......

> > I: resampler.c: Using resampler 'speex-float-3'
> > I: resampler.c: Using float32le as working format.
> > I: resampler.c: Choosing speex quality setting 3.
> > D: memblockq.c: memblockq requested: maxlength=33554432, tlength=0,
base=4,
> > prebuf=0, minreq=1 maxrewind=0
> > D: memblockq.c: memblockq sanitized: maxlength=33554432,
tlength=33554432,
> > base=4, prebuf=0, minreq=4 maxrewind=0
> > I: sink-input.c: Created input 1 "ALSA Playback" on
> > alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 with sample spec
s16le
> > 2ch 22050Hz and channel map front-left,front-right
> > I: protocol-native.c: Requested tlength=500.68 ms, minreq=1.45 ms
> > D: protocol-native.c: Early requests mode enabled, configuring sink
latency
> > to minreq.
> > D: memblockq.c: memblockq requested: maxlength=4194304, tlength=44160,
> > base=4, prebuf=44032, minreq=128 maxrewind=0
> > D: memblockq.c: memblockq sanitized: maxlength=4194304, tlength=44160,
> > base=4, prebuf=44032, minreq=128 maxrewind=0
> > I: protocol-native.c: Final latency 502.13 ms = 497.78 ms + 2*1.45 ms +
1.45
> > ms
> > D: module-alsa-sink.c: latency set to 4.00ms
> > D: module-alsa-sink.c: hwbuf_unused_frames=1872
> > D: module-alsa-sink.c: setting avail_min=2225
> > D: module-alsa-sink.c: Requesting rewind due to latency change.
> > D: module-alsa-sink.c: Requested to rewind 8192 bytes.
> > D: module-alsa-sink.c: Limited to 7804 bytes.
> > D: module-alsa-sink.c: before: 1951
> > D: module-alsa-sink.c: after: 1951
> > D: module-alsa-sink.c: Rewound 7804 bytes.
> > D: sink.c: Processing rewind...
> > D: sink-input.c: Have to rewind 7804 bytes on render memblockq.
> > E: asyncq.c: q overrun, queuing locally
> > E: asyncq.c: q overrun, queuing locally
> > E: asyncq.c: q overrun, queuing locally
> > E: asyncq.c: q overrun, queuing locally
> > I: module-alsa-sink.c: Underrun!
> > E: asyncq.c: q overrun, queuing locally
> > E: asyncq.c: q overrun, queuing locally
> > E: asyncq.c: q overrun, queuing locally
> > D: protocol-native.c: Requesting rewind due to end of underrun.
> > D: protocol-native.c: Requesting rewind due to end of underrun.
> > D: protocol-native.c: Requesting rewind due to end of underrun.
> > I: module-alsa-sink.c: Underrun!
> > I: module-alsa-sink.c: Underrun!
> > I: module-alsa-sink.c: Underrun!
> > I: module-alsa-sink.c: Underrun!
> > D: sink-input.c: Requesting rewind due to corking


Only post the error message is useless for debugging

2009/12/27 Chris <cpollock@embarqmail.com>

> On Sun, 2009-12-20 at 17:41 -0600, Chris wrote:
> > On Sun, 2009-12-20 at 07:47 +0800, Raymond Yau wrote:
> > > I can reproduce this bug on pulseaudio-0.9.14 by
> > >
> > > aplay -v --period-size=32  any_rate_not_equal_44100Hz.wav
> > >
> > >
>
> I'm still seeing this:
>
> Dec 26 14:53:19 localhost pulseaudio[5772]: ratelimit.c: 468 events
> suppressed
> Dec 26 14:53:19 localhost pulseaudio[5772]: asyncq.c: q overrun, queuing
> locally
> Dec 26 14:53:19 localhost last message repeated 10 times
>
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c: snd_pcm_avail()
> returned a value that is exceptionally large: 88384 bytes (501 ms).
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c: Most likely
> this is a bug in the ALSA driver 'snd_ens1371'. Please report this issue
> to the ALSA developers.
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c: snd_pcm_dump():
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c: Hardware PCM
> card 1 'Ensoniq AudioPCI' device 0 subdevice 0
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c: Its setup is:
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> stream       : PLAYBACK
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> access       : MMAP_INTERLEAVED
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> format       : S16_LE
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> subformat    : STD
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> channels     : 2
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> rate         : 44100
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:   exact
> rate   : 44101 (1445100000/32768)
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> msbits       : 16
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> buffer_size  : 4408
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> period_size  : 1102
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> period_time  : 24988
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> tstamp_mode  : ENABLE
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> period_step  : 1
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> avail_min    : 1102
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> period_event : 0
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> start_threshold  : -1
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> stop_threshold   : 1155530752
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> silence_threshold: 0
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> silence_size : 0
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> boundary     : 1155530752
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> appl_ptr     : 188107008
> Dec 26 16:07:17 localhost pulseaudio[5772]: alsa-util.c:
> hw_ptr       : 188130144
> Dec 26 16:07:17 localhost pulseaudio[5772]: ratelimit.c: 9 events
> suppressed
>
> though fortunately the drive doesn't seem to be thrashing any more. Is
> there anymore information I can provide that will help in
> troubleshooting this?
>
> Chris
>
>
> --
> KeyID 0xE372A7DA98E6705C
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
