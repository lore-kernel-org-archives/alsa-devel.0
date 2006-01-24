From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001774]: still need OSS driver cause of missing joystick connector support in ALSA driver of PCI Ensoniq ES1371
Date: Tue, 24 Jan 2006 09:05:48 +0100
Message-ID: <56253d0cf72662f2361a9da548881222@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1BB11159
	for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2006 09:05:48 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1774> 
======================================================================
Reported By:                muftialsa
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1774
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               installed knoppix (a debian variant) with additional
packages
Kernel Version:             Linux v2.6.15
======================================================================
Date Submitted:             01-23-2006 10:41 CET
Last Modified:              01-24-2006 09:05 CET
======================================================================
Summary:                    still need OSS driver cause of missing joystick
connector support in ALSA driver of PCI Ensoniq ES1371
Description: 
Adrian Bunk <bunk@stusta.de> told me to public this problem here:

>From make menuconfig of the Linux kernel:

 Linux Kernel v2.6.15 Configuration

qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq
  lqqqqqqqqqqqqqqqqqqqqqqqqq Obsolete OSS drivers
qqqqqqqqqqqqqqqqqqqqqqqqqqk
  x CONFIG_OBSOLETE_OSS_DRIVER:                                           
 x  
  x                                                                       
 x  
  x This option enables support for obsolete OSS drivers that             
 x  
  x are scheduled for removal in the near future since there              
 x  
  x are ALSA drivers for the same hardware.                               
 x  
  x                                                                       
 x  
  x Please contact Adrian Bunk <bunk@stusta.de> if you had to             
 x  
  x say Y here because your soundcard is not properly supported           
 x  
  x by ALSA.                                                              
 x  

In fact i need to say Y to use the OSS drivers, cause i need to use
the joystick connector (analog gameport/midi combiconnector) of the
Ensoniq ES1371 for usage of my analog joystick. 
I am the maintainer/a developer of a 3D program named white_dune, which
can use the joystick.

For me, it looks like the ALSA version of the Ensoniq ES1371 driver do
not support the usage of the analog gameport/midi combiconnector for a 
joystick, while the OSS version of the Ensoniq ES1371 driver do support 
the usage of the analog gameport/midi combiconnector for a joystick

For me, it would be very unfortunate, if the OSS version of the Ensoniq
ES1371 
driver would be removed from the Linux kernel, if the ALSA version of the

Ensoniq ES1371 would still not support the possibility to connect a 
analog joystick to the Ensoniq ES1371.

#lspci
0000:00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host
bridge (rev 03)
0000:00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP
bridge (rev 03)
0000:00:04.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
0000:00:04.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
0000:00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
0000:00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
0000:00:06.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891
0000:00:09.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97]
(rev 08)
0000:00:0a.0 SCSI storage controller: Future Domain Corp. TMC-18C30
[36C70]
0000:00:0b.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX
[Cyclone] (rev 24)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV18GL [Quadro4
580 XGL] (rev a2)


# lspci -n
0000:00:00.0 0600: 8086:7190 (rev 03)
0000:00:01.0 0604: 8086:7191 (rev 03)
0000:00:04.0 0601: 8086:7110 (rev 02)
0000:00:04.1 0101: 8086:7111 (rev 01)
0000:00:04.2 0c03: 8086:7112 (rev 01)
0000:00:04.3 0680: 8086:7113 (rev 02)
0000:00:06.0 0100: 9005:001f
0000:00:09.0 0401: 1274:1371 (rev 08)
0000:00:0a.0 0100: 1036:0000
0000:00:0b.0 0200: 10b7:9055 (rev 24)
0000:01:00.0 0300: 10de:0188 (rev a2)


dmesg of a Kernel with ALSA Ensonic 1371 support:

#dmesg 
Linux version 2.6.15 (root@muftis) (gcc version 3.3.6 (Debian 1:3.3.6-7))
#6 SMP PREEMPT Sat Jan 7 22:25:55 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fffd000 (usable)
 BIOS-e820: 000000000fffd000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
