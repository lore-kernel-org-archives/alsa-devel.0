From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000998]: access to second playback hangs
Date: Wed, 6 Apr 2005 12:34:06 +0200
Message-ID: <4aa5ab38d3d9e3f9d731e88ee4a5f285@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 25BC4230
	for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2005 12:34:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=998> 
======================================================================
Reported By:                allefant
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   998
Category:                   PCI - es1938
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Debian sid
Kernel Version:             2.6.10-6
======================================================================
Date Submitted:             03-19-2005 00:16 CET
Last Modified:              04-06-2005 12:34 CEST
======================================================================
Summary:                    access to second playback hangs
Description: 
This is haunting my since about half a year, since I got this card. Every
time the second playback device is accessed, there's a complete hardware
freeze. Disabling the second playback device makes it work. I know, this
isn't the best report, since I didn't compile the latest version and did
not much testing (no fun getting constant HW freezes) - but anyway, I
thought I report it here, maybe my workaround can help someone who googles
for this problems at least (or, maybe someone can give me even a hint how
to fix it).
======================================================================

----------------------------------------------------------------------
 allefant - 04-06-05 00:30 
----------------------------------------------------------------------
1.0.9rc2 fixes this. The bug can be closed, many thanks. (Now, if this just
would find its way into the kernel quicker..)

----------------------------------------------------------------------
 allefant - 04-06-05 12:34 
----------------------------------------------------------------------
Wait, ignore what I just said. Rejoiced too soon. I get the same HW freeze
as before. I actually couldn't reproduce it yesterday when I wrote the
above - but today I switched on the computer, started bmp, had it playing
for a while, then started another application with sound - and boom..
total HW freeze :| Going now to apply my workaround patch from above
again. (I also have another card with the intel HDA driver btw, in case
you wonder why I'm using such an old card as es1938 still.. but with that
I get no volume control. *sigh*)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-19-05 00:16 allefant       New Issue                                    
03-19-05 00:16 allefant       Distribution              => Debian sid      
03-19-05 00:16 allefant       Kernel Version            => 2.6.10-6        
04-06-05 00:30 allefant       Note Added: 0004344                          
04-06-05 12:34 allefant       Note Added: 0004345                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
