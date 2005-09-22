From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001435]: ac97 codec is not found when loading the driver
Date: Thu, 22 Sep 2005 06:44:25 +0200
Message-ID: <4970935c9eca7a5f5eefb528bf60cd59@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A5DFA176
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 06:44:25 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1435> 
======================================================================
Reported By:                iluxa
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   1435
Category:                   PCI - atiixp-modem
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.13, 2.6.14-rc1
======================================================================
Date Submitted:             09-19-2005 08:49 CEST
Last Modified:              09-22-2005 06:44 CEST
======================================================================
Summary:                    ac97 codec is not found when loading the driver
Description: 
When loading snd-tiixp-modem _after_ loading snd-atiixp, I get a message
saying
"atiixp-modem: no codec available" and modem doesn't function after that.

Little more investigation shown that snd_ac97_mixer thinks the codec is
already 
registered as sound codec by audio card driver.

I'v tried alsa-1.0.9, driver included in 2.6.13, 2.6.14-rc1 and drivers
from CVS HEAD - all with same result.


======================================================================

----------------------------------------------------------------------
 sashak - 09-22-05 02:39 
----------------------------------------------------------------------
> Of course - there is a question wether making it unconditionally unshared
is
> appropriate. Perhaps there are other cards, with MC97 codec, that
_should_ be
> shared... 

The shared "lock" was done some time ago to prevent ac97 bus
reinitialization, actually this should protect your audio (atiixp) from
modem and vice versa (and in our case this "protects" second driver very
well :)).

Since that codec initialization was modified and SKIP_AUDIO,SKIP_MODEM
flags were introduced. I've reviewed briefly ac97_codec.c codec now, and
seems that this is almost safe to "unshare" audio and modem codecs.

Uploaded patch is some cleanup in this area (it masks likely safe but
useless for modem operation). Try something like this:
- unload both atiixp and atiixp-modem
- load atiixp, start to play sound
- load atiixp-modem - this should break nothing with audio

----------------------------------------------------------------------
 iluxa - 09-22-05 06:44 
----------------------------------------------------------------------
Yes, sound works fine with the patch, no interruption happens when I load
modem driver

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-19-05 08:49 iluxa          New Issue                                    
09-19-05 08:49 iluxa          Kernel Version            => 2.6.13, 2.6.14-rc1
09-19-05 13:27 sashak         Note Added: 0006292                          
09-19-05 19:32 iluxa          File Added: pci.txt                          
09-19-05 19:56 iluxa          File Added: comment.diff                     
09-19-05 19:57 iluxa          Note Added: 0006296                          
09-19-05 20:01 iluxa          File Added: atiixp.txt                       
09-19-05 20:01 iluxa          File Added: codec97_0_ac97_0-0.txt                
   
09-19-05 20:07 iluxa          Note Added: 0006298                          
09-19-05 23:30 sashak         File Deleted: comment.diff                    
09-19-05 23:38 sashak         Note Added: 0006304                          
09-19-05 23:41 iluxa          File Added: codec97_0_ac97_0-0+regs.txt           
        
09-19-05 23:44 iluxa          Note Added: 0006306                          
09-20-05 01:03 sashak         File Added: atiixp-debug.patch                    
09-20-05 01:06 sashak         Note Added: 0006307                          
09-20-05 01:15 iluxa          Note Added: 0006308                          
09-21-05 22:24 sashak         Note Added: 0006325                          
09-21-05 22:24 sashak         File Added: atiixp-codec-detection.patch          
         
09-21-05 22:38 sashak         Note Added: 0006326                          
09-21-05 23:03 iluxa          Note Added: 0006328                          
09-21-05 23:05 iluxa          Note Added: 0006329                          
09-21-05 23:37 sashak         File Added: atiixp-modem-unshared.patch           
        
09-21-05 23:40 sashak         Note Added: 0006330                          
09-21-05 23:57 iluxa          Note Added: 0006331                          
09-22-05 00:01 iluxa          File Added: card1_codec97_0_mc97_0-0              
     
09-22-05 00:02 iluxa          File Added: card1_codec97_0_mc97_0-0+regs         
          
09-22-05 00:02 iluxa          Note Added: 0006332                          
09-22-05 02:21 sashak         File Added: ac97-unshared.patch                   

09-22-05 02:39 sashak         Note Added: 0006333                          
09-22-05 06:44 iluxa          Note Added: 0006334                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
