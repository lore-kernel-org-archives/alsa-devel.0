From: Pablo Yaggi <pyaggi@alsurdelsur.com>
Subject: snd_hda_intel bug
Date: Mon, 24 Sep 2007 21:07:12 -0300
Message-ID: <200709242107.12399.pyaggi@alsurdelsur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from alsurdelsur.com (59.42.80.200.host.ifxnw.com.ar [200.80.42.59])
	by alsa0.perex.cz (Postfix) with ESMTP id B20942490B
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Sep 2007 02:07:52 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Please let me know if a bug report must be
placed somewhere else because i get no
reply about this issue and i don't know if the
snd_hda_intel driver maintainer received it.

The bug repost:
	=A0i bought a sony vaio fz19vn, i try both modes for the snd_hda_intel, va=
io =

and vaio-ar, the same problem happen with both of them, when i plugin the =

headset internal speakers are not muted, so here is the card info:

00:00.0 0600: 8086:2a00 (rev 0c)
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, fast devsel, latency 0
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [e0] Vendor Specific Information

00:02.0 0300: 8086:2a02 (rev 0c) (prog-if 00 [VGA])
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, fast devsel, latency 0, IRQ 5
=A0=A0=A0=A0=A0=A0=A0=A0Memory at fc000000 (64-bit, non-prefetchable) [size=
=3D1M]
=A0=A0=A0=A0=A0=A0=A0=A0Memory at d0000000 (64-bit, prefetchable) [size=3D2=
56M]
=A0=A0=A0=A0=A0=A0=A0=A0I/O ports at 1800 [size=3D8]
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [90] Message Signalled Interrupts: Ma=
sk- 64bit- =

Queue=3D0/0 =

Enable-
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [d0] Power Management version 3

00:02.1 0380: 8086:2a03 (rev 0c)
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, fast devsel, latency 0
=A0=A0=A0=A0=A0=A0=A0=A0Memory at fc100000 (64-bit, non-prefetchable) [size=
=3D1M]
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [d0] Power Management version 3

00:1a.0 0c03: 8086:2834 (rev 03) (prog-if 00 [UHCI])
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, medium devsel, latency 0, IRQ 17
=A0=A0=A0=A0=A0=A0=A0=A0I/O ports at 1820 [size=3D32]

00:1a.1 0c03: 8086:2835 (rev 03) (prog-if 00 [UHCI])
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, medium devsel, latency 0, IRQ 20
=A0=A0=A0=A0=A0=A0=A0=A0I/O ports at 1840 [size=3D32]

00:1a.7 0c03: 8086:283a (rev 03) (prog-if 20 [EHCI])
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, medium devsel, latency 0, IRQ 18
=A0=A0=A0=A0=A0=A0=A0=A0Memory at fc604800 (32-bit, non-prefetchable) [size=
=3D1K]
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [50] Power Management version 2
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [58] Debug port

00:1b.0 0403: 8086:284b (rev 03)
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, fast devsel, latency 0, IRQ 21
=A0=A0=A0=A0=A0=A0=A0=A0Memory at fc400000 (64-bit, non-prefetchable) [size=
=3D16K]
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [50] Power Management version 2
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [60] Message Signalled Interrupts: Ma=
sk- 64bit+ =

Queue=3D0/0 =

Enable-
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [70] Express Unknown type IRQ 0
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [100] Virtual Channel
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [130] Unknown (5)

00:1c.0 0604: 8086:283f (rev 03) (prog-if 00 [Normal decode])
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, fast devsel, latency 0
=A0=A0=A0=A0=A0=A0=A0=A0Bus: primary=3D00, secondary=3D02, subordinate=3D03=
, sec-latency=3D0
=A0=A0=A0=A0=A0=A0=A0=A0I/O behind bridge: 00002000-00002fff
=A0=A0=A0=A0=A0=A0=A0=A0Memory behind bridge: f6000000-f7ffffff
=A0=A0=A0=A0=A0=A0=A0=A0Prefetchable memory behind bridge: 00000000f0000000=
-00000000f1ffffff
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [40] Express Root Port (Slot+) IRQ 0
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [80] Message Signalled Interrupts: Ma=
sk- 64bit- =

