From: Issam Mehssani <gosam@menara.ma>
Subject: Correct model for intel-hda 82801H.
Date: Sat, 13 Jan 2007 22:43:26 +0000
Message-ID: <1168728206.29492.7.camel@issam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hi

I have a HP dc7700 comp, which includes an onboard intel hda 82801H
chipset. After building alsa-driver from mercurial, and testing various
configurations it seems that this chip works with the hp-bpc model.
If I don't pass this parameter I get sound only from the front
headphones jack. Now I get sound from the rear line out too, and it's
fine apart from one last little glitch.
On the volume control panel, the headphone switch controls the rear line
out, and sound is continuously outputted from (front)headphones.

here's lspci's output : 

00:00.0 0600: 8086:2990 (rev 02)
        Subsystem: 103c:2802
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:02.0 0300: 8086:2992 (rev 02) (prog-if 00 [VGA])
        Subsystem: 103c:2802
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at f0400000 (32-bit, non-prefetchable) [size=1M]
        Memory at e0000000 (64-bit, prefetchable) [size=256M]
        I/O ports at 1110 [size=8]
        Capabilities: [90] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable-
        Capabilities: [d0] Power Management version 2

00:03.0 0780: 8086:2994 (rev 02)
        Subsystem: 103c:2802
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at f0526900 (64-bit, non-prefetchable) [size=16]
        Capabilities: [50] Power Management version 3
        Capabilities: [8c] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-

00:03.2 0101: 8086:2996 (rev 02) (prog-if 85 [Master SecO PriO])
        Subsystem: 103c:2802
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 18
        I/O ports at 1118 [size=8]
        I/O ports at 1140 [size=4]
        I/O ports at 1120 [size=8]
        I/O ports at 1144 [size=4]
        I/O ports at 10e0 [size=16]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-

00:03.3 0700: 8086:2997 (rev 02) (prog-if 02 [16550])
        Subsystem: 103c:2802
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 17
        I/O ports at 1128 [size=8]
        Memory at f0524000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-

00:19.0 0200: 8086:104a (rev 02)
        Subsystem: 103c:2800
        Flags: bus master, fast devsel, latency 0, IRQ 222
        Memory at f0500000 (32-bit, non-prefetchable) [size=128K]
        Memory at f0525000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 1000 [size=32]
        Capabilities: [c8] Power Management version 2
        Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable+

00:1a.0 0c03: 8086:2834 (rev 02) (prog-if 00 [UHCI])
        Subsystem: 103c:2802
        Flags: bus master, medium devsel, latency 0, IRQ 20
        I/O ports at 1020 [size=32]

00:1a.1 0c03: 8086:2835 (rev 02) (prog-if 00 [UHCI])
        Subsystem: 103c:2802
        Flags: bus master, medium devsel, latency 0, IRQ 21
        I/O ports at 1040 [size=32]

00:1a.7 0c03: 8086:283a (rev 02) (prog-if 20 [EHCI])
        Subsystem: 103c:2802
        Flags: bus master, medium devsel, latency 0, IRQ 22
        Memory at f0526000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port

00:1b.0 0403: 8086:284b (rev 02)
        Subsystem: 103c:2802
        Flags: bus master, fast devsel, latency 0, IRQ 21
        Memory at f0520000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0

00:1c.0 0604: 8086:283f (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=20, subordinate=20, sec-latency=0
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable+
        Capabilities: [90] Subsystem: 103c:2802
        Capabilities: [a0] Power Management version 2

00:1d.0 0c03: 8086:2830 (rev 02) (prog-if 00 [UHCI])
        Subsystem: 103c:2802
        Flags: bus master, medium devsel, latency 0, IRQ 20
        I/O ports at 1060 [size=32]

00:1d.1 0c03: 8086:2831 (rev 02) (prog-if 00 [UHCI])
        Subsystem: 103c:2802
        Flags: bus master, medium devsel, latency 0, IRQ 21
        I/O ports at 1080 [size=32]

00:1d.7 0c03: 8086:2836 (rev 02) (prog-if 20 [EHCI])
        Subsystem: 103c:2802
        Flags: bus master, medium devsel, latency 0, IRQ 20
        Memory at f0526400 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port

00:1e.0 0604: 8086:244e (rev f2) (prog-if 01 [Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=07, subordinate=07, sec-latency=32
        Capabilities: [50] Subsystem: 103c:2802

00:1f.0 0601: 8086:2814 (rev 02)
        Subsystem: 103c:2802
        Flags: bus master, medium devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:1f.2 0101: 8086:2820 (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: 103c:2802
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 18
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at 10f0 [size=16]
        I/O ports at 1100 [size=16]
        Capabilities: [70] Power Management version 3



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
