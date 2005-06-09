From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000364]: Driver for VIRTUAL/DUMMY card(s) that forward/mix to real cards
Date: Thu, 9 Jun 2005 18:14:53 +0200
Message-ID: <0d11dea769a251cb4c7e612ff6883804@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ABB0F209
	for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2005 18:14:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=364> 
======================================================================
Reported By:                bonbons
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   364
Category:                   1_OTHERS
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-04-2004 13:33 CEST
Last Modified:              06-09-2005 18:14 CEST
======================================================================
Summary:                    Driver for VIRTUAL/DUMMY card(s) that forward/mix to
real cards
Description: 
As all sound devices can only be opened with exclusive access, and there
are quite a few close-source programs that interact with "/dev/dspX"
(OSS), would it be possible to have virtual cards that would mix to the
real one(s)?

======================================================================

----------------------------------------------------------------------
 bonbons - 01-08-05 11:05 
----------------------------------------------------------------------
Is there no interest for such a driver?

This would allow to use closed-source apps that just support old-style OSS
and don't work (correctly) over wrappers (some browser plugins, VMWare and
others). In addition it could be used to get rid of sound-daemons, using
dmix plugin and routing non-alsa apps through that virtual-pcm driver!

Use: same as for virtualmidi, but for PCMs!

----------------------------------------------------------------------
 ikonst - 06-09-05 18:14 
----------------------------------------------------------------------
I'm certainly interested in such a driver and would really love, when I'll
have some more free time, to go into the kernel programming neceesary for
it.

BTW, Charles Samuels (of Noatun fame) once tried writing something like
this (a driver that forwards sound to a user-space application which then
can do whatever it wants with it) but I don't know how well he fared.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-04-04 13:33 bonbons        New Issue                                    
01-08-05 11:05 bonbons        Note Added: 0003128                          
06-09-05 18:14 ikonst         Note Added: 0004981                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
