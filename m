From: "Gary Metalle" <gary_metalle@hotmail.com>
Subject: EMU10KX/Dell PC
Date: Sat, 15 Oct 2005 20:13:13 +1300
Message-ID: <BAY18-F216663D96E337FEFE31CA1E57C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi.

I have a Dell PC with Creative Labs Live! Value motherboard sound support.

I've dumped the (verbose) output from lspci below, I hope it helps in some 
way:

[mythtv@localhost cards]$ /sbin/lspci -v -n
00:00.0 Class 0600: 8086:2570 (rev 02)
        Subsystem: 1028:0174
        Flags: bus master, fast devsel, latency 0
        Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Capabilities: <available only to root>

00:01.0 Class 0604: 8086:2571 (rev 02)
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        Memory behind bridge: fd000000-feafffff
        Prefetchable memory behind bridge: f0000000-f7ffffff

00:1d.0 Class 0c03: 8086:24d2 (rev 02)
        Subsystem: 1028:0174
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at ff80 [size=32]

00:1d.1 Class 0c03: 8086:24d4 (rev 02)
        Subsystem: 1028:0174
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at ff60 [size=32]

00:1d.2 Class 0c03: 8086:24d7 (rev 02)
        Subsystem: 1028:0174
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at ff40 [size=32]

00:1d.3 Class 0c03: 8086:24de (rev 02)
        Subsystem: 1028:0174
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at ff20 [size=32]

00:1d.7 Class 0c03: 8086:24dd (rev 02) (prog-if 20)
        Subsystem: 1028:0174
        Flags: bus master, medium devsel, latency 0, IRQ 5
        Memory at ffa80800 (32-bit, non-prefetchable) [size=1K]
        Capabilities: <available only to root>

00:1e.0 Class 0604: 8086:244e (rev c2)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fcf00000-fcffffff

00:1f.0 Class 0601: 8086:24d0 (rev 02)
        Flags: bus master, medium devsel, latency 0

00:1f.1 Class 0101: 8086:24db (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: 1028:0174
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at ffa0 [size=16]
        Memory at febffc00 (32-bit, non-prefetchable) [size=1K]

00:1f.2 Class 0101: 8086:24d1 (rev 02) (prog-if 8f [Master SecP SecO PriP 
PriO])
        Subsystem: 1028:0174
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 9
        I/O ports at fe00 [size=8]
        I/O ports at fe10 [size=4]
        I/O ports at fe20 [size=8]
        I/O ports at fe30 [size=4]
        I/O ports at fea0 [size=16]

00:1f.3 Class 0c05: 8086:24d3 (rev 02)
        Subsystem: 1028:0174
        Flags: medium devsel, IRQ 3
        I/O ports at efe0 [size=32]

01:00.0 Class 0300: 10de:0322 (rev a1)
        Subsystem: 10de:01b9
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at fea00000 [disabled] [size=128K]
        Capabilities: <available only to root>

02:00.0 Class 0c03: 1033:0035 (rev 41) (prog-if 10)
        Subsystem: 9710:0035
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at fcffd000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

02:00.1 Class 0c03: 1033:0035 (rev 41) (prog-if 10)
        Subsystem: 9710:0035
        Flags: bus master, medium devsel, latency 64, IRQ 5
        Memory at fcffe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

02:00.2 Class 0c03: 1033:00e0 (rev 02) (prog-if 20)
        Subsystem: 9710:1906
        Flags: bus master, medium devsel, latency 64, IRQ 5
        Memory at fcffcf00 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>

02:02.0 Class 0401: 1102:0006
        Subsystem: 1102:1003
        Flags: bus master, medium devsel, latency 64, IRQ 3
        I/O ports at df20 [size=32]
        Capabilities: <available only to root>

02:02.1 Class 0980: 1102:7004
        Subsystem: 1102:1003
        Flags: bus master, medium devsel, latency 64
        I/O ports at df18 [size=8]
        Capabilities: <available only to root>

02:08.0 Class 0200: 8086:1050 (rev 02)
        Subsystem: 1028:0174
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at fcfff000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at df40 [size=64]
        Capabilities: <available only to root>

[mythtv@localhost cards]$

_________________________________________________________________
Discover fun and games at  @  http://xtramsn.co.nz/kids



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
