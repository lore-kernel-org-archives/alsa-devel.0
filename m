From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000930]: Ego Sys Juli@ does not work at all
Date: Mon, 6 Jun 2005 10:38:02 +0200
Message-ID: <4aa0cdc1f4e3f4a415322b1b417e8a1a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (unknown [195.113.161.147])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2491E17A
	for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2005 10:38:02 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=930> 
======================================================================
Reported By:                lingis
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   930
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               Ubuntu 4.10
Kernel Version:             2.6.8.1-3-386
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-22-2005 00:32 CET
Last Modified:              06-06-2005 10:38 CEST
======================================================================
Summary:                    Ego Sys Juli@ does not work at all
Description: 
When trying to load ice1724 driver, nothing happens:

sudo modprobe snd-ice1724
dmesg | tail -n 20
bt878: Bt878 AUDIO function found (0).
ACPI: PCI interrupt 0000:00:0d.1[A] -> GSI 11 (level, low) -> IRQ 11
bt878(0): Bt878 (rev 2) at 00:0d.1, irq: 11, latency: 32, memory:
0xe3000000
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
8139cp: pci dev 0000:00:0f.0 (id 10ec:8139 rev 10) is not an 8139C+
compatible
chip
8139cp: Try the "8139too" driver instead.
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 11 (level, low) -> IRQ 11
eth0: RealTek RTL8139 at 0xe400, 00:50:fc:44:75:5d, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
NET: Registered protocol family 10
Disabled Privacy Extensions on device c02cc0c0(lo)
IPv6 over IPv4 tunneling driver
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
eth0: no IPv6 routers present
bttv0: timeout: drop=58 irq=7964/193355, risc=16103024, bits: HSYNC OFLOW
FDSR
bttv0: reset, reinitialize
bttv0: PLL: 28636363 => 35468950 . ok

cat /proc/asound/cards
--- no soundcards ---



======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000908 suport for ESI <a href="mailto:Juli@ -"...
======================================================================

----------------------------------------------------------------------
 perex - 03-11-05 08:56 
----------------------------------------------------------------------
You may try to change queue_delayed_work(chip->workqueue, &chip->work, 1);
to queue_delayed_work(chip->workqueue, &chip->work, 2); (or highter
value)
in alsa-kernel/i2c/other/ak4114.c .

It seems that i2c takes too much time. Or it might be, that the scheduler

code for task statistics is somewhat broken.

----------------------------------------------------------------------
 perex - 06-06-05 10:38 
----------------------------------------------------------------------
Please, reopen another bug in case of problems. The original issue was
resolved.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-22-05 00:32 lingis         New Issue                                    
02-22-05 00:32 lingis         Distribution              => Ubuntu 4.10     
02-22-05 00:32 lingis         Kernel Version            => 2.6.8.1-3-386   
02-22-05 00:45 lingis         Issue Monitored: lingis                      
02-22-05 09:26 perex          Note Added: 0003685                          
02-22-05 09:26 perex          Status                   new => assigned     
02-22-05 09:26 perex          Assigned To               => perex           
02-22-05 09:29 perex          View Status              private => public   
02-22-05 10:07 perex          Relationship added       related to 0000908  
02-24-05 21:27 bennoA         Note Added: 0003724                          
03-11-05 08:56 perex          Note Added: 0003881                          
06-06-05 10:38 perex          Status                   assigned => resolved
06-06-05 10:38 perex          Resolution               open => fixed       
06-06-05 10:38 perex          Note Added: 0004895                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
