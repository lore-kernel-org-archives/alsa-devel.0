From: Jaakko =?iso-8859-15?q?Pr=E4tt=E4l=E4?=
	<Jaakko.Prattala@Helsinki.FI>
Subject: rev 10 fw, hdsp I/O-error
Date: Thu, 17 Apr 2003 10:51:45 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304171051.45549.Jaakko.Prattala@Helsinki.FI>
References: <1050314137.1382.23.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_9U9HKPLAR05GW7IQBR9B"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1050314137.1382.23.camel@satellite.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--------------Boundary-00=_9U9HKPLAR05GW7IQBR9B
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hello again. I downgraded the firmware to rev 10 and hdsploader loaded=20
something up. At least the red led doesn't shine anymore. The hwdep ioctl
error still hasn't gone away. After loading snd-hdsp and hdsploading,
all alsa modules are reported as busy and cannot be removed.
Also in /dev/snd there are only these entries:
controlC0  hwC0D0     timer
I'm attaching dmesg output (this time with the card loading session too :=
)
and two straces of hdsploader. The second one is what happens when
hdsploader is run a second time right after the first.

--=20
Jaakko Pr=E4tt=E4l=E4
Jaakko.Prattala@Helsinki.FI

--------------Boundary-00=_9U9HKPLAR05GW7IQBR9B
Content-Type: text/plain;
  charset="iso-8859-15";
  name="rev10.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="rev10.dmesg"

Linux version 2.4.20ACPIp_wCS (root@kiertotahti) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #2 Wed Apr 16 01:26:03 EEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eef0000 (usable)
 BIOS-e820: 000000000eef0000 - 000000000eefc000 (ACPI data)
 BIOS-e820: 000000000eefc000 - 000000000ef00000 (ACPI NVS)
 BIOS-e820: 000000000ef00000 - 000000000f000000 (usable)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
240MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 61440
zone(0): 4096 pages.
zone(1): 57344 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6ca0
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x0eef6660
ACPI: FADT (v001 QUANTA TwisterT 01540.00000) @ 0x0eefbf8c
ACPI: DSDT (v001  VIA   PTL_ACPI 01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Kernel command line: ro root=LABEL=/ hdc=ide-scsi
ide_setup: hdc=ide-scsi
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
Detected 1202.787 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2398.61 BogoMIPS
Memory: 240244k/245760k available (1389k kernel code, 5064k reserved, 502k data, 120k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Mobile Intel(R) Celeron(TM) CPU         1200MHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20021212
PCI: PCI BIOS revision 2.10 entry at 0xfd821, last bus=2
PCI: Using configuration type 1
    ACPI-0263: *** Info: GPE Block0 defined as GPE0 to GPE15
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 7 9 10 12, enabled at IRQ 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7 9 10 12, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7 9 *10 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 11, enabled at IRQ 9)
ACPI: Embedded Controller [EC0] (gpe 1)
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
PCI: Via IRQ fixup for 00:11.6, from 255 to 10
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 89
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8231 (rev 10) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N030ATCS04-0, ATA DISK drive
hdc: QSI CD-RW/DVD-ROM SBW-161, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c03249e4, I/O limit 4095Mb (mask 0xffffffff)
hda: 58605120 sectors (30006 MB) w/1768KiB Cache, CHS=3648/255/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 132k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 120k freed
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
Adding Swap: 489940k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: QSI       Model: DVD/CDRW SBW-161  Rev: SX09
  Type:   CD-ROM                             ANSI SCSI revision: 02
usb-uhci.c: $Revision: 1.275 $ time 01:24:09 Apr 16 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0x1020, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: USB disconnect on device 00:11.2-0 address 1
usb.c: USB bus 1 deregistered
parport0: PC-style at 0x378 [PCSPP(,...)]
ip_tables: (C) 2000-2002 Netfilter core team
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Yenta IRQ list 0008, PCI irq11
Socket status: 30000007
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0230-0x04ff: excluding 0x378-0x37f 0x4d0-0x4d7
cs: IO port probe 0x0100-0x021f: clean.
cs: IO port probe 0x1000-0x17ff: clean.
cs: cb_alloc(bus 2): vendor 0x10ee, device 0x3fc5
PCI: Enabling device 02:00.0 (0080 -> 0082)
Hammerfall memory allocator: buffers allocated for 1 cards
PCI: Setting latency timer of device 02:00.0 to 64
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:4104: card initialization pending : waiting for firmware
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:644: wait for FIFO status <= 0 failed after 30 iterations
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:3800: initializing firmware upload
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:522: loading firmware
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:644: wait for FIFO status <= 0 failed after 5000 iterations
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:543: timeout at end of firmware loading

--------------Boundary-00=_9U9HKPLAR05GW7IQBR9B
Content-Type: text/plain;
  charset="iso-8859-15";
  name="rev10.hdsploader.1.strace"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="rev10.hdsploader.1.strace"

execve("/usr/local/bin/hdsploader", ["hdsploader"], [/* 34 vars */]) = 0
uname({sys="Linux", node="kiertotahti", ...}) = 0
brk(0)                                  = 0x80a876c
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=81506, ...}) = 0
old_mmap(NULL, 81506, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40013000
close(3)                                = 0
open("/usr/lib/libasound.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\263"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=3097033, ...}) = 0
old_mmap(NULL, 548564, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40027000
mprotect(0x400a9000, 16084, PROT_NONE)  = 0
old_mmap(0x400a9000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x81000) = 0x400a9000
close(3)                                = 0
open("/lib/i686/libm.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0007\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=170910, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x400ad000
old_mmap(NULL, 135680, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x400ae000
mprotect(0x400cf000, 512, PROT_NONE)    = 0
old_mmap(0x400cf000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x21000) = 0x400cf000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\30"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=11314, ...}) = 0
old_mmap(NULL, 11304, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x400d0000
mprotect(0x400d2000, 3112, PROT_NONE)   = 0
old_mmap(0x400d2000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x1000) = 0x400d2000
close(3)                                = 0
open("/lib/i686/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240E\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=85498, ...}) = 0
old_mmap(NULL, 196128, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x400d3000
mprotect(0x400e0000, 142880, PROT_NONE) = 0
old_mmap(0x400e0000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xd000) = 0x400e0000
old_mmap(0x400e3000, 130592, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x400e3000
close(3)                                = 0
open("/lib/i686/libc.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220Y\1"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1395734, ...}) = 0
old_mmap(0x42000000, 1239844, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x42000000
mprotect(0x42126000, 35620, PROT_NONE)  = 0
old_mmap(0x42126000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x126000) = 0x42126000
old_mmap(0x4212b000, 15140, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4212b000
close(3)                                = 0
mprotect(0x40027000, 532480, PROT_READ|PROT_WRITE) = 0
mprotect(0x40027000, 532480, PROT_READ|PROT_EXEC) = 0
munmap(0x40013000, 81506)               = 0
modify_ldt(1, {entry_number:0, base_addr:0x400e0080, limit:1056, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:0, seg_not_present:0, useable:1}, 16) = 0
getpid()                                = 780
rt_sigaction(SIGRTMIN, {0x400dad90, [], SA_RESTORER, 0x42028c48}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x400dade0, [], SA_RESTORER, 0x42028c48}, NULL, 8) = 0
rt_sigaction(SIGRT_2, {0x400db930, [], SA_RESTORER, 0x42028c48}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbffff5dc, 32, (nil), 0}) = 0
fstat64(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 1), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40013000
write(1, "hdsploader - firmware loader for"..., 58) = 58
write(1, "Looking for HDSP + Multiface or "..., 49) = 49
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbffff46c)  = 0
brk(0)                                  = 0x80a876c
brk(0x80a976c)                          = 0x80a976c
brk(0x80aa000)                          = 0x80aa000
ioctl(3, 0x81785501, 0xbffff4d0)        = 0
close(3)                                = 0
write(1, "Card 0 : RME Hammerfall DSP at 0"..., 50) = 50
write(1, "Upload firmware for card hw:0\n", 30) = 30
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7629, ...}) = 0
open("/usr/share/alsa/alsa.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7629, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
read(3, "#\n#  ALSA library configuration "..., 4096) = 4096
brk(0x80ab000)                          = 0x80ab000
brk(0x80ac000)                          = 0x80ac000
brk(0x80ad000)                          = 0x80ad000
read(3, "m.device\n\t\t\t}\n\t\t}\n\t\tsubdevice {\n"..., 4096) = 3533
brk(0x80ae000)                          = 0x80ae000
brk(0x80af000)                          = 0x80af000
brk(0x80b0000)                          = 0x80b0000
brk(0x80b1000)                          = 0x80b1000
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40014000, 4096)                = 0
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or directory)
access("/root/.asoundrc", R_OK)         = 0
open("/root/.asoundrc", O_RDONLY)       = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=65, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
read(3, "pcm.hdsp{\n  type hw\n  card 0\n}\n\n"..., 4096) = 65
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40014000, 4096)                = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/hwC0D0", O_RDWR)         = 3
ioctl(3, 0x80044800, 0xbffe752c)        = 0
ioctl(3, 0x80084843, 0xbffe78a0)        = 0
ioctl(3, 0x7d744842, 0xbffe78d0)        = -1 EIO (Input/output error)
write(2, "Hwdep ioctl error on card hw:0 :"..., 53Hwdep ioctl error on card hw:0 : Input/output error.
) = 53
close(3)                                = 0
open("/dev/snd/controlC1", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC1", O_RDONLY)          = -1 ENOSYS (Function not implemented)
open("/dev/aloadC1", O_RDONLY)          = -1 ENOSYS (Function not implemented)
open("/dev/aloadC1", O_RDONLY)          = -1 ENODEV (No such device)
open("/dev/snd/controlC2", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC2", O_RDONLY)          = -1 ENOSYS (Function not implemented)
open("/dev/aloadC2", O_RDONLY)          = -1 ENOSYS (Function not implemented)
open("/dev/aloadC2", O_RDONLY)          = -1 ENODEV (No such device)
open("/dev/snd/controlC3", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC3", O_RDONLY)          = -1 ENOSYS (Function not implemented)
open("/dev/aloadC3", O_RDONLY)          = -1 ENOSYS (Function not implemented)
open("/dev/aloadC3", O_RDONLY)          = -1 ENODEV (No such device)
open("/dev/snd/controlC4", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC4", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC5", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC5", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC6", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC6", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC7", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC7", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC8", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC8", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC9", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC9", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC10", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC10", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC11", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC11", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC12", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC12", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC13", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC13", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC14", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC14", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC15", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC15", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC16", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC16", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC17", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC17", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC18", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC18", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC19", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC19", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC20", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC20", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC21", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC21", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC22", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC22", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC23", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC23", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC24", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC24", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC25", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC25", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC26", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC26", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC27", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC27", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC28", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC28", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC29", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC29", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC30", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC30", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC31", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC31", O_RDONLY)         = -1 ENOENT (No such file or directory)
munmap(0x40013000, 4096)                = 0
_exit(0)                                = ?

--------------Boundary-00=_9U9HKPLAR05GW7IQBR9B
Content-Type: text/plain;
  charset="iso-8859-15";
  name="rev10.hdsploader.2.strace"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="rev10.hdsploader.2.strace"

execve("/usr/local/bin/hdsploader", ["hdsploader"], [/* 34 vars */]) = 0
uname({sys="Linux", node="kiertotahti", ...}) = 0
brk(0)                                  = 0x80a876c
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=81506, ...}) = 0
old_mmap(NULL, 81506, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40013000
close(3)                                = 0
open("/usr/lib/libasound.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\263"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=3097033, ...}) = 0
old_mmap(NULL, 548564, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40027000
mprotect(0x400a9000, 16084, PROT_NONE)  = 0
old_mmap(0x400a9000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x81000) = 0x400a9000
close(3)                                = 0
open("/lib/i686/libm.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0007\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=170910, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x400ad000
old_mmap(NULL, 135680, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x400ae000
mprotect(0x400cf000, 512, PROT_NONE)    = 0
old_mmap(0x400cf000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x21000) = 0x400cf000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\30"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=11314, ...}) = 0
old_mmap(NULL, 11304, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x400d0000
mprotect(0x400d2000, 3112, PROT_NONE)   = 0
old_mmap(0x400d2000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x1000) = 0x400d2000
close(3)                                = 0
open("/lib/i686/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240E\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=85498, ...}) = 0
old_mmap(NULL, 196128, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x400d3000
mprotect(0x400e0000, 142880, PROT_NONE) = 0
old_mmap(0x400e0000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xd000) = 0x400e0000
old_mmap(0x400e3000, 130592, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x400e3000
close(3)                                = 0
open("/lib/i686/libc.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220Y\1"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1395734, ...}) = 0
old_mmap(0x42000000, 1239844, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x42000000
mprotect(0x42126000, 35620, PROT_NONE)  = 0
old_mmap(0x42126000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x126000) = 0x42126000
old_mmap(0x4212b000, 15140, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4212b000
close(3)                                = 0
mprotect(0x40027000, 532480, PROT_READ|PROT_WRITE) = 0
mprotect(0x40027000, 532480, PROT_READ|PROT_EXEC) = 0
munmap(0x40013000, 81506)               = 0
modify_ldt(1, {entry_number:0, base_addr:0x400e0080, limit:1056, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:0, seg_not_present:0, useable:1}, 16) = 0
getpid()                                = 789
rt_sigaction(SIGRTMIN, {0x400dad90, [], SA_RESTORER, 0x42028c48}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x400dade0, [], SA_RESTORER, 0x42028c48}, NULL, 8) = 0
rt_sigaction(SIGRT_2, {0x400db930, [], SA_RESTORER, 0x42028c48}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbffff5dc, 32, (nil), 0}) = 0
fstat64(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 1), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40013000
write(1, "hdsploader - firmware loader for"..., 58) = 58
write(1, "Looking for HDSP + Multiface or "..., 49) = 49
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbffff46c)  = 0
brk(0)                                  = 0x80a876c
brk(0x80a976c)                          = 0x80a976c
brk(0x80aa000)                          = 0x80aa000
ioctl(3, 0x81785501, 0xbffff4d0)        = 0
close(3)                                = 0
write(1, "Card 0 : RME Hammerfall DSP at 0"..., 50) = 50
write(1, "Upload firmware for card hw:0\n", 30) = 30
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7629, ...}) = 0
open("/usr/share/alsa/alsa.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=7629, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
read(3, "#\n#  ALSA library configuration "..., 4096) = 4096
brk(0x80ab000)                          = 0x80ab000
brk(0x80ac000)                          = 0x80ac000
brk(0x80ad000)                          = 0x80ad000
read(3, "m.device\n\t\t\t}\n\t\t}\n\t\tsubdevice {\n"..., 4096) = 3533
brk(0x80ae000)                          = 0x80ae000
brk(0x80af000)                          = 0x80af000
brk(0x80b0000)                          = 0x80b0000
brk(0x80b1000)                          = 0x80b1000
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40014000, 4096)                = 0
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or directory)
access("/root/.asoundrc", R_OK)         = 0
open("/root/.asoundrc", O_RDONLY)       = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=65, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
read(3, "pcm.hdsp{\n  type hw\n  card 0\n}\n\n"..., 4096) = 65
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40014000, 4096)                = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/hwC0D0", O_RDWR)         = 3
ioctl(3, 0x80044800, 0xbffe752c)        = 0
ioctl(3, 0x80084843, 0xbffe78a0)        = 0
ioctl(3, 0x7d744842, 0xbffe78d0)        = 0
write(1, "Firmware uploaded for card hw:0\n", 32) = 32
close(3)                                = 0
open("/dev/snd/controlC1", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC1", O_RDONLY)          = -1 ENOSYS (Function not implemented)
open("/dev/aloadC1", O_RDONLY)          = -1 ENOSYS (Function not implemented)
open("/dev/aloadC1", O_RDONLY)          = -1 ENODEV (No such device)
open("/dev/snd/controlC2", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC2", O_RDONLY)          = -1 ENOSYS (Function not implemented)
open("/dev/aloadC2", O_RDONLY)          = -1 ENOSYS (Function not implemented)
open("/dev/aloadC2", O_RDONLY)          = -1 ENODEV (No such device)
open("/dev/snd/controlC3", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC3", O_RDONLY)          = -1 ENOSYS (Function not implemented)
open("/dev/aloadC3", O_RDONLY)          = -1 ENOSYS (Function not implemented)
open("/dev/aloadC3", O_RDONLY)          = -1 ENODEV (No such device)
open("/dev/snd/controlC4", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC4", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC5", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC5", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC6", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC6", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC7", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC7", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC8", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC8", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC9", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/dev/aloadC9", O_RDONLY)          = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC10", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC10", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC11", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC11", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC12", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC12", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC13", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC13", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC14", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC14", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC15", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC15", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC16", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC16", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC17", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC17", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC18", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC18", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC19", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC19", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC20", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC20", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC21", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC21", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC22", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC22", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC23", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC23", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC24", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC24", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC25", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC25", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC26", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC26", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC27", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC27", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC28", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC28", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC29", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC29", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC30", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC30", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/dev/snd/controlC31", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/dev/aloadC31", O_RDONLY)         = -1 ENOENT (No such file or directory)
munmap(0x40013000, 4096)                = 0
_exit(0)                                = ?

--------------Boundary-00=_9U9HKPLAR05GW7IQBR9B--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