found SMP MP-table at 000f6ed0
On node 0 totalpages: 65533
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 61437 pages, LIFO batch:15
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.0 present.
ASUS P2B-DS detected: force use of acpi=ht
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f8190
ACPI: RSDT (v001 ASUS   P2B-DS   0x58582e32 ASUS 0x31303030) @ 0x0fffd000
ACPI: FADT (v001 ASUS   P2B-DS   0x58582e32 ASUS 0x31303030) @ 0x0fffd100
ACPI: BOOT (v001 ASUS   P2B-DS   0x58582e32 ASUS 0x31303030) @ 0x0fffd040
ACPI: MADT (v001 ASUS   P2B-DS   0x00000000  0x00000000) @ 0x0fffd080
ACPI: DSDT (v001   ASUS P2B-DS   0x00001000 MSFT 0x01000001) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x01] enabled)
Processor #1 6:7 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:7 APIC version 17
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 20000000 (gap: 10000000:eec00000)
Built 1 zonelists
Kernel command line: root=/dev/sda1 ro ramdisk_size=100000 lang=de
apm=power-off nomce vga=791 
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 551.313 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 253244k/262132k available (3908k kernel code, 8352k reserved,
1369k data, 260k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay using timer specific routine.. 1103.22 BogoMIPS
(lpj=551611)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000
00000000 00000000
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Katmai) stepping 03
Booting processor 1/0 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1102.36 BogoMIPS
(lpj=551182)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000
00000000 00000000
CPU1: Intel Pentium III (Katmai) stepping 03
Total of 2 processors activated (2205.58 BogoMIPS).
ExtINT not setup in hardware but reported by MP table
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0730, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fd360
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xd390, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI quirk: region e400-e43f claimed by PIIX4 ACPI
PCI quirk: region e800-e80f claimed by PIIX4 SMB
PIIX4 devres B PIO at 0290-0297
Boot video device is 0000:01:00.0
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:04.0
PCI->APIC IRQ transform: 0000:00:04.2[D] -> IRQ 153
PCI->APIC IRQ transform: 0000:00:06.0[A] -> IRQ 153
PCI->APIC IRQ transform: 0000:00:09.0[A] -> IRQ 153
PCI->APIC IRQ transform: 0000:00:0a.0[A] -> IRQ 145
PCI->APIC IRQ transform: 0000:00:0b.0[A] -> IRQ 137
PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 129
pnp: 00:0f: ioport range 0x290-0x297 has been reserved
pnp: 00:0f: ioport range 0xe400-0xe43f has been reserved
pnp: 00:0f: ioport range 0xe800-0xe83f could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: d6000000-d7dfffff
  PREFETCH window: d7f00000-e3ffffff
Simple Boot Flag at 0x46 set to 0x1
apm: BIOS version 1.2 Flags 0x0b (Driver version 1.16ac)
apm: disabled - APM is not SMP safe (power off active).
audit: initializing netlink socket (disabled)
audit(1136673102.812:1): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.25 [Flags: R/O].
EFS: 1.0a - http://aeschi.ch.eu.org/efs/
fuse init (API version 7.3)
SGI XFS with ACLs, no debug enabled
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: AGP aperture is 64M @ 0xe4000000
PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:02: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:03: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
lp0: using parport0 (interrupt-driven).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 100000K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at d0812000. Vers
LK1.1.19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: LTN483, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: IBM       Model: DCAS-34330W       Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
 target0:0:1: Beginning Domain Validation
 target0:0:1: wide asynchronous.
 target0:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
 target0:0:1: Domain Validation skipping write tests
 target0:0:1: Ending Domain Validation
  Vendor: IBM       Model: DCAS-34330        Rev: S61A
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
 target0:0:6: Beginning Domain Validation
 target0:0:6: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)
 target0:0:6: Domain Validation skipping write tests
 target0:0:6: Ending Domain Validation
scsi1: <fdomain> No BIOS; using scsi id 7
scsi1: <fdomain> TMC-36C70 (PCI bus) chip at 0xb400 irq 145
scsi1 : Future Domain 16-bit SCSI Driver Version 5.51
  Vendor: FUJITSU   Model: M2513EL           Rev: 0020
  Type:   Direct-Access                      ANSI SCSI revision: 02
