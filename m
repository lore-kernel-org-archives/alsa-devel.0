From: Jaakko =?iso-8859-15?q?Pr=E4tt=E4l=E4?=
	<Jaakko.Prattala@Helsinki.FI>
Subject: Re: hdsp I/O-error
Date: Fri, 11 Apr 2003 21:50:11 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304112150.11818.Jaakko.Prattala@Helsinki.FI>
References: <200304112048.38744.Jaakko.Prattala@Helsinki.FI> <1050086275.1337.37.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1050086275.1337.37.camel@satellite.undata.org>
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

On Friday 11 April 2003 21:37, Thomas Charbonnel wrote:
> > Hi. I'm having problems with my multiface+cardbus.
> > I've tested the card in windows and it works.
> > I just updated the firmware from rev 5 to 11, but the problem persist=
s.
> >
> > If I don't load the firmware in windows, hdsploader goes:
> > hdsploader - firmware loader for RME Hammerfall DSP cards
> > Looking for HDSP + Multiface or Digiface cards :
> > Card 0 : RME Hammerfall DSP at 0x10800000, irq 11
> > Upload firmware for card hw:0
> > Hwdep ioctl error on card hw:0 : Input/output error.
> >
> > If I boot to windows and then back, hdsploader looks
> > ok but pd says:
> > ALSA lib pcm_hw.c:325:(snd_pcm_hw_hw_params)
> > SNDRV_PCM_IOCTL_HW_PARAMS failed: Device or resource busy
> > and jack hangs after "creating alsa driver ...
> > hdsp|1024|2|48000|swmon|rt"
> >
> > I'm using alsa cvs from ~2 hours ago, rhl8.0 stock kernel (2.4.18-14)
> > and the usual rhl8.0 pcmcia setup (I don't know what that actually is=
,
> > there's a separate package called kernel-pcmcia-cs-3.1.31-9 that I ha=
ve
> > installed with rhl).
>
> Could you please send the output of dmesg ?
> Did alsactl tried to restore old settings ?
>
> Thomas

Should it? I have to load snd-hdsp manually when I haven't
loaded the firmware in windows btw.

Here's the dmesg after a boot without windows firmware loading:

Linux version 2.4.18-14 (bhcompile@stripples.devel.redhat.com) (gcc versi=
on=20
3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 Wed Sep 4 13:35:50 EDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eef0000 (usable)
 BIOS-e820: 000000000eef0000 - 000000000eefc000 (ACPI data)
 BIOS-e820: 000000000eefc000 - 000000000ef00000 (ACPI NVS)
 BIOS-e820: 000000000ef00000 - 000000000f000000 (usable)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
240MB LOWMEM available.
On node 0 totalpages: 61440
zone(0): 4096 pages.
zone(1): 57344 pages.
zone(2): 0 pages.
Kernel command line: ro root=3DLABEL=3D/ hdc=3Dide-scsi
ide_setup: hdc=3Dide-scsi
Initializing CPU#0
Detected 1202.837 MHz processor.
Speakup v-1.00 CVS: Tue Jun 11 14:22:53 EDT 2002 : initialized
Console: colour VGA+ 80x25
Calibrating delay loop... 2375.92 BogoMIPS
Memory: 236964k/245760k available (1326k kernel code, 6424k reserved, 999=
k=20
data, 212k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 4096 (order: 3, 32768 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=3D29860 max_file_pages=3D0 max_inodes=3D0 max_dentries=3D=
29860
Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
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
PCI: PCI BIOS revision 2.10 entry at 0xfd821, last bus=3D2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/8231] at 00:11.0
PCI: Found IRQ 10 for device 00:11.6
PCI: Sharing IRQ 10 with 00:11.5
PCI: Via IRQ fixup for 00:11.6, from 255 to 10
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
speakup:  initialized device: /dev/synth, node (MAJOR 10, MINOR 25)
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_=
IRQ=20
SERIAL_PCI ISAPNP enabled
ttyS0 at 0x03f8 (irq =3D 4) is a 16550A
Real Time Clock Driver v1.10e
oprofile: mapping APIC.
oprofile: no local P6 APIC. Falling back to RTC mode.
Your CPU does not have a local APIC, e.g. mobile P6. Falling back to RTC =
mode.
oprofile: can't get RTC I/O Ports
block: 448 slots per queue, batch=3D112
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
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
hda: 58605120 sectors (30006 MB) w/1768KiB Cache, CHS=3D3648/255/63, UDMA=
(100)
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 126k freed
VFS: Mounted root (ext2 filesystem).
Journalled Block Device driver loaded
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 212k freed
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 13:44:31 Sep  4 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 9 for device 00:11.2
usb-uhci.c: USB UHCI at I/O 0x1020, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.18, 14 May 2002 on ide0(3,5), internal journal
Adding Swap: 489940k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.18, 14 May 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: QSI       Model: DVD/CDRW SBW-161  Rev: SX09
  Type:   CD-ROM                             ANSI SCSI revision: 02

--=20
Jaakko Pr=E4tt=E4l=E4
Jaakko.Prattala@Helsinki.FI



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
