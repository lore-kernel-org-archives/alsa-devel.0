From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000942]: XMMS with alsa dmix output hangs
Date: Fri, 25 Feb 2005 01:40:56 +0100
Message-ID: <b8459566a327b0794c158d53c193b342@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9ACC622C
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2005 01:40:56 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=942> 
======================================================================
Reported By:                padde
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   942
Category:                   mixer
Reproducibility:            sometimes
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-25-2005 01:40 CET
Last Modified:              02-25-2005 01:40 CET
======================================================================
Summary:                    XMMS with alsa dmix output hangs
Description: 
XMMS plays back through alsa-dmix, everything is fine. After some time
(sometimes hours, but mostly between 2 to 5 mins, perhaps depending on
system load or maybe just solar flux ;) ) xmms just hangs, one can move
around the window, but closing isn't possible. Even 'killall xmms' won't
shut it all the way down. "killall -9 xmms" will work though. I did an
strace on xmms and put the last 1000 lines on my server
(http://padde.dyndns.org/temp/test.log), they're of no use for me.
All right.. after killing -9 xmms and starting it up again, it will play
about the same time it played before, no matter which song, and then hang
again. I tried various MP3 files, so I can be sure the source isn't
corrupted. By the way: beep-media-player behaves exactly the same way
(because it uses the same ALSA output plugin, I guess...)
As far as I can tell, no other sound sources are involved, i.e. it doesn't
matter if other sound sources are playing via dmix, too, or not.
I didn't test with other programs much, but xine had hangs, too. While
xmms comes to a stop, xine continued playing very very slowly (like frame
by frame), the sound was chopped like that, too.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-25-05 01:40 padde          New Issue                                    
02-25-05 01:40 padde          File Added: .asoundrc-dmix                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