Queue=3D0/0 =

Enable+
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [90] Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [a0] Power Management version 2
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [100] Virtual Channel
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [180] Unknown (5)

00:1c.1 0604: 8086:2841 (rev 03) (prog-if 00 [Normal decode])
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, fast devsel, latency 0
=A0=A0=A0=A0=A0=A0=A0=A0Bus: primary=3D00, secondary=3D04, subordinate=3D05=
, sec-latency=3D0
=A0=A0=A0=A0=A0=A0=A0=A0I/O behind bridge: 00003000-00003fff
=A0=A0=A0=A0=A0=A0=A0=A0Memory behind bridge: f8000000-f9ffffff
=A0=A0=A0=A0=A0=A0=A0=A0Prefetchable memory behind bridge: 00000000f2000000=
-00000000f3ffffff
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [40] Express Root Port (Slot+) IRQ 0
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [80] Message Signalled Interrupts: Ma=
sk- 64bit- =

Queue=3D0/0 =

Enable+
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [90] Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [a0] Power Management version 2
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [100] Virtual Channel
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [180] Unknown (5)

00:1c.2 0604: 8086:2843 (rev 03) (prog-if 00 [Normal decode])
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, fast devsel, latency 0
=A0=A0=A0=A0=A0=A0=A0=A0Bus: primary=3D00, secondary=3D06, subordinate=3D07=
, sec-latency=3D0
=A0=A0=A0=A0=A0=A0=A0=A0I/O behind bridge: 00004000-00004fff
=A0=A0=A0=A0=A0=A0=A0=A0Memory behind bridge: fa000000-fbffffff
=A0=A0=A0=A0=A0=A0=A0=A0Prefetchable memory behind bridge: 00000000f4000000=
-00000000f5ffffff
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [40] Express Root Port (Slot+) IRQ 0
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [80] Message Signalled Interrupts: Ma=
sk- 64bit- =

Queue=3D0/0 =

Enable+
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [90] Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [a0] Power Management version 2
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [100] Virtual Channel
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [180] Unknown (5)

00:1c.4 0604: 8086:2847 (rev 03) (prog-if 00 [Normal decode])
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, fast devsel, latency 0
=A0=A0=A0=A0=A0=A0=A0=A0Bus: primary=3D00, secondary=3D08, subordinate=3D08=
, sec-latency=3D0
=A0=A0=A0=A0=A0=A0=A0=A0I/O behind bridge: 00005000-00005fff
=A0=A0=A0=A0=A0=A0=A0=A0Memory behind bridge: fc200000-fc2fffff
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [40] Express Root Port (Slot+) IRQ 0
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [80] Message Signalled Interrupts: Ma=
sk- 64bit- =

Queue=3D0/0 =

Enable+
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [90] Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [a0] Power Management version 2
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [100] Virtual Channel
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [180] Unknown (5)

00:1d.0 0c03: 8086:2830 (rev 03) (prog-if 00 [UHCI])
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, medium devsel, latency 0, IRQ 22
=A0=A0=A0=A0=A0=A0=A0=A0I/O ports at 1860 [size=3D32]

00:1d.1 0c03: 8086:2831 (rev 03) (prog-if 00 [UHCI])
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, medium devsel, latency 0, IRQ 19
=A0=A0=A0=A0=A0=A0=A0=A0I/O ports at 1880 [size=3D32]

00:1d.2 0c03: 8086:2832 (rev 03) (prog-if 00 [UHCI])
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, medium devsel, latency 0, IRQ 18
=A0=A0=A0=A0=A0=A0=A0=A0I/O ports at 18a0 [size=3D32]

00:1d.7 0c03: 8086:2836 (rev 03) (prog-if 20 [EHCI])
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, medium devsel, latency 0, IRQ 22
=A0=A0=A0=A0=A0=A0=A0=A0Memory at fc604c00 (32-bit, non-prefetchable) [size=
=3D1K]
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [50] Power Management version 2
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [58] Debug port

