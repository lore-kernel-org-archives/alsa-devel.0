From: cee1 <fykcee1@gmail.com>
Subject: Re: Adjust volume may cause audio playback corruption
Date: Thu, 17 May 2012 17:35:47 +0800
Message-ID: <CAGXxSxWSD+c9tnJHsKVDJYhq=AkY4KfefZgPj6rtgQozzFjuiQ@mail.gmail.com>
References: <CAGXxSxUxFbC3mGWa-pbUKrzUqsBbvoQ5PmXNrKfL2W_BXyv1_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id EDE32243A9
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2012 11:36:10 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so2889908pbb.38
	for <alsa-devel@alsa-project.org>; Thu, 17 May 2012 02:36:07 -0700 (PDT)
In-Reply-To: <CAGXxSxUxFbC3mGWa-pbUKrzUqsBbvoQ5PmXNrKfL2W_BXyv1_A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pulseaudio-discuss@lists.freedesktop.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2012/5/12 cee1 <fykcee1@gmail.com>:
> Hi all,
>
> We're using PA on our product, and sometimes audio playback may
> corrupt after adjusting volume.
>
> We found a way to (relatively) easily reproduce the problem:
> 1. Play sample.mp3 through totem in repeat mode.
> 2. In gnome-volume-control, Hardware tap, repeat to shift between "Off
> profile" and "Analog Stereo Duplex profile".
>
> When the problem happens, the corruption continues until I:
> * Do one more shift between "Off profile" and "Analog Stereo Duplex profi=
le".
> * Close totem (close all PA playback clients).
> * Adjust volume.
>
> When the problem happens, open another PA client doing audio playback,
> is also corrupt.
>
> Some additional information:
> * Output of alsa-info.sh on our product:
> http://dev.lemote.com/files/upload/software/PA-apc/alsa-info-lemote
> * PA daemon log:
> http://dev.lemote.com/files/upload/software/PA-apc/pulseaudio.log
> * The corrupted sound:
> http://dev.lemote.com/files/upload/software/PA-apc/corrupted_sound.ogg
> * The sample mp3: http://dev.lemote.com/files/upload/software/PA-apc/samp=
le.mp3
When the problem happens today, I notice:
1) PA complains "alsa-source.c: Overrun!". I doesn't run any recording
 application then. Curious.
2) Playback becomes good automatically when play sample.mp3 again(note
totem is in repeat playing mode). It says sink becomes idle(I didn't
touch totem, so totem should keep playing back).

Any idea?

