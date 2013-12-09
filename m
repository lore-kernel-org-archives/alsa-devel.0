From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Issue with multiple hdmi codecs in
 radeonhd, hacked to work
Date: Mon, 9 Dec 2013 12:50:47 +0800
Message-ID: <CAN8cciYeo9UrCPdjRfezFRyv6z_BXSwGvkRg6jKu2B9BMHJayA@mail.gmail.com>
References: <CAJ3TwYRYGR5Z2m1XSQ9QOp3ffe9sb2C_znsVUeBpARySZ7KbMQ@mail.gmail.com>
	<CAN8ccia9KA4fyU06LE3+DMPcj9w62Z8P-BvjR3-aA2Q9TWcC-A@mail.gmail.com>
	<CAJ3TwYQOiV2DFbVHagJ+O+tSbcvmNUTrZng1C8Tgooz8SrdPgg@mail.gmail.com>
	<CAJ3TwYQSYtv6qdCiTi9MHBoEnxqitXbSVgxq-8R+z7E0LQyhpg@mail.gmail.com>
	<CAN8cciZ=UWO_RNwJqrBwbbbU1f_4Ydapk=2d67CtYhVRbO-c1w@mail.gmail.com>
	<CAJ3TwYTeR4fZSRGaMpUudL2t_dR0dkYYV1tP_aEAGnjUqN3iDg@mail.gmail.com>
	<CAN8cciZ8okPOUD1X3Vy3ofayQHfW6K3eojUwLkGc3o-xX0BFgg@mail.gmail.com>
	<CAJ3TwYQr3u-04zRduACx9g283tpyj2bmjDvgA+ok=15OGg5g9w@mail.gmail.com>
	<CAN8cciYEikGtPaET-qZECcyGTAqRQab6jEsGP-Zt=4U2ngLqbA@mail.gmail.com>
	<CAJ3TwYRheSya2Y7y-e82=-HPv5j26n7SR-L1GeC=CPfrOKHpbA@mail.gmail.com>
	<CAN8ccibrFmQa4rPcP6gqt7h1MpMQ310b8y2zcbN-h_rtN_6vvw@mail.gmail.com>
	<CAJ3TwYQ_1BTmPafS-_BJWWNp1VSXA5K_e0vVHMipGrkdOjGuwA@mail.gmail.com>
	<CAN8cciaUWAxfPp0rNhBV=DCp2hSOJ-EPHeoQ-k25M91xYjmFiQ@mail.gmail.com>
	<CAJ3TwYTJnGb7C_TZrGOVTsPPb1kB6Kzqge4suh2B_QAdNUMWgw@mail.gmail.com>
	<CAN8cciZTuP8Y-nvv8ecJZBoJZBgsucb2p0sd-2dmyMWGxDgifQ@mail.gmail.com>
	<CAJ3TwYQukvyyXvuOtquv3UmnToK3CwM1zNxrq6kr4QE2Sshx2A@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1166280225=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAJ3TwYQukvyyXvuOtquv3UmnToK3CwM1zNxrq6kr4QE2Sshx2A@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
To: John Ettedgui <john.ettedgui@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Anssi Hannula <anssi.hannula@iki.fi>, Takashi Iwai <tiwai@suse.de>, erutrot@gmail.com, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

--===============1166280225==
Content-Type: multipart/alternative; boundary=001a1135f6a8481c2d04ed12bdde

--001a1135f6a8481c2d04ed12bdde
Content-Type: text/plain; charset=UTF-8

2013/12/9 John Ettedgui <john.ettedgui@gmail.com>

>
> I am using the gitcompile script to configure, compile...
> There is no configure by default, I was able to autogen it, but then I had
> issues while building so I reverted back to gitcompile
>



[    4.841881] ALSA hda_intel.c:3170 0000:01:00.1: Handle VGA-switcheroo
audio client
[    4.841885] ALSA hda_intel.c:3364 0000:01:00.1: Using LPIB position fix
[    4.841886] ALSA hda_intel.c:3510 0000:01:00.1: Force to non-snoop mode
[    4.841920] snd_hda_intel 0000:01:00.1: irq 47 for MSI/MSI-X
[    4.841940] ALSA hda_intel.c:3635 0000:01:00.1: chipset global
capabilities = 0x0

seem the max number of playback streams is hardcoded in the driver


[    4.842211] [drm] radeon kernel modesetting enabled.
[    4.844508] ALSA hda_intel.c:1244 0000:01:00.1: codec_mask = 0x1
[    4.844630] ALSA hda_intel.c:1716 0000:01:00.1: codec #0 probed OK
[    4.844632] ALSA hda_intel.c:1837 0000:01:00.1: Enable sync_write for
stable communication
[    4.851623] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=3
Presence_Detect=0 ELD_Valid=0
[    4.851654] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=5
Presence_Detect=0 ELD_Valid=0
[    4.851685] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=7
Presence_Detect=0 ELD_Valid=0
[    4.851717] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=9
Presence_Detect=0 ELD_Valid=0
[    4.851751] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=11
Presence_Detect=0 ELD_Valid=0
[    4.851787] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=13
Presence_Detect=0 ELD_Valid=0
[    4.851839] input: HDA ATI HDMI HDMI/DP,pcm=11 as
/devices/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card0/input12
[    4.851898] input: HDA ATI HDMI HDMI/DP,pcm=10 as
/devices/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card0/input11
[    4.851948] input: HDA ATI HDMI HDMI/DP,pcm=9 as
/devices/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card0/input10
[    4.852014] input: HDA ATI HDMI HDMI/DP,pcm=8 as
/devices/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card0/input9
[    4.852075] input: HDA ATI HDMI HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card0/input8
[    4.852129] input: HDA ATI HDMI HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card0/input7

