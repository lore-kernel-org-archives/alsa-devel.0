From: Chris Cavey <chris-alsa@rauros.net>
Subject: Re: M-Audio FastTrack C400
Date: Thu, 19 Apr 2012 07:19:06 -0400
Message-ID: <4F8FF4AA.2090506@rauros.net>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
	<4F8E6CA2.8010005@ladisch.de> <4F8F7213.8070206@rauros.net>
	<4F8FD2A7.60700@ladisch.de> <4F8FE83E.2070600@rauros.net>
	<CACckToWQr=XBNH+p+twGzKQscjZs5WyG3jazJ79x9jpU=DteGg@mail.gmail.com>
Reply-To: chris-alsa@rauros.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------010009070107060506050903
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vms173001pub.verizon.net (vms173001pub.verizon.net
	[206.46.173.1]) by alsa0.perex.cz (Postfix) with ESMTP id 8234610B8DC
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2012 13:18:11 +0200 (CEST)
Received: from rauros.net ([unknown] [74.107.69.179])
	by vms173001.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0M2Q000QU4PQ0UD6@vms173001.mailsrvcs.net> for
	alsa-devel@alsa-project.org; Thu, 19 Apr 2012 06:17:52 -0500 (CDT)
In-reply-to: <CACckToWQr=XBNH+p+twGzKQscjZs5WyG3jazJ79x9jpU=DteGg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010009070107060506050903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

