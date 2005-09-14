From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000744]: no sound
Date: Wed, 14 Sep 2005 16:11:46 +0200
Message-ID: <2ef4280c2d875c06551c34eba9ae86c2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B95E51A3
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2005 16:11:46 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=744> 
======================================================================
Reported By:                kluczus
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   744
Category:                   PCI - es1968
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               PLD
Kernel Version:             2.6.8
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             12-23-2004 23:34 CET
Last Modified:              09-14-2005 16:11 CEST
======================================================================
Summary:                    no sound
Description: 
on the notebook armada e500 i have a sound card ESS 1978, device was
detected but i have no sound (module es1968), alsamixer is telling me that
"snd_ctl_open failed for default: no such file or directory",
in modprobe.conf i have "alias char-major-116 snd
alias snd-card-0 snd-es1968
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
options snd major=116 cards_limit=1 device_mode=0660
options snd-es1968 index=0
"
on the OSS with module maestro it was worknig but i want to use alsa :)
the same problem with alsa on this equipment i have also on Fedora3

sorry for my english, i hope that you uderstand me :)
======================================================================

----------------------------------------------------------------------
 tiwai - 12-27-04 19:35 
----------------------------------------------------------------------
Make sure that the driver is really loaded and initialized.
Check /proc/asound/cards whether you have the valid entry.

If yes, it's likely the problem of device files.  Check whether you have
valid /dev/snd/* device files (and proper permissions).

----------------------------------------------------------------------
 jdthood - 09-14-05 16:11 
----------------------------------------------------------------------
Presumably a local problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-23-04 23:34 kluczus        New Issue                                    
12-23-04 23:34 kluczus        Distribution              => PLD             
12-23-04 23:34 kluczus        Kernel Version            => 2.6.8           
12-26-04 15:06 kluczus        Issue Monitored: kluczus                     
12-27-04 19:35 tiwai          Note Added: 0002974                          
09-14-05 16:11 jdthood        Status                   assigned => closed  
09-14-05 16:11 jdthood        Note Added: 0006176                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
