From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001493]: Permission denied when two users attempt to use dmix simultaneously
Date: Sat, 22 Oct 2005 01:06:34 +0200
Message-ID: <6a9f4c6460f75098d8f80978822c8800@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C1843141
	for <alsa-devel@alsa-project.org>; Sat, 22 Oct 2005 01:06:34 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1493> 
======================================================================
Reported By:                Davidian1024
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1493
Category:                   1_pcm_d - direct PCM plugins (dmix+)
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             10-22-2005 01:06 CEST
Last Modified:              10-22-2005 01:06 CEST
======================================================================
Summary:                    Permission denied when two users attempt to use dmix
simultaneously
Description: 
A single user account can use dmix to play audio simultaneously from as
many sources as he wants.  The problem is if audio is being played from
one user account then all other user accounts except root are blocked from
playing audio through dmix.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-22-05 01:06 Davidian1024   New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