Does this mean monitor is plugged and graphic driver is requesting monitor
to provide EDID ?


    5.340797] ALSA patch_hdmi.c:972 HDMI hot plug event: Codec=0 Pin=3
Presence_Detect=1 ELD_Valid=0
[    5.340812] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=3
Presence_Detect=1 ELD_Valid=1
[    5.340825] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
[    5.340838] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
[    5.340844] ALSA patch_hdmi.c:972 HDMI hot plug event: Codec=0 Pin=5
Presence_Detect=1 ELD_Valid=0
[    5.340857] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=5
Presence_Detect=1 ELD_Valid=1
[    5.340870] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
[    5.340882] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
[    5.340885] ALSA patch_hdmi.c:972 HDMI hot plug event: Codec=0 Pin=7
Presence_Detect=1 ELD_Valid=0
[    5.340898] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=7
Presence_Detect=1 ELD_Valid=1
[    5.340911] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
[    5.340923] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
[    5.340926] ALSA patch_hdmi.c:972 HDMI hot plug event: Codec=0 Pin=9
Presence_Detect=1 ELD_Valid=0
[    5.340939] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=9
Presence_Detect=1 ELD_Valid=1
[    5.340952] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
[    5.340965] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
[    5.340967] ALSA patch_hdmi.c:972 HDMI hot plug event: Codec=0 Pin=11
Presence_Detect=1 ELD_Valid=0
[    5.340980] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=11
Presence_Detect=1 ELD_Valid=1
[    5.340993] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
[    5.341005] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
[    5.341008] ALSA patch_hdmi.c:972 HDMI hot plug event: Codec=0 Pin=13
Presence_Detect=1 ELD_Valid=0
[    5.341021] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=13
Presence_Detect=1 ELD_Valid=1
[    5.341034] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
[    5.341046] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0


[    5.504525] [drm] Radeon Display Connectors
[    5.504527] [drm] Connector 0:
[    5.504528] [drm]   DP-1
[    5.504529] [drm]   HPD4
[    5.504530] [drm]   DDC: 0x6530 0x6530 0x6534 0x6534 0x6538 0x6538
0x653c 0x653c
[    5.504531] [drm]   Encoders:
[    5.504532] [drm]     DFP1: INTERNAL_UNIPHY2
[    5.504533] [drm] Connector 1:
[    5.504534] [drm]   DP-2
[    5.504535] [drm]   HPD5
[    5.504536] [drm]   DDC: 0x6540 0x6540 0x6544 0x6544 0x6548 0x6548
0x654c 0x654c
[    5.504537] [drm]   Encoders:
[    5.504538] [drm]     DFP2: INTERNAL_UNIPHY2
[    5.504538] [drm] Connector 2:
[    5.504539] [drm]   HDMI-A-1
[    5.504540] [drm]   HPD1
[    5.504541] [drm]   DDC: 0x6550 0x6550 0x6554 0x6554 0x6558 0x6558
0x655c 0x655c
[    5.504542] [drm]   Encoders:
[    5.504543] [drm]     DFP3: INTERNAL_UNIPHY1
[    5.504544] [drm] Connector 3:
[    5.504545] [drm]   DVI-I-1
[    5.504545] [drm]   HPD6
[    5.504547] [drm]   DDC: 0x6580 0x6580 0x6584 0x6584 0x6588 0x6588
0x658c 0x658c
[    5.504547] [drm]   Encoders:
[    5.504548] [drm]     DFP4: INTERNAL_UNIPHY
[    5.504549] [drm]     CRT1: INTERNAL_KLDSCP_DAC1

[    5.640237] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=3
Presence_Detect=1 ELD_Valid=1
[    5.640254] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
[    5.640267] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
[    5.640270] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=5
Presence_Detect=1 ELD_Valid=1
[    5.640282] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
[    5.640295] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
[    5.640297] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=7
Presence_Detect=1 ELD_Valid=1
[    5.640310] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
[    5.640322] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
[    5.640324] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=9
Presence_Detect=1 ELD_Valid=1
[    5.640336] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
[    5.640349] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
[    5.640351] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=11
Presence_Detect=1 ELD_Valid=1
[    5.640363] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
[    5.640376] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
[    5.640378] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=13
Presence_Detect=1 ELD_Valid=1
[    5.640390] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
[    5.640403] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0


