From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000705]: RME96 Driver crashes
Date: Sun, 12 Dec 2004 20:04:15 +0100
Message-ID: <69af656a9249fbab42f46d67a3eabe68@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2FF9A2C2
	for <alsa-devel@alsa-project.org>; Sun, 12 Dec 2004 20:04:16 +0100 (MET)
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
Last Modified:              12-12-2004 20:04 CET
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
 tiwai - 12-09-04 11:22 
----------------------------------------------------------------------
The crash of JACK is because of RT process.  You'd better to contact with
JACK developer ML for debugging this.

Maybe the older version of rme96 driver worked casually because its (a
kind of fake) implementation of mmap mode.

Martin, does the latest rme32 work with JACK?

----------------------------------------------------------------------
 martin - 12-12-04 20:04 
----------------------------------------------------------------------
Actually, my -nearly embedded- rme32 system is a little bit slow for "jackd
-R". But jackd aborts it cleanly.
Are you using alsa-lib 1.0.7? IIRC there were some iomem mmap related
changes in the lib, too. So far, my jackd (compiled with alsa-lib 1.0.7)
is running normally.  I don't believe that it's rme96 specific. I will try
my card on a faster system...

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
