From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000549]: Jackd crash randomly
Date: Sun, 18 Sep 2005 13:53:21 +0200
Message-ID: <c150bceb6808c83febd064eb930b1664@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 18984152
	for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2005 13:53:21 +0200 (MEST)
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
Last Modified:              09-18-2005 13:53 CEST
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
 jdthood - 09-14-05 15:49 
----------------------------------------------------------------------
Submitter: Is the behavior any better in more recent ALSA versions?

----------------------------------------------------------------------
 roswel - 09-18-05 13:53 
----------------------------------------------------------------------
This seems not to happen anymore with recent alsa version. I actually have
no more problem with my Tascam us-122. I guess this bug should be closed.
Thanx a lot for the work of the all alsa team :)

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
09-18-05 13:53 roswel         Note Added: 0006271                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
