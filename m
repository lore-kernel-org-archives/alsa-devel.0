From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001239]: forgotten __init and __exit in memory.c
Date: Fri, 29 Jul 2005 17:59:44 +0200
Message-ID: <9fff416a99f6334b69dd78f0f47a34e7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3104A197
	for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2005 17:59:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1239> 
======================================================================
Reported By:                Henne
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1239
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-07-2005 10:37 CEST
Last Modified:              07-29-2005 17:59 CEST
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

----------------------------------------------------------------------
 Henne - 07-25-05 14:54 
----------------------------------------------------------------------
Here is the new one!

----------------------------------------------------------------------
 tiwai - 07-29-05 17:59 
----------------------------------------------------------------------
Thanks, applied to CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-07-05 10:37 Henne          New Issue                                    
07-07-05 10:37 Henne          File Added: memory_c.diff                    
07-08-05 11:52 tiwai          Note Added: 0005410                          
07-12-05 11:41 Henne          File Added: memory_c_1.diff                    
07-25-05 14:54 Henne          Note Added: 0005563                          
07-29-05 17:59 tiwai          Status                   new => resolved     
07-29-05 17:59 tiwai          Resolution               open => fixed       
07-29-05 17:59 tiwai          Assigned To               => tiwai           
07-29-05 17:59 tiwai          Note Added: 0005582                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
