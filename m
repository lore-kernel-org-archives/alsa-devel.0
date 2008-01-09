From: Georgi Chorbadzhiyski <gf@unixsol.org>
Subject: No sound over HDMI on HDA-Intel - HDA ATI HDMI
Date: Wed, 09 Jan 2008 13:06:02 +0200
Message-ID: <4784AA9A.6000003@unixsol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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

Hi, I have an Asus MB with integrated ATI X1200 audio controller
connected over HDMI to an LCD TV.

intel-hda driver correctly identifies and drives the card, but
I get no sound over HDMI only over the standard stereo output
jack. I've unmuted iec958 control on the HDMI card.

I'm testing the card like this:

root@browser:~# aplay -D plughw:1,0 test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 16000 Hz, Stereo

No sound.

root@browser:~# aplay -D plughw:0,0 test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 16000 Hz, Stereo

Sound is ok.

Is there some patches that I could try to get the HDMI output
working?

Similar reports:
http://www.mail-archive.com/ubuntu-bugs@lists.ubuntu.com/msg590477.html
http://www.redhat.com/archives/rhl-list/2007-November/msg00372.html

aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: HDA Generic [HDA Generic]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: HDMI [HDA ATI HDMI], device 0: ATI HDMI [ATI HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


/proc/asound/cards
 0 [SB             ]: HDA-Intel - HDA ATI SB
                      HDA ATI SB at 0xfe8f4000 irq 16
 1 [HDMI           ]: HDA-Intel - HDA ATI HDMI
                      HDA ATI HDMI at 0xfeae8000 irq 19

lspci
00:00.0 Host bridge: ATI Technologies Inc RS690 Host Bridge
00:01.0 PCI bridge: ATI Technologies Inc RS690 PCI to PCI Bridge (Internal gfx)
00:06.0 PCI bridge: ATI Technologies Inc RS690 PCI to PCI Bridge (PCI Express Port 2)
00:07.0 PCI bridge: ATI Technologies Inc RS690 PCI to PCI Bridge (PCI Express Port 3)
00:12.0 SATA controller: ATI Technologies Inc SB600 Non-Raid-5 SATA
00:13.0 USB Controller: ATI Technologies Inc SB600 USB (OHCI0)
00:13.1 USB Controller: ATI Technologies Inc SB600 USB (OHCI1)
00:13.2 USB Controller: ATI Technologies Inc SB600 USB (OHCI2)
00:13.3 USB Controller: ATI Technologies Inc SB600 USB (OHCI3)
00:13.4 USB Controller: ATI Technologies Inc SB600 USB (OHCI4)
00:13.5 USB Controller: ATI Technologies Inc SB600 USB Controller (EHCI)
00:14.0 SMBus: ATI Technologies Inc SBx00 SMBus Controller (rev 14)
00:14.1 IDE interface: ATI Technologies Inc SB600 IDE
00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia
00:14.3 ISA bridge: ATI Technologies Inc SB600 PCI to LPC Bridge
00:14.4 PCI bridge: ATI Technologies Inc SBx00 PCI to PCI Bridge
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:05.0 VGA compatible controller: ATI Technologies Inc RS690 [Radeon X1200 Series]
01:05.2 Audio device: ATI Technologies Inc Radeon X1200 Series Audio Controller
03:00.0 Ethernet controller: Attansic Technology Corp. L1 Gigabit Ethernet Adapter (rev b0)

lspci -vv
01:05.2 Audio device: ATI Technologies Inc Radeon X1200 Series Audio Controller
	Subsystem: ASUSTeK Computer Inc. Unknown device 8287
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 19
	Region 0: Memory at feae8000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

dmesg:
Linux version 2.6.24-rc6 (gf@gf) (gcc version 4.1.2) #32 SMP PREEMPT Tue Jan 8 19:08:44 EET 2008
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000037fb0000 (usable)
 BIOS-e820: 0000000037fb0000 - 0000000037fbe000 (ACPI data)
 BIOS-e820: 0000000037fbe000 - 0000000037fe0000 (ACPI NVS)
 BIOS-e820: 0000000037fe0000 - 0000000038000000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
895MB LOWMEM available.
found SMP MP-table at 000ff780
Entering add_active_range(0, 0, 229296) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229296
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   229296
On node 0 totalpages: 229296
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1759 pages used for memmap
  Normal zone: 223441 pages, LIFO batch:31
  Movable zone: 0 pages used for memmap
DMI present.
ATI board detected. Disabling timer routing over 8254.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: ASUS     Product ID:  APIC at: 0xFEE00000
Processor #0 15:15 APIC version 16
I/O APIC #1 Version 33 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at 40000000 (gap: 38000000:c7f00000)
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 227505
Kernel command line: auto BOOT_IMAGE=Linux ro root=801 quiet
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2009.066 MHz processor.
Console: colour dummy device 80x25
console [tty0] enabled
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 906216k/917184k available (1460k kernel code, 10468k reserved, 560k data, 172k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffba000 - 0xfffff000   ( 276 kB)
    vmalloc : 0xf8800000 - 0xfffb8000   ( 119 MB)
    lowmem  : 0xc0000000 - 0xf7fb0000   ( 895 MB)
      .init : 0xc02ff000 - 0xc032a000   ( 172 kB)
      .data : 0xc026d14d - 0xc02f9154   ( 560 kB)
      .text : 0xc0100000 - 0xc026d14d   (1460 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
SLUB: Genslabs=11, HWalign=64, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
Calibrating delay using timer specific routine.. 4109.60 BogoMIPS (lpj=2054803)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 078bfbff ebd3fbff 00000000 00000000 00002001 00000000 0000001d 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 078bfbff ebd3fbff 00000000 00000410 00002001 00000000 0000001d 00000000
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 8k freed
CPU0: AMD Athlon(tm) 64 Processor 3200+ stepping 02
Total of 1 processors activated (4109.60 BogoMIPS).
ExtINT not setup in hardware but reported by MP table
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
Brought up 1 CPUs
net_namespace: 64 bytes
NET: Registered protocol family 16
PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=4
Setting up standard PCI resources
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:14.4
PCI: Using IRQ router default [1002/438d] at 0000:00:14.3
PCI->APIC IRQ transform: 0000:00:12.0[A] -> IRQ 22
PCI->APIC IRQ transform: 0000:00:13.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:13.1[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:00:13.2[C] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:13.3[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:00:13.4[C] -> IRQ 18
PCI->APIC IRQ transform: 0000:00:13.5[D] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:14.1[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:14.2[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:01:05.0[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:01:05.2[B] -> IRQ 19
PCI->APIC IRQ transform: 0000:03:00.0[A] -> IRQ 19
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: fe900000-feafffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:07.0
  IO window: disabled.
  MEM window: feb00000-febfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:14.4
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:06.0 to 64
PCI: Setting latency timer of device 0000:00:07.0 to 64
NET: Registered protocol family 2
Time: tsc clocksource has been installed.
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
io scheduler noop registered (default)
Boot video device is 0000:01:05.0
vesafb: framebuffer at 0xf0000000, mapped to 0xf8800000, using 2000k, total 16384k
vesafb: mode is 640x400x32, linelength=2560, pages=15
vesafb: protected mode interface info at c000:a034
vesafb: pmi: set display start = c00ca0be, set palette = c00ca17c
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
Console: switching to colour frame buffer device 80x25
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.102
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
PCI: Setting latency timer of device 0000:03:00.0 to 64
atl1 0000:03:00.0: version 2.0.7
ahci 0000:00:12.0: version 3.0
ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
ahci 0000:00:12.0: controller can't do PMP, turning off CAP_PMP
ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pio slum part
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 abar m1024@0xfe8ff800 port 0xfe8ff900 irq 22
ata2: SATA max UDMA/133 abar m1024@0xfe8ff800 port 0xfe8ff980 irq 22
ata3: SATA max UDMA/133 abar m1024@0xfe8ff800 port 0xfe8ffa00 irq 22
ata4: SATA max UDMA/133 abar m1024@0xfe8ff800 port 0xfe8ffa80 irq 22
ata1: SATA link down (SStatus 0 SControl 300)
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7: ST380815AS, 3.AAD, max UDMA/133
ata2.00: 156301488 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata2.00: configured for UDMA/133
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
scsi 1:0:0:0: Direct-Access     ATA      ST380815AS       3.AA PQ: 0 ANSI: 5
sd 1:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1
sd 1:0:0:0: [sda] Attached SCSI disk
ehci_hcd 0000:00:13.5: EHCI Host Controller
ehci_hcd 0000:00:13.5: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.5: debug port 1
ehci_hcd 0000:00:13.5: irq 19, io mem 0xfe8ff000
ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.0: irq 16, io mem 0xfe8fe000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.1: irq 17, io mem 0xfe8fd000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ohci_hcd 0000:00:13.2: OHCI Host Controller
ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:13.2: irq 18, io mem 0xfe8fc000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ohci_hcd 0000:00:13.3: OHCI Host Controller
ohci_hcd 0000:00:13.3: new USB bus registered, assigned bus number 5
ohci_hcd 0000:00:13.3: irq 17, io mem 0xfe8fb000
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 3-2: new low speed USB device using ohci_hcd and address 2
ohci_hcd 0000:00:13.4: OHCI Host Controller
ohci_hcd 0000:00:13.4: new USB bus registered, assigned bus number 6
ohci_hcd 0000:00:13.4: irq 18, io mem 0xfe8fa000
usb 3-2: configuration #1 chosen from 1 choice
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
USB Universal Host Controller Interface driver v3.0
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:00/0000:00:13.1/usb3/3-2/3-2:1.0/input/input0
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:13.1-2
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.15 (Tue Nov 20 19:16:42 2007 UTC).
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
ALSA device list:
  #0: HDA ATI SB at 0xfe8f4000 irq 16
  #1: HDA ATI HDMI at 0xfeae8000 irq 19
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 172k freed
atl1 0000:03:00.0: eth0 link is up 100 Mbps full duplex

-- 
Georgi Chorbadzhiyski
http://georgi.unixsol.org/
