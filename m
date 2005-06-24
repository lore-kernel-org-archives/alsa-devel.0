From: Harald Welte <laforge@gnumonks.org>
Subject: atiixp: Problems making it work on SB400
Date: Fri, 24 Jun 2005 18:59:08 +0200
Message-ID: <20050624165908.GL19928@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+svXpSx+RSEd8UhP"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--+svXpSx+RSEd8UhP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've recently obtained a Turion64 notebook (branded as TARGA, originally
built by MSI).  It is based on ATI chipset (SB400)

However, I don't get any audio output, neither on the headphone jack nor
on the speakers - despite everything looking quite nice in /proc/asound
(see remainder of mail).  I've already tried ac97 quirks and played with
every possible mixer setting.  No success :(

I'm happy to any suggestions and/or hints where to start further
debugging the issue.

Thanks in advance!

=3D=3D=3D=3D

/proc/asound/cards:

0 [IXP            ]: ATIIXP - ATI IXP
                     ATI IXP rev 1 with ALC658 at 0xfbdfc800, irq 193

/proc/asound/devices:

 17: [0- 1]: digital audio playback
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
 33:       : timer

/proc/asound/pcm:

00-00: ATI IXP AC97 : ATI IXP AC97 : playback 1 : capture 1
00-01: ATI IXP IEC958 : ATI IXP IEC958 (AC97) : playback 1


/proc/asound/version:
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:3=
3:39 2005 UTC).

/proc/asound/IXP/atiixp:

00: 00000000
04: 00004037
08: 9a500a04
0c: 00005c04
10: 1f405d00
14: 0000007f
18: 00000d09
1c: 00000000
20: 00000000
24: 00000000
28: 00000000
2c: 00000000
30: 03c00000
34: 00002003
38: 1e43d000
3c: 202fc000
40: 1e43d000
44: 202fc928
48: 08001000
4c: 00000000
50: 00000000
54: 00000000
58: 00000000
5c: 00000000
60: 03c00000
64: 00000000
68: 00000000
6c: 00000000
70: 00000000
74: 00000000
78: 00000000
7c: 00000000
80: 00000000
84: 00000000
88: 00000000
8c: 0000005a
90: 00000000
94: 00000000
98: 00000000
9c: 00000000
a0: 00000000
a4: 00000000
a8: 00000000
ac: 00000000
b0: 00000000
b4: 00000000
b8: 00000000
bc: 00000000
c0: 00000000
c4: 00000000
c8: 00000000
cc: 00000000
d0: 00000000
d4: 00000000
d8: 00000000
dc: 00000000
e0: 00000000
e4: 00000000
e8: 00000000
ec: 00000000
f0: 00000000
f4: 00000000
f8: 00000000
fc: 00000000

/proc/asound/IXP/codec97#0/ac97#0:

0-0/0: Realtek ALC658 rev 0

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0xffff
Subsys. ID       : 0xffff

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Double rate slots: 10/11
Extended ID      : codec=3D0 rev=3D2 LDAC SDAC CDAC DSA=3D0 SPDIF DRA VRA
Extended status  : LDAC SDAC CDAC SPDIF=3D3/4 VRA
PCM front DAC    : 8000Hz
PCM Surr DAC     : 8000Hz
PCM LFE DAC      : 8000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=3D0x2 Generation=3D1 Rate=3D48kHz

/proc/asound/IXP/codec97#0/ac97#0-0+regs:

0:00 =3D 0180
0:02 =3D 0707
0:04 =3D 0000
0:06 =3D 0000
0:08 =3D 0000
0:0a =3D 000e
0:0c =3D 000f
0:0e =3D 010d
0:10 =3D 0c0c
0:12 =3D 0303
0:14 =3D 0000
0:16 =3D 0d0d
0:18 =3D 0303
0:1a =3D 0505
0:1c =3D 0808
0:1e =3D 8000
0:20 =3D 0000
0:22 =3D 0000
0:24 =3D 0000
0:26 =3D 000f
0:28 =3D 09c7
0:2a =3D 01c1
0:2c =3D 1f40
0:2e =3D 1f40
0:30 =3D 1f40
0:32 =3D bb80
0:34 =3D bb80
0:36 =3D 1a18
0:38 =3D 1a1a
0:3a =3D 2824
0:3c =3D 0000
0:3e =3D 0000
0:40 =3D 0000
0:42 =3D 0000
0:44 =3D 0000
0:46 =3D 0000
0:48 =3D 0000
0:4a =3D 0000
0:4c =3D 0000
0:4e =3D 0000
0:50 =3D 0000
0:52 =3D 0000
0:54 =3D 0000
0:56 =3D 0000
0:58 =3D 0000
0:5a =3D 0000
0:5c =3D 0000
0:5e =3D 0000
0:60 =3D 0000
0:62 =3D 0000
0:64 =3D 0808
0:66 =3D 0808
0:68 =3D 0aea
0:6a =3D 8001
0:6c =3D 4601
0:6e =3D 0002
0:70 =3D 0008
0:72 =3D 0000
0:74 =3D 011f
0:76 =3D 0000
0:78 =3D 0007
0:7a =3D 40b0
0:7c =3D 414c
0:7e =3D 4780

/proc/asound/IXP/oss_mixer:


VOLUME "Master" 0
BASS "" 0
TREBLE "" 0
SYNTH "" 0
PCM "PCM" 0
SPEAKER "PC Speaker" 0
LINE "Line" 0
MIC "Mic" 0
CD "CD" 0
IMIX "" 0
ALTPCM "" 0
RECLEV "" 0
IGAIN "Capture" 0
OGAIN "" 0
LINE1 "Aux" 0
LINE2 "" 0
LINE3 "" 0
DIGITAL1 "IEC958" 0
DIGITAL2 "" 0
DIGITAL3 "" 0
PHONEIN "Phone" 0
PHONEOUT "Master Mono" 0
VIDEO "Video" 0
RADIO "" 0
MONITOR "" 0

/proc/asound/IXP/pcm0p/sub0/status (while playing):

state: RUNNING
trigger_time: 1118529954.000001603
tstamp      : 1118529975.000184514
delay       : 13526
avail       : 2858
avail_max   : 4096
-----
hw_ptr      : 84778
appl_ptr    : 98304


lspci -v

0000:00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5951
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0291
	Flags: bus master, 66MHz, medium devsel, latency 0

