From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000706]: SERR: Status=4210 followed by NMI reason 34 leading to reboot
Date: Tue, 7 Dec 2004 19:22:01 +0100
Message-ID: <80319924887bb2e24020e5b73e5f40f9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DFC863AD
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2004 19:22:01 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=706> 
======================================================================
Reported By:                dlc
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   706
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               DeMuDi1.2.0
Kernel Version:             2.4.25
======================================================================
Date Submitted:             12-04-2004 00:36 CET
Last Modified:              12-07-2004 19:22 CET
======================================================================
Summary:                    SERR: Status=4210 followed by NMI reason 34 leading
to reboot
Description: 
System reboots when attempting to install a game under Wine.
======================================================================

----------------------------------------------------------------------
 tiwai - 12-07-04 18:52 
----------------------------------------------------------------------
Too little information: Which sound card, which ALSA version?

Try to use snd-dummy driver instead of snd-ice1712, and see whether the
same problem occurs.  If it happens, the problem should be in others.

----------------------------------------------------------------------
 dlc - 12-07-04 19:22 
----------------------------------------------------------------------
I will pull the PCI card and retest, but consider the following logs:

Platform: IBM Netfinity 5600 -- dual Xenon 866 MHz -- M-Audio Delta 1010
-- DeMuDi 1.2.0
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
PowerPC Hypervisor Log:

Date/Time: 2004/11/23 01:51:17
DMI Type: 00
Source: SMI Hdlr
Message Code: SERR: Device Signaled SERR
Message Data: Bus=1 Slot=5 VendID=1412 DevID=1712 Status=4210

