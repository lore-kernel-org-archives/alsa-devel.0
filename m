From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001267]: snd-ioctl32 1.0.9 fails to load on sparc
Date: Tue, 19 Jul 2005 07:33:00 +0200
Message-ID: <d17ff2f4ed7699041b424bf8d05ddb40@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7E4B419D
	for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2005 07:33:00 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1267> 
======================================================================
Reported By:                eradicator
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1267
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux
Kernel Version:             2.6.12
======================================================================
Date Submitted:             07-19-2005 07:33 CEST
Last Modified:              07-19-2005 07:33 CEST
======================================================================
Summary:                    snd-ioctl32 1.0.9 fails to load on sparc
Description: 
There should really be a 'CORE - ioctl32' category... but anyways...

snd_ioctl32 doesn't load on sparc linux starting with 1.0.9 (not sure
about the rcs, I can narrow it down if you need me to).  The in-kernel (up
through 2.6.13-rc3-git4) and 1.0.8 drivers load fine.

$ modprobe snd_ioctl32
FATAL: Error inserting snd_ioctl32
(/lib/modules/2.6.13-rc3-git4-gentoo/alsa-driver/acore/ioctl32/snd-ioctl32.ko):
Unknown symbol in module, or unknown parameter (see dmesg)

$ dmesg | tail
<snip>
snd_ioctl32: Unknown symbol snd_pcm_hw_params


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-19-05 07:33 eradicator     New Issue                                    
07-19-05 07:33 eradicator     Distribution              => Gentoo Linux    
07-19-05 07:33 eradicator     Kernel Version            => 2.6.12          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
