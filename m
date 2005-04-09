From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001013]: Sound is not working on the MacMini
Date: Sat, 9 Apr 2005 02:45:02 +0200
Message-ID: <b5a60d8426efaa6b6e09b44f34cdf905@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5D0B9265
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 02:45:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1013> 
======================================================================
Reported By:                timing
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1013
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             2.6.11.5
======================================================================
Date Submitted:             03-24-2005 19:27 CET
Last Modified:              04-09-2005 02:45 CEST
======================================================================
Summary:                    Sound is not working on the MacMini
Description: 
Sound is not working on the MacMini. When loading the dmasound_pmac i get
the following error:

FATAL: Error inserting dmasound_pmac
(/lib/modules/2.6.11.5/kernel/sound/oss/dmasound/dmasound_pmac.ko): No
such device

When trying to play music i get an "maybe your device is busy?" error.

I've found a solution on the ubuntuforums(
http://www.ubuntuforums.org/showthread.php?t=12748 )

it says:

To manually apply the patch (just as easy in this case),
just open the file linux/sound/ppc/pmac.c in an editor,
and search for OAKeylargo.
Where it says SNAPPER right below, you change to SCREAMER (in uppercase).
(In kernel 2.6.10 it's at line 967). 

this solution is very minimal, the alsamixer is slow, and my computer
hangs for a couple of seconds before the start of every new process (when
opening a new window in gnome etc.). When i edit pmac.c in the old way my
system runs normal again.
======================================================================

----------------------------------------------------------------------
 perchrh - 04-03-05 14:36 
----------------------------------------------------------------------
Just wanted to let you know I've examined the mac mini sound issue some
more, and know what is causing it and how to fix it. 
Not sure how to add the support in a good way, though, was hoping you
could help out.

----------------------------------------------------------------------
 perchrh - 04-09-05 02:45 
----------------------------------------------------------------------
Ok, so I found a nice way of doing it myself. 
I'll post a patch this weekend.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-05 19:27 timing         New Issue                                    
03-24-05 19:27 timing         Distribution              => Ubuntu          
03-24-05 19:27 timing         Kernel Version            => 2.6.11.5        
03-24-05 19:32 timing         Note Added: 0004194                          
03-24-05 19:35 timing         Issue Monitored: timing                      
03-24-05 19:48 tiwai          Note Added: 0004197                          
03-24-05 21:35 timing         Note Added: 0004202                          
03-25-05 21:44 perchrh        Note Added: 0004212                          
03-25-05 21:50 perchrh        Note Edited: 0004212                         
03-25-05 21:52 perchrh        Issue Monitored: perchrh                     
03-25-05 22:57 timing         Note Edited: 0004202                         
03-25-05 23:27 timing         Note Edited: 0004202                         
04-03-05 13:44 perchrh        Note Added: 0004309                          
04-03-05 14:29 perchrh        Note Edited: 0004309                         
04-03-05 14:30 perchrh        Note Edited: 0004309                         
04-03-05 14:36 perchrh        Note Added: 0004310                          
04-09-05 02:45 perchrh        Note Added: 0004381                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