entire log

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.2.0-23-generic (buildd@crested) (gcc 
version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu4) ) #36-Ubuntu SMP Tue Apr 10 
20:39:51 UTC 2012 (Ubuntu 3.2.0-23.36-generic 3.2.14)
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.2.0-23-generic 
root=UUID=ec96128d-feb6-40e6-a5aa-b55aa2219935 ro
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000dfff0000 (usable)
[    0.000000]  BIOS-e820: 00000000dfff0000 - 00000000e0000000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.5 present.
[    0.000000] DMI: innotek GmbH VirtualBox, BIOS VirtualBox 12/01/2006
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 
(usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 
(usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x120000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR variable ranges disabled:
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 
0x7010600070106
[    0.000000] CPU MTRRs all blank - virtualized system.
[    0.000000] last_pfn = 0xdfff0 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [ffff88000009fff0] 9fff0
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff88000009a000] 9a000 size 20480
[    0.000000] init_memory_mapping: 0000000000000000-00000000dfff0000
[    0.000000]  0000000000 - 00dfe00000 page 2M
[    0.000000]  00dfe00000 - 00dfff0000 page 4k
[    0.000000] kernel direct mapping tables up to dfff0000 @ 
1fffa000-20000000
[    0.000000] init_memory_mapping: 0000000100000000-0000000120000000
[    0.000000]  0100000000 - 0120000000 page 2M
[    0.000000] kernel direct mapping tables up to 120000000 @ 
dffea000-dfff0000
[    0.000000] RAMDISK: 364ec000 - 3726e000
[    0.000000] ACPI: RSDP 00000000000e0000 00024 (v02 VBOX  )
[    0.000000] ACPI: XSDT 00000000dfff0030 0003C (v01 VBOX   VBOXXSDT 
00000001 ASL  00000061)
[    0.000000] ACPI: FACP 00000000dfff00f0 000F4 (v04 VBOX   VBOXFACP 
00000001 ASL  00000061)
[    0.000000] ACPI: DSDT 00000000dfff0480 01B96 (v01 VBOX   VBOXBIOS 
00000002 INTL 20100528)
[    0.000000] ACPI: FACS 00000000dfff0200 00040
[    0.000000] ACPI: APIC 00000000dfff0240 0006C (v02 VBOX   VBOXAPIC 
00000001 ASL  00000061)
[    0.000000] ACPI: SSDT 00000000dfff02b0 001CC (v01 VBOX   VBOXCPUT 
00000002 INTL 20100528)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000120000000
[    0.000000] Initmem setup node 0 0000000000000000-0000000120000000
[    0.000000]   NODE_DATA [000000011fffb000 - 000000011fffffff]
[    0.000000]  [ffffea0000000000-ffffea00047fffff] PMD -> 
[ffff88011b600000-ffff88011f5fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00120000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x000dfff0
[    0.000000]     0: 0x00100000 -> 0x00120000
[    0.000000] On node 0 totalpages: 1048447
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3914 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 16320 pages used for memmap
[    0.000000]   DMA32 zone: 897072 pages, LIFO batch:31
[    0.000000]   Normal zone: 2048 pages used for memmap
[    0.000000]   Normal zone: 129024 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 
0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 
00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 
00000000000f0000
[    0.000000] PM: Registered nosave memory: 00000000000f0000 - 
0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000dfff0000 - 
00000000e0000000
[    0.000000] PM: Registered nosave memory: 00000000e0000000 - 
00000000fffc0000
[    0.000000] PM: Registered nosave memory: 00000000fffc0000 - 
0000000100000000
[    0.000000] Allocating PCI resources starting at e0000000 (gap: 
e0000000:1ffc0000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 
nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88011fc00000 s83072 
r8192 d23424 u524288
[    0.000000] pcpu-alloc: s83072 r8192 d23424 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3
[    0.000000] Built 1 zonelists in Node order, mobility grouping on. 
Total pages: 1030010
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: 
BOOT_IMAGE=/boot/vmlinuz-3.2.0-23-generic 
root=UUID=ec96128d-feb6-40e6-a5aa-b55aa2219935 ro
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 4032084k/4718592k available (6566k kernel code, 
524804k absent, 161704k reserved, 6637k data, 920k init)
[    0.000000] SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, 
CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:16640 nr_irqs:712 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 33554432 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't 
want memory cgroups
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 3385.153 MHz processor.
[    0.004003] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 6770.30 BogoMIPS (lpj=13540612)
[    0.004007] pid_max: default: 32768 minimum: 301
[    0.004023] Security Framework initialized
[    0.004033] AppArmor: AppArmor initialized
[    0.004035] Yama: becoming mindful.
[    0.004588] Dentry cache hash table entries: 524288 (order: 10, 
4194304 bytes)
[    0.005520] Inode-cache hash table entries: 262144 (order: 9, 2097152 
bytes)
[    0.005792] Mount-cache hash table entries: 256
[    0.005903] Initializing cgroup subsys cpuacct
[    0.005908] Initializing cgroup subsys memory
[    0.005913] Initializing cgroup subsys devices
[    0.005916] Initializing cgroup subsys freezer
[    0.005918] Initializing cgroup subsys blkio
[    0.005922] Initializing cgroup subsys perf_event
[    0.006124] CPU: Physical Processor ID: 0
[    0.006127] CPU: Processor Core ID: 0
[    0.006143] mce: CPU supports 0 MCE banks
[    0.024772] ACPI: Core revision 20110623
[    0.025296] ftrace: allocating 27049 entries in 107 pages
[    0.036357] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.076499] CPU0: Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz stepping 07
[    0.080004] Performance Events: unsupported p6 CPU model 42 no PMU 
driver, software events only.
[    0.080004] NMI watchdog disabled (cpu0): hardware events not enabled
[    0.080004] Booting Node   0, Processors  #1
[    0.080004] smpboot cpu 1: start_ip = 9a000
[    0.008000] mce: CPU supports 0 MCE banks
[    0.168009] TSC synchronization [CPU#0 -> CPU#1]:
[    0.168009] Measured 195227 cycles TSC warp between CPUs, turning off 
TSC clock.
[    0.168009] Marking TSC unstable due to check_tsc_sync_source failed
[    0.168030] NMI watchdog disabled (cpu1): hardware events not enabled
[    0.168227]  #2
[    0.168228] smpboot cpu 2: start_ip = 9a000
[    0.008000] mce: CPU supports 0 MCE banks
[    0.256324] NMI watchdog disabled (cpu2): hardware events not enabled
[    0.256528]  #3 Ok.
[    0.256529] smpboot cpu 3: start_ip = 9a000
[    0.008000] mce: CPU supports 0 MCE banks
[    0.344331] NMI watchdog disabled (cpu3): hardware events not enabled
[    0.344371] Brought up 4 CPUs
[    0.344373] Total of 4 processors activated (27145.08 BogoMIPS).
[    0.345354] devtmpfs: initialized
[    0.345354] EVM: security.selinux
[    0.345354] EVM: security.SMACK64
[    0.345354] EVM: security.capability
[    0.345354] print_constraints: dummy:
[    0.345354] RTC time: 10:28:42, date: 04/19/12
[    0.345354] NET: Registered protocol family 16
[    0.345354] ACPI: bus type pci registered
[    0.345354] PCI: Using configuration type 1 for base access
[    0.345354] Trying to unpack rootfs image as initramfs...
[    0.348353] bio: create slab <bio-0> at 0
[    0.348353] ACPI: Added _OSI(Module Device)
[    0.348353] ACPI: Added _OSI(Processor Device)
[    0.348353] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.348353] ACPI: Added _OSI(Processor Aggregator Device)
[    0.348353] ACPI: EC: Look up EC in DSDT
[    0.348547] ACPI: Executed 1 blocks of module-level executable AML code
[    0.350447] ACPI: Interpreter enabled
[    0.350450] ACPI: (supports S0 S5)
[    0.350459] ACPI: Using IOAPIC for interrupt routing
[    0.352692] ACPI: No dock devices found.
[    0.352695] HEST: Table not found.
[    0.352697] PCI: Ignoring host bridge windows from ACPI; if 
necessary, use "pci=use_crs" and report a bug
[    0.352738] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.352813] pci_root PNP0A03:00: host bridge window [io 
0x0000-0x0cf7] (ignored)
[    0.352815] pci_root PNP0A03:00: host bridge window [io 
0x0d00-0xffff] (ignored)
[    0.352816] pci_root PNP0A03:00: host bridge window [mem 
0x000a0000-0x000bffff] (ignored)
[    0.352818] pci_root PNP0A03:00: host bridge window [mem 
0xe0000000-0xffdfffff] (ignored)
[    0.352852] pci 0000:00:00.0: [8086:1237] type 0 class 0x000600
[    0.353150] pci 0000:00:01.0: [8086:7000] type 0 class 0x000601
[    0.353567] pci 0000:00:01.1: [8086:7111] type 0 class 0x000101
[    0.353885] pci 0000:00:01.1: reg 20: [io  0xd000-0xd00f]
[    0.354120] pci 0000:00:02.0: [80ee:beef] type 0 class 0x000300
[    0.356449] pci 0000:00:02.0: reg 10: [mem 0xe0000000-0xe0ffffff pref]
[    0.372789] pci 0000:00:03.0: [1af4:1000] type 0 class 0x000200
[    0.372900] pci 0000:00:03.0: reg 10: [io  0xd020-0xd03f]
[    0.373432] pci 0000:00:04.0: [80ee:cafe] type 0 class 0x000880
[    0.376229] pci 0000:00:04.0: reg 10: [io  0xd040-0xd05f]
[    0.380229] pci 0000:00:04.0: reg 14: [mem 0xf0000000-0xf03fffff]
[    0.382891] pci 0000:00:04.0: reg 18: [mem 0xf0400000-0xf0403fff pref]
[    0.392444] pci 0000:00:06.0: [106b:003f] type 0 class 0x000c03
[    0.396234] pci 0000:00:06.0: reg 10: [mem 0xf0404000-0xf0404fff]
[    0.411054] pci 0000:00:07.0: [8086:7113] type 0 class 0x000680
[    0.412109] pci 0000:00:0b.0: [8086:265c] type 0 class 0x000c03
[    0.414940] pci 0000:00:0b.0: reg 10: [mem 0xf0405000-0xf0405fff]
[    0.431155] pci 0000:00:0d.0: [8086:2829] type 0 class 0x000106
[    0.432285] pci 0000:00:0d.0: reg 10: [io  0xd060-0xd067]
[    0.440252] pci 0000:00:0d.0: reg 18: [io  0xd070-0xd077]
[    0.444431] pci 0000:00:0d.0: reg 20: [io  0xd080-0xd08f]
[    0.448447] pci 0000:00:0d.0: reg 24: [mem 0xf0406000-0xf0407fff]
[    0.453161] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.454249]  pci0000:00: Unable to request _OSC control (_OSC support 
mask: 0x1e)
[    0.460028] ACPI: PCI Interrupt Link [LNKA] (IRQs *5 9 10 11)
[    0.460448] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 9 10 *11)
[    0.460566] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 9 *10 11)
[    0.460681] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 *9 10 11)
[    0.461127] vgaarb: device added: 
PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.461127] vgaarb: loaded
[    0.461127] vgaarb: bridge control possible 0000:00:02.0
[    0.461127] i2c-core: driver [aat2870] using legacy suspend method
[    0.461127] i2c-core: driver [aat2870] using legacy resume method
[    0.461127] SCSI subsystem initialized
[    0.461127] libata version 3.00 loaded.
[    0.461127] usbcore: registered new interface driver usbfs
[    0.461127] usbcore: registered new interface driver hub
[    0.461127] usbcore: registered new device driver usb
[    0.461127] PCI: Using ACPI for IRQ routing
[    0.461127] PCI: pci_cache_line_size set to 64 bytes
[    0.461127] reserve RAM buffer: 000000000009fc00 - 000000000009ffff
[    0.461127] reserve RAM buffer: 00000000dfff0000 - 00000000dfffffff
[    0.461127] NetLabel: Initializing
[    0.461127] NetLabel:  domain hash size = 128
[    0.461127] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.461127] NetLabel:  unlabeled traffic allowed by default
[    0.469329] AppArmor: AppArmor Filesystem Enabled
[    0.469352] pnp: PnP ACPI init
[    0.469365] ACPI: bus type pnp registered
[    0.469424] pnp 00:00: [bus 00-ff]
[    0.469425] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.469427] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.469428] pnp 00:00: [io  0x0d00-0xffff window]
[    0.469431] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.469432] pnp 00:00: [mem 0xe0000000-0xffdfffff window]
[    0.469454] pnp 00:00: Plug and Play ACPI device, IDs PNP0a03 (active)
[    0.469465] pnp 00:01: [io  0x0060]
[    0.469466] pnp 00:01: [io  0x0064]
[    0.469492] pnp 00:01: [irq 1]
[    0.469507] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.469513] pnp 00:02: [io  0x0000-0x000f]
[    0.469514] pnp 00:02: [io  0x0080-0x008f]
[    0.469515] pnp 00:02: [io  0x00c0-0x00df]
[    0.469516] pnp 00:02: [dma 4]
[    0.469527] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.469569] pnp 00:03: [irq 12]
[    0.469584] pnp 00:03: Plug and Play ACPI device, IDs PNP0f03 (active)
[    0.469593] pnp 00:04: [io  0x0378-0x037f]
[    0.469594] pnp 00:04: [io  0x0778-0x077f]
[    0.469612] pnp 00:04: [irq 7]
[    0.469626] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
[    0.469954] pnp: PnP ACPI: found 5 devices
[    0.469956] ACPI: ACPI bus type pnp unregistered
[    0.479843] Switching to clocksource acpi_pm
[    0.479942] PCI: max bus depth: 0 pci_try_num: 1
[    0.479960] pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
[    0.479964] pci_bus 0000:00: resource 1 [mem 0x00000000-0xfffffffff]
[    0.479989] NET: Registered protocol family 2
[    0.479989] IP route cache hash table entries: 131072 (order: 8, 
1048576 bytes)
[    0.479989] TCP established hash table entries: 524288 (order: 11, 
8388608 bytes)
[    0.479989] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.479989] TCP: Hash tables configured (established 524288 bind 65536)
[    0.479989] TCP reno registered
[    0.479989] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.479989] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    0.479989] NET: Registered protocol family 1
[    0.479989] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.479989] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    0.479989] pci 0000:00:02.0: Boot video device
[    0.479989] pci 0000:00:06.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[    0.536224] pci 0000:00:06.0: PCI INT A disabled
[    0.536281] pci 0000:00:0b.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    0.536419] pci 0000:00:0b.0: PCI INT A disabled
[    0.536438] PCI: CLS 64 bytes, default 64
[    0.536440] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.536442] Placing 64MB software IO TLB between ffff8800dbfea000 - 
ffff8800dffea000
[    0.536445] software IO TLB at phys 0xdbfea000 - 0xdffea000
[    0.536534] platform rtc_cmos: registered platform RTC device (no PNP 
device found)
[    0.537218] audit: initializing netlink socket (disabled)
[    0.537228] type=2000 audit(1334831321.536:1): initialized
[    0.559691] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.569424] VFS: Disk quotas dquot_6.5.2
[    0.569466] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.570011] fuse init (API version 7.17)
[    0.570131] msgmni has been set to 7875
[    0.571849] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 253)
[    0.571976] io scheduler noop registered
[    0.571979] io scheduler deadline registered
[    0.572009] io scheduler cfq registered (default)
[    0.572158] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.572176] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.572258] ACPI: Deprecated procfs I/F for AC is loaded, please 
retry with CONFIG_ACPI_PROCFS_POWER cleared
[    0.572298] ACPI: AC Adapter [AC] (on-line)
[    0.572375] input: Power Button as 
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.572380] ACPI: Power Button [PWRF]
[    0.572433] input: Sleep Button as 
/devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
[    0.572437] ACPI: Sleep Button [SLPF]
[    0.573452] ERST: Table is not found!
[    0.573454] GHES: HEST is not enabled!
[    0.573530] virtio-pci 0000:00:03.0: PCI INT A -> GSI 19 (level, low) 
-> IRQ 19
[    0.573727] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.605871] Freeing initrd memory: 13832k freed
[    1.248951] Linux agpgart interface v0.103
[    1.254544] brd: module loaded
[    1.256947] loop: module loaded
[    1.257314] ahci 0000:00:0d.0: version 3.0
[    1.257415] ahci 0000:00:0d.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[    1.257633] ahci: SSS flag set, parallel bus scan disabled
[    1.257942] ahci 0000:00:0d.0: AHCI 0001.0100 32 slots 1 ports 3 Gbps 
0x1 impl SATA mode
[    1.257951] ahci 0000:00:0d.0: flags: 64bit ncq stag only ccc
[    1.258674] scsi0 : ahci
[    1.258767] ata1: SATA max UDMA/133 abar m8192@0xf0406000 port 
0xf0406100 irq 21
[    1.258844] ata_piix 0000:00:01.1: version 2.13
[    1.259824] scsi1 : ata_piix
[    1.260317] scsi2 : ata_piix
[    1.260374] ata2: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0xd000 
irq 14
[    1.260380] ata3: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xd008 
irq 15
[    1.260804] Fixed MDIO Bus: probed
[    1.260817] tun: Universal TUN/TAP device driver, 1.6
[    1.260818] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.261638] PPP generic driver version 2.4.2
[    1.262079] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.262122] ehci_hcd 0000:00:0b.0: PCI INT A -> GSI 19 (level, low) 
-> IRQ 19
[    1.262195] ehci_hcd 0000:00:0b.0: EHCI Host Controller
[    1.262430] ehci_hcd 0000:00:0b.0: new USB bus registered, assigned 
bus number 1
[    1.262761] ehci_hcd 0000:00:0b.0: irq 19, io mem 0xf0405000
[    1.272188] ehci_hcd 0000:00:0b.0: USB 2.0 started, EHCI 1.00
[    1.272644] hub 1-0:1.0: USB hub found
[    1.272654] hub 1-0:1.0: 8 ports detected
[    1.272827] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.272898] ohci_hcd 0000:00:06.0: PCI INT A -> GSI 22 (level, low) 
-> IRQ 22
[    1.272984] ohci_hcd 0000:00:06.0: OHCI Host Controller
[    1.273269] ohci_hcd 0000:00:06.0: new USB bus registered, assigned 
bus number 2
[    1.273417] ohci_hcd 0000:00:06.0: irq 22, io mem 0xf0404000
[    1.329002] hub 2-0:1.0: USB hub found
[    1.329032] hub 2-0:1.0: 8 ports detected
[    1.329525] uhci_hcd: USB Universal Host Controller Interface driver
[    1.329601] usbcore: registered new interface driver libusual
[    1.329655] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] 
at 0x60,0x64 irq 1,12
[    1.330733] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.330748] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.331290] mousedev: PS/2 mouse device common for all mice
[    1.332223] input: AT Translated Set 2 keyboard as 
/devices/platform/i8042/serio0/input/input2
[    1.332913] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[    1.333075] rtc0: alarms up to one day, 114 bytes nvram
[    1.333222] device-mapper: uevent: version 1.0.3
[    1.333528] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) 
initialised: dm-devel@redhat.com
[    1.333559] cpuidle: using governor ladder
[    1.333563] cpuidle: using governor menu
[    1.333567] EFI Variables Facility v0.08 2004-May-17
[    1.333859] TCP cubic registered
[    1.334011] NET: Registered protocol family 10
[    1.334802] NET: Registered protocol family 17
[    1.334835] Registering the dns_resolver key type
[    1.335954] PM: Hibernation image not present or could not be loaded.
[    1.335973] registered taskstats version 1
[    1.360349]   Magic number: 8:400:477
[    1.360600] rtc_cmos rtc_cmos: setting system clock to 2012-04-19 
10:28:43 UTC (1334831323)
[    1.360808] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    1.360813] EDD information not available.
[    1.417071] ata3.00: ATAPI: VBOX CD-ROM, 1.0, max UDMA/133
[    1.418236] ata3.00: configured for UDMA/33
[    1.576294] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.576442] ata1.00: ATA-6: VBOX HARDDISK, 1.0, max UDMA/133
[    1.576449] ata1.00: 16777216 sectors, multi 128: LBA48 NCQ (depth 31/32)
[    1.576637] ata1.00: configured for UDMA/133
[    1.577145] scsi 0:0:0:0: Direct-Access     ATA      VBOX HARDDISK 
  1.0  PQ: 0 ANSI: 5
