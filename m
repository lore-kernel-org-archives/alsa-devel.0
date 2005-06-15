From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001195]: alsa-lib 1.0.9 crashes artsd
Date: Wed, 15 Jun 2005 19:47:17 +0200
Message-ID: <e91cbda2469d1a33f9e81635bb254e7a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A04F31F8
	for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2005 19:47:17 +0200 (MEST)
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
Last Modified:              06-15-2005 19:47 CEST
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
 jdthood - 06-15-05 18:24 
----------------------------------------------------------------------
> It's interesting whether this is inside rate/dmix or in arts...

Can you divine that from the artsd.crash file which I attached?

----------------------------------------------------------------------
 tiwai - 06-15-05 19:47 
----------------------------------------------------------------------
The backtrace looks inperfect, so can't trust 100%.
Anyway, please try the attached patch.

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
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