st: Version 20050830, fixed bufsize 32768, s/g segs 256
SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:1:0: Attached scsi disk sda
SCSI device sdb: 8467200 512-byte hdwr sectors (4335 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 8467200 512-byte hdwr sectors (4335 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2
sd 0:0:6:0: Attached scsi disk sdb
sd 1:0:5:0: Attached scsi removable disk sdc
sd 0:0:1:0: Attached scsi generic sg0 type 0
sd 0:0:6:0: Attached scsi generic sg1 type 0
sd 1:0:5:0: Attached scsi generic sg2 type 0
ieee1394: raw1394: /dev/raw1394 device initialized
usbmon: debugfs is not available
USB Universal Host Controller Interface driver v2.3
uhci_hcd 0000:00:04.2: UHCI Host Controller
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:04.2: irq 153, io base 0x0000d400
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usb 1-1: new low speed USB device using uhci_hcd and address 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
input: Wacom Graphire4 4x5 as /class/input/input0
usbcore: registered new driver wacom
drivers/usb/input/wacom.c: v1.44:USB Wacom Graphire and Wacom Intuos
tablet driver
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for
generic
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input1
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07
13:30:21 2005 UTC).
input: AT Translated Set 2 keyboard as /class/input/input2
input: ImPS/2 Generic Wheel Mouse as /class/input/input3
ALSA device list:
  #0: Ensoniq AudioPCI ENS1371 at 0xb800, irq 153
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 196608 bytes)
TCP bind hash table entries: 16384 (order: 5, 196608 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
ip_conntrack version 2.4 (2047 buckets, 16376 max) - 212 bytes per
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 260k freed
kjournald starting.  Commit interval 5 seconds
Warning: /proc/ide/hd?/settings interface is obsolete, and will be removed
soon!
EXT3 FS on sda1, internal journal
Adding 506008k swap on /dev/sdb1.  Priority:-1 extents:1 across:506008k
EXT3 FS on sda1, internal journal
EXT3-fs warning: maximal mount count reached, running e2fsck is
recommended
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
NFSD: starting 90-second grace period
nvidia: module license 'NVIDIA' taints kernel.
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7676  Fri Jul 29
12:58:54 PDT 2005
agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
NVRM: Xid: 17, Head=0 X=1024 Y=768 Refresh=115

Joysticktest with this kernel:

#jstest /dev/input/js0
jstest: No such device

dmesg of a kernel identical the last, except of the use of the 
OSS version of the Ensoniq ES1371 driver instead of the ALSA version.

#dmesg
Linux version 2.6.15 (root@muftis) (gcc version 3.3.6 (Debian 1:3.3.6-7))
#7 SMP PREEMPT Sat Jan 7 23:13:21 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fffd000 (usable)
 BIOS-e820: 000000000fffd000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
found SMP MP-table at 000f6ed0
On node 0 totalpages: 65533
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 61437 pages, LIFO batch:15
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.0 present.
ASUS P2B-DS detected: force use of acpi=ht
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f8190
ACPI: RSDT (v001 ASUS   P2B-DS   0x58582e32 ASUS 0x31303030) @ 0x0fffd000
ACPI: FADT (v001 ASUS   P2B-DS   0x58582e32 ASUS 0x31303030) @ 0x0fffd100
ACPI: BOOT (v001 ASUS   P2B-DS   0x58582e32 ASUS 0x31303030) @ 0x0fffd040
ACPI: MADT (v001 ASUS   P2B-DS   0x00000000  0x00000000) @ 0x0fffd080
ACPI: DSDT (v001   ASUS P2B-DS   0x00001000 MSFT 0x01000001) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x01] enabled)
Processor #1 6:7 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:7 APIC version 17
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 20000000 (gap: 10000000:eec00000)
Built 1 zonelists
Kernel command line: root=/dev/sda1 ro ramdisk_size=100000 lang=de
apm=power-off nomce vga=791 
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 551.263 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 253204k/262132k available (3938k kernel code, 8392k reserved,
1375k data, 260k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay using timer specific routine.. 1103.26 BogoMIPS
(lpj=551631)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000
00000000 00000000
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Katmai) stepping 03
Booting processor 1/0 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1102.40 BogoMIPS
(lpj=551201)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000
00000000 00000000
CPU1: Intel Pentium III (Katmai) stepping 03
Total of 2 processors activated (2205.66 BogoMIPS).
ExtINT not setup in hardware but reported by MP table
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0730, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fd360
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xd390, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI quirk: region e400-e43f claimed by PIIX4 ACPI
PCI quirk: region e800-e80f claimed by PIIX4 SMB
PIIX4 devres B PIO at 0290-0297
Boot video device is 0000:01:00.0
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:04.0
PCI->APIC IRQ transform: 0000:00:04.2[D] -> IRQ 153
PCI->APIC IRQ transform: 0000:00:06.0[A] -> IRQ 153
PCI->APIC IRQ transform: 0000:00:09.0[A] -> IRQ 153
PCI->APIC IRQ transform: 0000:00:0a.0[A] -> IRQ 145
PCI->APIC IRQ transform: 0000:00:0b.0[A] -> IRQ 137
PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 129
pnp: 00:0f: ioport range 0x290-0x297 has been reserved
pnp: 00:0f: ioport range 0xe400-0xe43f has been reserved
pnp: 00:0f: ioport range 0xe800-0xe83f could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: d6000000-d7dfffff
  PREFETCH window: d7f00000-e3ffffff
