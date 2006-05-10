From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002104]: No sound on Acer Travelmate 3012WTMI
Date: Wed, 10 May 2006 17:03:46 +0200
Message-ID: <44a2deb4f1807233f04bd66f49653d65@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9863717A
	for <alsa-devel@alsa-project.org>; Wed, 10 May 2006 17:03:46 +0200 (MEST)
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
Last Modified:              05-10-2006 17:03 CEST
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
 mcosta - 05-10-06 16:52 
----------------------------------------------------------------------
Hello, I have also tried the 1.0.11-final release and I have no sound.

I have /proc/asound/card0/codec#0
cat /proc/asound/card0/codec#0
Codec: Realtek ALC883
Address: 0
Vendor Id: 0x10ec0883
Subsystem Id: 0x1025160d
Revision Id: 0x100002
Default PCM: rates 0x560, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x11: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x03 [Audio Output] wcaps 0x11: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x04 [Audio Output] wcaps 0x11: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x05 [Audio Output] wcaps 0x11: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  PCM: rates 0x560, bits 0x1e, types 0x1
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x1f 0x1f]
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x1f 0x1f]
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 1
     0x22
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
  PCM: rates 0x560, bits 0x1e, types 0x1
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x1f 0x1f] [0x00 0x00] [0x00
0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x05 0x0b
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x083e: IN OUT HP
  Pin Default 0x0121411f: [Jack] HP Out at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0x40: OUT
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x083e: IN OUT HP
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Connection: 5
     0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x083e: IN OUT HP
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Connection: 5
     0x0c 0x0d 0x0e* 0x0f 0x26
Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x083e: IN OUT HP
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Connection: 5
     0x0c 0x0d 0x0e 0x0f* 0x26
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP
  Pin Default 0x41a19830: [N/A] Mic at Ext Rear
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x21: IN
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP
  Pin Default 0x99a30130: [Fixed] Mic at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x20: IN
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP
  Pin Default 0x01a19c3f: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x00:
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0xb71111f0: [Fixed] Speaker at Oth Mobile-In
    Conn = 1/8, Color = Black
  Pin-ctls: 0x00:
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x0810: OUT
  Pin Default 0x01451120: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
  Pin-ctls: 0x00:
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x00:
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80]
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x23 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80]
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Audio Output] wcaps 0x11: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x25 0x0b


cat /proc/asound/card0/codec#1
Codec: Generic 14f1 ID 2bfa
Address: 1
Vendor Id: 0x14f12bfa
Subsystem Id: 0x10250098
Revision Id: 0x90000

Thank you for your help.

----------------------------------------------------------------------
 mcosta - 05-10-06 17:03 
----------------------------------------------------------------------
I have put the file for the result of --> alsactl -f somefile store.

When I load the driver with model=3stack-dig, this message appear in
dmesg:

/alsa-driver-1.0.11/pci/hda/hda_codec.c:1704: hda_codec: model
'3stack-dig' is selected
hda_codec: num_steps = 0 for NID=0x7

 When I try to start alsamixer I get this error:
amixer: Mixer default load error: Invalid argument

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
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
