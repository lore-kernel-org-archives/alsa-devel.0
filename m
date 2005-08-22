From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001293]: trident: device supported by OSS but not by ALSA
Date: Mon, 22 Aug 2005 10:05:07 +0200
Message-ID: <ee00e83631de1389b9ffa3e27b715c0c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6C7E920F
	for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2005 10:05:08 +0200 (MEST)
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
Last Modified:              08-22-2005 10:05 CEST
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

----------------------------------------------------------------------
 perex - 08-03-05 12:01 
----------------------------------------------------------------------
TESTERS WANTED!

----------------------------------------------------------------------
 pwaechtler - 08-22-05 10:05 
----------------------------------------------------------------------
The cyberpro 5050 is an old combined video+audio controller - and is/was
used in some settop boxes (German Siemens Activity and also Loewe).

There will be no "desktop users" around.
And because I don't work for Loewe anymore: I don't have access to
hardware.

If you ask me: leave it out!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-31-05 21:13 Adrian Bunk    New Issue                                    
07-31-05 21:13 Adrian Bunk    Kernel Version            => 2.6.13-rc4-mm1  
08-03-05 12:01 perex          Note Added: 0005616                          
08-22-05 10:05 pwaechtler     Note Added: 0005890                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
