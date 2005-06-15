From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001170]: since update to 1.0.9 sound is not clear but noisy
Date: Wed, 15 Jun 2005 14:04:15 +0200
Message-ID: <12e65eafb3e958d39fc6912239d9e732@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E20131ED
	for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2005 14:04:15 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1170> 
======================================================================
Reported By:                dpinte
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1170
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.11-5
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             06-08-2005 10:09 CEST
Last Modified:              06-15-2005 14:04 CEST
======================================================================
Summary:                    since update to 1.0.9 sound is not clear but noisy
Description: 
Hi,

On my Debian/Sid, everything was ok since update to 1.0.9 (and 1.0.8 in
the same upgrade). There were no other changes than alsa updates. 

I'm running the Debian kernel-image-2.6.11-1-686.

I've tested aplay without success, sound is noisy. I've also tested to
reboot without my snd_intel8x0m module without changes.

Here are the modules loaded :

did@geru-itea:~$ lsmod | grep snd
snd_intel8x0           33216  2
snd_ac97_codec         78360  1 snd_intel8x0
snd_pcm_oss            53344  0
snd_mixer_oss          19872  2 snd_pcm_oss
snd_pcm                92712  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              24644  1 snd_pcm
snd                    55300  8
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               9664  2 snd
snd_page_alloc         10020  2 snd_intel8x0,snd_pcm

======================================================================

----------------------------------------------------------------------
 tiwai - 06-13-05 12:23 
----------------------------------------------------------------------
esound doesn't check the return value of snd_pcm_writei().
That's why it doesn't work with plug:dmix properly.

----------------------------------------------------------------------
 jdthood - 06-14-05 15:03 
----------------------------------------------------------------------
>  esound doesn't check the return value of snd_pcm_writei().
> That's why it doesn't work with plug:dmix properly.

Thanks for the explanation.

I have contacted the people who reported the problem and I will try to
find out whether fixing esd suffices to eliminate it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-05 10:09 dpinte         New Issue                                    
06-08-05 10:09 dpinte         Kernel Version            => 2.6.11-5        
06-08-05 10:21 dpinte         Note Added: 0004916                          
06-08-05 14:20 dpinte         Note Added: 0004918                          
06-08-05 14:27 tiwai          Note Added: 0004920                          
06-08-05 14:53 dpinte         Note Added: 0004925                          
06-13-05 10:27 jdthood        Note Added: 0005004                          
06-13-05 12:23 tiwai          Note Added: 0005005                          
06-14-05 15:03 jdthood        Note Added: 0005017                          
06-14-05 15:07 jdthood        Category                 1_OTHERS => PCI -
intel8x0
06-15-05 14:04 jdthood        Status                   new => resolved     
06-15-05 14:04 jdthood        Additional Information Updated                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
