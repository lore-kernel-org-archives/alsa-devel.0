From: Geoffrey McRae <geoff@spacevs.com>
Subject: Re: ASUS Phoebus (CMI8888) HDA Support
Date: Wed, 4 Dec 2013 23:18:33 +1100
Message-ID: <20131204231833.26fb17b1@sarah.home.spacevs.com>
References: <20131204213613.31b9a9c9@sarah.home.spacevs.com>
 <529F098C.3020208@ladisch.de>
 <20131204215711.68b52af6@sarah.home.spacevs.com>
 <529F1890.6070003@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.spacevs.com (mail1.spacevs.com [202.174.111.252])
 by alsa0.perex.cz (Postfix) with ESMTP id 9562B26545A
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 13:18:39 +0100 (CET)
In-Reply-To: <529F1890.6070003@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 04 Dec 2013 12:57:04 +0100
Clemens Ladisch <clemens@ladisch.de> wrote:

> Please show the outputs of dmesg directly after booting with the IOMMU
> option both disabled and enabled.

Here it is with IOMMU disabled:
=======================================================================

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.2.0-4-amd64 (debian-kernel@lists.debian.org) (gcc version 4.6.3 (Debian 4.6.3-14) ) #1 SMP Debian 3.2.51-1
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.2.0-4-amd64 root=UUID=1a15dffb-2f03-4e0a-977a-2d5e8cedc529 ro quiet
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
[    0.000000]  BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000dd830000 (usable)
[    0.000000]  BIOS-e820: 00000000dd830000 - 00000000dd882000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000dd882000 - 00000000dd88c000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000dd88c000 - 00000000dd88d000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000dd88d000 - 00000000ddad9000 (reserved)
[    0.000000]  BIOS-e820: 00000000ddad9000 - 00000000ddaea000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000ddaea000 - 00000000ddaff000 (reserved)
[    0.000000]  BIOS-e820: 00000000ddaff000 - 00000000ddb01000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000ddb01000 - 00000000ddb0a000 (reserved)
[    0.000000]  BIOS-e820: 00000000ddb0a000 - 00000000ddb10000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000ddb10000 - 00000000ddb72000 (reserved)
[    0.000000]  BIOS-e820: 00000000ddb72000 - 00000000ddd75000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000ddd75000 - 00000000ddf00000 (usable)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec10000 - 00000000fec11000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec20000 - 00000000fec21000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed61000 - 00000000fed71000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed80000 - 00000000fed90000 (reserved)
[    0.000000]  BIOS-e820: 00000000fef00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100001000 - 000000041f000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: To be filled by O.E.M. To be filled by O.E.M./SABERTOOTH 990FX, BIOS 1604 10/16/2012
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x41f000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF write-through
[    0.000000]   C0000-D1FFF write-protect
[    0.000000]   D2000-EBFFF uncachable
[    0.000000]   EC000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000C0000000 mask FFFFE0000000 write-back
[    0.000000]   3 base 0000DDF00000 mask FFFFFFF00000 uncachable
[    0.000000]   4 base 0000DE000000 mask FFFFFE000000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 000000041f000000 aka 16880M
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820 update range: 00000000ddf00000 - 0000000100000000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0xddf00 max_arch_pfn = 0x400000000
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 20480
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: 0000000000000000-00000000ddf00000
[    0.000000]  0000000000 - 00c0000000 page 1G
[    0.000000]  00c0000000 - 00dde00000 page 2M
[    0.000000]  00dde00000 - 00ddf00000 page 4k
[    0.000000] kernel direct mapping tables up to ddf00000 @ 1fffd000-20000000
[    0.000000] init_memory_mapping: 0000000100001000-000000041f000000
[    0.000000]  0100001000 - 0100200000 page 4k
[    0.000000]  0100200000 - 0140000000 page 2M
[    0.000000]  0140000000 - 0400000000 page 1G
[    0.000000]  0400000000 - 041f000000 page 2M
[    0.000000] kernel direct mapping tables up to 41f000000 @ ddefc000-ddf00000
[    0.000000] RAMDISK: 36a9c000 - 37546000
[    0.000000] ACPI: RSDP 00000000000f0450 00024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 00000000dd882068 0004C (v01 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: FACP 00000000dd88ac40 000F4 (v04 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI Warning: Optional field Pm2ControlBlock has zero address or length: 0x0000000000000000/0x1 (20110623/tbfadt-560)
[    0.000000] ACPI: DSDT 00000000dd882150 08AEC (v02 ALASKA    A M I 00000000 INTL 20051117)
[    0.000000] ACPI: FACS 00000000ddb0af80 00040
[    0.000000] ACPI: APIC 00000000dd88ad38 0009E (v03 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 00000000dd88add8 0003C (v01 ALASKA    A M I 01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 00000000dd88ae18 00038 (v01 ALASKA    A M I 01072009 AMI  00000004)
[    0.000000] ACPI: SSDT 00000000dd88aea8 00304 (v01 AMD    POWERNOW 00000001 AMD  00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000041f000000
[    0.000000] Initmem setup node 0 0000000000000000-000000041f000000
[    0.000000]   NODE_DATA [000000041effb000 - 000000041effffff]
[    0.000000]  [ffffea0000000000-ffffea000e7fffff] PMD -> [ffff88040e600000-ffff88041c7fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x0041f000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009d
[    0.000000]     0: 0x00000100 -> 0x000dd830
[    0.000000]     0: 0x000ddd75 -> 0x000ddf00
[    0.000000]     0: 0x00100001 -> 0x0041f000
[    0.000000] On node 0 totalpages: 4180295
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3920 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 889331 pages, LIFO batch:31
[    0.000000]   Normal zone: 44744 pages used for memmap
[    0.000000]   Normal zone: 3227959 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x10] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x11] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x12] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x13] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x14] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x15] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x16] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x17] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x09] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 9, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x0a] address[0xfec20000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 10, version 33, address 0xfec20000, GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x43538210 base: 0xfed00000
[    0.000000] SMP: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 72
[    0.000000] PM: Registered nosave memory: 000000000009d000 - 000000000009e000
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000dd830000 - 00000000dd882000
[    0.000000] PM: Registered nosave memory: 00000000dd882000 - 00000000dd88c000
[    0.000000] PM: Registered nosave memory: 00000000dd88c000 - 00000000dd88d000
[    0.000000] PM: Registered nosave memory: 00000000dd88d000 - 00000000ddad9000
[    0.000000] PM: Registered nosave memory: 00000000ddad9000 - 00000000ddaea000
[    0.000000] PM: Registered nosave memory: 00000000ddaea000 - 00000000ddaff000
[    0.000000] PM: Registered nosave memory: 00000000ddaff000 - 00000000ddb01000
[    0.000000] PM: Registered nosave memory: 00000000ddb01000 - 00000000ddb0a000
[    0.000000] PM: Registered nosave memory: 00000000ddb0a000 - 00000000ddb10000
[    0.000000] PM: Registered nosave memory: 00000000ddb10000 - 00000000ddb72000
[    0.000000] PM: Registered nosave memory: 00000000ddb72000 - 00000000ddd75000
[    0.000000] PM: Registered nosave memory: 00000000ddf00000 - 00000000fec00000
[    0.000000] PM: Registered nosave memory: 00000000fec00000 - 00000000fec01000
[    0.000000] PM: Registered nosave memory: 00000000fec01000 - 00000000fec10000
[    0.000000] PM: Registered nosave memory: 00000000fec10000 - 00000000fec11000
[    0.000000] PM: Registered nosave memory: 00000000fec11000 - 00000000fec20000
[    0.000000] PM: Registered nosave memory: 00000000fec20000 - 00000000fec21000
[    0.000000] PM: Registered nosave memory: 00000000fec21000 - 00000000fed00000
[    0.000000] PM: Registered nosave memory: 00000000fed00000 - 00000000fed01000
[    0.000000] PM: Registered nosave memory: 00000000fed01000 - 00000000fed61000
[    0.000000] PM: Registered nosave memory: 00000000fed61000 - 00000000fed71000
[    0.000000] PM: Registered nosave memory: 00000000fed71000 - 00000000fed80000
[    0.000000] PM: Registered nosave memory: 00000000fed80000 - 00000000fed90000
[    0.000000] PM: Registered nosave memory: 00000000fed90000 - 00000000fef00000
[    0.000000] PM: Registered nosave memory: 00000000fef00000 - 0000000100000000
[    0.000000] PM: Registered nosave memory: 0000000100000000 - 0000000100001000
[    0.000000] Allocating PCI resources starting at ddf00000 (gap: ddf00000:20d00000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88041ec00000 s82944 r8192 d23552 u262144
[    0.000000] pcpu-alloc: s82944 r8192 d23552 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 4121210
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.2.0-4-amd64 root=UUID=1a15dffb-2f03-4e0a-977a-2d5e8cedc529 ro quiet
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave/xrstor: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Node 0: aperture @ f8000000 size 32 MB
[    0.000000] Aperture too small (32 MB) than (64 MB)
[    0.000000] Your BIOS doesn't leave a aperture memory hole
[    0.000000] Please enable the IOMMU option in the BIOS setup
[    0.000000] This costs you 64 MB of RAM
[    0.000000] Mapping aperture over 65536 KB of RAM @ d4000000
[    0.000000] PM: Registered nosave memory: 00000000d4000000 - 00000000d8000000
[    0.000000] Memory: 16337812k/17285120k available (3426k kernel code, 563940k absent, 383368k reserved, 3312k data, 576k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:33024 nr_irqs:1288 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 4013.366 MHz processor.
[    0.004003] Calibrating delay loop (skipped), value calculated using timer frequency.. 8026.73 BogoMIPS (lpj=16053464)
[    0.004005] pid_max: default: 32768 minimum: 301
[    0.004032] Security Framework initialized
[    0.004035] AppArmor: AppArmor disabled by boot time parameter
[    0.004857] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.008657] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.010172] Mount-cache hash table entries: 256
[    0.010251] Initializing cgroup subsys cpuacct
[    0.010254] Initializing cgroup subsys memory
[    0.010263] Initializing cgroup subsys devices
[    0.010265] Initializing cgroup subsys freezer
[    0.010266] Initializing cgroup subsys net_cls
[    0.010267] Initializing cgroup subsys blkio
[    0.010272] Initializing cgroup subsys perf_event
[    0.010291] tseg: 00ddf00000
[    0.010292] CPU: Physical Processor ID: 0
[    0.010293] CPU: Processor Core ID: 0
[    0.010295] mce: CPU supports 7 MCE banks
[    0.010531] ACPI: Core revision 20110623
[    0.016378] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.056413] CPU0: AMD FX(tm)-8350 Eight-Core Processor            stepping 00
[    0.060003] Performance Events: AMD Family 15h PMU driver.
[    0.060003] ... version:                0
[    0.060003] ... bit width:              48
[    0.060003] ... generic registers:      6
[    0.060003] ... value mask:             0000ffffffffffff
[    0.060003] ... max period:             00007fffffffffff
[    0.060003] ... fixed-purpose events:   0
[    0.060003] ... event mask:             000000000000003f
[    0.060003] NMI watchdog enabled, takes one hw-pmu counter.
[    0.060003] Booting Node   0, Processors  #1
[    0.060003] smpboot cpu 1: start_ip = 98000
[    0.148027] NMI watchdog enabled, takes one hw-pmu counter.
[    0.148111]  #2
[    0.148112] smpboot cpu 2: start_ip = 98000
[    0.240025] NMI watchdog enabled, takes one hw-pmu counter.
[    0.240090]  #3
[    0.240091] smpboot cpu 3: start_ip = 98000
[    0.332029] NMI watchdog enabled, takes one hw-pmu counter.
[    0.332091]  #4
[    0.332092] smpboot cpu 4: start_ip = 98000
[    0.424036] NMI watchdog enabled, takes one hw-pmu counter.
[    0.424100]  #5
[    0.424101] smpboot cpu 5: start_ip = 98000
[    0.516041] NMI watchdog enabled, takes one hw-pmu counter.
[    0.516103]  #6
[    0.516104] smpboot cpu 6: start_ip = 98000
[    0.608047] NMI watchdog enabled, takes one hw-pmu counter.
[    0.608109]  #7 Ok.
[    0.608110] smpboot cpu 7: start_ip = 98000
[    0.700051] NMI watchdog enabled, takes one hw-pmu counter.
[    0.700064] Brought up 8 CPUs
[    0.700066] Total of 8 processors activated (64213.37 BogoMIPS).
[    0.704194] devtmpfs: initialized
[    0.706118] PM: Registering ACPI NVS region at dd830000 (335872 bytes)
[    0.706118] PM: Registering ACPI NVS region at dd88c000 (4096 bytes)
[    0.706118] PM: Registering ACPI NVS region at ddad9000 (69632 bytes)
[    0.706118] PM: Registering ACPI NVS region at ddaff000 (8192 bytes)
[    0.706118] PM: Registering ACPI NVS region at ddb0a000 (24576 bytes)
[    0.706118] PM: Registering ACPI NVS region at ddb72000 (2109440 bytes)
[    0.706118] print_constraints: dummy: 
[    0.706118] NET: Registered protocol family 16
[    0.706118] Extended Config Space enabled on 1 nodes
[    0.706118] ACPI: bus type pci registered
[    0.706118] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.706118] PCI: not using MMCONFIG
[    0.706118] PCI: Using configuration type 1 for base access
[    0.706118] PCI: Using configuration type 1 for extended access
[    0.708557] bio: create slab <bio-0> at 0
[    0.708557] ACPI: Added _OSI(Module Device)
[    0.708557] ACPI: Added _OSI(Processor Device)
[    0.708557] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.708557] ACPI: Added _OSI(Processor Aggregator Device)
[    0.708711] ACPI: EC: Look up EC in DSDT
[    0.709335] ACPI: Executed 2 blocks of module-level executable AML code
[    0.720449] ACPI: Interpreter enabled
[    0.720453] ACPI: (supports S0 S1 S3 S4 S5)
[    0.720469] ACPI: Using IOAPIC for interrupt routing
[    0.720574] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.720601] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    0.754326] ACPI: EC: GPE = 0xa, I/O: command/status = 0x66, data = 0x62
[    0.754429] ACPI: No dock devices found.
[    0.754430] HEST: Table not found.
[    0.754432] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.754555] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.754743] pci_root PNP0A03:00: host bridge window [io  0x0000-0x03af]
[    0.754745] pci_root PNP0A03:00: host bridge window [io  0x03e0-0x0cf7]
[    0.754746] pci_root PNP0A03:00: host bridge window [io  0x03b0-0x03df]
[    0.754748] pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff]
[    0.754749] pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff]
[    0.754751] pci_root PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff]
[    0.754752] pci_root PNP0A03:00: host bridge window [mem 0xe0000000-0xffffffff]
[    0.754764] pci 0000:00:00.0: [1002:5a14] type 0 class 0x000600
[    0.754822] pci 0000:00:02.0: [1002:5a16] type 1 class 0x000604
[    0.754852] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.754866] pci 0000:00:04.0: [1002:5a18] type 1 class 0x000604
[    0.754894] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.754907] pci 0000:00:05.0: [1002:5a19] type 1 class 0x000604
[    0.754935] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
[    0.754947] pci 0000:00:06.0: [1002:5a1a] type 1 class 0x000604
[    0.754976] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.754990] pci 0000:00:09.0: [1002:5a1c] type 1 class 0x000604
[    0.755018] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    0.755030] pci 0000:00:0a.0: [1002:5a1d] type 1 class 0x000604
[    0.755058] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    0.755079] pci 0000:00:11.0: [1002:4391] type 0 class 0x000106
[    0.755093] pci 0000:00:11.0: reg 10: [io  0xf040-0xf047]
[    0.755100] pci 0000:00:11.0: reg 14: [io  0xf030-0xf033]
[    0.755107] pci 0000:00:11.0: reg 18: [io  0xf020-0xf027]
[    0.755114] pci 0000:00:11.0: reg 1c: [io  0xf010-0xf013]
[    0.755121] pci 0000:00:11.0: reg 20: [io  0xf000-0xf00f]
[    0.755128] pci 0000:00:11.0: reg 24: [mem 0xfe707000-0xfe7073ff]
[    0.755172] pci 0000:00:12.0: [1002:4397] type 0 class 0x000c03
[    0.755182] pci 0000:00:12.0: reg 10: [mem 0xfe706000-0xfe706fff]
[    0.755264] pci 0000:00:12.2: [1002:4396] type 0 class 0x000c03
[    0.755278] pci 0000:00:12.2: reg 10: [mem 0xfe705000-0xfe7050ff]
[    0.755338] pci 0000:00:12.2: supports D1 D2
[    0.755339] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.755357] pci 0000:00:13.0: [1002:4397] type 0 class 0x000c03
[    0.755366] pci 0000:00:13.0: reg 10: [mem 0xfe704000-0xfe704fff]
[    0.755419] pci 0000:00:13.2: [1002:4396] type 0 class 0x000c03
[    0.755433] pci 0000:00:13.2: reg 10: [mem 0xfe703000-0xfe7030ff]
[    0.755493] pci 0000:00:13.2: supports D1 D2
[    0.755494] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.755511] pci 0000:00:14.0: [1002:4385] type 0 class 0x000c05
[    0.755567] pci 0000:00:14.3: [1002:439d] type 0 class 0x000601
[    0.755623] pci 0000:00:14.4: [1002:4384] type 1 class 0x000604
[    0.755654] pci 0000:00:14.5: [1002:4399] type 0 class 0x000c03
[    0.755663] pci 0000:00:14.5: reg 10: [mem 0xfe702000-0xfe702fff]
[    0.755716] pci 0000:00:15.0: [1002:43a0] type 1 class 0x000604
[    0.755769] pci 0000:00:15.0: supports D1 D2
[    0.755787] pci 0000:00:15.1: [1002:43a1] type 1 class 0x000604
[    0.755840] pci 0000:00:15.1: supports D1 D2
[    0.755861] pci 0000:00:16.0: [1002:4397] type 0 class 0x000c03
[    0.755871] pci 0000:00:16.0: reg 10: [mem 0xfe701000-0xfe701fff]
[    0.755923] pci 0000:00:16.2: [1002:4396] type 0 class 0x000c03
[    0.755937] pci 0000:00:16.2: reg 10: [mem 0xfe700000-0xfe7000ff]
[    0.755997] pci 0000:00:16.2: supports D1 D2
[    0.755998] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
[    0.756015] pci 0000:00:18.0: [1022:1600] type 0 class 0x000600
[    0.756030] pci 0000:00:18.1: [1022:1601] type 0 class 0x000600
[    0.756055] pci 0000:00:18.2: [1022:1602] type 0 class 0x000600
[    0.756067] pci 0000:00:18.3: [1022:1603] type 0 class 0x000600
[    0.756082] pci 0000:00:18.4: [1022:1604] type 0 class 0x000600
[    0.756094] pci 0000:00:18.5: [1022:1605] type 0 class 0x000600
[    0.756146] pci 0000:01:00.0: [10de:11ba] type 0 class 0x000300
[    0.756155] pci 0000:01:00.0: reg 10: [mem 0xfd000000-0xfdffffff]
[    0.756165] pci 0000:01:00.0: reg 14: [mem 0xf0000000-0xf7ffffff 64bit pref]
[    0.756174] pci 0000:01:00.0: reg 1c: [mem 0xf8000000-0xf9ffffff 64bit pref]
[    0.756181] pci 0000:01:00.0: reg 24: [io  0xe000-0xe07f]
[    0.756187] pci 0000:01:00.0: reg 30: [mem 0xfe000000-0xfe07ffff pref]
[    0.756244] pci 0000:01:00.1: [10de:0e0a] type 0 class 0x000403
[    0.756253] pci 0000:01:00.1: reg 10: [mem 0xfe080000-0xfe083fff]
[    0.764061] pci 0000:00:02.0: PCI bridge to [bus 01-01]
[    0.764064] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.764066] pci 0000:00:02.0:   bridge window [mem 0xfd000000-0xfe0fffff]
[    0.764069] pci 0000:00:02.0:   bridge window [mem 0xf0000000-0xf9ffffff 64bit pref]
[    0.764103] pci 0000:02:00.0: [197b:2362] type 0 class 0x000101
[    0.764131] pci 0000:02:00.0: reg 10: [io  0xd040-0xd047]
[    0.764140] pci 0000:02:00.0: reg 14: [io  0xd030-0xd033]
[    0.764150] pci 0000:02:00.0: reg 18: [io  0xd020-0xd027]
[    0.764160] pci 0000:02:00.0: reg 1c: [io  0xd010-0xd013]
[    0.764169] pci 0000:02:00.0: reg 20: [io  0xd000-0xd00f]
[    0.764179] pci 0000:02:00.0: reg 24: [mem 0xfe610000-0xfe6101ff]
[    0.764189] pci 0000:02:00.0: reg 30: [mem 0x00000000-0x0000ffff pref]
[    0.764227] pci 0000:02:00.0: PME# supported from D3hot
[    0.772058] pci 0000:00:04.0: PCI bridge to [bus 02-02]
[    0.772061] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    0.772063] pci 0000:00:04.0:   bridge window [mem 0xfe600000-0xfe6fffff]
[    0.772099] pci 0000:03:00.0: [197b:2362] type 0 class 0x000101
[    0.772122] pci 0000:03:00.0: reg 10: [io  0xc040-0xc047]
[    0.772132] pci 0000:03:00.0: reg 14: [io  0xc030-0xc033]
[    0.772141] pci 0000:03:00.0: reg 18: [io  0xc020-0xc027]
[    0.772151] pci 0000:03:00.0: reg 1c: [io  0xc010-0xc013]
[    0.772161] pci 0000:03:00.0: reg 20: [io  0xc000-0xc00f]
[    0.772171] pci 0000:03:00.0: reg 24: [mem 0xfe510000-0xfe5101ff]
[    0.772181] pci 0000:03:00.0: reg 30: [mem 0x00000000-0x0000ffff pref]
[    0.772249] pci 0000:03:00.0: PME# supported from D3hot
[    0.780058] pci 0000:00:05.0: PCI bridge to [bus 03-03]
[    0.780061] pci 0000:00:05.0:   bridge window [io  0xc000-0xcfff]
[    0.780063] pci 0000:00:05.0:   bridge window [mem 0xfe500000-0xfe5fffff]
[    0.780101] pci 0000:04:00.0: [1b21:1042] type 0 class 0x000c03
[    0.780119] pci 0000:04:00.0: reg 10: [mem 0xfe400000-0xfe407fff 64bit]
[    0.780201] pci 0000:04:00.0: PME# supported from D3hot D3cold
[    0.788058] pci 0000:00:06.0: PCI bridge to [bus 04-04]
[    0.788062] pci 0000:00:06.0:   bridge window [mem 0xfe400000-0xfe4fffff]
[    0.788102] pci 0000:05:00.0: [1b21:1042] type 0 class 0x000c03
[    0.788120] pci 0000:05:00.0: reg 10: [mem 0xfe300000-0xfe307fff 64bit]
[    0.788202] pci 0000:05:00.0: PME# supported from D3hot D3cold
[    0.796058] pci 0000:00:09.0: PCI bridge to [bus 05-05]
[    0.796062] pci 0000:00:09.0:   bridge window [mem 0xfe300000-0xfe3fffff]
[    0.796101] pci 0000:06:00.0: [13f6:5011] type 0 class 0x000403
[    0.796113] pci 0000:06:00.0: reg 10: [mem 0xfe200000-0xfe203fff]
[    0.796202] pci 0000:06:00.0: supports D1 D2
[    0.804060] pci 0000:00:0a.0: PCI bridge to [bus 06-06]
[    0.804064] pci 0000:00:0a.0:   bridge window [mem 0xfe200000-0xfe2fffff]
[    0.804097] pci 0000:07:07.0: [1106:3044] type 0 class 0x000c00
[    0.804117] pci 0000:07:07.0: reg 10: [mem 0xfe100000-0xfe1007ff]
[    0.804127] pci 0000:07:07.0: reg 14: [io  0xb000-0xb07f]
[    0.804201] pci 0000:07:07.0: supports D2
[    0.804203] pci 0000:07:07.0: PME# supported from D2 D3hot D3cold
[    0.804240] pci 0000:00:14.4: PCI bridge to [bus 07-07] (subtractive decode)
[    0.804243] pci 0000:00:14.4:   bridge window [io  0xb000-0xbfff]
[    0.804246] pci 0000:00:14.4:   bridge window [mem 0xfe100000-0xfe1fffff]
[    0.804250] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af] (subtractive decode)
[    0.804251] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7] (subtractive decode)
[    0.804253] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df] (subtractive decode)
[    0.804254] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.804256] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.804257] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    0.804259] pci 0000:00:14.4:   bridge window [mem 0xe0000000-0xffffffff] (subtractive decode)
[    0.804294] pci 0000:00:15.0: PCI bridge to [bus 08-08]
[    0.804352] pci 0000:09:00.0: [10ec:8168] type 0 class 0x000200
[    0.804366] pci 0000:09:00.0: reg 10: [io  0xa000-0xa0ff]
[    0.804391] pci 0000:09:00.0: reg 18: [mem 0xfa104000-0xfa104fff 64bit pref]
[    0.804407] pci 0000:09:00.0: reg 20: [mem 0xfa100000-0xfa103fff 64bit pref]
[    0.804474] pci 0000:09:00.0: supports D1 D2
[    0.804475] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.812063] pci 0000:00:15.1: PCI bridge to [bus 09-09]
[    0.812067] pci 0000:00:15.1:   bridge window [io  0xa000-0xafff]
[    0.812072] pci 0000:00:15.1:   bridge window [mem 0xfa100000-0xfa1fffff 64bit pref]
[    0.812093] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.812190] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PC._PRT]
[    0.812229] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PE20._PRT]
[    0.812251] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PE21._PRT]
[    0.812278] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC02._PRT]
[    0.812299] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC04._PRT]
[    0.812326] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC05._PRT]
[    0.812354] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC06._PRT]
[    0.812376] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC09._PRT]
[    0.812397] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC0A._PRT]
[    0.812421]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.812423]  pci0000:00: ACPI _OSC request failed (AE_NOT_FOUND), returned control mask: 0x1d
[    0.812424] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.817242] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 11 14 15) *0
[    0.817287] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 10 11 14 15) *0
[    0.817333] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 11 14 15) *0
[    0.817378] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 10 11 14 15) *0
[    0.817413] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 7 10 11 14 15) *0
[    0.817440] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 7 10 11 14 15) *0
[    0.817467] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7 10 11 14 15) *0
[    0.817493] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 7 10 11 14 15) *0
[    0.817550] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.817550] vgaarb: loaded
[    0.817550] vgaarb: bridge control possible 0000:01:00.0
[    0.817550] PCI: Using ACPI for IRQ routing
[    0.823807] PCI: pci_cache_line_size set to 64 bytes
[    0.823890] reserve RAM buffer: 000000000009d800 - 000000000009ffff 
[    0.823892] reserve RAM buffer: 00000000dd830000 - 00000000dfffffff 
[    0.823894] reserve RAM buffer: 00000000ddf00000 - 00000000dfffffff 
[    0.823895] reserve RAM buffer: 000000041f000000 - 000000041fffffff 
[    0.823964] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.823966] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.825082] Switching to clocksource hpet
[    0.825246] pnp: PnP ACPI init
[    0.825255] ACPI: bus type pnp registered
[    0.825363] pnp 00:00: [bus 00-ff]
[    0.825365] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.825366] pnp 00:00: [io  0x0000-0x03af window]
[    0.825368] pnp 00:00: [io  0x03e0-0x0cf7 window]
[    0.825369] pnp 00:00: [io  0x03b0-0x03df window]
[    0.825371] pnp 00:00: [io  0x0d00-0xffff window]
[    0.825372] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.825374] pnp 00:00: [mem 0x000c0000-0x000dffff window]
[    0.825375] pnp 00:00: [mem 0xe0000000-0xffffffff window]
[    0.825376] pnp 00:00: [mem 0x00000000 window]
[    0.825415] pnp 00:00: Plug and Play ACPI device, IDs PNP0a03 (active)
[    0.825439] pnp 00:01: [mem 0xe0000000-0xefffffff]
[    0.825475] system 00:01: [mem 0xe0000000-0xefffffff] has been reserved
[    0.825477] system 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.825810] pnp 00:02: [io  0x040b]
[    0.825812] pnp 00:02: [io  0x04d6]
[    0.825813] pnp 00:02: [io  0x0c00-0x0c01]
[    0.825815] pnp 00:02: [io  0x0c14]
[    0.825816] pnp 00:02: [io  0x0c50-0x0c51]
[    0.825817] pnp 00:02: [io  0x0c52]
[    0.825818] pnp 00:02: [io  0x0c6c]
[    0.825819] pnp 00:02: [io  0x0c6f]
[    0.825820] pnp 00:02: [io  0x0cd0-0x0cd1]
[    0.825821] pnp 00:02: [io  0x0cd2-0x0cd3]
[    0.825822] pnp 00:02: [io  0x0cd4-0x0cd5]
[    0.825823] pnp 00:02: [io  0x0cd6-0x0cd7]
[    0.825824] pnp 00:02: [io  0x0cd8-0x0cdf]
[    0.825825] pnp 00:02: [io  0x0800-0x089f]
[    0.825827] pnp 00:02: [io  0x0000-0xffffffffffffffff disabled]
[    0.825828] pnp 00:02: [io  0x0000-0x000f]
[    0.825829] pnp 00:02: [io  0x0b20-0x0b3f]
[    0.825831] pnp 00:02: [io  0x0900-0x090f]
[    0.825832] pnp 00:02: [io  0x0910-0x091f]
[    0.825833] pnp 00:02: [io  0xfe00-0xfefe]
[    0.825834] pnp 00:02: [io  0x0060-0x005f disabled]
[    0.825835] pnp 00:02: [io  0x0064-0x0063 disabled]
[    0.825836] pnp 00:02: [mem 0xfec00000-0xfec00fff]
[    0.825838] pnp 00:02: [mem 0xfee00000-0xfee00fff]
[    0.825839] pnp 00:02: [mem 0xfed80000-0xfed8ffff]
[    0.825840] pnp 00:02: [mem 0xfed61000-0xfed70fff]
[    0.825841] pnp 00:02: [mem 0xfec10000-0xfec10fff]
[    0.825842] pnp 00:02: [mem 0xfed00000-0xfed00fff]
[    0.825843] pnp 00:02: [mem 0xffc00000-0xffffffff]
[    0.825902] system 00:02: [io  0x040b] has been reserved
[    0.825904] system 00:02: [io  0x04d6] has been reserved
[    0.825906] system 00:02: [io  0x0c00-0x0c01] has been reserved
[    0.825907] system 00:02: [io  0x0c14] has been reserved
[    0.825909] system 00:02: [io  0x0c50-0x0c51] has been reserved
[    0.825910] system 00:02: [io  0x0c52] has been reserved
[    0.825912] system 00:02: [io  0x0c6c] has been reserved
[    0.825913] system 00:02: [io  0x0c6f] has been reserved
[    0.825915] system 00:02: [io  0x0cd0-0x0cd1] has been reserved
[    0.825916] system 00:02: [io  0x0cd2-0x0cd3] has been reserved
[    0.825917] system 00:02: [io  0x0cd4-0x0cd5] has been reserved
[    0.825919] system 00:02: [io  0x0cd6-0x0cd7] has been reserved
[    0.825920] system 00:02: [io  0x0cd8-0x0cdf] has been reserved
[    0.825922] system 00:02: [io  0x0800-0x089f] has been reserved
[    0.825923] system 00:02: [io  0x0b20-0x0b3f] has been reserved
[    0.825925] system 00:02: [io  0x0900-0x090f] has been reserved
[    0.825926] system 00:02: [io  0x0910-0x091f] has been reserved
[    0.825928] system 00:02: [io  0xfe00-0xfefe] has been reserved
[    0.825930] system 00:02: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.825932] system 00:02: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.825934] system 00:02: [mem 0xfed80000-0xfed8ffff] has been reserved
[    0.825936] system 00:02: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.825937] system 00:02: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.825939] system 00:02: [mem 0xfed00000-0xfed00fff] has been reserved
[    0.825941] system 00:02: [mem 0xffc00000-0xffffffff] has been reserved
[    0.825943] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.826027] pnp 00:03: [io  0x0000-0xffffffffffffffff disabled]
[    0.826028] pnp 00:03: [io  0x0290-0x02af]
[    0.826030] pnp 00:03: [io  0x0000-0xffffffffffffffff disabled]
[    0.826063] system 00:03: [io  0x0290-0x02af] has been reserved
[    0.826065] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.826073] pnp 00:04: [dma 4]
[    0.826074] pnp 00:04: [io  0x0000-0x000f]
[    0.826076] pnp 00:04: [io  0x0081-0x0083]
[    0.826077] pnp 00:04: [io  0x0087]
[    0.826078] pnp 00:04: [io  0x0089-0x008b]
[    0.826079] pnp 00:04: [io  0x008f]
[    0.826080] pnp 00:04: [io  0x00c0-0x00df]
[    0.826101] pnp 00:04: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.826107] pnp 00:05: [io  0x0070-0x0071]
[    0.826117] pnp 00:05: [irq 8]
[    0.826134] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.826140] pnp 00:06: [io  0x0061]
[    0.826157] pnp 00:06: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.826184] pnp 00:07: [io  0x0010-0x001f]
[    0.826187] pnp 00:07: [io  0x0022-0x003f]
[    0.826190] pnp 00:07: [io  0x0044-0x005f]
[    0.826192] pnp 00:07: [io  0x0062-0x0063]
[    0.826193] pnp 00:07: [io  0x0065-0x006f]
[    0.826195] pnp 00:07: [io  0x0072-0x007f]
[    0.826197] pnp 00:07: [io  0x0080]
[    0.826198] pnp 00:07: [io  0x0084-0x0086]
[    0.826199] pnp 00:07: [io  0x0088]
[    0.826200] pnp 00:07: [io  0x008c-0x008e]
[    0.826201] pnp 00:07: [io  0x0090-0x009f]
[    0.826202] pnp 00:07: [io  0x00a2-0x00bf]
[    0.826203] pnp 00:07: [io  0x00e0-0x00ef]
[    0.826204] pnp 00:07: [io  0x04d0-0x04d1]
[    0.826244] system 00:07: [io  0x04d0-0x04d1] has been reserved
[    0.826246] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.826252] pnp 00:08: [io  0x00f0-0x00ff]
[    0.826255] pnp 00:08: [irq 13]
[    0.826273] pnp 00:08: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.826312] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.826456] pnp 00:0a: [io  0x03f8-0x03ff]
[    0.826459] pnp 00:0a: [irq 4]
[    0.826460] pnp 00:0a: [dma 0 disabled]
[    0.826500] pnp 00:0a: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.826570] pnp 00:0b: [mem 0x00000000-0xffffffffffffffff disabled]
[    0.826606] system 00:0b: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.826665] pnp 00:0c: [mem 0x00000000-0xffffffffffffffff disabled]
[    0.826667] pnp 00:0c: [mem 0xfec20000-0xfec200ff]
[    0.826704] system 00:0c: [mem 0xfec20000-0xfec200ff] could not be reserved
[    0.826706] system 00:0c: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.826815] pnp 00:0d: [mem 0xfed00000-0xfed003ff]
[    0.826843] pnp 00:0d: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.826847] pnp: PnP ACPI: found 14 devices
[    0.826848] ACPI: ACPI bus type pnp unregistered
[    0.833256] PCI: max bus depth: 1 pci_try_num: 2
[    0.833288] pci 0000:00:04.0: BAR 15: assigned [mem 0xfa000000-0xfa0fffff pref]
[    0.833291] pci 0000:00:05.0: BAR 15: assigned [mem 0xfa200000-0xfa2fffff pref]
[    0.833293] pci 0000:00:02.0: PCI bridge to [bus 01-01]
[    0.833295] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.833297] pci 0000:00:02.0:   bridge window [mem 0xfd000000-0xfe0fffff]
[    0.833299] pci 0000:00:02.0:   bridge window [mem 0xf0000000-0xf9ffffff 64bit pref]
[    0.833303] pci 0000:02:00.0: BAR 6: assigned [mem 0xfa000000-0xfa00ffff pref]
[    0.833304] pci 0000:00:04.0: PCI bridge to [bus 02-02]
[    0.833306] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    0.833308] pci 0000:00:04.0:   bridge window [mem 0xfe600000-0xfe6fffff]
[    0.833310] pci 0000:00:04.0:   bridge window [mem 0xfa000000-0xfa0fffff pref]
[    0.833314] pci 0000:03:00.0: BAR 6: assigned [mem 0xfa200000-0xfa20ffff pref]
[    0.833315] pci 0000:00:05.0: PCI bridge to [bus 03-03]
[    0.833317] pci 0000:00:05.0:   bridge window [io  0xc000-0xcfff]
[    0.833319] pci 0000:00:05.0:   bridge window [mem 0xfe500000-0xfe5fffff]
[    0.833321] pci 0000:00:05.0:   bridge window [mem 0xfa200000-0xfa2fffff pref]
[    0.833323] pci 0000:00:06.0: PCI bridge to [bus 04-04]
[    0.833325] pci 0000:00:06.0:   bridge window [mem 0xfe400000-0xfe4fffff]
[    0.833329] pci 0000:00:09.0: PCI bridge to [bus 05-05]
[    0.833331] pci 0000:00:09.0:   bridge window [mem 0xfe300000-0xfe3fffff]
[    0.833334] pci 0000:00:0a.0: PCI bridge to [bus 06-06]
[    0.833336] pci 0000:00:0a.0:   bridge window [mem 0xfe200000-0xfe2fffff]
[    0.833339] pci 0000:00:14.4: PCI bridge to [bus 07-07]
[    0.833341] pci 0000:00:14.4:   bridge window [io  0xb000-0xbfff]
[    0.833344] pci 0000:00:14.4:   bridge window [mem 0xfe100000-0xfe1fffff]
[    0.833350] pci 0000:00:15.0: PCI bridge to [bus 08-08]
[    0.833357] pci 0000:00:15.1: PCI bridge to [bus 09-09]
[    0.833359] pci 0000:00:15.1:   bridge window [io  0xa000-0xafff]
[    0.833363] pci 0000:00:15.1:   bridge window [mem 0xfa100000-0xfa1fffff 64bit pref]
[    0.833404] pci 0000:00:02.0: setting latency timer to 64
[    0.833408] pci 0000:00:04.0: setting latency timer to 64
[    0.833412] pci 0000:00:05.0: setting latency timer to 64
[    0.833418] pci 0000:00:06.0: setting latency timer to 64
[    0.833421] pci 0000:00:09.0: setting latency timer to 64
[    0.833426] pci 0000:00:0a.0: setting latency timer to 64
[    0.833437] pci 0000:00:15.0: setting latency timer to 64
[    0.833442] pci 0000:00:15.1: setting latency timer to 64
[    0.833444] pci_bus 0000:00: resource 4 [io  0x0000-0x03af]
[    0.833446] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7]
[    0.833447] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df]
[    0.833448] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff]
[    0.833450] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff]
[    0.833451] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff]
[    0.833452] pci_bus 0000:00: resource 10 [mem 0xe0000000-0xffffffff]
[    0.833454] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.833455] pci_bus 0000:01: resource 1 [mem 0xfd000000-0xfe0fffff]
[    0.833456] pci_bus 0000:01: resource 2 [mem 0xf0000000-0xf9ffffff 64bit pref]
[    0.833458] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    0.833459] pci_bus 0000:02: resource 1 [mem 0xfe600000-0xfe6fffff]
[    0.833460] pci_bus 0000:02: resource 2 [mem 0xfa000000-0xfa0fffff pref]
[    0.833462] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
[    0.833463] pci_bus 0000:03: resource 1 [mem 0xfe500000-0xfe5fffff]
[    0.833464] pci_bus 0000:03: resource 2 [mem 0xfa200000-0xfa2fffff pref]
[    0.833466] pci_bus 0000:04: resource 1 [mem 0xfe400000-0xfe4fffff]
[    0.833467] pci_bus 0000:05: resource 1 [mem 0xfe300000-0xfe3fffff]
[    0.833469] pci_bus 0000:06: resource 1 [mem 0xfe200000-0xfe2fffff]
[    0.833470] pci_bus 0000:07: resource 0 [io  0xb000-0xbfff]
[    0.833471] pci_bus 0000:07: resource 1 [mem 0xfe100000-0xfe1fffff]
[    0.833472] pci_bus 0000:07: resource 4 [io  0x0000-0x03af]
[    0.833474] pci_bus 0000:07: resource 5 [io  0x03e0-0x0cf7]
[    0.833475] pci_bus 0000:07: resource 6 [io  0x03b0-0x03df]
[    0.833476] pci_bus 0000:07: resource 7 [io  0x0d00-0xffff]
[    0.833477] pci_bus 0000:07: resource 8 [mem 0x000a0000-0x000bffff]
[    0.833479] pci_bus 0000:07: resource 9 [mem 0x000c0000-0x000dffff]
[    0.833480] pci_bus 0000:07: resource 10 [mem 0xe0000000-0xffffffff]
[    0.833481] pci_bus 0000:09: resource 0 [io  0xa000-0xafff]
[    0.833483] pci_bus 0000:09: resource 2 [mem 0xfa100000-0xfa1fffff 64bit pref]
[    0.833598] NET: Registered protocol family 2
[    0.833872] IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.835061] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    0.836512] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.836685] TCP: Hash tables configured (established 524288 bind 65536)
[    0.836687] TCP reno registered
[    0.836703] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.836763] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.836924] NET: Registered protocol family 1
[    1.928086] pci 0000:01:00.0: Boot video device
[    1.928180] PCI: CLS 64 bytes, default 64
[    1.928213] Unpacking initramfs...
[    2.088198] Freeing initrd memory: 10920k freed
[    2.090351] PCI-DMA: Disabling AGP.
[    2.090436] PCI-DMA: aperture base @ d4000000 size 65536 KB
[    2.090437] PCI-DMA: using GART IOMMU.
[    2.090440] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    2.094414] perf: AMD IBS detected (0x000000ff)
[    2.094617] audit: initializing netlink socket (disabled)
[    2.094630] type=2000 audit(1386198985.088:1): initialized
[    2.104826] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.106408] VFS: Disk quotas dquot_6.5.2
[    2.106439] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.106494] msgmni has been set to 32059
[    2.106642] alg: No test for stdrng (krng)
[    2.106674] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    2.106676] io scheduler noop registered
[    2.106677] io scheduler deadline registered
[    2.106713] io scheduler cfq registered (default)
[    2.106962] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    2.106975] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    2.106976] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    2.107216] ERST: Table is not found!
[    2.107217] GHES: HEST is not enabled!
[    2.107262] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.127598] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    2.296539] 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    2.296796] Linux agpgart interface v0.103
[    2.296886] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    2.297230] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.297235] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.297330] mousedev: PS/2 mouse device common for all mice
[    2.297362] rtc_cmos 00:05: RTC can wake from S4
[    2.297435] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    2.297453] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    2.297461] cpuidle: using governor ladder
[    2.297462] cpuidle: using governor menu
[    2.297609] TCP cubic registered
[    2.297708] NET: Registered protocol family 10
[    2.298067] Mobile IPv6
[    2.298069] NET: Registered protocol family 17
[    2.298072] Registering the dns_resolver key type
[    2.298165] PM: Hibernation image not present or could not be loaded.
[    2.298172] registered taskstats version 1
[    2.299189] rtc_cmos 00:05: setting system clock to 2013-12-04 23:16:26 UTC (1386198986)
[    2.299234] Initializing network drop monitor service
[    2.300050] Freeing unused kernel memory: 576k freed
[    2.300138] Write protecting the kernel read-only data: 6144k
[    2.301855] Freeing unused kernel memory: 652k freed
[    2.303665] Freeing unused kernel memory: 688k freed
[    2.312106] udevd[79]: starting version 175
[    2.321709] SCSI subsystem initialized
[    2.322453] usbcore: registered new interface driver usbfs
[    2.322473] usbcore: registered new interface driver hub
[    2.323101] usbcore: registered new device driver usb
[    2.323576] libata version 3.00 loaded.
[    2.323682] xhci_hcd 0000:04:00.0: setting latency timer to 64
[    2.323686] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    2.323706] xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus number 1
[    2.324178] ahci 0000:00:11.0: version 3.0
[    2.324311] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    2.324314] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    2.326250] scsi0 : ahci
[    2.328663] scsi1 : ahci
[    2.331845] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.332038] scsi2 : ahci
[    2.332132] scsi3 : ahci
[    2.332183] scsi4 : ahci
[    2.332421] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    2.332469] r8169 0000:09:00.0: setting latency timer to 64
[    2.333548] r8169 0000:09:00.0: irq 72 for MSI/MSI-X
[    2.333879] scsi5 : ahci
[    2.333881] xhci_hcd 0000:04:00.0: irq 73 for MSI/MSI-X
[    2.333886] xhci_hcd 0000:04:00.0: irq 74 for MSI/MSI-X
[    2.333893] xhci_hcd 0000:04:00.0: irq 75 for MSI/MSI-X
[    2.333900] xhci_hcd 0000:04:00.0: irq 76 for MSI/MSI-X
[    2.333906] xhci_hcd 0000:04:00.0: irq 77 for MSI/MSI-X
[    2.333910] xhci_hcd 0000:04:00.0: irq 78 for MSI/MSI-X
[    2.333915] xhci_hcd 0000:04:00.0: irq 79 for MSI/MSI-X
[    2.333924] xhci_hcd 0000:04:00.0: irq 80 for MSI/MSI-X
[    2.333986] r8169 0000:09:00.0: eth0: RTL8168evl/8111evl at 0xffffc900125c6000, f4:6d:04:58:ff:c4, XID 0c900800 IRQ 72
[    2.333993] r8169 0000:09:00.0: eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    2.334026] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.334028] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.334030] usb usb1: Product: xHCI Host Controller
[    2.334032] usb usb1: Manufacturer: Linux 3.2.0-4-amd64 xhci_hcd
[    2.334033] usb usb1: SerialNumber: 0000:04:00.0
[    2.334149] xHCI xhci_add_endpoint called for root hub
[    2.334151] xHCI xhci_check_bandwidth called for root hub
[    2.334175] hub 1-0:1.0: USB hub found
[    2.334183] hub 1-0:1.0: 2 ports detected
[    2.334253] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    2.334257] xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus number 2
[    2.334277] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    2.334279] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.334280] usb usb2: Product: xHCI Host Controller
[    2.334282] usb usb2: Manufacturer: Linux 3.2.0-4-amd64 xhci_hcd
[    2.334284] usb usb2: SerialNumber: 0000:04:00.0
[    2.334301] ata1: SATA max UDMA/133 abar m1024@0xfe707000 port 0xfe707100 irq 19
[    2.334304] ata2: SATA max UDMA/133 abar m1024@0xfe707000 port 0xfe707180 irq 19
[    2.334307] ata3: SATA max UDMA/133 abar m1024@0xfe707000 port 0xfe707200 irq 19
[    2.334310] ata4: SATA max UDMA/133 abar m1024@0xfe707000 port 0xfe707280 irq 19
[    2.334312] ata5: SATA max UDMA/133 abar m1024@0xfe707000 port 0xfe707300 irq 19
[    2.334315] ata6: SATA max UDMA/133 abar m1024@0xfe707000 port 0xfe707380 irq 19
[    2.334348] xHCI xhci_add_endpoint called for root hub
[    2.334350] xHCI xhci_check_bandwidth called for root hub
[    2.334365] ehci_hcd 0000:00:12.2: EHCI Host Controller
[    2.334385] hub 2-0:1.0: USB hub found
[    2.334391] hub 2-0:1.0: 2 ports detected
[    2.334434] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 3
[    2.334438] ahci 0000:02:00.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
[    2.334442] ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
[    2.334447] ahci 0000:02:00.0: setting latency timer to 64
[    2.334450] ehci_hcd 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.334473] QUIRK: Enable AMD PLL fix
[    2.334483] ehci_hcd 0000:00:12.2: debug port 1
[    2.334510] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfe705000
[    2.334842] scsi6 : ahci
[    2.335899] scsi7 : ahci
[    2.335988] ata7: SATA max UDMA/133 abar m512@0xfe610000 port 0xfe610100 irq 44
[    2.335991] ata8: SATA max UDMA/133 abar m512@0xfe610000 port 0xfe610180 irq 44
[    2.336110] ahci 0000:03:00.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
[    2.336113] ahci 0000:03:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
[    2.336118] ahci 0000:03:00.0: setting latency timer to 64
[    2.336454] scsi8 : ahci
[    2.336582] scsi9 : ahci
[    2.336656] ata9: SATA max UDMA/133 abar m512@0xfe510000 port 0xfe510100 irq 46
[    2.336687] ata10: SATA max UDMA/133 abar m512@0xfe510000 port 0xfe510180 irq 46
[    2.344051] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    2.344068] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    2.344070] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.344071] usb usb3: Product: EHCI Host Controller
[    2.344073] usb usb3: Manufacturer: Linux 3.2.0-4-amd64 ehci_hcd
[    2.344074] usb usb3: SerialNumber: 0000:00:12.2
[    2.344154] hub 3-0:1.0: USB hub found
[    2.344158] hub 3-0:1.0: 5 ports detected
[    2.344231] ehci_hcd 0000:00:13.2: EHCI Host Controller
[    2.344237] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 4
[    2.344242] ehci_hcd 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.344256] ehci_hcd 0000:00:13.2: debug port 1
[    2.344271] ehci_hcd 0000:00:13.2: irq 21, io mem 0xfe703000
[    2.348102] xhci_hcd 0000:05:00.0: setting latency timer to 64
[    2.348105] xhci_hcd 0000:05:00.0: xHCI Host Controller
[    2.348112] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus number 5
[    2.356304] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.357784] xhci_hcd 0000:05:00.0: irq 81 for MSI/MSI-X
[    2.357789] xhci_hcd 0000:05:00.0: irq 82 for MSI/MSI-X
[    2.357793] xhci_hcd 0000:05:00.0: irq 83 for MSI/MSI-X
[    2.357796] xhci_hcd 0000:05:00.0: irq 84 for MSI/MSI-X
[    2.357800] xhci_hcd 0000:05:00.0: irq 85 for MSI/MSI-X
[    2.357804] xhci_hcd 0000:05:00.0: irq 86 for MSI/MSI-X
[    2.357807] xhci_hcd 0000:05:00.0: irq 87 for MSI/MSI-X
[    2.357810] xhci_hcd 0000:05:00.0: irq 88 for MSI/MSI-X
[    2.357884] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
[    2.357885] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.357887] usb usb5: Product: xHCI Host Controller
[    2.357888] usb usb5: Manufacturer: Linux 3.2.0-4-amd64 xhci_hcd
[    2.357889] usb usb5: SerialNumber: 0000:05:00.0
[    2.357946] xHCI xhci_add_endpoint called for root hub
[    2.357948] xHCI xhci_check_bandwidth called for root hub
[    2.357966] hub 5-0:1.0: USB hub found
[    2.357971] hub 5-0:1.0: 2 ports detected
[    2.358015] xhci_hcd 0000:05:00.0: xHCI Host Controller
[    2.358019] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus number 6
[    2.358034] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003
[    2.358036] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.358037] usb usb6: Product: xHCI Host Controller
[    2.358038] usb usb6: Manufacturer: Linux 3.2.0-4-amd64 xhci_hcd
[    2.358040] usb usb6: SerialNumber: 0000:05:00.0
[    2.358088] xHCI xhci_add_endpoint called for root hub
[    2.358089] xHCI xhci_check_bandwidth called for root hub
[    2.358108] hub 6-0:1.0: USB hub found
[    2.358113] hub 6-0:1.0: 2 ports detected
[    2.360036] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    2.360049] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
[    2.360050] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.360052] usb usb4: Product: EHCI Host Controller
[    2.360053] usb usb4: Manufacturer: Linux 3.2.0-4-amd64 ehci_hcd
[    2.360054] usb usb4: SerialNumber: 0000:00:13.2
[    2.360134] hub 4-0:1.0: USB hub found
[    2.360137] hub 4-0:1.0: 5 ports detected
[    2.360224] ehci_hcd 0000:00:16.2: EHCI Host Controller
[    2.360229] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 7
[    2.360234] ehci_hcd 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.360248] ehci_hcd 0000:00:16.2: debug port 1
[    2.360263] ehci_hcd 0000:00:16.2: irq 23, io mem 0xfe700000
[    2.376038] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
[    2.376050] usb usb7: New USB device found, idVendor=1d6b, idProduct=0002
[    2.376052] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.376053] usb usb7: Product: EHCI Host Controller
[    2.376055] usb usb7: Manufacturer: Linux 3.2.0-4-amd64 ehci_hcd
[    2.376056] usb usb7: SerialNumber: 0000:00:16.2
[    2.376139] hub 7-0:1.0: USB hub found
[    2.376142] hub 7-0:1.0: 4 ports detected
[    2.376247] ohci_hcd 0000:00:12.0: OHCI Host Controller
[    2.376255] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 8
[    2.376278] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfe706000
[    2.436051] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
[    2.436054] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.436055] usb usb8: Product: OHCI Host Controller
[    2.436056] usb usb8: Manufacturer: Linux 3.2.0-4-amd64 ohci_hcd
[    2.436058] usb usb8: SerialNumber: 0000:00:12.0
[    2.436139] hub 8-0:1.0: USB hub found
[    2.436144] hub 8-0:1.0: 5 ports detected
[    2.436217] ohci_hcd 0000:00:13.0: OHCI Host Controller
[    2.436224] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 9
[    2.436271] ohci_hcd 0000:00:13.0: irq 20, io mem 0xfe704000
[    2.496035] usb usb9: New USB device found, idVendor=1d6b, idProduct=0001
[    2.496037] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.496038] usb usb9: Product: OHCI Host Controller
[    2.496039] usb usb9: Manufacturer: Linux 3.2.0-4-amd64 ohci_hcd
[    2.496041] usb usb9: SerialNumber: 0000:00:13.0
[    2.496116] hub 9-0:1.0: USB hub found
[    2.496120] hub 9-0:1.0: 5 ports detected
[    2.496178] ohci_hcd 0000:00:14.5: OHCI Host Controller
[    2.496183] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 10
[    2.496193] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfe702000
[    2.556060] usb usb10: New USB device found, idVendor=1d6b, idProduct=0001
[    2.556062] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.556064] usb usb10: Product: OHCI Host Controller
[    2.556065] usb usb10: Manufacturer: Linux 3.2.0-4-amd64 ohci_hcd
[    2.556066] usb usb10: SerialNumber: 0000:00:14.5
[    2.556144] hub 10-0:1.0: USB hub found
[    2.556148] hub 10-0:1.0: 2 ports detected
[    2.556208] ohci_hcd 0000:00:16.0: OHCI Host Controller
[    2.556216] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 11
[    2.556235] ohci_hcd 0000:00:16.0: irq 22, io mem 0xfe701000
[    2.616032] usb usb11: New USB device found, idVendor=1d6b, idProduct=0001
[    2.616034] usb usb11: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.616036] usb usb11: Product: OHCI Host Controller
[    2.616037] usb usb11: Manufacturer: Linux 3.2.0-4-amd64 ohci_hcd
[    2.616038] usb usb11: SerialNumber: 0000:00:16.0
[    2.616116] hub 11-0:1.0: USB hub found
[    2.616121] hub 11-0:1.0: 4 ports detected
[    2.656085] ata5: SATA link down (SStatus 0 SControl 300)
[    2.656126] ata2: SATA link down (SStatus 0 SControl 300)
[    2.656149] ata3: SATA link down (SStatus 0 SControl 300)
[    2.660044] usb 3-2: new high-speed USB device number 2 using ehci_hcd
[    2.660069] ata6: SATA link down (SStatus 0 SControl 300)
[    2.660072] ata9: SATA link down (SStatus 0 SControl 300)
[    2.660122] ata4: SATA link down (SStatus 0 SControl 300)
[    2.664059] ata7: SATA link down (SStatus 0 SControl 300)
[    2.664087] ata8: SATA link down (SStatus 0 SControl 300)
[    2.793465] usb 3-2: New USB device found, idVendor=0409, idProduct=0058
[    2.793467] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.793469] usb 3-2: Product: USB2.0 Hub Controller
[    2.793470] usb 3-2: Manufacturer: NEC Corporation
[    2.793636] hub 3-2:1.0: USB hub found
[    2.793714] hub 3-2:1.0: 4 ports detected
[    2.828045] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.828217] ata1.00: ATA-9: Samsung SSD 840 EVO 1TB, EXT0BB0Q, max UDMA/133
[    2.828220] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    2.828407] ata1.00: configured for UDMA/133
[    2.828515] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 840  EXT0 PQ: 0 ANSI: 5
[    2.840047] ata10: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.842758] ata10.00: ATAPI: HL-DT-ST DVDRAM GSA-H66N, CB00, max UDMA/100
[    2.846723] ata10.00: configured for UDMA/100
[    2.960352] scsi 9:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-H66N  CB00 PQ: 0 ANSI: 5
[    2.963582] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
[    2.963639] sd 0:0:0:0: [sda] Write Protect is off
[    2.963641] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.963652] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.963954]  sda: sda1 sda2 sda3
[    2.964040] usb 4-3: new high-speed USB device number 3 using ehci_hcd
[    2.964236] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.965547] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.965581] sr 9:0:0:0: Attached scsi generic sg1 type 5
[    3.024068] firewire_ohci: Added fw-ohci device 0000:07:07.0, OHCI v1.10, 4 IR + 8 IT contexts, quirks 0x11
[    3.070946] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    3.070948] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.071044] sr 9:0:0:0: Attached scsi CD-ROM sr0
[    3.092042] Refined TSC clocksource calibration: 4013.472 MHz.
[    3.092046] Switching to clocksource tsc
[    3.097684] usb 4-3: New USB device found, idVendor=05e3, idProduct=0608
[    3.097687] usb 4-3: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    3.097688] usb 4-3: Product: USB2.0 Hub
[    3.098102] hub 4-3:1.0: USB hub found
[    3.098433] hub 4-3:1.0: 4 ports detected
[    3.476010] usb 9-2: new low-speed USB device number 2 using ohci_hcd
[    3.524068] firewire_core: created device fw0: GUID 001fc60000141e82, S400
[    3.655074] usb 9-2: New USB device found, idVendor=04d9, idProduct=2013
[    3.655077] usb 9-2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    3.655078] usb 9-2: Product: daskeyboard
[    3.672189] input: daskeyboard as /devices/pci0000:00/0000:00:13.0/usb9/9-2/9-2:1.0/input/input0
[    3.672227] generic-usb 0003:04D9:2013.0001: input,hidraw0: USB HID v1.10 Keyboard [daskeyboard] on usb-0000:00:13.0-2/input0
[    3.698174] input: daskeyboard as /devices/pci0000:00/0000:00:13.0/usb9/9-2/9-2:1.1/input/input1
[    3.698210] generic-usb 0003:04D9:2013.0002: input,hidraw1: USB HID v1.10 Device [daskeyboard] on usb-0000:00:13.0-2/input1
[    3.698221] usbcore: registered new interface driver usbhid
[    3.698222] usbhid: USB HID core driver
[    3.924029] usb 9-5: new full-speed USB device number 3 using ohci_hcd
[    3.966349] device-mapper: uevent: version 1.0.3
[    3.966401] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) initialised: dm-devel@redhat.com
[    4.101074] usb 9-5: New USB device found, idVendor=1532, idProduct=0037
[    4.101076] usb 9-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.101078] usb 9-5: Product: Razer DeathAdder 2013
[    4.101079] usb 9-5: Manufacturer: Razer
[    4.107190] input: Razer Razer DeathAdder 2013 as /devices/pci0000:00/0000:00:13.0/usb9/9-5/9-5:1.0/input/input2
[    4.107250] generic-usb 0003:1532:0037.0003: input,hidraw2: USB HID v1.11 Mouse [Razer Razer DeathAdder 2013] on usb-0000:00:13.0-5/input0
[    4.117157] input: Razer Razer DeathAdder 2013 as /devices/pci0000:00/0000:00:13.0/usb9/9-5/9-5:1.1/input/input3
[    4.117200] generic-usb 0003:1532:0037.0004: input,hidraw3: USB HID v1.11 Keyboard [Razer Razer DeathAdder 2013] on usb-0000:00:13.0-5/input1
[    4.121186] input: Razer Razer DeathAdder 2013 as /devices/pci0000:00/0000:00:13.0/usb9/9-5/9-5:1.2/input/input4
[    4.121226] generic-usb 0003:1532:0037.0005: input,hidraw4: USB HID v1.11 Keyboard [Razer Razer DeathAdder 2013] on usb-0000:00:13.0-5/input2
[    4.170756] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[    4.480137] udevd[426]: starting version 175
[    4.517759] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input5
[    4.517767] ACPI: Power Button [PWRB]
[    4.517812] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input6
[    4.517816] ACPI: Power Button [PWRF]
[    4.518616] ACPI: acpi_idle registered with cpuidle
[    4.519950] wmi: Mapper loaded
[    4.582379] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    4.583921] SP5100 TCO timer: SP5100 TCO WatchDog Timer Driver v0.01
[    4.583989] SP5100 TCO timer: mmio address 0xbafe00 already in use
[    4.586014] EDAC MC: Ver: 2.1.0
[    4.587150] MCE: In-kernel MCE decoding enabled.
[    4.587951] input: PC Speaker as /devices/platform/pcspkr/input/input7
[    4.588260] AMD64 EDAC driver v3.4.0
[    4.588294] EDAC amd64: DRAM ECC disabled.
[    4.588304] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
[    4.588304]  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
[    4.588305]  (Note that use of the override may cause unknown side effects.)
[    4.597513] nvidia: module license 'NVIDIA' taints kernel.
[    4.597515] Disabling lock debugging due to kernel taint
[    4.603742] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aesni)
[    4.604951] asus_wmi: ASUS WMI generic driver loaded
[    4.605647] asus_wmi: Initialization: 0x0
[    4.605665] asus_wmi: BIOS WMI version: 0.9
[    4.605697] asus_wmi: SFUN value: 0x0
[    4.605959] input: Eee PC WMI hotkeys as /devices/platform/eeepc-wmi/input/input8
[    4.607608] powernow-k8: Found 1 AMD FX(tm)-8350 Eight-Core Processor            (8 cpu cores) (version 2.20.00)
[    4.607621] powernow-k8: Core Performance Boosting: on.
[    4.607631] [Firmware Bug]: powernow-k8: No compatible ACPI _PSS objects found.
[    4.607631] [Firmware Bug]: powernow-k8: Try again with latest BIOS.
[    4.660369] nvidia 0000:01:00.0: setting latency timer to 64
[    4.660373] vgaarb: device changed decodes: PCI:0000:01:00.0,olddecodes=io+mem,decodes=none:owns=io+mem
[    4.660468] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  331.20  Wed Oct 30 17:43:35 PDT 2013
[    4.673200] powernow-k8: Found 1 AMD FX(tm)-8350 Eight-Core Processor            (8 cpu cores) (version 2.20.00)
[    4.673214] powernow-k8: Core Performance Boosting: on.
[    4.673225] [Firmware Bug]: powernow-k8: No compatible ACPI _PSS objects found.
[    4.673225] [Firmware Bug]: powernow-k8: Try again with latest BIOS.
[    5.319339] kvm: Nested Virtualization enabled
[    5.319343] kvm: Nested Paging enabled
[    5.387295] EXT4-fs (sda3): re-mounted. Opts: (null)
[    5.422300] EXT4-fs (sda3): re-mounted. Opts: errors=remount-ro,discard
[    5.434940] loop: module loaded
[    5.824543] RPC: Registered named UNIX socket transport module.
[    5.824545] RPC: Registered udp transport module.
[    5.824546] RPC: Registered tcp transport module.
[    5.824547] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    5.828146] FS-Cache: Loaded
[    5.832845] FS-Cache: Netfs 'nfs' registered for caching
[    5.836170] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    6.098011] powernow-k8: Found 1 AMD FX(tm)-8350 Eight-Core Processor            (8 cpu cores) (version 2.20.00)
[    6.098025] powernow-k8: Core Performance Boosting: on.
[    6.098036] [Firmware Bug]: powernow-k8: No compatible ACPI _PSS objects found.
[    6.098037] [Firmware Bug]: powernow-k8: Try again with latest BIOS.
[    6.126374] Bluetooth: Core ver 2.16
[    6.126387] NET: Registered protocol family 31
[    6.126388] Bluetooth: HCI device and connection manager initialized
[    6.126390] Bluetooth: HCI socket layer initialized
[    6.126391] Bluetooth: L2CAP socket layer initialized
[    6.126394] Bluetooth: SCO socket layer initialized
[    6.128452] Bluetooth: RFCOMM TTY layer initialized
[    6.128455] Bluetooth: RFCOMM socket layer initialized
[    6.128457] Bluetooth: RFCOMM ver 1.11
[    6.151254] lp: driver loaded but no devices found
[    6.153677] ppdev: user-space parallel port driver
[    6.157603] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    6.157605] Bluetooth: BNEP filters: protocol multicast
[    6.178036] vboxdrv: Found 8 processor cores.
[    6.178254] vboxdrv: fAsync=0 offMin=0x45f offMax=0x43b9
[    6.178318] vboxdrv: TSC mode is 'synchronous', kernel timer mode is 'normal'.
[    6.178323] vboxdrv: Successfully loaded version 4.3.4 (interface 0x001a0005).
[    6.196721] r8169 0000:09:00.0: firmware: agent loaded rtl_nic/rtl8168e-3.fw into memory
[    6.284961] r8169 0000:09:00.0: eth0: link down
[    6.284998] r8169 0000:09:00.0: eth0: link down
[    6.286217] ADDRCONF(NETDEV_UP): eth0: link is not ready
[    6.354659] nvidia 0000:01:00.0: irq 89 for MSI/MSI-X
[    6.388431] vboxpci: IOMMU not found (not registered)
[    6.426052] Ebtables v2.0 registered
[    6.435918] ip_tables: (C) 2000-2006 Netfilter Core Team
[    6.441364] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    8.576956] r8169 0000:09:00.0: eth0: link up
[    8.578130] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   18.792036] eth0: no IPv6 routers present
[   21.974059] hda_intel: Disabling MSI
[   21.974061] ALSA hda_intel.c:2553 Using LPIB position fix
[   21.974091] snd_hda_intel 0000:06:00.0: setting latency timer to 64
[   21.974095] ALSA hda_intel.c:2796 chipset global capabilities = 0x4300
[   21.974104] ALSA hda_intel.c:1175 Clearing TCSEL
[   21.996046] ALSA hda_intel.c:1031 codec_mask = 0x2
[   21.996175] ALSA hda_intel.c:783 spurious response 0x0:0x0, last cmd=0x000000
[   23.000003] ALSA hda_intel.c:824 azx_get_response timeout, polling the codec once: last cmd=0x100f0000
[   24.004008] ALSA hda_intel.c:824 azx_get_response timeout, polling the codec once: last cmd=0x100f0000
[   25.008014] ALSA hda_intel.c:834 azx_get_response timeout, switching to polling mode: last cmd=0x100f0000
[   26.012013] ALSA hda_intel.c:1563 Codec #1 probe error; disabling it...
[   26.044043] ALSA hda_intel.c:1031 codec_mask = 0x2
[   26.044081] ALSA hda_intel.c:783 spurious response 0x0:0x0, last cmd=0x000000
[   27.048014] ALSA hda_intel.c:873 hda_intel: azx_get_response timeout, switching to single_cmd mode: last cmd=0x100f0000
[   27.049609] ALSA hda_intel.c:909 get_response timeout: IRS=0x1
[   27.049801] ALSA hda_intel.c:909 get_response timeout: IRS=0x1
[   27.049997] ALSA hda_intel.c:909 get_response timeout: IRS=0x1
[   27.050217] ALSA hda_intel.c:909 get_response timeout: IRS=0x1
[   27.050416] ALSA hda_intel.c:909 get_response timeout: IRS=0x1
[   27.050622] ALSA hda_intel.c:909 get_response timeout: IRS=0x1
[   27.050825] ALSA hda_intel.c:909 get_response timeout: IRS=0x1
[   27.051032] ALSA hda_intel.c:909 get_response timeout: IRS=0x1
[   27.051519] ALSA hda_intel.c:909 get_response timeout: IRS=0x2
[   27.059356] ALSA hda_intel.c:909 get_response timeout: IRS=0x1
[   27.061602] ALSA hda_generic.c:586 AUD_IN = 8
[   27.061604] ALSA hda_generic.c:239 UNMUTE IN: NID=0x8 IDX=0x0
[   27.062042] ALSA hda_generic.c:239 UNMUTE IN: NID=0x12 IDX=0x0
[   27.062609] ALSA hda_generic.c:619 [Capture Source] NID=0x8, #SRC=1
[   27.062610] ALSA hda_generic.c:622   [Front Mic] IDX=0x0
[   27.062612] ALSA hda_generic.c:291 AUD_OUT found 2
[   27.062613] ALSA hda_generic.c:239 UNMUTE IN: NID=0xc IDX=0x0
[   27.062816] ALSA hda_generic.c:224 UNMUTE OUT: NID=0xc
[   27.063010] ALSA hda_generic.c:224 UNMUTE OUT: NID=0xc
[   27.063114] ALSA hda_generic.c:291 AUD_OUT found 6
[   27.063396] ALSA hda_generic.c:254 CONNECT: NID=0x8 IDX=0x0
[   27.063501] ALSA hda_generic.c:699 [Capture Switch] NID=0x8, DIR=IN, IDX=0x0
[   27.063505] ALSA hda_generic.c:725 [Capture Volume] NID=0x8, DIR=IN, IDX=0x0
[   27.063507] ALSA hda_generic.c:710 [Master Playback Switch] NID=0x2, DIR=OUT
[   27.063509] ALSA hda_generic.c:734 [Master Playback Volume] NID=0x2, DIR=OUT
