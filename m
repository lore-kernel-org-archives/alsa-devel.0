From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001365]: Dell/Creative Labs Audigy 2 ZS mixer controls
Date: Fri, 26 Aug 2005 22:04:47 +0200
Message-ID: <4a47ea82e50e79df7219e797b11759f2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8C5F61E8
	for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2005 22:04:47 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1365> 
======================================================================
Reported By:                phineas
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1365
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian testing (etch)
Kernel Version:             2.6.12.4 vanilla
======================================================================
Date Submitted:             08-24-2005 09:22 CEST
Last Modified:              08-26-2005 22:04 CEST
======================================================================
Summary:                    Dell/Creative Labs Audigy 2 ZS mixer controls
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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
