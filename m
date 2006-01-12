From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001293]: trident: device supported by OSS but not by ALSA
Date: Thu, 12 Jan 2006 23:38:05 +0100
Message-ID: <3d019a9a7e97df3ef8452e7dea8df6e7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C192C161
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2006 23:38:05 +0100 (MET)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1293> 
======================================================================
Reported By:                Adrian Bunk
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1293
Category:                   PCI - trident
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             2.6.13-rc4-mm1
======================================================================
Date Submitted:             07-31-2005 21:13 CEST
Last Modified:              01-12-2006 23:38 CET
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
 pwaechtler - 08-22-05 10:05 
----------------------------------------------------------------------
The cyberpro 5050 is an old combined video+audio controller - and is/was
used in some settop boxes (German Siemens Activity and also Loewe).

There will be no "desktop users" around.
And because I don't work for Loewe anymore: I don't have access to
hardware.

If you ask me: leave it out!

----------------------------------------------------------------------
 rlrevell - 01-12-06 23:38 
----------------------------------------------------------------------
Still no testers.  If we don't find one via LKML we can probably close
this.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-31-05 21:13 Adrian Bunk    New Issue                                    
07-31-05 21:13 Adrian Bunk    Kernel Version            => 2.6.13-rc4-mm1  
08-03-05 12:01 perex          Note Added: 0005616                          
08-22-05 10:05 pwaechtler     Note Added: 0005890                          
01-12-06 23:38 rlrevell       Note Added: 0007592                          
01-12-06 23:38 rlrevell       Assigned To               => rlrevell        
01-12-06 23:38 rlrevell       Status                   new => feedback     
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
