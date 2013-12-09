From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [pulseaudio-discuss] Issue with multiple hdmi
 codecs in radeonhd, hacked to work
Date: Mon, 09 Dec 2013 08:01:17 +0200
Message-ID: <52A55CAD.3080007@iki.fi>
References: <CAJ3TwYRYGR5Z2m1XSQ9QOp3ffe9sb2C_znsVUeBpARySZ7KbMQ@mail.gmail.com>	<CAN8cciZ=UWO_RNwJqrBwbbbU1f_4Ydapk=2d67CtYhVRbO-c1w@mail.gmail.com>	<CAJ3TwYTeR4fZSRGaMpUudL2t_dR0dkYYV1tP_aEAGnjUqN3iDg@mail.gmail.com>	<CAN8cciZ8okPOUD1X3Vy3ofayQHfW6K3eojUwLkGc3o-xX0BFgg@mail.gmail.com>	<CAJ3TwYQr3u-04zRduACx9g283tpyj2bmjDvgA+ok=15OGg5g9w@mail.gmail.com>	<CAN8cciYEikGtPaET-qZECcyGTAqRQab6jEsGP-Zt=4U2ngLqbA@mail.gmail.com>	<CAJ3TwYRheSya2Y7y-e82=-HPv5j26n7SR-L1GeC=CPfrOKHpbA@mail.gmail.com>	<CAN8ccibrFmQa4rPcP6gqt7h1MpMQ310b8y2zcbN-h_rtN_6vvw@mail.gmail.com>	<CAJ3TwYQ_1BTmPafS-_BJWWNp1VSXA5K_e0vVHMipGrkdOjGuwA@mail.gmail.com>	<CAN8cciaUWAxfPp0rNhBV=DCp2hSOJ-EPHeoQ-k25M91xYjmFiQ@mail.gmail.com>	<CAJ3TwYTJnGb7C_TZrGOVTsPPb1kB6Kzqge4suh2B_QAdNUMWgw@mail.gmail.com>	<CAN8cciZTuP8Y-nvv8ecJZBoJZBg
 sucb2p0sd-2dmyMWGxDgifQ@mail.gmail.com>	<CAJ3TwYQukvyyXvuOtquv3UmnToK3CwM1zNxrq6kr4QE2Sshx2A@mail.gmail.com>
 <CAN8cciYeo9UrCPdjRfezFRyv6z_BXSwGvkRg6jKu2B9BMHJayA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 70683262635
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 07:01:26 +0100 (CET)
In-Reply-To: <CAN8cciYeo9UrCPdjRfezFRyv6z_BXSwGvkRg6jKu2B9BMHJayA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>, John Ettedgui <john.ettedgui@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, erutrot@gmail.com, pulseaudio-discuss@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
List-Id: alsa-devel@alsa-project.org

09.12.2013 06:50, Raymond Yau kirjoitti:
> 2013/12/9 John Ettedgui <john.ettedgui@gmail.com
> <mailto:john.ettedgui@gmail.com>>
> 
> 
>     I am using the gitcompile script to configure, compile... 
>     There is no configure by default, I was able to autogen it, but then
>     I had issues while building so I reverted back to gitcompile
> 
> [    4.841881] ALSA hda_intel.c:3170 0000:01:00.1: Handle VGA-switcheroo
> audio client
> [    4.841885] ALSA hda_intel.c:3364 0000:01:00.1: Using LPIB position fix
> [    4.841886] ALSA hda_intel.c:3510 0000:01:00.1: Force to non-snoop mode
> [    4.841920] snd_hda_intel 0000:01:00.1: irq 47 for MSI/MSI-X
> [    4.841940] ALSA hda_intel.c:3635 0000:01:00.1: chipset global
> capabilities = 0x0
> 
> seem the max number of playback streams is hardcoded in the driver

Indeed it is hardcoded to 1 (previous ATI/AMD codecs had a single HDMI
pin). This is almost certainly not true anymore.

I wonder what the limit is now, maybe the amount of HDMI pins so that
there can be 6 or 7 independent streams? Alex?


