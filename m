From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001112]: ad1816a based card with id "ADS7180" not detected
Date: Tue, 9 Aug 2005 13:44:48 +0200
Message-ID: <839e5f00106442ca94b6460434faa84a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6D0011EC
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:44:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1112> 
======================================================================
Reported By:                sonne000ca
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1112
Category:                   ISA - ad1816a
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-15-2005 08:41 CEST
Last Modified:              08-09-2005 13:44 CEST
======================================================================
Summary:                    ad1816a based card with id "ADS7180" not detected
Description: 
To fix, add:
{ .id = "ADS7180", .devs = { { .id = "ADS7180" }, { .id = "ADS7181" } }
},
to snd_ad1816a_pnpids[] in ad1816a,c


======================================================================

----------------------------------------------------------------------
 tiwai - 05-15-05 15:41 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-15-05 08:41 sonne000ca     New Issue                                    
05-15-05 15:41 tiwai          Status                   new => resolved     
05-15-05 15:41 tiwai          Resolution               open => fixed       
05-15-05 15:41 tiwai          Assigned To               => tiwai           
05-15-05 15:41 tiwai          Note Added: 0004661                          
08-09-05 13:44 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
