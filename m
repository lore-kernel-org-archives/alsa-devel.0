From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000404]: No Sound out of the Center Channel
Date: Fri, 24 Sep 2004 13:37:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924113740.E7E20101DE@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 49A6B288
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:37:41 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000404
======================================================================
Reported By:                creeves
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     404
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.7-r10
======================================================================
Date Submitted:             07-24-2004 20:17 CEST
Last Modified:              09-24-2004 13:37 CEST
======================================================================
Summary:                    No Sound out of the Center Channel
Description: 
I am unable to produce any sound out of the center channel when playing 5.1
surround sound from vlc. Stereo and 2 front and 2 rear works. The
motherboard is Abit VA-10. I have tried all of the ac3_quirk options with
no success; its currently set to disabled. I am also recieving a buzzing
noise unless I have the dxs_support=4.

#### Proc Output #####
Below is some information I thought would be useful.
bash-2.05b# cat /proc/asound/cards
0 [V8235          ]: VIA8233 - VIA 8235
                     VIA 8235 at 0xdc00, irq 22
#### End Proc Output #####

##### Dmesg Output #####
bash-2.05b# dmesg
c_id[0x00] enabled)
Processor https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000000 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: ro root=/dev/hda3
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2087.877 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 513376k/524224k available (4000k kernel code, 10084k reserved,
1163k data, 204k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 4096.00 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security
failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
There is already a security framework initialized, register_security
failed.
Failure registering Root Plug module with the kernel
selinux_register_security:  There is already a secondary security module
registered.
Failure registering Root Plug  module with primary security module.
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: AMD Athlon(tm) XP 2800+ stepping 00
per-CPU timeslice cutoff: 1462.79 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Total of 1 processors activated (4096.00 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23
not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2087.0082 MHz.
..... host bus clock speed is 333.0933 MHz.
Brought up 1 CPUs
CPU0:  online
 domain 0: span 01
  groups: 01
  domain 1: span 01
   groups: 01
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb5c0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *0
ACPI: PCI Interrupt Link [ALKB] (IRQs 21) *0
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *0
ACPI: PCI Interrupt Link [ALKD] (IRQs 23) *0
ACPI: Power Resource [PFAN] (off)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
00:00:08[A] -> 2-16 -> IRQ 16 level low
00:00:08[B] -> 2-17 -> IRQ 17 level low
00:00:08[C] -> 2-18 -> IRQ 18 level low
00:00:08[D] -> 2-19 -> IRQ 19 level low
ACPI: PCI Interrupt Link [ALKB] BIOS reported IRQ 0, using IRQ 21
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 21
00:00:10[A] -> 2-21 -> IRQ 21 level low
ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 20
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
00:00:11[A] -> 2-20 -> IRQ 20 level low
ACPI: PCI Interrupt Link [ALKC] BIOS reported IRQ 0, using IRQ 22
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
00:00:11[C] -> 2-22 -> IRQ 22 level low
ACPI: PCI Interrupt Link [ALKD] BIOS reported IRQ 0, using IRQ 23
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 23
00:00:11[D] -> 2-23 -> IRQ 23 level low
number of MP IRQ sources: 15.
number of IO-APIC https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002 registers: 24.
testing the IO APIC.......................
IO APIC https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002......
.... register https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000000: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    A9
 11 001 01  1    1    0   1   0    1    1    B1
 12 001 01  1    1    0   1   0    1    1    B9
 13 001 01  1    1    0   1   0    1    1    C1
 14 001 01  1    1    0   1   0    1    1    D1
 15 001 01  1    1    0   1   0    1    1    C9
 16 001 01  1    1    0   1   0    1    1    D9
 17 001 01  1    1    0   1   0    1    1    E1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
NET: Registered protocol family 23
vesafb: probe of vesafb0 failed with error -6
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1090629112.843:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.14 [Flags: R/W].
udf: registering filesystem
SGI XFS with large block numbers, no debug enabled
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
PCI: Via IRQ fixup for 0000:00:10.1, from 3 to 5
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 5
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN] (off)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (57 C)
mice: PS/2 mouse device common for all mice
usbcore: registered new driver iforce
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA P4X600 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
via-rhine.c:v1.10-LK1.1.20-2.6 May-23-2004 Written by Donald Becker
eth0: VIA VT6102 Rhine-II at 0xe000, 00:50:8d:5c:0c:c0, IRQ 23.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link
45e1.
usbcore: registered new driver irda-usb
USB IrDA support registered
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
hda: MAXTOR 6L080J4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: _NEC DVD_RW ND-2500A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=65535/16/63,
UDMA(133)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
Loading Adaptec I2O RAID: Version 2.4 Build 5go
Detecting Adaptec I2O RAID controllers...
libata version 1.02 loaded.
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[16] 
MMIO=[e3003000-e30037ff]  Max Packet=[2048]
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
ip1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
ip1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ehci_hcd 0000:00:10.3: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.3: irq 21, pci mem e08c8000
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller
uhci_hcd 0000:00:10.0: irq 21, io base 0000cc00
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002)
uhci_hcd 0000:00:10.1: irq 21, io base 0000d000
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000003)
uhci_hcd 0000:00:10.2: irq 21, io base 0000d400
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver ati_remote
drivers/usb/input/ati_remote.c: Registered USB driver ATI/X10 RF USB
Remote Control v. 2.2.0
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
i2c /dev entries driver
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 300 bytes per
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
usb 3-2: new low speed USB device using address 2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[001206000000002c]
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max trans
age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 204k freed
Adding 506036k swap on /dev/hda2.  Priority:-1 extents:1
nvidia: module license 'NVIDIA' taints kernel.
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6106  Wed Jun 23
08:14:01 PDT 2004
PCI: Setting latency timer of device 0000:00:11.5 to 64
bttv: driver version 0.9.14 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:00:09.0, irq: 17, latency: 32, mmio:
0xe3000000
bttv0: subsystem: 107d:6609 (UNKNOWN)
please mail id, board name and the correct card= insmod option to
kraxel@bytesex.org
bttv0: using: Leadtek WinFast 2000/ WinFast 2000 XP [card=34,insmod
option]
bttv0: gpio: en=00000000, out=00000000 in=003fffff [init]
tuner: chip found at addr 0xc2 i2c-bus bt878 https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000000 [sw]
tuner: type set to 2 (Philips NTSC (FI1236,FM1236 and compatibles)) by
insmod option
tuner: The type=<n> insmod option will go away soon.
tuner: Please use the tuner=<n> option provided by
tuner: tv card core driver (bttv, saa7134, ...) instead.
bttv0: using tuner=5
tuner: type already set to 2, ignoring request for 5
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
bttv0: add subdevice "remote0"
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips:
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54
(PV951),ta8874z
eth0: Setting full-duplex based on MII https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 link partner capability of 45e1.
agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might
be trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might
be trying access hardware directly.
bttv0: PLL can sleep, using XTAL (28636363).
PCI: Setting latency timer of device 0000:00:11.5 to 64
#### End Dmesg Output ####

