From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000705]: RME96 Driver crashes
Date: Tue, 7 Dec 2004 23:06:46 +0100
Message-ID: <17f1c6c14f8831a6442636064b49f2a6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 188A72A1
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2004 23:06:46 +0100 (MET)
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
Last Modified:              12-07-2004 23:06 CET
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
 tiwai - 12-07-04 18:44 
----------------------------------------------------------------------
Which version of JACK?
Did you start JACK with RT option?

----------------------------------------------------------------------
 FishB8 - 12-07-04 23:06 
----------------------------------------------------------------------
Version of JACK is latest from CVS. (0.99.18) It works with kernel 2.6.8
just fine.

Yes I started it with the RT option. I just checked and it starts ok when
I don't use that option. Is this a bug with JACK rather than the ALSA
driver? If so, why does the RT option work with the previous ALSA driver?

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
