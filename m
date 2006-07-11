From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001907]: Maestro3 driver does not work
	with Fedora Xen Kernels
Date: Tue, 11 Jul 2006 12:35:14 +0200
Message-ID: <0e0fc69af4b83e61a6598fe9ecea7ffb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 94C021A9
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 12:35:16 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
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
Status:                     resolved
Distribution:               Fedora Core 5 Test 3
Kernel Version:             kernel-xen0-2.6.15-1.2038_FC5
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-11-2006 02:29 CET
Last Modified:              07-11-2006 12:35 CEST
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
07-11-06 12:35 Adrian Bunk    Status                   assigned => resolved
07-11-06 12:35 Adrian Bunk    Resolution               open => not an issue
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
