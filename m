From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000897]: test/timer.c malfunctions with snd-rtctimer
Date: Mon, 14 Feb 2005 11:35:55 +0100
Message-ID: <1dcec0e4a0cf84cd8e9ef4f9850db6ac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DA65421D
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 11:35:55 +0100 (MET)
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
Last Modified:              02-14-2005 11:35 CET
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

----------------------------------------------------------------------
 Clemens Ladisch - 02-14-05 10:47 
----------------------------------------------------------------------
Works fine on my machine (kernel 2.4.18 with RTC patch).
Which kernel version are you using?

$ ./timer class=1 sclass=0 card=0 device=1 subdevice=0
Using timer class 1, slave class 0, card 0, device 1, subdevice 0
Timer info:
  slave = no
  card = -1
  id = 'rtc'
  name = 'RTC timer'
  average resolution = 976562
Using 20 tick(s)
STATUS:
  resolution = 976562
  lost = 0
  overrun = 0
  queue = 0
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
TIMER: resolution = 976562ns, ticks = 20
STATUS:
  resolution = 976562
  lost = 0
  overrun = 0
  queue = 0
Done

----------------------------------------------------------------------
 phunge - 02-14-05 11:35 
----------------------------------------------------------------------
I'm using 2.6.8-1-686 from Debian woody. I will try again with kernel.org
2.6, and if that doesn't work I'll try 2.4.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-09-05 15:45 phunge         New Issue                                    
02-14-05 10:47 Clemens LadischNote Added: 0003587                          
02-14-05 11:35 phunge         Note Added: 0003589                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
