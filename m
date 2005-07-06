From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001218]: Line-In and Mic-In do not work
Date: Wed, 6 Jul 2005 22:10:25 +0200
Message-ID: <29364af8001a6f5db80223d57675bf49@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 03656199
	for <alsa-devel@alsa-project.org>; Wed,  6 Jul 2005 22:10:25 +0200 (MEST)
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


The following issue has been set as DUPLICATE OF issue 0001216.
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
Last Modified:              07-06-2005 22:10 CEST
======================================================================
Summary:                    Line-In and Mic-In do not work
Description: 
Capturing from Line-In and Mic-In don't work. I have connected a
bttv-tv-card with  Line-In and I cannot hear the sound output from it.
Every single input is at 100% using alsamixer and kmix. This happened
after an update from FC3 to FC4. Before the update everything was fine.


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001216 Microphone does not work
======================================================================

----------------------------------------------------------------------
 netslayer - 06-29-05 06:28 
----------------------------------------------------------------------
I just upgraded to alsa 1.0.9 and i'm experiencing the same thing with my
audigy 1 card. Line in doesn't work, I have the mixer setup just like I
did before (and tried all the bars up). 

 Sun Jun 26 21:32:35 2005 >>> sys-kernel/gentoo-sources-2.6.12-r1
 Sun Jun 26 22:25:51 2005 >>> media-sound/alsa-headers-1.0.9
 Sun Jun 26 22:29:23 2005 >>> media-libs/alsa-lib-1.0.9
 Sun Jun 26 22:30:21 2005 >>> media-sound/alsa-utils-1.0.9a
 Sun Jun 26 22:31:05 2005 >>> media-libs/alsa-oss-1.0.9

I feel like giving up on recording with this card..:-/ alsa doesn't like
it

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

----------------------------------------------------------------------
 cpitchford - 06-29-05 23:08 
----------------------------------------------------------------------
I have an audigy1 card and have noticed that line in wasn't working and
that the "live-drive" inputs were missing (aux2, line2, etc) This appeared
to be the case since 2.6.12-rc2. Line in definately works on 2.6.12-rc1
however so that fault was introduced between these two kernel versions.
Now running with 2.6.12.1 and the fault remains, installing 1.0.9b fixes
it again. I think merging the fixed 1.0.9b into the kernel would solve it,
though I'm not an expert

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-28-05 20:03 hugo4711       New Issue                                    
06-28-05 20:03 hugo4711       Distribution              => Fedora Core 4   
06-28-05 20:03 hugo4711       Kernel Version            => 2.6.11-1.1369_FC4
06-29-05 06:28 netslayer      Note Added: 0005303                          
06-29-05 08:33 rlrevell       Note Added: 0005304                          
06-29-05 10:08 hugo4711       Note Added: 0005305                          
06-29-05 23:08 cpitchford     Note Added: 0005319                          
07-06-05 22:10 rlrevell       Relationship added       duplicate of 0001216
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
