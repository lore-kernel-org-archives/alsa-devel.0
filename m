From: Olaf Hering <olh@suse.de>
Subject: 2.6.10, oops in snd_usb_audio after unplugging audio device
Date: Tue, 14 Dec 2004 22:11:16 +0100
Message-ID: <20041214211116.GA21561@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: linux-usb-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Got a soundblaster live 24bit today, it works ok with 2.6.10-rc3.

I got this crash while playing a wav file in a loop.
while true;do aplay /usr/share/sounds/alsa/test.wav;done
The volume tuner on the box does not work for some reason, it acts also
as mute button. Mute did not react anymore after a few tries, so I
unplugged it. The result was the crash below.

This is an ibook running sles9 ppc.


...
ohci_hcd 0001:10:18.0: wakeup
usb 1-1: new full speed USB device using ohci_hcd and address 4
usb 1-1: USB disconnect, address 4
ALSA /home/olaf/kernel/2610/linux-2.6.10-rc3-olh/sound/usb/usbaudio.c:687: cannot submit urb (err = -19)
ALSA /home/olaf/kernel/2610/linux-2.6.10-rc3-olh/sound/usb/usbaudio.c:795: cannot submit datapipe for urb 0, err = -19
ALSA /home/olaf/kernel/2610/linux-2.6.10-rc3-olh/sound/core/pcm_lib.c:2188: playback write error (DMA or IRQ trouble?)
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C000F748 LR: C00AB5E4 SP: C18DDD10 REGS: c18ddc60 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000000, DSISR: 40000000
TASK = e7fc14e0[3] 'events/0' THREAD: c18dc000Last syscall: 120 
GPR00: C00F0400 C18DDD10 E7FC14E0 00000000 FFFFFFFF DFE3D358 0000001A E6397858 
GPR08: 000003A8 DFE3D6D4 FFFFFFFF 00000003 357F36F0 00000000 00000000 00000000 
GPR16: 00000000 00000000 00000000 00000000 00230000 0012F000 C01C0000 E6AC46C0 
GPR24: 00000000 000003A8 E6397858 E7F2B6E4 DFE3D6CC 000000D0 00000001 E7F2B6E4 
NIP [c000f748] strlen+0x4/0x18
LR [c00ab5e4] kobject_get_path+0x28/0xc4
Call trace:
 [c00f0400] class_hotplug+0x88/0x194
 [c00abb4c] kobject_hotplug+0x1d0/0x2ac
 [c00ab010] kobject_del+0x1c/0x3c
 [c00f0a54] class_device_del+0x15c/0x1b4
 [c00f0ac4] class_device_unregister+0x18/0x30
 [c00f1048] class_simple_device_remove+0x84/0x94
 [e9938630] snd_unregister_device+0x9c/0x140 [snd]
 [e997a4a0] snd_pcm_dev_unregister+0x90/0x190 [snd_pcm]
 [e993f79c] snd_device_free+0x19c/0x1b8 [snd]
 [e993f844] snd_device_free_all+0x8c/0xd4 [snd]
 [e99394bc] snd_card_free+0xf0/0x2b0 [snd]
 [e9939918] snd_card_free_thread+0x70/0xd0 [snd]
 [c0029384] worker_thread+0x17c/0x228
 [c002e6c8] kthread+0xf0/0x12c
 [c00067f4] kernel_thread+0x44/0x60