Simple Boot Flag at 0x46 set to 0x1
apm: BIOS version 1.2 Flags 0x0b (Driver version 1.16ac)
apm: disabled - APM is not SMP safe (power off active).
audit: initializing netlink socket (disabled)
audit(1136675822.794:1): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.25 [Flags: R/O].
EFS: 1.0a - http://aeschi.ch.eu.org/efs/
fuse init (API version 7.3)
SGI XFS with ACLs, no debug enabled
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: AGP aperture is 64M @ 0xe4000000
PNP: PS/2 Controller [PNP0303,PNP0f13] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:02: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:03: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
lp0: using parport0 (interrupt-driven).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 100000K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at d0812000. Vers
LK1.1.19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: LTN483, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: IBM       Model: DCAS-34330W       Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
 target0:0:1: Beginning Domain Validation
 target0:0:1: wide asynchronous.
 target0:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
 target0:0:1: Domain Validation skipping write tests
 target0:0:1: Ending Domain Validation
  Vendor: IBM       Model: DCAS-34330        Rev: S61A
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
 target0:0:6: Beginning Domain Validation
 target0:0:6: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)
 target0:0:6: Domain Validation skipping write tests
 target0:0:6: Ending Domain Validation
scsi1: <fdomain> No BIOS; using scsi id 7
scsi1: <fdomain> TMC-36C70 (PCI bus) chip at 0xb400 irq 145
scsi1 : Future Domain 16-bit SCSI Driver Version 5.51
  Vendor: FUJITSU   Model: M2513EL           Rev: 0020
  Type:   Direct-Access                      ANSI SCSI revision: 02
st: Version 20050830, fixed bufsize 32768, s/g segs 256
SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
SCSI device sda: drive cache: write back
 sda: sda1
