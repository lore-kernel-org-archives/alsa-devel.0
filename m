From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000930]: Ego Sys Juli@ does not work at all
Date: Tue, 22 Feb 2005 00:32:02 +0100
Message-ID: <d1093065d58e767e0cd071dd836e96ca@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A6C1C158
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2005 00:32:02 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=930> 
======================================================================
Reported By:                lingis
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   930
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 4.10
Kernel Version:             2.6.8.1-3-386
======================================================================
Date Submitted:             02-22-2005 00:32 CET
Last Modified:              02-22-2005 00:32 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-22-05 00:32 lingis         New Issue                                    
02-22-05 00:32 lingis         Distribution              => Ubuntu 4.10     
02-22-05 00:32 lingis         Kernel Version            => 2.6.8.1-3-386   
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
