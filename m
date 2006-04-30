From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002086]: Module fails to load
Date: Sun, 30 Apr 2006 13:22:04 +0200
Message-ID: <19546b28de2456e868f77e3e584d6da5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D3CAC19F
	for <alsa-devel@alsa-project.org>; Sun, 30 Apr 2006 13:22:04 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2086> 
======================================================================
Reported By:                psgood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2086
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-30-2006 12:53 CEST
Last Modified:              04-30-2006 13:22 CEST
======================================================================
Summary:                    Module fails to load
Description: 
Have tried this with various kernels now from 2.6.15 to .17-rc3.

The module compiles fine, installs fine, even comes up in lsmod, but I get
this error on module insertion

ERROR: snd-cs46xx: never read ISV3 & ISV4 from AC'97
    Try reloading the ALSA driver, if you find something
    broken or not working on your soundcard upon
    this message please report to alsa-devel@lists.sourceforge.net

Soundcard is a Gametheater XP 5.1. The last kernel I had on here was
2.6.13 and it worked fine under that without this error. Have tried with
kernel drivers, manual download of drivers, with and without the debian
standard alsa tools. The NEW_DSP code is also enabled in all instances.

I have also tried with and without udev installed, to see if that was
causing an issue.

This also halts my intel8x0 card from working as well. Whatever is causing
it virtually causes all the alsactl stuff to die.

Output of lsmod:
snd_cs46xx             78024  0
snd_intel8x0           31772  0
snd_rawmidi            24608  1 snd_cs46xx
snd_seq_device          8972  1 snd_rawmidi
snd_ac97_codec         85024  2 snd_cs46xx,snd_intel8x0
snd_ac97_bus            3328  1 snd_ac97_codec
snd_pcm                78340  3 snd_cs46xx,snd_intel8x0,snd_ac97_codec
snd_timer              22916  1 snd_pcm
snd                    52192  7
snd_cs46xx,snd_intel8x0,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm,snd_timer
snd_page_alloc         10504  3 snd_cs46xx,snd_intel8x0,snd_pcm
soundcore              10848  1 snd

Output of /proc/asound/cards

pontius:/etc/modprobe.d# cat /proc/asound/cards
--- no soundcards ---



======================================================================

----------------------------------------------------------------------
 psgood - 04-30-06 13:22 
----------------------------------------------------------------------
Further to this, I have discovered that the issue is sporadic. Perhaps one
time in 10, the issue won't occur and everything comes up as normal.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-30-06 12:53 psgood         New Issue                                    
04-30-06 13:13 psgood         Issue Monitored: psgood                      
04-30-06 13:22 psgood         Note Added: 0009547                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
