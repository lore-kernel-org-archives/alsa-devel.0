From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000549]: Jackd crash randomly
Date: Wed, 14 Sep 2005 15:49:03 +0200
Message-ID: <921cb8aa71d85a67507781abf2919558@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6A908191
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2005 15:49:03 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=549> 
======================================================================
Reported By:                roswel
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Issue ID:                   549
Category:                   USB - usb-usx2y
Reproducibility:            random
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Debian sid/experimental
Kernel Version:             2.6.9-rc2-bk14
======================================================================
Date Submitted:             09-29-2004 07:52 CEST
Last Modified:              09-14-2005 15:49 CEST
======================================================================
Summary:                    Jackd crash randomly
Description: 
Hi,
I still have some troubles with jackd. I rebuilt a kernel without
USB_CONFIG_BANDWITH and now jackd start without problem. But sometimes, it
hang with the following jackd error  : 
04:25:29.436 Audio connection graph change.
delay of 1022980.000 usecs exceeds estimated spare time of 17909.000;
restart ...
04:28:42.753 XRUN callback. (1)

I never have this error with my integrated chip using intel_i8x0 driver.
But wost, after a random time, jackd crash with the following error : 
ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe
could not start playback (Broken pipe)
jackd watchdog: timeout - killing jackd

And in my kernel logs, i've got : 
Sequence Error!(ep=10;nuc=1,frame=643)
Sequence Error!(ep=8;nuc=0,frame=643)
Sequence Error!(ep=8;nuc=1,frame=644)

Jackd crashs also if i'm not doing anything. I tried to let it run
sometimes without using it, and it crashs.

Thanx for your attention.
======================================================================

----------------------------------------------------------------------
 roswel - 10-05-04 08:32 
----------------------------------------------------------------------
Hummm i would just add, that the driver crash also if i don't use my
soundcard. After a random time, if my soundcard is plugged, i got the
following message in my kernel logs :
ALSA
/home/roswel/Devel/alsa/alsa-driver/alsa-kernel/usb/usx2y/usbusx2yaudio.c:263:
Sequence Error!(ep=10;wait=628,frame=629).
Most propably some urb of usb-frame 628 is still missing.
Cause could be too long delays in usb-hcd interrupt handling.
This driver definitely wants 1 interrupt per ms.
To make it work for a system that can't deliver interrupts reliably at
that rate,
You'd have to make it work for NRPACKS > 1. To start, grep for NRPACKS in
this code ;-)

----------------------------------------------------------------------
 jdthood - 09-14-05 15:49 
----------------------------------------------------------------------
Submitter: Is the behavior any better in more recent ALSA versions?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-29-04 07:52 roswel         New Issue                                    
09-29-04 07:52 roswel         Distribution              => Debian
sid/experimental
09-29-04 07:52 roswel         Kernel Version            => 2.6.9-rc2-bk14  
09-29-04 07:52 roswel         Issue Monitored: roswel                      
10-01-04 01:24 karsten        Note Added: 0001989                          
10-01-04 10:07 roswel         Note Added: 0001996                          
10-01-04 15:27 karsten        File Added: snd-usb-usx2y.patch.0.8.0             
      
10-01-04 15:29 karsten        Note Added: 0001998                          
10-01-04 19:06 roswel         Note Added: 0002004                          
10-05-04 08:32 roswel         Note Added: 0002015                          
09-14-05 15:49 jdthood        Note Added: 0006159                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
