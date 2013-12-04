From: Geoffrey McRae <geoff@spacevs.com>
Subject: Re: ASUS Phoebus (CMI8888) HDA Support
Date: Wed, 4 Dec 2013 23:08:11 +1100
Message-ID: <20131204230811.011cf74b@sarah.home.spacevs.com>
References: <20131204213613.31b9a9c9@sarah.home.spacevs.com>
 <529F098C.3020208@ladisch.de>
 <20131204215711.68b52af6@sarah.home.spacevs.com>
 <529F1890.6070003@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.spacevs.com (mail1.spacevs.com [202.174.111.252])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FCFB265366
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 13:08:17 +0100 (CET)
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
> 
> 
> Regards,
> Clemens  

Sorry about the spam, forgot to CC the mailing list.

With IOMMU, I will send the output without IOMMU shortly.
========================================================================
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.2.0-4-amd64 (debian-kernel@lists.debian.org) (gcc version 4.6.3 (Debian 4.6.3-14) ) #1 SMP Debian 3.2.51-1
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.2.0-4-amd64 root=UUID=1a15dffb-2f03-4e0a-977a-2d5e8cedc529 ro quiet
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
[    0.000000]  BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cd82f000 (usable)
[    0.000000]  BIOS-e820: 00000000cd82f000 - 00000000cd882000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cd882000 - 00000000cd88c000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000cd88c000 - 00000000cd88d000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cd88d000 - 00000000cdad9000 (reserved)
[    0.000000]  BIOS-e820: 00000000cdad9000 - 00000000cdaea000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cdaea000 - 00000000cdaff000 (reserved)
[    0.000000]  BIOS-e820: 00000000cdaff000 - 00000000cdb01000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cdb01000 - 00000000cdb0a000 (reserved)
[    0.000000]  BIOS-e820: 00000000cdb0a000 - 00000000cdb10000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cdb10000 - 00000000cdb72000 (reserved)
[    0.000000]  BIOS-e820: 00000000cdb72000 - 00000000cdd75000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cdd75000 - 00000000cdf00000 (usable)
[    0.000000]  BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec10000 - 00000000fec11000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec20000 - 00000000fec21000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed00000 - 00000000fed01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed61000 - 00000000fed71000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed80000 - 00000000fed90000 (reserved)
[    0.000000]  BIOS-e820: 00000000fef00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100001000 - 000000042f000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: To be filled by O.E.M. To be filled by O.E.M./SABERTOOTH 990FX, BIOS 1604 10/16/2012
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x42f000 max_arch_pfn = 0x400000000
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
[    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
[    0.000000]   3 base 0000CDF00000 mask FFFFFFF00000 uncachable
[    0.000000]   4 base 0000CE000000 mask FFFFFE000000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 000000042f000000 aka 17136M
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820 update range: 00000000cdf00000 - 0000000100000000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0xcdf00 max_arch_pfn = 0x400000000
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 20480
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: 0000000000000000-00000000cdf00000
[    0.000000]  0000000000 - 00c0000000 page 1G
[    0.000000]  00c0000000 - 00cde00000 page 2M
[    0.000000]  00cde00000 - 00cdf00000 page 4k
[    0.000000] kernel direct mapping tables up to cdf00000 @ 1fffd000-20000000
[    0.000000] init_memory_mapping: 0000000100001000-000000042f000000
[    0.000000]  0100001000 - 0100200000 page 4k
[    0.000000]  0100200000 - 0140000000 page 2M
[    0.000000]  0140000000 - 0400000000 page 1G
[    0.000000]  0400000000 - 042f000000 page 2M
[    0.000000] kernel direct mapping tables up to 42f000000 @ cdefc000-cdf00000
[    0.000000] RAMDISK: 36a9c000 - 37546000
[    0.000000] ACPI: RSDP 00000000000f0450 00024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 00000000cd882070 00054 (v01 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: FACP 00000000cd88ac48 000F4 (v04 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI Warning: Optional field Pm2ControlBlock has zero address or length: 0x0000000000000000/0x1 (20110623/tbfadt-560)
[    0.000000] ACPI: DSDT 00000000cd882158 08AEC (v02 ALASKA    A M I 00000000 INTL 20051117)
[    0.000000] ACPI: FACS 00000000cdb0af80 00040
[    0.000000] ACPI: APIC 00000000cd88ad40 0009E (v03 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 00000000cd88ade0 0003C (v01 ALASKA    A M I 01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 00000000cd88ae20 00038 (v01 ALASKA    A M I 01072009 AMI  00000004)
[    0.000000] ACPI: SSDT 00000000cd88af98 00304 (v01 AMD    POWERNOW 00000001 AMD  00000001)
[    0.000000] ACPI: IVRS 00000000cd88aeb0 000E8 (v01  AMD     RD890S 00202031 AMD  00000000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000042f000000
[    0.000000] Initmem setup node 0 0000000000000000-000000042f000000
[    0.000000]   NODE_DATA [000000042effb000 - 000000042effffff]
[    0.000000]  [ffffea0000000000-ffffea000ebfffff] PMD -> [ffff88041e600000-ffff88042c7fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x0042f000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009d
[    0.000000]     0: 0x00000100 -> 0x000cd82f
[    0.000000]     0: 0x000cdd75 -> 0x000cdf00
[    0.000000]     0: 0x00100001 -> 0x0042f000
[    0.000000] On node 0 totalpages: 4180294
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3920 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 823794 pages, LIFO batch:31
[    0.000000]   Normal zone: 45640 pages used for memmap
[    0.000000]   Normal zone: 3292599 pages, LIFO batch:31
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
[    0.000000] PM: Registered nosave memory: 00000000cd82f000 - 00000000cd882000
[    0.000000] PM: Registered nosave memory: 00000000cd882000 - 00000000cd88c000
[    0.000000] PM: Registered nosave memory: 00000000cd88c000 - 00000000cd88d000
[    0.000000] PM: Registered nosave memory: 00000000cd88d000 - 00000000cdad9000
[    0.000000] PM: Registered nosave memory: 00000000cdad9000 - 00000000cdaea000
[    0.000000] PM: Registered nosave memory: 00000000cdaea000 - 00000000cdaff000
[    0.000000] PM: Registered nosave memory: 00000000cdaff000 - 00000000cdb01000
[    0.000000] PM: Registered nosave memory: 00000000cdb01000 - 00000000cdb0a000
[    0.000000] PM: Registered nosave memory: 00000000cdb0a000 - 00000000cdb10000
[    0.000000] PM: Registered nosave memory: 00000000cdb10000 - 00000000cdb72000
[    0.000000] PM: Registered nosave memory: 00000000cdb72000 - 00000000cdd75000
[    0.000000] PM: Registered nosave memory: 00000000cdf00000 - 00000000f8000000
[    0.000000] PM: Registered nosave memory: 00000000f8000000 - 00000000fc000000
[    0.000000] PM: Registered nosave memory: 00000000fc000000 - 00000000fec00000
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
[    0.000000] Allocating PCI resources starting at cdf00000 (gap: cdf00000:2a100000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 28 pages/cpu @ffff88042ec00000 s82944 r8192 d23552 u262144
[    0.000000] pcpu-alloc: s82944 r8192 d23552 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 4120313
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.2.0-4-amd64 root=UUID=1a15dffb-2f03-4e0a-977a-2d5e8cedc529 ro quiet
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave/xrstor: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Node 0: aperture @ f8000000 size 64 MB
[    0.000000] Memory: 16403344k/17547264k available (3426k kernel code, 826088k absent, 317832k reserved, 3312k data, 576k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:33024 nr_irqs:1288 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 4013.239 MHz processor.
[    0.004003] Calibrating delay loop (skipped), value calculated using timer frequency.. 8026.47 BogoMIPS (lpj=16052956)
[    0.004005] pid_max: default: 32768 minimum: 301
[    0.004032] Security Framework initialized
[    0.004035] AppArmor: AppArmor disabled by boot time parameter
[    0.004860] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.008692] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.010200] Mount-cache hash table entries: 256
[    0.010280] Initializing cgroup subsys cpuacct
[    0.010283] Initializing cgroup subsys memory
[    0.010291] Initializing cgroup subsys devices
[    0.010293] Initializing cgroup subsys freezer
[    0.010294] Initializing cgroup subsys net_cls
[    0.010296] Initializing cgroup subsys blkio
[    0.010300] Initializing cgroup subsys perf_event
[    0.010319] tseg: 00cdf00000
[    0.010321] CPU: Physical Processor ID: 0
[    0.010321] CPU: Processor Core ID: 0
[    0.010323] mce: CPU supports 7 MCE banks
[    0.010559] ACPI: Core revision 20110623
[    0.016378] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.057371] CPU0: AMD FX(tm)-8350 Eight-Core Processor            stepping 00
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
[    0.148026] NMI watchdog enabled, takes one hw-pmu counter.
[    0.148111]  #2
[    0.148112] smpboot cpu 2: start_ip = 98000
[    0.240025] NMI watchdog enabled, takes one hw-pmu counter.
[    0.240091]  #3
[    0.240092] smpboot cpu 3: start_ip = 98000
[    0.332029] NMI watchdog enabled, takes one hw-pmu counter.
[    0.332092]  #4
[    0.332093] smpboot cpu 4: start_ip = 98000
[    0.424036] NMI watchdog enabled, takes one hw-pmu counter.
[    0.424102]  #5
[    0.424103] smpboot cpu 5: start_ip = 98000
[    0.516041] NMI watchdog enabled, takes one hw-pmu counter.
[    0.516104]  #6
[    0.516105] smpboot cpu 6: start_ip = 98000
[    0.608047] NMI watchdog enabled, takes one hw-pmu counter.
[    0.608109]  #7 Ok.
[    0.608110] smpboot cpu 7: start_ip = 98000
[    0.700051] NMI watchdog enabled, takes one hw-pmu counter.
[    0.700063] Brought up 8 CPUs
[    0.700065] Total of 8 processors activated (64213.10 BogoMIPS).
[    0.704197] devtmpfs: initialized
[    0.706120] PM: Registering ACPI NVS region at cd82f000 (339968 bytes)
[    0.706120] PM: Registering ACPI NVS region at cd88c000 (4096 bytes)
[    0.706120] PM: Registering ACPI NVS region at cdad9000 (69632 bytes)
[    0.706120] PM: Registering ACPI NVS region at cdaff000 (8192 bytes)
[    0.706120] PM: Registering ACPI NVS region at cdb0a000 (24576 bytes)
[    0.706120] PM: Registering ACPI NVS region at cdb72000 (2109440 bytes)
[    0.706120] print_constraints: dummy: 
[    0.706120] NET: Registered protocol family 16
[    0.706120] Extended Config Space enabled on 1 nodes
[    0.706120] ACPI: bus type pci registered
[    0.706120] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.706120] PCI: not using MMCONFIG
[    0.706120] PCI: Using configuration type 1 for base access
[    0.706120] PCI: Using configuration type 1 for extended access
[    0.708591] bio: create slab <bio-0> at 0
[    0.708591] ACPI: Added _OSI(Module Device)
[    0.708591] ACPI: Added _OSI(Processor Device)
[    0.708591] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.708591] ACPI: Added _OSI(Processor Aggregator Device)
[    0.708712] ACPI: EC: Look up EC in DSDT
[    0.709336] ACPI: Executed 2 blocks of module-level executable AML code
[    0.720450] ACPI: Interpreter enabled
[    0.720454] ACPI: (supports S0 S1 S3 S4 S5)
[    0.720470] ACPI: Using IOAPIC for interrupt routing
[    0.720575] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.720602] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    0.754308] ACPI: EC: GPE = 0xa, I/O: command/status = 0x66, data = 0x62
[    0.754411] ACPI: No dock devices found.
[    0.754413] HEST: Table not found.
[    0.754415] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.754538] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.754725] pci_root PNP0A03:00: host bridge window [io  0x0000-0x03af]
[    0.754727] pci_root PNP0A03:00: host bridge window [io  0x03e0-0x0cf7]
[    0.754728] pci_root PNP0A03:00: host bridge window [io  0x03b0-0x03df]
[    0.754730] pci_root PNP0A03:00: host bridge window [io  0x0d00-0xffff]
[    0.754731] pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff]
[    0.754733] pci_root PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff]
[    0.754734] pci_root PNP0A03:00: host bridge window [mem 0xd0000000-0xffffffff]
[    0.754746] pci 0000:00:00.0: [1002:5a14] type 0 class 0x000600
[    0.754798] pci 0000:00:00.2: [1002:5a23] type 0 class 0x000806
[    0.754845] pci 0000:00:02.0: [1002:5a16] type 1 class 0x000604
[    0.754875] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.754889] pci 0000:00:04.0: [1002:5a18] type 1 class 0x000604
[    0.754918] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.754932] pci 0000:00:05.0: [1002:5a19] type 1 class 0x000604
[    0.754960] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
[    0.754974] pci 0000:00:06.0: [1002:5a1a] type 1 class 0x000604
[    0.755002] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.755017] pci 0000:00:09.0: [1002:5a1c] type 1 class 0x000604
[    0.755045] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    0.755059] pci 0000:00:0a.0: [1002:5a1d] type 1 class 0x000604
[    0.755117] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    0.755140] pci 0000:00:11.0: [1002:4391] type 0 class 0x000106
[    0.755154] pci 0000:00:11.0: reg 10: [io  0xf040-0xf047]
[    0.755161] pci 0000:00:11.0: reg 14: [io  0xf030-0xf033]
[    0.755168] pci 0000:00:11.0: reg 18: [io  0xf020-0xf027]
[    0.755174] pci 0000:00:11.0: reg 1c: [io  0xf010-0xf013]
[    0.755181] pci 0000:00:11.0: reg 20: [io  0xf000-0xf00f]
[    0.755188] pci 0000:00:11.0: reg 24: [mem 0xfe707000-0xfe7073ff]
[    0.755232] pci 0000:00:12.0: [1002:4397] type 0 class 0x000c03
[    0.755242] pci 0000:00:12.0: reg 10: [mem 0xfe706000-0xfe706fff]
[    0.755294] pci 0000:00:12.2: [1002:4396] type 0 class 0x000c03
[    0.755308] pci 0000:00:12.2: reg 10: [mem 0xfe705000-0xfe7050ff]
[    0.755368] pci 0000:00:12.2: supports D1 D2
[    0.755369] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.755387] pci 0000:00:13.0: [1002:4397] type 0 class 0x000c03
[    0.755396] pci 0000:00:13.0: reg 10: [mem 0xfe704000-0xfe704fff]
[    0.755449] pci 0000:00:13.2: [1002:4396] type 0 class 0x000c03
[    0.755463] pci 0000:00:13.2: reg 10: [mem 0xfe703000-0xfe7030ff]
[    0.755522] pci 0000:00:13.2: supports D1 D2
[    0.755524] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.755541] pci 0000:00:14.0: [1002:4385] type 0 class 0x000c05
[    0.755596] pci 0000:00:14.3: [1002:439d] type 0 class 0x000601
[    0.755652] pci 0000:00:14.4: [1002:4384] type 1 class 0x000604
[    0.755683] pci 0000:00:14.5: [1002:4399] type 0 class 0x000c03
[    0.755693] pci 0000:00:14.5: reg 10: [mem 0xfe702000-0xfe702fff]
[    0.755745] pci 0000:00:15.0: [1002:43a0] type 1 class 0x000604
[    0.755798] pci 0000:00:15.0: supports D1 D2
[    0.755817] pci 0000:00:15.1: [1002:43a1] type 1 class 0x000604
[    0.755870] pci 0000:00:15.1: supports D1 D2
[    0.755891] pci 0000:00:16.0: [1002:4397] type 0 class 0x000c03
[    0.755901] pci 0000:00:16.0: reg 10: [mem 0xfe701000-0xfe701fff]
[    0.755953] pci 0000:00:16.2: [1002:4396] type 0 class 0x000c03
[    0.755967] pci 0000:00:16.2: reg 10: [mem 0xfe700000-0xfe7000ff]
[    0.756027] pci 0000:00:16.2: supports D1 D2
[    0.756028] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
[    0.756057] pci 0000:00:18.0: [1022:1600] type 0 class 0x000600
[    0.756072] pci 0000:00:18.1: [1022:1601] type 0 class 0x000600
[    0.756084] pci 0000:00:18.2: [1022:1602] type 0 class 0x000600
[    0.756097] pci 0000:00:18.3: [1022:1603] type 0 class 0x000600
[    0.756112] pci 0000:00:18.4: [1022:1604] type 0 class 0x000600
[    0.756127] pci 0000:00:18.5: [1022:1605] type 0 class 0x000600
[    0.756174] pci 0000:01:00.0: [10de:11ba] type 0 class 0x000300
[    0.756183] pci 0000:01:00.0: reg 10: [mem 0xfd000000-0xfdffffff]
[    0.756193] pci 0000:01:00.0: reg 14: [mem 0xd0000000-0xd7ffffff 64bit pref]
[    0.756203] pci 0000:01:00.0: reg 1c: [mem 0xd8000000-0xd9ffffff 64bit pref]
[    0.756209] pci 0000:01:00.0: reg 24: [io  0xe000-0xe07f]
[    0.756216] pci 0000:01:00.0: reg 30: [mem 0xfe000000-0xfe07ffff pref]
[    0.756274] pci 0000:01:00.1: [10de:0e0a] type 0 class 0x000403
[    0.756283] pci 0000:01:00.1: reg 10: [mem 0xfe080000-0xfe083fff]
[    0.764061] pci 0000:00:02.0: PCI bridge to [bus 01-01]
[    0.764064] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.764066] pci 0000:00:02.0:   bridge window [mem 0xfd000000-0xfe0fffff]
[    0.764069] pci 0000:00:02.0:   bridge window [mem 0xd0000000-0xd9ffffff 64bit pref]
[    0.764103] pci 0000:02:00.0: [197b:2362] type 0 class 0x000101
[    0.764127] pci 0000:02:00.0: reg 10: [io  0xd040-0xd047]
[    0.764137] pci 0000:02:00.0: reg 14: [io  0xd030-0xd033]
[    0.764147] pci 0000:02:00.0: reg 18: [io  0xd020-0xd027]
[    0.764157] pci 0000:02:00.0: reg 1c: [io  0xd010-0xd013]
[    0.764166] pci 0000:02:00.0: reg 20: [io  0xd000-0xd00f]
[    0.764176] pci 0000:02:00.0: reg 24: [mem 0xfe610000-0xfe6101ff]
[    0.764186] pci 0000:02:00.0: reg 30: [mem 0x00000000-0x0000ffff pref]
[    0.764224] pci 0000:02:00.0: PME# supported from D3hot
[    0.772058] pci 0000:00:04.0: PCI bridge to [bus 02-02]
[    0.772061] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    0.772063] pci 0000:00:04.0:   bridge window [mem 0xfe600000-0xfe6fffff]
[    0.772131] pci 0000:03:00.0: [197b:2362] type 0 class 0x000101
[    0.772152] pci 0000:03:00.0: reg 10: [io  0xc040-0xc047]
[    0.772162] pci 0000:03:00.0: reg 14: [io  0xc030-0xc033]
[    0.772171] pci 0000:03:00.0: reg 18: [io  0xc020-0xc027]
[    0.772181] pci 0000:03:00.0: reg 1c: [io  0xc010-0xc013]
[    0.772190] pci 0000:03:00.0: reg 20: [io  0xc000-0xc00f]
[    0.772200] pci 0000:03:00.0: reg 24: [mem 0xfe510000-0xfe5101ff]
[    0.772210] pci 0000:03:00.0: reg 30: [mem 0x00000000-0x0000ffff pref]
[    0.772248] pci 0000:03:00.0: PME# supported from D3hot
[    0.780058] pci 0000:00:05.0: PCI bridge to [bus 03-03]
[    0.780061] pci 0000:00:05.0:   bridge window [io  0xc000-0xcfff]
[    0.780063] pci 0000:00:05.0:   bridge window [mem 0xfe500000-0xfe5fffff]
[    0.780106] pci 0000:04:00.0: [1b21:1042] type 0 class 0x000c03
[    0.780124] pci 0000:04:00.0: reg 10: [mem 0xfe400000-0xfe407fff 64bit]
[    0.780206] pci 0000:04:00.0: PME# supported from D3hot D3cold
[    0.788058] pci 0000:00:06.0: PCI bridge to [bus 04-04]
[    0.788062] pci 0000:00:06.0:   bridge window [mem 0xfe400000-0xfe4fffff]
[    0.788105] pci 0000:05:00.0: [1b21:1042] type 0 class 0x000c03
[    0.788122] pci 0000:05:00.0: reg 10: [mem 0xfe300000-0xfe307fff 64bit]
[    0.788204] pci 0000:05:00.0: PME# supported from D3hot D3cold
[    0.796059] pci 0000:00:09.0: PCI bridge to [bus 05-05]
[    0.796062] pci 0000:00:09.0:   bridge window [mem 0xfe300000-0xfe3fffff]
[    0.796098] pci 0000:06:00.0: [13f6:5011] type 0 class 0x000403
[    0.796110] pci 0000:06:00.0: reg 10: [mem 0xfe200000-0xfe203fff]
[    0.796199] pci 0000:06:00.0: supports D1 D2
[    0.804060] pci 0000:00:0a.0: PCI bridge to [bus 06-06]
[    0.804064] pci 0000:00:0a.0:   bridge window [mem 0xfe200000-0xfe2fffff]
[    0.804094] pci 0000:07:07.0: [1106:3044] type 0 class 0x000c00
[    0.804112] pci 0000:07:07.0: reg 10: [mem 0xfe100000-0xfe1007ff]
[    0.804128] pci 0000:07:07.0: reg 14: [io  0xb000-0xb07f]
[    0.804203] pci 0000:07:07.0: supports D2
[    0.804204] pci 0000:07:07.0: PME# supported from D2 D3hot D3cold
[    0.804241] pci 0000:00:14.4: PCI bridge to [bus 07-07] (subtractive decode)
[    0.804244] pci 0000:00:14.4:   bridge window [io  0xb000-0xbfff]
[    0.804247] pci 0000:00:14.4:   bridge window [mem 0xfe100000-0xfe1fffff]
[    0.804250] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af] (subtractive decode)
[    0.804252] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7] (subtractive decode)
[    0.804253] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df] (subtractive decode)
[    0.804255] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.804257] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.804258] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    0.804260] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xffffffff] (subtractive decode)
[    0.804295] pci 0000:00:15.0: PCI bridge to [bus 08-08]
[    0.804353] pci 0000:09:00.0: [10ec:8168] type 0 class 0x000200
[    0.804367] pci 0000:09:00.0: reg 10: [io  0xa000-0xa0ff]
[    0.804393] pci 0000:09:00.0: reg 18: [mem 0xda104000-0xda104fff 64bit pref]
[    0.804409] pci 0000:09:00.0: reg 20: [mem 0xda100000-0xda103fff 64bit pref]
[    0.804476] pci 0000:09:00.0: supports D1 D2
[    0.804477] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.812063] pci 0000:00:15.1: PCI bridge to [bus 09-09]
[    0.812067] pci 0000:00:15.1:   bridge window [io  0xa000-0xafff]
[    0.812073] pci 0000:00:15.1:   bridge window [mem 0xda100000-0xda1fffff 64bit pref]
[    0.812094] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.812193] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PC._PRT]
[    0.812233] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PE20._PRT]
[    0.812254] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PE21._PRT]
[    0.812281] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC02._PRT]
[    0.812302] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC04._PRT]
[    0.812331] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC05._PRT]
[    0.812357] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC06._PRT]
[    0.812379] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC09._PRT]
[    0.812400] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC0A._PRT]
[    0.812424]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.812426]  pci0000:00: ACPI _OSC request failed (AE_NOT_FOUND), returned control mask: 0x1d
[    0.812427] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.817429] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 11 14 15) *0
[    0.817474] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 10 11 14 15) *0
[    0.817520] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 11 14 15) *0
[    0.817565] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 10 11 14 15) *0
[    0.817601] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 7 10 11 14 15) *0
[    0.817627] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 7 10 11 14 15) *0
[    0.817654] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7 10 11 14 15) *0
[    0.817681] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 7 10 11 14 15) *0
[    0.817737] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.817737] vgaarb: loaded
[    0.817737] vgaarb: bridge control possible 0000:01:00.0
[    0.817737] PCI: Using ACPI for IRQ routing
[    0.823994] PCI: pci_cache_line_size set to 64 bytes
[    0.824083] reserve RAM buffer: 000000000009d800 - 000000000009ffff 
[    0.824085] reserve RAM buffer: 00000000cd82f000 - 00000000cfffffff 
[    0.824086] reserve RAM buffer: 00000000cdf00000 - 00000000cfffffff 
[    0.824088] reserve RAM buffer: 000000042f000000 - 000000042fffffff 
[    0.824171] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.824174] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.826209] Switching to clocksource hpet
[    0.827409] pnp: PnP ACPI init
[    0.827416] ACPI: bus type pnp registered
[    0.827518] pnp 00:00: [bus 00-ff]
[    0.827520] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.827521] pnp 00:00: [io  0x0000-0x03af window]
[    0.827523] pnp 00:00: [io  0x03e0-0x0cf7 window]
[    0.827525] pnp 00:00: [io  0x03b0-0x03df window]
[    0.827526] pnp 00:00: [io  0x0d00-0xffff window]
[    0.827528] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.827529] pnp 00:00: [mem 0x000c0000-0x000dffff window]
[    0.827530] pnp 00:00: [mem 0xd0000000-0xffffffff window]
[    0.827531] pnp 00:00: [mem 0x00000000 window]
[    0.827562] pnp 00:00: Plug and Play ACPI device, IDs PNP0a03 (active)
[    0.827585] pnp 00:01: [mem 0xe0000000-0xefffffff]
[    0.827618] system 00:01: [mem 0xe0000000-0xefffffff] has been reserved
[    0.827620] system 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.827981] pnp 00:02: [io  0x040b]
[    0.827983] pnp 00:02: [io  0x04d6]
[    0.827984] pnp 00:02: [io  0x0c00-0x0c01]
[    0.827985] pnp 00:02: [io  0x0c14]
[    0.827986] pnp 00:02: [io  0x0c50-0x0c51]
[    0.827987] pnp 00:02: [io  0x0c52]
[    0.827988] pnp 00:02: [io  0x0c6c]
[    0.827989] pnp 00:02: [io  0x0c6f]
[    0.827990] pnp 00:02: [io  0x0cd0-0x0cd1]
[    0.827991] pnp 00:02: [io  0x0cd2-0x0cd3]
[    0.827992] pnp 00:02: [io  0x0cd4-0x0cd5]
[    0.827993] pnp 00:02: [io  0x0cd6-0x0cd7]
[    0.827994] pnp 00:02: [io  0x0cd8-0x0cdf]
[    0.827995] pnp 00:02: [io  0x0800-0x089f]
[    0.827996] pnp 00:02: [io  0x0000-0xffffffffffffffff disabled]
[    0.827998] pnp 00:02: [io  0x0000-0x000f]
[    0.827999] pnp 00:02: [io  0x0b20-0x0b3f]
[    0.828000] pnp 00:02: [io  0x0900-0x090f]
[    0.828001] pnp 00:02: [io  0x0910-0x091f]
[    0.828002] pnp 00:02: [io  0xfe00-0xfefe]
[    0.828003] pnp 00:02: [io  0x0060-0x005f disabled]
[    0.828004] pnp 00:02: [io  0x0064-0x0063 disabled]
[    0.828006] pnp 00:02: [mem 0xfec00000-0xfec00fff]
[    0.828007] pnp 00:02: [mem 0xfee00000-0xfee00fff]
[    0.828008] pnp 00:02: [mem 0xfed80000-0xfed8ffff]
[    0.828010] pnp 00:02: [mem 0xfed61000-0xfed70fff]
[    0.828011] pnp 00:02: [mem 0xfec10000-0xfec10fff]
[    0.828012] pnp 00:02: [mem 0xfed00000-0xfed00fff]
[    0.828013] pnp 00:02: [mem 0xffc00000-0xffffffff]
[    0.828013] system 00:02: [io  0x040b] has been reserved
[    0.828013] system 00:02: [io  0x04d6] has been reserved
[    0.828013] system 00:02: [io  0x0c00-0x0c01] has been reserved
[    0.828013] system 00:02: [io  0x0c14] has been reserved
[    0.828013] system 00:02: [io  0x0c50-0x0c51] has been reserved
[    0.828013] system 00:02: [io  0x0c52] has been reserved
[    0.828013] system 00:02: [io  0x0c6c] has been reserved
[    0.828013] system 00:02: [io  0x0c6f] has been reserved
[    0.828013] system 00:02: [io  0x0cd0-0x0cd1] has been reserved
[    0.828013] system 00:02: [io  0x0cd2-0x0cd3] has been reserved
[    0.828013] system 00:02: [io  0x0cd4-0x0cd5] has been reserved
[    0.828013] system 00:02: [io  0x0cd6-0x0cd7] has been reserved
[    0.828013] system 00:02: [io  0x0cd8-0x0cdf] has been reserved
[    0.828013] system 00:02: [io  0x0800-0x089f] has been reserved
[    0.828013] system 00:02: [io  0x0b20-0x0b3f] has been reserved
[    0.828013] system 00:02: [io  0x0900-0x090f] has been reserved
[    0.828013] system 00:02: [io  0x0910-0x091f] has been reserved
[    0.828013] system 00:02: [io  0xfe00-0xfefe] has been reserved
[    0.828013] system 00:02: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.828013] system 00:02: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.828013] system 00:02: [mem 0xfed80000-0xfed8ffff] has been reserved
[    0.828013] system 00:02: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.828013] system 00:02: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.828013] system 00:02: [mem 0xfed00000-0xfed00fff] has been reserved
[    0.828013] system 00:02: [mem 0xffc00000-0xffffffff] has been reserved
[    0.828013] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.828013] pnp 00:03: [io  0x0000-0xffffffffffffffff disabled]
[    0.828013] pnp 00:03: [io  0x0290-0x02af]
[    0.828013] pnp 00:03: [io  0x0000-0xffffffffffffffff disabled]
[    0.828013] system 00:03: [io  0x0290-0x02af] has been reserved
[    0.828013] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.828013] pnp 00:04: [dma 4]
[    0.828013] pnp 00:04: [io  0x0000-0x000f]
[    0.828013] pnp 00:04: [io  0x0081-0x0083]
[    0.828013] pnp 00:04: [io  0x0087]
[    0.828013] pnp 00:04: [io  0x0089-0x008b]
[    0.828013] pnp 00:04: [io  0x008f]
[    0.828013] pnp 00:04: [io  0x00c0-0x00df]
[    0.828013] pnp 00:04: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.828013] pnp 00:05: [io  0x0070-0x0071]
[    0.828013] pnp 00:05: [irq 8]
[    0.828013] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.828013] pnp 00:06: [io  0x0061]
[    0.828013] pnp 00:06: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.828013] pnp 00:07: [io  0x0010-0x001f]
[    0.828013] pnp 00:07: [io  0x0022-0x003f]
[    0.828013] pnp 00:07: [io  0x0044-0x005f]
[    0.828013] pnp 00:07: [io  0x0062-0x0063]
[    0.828013] pnp 00:07: [io  0x0065-0x006f]
[    0.828013] pnp 00:07: [io  0x0072-0x007f]
[    0.828013] pnp 00:07: [io  0x0080]
[    0.828013] pnp 00:07: [io  0x0084-0x0086]
[    0.828013] pnp 00:07: [io  0x0088]
[    0.828013] pnp 00:07: [io  0x008c-0x008e]
[    0.828013] pnp 00:07: [io  0x0090-0x009f]
[    0.828013] pnp 00:07: [io  0x00a2-0x00bf]
[    0.828013] pnp 00:07: [io  0x00e0-0x00ef]
[    0.828013] pnp 00:07: [io  0x04d0-0x04d1]
[    0.828013] system 00:07: [io  0x04d0-0x04d1] has been reserved
[    0.828013] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.828013] pnp 00:08: [io  0x00f0-0x00ff]
[    0.828013] pnp 00:08: [irq 13]
[    0.828013] pnp 00:08: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.828013] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.828013] pnp 00:0a: [io  0x03f8-0x03ff]
[    0.828013] pnp 00:0a: [irq 4]
[    0.828013] pnp 00:0a: [dma 0 disabled]
[    0.828013] pnp 00:0a: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.828013] pnp 00:0b: [mem 0xfeb20000-0xfeb23fff]
[    0.828013] system 00:0b: [mem 0xfeb20000-0xfeb23fff] has been reserved
[    0.828013] system 00:0b: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.828013] pnp 00:0c: [mem 0x00000000-0xffffffffffffffff disabled]
[    0.828013] pnp 00:0c: [mem 0xfec20000-0xfec200ff]
[    0.828013] system 00:0c: [mem 0xfec20000-0xfec200ff] could not be reserved
[    0.828013] system 00:0c: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.828013] pnp 00:0d: [mem 0xfed00000-0xfed003ff]
[    0.828013] pnp 00:0d: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.828013] pnp: PnP ACPI: found 14 devices
[    0.828013] ACPI: ACPI bus type pnp unregistered
[    0.833227] PCI: max bus depth: 1 pci_try_num: 2
[    0.833257] pci 0000:00:04.0: BAR 15: assigned [mem 0xda000000-0xda0fffff pref]
[    0.833260] pci 0000:00:05.0: BAR 15: assigned [mem 0xda200000-0xda2fffff pref]
[    0.833262] pci 0000:00:02.0: PCI bridge to [bus 01-01]
[    0.833264] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.833267] pci 0000:00:02.0:   bridge window [mem 0xfd000000-0xfe0fffff]
[    0.833269] pci 0000:00:02.0:   bridge window [mem 0xd0000000-0xd9ffffff 64bit pref]
[    0.833272] pci 0000:02:00.0: BAR 6: assigned [mem 0xda000000-0xda00ffff pref]
[    0.833274] pci 0000:00:04.0: PCI bridge to [bus 02-02]
[    0.833275] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    0.833278] pci 0000:00:04.0:   bridge window [mem 0xfe600000-0xfe6fffff]
[    0.833280] pci 0000:00:04.0:   bridge window [mem 0xda000000-0xda0fffff pref]
[    0.833283] pci 0000:03:00.0: BAR 6: assigned [mem 0xda200000-0xda20ffff pref]
[    0.833284] pci 0000:00:05.0: PCI bridge to [bus 03-03]
[    0.833286] pci 0000:00:05.0:   bridge window [io  0xc000-0xcfff]
[    0.833288] pci 0000:00:05.0:   bridge window [mem 0xfe500000-0xfe5fffff]
[    0.833290] pci 0000:00:05.0:   bridge window [mem 0xda200000-0xda2fffff pref]
[    0.833292] pci 0000:00:06.0: PCI bridge to [bus 04-04]
[    0.833295] pci 0000:00:06.0:   bridge window [mem 0xfe400000-0xfe4fffff]
[    0.833298] pci 0000:00:09.0: PCI bridge to [bus 05-05]
[    0.833300] pci 0000:00:09.0:   bridge window [mem 0xfe300000-0xfe3fffff]
[    0.833303] pci 0000:00:0a.0: PCI bridge to [bus 06-06]
[    0.833305] pci 0000:00:0a.0:   bridge window [mem 0xfe200000-0xfe2fffff]
[    0.833308] pci 0000:00:14.4: PCI bridge to [bus 07-07]
[    0.833310] pci 0000:00:14.4:   bridge window [io  0xb000-0xbfff]
[    0.833314] pci 0000:00:14.4:   bridge window [mem 0xfe100000-0xfe1fffff]
[    0.833320] pci 0000:00:15.0: PCI bridge to [bus 08-08]
[    0.833326] pci 0000:00:15.1: PCI bridge to [bus 09-09]
[    0.833328] pci 0000:00:15.1:   bridge window [io  0xa000-0xafff]
[    0.833333] pci 0000:00:15.1:   bridge window [mem 0xda100000-0xda1fffff 64bit pref]
[    0.833343] pci 0000:00:02.0: setting latency timer to 64
[    0.833347] pci 0000:00:04.0: setting latency timer to 64
[    0.833350] pci 0000:00:05.0: setting latency timer to 64
[    0.833357] pci 0000:00:06.0: setting latency timer to 64
[    0.833360] pci 0000:00:09.0: setting latency timer to 64
[    0.833365] pci 0000:00:0a.0: setting latency timer to 64
[    0.833376] pci 0000:00:15.0: setting latency timer to 64
[    0.833381] pci 0000:00:15.1: setting latency timer to 64
[    0.833384] pci_bus 0000:00: resource 4 [io  0x0000-0x03af]
[    0.833385] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7]
[    0.833386] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df]
[    0.833388] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff]
[    0.833389] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff]
[    0.833390] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff]
[    0.833392] pci_bus 0000:00: resource 10 [mem 0xd0000000-0xffffffff]
[    0.833393] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.833395] pci_bus 0000:01: resource 1 [mem 0xfd000000-0xfe0fffff]
[    0.833396] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xd9ffffff 64bit pref]
[    0.833397] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    0.833399] pci_bus 0000:02: resource 1 [mem 0xfe600000-0xfe6fffff]
[    0.833400] pci_bus 0000:02: resource 2 [mem 0xda000000-0xda0fffff pref]
[    0.833401] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
[    0.833402] pci_bus 0000:03: resource 1 [mem 0xfe500000-0xfe5fffff]
[    0.833404] pci_bus 0000:03: resource 2 [mem 0xda200000-0xda2fffff pref]
[    0.833405] pci_bus 0000:04: resource 1 [mem 0xfe400000-0xfe4fffff]
[    0.833406] pci_bus 0000:05: resource 1 [mem 0xfe300000-0xfe3fffff]
[    0.833408] pci_bus 0000:06: resource 1 [mem 0xfe200000-0xfe2fffff]
[    0.833409] pci_bus 0000:07: resource 0 [io  0xb000-0xbfff]
[    0.833410] pci_bus 0000:07: resource 1 [mem 0xfe100000-0xfe1fffff]
[    0.833412] pci_bus 0000:07: resource 4 [io  0x0000-0x03af]
[    0.833413] pci_bus 0000:07: resource 5 [io  0x03e0-0x0cf7]
[    0.833414] pci_bus 0000:07: resource 6 [io  0x03b0-0x03df]
[    0.833415] pci_bus 0000:07: resource 7 [io  0x0d00-0xffff]
[    0.833416] pci_bus 0000:07: resource 8 [mem 0x000a0000-0x000bffff]
[    0.833418] pci_bus 0000:07: resource 9 [mem 0x000c0000-0x000dffff]
[    0.833419] pci_bus 0000:07: resource 10 [mem 0xd0000000-0xffffffff]
[    0.833420] pci_bus 0000:09: resource 0 [io  0xa000-0xafff]
[    0.833422] pci_bus 0000:09: resource 2 [mem 0xda100000-0xda1fffff 64bit pref]
[    0.833540] NET: Registered protocol family 2
[    0.833809] IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.834977] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    0.836426] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.836601] TCP: Hash tables configured (established 524288 bind 65536)
[    0.836602] TCP reno registered
[    0.836618] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.836680] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.836841] NET: Registered protocol family 1
[    1.928086] pci 0000:01:00.0: Boot video device
[    1.928180] PCI: CLS 64 bytes, default 64
[    1.928213] Unpacking initramfs...
[    2.088157] Freeing initrd memory: 10920k freed
[    2.090250] pci 0000:00:00.2: irq 72 for MSI/MSI-X
[    2.090317] AMD-Vi: Enabling IOMMU at 0000:00:00.2 cap 0x40
[    2.207768] AMD-Vi: Lazy IO/TLB flushing enabled
[    2.207771] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.207773] Placing 64MB software IO TLB between ffff8800c982f000 - ffff8800cd82f000
[    2.207774] software IO TLB at phys 0xc982f000 - 0xcd82f000
[    2.208383] perf: AMD IBS detected (0x000000ff)
[    2.208548] audit: initializing netlink socket (disabled)
[    2.208556] type=2000 audit(1386190593.204:1): initialized
[    2.218713] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.220295] VFS: Disk quotas dquot_6.5.2
[    2.220327] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.220381] msgmni has been set to 32059
[    2.220531] alg: No test for stdrng (krng)
[    2.220562] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    2.220565] io scheduler noop registered
[    2.220566] io scheduler deadline registered
[    2.220599] io scheduler cfq registered (default)
[    2.220845] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    2.220859] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    2.220861] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    2.221108] ERST: Table is not found!
[    2.221109] GHES: HEST is not enabled!
[    2.221153] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.241489] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    2.396583] 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    2.416199] Linux agpgart interface v0.103
[    2.416288] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    2.416618] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.416622] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.416702] mousedev: PS/2 mouse device common for all mice
[    2.416737] rtc_cmos 00:05: RTC can wake from S4
[    2.416809] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    2.416828] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    2.416836] cpuidle: using governor ladder
[    2.416837] cpuidle: using governor menu
[    2.416978] TCP cubic registered
[    2.417075] NET: Registered protocol family 10
[    2.417421] Mobile IPv6
[    2.417422] NET: Registered protocol family 17
[    2.417425] Registering the dns_resolver key type
[    2.417517] PM: Hibernation image not present or could not be loaded.
[    2.417522] registered taskstats version 1
[    2.418540] rtc_cmos 00:05: setting system clock to 2013-12-04 20:56:34 UTC (1386190594)
[    2.418587] Initializing network drop monitor service
[    2.419393] Freeing unused kernel memory: 576k freed
[    2.419489] Write protecting the kernel read-only data: 6144k
[    2.421192] Freeing unused kernel memory: 652k freed
[    2.423037] Freeing unused kernel memory: 688k freed
[    2.431404] udevd[80]: starting version 175
[    2.441581] usbcore: registered new interface driver usbfs
[    2.441598] usbcore: registered new interface driver hub
[    2.442894] usbcore: registered new device driver usb
[    2.443498] xhci_hcd 0000:04:00.0: setting latency timer to 64
[    2.443502] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    2.443528] xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus number 1
[    2.444705] SCSI subsystem initialized
[    2.447366] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.447403] ehci_hcd 0000:00:12.2: EHCI Host Controller
[    2.447414] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 2
[    2.447422] ehci_hcd 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.447445] QUIRK: Enable AMD PLL fix
[    2.447456] ehci_hcd 0000:00:12.2: debug port 1
[    2.447481] ehci_hcd 0000:00:12.2: irq 17, io mem 0xfe705000
[    2.449509] libata version 3.00 loaded.
[    2.453210] xhci_hcd 0000:04:00.0: irq 73 for MSI/MSI-X
[    2.453220] xhci_hcd 0000:04:00.0: irq 74 for MSI/MSI-X
[    2.453226] xhci_hcd 0000:04:00.0: irq 75 for MSI/MSI-X
[    2.453231] xhci_hcd 0000:04:00.0: irq 76 for MSI/MSI-X
[    2.453236] xhci_hcd 0000:04:00.0: irq 77 for MSI/MSI-X
[    2.453242] xhci_hcd 0000:04:00.0: irq 78 for MSI/MSI-X
[    2.453246] xhci_hcd 0000:04:00.0: irq 79 for MSI/MSI-X
[    2.453251] xhci_hcd 0000:04:00.0: irq 80 for MSI/MSI-X
[    2.453349] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.453352] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.453354] usb usb1: Product: xHCI Host Controller
[    2.453355] usb usb1: Manufacturer: Linux 3.2.0-4-amd64 xhci_hcd
[    2.453357] usb usb1: SerialNumber: 0000:04:00.0
[    2.453906] xHCI xhci_add_endpoint called for root hub
[    2.453908] xHCI xhci_check_bandwidth called for root hub
[    2.453996] hub 1-0:1.0: USB hub found
[    2.454002] hub 1-0:1.0: 2 ports detected
[    2.454069] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    2.454073] xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus number 3
[    2.454140] usb usb3: New USB device found, idVendor=1d6b, idProduct=0003
[    2.454142] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.454144] usb usb3: Product: xHCI Host Controller
[    2.454145] usb usb3: Manufacturer: Linux 3.2.0-4-amd64 xhci_hcd
[    2.454146] usb usb3: SerialNumber: 0000:04:00.0
[    2.454203] xHCI xhci_add_endpoint called for root hub
[    2.454204] xHCI xhci_check_bandwidth called for root hub
[    2.454241] hub 3-0:1.0: USB hub found
[    2.454247] hub 3-0:1.0: 2 ports detected
[    2.454407] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    2.454448] r8169 0000:09:00.0: setting latency timer to 64
[    2.454521] r8169 0000:09:00.0: irq 81 for MSI/MSI-X
[    2.454946] r8169 0000:09:00.0: eth0: RTL8168evl/8111evl at 0xffffc9001261e000, f4:6d:04:58:ff:c4, XID 0c900800 IRQ 81
[    2.454950] r8169 0000:09:00.0: eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    2.456037] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    2.456082] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    2.456086] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.456090] usb usb2: Product: EHCI Host Controller
[    2.456095] usb usb2: Manufacturer: Linux 3.2.0-4-amd64 ehci_hcd
[    2.456096] usb usb2: SerialNumber: 0000:00:12.2
[    2.456316] hub 2-0:1.0: USB hub found
[    2.456319] hub 2-0:1.0: 5 ports detected
[    2.456478] ehci_hcd 0000:00:13.2: EHCI Host Controller
[    2.456486] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 4
[    2.456492] ehci_hcd 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.456510] ehci_hcd 0000:00:13.2: debug port 1
[    2.456529] ehci_hcd 0000:00:13.2: irq 21, io mem 0xfe703000
[    2.468053] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    2.468068] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
[    2.468070] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.468071] usb usb4: Product: EHCI Host Controller
[    2.468072] usb usb4: Manufacturer: Linux 3.2.0-4-amd64 ehci_hcd
[    2.468073] usb usb4: SerialNumber: 0000:00:13.2
[    2.468123] xhci_hcd 0000:05:00.0: setting latency timer to 64
[    2.468126] xhci_hcd 0000:05:00.0: xHCI Host Controller
[    2.468207] hub 4-0:1.0: USB hub found
[    2.468210] hub 4-0:1.0: 5 ports detected
[    2.468267] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus number 5
[    2.468321] ehci_hcd 0000:00:16.2: EHCI Host Controller
[    2.468331] ehci_hcd 0000:00:16.2: new USB bus registered, assigned bus number 6
[    2.468339] ehci_hcd 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    2.468366] ehci_hcd 0000:00:16.2: debug port 1
[    2.468395] ehci_hcd 0000:00:16.2: irq 23, io mem 0xfe700000
[    2.468628] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.477933] xhci_hcd 0000:05:00.0: irq 82 for MSI/MSI-X
[    2.477937] xhci_hcd 0000:05:00.0: irq 83 for MSI/MSI-X
[    2.477941] xhci_hcd 0000:05:00.0: irq 84 for MSI/MSI-X
[    2.477945] xhci_hcd 0000:05:00.0: irq 85 for MSI/MSI-X
[    2.477949] xhci_hcd 0000:05:00.0: irq 86 for MSI/MSI-X
[    2.477952] xhci_hcd 0000:05:00.0: irq 87 for MSI/MSI-X
[    2.477956] xhci_hcd 0000:05:00.0: irq 88 for MSI/MSI-X
[    2.477959] xhci_hcd 0000:05:00.0: irq 89 for MSI/MSI-X
[    2.478028] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
[    2.478030] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.478031] usb usb5: Product: xHCI Host Controller
[    2.478032] usb usb5: Manufacturer: Linux 3.2.0-4-amd64 xhci_hcd
[    2.478033] usb usb5: SerialNumber: 0000:05:00.0
[    2.478084] xHCI xhci_add_endpoint called for root hub
[    2.478085] xHCI xhci_check_bandwidth called for root hub
[    2.478103] hub 5-0:1.0: USB hub found
[    2.478108] hub 5-0:1.0: 2 ports detected
[    2.478149] xhci_hcd 0000:05:00.0: xHCI Host Controller
[    2.478153] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus number 7
[    2.478169] usb usb7: New USB device found, idVendor=1d6b, idProduct=0003
[    2.478170] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.478172] usb usb7: Product: xHCI Host Controller
[    2.478173] usb usb7: Manufacturer: Linux 3.2.0-4-amd64 xhci_hcd
[    2.478174] usb usb7: SerialNumber: 0000:05:00.0
[    2.478220] xHCI xhci_add_endpoint called for root hub
[    2.478221] xHCI xhci_check_bandwidth called for root hub
[    2.478239] hub 7-0:1.0: USB hub found
[    2.478243] hub 7-0:1.0: 2 ports detected
[    2.480058] ehci_hcd 0000:00:16.2: USB 2.0 started, EHCI 1.00
[    2.480072] usb usb6: New USB device found, idVendor=1d6b, idProduct=0002
[    2.480074] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.480076] usb usb6: Product: EHCI Host Controller
[    2.480077] usb usb6: Manufacturer: Linux 3.2.0-4-amd64 ehci_hcd
[    2.480079] usb usb6: SerialNumber: 0000:00:16.2
[    2.480175] hub 6-0:1.0: USB hub found
[    2.480178] hub 6-0:1.0: 4 ports detected
[    2.480259] ahci 0000:00:11.0: version 3.0
[    2.480389] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    2.480392] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    2.480931] scsi0 : ahci
[    2.481022] scsi1 : ahci
[    2.481073] scsi2 : ahci
[    2.481126] scsi3 : ahci
[    2.481176] scsi4 : ahci
[    2.481227] scsi5 : ahci
[    2.481473] ata1: SATA max UDMA/133 abar m1024@0xfe707000 port 0xfe707100 irq 19
[    2.481476] ata2: SATA max UDMA/133 abar m1024@0xfe707000 port 0xfe707180 irq 19
[    2.481478] ata3: SATA max UDMA/133 abar m1024@0xfe707000 port 0xfe707200 irq 19
[    2.481480] ata4: SATA max UDMA/133 abar m1024@0xfe707000 port 0xfe707280 irq 19
[    2.481482] ata5: SATA max UDMA/133 abar m1024@0xfe707000 port 0xfe707300 irq 19
[    2.481484] ata6: SATA max UDMA/133 abar m1024@0xfe707000 port 0xfe707380 irq 19
[    2.481519] ohci_hcd 0000:00:12.0: OHCI Host Controller
[    2.481530] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 8
[    2.481564] ohci_hcd 0000:00:12.0: irq 18, io mem 0xfe706000
[    2.481603] ahci 0000:02:00.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
[    2.481606] ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
[    2.481610] ahci 0000:02:00.0: setting latency timer to 64
[    2.481820] scsi6 : ahci
[    2.481877] scsi7 : ahci
[    2.481931] ata7: SATA max UDMA/133 abar m512@0xfe610000 port 0xfe610100 irq 44
[    2.481934] ata8: SATA max UDMA/133 abar m512@0xfe610000 port 0xfe610180 irq 44
[    2.482023] ahci 0000:03:00.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
[    2.482025] ahci 0000:03:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
[    2.482029] ahci 0000:03:00.0: setting latency timer to 64
[    2.482242] scsi8 : ahci
[    2.482296] scsi9 : ahci
[    2.482350] ata9: SATA max UDMA/133 abar m512@0xfe510000 port 0xfe510100 irq 46
[    2.482353] ata10: SATA max UDMA/133 abar m512@0xfe510000 port 0xfe510180 irq 46
[    2.516121] firewire_ohci: Added fw-ohci device 0000:07:07.0, OHCI v1.10, 4 IR + 8 IT contexts, quirks 0x11
[    2.540038] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
[    2.540040] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.540042] usb usb8: Product: OHCI Host Controller
[    2.540043] usb usb8: Manufacturer: Linux 3.2.0-4-amd64 ohci_hcd
[    2.540044] usb usb8: SerialNumber: 0000:00:12.0
[    2.540126] hub 8-0:1.0: USB hub found
[    2.540131] hub 8-0:1.0: 5 ports detected
[    2.540209] ohci_hcd 0000:00:13.0: OHCI Host Controller
[    2.540214] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 9
[    2.540234] ohci_hcd 0000:00:13.0: irq 20, io mem 0xfe704000
[    2.600032] usb usb9: New USB device found, idVendor=1d6b, idProduct=0001
[    2.600034] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.600036] usb usb9: Product: OHCI Host Controller
[    2.600037] usb usb9: Manufacturer: Linux 3.2.0-4-amd64 ohci_hcd
[    2.600038] usb usb9: SerialNumber: 0000:00:13.0
[    2.600114] hub 9-0:1.0: USB hub found
[    2.600119] hub 9-0:1.0: 5 ports detected
[    2.600176] ohci_hcd 0000:00:14.5: OHCI Host Controller
[    2.600183] ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 10
[    2.600194] ohci_hcd 0000:00:14.5: irq 18, io mem 0xfe702000
[    2.660051] usb usb10: New USB device found, idVendor=1d6b, idProduct=0001
[    2.660053] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.660055] usb usb10: Product: OHCI Host Controller
[    2.660056] usb usb10: Manufacturer: Linux 3.2.0-4-amd64 ohci_hcd
[    2.660057] usb usb10: SerialNumber: 0000:00:14.5
[    2.660135] hub 10-0:1.0: USB hub found
[    2.660140] hub 10-0:1.0: 2 ports detected
[    2.660196] ohci_hcd 0000:00:16.0: OHCI Host Controller
[    2.660201] ohci_hcd 0000:00:16.0: new USB bus registered, assigned bus number 11
[    2.660212] ohci_hcd 0000:00:16.0: irq 22, io mem 0xfe701000
[    2.720030] usb usb11: New USB device found, idVendor=1d6b, idProduct=0001
[    2.720032] usb usb11: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.720034] usb usb11: Product: OHCI Host Controller
[    2.720035] usb usb11: Manufacturer: Linux 3.2.0-4-amd64 ohci_hcd
[    2.720036] usb usb11: SerialNumber: 0000:00:16.0
[    2.720144] hub 11-0:1.0: USB hub found
[    2.720149] hub 11-0:1.0: 4 ports detected
[    2.768049] usb 2-2: new high-speed USB device number 2 using ehci_hcd
[    2.800074] ata8: SATA link down (SStatus 0 SControl 300)
[    2.800077] ata6: SATA link down (SStatus 0 SControl 300)
[    2.800111] ata7: SATA link down (SStatus 0 SControl 300)
[    2.804067] ata9: SATA link down (SStatus 0 SControl 300)
[    2.804077] ata4: SATA link down (SStatus 0 SControl 300)
[    2.804102] ata2: SATA link down (SStatus 0 SControl 300)
[    2.804125] ata3: SATA link down (SStatus 0 SControl 300)
[    2.804151] ata5: SATA link down (SStatus 0 SControl 300)
[    2.905441] usb 2-2: New USB device found, idVendor=0409, idProduct=0058
[    2.905444] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.905445] usb 2-2: Product: USB2.0 Hub Controller
[    2.905446] usb 2-2: Manufacturer: NEC Corporation
[    2.905610] hub 2-2:1.0: USB hub found
[    2.905691] hub 2-2:1.0: 4 ports detected
[    2.976039] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.976052] ata10: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.977924] ata1.00: ATA-9: Samsung SSD 840 EVO 1TB, EXT0BB0Q, max UDMA/133
[    2.977926] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    2.978123] ata1.00: configured for UDMA/133
[    2.978226] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 840  EXT0 PQ: 0 ANSI: 5
[    2.978755] ata10.00: ATAPI: HL-DT-ST DVDRAM GSA-H66N, CB00, max UDMA/100
[    2.982740] ata10.00: configured for UDMA/100
[    3.016094] firewire_core: created device fw0: GUID 001fc60000141e82, S400
[    3.072022] usb 4-3: new high-speed USB device number 3 using ehci_hcd
[    3.096231] scsi 9:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-H66N  CB00 PQ: 0 ANSI: 5
[    3.097811] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
[    3.097844] sd 0:0:0:0: [sda] Write Protect is off
[    3.097846] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.097857] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.100287]  sda: sda1 sda2 sda3
[    3.100508] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.101725] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    3.101761] sr 9:0:0:0: Attached scsi generic sg1 type 5
[    3.205698] usb 4-3: New USB device found, idVendor=05e3, idProduct=0608
[    3.205700] usb 4-3: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    3.205702] usb 4-3: Product: USB2.0 Hub
[    3.206102] hub 4-3:1.0: USB hub found
[    3.206446] hub 4-3:1.0: 4 ports detected
[    3.207523] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    3.207525] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.207621] sr 9:0:0:0: Attached scsi CD-ROM sr0
[    3.208023] Refined TSC clocksource calibration: 4013.470 MHz.
[    3.208028] Switching to clocksource tsc
[    3.584011] usb 9-2: new low-speed USB device number 2 using ohci_hcd
[    3.763073] usb 9-2: New USB device found, idVendor=04d9, idProduct=2013
[    3.763075] usb 9-2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    3.763077] usb 9-2: Product: daskeyboard
[    3.778185] input: daskeyboard as /devices/pci0000:00/0000:00:13.0/usb9/9-2/9-2:1.0/input/input0
[    3.778227] generic-usb 0003:04D9:2013.0001: input,hidraw0: USB HID v1.10 Keyboard [daskeyboard] on usb-0000:00:13.0-2/input0
[    3.805176] input: daskeyboard as /devices/pci0000:00/0000:00:13.0/usb9/9-2/9-2:1.1/input/input1
[    3.805216] generic-usb 0003:04D9:2013.0002: input,hidraw1: USB HID v1.10 Device [daskeyboard] on usb-0000:00:13.0-2/input1
[    3.805227] usbcore: registered new interface driver usbhid
[    3.805228] usbhid: USB HID core driver
[    4.028031] usb 9-5: new full-speed USB device number 3 using ohci_hcd
[    4.070329] device-mapper: uevent: version 1.0.3
[    4.070383] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) initialised: dm-devel@redhat.com
[    4.201072] usb 9-5: New USB device found, idVendor=1532, idProduct=0037
[    4.201074] usb 9-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.201076] usb 9-5: Product: Razer DeathAdder 2013
[    4.201077] usb 9-5: Manufacturer: Razer
[    4.207187] input: Razer Razer DeathAdder 2013 as /devices/pci0000:00/0000:00:13.0/usb9/9-5/9-5:1.0/input/input2
[    4.207247] generic-usb 0003:1532:0037.0003: input,hidraw2: USB HID v1.11 Mouse [Razer Razer DeathAdder 2013] on usb-0000:00:13.0-5/input0
[    4.217159] input: Razer Razer DeathAdder 2013 as /devices/pci0000:00/0000:00:13.0/usb9/9-5/9-5:1.1/input/input3
[    4.217198] generic-usb 0003:1532:0037.0004: input,hidraw3: USB HID v1.11 Keyboard [Razer Razer DeathAdder 2013] on usb-0000:00:13.0-5/input1
[    4.221180] input: Razer Razer DeathAdder 2013 as /devices/pci0000:00/0000:00:13.0/usb9/9-5/9-5:1.2/input/input4
[    4.221222] generic-usb 0003:1532:0037.0005: input,hidraw4: USB HID v1.11 Keyboard [Razer Razer DeathAdder 2013] on usb-0000:00:13.0-5/input2
[    4.360413] EXT4-fs (sda3): INFO: recovery required on readonly filesystem
[    4.360416] EXT4-fs (sda3): write access will be enabled during recovery
[    4.424975] EXT4-fs (sda3): recovery complete
[    4.425066] EXT4-fs (sda3): mounted filesystem with ordered data mode. Opts: (null)
[    4.725396] udevd[434]: starting version 175
[    4.763788] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input5
[    4.763795] ACPI: Power Button [PWRB]
[    4.763936] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input6
[    4.763940] ACPI: Power Button [PWRF]
[    4.764272] ACPI: acpi_idle registered with cpuidle
[    4.767703] wmi: Mapper loaded
[    4.800148] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    4.807346] SP5100 TCO timer: SP5100 TCO WatchDog Timer Driver v0.01
[    4.807740] SP5100 TCO timer: mmio address 0xbafe00 already in use
[    4.825194] input: PC Speaker as /devices/platform/pcspkr/input/input7
[    4.827700] EDAC MC: Ver: 2.1.0
[    4.829312] MCE: In-kernel MCE decoding enabled.
[    4.831052] AMD64 EDAC driver v3.4.0
[    4.831110] EDAC amd64: DRAM ECC disabled.
[    4.831122] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
[    4.831123]  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
[    4.831124]  (Note that use of the override may cause unknown side effects.)
[    4.844199] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aesni)
[    4.849973] nvidia: module license 'NVIDIA' taints kernel.
[    4.849975] Disabling lock debugging due to kernel taint
[    4.850422] powernow-k8: Found 1 AMD FX(tm)-8350 Eight-Core Processor            (8 cpu cores) (version 2.20.00)
[    4.850433] powernow-k8: Core Performance Boosting: on.
[    4.850444] [Firmware Bug]: powernow-k8: No compatible ACPI _PSS objects found.
[    4.850445] [Firmware Bug]: powernow-k8: Try again with latest BIOS.
[    4.850856] asus_wmi: ASUS WMI generic driver loaded
[    4.851527] asus_wmi: Initialization: 0x0
[    4.851549] asus_wmi: BIOS WMI version: 0.9
[    4.851593] asus_wmi: SFUN value: 0x0
[    4.851937] input: Eee PC WMI hotkeys as /devices/platform/eeepc-wmi/input/input8
[    4.914504] nvidia 0000:01:00.0: setting latency timer to 64
[    4.914508] vgaarb: device changed decodes: PCI:0000:01:00.0,olddecodes=io+mem,decodes=none:owns=io+mem
[    4.914652] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  331.20  Wed Oct 30 17:43:35 PDT 2013
[    4.920370] powernow-k8: Found 1 AMD FX(tm)-8350 Eight-Core Processor            (8 cpu cores) (version 2.20.00)
[    4.920384] powernow-k8: Core Performance Boosting: on.
[    4.920395] [Firmware Bug]: powernow-k8: No compatible ACPI _PSS objects found.
[    4.920396] [Firmware Bug]: powernow-k8: Try again with latest BIOS.
[    5.588791] kvm: Nested Virtualization enabled
[    5.588795] kvm: Nested Paging enabled
[    5.656460] EXT4-fs (sda3): re-mounted. Opts: (null)
[    5.679283] EXT4-fs (sda3): re-mounted. Opts: errors=remount-ro,discard
[    5.691586] loop: module loaded
[    6.079108] RPC: Registered named UNIX socket transport module.
[    6.079110] RPC: Registered udp transport module.
[    6.079111] RPC: Registered tcp transport module.
[    6.079112] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    6.082706] FS-Cache: Loaded
[    6.087368] FS-Cache: Netfs 'nfs' registered for caching
[    6.090784] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    6.351439] powernow-k8: Found 1 AMD FX(tm)-8350 Eight-Core Processor            (8 cpu cores) (version 2.20.00)
[    6.351452] powernow-k8: Core Performance Boosting: on.
[    6.351461] [Firmware Bug]: powernow-k8: No compatible ACPI _PSS objects found.
[    6.351462] [Firmware Bug]: powernow-k8: Try again with latest BIOS.
[    6.382428] Bluetooth: Core ver 2.16
[    6.382442] NET: Registered protocol family 31
[    6.382443] Bluetooth: HCI device and connection manager initialized
[    6.382445] Bluetooth: HCI socket layer initialized
[    6.382446] Bluetooth: L2CAP socket layer initialized
[    6.382450] Bluetooth: SCO socket layer initialized
[    6.387870] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    6.387872] Bluetooth: BNEP filters: protocol multicast
[    6.398845] Bluetooth: RFCOMM TTY layer initialized
[    6.398848] Bluetooth: RFCOMM socket layer initialized
[    6.398850] Bluetooth: RFCOMM ver 1.11
[    6.403387] vboxdrv: Found 8 processor cores.
[    6.403578] vboxdrv: fAsync=0 offMin=0x42a offMax=0x3869
[    6.403637] vboxdrv: TSC mode is 'synchronous', kernel timer mode is 'normal'.
[    6.403638] vboxdrv: Successfully loaded version 4.3.4 (interface 0x001a0005).
[    6.411059] lp: driver loaded but no devices found
[    6.413404] ppdev: user-space parallel port driver
[    6.456462] r8169 0000:09:00.0: firmware: agent loaded rtl_nic/rtl8168e-3.fw into memory
[    6.556937] r8169 0000:09:00.0: eth0: link down
[    6.556944] r8169 0000:09:00.0: eth0: link down
[    6.558184] ADDRCONF(NETDEV_UP): eth0: link is not ready
[    6.603113] nvidia 0000:01:00.0: irq 90 for MSI/MSI-X
[    6.618509] vboxpci: IOMMU found
[    6.666743] Ebtables v2.0 registered
[    6.673295] ip_tables: (C) 2000-2006 Netfilter Core Team
[    6.678396] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    8.704051] r8169 0000:09:00.0: eth0: link up
[    8.705583] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   19.072031] eth0: no IPv6 routers present
[   66.697114] hda_intel: Disabling MSI
[   66.697116] ALSA hda_intel.c:2553 Using LPIB position fix
[   66.697146] snd_hda_intel 0000:06:00.0: setting latency timer to 64
[   66.697151] ALSA hda_intel.c:2796 chipset global capabilities = 0x4300
[   66.697159] ALSA hda_intel.c:1175 Clearing TCSEL
[   66.724049] ALSA hda_intel.c:1031 codec_mask = 0x2
[   66.724181] ALSA hda_intel.c:1484 codec #1 probed OK
[   66.734419] ALSA hda_generic.c:586 AUD_IN = 8
[   66.734422] ALSA hda_generic.c:239 UNMUTE IN: NID=0x8 IDX=0x0
[   66.734879] ALSA hda_generic.c:239 UNMUTE IN: NID=0x12 IDX=0x0
[   66.735565] ALSA hda_generic.c:619 [Capture Source] NID=0x8, #SRC=1
[   66.735567] ALSA hda_generic.c:622   [Front Mic] IDX=0x0
[   66.735568] ALSA hda_generic.c:291 AUD_OUT found 2
[   66.735570] ALSA hda_generic.c:239 UNMUTE IN: NID=0xc IDX=0x0
[   66.735903] ALSA hda_generic.c:224 UNMUTE OUT: NID=0xc
[   66.736136] ALSA hda_generic.c:224 UNMUTE OUT: NID=0xc
[   66.736139] ALSA hda_generic.c:291 AUD_OUT found 6
[   66.736569] ALSA hda_generic.c:254 CONNECT: NID=0x8 IDX=0x0
[   66.736572] ALSA hda_generic.c:699 [Capture Switch] NID=0x8, DIR=IN, IDX=0x0
[   66.736575] ALSA hda_generic.c:725 [Capture Volume] NID=0x8, DIR=IN, IDX=0x0
[   66.736578] ALSA hda_generic.c:710 [Master Playback Switch] NID=0x2, DIR=OUT
[   66.736580] ALSA hda_generic.c:734 [Master Playback Volume] NID=0x2, DIR=OUT
[   76.125606] ALSA hda_intel.c:1848 azx_pcm_prepare: bufsize=0x10000, format=0x31
[   76.125615] ALSA hda_codec.c:1414 hda_codec_setup_stream: NID=0x2, stream=0x7, channel=0, format=0x31
[   93.308666] ALSA hda_codec.c:1477 hda_codec_cleanup_stream: NID=0x2