sd 0:0:1:0: Attached scsi disk sda
SCSI device sdb: 8467200 512-byte hdwr sectors (4335 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 8467200 512-byte hdwr sectors (4335 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2
sd 0:0:6:0: Attached scsi disk sdb
sd 1:0:5:0: Attached scsi removable disk sdc
sd 0:0:1:0: Attached scsi generic sg0 type 0
sd 0:0:6:0: Attached scsi generic sg1 type 0
sd 1:0:5:0: Attached scsi generic sg2 type 0
ieee1394: raw1394: /dev/raw1394 device initialized
usbmon: debugfs is not available
USB Universal Host Controller Interface driver v2.3
uhci_hcd 0000:00:04.2: UHCI Host Controller
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:04.2: irq 153, io base 0x0000d400
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usb 1-1: new low speed USB device using uhci_hcd and address 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
input: Wacom Graphire4 4x5 as /class/input/input0
usbcore: registered new driver wacom
drivers/usb/input/wacom.c: v1.44:USB Wacom Graphire and Wacom Intuos
tablet driver
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for
generic
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input1
es1371: version v0.32 time 21:23:33 Jan  6 2006
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x08
es1371: found es1371 rev 8 at io 0xb800 irq 153
input: AT Translated Set 2 keyboard as /class/input/input2
ac97_codec: AC97 Audio codec, id: CRY19 (Cirrus Logic CS4297A rev A)
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07
13:30:21 2005 UTC).
ALSA device list:
  No soundcards found.
oprofile: using NMI interrupt.
NET: Registered protocol family 2
gameport: ESS1371 Gameport is isa0218/gameport0, io 0x218, speed 2057kHz
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 196608 bytes)
TCP bind hash table entries: 16384 (order: 5, 196608 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
ip_conntrack version 2.4 (2047 buckets, 16376 max) - 212 bytes per
conntrack
input: Analog 3-axis 4-button joystick as /class/input/input3
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 260k freed
kjournald starting.  Commit interval 5 seconds
input: ImPS/2 Generic Wheel Mouse as /class/input/input4
Warning: /proc/ide/hd?/settings interface is obsolete, and will be removed
soon!
EXT3 FS on sda1, internal journal
Adding 506008k swap on /dev/sdb1.  Priority:-1 extents:1 across:506008k
EXT3 FS on sda1, internal journal
EXT3-fs warning: maximal mount count reached, running e2fsck is
recommended
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
NFSD: starting 90-second grace period
(scsi0:A:1:0): parity error detected in Data-in phase. SEQADDR(0x55)
SCSIRATE(0x95)
(scsi0:A:1:0): parity error detected in Data-in phase. SEQADDR(0x84)
SCSIRATE(0x95)
(scsi0:A:1:0): parity error detected in Data-in phase. SEQADDR(0x1a8)
SCSIRATE(0x95)
(scsi0:A:1:0): parity error detected in Data-in phase. SEQADDR(0x1a8)
SCSIRATE(0x95)
nvidia: module license 'NVIDIA' taints kernel.
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7676  Fri Jul 29
12:58:54 PDT 2005
agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
NVRM: Xid: 17, Head=0 X=1024 Y=768 Refresh=115

Joysticktest with this kernel:

#jstest /dev/input/js0
Joystick (Analog 3-axis 4-button joystick) has 3 axes and 4 buttons.
Driver version is 2.1.0.
Testing ... (interrupt to exit)

Axes:  0:     0  1:     0  2:     0 Buttons:  0:off  1:off  2:off  3:off 
Axes:  0:     0  1:     0  2:     0 Buttons:  0:off  1:off  2:off  3:off 
Axes:  0:     0  1:     0  2:     0 Buttons:  0:off  1:off  2:off  3:off 
Axes:  0:     0  1:     0  2:     0 Buttons:  0:off  1:off  2:off  3:off 
Axes:  0:     0  1:     0  2:     0 Buttons:  0:off  1:off  2:off  3:off 
Axes:  0:     0  1:     0  2:     0 Buttons:  0:off  1:off  2:off  3:off 
Axes:  0:     0  1:     0  2:     0 Buttons:  0:off  1:off  2:off  3:off 

======================================================================

----------------------------------------------------------------------
 Raymond - 01-24-06 09:05 
----------------------------------------------------------------------
Add joystick_port=0x218 for ens1371 in /etc/modprobes.conf

as the OSS driver use 0x218

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-23-06 10:41 muftialsa      New Issue                                    
01-23-06 10:41 muftialsa      Distribution              => installed knoppix (a
debian variant) with additional packages
01-23-06 10:41 muftialsa      Kernel Version            => Linux v2.6.15   
01-23-06 12:47 Adrian Bunk    Issue Monitored: Adrian Bunk                    
01-24-06 09:05 Raymond        Note Added: 0007771                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
