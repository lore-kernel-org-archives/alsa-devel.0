From: Arthur Smith <asmith@smithhikers.net>
Subject: dxs_support=5 works for this motherboard's via82xx
Date: Sat, 01 Apr 2006 16:52:09 -0600
Message-ID: <442F0419.4020808@smithhikers.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030406040007090205050101"
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

This is a multi-part message in MIME format.
--------------030406040007090205050101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
  It works for me with dxs_support=5.The motherboard is an ECS K8T890-A. 
I've attached the requested lspci -nv output.

Thanks,
    Art Smith

--------------030406040007090205050101
Content-Type: text/plain;
 name="lspci.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.log"

00:00.0 0600: 1106:0238
	Subsystem: 1106:0238
	Flags: bus master, 66MHz, medium devsel, latency 8
	Memory at c4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [80] AGP version 3.0
	Capabilities: [50] Power Management version 2
	Capabilities: [60] HyperTransport: Slave or Primary Interface
	Capabilities: [58] HyperTransport: Interrupt Discovery and Configuration

00:00.1 0600: 1106:1238
	Subsystem: 1106:1238
	Flags: bus master, medium devsel, latency 0

00:00.2 0600: 1106:2238
	Subsystem: 1106:2238
	Flags: bus master, medium devsel, latency 0

00:00.3 0600: 1106:3238
	Subsystem: 1106:3238
	Flags: bus master, medium devsel, latency 0

00:00.4 0600: 1106:4238
	Subsystem: 1106:4238
	Flags: bus master, medium devsel, latency 0

00:00.5 0800: 1106:5238 (prog-if 20)
	Subsystem: 1106:5238
	Flags: bus master, fast devsel, latency 0

00:00.7 0600: 1106:7238
	Subsystem: 1106:7238
	Flags: bus master, medium devsel, latency 0

00:01.0 0604: 1106:b188
	Flags: bus master, 66MHz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Capabilities: [70] Power Management version 2

00:02.0 0604: 1106:a238
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [68] Power Management version 2
	Capabilities: [70] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel

00:03.0 0604: 1106:c238
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [68] Power Management version 2
	Capabilities: [70] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel

00:03.1 0604: 1106:d238
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [68] Power Management version 2
	Capabilities: [70] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel

00:03.2 0604: 1106:e238
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [68] Power Management version 2
	Capabilities: [70] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel

00:03.3 0604: 1106:f238
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [68] Power Management version 2
	Capabilities: [70] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel

00:05.0 0300: 1002:4242
	Subsystem: 1002:02aa
	Flags: bus master, stepping, 66MHz, medium devsel, latency 64, IRQ 19
	Memory at c8000000 (32-bit, prefetchable) [size=128M]
	I/O ports at e800 [size=256]
	Memory at febe0000 (32-bit, non-prefetchable) [size=128K]
	Memory at febd0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at feba0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2

00:05.1 0604: 1002:4243
	Flags: stepping, 66MHz, medium devsel
	Bus: primary=00, secondary=07, subordinate=07, sec-latency=64
	Memory behind bridge: fea00000-feafffff
	Capabilities: [50] Power Management version 2

00:09.0 0400: 109e:036e (rev 11)
	Subsystem: 0070:13eb
	Flags: bus master, medium devsel, latency 64, IRQ 21
	Memory at c3fff000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2

00:09.1 0480: 109e:0878 (rev 11)
	Subsystem: 0070:13eb
	Flags: bus master, medium devsel, latency 64, IRQ 21
	Memory at c3ffe000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2

00:0f.0 0104: 1106:3149 (rev 80)
	Subsystem: 1019:0022
	Flags: bus master, medium devsel, latency 64, IRQ 5
	I/O ports at ec00 [size=8]
	I/O ports at e400 [size=4]
	I/O ports at e000 [size=8]
	I/O ports at dc00 [size=4]
	I/O ports at d800 [size=16]
	I/O ports at d400 [size=256]
	Capabilities: [c0] Power Management version 2

00:0f.1 0101: 1106:0571 (rev 06) (prog-if 8a)
	Subsystem: 1019:0022
	Flags: bus master, medium devsel, latency 32, IRQ 22
	I/O ports at fc00 [size=16]
	Capabilities: [c0] Power Management version 2

00:10.0 0c03: 1106:3038 (rev 81)
	Subsystem: 1019:0022
	Flags: bus master, medium devsel, latency 64, IRQ 23
	I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2

00:10.1 0c03: 1106:3038 (rev 81)
	Subsystem: 1019:0022
	Flags: bus master, medium devsel, latency 64, IRQ 23
	I/O ports at cc00 [size=32]
	Capabilities: [80] Power Management version 2

00:10.2 0c03: 1106:3038 (rev 81)
	Subsystem: 1019:0022
	Flags: bus master, medium devsel, latency 64, IRQ 23
	I/O ports at c800 [size=32]
	Capabilities: [80] Power Management version 2

00:10.3 0c03: 1106:3038 (rev 81)
	Subsystem: 1019:0022
	Flags: bus master, medium devsel, latency 64, IRQ 23
	I/O ports at c400 [size=32]
	Capabilities: [80] Power Management version 2

00:10.4 0c03: 1106:3104 (rev 86) (prog-if 20)
	Subsystem: 1019:0022
	Flags: bus master, medium devsel, latency 64, IRQ 23
	Memory at febcfc00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2

00:11.0 0601: 1106:3227
	Subsystem: 1019:0022
	Flags: bus master, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:11.5 0401: 1106:3059 (rev 60)
	Subsystem: 1019:aa01
	Flags: medium devsel, IRQ 24
	I/O ports at c000 [size=256]
	Capabilities: [c0] Power Management version 2

00:12.0 0200: 1106:3065 (rev 78)
	Subsystem: 1106:0102
	Flags: bus master, medium devsel, latency 64, IRQ 20
	I/O ports at b800 [size=256]
	Memory at febcf800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2

00:18.0 0600: 1022:1100
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 0600: 1022:1101
	Flags: fast devsel

00:18.2 0600: 1022:1102
	Flags: fast devsel

00:18.3 0600: 1022:1103
	Flags: fast devsel

07:00.0 0c00: 11c1:5811 (rev 04) (prog-if 10)
	Subsystem: 1002:5811
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2


--------------030406040007090205050101--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
