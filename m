From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] XMOS UAC2
Date: Thu, 09 Aug 2012 22:32:24 +0200
Message-ID: <50241E58.8020408@gmail.com>
References: <50241074.8050001@freemail.gr> <5024135E.3000900@gmail.com> <502416B5.80903@freemail.gr> <50241B0B.1050301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1253
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50241B0B.1050301-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "adelias-Y8qEzhMunLxMo1R+fwTmgw@public.gmane.org" <adelias-Y8qEzhMunLxMo1R+fwTmgw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 09.08.2012 22:18, Daniel Mack wrote:
> (Cc linux-usb)
>=20
> On 09.08.2012 21:59, adelias-Y8qEzhMunLxMo1R+fwTmgw@public.gmane.org wrote:
>> I've attached the dmesg of each.
>>
>> On 9/8/2012 10:45 =EC=EC, Daniel Mack wrote:
>>>> On 09.08.2012 21:33, adelias wrote:
>>>>>> I have an XMOS Reference board with the latest firmware (v3.3). =
With
>>>>>> ALSA 1.0.23 it enumerates and functions properly. With ALSA 1.0.=
25 it
>>>>>> appears to enumerate properly after boot up but will not output =
sound.
>>>>>> Removing and reinserting snd-usb-audio with modprobe doesn't hel=
p. Only
>>>>>> after I reset it by unpluging and repluging the usb cable will i=
t
>>>>>> function as it should.
>>>>
>>>> Could you provide the full boot logs of both scenarios please?
>>
>> dmesg.1.0.24
>=20
> Thanks. To summarize, you're not only using two different versions of
> ALSA but two versions of the kernel (2.6.37 vs 3.0.36+), and the prob=
lem
> is not caused by ALSA but by the USB host controller driver (see belo=
w).

Hmm, after I had a second look, it might be this is unrelated, as the
actual sound device probe happens long after that warning. Still, that
type of atomic warning is suspicious and could bring the host controlle=
r
driver in a bogus state.

Please tell us if that also happens on 3.5.


Thanks,
Daniel

>> [    0.000000] Initializing cgroup subsys cpuset
>> [    0.000000] Initializing cgroup subsys cpu
>> [    0.000000] Linux version 3.0.36+ (gnexus-pWUzPmDh5QVg9hUCZPvPmw@public.gmane.org) (gcc vers=
ion 4.6.1 (Sourcery CodeBench Lite 2011.09-70) ) #34 PREEMPT Sat Jul 21=
 11:34:33 IST 2012
>> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), c=
r=3D10c5387d
>> [    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instr=
uction cache
>> [    0.000000] Machine: sun4i
>> [    0.000000] Total Detected Memory: 512MB with 1 banks
>> [    0.000000] Ignoring unrecognised tag 0x00000000
>> [    0.000000] Memory Reserved(in bytes):
>> [    0.000000] 	SYS: 0x43000000, 0x00010000
>> [    0.000000] 	LCD: 0x5a000000, 0x02000000
>> [    0.000000] 	G2D: 0x58000000, 0x01000000
>> [    0.000000] 	VE : 0x44000000, 0x05000000
>> [    0.000000] Memory policy: ECC disabled, Data cache writeback
>> [    0.000000] On node 0 totalpages: 114688
>> [    0.000000] free_area_init_node: node 0, pgdat c054f6bc, node_mem=
_map c0604000
>> [    0.000000]   Normal zone: 896 pages used for memmap
>> [    0.000000]   Normal zone: 0 pages reserved
>> [    0.000000]   Normal zone: 113792 pages, LIFO batch:31
>> [    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
>> [    0.000000] pcpu-alloc: [0] 0=20
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on=
=2E  Total pages: 113792
>> [    0.000000] Kernel command line: console=3DttyS0,115200 root=3D/d=
ev/mmcblk0p2 init=3D/init loglevel=3D8 rootfstype=3Dext4 rootwait
>> [    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
>> [    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262=
144 bytes)
>> [    0.000000] Inode-cache hash table entries: 32768 (order: 5, 1310=
72 bytes)
>> [    0.000000] allocated 1835008 bytes of page_cgroup
>> [    0.000000] please try 'cgroup_disable=3Dmemory' option if you do=
n't want memory cgroups
>> [    0.000000] Memory: 448MB =3D 448MB total
>> [    0.000000] Memory: 315636k/315636k available, 143116k reserved, =
0K highmem
>> [    0.000000] Virtual kernel memory layout:
>> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>> [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>> [    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
>> [    0.000000]     vmalloc : 0xdc800000 - 0xf0000000   ( 312 MB)
>> [    0.000000]     lowmem  : 0xc0000000 - 0xdc000000   ( 448 MB)
>> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
>> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
>> [    0.000000]       .init : 0xc0008000 - 0xc002c000   ( 144 kB)
>> [    0.000000]       .text : 0xc002c000 - 0xc0517850   (5039 kB)
>> [    0.000000]       .data : 0xc0518000 - 0xc0550040   ( 225 kB)
>> [    0.000000]        .bss : 0xc0550064 - 0xc0603630   ( 718 kB)
>> [    0.000000] SLUB: Genslabs=3D11, HWalign=3D64, Order=3D0-3, MinOb=
jects=3D0, CPUs=3D1, Nodes=3D1
>> [    0.000000] NR_IRQS:96 nr_irqs:96 96
>> [    0.000000] timer0: Periodic Mode
>> [    0.000000] Console: colour dummy device 80x30
>> [    0.000000] Calibrating delay loop... 1001.88 BogoMIPS (lpj=3D500=
9408)
>> [    0.040000] pid_max: default: 32768 minimum: 301
>> [    0.040000] Security Framework initialized
>> [    0.040000] Mount-cache hash table entries: 512
>> [    0.050000] Initializing cgroup subsys cpuacct
>> [    0.050000] Initializing cgroup subsys memory
>> [    0.060000] Initializing cgroup subsys devices
>> [    0.060000] Initializing cgroup subsys freezer
>> [    0.060000] Initializing cgroup subsys blkio
>> [    0.070000] Initializing cgroup subsys perf_event
>> [    0.070000] CPU: Testing write buffer coherency: ok
>> [    0.070000] hw perfevents: enabled with ARMv7 Cortex-A8 PMU drive=
r, 5 counters available
>> [    0.080000] devtmpfs: initialized
>> [    0.080000] print_constraints: dummy:=20
>> [    0.090000] NET: Registered protocol family 16
>> [    0.090000] hw-breakpoint: debug architecture 0x4 unsupported.
>> [    0.100000] SOFTWINNER DMA Driver, (c) 2003-2004,2006 Simtec Elec=
tronics
>> [    0.100000] Initialize DMAC OK
>> [    0.100000] bio: create slab <bio-0> at 0
>> [    0.110000] SCSI subsystem initialized
>> [    0.110000] usbcore: registered new interface driver usbfs
>> [    0.120000] usbcore: registered new interface driver hub
>> [    0.120000] usbcore: registered new device driver usb
>> [    0.120000] Advanced Linux Sound Architecture Driver Version 1.0.=
24.
>> [    0.130000] Init eGon pin module V2.0
>> [    0.130000] Switching to clocksource aw 64bits couter
>> [    0.140000] FS-Cache: Loaded
>> [    0.140000] CacheFiles: Loaded
>> [    0.150000] Switched to NOHz mode on CPU #0
>> [    0.150000] [usb_manager]: CONFIG_USB_SW_SUN4I_USB0_OTG
>> [    0.150000] [sw_hcd0]: usb host driver initialize........
>> [    0.160000] [sw_udc]: udc_init: version 20080411
>> [    0.160000] [sw_udc]: usb_vbase  =3D 0xf1c13000
>> [    0.160000] [sw_udc]: sram_vbase =3D 0xf1c00000
>> [    0.170000] [sw_udc]: open_usb_clock
>> [    0.190000] udc->driver is null, udc is need not stop
>> [    0.190000] NET: Registered protocol family 2
>> [    0.200000] IP route cache hash table entries: 4096 (order: 2, 16=
384 bytes)
>> [    0.200000] TCP established hash table entries: 16384 (order: 5, =
131072 bytes)
>> [    0.210000] TCP bind hash table entries: 16384 (order: 4, 65536 b=
ytes)
>> [    0.210000] TCP: Hash tables configured (established 16384 bind 1=
6384)
>> [    0.220000] TCP reno registered
>> [    0.220000] UDP hash table entries: 256 (order: 0, 4096 bytes)
>> [    0.230000] UDP-Lite hash table entries: 256 (order: 0, 4096 byte=
s)
>> [    0.230000] NET: Registered protocol family 1
>> [    0.240000] [pm]aw_pm_init!
>> [    0.240000] audit: initializing netlink socket (disabled)
>> [    0.240000] type=3D2000 audit(0.239:1): initialized
>> [    0.260000] VFS: Disk quotas dquot_6.5.2
>> [    0.260000] Dquot-cache hash table entries: 1024 (order 0, 4096 b=
ytes)
>> [    0.270000] msgmni has been set to 616
>> [    0.270000] alg: No test for stdrng (krng)
>> [    0.270000] Block layer SCSI generic (bsg) driver version 0.4 loa=
ded (major 253)
>> [    0.280000] io scheduler noop registered
>> [    0.280000] io scheduler deadline registered
>> [    0.290000] io scheduler cfq registered (default)
>> [    0.290000] Serial: 8250/16550 driver, 8 ports, IRQ sharing disab=
led
>> [    0.320000] serial8250.0: ttyS0 at MMIO 0x1c28000 (irq =3D 1) is =
a U6_16550A
>> [    0.860000] console [ttyS0] enabled
>> [    0.870000] [uart]: used uart info.: 0x05
>> [    0.900000] sunxi-uart.0: ttyS0 at MMIO 0x1c28000 (irq =3D 1) is =
a U6_16550A
>> [    0.910000] [uart]: serial probe 0, membase   (null) irq 1 mapbas=
e 0x01c28000
>> [    0.940000] sunxi-uart.2: ttyS1 at MMIO 0x1c28800 (irq =3D 3) is =
a U6_16550A
>> [    0.960000] [uart]: serial probe 2, membase   (null) irq 3 mapbas=
e 0x01c28800
>> [    0.970000] G2D: drv_g2d_init
>> [    0.970000] G2D: g2dmem: g2d_start=3D58000000, g2d_size=3D1000000
>> [    0.980000] G2D: head:d8000000,tail:d9000000
>> [    0.990000] G2D: Module initialized.major:251
>> [    1.000000] [drm] Initialized drm 1.1.0 20060810
>> [    1.010000] brd: module loaded
>> [    1.010000] [NAND]nand driver, init.
>> [    1.020000] cmu_clk is 360=20
>> [    1.020000] nand clk init end=20
>> [    1.030000] offset 0xc:  0x6141=20
>> [    1.030000] offset 0x14:  0x82000008=20
>> [    1.040000] [NAND] nand gpio_request
>> [    1.050000] [NAND] nand driver version: 0x2 0x9=20
>> [    1.050000] nand interrupte register ok
>> [    1.060000] ret of NFC_ChangMode is 0=20
>> [    1.070000] dma_hdle  is 0=20
>> [    1.070000] dma_hdle  is 10000008=20
>> [    1.080000] cmu_clk is 360=20
>> [    1.080000] nand clk init end=20
>> [    1.080000] offset 0xc:  0x6141=20
>> [    1.090000] offset 0x14:  0x82000005=20
>> [    1.110000] The 0 disk name =3D bootloader, class name =3D DISK, =
disk size =3D 32768
>> [    1.130000] The 1 disk name =3D env, class name =3D DISK, disk si=
ze =3D 4096
>> [    1.140000] The 2 disk name =3D boot, class name =3D DISK, disk s=
ize =3D 65536
>> [    1.150000] The 3 disk name =3D system, class name =3D DISK, disk=
 size =3D 524288
>> [    1.160000] The 4 disk name =3D data, class name =3D DISK, disk s=
ize =3D 524288
>> [    1.180000] The 5 disk name =3D misc, class name =3D DISK, disk s=
ize =3D 2048
>> [    1.190000] The 6 disk name =3D recovery, class name =3D DISK, di=
sk size =3D 65536
>> [    1.200000] The 7 disk name =3D cache, class name =3D DISK, disk =
size =3D 262144
>> [    1.210000] The 8 disk name =3D private, class name =3D DISK, dis=
k size =3D 2048
>> [    1.230000] The 9 disk name =3D sysrecovery, class name =3D DISK,=
 disk size =3D 655360
>> [    1.240000] The 10 disk name =3D UDISK, class name =3D DISK, disk=
 size =3D 0
>> [    1.250000] The 10 disk size =3D 5642240
>> [    1.260000] part total count =3D 11
>> [    1.260000]  nanda:
>> [    1.270000]  nandb: unknown partition table
>> [    1.280000]  nandc: unknown partition table
>> [    1.290000]  nandd: unknown partition table
>> [    1.300000]  nande: unknown partition table
>> [    1.300000]  nandf: unknown partition table
>> [    1.310000]  nandg: unknown partition table
>> [    1.320000]  nandh: unknown partition table
>> [    1.330000]  nandi:
>> [    1.340000]  nandj: unknown partition table
>> [    1.340000]  nandk:
>> [    1.350000] benn: nand probe enter
>> [    1.350000] [NAND]nand driver, ok.
>> [    1.360000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) D=
river
>> [    1.370000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Drive=
r
>> [    1.380000] [sw-ehci1]: probe, pdev->name: sw-ehci, pdev->id: 1, =
sw_ehci: 0xc05fe5dc
>> [    1.400000] [sw-ehci1]: open clock
>> [    1.420000] [sw-ehci1]: Set USB Power ON
>> [    1.430000] sw-ehci sw-ehci.1: SW USB2.0 'Enhanced' Host Controll=
er (EHCI) Driver
>> [    1.440000] sw-ehci sw-ehci.1: new USB bus registered, assigned b=
us number 1
>> [    1.460000] sw-ehci sw-ehci.1: irq 39, io mem 0xf1c14000
>> [    1.490000] sw-ehci sw-ehci.1: USB 0.0 started, EHCI 1.00
>> [    1.490000] ehci_irq: port change detect
>> [    1.500000] usb usb1: New USB device found, idVendor=3D1d6b, idPr=
oduct=3D0002
>> [    1.510000] usb usb1: New USB device strings: Mfr=3D3, Product=3D=
2, SerialNumber=3D1
>> [    1.530000] usb usb1: Product: SW USB2.0 'Enhanced' Host Controll=
er (EHCI) Driver
>> [    1.540000] usb usb1: Manufacturer: Linux 3.0.36+ ehci_hcd
>> [    1.550000] usb usb1: SerialNumber: sw-ehci
>> [    1.560000] hub 1-0:1.0: USB hub found
>> [    1.570000] hub 1-0:1.0: 1 port detected
>> [    1.570000] [sw-ohci1]: probe, pdev->name: sw-ohci, pdev->id: 1, =
sw_ohci: 0xc05fe6ec
>> [    1.590000] [sw-ohci1]: open clock
>> [    1.610000] sw-ohci sw-ohci.1: SW USB2.0 'Open' Host Controller (=
OHCI) Driver
>> [    1.630000] sw-ohci sw-ohci.1: new USB bus registered, assigned b=
us number 2
>> [    1.640000] sw-ohci sw-ohci.1: irq 64, io mem 0xf1c14400
>> [    1.710000] usb usb2: New USB device found, idVendor=3D1d6b, idPr=
oduct=3D0001
>> [    1.720000] usb usb2: New USB device strings: Mfr=3D3, Product=3D=
2, SerialNumber=3D1
>> [    1.730000] usb usb2: Product: SW USB2.0 'Open' Host Controller (=
OHCI) Driver
>> [    1.750000] usb usb2: Manufacturer: Linux 3.0.36+ ohci_hcd
>> [    1.760000] usb usb2: SerialNumber: sw-ohci
>> [    1.770000] hub 2-0:1.0: USB hub found
>> [    1.770000] hub 2-0:1.0: 1 port detected
>> [    1.780000] [sw-ehci2]: probe, pdev->name: sw-ehci, pdev->id: 2, =
sw_ehci: 0xc05fe800
>> [    1.790000] [sw-ehci2]: open clock
>> [    1.820000] [sw-ehci2]: Set USB Power ON
>> [    1.830000] sw-ehci sw-ehci.2: SW USB2.0 'Enhanced' Host Controll=
er (EHCI) Driver
>> [    1.840000] sw-ehci sw-ehci.2: new USB bus registered, assigned b=
us number 3
>> [    1.850000] sw-ehci sw-ehci.2: irq 40, io mem 0xf1c1c000
>> [    1.890000] usb 1-1: new high speed USB device number 2 using sw-=
ehci
>> [    1.920000] sw-ehci sw-ehci.2: USB 0.0 started, EHCI 1.00
>> [    1.920000] ehci_irq: port change detect
>> [    1.930000] usb usb3: New USB device found, idVendor=3D1d6b, idPr=
oduct=3D0002
>> [    1.940000] usb usb3: New USB device strings: Mfr=3D3, Product=3D=
2, SerialNumber=3D1
>> [    1.960000] usb usb3: Product: SW USB2.0 'Enhanced' Host Controll=
er (EHCI) Driver
>> [   47.380000] usb usb3: Manufacturer: Linux 3.0.36+ ehci_hcd
>> [   47.390000] usb usb3: SerialNumber: sw-ehci
>> [   47.400000] hub 3-0:1.0: USB hub found
>> [   47.410000] hub 3-0:1.0: 1 port detected
>> [   47.410000] [sw-ehci2]: sw_usb_disable_ehci
>> [   47.420000] [sw-ehci2]: remove, pdev->name: sw-ehci, pdev->id: 2,=
 sw_ehci: 0xc05fe800
>> [   47.440000] sw-ehci sw-ehci.2: remove, state 1
>> [   47.440000] usb usb3: USB disconnect, device number 1
>> [   47.450000] BUG: scheduling while atomic: swapper/1/0x40000002
>> [   47.460000] Modules linked in:
>> [   47.470000] [<c0036e80>] (unwind_backtrace+0x0/0xe0) from [<c03c2=
63c>] (__schedule+0x5c/0x4ec)
>> [   47.480000] [<c03c263c>] (__schedule+0x5c/0x4ec) from [<c00517fc>=
] (__cond_resched+0x14/0x20)
>> [   47.500000] [<c00517fc>] (__cond_resched+0x14/0x20) from [<c03c2b=
64>] (_cond_resched+0x34/0x44)
>> [   47.520000] [<c03c2b64>] (_cond_resched+0x34/0x44) from [<c024579=
4>] (wakeup_source_unregister+0xc/0x18)
>> [   47.530000] [<c0245794>] (wakeup_source_unregister+0xc/0x18) from=
 [<c0245964>] (device_wakeup_disable+0x64/0x78)
>> [   47.550000] [<c0245964>] (device_wakeup_disable+0x64/0x78) from [=
<c02447ac>] (device_pm_remove+0x48/0x58)
>> [   47.570000] [<c02447ac>] (device_pm_remove+0x48/0x58) from [<c023=
d144>] (device_del+0x34/0x168)
>> [   47.590000] [<c023d144>] (device_del+0x34/0x168) from [<c02847f4>=
] (usb_disconnect+0x9c/0xf8)
>> [   47.600000] [<c02847f4>] (usb_disconnect+0x9c/0xf8) from [<c02872=
44>] (usb_remove_hcd+0xb8/0x174)
>> [   47.620000] [<c0287244>] (usb_remove_hcd+0xb8/0x174) from [<c0295=
bbc>] (sw_ehci_hcd_remove+0x9c/0x104)
>> [   47.640000] [<c0295bbc>] (sw_ehci_hcd_remove+0x9c/0x104) from [<c=
0295cec>] (sw_usb_disable_ehci+0xc8/0xf0)
>> [   47.650000] [<c0295cec>] (sw_usb_disable_ehci+0xc8/0xf0) from [<c=
0295ed0>] (sw_ehci_hcd_probe+0x1bc/0x228)
>> [   47.670000] [<c0295ed0>] (sw_ehci_hcd_probe+0x1bc/0x228) from [<c=
02409c4>] (platform_drv_probe+0x14/0x18)
>> [   47.690000] [<c02409c4>] (platform_drv_probe+0x14/0x18) from [<c0=
23f8a8>] (driver_probe_device+0xc8/0x184)
>> [   47.710000] [<c023f8a8>] (driver_probe_device+0xc8/0x184) from [<=
c023e86c>] (bus_for_each_drv+0x48/0x80)
>> [   47.730000] [<c023e86c>] (bus_for_each_drv+0x48/0x80) from [<c023=
f700>] (device_attach+0x74/0xa0)
>> [   47.740000] [<c023f700>] (device_attach+0x74/0xa0) from [<c023f07=
8>] (bus_probe_device+0x24/0x40)
>> [   47.760000] [<c023f078>] (bus_probe_device+0x24/0x40) from [<c023=
d884>] (device_add+0x39c/0x528)
>> [   47.780000] [<c023d884>] (device_add+0x39c/0x528) from [<c0240fb0=
>] (platform_device_add+0x108/0x164)
>> [   47.790000] [<c0240fb0>] (platform_device_add+0x108/0x164) from [=
<c001e6c0>] (sw_hci_sun4i_init+0x154/0x1f0)
>> [   47.810000] [<c001e6c0>] (sw_hci_sun4i_init+0x154/0x1f0) from [<c=
002c408>] (do_one_initcall+0x90/0x160)
>> [   47.830000] [<c002c408>] (do_one_initcall+0x90/0x160) from [<c000=
8a90>] (kernel_init+0xb0/0x15c)
>> [   47.840000] [<c0008a90>] (kernel_init+0xb0/0x15c) from [<c0032598=
>] (kernel_thread_exit+0x0/0x8)
>> [   47.860000] sw-ehci sw-ehci.2: USB bus 3 deregistered
>=20
> Well, this is your problem appearantly, and it has nothing to do with
> ALSA. Not sure what causes this and whether this was a known problem =
in
> that 3.0.36+ kernel that you're using.
>=20
>> [   47.870000] [sw-ehci2]: Set USB Power OFF
>> [   47.880000] [sw-ehci2]: close clock
>> [   47.880000] [sw-ohci2]: probe, pdev->name: sw-ohci, pdev->id: 2, =
sw_ohci: 0xc05fe910
>> [   47.900000] [sw-ohci2]: open clock
>> [   47.920000] [sw-ohci2]: Set USB Power ON
>> [   47.930000] sw-ohci sw-ohci.2: SW USB2.0 'Open' Host Controller (=
OHCI) Driver
>> [   47.940000] sw-ohci sw-ohci.2: new USB bus registered, assigned b=
us number 3
>> [   47.960000] sw-ohci sw-ohci.2: irq 65, io mem 0xf1c1c400
>> [   47.970000] BUG: scheduling while atomic: swapper/1/0x00000002
>> [   47.980000] Modules linked in:
>> [   47.980000] [<c0036e80>] (unwind_backtrace+0x0/0xe0) from [<c03c2=
63c>] (__schedule+0x5c/0x4ec)
>> [   48.000000] [<c03c263c>] (__schedule+0x5c/0x4ec) from [<c03c3560>=
] (schedule_timeout+0x1d0/0x20c)
>> [   48.010000] [<c03c3560>] (schedule_timeout+0x1d0/0x20c) from [<c0=
0659e4>] (msleep+0x14/0x20)
>> [   48.030000] [<c00659e4>] (msleep+0x14/0x20) from [<c029c91c>] (oh=
ci_run+0xc0/0x434)
>> [   48.040000] [<c029c91c>] (ohci_run+0xc0/0x434) from [<c03bc290>] =
(sw_ohci_start+0x24/0x68)
>> [   48.060000] [<c03bc290>] (sw_ohci_start+0x24/0x68) from [<c0287fe=
4>] (usb_add_hcd+0x2cc/0x60c)
>> [   48.070000] [<c0287fe4>] (usb_add_hcd+0x2cc/0x60c) from [<c029cfc=
c>] (sw_ohci_hcd_probe+0x148/0x220)
>> [   48.090000] [<c029cfcc>] (sw_ohci_hcd_probe+0x148/0x220) from [<c=
02409c4>] (platform_drv_probe+0x14/0x18)
>> [   48.110000] [<c02409c4>] (platform_drv_probe+0x14/0x18) from [<c0=
23f8a8>] (driver_probe_device+0xc8/0x184)
>> [   48.130000] [<c023f8a8>] (driver_probe_device+0xc8/0x184) from [<=
c023e86c>] (bus_for_each_drv+0x48/0x80)
>> [   48.140000] [<c023e86c>] (bus_for_each_drv+0x48/0x80) from [<c023=
f700>] (device_attach+0x74/0xa0)
>> [   48.160000] [<c023f700>] (device_attach+0x74/0xa0) from [<c023f07=
8>] (bus_probe_device+0x24/0x40)
>> [   48.180000] [<c023f078>] (bus_probe_device+0x24/0x40) from [<c023=
d884>] (device_add+0x39c/0x528)
>> [   48.190000] [<c023d884>] (device_add+0x39c/0x528) from [<c0240fb0=
>] (platform_device_add+0x108/0x164)
>> [   48.210000] [<c0240fb0>] (platform_device_add+0x108/0x164) from [=
<c001e6fc>] (sw_hci_sun4i_init+0x190/0x1f0)
>> [   48.230000] [<c001e6fc>] (sw_hci_sun4i_init+0x190/0x1f0) from [<c=
002c408>] (do_one_initcall+0x90/0x160)
>> [   48.250000] [<c002c408>] (do_one_initcall+0x90/0x160) from [<c000=
8a90>] (kernel_init+0xb0/0x15c)
>> [   48.260000] [<c0008a90>] (kernel_init+0xb0/0x15c) from [<c0032598=
>] (kernel_thread_exit+0x0/0x8)
>> [   48.280000] usb usb3: New USB device found, idVendor=3D1d6b, idPr=
oduct=3D0001
>> [   48.300000] usb usb3: New USB device strings: Mfr=3D3, Product=3D=
2, SerialNumber=3D1
>> [   48.310000] usb usb3: Product: SW USB2.0 'Open' Host Controller (=
OHCI) Driver
>> [   48.320000] usb usb3: Manufacturer: Linux 3.0.36+ ohci_hcd
>> [   48.330000] usb usb3: SerialNumber: sw-ohci
>> [   48.340000] hub 3-0:1.0: USB hub found
>> [   48.350000] hub 3-0:1.0: 1 port detected
>> [   48.350000] [sw-ohci2]: sw_usb_disable_ohci
>> [   48.360000] [sw-ohci2]: remove, pdev->name: sw-ohci, pdev->id: 2,=
 sw_ohci: 0xc05fe910
>> [   48.380000] sw-ohci sw-ohci.2: remove, state 1
>> [   48.380000] usb usb3: USB disconnect, device number 1
>> [   48.390000] BUG: scheduling while atomic: swapper/1/0x40000002
>> [   48.400000] Modules linked in:
>> [   48.410000] [<c0036e80>] (unwind_backtrace+0x0/0xe0) from [<c03c2=
63c>] (__schedule+0x5c/0x4ec)
>> [   48.420000] [<c03c263c>] (__schedule+0x5c/0x4ec) from [<c00517fc>=
] (__cond_resched+0x14/0x20)
>> [   48.440000] [<c00517fc>] (__cond_resched+0x14/0x20) from [<c03c2b=
64>] (_cond_resched+0x34/0x44)
>> [   48.460000] [<c03c2b64>] (_cond_resched+0x34/0x44) from [<c024579=
4>] (wakeup_source_unregister+0xc/0x18)
>> [   48.470000] [<c0245794>] (wakeup_source_unregister+0xc/0x18) from=
 [<c0245964>] (device_wakeup_disable+0x64/0x78)
>> [   48.490000] [<c0245964>] (device_wakeup_disable+0x64/0x78) from [=
<c02447ac>] (device_pm_remove+0x48/0x58)
>> [   48.510000] [<c02447ac>] (device_pm_remove+0x48/0x58) from [<c023=
d144>] (device_del+0x34/0x168)
>> [   48.530000] [<c023d144>] (device_del+0x34/0x168) from [<c02847f4>=
] (usb_disconnect+0x9c/0xf8)
>> [   48.540000] [<c02847f4>] (usb_disconnect+0x9c/0xf8) from [<c02872=
44>] (usb_remove_hcd+0xb8/0x174)
>> [   48.560000] [<c0287244>] (usb_remove_hcd+0xb8/0x174) from [<c029c=
d30>] (sw_ohci_hcd_remove+0xa0/0x104)
>> [   48.580000] [<c029cd30>] (sw_ohci_hcd_remove+0xa0/0x104) from [<c=
029ce5c>] (sw_usb_disable_ohci+0xc8/0xf0)
>> [   48.590000] [<c029ce5c>] (sw_usb_disable_ohci+0xc8/0xf0) from [<c=
029d034>] (sw_ohci_hcd_probe+0x1b0/0x220)
>> [   48.610000] [<c029d034>] (sw_ohci_hcd_probe+0x1b0/0x220) from [<c=
02409c4>] (platform_drv_probe+0x14/0x18)
>> [   48.630000] [<c02409c4>] (platform_drv_probe+0x14/0x18) from [<c0=
23f8a8>] (driver_probe_device+0xc8/0x184)
>> [   48.650000] [<c023f8a8>] (driver_probe_device+0xc8/0x184) from [<=
c023e86c>] (bus_for_each_drv+0x48/0x80)
>> [   48.670000] [<c023e86c>] (bus_for_each_drv+0x48/0x80) from [<c023=
f700>] (device_attach+0x74/0xa0)
>> [   48.680000] [<c023f700>] (device_attach+0x74/0xa0) from [<c023f07=
8>] (bus_probe_device+0x24/0x40)
>> [   48.700000] [<c023f078>] (bus_probe_device+0x24/0x40) from [<c023=
d884>] (device_add+0x39c/0x528)
>> [   48.710000] [<c023d884>] (device_add+0x39c/0x528) from [<c0240fb0=
>] (platform_device_add+0x108/0x164)
>> [   48.730000] [<c0240fb0>] (platform_device_add+0x108/0x164) from [=
<c001e6fc>] (sw_hci_sun4i_init+0x190/0x1f0)
>> [   48.750000] [<c001e6fc>] (sw_hci_sun4i_init+0x190/0x1f0) from [<c=
002c408>] (do_one_initcall+0x90/0x160)
>> [   48.770000] [<c002c408>] (do_one_initcall+0x90/0x160) from [<c000=
8a90>] (kernel_init+0xb0/0x15c)
>> [   48.780000] [<c0008a90>] (kernel_init+0xb0/0x15c) from [<c0032598=
>] (kernel_thread_exit+0x0/0x8)
>> [   48.800000] sw-ohci sw-ohci.2: USB bus 3 deregistered
>> [   48.810000] [sw-ohci2]: Set USB Power OFF
>> [   48.820000] [sw-ohci2]: close clock
>> [   48.820000] initcall sw_hci_sun4i_init+0x0/0x1f0 returned with pr=
eemption imbalance=20
>> [   48.840000] mousedev: PS/2 mouse device common for all mice
>> [   48.850000] sunxi RTC version 0.1=20
>> [   48.850000] sunxi-rtc sunxi-rtc: sunxi_rtc_probe tmp_data =3D 380=
239881
>> [   48.860000] sunxi-rtc sunxi-rtc: sunxi_rtc_gettime
>> [   48.870000] usb 1-1: New USB device found, idVendor=3D05e3, idPro=
duct=3D0608
>> [   48.890000] sunxi-rtc sunxi-rtc: read time 2010-1-1 2:0:12
>> [   48.900000] using rtc device, rtc, for alarms
>> [   48.900000] sunxi-rtc sunxi-rtc: rtc core: registered rtc as rtc0
>> [   48.910000] usb 1-1: New USB device strings: Mfr=3D0, Product=3D1=
, SerialNumber=3D0
>> [   48.930000] i2c /dev entries driver
>> [   48.930000] !!! base_Addr =3D 0xdc84ac00=20
>> [   48.940000] config i2c gpio with gpio_config api=20
>> [   48.950000] usb 1-1: Product: USB2.0 Hub
>> [   48.960000] twi0, apb clock =3D 24000000=20
>> [   48.960000] hub 1-1:1.0: USB hub found
>> [   48.970000] hub 1-1:1.0: 4 ports detected
>> [   48.980000] axp_mfd 0-0034: AXP (CHIP ID: 0x21) detected
>> [   48.990000] I2C: i2c-0: AW16XX I2C adapter
>> [   48.990000] **********start************
>> [   49.000000] 0x40=20
>> [   49.000000] 0xf8=20
>> [   49.010000] 0x28=20
>> [   49.010000] 0x0=20
>> [   49.010000] 0x0=20
>> [   49.010000] **********end************
>> [   49.020000] !!! base_Addr =3D 0xdc84c000=20
>> [   49.030000] twi1, apb clock =3D 24000000=20
>> [   49.030000] I2C: i2c-1: AW16XX I2C adapter
>> [   49.040000] **********start************
>> [   49.050000] 0x40=20
>> [   49.050000] 0xf8=20
>> [   49.050000] 0x58=20
>> [   49.050000] 0x0=20
>> [   49.060000] 0x0=20
>> [   49.060000] **********end************
>> [   49.060000] !!! base_Addr =3D 0xdc84e400=20
>> [   49.070000] twi2, apb clock =3D 24000000=20
>> [   49.080000] I2C: i2c-2: AW16XX I2C adapter
>> [   49.080000] **********start************
>> [   49.090000] 0x40=20
>> [   49.090000] 0xf8=20
>> [   49.100000] 0x58=20
>> [   49.100000] 0x0=20
>> [   49.100000] 0x0=20
>> [   49.100000] **********end************
>> [   49.110000] Linux media interface: v0.10
>> [   49.120000] [cedar dev]: install start!!!
>> [   49.120000] [cedar dev]: install end!!!
>> [   49.130000] print_constraints: axp20_ldo1: 1300 mV=20
>> [   49.140000] print_constraints: axp20_ldo2: 1800 <--> 3300 mV at 3=
000 mV=20
>> [   49.150000] print_constraints: axp20_ldo3: 700 <--> 3500 mV at 28=
00 mV=20
>> [   49.170000] print_constraints: axp20_ldo4: 1250 <--> 3300 mV at 2=
800 mV=20
>> [   49.180000] print_constraints: axp20_buck2: 700 <--> 2275 mV at 1=
400 mV=20
>> [   49.190000] print_constraints: axp20_buck3: 700 <--> 3500 mV at 1=
250 mV=20
>> [   49.200000] print_constraints: axp20_ldoio0: 1800 <--> 3300 mV at=
 2800 mV=20
>> [   49.220000] input: axp20-supplyer as /devices/platform/sun4i-i2c.=
0/i2c-0/0-0034/axp20-supplyer.28/input/input0
>> [   49.240000] [AXP]axp driver uning configuration failed(1579)
>> [   49.250000] [AXP]pmu_suspendpwroff_vol =3D 3500
>> [   49.270000] cpuidle: using governor ladder
>> [   49.280000] cpuidle: using governor menu
>> [   49.280000] [mmc_pm]: no sdio card used in configuration
>> [   49.290000] [mmc]: sunximmc_init
>> [   49.300000] [mmc]: sunxi mmc controller using config : 0xb
>> [   49.310000] [mmc]: sunxi-mmc.0: pdev->name: sunxi-mmc, pdev->id: =
0
>> [   49.320000] [mmc]: mmc 0 power off !!
>> [   49.320000] usb 1-1.2: new high speed USB device number 3 using s=
w-ehci
>> [   49.340000] [mmc]: mmc0 Probe: base:0xdc854000 irq:32 dma:0 pdes:=
0xd9a04000, ret 0.
>> [   49.350000] [mmc]: sunxi-mmc.1: pdev->name: sunxi-mmc, pdev->id: =
1
>> [   49.360000] [mmc]: mmc 1 power off !!
>> [   49.370000] [mmc]: mmc1 Probe: base:0xdc856000 irq:33 dma:0 pdes:=
0xd9a10000, ret 0.
>> [   49.380000] [mmc]: sunxi-mmc.3: pdev->name: sunxi-mmc, pdev->id: =
3
>> [   49.390000] [mmc]: mmc 3 power off !!
>> [   49.400000] [mmc]: mmc3 Probe: base:0xdc858000 irq:35 dma:0 pdes:=
0xd9a14000, ret 0.
>> [   49.410000] enter sun4i Audio codec!!!
>> [   49.420000] sun4i audio support initialized
>> [   49.430000] audiocodec_adap_awxx_init: script_parser_fetch err.=20
>> [   49.440000] sun4i Audio codec successfully loaded..
>> [   49.450000] asoc: sndhdmi <-> sun4i-hdmiaudio.0 mapping ok
>> [   49.460000] asoc: sndspdif <-> sun4i-spdif.0 mapping ok
>> [   49.470000] [I2S]sun4i-i2s cannot find any using configuration fo=
r controllers, return directly!
>> [   49.490000] [I2S]sndi2s cannot find any using configuration for c=
ontrollers, return directly!
>> [   49.500000] [I2S]sun4i_sndi2s cannot find any using configuration=
 for controllers, return directly!
>> [   49.520000] ALSA device list:
>> [   49.530000]   #0: sun4i-CODEC  Audio Codec
>> [   49.530000]   #1: sun4i-sndhdmi
>> [   49.540000]   #2: sun4i-sndspdif
>> [   49.540000] usb 1-1.2: New USB device found, idVendor=3D20b1, idP=
roduct=3D0002
>> [   49.560000] TCP cubic registered
>> [   49.560000] NET: Registered protocol family 10
>> [   49.570000] NET: Registered protocol family 17
>> [   49.580000] usb 1-1.2: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D3
>> [   49.590000] Registering the dns_resolver key type
>> [   49.600000] usb 1-1.2: Product: XMOS USB Audio 2.0
>> [   49.610000] VFP support v0.3:=20
>> [   49.620000] usb 1-1.2: Manufacturer: XMOS=20
>> [   49.620000] usb 1-1.2: SerialNumber: 0000
>> [   49.630000] implementor 41 architecture 3 part 30 variant c rev 3
>> [   49.640000] ThumbEE CPU extension supported.
>> [   49.650000] Registering SWP/SWPB emulation handler
>> [   49.660000] registered taskstats version 1
>> [   49.670000] [LCD] lcd_module_init
>> [   49.730000] [DISP WRN] file:drivers/video/sun4i/disp/de_bsp/de/di=
sp_lcd.c,line:592:    lcd1_para.lcd_used not exit
>> [   49.750000] regulator_init_complete: axp20_buck3: incomplete cons=
traints, leaving on
>> [   49.770000] regulator_init_complete: axp20_buck2: incomplete cons=
traints, leaving on
>> [   49.780000] regulator_init_complete: axp20_ldo4: incomplete const=
raints, leaving on
>> [   49.800000] regulator_init_complete: axp20_ldo3: incomplete const=
raints, leaving on
>> [   49.810000] regulator_init_complete: axp20_ldo2: incomplete const=
raints, leaving on
>> [   49.830000] regulator_init_complete: axp20_ldo1: incomplete const=
raints, leaving on
>> [   49.840000] sunxi-rtc sunxi-rtc: sunxi_rtc_gettime
>> [   49.850000] sunxi-rtc sunxi-rtc: read time 2010-1-1 2:0:13
>> [   49.860000] sunxi-rtc sunxi-rtc: setting system clock to 2010-01-=
01 02:00:13 UTC (1262311213)
>> [   49.880000] Waiting for root device /dev/mmcblk0p2...
>> [   50.340000] [mmc]: mmc 0 detect change, present 1
>> [   50.640000] [mmc]: mmc 0 power on !!
>> [   50.680000] [mmc]: sdxc_request_done(L1113): smc 0 err, cmd 52,  =
RTO !!
>> [   50.690000] [mmc]: sdxc_request_done(L1113): smc 0 err, cmd 52,  =
RTO !!
>> [   50.700000] [mmc]: sdxc_request_done(L1113): smc 0 err, cmd 5,  R=
TO !!
>> [   50.720000] [mmc]: sdxc_request_done(L1113): smc 0 err, cmd 5,  R=
TO !!
>> [   50.730000] [mmc]: sdxc_request_done(L1113): smc 0 err, cmd 5,  R=
TO !!
>> [   50.740000] [mmc]: sdxc_request_done(L1113): smc 0 err, cmd 5,  R=
TO !!
>> [   50.790000] mmc0: new high speed SDHC card at address b368
>> [   50.800000] mmcblk0: mmc0:b368 USD   7.46 GiB=20
>> [   50.810000]  mmcblk0: p1 p2 p3
>> [   50.880000] EXT4-fs (mmcblk0p2): mounted filesystem with ordered =
data mode. Opts: (null)
>> [   50.890000] VFS: Mounted root (ext4 filesystem) on device 179:2.
>> [   50.910000] devtmpfs: mounted
>> [   50.910000] Freeing init memory: 144K
>> [   50.920000] Failed to execute /init.  Attempting defaults...
>> [   52.020000] udevd[136]: starting version 175
>> [   54.290000] ALSA sound/usb/mixer.c:342 cannot get ctl value: req =
=3D 0x83, wValue =3D 0x201, wIndex =3D 0xa00, type =3D 4
>> [   54.310000] ALSA sound/usb/mixer.c:342 cannot get ctl value: req =
=3D 0x83, wValue =3D 0x200, wIndex =3D 0xa00, type =3D 4
>> [   54.330000] usbcore: registered new interface driver snd-usb-audi=
o
>> [   54.920000] Adding 262136k swap on /dev/mmcblk0p3.  Priority:-1 e=
xtents:1 across:262136k SS
>> [   56.840000] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
>> [   57.280000] UMP<2>: Inserting UMP device driver. Compiled: Jul 21=
 2012, time: 11:43:11
>> [   57.300000] UMP<2>: Using OS memory backend, allocation limit: 13=
4217728
>> [   57.310000] UMP: UMP device driver  loaded
>> [   57.360000] mali: use config clk_div 3
>> [   57.360000] mali: clk_div 3
>> [   57.380000] Mali: mali clock set completed, clock is  320000000 M=
hz
>> [   57.390000] Mali: Mali device driver  loaded
>> [   57.460000] wemac Ethernet Driver, V1.00 in file:drivers/net/sun4=
i/sun4i_wemac.c
>> [   57.490000] [EMAC] ahb clk enable=20
>> [   57.490000] [EMAC] ahb gate clk: 0x26147=20
>> [   57.520000] wemac wemac.0: PHY SETUP, reg 0 value: 0
>> [   57.530000] wemac wemac.0: resetting device
>> [   57.540000] release temp resource
>> [   62.140000] wemac wemac.0: enabling eth0
>> [   62.140000] wemac wemac.0: WARNING: no IRQ resource flags set.
>> [   62.150000] wemac wemac.0: resetting device
>> [   62.160000] wemac wemac.0: eth0: link up, 100Mbps, full-duplex, l=
pa 0xFFFF
>> [   67.460000] RPC: Registered named UNIX socket transport module.
>> [   67.470000] RPC: Registered udp transport module.
>> [   67.480000] RPC: Registered tcp transport module.
>> [   67.490000] RPC: Registered tcp NFSv4.1 backchannel transport mod=
ule.
>> [   67.750000] FS-Cache: Netfs 'nfs' registered for caching
>> [   67.870000] Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYN7G3RF/2/jw@public.gmane.org=
e).
>> [   72.600000] eth0: no IPv6 routers present
>> [   81.520000] usbcore: deregistering interface driver snd-usb-audio
>> [   82.050000] ALSA sound/usb/mixer.c:342 cannot get ctl value: req =
=3D 0x83, wValue =3D 0x201, wIndex =3D 0xa00, type =3D 4
>> [   82.070000] ALSA sound/usb/mixer.c:342 cannot get ctl value: req =
=3D 0x83, wValue =3D 0x200, wIndex =3D 0xa00, type =3D 4
>> [   82.100000] usbcore: registered new interface driver snd-usb-audi=
o
>> [  288.510000] usbcore: deregistering interface driver snd-usb-audio
>> [  296.390000] ALSA sound/usb/mixer.c:342 cannot get ctl value: req =
=3D 0x83, wValue =3D 0x201, wIndex =3D 0xa00, type =3D 4
>> [  296.420000] ALSA sound/usb/mixer.c:342 cannot get ctl value: req =
=3D 0x83, wValue =3D 0x200, wIndex =3D 0xa00, type =3D 4
>> [  296.460000] usbcore: registered new interface driver snd-usb-audi=
o
>> [  384.700000] usb 1-1.2: USB disconnect, device number 3
>> [  392.090000] ehci_irq: port change detect
>> [  392.350000] usb 1-1.2: new high speed USB device number 4 using s=
w-ehci
>> [  392.470000] usb 1-1.2: New USB device found, idVendor=3D20b1, idP=
roduct=3D0002
>> [  392.490000] usb 1-1.2: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D3
>> [  392.510000] usb 1-1.2: Product: XMOS USB Audio 2.0
>> [  392.510000] usb 1-1.2: Manufacturer: XMOS=20
>> [  392.530000] usb 1-1.2: SerialNumber: 0000
>> [  393.010000] ALSA sound/usb/mixer.c:342 cannot get ctl value: req =
=3D 0x83, wValue =3D 0x201, wIndex =3D 0xa00, type =3D 4
>> [  393.040000] ALSA sound/usb/mixer.c:342 cannot get ctl value: req =
=3D 0x83, wValue =3D 0x200, wIndex =3D 0xa00, type =3D 4
>>
>>
>> dmesg.1.0.23
>>
>>
>> Linux version 2.6.37-dockstar (root@debian) (gcc version 4.4.5 (Debi=
an 4.4.5-4) ) #6 Mon Jan 17 01:55:44 CET 2011
>> CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=3D00053977
>> CPU: VIVT data cache, VIVT instruction cache
>> Machine: Seagate Dockstar Board
>> Memory policy: ECC disabled, Data cache writeback
>> On node 0 totalpages: 32768
>> free_area_init_node: node 0, pgdat c0559fa4, node_mem_map c0588000
>>   Normal zone: 256 pages used for memmap
>>   Normal zone: 0 pages reserved
>>   Normal zone: 32512 pages, LIFO batch:7
>> pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
>> pcpu-alloc: [0] 0=20
>> Built 1 zonelists in Zone order, mobility grouping on.  Total pages:=
 32512
>> Kernel command line: console=3DttyS0,115200 root=3D/dev/sda1 rootdel=
ay=3D10 rootfstype=3Dext2 mtdparts=3Dorion_nand:1M(u-boot),4M(uImage),3=
2M(rootfs),-(data)
>> PID hash table entries: 512 (order: -1, 2048 bytes)
>> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
>> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
>> Memory: 128MB =3D 128MB total
>> Memory: 124248k/124248k available, 6824k reserved, 0K highmem
>> Virtual kernel memory layout:
>>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>>     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
>>     vmalloc : 0xc8800000 - 0xfe800000   ( 864 MB)
>>     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
>>     modules : 0xbf000000 - 0xc0000000   (  16 MB)
>>       .init : 0xc0008000 - 0xc0030000   ( 160 kB)
>>       .text : 0xc0030000 - 0xc0525000   (5076 kB)
>>       .data : 0xc0526000 - 0xc055b680   ( 214 kB)
>> SLUB: Genslabs=3D13, HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=
=3D1, Nodes=3D1
>> NR_IRQS:114
>> Console: colour dummy device 80x30
>> Calibrating delay loop... 1192.75 BogoMIPS (lpj=3D5963776)
>> pid_max: default: 32768 minimum: 301
>> Mount-cache hash table entries: 512
>> CPU: Testing write buffer coherency: ok
>> regulator: core version 0.5
>> regulator: dummy:=20
>> NET: Registered protocol family 16
>> i2c-core: driver [dummy] registered
>> Kirkwood: MV88F6281-A0, TCLK=3D200000000.
>> Feroceon L2: Cache support initialised.
>> initial MPP regs: 01111111 11113322 00001111 00100000 00000000 00000=
000 00000000
>>   final MPP regs: 01111111 11113322 00001111 00000000 00000000 00000=
000 00000000
>> bio: create slab <bio-0> at 0
>> vgaarb: loaded
>> i2c-core: driver [88PM860x] registered
>> SCSI subsystem initialized
>> usbcore: registered new interface driver usbfs
>> usbcore: registered new interface driver hub
>> usbcore: registered new device driver usb
>> Switching to clocksource orion_clocksource
>> FS-Cache: Loaded
>> NET: Registered protocol family 2
>> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
>> TCP established hash table entries: 4096 (order: 3, 32768 bytes)
>> TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
>> TCP: Hash tables configured (established 4096 bind 4096)
>> TCP reno registered
>> UDP hash table entries: 256 (order: 0, 4096 bytes)
>> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
>> NET: Registered protocol family 1
>> RPC: Registered udp transport module.
>> RPC: Registered tcp transport module.
>> RPC: Registered tcp NFSv4.1 backchannel transport module.
>> PCI: CLS 0 bytes, default 32
>> FS-Cache: Netfs 'nfs' registered for caching
>> nfs4filelayout_init: NFSv4 File Layout Driver Registering...
>> Installing knfsd (copyright (C) 1996 okir-pn4DOG8n3UYbFoVRYvo4fw@public.gmane.org).
>> fuse init (API version 7.15)
>> msgmni has been set to 242
>> io scheduler noop registered
>> io scheduler deadline registered
>> io scheduler cfq registered (default)
>> Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
>> serial8250.0: ttyS0 at MMIO 0xf1012000 (irq =3D 33) is a 16550A
>> console [ttyS0] enabled
>> brd: module loaded
>> loop: module loaded
>> physmap-flash.0: failed to claim resource 0
>> ONFI flash detected
>> ONFI param page 0 valid
>> NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda (Micron NAND 256Mi=
B 3,3V 8-bit)
>> Scanning device for bad blocks
>> Bad eraseblock 877 at 0x000006da0000
>> Bad eraseblock 952 at 0x000007700000
>> Bad eraseblock 1020 at 0x000007f80000
>> 4 cmdlinepart partitions found on MTD device orion_nand
>> Creating 4 MTD partitions on "orion_nand":
>> 0x000000000000-0x000000100000 : "u-boot"
>> 0x000000100000-0x000000500000 : "uImage"
>> 0x000000500000-0x000002500000 : "rootfs"
>> 0x000002500000-0x000010000000 : "data"
>> MV-643xx 10/100/1000 ethernet driver version 1.4
>> mv643xx_eth smi: probed
>> net eth0: port 0 with MAC address 00:10:75:1a:42:2a
>> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>> orion-ehci orion-ehci.0: Marvell Orion EHCI
>> orion-ehci orion-ehci.0: new USB bus registered, assigned bus number=
 1
>> orion-ehci orion-ehci.0: irq 19, io mem 0xf1050000
>> orion-ehci orion-ehci.0: USB 2.0 started, EHCI 1.00
>> hub 1-0:1.0: USB hub found
>> hub 1-0:1.0: 1 port detected
>> ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
>> uhci_hcd: USB Universal Host Controller Interface driver
>> Initializing USB Mass Storage driver...
>> usbcore: registered new interface driver usb-storage
>> USB Mass Storage support registered.
>> usbcore: registered new interface driver usbserial
>> USB Serial support registered for generic
>> usbcore: registered new interface driver usbserial_generic
>> usbserial: USB Serial Driver core
>> mice: PS/2 mouse device common for all mice
>> i2c /dev entries driver
>> i2c-core: driver [dev_driver] registered
>> lirc_dev: IR Remote Control driver registered, major 253=20
>> IR NEC protocol handler initialized
>> IR RC5(x) protocol handler initialized
>> IR RC6 protocol handler initialized
>> IR JVC protocol handler initialized
>> IR Sony protocol handler initialized
>> IR RC5 (streamzap) protocol handler initialized
>> IR LIRC bridge handler initialized
>> Orion Watchdog Timer: Initial timeout 21 sec
>> cpuidle: using governor ladder
>> cpuidle: using governor menu
>> mv_xor_shared mv_xor_shared.0: Marvell shared XOR driver
>> mv_xor_shared mv_xor_shared.1: Marvell shared XOR driver
>> mv_xor mv_xor.0: Marvell XOR: ( xor cpy )
>> mv_xor mv_xor.1: Marvell XOR: ( xor fill cpy )
>> mv_xor mv_xor.2: Marvell XOR: ( xor cpy )
>> mv_xor mv_xor.3: Marvell XOR: ( xor fill cpy )
>> sdhci: Secure Digital Host Controller Interface driver
>> sdhci: Copyright(c) Pierre Ossman
>> mmc0: mvsdio driver initialized, lacking card detect (fall back to p=
olling)
>> Registered led device: dockstar:green:health
>> Registered led device: dockstar:orange:health
>> Driver for HIFN 795x crypto accelerator chip has been successfully r=
egistered.
>> usbcore: registered new interface driver usbhid
>> usbhid: USB HID core driver
>> zram: num_devices not specified. Using default: 1
>> zram: Creating 1 devices ...
>> oprofile: hardware counters not available
>> oprofile: using timer interrupt.
>> TCP cubic registered
>> NET: Registered protocol family 17
>> Gating clock of unused units
>> before: 0x00dfc3fd
>>  after: 0x00c701d9
>> drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
>> Waiting 10sec before mounting root device...
>> usb 1-1: new high speed USB device using orion-ehci and address 2
>> hub 1-1:1.0: USB hub found
>> hub 1-1:1.0: 4 ports detected
>> usb 1-1.2: new high speed USB device using orion-ehci and address 3
>> scsi0 : usb-storage 1-1.2:1.0
>> scsi 0:0:0:0: Direct-Access     Generic- SD/MMC           1.00 PQ: 0=
 ANSI: 0 CCS
>> sd 0:0:0:0: Attached scsi generic sg0 type 0
>> sd 0:0:0:0: [sda] 7880704 512-byte logical blocks: (4.03 GB/3.75 GiB=
)
>> sd 0:0:0:0: [sda] Write Protect is off
>> sd 0:0:0:0: [sda] Mode Sense: 03 00 00 00
>> sd 0:0:0:0: [sda] Assuming drive cache: write through
>> sd 0:0:0:0: [sda] Assuming drive cache: write through
>>  sda: sda1 sda2
>> sd 0:0:0:0: [sda] Assuming drive cache: write through
>> sd 0:0:0:0: [sda] Attached SCSI removable disk
>> VFS: Mounted root (ext2 filesystem) on device 8:1.
>> Freeing init memory: 160K
>> rtc-mv rtc-mv: internal RTC not ticking
>> Adding 260092k swap on /dev/sda2.  Priority:-1 extents:1 across:2600=
92k=20
>> eth0: link up, 100 Mb/s, full duplex, flow control disabled
>> sshd (1097): /proc/1097/oom_adj is deprecated, please use /proc/1097=
/oom_score_adj instead.
>> usb 1-1.3: new high speed USB device using orion-ehci and address 4
>> usbcore: registered new interface driver snd-usb-audio
>>
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
