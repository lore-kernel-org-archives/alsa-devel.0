From: Thomas Creutz <thomas.creutz@gmx.de>
Subject: snd-hda-intel and ALC861 ... strange mixer problem...
Date: Mon, 30 Oct 2006 00:11:24 +0100
Message-ID: <4545351C.9000300@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello Dev's,

I have some Problems with my sound card... I cant use the hardware-mixer.

I use a hg-clone from now:

By loading the sound-driver I become

PCI: Enabling device 0000:00:1b.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...
ALSA /usr/src/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2164: autoconfig:
line_outs=3D1 (0x20/0x0/0x0/0x0/0x0)
ALSA /usr/src/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2168:
speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
ALSA /usr/src/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2172: hp_outs=3D1
(0xb/0x0/0x0/0x0/0x0)
ALSA /usr/src/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2180: inputs:
mic=3D0xd, fmic=3D0x0, line=3D0xc, fline=3D0x0, cd=3D0x11, aux=3D0x0

I played around with alsamixer and find out, that when i push LINE up
and down

that on [dB gain=3D-6.00, -6.00] to [dB gain=3D-3.00, -3.00] the sound was
louder

But when I on [dB gain=3D0.00, 0.00], the sound gets very loud!

On all other gain settings was nothing to choose.

With Alsa 1.0.12rc1 from 2.6.18(and .1) and Alsa 1.0.13 there was a
additional mixer for master (sorry i forgot the label), but this don=B4t
chance anything...

Any Idea what i can do?

greetings,
Thomas

PS: sorry for multiple post, but i see that the first mail was base64 =

encoded :-(

---------------------------

My system:

nbtxc:/home/alientxc# uname -a
Linux nbtxc 2.6.18-1-686-smp #2 SMP Fri Oct 20 16:44:37 CEST 2006 i686
GNU/Linux

nbtxc:/home/alientxc# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.13.
Compiled on Oct 29 2006 for kernel 2.6.18-1-686-smp (SMP).

nbtxc:/home/alientxc# cat /proc/asound/devices
0: [ 0] : control
16: [ 0- 0]: digital audio playback
17: [ 0- 1]: digital audio playback
22: [ 0- 6]: digital audio playback
24: [ 0- 0]: digital audio capture
30: [ 0- 6]: digital audio capture
33: : timer

nbtxc:/home/alientxc# cat /proc/asound/modules
0 snd_hda_intel

nbtxc:/home/alientxc# lsmod|grep snd
snd_hda_intel 19800 4
snd_hda_codec 170688 1 snd_hda_intel
snd_pcm_oss 45536 0
snd_mixer_oss 16128 1 snd_pcm_oss
snd_pcm 75524 4 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_timer 21732 1 snd_pcm
snd 56336 13
snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore 9248 1 snd
snd_page_alloc 9960 2 snd_hda_intel,snd_pcm

nbtxc:/home/alientxc# lspci -vv -s 00:1b.0
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
Subsystem: Uniwill Computer Corp Unknown device 9078
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0, Cache Line Size: 32 bytes
Interrupt: pin A routed to IRQ 66
Region 0: Memory at febfc000 (64-bit, non-prefetchable) [size=3D16K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+,D1-,D2-,D3hot+,D3cold=
+)
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=3D0/0
Enable+
Address: 00000000fee00000 Data: 4042
Capabilities: [70] Express Unknown type IRQ 0
Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
Device: Latency L0s <64ns, L1 <1us
Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
Link: Latency L0s <64ns, L1 <1us
Link: ASPM Disabled CommClk- ExtSynch-
Link: Speed unknown, Width x0

nbtxc:/home/alientxc# amixer
Simple mixer control 'Headphone',0
Capabilities: pswitch
Playback channels: Front Left - Front Right
Mono:
Front Left: Playback [on]
Front Right: Playback [on]
Simple mixer control 'Front',0
Capabilities: pswitch
Playback channels: Front Left - Front Right
Mono:
Front Left: Playback [on]
Front Right: Playback [on]
Simple mixer control 'Line',0
Capabilities: pvolume pswitch
Playback channels: Front Left - Front Right
Limits: Playback 0 - 23
Mono:
Front Left: Playback 15 [65%] [9.00dB] [on]
Front Right: Playback 15 [65%] [9.00dB] [on]
Simple mixer control 'CD',0
Capabilities: pvolume pswitch
Playback channels: Front Left - Front Right
Limits: Playback 0 - 23
Mono:
Front Left: Playback 19 [83%] [21.00dB] [on]
Front Right: Playback 19 [83%] [21.00dB] [on]
Simple mixer control 'Mic',0
Capabilities: pvolume pswitch
Playback channels: Front Left - Front Right
Limits: Playback 0 - 23
Mono:
Front Left: Playback 0 [0%] [-36.00dB] [off]
Front Right: Playback 0 [0%] [-36.00dB] [off]
Simple mixer control 'IEC958',0
Capabilities: pswitch pswitch-joined
Playback channels: Mono
Mono: Playback [off]
Simple mixer control 'Capture',0
Capabilities: cvolume cswitch
Capture channels: Front Left - Front Right
Limits: Capture 0 - 13
Front Left: Capture 0 [0%] [-6.00dB] [on]
Front Right: Capture 0 [0%] [-6.00dB] [on]
Simple mixer control 'Caller ID',0
Capabilities: pswitch pswitch-joined
Playback channels: Mono
Mono: Playback [off]
Simple mixer control 'Input Source',0
Capabilities: enum
Items: 'Mic' 'Line' 'CD'
Item0: 'Mic'
Simple mixer control 'Off-hook',0
Capabilities: pswitch pswitch-joined
Playback channels: Mono
Mono: Playback [off]

nbtxc:/home/alientxc# dpkg -l | grep alsa
ii alsa-base 1.0.13-1 ALSA driver configuration files
ii alsa-oss 1.0.12-1 ALSA wrapper for OSS applications
ii alsa-tools 1.0.13-1 Console based ALSA utilities for specific ha
ii alsa-tools-gui 1.0.13-1 GUI based ALSA utilities for specific hardwa
ii alsa-utils 1.0.13-1 ALSA utilities
ii alsaplayer-alsa 0.99.76-9 PCM player designed for ALSA (ALSA output mo
ii alsaplayer-common 0.99.76-9 PCM player designed for ALSA (common files)
ii alsaplayer-esd 0.99.76-9 PCM player designed for ALSA (EsounD output
ii alsaplayer-gtk 0.99.76-9 PCM player designed for ALSA (GTK version)
ii alsaplayer-oss 0.99.76-9 PCM player designed for ALSA (OSS output mod
ii alsaplayer-text 0.99.76-9 PCM player designed for ALSA (text version)
ii gstreamer0.10-alsa 0.10.10-1 GStreamer plugin for ALSA
ii libpt-plugins-alsa 1.10.2-2 Portable Windows Library Audio Plugin for th
ii libsdl1.2debian-alsa 1.2.11-4 Simple DirectMedia Layer (with X11 and ALSA
ii vlc-plugin-alsa 0.8.6-svn20061012.debian-1 dummy transitional package

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