[     7.906] (II) RADEON(0): EDID for output DisplayPort-0
[     7.920] (II) RADEON(0): EDID for output DisplayPort-1
[     7.983] (II) RADEON(0): EDID for output HDMI-0
[     7.983] (II) RADEON(0): Manufacturer: DON  Model: 26  Serial#: 16843009
[     7.983] (II) RADEON(0): Year: 2011  Week: 0
[     7.983] (II) RADEON(0): EDID Version: 1.3
[     7.983] (II) RADEON(0): Monitor name: DENON-AVAMP
[     7.983] (II) RADEON(0): Number of EDID sections to follow: 1
[     7.983] (II) RADEON(0): EDID (in hex):
[     7.983] (II) RADEON(0):     00ffffffffffff0011ee260001010101
[     7.983] (II) RADEON(0):     00150103800000780adaffa3584aa229
[     7.983] (II) RADEON(0):     17494b00000001010101010101010101
[     7.983] (II) RADEON(0):     010101010101023a801871382d40582c
[     7.983] (II) RADEON(0):     4500ba882100001e011d8018711c1620
[     7.983] (II) RADEON(0):     582c2500ba882100009e000000fc0044
[     7.983] (II) RADEON(0):     454e4f4e2d4156414d500a20000000fd
[     7.983] (II) RADEON(0):     00173d0f440f000a202020202020010d
[     7.983] (II) RADEON(0):     020335714d9005200403020706010e23
[     7.983] (II) RADEON(0):     0f24320f7f073d1ec01507505f7e0157
[     7.983] (II) RADEON(0):     0600677e00835f0000e305030167030c
[     7.983] (II) RADEON(0):     001500b82d011d007251d01e206e2855
[     7.983] (II) RADEON(0):     00ba882100001e8c0ad08a20e02d1010
[     7.983] (II) RADEON(0):     3e9600ba88210000188c0ad08a20e02d
[     7.983] (II) RADEON(0):     10103e96000b88210000188c0aa01451
[     7.983] (II) RADEON(0):     f01600267c4300ba88210000980000e7


[     8.003] (II) RADEON(0): EDID for output DVI-0
[     8.003] (II) RADEON(0): Output DisplayPort-0 disconnected
[     8.003] (II) RADEON(0): Output DisplayPort-1 disconnected
[     8.003] (II) RADEON(0): Output HDMI-0 connected
[     8.003] (II) RADEON(0): Output DVI-0 disconnected


Does this mean the graphic driver received EDID from  DENON-AVAMP and pass
ELD to audio driver ?

[    8.228364] ALSA patch_hdmi.c:972 HDMI hot plug event: Codec=0 Pin=3
Presence_Detect=0 ELD_Valid=1
[    8.228380] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=3
Presence_Detect=1 ELD_Valid=1
[    8.228393] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
[    8.228406] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0
[    8.377652] type=1006 audit(1386558737.773:2): pid=515 uid=0 old
auid=4294967295 new auid=1000 old ses=4294967295 new ses=1 res=1
[    8.520795] ALSA hda_codec.c:1633 hda_codec_cleanup_stream: NID=0x2
[    8.521113] ALSA hda_codec.c:1633 hda_codec_cleanup_stream: NID=0x2
[    8.521434] ALSA hda_codec.c:1633 hda_codec_cleanup_stream: NID=0x2
[    8.521727] ALSA hda_codec.c:1633 hda_codec_cleanup_stream: NID=0x2
[    8.526625] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=3
Presence_Detect=1 ELD_Valid=1
[    8.526640] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128
[    8.526652] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0


[     8.261] (II) config/udev: Adding drm device (/dev/dri/card0)
[     8.262] (II) config/udev: Adding input device HDA ATI HDMI
HDMI/DP,pcm=9 (/dev/input/event8)
[     8.262] (II) No input driver specified, ignoring this device.
[     8.262] (II) This device may have been added with another device file.
[     8.262] (II) config/udev: Adding input device HDA ATI HDMI
HDMI/DP,pcm=10 (/dev/input/event7)
[     8.262] (II) No input driver specified, ignoring this device.
[     8.262] (II) This device may have been added with another device file.
[     8.262] (II) config/udev: Adding input device HDA ATI HDMI
HDMI/DP,pcm=11 (/dev/input/event6)
[     8.262] (II) No input driver specified, ignoring this device.
[     8.262] (II) This device may have been added with another device file.
[     8.262] (II) config/udev: Adding input device HDA ATI HDMI
HDMI/DP,pcm=3 (/dev/input/event11)
[     8.262] (II) No input driver specified, ignoring this device.
[     8.262] (II) This device may have been added with another device file.
[     8.262] (II) config/udev: Adding input device HDA ATI HDMI
HDMI/DP,pcm=7 (/dev/input/event10)
[     8.262] (II) No input driver specified, ignoring this device.
[     8.262] (II) This device may have been added with another device file.
[     8.263] (II) config/udev: Adding input device HDA ATI HDMI
HDMI/DP,pcm=8 (/dev/input/event9)
[     8.263] (II) No input driver specified, ignoring this device.
[     8.263] (II) This device may have been added with another device file.
[     8.263] (II) config/udev: Adding input device Logitech USB Receiver
(/dev/input/event0)

--001a1135f6a8481c2d04ed12bdde
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">2013/12/9 John Ettedgui <span dir=3D"ltr">&lt;<a href=3D"mailto:joh=
n.ettedgui@gmail.com" target=3D"_blank">john.ettedgui@gmail.com</a>&gt;</sp=
an><br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">


