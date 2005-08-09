From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001097]: alsamixer crashes on powerpc
Date: Tue, 9 Aug 2005 13:44:37 +0200
Message-ID: <fe5b7535e5433070b9d9d24825303a37@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9BD0F1D1
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:44:37 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1097> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1097
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-08-2005 20:02 CEST
Last Modified:              08-09-2005 13:44 CEST
======================================================================
Summary:                    alsamixer crashes on powerpc
Description: 
The submitter of Debian bug #308090 reports that alsamixer crashes.

1) run "alsamixer" from a shell prompt
2) press <TAB> at text UI screen that appears
3) observe crash

Please see http://bugs.debian.org/308090 for lots of additional
information.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-24-05 12:27 
----------------------------------------------------------------------
Fixed on CVS, 1.0.9rc4a.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-08-05 20:02 jdthood        New Issue                                    
05-24-05 12:27 tiwai          Status                   new => resolved     
05-24-05 12:27 tiwai          Resolution               open => fixed       
05-24-05 12:27 tiwai          Assigned To               => tiwai           
05-24-05 12:27 tiwai          Note Added: 0004717                          
08-09-05 13:44 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
