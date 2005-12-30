From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001017]: Front panel headphone and mic inverted
Date: Fri, 30 Dec 2005 04:05:15 +0100
Message-ID: <aab1f7807ec7cfa7c4e04465ffbc031d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8E75819E
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 04:05:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1017> 
======================================================================
Reported By:                michele
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1017
Category:                   PCI - azx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-25-2005 19:38 CET
Last Modified:              12-30-2005 04:05 CET
======================================================================
Summary:                    Front panel headphone and mic inverted
Description: 
Using the CVS version (March 25 2005) I noticed that the headphone and the
mic jack have to be inverted (with respect to plug colors). This may
address the issue presented as "0000790: no sound with azx driver in
Realtek integrated sound chip". 

I've got a P5GD1 (i915) asus mainboard, with an ALC861 codec.

lspci:

0000:00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL
Processor to I/O Controller (rev 04)
0000:00:01.0 PCI bridge: Intel Corporation 915G/P/GV/GL/PL/910GL PCI
Express Root Port (rev 04)
0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 03)
0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 1 (rev 03)
0000:00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 2 (rev 03)
0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 03)
0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4 (rev 03)
0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3)
0000:00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC
Interface Bridge (rev 03)
0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) IDE Controller (rev 03)
0000:00:1f.2 IDE interface: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW)
SATA Controller (rev 03)
0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
SMBus Controller (rev 03)
0000:01:03.0 Unknown mass storage controller: Integrated Technology
Express, Inc. IT/ITE8212 Dual channel ATA RAID controller (PCI version
seems to be IT8212, embedded seems (rev 13)
0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit
Ethernet Controller (rev 15)
0000:04:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60
[Radeon X300 (PCIE)]
0000:04:00.1 Display controller: ATI Technologies Inc: Unknown device
5b70

lspci -nv  

0000:00:1b.0 Class 0403: 8086:2668 (rev 03)
        Subsystem: 1043:814e
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at d7cf4000 (64-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] #10 [0091]

The 1043:814e seems not to be listed in patch_realtek.c.

I also noticed that there is no "Master" volume control.

Thank you very much,

Michele


======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 04:05 
----------------------------------------------------------------------
Any improvement with later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-25-05 19:38 michele        New Issue                                    
12-30-05 04:05 rlrevell       Note Added: 0007199                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
