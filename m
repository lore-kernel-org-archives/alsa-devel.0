From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001435]: ac97 codec is not found when loading the driver
Date: Mon, 19 Sep 2005 13:27:47 +0200
Message-ID: <1e8031861a205d56cdb65d73594a129d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 04797193
	for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2005 13:27:47 +0200 (MEST)
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
Last Modified:              09-19-2005 13:27 CEST
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
 sashak - 09-19-05 13:27 
----------------------------------------------------------------------
Please could you send us output of 'lspci -vv', content of files (audio
related) '/proc/asound/card0/atiixp' and
'/proc/asound/card0/atiixp/codec97#0/ac97#0-0'.
If you are with CVS version of ALSA, please configure it with option
'--with-debug=detect' and send us 'dmesg' output as well.

Thanks, Sasha.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-19-05 08:49 iluxa          New Issue                                    
09-19-05 08:49 iluxa          Kernel Version            => 2.6.13, 2.6.14-rc1
09-19-05 13:27 sashak         Note Added: 0006292                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
