From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001280]: intel8x0m module causes "codec semaphore" errors when alsa is started
Date: Sun, 24 Jul 2005 19:52:02 +0200
Message-ID: <4f29f0e1731ed0ecef27a26fc6f1c1d0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 86B371B0
	for <alsa-devel@alsa-project.org>; Sun, 24 Jul 2005 19:52:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1280> 
======================================================================
Reported By:                fjpop
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   1280
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian (unstable)
Kernel Version:             2.6.12
======================================================================
Date Submitted:             07-24-2005 17:52 CEST
Last Modified:              07-24-2005 19:52 CEST
======================================================================
Summary:                    intel8x0m module causes "codec semaphore" errors
when alsa is started
Description: 
On my Toshiba Satellite A40, the intel8x0m module somehow conflicts with
running alsa-utils.
The kern.log shows repeated errors on boot and shutdown (when
/etc/init.d/alsa start/stop is run):
kernel: codec_semaphore: semaphore is not ready [0x1][0x701300]
kernel: codec_write 1: semaphore is not ready for register 0x54

If I do not load the intel8x0m module, the errors disappear.
The same problem occurrs with earlier kernels.

======================================================================

----------------------------------------------------------------------
 sashak - 07-24-05 19:52 
----------------------------------------------------------------------
Should be fixed in CVS. Could you check?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-24-05 17:52 fjpop          New Issue                                    
07-24-05 17:52 fjpop          Distribution              => Debian (unstable)
07-24-05 17:52 fjpop          Kernel Version            => 2.6.12          
07-24-05 19:52 sashak         Note Added: 0005559                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
