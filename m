From: "Robert Gruendler" <dobre@gmx.at>
Subject: Problems with RME Multiface on a Titanium Powerbook
Date: Wed, 29 Dec 2004 03:39:47 +0100 (MET)
Message-ID: <9581.1104287987@www21.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello list,

i'm fiddling around with my RME Hammerfall HDSP Multiface since some time
now, but i can't get this thing to work.

Using a Powerbook Titanium G4, 1GhZ, 1 GB Ram.

Running Yellowdog Linux 4.0, Kernel version 2.6.8-1.ydl.7

Desktop Using: Gnome

I've compiled alsa-driver (./configure --with-cards=hdsp
--with-sequencer=yes;make;make install), alsa-lib, alsa-utils, alsa-tools
and alsa-firmware as described on the alsa-project documentation page and in
several threads in mailinglists.


I need to run hdsploader after each restart, and i get the following output:

[root@localhost alsa]# hdsploader
hdsploader - firmware loader for RME Hammerfall DSP cards
Looking for HDSP + Multiface or Digiface cards :
Card 0 : RME Hammerfall DSP + Multiface at 0xf3000000, irq 58
Upload firmware for card hw:0
Firmware uploaded for card hw:0

I'm not sure if the last 2 lines are ok, as i think that firmware uploading
is a thing only to be done once, i may be wrong there.

After hdsploader, i can open the hdspmixer, but here my problems start:

The first 8 Physical Inputs (Analog) show a constant signal of apx. -7 db,
although nothing is connected there.

With "aplay somesound.wav", i see a signal on the 1st software channel in
the hdspmixer, but nothing comes through to the physical output channel.

"aplay somesound.wav" gives me normal terminal info and plays the file. When
i turn up the volume of the first 8 input channels, i can see an increase in
the db box of the corresponding physical output channels. The value
increases from infinite to about -84db.

Also maybe interesting: typing "amixer" in the terminal gives no output at
all, just switching to the next prompt line.


Here's what happens if i try to start jack using alsa:

[root@localhost alsa]# jackd -d alsa
jackd 0.99.0
Copyright 2001-2003 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details
                                                                            
                                                
loading driver ..
creating alsa driver ... hw:0|hw:0|1024|2|48000|0|0|nomon|swmeter|-|32bit
control device hw:0
configuring for 48000Hz, period = 1024 frames, buffer = 2 periods
Couldn't open hw:0 for 32bit samples trying 24bit instead
Couldn't open hw:0 for 24bit samples trying 16bit instead
Sorry. The audio interface "hw:0" doesn't support any of the hardware sample
formats that JACK's alsa-driver can use.
ALSA: cannot configure capture channel
cannot load driver module alsa


Here are some files and the output of terminal commands which i hope will
give the info you need.


my /etc/modprobe.conf

alias eth0 airport
alias eth1 sungem
alias snd-card-0 snd_powermac 
install snd_powermac /sbin/modprobe --ignore-install snd_powermac &&
/usr/sbin/alsactl restore >/dev/null 2>&1 || :
remove snd_powermac { /usr/sbin/alsactl store >/dev/null 2>&1 || : ; };
/sbin/modprobe -r --ignore-remove snd_powermac
alias ieee1394-controller ohci1394


# ALSA portion
alias char-major-116 snd
alias snd-card-0 snd-hdsp
alias snd-card-1 snd-powermac

# module options should go here
options snd-hdsp id="0" enable_midi="1"

# OSS/Free portion
alias char-major-14 soundcore
alias sound-slot-0 snd-hdsp
	
# card #1
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

alias sound-slot-1 snd-powermac
alias sound-service-1-0 snd-mixer-oss
alias sound-service-1-3 snd-pcm-oss
alias sound-service-1-12 snd-pcm-oss


my /root/.asoundrc


pcm.hdsp {
	type hw
	card 0
}

ctl.hdsp {
	type hw
	card 0
}

