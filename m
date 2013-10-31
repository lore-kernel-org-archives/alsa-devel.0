From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH 1/4] ALSA: hda - hdmi: Add ATI/AMD multi-channel audio
 support
Date: Fri, 01 Nov 2013 01:34:56 +0200
Message-ID: <5272E920.6030606@iki.fi>
References: <1380659456-3746-1-git-send-email-anssi.hannula@iki.fi>	<1380659456-3746-2-git-send-email-anssi.hannula@iki.fi>	<CACna6ryr37WRvKbMFmLEGt_A2zUD46rZOtJMVom+B_xK9WNLuw@mail.gmail.com>	<07e8973b4665cc23c3f4a77e9c7e2b7c@mail.onse.fi>	<CACna6ryFtmZHAhmCPEsoxZc5h4mLuM4ajnKGsp=q0jag2f_SYw@mail.gmail.com>	<5272BCE1.7010700@iki.fi> <CACna6rzejyTOF2Fvvw1m2SAob7uU5-hJ+yRVk6HS5pDTz7+JWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACna6rzejyTOF2Fvvw1m2SAob7uU5-hJ+yRVk6HS5pDTz7+JWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, =?UTF-8?B?UGV0ZXIgRnLDvGhiZXJnZXI=?= <fritsch@xbmc.org>, Olivier Langlois <olivier@trillion01.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

01.11.2013 01:25, Rafa=C5=82 Mi=C5=82ecki kirjoitti:
> 2013/10/31 Anssi Hannula <anssi.hannula@iki.fi>:
>>> But I can hear sound for rear right and rear left only :(
>>>
>>> Is there anything more I can provide to help resolve this? Do you h=
ave
>>> any idea how we can resolve this?
>>
>> According to the below the receiver has separate PCM SADs for 2-chan=
nel
>> and multichannel playback. However, due to a radeon driver bug (see
>> "[PATCH] drm/radeon/audio: fix missing multichannel PCM SAD in some
>> cases", you were CCd) the multichannel SAD is lost and not shown bel=
ow.
>>
>> However, that is not (or at least should not be) the reason you are =
not
>> getting audio.
>> I suspect that the receiver does not support 192kHz multichannel aud=
io
>> (which would be indicated in the missing multichannel PCM SAD). Does=
 it
>> work with 48kHz or 96kHz?
>> (TODO: refuse PCM playback in such cases)
>>
>> If it does not work with 48kHz or 96kHz either, then we have a bug t=
o
>> solve :)
>=20
> First of all, you're right about 2 SADs for PCM.
>=20
> The weird thing is that 192kHz support... According to the EDID (SADs=
)
> it should be supported:
> Format: 1 (PCM)        Channels:1    Freq:0x7F (32-192)    B2:0x07 (1=
6-24b)
> Format: 1 (PCM)        Channels:7    Freq:0x7F (32-192)    B2:0x07 (1=
6-24b)
> Format: 2 (AC3)        Channels:7    Freq:0x07 (32-48)    B2:0x50 (64=
0?)
> Format: 7 (DTS)        Channels:7    Freq:0x06 (44-48)    B2:0xC0 (15=
36?)
> Format: 10 (EAC3)    Channels:7    Freq:0x06 (44-48)    B2:0x00
> Format: 11 (DTS_HD)    Channels:7    Freq:0x7E (44-192)    B2:0x01
> Format: 12 (MLP)    Channels:7    Freq:0x1E (44-96)    B2:0x00
>=20
> So I performed more tests and:
>=20
> 1) speaker-test -D hdmi:CARD=3DGeneric,DEV=3D0 -c6 -r192000 -F S16_LE
> A nice noise for rear right and rear left, silent for the rest
>=20
> 2) speaker-test -D hdmi:CARD=3DGeneric,DEV=3D0 -c6 -r176400 -F S16_LE
> A nice noise for rear right and rear left, short "bump" sound for the=
 rest
>=20
> 3) speaker-test -D hdmi:CARD=3DGeneric,DEV=3D0 -c6 -r96000 -F S16_LE
> A nice noise for all speakers (the same applies to 88200, 48000, 4410=
0, 32000)
>=20
> I don't get it. Onkyo reports support for 192kHz and it supports it,
> but only for 2 rear speakers... does it make any sense do you?

Just to check, is the display mode 720p50 or higher (as per HDMI spec
7.3.3)? Though I guess too small mode would cause something else, not
this...

Also, does DTS-HD/TrueHD work with this receiver (interesting since
those require 8-channel 192kHz link)?

Would be interesting to check if this works in Windows I guess (or mayb=
e
even just fglrx, though I can't think of a reason it'd make a differenc=
e).

--=20
Anssi Hannula
