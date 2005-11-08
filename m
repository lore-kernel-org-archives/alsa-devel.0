From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001519]: dxs_support=5 result
Date: Tue, 8 Nov 2005 18:44:51 +0100
Message-ID: <8389eb57d3826e369de9cb758ab527fe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1B0C71C0
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2005 18:44:52 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1519> 
======================================================================
Reported By:                systemloc
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1519
Category:                   PCI - via82xx
Reproducibility:            N/A
Severity:                   text
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-31-2005 06:44 CET
Last Modified:              11-08-2005 18:44 CET
======================================================================
Summary:                    dxs_support=5 result
Description: 
On my hardware, dxs_support=5 worked just fine. I tested it playing both
48kHz and 44.1kHz sound. I used the driver built into the stock kernel
2.6.14. The chip is built into an MSI KT880 Delta-FSR.

lspci -nv:

00:00.0 Class 0600: 1106:0269
        Subsystem: 1106:0269
        Flags: bus master, 66Mhz, medium devsel, latency 8
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [80] AGP version 3.5
        Capabilities: [50] Power Management version 2

00:00.1 Class 0600: 1106:1269
        Subsystem: 1106:1269
        Flags: bus master, medium devsel, latency 0

00:00.2 Class 0600: 1106:2269
        Subsystem: 1106:2269
        Flags: bus master, medium devsel, latency 0

00:00.3 Class 0600: 1106:3269
        Subsystem: 1106:3269
        Flags: bus master, medium devsel, latency 0

00:00.4 Class 0600: 1106:4269
        Subsystem: 1106:4269
        Flags: bus master, medium devsel, latency 0

00:00.7 Class 0600: 1106:7269
        Subsystem: 1106:7269
        Flags: bus master, medium devsel, latency 0

00:01.0 Class 0604: 1106:b198
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: fca00000-feafffff
        Prefetchable memory behind bridge: bfe00000-cfefffff
        Capabilities: [70] Power Management version 2

00:08.0 Class 0200: 1317:0985 (rev 11)
        Subsystem: 1317:0570
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at d400 [size=256]
        Memory at febff400 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at febc0000 [disabled] [size=128K]
        Capabilities: [c0] Power Management version 2

00:0b.0 Class 0200: 1106:3119 (rev 11)
        Subsystem: 1462:0470
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 10
        I/O ports at d800 [size=256]
        Memory at febff800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

00:0f.0 Class 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: 1106:0571
        Flags: bus master, medium devsel, latency 32
        I/O ports at fc00 [size=16]
        Capabilities: [c0] Power Management version 2

00:10.0 Class 0c03: 1106:3038 (rev 81)
        Subsystem: 1462:0470
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2

00:10.1 Class 0c03: 1106:3038 (rev 81)
        Subsystem: 1462:0470
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2

00:10.2 Class 0c03: 1106:3038 (rev 81)
        Subsystem: 1462:0470
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at e400 [size=32]
        Capabilities: [80] Power Management version 2

00:10.3 Class 0c03: 1106:3038 (rev 81)
        Subsystem: 1462:0470
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at ec00 [size=32]
        Capabilities: [80] Power Management version 2

00:10.4 Class 0c03: 1106:3104 (rev 86) (prog-if 20)
        Subsystem: 1462:0470
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at febffc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

00:11.0 Class 0601: 1106:3227
        Subsystem: 1106:3227
        Flags: bus master, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:11.5 Class 0401: 1106:3059 (rev 60)
        Subsystem: 1462:0470
        Flags: medium devsel, IRQ 10
        I/O ports at e800 [size=256]
        Capabilities: [c0] Power Management version 2

01:00.0 Class 0300: 10de:0253 (rev a3)
        Subsystem: 107d:289f
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 11
        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Memory at c0000000 (32-bit, prefetchable) [size=128M]
        Memory at cfe80000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at feae0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0

lspci:

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0269
00:00.1 Host bridge: VIA Technologies, Inc.: Unknown device 1269
00:00.2 Host bridge: VIA Technologies, Inc.: Unknown device 2269
00:00.3 Host bridge: VIA Technologies, Inc.: Unknown device 3269
00:00.4 Host bridge: VIA Technologies, Inc.: Unknown device 4269
00:00.7 Host bridge: VIA Technologies, Inc.: Unknown device 7269
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:08.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet
10/100 model NC100 (rev 11)
00:0b.0 Ethernet controller: VIA Technologies, Inc.: Unknown device 3119
(rev 11)
00:0f.0 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
(rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
(rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
(rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
(rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800
South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti
4200] (rev a3)

======================================================================

----------------------------------------------------------------------
 tiwai - 11-08-05 18:44 
----------------------------------------------------------------------
Thanks, fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-31-05 06:44 systemloc      New Issue                                    
11-08-05 18:44 tiwai          Status                   new => resolved     
11-08-05 18:44 tiwai          Resolution               open => fixed       
11-08-05 18:44 tiwai          Assigned To               => tiwai           
11-08-05 18:44 tiwai          Note Added: 0006635                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