::::::::::::::::::
::terminal stuff::
::::::::::::::::::

[root@localhost alsa]# lsmod
Module                  Size  Used by
snd_pcm_oss            60712  0
snd_mixer_oss          20032  3 snd_pcm_oss
autofs4                18596  0
snd_hdsp               57688  5
snd_rawmidi            24488  1 snd_hdsp
snd_seq_device          8556  1 snd_rawmidi
snd_pcm                98840  2 snd_pcm_oss,snd_hdsp
snd_timer              23588  1 snd_pcm
snd_page_alloc          8488  2 snd_hdsp,snd_pcm
snd_hwdep               8836  1 snd_hdsp
snd                    55636  14
snd_pcm_oss,snd_mixer_oss,snd_hdsp,snd_rawmidi,snd_seq_device,snd_pcm,snd_timer,snd_hwdep
soundcore               8004  3 snd
ds                     18116  2
yenta_socket           19424  1
pcmcia_core            62388  2 ds,yenta_socket
sungem                 30756  0
sungem_phy              9120  1 sungem
airport                 5376  0
orinoco                47444  1 airport
hermes                 13632  2 airport,orinoco
ipt_REJECT              5952  1
ipt_state               1440  5
ip_conntrack           33076  1 ipt_state
iptable_filter          2144  1
ip_tables              17440  3 ipt_REJECT,ipt_state,iptable_filter
ohci1394               35460  0
ieee1394              422024  1 ohci1394
ipv6                  266924  11


[root@localhost alsa]# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.7.
Compiled on Dec 27 2004 for kernel 2.6.8-1.ydl.7.


[root@localhost alsa]# cat /proc/asound/devices
  0: [0- 0]: ctl
  4: [0- 0]: hardware dependent
  9: [0- 1]: raw midi
  8: [0- 0]: raw midi
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer


[root@localhost alsa]# cat /proc/interrupts
           CPU0
 19:      40265   OpenPIC   Level     ide0
 20:      13729   OpenPIC   Level     ide1
 25:     642380   OpenPIC   Level     VIA-PMU
 26:          0   OpenPIC   Level     keywest i2c
 27:          0   OpenPIC   Level     ohci_hcd
 28:      90854   OpenPIC   Level     ohci_hcd
 40:          2   OpenPIC   Level     ohci1394
 42:          0   OpenPIC   Level     keywest i2c
 47:      14632   OpenPIC   Level     GPIO1/ADB
 55:          0   OpenPIC   Edge      NMI - XMON
 57:      12941   OpenPIC   Level     Airport
 58:       1204   OpenPIC   Level     yenta, hdsp


[root@localhost alsa]# cat /proc/asound/cards
0 [0              ]: H-DSP - Hammerfall DSP
                     RME Hammerfall DSP + Multiface at 0xf3000000, irq 58


