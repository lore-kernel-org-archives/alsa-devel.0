From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001000]: All programs that try to use alsa lockup.
Date: Sat, 19 Mar 2005 16:05:22 +0100
Message-ID: <ec051c1db90a17e92b43914c7d2d23be@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 589BE1D8
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 16:05:22 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1000> 
======================================================================
Reported By:                dr0p
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1000
Category:                   PCI - intel8x0
Reproducibility:            unable to duplicate
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.10
======================================================================
Date Submitted:             03-19-2005 16:05 CET
Last Modified:              03-19-2005 16:05 CET
======================================================================
Summary:                    All programs that try to use alsa lockup.
Description: 
I left the computer seeding some torrent the whole night.. no sound playing
or sound notification by the torrent client. The computer was up 19 hours.
Then i played some music (xmms). Everything was fine for some time, but
when xmms tried to play the 5 -th song in the playlist nothing happens. I
tried to play it manualy but then xmms just freezed. killall -9 xmms
xmms.bin closed the program. I start xmms again but this time xmms lockup
again when i play the first song. I tryed mpg123 - same thing. aplay ""
locksup too. I stoped X, killed xmms mpg123, aplay and unload the kernel
modules, then i load the alsa modules again i after a short time - the
same situation.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-19-05 16:05 dr0p           New Issue                                    
03-19-05 16:05 dr0p           Kernel Version            => 2.6.10          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
