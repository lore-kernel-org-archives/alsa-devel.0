From: Christian Guggenberger <Christian.Guggenberger@physik.uni-regensburg.de>
Subject: oops while unloading snd-intel8x0
Date: Tue, 10 Dec 2002 13:50:31 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021210135031.G31605@pc9391.uni-regensburg.de>
References: <20021204153112.C998@pc9391.uni-regensburg.de> <20021209202452.G6137@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021209202452.G6137@pc9391.uni-regensburg.de>; from Christian.Guggenberger@physik.uni-regensburg.de on Mon, Dec 09, 2002 at 20:24:52 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I get following oops while unloading snd-intel8x0 on a Dell Optiplex 260
Kernel is 2.4.20aa1 (happens again with plain 2.4.20)
Alsa is 0.9.0rc6 (and CVS 20021204)
Debian/woody.

Christian

Here's /proc/pci

PCI devices found:
   Bus  0, device   0, function  0:
     Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge (rev
1).
       Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
   Bus  0, device   2, function  0:
     VGA compatible controller: Intel Corp. 82845G/GL [Brookdale-G] Chipset
Integrated Graphics Device (rev 1).
       IRQ 16.
       Prefetchable 32 bit memory at 0xe8000000 [0xefffffff].
       Non-prefetchable 32 bit memory at 0xff680000 [0xff6fffff].
   Bus  0, device  29, function  0:
     USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 1).
       IRQ 16.
       I/O at 0xff80 [0xff9f].
   Bus  0, device  29, function  1:
     USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 1).
       IRQ 19.
       I/O at 0xff60 [0xff7f].
   Bus  0, device  29, function  2:
     USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 1).
       IRQ 18.
       I/O at 0xff40 [0xff5f].
   Bus  0, device  29, function  7:
     USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 1).
       IRQ 23.
       Non-prefetchable 32 bit memory at 0xffa00800 [0xffa00bff].
   Bus  0, device  30, function  0:
     PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 129).
       Master Capable.  No bursts.  Min Gnt=6.
   Bus  0, device  31, function  0:
     ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 1).
   Bus  0, device  31, function  1:
     IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 1).
       IRQ 18.
       I/O at 0x0 [0x7].
       I/O at 0x0 [0x3].
       I/O at 0x0 [0x7].
       I/O at 0x0 [0x3].
       I/O at 0xffa0 [0xffaf].
       Non-prefetchable 32 bit memory at 0x1f800000 [0x1f8003ff].
   Bus  0, device  31, function  3:
     SMBus: Intel Corp. 82801DB SMBus (rev 1).
       IRQ 17.
       I/O at 0xdc80 [0xdc9f].
   Bus  0, device  31, function  5:
     Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 1).
       IRQ 17.
       I/O at 0xd800 [0xd8ff].
       I/O at 0xdc40 [0xdc7f].
       Non-prefetchable 32 bit memory at 0xffa00400 [0xffa005ff].
       Non-prefetchable 32 bit memory at 0xffa00000 [0xffa000ff].
   Bus  1, device  12, function  0:
     Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev
2).
       IRQ 18.
       Master Capable.  Latency=64.  Min Gnt=255.
       Non-prefetchable 32 bit memory at 0xff8e0000 [0xff8fffff].
       I/O at 0xecc0 [0xecff].

-----------------------------------------------------------------------------

ksymoops 2.4.5 on i686 2.4.20aa1.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.20aa1/ (default)
      -m /boot/System.map-2.4.20aa1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_ksyms_lsmod): module snd-intel8x0 is in lsmod but not in
ksyms, probably no symbols exported

