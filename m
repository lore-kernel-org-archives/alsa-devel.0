From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001851]: No support for C-Media CMI9761 chip
Date: Tue, 2 May 2006 18:02:04 +0200
Message-ID: <a5ab7c4f1ffd6134d4b74091a47e9ba7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5FDEB19F
	for <alsa-devel@alsa-project.org>; Tue,  2 May 2006 18:02:04 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1851> 
======================================================================
Reported By:                duffymcdrew
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1851
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             2.6.12-10-386
======================================================================
Date Submitted:             02-17-2006 04:55 CET
Last Modified:              05-02-2006 18:02 CEST
======================================================================
Summary:                    No support for C-Media CMI9761 chip
Description: 
Recently installed Ubunut onto a new machine, and the sound is not working
at all.  I have an ASUS P4V8X-MX motherboard with an onboard VIA 8237 card
/ C-Media Electronics CMI9761 chip. Finally realized that ALSA soes not
support the CMI9761 chip.  Requesting a driver for this chipset.
======================================================================

----------------------------------------------------------------------
 nouguisa - 04-30-06 11:59 
----------------------------------------------------------------------
I encounter a similar problem with an ASUS A7N8X-XE board equiped with the
CMI9761A sound processor and Ubuntu dapper beta 2, Mandriva One beta 3 or
debian Sarge distributions.

Hardware : ASUS A7N8X-XE with Nforce2 MCP2-RAID, C-Media CMI9761A
Athlon XP 2000+, 2x256 Mb memory, ASUS A9250 graphic board, broadband
access.
Problem :
Installation of RealPlayer (file
realplay-10.0.7.785-linux-2.2-libc6-gcc32-i586)
When listening to the BBC, sound OK but :
1. sound master level has no effect on the sound level
2. Firefox reacts very slowly to mouse movements or keyboard actions

With ubuntu dapper :
/proc/asound/cards returns :
0 [CK8 ]: NFORCE - NVidia CK8
                     NVidia CK8 with CMI9761 at 0xff6ff000, irq 193

/proc/asound/oss/sndstat returns :
Sound Driver:3.8.1a-980706 (ALSA v1.0.10rc3 emulation code)
Kernel: Linux ubuntu 2.6.15-20-386 #1 PREEMPT Tue Apr 4 17:48:51 UTC 2006
i686
Config options: 0
Installed drivers:
Type 10: ALSA emulation
Card config:
NVidia CK8 with CMI9761 at 0xff6ff000, irq 193
Audio devices:
0: NVidia CK8 (DUPLEX)
Synth devices: NOT ENABLED IN CONFIG
Midi devices: NOT ENABLED IN CONFIG
Timers:
7: system timer
Mixers:
0: C-Media Electronics CMI9761

Sound loaded modules :
snd_intel8x0 33564 3
snd_ac97_codec 92704 1 snd_intel8x0
snd_ac97_bus 2304 1 snd_ac97_codec
snd_pcm_oss 53664 1
snd_mixer_oss 18688 2 snd_pcm_oss
snd_pcm 89736 3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer 25220 1 snd_pcm
snd 55268 8
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore 10208 3 snd
snd_page_alloc 10632 2 snd_intel8x0,snd_pcm

----------------------------------------------------------------------
 tiwai - 05-02-06 18:02 
----------------------------------------------------------------------
There is no driver for CM9761, and never be.  CM9761 is an AC97 codec chip,
not the sound core chip.  The driver you use is snd-via82xx.

Anyway, you're using too old version to debug.  Use ALSA 1.0.11.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-17-06 04:55 duffymcdrew    New Issue                                    
02-17-06 04:55 duffymcdrew    Distribution              => Ubuntu          
02-17-06 04:55 duffymcdrew    Kernel Version            => 2.6.12-10-386   
04-30-06 11:59 nouguisa       Note Added: 0009546                          
05-02-06 18:02 tiwai          Note Added: 0009563                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
