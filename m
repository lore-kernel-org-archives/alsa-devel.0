From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001139]: alsa-lib-1.0.9 breaks WINE and icc
Date: Tue, 9 Aug 2005 13:44:21 +0200
Message-ID: <3623e1a36feb48ae7b763087d8810ddf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AD73E1D5
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:44:21 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1139> 
======================================================================
Reported By:                canal
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1139
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-29-2005 02:17 CEST
Last Modified:              08-09-2005 13:44 CEST
======================================================================
Summary:                    alsa-lib-1.0.9 breaks WINE and icc
Description: 
alsa-lib uses identifier "interface". It's used as keyword in icc and WINE
(in case of WINE - via #define interface struct).

======================================================================

----------------------------------------------------------------------
 perex - 05-29-05 16:25 
----------------------------------------------------------------------
Fixed in CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-29-05 02:17 canal          New Issue                                    
05-29-05 16:25 perex          Status                   new => resolved     
05-29-05 16:25 perex          Resolution               open => fixed       
05-29-05 16:25 perex          Assigned To               => perex           
05-29-05 16:25 perex          Note Added: 0004789                          
08-09-05 13:44 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
