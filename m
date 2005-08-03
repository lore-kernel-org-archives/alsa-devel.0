From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000424]: No mute control on Master Volume
Date: Wed, 3 Aug 2005 14:54:50 +0200
Message-ID: <c3eba9dad25333c9b7aabba5b2e5710c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4240E189
	for <alsa-devel@alsa-project.org>; Wed,  3 Aug 2005 14:54:52 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=424> 
======================================================================
Reported By:                marm
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   424
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Debian unstable
Kernel Version:             2.6.7
======================================================================
Date Submitted:             08-05-2004 20:07 CEST
Last Modified:              08-03-2005 14:54 CEST
======================================================================
Summary:                    No mute control on Master Volume
Description: 
Please add a mute control for the Master Volume on cmipci cards (I have a
CMI8738-MC6), as it makes life difficult not having one when the phone
rings ;)

The Windows drivers support this, and indeed, I seem to recall earlier
(0.9.something) versions of the alsa driver did too.
======================================================================

----------------------------------------------------------------------
 tiwai - 08-03-05 12:43 
----------------------------------------------------------------------
Yes, the life is hard.  This chip doesn't have a hardware master mute
control.  It has only master volume.

----------------------------------------------------------------------
 schorpp - 08-03-05 14:54 
----------------------------------------------------------------------
hard to say without available register datasheet.. but if You say it...

on trying to emulate the switch button by software then.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-05-04 20:07 marm           New Issue                                    
08-05-04 20:07 marm           Distribution              => Debian unstable 
08-05-04 20:07 marm           Kernel Version            => 2.6.7           
08-02-05 10:19 schorpp        Note Added: 0005602                          
08-03-05 12:43 tiwai          Note Added: 0005623                          
08-03-05 14:54 schorpp        Note Added: 0005626                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
