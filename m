From: Michael Ringe <Michael.Ringe@web.de>
Subject: intel_hda model parameter for Samsung Q35
Date: Wed, 03 Jan 2007 00:25:19 +0100
Message-ID: <459AE9DF.4050001@web.de>
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

Using the dribers included in Kernel 2.6.19
My hardware is a Samsung Q35 Pro (Intel Core 2 Duo T5500)

Loading snd_hda_intel without parameters produces strong high frequency noise.

I am now using model=3stack which works fine and also shows the SPDIF output
controls (I could not test  SPDIF, though).
Feel free to contact me for any further information.

--Michael

lspci -nv follows

00:00.0 0600: 8086:27a0 (rev 03)
        Subsystem: 144d:c504
        Flags: bus master, fast devsel, latency 0
        Capabilities: <access denied>

00:02.0 0300: 8086:27a2 (rev 03)
        Subsystem: 144d:c504
        Flags: bus master, fast devsel, latency 0, IRQ 17
        Memory at d8100000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at 1800 [size=8]
        Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Memory at d8200000 (32-bit, non-prefetchable) [size=256K]
        Capabilities: <access denied>

00:02.1 0380: 8086:27a6 (rev 03)
        Subsystem: 144d:c504
        Flags: fast devsel
        Memory at d8180000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: <access denied>

00:1b.0 0403: 8086:27d8 (rev 02)
        Subsystem: 144d:c504
        Flags: bus master, fast devsel, latency 0, IRQ 19
        Memory at d8240000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: <access denied>

00:1c.0 0604: 8086:27d0 (rev 02)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: d4000000-d5ffffff
        Prefetchable memory behind bridge: 00000000d0000000-00000000d1f00000
        Capabilities: <access denied>

00:1c.1 0604: 8086:27d2 (rev 02)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=04, sec-latency=0
        Capabilities: <access denied>

00:1d.0 0c03: 8086:27c8 (rev 02)
        Subsystem: 144d:c504
        Flags: bus master, medium devsel, latency 0, IRQ 22
        I/O ports at 1820 [size=32]

00:1d.1 0c03: 8086:27c9 (rev 02)
        Subsystem: 144d:c504
        Flags: bus master, medium devsel, latency 0, IRQ 23
        I/O ports at 1840 [size=32]

00:1d.2 0c03: 8086:27ca (rev 02)
        Subsystem: 144d:c50400:1d.3 0c03: 8086:27cb (rev 02)
        Subsystem: 144d:c504
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at 1880 [size=32]

00:1d.7 0c03: 8086:27cc (rev 02) (prog-if 20)
        Subsystem: 144d:c504
        Flags: bus master, medium devsel, latency 0, IRQ 22
        Memory at d8444000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: <access denied>

00:1e.0 0604: 8086:2448 (rev e2) (prog-if 01)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=05, subordinate=09, sec-latency=32
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: d8000000-d80fffff
        Prefetchable memory behind bridge: 0000000050000000-0000000051f00000
        Capabilities: <access denied>

00:1f.0 0601: 8086:27b9 (rev 02)
        Subsystem: 144d:c504
        Flags: bus master, medium devsel, latency 0
        Capabilities: <access denied>

00:1f.1 0101: 8086:27df (rev 02) (prog-if 8a)
        Subsystem: 144d:c504
        Flags: bus master, medium devsel, latency 0, IRQ 20
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 1810 [size=16]

00:1f.3 0c05: 8086:27da (rev 02)
        Subsystem: 144d:c504
        Flags: medium devsel, IRQ 23
        I/O ports at 18a0 [size=32]

02:00.0 0280: 8086:4222 (rev 02)
        Subsystem: 8086:1001
        Flags: bus master, fast devsel, latency 0, IRQ 17
        Memory at d4000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <access denied>

05:05.0 0200: 14e4:170c (rev 02)05:09.0 0607: 1180:0476 (rev b4)
        Subsystem: 144d:c504
        Flags: bus master, medium devsel, latency 168, IRQ 18
        Memory at d8004000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=05, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 50000000-51fff000 (prefetchable)
        Memory window 1: 52000000-53fff000
        I/O window 0: 00003000-000030ff
        I/O window 1: 00003400-000034ff
        16-bit legacy interface ports at 0001

05:09.1 0c00: 1180:0552 (rev 09) (prog-if 10)
        Subsystem: 144d:c024
        Flags: bus master, medium devsel, latency 64, IRQ 21
        Memory at d8002000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: <access denied>

05:09.2 0805: 1180:0822 (rev 18)
        Subsystem: 144d:c024
        Flags: bus master, medium devsel, latency 64, IRQ 19
        Memory at d8002800 (32-bit, non-prefetchable) [size=256]
        Capabilities: <access denied>

05:09.3 0880: 1180:0843
        Subsystem: 144d:c024
        Flags: medium devsel, IRQ 255
        Memory at d8002c00 (32-bit, non-prefetchable) [disabled] [size=256]
        Capabilities: <access denied>

05:09.4 0880: 1180:0592 (rev 09)
        Subsystem: 144d:c024
        Flags: medium devsel, IRQ 255
        Memory at d8003000 (32-bit, non-prefetchable) [disabled] [size=256]
        Capabilities: <access denied>

05:09.5 0880: 1180:0852 (rev 04)
        Subsystem: 144d:c024
        Flags: medium devsel, IRQ 255
        Memory at d8003400 (32-bit, non-prefetchable) [disabled] [size=256]
        Capabilities: <access denied>

        Subsystem: 144d:c504
        Flags: bus master, fast devsel, latency 32, IRQ 19
        Memory at d8000000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: <access denied>

        Flags: bus master, medium devsel, latency 0, IRQ 20
        I/O ports at 1860 [size=32]


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