Following is PA daemon log:
I: [alsa-source] ratelimit.c: 1226 events suppressed
I: [alsa-source] alsa-source.c: Overrun!
I: [alsa-source] alsa-source.c: Increasing minimal latency to 1.00 ms
D: [alsa-source] alsa-source.c: latency set to 20.00ms
D: [alsa-source] alsa-source.c: hwbuf_unused=3D62008
D: [alsa-source] alsa-source.c: setting avail_min=3D442
I: [alsa-source] alsa-source.c: Overrun!
I: [alsa-source] alsa-source.c: Increasing minimal latency to 2.00 ms
D: [alsa-source] alsa-source.c: latency set to 20.00ms
D: [alsa-source] alsa-source.c: hwbuf_unused=3D62008
D: [alsa-source] alsa-source.c: setting avail_min=3D442
I: [alsa-source] alsa-source.c: Overrun!
I: [alsa-source] alsa-source.c: Increasing minimal latency to 4.00 ms
D: [alsa-source] alsa-source.c: latency set to 20.00ms
D: [alsa-source] alsa-source.c: hwbuf_unused=3D62008
D: [alsa-source] alsa-source.c: setting avail_min=3D442
I: [alsa-source] alsa-source.c: Overrun!
I: [alsa-source] alsa-source.c: Increasing minimal latency to 8.00 ms
D: [alsa-source] alsa-source.c: latency set to 20.00ms
D: [alsa-source] alsa-source.c: hwbuf_unused=3D62008
D: [alsa-source] alsa-source.c: setting avail_min=3D442
I: [alsa-source] alsa-source.c: Overrun!
I: [alsa-source] alsa-source.c: Increasing minimal latency to 16.00 ms
D: [alsa-source] alsa-source.c: latency set to 20.00ms
D: [alsa-source] alsa-source.c: hwbuf_unused=3D62008
D: [alsa-source] alsa-source.c: setting avail_min=3D442
I: [alsa-source] alsa-source.c: Overrun!
I: [alsa-source] alsa-source.c: Increasing minimal latency to 26.00 ms
D: [alsa-source] alsa-source.c: latency set to 26.00ms
D: [alsa-source] alsa-source.c: hwbuf_unused=3D60952
D: [alsa-source] alsa-source.c: setting avail_min=3D706
D: [alsa-sink] protocol-native.c: Underrun on 'Playback Stream', 0
bytes in queue.
D: [alsa-sink] protocol-native.c: Requesting rewind due to rewrite.
D: [alsa-sink] sink-input.c: Requesting rewind due to corking
D: [alsa-sink] alsa-sink.c: Requested to rewind 16208 bytes.
D: [alsa-sink] alsa-sink.c: Limited to 15096 bytes.
D: [alsa-sink] alsa-sink.c: before: 3774
D: [alsa-sink] alsa-sink.c: after: 3642
D: [alsa-sink] alsa-sink.c: Rewound 14568 bytes.
D: [alsa-sink] sink.c: Processing rewind...
D: [alsa-sink] sink.c: latency =3D 4156
D: [alsa-sink] sink-input.c: Have to rewind 14568 bytes on render memblockq.
D: [alsa-sink] sink-input.c: Have to rewind 29136 bytes on implementor.
D: [alsa-sink] source.c: Processing rewind...
D: [pulseaudio] module-suspend-on-idle.c: Sink
alsa_output.pci-0000_00_14.2.analog-stereo becomes idle, timeout in 5
seconds.
D: [alsa-sink] protocol-native.c: Requesting rewind due to end of underrun.
D: [alsa-sink] protocol-native.c: Requesting rewind due to end of underrun.
D: [alsa-sink] protocol-native.c: Requesting rewind due to end of underrun.
D: [alsa-sink] protocol-native.c: Requesting rewind due to end of underrun.
D: [alsa-sink] protocol-native.c: Requesting rewind due to end of underrun.
D: [pulseaudio] sink.c: Suspend cause of sink
alsa_output.pci-0000_00_14.2.analog-stereo is 0x0004, suspending
I: [alsa-sink] alsa-sink.c: Device suspended...
I: [pulseaudio] alsa-sink.c: Updating rate for device front:0, new rate is =
44100
I: [pulseaudio] sink.c: Changed sampling rate successfully
D: [alsa-sink] protocol-native.c: Requesting rewind due to end of underrun.
D: [alsa-sink] sink-input.c: Requesting rewind due to uncorking
D: [pulseaudio] sink.c: Suspend cause of sink
alsa_output.pci-0000_00_14.2.analog-stereo is 0x0000, resuming
I: [alsa-sink] alsa-sink.c: Trying resume...
I: [alsa-sink] alsa-util.c: Trying to disable ALSA period wakeups,
using timers only
D: [alsa-sink] alsa-util.c: Maximum hw buffer size is 371 ms
D: [alsa-sink] alsa-util.c: Set buffer size first (to 16384 samples),
period size second (to 8192 samples).
I: [alsa-sink] alsa-util.c: ALSA period wakeups disabled
D: [alsa-sink] alsa-sink.c: Latency set to 90.00ms
D: [alsa-sink] alsa-sink.c: hwbuf_unused=3D49660
D: [alsa-sink] alsa-sink.c: setting avail_min=3D15503
I: [alsa-sink] alsa-sink.c: Time scheduling watermark is 20.00ms
I: [alsa-sink] alsa-sink.c: Resumed successfully...
D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change eve=
nt.
I: [alsa-sink] alsa-sink.c: Starting playback.
D: [alsa-sink] alsa-sink.c: Cutting sleep time for the initial
iterations by half.
D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change eve=
nt.
D: [alsa-sink] alsa-sink.c: Cutting sleep time for the initial
iterations by half.
D: [pulseaudio] module-suspend-on-idle.c: Sink
alsa_output.pci-0000_00_14.2.analog-stereo becomes busy.
D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC0 is accessible: yes
D: [alsa-sink] alsa-sink.c: Cutting sleep time for the initial
iterations by half.
D: [alsa-sink] alsa-sink.c: Cutting sleep time for the initial
iterations by half.
D: [alsa-sink] alsa-sink.c: Cutting sleep time for the initial
iterations by half.
D: [alsa-sink] alsa-sink.c: Cutting sleep time for the initial
iterations by half.
D: [alsa-sink] alsa-sink.c: Cutting sleep time for the initial
iterations by half.
D: [alsa-sink] alsa-sink.c: Cutting sleep time for the initial
iterations by half.
D: [alsa-sink] alsa-sink.c: Cutting sleep time for the initial
iterations by half.
D: [alsa-sink] alsa-sink.c: Cutting sleep time for the initial
iterations by half.
D: [alsa-sink] alsa-sink.c: Cutting sleep time for the initial
iterations by half.


>
> We've tried PA 1.0-0ubuntu3, 1.1-0ubuntu15 and 2.0, the problem continues.
>
> The problem can also be reproduced on an AMD turion 64 x2 board with
> ubuntu 10.10 and ubuntu 12.04:
> * Output of alsa-info:
> =A0ubuntu 10.10(32bit)
> http://dev.lemote.com/files/upload/software/PA-apc/alsa-info-ubuntu-10.10
> =A0ubuntu 12.04(32bit)
> http://dev.lemote.com/files/upload/software/PA-apc/alsa-info-ubuntu-12.04
>
> Note:
> * The AMD turion 64 x2 board uses the same chipset as our product.
> * gnome-volume-control is removed in ubuntu 12.04, thus we compiled
> it: http://dev.lemote.com/files/upload/software/PA-apc/gnome-volume-contr=
ol



-- =

Regards,

- cee1