#### Modules.conf File ####

### This file is automatically generated by modules-update
#
# Please do not edit this file directly. If you want to change or add
# anything please take a look at the files in /etc/modules.d and read
# the manpage for modules-update.
#
### modules-update: start processing /etc/modules.d/aliases
# Aliases to tell insmod/modprobe which modules to use

# Uncomment the network protocols you don't want loaded:
# alias net-pf-1 off            # Unix
# alias net-pf-2 off            # IPv4
# alias net-pf-3 off            # Amateur Radio AX.25
# alias net-pf-4 off            # IPX
# alias net-pf-5 off            # DDP / appletalk
# alias net-pf-6 off            # Amateur Radio NET/ROM
# alias net-pf-9 off            # X.25
# alias net-pf-10 off           # IPv6
# alias net-pf-11 off           # ROSE / Amateur Radio X.25 PLP
# alias net-pf-19 off           # Acorn Econet

alias char-major-10-175 agpgart
alias char-major-10-200 tun
alias char-major-81     bttv
alias char-major-108    ppp_generic
alias /dev/ppp          ppp_generic
alias tty-ldisc-3       ppp_async
alias tty-ldisc-14      ppp_synctty
alias ppp-compress-21   bsd_comp
alias ppp-compress-24   ppp_deflate
alias ppp-compress-26   ppp_deflate

# Crypto modules (see http://www.kerneli.org/)
alias loop-xfer-gen-0   loop_gen
alias loop-xfer-3       loop_fish2
alias loop-xfer-gen-10  loop_gen
alias cipher-2          des
alias cipher-3          fish2
alias cipher-4          blowfish
alias cipher-6          idea
alias cipher-7          serp6f
alias cipher-8          mars6
alias cipher-11         rc62
alias cipher-15         dfc2
alias cipher-16         rijndael
alias cipher-17         rc5

