From: Rick Thomas <rbthomas-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: DTS: kirkwood-openrd-client: fix audio
Date: Mon, 25 Jan 2016 19:50:55 -0800
Message-ID: <B9F504A1-867C-4B99-98CF-8EDE3A0BEB38@pobox.com>
References: <1453588600-14831-1-git-send-email-aaro.koskinen@iki.fi> <1453588600-14831-2-git-send-email-aaro.koskinen@iki.fi> <20160124173701.GU3880@lunn.ch> <411C1DFA-3E76-42B0-866C-7C3C0D990039@pobox.com> <20160124214020.GA28667@jirafa.cyrius.com> <8E11A1EE-D73B-462E-A493-39571A17F2C3@pobox.com> <20160125182459.GE15550@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: multipart/mixed; boundary="Apple-Mail=_3FE2F279-D4CF-4748-8E77-B313601E6A83"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160125182459.GE15550-4/PLUo9XfK9owWHViPbQSXlKr5M7+etX9Sl0XMgJPXI@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: Martin Michlmayr <tbm-R+vWnYXSFMfQT0dZR+AlfA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--Apple-Mail=_3FE2F279-D4CF-4748-8E77-B313601E6A83
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


On Jan 25, 2016, at 10:24 AM, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org> wrote:

> 
> On my board I need to say "amixer set PCM on". Can you post the full
> output from "amixer" without any parameters?
> 
> Also check if you have this line in dmesg:
> 
> 	asoc-simple-card sound: cs42l51-hifi <-> i2s mapping ok
> 
> If it says "spdif" the player runs but is silent.
> 
> A.
> 

Here's the output of "amixer"


--Apple-Mail=_3FE2F279-D4CF-4748-8E77-B313601E6A83
Content-Disposition: attachment;
	filename=amixer.out
Content-Type: application/octet-stream;
	name="amixer.out"
Content-Transfer-Encoding: 7bit

Simple mixer control 'Bass',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 7 [47%] [0.00dB]
Simple mixer control 'Treble',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 7 [47%] [0.00dB]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 103 [81%] [0.00dB] [on]
  Front Right: Playback 103 [81%] [0.00dB] [on]
Simple mixer control 'PCM channel mixer',0
  Capabilities: enum
  Items: 'L R' 'L+R' 'R L'
  Item0: 'L R'
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 1
  Front Left: 0 [0%] [16.00dB]
  Front Right: 0 [0%] [16.00dB]
Simple mixer control 'Playback Deemphasis',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'ADC Mixer',0
  Capabilities: volume pswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 127
  Front Left: 103 [81%] [0.00dB] Playback [on]
  Front Right: 103 [81%] [0.00dB] Playback [on]
Simple mixer control 'Analog',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 228
  Mono:
  Front Left: Playback 204 [89%] [0.00dB]
  Front Right: Playback 204 [89%] [0.00dB]
Simple mixer control 'Auto-Mute',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'PGA-ADC Mux Left',0
  Capabilities: enum
  Items: 'AIN1 Left' 'AIN2 Left' 'MIC Left' 'MIC+preamp Left'
  Item0: 'AIN1 Left'
Simple mixer control 'PGA-ADC Mux Right',0
  Capabilities: enum
  Items: 'AIN1 Right' 'AIN2 Right' 'MIC Right' 'MIC+preamp Right'
  Item0: 'AIN1 Right'
Simple mixer control 'Soft Ramp',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]

--Apple-Mail=_3FE2F279-D4CF-4748-8E77-B313601E6A83
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



