From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001218]: Line-In and Mic-In do not work
Date: Wed, 6 Jul 2005 23:27:15 +0200
Message-ID: <6f74714a736ebba5594721a8dfdaafcd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 441FD1A4
	for <alsa-devel@alsa-project.org>; Wed,  6 Jul 2005 23:27:15 +0200 (MEST)
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
Status:                     resolved
Distribution:               Fedora Core 4
Kernel Version:             2.6.11-1.1369_FC4
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-28-2005 20:03 CEST
Last Modified:              07-06-2005 23:27 CEST
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
 cpitchford - 06-29-05 23:08 
----------------------------------------------------------------------
I have an audigy1 card and have noticed that line in wasn't working and
that the "live-drive" inputs were missing (aux2, line2, etc) This appeared
to be the case since 2.6.12-rc2. Line in definately works on 2.6.12-rc1
however so that fault was introduced between these two kernel versions.
Now running with 2.6.12.1 and the fault remains, installing 1.0.9b fixes
it again. I think merging the fixed 1.0.9b into the kernel would solve it,
though I'm not an expert

----------------------------------------------------------------------
 rlrevell - 07-06-05 23:26 
----------------------------------------------------------------------
Fixed in CVS.  Should also be fixed in the nest stable kernel release.

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
07-06-05 23:26 rlrevell       Note Added: 0005397                          
07-06-05 23:27 rlrevell       Status                   new => resolved     
07-06-05 23:27 rlrevell       Resolution               open => fixed       
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