<div dir=3D"ltr"><br><div>I am using the gitcompile script to configure, co=
mpile...=C2=A0</div><div>There is no configure by default, I was able to au=
togen it, but then I had issues while building so I reverted back to gitcom=
pile</div>


</div></blockquote><div><br></div><div><br></div><div><br>[=C2=A0=C2=A0=C2=
=A0 4.841881] ALSA hda_intel.c:3170 0000:01:00.1: Handle VGA-switcheroo aud=
io client<br>[=C2=A0=C2=A0=C2=A0 4.841885] ALSA hda_intel.c:3364 0000:01:00=
.1: Using LPIB position fix<br>


[=C2=A0=C2=A0=C2=A0 4.841886] ALSA hda_intel.c:3510 0000:01:00.1: Force to =
non-snoop mode<br>[=C2=A0=C2=A0=C2=A0 4.841920] snd_hda_intel 0000:01:00.1:=
 irq 47 for MSI/MSI-X<br>[=C2=A0=C2=A0=C2=A0 4.841940] ALSA hda_intel.c:363=
5 0000:01:00.1: chipset global capabilities =3D 0x0<br>


<br></div><div>seem the max number of playback streams is hardcoded in the =
driver <br></div><div><br><br>[=C2=A0=C2=A0=C2=A0 4.842211] [drm] radeon ke=
rnel modesetting enabled.<br>[=C2=A0=C2=A0=C2=A0 4.844508] ALSA hda_intel.c=
:1244 0000:01:00.1: codec_mask =3D 0x1<br>


[=C2=A0=C2=A0=C2=A0 4.844630] ALSA hda_intel.c:1716 0000:01:00.1: codec #0 =
probed OK<br>[=C2=A0=C2=A0=C2=A0 4.844632] ALSA hda_intel.c:1837 0000:01:00=
.1: Enable sync_write for stable communication<br>[=C2=A0=C2=A0=C2=A0 4.851=
623] ALSA patch_hdmi.c:1301 HDMI status: Codec=3D0 Pin=3D3 Presence_Detect=
=3D0 ELD_Valid=3D0<br>


[=C2=A0=C2=A0=C2=A0 4.851654] ALSA patch_hdmi.c:1301 HDMI status: Codec=3D0=
 Pin=3D5 Presence_Detect=3D0 ELD_Valid=3D0<br>[=C2=A0=C2=A0=C2=A0 4.851685]=
 ALSA patch_hdmi.c:1301 HDMI status: Codec=3D0 Pin=3D7 Presence_Detect=3D0 =
ELD_Valid=3D0<br>[=C2=A0=C2=A0=C2=A0 4.851717] ALSA patch_hdmi.c:1301 HDMI =
status: Codec=3D0 Pin=3D9 Presence_Detect=3D0 ELD_Valid=3D0<br>


[=C2=A0=C2=A0=C2=A0 4.851751] ALSA patch_hdmi.c:1301 HDMI status: Codec=3D0=
 Pin=3D11 Presence_Detect=3D0 ELD_Valid=3D0<br>[=C2=A0=C2=A0=C2=A0 4.851787=
] ALSA patch_hdmi.c:1301 HDMI status: Codec=3D0 Pin=3D13 Presence_Detect=3D=
0 ELD_Valid=3D0<br>[=C2=A0=C2=A0=C2=A0 4.851839] input: HDA ATI HDMI HDMI/D=
P,pcm=3D11 as /devices/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card0/inp=
ut12<br>


[=C2=A0=C2=A0=C2=A0 4.851898] input: HDA ATI HDMI HDMI/DP,pcm=3D10 as /devi=
ces/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card0/input11<br>[=C2=A0=C2=
=A0=C2=A0 4.851948] input: HDA ATI HDMI HDMI/DP,pcm=3D9 as /devices/pci0000=
:00/0000:00:03.0/0000:01:00.1/sound/card0/input10<br>


[=C2=A0=C2=A0=C2=A0 4.852014] input: HDA ATI HDMI HDMI/DP,pcm=3D8 as /devic=
es/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card0/input9<br>[=C2=A0=C2=A0=
=C2=A0 4.852075] input: HDA ATI HDMI HDMI/DP,pcm=3D7 as /devices/pci0000:00=
/0000:00:03.0/0000:01:00.1/sound/card0/input8<br>


[=C2=A0=C2=A0=C2=A0 4.852129] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as /devic=
es/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card0/input7 <br></div></div>=
<br></div><div class=3D"gmail_extra">Does this mean monitor is plugged and =
graphic driver is requesting monitor to provide EDID ?<br>

</div><div class=3D"gmail_extra"><br><br>=C2=A0=C2=A0=C2=A0 5.340797] ALSA =
patch_hdmi.c:972 HDMI hot plug event: Codec=3D0 Pin=3D3 Presence_Detect=3D1=
 ELD_Valid=3D0<br>
