From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000479]: [Patch] VIA based AC97 modem driver
Date: Tue, 9 Nov 2004 16:21:44 +0100
Message-ID: <5de815d7d48d15bee4c32f450b8b6c3c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 722AF244
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:21:44 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=479> 
======================================================================
Reported By:                sashak
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   479
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-02-2004 21:24 CEST
Last Modified:              11-09-2004 16:21 CET
======================================================================
Summary:                    [Patch] VIA based AC97 modem driver
Description: 
New 'via82xx_modem.c' driver supports VIA based AC97 modems. (tested with
2.6.8.1). The patch (for alsa-driver) is uploaded.
======================================================================

----------------------------------------------------------------------
 sashak - 09-08-04 16:40 
----------------------------------------------------------------------
Uploaded patch is for 'alsa-lib' conf: VIA82XX-MODEM card definition.

----------------------------------------------------------------------
 tiwai - 09-08-04 17:03 
----------------------------------------------------------------------
I forgot to commit my patch.

We don't need to add a new file since the configuration is
identical with ICH-MODEM.  The alias is added to CVS now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-02-04 21:24 sashak         New Issue                                    
09-02-04 21:24 sashak         File Added: via-modem.patch                    
09-03-04 15:52 tiwai          Status                   assigned => resolved
09-03-04 15:52 tiwai          Resolution               open => fixed       
09-03-04 15:52 tiwai          Note Added: 0001692                          
09-08-04 16:36 sashak         Status                   resolved => feedback
09-08-04 16:36 sashak         Resolution               fixed => reopened   
09-08-04 16:36 sashak         Note Added: 0001729                          
09-08-04 16:40 sashak         Note Added: 0001730                          
09-08-04 17:03 tiwai          Status                   feedback => resolved
09-08-04 17:03 tiwai          Resolution               reopened => fixed   
09-08-04 17:03 tiwai          Note Added: 0001731                          
11-09-04 16:21 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
