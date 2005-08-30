From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: No sound on ATI IXP with Realtek ALC655 rev0 (MSI Megabook S270)
Date: Tue, 30 Aug 2005 11:49:42 +0200
Message-ID: <200508301149.46320.rene@exactcode.de>
References: <200508291419.34270.rene@exactcode.de> <200508301130.42008.rene@exactcode.de> <s5hhdd73glc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1866924.BHZ1ZrGKSZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhdd73glc.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--nextPart1866924.BHZ1ZrGKSZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tuesday 30 August 2005 11:43, Takashi Iwai wrote:

> That's good to know.  Now we need to turn this on automatically at the
> start up.
>
> Could you attach /proc/asound/card0/codec97#0/* files?
> Also please give the output of "lspci -nv", too.

0000:00:00.0 Class 0600: 1002:5950
        Subsystem: 1462:0131
        Flags: bus master, 66Mhz, medium devsel, latency 0

0000:00:01.0 Class 0604: 1002:5a3f
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fbe00000-fbefffff
        Prefetchable memory behind bridge: 00000000f4000000-00000000faf00000
        Expansion ROM at 0000d000 [disabled] [size=3D4K]
        Capabilities: [44] #08 [a803]
        Capabilities: [b0] #0d [0000]

0000:00:13.0 Class 0c03: 1002:4374 (prog-if 10)
        Subsystem: 1002:4374
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
        Memory at fbdfd000 (32-bit, non-prefetchable)
        Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=3D0/0=
=20
Enable-

0000:00:13.1 Class 0c03: 1002:4375 (prog-if 10)
        Subsystem: 1002:4375
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
        Memory at fbdfe000 (32-bit, non-prefetchable)
        Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=3D0/0=
=20
Enable-

0000:00:13.2 Class 0c03: 1002:4373 (prog-if 20)
        Subsystem: 1002:4373
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
        Memory at fbdff000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2
        Capabilities: [d0] Message Signalled Interrupts: 64bit- Queue=3D0/0=
=20
Enable-

0000:00:14.0 Class 0c05: 1002:4372 (rev 10)
        Subsystem: 1462:0131
        Flags: 66Mhz, medium devsel
        I/O ports at c800
        Memory at fbdfc400 (32-bit, non-prefetchable) [size=3D1K]
        Capabilities: [b0] #08 [a802]

0000:00:14.1 Class 0101: 1002:4376 (prog-if 8a [Master SecP PriP])
        Subsystem: 1462:0131
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 11
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at ff00 [size=3D16]
        Capabilities: [70] Message Signalled Interrupts: 64bit- Queue=3D0/0=
=20
Enable-

0000:00:14.3 Class 0601: 1002:4377
        Flags: bus master, 66Mhz, medium devsel, latency 0

0000:00:14.4 Class 0604: 1002:4371 (prog-if 01)
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=3D00, secondary=3D02, subordinate=3D0a, sec-latency=3D=
64
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fbf00000-fbffffff
        Prefetchable memory behind bridge: 20000000-24ffffff
        Expansion ROM at 0000e000 [disabled] [size=3D4K]

0000:00:14.5 Class 0401: 1002:4370 (rev 01)
        Subsystem: 1462:0131
        Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 10
        Memory at fbdfc800 (32-bit, non-prefetchable)
        Capabilities: [40] Message Signalled Interrupts: 64bit- Queue=3D0/0=
=20
Enable-

0000:00:14.6 Class 0703: 1002:4378 (rev 01)
        Subsystem: 1462:0131
        Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 10
        Memory at fbdfcc00 (32-bit, non-prefetchable)
        Capabilities: [40] Message Signalled Interrupts: 64bit- Queue=3D0/0=
=20
Enable-

0000:00:18.0 Class 0600: 1022:1100
        Flags: fast devsel
        Capabilities: [80] #08 [2101]

0000:00:18.1 Class 0600: 1022:1101
        Flags: fast devsel

0000:00:18.2 Class 0600: 1022:1102
        Flags: fast devsel

0000:00:18.3 Class 0600: 1022:1103
        Flags: fast devsel

0000:01:05.0 Class 0300: 1002:5955
        Subsystem: 1462:0131
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 10
        Memory at f4000000 (32-bit, prefetchable) [size=3Df8000000]
        I/O ports at d800 [size=3D256]
        Memory at fbef0000 (32-bit, non-prefetchable) [size=3D64K]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [50] Power Management version 2

