From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001123]: No Sound on snd-via82xx
Date: Wed, 25 May 2005 14:29:54 +0200
Message-ID: <1798a6ebfd600065d51f51d6cc2ae099@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 58BD9189
	for <alsa-devel@alsa-project.org>; Wed, 25 May 2005 14:29:54 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1123> 
======================================================================
Reported By:                fingolfin
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1123
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware 10.0
Kernel Version:             2.6.10 and up
======================================================================
Date Submitted:             05-24-2005 14:30 CEST
Last Modified:              05-25-2005 14:29 CEST
======================================================================
Summary:                    No Sound on snd-via82xx
Description: 
In the most recent kernel revisions, sound for a VIA sound card no
longer works, except from the CD drive's direct connection to the sound
card (i.e., no more ogg123, sox, xmms, etc.). I have tried the stock
kernel 2.6.10 on OpenTLE 7.0.1 (Waghor Lite) and compiled 2.6.11.10 on
Slackware. In neither case did sound on my VIA work. However, stock
kernel on Ubuntu Warty (2.6.8.1) and compiled 2.6.7 on Slackware were
effective.

I have tried different options for ac97_quirk and dxs_support, all to no
avail.

I understand that the alsa suite is going under major changes for new
functionality and support coming up to the 1.1 release and I appreciate
the tremendous effort going into it. I also understand that the via
driver's development has been difficult. Nevertheless I am now forced to
use the old OSS drivers. :)

Output of lspci -v on Slackware, 2.6.11.10

00:00.0 Host bridge: VIA Technologies, Inc. VT8378 [KM400] Chipset Host
Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Flags: bus master, 66Mhz, medium devsel, latency 8
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [80] AGP version 3.5
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00
[Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: dde00000-dfefffff
	Prefetchable memory behind bridge: d5d00000-ddcfffff
	Capabilities: [80] Power Management version 2

00:10.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
(rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at e400 [size=32]
	Capabilities: [80] Power Management version 2

00:10.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
(rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at e800 [size=32]
	Capabilities: [80] Power Management version 2

00:10.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
(rev 80) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at ec00 [size=32]
	Capabilities: [80] Power Management version 2

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if
20 [EHCI])
	Subsystem: VIA Technologies, Inc. USB 2.0
	Flags: bus master, medium devsel, latency 32, IRQ 10
	Memory at dfffff00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
	Flags: bus master, medium devsel, latency 32, IRQ 255
	I/O ports at fc00 [size=16]
	Capabilities: [c0] Power Management version 2

00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
	Subsystem: Elitegroup Computer Systems: Unknown device a101
	Flags: medium devsel, IRQ 5
	I/O ports at dc00 [size=256]
	Capabilities: [c0] Power Management version 2

00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97
Modem] (rev 80)
	Subsystem: SILICON Laboratories: Unknown device 4c21
	Flags: medium devsel, IRQ 5
	I/O ports at e000 [size=256]
	Capabilities: [d0] Power Management version 2

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev
74)
	Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded Ethernet
Controller on VT8235
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at d800 [size=256]
	Memory at dffffe00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2

01:00.0 VGA compatible controller: VIA Technologies, Inc. VT8378 [S3
UniChrome] Integrated Video (rev 01) (prog-if 00 [VGA])
	Subsystem: VIA Technologies, Inc.: Unknown device 0000
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
	Memory at d8000000 (32-bit, prefetchable) [size=64M]
	Memory at de000000 (32-bit, non-prefetchable) [size=16M]
	Expansion ROM at dfef0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
	Capabilities: [70] AGP version 2.0

There is no difference between that and lspci -v on 2.6.7 under
Slackware, which leads me to believe nothing like the new ACPI IRQ
routing or other low-level code is to blame. Instead (though I am not a
kernel developer and submit my advice, well, humbly), I suggest
examination of the differences between the earlier and later drivers 
for the via series.

======================================================================

----------------------------------------------------------------------
 fingolfin - 05-25-05 14:29 
----------------------------------------------------------------------
My mistake. I compiled 1.0.9rc4 from tarballs and I succeeded. Perhaps I
ineptly built from CVS...I remember the CVS build script as being a
little imperfect (I'm not faulting you there, it /is/ a CVS build after
all) and I tried to take over manually. I might have erred somewhere
along the way.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-05 14:30 fingolfin      New Issue                                    
05-24-05 14:30 fingolfin      Distribution              => Slackware 10.0  
05-24-05 14:30 fingolfin      Kernel Version            => 2.6.10 and up   
05-25-05 14:29 fingolfin      Note Added: 0004736                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
