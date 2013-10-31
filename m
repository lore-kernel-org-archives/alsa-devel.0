From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH 1/4] ALSA: hda - hdmi: Add ATI/AMD multi-channel audio support
Date: Fri, 1 Nov 2013 00:25:44 +0100
Message-ID: <CACna6rzejyTOF2Fvvw1m2SAob7uU5-hJ+yRVk6HS5pDTz7+JWg@mail.gmail.com>
References: <1380659456-3746-1-git-send-email-anssi.hannula@iki.fi>
	<1380659456-3746-2-git-send-email-anssi.hannula@iki.fi>
	<CACna6ryr37WRvKbMFmLEGt_A2zUD46rZOtJMVom+B_xK9WNLuw@mail.gmail.com>
	<07e8973b4665cc23c3f4a77e9c7e2b7c@mail.onse.fi>
	<CACna6ryFtmZHAhmCPEsoxZc5h4mLuM4ajnKGsp=q0jag2f_SYw@mail.gmail.com>
	<5272BCE1.7010700@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5272BCE1.7010700@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, =?UTF-8?Q?Peter_Fr=C3=BChberger?= <fritsch@xbmc.org>, Olivier Langlois <olivier@trillion01.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

2013/10/31 Anssi Hannula <anssi.hannula@iki.fi>:
>> But I can hear sound for rear right and rear left only :(
>>
>> Is there anything more I can provide to help resolve this? Do you ha=
ve
>> any idea how we can resolve this?
>
> According to the below the receiver has separate PCM SADs for 2-chann=
el
> and multichannel playback. However, due to a radeon driver bug (see
> "[PATCH] drm/radeon/audio: fix missing multichannel PCM SAD in some
> cases", you were CCd) the multichannel SAD is lost and not shown belo=
w.
>
> However, that is not (or at least should not be) the reason you are n=
ot
> getting audio.
> I suspect that the receiver does not support 192kHz multichannel audi=
o
> (which would be indicated in the missing multichannel PCM SAD). Does =
it
> work with 48kHz or 96kHz?
> (TODO: refuse PCM playback in such cases)
>
> If it does not work with 48kHz or 96kHz either, then we have a bug to
> solve :)

=46irst of all, you're right about 2 SADs for PCM.

The weird thing is that 192kHz support... According to the EDID (SADs)
it should be supported:
=46ormat: 1 (PCM)        Channels:1    Freq:0x7F (32-192)    B2:0x07 (1=
6-24b)
=46ormat: 1 (PCM)        Channels:7    Freq:0x7F (32-192)    B2:0x07 (1=
6-24b)
=46ormat: 2 (AC3)        Channels:7    Freq:0x07 (32-48)    B2:0x50 (64=
0?)
=46ormat: 7 (DTS)        Channels:7    Freq:0x06 (44-48)    B2:0xC0 (15=
36?)
=46ormat: 10 (EAC3)    Channels:7    Freq:0x06 (44-48)    B2:0x00
=46ormat: 11 (DTS_HD)    Channels:7    Freq:0x7E (44-192)    B2:0x01
=46ormat: 12 (MLP)    Channels:7    Freq:0x1E (44-96)    B2:0x00

So I performed more tests and:

1) speaker-test -D hdmi:CARD=3DGeneric,DEV=3D0 -c6 -r192000 -F S16_LE
A nice noise for rear right and rear left, silent for the rest

2) speaker-test -D hdmi:CARD=3DGeneric,DEV=3D0 -c6 -r176400 -F S16_LE
A nice noise for rear right and rear left, short "bump" sound for the r=
est

3) speaker-test -D hdmi:CARD=3DGeneric,DEV=3D0 -c6 -r96000 -F S16_LE
A nice noise for all speakers (the same applies to 88200, 48000, 44100,=
 32000)

I don't get it. Onkyo reports support for 192kHz and it supports it,
but only for 2 rear speakers... does it make any sense do you?

--=20
Rafa=C5=82
