From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001280]: intel8x0m module causes "codec semaphore" errors when alsa is started
Date: Mon, 25 Jul 2005 21:01:54 +0200
Message-ID: <4be83805f332539c87d6573424521c78@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B39A6192
	for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2005 21:01:54 +0200 (MEST)
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
Last Modified:              07-25-2005 21:01 CEST
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

----------------------------------------------------------------------
 fjpop - 07-25-05 21:01 
----------------------------------------------------------------------
Hi,
Thanks for the quick response.

I grabbed the following files from CVS:
intel8x0.c  (1.204)
intel8x0m.c (1.33)

Was that what you intended?

I had to rip out all the .vendor => .subvendor and .device => .subdevice
changes out of intel8x0.c, but after that it compiled fine with my Debian
2.6.12 kernel.

After booting the kernel I noticed this message in the boot log when
/etc/init.d/alsa was started:
Setting up ALSA.../etc/init.d/alsa: Warning: 'alsactl restore' failed with
error message 'alsactl: set_control:873: failed to obtain info for control
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 (No such file or
directory)'. done.
However, on '/etc/init.d/alsa restart' that message was gone. I guess just
due to a change in the driver?

The original error message about codec_semaphore was gone. Nice :-)
I played a few sound files without problems.
I have not tried to use the modem device.

Hope this helps.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-24-05 17:52 fjpop          New Issue                                    
07-24-05 17:52 fjpop          Distribution              => Debian (unstable)
07-24-05 17:52 fjpop          Kernel Version            => 2.6.12          
07-24-05 19:52 sashak         Note Added: 0005559                          
07-25-05 21:01 fjpop          Note Added: 0005565                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
