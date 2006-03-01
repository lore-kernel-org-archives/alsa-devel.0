From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001886]: Problems on reboot
Date: Wed, 1 Mar 2006 18:01:52 +0100
Message-ID: <5673eb22462169f9ceaec281d27b07e4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BD0CCA0
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 18:01:52 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1886> 
======================================================================
Reported By:                eric
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1886
Category:                   PCI - via82xx
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-01-2006 17:59 CET
Last Modified:              03-01-2006 18:01 CET
======================================================================
Summary:                    Problems on reboot
Description: 
Hi, i have little problem with my alsa configuration,

i use kernel 2.6.15 and alsa release 10RC3

on my configuration i use 

1 X snd-via82xx and 2 X snd-ice1724

sometime when i reboot i card as inverted and i have this udev message:

 VIA 82xx Audio: probe of 0000:00:11.5 failed with error -12

======================================================================

----------------------------------------------------------------------
 eric - 03-01-06 18:01 
----------------------------------------------------------------------
my modules.conf on kernel 2.6:

##### ALSA Config avmmanager START #####
alias char-major-116* snd
alias snd-timer-1* snd_rtctimer
alias snd-timer-2* snd_hpet

alias /dev/mixer* snd-mixer-oss
alias /dev/dsp* snd-pcm-oss
alias /dev/midi* snd-seq-oss

##### Card via id=0 #####
alias snd-card-0 snd-via82xx
options snd-via82xx index=0 dxs_support=3

##### Card terratec28 id=1 #####
alias snd-card-1 snd-ice1724
options snd-ice1724 index=1 model=phase28

##### Card terratec28 id=2 #####
alias snd-card-2 snd-ice1724
options snd-ice1724 index=2 model=phase28
##### ALSA Config avmmanager END #####

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-01-06 17:59 eric           New Issue                                    
03-01-06 18:01 eric           Note Added: 0008285                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