[=C2=A0=C2=A0=C2=A0 5.340812] ALSA patch_hdmi.c:1301 HDMI status: Codec=3D0=
 Pin=3D3 Presence_Detect=3D1 ELD_Valid=3D1<br>[=C2=A0=C2=A0=C2=A0 5.340825]=
 ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128<br>[=C2=A0=C2=A0=C2=
=A0 5.340838] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0<br>


[=C2=A0=C2=A0=C2=A0 5.340844] ALSA patch_hdmi.c:972 HDMI hot plug event: Co=
dec=3D0 Pin=3D5 Presence_Detect=3D1 ELD_Valid=3D0<br>[=C2=A0=C2=A0=C2=A0 5.=
340857] ALSA patch_hdmi.c:1301 HDMI status: Codec=3D0 Pin=3D5 Presence_Dete=
ct=3D1 ELD_Valid=3D1<br>[=C2=A0=C2=A0=C2=A0 5.340870] ALSA hda_eld.c:334 HD=
MI: ELD buf size is 0, force 128<br>


[=C2=A0=C2=A0=C2=A0 5.340882] ALSA hda_eld.c:351 HDMI: invalid ELD data byt=
e 0<br>[=C2=A0=C2=A0=C2=A0 5.340885] ALSA patch_hdmi.c:972 HDMI hot plug ev=
ent: Codec=3D0 Pin=3D7 Presence_Detect=3D1 ELD_Valid=3D0<br>[=C2=A0=C2=A0=
=C2=A0 5.340898] ALSA patch_hdmi.c:1301 HDMI status: Codec=3D0 Pin=3D7 Pres=
ence_Detect=3D1 ELD_Valid=3D1<br>


[=C2=A0=C2=A0=C2=A0 5.340911] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, f=
orce 128<br>[=C2=A0=C2=A0=C2=A0 5.340923] ALSA hda_eld.c:351 HDMI: invalid =
ELD data byte 0<br>[=C2=A0=C2=A0=C2=A0 5.340926] ALSA patch_hdmi.c:972 HDMI=
 hot plug event: Codec=3D0 Pin=3D9 Presence_Detect=3D1 ELD_Valid=3D0<br>


[=C2=A0=C2=A0=C2=A0 5.340939] ALSA patch_hdmi.c:1301 HDMI status: Codec=3D0=
 Pin=3D9 Presence_Detect=3D1 ELD_Valid=3D1<br>[=C2=A0=C2=A0=C2=A0 5.340952]=
 ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128<br>[=C2=A0=C2=A0=C2=
=A0 5.340965] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0<br>


[=C2=A0=C2=A0=C2=A0 5.340967] ALSA patch_hdmi.c:972 HDMI hot plug event: Co=
dec=3D0 Pin=3D11 Presence_Detect=3D1 ELD_Valid=3D0<br>[=C2=A0=C2=A0=C2=A0 5=
.340980] ALSA patch_hdmi.c:1301 HDMI status: Codec=3D0 Pin=3D11 Presence_De=
tect=3D1 ELD_Valid=3D1<br>[=C2=A0=C2=A0=C2=A0 5.340993] ALSA hda_eld.c:334 =
HDMI: ELD buf size is 0, force 128<br>


[=C2=A0=C2=A0=C2=A0 5.341005] ALSA hda_eld.c:351 HDMI: invalid ELD data byt=
e 0<br>[=C2=A0=C2=A0=C2=A0 5.341008] ALSA patch_hdmi.c:972 HDMI hot plug ev=
ent: Codec=3D0 Pin=3D13 Presence_Detect=3D1 ELD_Valid=3D0<br>[=C2=A0=C2=A0=
=C2=A0 5.341021] ALSA patch_hdmi.c:1301 HDMI status: Codec=3D0 Pin=3D13 Pre=
sence_Detect=3D1 ELD_Valid=3D1<br>


[=C2=A0=C2=A0=C2=A0 5.341034] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, f=
orce 128<br>[=C2=A0=C2=A0=C2=A0 5.341046] ALSA hda_eld.c:351 HDMI: invalid =
ELD data byte 0<br><br><br>[=C2=A0=C2=A0=C2=A0 5.504525] [drm] Radeon Displ=
ay Connectors<br>[=C2=A0=C2=A0=C2=A0 5.504527] [drm] Connector 0:<br>


[=C2=A0=C2=A0=C2=A0 5.504528] [drm]=C2=A0=C2=A0 DP-1<br>[=C2=A0=C2=A0=C2=A0=
 5.504529] [drm]=C2=A0=C2=A0 HPD4<br>[=C2=A0=C2=A0=C2=A0 5.504530] [drm]=C2=
=A0=C2=A0 DDC: 0x6530 0x6530 0x6534 0x6534 0x6538 0x6538 0x653c 0x653c<br>[=
=C2=A0=C2=A0=C2=A0 5.504531] [drm]=C2=A0=C2=A0 Encoders:<br>[=C2=A0=C2=A0=
=C2=A0 5.504532] [drm]=C2=A0=C2=A0=C2=A0=C2=A0 DFP1: INTERNAL_UNIPHY2<br>


