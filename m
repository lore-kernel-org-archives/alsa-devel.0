From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000744]: no sound
Date: Thu, 23 Dec 2004 23:34:21 +0100
Message-ID: <3a9407b0d3dc6f81c91dae0b42f5f934@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 04ABC28A
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2004 23:34:21 +0100 (MET)
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


The following issue has been SUBMITTED.
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
Status:                     assigned
Distribution:               PLD
Kernel Version:             2.6.8
======================================================================
Date Submitted:             12-23-2004 23:34 CET
Last Modified:              12-23-2004 23:34 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-23-04 23:34 kluczus        New Issue                                    
12-23-04 23:34 kluczus        Distribution              => PLD             
12-23-04 23:34 kluczus        Kernel Version            => 2.6.8           
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
