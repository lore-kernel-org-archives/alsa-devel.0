From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001665]: Alsaconf crashes with driver e18xx
Date: Wed, 21 Dec 2005 15:59:06 +0100
Message-ID: <64bf0aa5be7d0ec3e0164e8a145c1058@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 70C831AD
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2005 15:59:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1665> 
======================================================================
Reported By:                renium
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1665
Category:                   ISA - es18xx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             Kernel 2.6.12-r10
======================================================================
Date Submitted:             12-21-2005 15:59 CET
Last Modified:              12-21-2005 15:59 CET
======================================================================
Summary:                    Alsaconf crashes with driver e18xx
Description: 
Siemens Scenic Mobile 510 Notebook
Compiled ALSA in the kernel as modules
and started alsaconf.
After searching soundcards the messages comes:
No supported PnP or PCI card found.
Input Would you like to probe legacy ISA sound cards/chips?
Yes.... 
Found an es18xx ESS ES18xx AudioDrive and the system crashes.
The hardware probe stops the whole system
and it freezes.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-21-05 15:59 renium         New Issue                                    
12-21-05 15:59 renium         Distribution              => Gentoo          
12-21-05 15:59 renium         Kernel Version            => Kernel 2.6.12-r10
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
