From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001883]: NO SOUND on  K8N4-E Delux motherboard (NFORCE-CK804 sound - snd-intel8x0)
Date: Tue, 7 Mar 2006 15:30:02 +0100
Message-ID: <78684755264dc123c89cd93bc2ac3d8e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 022D0195
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2006 15:30:02 +0100 (MET)
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
Last Modified:              03-07-2006 15:30 CET
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
 tiwai - 03-07-06 15:20 
----------------------------------------------------------------------
Try the latest ALSA with 2.6.10 kernel.
If it doesn't work, we need to debug it.

----------------------------------------------------------------------
 samael - 03-07-06 15:30 
----------------------------------------------------------------------
Oh, I forgot!!!

I try kernel-2.6.15 with ALSA-1.0.4  -- the same - NO SOUND!!!
but kernel-2.6.10 with ALSA-1.0.4 -OK!

Now I'm using kernel-2.6.12 with ALSA-1.0.9b - OK!

Thus, it's kernel-2.6.15 problem :(

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
