From: Filippo Giunchedi <filippo@esaurito.net>
Subject: detecting codecs for snd-hda-intel ?
Date: Tue, 27 Jun 2006 15:26:56 +0200
Message-ID: <20060627132656.GA32321@esaurito.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0920242348=="
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


--===============0920242348==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[please CC on replies, I'm not subscribed]

Hi,
first: many thanks for alsa! it is really a good product.

I'm having some troubles with the drivers on an asus w6f (notebook) with an=
 intel 945GM
chipset (lspci -nv at bottom).
1.0.11 kernel drivers stop here:

hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...

while a checkout of drivers from hg repo gives some more informations:

hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...
ALSA /home/ionocatabi/down/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2133: au=
toconfig: line_outs=3D1 (0xb/0x0/0x0/0x0/0x0)
ALSA /home/ionocatabi/down/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2137:   =
 speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
ALSA /home/ionocatabi/down/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2139:   =
 hp=3D0x0, dig_out=3D0x12, din_in=3D0x0
ALSA /home/ionocatabi/down/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2147:   =
 inputs: mic=3D0xd, fmic=3D0x0, line=3D0x0, fline=3D0x0, cd=3D0x11, aux=3D0=
x0

but still no luck :(
passing model=3Dasus is of no help, every volume control is up but I can't =
hear
sound, nor from line-out nor from internal speakers.  Sound seems to play b=
ut I
can't hear anything.

any clue on this?

thanks in advance,
filippo

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
00:00.0 0600: 8086:27a0 (rev 03)
	Subsystem: 1043:1267
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:02.0 0300: 8086:27a2 (rev 03)
	Subsystem: 1043:1252
	Flags: bus master, fast devsel, latency 0, IRQ 11
	Memory at feb80000 (32-bit, non-prefetchable) [size=3D512K]
	I/O ports at ec00 [size=3D8]
	Memory at d0000000 (32-bit, prefetchable) [size=3D256M]
	Memory at feb40000 (32-bit, non-prefetchable) [size=3D256K]
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=3D0/0 Enable-
	Capabilities: [d0] Power Management version 2

00:02.1 0380: 8086:27a6 (rev 03)
	Subsystem: 1043:1252
	Flags: bus master, fast devsel, latency 0
	Memory at fea80000 (32-bit, non-prefetchable) [size=3D512K]
	Capabilities: [d0] Power Management version 2

00:1b.0 0403: 8086:27d8 (rev 02)
	Subsystem: 1043:1263
	Flags: bus master, fast devsel, latency 0, IRQ 169
	Memory at feb3c000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=3D0/0 Enable-
	Capabilities: [70] Express Unknown type IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)

00:1c.0 0604: 8086:27d0 (rev 02)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D06, sec-latency=3D0
	I/O behind bridge: 00008000-0000cfff
	Memory behind bridge: fbf00000-fe6fffff
	Prefetchable memory behind bridge: 00000000b5f00000-00000000bfe00000
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=3D0/0 Enable+
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.1 0604: 8086:27d2 (rev 02)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=3D00, secondary=3D07, subordinate=3D07, sec-latency=3D0
	Memory behind bridge: fe700000-fe7fffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=3D0/0 Enable+
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1d.0 0c03: 8086:27c8 (rev 02)
	Subsystem: 1043:1267
	Flags: bus master, medium devsel, latency 0, IRQ 225
	I/O ports at e880 [size=3D32]

00:1d.1 0c03: 8086:27c9 (rev 02)
	Subsystem: 1043:1267
	Flags: bus master, medium devsel, latency 0, IRQ 233
	I/O ports at e800 [size=3D32]

00:1d.2 0c03: 8086:27ca (rev 02)
	Subsystem: 1043:1267
	Flags: bus master, medium devsel, latency 0, IRQ 50
	I/O ports at e480 [size=3D32]

00:1d.3 0c03: 8086:27cb (rev 02)
	Subsystem: 1043:1267
	Flags: bus master, medium devsel, latency 0, IRQ 169
	I/O ports at e400 [size=3D32]

00:1d.7 0c03: 8086:27cc (rev 02) (prog-if 20)
	Subsystem: 1043:1267
	Flags: bus master, medium devsel, latency 0, IRQ 225
	Memory at feb3bc00 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port

00:1e.0 0604: 8086:2448 (rev e2) (prog-if 01)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=3D00, secondary=3D08, subordinate=3D08, sec-latency=3D32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fe800000-fe8fffff
	Capabilities: [50] #0d [0000]

00:1f.0 0601: 8086:27b9 (rev 02)
	Subsystem: 8086:27b9
	Flags: bus master, medium devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:1f.1 0101: 8086:27df (rev 02) (prog-if 8a)
	Subsystem: 1043:1267
	Flags: bus master, medium devsel, latency 0, IRQ 50
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at ffa0 [size=3D16]

07:00.0 0280: 8086:4222 (rev 02)
	Subsystem: 8086:1001
	Flags: bus master, fast devsel, latency 0, IRQ 5
	Memory at fe7ff000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [c8] Power Management version 2
	Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=3D0/0 Enable-
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number 3e-d2-25-ff-ff-02-13-00

08:03.0 0c00: 1180:0832 (prog-if 10)
	Subsystem: 1043:1267
	Flags: bus master, medium devsel, latency 64, IRQ 217
	Memory at fe8ff800 (32-bit, non-prefetchable) [size=3D2K]
	Capabilities: [dc] Power Management version 2

08:03.1 0805: 1180:0822 (rev 19)
	Subsystem: 1043:1267
	Flags: bus master, medium devsel, latency 64, IRQ 3
	Memory at fe8ff400 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [80] Power Management version 2

08:03.2 0880: 1180:0843 (rev 01)
	Subsystem: 1043:1267
	Flags: bus master, medium devsel, latency 0, IRQ 3
	Memory at fe8ff000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [80] Power Management version 2

08:03.3 0880: 1180:0592 (rev 0a)
	Subsystem: 1043:1267
	Flags: medium devsel, IRQ 3
	Memory at fe8fec00 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [80] Power Management version 2

08:03.4 0880: 1180:0852 (rev 05)
	Subsystem: 1043:1267
	Flags: medium devsel, IRQ 3
	Memory at fe8fe800 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [80] Power Management version 2

08:04.0 0200: 10ec:8139 (rev 10)
	Subsystem: 1043:1045
	Flags: bus master, medium devsel, latency 64, IRQ 209
	I/O ports at d800 [size=3D256]
	Memory at fe8fe400 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [50] Power Management version 2

--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

How do you feel about women's rights? I like either side of them.
-- Groucho Marx

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEoTIgABzeamt51AERArBrAKCqlKMEnoYKqw37uvA9WUpFT9PNBQCgotIn
hKUbRACVmTz2dlMZgaoSmB4=
=58u+
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--


--===============0920242348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0920242348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0920242348==--
