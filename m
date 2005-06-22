From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000761]: Driver and all sound aplications hangs
Date: Wed, 22 Jun 2005 11:01:26 +0200
Message-ID: <64670cb5f0a2ebc7434500402dd952f4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AE295205
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2005 11:01:26 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=761> 
======================================================================
Reported By:                mr-k
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   761
Category:                   1_OTHERS
Reproducibility:            random
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-30-2004 13:13 CET
Last Modified:              06-22-2005 11:01 CEST
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
 mr-k - 06-21-05 23:04 
----------------------------------------------------------------------
Well, i think that this bug can be closed, everything is fine now. But if u
want 
I can make some tests..



----------------------------------------------------------------------
 tiwai - 06-22-05 11:01 
----------------------------------------------------------------------
OK, closing now.

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
01-16-05 15:38 mr-k           Note Added: 0003218                          
02-09-05 21:45 mr-k           Note Edited: 0003173                         
02-09-05 21:46 mr-k           Note Edited: 0003123                         
03-10-05 16:46 mr-k           Note Added: 0003868                          
03-10-05 16:47 mr-k           Note Edited: 0003868                         
03-20-05 22:53 bendis         Issue Monitored: bendis                      
03-22-05 17:59 mr-k           Issue Monitored: tiwai                       
03-22-05 17:59 mr-k           Note Added: 0004126                          
03-30-05 18:27 tiwai          Note Added: 0004269                          
03-30-05 19:06 mr-k           Note Added: 0004270                          
03-30-05 19:19 tiwai          Note Added: 0004271                          
03-31-05 00:36 mr-k           Note Added: 0004276                          
03-31-05 00:36 mr-k           File Added: alsa-sysrq                       
04-02-05 21:50 mr-k           Note Added: 0004300                          
05-25-05 23:10 mr-k           Note Added: 0004737                          
05-25-05 23:11 mr-k           Note Edited: 0004737                         
05-31-05 13:06 tiwai          Note Added: 0004829                          
05-31-05 13:06 tiwai          File Added: pcm-drain-lock-fix.diff               
    
05-31-05 15:43 bendis         Note Added: 0004832                          
06-01-05 15:50 mr-k           Note Added: 0004858                          
06-21-05 16:41 mr-k           Note Added: 0005112                          
06-21-05 23:04 mr-k           Note Edited: 0005112                         
06-22-05 11:01 tiwai          Status                   new => resolved     
06-22-05 11:01 tiwai          Resolution               open => fixed       
06-22-05 11:01 tiwai          Assigned To               => tiwai           
06-22-05 11:01 tiwai          Note Added: 0005121                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
