From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001435]: ac97 codec is not found when loading the driver
Date: Wed, 21 Sep 2005 22:24:03 +0200
Message-ID: <f1d498ca2fc45e8b124319f7448f07b7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E129F181
	for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2005 22:24:03 +0200 (MEST)
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
Last Modified:              09-21-2005 22:24 CEST
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
 iluxa - 09-20-05 01:15 
----------------------------------------------------------------------
Well, as far as failure to detect - it seems that both drivers notice this
codec,
but whichever of them grabs it first, marks it as audio or modem codec
respectively, and atiixp and atiixp-modem think that it is exclusive
(they
call snd_ac97_mixer with ac97.scaps SKIP_AUDIO/SKIP_MODEM flag set)

I tried loading snd-atiixp-modem before snd-atiixp, and modem driver
loaded, while 
audio did not. Now, question is if there is anything that could be done to
actuall
support modem (I don't think it actually worked even though it loaded fine
by itself)

----------------------------------------------------------------------
 sashak - 09-21-05 22:24 
----------------------------------------------------------------------
Obviously the codec detection code is buggy in both drivers. Try please
uploaded patch (against CVS).

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
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