Dec  4 15:23:46 pc51167 kernel: CPU 0 (0x0000) enabledProcessor #0 Pentium
4(tm) XEON(tm) APIC version 16
Dec  4 15:23:46 pc51167 kernel: CPU 1 (0x0100) disabled
Dec  4 15:23:46 pc51167 kernel: CPU 2 (0x0100) disabled
Dec  4 15:23:46 pc51167 kernel: CPU 3 (0x0300) disabled
Dec  4 15:23:46 pc51167 kernel: cpu: 0, clocks: 996318, slice: 498159
Dec  4 15:23:46 pc51167 kernel: SGI XFS CVS with ACLs, quota, no debug enabled
Dec  4 15:23:46 pc51167 kernel: e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
Dec  4 15:23:48 pc51167 kernel: ds: no socket drivers loaded!
Dec  4 15:24:42 pc51167 kernel: c01cfe37
Dec  4 15:24:42 pc51167 kernel: Oops: 0002 2.4.20aa1 #1 SMP Wed Dec 4 12:12:13
CET 2002
Dec  4 15:24:42 pc51167 kernel: CPU:    0
Dec  4 15:24:42 pc51167 kernel: EIP:    0010:[pci_unregister_driver+11/84]
Not tainted
Dec  4 15:24:42 pc51167 kernel: EFLAGS: 00010246
Dec  4 15:24:42 pc51167 kernel: eax: 00000000   ebx: c2c40000   ecx: c2ab4000
edx: 00000000
Dec  4 15:24:42 pc51167 kernel: esi: c2c445a0   edi: c41b0000   ebp: c027a074
esp: c44a1f7c
Dec  4 15:24:42 pc51167 kernel: ds: 0018   es: 0018   ss: 0018
Dec  4 15:24:42 pc51167 kernel: Process modprobe (pid: 871, stackpage=c44a1000)
Dec  4 15:24:42 pc51167 kernel: Stack: c2c40000 c027a074 c2c43320 c2c445a0
c2c444a0 c011b029 c2c40000 fffffff0
Dec  4 15:24:42 pc51167 kernel:        c41b0000 c027a074 c011a34f c2c40000
00000000 c44a0000 00000000 bffffe50
Dec  4 15:24:42 pc51167 kernel:        bfffeafc c01070f3 bffffe50 bffffe50
00000000 00000000 bffffe50 bfffeafc
Dec  4 15:24:42 pc51167 kernel: Call Trace:
[ehci-hcd:__insmod_ehci-hcd_S.data_L96+2881984/57020256]
[ehci-hcd:__insmod_ehci-hcd_S.data_L96+2886720/57015520]
[ehci-hcd:__insmod_ehci-hcd_S.data_L96+2886464/57015776] [free_module+45/212]
[sys_delete_module+311/616]
Dec  4 15:24:42 pc51167 kernel: Code: 89 50 04 89 02 c7 06 00 00 00 00 c7 46 04
00 00 00 00 8b 1d


>> ebx; c2c40000 <[snd-pcm].data.end+fc75/1fc75>
>> ecx; c2ab4000 <[ehci-hcd].data.end+130641/29c641>
>> esi; c2c445a0 <[snd-pcm].data.end+14215/1fc75>
>> edi; c41b0000 <END_OF_CODE+bf218d/????>
>> ebp; c027a074 <module_mutex+0/14>
>> esp; c44a1f7c <END_OF_CODE+ee4109/????>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000003 Before first symbol
    3:   89 02                     mov    %eax,(%edx)
Code;  00000005 Before first symbol
    5:   c7 06 00 00 00 00         movl   $0x0,(%esi)
Code;  0000000b Before first symbol
    b:   c7 46 04 00 00 00 00      movl   $0x0,0x4(%esi)
Code;  00000012 Before first symbol
   12:   8b 1d 00 00 00 00         mov    0x0,%ebx



---------------------------------------------------------------------------
Linux version 2.4.20aa1 (root@pc51167) (gcc version 2.95.4 20011002 (Debian
prerelease)) #1 SMP Wed Dec 4 12:12:13 CET 2002
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001f771000 (usable)
  BIOS-e820: 000000001f771000 - 000000001f773000 (ACPI NVS)
  BIOS-e820: 000000001f773000 - 000000001f794000 (ACPI data)
  BIOS-e820: 000000001f794000 - 000000001f800000 (reserved)
  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
