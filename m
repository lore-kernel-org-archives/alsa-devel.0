From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000761]: Driver and all sound aplications hangs
Date: Tue, 11 Jan 2005 22:11:52 +0100
Message-ID: <3a165413428c449d7c103a472f006642@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 90A0A2CD
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2005 22:11:52 +0100 (MET)
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
Last Modified:              01-11-2005 22:11 CET
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
 mr-k - 01-07-05 22:41 
----------------------------------------------------------------------
I have 1.0.8rc1 and the same problem. I was thinking that now everytjing is
good but after 2 or 3 days of testing i have the same symptoms. Now, I'm
makeing kernel with sysrq. Maybe it's not an alsa problem ?

----------------------------------------------------------------------
 mr-k - 01-11-05 22:11 
----------------------------------------------------------------------
Here is dmesg after SysRq:Showstate after alsa hang. If there's anything
else I should report, please tell me.

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
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
