From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000761]: Driver and all sound aplications hangs
Date: Wed, 12 Jan 2005 15:57:38 +0100
Message-ID: <481e020e75468238994aa6aee479666d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B1C2B329
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2005 15:57:38 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=761> 
======================================================================
Reported By:                mr-k
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   761
Category:                   OTHERS
Reproducibility:            random
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.10
======================================================================
Date Submitted:             12-30-2004 13:13 CET
Last Modified:              01-12-2005 15:57 CET
======================================================================
Summary:                    Driver and all sound aplications hangs
Description: 
I have a YMF-724F (lspci -v attached). Problem occur in alsa 1.0.7 and in
alsa
from kernel 2.6.10. In other versions (also in 1.0.6a) i havn't any
problems.

Sometimes (up to couple times a day) driver crash and all processes using
sound hangs. I can't kill them (by SIGKILL and SIGTERM) and I can't remove
the
module by rmmod (it hangs also). When i try to shutdown the system, it
stops
when it try to remove the module. ps hangs when it try to get
informations
about other hung processes, also when i try to do it manualy (by
/proc/pid/),
it hangs. Everything else is working good. 
There are no messages from the kernel in /var/log/messages and
/var/log/dmesg or reported to the console. 


======================================================================

----------------------------------------------------------------------
 tiwai - 01-12-05 15:14 
----------------------------------------------------------------------
It looks like the open semaphore.

How does "driver crash" in the original message happens?  What do you mean
exactly?

----------------------------------------------------------------------
 mr-k - 01-12-05 15:57 
----------------------------------------------------------------------
Well.. i didn't find any regularity. During usual work with computer sound
stops working (xmms stops playing song or aplay just hang; sometimes even
direfox hangs). Then i cant close or kill them, can't remove alsa modules
from kernel and even can't shutdown my system. I really want to help you
finding solution so tell me what should i do after crash? (i can record
what is going on to avi file or do enything you need)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-30-04 13:13 mr-k           New Issue                                    
12-30-04 13:13 mr-k           Distribution              => Gentoo          
12-30-04 13:13 mr-k           Kernel Version            => 2.6.10          
12-30-04 13:15 mr-k           File Added: alsa-report                      
12-30-04 13:18 mr-k           Issue Monitored: mr-k                        
12-30-04 15:09 tiwai          Note Added: 0003022                          
01-01-05 22:21 mr-k           Note Added: 0003038                          
01-07-05 22:41 mr-k           Note Added: 0003123                          
01-11-05 22:11 mr-k           Note Added: 0003158                          
01-11-05 22:12 mr-k           File Added: alsa.log                         
01-12-05 15:14 tiwai          Note Added: 0003170                          
01-12-05 15:57 mr-k           Note Added: 0003173                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
