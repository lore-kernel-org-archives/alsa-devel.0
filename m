From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000616]: codec read/write timeout is reported on module load, and card is not detected
Date: Fri, 29 Oct 2004 17:09:47 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4a4ec11c31bd4f54449a25f3039e3b38@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 17F4326A
	for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2004 17:09:47 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=616> 
======================================================================
Reported By:                jcpetruzza
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   616
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.8-gentoo-r3
======================================================================
Date Submitted:             10-29-2004 17:09 CEST
Last Modified:              10-29-2004 17:09 CEST
======================================================================
Summary:                    codec read/write timeout is reported on module load,
and card is not detected
Description: 
My Ensoniq 1371 rev 7 based card is not detected.

dmesg shows:

PCI: Found IRQ 12 for device 0000:00:09.0
codec write timeout at 0xec14 [0x40000000]
es1371: codec read timeout at 0xec14 [0x40000000]
es1371: codec read timeout at 0xec14 [0x40000000]
es1371: codec read timeout at 0xec14 [0x40000000]
.
.
.
codec write timeout at 0xec14 [0x40000000]
es1371: codec read timeout at 0xec14 [0x40000000]
AC'97 0 does not respond - RESET
es1371: codec read timeout at 0xec14 [0x40000000]
es1371: codec read timeout at 0xec14 [0x40000000]
AC'97 0 access is not valid [0x0], removing mixer.
ENS1371: probe of 0000:00:09.0 failed with error -5

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-29-04 17:09 jcpetruzza     New Issue                                    
10-29-04 17:09 jcpetruzza     Kernel Version            => 2.6.8-gentoo-r3 
======================================================================




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
