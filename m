From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001170]: since update to 1.0.9 sound is not clear but noisy
Date: Mon, 13 Jun 2005 12:23:33 +0200
Message-ID: <46f1c4df93656d62bb4794800777bb7d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E5CF21B4
	for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2005 12:23:33 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1170> 
======================================================================
Reported By:                dpinte
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1170
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.11-5
======================================================================
Date Submitted:             06-08-2005 10:09 CEST
Last Modified:              06-13-2005 12:23 CEST
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
 jdthood - 06-13-05 10:27 
----------------------------------------------------------------------
> We can close this

Are we sure that there is no bug in alsa-lib?  After all, esound
worked until the 1.0.9 release.

----------------------------------------------------------------------
 tiwai - 06-13-05 12:23 
----------------------------------------------------------------------
esound doesn't check the return value of snd_pcm_writei().
That's why it doesn't work with plug:dmix properly.

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
