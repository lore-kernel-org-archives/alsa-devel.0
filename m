From: LP <lasiodora@zonnet.nl>
Subject: Where to put dxs_support statement?
Date: Mon, 24 Jul 2006 13:20:19 +0200
Message-ID: <200607241320.19660.lasiodora@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
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

Hello there,

I don' t know where to put dxs_support=5.

Cheers,

Robert

-- Gentoo 2006.0
-- kernel-2.6.16-r13

00:00.0 0600: 1106:0259
        Subsystem: 1734:10ab
        Flags: bus master, 66MHz, medium devsel, latency 8
        Memory at a0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [80] AGP version 3.5
        Capabilities: [50] Power Management version 2

00:00.1 0600: 1106:1259
        Flags: bus master, medium devsel, latency 0

00:00.2 0600: 1106:2259
        Flags: bus master, medium devsel, latency 0

00:00.3 0600: 1106:3259
        Flags: bus master, medium devsel, latency 0

00:00.4 0600: 1106:4259
        Flags: bus master, medium devsel, latency 0

00:00.7 0600: 1106:7259
        Flags: bus master, medium devsel, latency 0

00:01.0 0604: 1106:b198
        Flags: bus master, 66MHz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: c0000000-cfffffff
        Prefetchable memory behind bridge: 90000000-9fffffff
        Capabilities: [70] Power Management version 2

00:06.0 0200: 168c:001a (rev 01)
        Subsystem: 168c:2052
        Flags: bus master, medium devsel, latency 168, IRQ 20
        Memory at 24000000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [44] Power Management version 2

00:09.0 0607: 1524:1410 (rev 01)
        Subsystem: 1734:10ab
        Flags: bus master, medium devsel, latency 64, IRQ 16
        Memory at 24010000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 20000000-21fff000 (prefetchable)
        Memory window 1: 22000000-23fff000 (prefetchable)
        I/O window 0: 00001800-000018ff
        I/O window 1: 00001c00-00001cff
        16-bit legacy interface ports at 0001

00:10.0 0c03: 1106:3038 (rev 80)
        Subsystem: 1734:10ab
        Flags: bus master, medium devsel, latency 22, IRQ 11
        I/O ports at 1200 [size=32]
        Capabilities: [80] Power Management version 2

00:10.1 0c03: 1106:3038 (rev 80)
        Subsystem: 1734:10ab
        Flags: bus master, medium devsel, latency 22, IRQ 7
        I/O ports at 1220 [size=32]
        Capabilities: [80] Power Management version 2

00:10.2 0c03: 1106:3038 (rev 80)
        Subsystem: 1734:10ab
        Flags: bus master, medium devsel, latency 22, IRQ 5
        I/O ports at 1240 [size=32]
        Capabilities: [80] Power Management version 2

00:10.3 0c03: 1106:3104 (rev 82) (prog-if 20)
        Subsystem: 1734:10ab
        Flags: bus master, medium devsel, latency 22, IRQ 10
        Memory at 24011000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

00:11.0 0601: 1106:3177
        Subsystem: 1734:10ab
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:11.1 0101: 1106:0571 (rev 06) (prog-if 8a)
        Subsystem: 1734:10ab
        Flags: bus master, stepping, medium devsel, latency 64, IRQ 18
        I/O ports at 1100 [size=16]
        Capabilities: [c0] Power Management version 2

00:11.5 0401: 1106:3059 (rev 50)
        Subsystem: 1734:10ab
        Flags: medium devsel, IRQ 19
        I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2

00:11.6 0780: 1106:3068 (rev 80)
        Subsystem: 1734:10ab
        Flags: medium devsel, IRQ 5
        I/O ports at e100 [size=256]
        Capabilities: [d0] Power Management version 2

00:12.0 0200: 1106:3065 (rev 74)
        Subsystem: 1734:10ab
        Flags: bus master, stepping, medium devsel, latency 128, IRQ 11
        I/O ports at e200 [size=256]
        Memory at d0000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2

01:00.0 0300: 1106:3118 (rev 02)
        Subsystem: 1734:10ab
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 17
        Memory at 90000000 (32-bit, prefetchable) [size=64M]
        Memory at c0000000 (32-bit, non-prefetchable) [size=16M]
        [virtual] Expansion ROM at 94000000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
        Capabilities: [70] AGP version 2.0

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
