From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000705]: RME96 Driver crashes
Date: Mon, 13 Dec 2004 19:28:27 +0100
Message-ID: <0cde21842fd208be47690604352c8876@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 93209259
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2004 19:28:27 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=705> 
======================================================================
Reported By:                FishB8
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   705
Category:                   PCI - RME 96
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-03-2004 23:43 CET
Last Modified:              12-13-2004 19:28 CET
======================================================================
Summary:                    RME96 Driver crashes
Description: 
Something has changed in the RME96 driver between 1.0.6 and 1.0.7 causeing
it to crash. Whenever an audio program uses ALSA and stops playing the
driver hangs. When trying to start JACK, it never gets started but the CPU
hits 100%. It's impossible to kill any of the programs because any program
dealing with processes hangs as well. The system will not totally shut
down and has to be reset. Kernel 2.6.8 works just fine.
======================================================================

----------------------------------------------------------------------
 FishB8 - 12-12-04 23:35 
----------------------------------------------------------------------
In case it makes any difference, my configure options for jack are:

./configure --prefix=/usr --enable-posix-shm --enable-mmx --enable-sse
--enable-timestamps --enable-preemption-check --enable-capabilities
--disable-oldtrans --disable-portaudio --disable-oss

(currently using 0.99.28)

CFLAGS/CXXFLAGS are:

-O3 -march=athlon-xp -mfpmath=sse -mmmx -msse -m3dnow -funroll-loops
-fprefetch-loop-arrays -fomit-frame-pointer -pipe


alsalib is 1.0.7

----------------------------------------------------------------------
 martin - 12-13-04 19:28 
----------------------------------------------------------------------
still no progress. jackd aborts on different machines always (more or less
cleanly) with my rme32: 

#jackd -R -d alsa -P hw:x,0:

jackd 0.99.30
JACK compiled with System V SHM support.
loading driver ..
creating alsa driver ... hw:0,0|-|1024|2|48000|0|0|nomon|swmeter|-|32bit
control device hw:0
configuring for 48000Hz, period = 1024 frames, buffer = 2 periods
nperiods = 16 for playback
Noise-shaped dithering at 16 bits
too many consecutive interrupt delays ... engine pausing
cycle execution failure, exiting
DRIVER NT: could not run driver cycle
delay of 298841.000 usecs exceeds estimated spare time of 20897.000;
restart ...
delay of 298841.000 usecs exceeds estimated spare time of 20897.000;
restart ...
delay of 298841.000 usecs exceeds estimated spare time of 20897.000;
restart ...
delay of 298841.000 usecs exceeds estimated spare time of 20897.000;
restart ...
delay of 298841.000 usecs exceeds estimated spare time of 20897.000;
restart ...
delay of 298841.000 usecs exceeds estimated spare time of 20897.000;
restart ...
delay of 298841.000 usecs exceeds estimated spare time of 20897.000;
restart ...
delay of 298841.000 usecs exceeds estimated spare time of 20897.000;
restart ...
delay of 298841.000 usecs exceeds estimated spare time of 20897.000;
restart ...
delay of 298841.000 usecs exceeds estimated spare time of 20897.000;
restart ...
delay of 298841.000 usecs exceeds estimated spare time of 20897.000;
restart ...
jack main caught signal 12
received signal 2 during shutdown (ignored)
jackd watchdog: timeout - killing jackd
Killed

Well, OTOH my via82xx runs fine with the same command on the same
machine.

Hmm, I don't see the core of the problem. It's so dark ... I'm a little
bit lost.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-03-04 23:43 FishB8         New Issue                                    
12-03-04 23:43 FishB8         File Added: config                           
12-03-04 23:43 FishB8         Distribution              => Gentoo          
12-03-04 23:43 FishB8         Kernel Version            => 2.6.9           
12-04-04 12:30 martin         Note Added: 0002715                          
12-04-04 17:56 FishB8         Note Added: 0002717                          
12-04-04 19:21 FishB8         Note Added: 0002718                          
12-04-04 20:18 eradicator     Issue Monitored: eradicator                    
12-07-04 18:44 tiwai          Note Added: 0002758                          
12-07-04 23:06 FishB8         Note Added: 0002768                          
12-08-04 12:08 tiwai          Note Added: 0002776                          
12-09-04 00:22 FishB8         Note Added: 0002796                          
12-09-04 11:22 tiwai          Note Added: 0002798                          
12-12-04 20:04 martin         Note Added: 0002819                          
12-12-04 23:35 FishB8         Note Added: 0002820                          
12-13-04 19:28 martin         Note Added: 0002822                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
