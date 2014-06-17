From: Simon Horman <horms@verge.net.au>
Subject: Possible regression caused by "ASoC: rsnd: add
 rsnd_gen_dma_addr() for DMAC addr"
Date: Tue, 17 Jun 2014 21:13:57 +0900
Message-ID: <20140617121349.GA20165@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 38D972655A5
 for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2014 14:14:02 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san, Hi All,

ad32d0c7b0e99343 ("ASoC: rsnd: add rsnd_gen_dma_addr() for DMAC addr"),
which is included in v3.16-rc1, appears to cause the following panic
on the bockw board when booted using the bockw_defconfig.


Booting Linux on physical CPU 0x0
Linux version 3.15.0-rc1-00017-gad32d0c (horms@ayumi.isobedori.kobe.vergenet.net) (gcc version 4.6.3 (GCC) ) #123 Tue Jun 17 20:56:53 JST 2014
CPU: ARMv7 Processor [412fc094] revision 4 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine model: bockw
debug: ignoring loglevel setting.
Memory policy: Data cache writeback
On node 0 totalpages: 65536
free_area_init_node: node 0, pgdat c03f7f88, node_mem_map cfdfb000
  Normal zone: 512 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 65536 pages, LIFO batch:15
DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map
CPU: All CPU(s) started in SVC mode.
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=ttySC0,115200 ignore_loglevel ip=dhcp root=/dev/nfs rw
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 255600K/262144K available (3123K kernel code, 146K rwdata, 628K rodata, 130K init, 165K bss, 6544K reserved, 0K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
      .text : 0xc0008000 - 0xc03b1e14   (3752 kB)
      .init : 0xc03b2000 - 0xc03d2a38   ( 131 kB)
      .data : 0xc03d4000 - 0xc03f8a20   ( 147 kB)
       .bss : 0xc03f8a20 - 0xc0422100   ( 166 kB)
NR_IRQS:16 nr_irqs:16 16
GIC CPU mask not found - kernel will fail to boot.
GIC CPU mask not found - kernel will fail to boot.
sched_clock: 32 bits at 1kHz, resolution 976562ns, wraps every 2097152000000000ns
Calibrating delay loop (skipped) preset value.. 532.00 BogoMIPS (lpj=260000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x60312b28 - 0x60312b5c
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
pinctrl core: initialized pinctrl subsystem
regulator-dummy: no parameters
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
renesas_intc_irqpin renesas_intc_irqpin: driving 4 irqs
L310 cache controller enabled
l2x0: 16 ways, CACHE_ID 0x410000c6, AUX_CTRL 0x42460000, Cache size: 1024 kB
sh-pfc pfc-r8a7778: r8a7778_pfc support registered
fixed-dummy: no parameters
fixed-3.3V: at 3300 mV 
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Linux video capture interface: v2.00
sh_tmu sh_tmu.0: used for clock events
sh_tmu sh_tmu.0: used for periodic clock events
sh_tmu sh_tmu.1: used as clock source
Advanced Linux Sound Architecture Driver Initialized.
Switched to clocksource sh_tmu.1
NET: Registered protocol family 2
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP: reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
futex hash table entries: 256 (order: -1, 3072 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
nfs4filelayout_init: NFSv4 File Layout Driver Registering...
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered (default)
SuperH (H)SCI(F) driver initialized
sh-sci.0: ttySC0 at MMIO 0xffe40000 (irq = 102, base_baud = 0) is a scif
console [ttySC0] enabled
sh-sci.1: ttySC1 at MMIO 0xffe41000 (irq = 103, base_baud = 0) is a scif
sh-sci.2: ttySC2 at MMIO 0xffe42000 (irq = 104, base_baud = 0) is a scif
sh-sci.3: ttySC3 at MMIO 0xffe43000 (irq = 105, base_baud = 0) is a scif
sh-sci.4: ttySC4 at MMIO 0xffe44000 (irq = 106, base_baud = 0) is a scif
sh-sci.5: ttySC5 at MMIO 0xffe45000 (irq = 107, base_baud = 0) is a scif
m25p80 spi0.0: found at26df081a, expected s25fl008k
m25p80 spi0.0: at26df081a (1024 Kbytes)
Creating 1 MTD partitions on "m25p80":
0x000000000000-0x000000100000 : "data(spi)"
libphy: smsc911x-mdio: probed
smsc911x smsc911x eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=smsc911x-fffffff:01, irq=-1)
smsc911x smsc911x eth0: MAC Address: 2e:09:0a:00:2f:04
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-platform: EHCI generic platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-platform: OHCI generic platform driver
usbcore: registered new interface driver usb-storage
rtc-rx8581 0-0051: chip found, driver version 0.1
rtc-rx8581 0-0051: low voltage detected, date/time is not reliable.
rtc-rx8581 0-0051: rtc core: registered rtc-rx8581 as rtc0
i2c-rcar i2c-rcar.0: probed
i2c-rcar i2c-rcar.1: probed
i2c-rcar i2c-rcar.2: probed
i2c-rcar i2c-rcar.3: probed
soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
ml86v7667 0-0041: chip found @ 0x41 (i2c-rcar)
soc-camera-pdrv soc-camera-pdrv.1: Probing soc-camera-pdrv.1
ml86v7667 0-0043: chip found @ 0x43 (i2c-rcar)
sh_mobile_sdhi.0 supply vmmc not found, using dummy regulator
sh_mobile_sdhi sh_mobile_sdhi.0: Failed getting OCR mask: -22
sh_mobile_sdhi sh_mobile_sdhi.0: could not set regulator OCR (-22)
sh_mobile_sdhi sh_mobile_sdhi.0: mmc0 base at 0xffe4c000 clock rate 66 MHz
sh_mmcif sh_mmcif: driver version 2010-04-28
asoc-simple-card asoc-simple-card.0: ASoC: CPU DAI rsnd-dai.0 not registered
platform asoc-simple-card.0: Driver asoc-simple-card requests probe deferral
asoc-simple-card asoc-simple-card.1: ASoC: CPU DAI rsnd-dai.1 not registered
platform asoc-simple-card.1: Driver asoc-simple-card requests probe deferral
asoc-simple-card asoc-simple-card.2: ASoC: CPU DAI rsnd-dai.2 not registered
platform asoc-simple-card.2: Driver asoc-simple-card requests probe deferral
asoc-simple-card asoc-simple-card.3: ASoC: CPU DAI rsnd-dai.3 not registered
platform asoc-simple-card.3: Driver asoc-simple-card requests probe deferral
asoc-simple-card asoc-simple-card.4: ASoC: CPU DAI rsnd-dai.4 not registered
platform asoc-simple-card.4: Driver asoc-simple-card requests probe deferral
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] ARM
CPU: 0 PID: 1 Comm: swapper Not tainted 3.15.0-rc1-00017-gad32d0c #123
task: cf827a40 ti: cf828000 task.ti: cf828000
PC is at rsnd_gen_dma_addr+0x40/0x1dc
LR is at rsnd_gen_dma_addr+0x38/0x1dc
pc : [<c026402c>]    lr : [<c0264024>]    psr: 60000113
sp : cf829c38  ip : 00000003  fp : cf829cdc
r10: cf8e5600  r9 : 00000000  r8 : cf8e5610
r7 : 00000001  r6 : cf9a3e0c  r5 : cf9a7c24  r4 : cf829ce8
r3 : 00000003  r2 : 00000000  r1 : 00000200  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 60004059  DAC: 00000015
Process swapper (pid: 1, stack limit = 0xcf828238)
Stack: (0xcf829c38 to 0xcf82a000)
9c20:                                                       c0088644 c00886f8
9c40: cf9b01e0 c032a990 00000000 cf9b5990 cf829c8c cf829c60 c016f7c8 c016e798
9c60: c016f70c cf9b01e0 c03ea34c c03ea35c 0000001f c016fab8 00200200 cf829d2c
9c80: cf829ca4 cf829c90 c016d628 c016f718 00000003 cf9b04d0 cf829cdc cf829ca8
9ca0: c016dc04 c0311854 00000000 cf9b01e0 cf829cd4 cf9a3e0c 00000001 cf9b5990
9cc0: cf829d1c cf8e5610 00000000 0000001f cf829d5c cf829ce0 c0263348 c0263ff8
9ce0: 0000001f ffffffff cf829d14 cf8e1f80 cf9a3630 cf9a7d90 00000060 00000004
9d00: 00000000 c03e0fd8 c03e1098 cf9a7dc8 cf829d34 cf829d20 c0262c14 c0007874
9d20: cf8e1f80 cf9a3630 cf829d7c 00000200 c0262e98 cf8e5600 c03e0fb4 00000005
9d40: cf9a7c1c 00000000 00000000 cf9b5990 cf829d7c cf829d60 c0265d08 c0263208
9d60: c03f40e0 cf9a7c18 cf9a7c10 cf9a7c10 cf829dcc cf829d80 c0262850 c0265c90
9d80: cf829db4 cf8e5610 c02641c8 c0265f6c c0264c7c c026663c c0265630 c0262cd8
9da0: 00000000 cf8e5610 c03f3d14 c0416bb8 00000000 00000000 c03d29e0 c03f3d14
9dc0: cf829de4 cf829dd0 c018fd88 c026274c cf8e5610 c0416bb0 cf829e0c cf829de8
9de0: c018ecb8 c018fd74 cf8e5610 c03f3d14 cf8e5644 00000000 c03b24c0 00000000
9e00: cf829e2c cf829e10 c018ee5c c018ebac cf8e8e3c c03f3d14 00000000 c018edc8
9e20: cf829e54 cf829e30 c018d32c c018edd4 cf818ecc cf8e8e30 cf9b5a34 c03f3d14
9e40: cf9b5a00 c03eb348 cf829e64 cf829e58 c018e990 c018d2dc cf829e8c cf829e68
9e60: c018db54 c018e978 c0380c40 cf829e78 c03f3d14 00000006 c03cd314 c03c69dc
9e80: cf829ea4 cf829e90 c018f27c c018da80 c03cd334 00000006 cf829eb4 cf829ea8
9ea0: c0190590 c018f208 cf829ec4 cf829eb8 c03c69f4 c019054c cf829f54 cf829ec8
9ec0: c03b2af4 c03c69e8 c040c9b4 c03f8a40 00000000 c03b0410 cf829f04 cf829ee8
9ee0: cf829f0c cf829ef0 cf829f00 cf829ef8 c03b24c0 c03b0410 cfdf7a3c 0000005c
9f00: cf829f54 cf829f10 c0030398 c03b24cc 00000000 00000006 00000006 c03afe50
9f20: 00000000 c039d11c cf829f54 c03cd334 00000006 c03cd314 c03f8a40 c03b24c0
9f40: c03d29e0 0000005c cf829f94 cf829f58 c03b2c98 c03b2a60 00000006 00000006
9f60: c03b24c0 3e9b7ef7 dfdf4fed 00000000 c030ce98 00000000 00000000 00000000
9f80: 00000000 00000000 cf829fac cf829f98 c030cea8 c03b2bb4 00000000 00000000
9fa0: 00000000 cf829fb0 c000e298 c030cea4 00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 5e3decfa e74e5bde
Backtrace: 
[<c0263fec>] (rsnd_gen_dma_addr) from [<c0263348>] (rsnd_dma_init+0x14c/0x24c)
 r10:0000001f r9:00000000 r8:cf8e5610 r7:cf829d1c r6:cf9b5990 r5:00000001
 r4:cf9a3e0c
[<c02631fc>] (rsnd_dma_init) from [<c0265d08>] (rsnd_ssi_dma_probe+0x84/0xa4)
 r10:cf9b5990 r9:00000000 r8:00000000 r7:cf9a7c1c r6:00000005 r5:c03e0fb4
 r4:cf8e5600
[<c0265c84>] (rsnd_ssi_dma_probe) from [<c0262850>] (rsnd_probe+0x110/0x258)
 r6:cf9a7c10 r5:cf9a7c10 r4:cf9a7c18 r3:c03f40e0
[<c0262740>] (rsnd_probe) from [<c018fd88>] (platform_drv_probe+0x20/0x50)
 r10:c03f3d14 r9:c03d29e0 r8:00000000 r7:00000000 r6:c0416bb8 r5:c03f3d14
 r4:cf8e5610
[<c018fd68>] (platform_drv_probe) from [<c018ecb8>] (driver_probe_device+0x118/0x228)
 r5:c0416bb0 r4:cf8e5610
[<c018eba0>] (driver_probe_device) from [<c018ee5c>] (__driver_attach+0x94/0x98)
 r10:00000000 r8:c03b24c0 r7:00000000 r6:cf8e5644 r5:c03f3d14 r4:cf8e5610
[<c018edc8>] (__driver_attach) from [<c018d32c>] (bus_for_each_dev+0x5c/0x90)
 r6:c018edc8 r5:00000000 r4:c03f3d14 r3:cf8e8e3c
[<c018d2d0>] (bus_for_each_dev) from [<c018e990>] (driver_attach+0x24/0x28)
 r6:c03eb348 r5:cf9b5a00 r4:c03f3d14
[<c018e96c>] (driver_attach) from [<c018db54>] (bus_add_driver+0xe0/0x1c8)
[<c018da74>] (bus_add_driver) from [<c018f27c>] (driver_register+0x80/0xfc)
 r7:c03c69dc r6:c03cd314 r5:00000006 r4:c03f3d14
[<c018f1fc>] (driver_register) from [<c0190590>] (__platform_driver_register+0x50/0x64)
 r5:00000006 r4:c03cd334
[<c0190540>] (__platform_driver_register) from [<c03c69f4>] (rsnd_driver_init+0x18/0x20)
[<c03c69dc>] (rsnd_driver_init) from [<c03b2af4>] (do_one_initcall+0xa0/0x154)
[<c03b2a54>] (do_one_initcall) from [<c03b2c98>] (kernel_init_freeable+0xf0/0x1b8)
 r10:0000005c r9:c03d29e0 r8:c03b24c0 r7:c03f8a40 r6:c03cd314 r5:00000006
 r4:c03cd334
[<c03b2ba8>] (kernel_init_freeable) from [<c030cea8>] (kernel_init+0x10/0xec)
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c030ce98
 r4:00000000
[<c030ce98>] (kernel_init) from [<c000e298>] (ret_from_fork+0x14/0x3c)
 r4:00000000 r3:00000000
Code: e1a07003 ebfcaf68 e3a01c02 e3a02000 (e5908000) 
---[ end trace 421d78826f73f05e ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
