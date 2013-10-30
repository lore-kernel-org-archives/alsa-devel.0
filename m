From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH 1/4] ALSA: hda - hdmi: Add ATI/AMD multi-channel audio  support
Date: Wed, 30 Oct 2013 17:59:01 +0200
Message-ID: <07e8973b4665cc23c3f4a77e9c7e2b7c@mail.onse.fi>
References: <1380659456-3746-1-git-send-email-anssi.hannula@iki.fi>
 <1380659456-3746-2-git-send-email-anssi.hannula@iki.fi>
 <CACna6ryr37WRvKbMFmLEGt_A2zUD46rZOtJMVom+B_xK9WNLuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACna6ryr37WRvKbMFmLEGt_A2zUD46rZOtJMVom+B_xK9WNLuw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, =?UTF-8?Q?Peter_Fr=C3=BChberger?= <fritsch@xbmc.org>, Olivier Langlois <olivier@trillion01.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Rafa=C5=82 Mi=C5=82ecki kirjoitti 2013-10-30 17:35:
> 2013/10/1 Anssi Hannula <anssi.hannula@iki.fi>:
> ATI/AMD codecs do not support all the standard HDA HDMI/DP functions,
> instead various vendor-specific verbs are provided.
>=20
> I've just tried my HD6970M (BARTS, DCE5) in my Samsung NP700G7A-S01PL=
=2E
>=20
> cat /proc/asound/card1/eld#0.0
> monitor_present 1
> eld_valid 1
> monitor_name
> connection_type HDMI
> eld_version [0x2] CEA-861D or below
> edid_version [0x0] no CEA EDID Timing Extension block present
> manufacture_id 0x0
> product_id 0x0
> port_id 0x0
> support_hdcp 0
> support_ai 0
> audio_sync_delay 0
> speakers [0x5f] FL/FR LFE FC RL/RR RC RLC/RRC
> sad_count 6
> sad0_coding_type [0x1] LPCM
> sad0_channels 8
> sad0_rates [0x1ee0] 32000 44100 48000 88200 96000 176400 192000
> sad0_bits [0xe0000] 16 20 24
> sad1_coding_type [0x2] AC-3
> sad1_channels 6
> sad1_rates [0xe0] 32000 44100 48000
> sad1_max_bitrate 640000
> sad2_coding_type [0x7] DTS
> sad2_channels 6
> sad2_rates [0x6c0] 44100 48000 88200 96000
> sad2_max_bitrate 1536000
> sad3_coding_type [0xa] E-AC-3/DD+ (Dolby Digital Plus)
> sad3_channels 8
> sad3_rates [0xc0] 44100 48000
> sad4_coding_type [0xb] DTS-HD
> sad4_channels 8
> sad4_rates [0x1ec0] 44100 48000 88200 96000 176400 192000
> sad5_coding_type [0xc] MLP (Dolby TrueHD)
> sad5_channels 8
> sad5_rates [0x1ec0] 44100 48000 88200 96000 176400 192000
>=20
> Command:
> speaker-test -D hdmi:CARD=3DGeneric,DEV=3D0 -c8 -r192000 -F S16_LE
> works, I just have 5.1 (not 7.1), so Side left goes to the Read left
> and Side right goes to the Rear right. But they were working!

Good :)

BTW, there is a newer version (which was actually applied) of this=20
patchset in alsa-devel@, seems you were missing from CC on that one.

> Next I've used howto from
> http://phoronix.com/forums/showthread.php?27348-TrueHD-DTS-HD-E-AC3-O=
ver-HDMI-On-Linux
> to test DTS MA and TrueHD.
>=20
> In the file from howto I've used:
> card Generic
> and then tested:
>=20
> zajec@linux-samsung700g7a:~> aplay -D hdmihdtest0 -c8 -fs16_le
> -r192000 thd.spdif
> Playing raw data 'thd.spdif' : Signed 16 bit Little Endian, Rate
> 192000 Hz, Channels 8
> zajec@linux-samsung700g7a:~> aplay -D hdmihdtest0 -c8 -fs16_le
> -r192000 dts.spdif
> Playing raw data 'dts.spdif' : Signed 16 bit Little Endian, Rate
> 192000 Hz, Channels 8

=46or the record, the "howto" is mostly a workaround for missing=20
DEV=3D[1..3] on (now) very old systems, instead of messing around with=20
asoundrc you can just use "-D hdmi:CARD=3DGeneric,DEV=3D0,AES0=3D6" ins=
tead of=20
-DhdmihdtestX. (in AES0 the 0x2 is non-PCM flag, 0x4 is non-copyright=20
flag IIRC - ALSA default is 0x4).

> Hooray! I got
> DOLBY HD
> and
> DTS-HD MA
> on my Denon 1912 display!
>=20
> Now the main question... do you have any experience on using DTS-HD M=
A
> (or TrueHD) with mplayer? :|

Nope (well, any that I still remember). Support is there, though, so I=20
guess it should work.

--=20
Anssi Hannula