00:1e.0 0604: 8086:2448 (rev f3) (prog-if 01 [Subtractive decode])
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, fast devsel, latency 0
=A0=A0=A0=A0=A0=A0=A0=A0Bus: primary=3D00, secondary=3D09, subordinate=3D0d=
, sec-latency=3D56
=A0=A0=A0=A0=A0=A0=A0=A0I/O behind bridge: 00006000-00006fff
=A0=A0=A0=A0=A0=A0=A0=A0Memory behind bridge: fc300000-fc3fffff
=A0=A0=A0=A0=A0=A0=A0=A0Prefetchable memory behind bridge: 0000000088000000=
-000000008bffffff
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [50] Subsystem: 104d:9005

00:1f.0 0601: 8086:2815 (rev 03)
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, medium devsel, latency 0
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [e0] Vendor Specific Information

00:1f.1 0101: 8086:2850 (rev 03) (prog-if 8a [Master SecP PriP])
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, medium devsel, latency 0, IRQ 19
=A0=A0=A0=A0=A0=A0=A0=A0I/O ports at 01f0 [size=3D8]
=A0=A0=A0=A0=A0=A0=A0=A0I/O ports at 03f4 [size=3D1]
=A0=A0=A0=A0=A0=A0=A0=A0I/O ports at 0170 [size=3D8]
=A0=A0=A0=A0=A0=A0=A0=A0I/O ports at 0374 [size=3D1]
=A0=A0=A0=A0=A0=A0=A0=A0I/O ports at 1810 [size=3D16]

00:1f.2 0106: 8086:2829 (rev 03) (prog-if 01 [AHCI 1.0])
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, 66MHz, medium devsel, latency 0,=
 IRQ 219
=A0=A0=A0=A0=A0=A0=A0=A0I/O ports at 1c00 [size=3D8]
=A0=A0=A0=A0=A0=A0=A0=A0I/O ports at 18d4 [size=3D4]
=A0=A0=A0=A0=A0=A0=A0=A0I/O ports at 18d8 [size=3D8]
=A0=A0=A0=A0=A0=A0=A0=A0I/O ports at 18d0 [size=3D4]
=A0=A0=A0=A0=A0=A0=A0=A0I/O ports at 18e0 [size=3D32]
=A0=A0=A0=A0=A0=A0=A0=A0Memory at fc604000 (32-bit, non-prefetchable) [size=
=3D2K]
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [80] Message Signalled Interrupts: Ma=
sk- 64bit- =

Queue=3D0/2 =

Enable+
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [70] Power Management version 3
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [a8] #12 [0010]

00:1f.3 0c05: 8086:283e (rev 03)
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: medium devsel, IRQ 19
=A0=A0=A0=A0=A0=A0=A0=A0Memory at 8c000000 (32-bit, non-prefetchable) [size=
=3D256]
=A0=A0=A0=A0=A0=A0=A0=A0I/O ports at 1c20 [size=3D32]

06:00.0 0280: 8086:4222 (rev 02)
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 8086:1051
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, fast devsel, latency 0, IRQ 10
=A0=A0=A0=A0=A0=A0=A0=A0Memory at fa000000 (32-bit, non-prefetchable) [size=
=3D4K]
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [c8] Power Management version 2
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [d0] Message Signalled Interrupts: Ma=
sk- 64bit+ =

Queue=3D0/0 =

Enable-
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [e0] Express Legacy Endpoint IRQ 0
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [100] Advanced Error Reporting
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [140] Device Serial Number ba-8c-73-f=
f-ff-77-1b-00

08:00.0 0200: 11ab:4351 (rev 16)
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, fast devsel, latency 0, IRQ 218
=A0=A0=A0=A0=A0=A0=A0=A0Memory at fc200000 (64-bit, non-prefetchable) [size=
=3D16K]
=A0=A0=A0=A0=A0=A0=A0=A0I/O ports at 5000 [size=3D256]
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [48] Power Management version 2
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [50] Vital Product Data
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [5c] Message Signalled Interrupts: Ma=
sk- 64bit+ =

Queue=3D0/1 =

Enable+
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [e0] Express Legacy Endpoint IRQ 0
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [100] Advanced Error Reporting

