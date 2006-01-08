From: Jean Delvare <khali@linux-fr.org>
Subject: snd-via82xx dxs_support report
Date: Sun, 8 Jan 2006 22:34:18 +0100
Message-ID: <20060108223418.7de0220f.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi all,

I just noticed that my kernel invites me to report to you the result of
some test on my system, so here we go. This is a custom Jetway K8M8MS
motherboard.

It has a VIA VT8237 chip, so I am using the snd-via82xx driver. I tried
loading the driver with dxs_support=5 as suggested, and everything
still works fine. I am able to play two 44.1 kHz media files with two
XMMS sessions concurently, and the sound quality is OK. In other
words, there are no differences for me between the default
(dxs_support=3) and dxs_support=5.

If there anything more you want to know, just tell me.

# lspci -vn
00:00.0 Class 0600: 1106:0204
	Subsystem: 1106:0204
	Flags: bus master, 66Mhz, medium devsel, latency 8
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: <available only to root>

00:00.1 Class 0600: 1106:1204
	Flags: bus master, medium devsel, latency 0

00:00.2 Class 0600: 1106:2204
	Flags: bus master, medium devsel, latency 0

00:00.3 Class 0600: 1106:3204
	Flags: bus master, medium devsel, latency 0

00:00.4 Class 0600: 1106:4204
	Flags: bus master, medium devsel, latency 0

00:00.7 Class 0600: 1106:7204
	Flags: bus master, medium devsel, latency 0

00:01.0 Class 0604: 1106:b188
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: f8000000-f80fffff
	Prefetchable memory behind bridge: e8000000-f7ffffff
	Capabilities: <available only to root>

00:08.0 Class 0400: 11de:6057 (rev 02)
	Subsystem: 1031:7efe
	Flags: fast devsel, IRQ 21
	Memory at f8114000 (32-bit, non-prefetchable) [size=4K]

00:0a.0 Class 0100: 1000:000f (rev 26)
	Subsystem: 1de1:3904
	Flags: bus master, medium devsel, latency 32, IRQ 20
	I/O ports at e000 [size=256]
	Memory at f8110000 (32-bit, non-prefetchable) [size=256]
	Memory at f8111000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 40000000 [disabled] [size=64K]
	Capabilities: <available only to root>

00:0b.0 Class 0200: 10ec:8139 (rev 10)
	Subsystem: 10ec:8139
	Flags: bus master, medium devsel, latency 32, IRQ 20
	I/O ports at e100 [size=256]
	Memory at f8112000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

00:0f.0 Class 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: 1106:0571
	Flags: bus master, medium devsel, latency 32, IRQ 17
	I/O ports at e200 [size=16]
	Capabilities: <available only to root>

00:10.0 Class 0c03: 1106:3038 (rev 81)
	Subsystem: 1106:3038
	Flags: bus master, medium devsel, latency 32, IRQ 19
	I/O ports at e300 [size=32]
	Capabilities: <available only to root>

00:10.1 Class 0c03: 1106:3038 (rev 81)
	Subsystem: 1106:3038
	Flags: bus master, medium devsel, latency 32, IRQ 19
	I/O ports at e400 [size=32]
	Capabilities: <available only to root>

00:10.2 Class 0c03: 1106:3038 (rev 81)
	Subsystem: 1106:3038
	Flags: bus master, medium devsel, latency 32, IRQ 19
	I/O ports at e500 [size=32]
	Capabilities: <available only to root>

00:10.3 Class 0c03: 1106:3038 (rev 81)
	Subsystem: 1106:3038
	Flags: bus master, medium devsel, latency 32, IRQ 19
	I/O ports at e600 [size=32]
	Capabilities: <available only to root>

00:10.4 Class 0c03: 1106:3104 (rev 86) (prog-if 20)
	Subsystem: 1106:3104
	Flags: bus master, medium devsel, latency 32, IRQ 19
	Memory at f8113000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

00:11.0 Class 0601: 1106:3227
	Subsystem: 1106:3227
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: <available only to root>

00:11.5 Class 0401: 1106:3059 (rev 60)
	Subsystem: 16f3:6405
	Flags: medium devsel, IRQ 18
	I/O ports at e700 [size=256]
	Capabilities: <available only to root>

00:18.0 Class 0600: 1022:1100
	Flags: fast devsel
	Capabilities: <available only to root>

00:18.1 Class 0600: 1022:1101
	Flags: fast devsel

00:18.2 Class 0600: 1022:1102
	Flags: fast devsel

00:18.3 Class 0600: 1022:1103
	Flags: fast devsel

01:00.0 Class 0300: 1002:5961 (rev 01)
	Subsystem: 17af:200c
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 16
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	I/O ports at d000 [size=256]
	Memory at f8030000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at f8000000 [disabled] [size=128K]
	Capabilities: <available only to root>

01:00.1 Class 0380: 1002:5941 (rev 01)
	Subsystem: 17af:200d
	Flags: 66Mhz, medium devsel
	Memory at f0000000 (32-bit, prefetchable) [disabled] [size=128M]
	Memory at f8020000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: <available only to root>

-- 
Jean Delvare


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
