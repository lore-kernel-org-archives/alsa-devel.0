From: Peter Vollmer <remllov_@gmx.de>
Subject: ICE1712 on Xscale IXP425
Date: Thu, 01 May 2003 20:38:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.2.20030501200455.036bc308@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
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

Hi,

I am trying to get the alsa driver for EWS88MT (ICE1712) working on an 
XScale Platform (IXP425).

While the register access via pci works apparently ok, I have no sound 
output, and the soundcards DMA-access to the processors system memory seems 
to access the wrong memory regions.

When using aplay or arecord in multitrack mode, it exits after some short 
crackling noise with

arecord: pcm_read:1106: read error: Input/output error

Interrupts from the card arrive, but after short time the function 
snd_pcm_update_hw_ptr_interrupt in pcm_lib.c returns -EPIPE (condition: 
avail>=runtime->stop_threshold)

when running aplay/arecord under strace, at least the whole file seems to 
be read, but still only crackling from the soundcard.

Does this indicate something ?

What would be the best way to check where the recorded data is going and 
where the card is reading from ?

I'll provide more info if needed

thanks !


Uncompressing Linux................................................... 
done, booting the kernel.
Linux version 2.4.19-rmk6-ds1 (root@melissa.dspe) (gcc version 2.95.3 
20010315 (release)) #10 Fre 3
CPU: XScale-IXP425/IXC1100 revision 0
Machine: Intel IXDP425 Development Platform
Warning: bad configuration page, trying to continue
alloc_bootmem_low
memtable_init
On node 0 totalpages: 65536
zone(0): 16384 pages.
zone(1): 49152 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,115200 root=/dev/ram rw ip=off 
initrd=0x00800000,16M mem=256M@0x00000000
Calibrating delay loop... 527.56 BogoMIPS
Memory: 256MB = 256MB total
Memory: 241224KB available (1230K code, 243K data, 200K init)
XScale Cache/TLB Locking Copyright(c) 2001 MontaVista Software, Inc.
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
POSIX conformance testing by UNIFIX
init!
PCI Autoconfig: Found Bus 0, Device 1, Function 0
PCI Autoconfig: BAR 0, Mem, size=0x1000, address=0x4bfff000
PCI Autoconfig: BAR 1, I/O, size=0x40, address=0xffffffc0
PCI Autoconfig: BAR 2, Mem, size=0x100000, address=0x4be00000
PCI Autoconfig: Found Bus 0, Device 2, Function 0			<- soundcard
PCI Autoconfig: BAR 0, I/O, size=0x20, address=0xffffffa0		
PCI Autoconfig: BAR 1, I/O, size=0x10, address=0xffffff90
PCI Autoconfig: BAR 2, I/O, size=0x10, address=0xffffff80
PCI Autoconfig: BAR 3, I/O, size=0x40, address=0xffffff40
PCI: bus0: Fast back to back transfers disabled
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications AB.
i2c-dev.o: Registered 'IXP425 I2C Adapter' as minor 0
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
ttyS00 at 0xfffd2003x (irq = 15) is a XScale UART
ttyS01 at 0xfffd3003x (irq = 13) is a XScale UART
Loaded PCF8594C2 I2C EEPROM NVRAM driver
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw@saw.sw.com.sg> and os
eth0: Intel Corp. 82557/8/9 [Ethernet Pro 100], 00:07:E9:0D:97:0D, IRQ 28.
Board assembly 741462-008, Physical connectors present: RJ45
Primary interface chip i82555 PHY #1.
General self-test: passed.
Serial sub-system self-test: passed.
Internal registers self-test: passed.
ROM checksum self-test: passed (0x8b51f404).
Using buffer write method
Creating 4 MTD partitions on "IXP425 Flash":
0x00000000-0x00040000 : "RedBoot"
0x00040000-0x00fc0000 : "unallocated space"
0x00fc0000-0x00fc1000 : "RedBoot config"
mtd: partition "RedBoot config" doesn't end on an erase block -- force 
read-only
0x00fe0000-0x01000000 : "FIS directory"
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NetWinder Floating Point Emulator V0.95 (c) 1998-1999 Rebel.com
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 16384K
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing init memory: 200K
init started:  BusyBox v0.60.5 (2003.04.16-16:49+0000) multi-call binary
Using /lib/csr/csr.o
Warning: loading csr will taint the kernel: no license
See http://www.tux.org/lkml/#export-tainted for information about tainted 
modules
Intel CSR module init.
Using /lib/csr/ixp425_eth.o
Warning: loading ixp425_eth will taint the kernel: non-GPL 
licenInitializing ixp425_eth driver 0.08
se - Copyright (c) Jungo Ltd. 2002
See http://www.tux.org/lkml/#export-tainted for information about tainted 
modules
Found PHY 0 at 0
Found PHY 1 at 1
PHY 0 MAC address is:   04:04:04:04:04:04
PHY 1 MAC address is:   06:06:06:06:06:06
Starting internet superserver: inetd.
Using /mnt/modules/soundcore.o
Using /mnt/modules/snd.o
Using /mnt/modules/snd-page-alloc.o
Using /mnt/modules/snd-ac97-codec.o
Using /mnt/modules/snd-timer.o
Using /mnt/modules/snd-pcm.o
Using /mnt/modules/snd-seq-device.o
Using /mnt/modules/snd-rawmidi.o
Using /mnt/modules/snd-i2c.o
Using /mnt/modules/snd-cs8427.o
Using /mnt/modules/snd-mpu401-uart.o
Using /mnt/modules/snd-seq.o
Using /mnt/modules/snd-ice1712.o



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
