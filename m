From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000943]: cmipci freezes the whole system
Date: Thu, 22 Sep 2005 20:16:01 +0200
Message-ID: <c227e3eac434ceecbdfe718011592970@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D409F138
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 20:16:01 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=943> 
======================================================================
Reported By:                aisotton
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   943
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Debian Sid (Unstable)
Kernel Version:             2.6.10
======================================================================
Date Submitted:             02-25-2005 16:06 CET
Last Modified:              09-22-2005 20:16 CEST
======================================================================
Summary:                    cmipci freezes the whole system
Description: 
Hi,

I have a Terratec Aureon 5.1 PCI sound card, and an on-board 3Com 3c940
gigabit ethernet controller (the board is an Asus A7V600). The sound
card uses the cmipci module, and the ethernet card the sk98lin module.

Playing sound and using the network at the same time freezes the sytem
after a short time (generally 15-30 seconds); nothing is logged or
displayed (I checked syslog, kern.log and /var/log/messages), it just
freezes everything, forcing a reset of the machine (and after the
subsequent reboot my mouse isn't recognized any more, but I don't think
that matters).

I am using that network card since more than a year, and it never gave a
problem; thus I think the bug is in the cmipci driver (the system never
froze before I installed the sound card).

I did a memtest, but my memory seems to be ok.

This happens with all kernels I tested, specifically:

Debian kernel-image-2.6.10-1-k7-4
Debian kernel-image-2.6.9-2-k7-5
Debian kernel-image-2.6.8-2-k7-13
Debian kernel-image-2.6.10-1-k7-4 with PREEMPT deactivated
Vanilla kernel 2.6.10, compiled with the same options as Debian
kernel-image-2.6.10-1-k7-4.


======================================================================

----------------------------------------------------------------------
 sbambach - 09-22-05 19:52 
----------------------------------------------------------------------
I tried it on AMD, Intel and nForce chipset and there are NO problems.

Only on my VIA chipset board. More research on google done and people
having problems often have VIA chipset too (But most do not report there
chipset).

I have a second card "Nightingale PRO 6" ... same soundchip and same
problem on VIA. And again no problem at all for all three other chipsets.

Perhaps a strange hardware conflict ?!



----------------------------------------------------------------------
 runderwo - 09-22-05 20:16 
----------------------------------------------------------------------
Compile the kernel with debug and SysRq enabled.  When the system
"freezes", issue Alt-SysRq-T and see what is going on.  At least this will
tell us whether the hardware or the kernel has stopped.

Also please try putting cmipci card on its own IRQ.  To do this you will
need to disable whatever motherboard resources share PCI interrupt lines
with that slot, and don't put any cards in slots that share PCI interrupt
lines with it either.

Perhaps this is a problem with PCI latency.  Try setting the latency to
255 with setpci.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-25-05 16:06 aisotton       New Issue                                    
02-25-05 16:06 aisotton       Distribution              => Debian Sid (Unstable)
02-25-05 16:06 aisotton       Kernel Version            => 2.6.10          
02-25-05 16:07 aisotton       Note Added: 0003734                          
02-25-05 21:57 runderwo       Note Added: 0003736                          
02-26-05 02:33 aisotton       Note Added: 0003737                          
06-11-05 23:46 sbambach       Note Added: 0004996                          
06-11-05 23:48 sbambach       Note Added: 0004997                          
06-11-05 23:48 sbambach       Issue Monitored: sbambach                    
06-14-05 21:23 graf_eichbaum  Issue Monitored: graf_eichbaum                    
09-16-05 15:27 mitch_f        Note Added: 0006244                          
09-22-05 19:40 mitch_f        Note Added: 0006357                          
09-22-05 19:51 sbambach       Note Added: 0006358                          
09-22-05 19:52 sbambach       Note Edited: 0006358                         
09-22-05 20:16 runderwo       Note Added: 0006360                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
