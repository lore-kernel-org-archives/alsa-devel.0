From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001036]: Replacement SB Live card not detected
Date: Tue, 5 Apr 2005 10:20:16 +0200
Message-ID: <f40cf719851a3a1b130f2bad526fbbe5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DA0411D8
	for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2005 10:20:16 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1036> 
======================================================================
Reported By:                grolschie
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1036
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.3
======================================================================
Date Submitted:             04-05-2005 02:10 CEST
Last Modified:              04-05-2005 10:20 CEST
======================================================================
Summary:                    Replacement SB Live card not detected
Description: 
Hi there.

I have been using my SB Live Value PCI for over a year with ALSA with no
problems. I recently swapped the card for a newer SB Live 5.1 DE PCI card.
Even though these cards are pretty much the same, alsaconf cannot detect
any supported sound cards. lspci shows that the new card is indeed
detected.

Regards,
grolschie
======================================================================

----------------------------------------------------------------------
 grolschie - 04-05-05 08:55 
----------------------------------------------------------------------
> lspci -n

0000:00:00.0 0600: 1106:3116
0000:00:01.0 0604: 1106:b091
0000:00:09.0 0401: 1102:0002 (rev 0a)
0000:00:09.1 0980: 1102:7002 (rev 0a)
0000:00:11.0 0601: 1106:3074
0000:00:11.1 0101: 1106:0571 (rev 06)
0000:00:11.2 0c03: 1106:3038 (rev 1b)
0000:00:11.3 0c03: 1106:3038 (rev 1b)
0000:00:11.4 0c03: 1106:3038 (rev 1b)
0000:00:12.0 0200: 1106:3065 (rev 70)
0000:01:00.0 0300: 1002:4242
0000:01:00.1 0604: 1002:4243
0000:02:00.0 0c00: 11c1:5811 (rev 04)

> lspci -v
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8375 [KM266/KL266] Host
Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Flags: bus master, medium devsel, latency 8
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
(prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: dfd00000-dfefffff
	Prefetchable memory behind bridge: cfa00000-dfbfffff
	Capabilities: [80] Power Management version 2

0000:00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1
(rev 0a)
	Subsystem: Creative Labs: Unknown device 8067
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at e800 [size=32]
	Capabilities: [dc] Power Management version 1

0000:00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game
Port (rev 0a)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 32
	I/O ports at ec00 [size=8]
	Capabilities: [dc] Power Management version 1

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

0000:00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if
8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
	Flags: bus master, medium devsel, latency 32, IRQ 255
	I/O ports at fc00 [size=16]
	Capabilities: [c0] Power Management version 2

0000:00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 1b) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 1b) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at e000 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:11.4 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 1b) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at e400 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]
(rev 70)
	Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded Ethernet
Controller on VT8235
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at d800 [size=256]
	Memory at dfffff00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2

0000:01:00.0 VGA compatible controller: ATI Technologies Inc R200 BB
[Radeon All in Wonder 8500DV] (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Radeon 8500 AIW DV Edition
	Flags: bus master, stepping, 66MHz, medium devsel, latency 255, IRQ 11
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	I/O ports at c800 [size=256]
	Memory at dfee0000 (32-bit, non-prefetchable) [size=128K]
	Memory at dfed0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at dfea0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2

0000:01:00.1 PCI bridge: ATI Technologies Inc: Unknown device 4243
(prog-if 00 [Normal decode])
	Flags: bus master, stepping, 66MHz, medium devsel, latency 32
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=32
	Memory behind bridge: dfd00000-dfdfffff
	Prefetchable memory behind bridge: cfa00000-cfafffff
	Capabilities: [50] Power Management version 2

0000:02:00.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 04)
(prog-if 10 [OHCI])
	Subsystem: ATI Technologies Inc: Unknown device 5811
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at dfdff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2


===

hmmm.... "Creative Labs: Unknown device 8067"

----------------------------------------------------------------------
 pzad - 04-05-05 10:20 
----------------------------------------------------------------------
This can by sb live (c) 2003 with STAC9758. Some older alsa versions had
bug for this card - card was sillent. And proper support was added in alsa
1.0.5.

kernel 2.6.3 contains old alsa. Try to upgrade to never alsa.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-05-05 02:10 grolschie      New Issue                                    
04-05-05 02:10 grolschie      Distribution              => Debian          
04-05-05 02:10 grolschie      Kernel Version            => 2.6.3           
04-05-05 02:12 grolschie      Note Added: 0004333                          
04-05-05 08:30 pzad           Note Added: 0004334                          
04-05-05 08:55 grolschie      Note Added: 0004335                          
04-05-05 10:20 pzad           Note Added: 0004336                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
