From: bugtrack@alsa-project.org
Subject: [ALSA - plugins 0001445]: jackplug and oss
Date: Sat, 24 Sep 2005 16:58:35 +0200
Message-ID: <e11b909d0a050c476067e4d1c194656b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 26D30D8
	for <alsa-devel@alsa-project.org>; Sat, 24 Sep 2005 16:58:36 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1445> 
======================================================================
Reported By:                FishB8
Assigned To:                
======================================================================
Project:                    ALSA - plugins
Issue ID:                   1445
Category:                   PCM - jack
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-23-2005 17:23 CEST
Last Modified:              09-24-2005 16:58 CEST
======================================================================
Summary:                    jackplug and oss
Description: 
I've tried setting up an asound.conf with a config for pcm.dsp0 so that I
can use aoss. No big deal. But then I thought it would be cool to set the
slave to pcm.jack. That way I could use aoss to route oss to jack using
alsa instead of some of the hacks out there that only work half the time.

No dice. It doesn't work. (Or at least I couldn't get it to work) Am I not
understanding how to do this correctly, or is this just not possible the
way things currently work?
======================================================================

----------------------------------------------------------------------
 b0ef - 09-24-05 16:58 
----------------------------------------------------------------------
You might try explaining a little more what "does not work" mean. What
happens?. What apps are you testing with?. What does your config file look
like?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-23-05 17:23 FishB8         New Issue                                    
09-24-05 16:58 b0ef           Note Added: 0006371                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
