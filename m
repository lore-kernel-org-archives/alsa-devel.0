From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000964]: "Swap surround slot" does not affect "Duplicate Front"
Date: Wed, 8 Jun 2005 16:10:24 +0200
Message-ID: <6367e436d17655575bd9df8fb6fca308@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 315F31F2
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 16:10:24 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=964> 
======================================================================
Reported By:                slammer
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   964
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-04-2005 20:20 CET
Last Modified:              06-08-2005 16:10 CEST
======================================================================
Summary:                    "Swap surround slot" does not affect "Duplicate
Front"
Description: 
When i turn the "Swap surround slot" option "on" and physically do the
swap, the "Duplicate Front" option duplicates front channels still to the
Unswapped plug i.e. it sends them to the Center/LFE channels. I think that
the "Duplicate front" switch should be affected by the "Swap surround"
switch. Don't You think so?
======================================================================

----------------------------------------------------------------------
 tiwai - 06-08-05 16:10 
----------------------------------------------------------------------
If it doesn't affect, it's really so - I mean, these switches are
straightforward implementation of the ac97 registers.  The behavior is
exactly what the hardware provides.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-04-05 20:20 slammer        New Issue                                    
03-05-05 22:50 slammer        Issue Monitored: slammer                     
05-30-05 12:57 perex          Project                  ALSA - lib => ALSA -
driver
05-30-05 12:58 perex          Category                 control / hcontrol => PCI
- intel8x0
06-08-05 16:10 tiwai          Note Added: 0004945                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