09:03.0 0607: 104c:8039
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, medium devsel, latency 168, IRQ =
17
=A0=A0=A0=A0=A0=A0=A0=A0Memory at fc300000 (32-bit, non-prefetchable) [size=
=3D4K]
=A0=A0=A0=A0=A0=A0=A0=A0Bus: primary=3D09, secondary=3D0a, subordinate=3D0d=
, sec-latency=3D176
=A0=A0=A0=A0=A0=A0=A0=A0Memory window 0: 88000000-8bfff000 (prefetchable)
=A0=A0=A0=A0=A0=A0=A0=A0Memory window 1: 90000000-93fff000
=A0=A0=A0=A0=A0=A0=A0=A0I/O window 0: 00006000-000060ff
=A0=A0=A0=A0=A0=A0=A0=A0I/O window 1: 00006400-000064ff
=A0=A0=A0=A0=A0=A0=A0=A016-bit legacy interface ports at 0001

09:03.1 0c00: 104c:803a (prog-if 10 [OHCI])
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, medium devsel, latency 32, IRQ 16
=A0=A0=A0=A0=A0=A0=A0=A0Memory at fc302000 (32-bit, non-prefetchable) [size=
=3D2K]
=A0=A0=A0=A0=A0=A0=A0=A0Memory at fc304000 (32-bit, non-prefetchable) [size=
=3D16K]
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [44] Power Management version 2

09:03.2 0180: 104c:803b
=A0=A0=A0=A0=A0=A0=A0=A0Subsystem: 104d:9005
=A0=A0=A0=A0=A0=A0=A0=A0Flags: bus master, medium devsel, latency 57, IRQ 18
=A0=A0=A0=A0=A0=A0=A0=A0Memory at fc301000 (32-bit, non-prefetchable) [size=
=3D4K]
=A0=A0=A0=A0=A0=A0=A0=A0Capabilities: [44] Power Management version 2



***************************
/proc/asound/card0/codec#1:
***************************

Codec: Conexant ID 2c06
Address: 1
Vendor Id: 0x14f12c06
Subsystem Id: 0x104d1700
Revision Id: 0x100000
Modem Function Group: 0x2


