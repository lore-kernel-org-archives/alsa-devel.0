From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000230]: sound is bad when dma is enabled
Date: Tue, 1 Nov 2005 19:06:51 +0100
Message-ID: <0f08d9b85a2a3c385d3269845332bb63@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1BBEE183
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2005 19:06:52 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=230> 
======================================================================
Reported By:                Hetfield
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   230
Category:                   PCI - ens1370
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.x
======================================================================
Date Submitted:             04-23-2004 18:55 CEST
Last Modified:              11-01-2005 19:06 CET
======================================================================
Summary:                    sound is bad when dma is enabled
Description: 
when dma is enabled for my harddisk sound is so bad

0000:00:0b.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev
01)
        Subsystem: Unknown device 4942:4c4c
        Flags: bus master, slow devsel, latency 248, IRQ 10
        I/O ports at b000

i setted latency to 248 but i tried lots of values, nothing changed.
interrupts are not shared.
disabling dma make sound clean.

with 2.6.x only...2.4.x works so good.
i tred with 2.6 integrated or external libs too, as module o builtin.
nothing changes.

how to fix that? should i disable busmaster or change devsel value? how?




======================================================================

----------------------------------------------------------------------
 Hetfield - 07-03-05 13:50 
----------------------------------------------------------------------
same errors with 2.6.13-rc1 and alsa 1.0.9

----------------------------------------------------------------------
 Hetfield - 11-01-05 19:06 
----------------------------------------------------------------------
seems now i got it **pretty** fixed.

what i did:
1) updated kernel to 2.6.14-git4
2) setted 100Hz instead of 250
3) setted latency to 0x40 (64) instead of old 0x20 (32)
4) disabled pci 2.1 in my bios.

you can mark as closed

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-23-04 18:55 Hetfield       New Issue                                    
04-23-04 18:55 Hetfield       Kernel Version            => 2.6.x           
04-24-04 14:10 perex          Note Added: 0000924                          
04-24-04 14:10 perex          Severity                 major => tweak      
04-24-04 14:10 perex          Description Updated                          
04-25-04 11:00 Hetfield       Note Added: 0000937                          
02-23-05 13:34 Hetfield       Note Added: 0003710                          
07-03-05 13:50 Hetfield       Note Added: 0005375                          
11-01-05 19:06 Hetfield       Note Added: 0006598                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
