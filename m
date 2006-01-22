From: Matthew William Solloway Bell <m.w.s.bell@durham.ac.uk>
Subject: via82xx - dxs_support report
Date: Sun, 22 Jan 2006 14:50:37 +0000
Message-ID: <1137941438.8053.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

I have tested my sound chipset using dxs_support=5 as per the
Documentation. I tested the sound output using:
alsaplayer -F {22050, 32000, 42100, 48000} <file.mp3>
There was no audible hissing or crackling although, distortion was
present in all playbacks (resampling?). 

Matthew W. S. Bell

Here is a dump of the output form lspci -nv -s <sound device>:

0000:00:11.5 0401: 1106:3059 (rev 60)
	Subsystem: 1734:1093
	Flags: medium devsel, IRQ 50
	I/O ports at c800 [size=256]
	Capabilities: [c0] Power Management version 2

And here is the output of lspci -nv (Just in case, with sound device
removed):

0000:00:00.0 0600: 1106:0238
	Subsystem: 1734:1093
	Flags: bus master, 66MHz, medium devsel, latency 8
	Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [80] AGP version 3.0
	Capabilities: [50] Power Management version 2
	Capabilities: [60] #08 [0060]
	Capabilities: [58] #08 [8001]

0000:00:00.1 0600: 1106:1238
	Subsystem: 1734:1093
	Flags: bus master, medium devsel, latency 0

0000:00:00.2 0600: 1106:2238
	Subsystem: 1734:1093
	Flags: bus master, medium devsel, latency 0

0000:00:00.3 0600: 1106:3238
	Subsystem: 1734:1093
	Flags: bus master, medium devsel, latency 0

0000:00:00.4 0600: 1106:4238
	Subsystem: 1734:1093
	Flags: bus master, medium devsel, latency 0

0000:00:00.5 0800: 1106:5238 (prog-if 20)
	Subsystem: 1734:1093
	Flags: bus master, fast devsel, latency 0

0000:00:00.7 0600: 1106:7238
	Subsystem: 1734:1093
	Flags: bus master, medium devsel, latency 0

0000:00:01.0 0604: 1106:b999
	Flags: bus master, 66MHz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Capabilities: [70] Power Management version 2

0000:00:02.0 0604: 1106:a238
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00009000-0000bfff
	Memory behind bridge: fea00000-feafffff
	Prefetchable memory behind bridge: aff00000-bfefffff
	Capabilities: [40] #10 [0041]
	Capabilities: [68] Power Management version 2
	Capabilities: [70] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable+

0000:00:03.0 0604: 1106:c238
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	Capabilities: [40] #10 [0041]
	Capabilities: [68] Power Management version 2
	Capabilities: [70] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable+

0000:00:03.2 0604: 1106:e238
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	Capabilities: [40] #10 [0041]
	Capabilities: [68] Power Management version 2
	Capabilities: [70] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-

0000:00:08.0 0c00: 104c:8023 (prog-if 10)
	Subsystem: 1734:1093
	Flags: bus master, medium devsel, latency 64, IRQ 217
	Memory at febff800 (32-bit, non-prefetchable) [size=2K]
	Memory at febf8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2

0000:00:09.0 0200: 10ec:8169 (rev 10)
	Subsystem: 1734:1093
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 225
	I/O ports at e800 [size=256]
	Memory at febff400 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at febc0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

0000:00:0a.0 0280: 14e4:4318 (rev 02)
	Subsystem: 17f9:0006
	Flags: bus master, fast devsel, latency 64, IRQ 58
	Memory at febfc000 (32-bit, non-prefetchable) [size=8K]

0000:00:0f.0 0101: 1106:3149 (rev 80) (prog-if 8f [Master SecP SecO PriP
PriO])
	Subsystem: 1734:1093
	Flags: bus master, medium devsel, latency 64, IRQ 209
	I/O ports at ec00 [size=8]
	I/O ports at e480 [size=4]
	I/O ports at e400 [size=8]
	I/O ports at e080 [size=4]
	I/O ports at e000 [size=16]
	I/O ports at d800 [size=256]
	Capabilities: [c0] Power Management version 2

0000:00:0f.1 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: 1734:1093
	Flags: bus master, medium devsel, latency 32, IRQ 209
	I/O ports at fc00 [size=16]
	Capabilities: [c0] Power Management version 2

0000:00:10.0 0c03: 1106:3038 (rev 81)
	Subsystem: 1734:1093
	Flags: bus master, medium devsel, latency 64, IRQ 233
	I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.1 0c03: 1106:3038 (rev 81)
	Subsystem: 1734:1093
	Flags: bus master, medium devsel, latency 64, IRQ 233
	I/O ports at d480 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.2 0c03: 1106:3038 (rev 81)
	Subsystem: 1734:1093
	Flags: bus master, medium devsel, latency 64, IRQ 233
	I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.3 0c03: 1106:3038 (rev 81)
	Subsystem: 1734:1093
	Flags: bus master, medium devsel, latency 64, IRQ 233
	I/O ports at d080 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.4 0c03: 1106:3104 (rev 86) (prog-if 20)
	Subsystem: 1734:1093
	Flags: bus master, medium devsel, latency 64, IRQ 233
	Memory at febff000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2

0000:00:11.0 0601: 1106:3227
	Subsystem: 1734:1093
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

0000:00:11.6 0780: 1106:3068 (rev 80)
	Subsystem: 1734:1093
	Flags: medium devsel, IRQ 50
	I/O ports at c400 [size=256]
	Capabilities: [d0] Power Management version 2

0000:02:00.0 0300: 1002:5653
	Subsystem: 1734:1093
	Flags: bus master, fast devsel, latency 0, IRQ 66
	Memory at b0000000 (64-bit, prefetchable) [size=128M]
	Memory at feaf0000 (64-bit, non-prefetchable) [size=64K]
	I/O ports at b000 [size=256]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #10 [0001]
	Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