# Support for i2c and lm_sensors
alias char-major-89    i2c-dev

# Old nvidia support ...
alias char-major-195 NVdriver
alias /dev/nvidiactl char-major-195

### modules-update: end processing /etc/modules.d/aliases

### modules-update: start processing /etc/modules.d/alsa
# Alsa 0.9.X kernel modules' configuration file.
# $Header:
/var/cvsroot/gentoo-x86/media-sound/alsa-utils/files/alsa-modules.conf-rc,v
1.1 2003/08/05 21:07:55 johnm Exp $

# ALSA portion

# OSS/Free portion

##
## IMPORTANT:
## You need to customise this section for your specific sound card(s)
## and then run `update-modules' command.
## Read alsa-driver's INSTALL file in /usr/share/doc for more info.
##
##  ALSA portion
## alias snd-card-0 snd-interwave
## alias snd-card-1 snd-ens1371
##  OSS/Free portion
## alias sound-slot-0 snd-card-0
## alias sound-slot-1 snd-card-1
##

# OSS/Free portion - card https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001
##  OSS/Free portion - card https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002
## alias sound-service-1-0 snd-mixer-oss
## alias sound-service-1-3 snd-pcm-oss
## alias sound-service-1-12 snd-pcm-oss

alias /dev/mixer snd-mixer-oss
alias /dev/dsp snd-pcm-oss
alias /dev/midi snd-seq-oss

# Set this to the correct number of cards.

# --- BEGIN: Generated by ALSACONF, do not edit. ---
# --- ALSACONF verion 1.0.5 ---
options snd  device_mode=0666
alias snd-card-0 snd-via82xx
alias sound-slot-0 snd-via82xx
# --- END: Generated by ALSACONF, do not edit. ---

alias char-major-116 snd
alias char-major-14 soundcore
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
options snd major=116 cards_limit=1
options snd-via82xx index=0 dxs_support=4 ac97_quirk=0

### modules-update: end processing /etc/modules.d/alsa

### modules-update: start processing /etc/modules.d/bttv
# TV
alias   char-major-81   bttv
pre-install bttv        modprobe -k tuner; modprobe -k msp3400
options bttv            radio=1 card=34
options tuner           type=2

### modules-update: end processing /etc/modules.d/bttv

### modules-update: start processing /etc/modules.d/i386
alias parport_lowlevel parport_pc
alias char-major-10-144 nvram
alias binfmt-0064 binfmt_aout
alias char-major-10-135 rtc

### modules-update: end processing /etc/modules.d/i386

### modules-update: start processing /etc/modules.d/nvidia
# Nvidia drivers support
alias char-major-195 nvidia
alias /dev/nvidiactl char-major-195

# To tweak the driver the following options can be used, note that
# you should be careful, as it could cause instability!!
#
#   To enable Side Band Adressing:  NVreg_EnableAGPSBA=1
#
#   To enable Fast Writes: NVreg_EnableAGPFW=1
#
# To enable both for instance, uncomment following line:
#
#options nvidia NVreg_EnableAGPSBA=1 NVreg_EnableAGPFW=1


### modules-update: end processing /etc/modules.d/nvidia

### modules-update: start processing /etc/modules.d/svgalib
probeall  /dev/svga  svgalib_helper

### modules-update: end processing /etc/modules.d/svgalib

##### End Modules.conf File #####

======================================================================

----------------------------------------------------------------------
 tiwai - 07-30-2004 17:13 CEST 
----------------------------------------------------------------------
Did you test via speaker-test program?

ac97_quirk has unlikely any influence on this problem.
Also, please provide the output of 'lspci -nv' to add the DXS whitelist
entry.

----------------------------------------------------------------------
 creeves - 08-01-2004 10:44 CEST 
----------------------------------------------------------------------
lspci -nv
0000:00:00.0 Class 0600: 1106:3205
        Subsystem: 147b:140b
        Flags: bus master, 66Mhz, medium devsel, latency 8
        Memory at d0000000 (32-bit, prefetchable)
        Capabilities: [80] AGP version 3.5
        Capabilities: [c0] Power Management version 2

0000:00:01.0 Class 0604: 1106:b198
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e0000000-e1ffffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        Capabilities: [80] Power Management version 2