(ibook bootet 2.6.8 for some reason after fsck ...)

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 14/900 us ( 2%), #Int=  1, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.8.1-olh ohci_hcd
S:  Product=OHCI Host Controller
S:  SerialNumber=0001:01:19.0
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c000 Rev=10.00
S:  Manufacturer=Logitech
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 36mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.8.1-olh ohci_hcd
S:  Product=OHCI Host Controller
S:  SerialNumber=0001:01:18.0
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=041e ProdID=3040 Rev= 1.00
S:  Manufacturer=Creative Technology
S:  Product=SB Live! 24-bit External
C:* #Ifs= 3 Cfg#= 1 Atr=80 MxPwr=308mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=01(audio) Sub=01 Prot=00 Driver=audio
E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=audio
I:  If#= 1 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 180 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 270 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 360 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 540 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 540 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 810 Ivl=1ms
I:  If#= 1 Alt= 7 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 192 Ivl=1ms
I:  If#= 1 Alt= 8 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 288 Ivl=1ms
I:  If#= 1 Alt= 9 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 384 Ivl=1ms
I:  If#= 1 Alt=10 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 576 Ivl=1ms
I:  If#= 1 Alt=11 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 576 Ivl=1ms
I:  If#= 1 Alt=12 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 864 Ivl=1ms
I:  If#= 1 Alt=13 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 384 Ivl=1ms
I:  If#= 1 Alt=14 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 576 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=audio
I:  If#= 2 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=82(I) Atr=0d(Isoc) MxPS= 180 Ivl=1ms
I:  If#= 2 Alt= 2 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=82(I) Atr=0d(Isoc) MxPS= 270 Ivl=1ms
I:  If#= 2 Alt= 3 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=82(I) Atr=0d(Isoc) MxPS= 196 Ivl=1ms
I:  If#= 2 Alt= 4 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=82(I) Atr=0d(Isoc) MxPS= 294 Ivl=1ms
I:  If#= 2 Alt= 5 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=82(I) Atr=0d(Isoc) MxPS= 388 Ivl=1ms
I:  If#= 2 Alt= 6 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=audio
E:  Ad=82(I) Atr=0d(Isoc) MxPS= 582 Ivl=1ms


Some data from the crash:
Module                  Size  Used by
snd_usb_audio          78592  1 
snd_pcm               124696  1 snd_usb_audio
snd_timer              29668  1 snd_pcm
snd_usb_lib            14688  1 snd_usb_audio
snd_rawmidi            30848  1 snd_usb_lib
snd_seq_device         10732  1 snd_rawmidi
snd                    77156  6 snd_usb_audio,snd_pcm,snd_timer,snd_usb_lib,snd_rawmidi,snd_seq_device
pppoe                  17024  2 
pppox                   3944  1 pppoe
ppp_generic            35284  6 pppoe,pppox
slhc                    7744  1 ppp_generic
sungem                 36488  0 
sungem_phy              9600  1 sungem
ipt_MASQUERADE          3776  1 
ipt_REJECT              8032  3 
ipt_LOG                 8256  3 
ipt_state               1888  8 
iptable_nat            27620  2 ipt_MASQUERADE
ip_conntrack           52912  3 ipt_MASQUERADE,ipt_state,iptable_nat
iptable_filter          3808  1 
ip_tables              20704  6 ipt_MASQUERADE,ipt_REJECT,ipt_LOG,ipt_state,iptable_nat,iptable_filter
nfsd                  109608  5 
exportfs                6656  1 nfsd
lockd                  73496  2 nfsd
sunrpc                173548  12 nfsd,lockd
i2c_keywest            11492  0 
soundcore              10916  1 snd
snd_page_alloc         11460  1 snd_pcm
i2c_core               26864  1 i2c_keywest
af_packet              25448  6 
usbhid                 51936  0 
ohci1394               46628  0 
ieee1394              126632  1 ohci1394
ohci_hcd               25896  0 
uninorth_agp            7872  1 
agpgart                38220  1 uninorth_agp
evdev                  11488  0 
usbcore               140112  5 snd_usb_audio,snd_usb_lib,usbhid,ohci_hcd
dm_mod                 67304  0 
unix                   31480  198 



