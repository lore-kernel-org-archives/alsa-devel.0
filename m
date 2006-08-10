From: Prakash Punnoor <prakash@punnoor.de>
Subject: MCP51 on Asus M2NPV-VM doesn't get correct parameters
	set
Date: Fri, 11 Aug 2006 00:13:46 +0200
Message-ID: <200608110013.49451.prakash@punnoor.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1899037248=="
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

--===============1899037248==
Content-Type: multipart/signed; boundary="nextPart1198423.tNEcp54P6y";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1198423.tNEcp54P6y
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

using snd-hda-intel I get a high pitched sound (and changing vol leads to=20
muted sounds) if I don't set position_fix=3D1. I have to recheck whether I =
need=20
model=3D3stack set or whether alsa puts it correctly. I am on x86_64 using=
=20
linux-2.6.18-rc4.


00:00.0 0500: 10de:02f0 (rev a2)
        Subsystem: 1043:81c0
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: [44] HyperTransport: Slave or Primary Interface
        Capabilities: [e0] HyperTransport: MSI Mapping

00:00.1 0500: 10de:02fa (rev a2)
        Subsystem: 1043:81c0
        Flags: 66MHz, fast devsel

00:00.2 0500: 10de:02fe (rev a2)
        Subsystem: 1043:81c0
        Flags: 66MHz, fast devsel

00:00.3 0500: 10de:02f8 (rev a2)
        Subsystem: 1043:81c0
        Flags: 66MHz, fast devsel

00:00.4 0500: 10de:02f9 (rev a2)
        Subsystem: 1043:81c0
        Flags: bus master, 66MHz, fast devsel, latency 0

00:00.5 0500: 10de:02ff (rev a2)
        Subsystem: 1043:81c0
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: [44] #00 [00fe]
        Capabilities: [fc] #00 [0000]

00:00.6 0500: 10de:027f (rev a2)
        Subsystem: 1043:81c0
        Flags: 66MHz, fast devsel

00:00.7 0500: 10de:027e (rev a2)
        Subsystem: 1043:81c0
        Flags: 66MHz, fast devsel

00:02.0 0604: 10de:02fc (rev a1)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: fd800000-fd8fffff
        Prefetchable memory behind bridge: 00000000fd700000-00000000fd700000
        Capabilities: [40] #0d [0000]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=3D0/1=
=20
Enable+
        Capabilities: [60] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0
        Capabilities: [100] Virtual Channel

00:03.0 0604: 10de:02fd (rev a1)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
        I/O behind bridge: 00008000-00008fff
        Memory behind bridge: fde00000-fdefffff
        Prefetchable memory behind bridge: 00000000fdd00000-00000000fdd00000
        Capabilities: [40] #0d [0000]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=3D0/1=
=20
Enable+
        Capabilities: [60] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0
        Capabilities: [100] Virtual Channel

00:04.0 0604: 10de:02fb (rev a1)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: fdc00000-fdcfffff
        Prefetchable memory behind bridge: 00000000fd900000-00000000fd900000
        Capabilities: [40] #0d [0000]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=3D0/1=
=20
Enable+
        Capabilities: [60] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0
        Capabilities: [100] Virtual Channel

00:05.0 0300: 10de:0240 (rev a2)
        Subsystem: 1043:81cd
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        Memory at fc000000 (32-bit, non-prefetchable) [size=3D16M]
        Memory at e0000000 (64-bit, prefetchable) [size=3D256M]
        Memory at fb000000 (64-bit, non-prefetchable) [size=3D16M]
        [virtual] Expansion ROM at 88000000 [disabled] [size=3D128K]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=3D0/0=
=20
Enable-

00:09.0 0500: 10de:0270 (rev a2)
        Subsystem: 1043:81c0
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: [44] HyperTransport: Slave or Primary Interface
        Capabilities: [e0] HyperTransport: MSI Mapping

00:0a.0 0601: 10de:0260 (rev a3)
        Subsystem: 1043:81c0
        Flags: bus master, 66MHz, fast devsel, latency 0

00:0a.1 0c05: 10de:0264 (rev a3)
        Subsystem: 1043:81c0
        Flags: 66MHz, fast devsel, IRQ 5
        I/O ports at 4c00 [size=3D64]
        I/O ports at 4c40 [size=3D64]
        Capabilities: [44] Power Management version 2