> [    4.842211] [drm] radeon kernel modesetting enabled.
> [    4.844508] ALSA hda_intel.c:1244 0000:01:00.1: codec_mask = 0x1
> [    4.844630] ALSA hda_intel.c:1716 0000:01:00.1: codec #0 probed OK
> [    4.844632] ALSA hda_intel.c:1837 0000:01:00.1: Enable sync_write for
> stable communication
> [    4.851623] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=3
> Presence_Detect=0 ELD_Valid=0
> [    4.851654] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=5
> Presence_Detect=0 ELD_Valid=0
> [    4.851685] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=7
> Presence_Detect=0 ELD_Valid=0
> [    4.851717] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=9
> Presence_Detect=0 ELD_Valid=0
> [    4.851751] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=11
> Presence_Detect=0 ELD_Valid=0
> [    4.851787] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=13
> Presence_Detect=0 ELD_Valid=0
> [    4.851839] input: HDA ATI HDMI HDMI/DP,pcm=11 as
> /devices/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card0/input12
> [    4.851898] input: HDA ATI HDMI HDMI/DP,pcm=10 as
> /devices/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card0/input11
> [    4.851948] input: HDA ATI HDMI HDMI/DP,pcm=9 as
> /devices/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card0/input10
> [    4.852014] input: HDA ATI HDMI HDMI/DP,pcm=8 as
> /devices/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card0/input9
> [    4.852075] input: HDA ATI HDMI HDMI/DP,pcm=7 as
> /devices/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card0/input8
> [    4.852129] input: HDA ATI HDMI HDMI/DP,pcm=3 as
> /devices/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card0/input7
> 
> Does this mean monitor is plugged and graphic driver is requesting
> monitor to provide EDID ?

The above means that no monitor is plugged in (Presence_Detect=0 on all
HDMI pins).

> 
>     5.340797] ALSA patch_hdmi.c:972 HDMI hot plug event: Codec=0 Pin=3
> Presence_Detect=1 ELD_Valid=0
> [    5.340812] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=3
> Presence_Detect=1 ELD_Valid=1
> [    5.340825] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
> [    5.340838] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
> [    5.340844] ALSA patch_hdmi.c:972 HDMI hot plug event: Codec=0 Pin=5
> Presence_Detect=1 ELD_Valid=0
> [    5.340857] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=5
> Presence_Detect=1 ELD_Valid=1
> [    5.340870] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
> [    5.340882] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
> [    5.340885] ALSA patch_hdmi.c:972 HDMI hot plug event: Codec=0 Pin=7
> Presence_Detect=1 ELD_Valid=0
> [    5.340898] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=7
> Presence_Detect=1 ELD_Valid=1
> [    5.340911] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
> [    5.340923] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
> [    5.340926] ALSA patch_hdmi.c:972 HDMI hot plug event: Codec=0 Pin=9
> Presence_Detect=1 ELD_Valid=0
> [    5.340939] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=9
> Presence_Detect=1 ELD_Valid=1
> [    5.340952] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
> [    5.340965] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
> [    5.340967] ALSA patch_hdmi.c:972 HDMI hot plug event: Codec=0 Pin=11
> Presence_Detect=1 ELD_Valid=0
> [    5.340980] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=11
> Presence_Detect=1 ELD_Valid=1
> [    5.340993] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
> [    5.341005] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
> [    5.341008] ALSA patch_hdmi.c:972 HDMI hot plug event: Codec=0 Pin=13
> Presence_Detect=1 ELD_Valid=0
> [    5.341021] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=13
> Presence_Detect=1 ELD_Valid=1
> [    5.341034] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
> [    5.341046] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0

And this means the codec reports monitor in all the pins
(Presence_Detect=1), but the monitor information is missing on all pins.

I'm only getting bits and pieces of the conversation here, but this
looks like a log from an older kernel without full AMD support as the
driver tries to use generic ELD methods on AMD hardware (on newer
kernels, the monitor info is shown in the correct pin and only that
pin). The presence detect stuff is unchanged on newer kernels, though.