Total memory = 640MB; using 2048kB for hash table (at c0400000)
Linux version 2.6.10-rc3-olh (olaf@ibook) (gcc-Version 3.3.3 (SuSE Linux)) #2 Sun Dec 12 16:00:41 CET 2004
Found UniNorth memory controller & host bridge, revision: 192
Mapped at 0xfdfc0000
Found a Pangea mac-io controller, rev: 0, mapped at 0xfdf40000
Processor NAP mode on idle enabled.
PowerMac motherboard: iBook 2
Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
via-pmu: Server Mode is disabled
PMU driver 2 initialized for Core99, firmware: 0c
nvram: Checking bank 0...
nvram: gen0=406, gen1=407
nvram: Active bank is: 1
nvram: OF partition at 0x410
nvram: XP partition at 0x1830
nvram: NR partition at 0x1930
On node 0 totalpages: 163840
  DMA zone: 163840 pages, LIFO batch:16
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: root=UUID=8fca6332-be54-4544-a0f7-9167378dde75 quiet 
PowerMac using OpenPIC irq controller at 0x80040000
OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at fc6ef000
OpenPIC timer frequency is 4.160000 MHz
PID hash table entries: 4096 (order: 12, 65536 bytes)
GMT Delta read from XPRAM: 0 minutes, DST: off
time_init: decrementer frequency = 24.960000 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 642944k available (1532k kernel code, 948k data, 148k init, 0k highmem)
AGP special page: 0xe7fff000
Calibrating delay loop... 1196.03 BogoMIPS (lpj=598016)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs... it is
Freeing initrd memory: 1212k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
Registering openpic with sysfs...
Thermal assist unit using timers, shrink_timer: 2000 jiffies
Registering PowerMac CPU frequency driver
Low: 400 Mhz, High: 600 Mhz, Boot: 600 Mhz
Initializing Cryptographic API
PCI: Enabling device 0000:00:10.0 (0086 -> 0087)
aty128fb: Invalid ROM signature e78e should be 0xaa55
aty128fb: BIOS not located, guessing timings.
aty128fb: Rage128 LF M3 AGP [chip rev 0x0] 8M 128-bit SDR SGRAM (1:1)
Console: switching to colour frame buffer device 128x48
Registered "ati" backlight controller, level: 15/15
fb0: ATY Rage128 frame buffer device on Rage128 LF M3 AGP
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
ttyS0 at MMIO 0x80013020 (irq = 22) is a Z85c30 ESCC - Serial port
ttyS1 at MMIO 0x80013000 (irq = 23) is a Z85c30 ESCC - Serial port
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 123456K size 1024 blocksize
MacIO PCI driver attached to Pangea chipset
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
hda: HTS548040M9AT00, ATA DISK drive
hdb: TOSHIBA DVD-ROM SD-R2002, ATAPI CD/DVD-ROM drive
hda: Enabling Ultra DMA 2
hdb: Enabling MultiWord DMA 2
elevator: using anticipatory as default io scheduler
ide0 at 0xe9006000-0xe9006007,0xe9006160 on irq 19
hda: max request size: 1024KiB
hda: 78140160 sectors (40007 MB) w/7877KiB Cache, CHS=16383/255/63, UDMA(33)
hda: cache flushes supported
 hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Freeing unused kernel memory: 148k init 4k chrp 8k prep
