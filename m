From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000914]: nm256 causes kernel to hard freeze
Date: Thu, 17 Feb 2005 22:40:52 +0100
Message-ID: <35ede79767c168f265c20f0f39103870@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 842CE26C
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2005 22:40:52 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=914> 
======================================================================
Reported By:                vaxen
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   914
Category:                   PCI - nm256
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.9 2.6.10
======================================================================
Date Submitted:             02-16-2005 20:39 CET
Last Modified:              02-17-2005 22:40 CET
======================================================================
Summary:                    nm256 causes kernel to hard freeze
Description: 
Hi, here is my specs:

Gateway solo 3300
http://support.gateway.com/support/manlib/Notebooks/Solo3300/8506533/06533.htm
Audio chipset NM2200 interface to AC97 CODEC

pegasos vaxen # lspci -tv
-[00]-+-00.0  Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
      +-01.0-[01]--+-00.0  Neomagic Corporation NM2200 [MagicGraph 256AV]
      |            \-00.1  Neomagic Corporation NM2200 [MagicMedia 256AV
Audio]
      +-07.0  Intel Corp. 82371AB/EB/MB PIIX4 ISA
      +-07.1  Intel Corp. 82371AB/EB/MB PIIX4 IDE
      +-07.2  Intel Corp. 82371AB/EB/MB PIIX4 USB
      +-07.3  Intel Corp. 82371AB/EB/MB PIIX4 ACPI
      +-0a.0  Texas Instruments PCI1211
      +-0d.0  3Com Corporation 3c905C-TX/TX-M [Tornado]
      \-10.0  Agere Systems (former Lucent Microelectronics) WinModem 56k

I am using a custom patched kernel at
http://morph-sources.sourceforge.net/?q=node/27 

It is using 2.6.10 with 1.08 alsa drivers wth alsa-bk-2005-01-05.patch and
alsa-bk-2005-01-14.patch.

I compiled the drivers into the kernel, the kernel hard freezes after
displaying these message:
nm256:found card signature in video RAM: 0x27ec00
nm256:Mapping port 1 from 0x2709a0-0x27ec00
I have to switch off the laptop as it does not respond to any inputs.

I also tried compiling the drivers as modules, when I tried to modprobe
snd-nm256, the kernel hard freezes without any warning message.

I also tried vanilla 2.6.9 which contains alsa 1.0.6 driver. It freezes
like 2.6.10.

I have not tried alsa 1.0.7 driver.

Please let me know if you need more diagnostic information to fix this
problem.
======================================================================

----------------------------------------------------------------------
 vaxen - 02-17-05 21:28 
