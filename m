From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000328]: snd-nm256 freezes Dell Latitude LS
Date: Tue, 8 Nov 2005 18:47:32 +0100
Message-ID: <b6d87a1ea3d83b957a8e28ea32f5fdac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5B4611C0
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2005 18:47:32 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=328> 
======================================================================
Reported By:                aaronkaplan
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   328
Category:                   PCI - nm256
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     feedback
Distribution:               Fedora Core 4
Kernel Version:             2.6.12-1.1398
======================================================================
Date Submitted:             06-08-2004 23:13 CEST
Last Modified:              11-08-2005 18:47 CET
======================================================================
Summary:                    snd-nm256 freezes Dell Latitude LS
Description: 
My Dell Latitude LS with an NM256AV hangs when I insert the
snd-nm256 module.

The OSS driver works fine.

======================================================================

----------------------------------------------------------------------
 florentb5 - 09-13-05 11:49 
----------------------------------------------------------------------
Hello,

I also have a crash.
Hardware : Dell Latitude Cpi A laptop (P2 366Mhz)
audio card : integrated Neomagic MagicMedia 256AV Audio
normal alsa audio driver : nm256

bug infos in OpenSuse Bugzilla :
https://bugzilla.novell.com/show_bug.cgi?id=116387

Here the output of lspci -v :
========================
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host
bridge
(rev 03)
	Flags: bus master, medium devsel, latency 32
	Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP
bridge
(rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fd000000-feffffff
	Prefetchable memory behind bridge: f8000000-f9ffffff

00:03.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Latitude CPi A400XT
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 10100000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 12000000-13fff000 (prefetchable)
	Memory window 1: 14000000-15fff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	16-bit legacy interface ports at 0001

00:03.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Latitude CPi A400XT
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 10101000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 16000000-17fff000 (prefetchable)
	Memory window 1: 18000000-19fff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	16-bit legacy interface ports at 0001

00:07.0 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 32
	I/O ports at 0860 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev
01)
(prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at ece0 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Flags: medium devsel, IRQ 9

01:00.0 VGA compatible controller: Neomagic Corporation NM2200
[MagicGraph
256AV] (rev 12) (prog-if 00 [VGA])
	Subsystem: Dell Latitude CPi A
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at f9000000 (32-bit, prefetchable) [size=16M]
	Memory at fdc00000 (32-bit, non-prefetchable) [size=4M]
	Memory at fdb00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 1

01:00.1 Multimedia audio controller: Neomagic Corporation NM2200
[MagicMedia
256AV Audio] (rev 12)
	Subsystem: Dell Latitude CPi A
	Flags: medium devsel, IRQ 5
	Memory at f8c00000 (32-bit, prefetchable) [disabled] [size=4M]
	Memory at fda00000 (32-bit, non-prefetchable) [disabled] [size=1M]
	Capabilities: [dc] Power Management version 1

========================

----------------------------------------------------------------------
 tiwai - 11-08-05 18:47 
----------------------------------------------------------------------
1.0.10rc3 has a fix for this laptop.  Give it a try.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-04 23:13 aaronkaplan    New Issue                                    
06-08-04 23:13 aaronkaplan    Distribution              => Fedora Core 2   
06-08-04 23:13 aaronkaplan    Kernel Version            => 2.6.5-1.358     
06-08-04 23:13 aaronkaplan    Issue Monitored: aaronkaplan                    
06-30-04 16:55 tiwai          Note Added: 0001362                          
06-30-04 16:56 tiwai          File Added: nm256-dell-test.dif                   

07-01-04 16:01 aaronkaplan    File Added: lspci.out                        
07-01-04 16:03 aaronkaplan    Note Added: 0001370                          
08-13-04 01:33 fridolin       Note Added: 0001559                          
08-13-04 12:46 fridolin       Note Added: 0001562                          
08-13-04 15:17 fridolin       Note Added: 0001564                          
08-14-04 20:04 aaronkaplan    Note Added: 0001565                          
08-19-04 19:18 tiwai          Status                   assigned => resolved
08-19-04 19:18 tiwai          Resolution               open => fixed       
08-19-04 19:18 tiwai          Note Added: 0001593                          
09-24-04 13:43 tiwai          Status                   resolved => closed  
09-03-05 22:43 aaronkaplan    Distribution             Fedora Core 2 => Fedora
Core 4
09-03-05 22:43 aaronkaplan    Kernel Version           2.6.5-1.358 =>
2.6.12-1.1398
09-03-05 22:43 aaronkaplan    Status                   closed => feedback  
09-03-05 22:43 aaronkaplan    Resolution               fixed => reopened   
09-03-05 22:43 aaronkaplan    Note Added: 0006030                          
09-04-05 00:33 rlrevell       Note Added: 0006031                          
09-13-05 11:49 florentb5      Note Added: 0006152                          
11-08-05 18:47 tiwai          Note Added: 0006636                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