0000:02:03.0 Class 0200: 10ec:8139 (rev 10)
        Subsystem: 1462:0131
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at e800 [size=3D576M]
        Memory at fbfffc00 (32-bit, non-prefetchable) [size=3D256]
        Expansion ROM at 00010000 [disabled]
        Capabilities: [50] Power Management version 2

0000:02:04.0 Class 0607: 1180:0476 (rev ac)
        Subsystem: 1462:0131
        Flags: bus master, medium devsel, latency 168, IRQ 11
        Memory at fbf00000 (32-bit, non-prefetchable)
        Bus: primary=3D02, secondary=3D03, subordinate=3D06, sec-latency=3D=
176
        Memory window 0: 20000000-21fff000 (prefetchable)
        Memory window 1: 26000000-27fff000
        I/O window 0: 0000e000-0000e0ff
        I/O window 1: 0000ec00-0000ecff
        16-bit legacy interface ports at 0001

0000:02:04.1 Class 0607: 1180:0476 (rev ac)
        Subsystem: 1462:0131
        Flags: bus master, medium devsel, latency 168, IRQ 6
        Memory at fbf01000 (32-bit, non-prefetchable)
        Bus: primary=3D02, secondary=3D07, subordinate=3D0a, sec-latency=3D=
176
        Memory window 0: 22000000-23fff000 (prefetchable)
        Memory window 1: 28000000-29fff000
        I/O window 0: 00001000-000010ff
        I/O window 1: 00001400-000014ff
        16-bit legacy interface ports at 0001

0000:02:04.2 Class 0c00: 1180:0552 (rev 04) (prog-if 10)
        Subsystem: 1462:0131
        Flags: bus master, medium devsel, latency 64, IRQ 7
        Memory at fbfff000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2

0000:02:09.0 Class 0200: 17fe:2220
        Subsystem: 1462:6855
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at e400
        Memory at fbfff800 (32-bit, non-prefetchable) [size=3D32]
        Memory at fbffe800 (32-bit, non-prefetchable) [size=3D2K]
        Capabilities: [40] Power Management version 2


/proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Realtek ALC655 rev 0

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0xffff
Subsys. ID       : 0xffff

Capabilities     :
DAC resolution   : 16-bit
ADC resolution   : 16-bit
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
Extended ID      : codec=3D0 rev=3D2 LDAC SDAC CDAC DSA=3D0 SPDIF
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3D3/4
SPDIF Control    : Consumer PCM Copyright Category=3D0x22 Generation=3D1=20
Rate=3D48kHz

/proc/asound/card0/codec97#0/ac97#0-0+regs
0:00 =3D 0000
0:02 =3D 1616
0:04 =3D 0000
0:06 =3D 801f
0:08 =3D 0000
0:0a =3D 0014
0:0c =3D 801f
0:0e =3D 801f
0:10 =3D 9f1f
0:12 =3D 9f1f
0:14 =3D 0000
0:16 =3D 9f1f
0:18 =3D 0707
0:1a =3D 0000
0:1c =3D 0000
0:1e =3D 0000
0:20 =3D 0400
0:22 =3D 0000
0:24 =3D 0000
0:26 =3D 000f
0:28 =3D 09c4
0:2a =3D 05c0
0:2c =3D bb80
0:2e =3D bb80
0:30 =3D bb80
0:32 =3D bb80
0:34 =3D 0000
0:36 =3D 9f9f
0:38 =3D 9f9f
0:3a =3D 2a20
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
0:6a =3D 8000
0:6c =3D 0000
0:6e =3D 0025
0:70 =3D 81e0
0:72 =3D 22e8
0:74 =3D 8000
0:76 =3D 0000
0:78 =3D 0007
0:7a =3D 2090
0:7c =3D 414c
0:7e =3D 4760


=2D-=20
Ren=E9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45

--nextPart1866924.BHZ1ZrGKSZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDFCu6QuICExGFvYIRAn2kAJ9uLlkpZWpjjy8sMEk2lG0H4ZaBowCcDeI6
Ard/Cp9AVA7xXXANxL8iqSg=
=RkJU
-----END PGP SIGNATURE-----

--nextPart1866924.BHZ1ZrGKSZ--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
