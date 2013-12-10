From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Issue with multiple hdmi codecs in
 radeonhd, hacked to work
Date: Tue, 10 Dec 2013 18:22:38 +0200
Message-ID: <52A73FCE.3060303@iki.fi>
References: <CAJ3TwYRYGR5Z2m1XSQ9QOp3ffe9sb2C_znsVUeBpARySZ7KbMQ@mail.gmail.com>	<CAJ3TwYRheSya2Y7y-e82=-HPv5j26n7SR-L1GeC=CPfrOKHpbA@mail.gmail.com>	<CAN8ccibrFmQa4rPcP6gqt7h1MpMQ310b8y2zcbN-h_rtN_6vvw@mail.gmail.com>	<CAJ3TwYQ_1BTmPafS-_BJWWNp1VSXA5K_e0vVHMipGrkdOjGuwA@mail.gmail.com>	<CAN8cciaUWAxfPp0rNhBV=DCp2hSOJ-EPHeoQ-k25M91xYjmFiQ@mail.gmail.com>	<CAJ3TwYTJnGb7C_TZrGOVTsPPb1kB6Kzqge4suh2B_QAdNUMWgw@mail.gmail.com>	<CAN8cciZTuP8Y-nvv8ecJZBoJZBgsucb2p0sd-2dmyMWGxDgifQ@mail.gmail.com>	<CAJ3TwYQukvyyXvuOtquv3UmnToK3CwM1zNxrq6kr4QE2Sshx2A@mail.gmail.com>	<CAN8cciYeo9UrCPdjRfezFRyv6z_BXSwGvkRg6jKu2B9BMHJayA@mail.gmail.com>	<52A55CAD.3080007@iki.fi>	<52A55E4D.1050906@iki.fi>	<CAJ3TwYSQHSTF0QyFn35db2FGAwpGgT3wKNa44eVMsrgFW95BJg@mail.gmail.com>	<CAN8ccibt-pbWY0roHVjkhRz5eoOGMhbZRmL5Ce4fQLFO
 nZ0GaA@mail.gmail.com>	<CAJ3TwYSqGYbYM=UZv2kpc8QRYteBz63utE6g6uecmdTcw7cwJA@mail.gmail.com>
	<CAN8cciZZhve=-BYNorv1Fhxr6P6-ZD47HY_gSx2DMXdRwQ+fbA@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAN8cciZZhve=-BYNorv1Fhxr6P6-ZD47HY_gSx2DMXdRwQ+fbA@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
To: Raymond Yau <superquad.vortex2@gmail.com>, John Ettedgui <john.ettedgui@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Alex Deucher <alexander.deucher@amd.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

10.12.2013 15:54, Raymond Yau kirjoitti:
> 
>         Codec: ATI R6xx HDMI
>         Address: 0
>         AFG Function Id: 0x1 (unsol 0)
>         Vendor Id: 0x1002aa01
>         Subsystem Id: 0x00aa0100
>         Revision Id: 0x100300
> 
>         seem that your codec may get Audio-Video Association Port ID and
>         Sink Information for your DENON-AVAMP
> 
> 
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/hda_eld.c?id=89250f84644676c1ed6a09acef1033e14596a402
> 
> Revision ID 3 and later (0x100300 as reported by procfs codec#X) have
> support for providing more information than the previous revisions (but
> only if supported by the display driver).
> 
> manufacture_id        0x0
> product_id        0x0
> port_id            0x0
> 
> you have to find out those values return by hda_codec_read
> ATI_VERB_GET_SINK_INFO_DATA as your codec are revision 3 and your
> graphic driver got the product_id, manufacture_id, port_id

Not sure what you are after exactly, but I don't think those are
supported by the radeon driver just yet. The filled fields currently are
(per dce6_afmt.c): latency fields, speaker allocation, short audio
descriptors, connector type.

Should be relatively trivial to add support for the rest, though, as the
correct registers are named clearly in sid.h
(AZ_F0_CODEC_PIN_CONTROL_SINK_INFOx). It is not very high on my TODO at
the moment, though.


> Manufacturer: DON Model 26 Serial Number 16843009
> Made week 0 of 2011
> Monitor name: DENON
> 
> Audio data block
>     Linear PCM, max channels 7
>     Supported sample rates (kHz): 192 176.4 96 88.2 48 44.1 32
>     Supported sample sizes (bits): 24 20 16
>     DTS, max channels 5
>     Supported sample rates (kHz): 96 88.2 48 44.1
>     Maximum bit rate: 1016 kHz
>     AC-3, max channels 5
>     Supported sample rates (kHz): 48 44.1 32
>     Maximum bit rate: 1016 kHz
>     DTS-HD, max channels 7
>     Supported sample rates (kHz): 192 176.4 96 88.2 48 44.1
>     Dolby Digital+, max channels 7
>     Supported sample rates (kHz): 48 44.1
>     MAT (MLP), max channels 7
>     Supported sample rates (kHz): 192 176.4 96 88.2 48 44.1
>   Speaker allocation data block
> 
> Do those SAD in EDID in xorg.log  match with the specification of your
> Denon HDMI receiver ?
> 
> speakers        [0x5f] FL/FR LFE FC RL/RR RC RLC/RRC
> sad_count        6
> sad0_coding_type    [0x1] LPCM
> sad0_channels        8
> sad0_rates        [0x1ee0] 32000 44100 48000 88200 96000 176400 192000
> sad0_bits        [0xe0000] 16 20 24
> sad1_coding_type    [0x2] AC-3
> sad1_channels        6
> sad1_rates        [0xe0] 32000 44100 48000
> sad1_max_bitrate    640000
> sad2_coding_type    [0x7] DTS
> sad2_channels        6
> sad2_rates        [0x6c0] 44100 48000 88200 96000
> sad2_max_bitrate    1536000
> sad3_coding_type    [0xa] E-AC-3/DD+ (Dolby Digital Plus)
> sad3_channels        8
> sad3_rates        [0xc0] 44100 48000
> sad4_coding_type    [0xb] DTS-HD
> sad4_channels        8
> sad4_rates        [0x1ec0] 44100 48000 88200 96000 176400 192000
> sad5_coding_type    [0xc] MLP (Dolby TrueHD)
> sad5_channels        8
> sad5_rates        [0x1ec0] 44100 48000 88200 96000 176400 192000
> 
> seem emulated ELD 's max bitrate are different from those in SAD of EDID

Whatever you used to decode the EDID misdecoded the bitrates.
The SADs from the Xorg log are:
0f7f07 3d1ec0 150750 5f7e01 570600 677e00
PCM    DTS    AC-3   DTS-HD E-AC-3 TrueHD

As per CEA-861 maximum bitrate for format codes 2 to 8 (DTS and AC-3 in
this case) is encoded in 3rd byte, divided by 8kHz.
DTS: 0xC0 * 8k = 1536k
AC-3: 0x50 * 8k = 640k

[...]
-- 
Anssi Hannula
