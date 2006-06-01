From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002104]: No sound on Acer Travelmate
	3012WTMI
Date: Thu, 1 Jun 2006 13:12:38 +0200
Message-ID: <147ad91e42627ff9972233b9990ec355@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C0408140
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jun 2006 13:12:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2104> 
======================================================================
Reported By:                mcosta
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2104
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-08-2006 16:08 CEST
Last Modified:              06-01-2006 13:12 CEST
======================================================================
Summary:                    No sound on Acer Travelmate 3012WTMI
Description: 
Hello, I have a TM3012WTMI laptop and I can not hear any sound. I am
running 2.6.1.6-11-smp kernel. I have compiled serveral versions of alsa
drivers and I am in the same situation: no sound at all.

I attach some information:
lspci
00:00.0 Host bridge: Intel Corporation Mobile Memory Controller Hub (rev
03)
00:02.0 VGA compatible controller: Intel Corporation Mobile Integrated
Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile Integrated Graphics
Controller (rev 03)
00:1b.0 Class 0403: Intel Corporation 82801G (ICH7 Family) High Definition
Audio Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 02)
00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 2 (rev 02)
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 3 (rev 02)
00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 4 (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1
(rev 02)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2
(rev 02)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3
(rev 02)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4
(rev 02)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface
Bridge (rev 02)
00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial
ATA Storage Controllers cc=IDE (rev 02)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller
(rev 02)
02:00.0 Network controller: Intel Corporation: Unknown device 4222 (rev
02)
03:00.0 Ethernet controller: Broadcom Corporation NetLink BCM5789 Gigabit
Ethernet PCI Express (rev 11)
0a:09.0 CardBus bridge: Texas Instruments: Unknown device 8039
0a:09.1 FireWire (IEEE 1394): Texas Instruments: Unknown device 803a
0a:09.2 Unknown mass storage controller: Texas Instruments: Unknown device
803b

hwinfo --sound:
13: PCI 1b.0: 0403 Multimedia controller
  [Created at pci.277]
  UDI: /org/freedesktop/Hal/devices/pci_8086_27d8
  Unique ID: u1Nb.NLLhYZ867B4
  SysFS ID: /devices/pci0000:00/0000:00:1b.0
  SysFS BusID: 0000:00:1b.0
  Hardware Class: sound
  Model: "Acer Incorporated [ALI] 82801G (ICH7 Family) High Definition
Audio Controller"
  Vendor: pci 0x8086 "Intel Corporation"
  Device: pci 0x27d8 "82801G (ICH7 Family) High Definition Audio
Controller"
  SubVendor: pci 0x1025 "Acer Incorporated [ALI]"
  SubDevice: pci 0x0098
  Revision: 0x02
  Driver: "HDA Intel"
  Memory Range: 0xb0000000-0xb0003fff (rw,non-prefetchable)
  IRQ: 66 (138 events)
  Module Alias: "pci:v00008086d000027D8sv00001025sd00000098bc04sc03i00"
  Driver Info #0:
    Driver Status: snd_hda_intel is active
    Driver Activation Cmd: "modprobe snd_hda_intel"
  Config Status: cfg=no, avail=yes, need=no, active=unknown

When the driver is loaded I get on /var/log/messages:

ACPI: PCI interrupt for device 0000:00:1b.0 disabled
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...
ALSA /TM3012/CVS2/alsa-driver/pci/hda/hda_codec.c:2115: autoconfig:
line_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /TM3012/CVS2/alsa-driver/pci/hda/hda_codec.c:2119:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
ALSA /TM3012/CVS2/alsa-driver/pci/hda/hda_codec.c:2121:    hp=0x14,
dig_out=0x1e, din_in=0x0
ALSA /TM3012/CVS2/alsa-driver/pci/hda/hda_codec.c:2129:    inputs:
mic=0x1a, fmic=0x0, line=0x0, fline=0x0, cd=0x0, aux=0x0

Best regards.



======================================================================

----------------------------------------------------------------------
 flaviocu - 06-01-06 01:12 
----------------------------------------------------------------------
I have the same problems. Any news on this issue?

Thank you and kind regards

Flavio Curti

----------------------------------------------------------------------
 nevvios - 06-01-06 13:12 
----------------------------------------------------------------------
I have the same laptop and the same problem using Gentoo 2006.0 (kernel
2.6.16-r7). 
At present, I emerged and configured alsa-driver instead of alsa kernel.
Please, anyone, any suggestion or solution will be well accepted.

Thanks

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-08-06 16:08 mcosta         New Issue                                    
05-09-06 17:35 lrupn          Note Added: 0009666                          
05-09-06 23:28 useidel        Note Added: 0009695                          
05-09-06 23:29 useidel        Note Edited: 0009695                         
05-09-06 23:47 rlrevell       Note Added: 0009696                          
05-09-06 23:56 useidel        Note Added: 0009697                          
05-10-06 14:48 tiwai          Note Added: 0009715                          
05-10-06 16:43 useidel        Note Added: 0009727                          
05-10-06 16:50 tiwai          Note Added: 0009729                          
05-10-06 16:52 mcosta         Note Added: 0009730                          
05-10-06 17:00 mcosta         File Added: tm3012sound.txt                    
05-10-06 17:03 mcosta         Note Added: 0009733                          
05-10-06 17:19 tiwai          Note Added: 0009739                          
05-10-06 17:19 tiwai          File Added: alc882-capture-adc-fix.diff           
        
05-10-06 17:48 mcosta         Note Added: 0009744                          
05-10-06 18:52 useidel        File Added: proc.asound.card0.codec0              
     
05-10-06 18:53 useidel        File Added: proc.asound.card0.codec1              
     
05-10-06 18:53 useidel        File Added: alsactl.store                    
05-10-06 19:07 useidel        Note Added: 0009749                          
05-19-06 16:50 joppe          Issue Monitored: joppe                       
05-23-06 21:35 useidel        Note Added: 0009952                          
05-31-06 19:50 useidel        Note Added: 0010027                          
06-01-06 01:12 flaviocu       Note Added: 0010038                          
06-01-06 13:12 nevvios        Note Added: 0010043                          
======================================================================