[    1.577596] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.577628] sd 0:0:0:0: [sda] 16777216 512-byte logical blocks: (8.58 
GB/8.00 GiB)
[    1.578323] sd 0:0:0:0: [sda] Write Protect is off
[    1.578332] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.578580] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    1.578765] scsi 2:0:0:0: CD-ROM            VBOX     CD-ROM 
  1.0  PQ: 0 ANSI: 5
[    1.579836] sr0: scsi3-mmc drive: 32x/32x xa/form2 tray
[    1.579853] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.580258] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    1.580557] sr 2:0:0:0: Attached scsi generic sg1 type 5
[    1.581366]  sda: sda1 sda2 < sda5 >
[    1.583094] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.584231] usb 1-1: new high-speed USB device number 2 using ehci_hcd
[    1.585305] Freeing unused kernel memory: 920k freed
[    1.585472] Write protecting the kernel read-only data: 12288k
[    1.593051] Freeing unused kernel memory: 1608k freed
[    1.599031] Freeing unused kernel memory: 1196k freed
[    1.637534] udevd[101]: starting version 175
[    1.771768] EXT4-fs (sda1): mounted filesystem with ordered data 
mode. Opts: (null)
[    1.874977] hrtimer: interrupt took 107977688 ns
[    2.224241] usb 2-1: new full-speed USB device number 2 using ohci_hcd
[    4.998829] ADDRCONF(NETDEV_UP): eth0: link is not ready
[    5.015680] udevd[296]: starting version 175
[    5.046608] Adding 4192252k swap on /dev/sda5.  Priority:-1 extents:1 
across:4192252k
[    5.084794] piix4_smbus 0000:00:07.0: SMBus base address 
uninitialized - upgrade BIOS or use force_addr=0xaddr
[    5.090614] lp: driver loaded but no devices found
[    5.096851] type=1400 audit(1334831327.232:2): apparmor="STATUS" 
operation="profile_load" name="/sbin/dhclient" pid=359 
comm="apparmor_parser"
[    5.097421] type=1400 audit(1334831327.232:3): apparmor="STATUS" 
operation="profile_load" 
name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=359 
comm="apparmor_parser"
[    5.097656] type=1400 audit(1334831327.232:4): apparmor="STATUS" 
operation="profile_load" name="/usr/lib/connman/scripts/dhclient-script" 
pid=359 comm="apparmor_parser"
[    5.142805] pci 0000:00:04.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    5.148416] input: M-Audio Fast Track C400 as 
/devices/pci0000:00/0000:00:0b.0/usb1/1-1/1-1:1.5/input/input3
[    5.150294] input: Unspecified device as /devices/virtual/input/input4
[    5.151404] vboxguest: major 0, IRQ 20, I/O port d040, MMIO at 
00000000f0000000 (size 0x400000)
[    5.151407] vboxguest: Successfully loaded version 4.1.12 (interface 
0x00010004)
[    5.153200] generic-usb 0003:0763:2030.0001: input,hidraw0: USB HID 
v1.10 Keyboard [M-Audio Fast Track C400] on usb-0000:00:0b.0-1/input5
[    5.154104] input: ImExPS/2 Generic Explorer Mouse as 
/devices/platform/i8042/serio1/input/input5
[    5.173055] parport_pc 00:04: reported by Plug and Play ACPI
[    5.176070] input: VirtualBox USB Tablet as 
/devices/pci0000:00/0000:00:06.0/usb2/2-1/2-1:1.0/input/input6
[    5.176363] generic-usb 0003:80EE:0021.0002: input,hidraw1: USB HID 
v1.10 Mouse [VirtualBox USB Tablet] on usb-0000:00:06.0-1/input0
[    5.176376] usbcore: registered new interface driver usbhid
[    5.176377] usbhid: USB HID core driver
[    5.193484] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[    5.197201] ppdev: user-space parallel port driver
[    5.284929] snd-usb-audio: probe of 1-1:1.1 failed with error -5
[    5.290898] snd-usb-audio: probe of 1-1:1.2 failed with error -5
[    5.296928] snd-usb-audio: probe of 1-1:1.3 failed with error -5
[    5.303749] usbcore: registered new interface driver snd-usb-audio
[    5.568497] vesafb: mode is 640x480x32, linelength=2560, pages=0
[    5.568501] vesafb: scrolling: redraw
[    5.568505] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    5.568573] mtrr: your processor doesn't support write-combining
[    5.568906] vesafb: framebuffer at 0xe0000000, mapped to 
0xffffc90003f00000, using 1216k, total 1216k
[    5.569237] Console: switching to colour frame buffer device 80x30
[    5.573612] fb0: VESA VGA frame buffer device
[    7.628873] init: failsafe main process (676) killed by TERM signal
[    7.686842] type=1400 audit(1334831329.820:5): apparmor="STATUS" 
operation="profile_load" name="/usr/sbin/tcpdump" pid=856 
comm="apparmor_parser"
[    7.686955] type=1400 audit(1334831329.820:6): apparmor="STATUS" 
operation="profile_replace" name="/sbin/dhclient" pid=854 
comm="apparmor_parser"
[    7.687523] type=1400 audit(1334831329.820:7): apparmor="STATUS" 
operation="profile_replace" 
name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=854 
comm="apparmor_parser"
[    7.687836] type=1400 audit(1334831329.820:8): apparmor="STATUS" 
operation="profile_replace" 
name="/usr/lib/connman/scripts/dhclient-script" pid=854 
comm="apparmor_parser"
[    7.881629] vboxsf: Successfully loaded version 4.1.12 (interface 
0x00010004)
[   15.552201] eth0: no IPv6 routers present


