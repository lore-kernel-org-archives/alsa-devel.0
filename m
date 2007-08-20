From: Jorge Peixoto de Morais Neto <please.no.spam.here@gmail.com>
Subject: Unknown card info
Date: Mon, 20 Aug 2007 16:29:10 -0300
Message-ID: <20070820162910.58f7f1e0@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_AchoAfMslb4fwMiMd6UT/dX"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 99E1B103855
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Aug 2007 21:29:17 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so876902rvb
	for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2007 12:29:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--MP_AchoAfMslb4fwMiMd6UT/dX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

When I execute sudo modprobe snd_bt87x, I can't capture audio from my
tv capture card (mencoder segfaults). It only works when I execute
sudo modprobe snd_bt87x load_all=1. Then it seems to work ok.

When I issue sudo modprobe snd_bt87x load_all=1, the following lines
appear in dmesg:

unknown card 0x878-0x1554:0x4011, using default rate 32000
please mail id, board name, and, if it works, the correct digital_rate
option to <alsa-devel@alsa-project.org>

I am obeying the request and mailing this information to you. I have no
idea what is the correct digital_rate option; all I know is that the
default seems to work ok. I have a cable connecting the sound output of
the tv card to the line in of my sound card; it seems that when wathing
tv through mplayer this is the mechanism used (and it works ok).
However, when recording tv through mencoder, it seems to use snd_bt87x
(in fact, it does not work if snd_bt87x is not loaded), and it also
works ok.

The card option I pass when loading the module bttv is card=139.
According to /usr/src/linux/Documentation/video4linux/CARDLIST.bttv,
this corresponds to the card 
Prolink PixelView PlayTV MPEG2 PV-M4900

In fact, there is a sticker in the PCB that reads (if my
eyes are not failing me) PixelView PV-M4900 FM.RC

The full output of dmesg is attached to this email. 
If you need any additional information please contact me directly,
since I will now unsubscribe to this list.

Some possibly useful information:

jorge@jorge ~ $ uname -a
Linux jorge 2.6.22-gentoo-r3 #1 PREEMPT Tue Aug 14 18:51:06 BRT 2007 i686 AMD Athlon(tm) XP 2600+ AuthenticAMD GNU/Linux

jorge@jorge ~ $ cat /etc/modprobe.d/tv
options bttv card=139 automute=0
options snd_bt87x load_all=1

