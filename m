From: Olaf Hering <olaf@aepfle.de>
Subject: control.c: BUG info->access == 0
Date: Thu, 21 Sep 2006 22:48:04 +0200
Message-ID: <20060921204804.GA20477@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from natreg.rzone.de (natreg.rzone.de [81.169.145.183])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D7B501A9
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Sep 2006 22:48:07 +0200 (MEST)
Received: from ibook.aepfle.de (p5493EE14.dip.t-dialin.net [84.147.238.20])
	by post.webmailer.de (8.13.6/8.13.6) with ESMTP id k8LKm5i9003019
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Sep 2006 22:48:06 +0200 (MEST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


I get this on an unconfigured G5 (PowerMac11,2) during boot:

ALSA sound/core/control.c:660: BUG? (info->access == 0)
Call Trace:
[C00000007B0C3B60] [C00000000000F5E8] .show_stack+0x68/0x1b0 (unreliable)
[C00000007B0C3C00] [D00000000013AB9C] .snd_ctl_elem_info+0xd0/0x1d8 [snd]
[C00000007B0C3CB0] [D00000000013CCA0] .snd_ctl_ioctl_compat+0x2c8/0x638 [snd]
[C00000007B0C3D70] [C0000000001160F4] .compat_sys_ioctl+0x158/0x3b4
[C00000007B0C3E30] [C00000000000871C] syscall_exit+0x0/0x40

system is a 10.2alpha4plus, installed with rpm -Uvh */{xine,and,required,rpms}.rpm

Module                  Size  Used by
ipv6                  465176  12 
snd_pcm_oss            92120  0 
snd_mixer_oss          44296  1 snd_pcm_oss
snd_seq               113152  0 
snd_seq_device         29928  1 snd_seq
loop                   41512  0 
sbp2                   47352  0 
snd_aoa_codec_onyx     36880  2 
snd_aoa_fabric_layout    34800  0 
snd_aoa                43608  2 snd_aoa_codec_onyx,snd_aoa_fabric_layout
ohci1394               68856  1 
ide_cd                 73472  0 
snd_aoa_i2sbus         47708  1 
snd_aoa_soundbus       26988  2 snd_aoa_fabric_layout,snd_aoa_i2sbus
snd_pcm               151108  2 snd_pcm_oss,snd_aoa_i2sbus
snd_page_alloc         31704  1 snd_pcm
ieee1394              165456  2 sbp2,ohci1394
snd_timer              55648  2 snd_seq,snd_pcm
snd                   115488  10 snd_pcm_oss,snd_mixer_oss,snd_seq,snd_seq_device,snd_aoa_codec_onyx,snd_aoa_fabric_layout,snd_aoa,snd_aoa_i2sbus,snd_pcm,snd_timer
cdrom                  64656  1 ide_cd
soundcore              31216  1 snd
tg3                   160596  0 
xfs                   707000  1 
sg                     69048  0 
sata_svw               30716  1 
libata                168744  1 sata_svw
sd_mod                 46032  2 
scsi_mod              221104  4 sbp2,sg,libata,sd_mod

DART table allocated at: c00000007f000000
Using PowerMac machine description
Page orders: linear mapping = 24, virtual = 12, io = 12
Found initrd at 0xc000000001300000:0xc000000001550ccf
Found U4 memory controller & host bridge @ 0xf8000000 revision: 0x42
Mapped at 0xd000080080000000
Found a Shasta mac-io controller, rev: 0, mapped at 0xd000080080041000
PowerMac motherboard: PowerMac G5 Dual Core
DART IOMMU initialized for U4 type chipset
Starting Linux PPC64 #1 SMP Thu Sep 21 16:31:16 UTC 2006
-----------------------------------------------------
ppc64_pft_size                = 0x0
physicalMemorySize            = 0x80000000
ppc64_caches.dcache_line_size = 0x80
ppc64_caches.icache_line_size = 0x80
htab_address                  = 0xc00000007c000000
htab_hash_mask                = 0x3ffff
-----------------------------------------------------
Linux version 2.6.18-20060921163116-ppc64 (geeko@buildhost) (gcc version 4.1.2 20060913 (prerelease) (SUSE Linux)) #1 SMP Thu Sep 21 16:31:16 UTC 2006
[boot]0012 Setup Arch
Top of RAM: 0x80000000, Total RAM: 0x80000000
Memory hole size: 0MB
Found U4-PCIE PCI host bridge.  Firmware bus number: 0->255
Can't get bus-range for /ht@0,f2000000, assume bus 0
Found U3-HT PCI host bridge.  Firmware bus number: 0->-1
PCI Host 0, io start: 400000; io end: bfffff
PCI Host 1, io start: 0; io end: 3fffff
SMU driver 0.7 (c) 2005 Benjamin Herrenschmidt, IBM Corp.
nvram: Checking bank 0...
nvram: gen0=152, gen1=151
nvram: Active bank is: 0
nvram: OF partition at 0x410
nvram: XP partition at 0x1020
nvram: NR partition at 0x1120
On node 0 totalpages: 524288
  DMA zone: 524288 pages, LIFO batch:31
[boot]0015 Setup Done
Built 1 zonelists.  Total pages: 524288
Kernel command line: root=LABEL=test
mpic: Setting up MPIC " MPIC 1   " version 1.2 at f8040000, max 4 CPUs
mpic: ISU size: 124, shift: 7, mask: 7f
mpic: Initializing for 124 sources
mpic: Setting up HT PICs workarounds for U3/U4
mpic:   - HT:07.0 [0x90] vendor 106b device 0053 has 86 irqs
PID hash table entries: 4096 (order: 12, 32768 bytes)
time_init: decrementer frequency = 33.333333 MHz
time_init: processor frequency   = 2300.000000 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
freeing bootmem node 0
Memory: 2006048k/2097152k available (4488k kernel code, 91104k reserved, 1856k data, 836k bss, 256k init)
Calibrating delay loop... 66.56 BogoMIPS (lpj=332800)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 256
device-tree: Duplicate name in /ht@0,f2000000/pci@8/mac-io@7/i2c@18000, renamed to "i2c-bus@0#1"
checking if image is initramfs... it is
Freeing initrd memory: 2371k freed
PowerMac SMP probe found 2 cpus
KeyWest i2c @0xf8001003 irq 16 /u4@0,f8000000/i2c@f8001000
 channel 1 bus /u4@0,f8000000/i2c@f8001000/i2c-bus@1
KeyWest i2c @0x80018000 irq 27 /ht@0,f2000000/pci@8/mac-io@7/i2c@18000
 channel 0 bus /ht@0,f2000000/pci@8/mac-io@7/i2c@18000/i2c-bus@0
 channel 0 bus /ht@0,f2000000/pci@8/mac-io@7/i2c@18000/i2c-bus@0
SMU i2c /smu@0,0/smu-i2c-control@0
 channel b bus /smu@0,0/smu-i2c-control@0/i2c-bus@b
 channel e bus /smu@0,0/smu-i2c-control@0/i2c-bus@e
Processor timebase sync using platform function
mpic: requesting IPIs ... 
Processor 1 found.
Brought up 2 CPUs
migration_cost=1032
NET: Registered protocol family 16
PCI: Probing PCI hardware
IOMMU table initialized, virtual merging enabled
Can't get ranges for PCI-PCI bridge /ht@0,f2000000/pci@1
Can't get ranges for PCI-PCI bridge /ht@0,f2000000/pci@3
Can't get ranges for PCI-PCI bridge /ht@0,f2000000/pci@4
Can't get ranges for PCI-PCI bridge /ht@0,f2000000/pci@5
Can't get ranges for PCI-PCI bridge /ht@0,f2000000/pci@6
mapping IO f0000000 -> d000080000400000, size: 800000
mapping IO f4000000 -> d000080000000000, size: 400000
PCI: Probing PCI hardware done
Registering pmac pic with sysfs...
usbcore: registered new driver usbfs
usbcore: registered new driver hub
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
rtas_flash: no firmware flash support
IBM eBus Device Driver
nvram_init: Could not find nvram partition for nvram buffered error logging.
Registering G5 CPU frequency driver
Frequency method: SCOM, Voltage method: GPIO
Low: 1150 Mhz, High: 2300 Mhz, Cur: 2300 MHz
audit: initializing netlink socket (disabled)
audit(1158871126.719:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pcie_portdrv_probe->Dev[005b:106b] has invalid IRQ. Check vendor BIOS
Allocate Port Service[0000:00:0b.0:pcie00]
Allocate Port Service[0000:00:0b.0:pcie01]
pcie_portdrv_probe->Dev[0132:1166] has invalid IRQ. Check vendor BIOS
pcie_portdrv_probe->Dev[0132:1166] has invalid IRQ. Check vendor BIOS
pcie_portdrv_probe->Dev[0132:1166] has invalid IRQ. Check vendor BIOS
pcie_portdrv_probe->Dev[0132:1166] has invalid IRQ. Check vendor BIOS
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
rpadlpar_io_init: partition not DLPAR capable
nvidiafb: Device ID: 10de0141 
nvidiafb: CRTC0 analog found
nvidiafb: CRTC1 analog found
nvidiafb: Found OF EDID for head 1
nvidiafb: EDID found from BUS1
nvidiafb: EDID found from BUS2
nvidiafb: CRTC 0 appears to have a CRT attached
nvidiafb: Using CRT on CRTC 0
Console: switching to colour frame buffer device 100x37
nvidiafb: PCI nVidia NV14 framebuffer (64MB @ 0x90000000)
vio_register_driver: driver hvc_console registering
HVSI: registered 0 devices
Generic RTC Driver v1.07
pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
ttyS0 at MMIO 0x80013020 (irq = 23) is a Z85c30 ESCC - Serial port
ttyS1 at MMIO 0x80013000 (irq = 24) is a Z85c30 ESCC - Serial port
RAMDISK driver initialized: 16 RAM disks of 123456K size 1024 blocksize
MacIO PCI driver attached to Shasta chipset
input: Macintosh mouse button emulation as /class/input/input0
Warning: no ADB interface detected
windfarm: initializing for dual-core desktop G5
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI: Enabling device: (0001:03:0d.0), cmd 6
ide0: Found Apple Shasta ATA-6 controller, bus ID 3, irq 38
Probing IDE interface ide0...
hda: HL-DT-ST DVD-RW GWA-4165B, ATAPI CD/DVD-ROM drive
hda: Enabling Ultra DMA 4
ide0 at 0xd0000800873b0000-0xd0000800873b0007,0xd0000800873b0160 on irq 38
PCI: Enabling device: (0001:01:0b.2), cmd 6
ehci_hcd 0001:01:0b.2: EHCI Host Controller
ehci_hcd 0001:01:0b.2: new USB bus registered, assigned bus number 1
ehci_hcd 0001:01:0b.2: irq 70, io mem 0x80080000
ehci_hcd 0001:01:0b.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.18-20060921163116-ppc64 ehci_hcd
usb usb1: SerialNumber: 0001:01:0b.2
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: Enabling device: (0001:01:0b.0), cmd 2
ohci_hcd 0001:01:0b.0: OHCI Host Controller
ohci_hcd 0001:01:0b.0: new USB bus registered, assigned bus number 2
ohci_hcd 0001:01:0b.0: irq 70, io mem 0x80082000
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.18-20060921163116-ppc64 ohci_hcd
usb usb2: SerialNumber: 0001:01:0b.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
PCI: Enabling device: (0001:01:0b.1), cmd 2
ohci_hcd 0001:01:0b.1: OHCI Host Controller
ohci_hcd 0001:01:0b.1: new USB bus registered, assigned bus number 3
ohci_hcd 0001:01:0b.1: irq 70, io mem 0x80081000
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: OHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.18-20060921163116-ppc64 ohci_hcd
usb usb3: SerialNumber: 0001:01:0b.1
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
PowerMac i2c bus smu 14 registered
wf_sat: creating sat at address b0
PowerMac i2c bus smu 11 registered
windfarm: CPUs control loops started.
PowerMac i2c bus mac-io 0 registered
PowerMac i2c bus mac-io 0 registered
found max6690, loc=BACKSIDE addr=0x98
found max6690, loc=TUNNEL addr=0x9c
PowerMac i2c bus u4 1 registered
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
oprofile: using ppc64/970 performance monitoring.
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Freeing unused kernel memory: 256k freed
usb 3-1: new full speed USB device using ohci_hcd and address 2
sat 0 partition c8: c8 6 2 7f ff 2 ff 1 fb bf 0 41 0 20 0 0 0 7 89 37 0 a0 0 0
usb 3-1: new device found, idVendor=05ac, idProduct=1003
usb 3-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 3-1: Product: Hub in Apple Extended USB Keyboard
usb 3-1: Manufacturer: Mitsumi Electric
usb 3-1: configuration #1 chosen from 1 choice
hub 3-1:1.0: USB hub found
hub 3-1:1.0: 3 ports detected
usb 3-1.2: new low speed USB device using ohci_hcd and address 3
sat 0 partition c4: c4 4 1 7f 22 11 e0 e6 ff 55 7b 12 ec 11 0 0
SCSI subsystem initialized
libata version 2.00 loaded.
usb 3-1.2: new device found, idVendor=05ac, idProduct=0304
usb 3-1.2: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 3-1.2: Product: Apple Optical USB Mouse
usb 3-1.2: Manufacturer: Mitsumi Electric
usb 3-1.2: configuration #1 chosen from 1 choice
sata_svw 0001:03:0c.0: version 2.0
ata1: SATA max UDMA/133 cmd 0xD0000800873B5000 ctl 0xD0000800873B5020 bmdma 0xD0000800873B5030 irq 18
ata2: SATA max UDMA/133 cmd 0xD0000800873B5100 ctl 0xD0000800873B5120 bmdma 0xD0000800873B5130 irq 18
ata3: SATA max UDMA/133 cmd 0xD0000800873B5200 ctl 0xD0000800873B5220 bmdma 0xD0000800873B5230 irq 18
input: Mitsumi Electric Apple Optical USB Mouse as /class/input/input1
input: USB HID v1.10 Mouse [Mitsumi Electric Apple Optical USB Mouse] on usb-0001:01:0b.1-1.2
ata4: SATA max UDMA/133 cmd 0xD0000800873B5300 ctl 0xD0000800873B5320 bmdma 0xD0000800873B5330 irq 18
scsi0 : sata_svw
usb 3-1.3: new full speed USB device using ohci_hcd and address 4
usb 3-1.3: new device found, idVendor=05ac, idProduct=020b
usb 3-1.3: new device strings: Mfr=1, Product=3, SerialNumber=0
usb 3-1.3: Product: Apple Extended USB Keyboard
usb 3-1.3: Manufacturer: Mitsumi Electric
usb 3-1.3: configuration #1 chosen from 1 choice
input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input2
input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:01:0b.1-1.3
input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input3
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:01:0b.1-1.3
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 
ata1.00: ata1: dev 0 multi count 0
ata1.00: configured for UDMA/133
scsi1 : sata_svw
sat 0 partition c9: c9 6 2 7f ff 2 ff 1 fb bf 0 41 0 20 0 0 0 7 89 37 0 a0 0 0
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7, max UDMA/133, 490234752 sectors: LBA48 NCQ (depth 0/32)
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
scsi2 : sata_svw
ata3: SATA link down (SStatus 0 SControl 0)
scsi3 : sata_svw
sat 0 partition c5: c5 4 1 7f 22 11 e0 e6 ff 55 7b 12 ec 11 0 0
ata4: SATA link down (SStatus 0 SControl 0)
  Vendor: ATA       Model: WDC WD2500JS-41M  Rev: 10.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: [mac] sda1 sda2 sda3 sda4 sda5 sda6 sda7
sd 0:0:0:0: Attached scsi disk sda
  Vendor: ATA       Model: Maxtor 6V250F0    Rev: VA11
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb:<5>sd 0:0:0:0: Attached scsi generic sg0 type 0
 [mac] sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 sdb11 sdb12
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
windfarm: Backside control loop started.
windfarm: Slots control loop started.
windfarm: Drive bay control loop started.
SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem sdb11
Ending clean XFS mount for filesystem: sdb11
tg3.c:v3.65 (August 07, 2006)
eth0: Tigon3 [partno(BCM95780) rev 8003 PHY(5780)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:14:51:68:b7:00
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[76144000] dma_mask[40-bit]
eth1: Tigon3 [partno(BCM95780) rev 8003 PHY(5780)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:14:51:68:b7:01
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth1: dma_rwctrl[76144000] dma_mask[40-bit]
ieee1394: Initialized config rom entry `ip1394'
snd_aoa_soundbus: module not supported by Novell, setting U taint flag.
snd_aoa_i2sbus: module not supported by Novell, setting U taint flag.
hda: ATAPI 32X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
PCI: Enabling device: (0001:03:0e.0), cmd 2
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[39]  MMIO=[fa400000-fa4007ff]  Max Packet=[4096]  IR/IT contexts=[8/8]
snd_aoa: module not supported by Novell, setting U taint flag.
snd_aoa_fabric_layout: module not supported by Novell, setting U taint flag.
snd-aoa-fabric-layout: found bus with layout 68
snd-aoa-fabric-layout: Using PMF GPIOs
snd_aoa_codec_onyx: module not supported by Novell, setting U taint flag.
snd-aoa-codec-onyx: found pcm3052
snd-aoa-fabric-layout: platform-onyx-codec-ref doesn't match!
snd-aoa: fabric didn't like codec onyx
snd-aoa-codec-onyx: found pcm3052
snd-aoa-fabric-layout: can use this codec
snd-aoa-codec-onyx: attached to onyx codec via i2c
snd-aoa-codec-onyx: created and attached onyx instance
ALSA sound/core/control.c:660: BUG? (info->access == 0)
Call Trace:
[C00000007B0C3B60] [C00000000000F5E8] .show_stack+0x68/0x1b0 (unreliable)
[C00000007B0C3C00] [D00000000013AB9C] .snd_ctl_elem_info+0xd0/0x1d8 [snd]
[C00000007B0C3CB0] [D00000000013CCA0] .snd_ctl_ioctl_compat+0x2c8/0x638 [snd]
[C00000007B0C3D70] [C0000000001160F4] .compat_sys_ioctl+0x158/0x3b4
[C00000007B0C3E30] [C00000000000871C] syscall_exit+0x0/0x40
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0010b92100519fad]
ieee1394: Host added: ID:BUS[0-02:1023]  GUID[001451fffea8daae]
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
scsi4 : SBP-2 IEEE-1394
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
  Vendor: Maxtor    Model: OneTouch II       Rev: 023g
  Type:   Direct-Access                      ANSI SCSI revision: 04
SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 32 00 00
sdc: cache data unavailable
sdc: assuming drive cache: write through
SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 32 00 00
sdc: cache data unavailable
sdc: assuming drive cache: write through
 sdc: [mac] sdc1 sdc2 sdc3 sdc4 sdc5 sdc6 sdc7 sdc8 sdc9 sdc10 sdc11
sd 4:0:1:0: Attached scsi disk sdc
sd 4:0:1:0: Attached scsi generic sg2 type 0
loop: loaded (max 8 devices)
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
