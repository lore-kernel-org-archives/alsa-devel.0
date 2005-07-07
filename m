From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001239]: forgotten __init and __exit in memory.c
Date: Thu, 7 Jul 2005 10:37:11 +0200
Message-ID: <82988437a9db5af9652cb89a2a60aed8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 15B361B8
	for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2005 10:37:12 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1239> 
======================================================================
Reported By:                Henne
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1239
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-07-2005 10:37 CEST
Last Modified:              07-07-2005 10:37 CEST
======================================================================
Summary:                    forgotten __init and __exit in memory.c
Description: 
I think that snd_memory_init() should get an __init,
and snd_memory_exit() an __exit, cause that __init
function isn't called again and can be removed from the memory.
That doesn't save too much space, but it's cleaner and mekes more sense
.
The patch I added will fix it and is made for the current cvs
version(memory.c 1.38). 

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-07-05 10:37 Henne          New Issue                                    
07-07-05 10:37 Henne          File Added: memory_c.diff                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
