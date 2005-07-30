From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001283]: Allegro-1 does not generate interrupts - but does on linux 2.4.27
Date: Sat, 30 Jul 2005 05:21:46 +0200
Message-ID: <d5cbceb0fab9b8b7b764fd811c715d9d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 409AE1A9
	for <alsa-devel@alsa-project.org>; Sat, 30 Jul 2005 05:21:46 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1283> 
======================================================================
Reported By:                sclark46
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1283
Category:                   PCI - maestro3
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.12-1.1398_FC4
======================================================================
Date Submitted:             07-27-2005 03:51 CEST
Last Modified:              07-30-2005 05:21 CEST
======================================================================
Summary:                    Allegro-1 does not generate interrupts - but does on
linux 2.4.27
Description: 
Aplay fails with a write error and the following error message:
Jul 26 21:06:14 joker4 kernel: ALSA
/home/sclark/alsa-driver-1.0.9rc4a/acore/pcm_native.c:1442: playback drain
error (DMA or IRQ trouble?)

The sound clip plays repeatedly until that error pops up.

I booted a Knoppix CD to verify the HW worked and sound played correctly.
The Knoppix kernel was 2.4.27


======================================================================

----------------------------------------------------------------------
 sclark46 - 07-30-05 05:21 
----------------------------------------------------------------------
Henry Yuan suggested I boot with lapic set and lo and behold this resolved
the problem on my HP N5430 laptop - so I guess this is not and alsa
problem

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-27-05 03:51 sclark46       New Issue                                    
07-27-05 03:51 sclark46       Distribution              => Fedora Core 4   
07-27-05 03:51 sclark46       Kernel Version            => 2.6.12-1.1398_FC4
07-27-05 03:52 sclark46       Issue Monitored: sclark46                    
07-27-05 03:52 sclark46       Issue End Monitor: sclark46                    
07-30-05 05:21 sclark46       Note Added: 0005588                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
