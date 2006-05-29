From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001883]: NO SOUND on K8N4-E Delux
	motherboard (NFORCE-CK804 sound - snd-intel8x0)
Date: Mon, 29 May 2006 10:27:41 +0200
Message-ID: <5469982d6a1068ab71ae1e7d292593ec@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AE637167
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 10:27:41 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1883> 
======================================================================
Reported By:                samael
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1883
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo / Ubuntu
Kernel Version:             kernel-2.6.15
======================================================================
Date Submitted:             02-27-2006 09:03 CET
Last Modified:              05-29-2006 10:27 CEST
======================================================================
Summary:                    NO SOUND on  K8N4-E Delux motherboard (NFORCE-CK804
sound - snd-intel8x0)
Description: 
AMD64 3000+ on K8N4-E Delux motherboard
(NFORCE-CK804 sound - snd-intel8x0)

ALSA-1.0.2/4 - sound works perfect!! After 1.0.4 - NO SOUND!!
GSI 21 (level, low) -> IRQ 18
Feb 12 19:46:31 tux PCI: Setting latency timer of device 0000:00:04.0 to
64 
Feb 12 19:46:31 tux codec_semaphore: semaphore is not ready
[0x1][0x1010101] 
Feb 12 19:46:31 tux codec_semaphore: semaphore is not ready
[0x1][0x1010101] 
...............................................
Feb 12 19:46:31 tux codec_semaphore: semaphore is not ready
[0x1][0x1010101] 
Feb 12 19:46:31 tux AC'97 0 does not respond - RESET
Feb 12 19:46:31 tux codec_semaphore: semaphore is not ready
[0x1][0x1010101] 
Feb 12 19:46:31 tux codec_semaphore: semaphore is not ready
[0x1][0x1010101] 
Feb 12 19:46:31 tux AC'97 0 access is not valid [0xffffffff], removing
mixer. Feb 12 19:46:31 tux Unable to initialize codec #0
Feb 12 19:46:31 tux ACPI: PCI interrupt for device 0000:00:04.0 disabled
======================================================================

----------------------------------------------------------------------
 samael - 05-03-06 19:16 
----------------------------------------------------------------------
I resolved this problem by upgrading BIOS to newest one (beta) from
asus.com.

By the way, after 2 hard monthes of using ASUS K8N4-E Delux, I replaced it
on Epox MB :) 
Much better!!!!! 

All this problems are linked with bad Asus BIOS :(



----------------------------------------------------------------------
 thessy - 05-29-06 10:27 
----------------------------------------------------------------------
Same problem here (look at uploaded aa-debug-output file).

kernel 2.6.16, debian sarge (with backports)

worked with 2.6.7, till upgrade no more.

I won't get back, because of suspend2 works now ;-)

The problem is known and will be fixed in new kernel version?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-27-06 09:03 samael         New Issue                                    
02-27-06 09:03 samael         Distribution              => Gentoo / Ubuntu 
02-27-06 09:03 samael         Kernel Version            => kernel-2.6.15   
02-27-06 09:04 samael         Issue Monitored: samael                      
03-02-06 15:29 tiwai          Note Added: 0008309                          
03-07-06 15:15 samael         Note Added: 0008363                          
03-07-06 15:20 tiwai          Note Added: 0008364                          
03-07-06 15:30 samael         Note Added: 0008367                          
05-03-06 12:18 ksc91u         Note Added: 0009592                          
05-03-06 19:14 samael         Note Added: 0009598                          
05-03-06 19:15 samael         Note Edited: 0009598                         
05-03-06 19:16 samael         Note Edited: 0009598                         
05-29-06 10:27 thessy         Note Added: 0010008                          
======================================================================
