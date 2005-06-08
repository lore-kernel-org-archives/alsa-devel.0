From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001157]: alsa-plugins depends on alsa-lib 1.0.9
Date: Wed, 8 Jun 2005 16:00:30 +0200
Message-ID: <0f0c359328b8a5b73c1b69c385c75d62@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8A15E1C5
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 16:00:30 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1157> 
======================================================================
Reported By:                jordi
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1157
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-06-2005 01:35 CEST
Last Modified:              06-08-2005 16:00 CEST
======================================================================
Summary:                    alsa-plugins depends on alsa-lib 1.0.9
Description: 
configure.in needs to update the libasound2 requirement to 1.0.9, or else
-plugins fails to build because it lacks snd_pcm_ioplug_create().

This report should be moved to the alsa-plugins category when it's
created, I'm filing it under lib because it's where the plugins lived
before.
======================================================================

----------------------------------------------------------------------
 tiwai - 06-08-05 16:00 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-05 01:35 jordi          New Issue                                    
06-08-05 16:00 tiwai          Status                   new => resolved     
06-08-05 16:00 tiwai          Resolution               open => fixed       
06-08-05 16:00 tiwai          Assigned To               => tiwai           
06-08-05 16:00 tiwai          Note Added: 0004941                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
