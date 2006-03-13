From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001816]: identify alc880 chip on Aopen i915GMm-HFS motherboard
Date: Mon, 13 Mar 2006 15:21:37 +0100
Message-ID: <fe5dcc11dd5bf81bc943fd4c88756325@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5F49318C
	for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2006 15:21:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1816> 
======================================================================
Reported By:                kylecronan
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1816
Category:                   PCI - hda-intel
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-03-2006 21:26 CET
Last Modified:              03-13-2006 15:21 CET
======================================================================
Summary:                    identify alc880 chip on Aopen i915GMm-HFS
motherboard
Description: 
This motherboard has the Realtek ALC880 chip, but it is not recognized.  I
used lspci -n to get the PCI ID of the audio subsystem, then edited
patch_realtek.c as follows:

--- patch_realtek.c~    2006-02-02 22:29:54.000000000 -0800
+++ patch_realtek.c     2006-02-02 22:29:54.000000000 -0800
@@ -989,7 +989,7 @@
        { .pci_vendor = 0x8086, .pci_device = 0xd401, .config =
ALC880_5ST_DIG },
        { .pci_vendor = 0x8086, .pci_device = 0xa100, .config =
ALC880_5ST_DIG },
        { .pci_vendor = 0x1565, .pci_device = 0x8202, .config =
ALC880_5ST_DIG },
+       { .pci_vendor = 0xa0a0, .pci_device = 0x0560, .config =
ALC880_5ST_DIG },

        { .modelname = "w810", .config = ALC880_W810 },
        { .pci_vendor = 0x161f, .pci_device = 0x203d, .config =
ALC880_W810 },

I'm not sure that I've done this properly, but I now see an IEC958 option
in alsamixer.  I don't have any S/PDIF equipment to test it out with right
now, but there's red laser light coming out the back of my machine!

======================================================================

----------------------------------------------------------------------
 tiwai - 03-13-06 15:21 
----------------------------------------------------------------------
Fixed on CVS.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-06 21:26 kylecronan     New Issue                                    
03-13-06 15:21 tiwai          Status                   assigned => resolved
03-13-06 15:21 tiwai          Resolution               open => fixed       
03-13-06 15:21 tiwai          Note Added: 0008444                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
