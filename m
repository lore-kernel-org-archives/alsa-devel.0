From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001062]: creative mp3+ doesnt work with external usb hub
Date: Wed, 22 Mar 2006 03:27:16 +0100
Message-ID: <2bb7503768aa319e9e1bde2409515bc8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A5BF81A7
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:27:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1062> 
======================================================================
Reported By:                TheCoop
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1062
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.12-rc2-mm3
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             04-18-2005 12:04 CEST
Last Modified:              03-22-2006 03:27 CET
======================================================================
Summary:                    creative mp3+ doesnt work with external usb hub
Description: 
My usb creative mp3+ only works when it is plugged directly into the
computer. When it is plugged into an external usb hub, sound doesnt play
(the timer is stuck at 0:00), the following appears in the command line:
ALSA lib pcm_hw.c:563:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe
ALSA lib pcm_hw.c:563:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe
ALSA lib pcm_hw.c:563:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe

and the following appears in dmesg:
cannot submit datapipe for urb 0, err = -38
cannot submit datapipe for urb 0, err = -38
cannot submit datapipe for urb 0, err = -38

Details at http://forums.gentoo.org/viewtopic-t-272854.html
======================================================================

----------------------------------------------------------------------
 andersin - 08-26-05 02:08 
----------------------------------------------------------------------
I have a similar problem with my SB Extigy. However, I do not get the same
error message. Here is what I get in dmesg:
ALSA [...]/alsa-driver-1.0.9b/usb/usbaudio.c:771: cannot submit datapipe
for urb 0, err = -28
ALSA [...]//alsa-driver-1.0.9b/usb/usbmidi.c:178: urb status -108

[...] inserted to improve readability.

I tried this with kernel 2.6.12.1 and 2.6.13.

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:27 
----------------------------------------------------------------------
Not an ALSA bug

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-18-05 12:04 TheCoop        New Issue                                    
04-18-05 12:04 TheCoop        Distribution              => Gentoo          
04-18-05 12:04 TheCoop        Kernel Version            => 2.6.12-rc2-mm3  
04-25-05 10:45 Clemens LadischNote Added: 0004570                          
08-26-05 02:08 andersin       Note Added: 0005945                          
03-22-06 03:27 rlrevell       Status                   assigned => closed  
03-22-06 03:27 rlrevell       Note Added: 0008819                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
