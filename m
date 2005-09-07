From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000322]: oops while removing au8810
Date: Wed, 7 Sep 2005 03:14:15 +0200
Message-ID: <0c2bcb3bb1edbe60e20599cbc65c511b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9F24A198
	for <alsa-devel@alsa-project.org>; Wed,  7 Sep 2005 03:14:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=322> 
======================================================================
Reported By:                aris
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   322
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               conectiva linux 10 snapshot with custom kernel
Kernel Version:             2.6.7-rc2
======================================================================
Date Submitted:             06-02-2004 13:24 CEST
Last Modified:              09-07-2005 03:14 CEST
======================================================================
Summary:                    oops while removing au8810
Description: 
after getting an error on activating IRQ (not sure if this board is
working)
and trying to remove module I get an oops. I tryed to dig in but couldn't
find where exactly it is happening.
the IRQ error message:
PCI: Found IRQ 11 for device 0000:00:0b.0
PCI: Sharing IRQ 11 with 0000:00:01.1
Vortex: init.... <6>done.
vortex: IRQ reg error

======================================================================

----------------------------------------------------------------------
 aris - 09-07-05 02:22 
----------------------------------------------------------------------
Hi Raymond,

here's the output of lspci -vvn:

0000:00:0b.0 0401: 12eb:0003 (rev 02)
	Subsystem: 12eb:0003
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 20750ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 193
	Region 0: Memory at fdf00000 (32-bit, non-prefetchable) [size=256K]
	Region 1: I/O ports at b800 [size=8]
	Region 2: I/O ports at b400 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

here's the output loading the stock 2.6.13 driver:
ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 16 (level, low) -> IRQ 193
Vortex: init.... <6>done.
gameport: AU88x0 Gameport is pci0000:00:0b.0/gameport0, speed 1387kHz
vortex: IRQ reg error

the sound works fine!
I don't have a joystick here to test the gameport but tomorrow by morning
I'll test it.
thanks for the great work ALSA team!

----------------------------------------------------------------------
 Raymond - 09-07-05 03:14 
----------------------------------------------------------------------
cat /proc/asound/au8810/codec97#0/ac97#0-0+regs

Do your card look like this one ? 

http://www.watch.impress.co.jp/akiba/hotline/991106/newitem.html#19

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-02-04 13:24 aris           New Issue                                    
06-02-04 13:24 aris           Distribution              => conectiva linux 10
snapshot with custom kernel
06-02-04 13:24 aris           Kernel Version            => 2.6.7-rc2       
06-03-04 17:51 mjander        Note Added: 0001289                          
06-03-04 17:51 mjander        Note Added: 0001290                          
06-03-04 17:52 mjander        File Added: aureal-quadfix.patch                  
 
04-12-05 20:45 alien999999999 Issue Monitored: alien999999999                   

08-30-05 12:22 jdthood        Note Added: 0005973                          
09-06-05 11:03 Raymond        Note Added: 0006043                          
09-06-05 14:12 aris           Note Added: 0006044                          
09-06-05 14:32 Raymond        Note Added: 0006045                          
09-06-05 14:34 Raymond        Note Edited: 0006045                         
09-06-05 14:58 Raymond        Note Added: 0006046                          
09-06-05 15:02 Raymond        Note Edited: 0006046                         
09-07-05 02:22 aris           Note Added: 0006051                          
09-07-05 03:14 Raymond        Note Added: 0006052                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
