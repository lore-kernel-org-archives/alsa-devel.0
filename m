From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001520]: Soundchip was not detected
Date: Sat, 12 Nov 2005 19:33:47 +0100
Message-ID: <02f1003782d1933f9fbc51e771e68bf4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F1E5F189
	for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2005 19:33:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1520> 
======================================================================
Reported By:                Henne
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1520
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Slackware 9.0
Kernel Version:             2.6.14-rc4
======================================================================
Date Submitted:             11-01-2005 10:35 CET
Last Modified:              11-12-2005 19:33 CET
======================================================================
Summary:                    Soundchip was not detected
Description: 
I have an HP Omnibook 5700 CTX with some CS423x chip onboard, which is not
detected by alsaconf. I did not find the ids in cs4236.c so I think the
Pnp ID's
must added to this file.


======================================================================

----------------------------------------------------------------------
 Henne - 11-08-05 21:00 
----------------------------------------------------------------------
Sure, but I don't know where this patch is.
Please help.

----------------------------------------------------------------------
 Henne - 11-12-05 19:33 
----------------------------------------------------------------------
Okay,

I found, applied and run it. The chip is detected with alsaconf as a
cs4232 instead cs4236 and changes the modprobe.conf-file.

When I run modprobe snd-cs4232 (slackware 9.0 has no alsa-init-script), I
got a noise from the speakers and the kernel says:

ALSA (path to) cs4236.c:179: CS4232 WSS PnP manual resources are invalid,
using 
auto config

The modules are loaded.

Consulting the /proc - files I got:


/proc/ioports

...
0220-022f : CS4232 SB
...
0388-0389 : OPL2/3 (left)
038a-038b : OPL2/3 (right)
...
0534-0537 : CS4231
...


/proc/interrupts

...
5:     0     XT-PIC CS4231
...


/proc/dma

0: CS4231 - 2
1: CS4231 - 1
...


In /proc/asound I have a link CS4236 to card0

/proc/asound/cards
0 [CS4236]: CS4236 - CS4236
            CS4236 at 0x534, irq 5, dma 1&0

/proc/asound/devices
 4: [0- 0]: hardware dependent
16: [0- 0]: digital audio playback
24: [0- 0]: digital audio capture
 0: [0 -0]: ctl
33:       : timer


/proc/asound/card0/id

CS4236


/proc/asound/card0/pcm0c/info

...
id: CS4231
name: CS4236
...


So everything looks fine, but when I start alsamixer I get:

alsamixer: function snd_ctl_open failed for default: No such device


When starting aplay (without options) I get:

ALSA lib confmisc.c:672:(snd_func_card_driver) cannot find caro ´0´
and other "No such device" errors.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-01-05 10:35 Henne          New Issue                                    
11-01-05 10:35 Henne          Distribution              => Slackware 9.0   
11-01-05 10:35 Henne          Kernel Version            => 2.6.14-rc4      
11-08-05 18:48 tiwai          Note Added: 0006637                          
11-08-05 21:00 Henne          Note Added: 0006643                          
11-12-05 19:33 Henne          Note Added: 0006688                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
