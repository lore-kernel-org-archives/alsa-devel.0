From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001218]: Line-In and Mic-In do not work
Date: Wed, 29 Jun 2005 10:08:11 +0200
Message-ID: <861bf6f5f4bd7ddfbad49f2daf809d29@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ACD591B2
	for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2005 10:08:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1218> 
======================================================================
Reported By:                hugo4711
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1218
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 4
Kernel Version:             2.6.11-1.1369_FC4
======================================================================
Date Submitted:             06-28-2005 20:03 CEST
Last Modified:              06-29-2005 10:08 CEST
======================================================================
Summary:                    Line-In and Mic-In do not work
Description: 
Capturing from Line-In and Mic-In don't work. I have connected a
bttv-tv-card with  Line-In and I cannot hear the sound output from it.
Every single input is at 100% using alsamixer and kmix. This happened
after an update from FC3 to FC4. Before the update everything was fine.


======================================================================

----------------------------------------------------------------------
 rlrevell - 06-29-05 08:33 
----------------------------------------------------------------------
0 [Unknown ]: Audigy - Audigy 1 or 2 [Unknown]
                     Audigy 1 or 2 [Unknown] (rev.3, serial:0x511102) at
0xe800, irq 11

This bug is thought to be fixed in ALSA CVS.  If someone can confirm that
it's fixed, we need to submit this for the -stable kernel, because I think
2.6.12 shipped with this bug too.

----------------------------------------------------------------------
 hugo4711 - 06-29-05 10:08 
----------------------------------------------------------------------
I did an upgrade from 1.0.9rc2 to 1.0.9a with the 2.6.11-1.1369_FC4 Kernel.
And the Bug is fixed! Now it works perfectly again. 

My 0x511102 is now recognized as Audigy 1.

There is a 2.6.12 Kernel in the development Branch of FC4. This Kernel
uses the alsa 1.0.9 driver. I will try this kernel later and post if this
one works.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-28-05 20:03 hugo4711       New Issue                                    
06-28-05 20:03 hugo4711       Distribution              => Fedora Core 4   
06-28-05 20:03 hugo4711       Kernel Version            => 2.6.11-1.1369_FC4
06-29-05 06:28 netslayer      Note Added: 0005303                          
06-29-05 08:33 rlrevell       Note Added: 0005304                          
06-29-05 10:08 hugo4711       Note Added: 0005305                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
