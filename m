From: helgedt@tihlde.org
Subject: Bug report: snd_pcm_oss crash (in pcm_pcm_format_silence)
Date: Tue, 14 Oct 2003 00:15:49 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <55378.129.241.131.223.1066083349.squirrel@webmail.tihlde.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20031014001549_37320"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

------=_20031014001549_37320
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hey, snd_pcm_oss (I think) just crashed on me. Included dmesg output as
attachment. It happened when ogg123 finished playing, has never happened
to me before. Additionally, alsamixer was running on a different tty.

Sound hardware: Intel Corp. 82801CA/CAM AC'97 Audio Controller
Kernel version: 2.6.0-test7 (vanilla + nvidia + linux_wlan_ng)
Loaded modules:
prism2_pci
p80211
irda
snd_intel8x0
snd_ac97_codec
snd_mpu401_uart
snd_rawmidi
snd_seq_device
snd_pcm_oss
snd_pcm
snd_page_alloc
snd_timer
snd_mixer_oss
snd

Couldn't reproduce the bug, didn't try too much though.

-- 
Helge Titlestad

------=_20031014001549_37320
Content-Type: text/plain; name="snd_pcm_format_set_silence.crash.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
      filename="snd_pcm_format_set_silence.crash.txt"

Linux version 2.6.0-test7 (root@riva) (gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r1, propolice)) #4 Thu Oct 9 22:34:35 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001fefc000 (ACPI data)
 BIOS-e820: 000000001fefc000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 000000001ff80000 (usable)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130944
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126848 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6c50
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1fef5ae9
ACPI: FADT (v001 INTEL  845M     0x06040000 PTL  0x0000004b) @ 0x1fefbf8c
ACPI: DSDT (v001 COMPAL 845M     0x06040000 MSFT 0x0100000d) @ 0x00000000
Building zonelist for node : 0
Kernel command line: root=/dev/hda2
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1595.960 MHz processor.
Console: colour VGA+ 80x25
Memory: 513888k/523776k available (2686k kernel code, 9072k reserved, 886k data, 128k init, 0k highmem)
Calibrating delay loop... 3145.72 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 3febf9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 3febf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd984, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030918
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs 9)
ACPI: PCI Interrupt Link [LNKD] (IRQs 9)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 5)
ACPI: Embedded Controller [EC0] (gpe 28)
Linux Kernel Card Services
  options:  [pci] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Machine check exception polling timer started.
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
udf: registering filesystem
SGI XFS for Linux with large block numbers, no debug enabled
Initializing Cryptographic API
    ACPI-0165: *** Warning: The ACPI AML in your computer contains errors, please nag the manufacturer to correct it.
    ACPI-0168: *** Warning: Allowing relaxed access to fields; turn on CONFIG_ACPI_DEBUG for details.
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
ACPI: Thermal Zone [THRM] (36 C)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xd4000000
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0xe0822800, 00:02:3f:ab:90:44, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHR2030AT, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 58605120 sectors (30005 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdc: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 0000:02:00.0 (0110 -> 0113)
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[e0000000-e00007ff]  Max Packet=[65536]
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci-hcd 0000:00:1d.0: irq 10, io base 00002400
uhci-hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci-hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci-hcd 0000:00:1d.1: irq 11, io base 00002420
uhci-hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
ACPI: (supports S0 S1 S3 S4 S5)
UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not supported: rc=-22
UDF-fs DEBUG fs/udf/super.c:1544:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:532:udf_vrs: Starting at sector 16 (2048 byte sectors)
UDF-fs: No VRS found
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023f251a000ac2]
XFS mounting filesystem hda2
Ending clean XFS mount for filesystem: hda2
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 128k freed
Adding 385552k swap on /dev/hda3.  Priority:-1 extents:1
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0: clocking to 48000
NET: Registered protocol family 23
prism2_init: prism2_pci.o: 0.2.1-pre11 Loaded
prism2_init: dev_info is: prism2_pci
PCI: Enabling device 0000:02:02.0 (0114 -> 0116)
A Prism2.5 PCI device found, phymem:0xe0100000, irq:11, mem:0xe085d000
ident: nic h/w: id=0x8013 1.0.0
ident: pri f/w: id=0x15 1.0.7
ident: sta f/w: id=0x1f 1.3.5
MFI:SUP:role=0x00:id=0x01:var=0x01:b/t=1/1
CFI:SUP:role=0x00:id=0x02:var=0x02:b/t=1/1
PRI:SUP:role=0x00:id=0x03:var=0x01:b/t=4/4
STA:SUP:role=0x00:id=0x04:var=0x01:b/t=1/9
PRI-CFI:ACT:role=0x01:id=0x02:var=0x02:b/t=1/1
STA-CFI:ACT:role=0x01:id=0x02:var=0x02:b/t=1/1
STA-MFI:ACT:role=0x01:id=0x01:var=0x01:b/t=1/1
Prism2 card SN: 99SA01000000
blk: queue dfd53800, I/O limit 4095Mb (mask 0xffffffff)
Unable to handle kernel paging request at virtual address e087e000
 printing eip:
e08b34e1
*pde = 1fec4067
*pte = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<e08b34e1>]    Not tainted
EFLAGS: 00010206
EIP is at snd_pcm_format_set_silence+0x9c/0x1d6 [snd_pcm]
eax: 00000000   ebx: 00000002   ecx: 0000003c   edx: 000010f0
esi: 00000878   edi: e087e000   ebp: df616460   esp: de04bf28
ds: 007b   es: 007b   ss: 0068
Process ogg123 (pid: 1844, threadinfo=de04a000 task=de98a680)
Stack: 00000002 40449000 00000878 de50bc00 dfc71a80 e08c1b33 00000002 e087d000 
       00000878 de623880 dfc93200 df616460 de623880 e08c2f0b df616460 c01436c8 
       de623880 dff74800 df319380 df223980 c014fb26 df319380 de623880 de623880 
Call Trace:
 [<e08c1b33>] snd_pcm_oss_sync+0x69/0x15f [snd_pcm_oss]
 [<e08c2f0b>] snd_pcm_oss_release+0x2a/0x92 [snd_pcm_oss]
 [<c01436c8>] unmap_vma_list+0x1c/0x28
 [<c014fb26>] __fput+0xb3/0xc5
 [<c014e2c9>] filp_close+0x59/0x86
 [<c014e35a>] sys_close+0x64/0x98
 [<c0109327>] syscall_call+0x7/0xb

Code: f3 ab f6 c2 02 74 02 66 ab f6 c2 01 74 01 aa eb be 89 f0 83 
 
------=_20031014001549_37320--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