503MB LOWMEM available.
found SMP MP-table at 000fe710
hm, page 000fe000 reserved twice.
hm, page 000ff000 reserved twice.
hm, page 000f0000 reserved twice.
On node 0 totalpages: 128881
zone(0): 4096 pages.
zone(1): 124785 pages.
zone(2): 0 pages.
ACPI: Searched entire block, no RSDP was found.
ACPI: RSDP located at physical address c00feba0
RSD PTR  v0 [DELL  ]
__va_range(0xfd501, 0x68): idx=8 mapped at ffff6000
ACPI table found: RSDT v1 [DELL   GX260   0.6]
__va_range(0xfd539, 0x24): idx=8 mapped at ffff6000
__va_range(0xfd539, 0x74): idx=8 mapped at ffff6000
ACPI table found: FACP v1 [DELL   GX260   0.6]
__va_range(0xfffd82e7, 0x24): idx=8 mapped at ffff6000
__va_range(0xfffd82e7, 0xa7): idx=8 mapped at ffff6000
ACPI table found: SSDT v1 [DELL st_ex 0.4096]
__va_range(0xfd5ad, 0x24): idx=8 mapped at ffff6000
__va_range(0xfd5ad, 0x6c): idx=8 mapped at ffff6000
ACPI table found: APIC v1 [DELL   GX260   0.6]
__va_range(0xfd5ad, 0x6c): idx=8 mapped at ffff6000
LAPIC (acpi_id[0x0001] id[0x0] enabled[1])
CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC version 16