This is after having run alsamixer (per Martin's suggestion) and =
un-mute-ing everything I could find.

And here's the output of "dmesg"


--Apple-Mail=_3FE2F279-D4CF-4748-8E77-B313601E6A83
Content-Disposition: attachment;
	filename=dmesg.out
Content-Type: application/octet-stream;
	name="dmesg.out"
Content-Transfer-Encoding: 7bit

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.3.0-1-kirkwood (debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org) (gcc version 4.9.3 (Debian 4.9.3-10) ) #1 Debian 4.3.3-7test1 (2016-01-19)
[    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=0005317f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine model: OpenRD Client
[    0.000000] Memory policy: Data cache writeback
[    0.000000] On node 0 totalpages: 131072
[    0.000000] free_area_init_node: node 0, pgdat c0590e4c, node_mem_map dfbf8000
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 131072 pages, LIFO batch:31
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
[    0.000000] Kernel command line: console=ttyS0,115200
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 502084K/524288K available (3724K kernel code, 328K rwdata, 1384K rodata, 264K init, 292K bss, 22204K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
                   vector  : 0xffff0000 - 0xffff1000   (   4 kB)
                   fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
                   vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
                   lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
                   pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
                   modules : 0xbf000000 - 0xbfe00000   (  14 MB)
                     .text : 0xc0008000 - 0xc05053d4   (5109 kB)
                     .init : 0xc0506000 - 0xc0548000   ( 264 kB)
                     .data : 0xc0548000 - 0xc059a200   ( 329 kB)
                      .bss : 0xc059a200 - 0xc05e326c   ( 293 kB)
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] clocksource: orion_clocksource: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 9556302233 ns
[    0.000009] sched_clock: 32 bits at 200MHz, resolution 5ns, wraps every 10737418237ns
[    0.000304] Console: colour dummy device 80x30
[    0.000331] Calibrating delay loop... 1191.93 BogoMIPS (lpj=2383872)
[    0.020059] pid_max: default: 32768 minimum: 301
[    0.020170] Security Framework initialized
[    0.020185] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.020274] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.020293] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.021084] Initializing cgroup subsys io
[    0.021129] Initializing cgroup subsys devices
[    0.021153] Initializing cgroup subsys freezer
[    0.021173] Initializing cgroup subsys net_cls
[    0.021201] Initializing cgroup subsys perf_event
[    0.021225] Initializing cgroup subsys net_prio
[    0.021293] CPU: Testing write buffer coherency: ok
[    0.021389] ftrace: allocating 15958 entries in 32 pages
[    0.046027] Setting up static identity map for 0x8200 - 0x823c
[    0.046297] mvebu-soc-id: MVEBU SoC ID=0x6281, Rev=0x2
[    0.048663] devtmpfs: initialized
[    0.053106] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.053526] pinctrl core: initialized pinctrl subsystem
[    0.054794] NET: Registered protocol family 16
[    0.055154] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.056246] cpuidle: using governor ladder
[    0.056272] cpuidle: using governor menu
[    0.056579] Feroceon L2: Enabling L2
[    0.056620] Feroceon L2: Cache support initialised.
[    0.056882] [Firmware Info]: /ocp@f1000000/ethernet-controller@72000/ethernet0-port@0: local-mac-address is not set
[    0.056977] [Firmware Info]: /ocp@f1000000/ethernet-controller@76000/ethernet1-port@0: local-mac-address is not set
[    0.060812] No ATAGs?
[    0.065733] clocksource: Switched to clocksource orion_clocksource
[    0.086769] NET: Registered protocol family 2
[    0.087515] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.087575] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.087625] TCP: Hash tables configured (established 4096 bind 4096)
[    0.087691] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.087725] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.087927] NET: Registered protocol family 1
[    0.087978] PCI: CLS 0 bytes, default 32
[    0.088215] Unpacking initramfs...
[    1.106205] Freeing initrd memory: 11580K (c1100000 - c1c4f000)
[    1.107033] futex hash table entries: 256 (order: -1, 3072 bytes)
[    1.107097] audit: initializing netlink subsys (disabled)
[    1.107165] audit: type=2000 audit(1.100:1): initialized
[    1.107755] zbud: loaded
[    1.107986] VFS: Disk quotas dquot_6.6.0
[    1.108044] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.108152] jffs2: version 2.2. (NAND) (SUMMARY)  \xffffffc2\xffffffa9 2001-2006 Red Hat, Inc.
[    1.110079] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    1.110246] io scheduler noop registered
[    1.110298] io scheduler cfq registered (default)
[    1.111556] kirkwood-pinctrl f1010000.pin-controller: registered pinctrl driver
[    1.111880] GPIO line 28 (SelRS232or485) hogged as output/low
[    1.112190] irq: Cannot allocate irq_descs @ IRQ36, assuming pre-allocated
[    1.112330] GPIO line 34 (SelUARTorSD) hogged as output/high
[    1.112571] irq: Cannot allocate irq_descs @ IRQ68, assuming pre-allocated
[    1.113334] mvebu-pcie mbus:pcie-controller: PCI host bridge to bus 0000:00
[    1.113353] pci_bus 0000:00: root bus resource [io  0x1000-0xfffff]
[    1.113366] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xefffffff]
[    1.113379] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.113409] pci 0000:00:01.0: [11ab:6281] type 01 class 0x060400
[    1.113641] PCI: bus0: Fast back to back transfers disabled
[    1.113656] pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.113874] pci 0000:01:00.0: [18ca:0027] type 00 class 0x030000
[    1.113921] pci 0000:01:00.0: reg 0x10: [mem 0x40000000-0x43ffffff pref]
[    1.113943] pci 0000:01:00.0: reg 0x14: [mem 0x44000000-0x4403ffff]
[    1.113963] pci 0000:01:00.0: reg 0x18: [io  0xf0000000-0xf000007f]
[    1.114007] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    1.114053] pci 0000:01:00.0: supports D1 D2
[    1.114264] PCI: bus1: Fast back to back transfers disabled
[    1.114280] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    1.114321] pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe5ffffff]
[    1.114336] pci 0000:00:01.0: BAR 7: assigned [io  0x10000-0x10fff]
[    1.114355] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0000000-0xe3ffffff pref]
[    1.114373] pci 0000:01:00.0: BAR 1: assigned [mem 0xe4000000-0xe403ffff]
[    1.114391] pci 0000:01:00.0: BAR 6: assigned [mem 0xe4040000-0xe404ffff pref]
[    1.114405] pci 0000:01:00.0: BAR 2: assigned [io  0x10000-0x1007f]
[    1.114420] pci 0000:00:01.0: PCI bridge to [bus 01]
[    1.114432] pci 0000:00:01.0:   bridge window [io  0x10000-0x10fff]
[    1.114446] pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe5ffffff]
[    1.114755] mv_xor f1060800.xor: Marvell shared XOR driver
[    1.134966] mv_xor f1060800.xor: Marvell XOR (Registers Mode): ( xor cpy intr )
[    1.135149] mv_xor f1060900.xor: Marvell shared XOR driver
[    1.154958] mv_xor f1060900.xor: Marvell XOR (Registers Mode): ( xor cpy intr )
[    1.155358] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    1.156457] console [ttyS0] disabled
[    1.156511] f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 27, base_baud = 12500000) is a 16550A
[    1.788094] console [ttyS0] enabled
[    1.792926] nand: device found, Manufacturer ID: 0xec, Chip ID: 0xdc
[    1.799339] nand: Samsung NAND 512MiB 3,3V 8-bit
[    1.803993] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    1.811629] Scanning device for bad blocks
[    2.020537] Bad eraseblock 2700 at 0x000015180000
[    2.043069] Bad eraseblock 2935 at 0x000016ee0000
[    2.128380] Bad eraseblock 3998 at 0x00001f3c0000
[    2.133155] Bad eraseblock 3999 at 0x00001f3e0000
[    2.145183] 3 ofpart partitions found on MTD device orion_nand
[    2.151056] Creating 3 MTD partitions on "orion_nand":
[    2.156230] 0x000000000000-0x000000100000 : "u-boot"
[    2.162365] 0x000000100000-0x000000500000 : "uImage"
[    2.168343] 0x000000600000-0x000020000000 : "root"
[    2.175693] mousedev: PS/2 mouse device common for all mice
[    2.181818] rtc-mv f1010300.rtc: rtc core: registered f1010300.rtc as rtc0
[    2.188861] i2c /dev entries driver
[    2.193982] ledtrig-cpu: registered to indicate activity on CPUs
[    2.200436] NET: Registered protocol family 17
[    2.205538] registered taskstats version 1
[    2.209785] zswap: loaded using pool lzo/zbud
[    2.214709] rtc-mv f1010300.rtc: setting system clock to 2016-01-26 03:18:28 UTC (1453778308)
[    2.225271] Freeing unused kernel memory: 264K (c0506000 - c0548000)
[    2.304659] random: systemd-udevd urandom read with 7 bits of entropy available
[    2.536671] usbcore: registered new interface driver usbfs
[    2.557199] libphy: orion_mdio_bus: probed
[    2.585941] usbcore: registered new interface driver hub
[    2.613951] usbcore: registered new device driver usb
[    2.629075] SCSI subsystem initialized
[    2.648192] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.658109] mv643xx_eth: MV-643xx 10/100/1000 ethernet driver version 1.4
[    2.679036] mvsdio f1090000.mvsdio: Got CD GPIO
[    2.699275] ehci-orion: EHCI orion driver
[    2.705354] libata version 3.00 loaded.
[    2.733252] sata_mv f1080000.sata: version 1.28
[    2.733506] sata_mv f1080000.sata: slots 32 ports 2
[    2.762343] scsi host0: sata_mv
[    2.777145] scsi host1: sata_mv
[    2.780644] ata1: SATA max UDMA/133 irq 34
[    2.784800] ata2: SATA max UDMA/133 irq 34
[    2.788947] mmc0: host does not support reading read-only switch, assuming write-enable
[    3.311293] mmc0: new high speed SDHC card at address 8fe4
[    3.322275] orion-ehci f1050000.ehci: EHCI Host Controller
[    3.335292] orion-ehci f1050000.ehci: new USB bus registered, assigned bus number 1
[    3.360647] orion-ehci f1050000.ehci: irq 30, io mem 0xf1050000
[    3.389791] orion-ehci f1050000.ehci: USB 2.0 started, EHCI 1.00
[    3.406250] ata1: SATA link down (SStatus 0 SControl F300)
[    3.413134] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.419993] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.427269] usb usb1: Product: EHCI Host Controller
[    3.432184] usb usb1: Manufacturer: Linux 4.3.0-1-kirkwood ehci_hcd
[    3.438499] usb usb1: SerialNumber: f1050000.ehci
[    3.509564] hub 1-0:1.0: USB hub found
[    3.521684] hub 1-0:1.0: 1 port detected
[    3.532274] mmcblk0: mmc0:8fe4 SD16G 14.8 GiB 
[    3.546417]  mmcblk0: p1
[    4.057438] mv643xx_eth_port mv643xx_eth_port.0 eth0: port 0 with MAC address 00:50:43:01:a2:7e
[    5.128339] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl F300)
[    5.142063] mv643xx_eth_port mv643xx_eth_port.1 eth1: port 0 with MAC address 00:50:43:01:a2:7f
[    5.150892] ata2.00: ATA-8: HGST HTS721010A9E630, JB0OA3J0, max UDMA/133
[    5.157642] ata2.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    5.189774] usb 1-1: new high-speed USB device number 2 using orion-ehci
[    5.196878] ata2.00: configured for UDMA/133
[    5.201901] scsi 1:0:0:0: Direct-Access     ATA      HGST HTS721010A9 A3J0 PQ: 0 ANSI: 5
[    5.239148] sd 1:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
[    5.246931] sd 1:0:0:0: [sda] 4096-byte physical blocks
[    5.253931] sd 1:0:0:0: [sda] Write Protect is off
[    5.258823] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.261356] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.312930]  sda: sda1 sda2 sda3 sda4 < sda5 >
[    5.323587] sd 1:0:0:0: [sda] Attached SCSI disk
[    5.350289] usb 1-1: New USB device found, idVendor=0424, idProduct=2517
[    5.357064] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.373548] hub 1-1:1.0: USB hub found
[    5.377534] hub 1-1:1.0: 7 ports detected
[    5.653785] usb 1-1.4: new high-speed USB device number 3 using orion-ehci
[    5.775528] usb 1-1.4: New USB device found, idVendor=090c, idProduct=1000
[    5.782767] usb 1-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    5.790181] usb 1-1.4: Product: Flash Drive
[    5.794400] usb 1-1.4: Manufacturer: Samsung
[    5.798706] usb 1-1.4: SerialNumber: 0334015100002306
[    5.821702] usb-storage 1-1.4:1.0: USB Mass Storage device detected
[    5.828423] scsi host2: usb-storage 1-1.4:1.0
[    5.835029] usbcore: registered new interface driver usb-storage
[    5.845557] usbcore: registered new interface driver uas
[    7.127384] scsi 2:0:0:0: Direct-Access     Samsung  Flash Drive      1100 PQ: 0 ANSI: 6
[    7.138959] sd 2:0:0:0: [sdb] 31326208 512-byte logical blocks: (16.0 GB/14.9 GiB)
[    7.156350] sd 2:0:0:0: [sdb] Write Protect is off
[    7.161217] sd 2:0:0:0: [sdb] Mode Sense: 43 00 00 00
[    7.169449] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    7.187182]  sdb: sdb1 sdb2 sdb3 < sdb5 >
[    7.200472] sd 2:0:0:0: [sdb] Attached SCSI removable disk
[    8.200899] EXT4-fs (sdb2): mounted filesystem with ordered data mode. Opts: (null)
[    8.210940] random: nonblocking pool is initialized
[    8.672001] NET: Registered protocol family 10
[    8.678289] systemd[1]: Failed to insert module 'kdbus': Function not implemented
[    8.717803] systemd[1]: systemd 228 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
[    8.736420] systemd[1]: Detected architecture arm.
[    8.755066] systemd[1]: Set hostname to <base>.
[    9.276375] systemd[1]: display-manager.service: Cannot add dependency job, ignoring: Unit display-manager.service failed to load: No such file or directory.
[    9.296041] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    9.318192] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    9.338120] systemd[1]: Listening on Syslog Socket.
[    9.354592] systemd[1]: Created slice System Slice.
[    9.370536] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    9.386536] systemd[1]: Created slice system-serial\x2dgetty.slice.
[    9.402064] systemd[1]: Listening on udev Kernel Socket.
[    9.418162] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    9.437947] systemd[1]: Reached target Paths.
[    9.450408] systemd[1]: Listening on Journal Audit Socket.
[    9.466149] systemd[1]: Listening on Journal Socket.
[    9.487576] systemd[1]: Mounting POSIX Message Queue File System...
[    9.513150] systemd[1]: Starting Load Kernel Modules...
[    9.538924] systemd[1]: Mounting Debug File System...
[    9.569554] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    9.606652] systemd[1]: Created slice system-getty.slice.
[    9.626012] systemd[1]: Reached target Remote File Systems (Pre).
[    9.641949] systemd[1]: Reached target Remote File Systems.
[    9.658110] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    9.678089] systemd[1]: Listening on Journal Socket (/dev/log).
[    9.697178] systemd[1]: Starting Journal Service...
[    9.714180] systemd[1]: Listening on udev Control Socket.
[    9.730255] systemd[1]: Reached target Encrypted Volumes.
[    9.746835] systemd[1]: Listening on fsck to fsckd communication Socket.
[    9.769713] systemd[1]: Starting Remount Root and Kernel File Systems...
[    9.794611] systemd[1]: Created slice User and Session Slice.
[    9.818060] systemd[1]: Reached target Slices.
[    9.857713] systemd[1]: Mounted Debug File System.
[    9.862645] EXT4-fs (sdb2): re-mounted. Opts: errors=remount-ro
[    9.890087] systemd[1]: Mounted POSIX Message Queue File System.
[    9.923506] systemd[1]: Started Load Kernel Modules.
[    9.951590] systemd[1]: Started Create list of required static device nodes for the current kernel.
[    9.983193] systemd[1]: Started Remount Root and Kernel File Systems.
[   10.010710] systemd[1]: Started Journal Service.
[   10.541158] systemd-journald[154]: Received request to flush runtime journal from PID 1
[   11.149339] MV-CESA:Could not register sha1 driver
[   11.154214] MV-CESA:Could not register hmac-sha1 driver
[   11.306775] xgifb: module is from the staging directory, the quality is unknown, you have been warned.
[   11.321848] orion_wdt: Initial timeout 21 sec
[   11.400229] xgifb 0000:01:00.0: Relocate IO address: 10000 [00010030]
[   11.406800] pci 0000:00:01.0: enabling device (0140 -> 0143)
[   11.412535] xgifb 0000:01:00.0: chipid = 32
[   11.416766] xgifb: SR14=51 DramSzie 2000000 ChannelNum 1
[   11.567483] cs42l51 0-004a: Cirrus Logic CS42L51, Revision: 01
[   11.613181] sd 1:0:0:0: Attached scsi generic sg0 type 0
[   11.620784] xgifb 0000:01:00.0: Framebuffer at 0xe0000000, mapped to 0xe1000000, size 32768k
[   11.629330] xgifb 0000:01:00.0: MMIO at 0xe4000000, mapped to 0xe0f00000, size 256k
[   11.640801] xgifb 0000:01:00.0: No or unknown bridge type detected
[   11.647036] xgifb: Default mode is 800x600x16 (60Hz)
[   11.678010] sd 2:0:0:0: Attached scsi generic sg1 type 0
[   11.777850] asoc-simple-card sound: cs42l51-hifi <-> i2s mapping ok
[   11.837937] cs42l51 0-004a: ASoC: mux DAC Mux has no paths
[   13.182598] Adding 698364k swap on /dev/sdb5.  Priority:-1 extents:1 across:698364k FS
[   13.497773] EXT4-fs (sdb1): mounting ext2 file system using the ext4 subsystem
[   13.534109] EXT4-fs (sdb1): mounted filesystem without journal. Opts: (null)
[   13.878770] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[   15.203621] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   18.323832] mv643xx_eth_port mv643xx_eth_port.0 eth0: link up, 1000 Mb/s, full duplex, flow control disabled
[   18.333788] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

--Apple-Mail=_3FE2F279-D4CF-4748-8E77-B313601E6A83
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii



In particular

> rbthomas@base:~$ dmesg | grep sound    
> [   11.777850] asoc-simple-card sound: cs42l51-hifi <-> i2s mapping ok

Everything is working fine now.

Thanks for all the help!
Rick


--Apple-Mail=_3FE2F279-D4CF-4748-8E77-B313601E6A83--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