> 
> [    5.504525] [drm] Radeon Display Connectors
> [    5.504527] [drm] Connector 0:
> [    5.504528] [drm]   DP-1
> [    5.504529] [drm]   HPD4
> [    5.504530] [drm]   DDC: 0x6530 0x6530 0x6534 0x6534 0x6538 0x6538
> 0x653c 0x653c
> [    5.504531] [drm]   Encoders:
> [    5.504532] [drm]     DFP1: INTERNAL_UNIPHY2
> [    5.504533] [drm] Connector 1:
> [    5.504534] [drm]   DP-2
> [    5.504535] [drm]   HPD5
> [    5.504536] [drm]   DDC: 0x6540 0x6540 0x6544 0x6544 0x6548 0x6548
> 0x654c 0x654c
> [    5.504537] [drm]   Encoders:
> [    5.504538] [drm]     DFP2: INTERNAL_UNIPHY2
> [    5.504538] [drm] Connector 2:
> [    5.504539] [drm]   HDMI-A-1
> [    5.504540] [drm]   HPD1
> [    5.504541] [drm]   DDC: 0x6550 0x6550 0x6554 0x6554 0x6558 0x6558
> 0x655c 0x655c
> [    5.504542] [drm]   Encoders:
> [    5.504543] [drm]     DFP3: INTERNAL_UNIPHY1
> [    5.504544] [drm] Connector 3:
> [    5.504545] [drm]   DVI-I-1
> [    5.504545] [drm]   HPD6
> [    5.504547] [drm]   DDC: 0x6580 0x6580 0x6584 0x6584 0x6588 0x6588
> 0x658c 0x658c
> [    5.504547] [drm]   Encoders:
> [    5.504548] [drm]     DFP4: INTERNAL_UNIPHY
> [    5.504549] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
> 
> [    5.640237] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=3
> Presence_Detect=1 ELD_Valid=1
> [    5.640254] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
> [    5.640267] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
> [    5.640270] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=5
> Presence_Detect=1 ELD_Valid=1
> [    5.640282] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
> [    5.640295] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
> [    5.640297] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=7
> Presence_Detect=1 ELD_Valid=1
> [    5.640310] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
> [    5.640322] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
> [    5.640324] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=9
> Presence_Detect=1 ELD_Valid=1
> [    5.640336] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
> [    5.640349] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
> [    5.640351] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=11
> Presence_Detect=1 ELD_Valid=1
> [    5.640363] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
> [    5.640376] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
> [    5.640378] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=13
> Presence_Detect=1 ELD_Valid=1
> [    5.640390] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
> [    5.640403] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0

This is ALSA driver retrying reading monitor information (still fails as
not supported by this driver).

> [     7.906] (II) RADEON(0): EDID for output DisplayPort-0
> [     7.920] (II) RADEON(0): EDID for output DisplayPort-1
> [     7.983] (II) RADEON(0): EDID for output HDMI-0
> [     7.983] (II) RADEON(0): Manufacturer: DON  Model: 26  Serial#: 16843009
> [     7.983] (II) RADEON(0): Year: 2011  Week: 0
> [     7.983] (II) RADEON(0): EDID Version: 1.3
> [     7.983] (II) RADEON(0): Monitor name: DENON-AVAMP
> [     7.983] (II) RADEON(0): Number of EDID sections to follow: 1
> [     7.983] (II) RADEON(0): EDID (in hex):
> [     7.983] (II) RADEON(0):     00ffffffffffff0011ee260001010101
> [     7.983] (II) RADEON(0):     00150103800000780adaffa3584aa229
> [     7.983] (II) RADEON(0):     17494b00000001010101010101010101
> [     7.983] (II) RADEON(0):     010101010101023a801871382d40582c
> [     7.983] (II) RADEON(0):     4500ba882100001e011d8018711c1620
> [     7.983] (II) RADEON(0):     582c2500ba882100009e000000fc0044
> [     7.983] (II) RADEON(0):     454e4f4e2d4156414d500a20000000fd
> [     7.983] (II) RADEON(0):     00173d0f440f000a202020202020010d
> [     7.983] (II) RADEON(0):     020335714d9005200403020706010e23
> [     7.983] (II) RADEON(0):     0f24320f7f073d1ec01507505f7e0157
> [     7.983] (II) RADEON(0):     0600677e00835f0000e305030167030c
> [     7.983] (II) RADEON(0):     001500b82d011d007251d01e206e2855
> [     7.983] (II) RADEON(0):     00ba882100001e8c0ad08a20e02d1010
> [     7.983] (II) RADEON(0):     3e9600ba88210000188c0ad08a20e02d
> [     7.983] (II) RADEON(0):     10103e96000b88210000188c0aa01451
> [     7.983] (II) RADEON(0):     f01600267c4300ba88210000980000e7
> 
> 
> [     8.003] (II) RADEON(0): EDID for output DVI-0
> [     8.003] (II) RADEON(0): Output DisplayPort-0 disconnected
> [     8.003] (II) RADEON(0): Output DisplayPort-1 disconnected
> [     8.003] (II) RADEON(0): Output HDMI-0 connected
> [     8.003] (II) RADEON(0): Output DVI-0 disconnected
> 
> Does this mean the graphic driver received EDID from  DENON-AVAMP and
> pass ELD to audio driver ?