0000:00:02.0 PCI bridge: ATI Technologies Inc: Unknown device 5a34 (prog-if=
 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fbe00000-fbefffff
	Prefetchable memory behind bridge: f0000000-faffffff
	Capabilities: [50] Power Management version 3
	Capabilities: [58] #10 [0041]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=3D0/0 Enable+
	Capabilities: [b0] #0d [0000]
	Capabilities: [b8] #08 [a803]

0000:00:13.0 USB Controller: ATI Technologies Inc: Unknown device 4374 (pro=
g-if 10 [OHCI])
	Subsystem: ATI Technologies Inc: Unknown device 4374
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 209
	Memory at fbdfd000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=3D0/0 Enable-

0000:00:13.1 USB Controller: ATI Technologies Inc: Unknown device 4375 (pro=
g-if 10 [OHCI])
	Subsystem: ATI Technologies Inc: Unknown device 4375
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 209
	Memory at fbdfe000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=3D0/0 Enable-

0000:00:13.2 USB Controller: ATI Technologies Inc: Unknown device 4373 (pro=
g-if 20 [EHCI])
	Subsystem: ATI Technologies Inc: Unknown device 4373
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 209
	Memory at fbdff000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=3D0/0 Enable-

0000:00:14.0 SMBus: ATI Technologies Inc: Unknown device 4372 (rev 10)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0291
	Flags: 66MHz, medium devsel
	I/O ports at c800 [size=3D16]
	Memory at fbdfc400 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [b0] #08 [a802]

0000:00:14.1 IDE interface: ATI Technologies Inc: Unknown device 4376 (prog=
-if 8a [Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0291
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 201
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at ff00 [size=3D16]
	Capabilities: [70] Message Signalled Interrupts: 64bit- Queue=3D0/0 Enable-

0000:00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 4377
	Flags: bus master, 66MHz, medium devsel, latency 0

0000:00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4371 (prog-if=
 01 [Subtractive decode])
	Flags: bus master, 66MHz, medium devsel, latency 64
	Bus: primary=3D00, secondary=3D02, subordinate=3D04, sec-latency=3D64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fbf00000-fbffffff

0000:00:14.5 Multimedia audio controller: ATI Technologies Inc: Unknown dev=
ice 4370 (rev 01)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0291
	Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 193
	Memory at fbdfc800 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [40] Message Signalled Interrupts: 64bit- Queue=3D0/0 Enable-

0000:00:14.6 Modem: ATI Technologies Inc: Unknown device 4378 (rev 01) (pro=
g-if 00 [Generic])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0131
	Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 193
	Memory at fbdfcc00 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [40] Message Signalled Interrupts: 64bit- Queue=3D0/0 Enable-

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel
	Capabilities: [80] #08 [2101]

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel

0000:01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown devic=
e 5653 (prog-if 00 [VGA])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0291
	Flags: bus master, fast devsel, latency 0, IRQ 10
	Memory at f0000000 (32-bit, prefetchable) [size=3D128M]
	I/O ports at d800 [size=3D256]
	Memory at fbef0000 (32-bit, non-prefetchable) [size=3D64K]
	Expansion ROM at fbec0000 [disabled] [size=3D128K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #10 [0001]
	Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=3D0/0 Enable-

0000:02:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/=
8139C/8139C+ (rev 10)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0291
	Flags: bus master, medium devsel, latency 64, IRQ 225
	I/O ports at e800 [size=3D256]
	Memory at fbfffc00 (32-bit, non-prefetchable) [size=3D256]
	Expansion ROM at fbfe0000 [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2

0000:02:04.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0291
	Flags: bus master, medium devsel, latency 168, IRQ 209
	Memory at 40000000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D02, secondary=3D03, subordinate=3D06, sec-latency=3D176
	Memory window 0: 40400000-407ff000 (prefetchable)
	Memory window 1: 40800000-40bff000
	I/O window 0: 00004400-000044ff
	I/O window 1: 00004800-000048ff
	16-bit legacy interface ports at 0001

0000:02:04.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0291
	Flags: bus master, medium devsel, latency 168, IRQ 217
	Memory at 40001000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D02, secondary=3D07, subordinate=3D0a, sec-latency=3D176
	Memory window 0: 40c00000-40fff000 (prefetchable)
	Memory window 1: 41000000-413ff000
	I/O window 0: 00004c00-00004cff
	I/O window 1: 00005000-000050ff
	16-bit legacy interface ports at 0001

0000:02:04.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller=
 (rev 04) (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0291
	Flags: bus master, medium devsel, latency 64, IRQ 169
	Memory at fbfff000 (32-bit, non-prefetchable) [size=3D2K]
	Capabilities: [dc] Power Management version 2

0000:02:09.0 Network controller: Intel Corp.: Unknown device 4223 (rev 05)
	Subsystem: Intel Corp.: Unknown device 1001
	Flags: bus master, medium devsel, latency 64, IRQ 201
	Memory at fbffe000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [dc] Power Management version 2


lspci -n
0000:00:00.0 0600: 1002:5951
0000:00:02.0 0604: 1002:5a34
0000:00:13.0 0c03: 1002:4374
0000:00:13.1 0c03: 1002:4375
0000:00:13.2 0c03: 1002:4373
0000:00:14.0 0c05: 1002:4372 (rev 10)
0000:00:14.1 0101: 1002:4376
0000:00:14.3 0601: 1002:4377
0000:00:14.4 0604: 1002:4371
0000:00:14.5 0401: 1002:4370 (rev 01)
0000:00:14.6 0703: 1002:4378 (rev 01)
0000:00:18.0 0600: 1022:1100
0000:00:18.1 0600: 1022:1101
0000:00:18.2 0600: 1022:1102
0000:00:18.3 0600: 1022:1103
0000:01:00.0 0300: 1002:5653
0000:02:03.0 0200: 10ec:8139 (rev 10)
0000:02:04.0 0607: 1180:0476 (rev ac)
0000:02:04.1 0607: 1180:0476 (rev ac)
0000:02:04.2 0c00: 1180:0552 (rev 04)
0000:02:09.0 0280: 8086:4223 (rev 05)
--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--+svXpSx+RSEd8UhP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCvDvcXaXGVTD0i/8RAiPKAKChRSj093tzRvzX5Ba2UndgUQXf9gCdFNSE
u/q8UmdzfcScUsnM3Wz6kBY=
=mzEN
-----END PGP SIGNATURE-----

--+svXpSx+RSEd8UhP--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
