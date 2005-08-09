From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001080]: [PATCH] alsamixer crashes with toonie (mac-mini) when pressing F4
Date: Tue, 9 Aug 2005 13:44:40 +0200
Message-ID: <10d1a681a3a43b041137e90fabb5d3fc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6DAA81C9
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:44:40 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1080> 
======================================================================
Reported By:                gjasny
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1080
Category:                   alsamixer
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-28-2005 12:21 CEST
Last Modified:              08-09-2005 13:44 CEST
======================================================================
Summary:                    [PATCH] alsamixer crashes with toonie (mac-mini)
when pressing F4
Description: 
When entering the capture view, alsamixer recognized that there are no
napture controls and switches back to playback.

But during the first reinit after F4 mixer_grpidx is freeed and malloced.
Because there are no capture devices mixer_grpidx[0] contains garbage,
which leads to a crash.

I've replaced the malloc with a calloc, so that mixer_grpidx always
contains some sane values.

Cheers,
Gregor
======================================================================

----------------------------------------------------------------------
 tiwai - 05-23-05 18:57 
----------------------------------------------------------------------
Fixed on CVS.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-28-05 12:21 gjasny         New Issue                                    
04-28-05 12:21 gjasny         File Added: alsamixer.diff                    
05-23-05 18:57 tiwai          Status                   new => resolved     
05-23-05 18:57 tiwai          Resolution               open => fixed       
05-23-05 18:57 tiwai          Assigned To               => tiwai           
05-23-05 18:57 tiwai          Note Added: 0004705                          
08-09-05 13:44 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
