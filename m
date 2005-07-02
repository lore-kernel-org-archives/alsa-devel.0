From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001227]: Audio output to headphone changes mapping when JACKD XRUN
Date: Sat, 2 Jul 2005 04:32:06 +0200
Message-ID: <1ecb9549d47a2b645c82757f6c650de7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 863DD1AE
	for <alsa-devel@alsa-project.org>; Sat,  2 Jul 2005 04:32:06 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1227> 
======================================================================
Reported By:                rfonseca
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1227
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 3 with real time smp kernel from ccrma
Kernel Version:             2.6.10-2.1.ll.rhfc3.ccrmasmp
======================================================================
Date Submitted:             07-02-2005 01:24 CEST
Last Modified:              07-02-2005 04:32 CEST
======================================================================
Summary:                    Audio output to headphone changes mapping when JACKD
XRUN
Description: 
When running jack and there is an XRUN, the mapping of which output goes to
the headphone jack changes. For example, suppose there is an app connected
(via JACK) to playback_1 and playback_2 (controlled by mixer PCM).
Sometimes when there is an XRUN, the output will stop. Suddenly, the
output jack  (the headphones) is now fed by the surround channel. If I
connect the same application to playback_3 and playback_4, I can hear the
output, and the volume is controlled by mixer "Surround". Furhter XRUNS
will move the output to playback_5 and playback_6, and even other
combinations.
======================================================================

----------------------------------------------------------------------
 rlrevell - 07-02-05 03:10 
----------------------------------------------------------------------
Weird, it must be a driver bug then.

I guess you are using the ALSA that came with your kernel, can you try
ALSA CVS or 1.0.9b?

----------------------------------------------------------------------
 rfonseca - 07-02-05 04:32 
----------------------------------------------------------------------
I did download 1.09b (alsa-drivers), then dir configure; make; make
install; reboot. The rest of the alsa packages (alsa-oss, alsa-lib,
alsa-firmware) are 1.09rc1.

Same problem was reproduced. There does seem to be a pattern: output gets
mapped to playback_1 and 2, then 3 and 4, then 5 and 6.

Will download all packages to be 1.09b.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-02-05 01:24 rfonseca       New Issue                                    
07-02-05 01:24 rfonseca       Distribution              => Fedora Core 3 with
real time smp kernel from ccrma
07-02-05 01:24 rfonseca       Kernel Version            =>
2.6.10-2.1.ll.rhfc3.ccrmasmp
07-02-05 01:37 rfonseca       Note Added: 0005345                          
07-02-05 01:39 rfonseca       Issue Monitored: rfonseca                    
07-02-05 02:46 rfonseca       Note Added: 0005346                          
07-02-05 02:55 rlrevell       Note Added: 0005347                          
07-02-05 03:03 rfonseca       Note Added: 0005348                          
07-02-05 03:10 rlrevell       Note Added: 0005349                          
07-02-05 04:32 rfonseca       Note Added: 0005351                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
