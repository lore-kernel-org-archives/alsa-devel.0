From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000549]: Jackd crash randomly
Date: Fri,  1 Oct 2004 15:29:36 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041001132936.8211D2D0C1@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6244D1AE
	for <alsa-devel@alsa-project.org>; Fri,  1 Oct 2004 15:29:37 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000549
======================================================================
Reported By:                roswel
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Bug ID:                     549
Category:                   USB - usb-usx2y
Reproducibility:            random
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Debian sid/experimental
Kernel Version:             2.6.9-rc2-bk14
======================================================================
Date Submitted:             09-29-2004 07:52 CEST
Last Modified:              10-01-2004 15:29 CEST
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
 karsten - 10-01-2004 01:24 CEST 
----------------------------------------------------------------------
please recheck snd-usb-usx2y version 0.8.0, which I posted to the
alsa-devel list.

----------------------------------------------------------------------
 roswel - 10-01-2004 10:07 CEST 
----------------------------------------------------------------------
How to get it, i'm not subscribe to alsa-devel list. Can you forward me
your mail? or give me a link kto download it please.

----------------------------------------------------------------------
 karsten - 10-01-2004 15:29 CEST 
----------------------------------------------------------------------
I've uploaded it here now too.
apply it against a fresh new alsa tree.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-29-04 07:52 roswel         New Bug                                      
09-29-04 07:52 roswel         Distribution              => Debian sid/experimental
09-29-04 07:52 roswel         Kernel Version            => 2.6.9-rc2-bk14  
09-29-04 07:52 roswel         Bug Monitored: roswel                        
10-01-04 01:24 karsten        Bugnote Added: 0001989                       
10-01-04 10:07 roswel         Bugnote Added: 0001996                       
10-01-04 15:27 karsten        File Added: snd-usb-usx2y.patch.0.8.0                    
10-01-04 15:29 karsten        Bugnote Added: 0001998                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
