From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001365]: Dell/Creative Labs Audigy 2
	ZS: No capture control
Date: Tue, 18 Jul 2006 14:43:42 +0200
Message-ID: <a50c38338be317cc97cd3f9543482376@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 39298176
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:43:42 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1365> 
======================================================================
Reported By:                phineas
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1365
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Debian testing (etch)
Kernel Version:             2.6.12.4 vanilla
======================================================================
Date Submitted:             08-24-2005 09:22 CEST
Last Modified:              07-18-2006 14:43 CEST
======================================================================
Summary:                    Dell/Creative Labs Audigy 2 ZS: No capture control
Description: 
Unless this is a user overlooking a step...

There is no mute control on the "Master" item (or most other items for
that matter).
More importantly, the capture items do not have a capture control; they
have level adjustments, but one cannot actually select an item for
capturing.
It appears that this Dell-supplied device (with Audigy subsytem 1003) is
generally unknown to the drivers -- but it does work well for sound
playback.

======================================================================

----------------------------------------------------------------------
 pzad - 08-25-05 17:11 
----------------------------------------------------------------------
All controls implemented in DSP don't have mute. No one implemented them.

Capture problem is related to your card not detected correctly.
You can try add this to CVS version of alsa to file
alsa-driver/alsa-kernel/pci/emu10k1/emu10k1_main.c to table
emu_chip_details[]

{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10031102,
	 .driver = "Audigy2", .name = "Audigy 2 ZS [SB0353]", 
	 .id = "Audigy2",
	 .emu10k2_chip = 1,
	 .ca0102_chip = 1,
	 .ca0151_chip = 1,
	 .spk71 = 1,
	 .spdif_bug = 1,
	 .ac97_chip = 1}

Then if your card is detected correctly look at
http://alsa.opensrc.org/emu10k1
7. How to record on Audigy and Audigy 2

----------------------------------------------------------------------
 phineas - 08-26-05 22:04 
----------------------------------------------------------------------
Okay, I was unable to compile alsa from cvs, so I applied the patch
(without the .id field) to the alsa sources included with vanilla kernel
2.6.12.4.  Everything seems to work now.  Do you need me to try it again
with cvs for admission in a future release?

----------------------------------------------------------------------
 phineas - 12-14-05 23:03 
----------------------------------------------------------------------
The code segment posted by pzad works as provided with alsa included with
debian kernel 2.6.14.

Could someone apply the definition posted by pzad as a patch to CVS?


$ cat /proc/asound/version 
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12
08:13:09 2005 UTC).

$ cat /proc/asound/cards   
0 [Audigy2        ]: Audigy2 - Audigy 2 ZS [SB0353]
                     Audigy 2 ZS [SB0353] (rev.4, serial:0x10031102) at
0xccc0, irq 17

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-24-05 09:22 phineas        New Issue                                    
08-24-05 09:22 phineas        File Added: vegan.state                      
08-24-05 09:22 phineas        Distribution              => Debian testing (etch)
08-24-05 09:22 phineas        Kernel Version            => 2.6.12.4 vanilla
08-24-05 20:58 phineas        Issue Monitored: phineas                     
08-25-05 17:11 pzad           Note Added: 0005941                          
08-26-05 22:04 phineas        Note Added: 0005958                          
09-17-05 18:54 jdthood        Summary                  Dell/Creative Labs Audigy
2 ZS mixer controls => Dell/Creative Labs Audigy 2 ZS: No capture control
12-14-05 23:03 phineas        Note Added: 0007043                          
07-18-06 14:43 jcdutton       Status                   new => assigned     
07-18-06 14:43 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
