From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000489]: With NForce [Patch] With NForce cards "modem" device does not exist.
Date: Tue, 9 Nov 2004 16:30:53 +0100
Message-ID: <2a9beeb00ed4b6f62ae319756eee3f27@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 97A122A9
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:30:53 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=489> 
======================================================================
Reported By:                sashak
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   489
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-08-2004 17:14 CEST
Last Modified:              11-09-2004 16:30 CET
======================================================================
Summary:                    With NForce [Patch] With NForce cards "modem" device
does not exist.
Description: 
NFORCE-MODEM resonably does not defined in alsa-lib config (it is same as
ICH-MODEM). Since there is no configuration differences just common driver
name 'ICH-MODEM' may be always used.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-08-04 17:24 
----------------------------------------------------------------------
Applied to CVS.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-08-04 17:14 sashak         New Issue                                    
09-08-04 17:14 sashak         File Added: ich_modem-config.patch                
   
09-08-04 17:24 tiwai          Status                   assigned => resolved
09-08-04 17:24 tiwai          Resolution               open => fixed       
09-08-04 17:24 tiwai          Note Added: 0001736                          
11-09-04 16:30 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