[=C2=A0=C2=A0=C2=A0 5.504533] [drm] Connector 1:<br>[=C2=A0=C2=A0=C2=A0 5.5=
04534] [drm]=C2=A0=C2=A0 DP-2<br>[=C2=A0=C2=A0=C2=A0 5.504535] [drm]=C2=A0=
=C2=A0 HPD5<br>[=C2=A0=C2=A0=C2=A0 5.504536] [drm]=C2=A0=C2=A0 DDC: 0x6540 =
0x6540 0x6544 0x6544 0x6548 0x6548 0x654c 0x654c<br>[=C2=A0=C2=A0=C2=A0 5.5=
04537] [drm]=C2=A0=C2=A0 Encoders:<br>


[=C2=A0=C2=A0=C2=A0 5.504538] [drm]=C2=A0=C2=A0=C2=A0=C2=A0 DFP2: INTERNAL_=
UNIPHY2<br>[=C2=A0=C2=A0=C2=A0 5.504538] [drm] Connector 2:<br>[=C2=A0=C2=
=A0=C2=A0 5.504539] [drm]=C2=A0=C2=A0 HDMI-A-1<br>[=C2=A0=C2=A0=C2=A0 5.504=
540] [drm]=C2=A0=C2=A0 HPD1<br>[=C2=A0=C2=A0=C2=A0 5.504541] [drm]=C2=A0=C2=
=A0 DDC: 0x6550 0x6550 0x6554 0x6554 0x6558 0x6558 0x655c 0x655c<br>


[=C2=A0=C2=A0=C2=A0 5.504542] [drm]=C2=A0=C2=A0 Encoders:<br>[=C2=A0=C2=A0=
=C2=A0 5.504543] [drm]=C2=A0=C2=A0=C2=A0=C2=A0 DFP3: INTERNAL_UNIPHY1<br>[=
=C2=A0=C2=A0=C2=A0 5.504544] [drm] Connector 3:<br>[=C2=A0=C2=A0=C2=A0 5.50=
4545] [drm]=C2=A0=C2=A0 DVI-I-1<br>[=C2=A0=C2=A0=C2=A0 5.504545] [drm]=C2=
=A0=C2=A0 HPD6<br>[=C2=A0=C2=A0=C2=A0 5.504547] [drm]=C2=A0=C2=A0 DDC: 0x65=
80 0x6580 0x6584 0x6584 0x6588 0x6588 0x658c 0x658c<br>


[=C2=A0=C2=A0=C2=A0 5.504547] [drm]=C2=A0=C2=A0 Encoders:<br>[=C2=A0=C2=A0=
=C2=A0 5.504548] [drm]=C2=A0=C2=A0=C2=A0=C2=A0 DFP4: INTERNAL_UNIPHY<br>[=
=C2=A0=C2=A0=C2=A0 5.504549] [drm]=C2=A0=C2=A0=C2=A0=C2=A0 CRT1: INTERNAL_K=
LDSCP_DAC1<br><br>[=C2=A0=C2=A0=C2=A0 5.640237] ALSA patch_hdmi.c:1301 HDMI=
 status: Codec=3D0 Pin=3D3 Presence_Detect=3D1 ELD_Valid=3D1<br>


[=C2=A0=C2=A0=C2=A0 5.640254] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, f=
orce 128<br>[=C2=A0=C2=A0=C2=A0 5.640267] ALSA hda_eld.c:351 HDMI: invalid =
ELD data byte 0<br>[=C2=A0=C2=A0=C2=A0 5.640270] ALSA patch_hdmi.c:1301 HDM=
I status: Codec=3D0 Pin=3D5 Presence_Detect=3D1 ELD_Valid=3D1<br>


[=C2=A0=C2=A0=C2=A0 5.640282] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, f=
orce 128<br>[=C2=A0=C2=A0=C2=A0 5.640295] ALSA hda_eld.c:351 HDMI: invalid =
ELD data byte 0<br>[=C2=A0=C2=A0=C2=A0 5.640297] ALSA patch_hdmi.c:1301 HDM=
I status: Codec=3D0 Pin=3D7 Presence_Detect=3D1 ELD_Valid=3D1<br>


[=C2=A0=C2=A0=C2=A0 5.640310] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, f=
orce 128<br>[=C2=A0=C2=A0=C2=A0 5.640322] ALSA hda_eld.c:351 HDMI: invalid =
ELD data byte 0<br>[=C2=A0=C2=A0=C2=A0 5.640324] ALSA patch_hdmi.c:1301 HDM=
I status: Codec=3D0 Pin=3D9 Presence_Detect=3D1 ELD_Valid=3D1<br>


[=C2=A0=C2=A0=C2=A0 5.640336] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, f=
orce 128<br>[=C2=A0=C2=A0=C2=A0 5.640349] ALSA hda_eld.c:351 HDMI: invalid =
ELD data byte 0<br>[=C2=A0=C2=A0=C2=A0 5.640351] ALSA patch_hdmi.c:1301 HDM=
I status: Codec=3D0 Pin=3D11 Presence_Detect=3D1 ELD_Valid=3D1<br>


[=C2=A0=C2=A0=C2=A0 5.640363] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, f=
orce 128<br>[=C2=A0=C2=A0=C2=A0 5.640376] ALSA hda_eld.c:351 HDMI: invalid =
ELD data byte 0<br>[=C2=A0=C2=A0=C2=A0 5.640378] ALSA patch_hdmi.c:1301 HDM=
I status: Codec=3D0 Pin=3D13 Presence_Detect=3D1 ELD_Valid=3D1<br>