[root@localhost alsa]# dmesg
Total memory = 1024MB; using 2048kB for hash table (at c0600000)
Linux version 2.6.8-1.ydl.7 (root@build.terraplex.com) (gcc version 3.3.3
(Yellow Dog Linux 3.3.3-16.ydl.4)) #1 Wed Sep 22 18:46:40 EDT 2004
Found UniNorth memory controller & host bridge, revision: 17
Mapped at 0xfdeb5000
Found a Keylargo mac-io controller, rev: 3, mapped at 0xfde35000
Processor NAP mode on idle enabled.
PowerMac motherboard: PowerBook Titanium IV
via-pmu: Server Mode is disabled
PMU driver 2 initialized for Core99, firmware: 0c
Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->1
Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->1
Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->1
nvram: Checking bank 0...
nvram: gen0=1218, gen1=1219
nvram: Active bank is: 1
nvram: OF partition at 0x410
nvram: XP partition at 0x1020
nvram: NR partition at 0x1120
On node 0 totalpages: 262144
  DMA zone: 196608 pages, LIFO batch:16
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 65536 pages, LIFO batch:16
Built 1 zonelists
Kernel command line: root=/dev/hda4 ro rhgb quiet
PowerMac using OpenPIC irq controller at 0x80040000
OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at fc5e3000
OpenPIC timer frequency is 4.166666 MHz
PID hash table entries: 4096 (order 12: 32768 bytes)
GMT Delta read from XPRAM: 60 minutes, DST: off
time_init: decrementer frequency = 33.331610 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1030848k available (2988k kernel code, 1720k data, 172k init,
262144k highmem)
AGP special page: 0xeffff000
Calibrating delay loop... 665.60 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 600k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
Can't get bus-range for /pci@f2000000/cardbus@1a, assuming it starts at 0
Registering openpic with sysfs...
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Enabling device 0000:00:10.0 (0086 -> 0087)
radeonfb: Invalid ROM signature 0 should be 0xaa55
radeonfb: Retreived PLL infos from Open Firmware
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=200.00 Mhz, System=200.00
MHz
radeonfb: Monitor 1 type LCD found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
radeonfb: Power Management enabled for Mobility chipsets
Registered "ati" backlight controller, level: 15/15
radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
Thermal assist unit not available
Registering PowerMac CPU frequency driver
Low: 667 Mhz, High: 1000 Mhz, Boot: 667 Mhz
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SGI XFS with no debug enabled
Initializing Cryptographic API
Console: switching to colour frame buffer device 160x53
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Apple UniNorth 1.5 chipset
agpgart: Maximum main memory to use for agp memory: 942M
agpgart: configuring for size idx: 4
agpgart: AGP aperture is 16M @ 0x0
pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
ttyS0 at MMIO 0x80013020 (irq = 22) is a Z85c30 ESCC - Serial port
ttyS1 at MMIO 0x80013000 (irq = 23) is a Z85c30 ESCC - Serial port
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
MacIO PCI driver attached to Keylargo chipset
Can't request resource 0 for MacIO device 0.80000000:mac-io
macserial: can't request IO resource !
input: Macintosh mouse button emulation
apm_emu: APM Emulation 0.5 initialized.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
adb: starting probe task...
adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
ADB keyboard at 2, handler 1
Detected ADB keyboard, type ISO, swapping keys.
input: ADB keyboard on adb2:2.c4/input
input: ADB Powerbook buttons on adb7:7.1f/input
ADB mouse at 3, handler set to 4 (trackpad)
input: ADB mouse on adb3:3.01/input
adb: finished probe task...
ide0: Found Apple KeyLargo ATA-4 controller, bus ID 2, irq 19
Probing IDE interface ide0...
hda: TOSHIBA MK6021GAS, ATA DISK drive
ide_pmac: Set UDMA timing for mode 4, reg: 0x0c50038c
hda: Enabling Ultra DMA 4
Using anticipatory io scheduler
ide0 at 0xf215f000-0xf215f007,0xf215f160 on irq 19
ide1: Found Apple KeyLargo ATA-3 controller, bus ID 0, irq 20
Probing IDE interface ide1...
hdc: MATSHITADVD-R UJ-815, ATAPI CD/DVD-ROM drive
hdc: MDMA, cycleTime: 120, accessTime: 90, recTime: 30
hdc: Set MDMA timing for mode 2, reg: 0x00011d26
hdc: Enabling MultiWord DMA 2
ide1 at 0xf2164000-0xf2164007,0xf2164160 on irq 20
hda: max request size: 128KiB
hda: 117210240 sectors (60011 MB), CHS=65535/16/63, UDMA(66)
 hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9
