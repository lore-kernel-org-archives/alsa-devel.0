From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001080]: [PATCH] alsamixer crashes with toonie (mac-mini) when pressing F4
Date: Thu, 28 Apr 2005 12:21:24 +0200
Message-ID: <547133da95f6d962e45348f9604b4067@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F171A251
	for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2005 12:21:24 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1080> 
======================================================================
Reported By:                gjasny
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1080
Category:                   alsamixer
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-28-2005 12:21 CEST
Last Modified:              04-28-2005 12:21 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-28-05 12:21 gjasny         New Issue                                    
04-28-05 12:21 gjasny         File Added: alsamixer.diff                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
