From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000705]: RME96 Driver crashes
Date: Thu, 16 Dec 2004 18:27:35 +0100
Message-ID: <a979e7ad23db209e1ce884645528ba69@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DB058249
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2004 18:27:35 +0100 (MET)
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
Last Modified:              12-16-2004 18:27 CET
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
 martin - 12-15-04 20:06 
----------------------------------------------------------------------
Yes, same result with POSIX SHM support :(

----------------------------------------------------------------------
 tiwai - 12-16-04 18:27 
----------------------------------------------------------------------
Could you try the old version of JACK (e.g. 0.98.x) to check the changes
for swparams threshold in the recent JACK version has any influence on the
behavior on rme32/96?

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
12-15-04 06:09 FishB8         Note Added: 0002825                          
12-15-04 20:06 martin         Note Added: 0002828                          
12-16-04 18:27 tiwai          Note Added: 0002835                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