hdc: ATAPI 31X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
mesh: configured for synchronous 5 MB/s
libata version 1.02 loaded.
st: Version 20040403, fixed bufsize 32768, s/g segs 256
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
PCI: Enabling device 0001:10:18.0 (0000 -> 0002)
ohci_hcd 0001:10:18.0: Apple Computer Inc. KeyLargo USB
ohci_hcd 0001:10:18.0: irq 27, pci mem f2169000
ohci_hcd 0001:10:18.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Enabling device 0001:10:19.0 (0000 -> 0002)
ohci_hcd 0001:10:19.0: Apple Computer Inc. KeyLargo USB (#2)
ohci_hcd 0001:10:19.0: irq 28, pci mem f216b000
ohci_hcd 0001:10:19.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
Found KeyWest i2c on "uni-n", 2 channels, stepping: 4 bits
Found KeyWest i2c on "mac-io", 1 channel, stepping: 4 bits
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
RAMDISK: Compressed image found at block 0
RAMDISK: incomplete write (-28 != 32768) 4194304
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 172k init 4k chrp 8k prep
usb 2-1: new low speed USB device using address 2
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with
IntelliEye(TM)] on usb-0001:10:19.0-1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
EXT3 FS on hda4, internal journal
Adding 2047744k swap on /dev/hda6.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff] 
Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000393fffecc723c]
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
airport.c 0.13e (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
Airport at physical address 80030000
eth0: Station identity 001f:0001:0008:0046
eth0: Looks like a Lucent/Agere firmware version 8.70
eth0: Ad-hoc demo mode supported
eth0: IEEE standard IBSS ad-hoc mode supported
eth0: WEP supported, 104-bit key
eth0: MAC address 00:30:65:28:BC:D5
eth0: Station name "HERMES I"
eth0: ready
airport: card registered for interface eth0
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
eth1: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:93:cc:72:3c
PHY ID: 2060e1, addr: 0
eth1: Found BCM5421 PHY
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 296 bytes per conntrack
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
airport.c 0.13e (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
Airport at physical address 80030000
eth0: Station identity 001f:0001:0008:0046
eth0: Looks like a Lucent/Agere firmware version 8.70
eth0: Ad-hoc demo mode supported
eth0: IEEE standard IBSS ad-hoc mode supported
eth0: WEP supported, 104-bit key
eth0: MAC address 00:30:65:28:BC:D5
eth0: Station name "HERMES I"
eth0: ready
airport: card registered for interface eth0
eth0: New link status: Connected (0001)
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
eth1: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:93:cc:72:3c
PHY ID: 2060e1, addr: 0
eth1: Found BCM5421 PHY
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0001:10:1a.0 [0000:0000]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0001:10:1a.0, mfunc 0x00000002, devctl 0x60
Yenta: ISA IRQ mask 0x0000, PCI irq 58
Socket status: 30000069
snd_hdsp: Unknown parameter `enable_midi'
PCI: Enabling device 0001:11:00.0 (0080 -> 0082)
ALSA /alsa/alsa-driver-1.0.7/alsa-kernel/pci/rme9652/hdsp.c:639:
Hammerfall-DSP: no Digiface or Multiface connected!
ALSA /alsa/alsa-driver-1.0.7/alsa-kernel/pci/rme9652/hdsp.c:4993: card
initialization pending : waiting for firmware
eth0: no IPv6 routers present
ALSA /alsa/alsa-driver-1.0.7/alsa-kernel/pci/rme9652/hdsp.c:4664:
initializing firmware upload
ALSA /alsa/alsa-driver-1.0.7/alsa-kernel/pci/rme9652/hdsp.c:4664:
initializing firmware upload
ALSA /alsa/alsa-driver-1.0.7/alsa-kernel/pci/rme9652/hdsp.c:696: firmware
loaded from cache, restoring defaults


Sorry for the long message, but i thought i'll give all important info.

I'd really be glad for some hints on how to get this card working.

Thanks for your time.


Best Regards,

Robert

-- 
+++ Sparen Sie mit GMX DSL +++ http://www.gmx.net/de/go/dsl
AKTION für Wechsler: DSL-Tarife ab 3,99 EUR/Monat + Startguthaben


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
