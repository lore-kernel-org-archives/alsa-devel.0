From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001493]: Permission denied when two users attempt to use dmix simultaneously
Date: Mon, 14 Nov 2005 09:51:11 +0100
Message-ID: <b83e7c731e9de6c1bf349cc49714577d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8AD7919D
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 09:51:11 +0100 (MET)
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


The following issue has been RESOLVED.
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
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-22-2005 01:06 CEST
Last Modified:              11-14-2005 09:51 CET
======================================================================
Summary:                    Permission denied when two users attempt to use dmix
simultaneously
Description: 
A single user account can use dmix to play audio simultaneously from as
many sources as he wants.  The problem is if audio is being played from
one user account then all other user accounts except root are blocked from
playing audio through dmix.
======================================================================

----------------------------------------------------------------------
 perex - 11-14-05 09:51 
----------------------------------------------------------------------
This problem is fixed in latest ALSA 1.0.10 development packages. All users
in group 'audio' are allowed to share device.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-22-05 01:06 Davidian1024   New Issue                                    
11-14-05 09:51 perex          Status                   assigned => resolved
11-14-05 09:51 perex          Resolution               open => fixed       
11-14-05 09:51 perex          Note Added: 0006696                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
