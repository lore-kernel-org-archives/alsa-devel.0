From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000761]: Driver and all sound aplications hangs
Date: Thu, 31 Mar 2005 00:36:02 +0200
Message-ID: <b6b6e314f18f658e0e5cd20713c230d2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A052A271
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2005 00:36:02 +0200 (MEST)
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
Last Modified:              03-31-2005 00:36 CEST
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
 tiwai - 03-30-05 19:19 
----------------------------------------------------------------------
I believe it's a bug of alsa-driver, most likely a race among mutex.
This might be related with mmap and linked streams.

You wrote that the hang happens with many aplay's.  Does it happen even
after fresh reboot?  Also, try to run 'aplay -Dhw foo.wav' instead.
If the hang happens after aplay, please get sysrq traces.  You'll get a
non-truncated output in /var/log/messages (or another log file, depending
on the configuration).

----------------------------------------------------------------------
 mr-k - 03-31-05 00:36 
----------------------------------------------------------------------
Ok, i have another clue. I've been doing some tests. I had several
processes running at the same time in the following way:
aplay file.wav & aplay file.wav & aplay.wav & .....
Everything was fine as long as the number of processes didn't exceed 32
(this card have 32 channels, right?). At 33rd I heard that 32 processes
ran at a time, and the last one waited untill one of the others had
finished (it's ok, right?). But if I launched 32 and before they'd ended -
yet another 32, the driver crashed. This happens even just after rebooting
and with the -Dhw parameter. I also attach the sysrq traces.

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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
