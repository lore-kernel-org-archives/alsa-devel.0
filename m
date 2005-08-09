From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001122]: Soudcard will not suspend due to white list incomplete
Date: Tue, 9 Aug 2005 13:44:41 +0200
Message-ID: <8db6b9c4c486a964801115f4404ef7a8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CE8F71C9
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:44:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1122> 
======================================================================
Reported By:                hiaslboy
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1122
Category:                   PCI - es1968
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.11 with 2.6.11.10 patch and softwaresuspend2
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-21-2005 16:10 CEST
Last Modified:              08-09-2005 13:44 CEST
======================================================================
Summary:                    Soudcard will not suspend due to white list
incomplete
Description: 
M soundcard will not suspend, even though it works perfectly adding the
vendor 1558 to the whitelist.

======================================================================

----------------------------------------------------------------------
 tiwai - 05-23-05 11:33 
----------------------------------------------------------------------
Thanks, fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-21-05 16:10 hiaslboy       New Issue                                    
05-21-05 16:11 hiaslboy       File Added: es1968-matthias.patch                 
  
05-21-05 16:11 hiaslboy       Distribution              => Debian          
05-21-05 16:11 hiaslboy       Kernel Version            => 2.6.11 with 2.6.11.10
patch and softwaresuspend2
05-23-05 11:33 tiwai          Status                   assigned => resolved
05-23-05 11:33 tiwai          Resolution               open => fixed       
05-23-05 11:33 tiwai          Note Added: 0004701                          
08-09-05 13:44 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
