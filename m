From: David Fries <dfries@mail.win.org>
Subject: opl kernel panic
Date: Sat, 29 Mar 2003 18:01:56 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030330000156.GA16202@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

I just updated the alsa-driver from cvs today and I'm using a stock
2.4.18 kernel on my laptop which is an older Pentium MMX system.

The only option I gave cvscompile was --with-cards= for the opl cards.

modprobe snd-opl3sa2 port=0x370 wss_port=0x530 fm_port=0x388 midi_port=0x330 irq=5 dma1=1 dma2=0

After three reboots I have determined that it doesn't crash just on
processes accessing the sound card it crashes randomly on any process.
I would manually load the module, on the oops I captured I ran
alsamixer which is the process that oopsed, copied /proc/ksyms, dmesg,
and rebooted as the last time I tried to decode the oops without
rebooting ksymoops was unable to run due to crashes.

ksymoops 2.4.8 on i586 2.4.18.  Options used
     -V (default)
     -k alsa_oops3_ksyms (specified)
     -L (specified)
     -O (specified)
     -m /boot/kernel/2.4.18.map (specified)

Intel Pentium with F0 0F bug - workaround enabled.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x330-0x337 0x370-0x37f 0x388-0x38f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0111093
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0111093>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010097
eax: c0eec388   ebx: c0eec384   ecx: 00000000   edx: 00000003
esi: c19840e0   edi: 00000001   ebp: c1df3f4c   esp: c1df3f34
ds: 0018   es: 0018   ss: 0018
Process alsamixer (pid: 603, stackpage=c1df3000)
Stack: c069a220 c19840e0 c19840e0 c0eec388 00000286 00000003 c03b8bc0 c30491fd 
       c03acd20 c0eec200 c304a916 c0eec200 c19840e0 c19840e0 c12e79a0 c1086320 
       c012def4 c12e79a0 c19840e0 c19840e0 00000000 00000000 bffff668 c012d02c 
Call Trace: [<c30491fd>] [<c304a916>] [<c012def4>] [<c012d02c>] [<c012d077>] 
   [<c0106b73>] 
Code: 8b 01 85 45 fc 74 4d 31 c0 9c 5e fa c7 01 00 00 00 00 83 79 


>>EIP; c0111093 <__wake_up+2b/94>   <=====

>>eax; c0eec388 <_end+c19158/2d42e30>
>>ebx; c0eec384 <_end+c19154/2d42e30>
>>esi; c19840e0 <_end+16b0eb0/2d42e30>
>>ebp; c1df3f4c <_end+1b20d1c/2d42e30>
>>esp; c1df3f34 <_end+1b20d04/2d42e30>

Trace; c30491fd <[snd]snd_card_file_remove+6d/90>
Trace; c304a916 <[snd]snd_ctl_release+a6/c0>
Trace; c012def4 <fput+4c/d0>
Trace; c012d02c <filp_close+5c/64>
Trace; c012d077 <sys_close+43/54>
Trace; c0106b73 <system_call+33/40>

Code;  c0111093 <__wake_up+2b/94>
00000000 <_EIP>:
Code;  c0111093 <__wake_up+2b/94>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c0111095 <__wake_up+2d/94>
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0111098 <__wake_up+30/94>
   5:   74 4d                     je     54 <_EIP+0x54>
Code;  c011109a <__wake_up+32/94>
   7:   31 c0                     xor    %eax,%eax
Code;  c011109c <__wake_up+34/94>
   9:   9c                        pushf  
Code;  c011109d <__wake_up+35/94>
   a:   5e                        pop    %esi
Code;  c011109e <__wake_up+36/94>
   b:   fa                        cli    
Code;  c011109f <__wake_up+37/94>
   c:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c01110a5 <__wake_up+3d/94>
  12:   83 79 00 00               cmpl   $0x0,0x0(%ecx)


