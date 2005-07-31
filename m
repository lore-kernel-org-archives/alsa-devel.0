From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001293]: trident: device supported by OSS but not by ALSA
Date: Sun, 31 Jul 2005 21:13:58 +0200
Message-ID: <f667eb029fb3a9443df0d1299a5612d3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 755731C2
	for <alsa-devel@alsa-project.org>; Sun, 31 Jul 2005 21:13:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1293> 
======================================================================
Reported By:                Adrian Bunk
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1293
Category:                   PCI - trident
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.13-rc4-mm1
======================================================================
Date Submitted:             07-31-2005 21:13 CEST
Last Modified:              07-31-2005 21:13 CEST
======================================================================
Summary:                    trident: device supported by OSS but not by ALSA
Description: 
I'm currently creating a list of OSS drivers where all the hardware
supported by them is also supported by ALSA. The goal is to schedule
them for removal (except someone tells that for one or more of them ALSA
support is inferior). I do not have this hardware, but this is currently
the reason why the old OSS driver can't be removed from the kernel.


The OSS trident driver has 5 different pci_device_id entries.

For 4 of them there seems to be similar ALSA support, but I can't find
any ALSA equivalent for the following entry:
        {PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_5050,
         PCI_ANY_ID, PCI_ANY_ID, 0, 0, CYBER5050},



Alan Cox said about this:

The OSS driver supports the CyberPro T-squared core integrated into the
cyberpro chipset while the ALSA driver only supports the others. Should
be easy for someone to resolve. I don't have any 5000 hardware to test
it however.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-31-05 21:13 Adrian Bunk    New Issue                                    
07-31-05 21:13 Adrian Bunk    Kernel Version            => 2.6.13-rc4-mm1  
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
