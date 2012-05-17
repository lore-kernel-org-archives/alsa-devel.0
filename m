From: cee1 <fykcee1@gmail.com>
Subject: Re: Adjust volume may cause audio playback corruption
Date: Thu, 17 May 2012 21:30:02 +0800
Message-ID: <CAGXxSxUYWLyRZ1BEz53TRY9aE-CPPxSRoZeNGE5QTsOKP=B+Gg@mail.gmail.com>
References: <CAGXxSxUxFbC3mGWa-pbUKrzUqsBbvoQ5PmXNrKfL2W_BXyv1_A@mail.gmail.com>
	<CAGXxSxWSD+c9tnJHsKVDJYhq=AkY4KfefZgPj6rtgQozzFjuiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A5D7810404F
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2012 15:30:23 +0200 (CEST)
Received: by dajt11 with SMTP id t11so3003991daj.38
	for <alsa-devel@alsa-project.org>; Thu, 17 May 2012 06:30:22 -0700 (PDT)
In-Reply-To: <CAGXxSxWSD+c9tnJHsKVDJYhq=AkY4KfefZgPj6rtgQozzFjuiQ@mail.gmail.com>
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

2012/5/17 cee1 <fykcee1@gmail.com>:
> 2012/5/12 cee1 <fykcee1@gmail.com>:
>> Hi all,
>>
>> We're using PA on our product, and sometimes audio playback may
>> corrupt after adjusting volume.
>>
>> We found a way to (relatively) easily reproduce the problem:
>> 1. Play sample.mp3 through totem in repeat mode.
>> 2. In gnome-volume-control, Hardware tap, repeat to shift between "Off
>> profile" and "Analog Stereo Duplex profile".
>>
>> When the problem happens, the corruption continues until I:
>> * Do one more shift between "Off profile" and "Analog Stereo Duplex prof=
ile".
>> * Close totem (close all PA playback clients).
>> * Adjust volume.
>>
>> When the problem happens, open another PA client doing audio playback,
>> is also corrupt.
>>
>> Some additional information:
>> * Output of alsa-info.sh on our product:
>> http://dev.lemote.com/files/upload/software/PA-apc/alsa-info-lemote
>> * PA daemon log:
>> http://dev.lemote.com/files/upload/software/PA-apc/pulseaudio.log
>> * The corrupted sound:
>> http://dev.lemote.com/files/upload/software/PA-apc/corrupted_sound.ogg
>> * The sample mp3: http://dev.lemote.com/files/upload/software/PA-apc/sam=
ple.mp3
> When the problem happens today, I notice:
> 1) PA complains "alsa-source.c: Overrun!". I doesn't run any recording
> =A0application then. Curious.
> 2) Playback becomes good automatically when play sample.mp3 again(note
> totem is in repeat playing mode). It says sink becomes idle(I didn't
> touch totem, so totem should keep playing back).
Update:

We've found a way the can reproduce the problem more quickly on our product:
1. do audio playback
2. alsamixer, select 'Master', press 'm' and hold for a while.

Then release 'm', playback corrupts(sounds similar to
http://dev.lemote.com/files/upload/software/PA-apc/corrupted_sound.ogg).
I notice the following in PA daemon log:
( 439.779|  55.236) D: [alsa-sink][modules/alsa/alsa-sink.c:1261
sink_get_volume_cb()] Read hardware volume: 0:  78% 1:  78%
([0x31a4e488])
( 439.780|   0.000) D: [alsa-sink][modules/alsa/alsa-sink.c:1266
sink_get_volume_cb()]                in dB: 0: -6.40 dB 1: -6.40 dB
([0x31a4e488])
( 439.781|   0.001) I:
[pulseaudio][modules/module-device-restore.c:723 subscribe_callback()]
Storing volume/mute for device+port
sink:alsa_output.pci-0000_00_14.2.analog-stereo:analog-output.
([0x7f891270])
( 439.782|   0.001) D: [alsa-sink][modules/alsa/alsa-sink.c:1607
process_rewind()] Requested to rewind 65536 bytes. ([0x31a4e9d8])
( 439.782|   0.000) D: [alsa-sink][modules/alsa/alsa-sink.c:1630
process_rewind()] Limited to 11248 bytes. ([0x31a4e9d8])
( 439.783|   0.000) D: [alsa-sink][modules/alsa/alsa-sink.c:1633
process_rewind()] before: 2812 ([0x31a4e9d8])
( 439.783|   0.000) D: [alsa-sink][modules/alsa/alsa-sink.c:1641
process_rewind()] after: 2812 ([0x31a4e9d8])
( 439.783|   0.000) D: [alsa-sink][modules/alsa/alsa-sink.c:1649
process_rewind()] Rewound 11248 bytes. ([0x31a4e9d8])
( 439.783|   0.000) D: [alsa-sink][pulsecore/sink.c:935
pa_sink_process_rewind()] Processing rewind... ([0x31a4e998])
( 439.783|   0.000) D: [alsa-sink][pulsecore/sink.c:3617
pa_sink_volume_change_rewind()] latency =3D 632 ([0x31a4e928])
( 439.784|   0.000) D: [alsa-sink][pulsecore/sink-input.c:984
pa_sink_input_process_rewind()] Have to rewind 11248 bytes on render
memblockq. ([0x31a4e940])
( 439.784|   0.000) D: [alsa-sink][pulsecore/source.c:864
pa_source_process_rewind()] Processing rewind... ([0x31a4e958])

I guess it is 'rewind' that cause the problem? What does rewind do?
Why we need rewind here?

BTW, PA has module-device-restore and module-stream-restore, dose that
means we don't need alsa-restore.service/store stuffs? What is the
difference between device-restore and stream-restore?



----
Regards,
cee1