LAPIC (acpi_id[0x0002] id[0x1] enabled[0])
CPU 1 (0x0100) disabled
LAPIC (acpi_id[0x0003] id[0x1] enabled[0])
CPU 2 (0x0100) disabled
LAPIC (acpi_id[0x0004] id[0x3] enabled[0])
CPU 3 (0x0300) disabled
IOAPIC (id[0x1] address[0xfec00000] global_irq_base[0x0])
INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
4 CPUs total
Local APIC address fee00000
__va_range(0xfd619, 0x24): idx=8 mapped at ffff6000
__va_range(0xfd619, 0x28): idx=8 mapped at ffff6000
ACPI table found: BOOT v1 [DELL   GX260   0.6]
__va_range(0xfd641, 0x24): idx=8 mapped at ffff6000
__va_range(0xfd641, 0x67): idx=8 mapped at ffff6000
ACPI table found: ASF! v16 [DELL   GX260   0.6]
ACPI: Unsupported table ASF!
Enabling the CPU's according to the ACPI table
Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: Opti GX260   APIC at: 0xFEE00000
I/O APIC #1 Version 32 at 0xFEC00000.
Processors: 1
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux ro root=301
Initializing CPU#0
Detected 1992.652 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3971.48 BogoMIPS
Memory: 506528k/515524k available (1205k kernel code, 8612k reserved, 548k
data, 100k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 04
per-CPU timeslice cutoff: 1462.62 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
Setting 1 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 1 ... ok.
init IO_APIC IRQs
  IO-APIC (apicid-pin) 1-0, 1-13, 1-20, 1-21, 1-22 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 41.
number of IO-APIC #1 registers: 24.
testing the IO APIC.......................

IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
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
  09 001 01  0    0    0   0   0    1    1    71
  0a 001 01  0    0    0   0   0    1    1    79
  0b 001 01  0    0    0   0   0    1    1    81
  0c 001 01  0    0    0   0   0    1    1    89
  0d 000 00  1    0    0   0   0    0    0    00
  0e 001 01  0    0    0   0   0    1    1    91
  0f 001 01  0    0    0   0   0    1    1    99
  10 001 01  1    1    0   1   0    1    1    A1
  11 001 01  1    1    0   1   0    1    1    A9
  12 001 01  1    1    0   1   0    1    1    B1
  13 001 01  1    1    0   1   0    1    1    B9
  14 000 00  1    0    0   0   0    0    0    00
  15 000 00  1    0    0   0   0    0    0    00
  16 000 00  1    0    0   0   0    0    0    00
  17 001 01  1    1    0   1   0    1    1    C1
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
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1992.6392 MHz.
..... host bus clock speed is 99.6318 MHz.
cpu: 0, clocks: 996318, slice: 498159
CPU0<T0:996304,T1:498144,D:1,S:498159,C:996318>
migration_task 0 on cpu=0
PCI: PCI BIOS revision 2.10 entry at 0xfbdf8, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
PCI: Using IRQ router PIIX [8086/24c0] at 00:1f.0
PCI->APIC IRQ transform: (B0,I2,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I12,P0) -> 18
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
bigpage subsystem: allocated 0 bigpages (=0MB).
VFS: Disk quotas vdquot_6.5.1
aio_setup: num_physpages = 32220
aio_setup: sizeof(struct page) = 48
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI
enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
ICH4: BIOS setup was incomplete.
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: ST340016A, ATA DISK drive
hdc: HL-DT-ST GCE-8400B, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG DVD-ROM SD-616, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c03539a4, I/O limit 4095Mb (mask 0xffffffff)
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, UDMA(100)
Partition check:
  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 >
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
    8regs     :  2299.600 MB/sec
    32regs    :  1745.600 MB/sec
    pIII_sse  :  2596.800 MB/sec
    pII_mmx   :  2285.200 MB/sec
    p5_mmx    :  2306.800 MB/sec
raid5: using function: pIII_sse (2596.800 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 100k freed
Adding Swap: 995988k swap-space (priority -1)
Real Time Clock Driver v1.10e
Intel(R) PRO/1000 Network Driver - version 4.4.12-k1
Copyright (c) 1999-2002 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
SGI XFS CVS with ACLs, quota, no debug enabled
XFS mounting filesystem ide0(3,2)
XFS mounting filesystem ide0(3,3)
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:1d.7 to 64
hcd.c: ehci-hcd @ 00:1d.7, Intel Corp. 82801DB USB EHCI Controller
hcd.c: irq 23, pci mem e009e800
usb.c: new USB bus registered, assigned bus number 1
ehci-hcd.c: restricting 64bit DMA mappings to segment 0 ...
ehci-hcd.c: USB 2.0 support enabled, EHCI rev 1. 0
hub.c: USB hub found
hub.c: 6 ports detected
usb-uhci.c: $Revision: 1.275 $ time 12:17:56 Dec  4 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0xff80, IRQ 16
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0xff60, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0xff40, IRQ 18
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
PCI: Setting latency timer of device 00:1f.5 to 64
Linux Kernel Card Services 3.1.22
   options:  [pci] [cardbus]
ds: no socket drivers loaded!
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
Unable to handle kernel NULL pointer dereference at virtual address 00000004
  printing eip:
c01cfe37
*pde = 00000000
Oops: 0002 2.4.20aa1 #1 SMP Wed Dec 4 12:12:13 CET 2002
CPU:    0
EIP:    0010:[<c01cfe37>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c2c40000   ecx: c2ab4000   edx: 00000000
esi: c2c445a0   edi: c41b0000   ebp: c027a074   esp: c44a1f7c
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 871, stackpage=c44a1000)
Stack: c2c40000 c027a074 c2c43320 c2c445a0 c2c444a0 c011b029 c2c40000 fffffff0
        c41b0000 c027a074 c011a34f c2c40000 00000000 c44a0000 00000000 bffffe50
        bfffeafc c01070f3 bffffe50 bffffe50 00000000 00000000 bffffe50 bfffeafc
Call Trace:    [<c2c43320>] [<c2c445a0>] [<c2c444a0>] [<c011b029>] [<c011a34f>]
   [<c01070f3>]
Modules: [(snd-intel8x0:<c2c40060>:<c2c44620>)]
Code: 89 50 04 89 02 c7 06 00 00 00 00 c7 46 04 00 00 00 00 8b 1d




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