----------------------------------------------------------------------
Linux version 2.6.10-morph23 (root@pegasos) (gcc version 3.4.3 20050110
(Gentoo Linux 3.4.3.20050110, ssp-3.4.3.20050110-0, pie-8.7.7))
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4 Thu Feb
17 20:11:00 GMT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000eac00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007fffc00 (ACPI data)
 BIOS-e820: 0000000007fffc00 - 0000000008000000 (ACPI NVS)
 BIOS-e820: 00000000fffeac00 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32752
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 28656 pages, LIFO batch:6
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6b10
ACPI: RSDT (v001 GATEWA SOLO3300 0x20000529  LTP 0x00000000) @ 0x07ffcb5b
ACPI: FADT (v001 GATEWA SOLO3300 0x20000529 PTL  0x000f4240) @ 0x07fffb65
ACPI: BOOT (v001 GATEWA SOLO3300 0x20000529  LTP 0x00000001) @ 0x07fffbd9
ACPI: DSDT (v001 GATEWA SOLO3300 0x20000529 MSFT 0x01000007) @ 0x00000000
Built 1 zonelists
Kernel command line: root=/dev/hda3 resume2=swap:/dev/hda2
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01102000)
Initializing CPU#0
CPU 0 irqstacks, hard=c0502000 soft=c0501000
PID hash table entries: 512 (order: 9, 8192 bytes)
Detected 497.959 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 124956k/131008k available (2921k kernel code, 5540k reserved, 972k
data, 180k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 983.04 BogoMIPS (lpj=491520)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000
00000000 00000000
CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000
00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0408)
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9d5, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050125
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 14 15)
ACPI: Device [FDDA] status [00000008]: functional but not present; setting
present
ACPI: Embedded Controller [EC0] (gpe 0)
ACPI: Device [CDRM] status [00000008]: functional but not present; setting
present
ACPI: Power Resource [PIDE] (on)
ACPI: Power Resource [PMDE] (on)
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
pnp: 00:05: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:05: ioport range 0x8000-0x803f could not be reserved
pnp: 00:05: ioport range 0x2180-0x218f has been reserved
pnp: 00:05: ioport range 0x398-0x399 has been reserved
Simple Boot Flag at 0x63 set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1108671266.066:0): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Limiting direct PCI/PCI transfers.
inotify device minor=63
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 94M
agpgart: AGP aperture is 64M @ 0xf8000000
vesafb: NeoMagic, MagicMedia 256 AV, 01.0 (OEM: MagicGraph 256 AV 48K)
vesafb: VBE version: 2.0
vesafb: protected mode interface info at c000:a690
vesafb: pmi: set display start = c00ca6c6, set palette = c00ca726
vesafb: monitor limits: vf = 0 Hz, hf = 0 kHz, clk = 0 MHz
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 100x37
vesafb: framebuffer at 0xf6000000, mapped to 0xc8880000, using 937k, total
2496k
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [ACAD] (off-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (58 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using cfq as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 10 (level, low) -> IRQ 10
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0d.0: 3Com PCI 3c905C Tornado at 0xfc00. Vers LK1.1.19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcd0-0xfcd7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfcd8-0xfcdf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK1214GAP, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 23579136 sectors (12072 MB), CHS=23392/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 hda3
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 10 (level, low) -> IRQ 10
Yenta: CardBus bridge found at 0000:00:0a.0 [107b:3300]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0a.0, mfunc 0x01201212, devctl 0x64
Yenta: ISA IRQ mask 0x08b8, PCI irq 10
Socket status: 30000006
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:07.2: Intel Corp. 82371AB/EB/MB PIIX4 USB
uhci_hcd 0000:00:07.2: irq 10, io base 0xfce0
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: over-current change on port 2
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 4.1
 180 degree mounted touchpad
 Sensor: 8
 new absolute packet format
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13
09:39:32 2005 UTC).
ALSA device list:
  No soundcards found.
oprofile: using timer interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
Software Suspend Core.
Software Suspend text mode support loaded.
Software Suspend LZF Compression Driver registered.
Software Suspend Swap Writer registered.
ACPI wakeup devices: 
PCI0 COMA CRD0 MDEM  LID 
ACPI: (supports S0 S3 S4 S5)
Looking for first block of swap header at block 0.
Setting logical block size of resume device to 4096.
Software Suspend 2.1.5.15: Swap space signature found.
Software Suspend 2.1.5.15: Suspending enabled.
Software Suspend 2.1.5.15: This is normal swap space.
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max trans
age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 180k freed
Adding 506036k swap on /dev/hda2.  Priority:-1 extents:1
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x37f
cs: IO port probe 0x0a00-0x0aff: clean.
mtrr: 0xf6000000,0x400000 overlaps existing 0xf6000000,0x200000

This is my current dmesg for 2.6.10-morph23. First I thought it would be
the frame buffer giving problem since nm256 share the same mem as the
video. I removed the frame buffer and still nm256 freezes the kernel. As
you notice the alsa line in the dmesg says "No soundcards found." Why
can't alsa see the card?

----------------------------------------------------------------------
 vaxen - 02-17-05 22:40 
----------------------------------------------------------------------
I just tried compiling the free OSS in the kernel as modules. modprobe
nm256_audio also freezes the kernel. So far only the OSS module from
knoppix 3.4 is working.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-16-05 20:39 vaxen          New Issue                                    
02-16-05 20:39 vaxen          Kernel Version            => 2.6.9 2.6.10    
02-16-05 21:36 vaxen          Note Added: 0003626                          
02-16-05 21:38 vaxen          Note Edited: 0003626                         
02-16-05 21:56 vaxen          Note Edited: 0003626                         
02-17-05 18:31 tiwai          Note Added: 0003632                          
02-17-05 20:44 vaxen          Note Added: 0003638                          
02-17-05 20:45 vaxen          Note Edited: 0003638                         
02-17-05 21:28 vaxen          Note Added: 0003641                          
02-17-05 22:40 vaxen          Note Added: 0003644                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
