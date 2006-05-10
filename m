From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002104]: No sound on Acer Travelmate 3012WTMI
Date: Wed, 10 May 2006 14:48:04 +0200
Message-ID: <916d06855d604b5f6b6e8006451bbcd3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E2B6015A
	for <alsa-devel@alsa-project.org>; Wed, 10 May 2006 14:48:04 +0200 (MEST)
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
Last Modified:              05-10-2006 14:48 CEST
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
 useidel - 05-09-06 23:56 
----------------------------------------------------------------------
Done already (laptop, laptop-eapd, 6stck-dig, 3stack-dig), didn't help. I
also tried the "position_fix" option with the values 0, 1 and 2.

----------------------------------------------------------------------
 tiwai - 05-10-06 14:48 
----------------------------------------------------------------------
First, try the 1.0.11-final version.  If it doesn't work, please upload the
contents of /proc/asound/card0/codec#* files.

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
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