***************************
/proc/asound/card0/codec#0 :
***************************
Codec: SigmaTel STAC9872AK
Address: 0
Vendor Id: 0x83847662
Subsystem Id: 0x104d2300
Revision Id: 0x100201
No Modem Function Group found
Default PCM:
=A0 =A0 rates [0x7e0]: 44100 48000 88200 96000 176400 192000
=A0 =A0 bits [0xe]: 16 20 24
=A0 =A0 formats [0x1]: PCM
Default Amp-In caps: ofs=3D0x00, nsteps=3D0x0f, stepsize=3D0x05, mute=3D1
Default Amp-Out caps: ofs=3D0x7f, nsteps=3D0x7f, stepsize=3D0x02, mute=3D1
Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
=A0 Amp-Out caps: N/A
=A0 Amp-Out vals: =A0[0x7f 0x7f]
=A0 Power: 0x0
Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
=A0 Amp-Out caps: N/A
=A0 Amp-Out vals: =A0[0xff 0xff]
=A0 Power: 0x0
Node 0x04 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
=A0 Amp-Out caps: N/A
=A0 Amp-Out vals: =A0[0xff 0xff]
=A0 Power: 0x0
Node 0x05 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
=A0 Amp-Out caps: N/A
=A0 Amp-Out vals: =A0[0x7f 0x7f]
=A0 Power: 0x0
Node 0x06 [Audio Input] wcaps 0x1d0541: Stereo
=A0 Power: 0x0
=A0 Connection: 1
=A0 =A0 =A00x07
Node 0x07 [Audio Selector] wcaps 0x300903: Stereo Amp-In
=A0 Amp-In caps: N/A
=A0 Amp-In vals: =A0[0x00 0x00]
=A0 Connection: 1
=A0 =A0 =A00x0e
Node 0x08 [Audio Input] wcaps 0x1d0541: Stereo
=A0 Power: 0x0
=A0 Connection: 1
=A0 =A0 =A00x09
Node 0x09 [Audio Selector] wcaps 0x300903: Stereo Amp-In
=A0 Amp-In caps: N/A
=A0 Amp-In vals: =A0[0x0c 0x0c]
=A0 Connection: 1
=A0 =A0 =A00x15
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
=A0 Pincap 0x08173c: IN OUT HP Detect
=A0 Pin Default 0x04214020: [Jack] HP Out at Ext Right
=A0 =A0 Conn =3D 1/8, Color =3D Green
=A0 Pin-ctls: 0xc0: OUT HP
=A0 Connection: 1
=A0 =A0 =A00x02
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
=A0 Pincap 0x0814: OUT Detect
=A0 Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
=A0 =A0 Conn =3D 1/8, Color =3D Black
=A0 Pin-ctls: 0x00:
=A0 Connection: 1
=A0 =A0 =A00x04
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
=A0 Pincap 0x0814: OUT Detect
=A0 Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
=A0 =A0 Conn =3D 1/8, Color =3D Black
=A0 Pin-ctls: 0x00:
=A0 Connection: 1
=A0 =A0 =A00x03
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
=A0 Pincap 0x08173c: IN OUT HP Detect
=A0 Pin Default 0x04a15030: [Jack] Mic at Ext Right
=A0 =A0 Conn =3D 1/8, Color =3D Red
=A0 Pin-ctls: 0x24: IN
=A0 Connection: 1
=A0 =A0 =A00x02
Node 0x0e [Pin Complex] wcaps 0x400081: Stereo
=A0 Pincap 0x0824: IN Detect
=A0 Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
=A0 =A0 Conn =3D 1/8, Color =3D Black
=A0 Pin-ctls: 0x20: IN
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
=A0 Pincap 0x0814: OUT Detect
=A0 Pin Default 0x90170110: [Fixed] Speaker at Int N/A
=A0 =A0 Conn =3D Analog, Color =3D Unknown
=A0 Pin-ctls: 0x40: OUT
=A0 Connection: 1
=A0 =A0 =A00x05
Node 0x10 [Audio Output] wcaps 0x40211: Stereo Digital
=A0 PCM:
=A0 =A0 rates [0x3e0]: 44100 48000 88200 96000 176400
=A0 =A0 bits [0xe]: 16 20 24
=A0 =A0 formats [0x5]: PCM AC3
Node 0x11 [Pin Complex] wcaps 0x400301: Stereo Digital
=A0 Pincap 0x0810: OUT
=A0 Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
=A0 =A0 Conn =3D 1/8, Color =3D Black
=A0 Pin-ctls: 0x00:
=A0 Connection: 2
=A0 =A0 =A00x10* 0x09
Node 0x12 [Audio Input] wcaps 0x140311: Stereo Digital
=A0 PCM:
=A0 =A0 rates [0x160]: 44100 48000 96000
=A0 =A0 bits [0xe]: 16 20 24
=A0 =A0 formats [0x5]: PCM AC3
=A0 Connection: 1
=A0 =A0 =A00x13
Node 0x13 [Pin Complex] wcaps 0x440381: Stereo Digital
=A0 Pincap 0x0834: IN OUT Detect
=A0 Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
=A0 =A0 Conn =3D 1/8, Color =3D Black
=A0 Pin-ctls: 0x00:
=A0 Connection: 1
=A0 =A0 =A00x18
Node 0x14 [Pin Complex] wcaps 0x400001: Stereo
=A0 Pincap 0x0820: IN
=A0 Pin Default 0x90a7013e: [Fixed] Mic at Int N/A
=A0 =A0 Conn =3D Analog, Color =3D Unknown
=A0 Pin-ctls: 0x20: IN
Node 0x15 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
=A0 Amp-Out caps: ofs=3D0x00, nsteps=3D0x04, stepsize=3D0x27, mute=3D1
=A0 Amp-Out vals: =A0[0x00 0x00]
=A0 Connection: 4
=A0 =A0 =A00x0a 0x0d* 0x14 0x02
Node 0x16 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
=A0 Amp-Out caps: ofs=3D0x03, nsteps=3D0x03, stepsize=3D0x17, mute=3D0
=A0 Amp-Out vals: =A0[0x00]
Node 0x17 [Volume Knob Widget] wcaps 0x600000: Mono
Node 0x18 [Audio Output] wcaps 0x40201: Stereo Digital

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
