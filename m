From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001520]: Soundchip was not detected
Date: Thu, 16 Mar 2006 13:57:03 +0100
Message-ID: <9025c863e71d1a0c1f0146dd00ad8129@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 17A0E1DC
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 13:57:04 +0100 (MET)
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
Last Modified:              03-16-2006 13:57 CET
======================================================================
Summary:                    Soundchip was not detected
Description: 
I have an HP Omnibook 5700 CTX with some CS423x chip onboard, which is not
detected by alsaconf. I did not find the ids in cs4236.c so I think the
Pnp ID's
must added to this file.


======================================================================

----------------------------------------------------------------------
 Henne - 02-06-06 09:34 
----------------------------------------------------------------------
Here I'am again!

I'm now using kernel 2.6.16-rc2 and nothing changed, but I found out, that
the oss driver works well, so I try to look what he's doing, look what the
alsa-driver isn't doing and then make the alsa driver doing this.

----------------------------------------------------------------------
 Henne - 03-16-06 13:57 
----------------------------------------------------------------------
I've played a little bit with my OMNIBOOK 5700 CTX and found out more.
In the BIOS there are two switches which seem to have something to do
with:

1. Fast Boot (a hint from kerneltrap) which was enabled, so I disabled it,
and
2. Boot Configuration (was switched to "Auto-detect") the two other
settings are "Full (DOS, Windows 3.x)" (now chosen by me) and "Boot
devices only (Plug 'n Play)"

The OSS-driver works and ALSA won't.
modprobe snd-cs4232 makes the kernel say:

pnp: the driver 'cs4232-pnpbios' has been registered
pnp: match found with the PnP device '00:10' and the driver
'cs4232-pnpbios'

(that were the good news)

ALSA sound/isa/cs423x/cs4236.c:293: CS4232 WSS PnP manual resources are
invalid, using auto config
CS4232 WSS PnP configure failed for WSS (out of resources?)
PnP BIOS detection failed for CS4232
pnp: Device 00:10 disabled.
cs4232-pnpbios: probe of 00:10 failed with error -1

snd_cs423x_pnp_init_wss() is the function where the init fails,
in detail
 err = pnp_manual_config_dev(pdev, cfg, 0);

I've also tried:

modprobe snd-cs4232 port=0x534 fm_port=0x388 sb_port=0x220 irq=0x05
dma1=0x1 
dma2=0x0

with the same result.

Any ideas?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-01-05 10:35 Henne          New Issue                                    
11-01-05 10:35 Henne          Distribution              => Slackware 9.0   
11-01-05 10:35 Henne          Kernel Version            => 2.6.14-rc4      
11-08-05 18:48 tiwai          Note Added: 0006637                          
11-08-05 21:00 Henne          Note Added: 0006643                          
11-12-05 19:33 Henne          Note Added: 0006688                          
11-15-05 10:10 Henne          Note Added: 0006729                          
02-06-06 09:34 Henne          Note Added: 0007944                          
03-16-06 13:57 Henne          Note Added: 0008602                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
