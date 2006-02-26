From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000305]: sound is locked up after suspend/resume (APM)
Date: Sun, 26 Feb 2006 04:44:57 +0100
Message-ID: <d81c66a4de6cb0c6bf22d603a192c6ba@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4B9C71DC
	for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2006 04:44:57 +0100 (MET)
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
Last Modified:              02-26-2006 04:44 CET
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
 cull - 02-26-06 04:24 
----------------------------------------------------------------------
To be more precise, here is what I get in dmesg during suspend to ram (I
use ACPI with suspend2 configs):

[4297745.567000] uhci_hcd 0000:00:07.2: remove, state 1
[4297745.568000] usb usb1: USB disconnect, address 1
[4297745.568000] usb 1-1: USB disconnect, address 2
[4297746.100000] uhci_hcd 0000:00:07.2: USB bus 1 deregistered
[4297746.138000] ACPI: PCI interrupt for device 0000:00:07.2 disabled
[4297750.517000] ACPI: PCI interrupt for device 0000:00:05.0 disabled
[4297750.528000] ACPI: PCI interrupt for device 0000:00:03.0 disabled
[4297750.540000] ACPI: PCI interrupt for device 0000:00:02.1 disabled
[4297750.540000] ACPI: PCI interrupt for device 0000:00:02.0 disabled
[4297750.540000] Back to C!
[4297755.544000] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI
11 (level, low) -> IRQ 11
[4297755.576000] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LNKB] -> GSI
11 (level, low) -> IRQ 11
[4297755.654000] ACPI: PCI Interrupt 0000:00:03.1[A] -> Link [LNKC] -> GSI
11 (level, low) -> IRQ 11
[4297755.654000] ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [LNKA] -> GSI
11 (level, low) -> IRQ 11
[4297757.644000] e100: eth0: e100_watchdog: link up, 10Mbps, full-duplex
[4297757.709000] USB Universal Host Controller Interface driver v2.3
[4297757.722000] ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI
11 (level, low) -> IRQ 11
[4297757.722000] uhci_hcd 0000:00:07.2: UHCI Host Controller
[4297757.770000] uhci_hcd 0000:00:07.2: new USB bus registered, assigned
bus number 1
[4297757.770000] uhci_hcd 0000:00:07.2: irq 11, io base 0x00001860
[4297757.785000] hub 1-0:1.0: USB hub found
[4297757.786000] hub 1-0:1.0: 2 ports detected
[4297757.957000] ACPI: Power Button (FF) [PWRF]
[4297757.958000] ACPI: Lid Switch [LID]
[4297757.958000] ACPI: Sleep Button (CM) [SLPB]
[4297758.123000] usb 1-1: new low speed USB device using uhci_hcd and
address 2
[4297758.317000] input: Logitech USB Mouse as /class/input/input12
[4297758.333000] input: USB HID v1.10 Mouse [Logitech USB Mouse] on
usb-0000:00:07.2-1
[4297759.066000] IBM TrackPoint firmware: 0x0e, buttons: 3/3
[4297759.116000] input: TPPS/2 IBM TrackPoint as /class/input/input13

this appears in dmesg after I do rmmod snd_cs46xx:

[4297976.326000] ACPI: PCI interrupt for device 0000:00:05.0 disabled

and after modprobe snd_cs46xx I get:

[4298142.329000] ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [LNKA] -> GSI
11 (level, low) -> IRQ 11
[4298142.329000] ALSA
/usr/src/alsa/1.0.11rc3/alsa-driver-1.0.11rc3/pci/cs46xx/../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:3824:
Activating CLKRUN hack for Thinkpad.
[4298142.899000] gameport: CS46xx Gameport is pci0000:00:05.0/gameport0,
speed 1864kHz

my hardware (thinkpad T21):

$ cat /proc/asound/cards 
 0 [CS46xx         ]: CS46xx - Sound Fusion CS46xx
                      Sound Fusion CS46xx at 0xe8122000/0xe8000000, irq
11

$ lspci 
0000:00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host
bridge (rev 03)
0000:00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP
bridge (rev 03)
0000:00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
0000:00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
0000:00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 0c)
0000:00:03.1 Serial controller: Lucent Microelectronics LT WinModem (rev
01)
0000:00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
0000:00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
0000:00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
0000:00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
0000:00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
0000:01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV
(rev 13)

Soft: Ubuntu breezy, kernel 2.6.15 with some patches (suspend2, CK)

----------------------------------------------------------------------
 rlrevell - 02-26-06 04:44 
----------------------------------------------------------------------
So you are using suspend2 to suspend?  That's completely different.

What happens if you suspend the normal way?

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