00:0a.2 0500: 10de:0272 (rev a3)
        Subsystem: 1043:81c0
        Flags: 66MHz, fast devsel

00:0b.0 0c03: 10de:026d (rev a3) (prog-if 10)
        Subsystem: 1043:81c0
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        Memory at fe02f000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] Power Management version 2

00:0b.1 0c03: 10de:026e (rev a3) (prog-if 20)
        Subsystem: 1043:81c0
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
        Memory at fe02e000 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [44] Debug port
        Capabilities: [80] Power Management version 2

00:0d.0 0101: 10de:0265 (rev a1) (prog-if 8a)
        Subsystem: 1043:81c0
        Flags: bus master, 66MHz, fast devsel, latency 0
        I/O ports at f400 [size=3D16]
        Capabilities: [44] Power Management version 2

00:0e.0 0101: 10de:0266 (rev a1) (prog-if 85)
        Subsystem: 1043:81c0
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        I/O ports at 09f0 [size=3D8]
        I/O ports at 0bf0 [size=3D4]
        I/O ports at 0970 [size=3D8]
        I/O ports at 0b70 [size=3D4]
        I/O ports at e000 [size=3D16]
        Memory at fe02d000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] Power Management version 2
        Capabilities: [b0] Message Signalled Interrupts: 64bit+ Queue=3D0/2=
=20
Enable-
        Capabilities: [cc] HyperTransport: MSI Mapping

00:0f.0 0101: 10de:0267 (rev a1) (prog-if 85)
        Subsystem: 1043:81c0
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 10
        I/O ports at 09e0 [size=3D8]
        I/O ports at 0be0 [size=3D4]
        I/O ports at 0960 [size=3D8]
        I/O ports at 0b60 [size=3D4]
        I/O ports at cc00 [size=3D16]
        Memory at fe02c000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] Power Management version 2
        Capabilities: [b0] Message Signalled Interrupts: 64bit+ Queue=3D0/2=
=20
Enable-
        Capabilities: [cc] HyperTransport: MSI Mapping

00:10.0 0604: 10de:026f (rev a2) (prog-if 01)
        Flags: bus master, 66MHz, fast devsel, latency 0
        Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-latency=3D=
128
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: fdb00000-fdbfffff
        Prefetchable memory behind bridge: fda00000-fdafffff
        Capabilities: [b8] #0d [0000]
        Capabilities: [8c] HyperTransport: MSI Mapping

00:10.1 0403: 10de:026c (rev a2)
        Subsystem: 1043:81cb
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
        Memory at fe024000 (32-bit, non-prefetchable) [size=3D16K]
        Capabilities: [44] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=3D0/0=
=20
Enable-
        Capabilities: [6c] HyperTransport: MSI Mapping

00:14.0 0680: 10de:0269 (rev a3)
        Subsystem: 1043:816a
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
        Memory at fe02b000 (32-bit, non-prefetchable) [size=3D4K]
        I/O ports at c800 [size=3D8]
        Capabilities: [44] Power Management version 2

00:18.0 0600: 1022:1100
        Flags: fast devsel
        Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 0600: 1022:1101
        Flags: fast devsel

00:18.2 0600: 1022:1102
        Flags: fast devsel

00:18.3 0600: 1022:1103
        Flags: fast devsel
        Capabilities: [f0] #0f [0010]

04:05.0 0c00: 104c:8023 (prog-if 10)
        Subsystem: 1043:808b
        Flags: bus master, medium devsel, latency 32, IRQ 5
        Memory at fdbff000 (32-bit, non-prefetchable) [size=3D2K]
        Memory at fdbf8000 (32-bit, non-prefetchable) [size=3D16K]
        Capabilities: [44] Power Management version 2

Cheers,
=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1198423.tNEcp54P6y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE26+dxU2n/+9+t5gRAuvpAJ9gA1Yv36K1AUJcUH9A8692zgP4WgCeI4qf
a9yJsI3lhSfHInmOmvH2KO4=
=dYfj
-----END PGP SIGNATURE-----

--nextPart1198423.tNEcp54P6y--


--===============1899037248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1899037248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1899037248==--
