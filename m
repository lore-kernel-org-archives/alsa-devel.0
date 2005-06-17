From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001195]: alsa-lib 1.0.9 crashes artsd
Date: Fri, 17 Jun 2005 08:54:45 +0200
Message-ID: <8710083c4eb865d13d83ea6964a937d6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D2EE416B
	for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2005 08:54:46 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1195> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1195
Category:                   0_general
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-15-2005 17:21 CEST
Last Modified:              06-17-2005 08:54 CEST
======================================================================
Summary:                    alsa-lib 1.0.9 crashes artsd
Description: 
The submitter of Debian bug report
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=312577 says that after
upgrading his
ALSA library to 1.0.9 his artsd process crashes after a number of hours.

The submitter provided a backtrace which I attach (artsd.crash).
======================================================================

----------------------------------------------------------------------
 tiwai - 06-15-05 19:47 
----------------------------------------------------------------------
The backtrace looks inperfect, so can't trust 100%.
Anyway, please try the attached patch.

----------------------------------------------------------------------
 jdthood - 06-17-05 08:54 
----------------------------------------------------------------------
-------- Forwarded Message --------
From: Andreas Pakulat <apaku@gmx.de>
To: Thomas Hood <jdthood@aglu.demon.nl>, 312577-quiet@bugs.debian.org
Subject: Re: Bug#312577: Try this patch
Date: Thu, 16 Jun 2005 23:08:08 +0200

On 15.Jun 2005 - 23:45:18, Thomas Hood wrote:
> Upstream provides the attached patch for you to try.

Ok, applied it to the alsa-libs package from unstable. artsd doesn't
crash, at least I don't get a drkonqi window and I still see the
process(es), but the player "hangs" and I don't hear any music. Wait,
after some time I get a second of music and then nothing, then again I
get to hear a second or so.. There is no high load or something.

Oh and yesterday I tried the workaround of setting the frequency to
48KHz, after about 6:30 hours artsd still did not crash, so I guess that
workaround is working better than the patch.

Andreas

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-15-05 17:21 jdthood        New Issue                                    
06-15-05 17:21 jdthood        File Added: artsd.crash                      
06-15-05 17:52 tiwai          Note Added: 0005038                          
06-15-05 17:58 pzad           Note Added: 0005039                          
06-15-05 18:17 tiwai          Note Added: 0005040                          
06-15-05 18:24 jdthood        Note Added: 0005041                          
06-15-05 19:47 tiwai          Note Added: 0005042                          
06-15-05 19:47 tiwai          File Added: dmix-boundary-fix.diff                
   
06-17-05 08:54 jdthood        Note Added: 0005064                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
