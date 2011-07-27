From: Colomban Wendling <lists.ban@herbesfolles.org>
Subject: Re: Realtek ALC889: HDA Intel and kernel 3.0 gives
	choppy sound
Date: Wed, 27 Jul 2011 13:14:41 +0200
Message-ID: <4E2FF321.4070101@herbesfolles.org>
References: <4E2F2E47.8080902@herbesfolles.org> <s5h8vrk8esz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060309000909090102010107"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.herbesfolles.org (a4nancy.globenet.org [80.67.172.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DF7B2433D
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jul 2011 13:14:43 +0200 (CEST)
In-Reply-To: <s5h8vrk8esz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Nieder <jrnieder@gmail.com>, 635362@bugs.debian.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060309000909090102010107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Le 27/07/2011 07:37, Takashi Iwai a =E9crit :
> Do you have 2.6.39 kernel messages?  I see the warnings in your
> dmesg below in 3.0* kernels.  Did you get it with the working kernel
> as well?

Yes, and this one appears in all logs (as said in Debian bug).
See
http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=3D15;filename=3Ddmesg-2.=
6.39-2-amd64;att=3D1;bug=3D635362
for the full dmesg of Debian's 2.6.39.

>=20
>> [...]
>=20
>=20
> Also, you can replace the files in sound/pci/hda/* from 2.6.39 kernel
> tree.  If this fixes the problem, it's a sound driver bug.  If not,
> it's anything else, e.g. the problem in more core side, e.g. IOMMU
> like above or the timer change, etc.

Hey, that was a great idea! I reverse-patched sound/pci/hda of 3.0 with
2.6.39.3, and it fixes the problem! :)
I attach the dmesg of that version (3.0 with 2.6.39.3's sound/pci/hda)
if it is of any use for you.


Regards,
Colomban

--------------060309000909090102010107
Content-Type: text/plain;
 name="dmesg-3.0.0-mainline+2.6.39.3hda"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg-3.0.0-mainline+2.6.39.3hda"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.0.0 (ban@Hermione) (gcc version 4.6.1 (Debian 4.6.1-5) ) #5 SMP Wed Jul 27 12:41:08 CEST 2011
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.0.0 root=/dev/mapper/hermione-debian ro quiet
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000bf780000 (usable)
[    0.000000]  BIOS-e820: 00000000bf780000 - 00000000bf78e000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000bf78e000 - 00000000bf7d0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bf7d0000 - 00000000bf7e0000 (reserved)
[    0.000000]  BIOS-e820: 00000000bf7ed000 - 00000000c0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000138000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI present.
[    0.000000] DMI: MSI MS-7636/H55M-E33(MS-7636)   , BIOS V1.1 11/23/2009
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x138000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DFFFF uncachable
[    0.000000]   E0000-E3FFF write-protect
[    0.000000]   E4000-E7FFF write-through
[    0.000000]   E8000-EBFFF write-protect
[    0.000000]   EC000-EFFFF write-through
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 13C000000 mask FFC000000 uncachable
[    0.000000]   1 base 000000000 mask F00000000 write-back
[    0.000000]   2 base 100000000 mask FC0000000 write-back
[    0.000000]   3 base 0C0000000 mask FC0000000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820 update range: 00000000c0000000 - 0000000100000000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0xbf780 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [ffff8800000ff780] ff780
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff88000009a000] 9a000 size 20480
[    0.000000] init_memory_mapping: 0000000000000000-00000000bf780000
[    0.000000]  0000000000 - 00bf600000 page 2M
[    0.000000]  00bf600000 - 00bf780000 page 4k
[    0.000000] kernel direct mapping tables up to bf780000 @ bf77b000-bf780000
[    0.000000] init_memory_mapping: 0000000100000000-0000000138000000
[    0.000000]  0100000000 - 0138000000 page 2M
[    0.000000] kernel direct mapping tables up to 138000000 @ 137ffa000-138000000
[    0.000000] RAMDISK: 36a4e000 - 3751f000
[    0.000000] ACPI: RSDP 00000000000f9f00 00014 (v00 ACPIAM)
[    0.000000] ACPI: RSDT 00000000bf780000 00044 (v01 7636MS A7636100 20091123 MSFT 00000097)
[    0.000000] ACPI: FACP 00000000bf780200 00084 (v01 7636MS A7636100 20091123 MSFT 00000097)
[    0.000000] ACPI: DSDT 00000000bf7805e0 07303 (v01  A7636 A7636100 00000100 INTL 20051117)
[    0.000000] ACPI: FACS 00000000bf78e000 00040
[    0.000000] ACPI: APIC 00000000bf780390 0008C (v01 7636MS A7636100 20091123 MSFT 00000097)
[    0.000000] ACPI: MCFG 00000000bf780420 0003C (v01 7636MS OEMMCFG  20091123 MSFT 00000097)
[    0.000000] ACPI: OEMB 00000000bf78e040 00072 (v01 7636MS A7636100 20091123 MSFT 00000097)
[    0.000000] ACPI: HPET 00000000bf78a5e0 00038 (v01 7636MS OEMHPET  20091123 MSFT 00000097)
[    0.000000] ACPI: GSCI 00000000bf78e0c0 02024 (v01 7636MS GMCHSCI  20091123 MSFT 00000097)
[    0.000000] ACPI: DMAR 00000000bf7900f0 00108 (v01    AMI  OEMDMAR 00000001 MSFT 00000097)
[    0.000000] ACPI: SSDT 00000000bf791940 00363 (v01 DpgPmm    CpuPm 00000012 INTL 20051117)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000138000000
[    0.000000] Initmem setup node 0 0000000000000000-0000000138000000
[    0.000000]   NODE_DATA [0000000137ffb000 - 0000000137ffffff]
[    0.000000]  [ffffea0000000000-ffffea00045fffff] PMD -> [ffff880133800000-ffff880136ffffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00138000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x000bf780
[    0.000000]     0: 0x00100000 -> 0x00138000
[    0.000000] On node 0 totalpages: 1013519
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3922 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 765880 pages, LIFO batch:31
[    0.000000]   Normal zone: 3136 pages used for memmap
[    0.000000]   Normal zone: 226240 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x84] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x85] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x86] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x87] disabled)
[    0.000000] ACPI: IOAPIC (id[0x06] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 6, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] SMP: Allowing 8 CPUs, 4 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000bf780000 - 00000000bf78e000
[    0.000000] PM: Registered nosave memory: 00000000bf78e000 - 00000000bf7d0000
[    0.000000] PM: Registered nosave memory: 00000000bf7d0000 - 00000000bf7e0000
[    0.000000] PM: Registered nosave memory: 00000000bf7e0000 - 00000000bf7ed000
[    0.000000] PM: Registered nosave memory: 00000000bf7ed000 - 00000000c0000000
[    0.000000] PM: Registered nosave memory: 00000000c0000000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000ffe00000
[    0.000000] PM: Registered nosave memory: 00000000ffe00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at c0000000 (gap: c0000000:3ee00000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 27 pages/cpu @ffff880137c00000 s78976 r8192 d23424 u262144
[    0.000000] pcpu-alloc: s78976 r8192 d23424 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 996042
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-3.0.0 root=/dev/mapper/hermione-debian ro quiet
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: at drivers/pci/dmar.c:634 warn_invalid_dmar+0x77/0x85()
[    0.000000] Hardware name: MS-7636
[    0.000000] Your BIOS is broken; DMAR reported at address fed93000 returns all ones!
[    0.000000] BIOS vendor: American Megatrends Inc.; Ver: V1.1; Product Version: 1.0
[    0.000000] Modules linked in:
[    0.000000] Pid: 0, comm: swapper Not tainted 3.0.0 #5
[    0.000000] Call Trace:
[    0.000000]  [<ffffffff81043359>] ? warn_slowpath_common+0x78/0x8c
[    0.000000]  [<ffffffff810433bb>] ? warn_slowpath_fmt_taint+0x3d/0x42
[    0.000000]  [<ffffffff81318a7e>] ? __pte+0x7/0x8
[    0.000000]  [<ffffffff816b2a2d>] ? __early_set_fixmap+0x89/0x8d
[    0.000000]  [<ffffffff81318a7e>] ? __pte+0x7/0x8
[    0.000000]  [<ffffffff816b2a2d>] ? __early_set_fixmap+0x89/0x8d
[    0.000000]  [<ffffffff81318a7e>] ? __pte+0x7/0x8
[    0.000000]  [<ffffffff811b72c9>] ? warn_invalid_dmar+0x77/0x85
[    0.000000]  [<ffffffff816b2e3a>] ? early_iounmap+0xc5/0x114
[    0.000000]  [<ffffffff816c6f13>] ? check_zero_address+0xb0/0xeb
[    0.000000]  [<ffffffff81327736>] ? bad_to_user+0x620/0x620
[    0.000000]  [<ffffffff816c6f5f>] ? detect_intel_iommu+0x11/0xa6
[    0.000000]  [<ffffffff816a5b29>] ? pci_iommu_alloc+0x3f/0x67
[    0.000000]  [<ffffffff816b280c>] ? mem_init+0x14/0xe5
[    0.000000]  [<ffffffff8169f94e>] ? start_kernel+0x1d0/0x3c8
[    0.000000]  [<ffffffff8169f140>] ? early_idt_handlers+0x140/0x140
[    0.000000]  [<ffffffff8169f3c4>] ? x86_64_start_kernel+0x104/0x111
[    0.000000] ---[ end trace a7919e7f17c0a725 ]---
[    0.000000] Disabling lock debugging due to kernel taint
[    0.000000] Memory: 3910280k/5111808k available (3229k kernel code, 1057732k absent, 143796k reserved, 3465k data, 556k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:33024 nr_irqs:744 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 32505856 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.004000] Detected 2926.498 MHz processor.
[    0.000003] Calibrating delay loop (skipped), value calculated using timer frequency.. 5852.99 BogoMIPS (lpj=11705992)
[    0.000006] pid_max: default: 32768 minimum: 301
[    0.000068] Security Framework initialized
[    0.000071] SELinux:  Disabled at boot.
[    0.000395] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.001319] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.001685] Mount-cache hash table entries: 256
[    0.001802] Initializing cgroup subsys cpuacct
[    0.001807] Initializing cgroup subsys memory
[    0.001818] Initializing cgroup subsys devices
[    0.001820] Initializing cgroup subsys freezer
[    0.001822] Initializing cgroup subsys net_cls
[    0.001825] Initializing cgroup subsys blkio
[    0.001857] CPU: Physical Processor ID: 0
[    0.001858] CPU: Processor Core ID: 0
[    0.001863] mce: CPU supports 9 MCE banks
[    0.001874] CPU0: Thermal monitoring enabled (TM1)
[    0.001881] using mwait in idle threads.
[    0.002235] ACPI: Core revision 20110413
[    0.028446] DMAR: Host address width 36
[    0.028448] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.028455] IOMMU 0: reg_base_addr fed90000 ver 1:0 cap c9008020e30272 ecap 1000
[    0.028456] DMAR: DRHD base: 0x000000fed93000 flags: 0x1
[    0.028465] DMAR: parse DMAR table failure.
[    0.028787] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.068368] CPU0: Intel(R) Core(TM) i3 CPU         530  @ 2.93GHz stepping 02
[    0.172757] Performance Events: PEBS fmt1+, Westmere events, Intel PMU driver.
[    0.172764] ... version:                3
[    0.172765] ... bit width:              48
[    0.172766] ... generic registers:      4
[    0.172767] ... value mask:             0000ffffffffffff
[    0.172769] ... max period:             000000007fffffff
[    0.172770] ... fixed-purpose events:   3
[    0.172771] ... event mask:             000000070000000f
[    0.172975] NMI watchdog enabled, takes one hw-pmu counter.
[    0.173091] Booting Node   0, Processors  #1
[    0.173093] smpboot cpu 1: start_ip = 9a000
[    0.280590] NMI watchdog enabled, takes one hw-pmu counter.
[    0.280721]  #2
[    0.280723] smpboot cpu 2: start_ip = 9a000
[    0.388257] NMI watchdog enabled, takes one hw-pmu counter.
[    0.388379]  #3
[    0.388380] smpboot cpu 3: start_ip = 9a000
[    0.495948] NMI watchdog enabled, takes one hw-pmu counter.
[    0.495983] Brought up 4 CPUs
[    0.495985] Total of 4 processors activated (23408.59 BogoMIPS).
[    0.497899] devtmpfs: initialized
[    0.500870] PM: Registering ACPI NVS region at bf78e000 (270336 bytes)
[    0.500991] print_constraints: dummy: 
[    0.501043] NET: Registered protocol family 16
[    0.501123] ACPI: bus type pci registered
[    0.501176] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.501178] PCI: not using MMCONFIG
[    0.501179] PCI: Using configuration type 1 for base access
[    0.501606] bio: create slab <bio-0> at 0
[    0.502540] ACPI: EC: Look up EC in DSDT
[    0.503660] ACPI: Executed 1 blocks of module-level executable AML code
[    0.506705] ACPI: SSDT 00000000bf790200 01238 (v01 DpgPmm  P001Ist 00000011 INTL 20051117)
[    0.506964] ACPI: Dynamic OEM Table Load:
[    0.506966] ACPI: SSDT           (null) 01238 (v01 DpgPmm  P001Ist 00000011 INTL 20051117)
[    0.507045] ACPI: SSDT 00000000bf791440 004F4 (v01  PmRef  P001Cst 00003001 INTL 20051117)
[    0.507270] ACPI: Dynamic OEM Table Load:
[    0.507272] ACPI: SSDT           (null) 004F4 (v01  PmRef  P001Cst 00003001 INTL 20051117)
[    0.507624] ACPI: Interpreter enabled
[    0.507626] ACPI: (supports S0 S3 S4 S5)
[    0.507642] ACPI: Using IOAPIC for interrupt routing
[    0.507660] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.508590] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    0.531628] ACPI: No dock devices found.
[    0.531630] HEST: Table not found.
[    0.531632] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.531818] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.531975] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    0.531977] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    0.531979] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    0.531981] pci_root PNP0A08:00: host bridge window [mem 0x000d0000-0x000dffff]
[    0.531983] pci_root PNP0A08:00: host bridge window [mem 0xc0000000-0xdfffffff]
[    0.531984] pci_root PNP0A08:00: host bridge window [mem 0xf0000000-0xfed8ffff]
[    0.531994] pci 0000:00:00.0: [8086:0040] type 0 class 0x000600
[    0.532009] DMAR: BIOS has allocated no shadow GTT; disabling IOMMU for graphics
[    0.532024] pci 0000:00:01.0: [8086:0041] type 1 class 0x000604
[    0.532044] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.532046] pci 0000:00:01.0: PME# disabled
[    0.532079] pci 0000:00:16.0: [8086:3b64] type 0 class 0x000780
[    0.532105] pci 0000:00:16.0: reg 10: [mem 0xf7ffe000-0xf7ffe00f 64bit]
[    0.532176] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.532180] pci 0000:00:16.0: PME# disabled
[    0.532207] pci 0000:00:1a.0: [8086:3b3c] type 0 class 0x000c03
[    0.532224] pci 0000:00:1a.0: reg 10: [mem 0xf7ffc000-0xf7ffc3ff]
[    0.532284] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.532287] pci 0000:00:1a.0: PME# disabled
[    0.532306] pci 0000:00:1b.0: [8086:3b56] type 0 class 0x000403
[    0.532319] pci 0000:00:1b.0: reg 10: [mem 0xf7ff8000-0xf7ffbfff 64bit]
[    0.532362] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.532365] pci 0000:00:1b.0: PME# disabled
[    0.532380] pci 0000:00:1c.0: [8086:3b42] type 1 class 0x000604
[    0.532423] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.532426] pci 0000:00:1c.0: PME# disabled
[    0.532443] pci 0000:00:1c.2: [8086:3b46] type 1 class 0x000604
[    0.532485] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.532488] pci 0000:00:1c.2: PME# disabled
[    0.532513] pci 0000:00:1d.0: [8086:3b34] type 0 class 0x000c03
[    0.532530] pci 0000:00:1d.0: reg 10: [mem 0xf7ff6000-0xf7ff63ff]
[    0.532592] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.532596] pci 0000:00:1d.0: PME# disabled
[    0.532612] pci 0000:00:1e.0: [8086:244e] type 1 class 0x000604
[    0.532659] pci 0000:00:1f.0: [8086:3b06] type 0 class 0x000601
[    0.532753] pci 0000:00:1f.2: [8086:3b20] type 0 class 0x000101
[    0.532765] pci 0000:00:1f.2: reg 10: [io  0xbc00-0xbc07]
[    0.532771] pci 0000:00:1f.2: reg 14: [io  0xb880-0xb883]
[    0.532778] pci 0000:00:1f.2: reg 18: [io  0xb800-0xb807]
[    0.532784] pci 0000:00:1f.2: reg 1c: [io  0xb480-0xb483]
[    0.532791] pci 0000:00:1f.2: reg 20: [io  0xb400-0xb40f]
[    0.532797] pci 0000:00:1f.2: reg 24: [io  0xb080-0xb08f]
[    0.532826] pci 0000:00:1f.3: [8086:3b30] type 0 class 0x000c05
[    0.532838] pci 0000:00:1f.3: reg 10: [mem 0xf7ff4000-0xf7ff40ff 64bit]
[    0.532855] pci 0000:00:1f.3: reg 20: [io  0x0400-0x041f]
[    0.532880] pci 0000:00:1f.5: [8086:3b26] type 0 class 0x000101
[    0.532892] pci 0000:00:1f.5: reg 10: [io  0xac00-0xac07]
[    0.532898] pci 0000:00:1f.5: reg 14: [io  0xa880-0xa883]
[    0.532904] pci 0000:00:1f.5: reg 18: [io  0xa800-0xa807]
[    0.532911] pci 0000:00:1f.5: reg 1c: [io  0xa480-0xa483]
[    0.532917] pci 0000:00:1f.5: reg 20: [io  0xa400-0xa40f]
[    0.532923] pci 0000:00:1f.5: reg 24: [io  0xa080-0xa08f]
[    0.532973] pci 0000:01:00.0: [10de:0402] type 0 class 0x000300
[    0.532981] pci 0000:01:00.0: reg 10: [mem 0xfa000000-0xfaffffff]
[    0.532989] pci 0000:01:00.0: reg 14: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.532998] pci 0000:01:00.0: reg 1c: [mem 0xf8000000-0xf9ffffff 64bit]
[    0.533004] pci 0000:01:00.0: reg 24: [io  0xcc00-0xcc7f]
[    0.533010] pci 0000:01:00.0: reg 30: [mem 0xfbee0000-0xfbefffff pref]
[    0.533044] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.533047] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
[    0.533049] pci 0000:00:01.0:   bridge window [mem 0xf8000000-0xfbefffff]
[    0.533052] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.533098] pci 0000:02:00.0: [10ec:8168] type 0 class 0x000200
[    0.533112] pci 0000:02:00.0: reg 10: [io  0xd800-0xd8ff]
[    0.533137] pci 0000:02:00.0: reg 18: [mem 0xf6fff000-0xf6ffffff 64bit pref]
[    0.533152] pci 0000:02:00.0: reg 20: [mem 0xf6ff8000-0xf6ffbfff 64bit pref]
[    0.533163] pci 0000:02:00.0: reg 30: [mem 0xfbfe0000-0xfbffffff pref]
[    0.533197] pci 0000:02:00.0: supports D1 D2
[    0.533198] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.533202] pci 0000:02:00.0: PME# disabled
[    0.539751] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.539757] pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
[    0.539763] pci 0000:00:1c.0:   bridge window [mem 0xfbf00000-0xfbffffff]
[    0.539771] pci 0000:00:1c.0:   bridge window [mem 0xf6f00000-0xf6ffffff 64bit pref]
[    0.539842] pci 0000:03:00.0: [197b:2368] type 0 class 0x000101
[    0.539869] pci 0000:03:00.0: reg 10: [io  0xec00-0xec07]
[    0.539881] pci 0000:03:00.0: reg 14: [io  0xe880-0xe883]
[    0.539894] pci 0000:03:00.0: reg 18: [io  0xe800-0xe807]
[    0.539906] pci 0000:03:00.0: reg 1c: [io  0xe480-0xe483]
[    0.539918] pci 0000:03:00.0: reg 20: [io  0xe400-0xe40f]
[    0.539983] pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.539992] pci 0000:00:1c.2: PCI bridge to [bus 03-03]
[    0.539995] pci 0000:00:1c.2:   bridge window [io  0xe000-0xefff]
[    0.539998] pci 0000:00:1c.2:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    0.540003] pci 0000:00:1c.2:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    0.540052] pci 0000:00:1e.0: PCI bridge to [bus 04-04] (subtractive decode)
[    0.540055] pci 0000:00:1e.0:   bridge window [io  0xf000-0x0000] (disabled)
[    0.540058] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    0.540063] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    0.540065] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.540067] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.540069] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.540071] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dffff] (subtractive decode)
[    0.540073] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xdfffffff] (subtractive decode)
[    0.540074] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xfed8ffff] (subtractive decode)
[    0.540089] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.540289] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR1E._PRT]
[    0.540340] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR20._PRT]
[    0.540372] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR22._PRT]
[    0.540526]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.540715]  pci0000:00: ACPI _OSC request failed (AE_SUPPORT), returned control mask: 0x0d
[    0.540717] ACPI _OSC control for PCIe not granted, disabling ASPM
[    0.547255] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 *10 11 12 14 15)
[    0.547294] ACPI: PCI Interrupt Link [LNKB] (IRQs *5)
[    0.547330] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 *11 12 14 15)
[    0.547367] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *6 7 10 11 12 14 15)
[    0.547404] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12 14 15) *0, disabled.
[    0.547442] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12 14 15) *0, disabled.
[    0.547480] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 6 7 10 11 12 14 *15)
[    0.547517] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 10 11 12 *14 15)
[    0.547598] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.547600] vgaarb: loaded
[    0.547601] vgaarb: bridge control possible 0000:01:00.0
[    0.547630] PCI: Using ACPI for IRQ routing
[    0.552647] PCI: Discovered peer bus ff
[    0.552674] pci 0000:ff:00.0: [8086:2c61] type 0 class 0x000600
[    0.552690] pci 0000:ff:00.1: [8086:2d01] type 0 class 0x000600
[    0.552705] pci 0000:ff:02.0: [8086:2d10] type 0 class 0x000600
[    0.552719] pci 0000:ff:02.1: [8086:2d11] type 0 class 0x000600
[    0.552733] pci 0000:ff:02.2: [8086:2d12] type 0 class 0x000600
[    0.552747] pci 0000:ff:02.3: [8086:2d13] type 0 class 0x000600
[    0.552879] PCI: pci_cache_line_size set to 64 bytes
[    0.552932] reserve RAM buffer: 000000000009fc00 - 000000000009ffff 
[    0.552934] reserve RAM buffer: 00000000bf780000 - 00000000bfffffff 
[    0.553019] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.553023] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.555032] Switching to clocksource hpet
[    0.555694] Switched to NOHz mode on CPU #0
[    0.555775] Switched to NOHz mode on CPU #3
[    0.555783] Switched to NOHz mode on CPU #2
[    0.555813] Switched to NOHz mode on CPU #1
[    0.556200] pnp: PnP ACPI init
[    0.556211] ACPI: bus type pnp registered
[    0.556292] pnp 00:00: [bus 00-ff]
[    0.556294] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.556296] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.556297] pnp 00:00: [io  0x0d00-0xffff window]
[    0.556299] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.556301] pnp 00:00: [mem 0x000d0000-0x000dffff window]
[    0.556302] pnp 00:00: [mem 0xc0000000-0xdfffffff window]
[    0.556304] pnp 00:00: [mem 0xf0000000-0xfed8ffff window]
[    0.556342] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    0.556351] pnp 00:01: [mem 0xfc000000-0xfcffffff]
[    0.556352] pnp 00:01: [mem 0xfd000000-0xfdffffff]
[    0.556354] pnp 00:01: [mem 0xfe000000-0xfebfffff]
[    0.556355] pnp 00:01: [mem 0xfed14000-0xfed19fff]
[    0.556386] system 00:01: [mem 0xfc000000-0xfcffffff] has been reserved
[    0.556389] system 00:01: [mem 0xfd000000-0xfdffffff] has been reserved
[    0.556391] system 00:01: [mem 0xfe000000-0xfebfffff] has been reserved
[    0.556393] system 00:01: [mem 0xfed14000-0xfed19fff] has been reserved
[    0.556395] system 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.556425] pnp 00:02: [dma 4]
[    0.556427] pnp 00:02: [io  0x0000-0x000f]
[    0.556428] pnp 00:02: [io  0x0081-0x0083]
[    0.556430] pnp 00:02: [io  0x0087]
[    0.556431] pnp 00:02: [io  0x0089-0x008b]
[    0.556433] pnp 00:02: [io  0x008f]
[    0.556434] pnp 00:02: [io  0x00c0-0x00df]
[    0.556453] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.556462] pnp 00:03: [io  0x0070-0x0071]
[    0.556469] pnp 00:03: [irq 8]
[    0.556488] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.556496] pnp 00:04: [io  0x0061]
[    0.556514] pnp 00:04: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.556522] pnp 00:05: [io  0x00f0-0x00ff]
[    0.556526] pnp 00:05: [irq 13]
[    0.556547] pnp 00:05: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.556778] pnp 00:06: [io  0x03f8-0x03ff]
[    0.556783] pnp 00:06: [irq 4]
[    0.556785] pnp 00:06: [dma 0 disabled]
[    0.556834] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.557061] pnp 00:07: [io  0x02f8-0x02ff]
[    0.557065] pnp 00:07: [irq 3]
[    0.557067] pnp 00:07: [dma 0 disabled]
[    0.557134] pnp 00:07: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.557436] pnp 00:08: [io  0x0378-0x037f]
[    0.557440] pnp 00:08: [irq 7]
[    0.557442] pnp 00:08: [dma 0 disabled]
[    0.557557] pnp 00:08: Plug and Play ACPI device, IDs PNP0400 (active)
[    0.557582] pnp 00:09: [io  0x0060]
[    0.557583] pnp 00:09: [io  0x0064]
[    0.557587] pnp 00:09: [irq 1]
[    0.557612] pnp 00:09: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.557651] pnp 00:0a: [irq 12]
[    0.557676] pnp 00:0a: Plug and Play ACPI device, IDs PNP0f03 PNP0f13 (active)
[    0.557755] pnp 00:0b: [io  0x0000-0xffffffffffffffff disabled]
[    0.557757] pnp 00:0b: [io  0x0a00-0x0adf]
[    0.557758] pnp 00:0b: [io  0x0ae0-0x0aef]
[    0.557793] system 00:0b: [io  0x0a00-0x0adf] has been reserved
[    0.557795] system 00:0b: [io  0x0ae0-0x0aef] has been reserved
[    0.557797] system 00:0b: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.557898] pnp 00:0c: [io  0x0010-0x001f]
[    0.557900] pnp 00:0c: [io  0x0022-0x002d]
[    0.557901] pnp 00:0c: [io  0x0030-0x003f]
[    0.557903] pnp 00:0c: [io  0x0044-0x005f]
[    0.557904] pnp 00:0c: [io  0x0062-0x0063]
[    0.557906] pnp 00:0c: [io  0x0065-0x006f]
[    0.557907] pnp 00:0c: [io  0x0072-0x007f]
[    0.557908] pnp 00:0c: [io  0x0080]
[    0.557910] pnp 00:0c: [io  0x0084-0x0086]
[    0.557911] pnp 00:0c: [io  0x0088]
[    0.557912] pnp 00:0c: [io  0x008c-0x008e]
[    0.557915] pnp 00:0c: [io  0x0090-0x009f]
[    0.557916] pnp 00:0c: [io  0x00a2-0x00bf]
[    0.557918] pnp 00:0c: [io  0x00e0-0x00ef]
[    0.557919] pnp 00:0c: [io  0x04d0-0x04d1]
[    0.557921] pnp 00:0c: [io  0x0800-0x087f]
[    0.557922] pnp 00:0c: [io  0x0000-0xffffffffffffffff disabled]
[    0.557924] pnp 00:0c: [io  0x0500-0x057f]
[    0.557925] pnp 00:0c: [mem 0xfed1c000-0xfed1ffff]
[    0.557927] pnp 00:0c: [mem 0xfed20000-0xfed3ffff]
[    0.557928] pnp 00:0c: [mem 0xfed45000-0xfed89fff]
[    0.557930] pnp 00:0c: [mem 0xfed20000-0xfed3ffff]
[    0.557931] pnp 00:0c: [mem 0xfed40000-0xfed8ffff]
[    0.557984] system 00:0c: [io  0x04d0-0x04d1] has been reserved
[    0.557986] system 00:0c: [io  0x0800-0x087f] has been reserved
[    0.557989] system 00:0c: [io  0x0500-0x057f] has been reserved
[    0.557991] system 00:0c: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.557994] system 00:0c: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.557996] system 00:0c: [mem 0xfed45000-0xfed89fff] has been reserved
[    0.557998] system 00:0c: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.558001] system 00:0c: [mem 0xfed40000-0xfed8ffff] could not be reserved
[    0.558003] system 00:0c: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.558051] pnp 00:0d: [mem 0xfed00000-0xfed003ff]
[    0.558073] pnp 00:0d: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.558144] pnp 00:0e: [mem 0xfec00000-0xfec00fff]
[    0.558146] pnp 00:0e: [mem 0xfee00000-0xfee00fff]
[    0.558183] system 00:0e: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.558186] system 00:0e: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.558188] system 00:0e: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.558227] pnp 00:0f: [mem 0xe0000000-0xefffffff]
[    0.558261] system 00:0f: [mem 0xe0000000-0xefffffff] has been reserved
[    0.558263] system 00:0f: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.558453] pnp 00:10: [mem 0x00000000-0x0009ffff]
[    0.558455] pnp 00:10: [mem 0x000c0000-0x000cffff]
[    0.558456] pnp 00:10: [mem 0x000e0000-0x000fffff]
[    0.558458] pnp 00:10: [mem 0x00100000-0xbfffffff]
[    0.558460] pnp 00:10: [mem 0xfed90000-0xffffffff]
[    0.558506] system 00:10: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.558509] system 00:10: [mem 0x000c0000-0x000cffff] could not be reserved
[    0.558511] system 00:10: [mem 0x000e0000-0x000fffff] could not be reserved
[    0.558513] system 00:10: [mem 0x00100000-0xbfffffff] could not be reserved
[    0.558515] system 00:10: [mem 0xfed90000-0xffffffff] could not be reserved
[    0.558518] system 00:10: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.558627] pnp: PnP ACPI: found 17 devices
[    0.558629] ACPI: ACPI bus type pnp unregistered
[    0.564346] PCI: max bus depth: 1 pci_try_num: 2
[    0.564369] pci 0000:00:1c.2: BAR 14: assigned [mem 0xc0000000-0xc01fffff]
[    0.564372] pci 0000:00:1c.2: BAR 15: assigned [mem 0xc0200000-0xc03fffff 64bit pref]
[    0.564374] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.564376] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
[    0.564378] pci 0000:00:01.0:   bridge window [mem 0xf8000000-0xfbefffff]
[    0.564381] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.564384] pci 0000:00:1c.0: PCI bridge to [bus 02-02]
[    0.564386] pci 0000:00:1c.0:   bridge window [io  0xd000-0xdfff]
[    0.564390] pci 0000:00:1c.0:   bridge window [mem 0xfbf00000-0xfbffffff]
[    0.564393] pci 0000:00:1c.0:   bridge window [mem 0xf6f00000-0xf6ffffff 64bit pref]
[    0.564397] pci 0000:00:1c.2: PCI bridge to [bus 03-03]
[    0.564399] pci 0000:00:1c.2:   bridge window [io  0xe000-0xefff]
[    0.564403] pci 0000:00:1c.2:   bridge window [mem 0xc0000000-0xc01fffff]
[    0.564406] pci 0000:00:1c.2:   bridge window [mem 0xc0200000-0xc03fffff 64bit pref]
[    0.564411] pci 0000:00:1e.0: PCI bridge to [bus 04-04]
[    0.564412] pci 0000:00:1e.0:   bridge window [io  disabled]
[    0.564415] pci 0000:00:1e.0:   bridge window [mem disabled]
[    0.564418] pci 0000:00:1e.0:   bridge window [mem pref disabled]
[    0.564431] pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.564433] pci 0000:00:01.0: setting latency timer to 64
[    0.564442] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.564445] pci 0000:00:1c.0: setting latency timer to 64
[    0.564449] pci 0000:00:1c.2: enabling device (0105 -> 0107)
[    0.564455] pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.564458] pci 0000:00:1c.2: setting latency timer to 64
[    0.564462] pci 0000:00:1e.0: setting latency timer to 64
[    0.564465] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.564467] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.564468] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.564470] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff]
[    0.564471] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xdfffffff]
[    0.564473] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfed8ffff]
[    0.564475] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
[    0.564476] pci_bus 0000:01: resource 1 [mem 0xf8000000-0xfbefffff]
[    0.564478] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.564479] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    0.564481] pci_bus 0000:02: resource 1 [mem 0xfbf00000-0xfbffffff]
[    0.564483] pci_bus 0000:02: resource 2 [mem 0xf6f00000-0xf6ffffff 64bit pref]
[    0.564484] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
[    0.564486] pci_bus 0000:03: resource 1 [mem 0xc0000000-0xc01fffff]
[    0.564487] pci_bus 0000:03: resource 2 [mem 0xc0200000-0xc03fffff 64bit pref]
[    0.564489] pci_bus 0000:04: resource 4 [io  0x0000-0x0cf7]
[    0.564491] pci_bus 0000:04: resource 5 [io  0x0d00-0xffff]
[    0.564492] pci_bus 0000:04: resource 6 [mem 0x000a0000-0x000bffff]
[    0.564494] pci_bus 0000:04: resource 7 [mem 0x000d0000-0x000dffff]
[    0.564496] pci_bus 0000:04: resource 8 [mem 0xc0000000-0xdfffffff]
[    0.564497] pci_bus 0000:04: resource 9 [mem 0xf0000000-0xfed8ffff]
[    0.564499] pci_bus 0000:ff: resource 0 [io  0x0000-0xffff]
[    0.564500] pci_bus 0000:ff: resource 1 [mem 0x00000000-0xfffffffff]
[    0.564561] NET: Registered protocol family 2
[    0.564681] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.565480] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    0.567630] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.567885] TCP: Hash tables configured (established 524288 bind 65536)
[    0.567887] TCP reno registered
[    0.567896] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.567925] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    0.568080] NET: Registered protocol family 1
[    0.568159] pci 0000:01:00.0: Boot video device
[    0.568174] PCI: CLS 32 bytes, default 64
[    0.568211] Unpacking initramfs...
[    0.758090] Freeing initrd memory: 11076k freed
[    0.760033] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.760038] Placing 64MB software IO TLB between ffff8800bb77b000 - ffff8800bf77b000
[    0.760040] software IO TLB at phys 0xbb77b000 - 0xbf77b000
[    0.760484] audit: initializing netlink socket (disabled)
[    0.760496] type=2000 audit(1311763886.588:1): initialized
[    0.777650] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.790212] VFS: Disk quotas dquot_6.5.2
[    0.790243] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.790309] msgmni has been set to 7658
[    0.790451] alg: No test for stdrng (krng)
[    0.790489] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.790492] io scheduler noop registered
[    0.790493] io scheduler deadline registered
[    0.790509] io scheduler cfq registered (default)
[    0.790588] pcieport 0000:00:01.0: setting latency timer to 64
[    0.790612] pcieport 0000:00:01.0: irq 40 for MSI/MSI-X
[    0.790765] vesafb: mode is 1680x1050x32, linelength=6720, pages=0
[    0.790766] vesafb: scrolling: redraw
[    0.790768] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.791331] vesafb: framebuffer at 0xf9000000, mapped to 0xffffc90011100000, using 6912k, total 6912k
[    0.974095] Console: switching to colour frame buffer device 210x65
[    1.155082] fb0: VESA VGA frame buffer device
[    1.155112] ERST: Table is not found!
[    1.155169] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.175474] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.249457] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    1.317498] 00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.337851] 00:07: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    1.338105] Linux agpgart interface v0.103
[    1.338267] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    1.338595] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.338600] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.338685] mousedev: PS/2 mouse device common for all mice
[    1.338720] rtc_cmos 00:03: RTC can wake from S4
[    1.338807] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    1.338831] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    1.338839] cpuidle: using governor ladder
[    1.338841] cpuidle: using governor menu
[    1.338994] TCP cubic registered
[    1.339043] NET: Registered protocol family 10
[    1.339441] Mobile IPv6
[    1.339443] NET: Registered protocol family 17
[    1.339446] Registering the dns_resolver key type
[    1.339517] PM: Hibernation image not present or could not be loaded.
[    1.339525] registered taskstats version 1
[    1.346055] rtc_cmos 00:03: setting system clock to 2011-07-27 10:51:28 UTC (1311763888)
[    1.346084] Initializing network drop monitor service
[    1.347096] Freeing unused kernel memory: 556k freed
[    1.347164] Write protecting the kernel read-only data: 6144k
[    1.349867] Freeing unused kernel memory: 848k freed
[    1.352389] Freeing unused kernel memory: 776k freed
[    1.359132] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.426792] udevd[60]: starting version 172
[    1.437313] usbcore: registered new interface driver usbfs
[    1.437339] usbcore: registered new interface driver hub
[    1.439019] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    1.439039] r8169 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.439080] r8169 0000:02:00.0: setting latency timer to 64
[    1.439133] r8169 0000:02:00.0: irq 41 for MSI/MSI-X
[    1.439569] r8169 0000:02:00.0: eth0: RTL8168d/8111d at 0xffffc9000064a000, 40:61:86:63:b8:90, XID 081000c0 IRQ 41
[    1.440046] usbcore: registered new device driver usb
[    1.440443] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.440471] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.440493] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    1.440497] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    1.440522] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    1.440555] ehci_hcd 0000:00:1a.0: debug port 2
[    1.444494] ehci_hcd 0000:00:1a.0: cache line size of 32 is not supported
[    1.449258] SCSI subsystem initialized
[    1.454954] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xf7ffc000
[    1.464395] libata version 3.00 loaded.
[    1.464667] pata_jmicron 0000:03:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    1.464698] pata_jmicron 0000:03:00.0: setting latency timer to 64
[    1.466840] scsi0 : pata_jmicron
[    1.467595] scsi1 : pata_jmicron
[    1.468151] ata1: PATA max UDMA/100 cmd 0xec00 ctl 0xe880 bmdma 0xe400 irq 18
[    1.468155] ata2: PATA max UDMA/100 cmd 0xe800 ctl 0xe480 bmdma 0xe408 irq 18
[    1.476486] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    1.476515] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.476518] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.476520] usb usb1: Product: EHCI Host Controller
[    1.476522] usb usb1: Manufacturer: Linux 3.0.0 ehci_hcd
[    1.476524] usb usb1: SerialNumber: 0000:00:1a.0
[    1.476640] hub 1-0:1.0: USB hub found
[    1.476645] hub 1-0:1.0: 2 ports detected
[    1.476724] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    1.476749] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    1.476752] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    1.476758] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    1.476783] ehci_hcd 0000:00:1d.0: debug port 2
[    1.480723] ehci_hcd 0000:00:1d.0: cache line size of 32 is not supported
[    1.480802] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xf7ff6000
[    1.496434] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    1.496466] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    1.496470] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.496475] usb usb2: Product: EHCI Host Controller
[    1.496478] usb usb2: Manufacturer: Linux 3.0.0 ehci_hcd
[    1.496481] usb usb2: SerialNumber: 0000:00:1d.0
[    1.496566] hub 2-0:1.0: USB hub found
[    1.496570] hub 2-0:1.0: 2 ports detected
[    1.496618] ata_piix 0000:00:1f.2: version 2.13
[    1.496635] ata_piix 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.496639] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[    1.496674] ata_piix 0000:00:1f.2: setting latency timer to 64
[    1.496894] scsi2 : ata_piix
[    1.496945] scsi3 : ata_piix
[    1.498097] ata3: SATA max UDMA/133 cmd 0xbc00 ctl 0xb880 bmdma 0xb400 irq 19
[    1.498101] ata4: SATA max UDMA/133 cmd 0xb800 ctl 0xb480 bmdma 0xb408 irq 19
[    1.498117] ata_piix 0000:00:1f.5: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.498121] ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
[    1.498144] ata_piix 0000:00:1f.5: setting latency timer to 64
[    1.498296] scsi4 : ata_piix
[    1.498342] scsi5 : ata_piix
[    1.499169] ata5: SATA max UDMA/133 cmd 0xac00 ctl 0xa880 bmdma 0xa400 irq 19
[    1.499172] ata6: SATA max UDMA/133 cmd 0xa800 ctl 0xa480 bmdma 0xa408 irq 19
[    1.755712] Refined TSC clocksource calibration: 2925.999 MHz.
[    1.755718] Switching to clocksource tsc
[    1.787626] usb 1-1: new high speed USB device number 2 using ehci_hcd
[    1.826133] ata5: SATA link down (SStatus 0 SControl 300)
[    1.836734] ata6: SATA link down (SStatus 0 SControl 300)
[    1.919655] usb 1-1: New USB device found, idVendor=8087, idProduct=0020
[    1.919660] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.919964] hub 1-1:1.0: USB hub found
[    1.920028] hub 1-1:1.0: 6 ports detected
[    2.030956] usb 2-1: new high speed USB device number 2 using ehci_hcd
[    2.162980] usb 2-1: New USB device found, idVendor=8087, idProduct=0020
[    2.162986] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.163257] hub 2-1:1.0: USB hub found
[    2.163347] hub 2-1:1.0: 8 ports detected
[    2.302252] ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.302266] ata4.01: SATA link down (SStatus 0 SControl 300)
[    2.302384] ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.302396] ata3.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.310550] ata4.00: ATA-8: ST3500418AS, CC38, max UDMA/133
[    2.310552] ata4.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    2.326433] ata4.00: configured for UDMA/133
[    2.368283] ata3.00: HPA detected: current 312579695, native 312581808
[    2.368290] ata3.00: ATA-7: ST3160815AS, 3.AAD, max UDMA/133
[    2.368294] ata3.00: 312579695 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    2.368304] ata3.01: ATAPI: TSSTcorp CDDVDW SH-S203P, SB00, max UDMA/100
[    2.434734] ata3.00: configured for UDMA/133
[    2.449904] ata3.01: configured for UDMA/100
[    2.450443] scsi 2:0:0:0: Direct-Access     ATA      ST3160815AS      3.AA PQ: 0 ANSI: 5
[    2.451250] scsi 2:0:1:0: CD-ROM            TSSTcorp CDDVDW SH-S203P  SB00 PQ: 0 ANSI: 5
[    2.451408] scsi 3:0:0:0: Direct-Access     ATA      ST3500418AS      CC38 PQ: 0 ANSI: 5
[    2.458279] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    2.458291] sd 2:0:0:0: [sda] 312579695 512-byte logical blocks: (160 GB/149 GiB)
[    2.458301] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.458377] sd 2:0:0:0: [sda] Write Protect is off
[    2.458379] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.458401] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.458403] sr 2:0:1:0: Attached scsi CD-ROM sr0
[    2.458574] sd 3:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    2.458623] sd 3:0:0:0: [sdb] Write Protect is off
[    2.458626] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.458649] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.474903] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    2.474942] sr 2:0:1:0: Attached scsi generic sg1 type 5
[    2.474978] sd 3:0:0:0: Attached scsi generic sg2 type 0
[    2.481665]  sdb: sdb1
[    2.481872] sd 3:0:0:0: [sdb] Attached SCSI disk
[    2.482764]  sda: sda1 sda2
[    2.482971] sd 2:0:0:0: [sda] Attached SCSI disk
[    3.004684] device-mapper: uevent: version 1.0.3
[    3.004752] device-mapper: ioctl: 4.20.0-ioctl (2011-02-02) initialised: dm-devel@redhat.com
[   24.784826] Intel AES-NI instructions are not detected.
[   25.664299] PM: Starting manual resume from disk
[   25.664302] PM: Hibernation image partition 254:1 present
[   25.664303] PM: Looking for hibernation image.
[   25.670751] PM: Image not found (code -22)
[   25.670752] PM: Hibernation image not present or could not be loaded.
[   25.673303] PM: Marking nosave pages: 000000000009f000 - 0000000000100000
[   25.673307] PM: Marking nosave pages: 00000000bf780000 - 0000000100000000
[   25.674236] PM: Basic memory bitmaps created
[   25.687427] PM: Basic memory bitmaps freed
[   25.727619] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: (null)
[   27.427884] udevd[381]: starting version 172
[   28.717089] input: PC Speaker as /devices/platform/pcspkr/input/input1
[   28.758833] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input2
[   28.758868] ACPI: Power Button [PWRB]
[   28.758908] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[   28.758929] ACPI: Power Button [PWRF]
[   28.800885] parport_pc 00:08: reported by Plug and Play ACPI
[   28.800934] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[   28.874567] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[   28.890537] ACPI: acpi_idle registered with cpuidle
[   28.890802] Monitor-Mwait will be used to enter C-1 state
[   28.890822] Monitor-Mwait will be used to enter C-3 state
[   28.890841] Monitor-Mwait will be used to enter C-3 state
[   28.990584] wmi: Mapper loaded
[   29.076386] [drm] Initialized drm 1.1.0 20060810
[   29.138980] nouveau 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   29.138986] nouveau 0000:01:00.0: setting latency timer to 64
[   29.139815] [drm] nouveau 0000:01:00.0: Detected an NV50 generation card (0x084200a2)
[   29.139819] checking generic (f9000000 6c0000) vs hw (d0000000 10000000)
[   29.139820] checking generic (f9000000 6c0000) vs hw (f8000000 2000000)
[   29.139822] fb: conflicting fb hw usage nouveaufb vs VESA VGA - removing generic driver
[   29.139845] Console: switching to colour dummy device 80x25
[   29.142781] [drm] nouveau 0000:01:00.0: Attempting to load BIOS image from PRAMIN
[   29.189275] [drm] nouveau 0000:01:00.0: ... appears to be valid
[   29.189278] [drm] nouveau 0000:01:00.0: BIT BIOS found
[   29.189280] [drm] nouveau 0000:01:00.0: Bios version 60.84.5e.00
[   29.189282] [drm] nouveau 0000:01:00.0: TMDS table version 2.0
[   29.189284] [drm] nouveau 0000:01:00.0: Found Display Configuration Block version 4.0
[   29.189286] [drm] nouveau 0000:01:00.0: Raw DCB entry 0: 02000300 00000028
[   29.189287] [drm] nouveau 0000:01:00.0: Raw DCB entry 1: 01000302 00000030
[   29.189289] [drm] nouveau 0000:01:00.0: Raw DCB entry 2: 04011310 00000028
[   29.189290] [drm] nouveau 0000:01:00.0: Raw DCB entry 3: 02011312 00000030
[   29.189292] [drm] nouveau 0000:01:00.0: Raw DCB entry 4: 010223f1 00c0c080
[   29.189294] [drm] nouveau 0000:01:00.0: DCB connector table: VHER 0x40 5 14 2
[   29.189296] [drm] nouveau 0000:01:00.0:   0: 0x00002030: type 0x30 idx 0 tag 0x08
[   29.189298] [drm] nouveau 0000:01:00.0:   1: 0x00001130: type 0x30 idx 1 tag 0x07
[   29.189300] [drm] nouveau 0000:01:00.0:   2: 0x00000210: type 0x10 idx 2 tag 0xff
[   29.189302] [drm] nouveau 0000:01:00.0:   3: 0x00000211: type 0x11 idx 3 tag 0xff
[   29.189304] [drm] nouveau 0000:01:00.0:   4: 0x00000213: type 0x13 idx 4 tag 0xff
[   29.189306] [drm] nouveau 0000:01:00.0: Parsing VBIOS init table 0 at offset 0xC474
[   29.212251] [drm] nouveau 0000:01:00.0: Parsing VBIOS init table 1 at offset 0xC7F8
[   29.228907] [drm] nouveau 0000:01:00.0: Parsing VBIOS init table 2 at offset 0xD248
[   29.228913] [drm] nouveau 0000:01:00.0: Parsing VBIOS init table 3 at offset 0xD33A
[   29.229972] [drm] nouveau 0000:01:00.0: Parsing VBIOS init table 4 at offset 0xD56D
[   29.229973] [drm] nouveau 0000:01:00.0: Parsing VBIOS init table at offset 0xD5D2
[   29.249766] [drm] nouveau 0000:01:00.0: 0xD5D2: Condition still not met after 20ms, skipping following opcodes
[   29.249782] [drm] nouveau 0000:01:00.0: timingset 255 does not exist
[   29.268944] [drm] nouveau 0000:01:00.0: 1 available performance level(s)
[   29.268953] [drm] nouveau 0000:01:00.0: 0: memory 720MHz core 600MHz shader 1450MHz fanspeed 100%
[   29.268972] [drm] nouveau 0000:01:00.0: c: memory 702MHz core 540MHz shader 1188MHz voltage 1320mV
[   29.269106] [TTM] Zone  kernel: Available graphics memory: 1961768 kiB.
[   29.269110] [TTM] Initializing pool allocator.
[   29.269133] [drm] nouveau 0000:01:00.0: Detected 256MiB VRAM
[   29.269143] mtrr: type mismatch for d0000000,10000000 old: write-back new: write-combining
[   29.273496] [drm] nouveau 0000:01:00.0: 512 MiB GART (aperture)
[   29.352341] [drm] nouveau 0000:01:00.0: DCB encoder 1 unknown
[   29.352343] [drm] nouveau 0000:01:00.0: TV-1 has no encoders, removing
[   29.353922] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[   29.353924] [drm] No driver support for vblank timestamp query.
[   29.527463] [drm] nouveau 0000:01:00.0: allocated 1680x1050 fb: 0x40000000, bo ffff88012db54800
[   29.527518] fbcon: nouveaufb (fb0) is primary device
[   29.568986] Console: switching to colour frame buffer device 210x65
[   29.570363] fb0: nouveaufb frame buffer device
[   29.570364] drm: registered panic notifier
[   29.570369] [drm] Initialized nouveau 0.0.16 20090420 for 0000:01:00.0 on minor 0
[   29.575827] input: ImPS/2 Logitech Wheel Mouse as /devices/platform/i8042/serio1/input/input4
[   29.605613] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   29.605670] HDA Intel 0000:00:1b.0: irq 42 for MSI/MSI-X
[   29.605700] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   29.702782] hda_codec: ALC889: BIOS auto-probing.
[   29.733099] input: HDA Intel Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input5
[   31.626249] EXT4-fs (dm-2): re-mounted. Opts: (null)
[   31.865395] EXT4-fs (dm-2): re-mounted. Opts: errors=remount-ro
[   63.432816] loop: module loaded
[   63.519300] coretemp coretemp.0: TjMax is 105 C.
[   63.519307] coretemp coretemp.0: TjMax is 105 C.
[   63.630590] f71882fg: Found f71889fg chip at 0xa00, revision 21
[   63.630890] f71882fg f71882fg.2560: Fan: 1 is in duty-cycle mode
[   63.630896] f71882fg f71882fg.2560: Fan: 2 is in duty-cycle mode
[   63.630900] f71882fg f71882fg.2560: Fan: 3 is in duty-cycle mode
[   64.094016] Adding 7811068k swap on /dev/mapper/hermione-swap.  Priority:-1 extents:1 across:7811068k 
[   65.206744] EXT4-fs (dm-3): mounted filesystem with ordered data mode. Opts: (null)
[   65.297425] EXT4-fs (dm-5): mounted filesystem with ordered data mode. Opts: (null)
[   65.396668] EXT4-fs (dm-6): mounted filesystem with ordered data mode. Opts: (null)
[   65.480211] EXT4-fs (dm-7): mounted filesystem with ordered data mode. Opts: (null)
[   66.621200] fuse init (API version 7.16)
[   70.059809] r8169 0000:02:00.0: eth0: link down
[   70.059819] r8169 0000:02:00.0: eth0: link down
[   70.060258] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   71.836612] r8169 0000:02:00.0: eth0: link up
[   71.837115] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   77.720736] Bluetooth: Core ver 2.16
[   77.720754] NET: Registered protocol family 31
[   77.720756] Bluetooth: HCI device and connection manager initialized
[   77.720758] Bluetooth: HCI socket layer initialized
[   77.720760] Bluetooth: L2CAP socket layer initialized
[   77.720815] Bluetooth: SCO socket layer initialized
[   77.781730] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   77.781733] Bluetooth: BNEP filters: protocol multicast
[   77.800132] Bluetooth: RFCOMM TTY layer initialized
[   77.800138] Bluetooth: RFCOMM socket layer initialized
[   77.800139] Bluetooth: RFCOMM ver 1.11
[   79.179467] lp0: using parport0 (interrupt-driven).
[   79.438550] ppdev: user-space parallel port driver
[   81.862034] eth0: no IPv6 routers present
[   94.136339] EXT4-fs (dm-2): re-mounted. Opts: errors=remount-ro,commit=0
[   94.139834] EXT4-fs (dm-3): re-mounted. Opts: commit=0
[   94.175883] EXT4-fs (dm-5): re-mounted. Opts: commit=0
[   94.222738] EXT4-fs (dm-6): re-mounted. Opts: commit=0
[   94.257515] EXT4-fs (dm-7): re-mounted. Opts: commit=0

--------------060309000909090102010107
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060309000909090102010107--
