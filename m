From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001298]: Creative Labs Sound Blaster Live! 24-bit not detected
Date: Mon, 1 Aug 2005 15:15:28 +0200
Message-ID: <9a7143a60265539e6bf828a8ae260b84@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 862931C9
	for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2005 15:15:28 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1298> 
======================================================================
Reported By:                andrewvegan
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1298
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.11-1.1369_FC4smp
======================================================================
Date Submitted:             08-01-2005 15:15 CEST
Last Modified:              08-01-2005 15:15 CEST
======================================================================
Summary:                    Creative Labs Sound Blaster Live! 24-bit not
detected
Description: 
Unable to get the sound card detected in Fedora Core 4. PC is a Shuttle XPC
SD31P which has an onboard "Creative Labs Sound Blaster Live! 24-bit EAX
high-definition 7.1 audio processor".

from dmesg:

AC'97 0 does not respond - RESET
AC'97 0 access is not valid [0x0], removing mixer.
CA0106: probe of 0000:03:0b.0 failed with error -5

When I run lspci it lists a different card (Creative Labs SB Audigy LS):
 
[root@localhost ~]# lspci
00:00.0 Host bridge: Intel Corporation Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corporation PCI Express Graphics Port (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC
Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 01)
00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family)
Serial ATA Storage Controllers cc=IDE (rev 01)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller
(rev 01)
01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce
6600] (rev a2)
02:00.0 Ethernet controller: Broadcom Corporation NetLink BCM5789
Gigabit Ethernet PCI Express (rev 11)
03:0a.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80)
03:0b.0 Multimedia audio controller: Creative Labs SB Audigy LS






======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-01-05 15:15 andrewvegan    New Issue                                    
08-01-05 15:15 andrewvegan    Distribution              => Fedora Core 4   
08-01-05 15:15 andrewvegan    Kernel Version            => 2.6.11-1.1369_FC4smp
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