[=C2=A0=C2=A0=C2=A0 5.640390] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, f=
orce 128<br>[=C2=A0=C2=A0=C2=A0 5.640403] ALSA hda_eld.c:351 HDMI: invalid =
ELD data byte 0<br><br><br>[=C2=A0=C2=A0=C2=A0=C2=A0 7.906] (II) RADEON(0):=
 EDID for output DisplayPort-0<br>[=C2=A0=C2=A0=C2=A0=C2=A0 7.920] (II) RAD=
EON(0): EDID for output DisplayPort-1<br>


[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) RADEON(0): EDID for output HDMI-0<br>=
[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) RADEON(0): Manufacturer: DON=C2=A0 Mo=
del: 26=C2=A0 Serial#: 16843009<br>[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) RA=
DEON(0): Year: 2011=C2=A0 Week: 0<br>[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) =
RADEON(0): EDID Version: 1.3<br>
[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) RADEON(0): Monitor name: DENON-AVAMP<=
br>[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) RADEON(0): Number of EDID sections=
 to follow: 1<br>[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) RADEON(0): EDID (in =
hex):<br>[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) RADEON(0): =C2=A0=C2=A0=C2=
=A0 00ffffffffffff0011ee260001010101<br>
[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) RADEON(0): =C2=A0=C2=A0=C2=A0 0015010=
3800000780adaffa3584aa229<br>[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) RADEON(0=
): =C2=A0=C2=A0=C2=A0 17494b00000001010101010101010101<br>[=C2=A0=C2=A0=C2=
=A0=C2=A0 7.983] (II) RADEON(0): =C2=A0=C2=A0=C2=A0 010101010101023a8018713=
82d40582c<br>[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) RADEON(0): =C2=A0=C2=A0=
=C2=A0 4500ba882100001e011d8018711c1620<br>
[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) RADEON(0): =C2=A0=C2=A0=C2=A0 582c250=
0ba882100009e000000fc0044<br>[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) RADEON(0=
): =C2=A0=C2=A0=C2=A0 454e4f4e2d4156414d500a20000000fd<br>[=C2=A0=C2=A0=C2=
=A0=C2=A0 7.983] (II) RADEON(0): =C2=A0=C2=A0=C2=A0 00173d0f440f000a2020202=
02020010d<br>[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) RADEON(0): =C2=A0=C2=A0=
=C2=A0 020335714d9005200403020706010e23<br>
[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) RADEON(0): =C2=A0=C2=A0=C2=A0 0f24320=
f7f073d1ec01507505f7e0157<br>[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) RADEON(0=
): =C2=A0=C2=A0=C2=A0 0600677e00835f0000e305030167030c<br>[=C2=A0=C2=A0=C2=
=A0=C2=A0 7.983] (II) RADEON(0): =C2=A0=C2=A0=C2=A0 001500b82d011d007251d01=
e206e2855<br>[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) RADEON(0): =C2=A0=C2=A0=
=C2=A0 00ba882100001e8c0ad08a20e02d1010<br>
[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) RADEON(0): =C2=A0=C2=A0=C2=A0 3e9600b=
a88210000188c0ad08a20e02d<br>[=C2=A0=C2=A0=C2=A0=C2=A0 7.983] (II) RADEON(0=
): =C2=A0=C2=A0=C2=A0 10103e96000b88210000188c0aa01451<br>[=C2=A0=C2=A0=C2=
=A0=C2=A0 7.983] (II) RADEON(0): =C2=A0=C2=A0=C2=A0 f01600267c4300ba8821000=
0980000e7<br>

<br><br>[=C2=A0=C2=A0=C2=A0=C2=A0 8.003] (II) RADEON(0): EDID for output DV=
I-0<br>[=C2=A0=C2=A0=C2=A0=C2=A0 8.003] (II) RADEON(0): Output DisplayPort-=
0 disconnected<br>[=C2=A0=C2=A0=C2=A0=C2=A0 8.003] (II) RADEON(0): Output D=
isplayPort-1 disconnected<br>[=C2=A0=C2=A0=C2=A0=C2=A0 8.003] (II) RADEON(0=
): Output HDMI-0 connected<br>


[=C2=A0=C2=A0=C2=A0=C2=A0 8.003] (II) RADEON(0): Output DVI-0 disconnected<=
br><br><br></div><div class=3D"gmail_extra">Does this mean the graphic driv=
er received EDID from=C2=A0 DENON-AVAMP and pass ELD to audio driver ?<br><=
br>[=C2=A0=C2=A0=C2=A0 8.228364] ALSA patch_hdmi.c:972 HDMI hot plug event:=
 Codec=3D0 Pin=3D3 Presence_Detect=3D0 ELD_Valid=3D1<br>


[=C2=A0=C2=A0=C2=A0 8.228380] ALSA patch_hdmi.c:1301 HDMI status: Codec=3D0=
 Pin=3D3 Presence_Detect=3D1 ELD_Valid=3D1<br>[=C2=A0=C2=A0=C2=A0 8.228393]=
 ALSA hda_eld.c:334 HDMI: ELD buf size is 0, force 128<br>[=C2=A0=C2=A0=C2=
=A0 8.228406] ALSA hda_eld.c:351 HDMI: invalid ELD data byte 0<br>