jorge@jorge ~ $ arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: CMI8738MC6 [C-Media PCI CMI8738-MC6], device 0: CMI8738-MC6 [C-Media PCI DAC/ADC]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: CMI8738MC6 [C-Media PCI CMI8738-MC6], device 2: CMI8738-MC6 [C-Media PCI IEC958]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Bt878 [Brooktree Bt878], device 0: Bt87x Digital [Bt87x Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Bt878 [Brooktree Bt878], device 1: Bt87x Analog [Bt87x Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

jorge@jorge ~ $ sudo lspci
Password:
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
00:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
00:0c.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX 440] (rev a3)

-- 
Software is like sex: it is better when it is free. --Linus Torvalds

--MP_AchoAfMslb4fwMiMd6UT/dX
Content-Type: text/plain; name=dmesg.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dmesg.txt

Linux version 2.6.22-gentoo-r3 (root@jorge) (gcc version 4.1.2 (Gentoo 4.1.2 p1.0.1)) #1 PREEMPT Tue Aug 14 18:51:06 BRT 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fb930
Entering add_active_range(0, 0, 131056) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   131056
early_node_map[1] active PFN ranges
    0:        0 ->   131056
On node 0 totalpages: 131056
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 991 pages used for memmap
  Normal zone: 125969 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP 000FA9C0, 0014 (r0 AMI   )
ACPI: RSDT 1FFF0000, 002C (r1 AMIINT VIA_K7         10 MSFT       97)
ACPI: FACP 1FFF0030, 0081 (r1 AMIINT VIA_K7         11 MSFT       97)
ACPI: DSDT 1FFF0120, 332F (r1    VIA   VIA_K7     1000 MSFT  100000D)
ACPI: FACS 1FFF8000, 0040
ACPI: APIC 1FFF00C0, 0054 (r1 AMIINT VIA_K7          9 MSFT       97)
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Built 1 zonelists.  Total pages: 130033
Kernel command line: root=/dev/hda2 init=/sbin/initng video=vesafb:ywrap
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 2308.916 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 515740k/524224k available (2308k kernel code, 7924k reserved, 722k data, 180k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
    vmalloc : 0xe0800000 - 0xfffb5000   ( 503 MB)
    lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
      .init : 0xc03f8000 - 0xc0425000   ( 180 kB)
      .data : 0xc03411e3 - 0xc03f5a04   ( 722 kB)
      .text : 0xc0100000 - 0xc03411e3   (2308 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4621.48 BogoMIPS (lpj=9242978)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: CLK_CTL MSR was 6003d22f. Reprogramming to 2003d22f
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000420 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: AMD Athlon(tm) XP 2600+ stepping 01
Checking 'hlt' instruction... OK.
ACPI: Core revision 20070126
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by vt8235 PM
PCI quirk: region 0400-040f claimed by vt8235 SMB
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 *6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 12 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:01: iomem range 0xfee00000-0xfee00fff could not be reserved
Time: tsc clocksource has been installed.
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: dde00000-dfefffff
  PREFETCH window: cdc00000-ddcfffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
Machine check exception polling timer started.
io scheduler noop registered
io scheduler anticipatory registered (default)
PCI: VIA PCI bridge detected. Disabling DAC.
Boot video device is 0000:01:00.0
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.102 (c) Dave Jones
vesafb: NVidia Corporation, NV17 () Board, Chip Rev A2 (OEM: NVidia)
vesafb: VBE version: 3.0
vesafb: protected mode interface info at c000:f880
vesafb: pmi: set display start = c00cf8c5, set palette = c00cf94a
vesafb: pmi: ports = b4c3 b503 ba03 c003 c103 c403 c503 c603 c703 c803 c903 cc03 ce03 cf03 d003 d103 d203 d303 d403 d503 da03 ff03 
vesafb: VBIOS/hardware supports DDC2 transfers
vesafb: monitor limits: vf = 160 Hz, hf = 70 kHz, clk = 110 MHz
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=19660
Console: switching to colour frame buffer device 160x64
vesafb: framebuffer at 0xd0000000, mapped to 0xe0880000, using 24576k, total 65536k
fb0: VESA VGA frame buffer device
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
input: Sleep Button (CM) as /class/input/input2
ACPI: Sleep Button (CM) [SLPB]
8139too Fast Ethernet driver 0.9.28
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 19 (level, low) -> IRQ 16
eth0: RealTek RTL8139 at 0xe0808f00, 00:e0:7d:c4:bf:f7, IRQ 16
eth0:  Identified 8139 chip type 'RTL-8139C'
Linux video capture interface: v2.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: Unable to derive IRQ for device 0000:00:11.1
ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG SP0822N, ATA DISK drive
hdb: HL-DT-ST GCE-8320B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QUANTUM FIREBALLlct20 20, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2
hdc: max request size: 128KiB
hdc: 39876480 sectors (20416 MB) w/418KiB Cache, CHS=39560/16/63<4>hdc: drive side 80-wire cable detection failed, limiting max speed to UDMA33

hdc: cache flushes not supported
 hdc: hdc1 hdc2 hdc3
hdb: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 17
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: irq 17, io mem 0xdffffe00
ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 17
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 17, io base 0x0000dc00
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[B] -> GSI 21 (level, low) -> IRQ 17
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 17, io base 0x0000e000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[C] -> GSI 21 (level, low) -> IRQ 17
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 17, io base 0x0000e400
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input3
w83627hf: Found W83697HF chip at 0x290
input: ImPS/2 Generic Wheel Mouse as /class/input/input4
Advanced Linux Sound Architecture Driver Version 1.0.14 (Thu May 31 09:03:25 2007 UTC).
ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 16 (level, low) -> IRQ 18
ALSA device list:
  #0: C-Media PCI CMI8738-MC6 (model 55) at 0xe800, irq 18
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 180k freed
loop: module loaded
ReiserFS: hdc1: found reiserfs format "3.6" with standard journal
ReiserFS: hdc1: using ordered data mode
ReiserFS: hdc1: journal params: device hdc1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc1: checking transaction log (hdc1)
unknown card 0x878-0x1554:0x4011, using default rate 32000
please mail id, board name, and, if it works, the correct digital_rate option to <alsa-devel@alsa-project.org>
ACPI: PCI Interrupt 0000:00:0b.1[A] -> GSI 18 (level, low) -> IRQ 19
ReiserFS: hdc1: Using r5 hash to sort names
bttv: driver version 0.9.17 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 18 (level, low) -> IRQ 19
bttv0: Bt878 (rev 17) at 0000:00:0b.0, irq: 19, latency: 32, mmio: 0xdddfe000
bttv0: detected: Prolink Pixelview PV-BT [card=72], PCI subsystem ID is 1554:4011
bttv0: using: Prolink PixelView PlayTV MPEG2 PV-M4900 [card=139,insmod option]
bttv0: gpio: en=00000000, out=00000000 in=006fc0bf [init]
bttv0: using tuner=59
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: i2c: checking for TDA9887 @ 0x86... not found
tuner 0-0061: chip found @ 0xc2 (bt878 #0 [sw])
tuner 0-0061: type set to 59 (Ymec TVision TVF-5533MF)
tuner 0-0061: type set to 59 (Ymec TVision TVF-5533MF)
tuner 0-0063: chip found @ 0xc6 (bt878 #0 [sw])
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .<6>Adding 995988k swap on /dev/hda1.  Priority:1 extents:1 across:995988k
.<6>Adding 1052248k swap on /dev/hdc2.  Priority:0 extents:1 across:1052248k
 ok
input: bttv IR (card=139) as /class/input/input5
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

--MP_AchoAfMslb4fwMiMd6UT/dX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--MP_AchoAfMslb4fwMiMd6UT/dX--