Date/Time: 20041123 01:51:24
Source: SERVPROC
Message Code: NMI Detected
= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
/var/log/messages:
Nov 22 20:36:53 muse syslogd 1.4.1#15: restart.
Nov 22 20:36:53 muse kernel: klogd 1.4.1#15, log source = /proc/kmsg
started.
Nov 22 20:36:53 muse kernel: Inspecting
/boot/System.map-2.4.25-1-multimedia-686
Nov 22 20:36:53 muse kernel: Loaded 18934 symbols from
/boot/System.map-2.4.25-1-multimedia-686.
Nov 22 20:36:53 muse kernel: Symbols match kernel version 2.4.25.
Nov 22 20:36:53 muse kernel: Loaded 935 symbols from 32 modules.
Nov 22 20:36:53 muse kernel: Linux version 2.4.25-1-multimedia-686
(free@debian) (gcc version 3.3.4 (Debian 1:3.3.4-6sarge1))
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 SMP
Fri Sep 3 10:57:47 CEST 2004
Nov 22 20:36:53 muse kernel: BIOS-provided physical RAM map:
Nov 22 20:36:53 muse kernel: BIOS-e820: 0000000000000000 -
000000000009d000 (usable)
Nov 22 20:36:53 muse kernel: BIOS-e820: 000000000009d000 -
00000000000a0000 (reserved)
Nov 22 20:36:53 muse kernel: BIOS-e820: 00000000000e0000 -
0000000000100000 (reserved)
Nov 22 20:36:53 muse kernel: BIOS-e820: 0000000000100000 -
000000001fffb8c0 (usable)
Nov 22 20:36:53 muse kernel: BIOS-e820: 000000001fffb8c0 -
0000000020000000 (ACPI data)
Nov 22 20:36:53 muse kernel: BIOS-e820: 00000000fec00000 -
00000000fec01000 (reserved)
Nov 22 20:36:53 muse kernel: BIOS-e820: 00000000fee00000 -
00000000fee01000 (reserved)
Nov 22 20:36:53 muse kernel: BIOS-e820: 00000000fff80000 -
0000000100000000 (reserved)
Nov 22 20:36:53 muse kernel: 511MB LOWMEM available.
Nov 22 20:36:53 muse kernel: found SMP MP-table at 0009e140
Nov 22 20:36:53 muse kernel: hm, page 0009e000 reserved twice.
Nov 22 20:36:53 muse kernel: hm, page 0009f000 reserved twice.
Nov 22 20:36:53 muse kernel: hm, page 0009e000 reserved twice.
Nov 22 20:36:53 muse kernel: hm, page 0009f000 reserved twice.
Nov 22 20:36:53 muse kernel: On node 0 totalpages: 131067
Nov 22 20:36:53 muse kernel: zone(0): 4096 pages.
Nov 22 20:36:53 muse kernel: zone(1): 126971 pages.
Nov 22 20:36:53 muse kernel: zone(2): 0 pages.
Nov 22 20:36:53 muse kernel: IBM machine detected. Disabling SMBus
accesses.
Nov 22 20:36:53 muse kernel: IBM machine detected. Enabling interrupts
during APM calls.
Nov 22 20:36:53 muse kernel: ACPI: RSDP (v000 IBM ) @ 0x000fdfe0
Nov 22 20:36:53 muse kernel: ACPI: RSDT (v001 IBM SERTETON 0x00001000 IBM
0x00000000) @ 0x1fffff80
Nov 22 20:36:53 muse kernel: ACPI: FADT (v001 IBM SERTETON 0x00001000 IBM
0x00000000) @ 0x1fffff00
Nov 22 20:36:53 muse kernel: ACPI: MADT (v001 IBM SERTETON 0x00001000 IBM
0x00000000) @ 0x1ffffe80
Nov 22 20:36:53 muse kernel: ACPI: SSDT (v001 IBM SERTETON 0x00001000 MSFT
0x0100000b) @ 0x1fffea79
Nov 22 20:36:53 muse kernel: ACPI: DSDT (v001 IBM SERTETON 0x00001000 MSFT
0x0100000b) @ 0x00000000
Nov 22 20:36:53 muse kernel: ACPI: Local APIC address 0xfee00000
Nov 22 20:36:53 muse kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x01]
enabled)
Nov 22 20:36:53 muse kernel: Processor
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Pentium(tm) Pro APIC
version 17
Nov 22 20:36:53 muse kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00]
enabled)
Nov 22 20:36:53 muse kernel: Processor
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0 Pentium(tm) Pro APIC
version 17
Nov 22 20:36:53 muse kernel: Using ACPI for processor (LAPIC)
configuration information
Nov 22 20:36:53 muse kernel: Intel MultiProcessor Specification v1.4
Nov 22 20:36:53 muse kernel: Virtual Wire compatibility mode.
Nov 22 20:36:53 muse kernel: OEM ID: IBM GNK Product ID: Teton SMP APIC
at: 0xFEE00000
Nov 22 20:36:53 muse kernel: I/O APIC
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=14 Version 17 at
0xFEC00000.
Nov 22 20:36:53 muse kernel: I/O APIC
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=15 Version 17 at
0xFEC01000.
Nov 22 20:36:53 muse kernel: Enabling APIC mode: Flat.^IUsing 2 I/O APICs
Nov 22 20:36:53 muse kernel: Processors: 2
Nov 22 20:36:53 muse kernel: Kernel command line: root=/dev/sda1 ro
Nov 22 20:36:53 muse kernel: Initializing CPU#0
Nov 22 20:36:53 muse kernel: Detected 866.309 MHz processor.
Nov 22 20:36:53 muse kernel: Console: colour VGA+ 80x25
Nov 22 20:36:53 muse kernel: Calibrating delay loop... 1730.15 BogoMIPS
Nov 22 20:36:53 muse kernel: Memory: 511976k/524268k available (1218k
kernel code, 11896k reserved, 504k data, 100k init, 0k highmem
)
Nov 22 20:36:53 muse kernel: Dentry cache hash table entries: 65536
(order: 7, 524288 bytes)
Nov 22 20:36:53 muse kernel: Inode cache hash table entries: 32768 (order:
6, 262144 bytes)
Nov 22 20:36:53 muse kernel: Mount cache hash table entries: 512 (order:
0, 4096 bytes)
Nov 22 20:36:53 muse kernel: Buffer cache hash table entries: 32768
(order: 5, 131072 bytes)
Nov 22 20:36:53 muse kernel: Page-cache hash table entries: 131072 (order:
7, 524288 bytes)
Nov 22 20:36:53 muse kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Nov 22 20:36:53 muse kernel: CPU: L2 cache: 256K
Nov 22 20:36:53 muse kernel: CPU serial number disabled.
Nov 22 20:36:53 muse kernel: Enabling fast FPU save and restore... done.
Nov 22 20:36:53 muse kernel: Enabling unmasked SIMD FPU exception
support... done.
Nov 22 20:36:53 muse kernel: Checking 'hlt' instruction... OK.
Nov 22 20:36:53 muse kernel: POSIX conformance testing by UNIFIX
Nov 22 20:36:53 muse kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Nov 22 20:36:53 muse kernel: CPU: L2 cache: 256K
Nov 22 20:36:53 muse kernel: CPU0: Intel Pentium III (Coppermine) stepping
06
Nov 22 20:36:53 muse kernel: per-CPU timeslice cutoff: 731.68 usecs.
Nov 22 20:36:53 muse kernel: enabled ExtINT on CPU#0
Nov 22 20:36:53 muse kernel: ESR value before enabling vector: 00000000
Nov 22 20:36:53 muse kernel: ESR value after enabling vector: 00000000
Nov 22 20:36:53 muse kernel: Booting processor 1/0 eip 3000
Nov 22 20:36:53 muse kernel: Initializing CPU#1
Nov 22 20:36:53 muse kernel: masked ExtINT on CPU#1
Nov 22 20:36:53 muse kernel: ESR value before enabling vector: 00000000
Nov 22 20:36:53 muse kernel: ESR value after enabling vector: 00000000
Nov 22 20:36:53 muse kernel: Calibrating delay loop... 1730.15 BogoMIPS
Nov 22 20:36:53 muse kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Nov 22 20:36:53 muse kernel: CPU: L2 cache: 256K
Nov 22 20:36:53 muse kernel: CPU serial number disabled.
Nov 22 20:36:53 muse kernel: CPU1: Intel Pentium III (Coppermine) stepping
06
Nov 22 20:36:53 muse kernel: Total of 2 processors activated (3460.30
BogoMIPS).
Nov 22 20:36:53 muse kernel: ENABLING IO-APIC IRQs
Nov 22 20:36:53 muse kernel: Setting 14 in the phys_id_present_map
Nov 22 20:36:53 muse kernel: ...changing IO-APIC physical APIC ID to 14
... ok.
Nov 22 20:36:53 muse kernel: Setting 15 in the phys_id_present_map
Nov 22 20:36:53 muse kernel: ...changing IO-APIC physical APIC ID to 15
... ok.
Nov 22 20:36:53 muse kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Nov 22 20:36:53 muse kernel: ...trying to set up timer (IRQ0) through the
8259A ...
Nov 22 20:36:53 muse kernel: ..... (found pin 0) ...works.
Nov 22 20:36:53 muse kernel: testing the IO APIC.......................
Nov 22 20:36:53 muse kernel:
Nov 22 20:36:53 muse kernel:
Nov 22 20:36:53 muse kernel: .................................... done.
Nov 22 20:36:53 muse kernel: Using local APIC timer interrupts.
Nov 22 20:36:53 muse kernel: calibrating APIC timer ...
Nov 22 20:36:53 muse kernel: ..... CPU clock speed is 866.1158 MHz.
Nov 22 20:36:53 muse kernel: ..... host bus clock speed is 133.2483 MHz.
Nov 22 20:36:53 muse kernel: cpu: 0, clocks: 1332483, slice: 444161
Nov 22 20:36:53 muse kernel:
CPU0<T0:1332480,T1:888304,D:15,S:444161,C:1332483>
Nov 22 20:36:53 muse kernel: cpu: 1, clocks: 1332483, slice: 444161
Nov 22 20:36:53 muse kernel:
CPU1<T0:1332480,T1:444144,D:14,S:444161,C:1332483>
Nov 22 20:36:53 muse kernel: checking TSC synchronization across CPUs:
passed.
Nov 22 20:36:53 muse kernel: Waiting on wait_init_idle (map = 0x2)
Nov 22 20:36:53 muse kernel: All processors have done init_idle
Nov 22 20:36:53 muse kernel: ACPI: Subsystem revision 20040116
Nov 22 20:36:53 muse kernel: ACPI: Interpreter disabled.
Nov 22 20:36:53 muse kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd34c,
last bus=4
Nov 22 20:36:53 muse kernel: PCI: Using configuration type 1
Nov 22 20:36:53 muse kernel: PCI: Probing PCI hardware
Nov 22 20:36:53 muse kernel: PCI: ACPI tables contain no PCI IRQ routing
entries
Nov 22 20:36:53 muse kernel: PCI: Probing PCI hardware (bus 00)
Nov 22 20:36:53 muse kernel: PCI: Discovered peer bus 01
Nov 22 20:36:53 muse kernel: PCI->APIC IRQ transform: (B0,I2,P0) -> 27
Nov 22 20:36:53 muse kernel: PCI->APIC IRQ transform: (B0,I10,P0) -> 18
Nov 22 20:36:53 muse kernel: PCI->APIC IRQ transform: (B0,I15,P0) -> 9
Nov 22 20:36:53 muse kernel: PCI->APIC IRQ transform: (B1,I3,P0) -> 28
Nov 22 20:36:53 muse kernel: PCI->APIC IRQ transform: (B1,I3,P0) -> 28
Nov 22 20:36:53 muse kernel: PCI->APIC IRQ transform: (B1,I5,P0) -> 20
Nov 22 20:36:53 muse kernel: PCI->APIC IRQ transform: (B1,I6,P0) -> 22
Nov 22 20:36:53 muse kernel: PCI->APIC IRQ transform: (B1,I7,P0) -> 24
Nov 22 20:36:53 muse kernel: Linux NET4.0 for Linux 2.4
Nov 22 20:36:53 muse kernel: Based upon Swansea University Computer
Society NET3.039
Nov 22 20:36:53 muse kernel: Initializing RT netlink socket
Nov 22 20:36:53 muse kernel: Starting kswapd
Nov 22 20:36:53 muse kernel: VFS: Disk quotas vdquot_6.5.1
Nov 22 20:36:53 muse kernel: devfs: v1.12c (20020818) Richard Gooch
(rgooch@atnf.csiro.au)
Nov 22 20:36:53 muse kernel: devfs: boot_options: 0x0
Nov 22 20:36:53 muse kernel: pty: 256 Unix98 ptys configured
Nov 22 20:36:53 muse kernel: Serial driver version 5.05c (2001-07-08) with
HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
Nov 22 20:36:53 muse kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Nov 22 20:36:53 muse kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Nov 22 20:36:53 muse kernel: Real Time Clock Driver v1.10f
Nov 22 20:36:53 muse kernel: COMX: driver version 0.85 (C) 1995-1999
ITConsult-Pro Co. <info@itc.hu>
Nov 22 20:36:53 muse kernel: RAMDISK driver initialized: 16 RAM disks of
8192K size 1024 blocksize
Nov 22 20:36:53 muse kernel: Initializing Cryptographic API
Nov 22 20:36:53 muse kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Nov 22 20:36:53 muse kernel: IP: routing cache hash table of 4096 buckets,
32Kbytes
Nov 22 20:36:53 muse kernel: TCP: Hash tables configured (established
32768 bind 32768)
Nov 22 20:36:53 muse kernel: Linux IP multicast router 0.06 plus PIM-SM
Nov 22 20:36:53 muse kernel: RAMDISK: cramfs filesystem found at block 0
Nov 22 20:36:53 muse kernel: RAMDISK: Loading 3832 blocks [1 disk] into
ram disk... |^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H
|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H
|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H
|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H
|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H
|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H
|^H/^H-^H\^Hdone.
Nov 22 20:36:53 muse kernel: Freeing initrd memory: 3832k freed
Nov 22 20:36:53 muse kernel: VFS: Mounted root (cramfs filesystem).
Nov 22 20:36:53 muse kernel: Freeing unused kernel memory: 100k freed
Nov 22 20:36:53 muse kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0.
Nov 22 20:36:53 muse kernel: SCSI subsystem driver Revision: 1.00
Nov 22 20:36:53 muse kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA
DRIVER, Rev 6.2.36
Nov 22 20:36:53 muse kernel: <Adaptec 2940 Ultra SCSI adapter>
Nov 22 20:36:53 muse kernel: aic7880: Ultra Wide Channel A, SCSI Id=7,
16/253 SCBs
Nov 22 20:36:53 muse kernel:
Nov 22 20:36:53 muse kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA
DRIVER, Rev 6.2.36
Nov 22 20:36:53 muse kernel: <Adaptec aic7896/97 Ultra2 SCSI adapter>
Nov 22 20:36:53 muse kernel: aic7896/97: Ultra2 Wide Channel A, SCSI Id=7,
32/253 SCBs
Nov 22 20:36:53 muse kernel:
Nov 22 20:36:53 muse kernel: scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA
DRIVER, Rev 6.2.36
Nov 22 20:36:53 muse kernel: <Adaptec aic7896/97 Ultra2 SCSI adapter>
Nov 22 20:36:53 muse kernel: aic7896/97: Ultra2 Wide Channel B, SCSI Id=7,
32/253 SCBs
Nov 22 20:36:53 muse kernel:
Nov 22 20:36:53 muse kernel: (scsi0:A:0): 40.000MB/s transfers (20.000MHz,
offset 8, 16bit)
Nov 22 20:36:53 muse kernel: Vendor: SEAGATE Model: ST318203LC Rev: 0002
Nov 22 20:36:53 muse kernel: Type: Direct-Access ANSI SCSI revision: 02
Nov 22 20:36:53 muse kernel: (scsi0:A:2): 40.000MB/s transfers (20.000MHz,
offset 8, 16bit)
Nov 22 20:36:53 muse kernel: Vendor: SEAGATE Model: ST318203LC Rev: 0003
Nov 22 20:36:53 muse kernel: Type: Direct-Access ANSI SCSI revision: 02
Nov 22 20:36:53 muse kernel: scsi0:A:0:0: Tagged Queuing enabled. Depth 8
Nov 22 20:36:53 muse kernel: scsi0:A:2:0: Tagged Queuing enabled. Depth 8
Nov 22 20:36:53 muse kernel: Attached scsi disk sda at scsi0, channel 0,
id 0, lun 0
Nov 22 20:36:53 muse kernel: Attached scsi disk sdb at scsi0, channel 0,
id 2, lun 0
Nov 22 20:36:53 muse kernel: SCSI device sda: 35566480 512-byte hdwr
sectors (18210 MB)
Nov 22 20:36:53 muse kernel: Partition check:
Nov 22 20:36:53 muse kernel: /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
p4
Nov 22 20:36:53 muse kernel: SCSI device sdb: 35566480 512-byte hdwr
sectors (18210 MB)
Nov 22 20:36:53 muse kernel: /dev/scsi/host0/bus0/target2/lun0: p1 p2 p3
p4
Nov 22 20:36:53 muse kernel: Journalled Block Device driver loaded
Nov 22 20:36:53 muse kernel: EXT3-fs: INFO: recovery required on readonly
filesystem.
Nov 22 20:36:53 muse kernel: EXT3-fs: write access will be enabled during
recovery.
Nov 22 20:36:53 muse kernel: kjournald starting. Commit interval 5
seconds
Nov 22 20:36:53 muse kernel: EXT3-fs: sd(8,1): orphan cleanup on readonly
fs
Nov 22 20:36:53 muse kernel: EXT3-fs: sd(8,1): 1 orphan inode deleted
Nov 22 20:36:53 muse kernel: EXT3-fs: recovery complete.
Nov 22 20:36:53 muse kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Nov 22 20:36:53 muse kernel: kjournald starting. Commit interval 5
seconds
Nov 22 20:36:53 muse kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Nov 22 20:36:53 muse kernel: Adding Swap: 996016k swap-space (priority
-1)
Nov 22 20:36:53 muse kernel: Adding Swap: 996016k swap-space (priority
-2)
Nov 22 20:36:53 muse kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
sd(8,1), internal journal
Nov 22 20:36:53 muse kernel: Uniform Multi-Platform E-IDE driver Revision:
7.00beta4-2.4
Nov 22 20:36:53 muse kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Nov 22 20:36:53 muse kernel: scsi3 : SCSI host adapter emulation for IDE
ATAPI devices
Nov 22 20:36:53 muse kernel: hda: LTN485S, ATAPI CD/DVD-ROM drive
Nov 22 20:36:53 muse kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 22 20:36:53 muse kernel: kjournald starting. Commit interval 5
seconds
Nov 22 20:36:53 muse kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
sd(8,3), internal journal
Nov 22 20:36:53 muse kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Nov 22 20:36:53 muse kernel: kjournald starting. Commit interval 5
seconds
Nov 22 20:36:53 muse kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
sd(8,17), internal journal
Nov 22 20:36:53 muse kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Nov 22 20:36:53 muse kernel: kjournald starting. Commit interval 5
seconds
Nov 22 20:36:53 muse kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on
sd(8,19), internal journal
Nov 22 20:36:53 muse kernel: EXT3-fs: mounted filesystem with ordered data
mode.
Nov 22 20:36:53 muse kernel: pcnet32.c:v1.27a 10.02.2002
tsbogend@alpha.franken.de
Nov 22 20:36:53 muse kernel: pcnet32: PCnet/FAST III 79C975 at 0x2000, 00
06 29 a8 d8 95 assigned IRQ 27.
Nov 22 20:36:53 muse kernel: eth0: registered as PCnet/FAST III 79C975
Nov 22 20:36:53 muse kernel: pcnet32: 1 cards_found.
Nov 22 20:36:53 muse kernel: Intel(R) PRO/1000 Network Driver - version
5.2.20-k1
Nov 22 20:36:53 muse kernel: Copyright (c) 1999-2003 Intel Corporation.
Nov 22 20:36:53 muse kernel: eth1: Dropping NETIF_F_SG since no checksum
feature.
Nov 22 20:36:53 muse kernel: eth1: Intel(R) PRO/1000 Network Connection
Nov 22 20:36:53 muse kernel: Warning ! ! ! ServeRAID Version Mismatch
Nov 22 20:36:53 muse kernel: Bios = 4.50.05, Firmware = 4.50.05, Device
Driver = 6.11.07
Nov 22 20:36:53 muse kernel: These levels should match to avoid possible
compatibility problems.
Nov 22 20:36:53 muse kernel: scsi4 : IBM PCI ServeRAID 6.11.07 Build 2224
<ServeRAID 4L>
Nov 22 20:36:53 muse kernel: Vendor: IBM Model: SERVERAID Rev: 1.00
Nov 22 20:36:53 muse kernel: Type: Processor ANSI SCSI revision: 02
Nov 22 20:36:53 muse kernel: usb.c: registered new driver usbdevfs
Nov 22 20:36:53 muse kernel: usb.c: registered new driver hub
Nov 22 20:36:53 muse kernel: usb-ohci.c: USB OHCI at membase 0xe0a4d000,
IRQ 9
Nov 22 20:36:53 muse kernel: usb-ohci.c: usb-00:0f.2, ServerWorks
OSB4/CSB5 OHCI USB Controller
Nov 22 20:36:53 muse kernel: usb.c: new USB bus registered, assigned bus
number 1
Nov 22 20:36:53 muse kernel: hub.c: USB hub found
Nov 22 20:36:53 muse kernel: hub.c: 4 ports detected
Nov 22 20:36:55 muse lpd[718]: restarted
Nov 22 20:51:16 muse kernel: Uhhuh. NMI received for unknown reason 34.
Nov 22 20:51:16 muse kernel: Dazed and confused, but trying to continue
Nov 22 20:51:16 muse kernel: Do you have a strange power saving mode
enabled?
Nov 22 20:58:27 muse syslogd 1.4.1#15: restart.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-04-04 00:36 dlc            New Issue                                    
12-04-04 00:36 dlc            Distribution              => DeMuDi1.2.0     
12-04-04 00:36 dlc            Kernel Version            => 2.4.25          
12-07-04 18:52 tiwai          Note Added: 0002760                          
12-07-04 19:22 dlc            Note Added: 0002763                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