NET: Registered protocol family 1
device-mapper: 4.3.0-ioctl (2004-09-30) initialised: dm-devel@redhat.com
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Apple UniNorth/Pangea chipset
agpgart: Maximum main memory to use for agp memory: 565M
agpgart: configuring for size idx: 4
agpgart: AGP aperture is 16M @ 0x0
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: Enabling device 0001:10:18.0 (0000 -> 0002)
ohci_hcd 0001:10:18.0: OHCI Host Controller
ohci_hcd 0001:10:18.0: irq 27, pci mem 0x80081000
ohci_hcd 0001:10:18.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Enabling device 0001:10:19.0 (0000 -> 0002)
ohci_hcd 0001:10:19.0: OHCI Host Controller
ohci_hcd 0001:10:19.0: irq 28, pci mem 0x80080000
ohci_hcd 0001:10:19.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 2-1: new low speed USB device using ohci_hcd and address 2
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:93:85:74:cc 
PHY ID: 4061e4, addr: 0
eth0: Found BCM5221 PHY
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: Remapped memory spaces reg 0xe907c000
ohci1394: fw-host0: Soft reset finished
ohci1394: fw-host0: Iso contexts reg: 000000a8 implemented: 000000ff
ohci1394: fw-host0: 8 iso receive contexts available
ohci1394: fw-host0: Iso contexts reg: 00000098 implemented: 000000ff
ohci1394: fw-host0: 8 iso transmit contexts available
ohci1394: fw-host0: Receive DMA ctx=0 initialized
ohci1394: fw-host0: Receive DMA ctx=0 initialized
ohci1394: fw-host0: Transmit DMA ctx=0 initialized
ohci1394: fw-host0: Transmit DMA ctx=1 initialized
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max Packet=[2048]
ieee1394: CSR: setting expire to 98, HZ=1000
ohci1394: fw-host0: IntEvent: 00030010
ohci1394: fw-host0: irq_handler: Bus reset requested
ohci1394: fw-host0: Cancel request received
ohci1394: fw-host0: Got RQPkt interrupt status=0x00008409
ohci1394: fw-host0: SelfID interrupt received (phyid 0, root)
ohci1394: fw-host0: SelfID packet 0x807f8842 received
ieee1394: Including SelfID 0x807f8842
ohci1394: fw-host0: SelfID for this node is 0x807f8842
ohci1394: fw-host0: SelfID complete
ohci1394: fw-host0: PhyReqFilter=ffffffffffffffff
ieee1394: selfid_complete called with successful SelfID stage ... irm_id: 0xFFC0 node_id: 0xFFC0
ieee1394: NodeMgr: Processing host reset for knodemgrd_0
ohci1394: fw-host0: Single packet rcv'd
ohci1394: fw-host0: Got phy packet ctx=0 ... discarded
eth0: Link is up at 10 Mbps, half-duplex.
eth0: Pause is disabled
usbcore: registered new driver hiddev
input: USB HID v1.00 Mouse [Logitech] on usb-0001:10:19.0-1
usbcore: registered new driver usbhid
/home/olaf/kernel/2610/linux-2.6.10-rc3-olh/drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ieee1394: send packet local: ffc00140 ffc0ffff f0000400
ieee1394: received packet: ffc00140 ffc0ffff f0000400
ieee1394: send packet local: ffc00160 ffc00000 00000000 04042c34
ieee1394: received packet: ffc00160 ffc00000 00000000 04042c34
ieee1394: send packet local: ffc00540 ffc0ffff f0000404
ieee1394: received packet: ffc00540 ffc0ffff f0000404
ieee1394: send packet local: ffc00560 ffc00000 00000000 31333934
ieee1394: received packet: ffc00560 ffc00000 00000000 31333934
ieee1394: send packet local: ffc00940 ffc0ffff f0000408
ieee1394: received packet: ffc00940 ffc0ffff f0000408
ieee1394: send packet local: ffc00960 ffc00000 00000000 e064a232
ieee1394: received packet: ffc00960 ffc00000 00000000 e064a232
ieee1394: send packet local: ffc00d40 ffc0ffff f000040c
ieee1394: received packet: ffc00d40 ffc0ffff f000040c
ieee1394: send packet local: ffc00d60 ffc00000 00000000 000393ff
ieee1394: received packet: ffc00d60 ffc00000 00000000 000393ff
ieee1394: send packet local: ffc01140 ffc0ffff f0000410
ieee1394: received packet: ffc01140 ffc0ffff f0000410
ieee1394: send packet local: ffc01160 ffc00000 00000000 fe8574cc
ieee1394: received packet: ffc01160 ffc00000 00000000 fe8574cc
ieee1394: send packet local: ffc01550 ffc0ffff f0000400 04000000
ieee1394: received packet: ffc01550 ffc0ffff f0000400 04000000
ieee1394: send packet local: ffc01570 ffc00000 00000000 04000000
ieee1394: received packet: ffc01570 ffc00000 00000000 04000000
ieee1394: NodeMgr: raw=0xe064a232 irmc=1 cmc=1 isc=1 bmc=0 pmc=0 cyc_clk_acc=100 max_rec=2048 max_rom=1024 gen=3 lspd=2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000393fffe8574cc]
ieee1394: send packet 100: ffff0100 ffc0ffff f0000234 c000001f
ohci1394: fw-host0: Inserting packet for node 0-63:1023, tlabel=0, tcode=0x0, speed=0
ohci1394: fw-host0: Starting transmit DMA ctx=0
ohci1394: fw-host0: IntEvent: 00000001
ohci1394: fw-host0: Got reqTxComplete interrupt status=0x00008011
ohci1394: fw-host0: Packet sent to node 63 tcode=0x0 tLabel=0x00 ack=0x11 spd=0 data=0x1F0000C0 ctx=0
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
NET: Registered protocol family 17
Found KeyWest i2c on "uni-n", 2 channels, stepping: 4 bits
Found KeyWest i2c on "mac-io", 1 channel, stepping: 4 bits
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NET: Registered protocol family 24
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (5120 buckets, 40960 max) - 336 bytes per conntrack
IN=ppp0 OUT= MAC= SRC=82.80.184.26 DST=217.86.84.64 LEN=48 TOS=0x00 PREC=0x00 TTL=119 ID=11940 DF PROTO=TCP SPT=3619 DPT=445 WINDOW=64800 RES=0x00 SYN URGP=0 
...
IN=ppp0 OUT= MAC= SRC=81.240.219.37 DST=217.86.84.64 LEN=48 TOS=0x00 PREC=0x00 TTL=120 ID=40784 DF PROTO=TCP SPT=4785 DPT=6880 WINDOW=16384 RES=0x00 SYN URGP=0 
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:93:85:74:cc 
PHY ID: 4061e4, addr: 0
eth0: Found BCM5221 PHY
PHY ID: 4061e4, addr: 0
eth0: Link is up at 10 Mbps, half-duplex.
eth0: Pause is disabled
NET: Unregistered protocol family 24
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:93:85:74:cc 
PHY ID: 4061e4, addr: 0
eth0: Found BCM5221 PHY
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
NET: Registered protocol family 24
eth0: Link is up at 10 Mbps, half-duplex.
eth0: Pause is disabled
IN=ppp0 OUT= MAC= SRC=195.135.221.2 DST=80.140.182.116 LEN=60 TOS=0x00 PREC=0x00 TTL=52 ID=63993 DF PROTO=TCP SPT=60170 DPT=22 WINDOW=5840 RES=0x00 SYN URGP=0 
...
INVALID:IN=ppp0 OUT= MAC= SRC=81.10.200.130 DST=217.86.90.115 LEN=40 TOS=0x00 PREC=0x00 TTL=245 ID=31901 PROTO=TCP SPT=22657 DPT=4662 WINDOW=0 RES=0x00 RST URGP=0 
ohci_hcd 0001:10:18.0: wakeup
usb 1-1: new full speed USB device using ohci_hcd and address 2
usbcore: registered new driver snd-usb-audio
usbcore: deregistering driver snd-usb-audio
usb 1-1: USB disconnect, address 2
ohci_hcd 0001:10:18.0: wakeup
usb 1-1: new full speed USB device using ohci_hcd and address 3
usbcore: registered new driver snd-usb-audio
usb 1-1: USB disconnect, address 3
ohci_hcd 0001:10:18.0: wakeup
usb 1-1: new full speed USB device using ohci_hcd and address 4
usb 1-1: USB disconnect, address 4
ALSA /home/olaf/kernel/2610/linux-2.6.10-rc3-olh/sound/usb/usbaudio.c:687: cannot submit urb (err = -19)
ALSA /home/olaf/kernel/2610/linux-2.6.10-rc3-olh/sound/usb/usbaudio.c:795: cannot submit datapipe for urb 0, err = -19
ALSA /home/olaf/kernel/2610/linux-2.6.10-rc3-olh/sound/core/pcm_lib.c:2188: playback write error (DMA or IRQ trouble?)
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C000F748 LR: C00AB5E4 SP: C18DDD10 REGS: c18ddc60 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000000, DSISR: 40000000
TASK = e7fc14e0[3] 'events/0' THREAD: c18dc000Last syscall: 120 
GPR00: C00F0400 C18DDD10 E7FC14E0 00000000 FFFFFFFF DFE3D358 0000001A E6397858 
GPR08: 000003A8 DFE3D6D4 FFFFFFFF 00000003 357F36F0 00000000 00000000 00000000 
GPR16: 00000000 00000000 00000000 00000000 00230000 0012F000 C01C0000 E6AC46C0 
GPR24: 00000000 000003A8 E6397858 E7F2B6E4 DFE3D6CC 000000D0 00000001 E7F2B6E4 
NIP [c000f748] strlen+0x4/0x18
LR [c00ab5e4] kobject_get_path+0x28/0xc4
Call trace:
 [c00f0400] class_hotplug+0x88/0x194
 [c00abb4c] kobject_hotplug+0x1d0/0x2ac
 [c00ab010] kobject_del+0x1c/0x3c
 [c00f0a54] class_device_del+0x15c/0x1b4
 [c00f0ac4] class_device_unregister+0x18/0x30
 [c00f1048] class_simple_device_remove+0x84/0x94
 [e9938630] snd_unregister_device+0x9c/0x140 [snd]
 [e997a4a0] snd_pcm_dev_unregister+0x90/0x190 [snd_pcm]
 [e993f79c] snd_device_free+0x19c/0x1b8 [snd]
 [e993f844] snd_device_free_all+0x8c/0xd4 [snd]
 [e99394bc] snd_card_free+0xf0/0x2b0 [snd]
 [e9939918] snd_card_free_thread+0x70/0xd0 [snd]
 [c0029384] worker_thread+0x17c/0x228
 [c002e6c8] kthread+0xf0/0x12c
 [c00067f4] kernel_thread+0x44/0x60


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
