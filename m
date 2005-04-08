From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001033]: hda sound 82801FB/FBM/FR/FW/FRW (ICH6 Family)
Date: Fri, 8 Apr 2005 21:08:24 +0200
Message-ID: <354cda0103910d68ea05e73da5cd6232@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E8CEE24F
	for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2005 21:08:24 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1033> 
======================================================================
Reported By:                sjankie
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1033
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.11.6
======================================================================
Date Submitted:             04-03-2005 15:07 CEST
Last Modified:              04-08-2005 21:08 CEST
======================================================================
Summary:                    hda sound 82801FB/FBM/FR/FW/FRW (ICH6 Family)
Description: 
0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)

azx driver compliens about: NO AFG found.

alsmixer starts, but no sound.
======================================================================

----------------------------------------------------------------------
 Thomas - 04-05-05 19:50 
----------------------------------------------------------------------
Same problem here. Modules loaded but no sound.
I tried all models (even cmi while my card is supposed to be a realtek
ALC880.)
tested with 1.0.8, 1.0.9rc2, cvs.

lspci -v output:
0000:00:1b.0 Class 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family)
High Definition Audio Controller (rev 04)
        Subsystem: Rioworks: Unknown device 203d
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at 80000000 (64-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70]
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=10 [0091]

lspci -vn:
0000:00:1b.0 Class 0403: 8086:2668 (rev 04)
        Subsystem: 161f:203d


dmesg output:
ALSA
/root/install/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:552:
codec_mask = 0x3
ALSA
/root/install/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:511:
hda_codec: no AFG node found

I'll provide any additional informations required.

----------------------------------------------------------------------
 Thomas - 04-08-05 21:08 
----------------------------------------------------------------------
After some tweakings (don't ask me exactly what I did, I changed lots of
stuff), I've got it working.

Some problems though. Headphone and my laptop speaker are not working.
"Front" output works but there is lot of noise.
"Surround" "Center/LFE" don't work. It might be normal as "Front" is not
plugged.

I can't test inputs.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-03-05 15:07 sjankie        New Issue                                    
04-03-05 15:07 sjankie        Kernel Version            => 2.6.11.6        
04-03-05 15:08 sjankie        Issue Monitored: sjankie                     
04-03-05 15:08 sjankie        Issue End Monitor: sjankie                    
04-03-05 15:08 sjankie        Issue Monitored: sjankie                     
04-04-05 17:09 1g0R           Note Added: 0004328                          
04-05-05 14:52 sjankie        Note Added: 0004337                          
04-05-05 18:48 Thomas         Issue Monitored: Thomas                      
04-05-05 19:50 Thomas         Note Added: 0004339                          
04-08-05 21:08 Thomas         Note Added: 0004373                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
