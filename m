From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001863]: Roland ua-20 stops working
Date: Fri, 24 Feb 2006 17:17:00 +0100
Message-ID: <40b728217f8e521aa79e94637f3fa3aa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3836F1C3
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2006 17:17:01 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1863> 
======================================================================
Reported By:                ldk_linux
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1863
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian Sarge, SUSE Linux OSS
Kernel Version:             2.6.15
======================================================================
Date Submitted:             02-21-2006 13:25 CET
Last Modified:              02-24-2006 17:17 CET
======================================================================
Summary:                    Roland ua-20 stops working
Description: 
With the usb-audio alsa driver shipped with kernel 2.6.15 this unit (Roland
ua-20 audio & midi interface) stops working. Under a standard vanilla
kernel alsa clients (xmms, alsaplayer, jack) reports "unable to set hw
parameters" and quit. Under the kernel from the jacklab project
(http://jacklab.net/) no error message is visualized, all seems to work
but there is no audio output.

I've tested the unit with 2.6.12 and 2.6.13 kernels and it works
perfectly.
======================================================================

----------------------------------------------------------------------
 lemeur - 02-22-06 16:06 
----------------------------------------------------------------------
What is the ALSA driver version included in your kernel?

Your problem seems similar to this one:
--> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1585

Moreover, Florian Ladstaedter has reported this issue on the debia-kernel
mailing list (Bug#346070: linux-image-2.6.15-1-k7)
--> see http://lists.debian.org/debian-kernel/2006/01/msg00598.html

Can you compile and test the lastest ALSA driver?

----------------------------------------------------------------------
 ldk_linux - 02-24-06 17:17 
----------------------------------------------------------------------
It may be the same problem, but I know the driver for the UA-20 has been
recently updated, so there may be additional issues.
I don't have 2.6.15 installed anymore, but I can compile one patched with
the latest alsa drivers.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-21-06 13:25 ldk_linux      New Issue                                    
02-21-06 13:25 ldk_linux      Distribution              => Debian Sarge, SUSE
Linux OSS
02-21-06 13:25 ldk_linux      Kernel Version            => 2.6.15          
02-22-06 15:33 ldk_linux      Note Added: 0008158                          
02-22-06 15:36 ldk_linux      Note Edited: 0008158                         
02-22-06 16:06 lemeur         Note Added: 0008159                          
02-24-06 17:17 ldk_linux      Note Added: 0008180                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
