From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000897]: test/timer.c malfunctions with snd-rtctimer
Date: Wed, 9 Feb 2005 15:45:05 +0100
Message-ID: <c2859c1e21039c22355806e2d7907c93@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E3270260
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2005 15:45:05 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=897> 
======================================================================
Reported By:                phunge
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   897
Category:                   timer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-09-2005 15:45 CET
Last Modified:              02-09-2005 15:45 CET
======================================================================
Summary:                    test/timer.c malfunctions with snd-rtctimer
Description: 
I'm trying to learn how to use the ALSA timer API for getting a hi-res
interrupt in a program of mine. When I compile test/timer.c, it runs
correctly using the default system timer. However, when I try to specify
the RTC timer by modprobing snd-rtctimer and running

./timer class=1 sclass=0 card=0 device=1 subdevice=0

the program fails (output under "additional information").

/dev/rtc is readable and I can run the RTC test from
http://stommel.tamu.edu/~baum/linux-kernel/rtc.txt
so I think the problem is in alsa.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-09-05 15:45 phunge         New Issue                                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