0000:00:08.0 Class 0c00: 1106:3044 (rev 43) (prog-if 10)
        Subsystem: 1106:3044
        Flags: bus master, medium devsel, latency 32, IRQ 16
        Memory at e3003000 (32-bit, non-prefetchable)
        I/O ports at c000 [size=128]
        Capabilities: [50] Power Management version 2

0000:00:09.0 Class 0400: 109e:036e (rev 11)
        Subsystem: 107d:6609
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at e3000000 (32-bit, prefetchable)
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2

0000:00:09.1 Class 0480: 109e:0878 (rev 11)
        Subsystem: 107d:6609
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at e3001000 (32-bit, prefetchable)
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2

0000:00:0a.0 Class 0100: 9004:7895 (rev 03)
        Subsystem: 9004:7892
        Flags: bus master, medium devsel, latency 32, IRQ 18
        I/O ports at c400
        Memory at e3002000 (32-bit, non-prefetchable) [size=4K]

0000:00:0a.1 Class 0100: 9004:7895 (rev 03)
        Subsystem: 9004:7892
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at c800
        Memory at e3004000 (32-bit, non-prefetchable) [size=4K]

0000:00:10.0 Class 0c03: 1106:3038 (rev 80)
        Subsystem: 147b:140b
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at cc00 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:10.1 Class 0c03: 1106:3038 (rev 80)
        Subsystem: 147b:140b
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:10.2 Class 0c03: 1106:3038 (rev 80)
        Subsystem: 147b:140b
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:10.3 Class 0c03: 1106:3104 (rev 82) (prog-if 20)
        Subsystem: 147b:140b
        Flags: bus master, medium devsel, latency 32, IRQ 21
        Memory at e3005000 (32-bit, non-prefetchable)
        Capabilities: [80] Power Management version 2

0000:00:11.0 Class 0601: 1106:3177
        Subsystem: 147b:140b
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

0000:00:11.1 Class 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP
PriP])
        Subsystem: 147b:140b
        Flags: bus master, medium devsel, latency 32, IRQ 20
        I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2

0000:00:11.5 Class 0401: 1106:3059 (rev 50)
        Subsystem: 147b:140b
        Flags: medium devsel, IRQ 22
        I/O ports at dc00
        Capabilities: [c0] Power Management version 2

0000:00:12.0 Class 0200: 1106:3065 (rev 74)
        Subsystem: 147b:140b
        Flags: bus master, medium devsel, latency 32, IRQ 23
        I/O ports at e000
        Memory at e3006000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2

0000:01:00.0 Class 0300: 10de:0322 (rev a1)
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 16
        Memory at e0000000 (32-bit, non-prefetchable)
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 3.0

----------------------------------------------------------------------
 creeves - 08-01-2004 10:48 CEST 
----------------------------------------------------------------------
Yes, I ran these test via a speaker test program. There is no sound coming
out of the center/subwoofer channel for 5.1 surround sound. There is sound
from the frount/rear right and left speakers and subwoofer when it is set
to 4-channel audio.

----------------------------------------------------------------------
 creeves - 08-01-2004 10:57 CEST 
----------------------------------------------------------------------
I had a slight misstatemnet in my last post. 
There in no sound of the rear channels when set to 4-channel mode and
5.1.
Is this a possible problem with the .asound file?

----------------------------------------------------------------------
 tiwai - 08-02-2004 18:33 CEST 
----------------------------------------------------------------------
Ah then it's a design issue, not a bug.
surround40 is designed for the physical 4.0 outputs.

You can do this thing with asoundrc, of course, but it's
out of the scope of bug-reporting system.
Please discuss this on alsa-devel or alsa-users ML.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-24-04 20:17 creeves        New Bug                                      
07-24-04 20:17 creeves        Distribution              => Gentoo          
07-24-04 20:17 creeves        Kernel Version            => 2.6.7-r10       
07-24-04 21:18 creeves        Bug Monitored: creeves                       
07-30-04 17:13 tiwai          Bugnote Added: 0001498                       
08-01-04 10:44 creeves        Bugnote Added: 0001512                       
08-01-04 10:48 creeves        Bugnote Added: 0001513                       
08-01-04 10:57 creeves        Bugnote Added: 0001514                       
08-02-04 18:33 tiwai          Bugnote Added: 0001525                       
08-02-04 18:33 tiwai          Assigned To               => tiwai           
08-02-04 18:33 tiwai          Resolution               open => not a bug   
08-02-04 18:33 tiwai          Status                   new => resolved     
09-24-04 13:37 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