Linux version 2.4.18 (root@NoSpace) (gcc version 2.95.4 20010721 (Debian prerelease)) #21 Tue Oct 29 17:08:48 CST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000002010000 (usable)
 BIOS-e820: 0000000002010000 - 0000000002020000 (ACPI data)
 BIOS-e820: 0000000002020000 - 0000000002040000 (reserved)
 BIOS-e820: 00000000fef80000 - 00000000ff000000 (reserved)
 BIOS-e820: 00000000fffe0000 - 00000000fffe6e00 (reserved)
 BIOS-e820: 00000000fffe6e00 - 00000000fffe7000 (ACPI NVS)
 BIOS-e820: 00000000fffe7000 - 0000000100000000 (reserved)
On node 0 totalpages: 8208
zone(0): 4096 pages.
zone(1): 4112 pages.
zone(2): 0 pages.
No local APIC present or hardware disabled
Kernel command line: auto BOOT_IMAGE=2.4.18 root=302
Initializing CPU#0
Detected 266.619 MHz processor.
Console: colour VGA+ 80x60
Calibrating delay loop... 532.48 BogoMIPS
Memory: 30024k/32832k available (1166k kernel code, 2420k reserved, 306k data, 200k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
CPU:             Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Mobile Pentium MMX stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfd837, last bus=21
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x02 (Driver version 1.16)
Starting kswapd
Journalled Block Device driver loaded
ACPI: APM is already active, exiting
pty: 256 Unix98 ptys configured
Toshiba System Managment Mode driver v1.11 26/9/2001
Real Time Clock Driver v1.10e
block: 64 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: TOSHIBA MK4310MAT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 8452080 sectors (4327 MB), CHS=526/255/63
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 8272A
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 00:13.0 (0000 -> 0002)
PCI: Enabling device 00:13.1 (0000 -> 0002)
Intel PCIC probe: not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
Yenta IRQ list 06b8, PCI irq11
Socket status: 30000007
Yenta IRQ list 06b8, PCI irq11
Socket status: 30000011
kjournald starting.  Commit interval 5 seconds
EXT3-fs: ide0(3,2): orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 620605
ext3_orphan_cleanup: deleting unreferenced inode 620603
EXT3-fs: ide0(3,2): 2 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 200k freed
Adding Swap: 120480k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver usblp
printer.c: v0.8:USB Printer Device Class driver
mice: PS/2 mouse device common for all mice
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb-ohci.c: USB OHCI at membase 0xc3044000, IRQ 11
usb-ohci.c: usb-00:0b.0, NEC Corporation USB
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
ALSA ../alsa-kernel/isa/opl3sa2.c:733: specify port
Yamaha OPL3-SA soundcard not found or device busy
ip_tables: (C) 2000-2002 Netfilter core team
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x330-0x337 0x370-0x37f 0x388-0x38f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
xirc2ps_cs.c 1.31 1998/12/09 19:32:55 (dd9jn+kvh)
eth0: Intel: port 0x300, irq 3, hwaddr 00:A0:C9:7A:CE:D5
eth0: autonegotiation failed; using 10mbs
eth0: MII detected; using 10mbs
eth0: media 10BaseT, silicon revision 4
eth0: no IPv6 routers present
ALSA ../alsa-kernel/isa/opl3sa2.c:733: specify port
Yamaha OPL3-SA soundcard not found or device busy
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0111093
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0111093>]    Not tainted
EFLAGS: 00010097
eax: c0eec388   ebx: c0eec384   ecx: 00000000   edx: 00000003
esi: c19840e0   edi: 00000001   ebp: c1df3f4c   esp: c1df3f34
ds: 0018   es: 0018   ss: 0018
Process alsamixer (pid: 603, stackpage=c1df3000)
Stack: c069a220 c19840e0 c19840e0 c0eec388 00000286 00000003 c03b8bc0 c30491fd 
       c03acd20 c0eec200 c304a916 c0eec200 c19840e0 c19840e0 c12e79a0 c1086320 
       c012def4 c12e79a0 c19840e0 c19840e0 00000000 00000000 bffff668 c012d02c 
Call Trace: [<c30491fd>] [<c304a916>] [<c012def4>] [<c012d02c>] [<c012d077>] 
   [<c0106b73>] 

Code: 8b 01 85 45 fc 74 4d 31 c0 9c 5e fa c7 01 00 00 00 00 83 79 
 

-- 
David Fries <dfries@mail.win.org>
http://fries.net/~david/pgpkey.txt


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