ATI/AMD does not internally use ELD but analogous custom stuff. But as
noted, the HDA driver on this kernel does not support reading it, it is
a 3.12+ feature (though note that writing the info is disabled in 3.12
radeon video driver on some cards).

> 
> [    8.228364] ALSA patch_hdmi.c:972 HDMI hot plug event: Codec=0 Pin=3
> Presence_Detect=0 ELD_Valid=1
> [    8.228380] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=3
> Presence_Detect=1 ELD_Valid=1
> [    8.228393] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
> [    8.228406] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
> [    8.377652] type=1006 audit(1386558737.773:2): pid=515 uid=0 old
> auid=4294967295 new auid=1000 old ses=4294967295 new ses=1 res=1
> [    8.520795] ALSA hda_codec.c:1633 hda_codec_cleanup_stream: NID=0x2
> [    8.521113] ALSA hda_codec.c:1633 hda_codec_cleanup_stream: NID=0x2
> [    8.521434] ALSA hda_codec.c:1633 hda_codec_cleanup_stream: NID=0x2
> [    8.521727] ALSA hda_codec.c:1633 hda_codec_cleanup_stream: NID=0x2
> [    8.526625] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=3
> Presence_Detect=1 ELD_Valid=1
> [    8.526640] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
> [    8.526652] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
> 
> 
> [     8.261] (II) config/udev: Adding drm device (/dev/dri/card0)
> [     8.262] (II) config/udev: Adding input device HDA ATI HDMI
> HDMI/DP,pcm=9 (/dev/input/event8)
> [     8.262] (II) No input driver specified, ignoring this device.
> [     8.262] (II) This device may have been added with another device file.
> [     8.262] (II) config/udev: Adding input device HDA ATI HDMI
> HDMI/DP,pcm=10 (/dev/input/event7)
> [     8.262] (II) No input driver specified, ignoring this device.
> [     8.262] (II) This device may have been added with another device file.
> [     8.262] (II) config/udev: Adding input device HDA ATI HDMI
> HDMI/DP,pcm=11 (/dev/input/event6)
> [     8.262] (II) No input driver specified, ignoring this device.
> [     8.262] (II) This device may have been added with another device file.
> [     8.262] (II) config/udev: Adding input device HDA ATI HDMI
> HDMI/DP,pcm=3 (/dev/input/event11)
> [     8.262] (II) No input driver specified, ignoring this device.
> [     8.262] (II) This device may have been added with another device file.
> [     8.262] (II) config/udev: Adding input device HDA ATI HDMI
> HDMI/DP,pcm=7 (/dev/input/event10)
> [     8.262] (II) No input driver specified, ignoring this device.
> [     8.262] (II) This device may have been added with another device file.
> [     8.263] (II) config/udev: Adding input device HDA ATI HDMI
> HDMI/DP,pcm=8 (/dev/input/event9)
> [     8.263] (II) No input driver specified, ignoring this device.
> [     8.263] (II) This device may have been added with another device file.
> [     8.263] (II) config/udev: Adding input device Logitech USB Receiver
> (/dev/input/event0)
> 
> 
> 
> 


-- 
Anssi Hannula
