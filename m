From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000305]: sound is locked up after suspend/resume (APM)
Date: Wed, 1 Mar 2006 03:50:40 +0100
Message-ID: <30ff094742810f1efadbe1cef3bcd026@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D7CAB1CA
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 03:50:40 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=305> 
======================================================================
Reported By:                klausr
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   305
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             Debian kernel 2.6.5-4-686
======================================================================
Date Submitted:             05-25-2004 14:49 CEST
Last Modified:              03-01-2006 03:50 CET
======================================================================
Summary:                    sound is locked up after suspend/resume (APM)
Description: 
Until recently I was running oss driver cs46xx without a problem. I could
suspend in the middle of playback and xmms would keep playing after resume
as if nothing happend at all.
After switching to the 2.6 kernel, currently running 2.6.5, I also
switched to ALSA beeing the new sound architecture of choice.
Unforunately now when I suspend and resume my notebook sound stops working
at all. Sometimes unloading all ALSA modules helps, sometimes even that is
not possible anymore.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000226 Sound hangs after APM resume
======================================================================

----------------------------------------------------------------------
 cull - 03-01-06 03:41 
----------------------------------------------------------------------
Hi, I don't know if this might give a clue, but I get additional sound
related messages when I hibernate to disc using suspend2:

[4469757.963000] ACPI: PCI interrupt for device 0000:00:05.0 disabled
[4469758.655000] snd: Not freed snd_alloc_kmalloc = 468
[4469758.655000] snd: kmalloc(468) from d0caad05 not freed
[4469758.829000] gameport: kgameportd exiting

Here I do not tell suspend2 to unload the sound module before suspend,
however it is not loaded after resume. If I use ACPI suspend, I don't have
these messages, the sound module is loaded after resume but is not
functional.

The rest of the log for suspend2 looks as follows:

[4469759.540000] uhci_hcd 0000:00:07.2: remove, state 1
[4469759.541000] usb usb1: USB disconnect, address 1
[4469759.541000] usb 1-1: USB disconnect, address 2
[4469759.868000] uhci_hcd 0000:00:07.2: USB bus 1 deregistered
[4469759.918000] ACPI: PCI interrupt for device 0000:00:07.2 disabled
[4469760.764000] Suspend2 2.2-rc16: Initiating a software suspend cycle.
[4469764.665000] 20%...40%...60%...80%...100%...done.
[4469773.160000] ACPI: PCI interrupt for device 0000:00:03.0 disabled
[4469773.171000] ACPI: PCI interrupt for device 0000:00:02.1 disabled
[4469773.171000] ACPI: PCI interrupt for device 0000:00:02.0 disabled
[4469808.175000] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI
11 (l
evel, low) -> IRQ 11
[4469808.206000] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LNKB] -> GSI
11 (l
evel, low) -> IRQ 11
[4469808.284000] ACPI: PCI Interrupt 0000:00:03.1[A] -> Link [LNKC] -> GSI
11 (l
evel, low) -> IRQ 11
[4469810.274000] e100: eth0: e100_watchdog: link up, 10Mbps, full-duplex
[4469810.624000] 20%...40%...60%...80%...100%...done.
[4469819.456000] Suspend2 debugging info:
[4469819.456000] - SUSPEND core   : 2.2-rc16
[4469819.456000] - Kernel Version : 2.6.15-archck2
[4469819.456000] - Compiler vers. : 4.0
[4469819.456000] - Attempt number : 5
[4469819.456000] - Parameters     : 0 32 0 1 182 0
[4469819.456000] - Overall expected compression percentage: 50.
[4469819.456000] - Compressor lzf enabled.
[4469819.456000]   Compressed 246611968 bytes into 132064606 (46 percent
compres
sion).
[4469819.456000] - Swapwriter active.
[4469819.456000]   Swap available for image: 485537 pages.
[4469819.456000] - I/O speed: Write 20 MB/s, Read 18 MB/s.
[4469819.798000] USB Universal Host Controller Interface driver v2.3
[4469819.813000] ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI
11 (l
evel, low) -> IRQ 11
[4469819.814000] uhci_hcd 0000:00:07.2: UHCI Host Controller
[4469819.863000] uhci_hcd 0000:00:07.2: new USB bus registered, assigned
bus num
ber 1
[4469819.863000] uhci_hcd 0000:00:07.2: irq 11, io base 0x00001860
[4469819.881000] hub 1-0:1.0: USB hub found
[4469819.881000] hub 1-0:1.0: 2 ports detected
[4469820.421000] usb 1-1: new low speed USB device using uhci_hcd and
address 2
[4469820.639000] input: Logitech USB Mouse as /class/input/input29
[4469820.644000] input: USB HID v1.10 Mouse [Logitech USB Mouse] on
usb-0000:00:
07.2-1
[4469820.832000] ACPI: Power Button (FF) [PWRF]
[4469820.832000] ACPI: Lid Switch [LID]
[4469820.832000] ACPI: Sleep Button (CM) [SLPB]
[4469820.954000] IBM TrackPoint firmware: 0x0e, buttons: 3/3
[4469821.002000] input: TPPS/2 IBM TrackPoint as /class/input/input30

----------------------------------------------------------------------
 rlrevell - 03-01-06 03:50 
----------------------------------------------------------------------
Can you save /proc/asound/card0/codec97#0/ac97#0-0+regs before and after
suspend and post the diff?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-25-04 14:49 klausr         New Issue                                    
05-25-04 14:49 klausr         Kernel Version            => Debian kernel
2.6.5-4-686
05-25-04 15:02 tiwai          Note Added: 0001213                          
05-25-04 15:31 klausr         Note Added: 0001215                          
05-25-04 15:59 klausr         Note Added: 0001217                          
05-25-04 16:02 klausr         Issue Monitored: klausr                      
05-25-04 16:05 tiwai          Note Added: 0001218                          
05-25-04 16:44 klausr         Note Added: 0001220                          
05-25-04 16:56 klausr         Note Edited: 0001220                         
05-27-04 08:49 klausr         Issue End Monitor: klausr                    
05-28-04 17:08 tiwai          Note Added: 0001269                          
05-29-04 09:36 klausr         Note Added: 0001276                          
01-17-05 10:57 jdthood        Note Added: 0003226                          
03-22-05 15:02 jdthood        Relationship added       has duplicate 0000226
03-23-05 00:39 rlrevell       Note Added: 0004145                          
03-28-05 15:42 sboehler       Issue Monitored: sboehler                    
06-20-05 01:59 tromer         Issue Monitored: tromer                      
12-12-05 11:12 bheung         Issue Monitored: bheung                      
12-13-05 12:49 jdthood        Note Added: 0007003                          
12-13-05 22:06 jdthood        Note Added: 0007025                          
02-26-06 03:52 cull           Note Added: 0008193                          
02-26-06 04:24 cull           Note Added: 0008194                          
02-26-06 04:44 rlrevell       Note Added: 0008195                          
02-26-06 16:31 cull           Note Added: 0008204                          
02-26-06 23:24 cull           Note Edited: 0008204                         
03-01-06 03:41 cull           Note Added: 0008264                          
03-01-06 03:50 rlrevell       Note Added: 0008265                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