[=C2=A0=C2=A0=C2=A0 8.377652] type=3D1006 audit(1386558737.773:2): pid=3D51=
5 uid=3D0 old auid=3D4294967295 new auid=3D1000 old ses=3D4294967295 new se=
s=3D1 res=3D1<br>[=C2=A0=C2=A0=C2=A0 8.520795] ALSA hda_codec.c:1633 hda_co=
dec_cleanup_stream: NID=3D0x2<br>[=C2=A0=C2=A0=C2=A0 8.521113] ALSA hda_cod=
ec.c:1633 hda_codec_cleanup_stream: NID=3D0x2<br>


[=C2=A0=C2=A0=C2=A0 8.521434] ALSA hda_codec.c:1633 hda_codec_cleanup_strea=
m: NID=3D0x2<br>[=C2=A0=C2=A0=C2=A0 8.521727] ALSA hda_codec.c:1633 hda_cod=
ec_cleanup_stream: NID=3D0x2<br>[=C2=A0=C2=A0=C2=A0 8.526625] ALSA patch_hd=
mi.c:1301 HDMI status: Codec=3D0 Pin=3D3 Presence_Detect=3D1 ELD_Valid=3D1<=
br>


[=C2=A0=C2=A0=C2=A0 8.526640] ALSA hda_eld.c:334 HDMI: ELD buf size is 0, f=
orce 128<br>[=C2=A0=C2=A0=C2=A0 8.526652] ALSA hda_eld.c:351 HDMI: invalid =
ELD data byte 0<br><br><br>[=C2=A0=C2=A0=C2=A0=C2=A0 8.261] (II) config/ude=
v: Adding drm device (/dev/dri/card0)<br>[=C2=A0=C2=A0=C2=A0=C2=A0 8.262] (=
II) config/udev: Adding input device HDA ATI HDMI HDMI/DP,pcm=3D9 (/dev/inp=
ut/event8)<br>


[=C2=A0=C2=A0=C2=A0=C2=A0 8.262] (II) No input driver specified, ignoring t=
his device.<br>[=C2=A0=C2=A0=C2=A0=C2=A0 8.262] (II) This device may have b=
een added with another device file.<br>[=C2=A0=C2=A0=C2=A0=C2=A0 8.262] (II=
) config/udev: Adding input device HDA ATI HDMI HDMI/DP,pcm=3D10 (/dev/inpu=
t/event7)<br>


[=C2=A0=C2=A0=C2=A0=C2=A0 8.262] (II) No input driver specified, ignoring t=
his device.<br>[=C2=A0=C2=A0=C2=A0=C2=A0 8.262] (II) This device may have b=
een added with another device file.<br>[=C2=A0=C2=A0=C2=A0=C2=A0 8.262] (II=
) config/udev: Adding input device HDA ATI HDMI HDMI/DP,pcm=3D11 (/dev/inpu=
t/event6)<br>


[=C2=A0=C2=A0=C2=A0=C2=A0 8.262] (II) No input driver specified, ignoring t=
his device.<br>[=C2=A0=C2=A0=C2=A0=C2=A0 8.262] (II) This device may have b=
een added with another device file.<br>[=C2=A0=C2=A0=C2=A0=C2=A0 8.262] (II=
) config/udev: Adding input device HDA ATI HDMI HDMI/DP,pcm=3D3 (/dev/input=
/event11)<br>


[=C2=A0=C2=A0=C2=A0=C2=A0 8.262] (II) No input driver specified, ignoring t=
his device.<br>[=C2=A0=C2=A0=C2=A0=C2=A0 8.262] (II) This device may have b=
een added with another device file.<br>[=C2=A0=C2=A0=C2=A0=C2=A0 8.262] (II=
) config/udev: Adding input device HDA ATI HDMI HDMI/DP,pcm=3D7 (/dev/input=
/event10)<br>


[=C2=A0=C2=A0=C2=A0=C2=A0 8.262] (II) No input driver specified, ignoring t=
his device.<br>[=C2=A0=C2=A0=C2=A0=C2=A0 8.262] (II) This device may have b=
een added with another device file.<br>[=C2=A0=C2=A0=C2=A0=C2=A0 8.263] (II=
) config/udev: Adding input device HDA ATI HDMI HDMI/DP,pcm=3D8 (/dev/input=
/event9)<br>


[=C2=A0=C2=A0=C2=A0=C2=A0 8.263] (II) No input driver specified, ignoring t=
his device.<br>[=C2=A0=C2=A0=C2=A0=C2=A0 8.263] (II) This device may have b=
een added with another device file.<br>[=C2=A0=C2=A0=C2=A0=C2=A0 8.263] (II=
) config/udev: Adding input device Logitech USB Receiver (/dev/input/event0=
)<br>


<br><br><br></div><div class=3D"gmail_extra"><br></div></div>

--001a1135f6a8481c2d04ed12bdde--

--===============1166280225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--===============1166280225==--
