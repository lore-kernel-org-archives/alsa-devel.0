From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000750]: no sound since 2.6.8.1
Date: Mon, 24 Jan 2005 04:10:02 +0100
Message-ID: <2e6990c945add90ff4ff57d01d1bbfe5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 75BBB21C
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2005 04:10:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=750> 
======================================================================
Reported By:                aquarichy
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   750
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware 10
Kernel Version:             2.6.9+
======================================================================
Date Submitted:             12-28-2004 02:20 CET
Last Modified:              01-24-2005 04:10 CET
======================================================================
Summary:                    no sound since 2.6.8.1
Description: 
Sound using a kernel.org 2.6.8.1 kernel with ALSA built-in worked.  When I
compile  any newer stable kernel, there is no sound.  Compilation executes
without complaints.  No Sound related options change.  I have even tried
saying No to all the new options 2.6.9 and .10 provided in fear that one
of those might be interfering, but nada.  
======================================================================

----------------------------------------------------------------------
 aquarichy - 01-03-05 20:30 
----------------------------------------------------------------------
dxs_support does not affect whether the driver works or not.  It does,
however, seem to eliminate some tinny noises when songs hit higher
volumes.
There is no sound without the ac97_quirk option.  It also affects the
volume controls I get in alsamixer, giving me back a headphone one, and
revealing a muted master one on control 1.  With the option set, I have
sound.

I will try to-days CVS later this evening, if that would help.  When I
tried to upload my 'asound.state's (one without the quirk and one with), I
got a PHP error :| after clicking upload.

My machine is an eMachine C2280 affectionately called 'Tourniquet'.
My motherboard is a L7VMM2: 
http://www.e4allinc.info/dir1/motherboards/socketa/l7vmm2.htm

--------------
'lspci -nv' output: 

00:00.0 Class 0600: 1106:3116
        Subsystem: 1019:0a85
        Flags: bus master, 66Mhz, medium devsel, latency 8
        Memory at e8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 Class 0604: 1106:b091
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: ec000000-edffffff
        Prefetchable memory behind bridge: e0000000-e7ffffff
        Capabilities: [80] Power Management version 2

00:0a.0 Class 0780: 14f1:2f00 (rev 01)
        Subsystem: 155d:8d8b
        Flags: bus master, medium devsel, latency 32, IRQ 12
        Memory at ee000000 (32-bit, non-prefetchable) [size=64K]
        I/O ports at d000 [size=8]
        Capabilities: [40] Power Management version 2

00:0e.0 Class 0200: 10ec:8139 (rev 10)
        Subsystem: 10ec:8139
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at d400 [size=256]
        Memory at ee010000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

00:10.0 Class 0c03: 1106:3038 (rev 80)
        Subsystem: 1019:0a85
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2

00:10.1 Class 0c03: 1106:3038 (rev 80)
        Subsystem: 1019:0a85
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2

00:10.2 Class 0c03: 1106:3038 (rev 80)
        Subsystem: 1019:0a85
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2

00:10.3 Class 0c03: 1106:3104 (rev 82) (prog-if 20)
        Subsystem: 1019:0a85
        Flags: bus master, medium devsel, latency 32, IRQ 21
        Memory at ee011000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

00:11.0 Class 0601: 1106:3177
        Subsystem: 1019:0a85
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:11.1 Class 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: 1019:0a85
        Flags: bus master, medium devsel, latency 32, IRQ 20
        I/O ports at e400 [size=16]
        Capabilities: [c0] Power Management version 2

00:11.5 Class 0401: 1106:3059 (rev 50)
        Subsystem: 1019:0a85
        Flags: medium devsel, IRQ 22
        I/O ports at e800 [size=256]
        Capabilities: [c0] Power Management version 2

01:00.0 Class 0300: 10de:0322 (rev a1)
        Subsystem: 1462:9309
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 16
        Memory at ec000000 (32-bit, non-prefetchable) [size=16M]
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 3.0

----------------------------------------------------------------------
 FrankS - 01-24-05 04:10 
----------------------------------------------------------------------
I have the same system, and am seeing the same problem on debian
distributions.  If I add a file to my /etc/modprobe.d that sets the
ac97_quirk=0 option, life is wonderful and there is sound.  I searched for
other files setting this option and found none.  I downloaded and compiled
other versions of the alsa drivers, for me  it broke between 1.0.5a and
1.0.6rc1 (kernel 2.6.7 ). I did not verify the fix on .6rc1, but I did on
.6a.  The fix worked on both MEPIS and Ubuntu beta releaes.  I have
several test partitions setup, and would be more than willing to test any
potential fixes and or run experiments.

Frank

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-04 02:20 aquarichy      New Issue                                    
12-28-04 02:20 aquarichy      Distribution              => Slackware 10    
12-28-04 02:20 aquarichy      Kernel Version            => 2.6.9+          
12-29-04 08:23 aquarichy      Note Added: 0002993                          
12-29-04 14:12 tiwai          Note Added: 0002996                          
12-29-04 19:02 aquarichy      Note Added: 0003007                          
12-29-04 19:17 aquarichy      Note Added: 0003008                          
12-29-04 19:37 aquarichy      Note Added: 0003009                          
12-29-04 20:39 aquarichy      Note Added: 0003011                          
12-29-04 20:46 rlrevell       Note Added: 0003012                          
12-30-04 00:07 aquarichy      Note Added: 0003015                          
12-30-04 06:05 aquarichy      Note Edited: 0003015                         
12-30-04 06:36 aquarichy      Note Added: 0003017                          
12-30-04 13:02 tiwai          Note Added: 0003018                          
12-31-04 06:30 aquarichy      Note Added: 0003024                          
01-03-05 12:07 tiwai          Note Added: 0003053                          
01-03-05 20:30 aquarichy      Note Added: 0003074                          
01-24-05 04:10 FrankS         Note Added: 0003389                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