On 4/19/2012 7:09 AM, Grant Diffey wrote:
> On Thu, Apr 19, 2012 at 8:26 PM, Chris Cavey<chris-alsa@rauros.net>  wrote:
>
>> Complete snippet from the log
>>
>> [  374.104138] usbcore: deregistering interface driver snd-usb-audio
>> [  374.875660] snd-usb-audio: probe of 1-1:1.1 failed with error -5
>> [  374.881649] snd-usb-audio: probe of 1-1:1.2 failed with error -5
>> [  374.887654] snd-usb-audio: probe of 1-1:1.3 failed with error -5
>> [  374.895366] usbcore: registered new interface driver snd-usb-audio
>>
>> Sidenote - While I don't have a midi device to test with, it would
>> appear that the midi portion registers correctly and is accessible (at
>> least through amidi and aplaymidi)
>>
>> On 04/19/2012 04:53 AM, Clemens Ladisch wrote:
>>> Chris Cavey wrote:
>>>>    snd-usb-audio: probe of 1-1:1.1 failed with error -5
>>>>    snd-usb-audio: probe of 1-1:1.2 failed with error -5
>>>>    snd-usb-audio: probe of 1-1:1.3 failed with error -5
>>> Are there no other messages immediately before this?
>>>
>>
> that looks like a snippet on unload can I have another 10 lines either side?
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010009070107060506050903
Content-Type: text/plain; charset=windows-1252;
 name="c400bootlog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="c400bootlog.txt"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.2.0-23-generic (buildd@crested) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu4) ) #36-Ubuntu SMP Tue Apr 10 20:39:51 UTC 2012 (Ubuntu 3.2.0-23.36-generic 3.2.14)
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.2.0-23-generic root=UUID=ec96128d-feb6-40e6-a5aa-b55aa2219935 ro
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000dfff0000 (usable)
[    0.000000]  BIOS-e820: 00000000dfff0000 - 00000000e0000000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.5 present.
[    0.000000] DMI: innotek GmbH VirtualBox, BIOS VirtualBox 12/01/2006
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x120000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR variable ranges disabled:
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] CPU MTRRs all blank - virtualized system.
[    0.000000] last_pfn = 0xdfff0 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [ffff88000009fff0] 9fff0
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff88000009a000] 9a000 size 20480
[    0.000000] init_memory_mapping: 0000000000000000-00000000dfff0000
[    0.000000]  0000000000 - 00dfe00000 page 2M
[    0.000000]  00dfe00000 - 00dfff0000 page 4k
[    0.000000] kernel direct mapping tables up to dfff0000 @ 1fffa000-20000000
[    0.000000] init_memory_mapping: 0000000100000000-0000000120000000
[    0.000000]  0100000000 - 0120000000 page 2M
[    0.000000] kernel direct mapping tables up to 120000000 @ dffea000-dfff0000
[    0.000000] RAMDISK: 364ec000 - 3726e000
[    0.000000] ACPI: RSDP 00000000000e0000 00024 (v02 VBOX  )
[    0.000000] ACPI: XSDT 00000000dfff0030 0003C (v01 VBOX   VBOXXSDT 00000001 ASL  00000061)
[    0.000000] ACPI: FACP 00000000dfff00f0 000F4 (v04 VBOX   VBOXFACP 00000001 ASL  00000061)
[    0.000000] ACPI: DSDT 00000000dfff0480 01B96 (v01 VBOX   VBOXBIOS 00000002 INTL 20100528)
[    0.000000] ACPI: FACS 00000000dfff0200 00040
[    0.000000] ACPI: APIC 00000000dfff0240 0006C (v02 VBOX   VBOXAPIC 00000001 ASL  00000061)
[    0.000000] ACPI: SSDT 00000000dfff02b0 001CC (v01 VBOX   VBOXCPUT 00000002 INTL 20100528)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000120000000
[    0.000000] Initmem setup node 0 0000000000000000-0000000120000000
[    0.000000]   NODE_DATA [000000011fffb000 - 000000011fffffff]
[    0.000000]  [ffffea0000000000-ffffea00047fffff] PMD -> [ffff88011b600000-ffff88011f5fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00120000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x000dfff0
[    0.000000]     0: 0x00100000 -> 0x00120000
[    0.000000] On node 0 totalpages: 1048447
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3914 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 16320 pages used for memmap
[    0.000000]   DMA32 zone: 897072 pages, LIFO batch:31
[    0.000000]   Normal zone: 2048 pages used for memmap
[    0.000000]   Normal zone: 129024 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
[    0.000000] PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000dfff0000 - 00000000e0000000
[    0.000000] PM: Registered nosave memory: 00000000e0000000 - 00000000fffc0000
[    0.000000] PM: Registered nosave memory: 00000000fffc0000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at e0000000 (gap: e0000000:1ffc0000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88011fc00000 s83072 r8192 d23424 u524288
[    0.000000] pcpu-alloc: s83072 r8192 d23424 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1030010
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.2.0-23-generic root=UUID=ec96128d-feb6-40e6-a5aa-b55aa2219935 ro
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 4032084k/4718592k available (6566k kernel code, 524804k absent, 161704k reserved, 6637k data, 920k init)
[    0.000000] SLUB: Genslabs=15, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:16640 nr_irqs:712 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 33554432 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 3385.153 MHz processor.
[    0.004003] Calibrating delay loop (skipped), value calculated using timer frequency.. 6770.30 BogoMIPS (lpj=13540612)
[    0.004007] pid_max: default: 32768 minimum: 301
[    0.004023] Security Framework initialized
[    0.004033] AppArmor: AppArmor initialized
[    0.004035] Yama: becoming mindful.
[    0.004588] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.005520] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.005792] Mount-cache hash table entries: 256
[    0.005903] Initializing cgroup subsys cpuacct
[    0.005908] Initializing cgroup subsys memory
[    0.005913] Initializing cgroup subsys devices
[    0.005916] Initializing cgroup subsys freezer
[    0.005918] Initializing cgroup subsys blkio
[    0.005922] Initializing cgroup subsys perf_event
[    0.006124] CPU: Physical Processor ID: 0
[    0.006127] CPU: Processor Core ID: 0
[    0.006143] mce: CPU supports 0 MCE banks
[    0.024772] ACPI: Core revision 20110623
[    0.025296] ftrace: allocating 27049 entries in 107 pages
[    0.036357] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.076499] CPU0: Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz stepping 07
[    0.080004] Performance Events: unsupported p6 CPU model 42 no PMU driver, software events only.
[    0.080004] NMI watchdog disabled (cpu0): hardware events not enabled
[    0.080004] Booting Node   0, Processors  #1
[    0.080004] smpboot cpu 1: start_ip = 9a000
[    0.008000] mce: CPU supports 0 MCE banks
[    0.168009] TSC synchronization [CPU#0 -> CPU#1]:
[    0.168009] Measured 195227 cycles TSC warp between CPUs, turning off TSC clock.
[    0.168009] Marking TSC unstable due to check_tsc_sync_source failed
[    0.168030] NMI watchdog disabled (cpu1): hardware events not enabled
[    0.168227]  #2
[    0.168228] smpboot cpu 2: start_ip = 9a000
[    0.008000] mce: CPU supports 0 MCE banks
[    0.256324] NMI watchdog disabled (cpu2): hardware events not enabled
[    0.256528]  #3 Ok.
[    0.256529] smpboot cpu 3: start_ip = 9a000
[    0.008000] mce: CPU supports 0 MCE banks
[    0.344331] NMI watchdog disabled (cpu3): hardware events not enabled
[    0.344371] Brought up 4 CPUs
[    0.344373] Total of 4 processors activated (27145.08 BogoMIPS).
[    0.345354] devtmpfs: initialized
[    0.345354] EVM: security.selinux
[    0.345354] EVM: security.SMACK64
[    0.345354] EVM: security.capability
[    0.345354] print_constraints: dummy: 
[    0.345354] RTC time: 10:28:42, date: 04/19/12
[    0.345354] NET: Registered protocol family 16
[    0.345354] ACPI: bus type pci registered
[    0.345354] PCI: Using configuration type 1 for base access
[    0.345354] Trying to unpack rootfs image as initramfs...
[    0.348353] bio: create slab <bio-0> at 0
[    0.348353] ACPI: Added _OSI(Module Device)
[    0.348353] ACPI: Added _OSI(Processor Device)
[    0.348353] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.348353] ACPI: Added _OSI(Processor Aggregator Device)
[    0.348353] ACPI: EC: Look up EC in DSDT
[    0.348547] ACPI: Executed 1 blocks of module-level executable AML code
[    0.350447] ACPI: Interpreter enabled
[    0.350450] ACPI: (supports S0 S5)
[    0.350459] ACPI: Using IOAPIC for interrupt routing
[    0.352692] ACPI: No dock devices found.
[    0.352695] HEST: Table not found.
[    0.352697] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.352738] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.352813] pci_root PNP0A03:00: host bridge window [io  0x0000-0x0cf7] (ignored)
[    0.352815] pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff] (ignored)
[    0.352816] pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff] (ignored)
[    0.352818] pci_root PNP0A03:00: host bridge window [mem 0xe0000000-0xffdfffff] (ignored)
[    0.352852] pci 0000:00:00.0: [8086:1237] type 0 class 0x000600
[    0.353150] pci 0000:00:01.0: [8086:7000] type 0 class 0x000601
[    0.353567] pci 0000:00:01.1: [8086:7111] type 0 class 0x000101
[    0.353885] pci 0000:00:01.1: reg 20: [io  0xd000-0xd00f]
[    0.354120] pci 0000:00:02.0: [80ee:beef] type 0 class 0x000300
[    0.356449] pci 0000:00:02.0: reg 10: [mem 0xe0000000-0xe0ffffff pref]
[    0.372789] pci 0000:00:03.0: [1af4:1000] type 0 class 0x000200
[    0.372900] pci 0000:00:03.0: reg 10: [io  0xd020-0xd03f]
[    0.373432] pci 0000:00:04.0: [80ee:cafe] type 0 class 0x000880
[    0.376229] pci 0000:00:04.0: reg 10: [io  0xd040-0xd05f]
[    0.380229] pci 0000:00:04.0: reg 14: [mem 0xf0000000-0xf03fffff]
[    0.382891] pci 0000:00:04.0: reg 18: [mem 0xf0400000-0xf0403fff pref]
[    0.392444] pci 0000:00:06.0: [106b:003f] type 0 class 0x000c03
[    0.396234] pci 0000:00:06.0: reg 10: [mem 0xf0404000-0xf0404fff]
[    0.411054] pci 0000:00:07.0: [8086:7113] type 0 class 0x000680
[    0.412109] pci 0000:00:0b.0: [8086:265c] type 0 class 0x000c03
[    0.414940] pci 0000:00:0b.0: reg 10: [mem 0xf0405000-0xf0405fff]
[    0.431155] pci 0000:00:0d.0: [8086:2829] type 0 class 0x000106
[    0.432285] pci 0000:00:0d.0: reg 10: [io  0xd060-0xd067]
[    0.440252] pci 0000:00:0d.0: reg 18: [io  0xd070-0xd077]
[    0.444431] pci 0000:00:0d.0: reg 20: [io  0xd080-0xd08f]
[    0.448447] pci 0000:00:0d.0: reg 24: [mem 0xf0406000-0xf0407fff]
[    0.453161] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.454249]  pci0000:00: Unable to request _OSC control (_OSC support mask: 0x1e)
[    0.460028] ACPI: PCI Interrupt Link [LNKA] (IRQs *5 9 10 11)
[    0.460448] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 9 10 *11)
[    0.460566] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 9 *10 11)
[    0.460681] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 *9 10 11)
[    0.461127] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.461127] vgaarb: loaded
[    0.461127] vgaarb: bridge control possible 0000:00:02.0
[    0.461127] i2c-core: driver [aat2870] using legacy suspend method
[    0.461127] i2c-core: driver [aat2870] using legacy resume method
[    0.461127] SCSI subsystem initialized
[    0.461127] libata version 3.00 loaded.
[    0.461127] usbcore: registered new interface driver usbfs
[    0.461127] usbcore: registered new interface driver hub
[    0.461127] usbcore: registered new device driver usb
[    0.461127] PCI: Using ACPI for IRQ routing
[    0.461127] PCI: pci_cache_line_size set to 64 bytes
[    0.461127] reserve RAM buffer: 000000000009fc00 - 000000000009ffff 
[    0.461127] reserve RAM buffer: 00000000dfff0000 - 00000000dfffffff 
[    0.461127] NetLabel: Initializing
[    0.461127] NetLabel:  domain hash size = 128
[    0.461127] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.461127] NetLabel:  unlabeled traffic allowed by default
[    0.469329] AppArmor: AppArmor Filesystem Enabled
[    0.469352] pnp: PnP ACPI init
[    0.469365] ACPI: bus type pnp registered
[    0.469424] pnp 00:00: [bus 00-ff]
[    0.469425] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.469427] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.469428] pnp 00:00: [io  0x0d00-0xffff window]
[    0.469431] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.469432] pnp 00:00: [mem 0xe0000000-0xffdfffff window]
[    0.469454] pnp 00:00: Plug and Play ACPI device, IDs PNP0a03 (active)
[    0.469465] pnp 00:01: [io  0x0060]
[    0.469466] pnp 00:01: [io  0x0064]
[    0.469492] pnp 00:01: [irq 1]
[    0.469507] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.469513] pnp 00:02: [io  0x0000-0x000f]
[    0.469514] pnp 00:02: [io  0x0080-0x008f]
[    0.469515] pnp 00:02: [io  0x00c0-0x00df]
[    0.469516] pnp 00:02: [dma 4]
[    0.469527] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.469569] pnp 00:03: [irq 12]
[    0.469584] pnp 00:03: Plug and Play ACPI device, IDs PNP0f03 (active)
[    0.469593] pnp 00:04: [io  0x0378-0x037f]
[    0.469594] pnp 00:04: [io  0x0778-0x077f]
[    0.469612] pnp 00:04: [irq 7]
[    0.469626] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
[    0.469954] pnp: PnP ACPI: found 5 devices
[    0.469956] ACPI: ACPI bus type pnp unregistered
[    0.479843] Switching to clocksource acpi_pm
[    0.479942] PCI: max bus depth: 0 pci_try_num: 1
[    0.479960] pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
[    0.479964] pci_bus 0000:00: resource 1 [mem 0x00000000-0xfffffffff]
[    0.479989] NET: Registered protocol family 2
[    0.479989] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.479989] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    0.479989] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.479989] TCP: Hash tables configured (established 524288 bind 65536)
[    0.479989] TCP reno registered
[    0.479989] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.479989] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    0.479989] NET: Registered protocol family 1
[    0.479989] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.479989] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    0.479989] pci 0000:00:02.0: Boot video device
[    0.479989] pci 0000:00:06.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[    0.536224] pci 0000:00:06.0: PCI INT A disabled
[    0.536281] pci 0000:00:0b.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    0.536419] pci 0000:00:0b.0: PCI INT A disabled
[    0.536438] PCI: CLS 64 bytes, default 64
[    0.536440] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.536442] Placing 64MB software IO TLB between ffff8800dbfea000 - ffff8800dffea000
[    0.536445] software IO TLB at phys 0xdbfea000 - 0xdffea000
[    0.536534] platform rtc_cmos: registered platform RTC device (no PNP device found)
[    0.537218] audit: initializing netlink socket (disabled)
[    0.537228] type=2000 audit(1334831321.536:1): initialized
[    0.559691] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.569424] VFS: Disk quotas dquot_6.5.2
[    0.569466] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.570011] fuse init (API version 7.17)
[    0.570131] msgmni has been set to 7875
[    0.571849] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.571976] io scheduler noop registered
[    0.571979] io scheduler deadline registered
[    0.572009] io scheduler cfq registered (default)
[    0.572158] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.572176] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.572258] ACPI: Deprecated procfs I/F for AC is loaded, please retry with CONFIG_ACPI_PROCFS_POWER cleared
[    0.572298] ACPI: AC Adapter [AC] (on-line)
[    0.572375] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.572380] ACPI: Power Button [PWRF]
[    0.572433] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
[    0.572437] ACPI: Sleep Button [SLPF]
[    0.573452] ERST: Table is not found!
[    0.573454] GHES: HEST is not enabled!
[    0.573530] virtio-pci 0000:00:03.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    0.573727] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.605871] Freeing initrd memory: 13832k freed
[    1.248951] Linux agpgart interface v0.103
[    1.254544] brd: module loaded
[    1.256947] loop: module loaded
[    1.257314] ahci 0000:00:0d.0: version 3.0
[    1.257415] ahci 0000:00:0d.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[    1.257633] ahci: SSS flag set, parallel bus scan disabled
[    1.257942] ahci 0000:00:0d.0: AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
[    1.257951] ahci 0000:00:0d.0: flags: 64bit ncq stag only ccc 
[    1.258674] scsi0 : ahci
[    1.258767] ata1: SATA max UDMA/133 abar m8192@0xf0406000 port 0xf0406100 irq 21
[    1.258844] ata_piix 0000:00:01.1: version 2.13
[    1.259824] scsi1 : ata_piix
[    1.260317] scsi2 : ata_piix
[    1.260374] ata2: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0xd000 irq 14
[    1.260380] ata3: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xd008 irq 15
[    1.260804] Fixed MDIO Bus: probed
[    1.260817] tun: Universal TUN/TAP device driver, 1.6
[    1.260818] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.261638] PPP generic driver version 2.4.2
[    1.262079] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.262122] ehci_hcd 0000:00:0b.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    1.262195] ehci_hcd 0000:00:0b.0: EHCI Host Controller
[    1.262430] ehci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 1
[    1.262761] ehci_hcd 0000:00:0b.0: irq 19, io mem 0xf0405000
[    1.272188] ehci_hcd 0000:00:0b.0: USB 2.0 started, EHCI 1.00
[    1.272644] hub 1-0:1.0: USB hub found
[    1.272654] hub 1-0:1.0: 8 ports detected
[    1.272827] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.272898] ohci_hcd 0000:00:06.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[    1.272984] ohci_hcd 0000:00:06.0: OHCI Host Controller
[    1.273269] ohci_hcd 0000:00:06.0: new USB bus registered, assigned bus number 2
[    1.273417] ohci_hcd 0000:00:06.0: irq 22, io mem 0xf0404000
[    1.329002] hub 2-0:1.0: USB hub found
[    1.329032] hub 2-0:1.0: 8 ports detected
[    1.329525] uhci_hcd: USB Universal Host Controller Interface driver
[    1.329601] usbcore: registered new interface driver libusual
[    1.329655] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    1.330733] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.330748] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.331290] mousedev: PS/2 mouse device common for all mice
[    1.332223] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    1.332913] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[    1.333075] rtc0: alarms up to one day, 114 bytes nvram
[    1.333222] device-mapper: uevent: version 1.0.3
[    1.333528] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) initialised: dm-devel@redhat.com
[    1.333559] cpuidle: using governor ladder
[    1.333563] cpuidle: using governor menu
[    1.333567] EFI Variables Facility v0.08 2004-May-17
[    1.333859] TCP cubic registered
[    1.334011] NET: Registered protocol family 10
[    1.334802] NET: Registered protocol family 17
[    1.334835] Registering the dns_resolver key type
[    1.335954] PM: Hibernation image not present or could not be loaded.
[    1.335973] registered taskstats version 1
[    1.360349]   Magic number: 8:400:477
[    1.360600] rtc_cmos rtc_cmos: setting system clock to 2012-04-19 10:28:43 UTC (1334831323)
[    1.360808] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    1.360813] EDD information not available.
[    1.417071] ata3.00: ATAPI: VBOX CD-ROM, 1.0, max UDMA/133
[    1.418236] ata3.00: configured for UDMA/33
[    1.576294] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.576442] ata1.00: ATA-6: VBOX HARDDISK, 1.0, max UDMA/133
[    1.576449] ata1.00: 16777216 sectors, multi 128: LBA48 NCQ (depth 31/32)
[    1.576637] ata1.00: configured for UDMA/133
[    1.577145] scsi 0:0:0:0: Direct-Access     ATA      VBOX HARDDISK    1.0  PQ: 0 ANSI: 5
[    1.577596] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.577628] sd 0:0:0:0: [sda] 16777216 512-byte logical blocks: (8.58 GB/8.00 GiB)
[    1.578323] sd 0:0:0:0: [sda] Write Protect is off
[    1.578332] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.578580] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.578765] scsi 2:0:0:0: CD-ROM            VBOX     CD-ROM           1.0  PQ: 0 ANSI: 5
[    1.579836] sr0: scsi3-mmc drive: 32x/32x xa/form2 tray
[    1.579853] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.580258] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    1.580557] sr 2:0:0:0: Attached scsi generic sg1 type 5
[    1.581366]  sda: sda1 sda2 < sda5 >
[    1.583094] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.584231] usb 1-1: new high-speed USB device number 2 using ehci_hcd
[    1.585305] Freeing unused kernel memory: 920k freed
[    1.585472] Write protecting the kernel read-only data: 12288k
[    1.593051] Freeing unused kernel memory: 1608k freed
[    1.599031] Freeing unused kernel memory: 1196k freed
[    1.637534] udevd[101]: starting version 175
[    1.771768] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    1.874977] hrtimer: interrupt took 107977688 ns
[    2.224241] usb 2-1: new full-speed USB device number 2 using ohci_hcd
[    4.998829] ADDRCONF(NETDEV_UP): eth0: link is not ready
[    5.015680] udevd[296]: starting version 175
[    5.046608] Adding 4192252k swap on /dev/sda5.  Priority:-1 extents:1 across:4192252k 
[    5.084794] piix4_smbus 0000:00:07.0: SMBus base address uninitialized - upgrade BIOS or use force_addr=0xaddr
[    5.090614] lp: driver loaded but no devices found
[    5.096851] type=1400 audit(1334831327.232:2): apparmor="STATUS" operation="profile_load" name="/sbin/dhclient" pid=359 comm="apparmor_parser"
[    5.097421] type=1400 audit(1334831327.232:3): apparmor="STATUS" operation="profile_load" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=359 comm="apparmor_parser"
[    5.097656] type=1400 audit(1334831327.232:4): apparmor="STATUS" operation="profile_load" name="/usr/lib/connman/scripts/dhclient-script" pid=359 comm="apparmor_parser"
[    5.142805] pci 0000:00:04.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    5.148416] input: M-Audio Fast Track C400 as /devices/pci0000:00/0000:00:0b.0/usb1/1-1/1-1:1.5/input/input3
[    5.150294] input: Unspecified device as /devices/virtual/input/input4
[    5.151404] vboxguest: major 0, IRQ 20, I/O port d040, MMIO at 00000000f0000000 (size 0x400000)
[    5.151407] vboxguest: Successfully loaded version 4.1.12 (interface 0x00010004)
[    5.153200] generic-usb 0003:0763:2030.0001: input,hidraw0: USB HID v1.10 Keyboard [M-Audio Fast Track C400] on usb-0000:00:0b.0-1/input5
[    5.154104] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input5
[    5.173055] parport_pc 00:04: reported by Plug and Play ACPI
[    5.176070] input: VirtualBox USB Tablet as /devices/pci0000:00/0000:00:06.0/usb2/2-1/2-1:1.0/input/input6
[    5.176363] generic-usb 0003:80EE:0021.0002: input,hidraw1: USB HID v1.10 Mouse [VirtualBox USB Tablet] on usb-0000:00:06.0-1/input0
[    5.176376] usbcore: registered new interface driver usbhid
[    5.176377] usbhid: USB HID core driver
[    5.193484] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[    5.197201] ppdev: user-space parallel port driver
[    5.284929] snd-usb-audio: probe of 1-1:1.1 failed with error -5
[    5.290898] snd-usb-audio: probe of 1-1:1.2 failed with error -5
[    5.296928] snd-usb-audio: probe of 1-1:1.3 failed with error -5
[    5.303749] usbcore: registered new interface driver snd-usb-audio
[    5.568497] vesafb: mode is 640x480x32, linelength=2560, pages=0
[    5.568501] vesafb: scrolling: redraw
[    5.568505] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    5.568573] mtrr: your processor doesn't support write-combining
[    5.568906] vesafb: framebuffer at 0xe0000000, mapped to 0xffffc90003f00000, using 1216k, total 1216k
[    5.569237] Console: switching to colour frame buffer device 80x30
[    5.573612] fb0: VESA VGA frame buffer device
[    7.628873] init: failsafe main process (676) killed by TERM signal
[    7.686842] type=1400 audit(1334831329.820:5): apparmor="STATUS" operation="profile_load" name="/usr/sbin/tcpdump" pid=856 comm="apparmor_parser"
[    7.686955] type=1400 audit(1334831329.820:6): apparmor="STATUS" operation="profile_replace" name="/sbin/dhclient" pid=854 comm="apparmor_parser"
[    7.687523] type=1400 audit(1334831329.820:7): apparmor="STATUS" operation="profile_replace" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=854 comm="apparmor_parser"
[    7.687836] type=1400 audit(1334831329.820:8): apparmor="STATUS" operation="profile_replace" name="/usr/lib/connman/scripts/dhclient-script" pid=854 comm="apparmor_parser"
[    7.881629] vboxsf: Successfully loaded version 4.1.12 (interface 0x00010004)
[   15.552201] eth0: no IPv6 routers present

--------------010009070107060506050903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010009070107060506050903--
