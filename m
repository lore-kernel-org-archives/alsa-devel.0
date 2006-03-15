From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001907]: Maestro3 driver does not work with Fedora Xen Kernels
Date: Wed, 15 Mar 2006 14:06:55 +0100
Message-ID: <f7b2fa73c6a89fafc053468e5fa5d4db@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5E5F31FD
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2006 14:06:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1907> 
======================================================================
Reported By:                xaoslaad
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1907
Category:                   PCI - maestro3
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5 Test 3
Kernel Version:             kernel-xen0-2.6.15-1.2038_FC5
======================================================================
Date Submitted:             03-11-2006 02:29 CET
Last Modified:              03-15-2006 14:06 CET
======================================================================
Summary:                    Maestro3 driver does not work with Fedora Xen
Kernels
Description: 
maestro3.c contains the following check which causes the driver to fail to
work when using Fedora Xen0 kernels:

-----------------------------------------------------------------------------
        /* check, if we can restrict PCI DMA transfers to 28 bits */
        if (pci_set_dma_mask(pci, 0x0fffffff) < 0 ||
            pci_set_consistent_dma_mask(pci, 0x0fffffff) < 0) {
                snd_printk(KERN_ERR "architecture does not support 28bit
PCI busmaster DMA\n");
                pci_disable_device(pci);
                return -ENXIO;
        }
-----------------------------------------------------------------------------

Commenting out the lines:

                pci_disable_device(pci);
                return -ENXIO;

causes the driver to load and seemingly work properly.  Not sure what
negative impact removing this check can have.

======================================================================

----------------------------------------------------------------------
 chrisw - 03-14-06 04:46 
----------------------------------------------------------------------
File this under kernel-xen in Fedora Bugzilla (it's a Xen issue).  Also,
please include the dmesg from bootup.  It will show swiotlb info that's
useful.  Specifically, if the swiotlb is in use, and mapped up too high,
it won't be able to handle 28-bit dma mask.

----------------------------------------------------------------------
 xaoslaad - 03-15-06 14:06 
----------------------------------------------------------------------
Will file as you said, and leave the information you suggested.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-11-06 02:29 xaoslaad       New Issue                                    
03-11-06 02:29 xaoslaad       Distribution              => Fedora Core 5 Test 3
03-11-06 02:29 xaoslaad       Kernel Version            =>
kernel-xen0-2.6.15-1.2038_FC5
03-13-06 15:49 tiwai          Note Added: 0008448                          
03-14-06 04:46 chrisw         Note Added: 0008473                          
03-15-06 14:06 xaoslaad       Note Added: 0008547                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
