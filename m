From: "Ivica Bukvic" <ico@fuse.net>
Subject: RE: HDSP CardBus issue - /proc/ioports /proc/iomem
Date: Sat, 25 May 2002 18:38:30 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <001201c2043c$e7e55330$ac1f830a@ico>
References: <20020524140731.RIFY18202.mta02.fuse.net@newmx1.fast.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mta01.fuse.net (mx1.fuse.net [216.68.2.90])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA26755
	for <alsa-devel@alsa-project.org>; Sun, 26 May 2002 00:38:39 +0200
In-Reply-To: <20020524140731.RIFY18202.mta02.fuse.net@newmx1.fast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: 'Paul Davis' <pbd@op.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I changed my lilo.conf accordingly.

The original entry had a nobiospnp option (nobiospnp was there since
initially that prevented me from booting due to fact that long time ago
Mdk froze at boot time when it came to probing pcmcia service, however
I've changed it and it made no difference).

I did /sbin/lilo (which installed the thing) and booted from it. No
significant changes occurred, however. I still get the segfault, as well
as no reports of pcmcia at /proc/interrupts. Here's the pertinent info:

/proc/interrupts remain the same
           CPU0
  0:    1353528          XT-PIC  timer
  1:        824          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  Maestro3
  8:          1          XT-PIC  rtc
 11:     819418          XT-PIC  usb-uhci, i82365, nvidia, eth0
 12:       1878          XT-PIC  PS/2 Mouse
 14:       6816          XT-PIC  ide0
 15:          3          XT-PIC  ide1
NMI:          0
ERR:          0

Here's the /var/log/messages excerpt of the boot process involving
pci=3Dbiosirq

May 26 20:02:26 badass-bukvic kernel: BIOS-provided physical RAM map:
May 26 20:02:26 badass-bukvic kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable)
May 26 20:02:26 badass-bukvic kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved)
May 26 20:02:26 badass-bukvic kernel:  BIOS-e820: 0000000000100000 -
0000000017fea800 (usable)
May 26 20:02:26 badass-bukvic kernel:  BIOS-e820: 0000000017fea800 -
0000000018000000 (reserved)
May 26 20:02:26 badass-bukvic kernel:  BIOS-e820: 00000000feea0000 -
00000000fef00000 (reserved)
May 26 20:02:26 badass-bukvic kernel:  BIOS-e820: 00000000ffb80000 -
0000000100000000 (reserved)
May 26 20:02:26 badass-bukvic kernel: On node 0 totalpages: 98282
May 26 20:02:26 badass-bukvic kernel: zone(0): 4096 pages.
May 26 20:02:26 badass-bukvic kernel: zone(1): 94186 pages.
May 26 20:02:26 badass-bukvic kernel: zone(2): 0 pages.
May 26 20:02:26 badass-bukvic kernel: Kernel command line:
BOOT_IMAGE=3DLinux ro root=3D305 devfs=3Dmount hdb=3Dide-scsi quiet =
hdc=3Dide-scsi
quiet pci=3Dbiosirq PCMCIA
May 26 20:02:26 badass-bukvic kernel: ide_setup: hdb=3Dide-scsi
May 26 20:02:26 badass-bukvic kernel: ide_setup: hdc=3Dide-scsi
May 26 20:02:26 badass-bukvic kernel: Initializing CPU#0
May 26 20:02:26 badass-bukvic kernel: Detected 697.693 MHz processor.
May 26 20:02:26 badass-bukvic kernel: Console: colour dummy device 80x25
May 26 20:02:26 badass-bukvic kernel: Calibrating delay loop... 1392.64
BogoMIPS
May 26 20:02:26 badass-bukvic kernel: Memory: 383664k/393128k available
(1086k kernel code, 9076k reserved, 397k data, 712k init, 0k highmem)
May 26 20:02:26 badass-bukvic kernel: Dentry-cache hash table entries:
65536 (order: 7, 524288 bytes)
May 26 20:02:26 badass-bukvic kernel: Inode-cache hash table entries:
32768 (order: 6, 262144 bytes)
May 26 20:02:26 badass-bukvic kernel: Mount-cache hash table entries:
8192 (order: 4, 65536 bytes)
May 26 20:02:26 badass-bukvic kernel: Buffer-cache hash table entries:
32768 (order: 5, 131072 bytes)
May 26 20:02:26 badass-bukvic kernel: Page-cache hash table entries:
131072 (order: 7, 524288 bytes)
May 26 20:02:26 badass-bukvic kernel: CPU: L1 I cache: 16K, L1 D cache:
16K
May 26 20:02:26 badass-bukvic kernel: CPU: L2 cache: 256K
May 26 20:02:26 badass-bukvic kernel: Intel machine check architecture
supported.
May 26 20:02:26 badass-bukvic kernel: Intel machine check reporting
enabled on CPU#0.
May 26 20:02:26 badass-bukvic kernel: CPU: Intel Pentium III
(Coppermine) stepping 0a
May 26 20:02:26 badass-bukvic kernel: Enabling fast FPU save and
restore... done.
May 26 20:02:26 badass-bukvic kernel: Enabling unmasked SIMD FPU
exception support... done.
May 26 20:02:26 badass-bukvic kernel: Checking 'hlt' instruction... OK.
May 26 20:02:26 badass-bukvic kernel: POSIX conformance testing by
UNIFIX
May 26 20:02:26 badass-bukvic kernel: mtrr: v1.40 (20010327) Richard
Gooch (rgooch@atnf.csiro.au)
May 26 20:02:26 badass-bukvic kernel: mtrr: detected mtrr type: Intel
May 26 20:02:26 badass-bukvic kernel: PCI: PCI BIOS revision 2.10 entry
at 0xfc06e, last bus=3D2
May 26 20:02:26 badass-bukvic kernel: PCI: Using configuration type 1
May 26 20:02:26 badass-bukvic kernel: PCI: Probing PCI hardware
May 26 20:02:26 badass-bukvic kernel: Unknown bridge resource 2:
assuming transparent
May 26 20:02:26 badass-bukvic kernel: PCI: Discovered primary peer bus
08 [IRQ]
May 26 20:02:26 badass-bukvic kernel: PCI: Using IRQ router PIIX
[8086/244c] at 00:1f.0
May 26 20:02:26 badass-bukvic kernel: isapnp: Scanning for PnP cards...
May 26 20:02:26 badass-bukvic kernel: isapnp: No Plug & Play device
found
May 26 20:02:26 badass-bukvic kernel: PnP: PNP BIOS installation
structure at 0xc00fe2d0
May 26 20:02:26 badass-bukvic kernel: PnP: PNP BIOS version 1.0, entry
at f0000:e2f4, dseg at 40
May 26 20:02:26 badass-bukvic kernel: PnPBIOS: PNP0c01: request
0x800-0x880 ok
May 26 20:02:26 badass-bukvic kernel: PnPBIOS: PNP0c01: request
0x860-0x880
May 26 20:02:26 badass-bukvic kernel: PnPBIOS: PNP0c01: request
0x880-0x8c0 ok
May 26 20:02:26 badass-bukvic kernel: PnPBIOS: PNP0c01: request
0x8c0-0x900 ok
May 26 20:02:26 badass-bukvic kernel: PnPBIOS: PNP0c01: request
0x600-0x680 ok
May 26 20:02:26 badass-bukvic kernel: PnPBIOS: PNP0c01: request
0x680-0x700 ok
May 26 20:02:26 badass-bukvic kernel: PnPBIOS: PNP0c01: request
0x3f0-0x3f2 ok
May 26 20:02:26 badass-bukvic kernel: PnPBIOS: PNP0c01: request
0x900-0x910 ok
May 26 20:02:26 badass-bukvic kernel: PnPBIOS: PNP0c01: request
0x910-0x920 ok
May 26 20:02:26 badass-bukvic kernel: PnP: 15 devices detected total
May 26 20:02:26 badass-bukvic kernel: Linux NET4.0 for Linux 2.4
May 26 20:02:26 badass-bukvic kernel: Based upon Swansea University
Computer Society NET3.039
May 26 20:02:26 badass-bukvic kernel: Initializing RT netlink socket
May 26 20:02:26 badass-bukvic kernel: apm: BIOS version 1.2 Flags 0x03
(Driver version 1.14)
May 26 20:02:26 badass-bukvic kernel: Starting kswapd v1.8
May 26 20:02:26 badass-bukvic kernel: VFS: Diskquotas version
dquot_6.5.0 initialized
May 26 20:02:26 badass-bukvic kernel: devfs: v0.115 (20010827) Richard
Gooch (rgooch@atnf.csiro.au)
May 26 20:02:26 badass-bukvic kernel: devfs: boot_options: 0x1
May 26 20:02:26 badass-bukvic kernel: vesafb: framebuffer at 0xe0000000,
mapped to 0xd8800000, size 32768k
May 26 20:02:26 badass-bukvic kernel: vesafb: mode is 1280x1024x16,
linelength=3D2560, pages=3D1
May 26 20:02:26 badass-bukvic kernel: vesafb: protected mode interface
info at c000:bdd5
May 26 20:02:26 badass-bukvic kernel: vesafb: scrolling: redraw
May 26 20:02:26 badass-bukvic kernel: vesafb: directcolor: =
size=3D0:5:6:5,
shift=3D0:11:5:0
May 26 20:02:26 badass-bukvic kernel: Console: switching to colour frame
buffer device 160x64
May 26 20:02:26 badass-bukvic kernel: fb0: VESA VGA frame buffer device
May 26 20:02:26 badass-bukvic kernel: pty: 256 Unix98 ptys configured
May 26 20:02:26 badass-bukvic kernel: Serial driver version 5.05c
(2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP
enabled
May 26 20:02:26 badass-bukvic kernel: ttyS00 at 0x03f8 (irq =3D 4) is a
16550A
May 26 20:02:26 badass-bukvic kernel: ttyS01 at 0x02f8 (irq =3D 3) is a
16550A
May 26 20:02:26 badass-bukvic kernel: block: queued sectors max/low
254394kB/123322kB, 768 slots per queue
May 26 20:02:26 badass-bukvic kernel: RAMDISK driver initialized: 16 RAM
disks of 4096K size 1024 blocksize
May 26 20:02:26 badass-bukvic kernel: Uniform Multi-Platform E-IDE
driver Revision: 6.31
May 26 20:02:26 badass-bukvic kernel: ide: Assuming 33MHz system bus
speed for PIO modes; override with idebus=3Dxx
May 26 20:02:26 badass-bukvic kernel: PIIX4: IDE controller on PCI bus
00 dev f9
May 26 20:02:26 badass-bukvic kernel: PIIX4: chipset revision 2
May 26 20:02:26 badass-bukvic kernel: PIIX4: not 100%% native mode: will
probe irqs later
May 26 20:02:26 badass-bukvic kernel:     ide0: BM-DMA at 0xbfa0-0xbfa7,
BIOS settings: hda:DMA, hdb:DMA
May 26 20:02:26 badass-bukvic kernel:     ide1: BM-DMA at 0xbfa8-0xbfaf,
BIOS settings: hdc:DMA, hdd:pio
May 26 20:02:26 badass-bukvic kernel: hda: IBM-DJSA-232, ATA DISK drive
May 26 20:02:26 badass-bukvic kernel: hdb: SONY CD-RW CRX700E, ATAPI
CD/DVD-ROM drive
May 26 20:02:26 badass-bukvic kernel: hdc: LG DVD-ROM DRN-8080B, ATAPI
CD/DVD-ROM drive
May 26 20:02:26 badass-bukvic kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq
14
May 26 20:02:26 badass-bukvic kernel: ide1 at 0x170-0x177,0x376 on irq
15
May 26 20:02:26 badass-bukvic kernel: hda: 62506080 sectors (32003 MB)
w/1874KiB Cache, CHS=3D3890/255/63, UDMA(66)
May 26 20:02:26 badass-bukvic kernel: ide-floppy driver 0.97
May 26 20:02:26 badass-bukvic kernel: Partition check:
May 26 20:02:26 badass-bukvic kernel:  /dev/ide/host0/bus0/target0/lun0:
p1 p2 < p5 p6 p7 >
May 26 20:02:26 badass-bukvic kernel: Floppy drive(s): fd0 is 1.44M
May 26 20:02:26 badass-bukvic kernel: floppy0: Floppy io-port 0x03f0 in
use
May 26 20:02:26 badass-bukvic kernel: ide-floppy driver 0.97
May 26 20:02:26 badass-bukvic kernel: md: md driver 0.90.0
MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
May 26 20:02:26 badass-bukvic kernel: md: Autodetecting RAID arrays.
May 26 20:02:26 badass-bukvic kernel: md: autorun ...
May 26 20:02:26 badass-bukvic kernel: md: ... autorun DONE.
May 26 20:02:26 badass-bukvic kernel: NET4: Linux TCP/IP 1.0 for NET4.0
May 26 20:02:26 badass-bukvic kernel: IP Protocols: ICMP, UDP, TCP, IGMP
May 26 20:02:26 badass-bukvic kernel: IP: routing cache hash table of
4096 buckets, 32Kbytes
May 26 20:02:26 badass-bukvic kernel: TCP: Hash tables configured
(established 32768 bind 32768)
May 26 20:02:26 badass-bukvic kernel: Linux IP multicast router 0.06
plus PIM-SM
May 26 20:02:26 badass-bukvic kernel: NET4: Unix domain sockets 1.0/SMP
for Linux NET4.0.
May 26 20:02:26 badass-bukvic kernel: RAMDISK: Compressed image found at
block 0
May 26 20:02:26 badass-bukvic kernel: Uncompressing...done.
May 26 20:02:26 badass-bukvic kernel: Freeing initrd memory: 23k freed
May 26 20:02:26 badass-bukvic kernel: EXT2-fs warning: checktime
reached, running e2fsck is recommended
May 26 20:02:26 badass-bukvic kernel: VFS: Mounted root (ext2
filesystem).
May 26 20:02:26 badass-bukvic kernel: Mounted devfs on /dev
May 26 20:02:26 badass-bukvic kernel: Freeing unused kernel memory: 712k
freed
May 26 20:02:26 badass-bukvic kernel: Real Time Clock Driver v1.10d
May 26 20:02:26 badass-bukvic kernel: Adding Swap: 265032k swap-space
(priority -1)
May 26 20:02:26 badass-bukvic kernel: SCSI subsystem driver Revision:
1.00
May 26 20:02:26 badass-bukvic kernel: scsi0 : SCSI host adapter
emulation for IDE ATAPI devices
May 26 20:02:26 badass-bukvic kernel:   Vendor: SONY      Model: CD-RW
CRX700E    Rev: 1.4j
May 26 20:02:26 badass-bukvic kernel:   Type:   CD-ROM
ANSI SCSI revision: 02
May 26 20:02:26 badass-bukvic kernel:   Vendor: LG        Model: DVD-ROM
DRN8080B  Rev: 1.11
May 26 20:02:26 badass-bukvic kernel:   Type:   CD-ROM
ANSI SCSI revision: 02
May 26 20:02:26 badass-bukvic kernel: PCI: Found IRQ 11 for device
02:06.0
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 00:1f.2
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 02:06.1
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 02:0f.0
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 02:0f.1
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 02:0f.2
May 26 20:02:26 badass-bukvic kernel: 3c59x: Donald Becker and others.
www.scyld.com/network/vortex.html
May 26 20:02:26 badass-bukvic kernel: 02:06.0: 3Com PCI 3c556 Laptop
Tornado at 0xe800. Vers LK1.1.16
May 26 20:02:26 badass-bukvic kernel: usb.c: registered new driver
usbdevfs
May 26 20:02:26 badass-bukvic kernel: usb.c: registered new driver hub
May 26 20:02:26 badass-bukvic kernel: usb-uhci.c: $Revision: 1.259 $
time 17:30:17 Sep 23 2001
May 26 20:02:26 badass-bukvic kernel: usb-uhci.c: High bandwidth mode
enabled
May 26 20:02:26 badass-bukvic kernel: PCI: Found IRQ 11 for device
00:1f.2
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 02:06.0
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 02:06.1
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 02:0f.0
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 02:0f.1
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 02:0f.2
May 26 20:02:26 badass-bukvic kernel: PCI: Setting latency timer of
device 00:1f.2 to 64
May 26 20:02:26 badass-bukvic kernel: usb-uhci.c: USB UHCI at I/O
0xdce0, IRQ 11
May 26 20:02:26 badass-bukvic kernel: usb-uhci.c: Detected 2 ports
May 26 20:02:26 badass-bukvic kernel: usb.c: new USB bus registered,
assigned bus number 1
May 26 20:02:26 badass-bukvic kernel: hub.c: USB hub found
May 26 20:02:26 badass-bukvic kernel: hub.c: 2 ports detected
May 26 20:02:26 badass-bukvic kernel: usb-uhci.c: v1.251:USB Universal
Host Controller Interface driver
May 26 20:02:26 badass-bukvic kernel: Linux PCMCIA Card Services 3.1.29
May 26 20:02:26 badass-bukvic kernel:   kernel build: 2.4.8-26mdk #1 Sun
Sep 23 17:06:39 CEST 2001
May 26 20:02:26 badass-bukvic kernel:   options:  [pci] [cardbus] [apm]
May 26 20:02:26 badass-bukvic kernel: Intel ISA/PCI/CardBus PCIC probe:
May 26 20:02:26 badass-bukvic kernel: PCI: Found IRQ 11 for device
02:0f.0
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 00:1f.2
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 02:06.0
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 02:06.1
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 02:0f.1
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 02:0f.2
May 26 20:02:26 badass-bukvic kernel: PCI: Found IRQ 11 for device
02:0f.1
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 00:1f.2
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 02:06.0
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 02:06.1
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 02:0f.0
May 26 20:02:26 badass-bukvic kernel: PCI: Sharing IRQ 11 with 02:0f.2
May 26 20:02:26 badass-bukvic kernel:   TI 4451 rev 00 PCI-to-CardBus at
slot 02:0f, mem 0xf4000000
May 26 20:02:26 badass-bukvic kernel:     host opts [0]: [ring] [pci +
serial irq] [pci irq 11] [lat 32/32] [bus 3/6]
May 26 20:02:26 badass-bukvic kernel:     host opts [1]: [ring] [pci +
serial irq] [pci irq 11] [lat 32/32] [bus 7/10]
May 26 20:02:26 badass-bukvic kernel:     ISA irqs (scanned) =3D
3,4,7,9,10 PCI status changes
May 26 20:02:26 badass-bukvic kernel: cs: cb_alloc(bus 3): vendor
0x10ee, device 0x3fc5
May 26 20:02:27 badass-bukvic netfs: Mounting other filesystems:
succeeded
May 26 20:02:27 badass-bukvic sshd: Starting sshd:
May 26 20:02:27 badass-bukvic sshd: sshd startup succeeded
May 26 20:02:27 badass-bukvic sshd: ^[[60G[  ^[[1;32m
May 26 20:02:27 badass-bukvic sshd[1185]: Server listening on 0.0.0.0
port 22.
May 26 20:02:27 badass-bukvic sshd:
May 26 20:02:27 badass-bukvic rc: =A7hide=A7 =A7hide=A7 Starting sshd:   =
=A7end=A7
Starting sshd:   =A7end=A7 =A7hide=A7 Starting sshd:   =A7end=A7 =
Starting sshd:
succeeded
May 26 16:02:09 badass-bukvic devfsd: Started device management daemon
for /dev
May 26 16:02:10 badass-bukvic rc.sysinit: Running DevFs deamon succeeded
May 26 16:02:10 badass-bukvic devfsd[111]: error calling: "unlink" in
"GLOBAL"
May 26 16:02:11 badass-bukvic rc.sysinit: Booting Aurora... succeeded
May 26 16:02:11 badass-bukvic rc.sysinit: =A7hide=A7
May 26 16:02:12 badass-bukvic rc.sysinit: =A7hide=A7
May 26 20:02:13 badass-bukvic date: Sun May 26 20:02:13 EDT 2002
May 26 20:02:13 badass-bukvic rc.sysinit: =A7hide=A7
May 26 20:02:13 badass-bukvic last message repeated 2 times
May 26 20:02:13 badass-bukvic fsck: /dev/hda5: clean, 221121/948416
files, 1635050/1893654 blocks
May 26 20:02:14 badass-bukvic rc.sysinit: =A7hide=A7
May 26 20:02:16 badass-bukvic rc.sysinit: =A7hide=A7 =A7hide=A7 Finding =
module
dependencies:   =A7end=A7 Finding module dependencies:   =A7end=A7 =
=A7hide=A7
Finding module dependencies:   =A7end=A7 Finding module dependencies:
succeeded
May 26 20:02:16 badass-bukvic : Loading module: scsi_hostadapter
May 26 20:02:17 badass-bukvic fsck: /dev/hda6: clean, 75669/975360
files, 1833058/1947873 blocks
May 26 20:02:17 badass-bukvic rc.sysinit: =A7hide=A7 =A7hide=A7 Mounting =
local
filesystems:   =A7end=A7 Mounting local filesystems:   =A7end=A7 =
=A7hide=A7 Mounting
local filesystems:   =A7end=A7 Mounting local filesystems:  succeeded
May 26 20:02:17 badass-bukvic rc.sysinit: =A7hide=A7 =A7hide=A7 Mounting
loopback filesystems:   =A7end=A7 Mounting loopback filesystems:   =
=A7end=A7
=A7hide=A7 Mounting loopback filesystems:   =A7end=A7 Mounting loopback
filesystems:  succeeded
May 26 20:02:17 badass-bukvic devfsd[111]: Caught SIGHUP  <30>May 26
20:02:17 devfsd[111]: read config file: "/etc/devfsd.conf"
May 26 20:02:18 badass-bukvic rc.sysinit: =A7hide=A7 =A7hide=A7 Running =
devfsd
actions:   =A7end=A7 Running devfsd actions:   =A7end=A7 =A7hide=A7 =
Running devfsd
actions:   =A7end=A7 Running devfsd actions:  succeeded
May 26 20:02:18 badass-bukvic loadkeys: Loading
/usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz
May 26 20:02:18 badass-bukvic keytable: Loading keymap: us succeeded
May 26 20:02:19 badass-bukvic loadkeys: Loading
/usr/lib/kbd/keymaps/include/compose.latin1.inc.gz
May 26 20:02:19 badass-bukvic keytable: Loading compose keys:
compose.latin1.inc succeeded
May 26 20:02:19 badass-bukvic keytable:  succeeded
May 26 20:02:19 badass-bukvic rc.sysinit: =A7hide=A7 =A7hide=A7 Enabling =
local
filesystem quotas:   =A7end=A7 Enabling local filesystem quotas:   =
=A7end=A7
=A7hide=A7 Enabling local filesystem quotas:   =A7end=A7 Enabling local
filesystem quotas:  succeeded
May 26 20:02:20 badass-bukvic rc.sysinit: =A7hide=A7 =A7hide=A7 Turning =
on user
and group quotas for local filesystems:   =A7end=A7 Turning on user and
group quotas for local filesystems:   =A7end=A7 =A7hide=A7 Turning on =
user and
group quotas for local filesystems:   =A7end=A7 Turning on user and =
group
quotas for local filesystems:  succeeded
May 26 20:02:21 badass-bukvic rc.sysinit: =A7hide=A7 =A7hide=A7 Enabling =
swap
space:   =A7end=A7 Enabling swap space:   =A7end=A7 =A7hide=A7 Enabling =
swap space:
=A7end=A7 Enabling swap space:  succeeded
May 26 20:02:23 badass-bukvic mandrake_everytime: Building Window
Manager Sessions succeeded
May 26 20:02:23 badass-bukvic modprobe: modprobe: Can't locate module
eth1
May 26 20:02:23 badass-bukvic modprobe: modprobe: Can't locate module
eth2
May 26 20:02:23 badass-bukvic modprobe: modprobe: Can't locate module
eth3
May 26 20:02:23 badass-bukvic modprobe: modprobe: Can't locate module
eth4
May 26 20:02:23 badass-bukvic modprobe: modprobe: Can't locate module
eth5
May 26 20:02:23 badass-bukvic modprobe: modprobe: Can't locate module
eth6
May 26 20:02:23 badass-bukvic modprobe: modprobe: Can't locate module
eth7
May 26 20:02:23 badass-bukvic modprobe: modprobe: Can't locate module
eth8
May 26 20:02:23 badass-bukvic modprobe: modprobe: Can't locate module
eth9
May 26 20:02:23 badass-bukvic init: Entering runlevel: 5
May 26 20:02:24 badass-bukvic usb: Loading USB interface (usb-uhci)
succeeded
May 26 20:02:24 badass-bukvic usb: Mount USB filesystem succeeded
May 26 20:02:25 badass-bukvic pcmcia: Starting PCMCIA services:
May 26 20:02:25 badass-bukvic pcmcia:  modules
May 26 20:02:25 badass-bukvic pcmcia:  cardmgr.
May 26 20:02:25 badass-bukvic /etc/hotplug/usb.agent: ... no drivers for
USB product 0/0/0
May 26 20:02:25 badass-bukvic cardmgr[1023]: starting, version is 3.1.29
May 26 20:02:25 badass-bukvic rc: =A7hide=A7 =A7hide=A7 Starting pcmcia: =
  =A7end=A7
Starting pcmcia:   =A7end=A7 =A7hide=A7 Starting pcmcia:   =A7end=A7 =
Starting
pcmcia:  succeeded
May 26 20:02:25 badass-bukvic portmap: portmap startup succeeded
May 26 20:02:25 badass-bukvic cardmgr[1023]: unsupported card in socket
0
May 26 20:02:26 badass-bukvic cardmgr[1023]:   PCI id: 0x10ee, 0x3fc5
May 26 20:02:28 badass-bukvic xinetd[1235]: Service ftp: attribute
already set: disable [line=3D16]
May 26 20:02:28 badass-bukvic xinetd[1235]: chargen disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: chargen-udp disabled,
removing
May 26 20:02:28 badass-bukvic xinetd[1235]: comsat disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: printer disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: cvspserver disabled,
removing
May 26 20:02:28 badass-bukvic xinetd[1235]: daytime disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: daytime-udp disabled,
removing
May 26 20:02:28 badass-bukvic xinetd[1235]: echo disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: echo-udp disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: imap disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: imaps disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: pop2 disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: linuxconf disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: pop3s disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: ftp disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: exec disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: login disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: shell disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: rsync disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: swat disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: time disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: time disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: ftp disabled, removing
May 26 20:02:28 badass-bukvic xinetd[1235]: bind failed (Cannot assign
requested address (errno =3D 99)). service =3D sgi_fam
May 26 20:02:28 badass-bukvic xinetd[1235]: xinetd Version 2.3.3 started
with libwrap options compiled in.
May 26 20:02:28 badass-bukvic xinetd[1235]: Started working: 2 available
services
May 26 20:02:31 badass-bukvic xinetd: xinetd startup succeeded
May 26 20:02:32 badass-bukvic kernel: PCI: Found IRQ 5 for device
02:03.0
May 26 20:02:32 badass-bukvic kernel: Hammerfall memory allocator:
buffers allocated for 1 cards
May 26 20:02:33 badass-bukvic kernel: PCI: No IRQ known for interrupt
pin A of device .
May 26 20:02:33 badass-bukvic kernel: PCI: Setting latency timer of
device  to 64
May 26 20:02:33 badass-bukvic kernel: ALSA
../../alsa-kernel/pci/rme9652/hdsp.c:2984: unable to grab memory region
0x0-0x1447
May 26 20:02:33 badass-bukvic kernel: Unable to handle kernel NULL
pointer dereference at virtual address 00000040
May 26 20:02:33 badass-bukvic kernel:  printing eip:
May 26 20:02:33 badass-bukvic kernel: da8be827
May 26 20:02:33 badass-bukvic kernel: *pde =3D 00000000
May 26 20:02:33 badass-bukvic kernel: Oops: 0002
May 26 20:02:33 badass-bukvic kernel: CPU:    0
May 26 20:02:33 badass-bukvic kernel: EIP:
0010:[usbcore:__insmod_usbcore_S.bss_L96+414279/207484713]
May 26 20:02:33 badass-bukvic kernel: EIP:    0010:[<da8be827>]
May 26 20:02:33 badass-bukvic kernel: EFLAGS: 00010246
May 26 20:02:33 badass-bukvic kernel: eax: 00000000   ebx: d7e001bc
ecx: 00000002   edx: 00000000
May 26 20:02:33 badass-bukvic kernel: esi: fffffff0   edi: 00000001
ebp: d7e001bc   esp: d7577eb4
May 26 20:02:33 badass-bukvic kernel: ds: 0018   es: 0018   ss: 0018
May 26 20:02:33 badass-bukvic kernel: Process modprobe (pid: 1300,
stackpage=3Dd7577000)
May 26 20:02:33 badass-bukvic kernel: Stack: d7e00014 da87fb4a d7e001bc
d7e00014 da8be962 d7e00014 da8ef370 da8ef840
May 26 20:02:33 badass-bukvic kernel:        d7a1201c 00000000 c01aacfc
d7a1201c da8ef370 d7a1201c da8ef840 00000000
May 26 20:02:33 badass-bukvic kernel:        00000004 c01aad62 da8ef840
d7a1201c da8bb000 00000004 00000011 da8be9fe
May 26 20:02:33 badass-bukvic kernel: Call Trace:
[usbcore:__insmod_usbcore_S.bss_L96+157034/207741958]
[usbcore:__insmod_usbcore_S.bss_L96+414594/207484398]
[usbcore:__insmod_usbcore_S.bss_L96+613776/207285216]
[usbcore:__insmod_usbcore_S.bss_L96+615008/207283984]
[pci_announce_device+60/96]
May 26 20:02:33 badass-bukvic kernel: Call Trace: [<da87fb4a>]
[<da8be962>] [<da8ef370>] [<da8ef840>] [<c01aacfc>]
May 26 20:02:33 badass-bukvic kernel:
[usbcore:__insmod_usbcore_S.bss_L96+613776/207285216]
[usbcore:__insmod_usbcore_S.bss_L96+615008/207283984]
[pci_register_driver+66/96]
[usbcore:__insmod_usbcore_S.bss_L96+615008/207283984]
[usbcore:__insmod_usbcore_S.bss_L96+414750/207484242]
[usbcore:__insmod_usbcore_S.bss_L96+615008/207283984]
May 26 20:02:33 badass-bukvic kernel:    [<da8ef370>] [<da8ef840>]
[<c01aad62>] [<da8ef840>] [<da8be9fe>] [<da8ef840>]
May 26 20:02:33 badass-bukvic kernel:    [sys_init_module+1335/1520]
[usbcore:__insmod_usbcore_S.bss_L96+615348/207283644]
[usbcore:__insmod_usbcore_S.bss_L96+400000/207498992]
[system_call+51/64]
May 26 20:02:33 badass-bukvic kernel:    [<c0115c47>] [<da8ef994>]
[<da8bb060>] [<c0106ec3>]
May 26 20:02:33 badass-bukvic kernel:
May 26 20:02:33 badass-bukvic kernel: Code: 89 50 40 8b 83 c4 00 00 00
85 c0 78 0f 53 8b 8b c4 00 00 00
May 26 20:02:33 badass-bukvic alsa:  succeeded
May 26 20:02:33 badass-bukvic loadkeys: Loading
/usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz
May 26 20:02:33 badass-bukvic keytable: Loading keymap: us succeeded
May 26 20:02:33 badass-bukvic loadkeys: Loading
/usr/lib/kbd/keymaps/include/compose.latin1.inc.gz
May 26 20:02:33 badass-bukvic keytable: Loading compose keys:
compose.latin1.inc succeeded
May 26 20:02:33 badass-bukvic keytable:  succeeded
May 26 20:02:33 badass-bukvic postfix: Starting postfix:
May 26 20:02:34 badass-bukvic postfix: newaliases: fatal: could not find
any active network interfaces
May 26 20:02:35 badass-bukvic postfix: postmap: fatal: could not find
any active network interfaces
May 26 20:02:39 badass-bukvic last message repeated 4 times
May 26 20:02:41 badass-bukvic postfix: postfix
May 26 20:02:41 badass-bukvic rc: =A7hide=A7 =A7hide=A7 Starting =
postfix:
=A7end=A7 Starting postfix:   =A7end=A7 =A7hide=A7 Starting postfix:   =
=A7end=A7
Starting postfix:  succeeded
May 26 20:02:41 badass-bukvic gpm: gpm startup succeeded
May 26 20:02:43 badass-bukvic httpd: httpd-perl startup succeeded
May 26 20:02:46 badass-bukvic httpd: httpd startup succeeded
May 26 20:02:47 badass-bukvic alsasound: ALSA driver is already running.
May 26 20:02:47 badass-bukvic rc: =A7hide=A7 =A7hide=A7 Starting =
alsasound:
=A7end=A7 Starting alsasound:   =A7end=A7 =A7hide=A7 Starting alsasound: =
  =A7end=A7
Starting alsasound:  succeeded
May 26 20:02:47 badass-bukvic crond[1647]: (CRON) STARTUP (fork ok)
May 26 20:02:48 badass-bukvic crond: crond startup succeeded
May 26 20:02:48 badass-bukvic xfs: xfs startup succeeded
May 26 20:02:48 badass-bukvic xfs: listening on port -1
May 26 20:02:49 badass-bukvic rc: =A7hide=A7 =A7hide=A7 Starting =
kheader:
=A7end=A7 Starting kheader:   =A7end=A7 =A7hide=A7 Starting kheader:   =
=A7end=A7
Starting kheader:  succeeded
May 26 20:02:51 badass-bukvic netconf:   Checking kernel configuration
May 26 20:02:52 badass-bukvic linuxconf: Running Linuxconf hooks:
succeeded
May 26 20:02:55 badass-bukvic kernel:  nvidia: loading NVIDIA NVdriver
Kernel Module  1.0-2802  Tue Mar  5 06:26:45 PST 2002
May 26 20:02:55 badass-bukvic kernel: devfs: devfs_register(): device
already registered: "nvidiactl"
May 26 20:02:55 badass-bukvic kernel: devfs: devfs_register(): device
already registered: "nvidia0"
May 26 20:02:56 badass-bukvic kernel: Linux agpgart interface v0.99 (c)
Jeff Hartmann
May 26 20:02:56 badass-bukvic kernel: agpgart: Maximum main memory to
use for agp memory: 321M
May 26 20:02:56 badass-bukvic kernel: agpgart: agpgart: Detected an
Intel i815, but could not find the secondary device. Assuming a
non-integrated video card.
May 26 20:02:56 badass-bukvic kernel: agpgart: Detected Intel i815
chipset
May 26 20:02:56 badass-bukvic kernel: agpgart: AGP aperture is 64M @
0xe8000000
May 26 20:02:56 badass-bukvic kernel: NVRM: AGPGART: Intel i815 chipset
May 26 20:02:56 badass-bukvic kernel: NVRM: AGPGART: aperture: 64M @
0xe8000000
May 26 20:02:56 badass-bukvic kernel: NVRM: AGPGART: aperture mapped
from 0xe8000000 to 0xdba4a000
May 26 20:02:56 badass-bukvic kernel: NVRM: AGPGART: mode 4x
May 26 20:02:56 badass-bukvic kernel: NVRM: AGPGART: allocated 16 pages
May 26 20:03:07 badass-bukvic login(pam_unix)[1759]: session opened for
user root by (uid=3D0)
May 26 20:03:07 badass-bukvic  -- root[1759]: ROOT LOGIN ON vc/1



I still cannot initialize lo and eth0 devices for network when the
segfault occurs at the boot time (which does allow me to boot into
system, just doesn't let me get on the net for some reason).

Hope this helps a bit. Also, I have a desktop cpu which has one of the
PCI to PCMCIA (Cardbus) cards, so if you want, I can try to mess with
that one as well and see what I come up with. Finally, I will have an
opportunity on Monday to try out the same thing on a Suse laptop (also
Dell's), so I will let you know how that one goes.

Finally, if I do insert the card, I get the same notice as Thomas about
the insterted pcmcia card.

Ico


> -----Original Message-----
> From: Paul Davis [mailto:pbd@op.net]
> Sent: Friday, May 24, 2002 10:10 AM
> To: thomas@undata.org; Ivica Bukvic
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [Alsa-devel] HDSP CardBus issue - /proc/ioports
/proc/iomem
>=20
> Thomas and Ico:
>=20
> can you please try to boot your systems with the "pci=3Dbiosirq" =
command
> line flag?
>=20
> from my discussions with alan cox on the linux kernel mailing list, it
> appears that the PCI configuration information for the card isn't
> complete, and only the BIOS knows how to figure out the interrupt
> number. You both had different issues - one of you had a problem with
> IO memory, the other with interrupts - but I'd like to see what
> difference this makes.
>=20
> as i understand it, it tells the PCI code in the kernel to use the IRQ
> allocation decisions made by the BIOS (linux usually throws them away
> and does its own thing; windows uses the BIOS values).
>=20
> thanks.
>=20
> --p



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
