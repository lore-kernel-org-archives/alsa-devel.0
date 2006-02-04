From: Brian Morrison <bdm@fenrir.org.uk>
Subject: VIA82xx dxs_support=5 success report
Date: Sat, 4 Feb 2006 20:33:05 +0000
Message-ID: <20060204203305.4c16ab82@peterson.fenrir.org.uk>
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

I've just updated my Fujitsu-Siemens Amilo L7300 laptop to the latest
Fedora Core 4 kernel (2.6.15.2 based) 2.6.15-1.1830_FC4 and added
dxs_support=5 to /etc/modprobe.conf. I can confirm that ALSA audio seems
fine using 44.1kHz sampling rate mp3 and ogg files from xmms, so I
thought it would help to report it here. I'm not subscribed to the
list, so any queries please by email if necessary.

Appended below is the output from lspci and lspci -nv, I've included all
of it in case it's needed but I assume that device 00:11.5 is the
important part of it:

00:00.0 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.7 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:06.0 Network controller: RaLink Ralink RT2500 802.11 Cardbus Reference Card (rev 01)
00:0c.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller (rev 01)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem Controller (rev 80)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
01:00.0 VGA compatible controller: VIA Technologies, Inc. S3 Unichrome Pro VGA Adapter (rev 02)


00:00.0 Class 0600: 1106:0259
	Subsystem: 1106:0259
	Flags: bus master, 66Mhz, medium devsel, latency 8
	Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [80] AGP version 3.5
	Capabilities: [50] Power Management version 2

00:00.1 Class 0600: 1106:1259
	Flags: bus master, medium devsel, latency 0

00:00.2 Class 0600: 1106:2259
	Flags: bus master, medium devsel, latency 0

00:00.3 Class 0600: 1106:3259
	Flags: bus master, medium devsel, latency 0

00:00.4 Class 0600: 1106:4259
	Flags: bus master, medium devsel, latency 0

00:00.7 Class 0600: 1106:7259
	Flags: bus master, medium devsel, latency 0

00:01.0 Class 0604: 1106:b198
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: d1000000-d1ffffff
	Prefetchable memory behind bridge: f0000000-f3ffffff
	Capabilities: [70] Power Management version 2

00:06.0 Class 0280: 1814:0201 (rev 01)
	Subsystem: 1814:2560
	Flags: bus master, slow devsel, latency 64, IRQ 11
	Memory at d0002000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2

00:0c.0 Class 0607: 1524:1410 (rev 01)
	Subsystem: 1734:1078
	Flags: bus master, medium devsel, latency 168, IRQ 10
	Memory at 24000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 20000000-21fff000 (prefetchable)
	Memory window 1: 22000000-23fff000
	I/O window 0: 00002000-000020ff
	I/O window 1: 00002400-000024ff
	16-bit legacy interface ports at 0001

00:10.0 Class 0c03: 1106:3038 (rev 80)
	Subsystem: 1106:3038
	Flags: bus master, medium devsel, latency 64, IRQ 7
	I/O ports at 1020 [size=32]
	Capabilities: [80] Power Management version 2

00:10.1 Class 0c03: 1106:3038 (rev 80)
	Subsystem: 1106:3038
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at 1040 [size=32]
	Capabilities: [80] Power Management version 2

00:10.3 Class 0c03: 1106:3104 (rev 82) (prog-if 20)
	Subsystem: 1106:3104
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at d0000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2

00:11.0 Class 0601: 1106:3177
	Subsystem: 1106:3177
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:11.1 Class 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: 1734:1078
	Flags: bus master, medium devsel, latency 64, IRQ 7
	I/O ports at 1000 [size=16]
	Capabilities: [c0] Power Management version 2

00:11.5 Class 0401: 1106:3059 (rev 50)
	Subsystem: 1734:1078
	Flags: medium devsel, IRQ 11
	I/O ports at 1400 [size=256]
	Capabilities: [c0] Power Management version 2

00:11.6 Class 0780: 1106:3068 (rev 80)
	Subsystem: 1734:1078
	Flags: medium devsel, IRQ 11
	I/O ports at 1800 [size=256]
	Capabilities: [d0] Power Management version 2

00:12.0 Class 0200: 1106:3065 (rev 74)
	Subsystem: 1734:1078
	Flags: bus master, medium devsel, latency 64, IRQ 7
	I/O ports at 1c00 [size=256]
	Memory at d0000400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2

01:00.0 Class 0300: 1106:3118 (rev 02)
	Subsystem: 1734:1078
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 7
	Memory at f0000000 (32-bit, prefetchable) [size=64M]
	Memory at d1000000 (32-bit, non-prefetchable) [size=16M]
	Capabilities: [60] Power Management version 2
	Capabilities: [70] AGP version 2.0

-- 

Brian Morrison

bdm at fenrir dot org dot uk

GnuPG key ID DE32E5C5 - http://wwwkeys.uk.pgp.net/pgpnet/wwwkeys.html


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
