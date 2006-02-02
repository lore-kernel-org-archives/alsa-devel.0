From: "Piotr A." =?iso-8859-2?Q?Fr=B1tczak?= <paf@toya.net.pl>
Subject: Request for help with snd-hda-intel ICH6 CMI9880
Date: Thu, 02 Feb 2006 21:07:15 +0100
Message-ID: <1138910835.9837.8.camel@localhost>
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

I have problem with below mentioned motherboard
http://www.gigabyte.pl/MotherBoard/Products/Products_Spec_GA-8I915P%
20Duo%20Pro.htm

sound input. I'm using it since the times of snd-azx module, but until
now I never had the need to use any external sound input, thus I wasn;t
aware I have a problem. I am unable to hear anything neither by
connecting the microphone nor by connecting my new tv-card to the
'cdrom-in' connector on the motherboard. It works on W2K or with another
card (snd-cmipci) - I usually use Gentoo, but I checked it on Fedora
Core 4 and OpenSuse 10.0 - same effect.
Please give me a hint how to fix this 
best regards
PiotrAF

uname -r
2.6.15-gentoo-r1

cat /proc/asound/cards
0 [Intel          ]: HDA-Intel - HDA Intel
                     HDA Intel at 0xec200000 irq 16
 # lspci -nv
00:00.0 0600: 8086:2580 (rev 04)
        Subsystem: 1458:2580
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:01.0 0604: 8086:2581 (rev 04)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: e8000000-e9ffffff
        Prefetchable memory behind bridge: e0000000-e7ffffff
        Capabilities: [88] #0d [0000]
        Capabilities: [80] Power Management version 2
        Capabilities: [90] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable-
        Capabilities: [a0] Express Root Port (Slot+) IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [140] Unknown (5)

00:1b.0 0403: 8086:2668 (rev 03)
        Subsystem: 1458:a005
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at ec200000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

00:1c.0 0604: 8086:2660 (rev 03)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1c.2 0604: 8086:2664 (rev 03)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        Memory behind bridge: ec100000-ec1fffff
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1c.3 0604: 8086:2666 (rev 03)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        Memory behind bridge: ec000000-ec0fffff
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
        Capabilities: [100] Virtual Channel
        Capabilities: [180] Unknown (5)

00:1d.0 0c03: 8086:2658 (rev 03)
        Subsystem: 1458:2658
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at b000 [size=32]

00:1d.1 0c03: 8086:2659 (rev 03)
        Subsystem: 1458:2659
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at b400 [size=32]

00:1d.2 0c03: 8086:265a (rev 03)
        Subsystem: 1458:265a
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at b800 [size=32]

00:1d.3 0c03: 8086:265b (rev 03)
        Subsystem: 1458:265a
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at bc00 [size=32]

00:1d.7 0c03: 8086:265c (rev 03) (prog-if 20)
        Subsystem: 1458:5006
        Flags: bus master, medium devsel, latency 0, IRQ 19
        Memory at ec204000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2

00:1e.0 0604: 8086:244e (rev d3) (prog-if 01)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
        Memory behind bridge: ea000000-ebffffff
        Capabilities: [50] #0d [0000]

00:1f.0 0601: 8086:2640 (rev 03)
        Flags: bus master, medium devsel, latency 0

00:1f.1 0101: 8086:266f (rev 03) (prog-if 8a)
        Subsystem: 1458:266f
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at f000 [size=16]

00:1f.2 0106: 8086:2652 (rev 03) (prog-if 01)
        Subsystem: 1458:b005
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 18
        I/O ports at d000 [size=8]
        I/O ports at d400 [size=4]
        I/O ports at d800 [size=8]
        I/O ports at dc00 [size=4]
        I/O ports at e000 [size=16]
        Memory at ec207000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [70] Power Management version 2

00:1f.3 0c05: 8086:266a (rev 03)
        Subsystem: 1458:266a
        Flags: medium devsel, IRQ 11
        I/O ports at 0500 [size=32]

01:00.0 0300: 1002:5b60
        Subsystem: 1458:2102
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        I/O ports at a000 [size=256]
        Memory at e9000000 (32-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at e8000000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Express Endpoint IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [100] Advanced Error Reporting

01:00.1 0380: 1002:5b70
        Subsystem: 1458:2103
        Flags: bus master, fast devsel, latency 0
        Memory at e9010000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Express Endpoint IRQ 0

03:00.0 0200: 14e4:1677 (rev 01)
        Subsystem: 1458:e000
        Flags: bus master, fast devsel, latency 0, IRQ 17
        Memory at ec100000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-
        Capabilities: [d0] Express Endpoint IRQ 0
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [13c] Virtual Channel

04:00.0 0200: 14e4:1677 (rev 01)
        Subsystem: 1458:e000
        Flags: bus master, fast devsel, latency 0, IRQ 18
        Memory at ec000000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-
        Capabilities: [d0] Express Endpoint IRQ 0
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [13c] Virtual Channel

05:00.0 0400: 14f1:8800 (rev 05)
        Subsystem: 107d:6611
        Flags: bus master, medium devsel, latency 32, IRQ 20
        Memory at ea000000 (32-bit, non-prefetchable) [size=16M]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2

05:07.0 0c00: 104c:8024 (prog-if 10)
        Subsystem: 1458:1000
        Flags: bus master, medium devsel, latency 32, IRQ 19
        Memory at eb004000 (32-bit, non-prefetchable) [size=2K]
        Memory at eb000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
