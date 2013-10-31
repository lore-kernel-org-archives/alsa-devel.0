From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH 1/4] ALSA: hda - hdmi: Add ATI/AMD multi-channel audio
 support
Date: Thu, 31 Oct 2013 22:26:09 +0200
Message-ID: <5272BCE1.7010700@iki.fi>
References: <1380659456-3746-1-git-send-email-anssi.hannula@iki.fi>	<1380659456-3746-2-git-send-email-anssi.hannula@iki.fi>	<CACna6ryr37WRvKbMFmLEGt_A2zUD46rZOtJMVom+B_xK9WNLuw@mail.gmail.com>	<07e8973b4665cc23c3f4a77e9c7e2b7c@mail.onse.fi> <CACna6ryFtmZHAhmCPEsoxZc5h4mLuM4ajnKGsp=q0jag2f_SYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACna6ryFtmZHAhmCPEsoxZc5h4mLuM4ajnKGsp=q0jag2f_SYw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, =?UTF-8?B?UGV0ZXIgRnLDvGhiZXJnZXI=?= <fritsch@xbmc.org>, Olivier Langlois <olivier@trillion01.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

31.10.2013 18:22, Rafa=C5=82 Mi=C5=82ecki kirjoitti:
> 2013/10/30 Anssi Hannula <anssi.hannula@iki.fi>:
>> BTW, there is a newer version (which was actually applied) of this p=
atchset
>> in alsa-devel@, seems you were missing from CC on that one.
>=20
> I didn't try that updated version yet, but I'm afraid I discovered
> some problem. I've switched from my Denon 1912 to the older Onkyo
> TX-SR605 and there is problem with multichannel playback. I've tried:
>> speaker-test -D hdmi:CARD=3DGeneric,DEV=3D0 -c6 -r192000 -F S16_LE
>=20
> speaker-test 1.0.25
>=20
> Playback device is hdmi:CARD=3DGeneric,DEV=3D0
> Stream parameters are 192000Hz, S16_LE, 6 channels
> Using 16 octaves of pink noise
> Rate set to 192000Hz (requested 192000Hz)
> Buffer size range from 64 to 87360
> Period size range from 32 to 43680
> Using max buffer size 87360
> Periods =3D 4
> was set period_size =3D 17472
> was set buffer_size =3D 87360
> 0 - Front Left
> 4 - Center
> 1 - Front Right
> 3 - Rear Right
> 2 - Rear Left
> 5 - LFE
> Time per period =3D 17.027360
>=20
> But I can hear sound for rear right and rear left only :(
>=20
> Is there anything more I can provide to help resolve this? Do you hav=
e
> any idea how we can resolve this?

According to the below the receiver has separate PCM SADs for 2-channel
and multichannel playback. However, due to a radeon driver bug (see
"[PATCH] drm/radeon/audio: fix missing multichannel PCM SAD in some
cases", you were CCd) the multichannel SAD is lost and not shown below.

However, that is not (or at least should not be) the reason you are not
getting audio.
I suspect that the receiver does not support 192kHz multichannel audio
(which would be indicated in the missing multichannel PCM SAD). Does it
work with 48kHz or 96kHz?
(TODO: refuse PCM playback in such cases)

If it does not work with 48kHz or 96kHz either, then we have a bug to
solve :)

> zajec@linux-samsung700g7a:/proc/asound/card1> cat eld#0.0
> monitor_present         1
> eld_valid               1
> monitor_name
> connection_type         HDMI
> eld_version             [0x2] CEA-861D or below
> edid_version            [0x0] no CEA EDID Timing Extension block pres=
ent
> manufacture_id          0x0
> product_id              0x0
> port_id                 0x0
> support_hdcp            0
> support_ai              0
> audio_sync_delay        0
> speakers                [0x4f] FL/FR LFE FC RL/RR RLC/RRC
> sad_count               6
> sad0_coding_type        [0x1] LPCM
> sad0_channels           2
> sad0_rates              [0x1ee0] 32000 44100 48000 88200 96000 176400=
 192000
> sad0_bits               [0xe0000] 16 20 24
> sad1_coding_type        [0x2] AC-3
> sad1_channels           8
> sad1_rates              [0xe0] 32000 44100 48000
> sad1_max_bitrate        640000
> sad2_coding_type        [0x7] DTS
> sad2_channels           8
> sad2_rates              [0xc0] 44100 48000
> sad2_max_bitrate        1536000
> sad3_coding_type        [0xa] E-AC-3/DD+ (Dolby Digital Plus)
> sad3_channels           8
> sad3_rates              [0xc0] 44100 48000
> sad4_coding_type        [0xb] DTS-HD
> sad4_channels           8
> sad4_rates              [0x1ec0] 44100 48000 88200 96000 176400 19200=
0
> sad5_coding_type        [0xc] MLP (Dolby TrueHD)
> sad5_channels           8
> sad5_rates              [0x6c0] 44100 48000 88200 96000
> zajec@linux-samsung700g7a:/proc/asound/card1> ls
> codec#0  eld#0.0  id  pcm3p
> zajec@linux-samsung700g7a:/proc/asound/card1> cat codec#0
> Codec: ATI R6xx HDMI
> Address: 0
> AFG Function Id: 0x1 (unsol 0)
> Vendor Id: 0x1002aa01
> Subsystem Id: 0x00aa0100
> Revision Id: 0x100200
> No Modem Function Group found
> Default PCM:
>     rates [0x70]: 32000 44100 48000
>     bits [0x2]: 16
>     formats [0x1]: PCM
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> State of AFG node 0x01:
>   Power states:  D0 D3
>   Power: setting=3DD0, actual=3DD0
> GPIO: io=3D0, o=3D0, i=3D0, unsolicited=3D0, wake=3D0
> Node 0x02 [Audio Output] wcaps 0x201: Stereo Digital
>   Converter: stream=3D0, channel=3D0
>   Digital: Enabled GenLevel
>   Digital category: 0x2
>   IEC Coding Type: 0x0
> Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
>   Control: name=3D"HDMI/DP,pcm=3D3 Jack", index=3D0, device=3D0
>   Control: name=3D"IEC958 Playback Con Mask", index=3D0, device=3D0
>   Control: name=3D"IEC958 Playback Pro Mask", index=3D0, device=3D0
>   Control: name=3D"IEC958 Playback Default", index=3D0, device=3D0
>   Control: name=3D"IEC958 Playback Switch", index=3D0, device=3D0
>   Control: name=3D"ELD", index=3D0, device=3D3
>   Pincap 0x00000094: OUT Detect HDMI
>   Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
>     Conn =3D Digital, Color =3D Unknown
>     DefAssociation =3D 0x1, Sequence =3D 0x0
>   Pin-ctls: 0x40: OUT
>   Unsolicited: tag=3D01, enabled=3D1
>   Connection: 1
>      0x02
[...]

--=20
Anssi Hannula
