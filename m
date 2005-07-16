From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001071]: Help with Volume Controls
Date: Sat, 16 Jul 2005 17:11:50 +0200
Message-ID: <03f0220e1566982e5bd1d14dc83dae75@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BD790192
	for <alsa-devel@alsa-project.org>; Sat, 16 Jul 2005 17:11:50 +0200 (MEST)
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


The following issue has been set as DUPLICATE OF issue 0000154.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1071> 
======================================================================
Reported By:                snekiepete
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1071
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.11
======================================================================
Date Submitted:             04-23-2005 07:05 CEST
Last Modified:              07-16-2005 17:11 CEST
======================================================================
Summary:                    Help with Volume Controls
Description: 
I am looking for help configuring this card to have the ability to adjust
"Front" and "Surround" volumes with one control instead of two. Is this
possible and how?
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000154 Master volume only controls front outpu...
======================================================================

----------------------------------------------------------------------
 adamk75 - 04-24-05 13:46 
----------------------------------------------------------------------
This seems to be related to the folllwing bugs, which are for different
soundcards:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=154
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=172
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=919

Seems that Alsa doesn't necessary have a master volume control on all
cards that actually controls the volume of all output..  I know Lee Revell
is working on this for Live! cards but I have no idea if his solution will
be able to be used for other cards/drivers.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-23-05 07:05 snekiepete     New Issue                                    
04-23-05 07:05 snekiepete     Kernel Version            => 2.6.11          
04-24-05 13:46 adamk75        Note Added: 0004566                          
07-16-05 17:11 jdthood        Relationship added       duplicate of 0000154
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
