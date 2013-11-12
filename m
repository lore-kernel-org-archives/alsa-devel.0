From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [snd_msnd_init] WARNING: CPU: 0 PID: 1 at
 fs/sysfs/dir.c:486 sysfs_warn_dup+0x7d/0xa0()
Date: Tue, 12 Nov 2013 08:11:04 +0800
Message-ID: <20131112001104.GA23993@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id BAF0226158C
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2013 01:11:29 +0100 (CET)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

I got this warning when booting a kernel with the attached kconfig.

[    5.073253] kobject: 'msnd-pinnacle.7' (cec33408): kobject_release, parent   (null) (delayed)
[    5.074347] kobject: 'msnd-pinnacle' (cecd4980): kobject_release, parent cf3ad9b0 (delayed)
[    5.075576] ------------[ cut here ]------------
[    5.076200] WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:486 sysfs_warn_dup+0x7d/0xa0()
[    5.077434] sysfs: cannot create duplicate filename '/bus/isa/drivers/msnd-pinnacle'
[    5.078422] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.12.0-wl-05537-gf1c1073 #242
[    5.079529] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[    5.080418]  00000000 00000000 cb857d74 c17a4989 cb857db4 cb857da4 c10944ba c1a23264
[    5.081680]  cb857dd0 00000001 c1a231f8 000001e6 c11c051d c11c051d c0025000 000001e6
[    5.083104]  c0025000 cb857dbc c109452e 00000009 cb857db4 c1a23264 cb857dd0 cb857de0
[    5.084361] Call Trace:
[    5.084745]  [<c17a4989>] dump_stack+0x4b/0x98
[    5.085463]  [<c10944ba>] warn_slowpath_common+0x7a/0xa0
[    5.086182]  [<c11c051d>] ? sysfs_warn_dup+0x7d/0xa0
[    5.086785]  [<c11c051d>] ? sysfs_warn_dup+0x7d/0xa0
[    5.087397]  [<c109452e>] warn_slowpath_fmt+0x2e/0x30
[    5.087980]  [<c11c051d>] sysfs_warn_dup+0x7d/0xa0
[    5.088621]  [<c11c0569>] sysfs_add_one+0x29/0x40
[    5.089230]  [<c11c0648>] create_dir+0x58/0xa0
[    5.089797]  [<c11c0a1d>] sysfs_create_dir_ns+0xfd/0x120
[    5.090709]  [<c12343c2>] kobject_add_internal+0xc2/0x240
[    5.091505]  [<c1179fbb>] ? kfree+0x7b/0x210
[    5.092211]  [<c1233fc2>] ? kobject_set_name_vargs+0x42/0x60
[    5.092978]  [<c123458d>] kobject_init_and_add+0x4d/0x60
[    5.093706]  [<c13e108a>] bus_add_driver+0x7a/0x200
[    5.094351]  [<c1c1c729>] ? snd_msnd_init+0x49/0x49
[    5.095085]  [<c13ebbb0>] ? isa_bus_remove+0x30/0x30
[    5.095817]  [<c1c1c729>] ? snd_msnd_init+0x49/0x49
[    5.096521]  [<c13e285f>] driver_register+0xaf/0xf0
[    5.097136]  [<c10c4492>] ? preempt_count_sub+0xf2/0x150
[    5.097795]  [<c13ebca6>] isa_register_driver+0x26/0x160
[    5.098534]  [<c1c1c6e0>] ? alsa_card_gusextreme_init+0x14/0x14
[    5.099423]  [<c17b3f20>] ? _raw_spin_unlock+0x50/0x60
[    5.100093]  [<c1c1c729>] ? snd_msnd_init+0x49/0x49
[    5.100715]  [<c1c1c73b>] snd_msnd_init+0x12/0x49
[    5.101336]  [<c1bd3bb3>] do_one_initcall+0x90/0x155
[    5.102207]  [<c10d00e0>] ? put_prev_task_fair+0x130/0x490
[    5.102891]  [<c123ecfd>] ? strlen+0xd/0x20
[    5.103490]  [<c1bd3500>] ? do_early_param+0x5e/0x7a
[    5.104164]  [<c10b4a6c>] ? parse_args+0x1ec/0x330
[    5.104746]  [<c17b3fa8>] ? _raw_spin_unlock_irqrestore+0x78/0x90
[    5.105526]  [<c1bd3e18>] kernel_init_freeable+0x1a0/0x23f
[    5.106240]  [<c1bd351c>] ? do_early_param+0x7a/0x7a
[    5.106961]  [<c179bbcb>] kernel_init+0xb/0x150
[    5.107566]  [<c17b5937>] ret_from_kernel_thread+0x1b/0x28
[    5.108356]  [<c179bbc0>] ? rest_init+0xc0/0xc0
[    5.109054] ---[ end trace f2f06bffaee363dd ]---
[    5.109705] ------------[ cut here ]------------

Thanks,
Fengguang

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-quantal-xps-3:20131112155755:i386-randconfig-x3-1112:3.12.0-wl-05537-gf1c1073:242"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.12.0-wl-05537-gf1c1073 (kbuild@xian) (gcc ve=
rsion 4.8.1 (Debian 4.8.1-8) ) #242 SMP PREEMPT Tue Nov 12 07:51:29 CST 2013
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000000fffdfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000fffe000-0x000000000fffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reser=
ved
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] Notice: NX (Execute Disable) protection cannot be enabled: n=
on-PAE kernel!
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Bochs Bochs, BIOS Bochs 01/01/2011
[    0.000000] Hypervisor detected: KVM
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn =3D 0xfffe max_arch_pfn =3D 0x100000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0080000000 mask FF80000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] found SMP MP-table at [mem 0x000fdab0-0x000fdabf] mapped at =
[c00fdab0]
[    0.000000]   mpc: fdac0-fdbe4
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] initial memory mapped: [mem 0x00000000-0x027fffff]
[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x0e000000-0x0e3fffff]
[    0.000000]  [mem 0x0e000000-0x0e3fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x08000000-0x0dffffff]
[    0.000000]  [mem 0x08000000-0x0dffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x07ffffff]
[    0.000000]  [mem 0x00100000-0x003fffff] page 4k
[    0.000000]  [mem 0x00400000-0x07ffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x0e400000-0x0fffdfff]
[    0.000000]  [mem 0x0e400000-0x0fbfffff] page 2M
[    0.000000]  [mem 0x0fc00000-0x0fffdfff] page 4k
[    0.000000] BRK [0x02314000, 0x02314fff] PGTABLE
[    0.000000] cma: CMA: reserved 28 MiB at 0c800000
[    0.000000] log_buf_len: 8388608
[    0.000000] early log buf free: 127904(97%)
[    0.000000] RAMDISK: [mem 0x0e73f000-0x0ffeffff]
[    0.000000] ACPI: RSDP 000fd920 00014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0fffe450 00034 (v01 BOCHS  BXPCRSDT 00000001 BXPC=
 00000001)
[    0.000000] ACPI: FACP 0fffff80 00074 (v01 BOCHS  BXPCFACP 00000001 BXPC=
 00000001)
[    0.000000] ACPI: DSDT 0fffe490 011A9 (v01   BXPC   BXDSDT 00000001 INTL=
 20100528)
[    0.000000] ACPI: FACS 0fffff40 00040
[    0.000000] ACPI: SSDT 0ffff7a0 00796 (v01 BOCHS  BXPCSSDT 00000001 BXPC=
 00000001)
[    0.000000] ACPI: APIC 0ffff680 00080 (v01 BOCHS  BXPCAPIC 00000001 BXPC=
 00000001)
[    0.000000] ACPI: HPET 0ffff640 00038 (v01 BOCHS  BXPCHPET 00000001 BXPC=
 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to         ffffa000 (        fee00000)
[    0.000000] 255MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 0fffe000
[    0.000000]   low ram: 0 - 0fffe000
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 0:fffd001, boot clock
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   Normal   [mem 0x01000000-0x0fffdfff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009efff]
[    0.000000]   node   0: [mem 0x00100000-0x0fffdfff]
[    0.000000] On node 0 totalpages: 65436
[    0.000000] free_area_init_node: node 0, pgdat c1b9abc0, node_mem_map ce=
53f020
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 480 pages used for memmap
[    0.000000]   Normal zone: 61438 pages, LIFO batch:15
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0xb008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to         ffffa000 (        fee00000)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC =
INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC =
INT 05
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC =
INT 09
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC =
INT 0a
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC =
INT 0b
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC =
INT 01
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC =
INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC =
INT 04
[    0.000000] ACPI: IRQ5 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC =
INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC =
INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC =
INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] ACPI: IRQ11 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC =
INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC =
INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC =
INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC =
INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffff9000 (fec00000)
[    0.000000] nr_irqs_gsi: 40
[    0.000000] e820: [mem 0x10000000-0xfeffbfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] setup_percpu: NR_CPUS:32 nr_cpumask_bits:2 nr_cpu_ids:2 nr_n=
ode_ids:1
[    0.000000] PERCPU: Embedded 332 pages/cpu @cbd68000 s1343808 r0 d16064 =
u1359872
[    0.000000] pcpu-alloc: s1343808 r0 d16064 u1359872 alloc=3D332*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1=20
[    0.000000] kvm-clock: cpu 0, msr 0:fffd001, primary cpu clock
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr bd6a9c0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 64924
[    0.000000] Kernel command line: hung_task_panic=3D1 rcutree.rcu_cpu_sta=
ll_timeout=3D100 log_buf_len=3D8M ignore_loglevel debug sched_debug apic=3D=
debug dynamic_printk sysrq_always_enabled panic=3D10  prompt_ramdisk=3D0 co=
nsole=3DttyS0,115200 console=3Dtty0 vga=3Dnormal  root=3D/dev/ram0 rw link=
=3D/kernel-tests/run-queue/kvm/i386-randconfig-x3-1112/devel-xian-i386-2013=
11120742/.vmlinuz-f1c1073ffd84889ce9a8559c17d0226c5423c424-20131112075235-2=
-xps branch=3Dlinux-devel/devel-xian-i386-201311120742 BOOT_IMAGE=3D/kernel=
/i386-randconfig-x3-1112/f1c1073ffd84889ce9a8559c17d0226c5423c424/vmlinuz-3=
=2E12.0-wl-05537-gf1c1073
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 byt=
es)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Memory: 175036K/261744K available (7897K kernel code, 1066K =
rwdata, 3136K rodata, 1884K init, 5480K bss, 86708K reserved)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xffd34000 - 0xfffff000   (2860 kB)
[    0.000000]     vmalloc : 0xd07fe000 - 0xffd32000   ( 757 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xcfffe000   ( 255 MB)
[    0.000000]       .init : 0xc1bd3000 - 0xc1daa000   (1884 kB)
[    0.000000]       .data : 0xc17b68ec - 0xc1bd2b80   (4208 kB)
[    0.000000]       .text : 0xc1000000 - 0xc17b68ec   (7898 kB)
[    0.000000] Checking if this processor honours the WP bit even in superv=
isor mode...Ok.
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]=20
[    0.000000]=20
[    0.000000]=20
[    0.000000]=20
[    0.000000] NR_IRQS:2304 nr_irqs:512 16
[    0.000000] CPU 0 irqstacks, hard=3Dcb80c000 soft=3Dcb80e000
[    0.000000] console [ttyS0] enabled
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3807 kB
[    0.000000]  per task-struct memory footprint: 1920 bytes
[    0.000000] ODEBUG: 13 of 13 active objects replaced
[    0.000000] ODEBUG: selftest passed
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Detected 2925.992 MHz processor
[    0.003000] Calibrating delay loop (skipped) preset value.. 5851.98 Bogo=
MIPS (lpj=3D2925992)
[    0.003012] pid_max: default: 32768 minimum: 301
[    0.004105] Mount-cache hash table entries: 512
[    0.005335] Initializing cgroup subsys devices
[    0.005895] Initializing cgroup subsys freezer
[    0.006018] Initializing cgroup subsys perf_event
[    0.007130] mce: CPU supports 10 MCE banks
[    0.007735] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.007735] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.007735] tlb_flushall_shift: 6
[    0.009353] Freeing SMP alternatives memory: 20K (c1daa000 - c1daf000)
[    0.014428] ACPI: Core revision 20130725
[    0.020900] ACPI: All ACPI Tables successfully acquired
[    0.021734] Getting VERSION: 50014
[    0.022018] Getting VERSION: 50014
[    0.022480] Getting ID: 0
[    0.023021] Getting ID: f000000
[    0.023447] Getting LVT0: 8700
[    0.024014] Getting LVT1: 8400
[    0.024399] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.025100] enabled ExtINT on CPU#0
[    0.027293] ENABLING IO-APIC IRQs
[    0.027689] init IO_APIC IRQs
[    0.028010]  apic 0 pin 0 not connected
[    0.028472] IOAPIC[0]: Set routing entry (0-1 -> 0x31 -> IRQ 1 Mode:0 Ac=
tive:0 Dest:1)
[    0.029040] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Ac=
tive:0 Dest:1)
[    0.030038] IOAPIC[0]: Set routing entry (0-3 -> 0x33 -> IRQ 3 Mode:0 Ac=
tive:0 Dest:1)
[    0.031036] IOAPIC[0]: Set routing entry (0-4 -> 0x34 -> IRQ 4 Mode:0 Ac=
tive:0 Dest:1)
[    0.032038] IOAPIC[0]: Set routing entry (0-5 -> 0x35 -> IRQ 5 Mode:1 Ac=
tive:0 Dest:1)
[    0.033036] IOAPIC[0]: Set routing entry (0-6 -> 0x36 -> IRQ 6 Mode:0 Ac=
tive:0 Dest:1)
[    0.034034] IOAPIC[0]: Set routing entry (0-7 -> 0x37 -> IRQ 7 Mode:0 Ac=
tive:0 Dest:1)
[    0.035038] IOAPIC[0]: Set routing entry (0-8 -> 0x38 -> IRQ 8 Mode:0 Ac=
tive:0 Dest:1)
[    0.036035] IOAPIC[0]: Set routing entry (0-9 -> 0x39 -> IRQ 9 Mode:1 Ac=
tive:0 Dest:1)
[    0.037040] IOAPIC[0]: Set routing entry (0-10 -> 0x3a -> IRQ 10 Mode:1 =
Active:0 Dest:1)
[    0.038039] IOAPIC[0]: Set routing entry (0-11 -> 0x3b -> IRQ 11 Mode:1 =
Active:0 Dest:1)
[    0.039037] IOAPIC[0]: Set routing entry (0-12 -> 0x3c -> IRQ 12 Mode:0 =
Active:0 Dest:1)
[    0.040040] IOAPIC[0]: Set routing entry (0-13 -> 0x3d -> IRQ 13 Mode:0 =
Active:0 Dest:1)
[    0.041038] IOAPIC[0]: Set routing entry (0-14 -> 0x3e -> IRQ 14 Mode:0 =
Active:0 Dest:1)
[    0.042039] IOAPIC[0]: Set routing entry (0-15 -> 0x3f -> IRQ 15 Mode:0 =
Active:0 Dest:1)
[    0.043033]  apic 0 pin 16 not connected
[    0.044008]  apic 0 pin 17 not connected
[    0.045008]  apic 0 pin 18 not connected
[    0.045524]  apic 0 pin 19 not connected
[    0.046008]  apic 0 pin 20 not connected
[    0.046494]  apic 0 pin 21 not connected
[    0.047008]  apic 0 pin 22 not connected
[    0.047494]  apic 0 pin 23 not connected
[    0.048158] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.049008] smpboot: CPU0: Intel Common KVM processor (fam: 0f, model: 0=
6, stepping: 01)
[    0.050647] Using local APIC timer interrupts.
[    0.050647] calibrating APIC timer ...
[    0.052000] ... lapic delta =3D 6249916
[    0.052000] ... PM-Timer delta =3D 357929
[    0.052000] ... PM-Timer result ok
[    0.052000] ..... delta 6249916
[    0.052000] ..... mult: 268431848
[    0.052000] ..... calibration result: 999986
[    0.052000] ..... CPU clock speed is 2927.0203 MHz.
[    0.052000] ..... host bus clock speed is 999.0986 MHz.
[    0.052146] Performance Events: unsupported Netburst CPU model 6 no PMU =
driver, software events only.
[    0.061050] ftrace: Allocated trace_printk buffers
[    0.069252] NMI watchdog: disabled (cpu0): hardware events not enabled
[    0.073266] CPU 1 irqstacks, hard=3Dcbbac000 soft=3Dcbbae000
[    0.074009] smpboot: Booting Node   0, Processors  #   1 OK
[    0.002000] Initializing CPU#1
[    0.003000] kvm-clock: cpu 1, msr 0:fffd041, secondary cpu clock
[    0.003000] masked ExtINT on CPU#1
[    0.096110] KVM setup async PF for cpu 1
[    0.096173] Brought up 2 CPUs
[    0.096180] ----------------
[    0.096181] | NMI testsuite:
[    0.096182] --------------------
[    0.096110] kvm-stealtime: cpu 1, msr beb69c0
[    0.096183]   remote IPI:  ok  |
[    0.099585]    local IPI:  ok  |
[    0.103825] --------------------
[    0.104006] Good, all   2 testcases passed! |
[    0.104580] ---------------------------------
[    0.105008] smpboot: Total of 2 processors activated (11703.96 BogoMIPS)
[    0.110833] regulator-dummy: no parameters
[    0.116816] NET: Registered protocol family 16
[    0.118671] EISA bus registered
[    0.119015] cpuidle: using governor ladder
[    0.119533] cpuidle: using governor menu
[    0.132787] ACPI: bus type PCI registered
[    0.133000] dca service started, version 1.12.1
[    0.133000] PCI: Using configuration type 1 for base access
[    0.176278] ACPI: Added _OSI(Module Device)
[    0.177042] ACPI: Added _OSI(Processor Device)
[    0.177780] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.179009] ACPI: Added _OSI(Processor Aggregator Device)
[    0.184850] ACPI: EC: Look up EC in DSDT
[    0.199927] ACPI: Interpreter enabled
[    0.200028] ACPI: (supports S0 S5)
[    0.200486] ACPI: Using IOAPIC for interrupt routing
[    0.201069] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.229646] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.230023] acpi PNP0A03:00: ACPI _OSC support notification failed, disa=
bling PCIe ASPM
[    0.231008] acpi PNP0A03:00: Unable to request _OSC control (_OSC suppor=
t mask: 0x08)
[    0.233540] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended PCI configuration space under this bridge.
[    0.234203] PCI host bridge to bus 0000:00
[    0.234768] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.235009] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.236008] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.237008] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f]
[    0.238008] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebffff=
f]
[    0.239080] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.241537] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.243820] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.248356] pci 0000:00:01.1: reg 0x20: [io  0xc1c0-0xc1cf]
[    0.251503] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.252574] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX=
4 ACPI
[    0.253023] pci 0000:00:01.3: quirk: [io  0xb100-0xb10f] claimed by PIIX=
4 SMB
[    0.255745] pci 0000:00:02.0: [1013:00b8] type 00 class 0x030000
[    0.258056] pci 0000:00:02.0: reg 0x10: [mem 0xfc000000-0xfdffffff pref]
[    0.261060] pci 0000:00:02.0: reg 0x14: [mem 0xfebf4000-0xfebf4fff]
[    0.272057] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.274511] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    0.276696] pci 0000:00:03.0: reg 0x10: [mem 0xfeba0000-0xfebbffff]
[    0.278711] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    0.286010] pci 0000:00:03.0: reg 0x30: [mem 0xfebc0000-0xfebdffff pref]
[    0.288379] pci 0000:00:04.0: [8086:2668] type 00 class 0x040300
[    0.290009] pci 0000:00:04.0: reg 0x10: [mem 0xfebf0000-0xfebf3fff]
[    0.296510] pci 0000:00:05.0: [1af4:1001] type 00 class 0x010000
[    0.298695] pci 0000:00:05.0: reg 0x10: [io  0xc040-0xc07f]
[    0.300697] pci 0000:00:05.0: reg 0x14: [mem 0xfebf5000-0xfebf5fff]
[    0.310008] pci 0000:00:06.0: [1af4:1001] type 00 class 0x010000
[    0.312009] pci 0000:00:06.0: reg 0x10: [io  0xc080-0xc0bf]
[    0.314008] pci 0000:00:06.0: reg 0x14: [mem 0xfebf6000-0xfebf6fff]
[    0.323823] pci 0000:00:07.0: [1af4:1001] type 00 class 0x010000
[    0.326009] pci 0000:00:07.0: reg 0x10: [io  0xc0c0-0xc0ff]
[    0.328014] pci 0000:00:07.0: reg 0x14: [mem 0xfebf7000-0xfebf7fff]
[    0.337725] pci 0000:00:08.0: [1af4:1001] type 00 class 0x010000
[    0.340010] pci 0000:00:08.0: reg 0x10: [io  0xc100-0xc13f]
[    0.342008] pci 0000:00:08.0: reg 0x14: [mem 0xfebf8000-0xfebf8fff]
[    0.351457] pci 0000:00:09.0: [1af4:1001] type 00 class 0x010000
[    0.353661] pci 0000:00:09.0: reg 0x10: [io  0xc140-0xc17f]
[    0.355693] pci 0000:00:09.0: reg 0x14: [mem 0xfebf9000-0xfebf9fff]
[    0.365573] pci 0000:00:0a.0: [1af4:1001] type 00 class 0x010000
[    0.367731] pci 0000:00:0a.0: reg 0x10: [io  0xc180-0xc1bf]
[    0.370009] pci 0000:00:0a.0: reg 0x14: [mem 0xfebfa000-0xfebfafff]
[    0.379061] pci 0000:00:0b.0: [8086:25ab] type 00 class 0x088000
[    0.380393] pci 0000:00:0b.0: reg 0x10: [mem 0xfebfb000-0xfebfb00f]
[    0.387205] pci_bus 0000:00: on NUMA node 0
[    0.390784] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.392135] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.393406] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.394644] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.395508] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    0.398350] ACPI: Enabled 16 GPEs in block 00 to 0F
[    0.399029] ACPI: \_SB_.PCI0: notify handler is installed
[    0.400234] Found 1 acpi root devices
[    0.403268] kobject: 'spi_txx9' (cb071180): kobject_release, parent cbba=
40b0 (delayed)
[    0.404436] Linux video capture interface: v2.00
[    0.405141] pps_core: LinuxPPS API ver. 1 registered
[    0.406006] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.407034] PTP clock support registered
[    0.408849] Advanced Linux Sound Architecture Driver Initialized.
[    0.409014] PCI: Using ACPI for IRQ routing
[    0.410013] PCI: pci_cache_line_size set to 64 bytes
[    0.411334] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.412016] e820: reserve RAM buffer [mem 0x0fffe000-0x0fffffff]
[    0.413688] Bluetooth: Core ver 2.17
[    0.414084] NET: Registered protocol family 31
[    0.414684] Bluetooth: HCI device and connection manager initialized
[    0.415024] Bluetooth: HCI socket layer initialized
[    0.416016] Bluetooth: L2CAP socket layer initialized
[    0.416694] Bluetooth: SCO socket layer initialized
[    0.417305] nfc: nfc_init: NFC Core ver 0.1
[    0.418119] NET: Registered protocol family 39
[    0.420112] HPET: 3 timers in total, 0 timers will be used for per-cpu t=
imer
[    0.423218] Switched to clocksource kvm-clock
[    0.425521] Warning: could not register annotated branches stats
[    0.472831] pnp: PnP ACPI init
[    0.473402] ACPI: bus type PNP registered
[    0.474208] IOAPIC[0]: Set routing entry (0-8 -> 0x38 -> IRQ 8 Mode:0 Ac=
tive:0 Dest:3)
[    0.475560] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.476581] IOAPIC[0]: Set routing entry (0-1 -> 0x31 -> IRQ 1 Mode:0 Ac=
tive:0 Dest:3)
[    0.477783] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.478829] IOAPIC[0]: Set routing entry (0-12 -> 0x3c -> IRQ 12 Mode:0 =
Active:0 Dest:3)
[    0.480200] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.481291] IOAPIC[0]: Set routing entry (0-6 -> 0x36 -> IRQ 6 Mode:0 Ac=
tive:0 Dest:3)
[    0.482470] pnp 00:03: [dma 2]
[    0.482989] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.483998] IOAPIC[0]: Set routing entry (0-7 -> 0x37 -> IRQ 7 Mode:0 Ac=
tive:0 Dest:3)
[    0.485213] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
[    0.486942] IOAPIC[0]: Set routing entry (0-4 -> 0x34 -> IRQ 4 Mode:0 Ac=
tive:0 Dest:3)
[    0.488294] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.490248] pnp 00:06: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.491681] pnp: PnP ACPI: found 7 devices
[    0.492285] ACPI: bus type PNP unregistered
[    0.529534] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.530340] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.531147] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.531938] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff]
[    0.532908] NET: Registered protocol family 1
[    0.533571] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.534489] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.535379] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    0.536368] pci 0000:00:02.0: Boot video device
[    0.537206] PCI: CLS 0 bytes, default 64
[    0.538811] Unpacking initramfs...
[    3.342443] Freeing initrd memory: 25284K (ce73f000 - cfff0000)
[    3.370929] DMA-API: preallocated 65536 debug entries
[    3.371592] DMA-API: debugging enabled by kernel config
[    3.372969] has_svm: not amd
[    3.373379] kvm: no hardware support
[    3.374172] Machine check injector initialized
[    3.374773] Scanning for low memory corruption every 60 seconds
[    3.376217] cryptomgr_test (29) used greatest stack depth: 7116 bytes le=
ft
[    3.379073] cryptomgr_test (36) used greatest stack depth: 7112 bytes le=
ft
[    3.380918] The force parameter has not been set to 1. The Iris poweroff=
 handler will not be installed.
[    3.382216] NatSemi SCx200 Driver
[    3.387670] fuse init (API version 7.22)
[    3.388537] msgmni has been set to 447
[    3.443125] NET: Registered protocol family 38
[    3.443736] list_sort_test: start testing list_sort()
[    3.453985] nvidiafb_setup START
[    3.455908] VIA Graphics Integration Chipset framebuffer 2.4 initializing
[    3.462694] cirrusfb 0000:00:02.0: Cirrus Logic chipset on PCI bus, RAM =
(4096 kB) at 0xfc000000
[    3.468275] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input0
[    3.470273] ACPI: Power Button [PWRF]
[    3.472721] ioatdma: Intel(R) QuickData Technology Driver 4.00
[    3.570015] r3964: Philips r3964 Driver $Revision: 1.10 $
[    3.570749] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    3.593464] 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[    3.596916] serial: Freescale lpuart driver
[    3.597569] Initializing Nozomi driver 2.1d
[    3.598304] DoubleTalk PC - not found
[    3.598751] kobject: 'dtlk' (cf240080): kobject_release, parent   (null)=
 (delayed)
[    3.599691] Applicom driver: $Id: ac.c,v 1.30 2000/03/22 16:03:57 dwmw2 =
Exp $
[    3.600618] ac.o: No PCI boards found.
[    3.601140] ac.o: For an ISA board you must supply memory and irq parame=
ters.
[    3.602224] Non-volatile memory driver v1.3
[    3.603581] telclk_interrupt =3D 0xf non-mcpbl0010 hw.
[    3.604212] kobject: 'telco_clock' (cf3ade80): kobject_release, parent  =
 (null) (delayed)
[    3.605239] smapi::smapi_init, ERROR invalid usSmapiID
[    3.605841] mwave: tp3780i::tp3780I_InitializeBoardData: Error: SMAPI is=
 not available on this machine
[    3.607030] mwave: mwavedd::mwave_init: Error: Failed to initialize boar=
d data
[    3.607961] mwave: mwavedd::mwave_init: Error: Failed to initialize
[    3.608875] SyncLink PC Card driver $Revision: 4.34 $, tty major#241
[    3.609944] kobject: 'tpm_atmel' (cf3afe80): kobject_release, parent cbb=
a40b0 (delayed)
[    3.611117] [drm] Initialized drm 1.1.0 20060810
[    3.612645] dummy-irq: no IRQ given.  Use irq=3DN
[    3.613374] Phantom Linux Driver, version n0.9.8, init OK
[    3.614267] Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Rodolfo Gi=
ometti
[    3.615413] c2port c2port0: C2 port uc added
[    3.615968] c2port c2port0: uc flash has 30 blocks x 512 bytes (15360 by=
tes total)
[    3.617742] kobject: 'i2c-htcpld' (cf3c7e80): kobject_release, parent cb=
ba40b0 (delayed)
[    3.620919] HSI/SSI char device loaded
[    3.621957] LocalTalk card not found; 220 =3D ff, 240 =3D ff.
[    3.624580] ipddp.c:v0.01 8/28/97 Bradford W. Johnson <johns393@maroon.t=
c.umn.edu>
[    3.625875] ipddp0: Appletalk-IP Encap. mode by Bradford W. Johnson <joh=
ns393@maroon.tc.umn.edu>
[    3.627324] AX.25: Z8530 SCC driver version 3.0.dl1bke
[    3.628311] mkiss: AX.25 Multikiss, Hans Albas PE1AYX
[    3.628902] YAM driver version 0.8 by F1OAT/F6FBB
[    3.630996] baycom_ser_fdx: (C) 1996-2000 Thomas Sailer, HB9JNX/AE4WA
[    3.630996] baycom_ser_fdx: version 0.10
[    3.633852] hdlcdrv: (C) 1996-2000 Thomas Sailer HB9JNX/AE4WA
[    3.634612] hdlcdrv: version 0.8
[    3.634995] baycom_ser_hdx: (C) 1996-2000 Thomas Sailer, HB9JNX/AE4WA
[    3.634995] baycom_ser_hdx: version 0.10
[    3.637668] SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=
=3D256).
[    3.638638] DLCI driver v0.35, 4 Jan 1997, mike.mclagan@linux.org.
[    3.653794] ieee802154fakelb ieee802154fakelb: added ieee802154 hardware
[    3.656215] Intel ISA PCIC probe: not found.
[    3.657052] kobject: 'i82365.0' (cec07014): kobject_release, parent   (n=
ull) (delayed)
[    3.657996] kobject: 'i82365' (cec08580): kobject_release, parent cbba40=
b0 (delayed)
[    3.659161] Databook TCIC-2 PCMCIA probe: not found.
[    3.659879] kobject: 'tcic-pcmcia' (cec08380): kobject_release, parent c=
bba40b0 (delayed)
[    3.661116] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[    3.682048] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.682909] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.805913] mousedev: PS/2 mouse device common for all mice
[    3.806776] evbug: Connected device: input0 (Power Button at LNXPWRBN/bu=
tton/input0)
[    3.808129] inport.c: Didn't find InPort mouse at 0x23c
[    3.824266] logibm.c: Didn't find Logitech busmouse at 0x23c
[    3.847886] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1
[    3.849188] evbug: Connected device: input1 (AT Translated Set 2 keyboar=
d at isa0060/serio0/input0)
[    3.851385] kobject: 'rtc-rp5c01' (cec27e80): kobject_release, parent cb=
ba40b0 (delayed)
[    3.853863] i2c-parport-light: adapter type unspecified
[    3.854755] isa i2c-pca-isa.0: Please specify I/O base
[    3.855608] kobject: 'i2c-pca-isa.0' (cb011008): kobject_release, parent=
   (null) (delayed)
[    3.856732] kobject: 'i2c-pca-isa' (cec29080): kobject_release, parent c=
f3ad9b0 (delayed)
[    3.857976] kobject: 'input2' (cec25a1c): kobject_release, parent   (nul=
l) (delayed)
[    3.859425] IR NEC protocol handler initialized
[    3.860058] IR RC5(x) protocol handler initialized
[    3.860714] IR RC6 protocol handler initialized
[    3.865337] IR SANYO protocol handler initialized
[    3.866146] pps pps0: new PPS source ktimer
[    3.866690] pps pps0: ktimer PPS source registered
[    3.867374] Driver for 1-wire Dallas network protocol.
[    3.868267] DS1WM w1 busmaster driver - (c) 2004 Szabolcs Gyurko
[    3.872629] kobject: 'twl4030_bci' (cec36980): kobject_release, parent c=
bba40b0 (delayed)
[    3.889849] w83781d: Detection failed at step 2
[    3.891210] applesmc: supported laptop not found!
[    3.891809] applesmc: driver init failed (ret=3D-19)!
[    3.892840] f71882fg: Not a Fintek device
[    3.893499] f71882fg: Not a Fintek device
[    3.895631] kobject: 'mc13783-adc' (cec41680): kobject_release, parent c=
bba40b0 (delayed)
[    3.896847] sch56xx_common: Unsupported device id: 0xff
[    3.897555] sch56xx_common: Unsupported device id: 0xff
[    3.899556] kobject: 'pcwd.0' (cec33408): kobject_release, parent   (nul=
l) (delayed)
[    3.900785] kobject: 'pcwd.1' (cec33008): kobject_release, parent   (nul=
l) (delayed)
[    3.901968] kobject: 'pcwd.2' (cec48c08): kobject_release, parent   (nul=
l) (delayed)
[    3.915593] kobject: 'pcwd' (cec43080): kobject_release, parent cf3ad9b0=
 (delayed)
[    3.916877] acquirewdt: WDT driver for Acquire single board computer ini=
tialising
[    3.918249] acquirewdt: I/O address 0x0043 already in use
[    3.918966] acquirewdt: probe of acquirewdt failed with error -5
[    3.919829] advantechwdt: WDT driver for Advantech single board computer=
 initialising
[    3.921296] advantechwdt: initialized. timeout=3D60 sec (nowayout=3D0)
[    3.922306] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
[    3.924579] sc520_wdt: cannot register miscdev on minor=3D130 (err=3D-16)
[    3.925476] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.10
[    3.926280] iTCO_vendor_support: vendor-support=3D0
[    3.926985] sc1200wdt: build 20020303
[    3.927520] sc1200wdt: io parameter must be specified
[    3.928190] kobject: 'scl200wdt' (cec49680): kobject_release, parent cbb=
ba2b0 (delayed)
[    3.929167] pc87413_wdt: Version 1.1 at io 0x2E
[    3.929721] pc87413_wdt: cannot register miscdev on minor=3D130 (err=3D-=
16)
[    3.930563] nv_tco: NV TCO WatchDog Timer Driver v0.01
[    3.931600] sbc7240_wdt: I/O address 0x0443 already in use
[    3.937724] cpu5wdt: misc_register failed
[    3.938666] smsc37b787_wdt: SMsC 37B787 watchdog component driver 1.1 in=
itialising...
[    3.940904] smsc37b787_wdt: Unable to register miscdev on minor 130
[    3.941796] w83627hf_wdt: WDT driver for the Winbond(TM) W83627HF/THF/HG=
/DHG Super I/O chip initialising
[    3.943231] w83627hf_wdt: Watchdog already running. Resetting timeout to=
 60 sec
[    3.944244] w83627hf_wdt: cannot register miscdev on minor=3D130 (err=3D=
-16)
[    3.945107] w83697ug_wdt: WDT driver for the Winbond(TM) W83697UG/UF Sup=
er I/O chip initialising
[    3.946193] w83697ug_wdt: No W83697UG/UF could be found
[    3.946825] w83877f_wdt: I/O address 0x0443 already in use
[    3.947575] w83977f_wdt: driver v1.00
[    3.948086] w83977f_wdt: cannot register miscdev on minor=3D130 (err=3D-=
16)
[    3.948938] machzwd: MachZ ZF-Logic Watchdog driver initializing
[    3.949757] machzwd: no ZF-Logic found
[    3.950274] sbc_epx_c3: cannot register miscdev on minor=3D130 (err=3D-1=
6)
[    3.951194] watchdog: Software Watchdog: cannot register miscdev on mino=
r=3D130 (err=3D-16).
[    3.952231] watchdog: Software Watchdog: a legacy watchdog module is pro=
bably present.
[    3.953485] softdog: Software Watchdog Timer: 0.08 initialized. soft_nob=
oot=3D0 soft_margin=3D60 sec soft_panic=3D0 (nowayout=3D0)
[    3.954864] Bluetooth: Virtual HCI driver ver 1.4
[    3.955622] Bluetooth: HCI UART driver ver 2.2
[    3.956223] Bluetooth: HCI BCSP protocol initialized
[    3.956839] Bluetooth: HCILL protocol initialized
[    3.957488] Bluetooth: HCI Three-wire UART (H5) protocol initialized
[    3.964582] ISDN subsystem Rev: 1.1.2.3/1.1.2.2/none/1.1.2.2/1.1.2.2
[    3.965811] CAPI 2.0 started up with major 68 (no middleware)
[    3.966595] b1isa: revision 1.1.2.3
[    3.967109] b1: revision 1.1.2.2
[    3.967598] b1pci: revision 1.1.2.2
[    3.968087] b1dma: revision 1.1.2.3
[    3.968525] b1pci: revision 1.1.2.2
[    3.969080] t1isa: revision 1.1.2.3
[    3.969703] t1pci: revision 1.1.2.2
[    3.970266] c4: revision 1.1.2.2
[    3.970672] dss1_divert module successfully installed
[    3.975545] gigaset: Driver for Gigaset 307x
[    3.976115] gigaset: Kernel CAPI interface
[    3.976935] platform eisa.0: Probing EISA bus 0
[    3.977616] platform eisa.0: EISA: Detected 0 cards
[    3.978286] lguest: mapped switcher at ffd2e000
[    3.995085] leds_ss4200: no LED devices found
[    3.995743] kobject: 'mc13xxx-led' (cecd4980): kobject_release, parent c=
bba40b0 (delayed)
[    3.997629] dcdbas dcdbas: Dell Systems Management Base Driver (version =
5.6.0-3.2)
[    3.998813] Driver for HIFN 795x crypto accelerator chip has been succes=
sfully registered.
[    4.004879] vme_pio2: No cards, skipping registration
[    4.006876] logger: created 256K log 'log_main'
[    4.011056] logger: created 256K log 'log_events'
[    4.011800] logger: created 256K log 'log_radio'
[    4.012563] logger: created 256K log 'log_system'
[    4.018044] goldfish_pdev_bus goldfish_pdev_bus: unable to reserve Goldf=
ish MMIO.
[    4.018956] goldfish_pdev_bus: probe of goldfish_pdev_bus failed with er=
ror -16
[    4.022445]  fake-fmc-carrier: mezzanine 0
[    4.034489]       Manufacturer: fake-vendor
[    4.035047]       Product name: fake-design-for-testing
[    4.035767] fmc fake-design-for-testing-f001: Driver has no ID: matches =
all
[    4.036629] fmc_write_eeprom fake-design-for-testing-f001: fmc_write_eep=
rom: no busid passed, refusing all cards
[    4.041339] fmc fake-design-for-testing-f001: Driver has no ID: matches =
all
[    4.042334] fmc_chardev fake-design-for-testing-f001: Created misc devic=
e "fake-design-for-testing-f001"
[    4.043837] isa adlib.0: please specify port
[    4.047918] kobject: 'adlib.0' (cedf0008): kobject_release, parent   (nu=
ll) (delayed)
[    4.049161] kobject: 'adlib.1' (cedf2c08): kobject_release, parent   (nu=
ll) (delayed)
[    4.050468] kobject: 'adlib.2' (cedf2808): kobject_release, parent   (nu=
ll) (delayed)
[    4.055099] kobject: 'adlib.3' (cedf2408): kobject_release, parent   (nu=
ll) (delayed)
[    4.056289] kobject: 'adlib.4' (cedf2008): kobject_release, parent   (nu=
ll) (delayed)
[    4.057440] kobject: 'adlib.5' (cedf3c08): kobject_release, parent   (nu=
ll) (delayed)
[    4.058580] kobject: 'adlib.6' (cedf3808): kobject_release, parent   (nu=
ll) (delayed)
[    4.059721] kobject: 'adlib.7' (cedf3408): kobject_release, parent   (nu=
ll) (delayed)
[    4.060782] kobject: 'adlib' (cedec380): kobject_release, parent cf3ad9b=
0 (delayed)
[    4.062073] kobject: 'cmi8330.0' (cedf3008): kobject_release, parent   (=
null) (delayed)
[    4.063253] kobject: 'cmi8330.1' (cedf4c08): kobject_release, parent   (=
null) (delayed)
[    4.064470] kobject: 'cmi8330.2' (cedf4808): kobject_release, parent   (=
null) (delayed)
[    4.065801] kobject: 'cmi8330.3' (cedf4408): kobject_release, parent   (=
null) (delayed)
[    4.081194] kobject: 'cmi8330.4' (cedf4008): kobject_release, parent   (=
null) (delayed)
[    4.082472] kobject: 'cmi8330.5' (cedf5c08): kobject_release, parent   (=
null) (delayed)
[    4.083635] kobject: 'cmi8330.6' (cedf5808): kobject_release, parent   (=
null) (delayed)
[    4.084846] kobject: 'cmi8330.7' (cedf5408): kobject_release, parent   (=
null) (delayed)
[    4.085938] kobject: 'cmi8330' (cedec280): kobject_release, parent cf3ad=
9b0 (delayed)
[    4.087254] kobject: 'opl3sa2.0' (cedf5008): kobject_release, parent   (=
null) (delayed)
[    4.088409] kobject: 'opl3sa2.1' (cedf7c08): kobject_release, parent   (=
null) (delayed)
[    4.089602] kobject: 'opl3sa2.2' (cedf7808): kobject_release, parent   (=
null) (delayed)
[    4.090887] kobject: 'opl3sa2.3' (cedf7408): kobject_release, parent   (=
null) (delayed)
[    4.092135] kobject: 'opl3sa2.4' (cedf7008): kobject_release, parent   (=
null) (delayed)
[    4.093307] kobject: 'opl3sa2.5' (cedf9c08): kobject_release, parent   (=
null) (delayed)
[    4.112546] kobject: 'opl3sa2.6' (cedf9808): kobject_release, parent   (=
null) (delayed)
[    4.113934] kobject: 'opl3sa2.7' (cedf9408): kobject_release, parent   (=
null) (delayed)
[    4.115071] kobject: 'opl3sa2' (cedec080): kobject_release, parent cf3ad=
9b0 (delayed)
[    4.116356] isa cs4231.0: please specify port
[    4.117097] kobject: 'cs4231.0' (cedf9008): kobject_release, parent   (n=
ull) (delayed)
[    4.118428] kobject: 'cs4231.1' (cedfcc08): kobject_release, parent   (n=
ull) (delayed)
[    4.119781] kobject: 'cs4231.2' (cedfc808): kobject_release, parent   (n=
ull) (delayed)
[    4.121114] kobject: 'cs4231.3' (cedfc408): kobject_release, parent   (n=
ull) (delayed)
[    4.132468] kobject: 'cs4231.4' (cedfc008): kobject_release, parent   (n=
ull) (delayed)
[    4.133850] kobject: 'cs4231.5' (cedfdc08): kobject_release, parent   (n=
ull) (delayed)
[    4.135060] kobject: 'cs4231.6' (cedfd808): kobject_release, parent   (n=
ull) (delayed)
[    4.136099] kobject: 'cs4231.7' (cedfd408): kobject_release, parent   (n=
ull) (delayed)
[    4.136969] kobject: 'cs4231' (cedfac80): kobject_release, parent cf3ad9=
b0 (delayed)
[    4.138067] kobject: 'cs4232+.0' (cedfd008): kobject_release, parent   (=
null) (delayed)
[    4.139132] kobject: 'cs4232+.1' (cedfec08): kobject_release, parent   (=
null) (delayed)
[    4.140164] kobject: 'cs4232+.2' (cedfe808): kobject_release, parent   (=
null) (delayed)
[    4.141226] kobject: 'cs4232+.3' (cedfe408): kobject_release, parent   (=
null) (delayed)
[    4.152673] psmouse serio1: hgpk: ID: 10 02 64
[    4.153254] kobject: 'cs4232+.4' (cedfe008): kobject_release, parent   (=
null) (delayed)
[    4.154673] kobject: 'cs4232+.5' (cedffc08): kobject_release, parent   (=
null) (delayed)
[    4.156103] kobject: 'cs4232+.6' (cedff808): kobject_release, parent   (=
null) (delayed)
[    4.157576] kobject: 'cs4232+.7' (cedff408): kobject_release, parent   (=
null) (delayed)
[    4.158590] kobject: 'cs4232+' (cedfab80): kobject_release, parent cf3ad=
9b0 (delayed)
[    4.159811] ALSA gus_main.c:180 gus: can't grab synth port 0x320
[    4.169186] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/=
i8042/serio1/input/input3
[    4.170331] evbug: Connected device: input3 (ImExPS/2 Generic Explorer M=
ouse at isa0060/serio1/input0)
[    4.215351] kobject: 'gusclassic.1' (cee00c08): kobject_release, parent =
  (null) (delayed)
[    4.216416] kobject: 'gusclassic.2' (cee00808): kobject_release, parent =
  (null) (delayed)
[    4.217546] kobject: 'gusclassic.3' (cee00408): kobject_release, parent =
  (null) (delayed)
[    4.218634] kobject: 'gusclassic.4' (cee00008): kobject_release, parent =
  (null) (delayed)
[    4.219687] kobject: 'gusclassic.5' (cee07c08): kobject_release, parent =
  (null) (delayed)
[    4.220774] kobject: 'gusclassic.6' (cee07808): kobject_release, parent =
  (null) (delayed)
[    4.221984] kobject: 'gusclassic.7' (cee07408): kobject_release, parent =
  (null) (delayed)
[    4.449990] tsc: Refined TSC clocksource calibration: 2927.444 MHz
[    5.054307] kobject: 'gusextreme.1' (cee09c08): kobject_release, parent =
  (null) (delayed)
[    5.055583] kobject: 'gusextreme.2' (cedf2c08): kobject_release, parent =
  (null) (delayed)
[    5.056819] kobject: 'gusextreme.3' (cedf2808): kobject_release, parent =
  (null) (delayed)
[    5.057992] kobject: 'gusextreme.4' (cedf0008): kobject_release, parent =
  (null) (delayed)
[    5.059373] kobject: 'gusextreme.5' (cedf2408): kobject_release, parent =
  (null) (delayed)
[    5.060826] kobject: 'gusextreme.6' (cedf3808): kobject_release, parent =
  (null) (delayed)
[    5.062273] kobject: 'gusextreme.7' (cedf3408): kobject_release, parent =
  (null) (delayed)
[    5.063689] kobject: 'msnd-pinnacle.0' (cedf3c08): kobject_release, pare=
nt   (null) (delayed)
[    5.065174] kobject: 'msnd-pinnacle.1' (cedf3008): kobject_release, pare=
nt   (null) (delayed)
[    5.066517] kobject: 'msnd-pinnacle.2' (cedf4c08): kobject_release, pare=
nt   (null) (delayed)
[    5.067871] kobject: 'msnd-pinnacle.3' (cedf2008): kobject_release, pare=
nt   (null) (delayed)
[    5.069198] kobject: 'msnd-pinnacle.4' (cedf4808): kobject_release, pare=
nt   (null) (delayed)
[    5.070652] kobject: 'msnd-pinnacle.5' (cec48c08): kobject_release, pare=
nt   (null) (delayed)
[    5.071976] kobject: 'msnd-pinnacle.6' (cec33008): kobject_release, pare=
nt   (null) (delayed)
[    5.073253] kobject: 'msnd-pinnacle.7' (cec33408): kobject_release, pare=
nt   (null) (delayed)
[    5.074347] kobject: 'msnd-pinnacle' (cecd4980): kobject_release, parent=
 cf3ad9b0 (delayed)
[    5.075576] ------------[ cut here ]------------
[    5.076200] WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:486 sysfs_warn_dup+=
0x7d/0xa0()
[    5.077434] sysfs: cannot create duplicate filename '/bus/isa/drivers/ms=
nd-pinnacle'
[    5.078422] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.12.0-wl-05537-gf=
1c1073 #242
[    5.079529] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[    5.080418]  00000000 00000000 cb857d74 c17a4989 cb857db4 cb857da4 c1094=
4ba c1a23264
[    5.081680]  cb857dd0 00000001 c1a231f8 000001e6 c11c051d c11c051d c0025=
000 000001e6
[    5.083104]  c0025000 cb857dbc c109452e 00000009 cb857db4 c1a23264 cb857=
dd0 cb857de0
[    5.084361] Call Trace:
[    5.084745]  [<c17a4989>] dump_stack+0x4b/0x98
[    5.085463]  [<c10944ba>] warn_slowpath_common+0x7a/0xa0
[    5.086182]  [<c11c051d>] ? sysfs_warn_dup+0x7d/0xa0
[    5.086785]  [<c11c051d>] ? sysfs_warn_dup+0x7d/0xa0
[    5.087397]  [<c109452e>] warn_slowpath_fmt+0x2e/0x30
[    5.087980]  [<c11c051d>] sysfs_warn_dup+0x7d/0xa0
[    5.088621]  [<c11c0569>] sysfs_add_one+0x29/0x40
[    5.089230]  [<c11c0648>] create_dir+0x58/0xa0
[    5.089797]  [<c11c0a1d>] sysfs_create_dir_ns+0xfd/0x120
[    5.090709]  [<c12343c2>] kobject_add_internal+0xc2/0x240
[    5.091505]  [<c1179fbb>] ? kfree+0x7b/0x210
[    5.092211]  [<c1233fc2>] ? kobject_set_name_vargs+0x42/0x60
[    5.092978]  [<c123458d>] kobject_init_and_add+0x4d/0x60
[    5.093706]  [<c13e108a>] bus_add_driver+0x7a/0x200
[    5.094351]  [<c1c1c729>] ? snd_msnd_init+0x49/0x49
[    5.095085]  [<c13ebbb0>] ? isa_bus_remove+0x30/0x30
[    5.095817]  [<c1c1c729>] ? snd_msnd_init+0x49/0x49
[    5.096521]  [<c13e285f>] driver_register+0xaf/0xf0
[    5.097136]  [<c10c4492>] ? preempt_count_sub+0xf2/0x150
[    5.097795]  [<c13ebca6>] isa_register_driver+0x26/0x160
[    5.098534]  [<c1c1c6e0>] ? alsa_card_gusextreme_init+0x14/0x14
[    5.099423]  [<c17b3f20>] ? _raw_spin_unlock+0x50/0x60
[    5.100093]  [<c1c1c729>] ? snd_msnd_init+0x49/0x49
[    5.100715]  [<c1c1c73b>] snd_msnd_init+0x12/0x49
[    5.101336]  [<c1bd3bb3>] do_one_initcall+0x90/0x155
[    5.102207]  [<c10d00e0>] ? put_prev_task_fair+0x130/0x490
[    5.102891]  [<c123ecfd>] ? strlen+0xd/0x20
[    5.103490]  [<c1bd3500>] ? do_early_param+0x5e/0x7a
[    5.104164]  [<c10b4a6c>] ? parse_args+0x1ec/0x330
[    5.104746]  [<c17b3fa8>] ? _raw_spin_unlock_irqrestore+0x78/0x90
[    5.105526]  [<c1bd3e18>] kernel_init_freeable+0x1a0/0x23f
[    5.106240]  [<c1bd351c>] ? do_early_param+0x7a/0x7a
[    5.106961]  [<c179bbcb>] kernel_init+0xb/0x150
[    5.107566]  [<c17b5937>] ret_from_kernel_thread+0x1b/0x28
[    5.108356]  [<c179bbc0>] ? rest_init+0xc0/0xc0
[    5.109054] ---[ end trace f2f06bffaee363dd ]---
[    5.109705] ------------[ cut here ]------------
[    5.110360] WARNING: CPU: 0 PID: 1 at lib/kobject.c:223 kobject_add_inte=
rnal+0x150/0x240()
[    5.111711] kobject_add_internal failed for msnd-pinnacle with -EEXIST, =
don't try to register things with the same name in the same directory.
[    5.113675] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.12.0-=
wl-05537-gf1c1073 #242
[    5.114732] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[    5.115553]  00000000 00000000 cb857df4 c17a4989 cb857e34 cb857e24 c1094=
4ba c1a2b380
[    5.116859]  cb857e50 00000001 c1a2b31c 000000df c1234450 c1234450 cec49=
680 00000000
[    5.117995]  00000000 cb857e3c c109452e 00000009 cb857e34 c1a2b380 cb857=
e50 cb857e74
[    5.119136] Call Trace:
[    5.119440]  [<c17a4989>] dump_stack+0x4b/0x98
[    5.119966]  [<c10944ba>] warn_slowpath_common+0x7a/0xa0
[    5.120664]  [<c1234450>] ? kobject_add_internal+0x150/0x240
[    5.121407]  [<c1234450>] ? kobject_add_internal+0x150/0x240
[    5.123055]  [<c109452e>] warn_slowpath_fmt+0x2e/0x30
[    5.123720]  [<c1234450>] kobject_add_internal+0x150/0x240
[    5.124488]  [<c123458d>] kobject_init_and_add+0x4d/0x60
[    5.125229]  [<c13e108a>] bus_add_driver+0x7a/0x200
[    5.125892]  [<c1c1c729>] ? snd_msnd_init+0x49/0x49
[    5.126559]  [<c13ebbb0>] ? isa_bus_remove+0x30/0x30
[    5.127264]  [<c1c1c729>] ? snd_msnd_init+0x49/0x49
[    5.127925]  [<c13e285f>] driver_register+0xaf/0xf0
[    5.128616]  [<c10c4492>] ? preempt_count_sub+0xf2/0x150
[    5.129380]  [<c13ebca6>] isa_register_driver+0x26/0x160
[    5.130137]  [<c1c1c6e0>] ? alsa_card_gusextreme_init+0x14/0x14
[    5.130828]  [<c17b3f20>] ? _raw_spin_unlock+0x50/0x60
[    5.131479]  [<c1c1c729>] ? snd_msnd_init+0x49/0x49
[    5.132256]  [<c1c1c73b>] snd_msnd_init+0x12/0x49
[    5.133060]  [<c1bd3bb3>] do_one_initcall+0x90/0x155
[    5.133733]  [<c10d00e0>] ? put_prev_task_fair+0x130/0x490
[    5.134451]  [<c123ecfd>] ? strlen+0xd/0x20
[    5.134935]  [<c1bd3500>] ? do_early_param+0x5e/0x7a
[    5.135566]  [<c10b4a6c>] ? parse_args+0x1ec/0x330
[    5.136172]  [<c17b3fa8>] ? _raw_spin_unlock_irqrestore+0x78/0x90
[    5.136910]  [<c1bd3e18>] kernel_init_freeable+0x1a0/0x23f
[    5.137633]  [<c1bd351c>] ? do_early_param+0x7a/0x7a
[    5.138312]  [<c179bbcb>] kernel_init+0xb/0x150
[    5.138941]  [<c17b5937>] ret_from_kernel_thread+0x1b/0x28
[    5.139645]  [<c179bbc0>] ? rest_init+0xc0/0xc0
[    5.140693] ---[ end trace f2f06bffaee363de ]---
[    5.141353] kobject: 'msnd-pinnacle' (cec49680): kobject_release, parent=
   (null) (delayed)
[    5.143203] ------------[ cut here ]------------
[    5.143833] WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:260 debug_print=
_object+0x8c/0xa0()
[    5.144165] ODEBUG: free active (active state 0) object type: timer_list=
 hint: delayed_work_timer_fn+0x0/0x20
[    5.144165] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.12.0-=
wl-05537-gf1c1073 #242
[    5.144165] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[    5.144165]  00000000 00000000 cb857db0 c17a4989 cb857df0 cb857de0 c1094=
4ba c1a2c7c8
[    5.144165]  cb857e0c 00000001 c1a2c808 00000104 c1248d7c c1248d7c c1a2c=
7c8 00000104
[    5.144165]  cec496c8 cb857df8 c109452e 00000009 cb857df0 c1a2c7c8 cb857=
e0c cb857e2c
[    5.144165] Call Trace:
[    5.144165]  [<c17a4989>] dump_stack+0x4b/0x98
[    5.144165]  [<c10944ba>] warn_slowpath_common+0x7a/0xa0
[    5.144165]  [<c1248d7c>] ? debug_print_object+0x8c/0xa0
[    5.144165]  [<c1248d7c>] ? debug_print_object+0x8c/0xa0
[    5.144165]  [<c109452e>] warn_slowpath_fmt+0x2e/0x30
[    5.144165]  [<c1248d7c>] debug_print_object+0x8c/0xa0
[    5.144165]  [<c10acbb0>] ? __queue_work+0x540/0x540
[    5.144165]  [<c12491f9>] __debug_check_no_obj_freed+0x99/0x1a0
[    5.144165]  [<c1249bd2>] debug_check_no_obj_freed+0x12/0x20
[    5.144165]  [<c117a021>] kfree+0xe1/0x210
[    5.144165]  [<c13e1182>] bus_add_driver+0x172/0x200
[    5.144165]  [<c13ebbb0>] ? isa_bus_remove+0x30/0x30
[    5.144165]  [<c1c1c729>] ? snd_msnd_init+0x49/0x49
[    5.144165]  [<c13e285f>] driver_register+0xaf/0xf0
[    5.144165]  [<c10c4492>] ? preempt_count_sub+0xf2/0x150
[    5.144165]  [<c13ebca6>] isa_register_driver+0x26/0x160
[    5.144165]  [<c1c1c6e0>] ? alsa_card_gusextreme_init+0x14/0x14
[    5.144165]  [<c17b3f20>] ? _raw_spin_unlock+0x50/0x60
[    5.144165]  [<c1c1c729>] ? snd_msnd_init+0x49/0x49
[    5.144165]  [<c1c1c73b>] snd_msnd_init+0x12/0x49
[    5.144165]  [<c1bd3bb3>] do_one_initcall+0x90/0x155
[    5.144165]  [<c10d00e0>] ? put_prev_task_fair+0x130/0x490
[    5.144165]  [<c123ecfd>] ? strlen+0xd/0x20
[    5.144165]  [<c1bd3500>] ? do_early_param+0x5e/0x7a
[    5.144165]  [<c10b4a6c>] ? parse_args+0x1ec/0x330
[    5.144165]  [<c17b3fa8>] ? _raw_spin_unlock_irqrestore+0x78/0x90
[    5.144165]  [<c1bd3e18>] kernel_init_freeable+0x1a0/0x23f
[    5.144165]  [<c1bd351c>] ? do_early_param+0x7a/0x7a
[    5.144165]  [<c179bbcb>] kernel_init+0xb/0x150
[    5.144165]  [<c17b5937>] ret_from_kernel_thread+0x1b/0x28
[    5.144165]  [<c179bbc0>] ? rest_init+0xc0/0xc0
[    5.144165] ---[ end trace f2f06bffaee363df ]---
[    5.175412] Error: Driver 'msnd_pinnacle' is already registered, abortin=
g...
[    5.176411] kobject: 'snd_opti92x_ad1848' (cedfab80): kobject_release, p=
arent cbbba2b0 (delayed)
[    5.177846] kobject: 'snd_opti92x_ad1848.0' (cedff408): kobject_release,=
 parent   (null) (delayed)
[    5.179044] kobject: 'snd_opti92x_ad1848' (cec49680): kobject_release, p=
arent cf3ad9b0 (delayed)
[    5.182540] kobject: 'snd_opti92x_cs4231' (cedfac80): kobject_release, p=
arent cbbba2b0 (delayed)
[    5.183877] kobject: 'snd_opti92x_cs4231.0' (cedff808): kobject_release,=
 parent   (null) (delayed)
[    5.185045] kobject: 'snd_opti92x_cs4231' (cedec080): kobject_release, p=
arent cf3ad9b0 (delayed)
[    5.186262] kobject: 'miro' (cedec280): kobject_release, parent cbbba2b0=
 (delayed)
[    5.187551] kobject: 'miro.0' (cedffc08): kobject_release, parent   (nul=
l) (delayed)
[    5.188494] kobject: 'miro' (cec43080): kobject_release, parent cf3ad9b0=
 (delayed)
[    5.189618] isa sb8.0: please specify irq
[    5.190340] kobject: 'sb8.0' (cedfe008): kobject_release, parent   (null=
) (delayed)
[    5.191673] kobject: 'sb8.1' (cedfe408): kobject_release, parent   (null=
) (delayed)
[    5.193420] kobject: 'sb8.2' (cedfe808): kobject_release, parent   (null=
) (delayed)
[    5.194675] kobject: 'sb8.3' (cedfec08): kobject_release, parent   (null=
) (delayed)
[    5.195862] kobject: 'sb8.4' (cedfd008): kobject_release, parent   (null=
) (delayed)
[    5.197070] kobject: 'sb8.5' (cedfd408): kobject_release, parent   (null=
) (delayed)
[    5.198195] kobject: 'sb8.6' (cedfd808): kobject_release, parent   (null=
) (delayed)
[    5.199401] kobject: 'sb8.7' (cedfdc08): kobject_release, parent   (null=
) (delayed)
[    5.200522] kobject: 'sb8' (cec41680): kobject_release, parent cf3ad9b0 =
(delayed)
[    5.201909] kobject: 'sb16.0' (cedfc008): kobject_release, parent   (nul=
l) (delayed)
[    5.203338] kobject: 'sb16.1' (cedfc408): kobject_release, parent   (nul=
l) (delayed)
[    5.204564] kobject: 'sb16.2' (cedfc808): kobject_release, parent   (nul=
l) (delayed)
[    5.205830] kobject: 'sb16.3' (cedfcc08): kobject_release, parent   (nul=
l) (delayed)
[    5.207181] kobject: 'sb16.4' (cedf9008): kobject_release, parent   (nul=
l) (delayed)
[    5.208506] kobject: 'sb16.5' (cedf9408): kobject_release, parent   (nul=
l) (delayed)
[    5.209766] kobject: 'sb16.6' (cedf9808): kobject_release, parent   (nul=
l) (delayed)
[    5.211112] kobject: 'sb16.7' (cedf9c08): kobject_release, parent   (nul=
l) (delayed)
[    5.212373] kobject: 'sb16' (cec36980): kobject_release, parent cf3ad9b0=
 (delayed)
[    5.213736] kobject: 'sbawe.0' (cedf7008): kobject_release, parent   (nu=
ll) (delayed)
[    5.215063] kobject: 'sbawe.1' (cedf7408): kobject_release, parent   (nu=
ll) (delayed)
[    5.216377] kobject: 'sbawe.2' (cedf7808): kobject_release, parent   (nu=
ll) (delayed)
[    5.217698] kobject: 'sbawe.3' (cedf7c08): kobject_release, parent   (nu=
ll) (delayed)
[    5.219141] kobject: 'sbawe.4' (cee00c08): kobject_release, parent   (nu=
ll) (delayed)
[    5.220488] kobject: 'sbawe.5' (cee00008): kobject_release, parent   (nu=
ll) (delayed)
[    5.221980] kobject: 'sbawe.6' (cee00408): kobject_release, parent   (nu=
ll) (delayed)
[    5.223381] kobject: 'sbawe.7' (cee07c08): kobject_release, parent   (nu=
ll) (delayed)
[    5.224528] kobject: 'sbawe' (cec27e80): kobject_release, parent cf3ad9b=
0 (delayed)
[    5.225886] kobject: 'wavefront.0' (cee07408): kobject_release, parent  =
 (null) (delayed)
[    5.227295] kobject: 'wavefront.1' (cee07808): kobject_release, parent  =
 (null) (delayed)
[    5.228617] kobject: 'wavefront.2' (cee00808): kobject_release, parent  =
 (null) (delayed)
[    5.229937] kobject: 'wavefront.3' (cedf5008): kobject_release, parent  =
 (null) (delayed)
[    5.231344] kobject: 'wavefront.4' (cedf5408): kobject_release, parent  =
 (null) (delayed)
[    5.232763] kobject: 'wavefront.5' (cedf5808): kobject_release, parent  =
 (null) (delayed)
[    5.234094] kobject: 'wavefront.6' (cedf5c08): kobject_release, parent  =
 (null) (delayed)
[    5.235487] kobject: 'wavefront.7' (cedf4008): kobject_release, parent  =
 (null) (delayed)
[    5.236710] kobject: 'wavefront' (cec08580): kobject_release, parent cf3=
ad9b0 (delayed)
[    5.237980] oprofile: using NMI interrupt.
[    5.238715] NET: Registered protocol family 26
[    5.239409] NET: Registered protocol family 15
[    5.240252] NET: Registered protocol family 4
[    5.240899] NET: Registered protocol family 5
[    5.241580] NET: Registered protocol family 9
[    5.242321] X.25 for Linux Version 0.2
[    5.242905] NET: Registered protocol family 3
[    5.243832] Bluetooth: RFCOMM TTY layer initialized
[    5.244437] Bluetooth: RFCOMM socket layer initialized
[    5.245000] Bluetooth: RFCOMM ver 1.11
[    5.245468] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    5.246043] Bluetooth: BNEP filters: protocol multicast
[    5.246601] Bluetooth: BNEP socket layer initialized
[    5.247167] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[    5.247706] Bluetooth: CMTP socket layer initialized
[    5.248241] NET4: DECnet for Linux: V.2.5.68s (C) 1995-2003 Linux DECnet=
 Project Team
[    5.249250] DECnet: Routing cache hash table of 256 buckets, 11Kbytes
[    5.250121] Bluetooth: Bind failed -22
[    5.250784] NET: Registered protocol family 12
[    5.254263] 9pnet: Installing 9P2000 support
[    5.255360] NET: Registered protocol family 37
[    5.255884] NET: Registered protocol family 36
[    5.256930] batman_adv: B.A.T.M.A.N. advanced 2013.4.0 (compatibility ve=
rsion 14) loaded
[    5.257871] mpls_gso: MPLS GSO support
[    5.259477]=20
[    5.259477] printing PIC contents
[    5.259997] ... PIC  IMR: ffff
[    5.260019] ... PIC  IRR: 1013
[    5.260837] ... PIC  ISR: 0000
[    5.261308] ... PIC ELCR: 0c00
[    5.261745] printing local APIC contents on CPU#0/0:
[    5.262284] ... APIC ID:      00000000 (0)
[    5.262284] ... APIC VERSION: 00050014
[    5.262284] ... APIC TASKPRI: 00000000 (00)
[    5.262284] ... APIC PROCPRI: 00000000
[    5.262284] ... APIC LDR: 01000000
[    5.262284] ... APIC DFR: ffffffff
[    5.262284] ... APIC SPIV: 000001ff
[    5.262284] ... APIC ISR field:
[    5.262284] 000000000000000000000000000000000000000000000000000000000000=
0000
[    5.262284] ... APIC TMR field:
[    5.262284] 000000000200000000000000000000000000000000000000000000000000=
0000
[    5.262284] ... APIC IRR field:
[    5.262284] 000000000000000000000000000000000000000000000000000000000000=
8000
[    5.262284] ... APIC ESR: 00000000
[    5.262284] ... APIC ICR: 000008fd
[    5.262284] ... APIC ICR2: 02000000
[    5.262284] ... APIC LVTT: 000000ef
[    5.262284] ... APIC LVTPC: 00010000
[    5.262284] ... APIC LVT0: 00010700
[    5.262284] ... APIC LVT1: 00000400
[    5.262284] ... APIC LVTERR: 000000fe
[    5.262284] ... APIC TMICT: 0000acde
[    5.262284] ... APIC TMCCT: 00000000
[    5.262284] ... APIC TDCR: 00000003
[    5.262284]=20
[    5.274039] number of MP IRQ sources: 15.
[    5.274500] number of IO-APIC #0 registers: 24.
[    5.275000] testing the IO APIC.......................
[    5.275650] IO APIC #0......
[    5.275967] .... register #00: 00000000
[    5.276443] .......    : physical APIC id: 00
[    5.276892] .......    : Delivery Type: 0
[    5.277334] .......    : LTS          : 0
[    5.277755] .... register #01: 00170011
[    5.278190] .......     : max redirection entries: 17
[    5.278738] .......     : PRQ implemented: 0
[    5.279236] .......     : IO APIC version: 11
[    5.279733] .... register #02: 00000000
[    5.280191] .......     : arbitration: 00
[    5.280636] .... IRQ redirection table:
[    5.281094] 1    0    0   0   0    0    0    00
[    5.281581] 0    0    0   0   0    1    1    31
[    5.282135] 0    0    0   0   0    1    1    30
[    5.282622] 0    0    0   0   0    1    1    33
[    5.283256] 1    0    0   0   0    1    1    34
[    5.283866] 1    1    0   0   0    1    1    35
[    5.284586] 0    0    0   0   0    1    1    36
[    5.285266] 0    0    0   0   0    1    1    37
[    5.285905] 0    0    0   0   0    1    1    38
[    5.287053] 0    1    0   0   0    1    1    39
[    5.287552] 1    1    0   0   0    1    1    3A
[    5.288052] 1    1    0   0   0    1    1    3B
[    5.288540] 0    0    0   0   0    1    1    3C
[    5.289047] 0    0    0   0   0    1    1    3D
[    5.289554] 0    0    0   0   0    1    1    3E
[    5.290076] 0    0    0   0   0    1    1    3F
[    5.290607] 1    0    0   0   0    0    0    00
[    5.291148] 1    0    0   0   0    0    0    00
[    5.291670] 1    0    0   0   0    0    0    00
[    5.292255] 1    0    0   0   0    0    0    00
[    5.292792] 1    0    0   0   0    0    0    00
[    5.293300] 1    0    0   0   0    0    0    00
[    5.293784] 1    0    0   0   0    0    0    00
[    5.294285] 1    0    0   0   0    0    0    00
[    5.294779] IRQ to pin mappings:
[    5.295159] IRQ0 -> 0:2
[    5.295492] IRQ1 -> 0:1
[    5.295809] IRQ3 -> 0:3
[    5.296159] IRQ4 -> 0:4
[    5.296483] IRQ5 -> 0:5
[    5.296783] IRQ6 -> 0:6
[    5.297120] IRQ7 -> 0:7
[    5.297432] IRQ8 -> 0:8
[    5.297718] IRQ9 -> 0:9
[    5.298002] IRQ10 -> 0:10
[    5.298339] IRQ11 -> 0:11
[    5.298742] IRQ12 -> 0:12
[    5.299099] IRQ13 -> 0:13
[    5.299447] IRQ14 -> 0:14
[    5.299784] IRQ15 -> 0:15
[    5.300155] .................................... done.
[    5.300728] Using IPI Shortcut mode
[    5.301479] registered taskstats version 1
[    5.303160] cryptomgr_probe (96) used greatest stack depth: 6860 bytes l=
eft
[    5.303191] Key type trusted registered
[    5.304283] Key type encrypted registered
[    5.307507] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    5.308468] ALSA device list:
[    5.308783]   No soundcards found.
[    5.313201] Freeing unused kernel memory: 1884K (c1bd3000 - c1daa000)
[    5.316591] Write protecting the kernel text: 7900k
[    5.318534] Write protecting the kernel read-only data: 3140k
[    5.356862] hostname (104) used greatest stack depth: 6672 bytes left
[    5.380492] sh (105) used greatest stack depth: 6400 bytes left
/bin/sh: /proc/self/fd/9: No such file or directory
/bin/sh: /proc/self/fd/9: No such file or directory
/bin/sh: /proc/self/fd/9: No such file or directory
[   65.514488] sh (127) used greatest stack depth: 6388 bytes left
[   65.965902] initctl (133) used greatest stack depth: 6276 bytes left
 * Asking all remaining processes to terminate...      =20
killall5[145]: mount returned non-zero exit status
killall5[145]: /proc not mounted, failed to mount.

mount: proc has wrong device number or fs type proc not supported
killall5[153]: mount returned non-zero exit status
killall5[153]: /proc not mounted, failed to mount.
 * All processes ended within 1 seconds....      =20
/etc/rc6.d/S40umountfs: line 20: /proc/mounts: No such file or directory
cat: /proc/1/maps: No such file or directory
[   68.954024] [sched_delayed] sched: RT throttling activated
cat: /proc/1/maps: No such file or directory
cat: /proc/1/maps: No such file or directory
cat: /proc/1/maps: No such file or directory
cat: /proc/1/maps: No such file or directory
cat: /proc/1/maps: No such file or directory
umount: /var/run: not mounted
umount: /var/lock: not mounted
umount: /dev/shm: not mounted
 * Will now restart
[   74.060692] Unregister pv shared memory for cpu 0
[   74.061348] Unregister pv shared memory for cpu 1
[   74.062089] no ifx modem active;
[   74.066187] reboot: Restarting system
[   74.066712] reboot: machine restart
Elapsed time: 85
qemu-system-x86_64 -cpu kvm64 -enable-kvm -kernel /kernel/i386-randconfig-x=
3-1112/f1c1073ffd84889ce9a8559c17d0226c5423c424/vmlinuz-3.12.0-wl-05537-gf1=
c1073 -append 'hung_task_panic=3D1 rcutree.rcu_cpu_stall_timeout=3D100 log_=
buf_len=3D8M ignore_loglevel debug sched_debug apic=3Ddebug dynamic_printk =
sysrq_always_enabled panic=3D10  prompt_ramdisk=3D0 console=3DttyS0,115200 =
console=3Dtty0 vga=3Dnormal  root=3D/dev/ram0 rw link=3D/kernel-tests/run-q=
ueue/kvm/i386-randconfig-x3-1112/devel-xian-i386-201311120742/.vmlinuz-f1c1=
073ffd84889ce9a8559c17d0226c5423c424-20131112075235-2-xps branch=3Dlinux-de=
vel/devel-xian-i386-201311120742 BOOT_IMAGE=3D/kernel/i386-randconfig-x3-11=
12/f1c1073ffd84889ce9a8559c17d0226c5423c424/vmlinuz-3.12.0-wl-05537-gf1c107=
3'  -initrd /kernel-tests/initrd/quantal-core-i386.cgz -m 256M -smp 2 -net =
nic,vlan=3D1,model=3De1000 -net user,vlan=3D1 -boot order=3Dnc -no-reboot -=
watchdog i6300esb -soundhw hda -drive file=3D/fs/LABEL=3DKVM/disk0-quantal-=
xps-3,media=3Ddisk,if=3Dvirtio -drive file=3D/fs/LABEL=3DKVM/disk1-quantal-=
xps-3,media=3Ddisk,if=3Dvirtio -drive file=3D/fs/LABEL=3DKVM/disk2-quantal-=
xps-3,media=3Ddisk,if=3Dvirtio -drive file=3D/fs/LABEL=3DKVM/disk3-quantal-=
xps-3,media=3Ddisk,if=3Dvirtio -drive file=3D/fs/LABEL=3DKVM/disk4-quantal-=
xps-3,media=3Ddisk,if=3Dvirtio -drive file=3D/fs/LABEL=3DKVM/disk5-quantal-=
xps-3,media=3Ddisk,if=3Dvirtio -pidfile /dev/shm/kboot/pid-quantal-xps-3 -s=
erial file:/dev/shm/kboot/serial-quantal-xps-3 -daemonize -display none -mo=
nitor null=20

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-3.12.0-wl-05537-gf1c1073"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 3.12.0 Kernel Configuration
#
# CONFIG_64BIT is not set
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_MMU=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CPU_AUTOPROBE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
# CONFIG_ZONE_DMA32 is not set
# CONFIG_AUDIT_ARCH is not set
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_X86_HT=y
CONFIG_ARCH_HWEIGHT_CFLAGS="-fcall-saved-ecx -fcall-saved-edx"
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
CONFIG_COMPILE_TEST=y
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_FHANDLE=y
# CONFIG_AUDIT is not set

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_IRQ_DOMAIN=y
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_KTIME_SCALAR=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y

#
# RCU Subsystem
#
CONFIG_TREE_PREEMPT_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_FANOUT_EXACT is not set
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_RCU_BOOST=y
CONFIG_RCU_BOOST_PRIO=1
CONFIG_RCU_BOOST_DELAY=500
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_NONE is not set
CONFIG_RCU_NOCB_CPU_ZERO=y
# CONFIG_RCU_NOCB_CPU_ALL is not set
CONFIG_IKCONFIG=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANTS_PROT_NUMA_PROT_NONE=y
CONFIG_CGROUPS=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_RESOURCE_COUNTERS is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
CONFIG_UIDGID_STRICT_TYPE_CHECKS=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_PRINTK=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_SIGNALFD is not set
# CONFIG_TIMERFD is not set
CONFIG_EVENTFD=y
# CONFIG_SHMEM is not set
# CONFIG_AIO is not set
CONFIG_PCI_QUIRKS=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_OPROFILE=y
# CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_JUMP_LABEL is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_ATTRS=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_USE_GENERIC_SMP_HELPERS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
# CONFIG_BLOCK is not set
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_MPPARSE=y
CONFIG_X86_BIGSMP=y
CONFIG_GOLDFISH=y
CONFIG_X86_EXTENDED_PLATFORM=y
CONFIG_X86_GOLDFISH=y
# CONFIG_X86_WANT_INTEL_MID is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_RDC321X is not set
# CONFIG_X86_32_NON_STANDARD is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
# CONFIG_XEN_PRIVILEGED_GUEST is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_LGUEST_GUEST is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_MEMTEST is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUMM=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS=32
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
# CONFIG_X86_ANCIENT_MCE is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=y
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
# CONFIG_MICROCODE_INTEL_EARLY is not set
# CONFIG_MICROCODE_AMD_EARLY is not set
CONFIG_MICROCODE_EARLY=y
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
# CONFIG_X86_PAE is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=999999
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_ZONE_DMA_FLAG=1
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_ZBUD is not set
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
# CONFIG_X86_PAT is not set
# CONFIG_ARCH_RANDOM is not set
# CONFIG_X86_SMAP is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
CONFIG_CC_STACKPROTECTOR=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
# CONFIG_HOTPLUG_CPU is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_PM_RUNTIME=y
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ACPI=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_CUSTOM_DSDT is not set
# CONFIG_ACPI_INITRD_TABLE_OVERRIDE is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_APEI is not set
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_MULTIPLE_DRIVERS is not set
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
CONFIG_PCI_GOMMCONFIG=y
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_CNB20LE_QUIRK=y
CONFIG_PCIEPORTBUS=y
# CONFIG_PCIEAER is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PME=y
CONFIG_PCI_MSI=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=y
CONFIG_HT_IRQ=y
CONFIG_PCI_ATS=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
# CONFIG_PCI_IOAPIC is not set
CONFIG_PCI_LABEL=y

#
# PCI host controller drivers
#
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
# CONFIG_EISA_NAMES is not set
CONFIG_SCx200=y
# CONFIG_SCx200HR_TIMER is not set
CONFIG_OLPC=y
# CONFIG_OLPC_XO15_SCI is not set
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
CONFIG_GEOS=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
CONFIG_PD6729=y
CONFIG_I82092=y
CONFIG_I82365=y
CONFIG_TCIC=y
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_HOTPLUG_PCI is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_TSI721=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
CONFIG_RAPIDIO_DMA_ENGINE=y
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=y

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=y
# CONFIG_RAPIDIO_CPS_XX is not set
# CONFIG_RAPIDIO_TSI568 is not set
CONFIG_RAPIDIO_CPS_GEN2=y
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ARCH_BINFMT_ELF_RANDOMIZE_PIE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=y
# CONFIG_COREDUMP is not set
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_SUB_POLICY=y
# CONFIG_XFRM_MIGRATE is not set
CONFIG_NET_KEY=y
# CONFIG_NET_KEY_MIGRATE is not set
# CONFIG_INET is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NETWORK_PHY_TIMESTAMPING=y
# CONFIG_NETFILTER is not set
# CONFIG_ATM is not set
CONFIG_STP=y
CONFIG_BRIDGE=y
CONFIG_HAVE_NET_DSA=y
CONFIG_NET_DSA=y
CONFIG_NET_DSA_TAG_DSA=y
# CONFIG_VLAN_8021Q is not set
CONFIG_DECNET=y
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_IPX=y
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
CONFIG_LTPC=y
# CONFIG_COPS is not set
CONFIG_IPDDP=y
CONFIG_IPDDP_ENCAP=y
CONFIG_X25=y
# CONFIG_LAPB is not set
CONFIG_PHONET=y
CONFIG_IEEE802154=y
CONFIG_MAC802154=y
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
# CONFIG_DNS_RESOLVER is not set
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_NC is not set
CONFIG_BATMAN_ADV_DEBUG=y
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_MMAP is not set
# CONFIG_NETLINK_DIAG is not set
CONFIG_NET_MPLS_GSO=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_NETPRIO_CGROUP is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
# CONFIG_AX25_DAMA_SLAVE is not set
# CONFIG_NETROM is not set
# CONFIG_ROSE is not set

#
# AX.25 network device drivers
#
CONFIG_MKISS=y
# CONFIG_6PACK is not set
# CONFIG_BPQETHER is not set
CONFIG_SCC=y
CONFIG_SCC_DELAY=y
CONFIG_SCC_TRXECHO=y
CONFIG_BAYCOM_SER_FDX=y
CONFIG_BAYCOM_SER_HDX=y
CONFIG_YAM=y
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
CONFIG_BT=y
CONFIG_BT_RFCOMM=y
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=y
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=y
# CONFIG_BT_HIDP is not set

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUART=y
# CONFIG_BT_HCIUART_H4 is not set
CONFIG_BT_HCIUART_BCSP=y
# CONFIG_BT_HCIUART_ATH3K is not set
CONFIG_BT_HCIUART_LL=y
CONFIG_BT_HCIUART_3WIRE=y
CONFIG_BT_HCIDTL1=y
CONFIG_BT_HCIBT3C=y
CONFIG_BT_HCIBLUECARD=y
# CONFIG_BT_HCIBTUART is not set
CONFIG_BT_HCIVHCI=y
CONFIG_BT_MRVL=y
CONFIG_FIB_RULES=y
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
CONFIG_RFKILL=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_REGULATOR=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=y
CONFIG_CAIF_DEBUG=y
CONFIG_CAIF_NETDEV=y
# CONFIG_CAIF_USB is not set
CONFIG_NFC=y
# CONFIG_NFC_DIGITAL is not set
# CONFIG_NFC_NCI is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_SIM=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH=""
# CONFIG_DEVTMPFS is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_PERCENTAGE=10
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
CONFIG_CMA_AREAS=7

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
CONFIG_OF=y

#
# Device Tree and Open Firmware support
#
# CONFIG_OF_SELFTEST is not set
CONFIG_OF_PROMTREE=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_MDIO=y
CONFIG_OF_PCI=y
CONFIG_OF_PCI_IRQ=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_AD525X_DPOT_SPI is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=y
# CONFIG_INTEL_MID_PTI is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
# CONFIG_ATMEL_SSC is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1780=y
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
CONFIG_DS1682=y
CONFIG_TI_DAC7512=y
CONFIG_VMWARE_BALLOON=y
CONFIG_BMP085=y
CONFIG_BMP085_I2C=y
CONFIG_BMP085_SPI=y
CONFIG_PCH_PHUB=y
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_93XX46 is not set
CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y

#
# Altera FPGA firmware download module
#
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#
CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
CONFIG_FIREWIRE_NOSY=y
# CONFIG_I2O is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
# CONFIG_NET_CORE is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#
CONFIG_CAIF_TTY=y
CONFIG_CAIF_SPI_SLAVE=y
CONFIG_CAIF_SPI_SYNC=y
CONFIG_CAIF_HSI=y
CONFIG_CAIF_VIRTIO=y
CONFIG_VHOST_NET=y
CONFIG_VHOST_RING=y
CONFIG_VHOST=y

#
# Distributed Switch Architecture drivers
#
CONFIG_NET_DSA_MV88E6XXX=y
# CONFIG_NET_DSA_MV88E6060 is not set
CONFIG_NET_DSA_MV88E6XXX_NEED_PPU=y
CONFIG_NET_DSA_MV88E6131=y
# CONFIG_NET_DSA_MV88E6123_61_65 is not set
# CONFIG_ETHERNET is not set
CONFIG_FDDI=y
CONFIG_DEFXX=y
# CONFIG_DEFXX_MMIO is not set
# CONFIG_SKFP is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y

#
# MII PHY device drivers
#
# CONFIG_AT803X_PHY is not set
CONFIG_AMD_PHY=y
CONFIG_MARVELL_PHY=y
CONFIG_DAVICOM_PHY=y
# CONFIG_QSEMI_PHY is not set
CONFIG_LXT_PHY=y
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_SMSC_PHY is not set
CONFIG_BROADCOM_PHY=y
CONFIG_BCM87XX_PHY=y
CONFIG_ICPLUS_PHY=y
CONFIG_REALTEK_PHY=y
CONFIG_NATIONAL_PHY=y
# CONFIG_STE10XP is not set
CONFIG_LSI_ET1011C_PHY=y
CONFIG_MICREL_PHY=y
# CONFIG_FIXED_PHY is not set
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_GPIO=y
CONFIG_MDIO_BUS_MUX=y
CONFIG_MDIO_BUS_MUX_GPIO=y
# CONFIG_MDIO_BUS_MUX_MMIOREG is not set
CONFIG_MICREL_KS8995MA=y
# CONFIG_PPP is not set
CONFIG_SLIP=y
CONFIG_SLHC=y
CONFIG_SLIP_COMPRESSED=y
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set
# CONFIG_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_HDLC is not set
CONFIG_DLCI=y
CONFIG_DLCI_MAX=8
# CONFIG_SDLA is not set
CONFIG_SBNI=y
CONFIG_SBNI_MULTILINE=y
CONFIG_IEEE802154_DRIVERS=y
# CONFIG_IEEE802154_FAKEHARD is not set
CONFIG_IEEE802154_FAKELB=y
# CONFIG_IEEE802154_AT86RF230 is not set
CONFIG_IEEE802154_MRF24J40=y
CONFIG_ISDN=y
CONFIG_ISDN_I4L=y
CONFIG_ISDN_AUDIO=y
# CONFIG_ISDN_TTY_FAX is not set
CONFIG_ISDN_X25=y

#
# ISDN feature submodules
#
CONFIG_ISDN_DIVERSION=y

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
# CONFIG_ISDN_DRV_HISAX is not set

#
# Active cards
#
# CONFIG_ISDN_DRV_ICN is not set
# CONFIG_ISDN_DRV_PCBIT is not set
# CONFIG_ISDN_DRV_SC is not set
# CONFIG_ISDN_DRV_ACT2000 is not set
CONFIG_ISDN_CAPI=y
# CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON is not set
CONFIG_CAPI_TRACE=y
# CONFIG_ISDN_CAPI_MIDDLEWARE is not set
CONFIG_ISDN_CAPI_CAPI20=y
CONFIG_ISDN_CAPI_CAPIDRV=y

#
# CAPI hardware drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1ISA=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=y
# CONFIG_ISDN_DRV_AVMB1_B1PCIV4 is not set
CONFIG_ISDN_DRV_AVMB1_T1ISA=y
CONFIG_ISDN_DRV_AVMB1_B1PCMCIA=y
CONFIG_ISDN_DRV_AVMB1_AVM_CS=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=y
CONFIG_ISDN_DRV_AVMB1_C4=y
# CONFIG_CAPI_EICON is not set
CONFIG_ISDN_DRV_GIGASET=y
CONFIG_GIGASET_CAPI=y
# CONFIG_GIGASET_I4L is not set
# CONFIG_GIGASET_DUMMYLL is not set
# CONFIG_GIGASET_M101 is not set
# CONFIG_GIGASET_DEBUG is not set
# CONFIG_MISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_STMPE is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_ALPS is not set
CONFIG_MOUSE_PS2_LOGIPS2PP=y
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
CONFIG_MOUSE_PS2_CYPRESS=y
# CONFIG_MOUSE_PS2_LIFEBOOK is not set
# CONFIG_MOUSE_PS2_TRACKPOINT is not set
CONFIG_MOUSE_PS2_ELANTECH=y
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_OLPC=y
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
CONFIG_MOUSE_INPORT=y
# CONFIG_MOUSE_ATIXL is not set
CONFIG_MOUSE_LOGIBM=y
# CONFIG_MOUSE_PC110PAD is not set
CONFIG_MOUSE_VSXXXAA=y
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=y
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
CONFIG_JOYSTICK_STINGER=y
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_WACOM is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_OLPC_APSP=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
CONFIG_GAMEPORT_FM801=y

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_NOZOMI=y
CONFIG_N_GSM=y
# CONFIG_TRACE_SINK is not set
# CONFIG_GOLDFISH_TTY is not set
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_CS=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DW=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=y
CONFIG_SERIAL_MAX310X=y
CONFIG_SERIAL_MFD_HSU=y
CONFIG_SERIAL_MFD_HSU_CONSOLE=y
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_OF_PLATFORM=y
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
CONFIG_SERIAL_TIMBERDALE=y
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
CONFIG_SERIAL_IFX6X60=y
CONFIG_SERIAL_PCH_UART=y
CONFIG_SERIAL_PCH_UART_CONSOLE=y
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
CONFIG_SERIAL_RP2=y
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
# CONFIG_SERIAL_ST_ASC is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_HVC_DRIVER=y
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_NVRAM=y
CONFIG_DTLK=y
CONFIG_R3964=y
CONFIG_APPLICOM=y
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=y
CONFIG_CARDMAN_4000=y
# CONFIG_CARDMAN_4040 is not set
# CONFIG_IPWIRELESS is not set
CONFIG_MWAVE=y
# CONFIG_SCx200_GPIO is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
# CONFIG_TCG_TIS is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_ST33_I2C=y
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
# CONFIG_I2C_MUX is not set
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=y
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD756_S4882=y
CONFIG_I2C_AMD8111=y
CONFIG_I2C_I801=y
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PCI=y
CONFIG_I2C_EG20T=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=y
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_PXA_PCI is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_PCA_ISA=y
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ATMEL=y
CONFIG_SPI_BCM2835=y
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_EP93XX is not set
CONFIG_SPI_GPIO=y
# CONFIG_SPI_IMX is not set
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
# CONFIG_SPI_FSL_DSPI is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_OMAP24XX is not set
# CONFIG_SPI_TI_QSPI is not set
# CONFIG_SPI_OMAP_100K is not set
CONFIG_SPI_ORION=y
CONFIG_SPI_PXA2XX_DMA=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_SC18IS602=y
# CONFIG_SPI_SH is not set
# CONFIG_SPI_SH_HSPI is not set
CONFIG_SPI_TEGRA114=y
CONFIG_SPI_TEGRA20_SFLASH=y
CONFIG_SPI_TEGRA20_SLINK=y
CONFIG_SPI_TOPCLIFF_PCH=y
CONFIG_SPI_TXX9=y
CONFIG_SPI_XCOMM=y
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_DESIGNWARE is not set

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
# CONFIG_SPI_TLE62X0 is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI clients
#
CONFIG_HSI_CHAR=y

#
# PPS support
#
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=y
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
CONFIG_GPIO_DEVRES=y
CONFIG_GPIOLIB=y
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
# CONFIG_GPIO_DA9052 is not set
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers:
#
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_IT8761E is not set
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_TS5500 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_VX855=y
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_GRGPIO=y

#
# I2C GPIO expanders:
#
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_SX150X=y
# CONFIG_GPIO_STMPE is not set
CONFIG_GPIO_TPS65912=y
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
CONFIG_GPIO_ADNP=y

#
# PCI GPIO expanders:
#
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_LANGWELL=y
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_SODAVILLE is not set
CONFIG_GPIO_TIMBERDALE=y
CONFIG_GPIO_RDC321X=y

#
# SPI GPIO expanders:
#
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MCP23S08=y
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_74X164=y

#
# AC97 GPIO expanders:
#

#
# LPC GPIO expanders:
#
CONFIG_GPIO_KEMPLD=y

#
# MODULbus GPIO expanders:
#
CONFIG_GPIO_JANZ_TTL=y
CONFIG_GPIO_TPS65910=y

#
# USB GPIO expanders:
#
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
# CONFIG_W1_SLAVE_DS2413 is not set
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2760 is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_BQ27000=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=y
CONFIG_WM831X_BACKUP=y
# CONFIG_WM831X_POWER is not set
CONFIG_TEST_POWER=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_OLPC=y
CONFIG_BATTERY_SBS=y
CONFIG_BATTERY_BQ27x00=y
# CONFIG_BATTERY_BQ27X00_I2C is not set
# CONFIG_BATTERY_BQ27X00_PLATFORM is not set
CONFIG_BATTERY_DA9052=y
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_TWL4030=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_SMB347=y
# CONFIG_CHARGER_TPS65090 is not set
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_POWER_RESET is not set
CONFIG_POWER_AVS=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
CONFIG_SENSORS_ABITUGURU3=y
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_FAM15H_POWER=y
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
# CONFIG_SENSORS_DA9052_ADC is not set
# CONFIG_SENSORS_DA9055 is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_FSCHMD=y
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=y
# CONFIG_SENSORS_HTU21 is not set
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IIO_HWMON is not set
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MCP3021=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
# CONFIG_SENSORS_ADM1275 is not set
# CONFIG_SENSORS_LM25066 is not set
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_MAX16064=y
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
# CONFIG_SENSORS_ZL6100 is not set
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=y
# CONFIG_SENSORS_ADS1015 is not set
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_ADS7871=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM831X=y
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_MC13783_ADC=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_EMULATION=y
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_PKG_TEMP_THERMAL=y

#
# Texas Instruments thermal drivers
#
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_DA9052_WATCHDOG is not set
# CONFIG_DA9055_WATCHDOG is not set
CONFIG_WM831X_WATCHDOG=y
CONFIG_TWL4030_WATCHDOG=y
# CONFIG_RETU_WATCHDOG is not set
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
CONFIG_ALIM1535_WDT=y
# CONFIG_ALIM7101_WDT is not set
# CONFIG_F71808E_WDT is not set
CONFIG_SP5100_TCO=y
CONFIG_SC520_WDT=y
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
CONFIG_IBMASR=y
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
CONFIG_IE6XX_WDT=y
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=y
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=y
CONFIG_SC1200_WDT=y
CONFIG_SCx200_WDT=y
CONFIG_PC87413_WDT=y
CONFIG_NV_TCO=y
# CONFIG_60XX_WDT is not set
# CONFIG_SBC8360_WDT is not set
CONFIG_SBC7240_WDT=y
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=y
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
# CONFIG_W83697HF_WDT is not set
CONFIG_W83697UG_WDT=y
CONFIG_W83877F_WDT=y
CONFIG_W83977F_WDT=y
CONFIG_MACHZ_WDT=y
CONFIG_SBC_EPX_C3_WATCHDOG=y
# CONFIG_MEN_A21_WDT is not set

#
# ISA-based Watchdog Cards
#
CONFIG_PCWATCHDOG=y
# CONFIG_MIXCOMWD is not set
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
CONFIG_WDTPCI=y
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_I2C=y
CONFIG_MFD_CROS_EC_SPI=y
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_MC13783=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RTSX_PCI is not set
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SMSC=y
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
# CONFIG_STMPE_SPI is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS65912_SPI=y
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
# CONFIG_TWL4030_MADC is not set
# CONFIG_MFD_TWL4030_AUDIO is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TMIO is not set
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=y
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_DUMMY=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_AD5398=y
# CONFIG_REGULATOR_ANATOP is not set
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8907=y
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX8973=y
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
# CONFIG_REGULATOR_PCF50633 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65090=y
CONFIG_REGULATOR_TPS65217=y
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TPS80031=y
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_WM831X=y
# CONFIG_REGULATOR_WM8400 is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_RC_SUPPORT=y
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_V4L2_INT_DEVICE=y
# CONFIG_TTPCI_EEPROM is not set

#
# Media drivers
#
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
CONFIG_RC_DECODERS=y
# CONFIG_LIRC is not set
CONFIG_IR_NEC_DECODER=y
CONFIG_IR_RC5_DECODER=y
CONFIG_IR_RC6_DECODER=y
# CONFIG_IR_JVC_DECODER is not set
# CONFIG_IR_SONY_DECODER is not set
# CONFIG_IR_RC5_SZ_DECODER is not set
CONFIG_IR_SANYO_DECODER=y
# CONFIG_IR_MCE_KBD_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_IR_ENE is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_IR_GPIO_CIR is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set

#
# Supported MMC/SDIO adapters
#

#
# Media ancillary drivers (tuners, sensors, i2c, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_VIDEO_IR_I2C=y

#
# Audio decoders, processors and mixers
#

#
# RDS decoders
#

#
# Video decoders
#

#
# Video and audio decoders
#

#
# Video encoders
#

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#

#
# Miscelaneous helper chips
#

#
# Sensors used on soc_camera driver
#
CONFIG_MEDIA_TUNER=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MC44S803=y

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set

#
# Graphics support
#
# CONFIG_AGP is not set
# CONFIG_VGA_ARB is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_TTM=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=y
CONFIG_DRM_TDFX=y
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_VIA is not set
CONFIG_DRM_SAVAGE=y
CONFIG_DRM_VMWGFX=y
# CONFIG_DRM_VMWGFX_FBCON is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=y
CONFIG_DRM_MGAG200=y
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_QXL is not set
CONFIG_VGASTATE=y
CONFIG_VIDEO_OUTPUT_CONTROL=y
CONFIG_HDMI=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=y
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=y
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=y
CONFIG_FB_RIVA_I2C=y
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_RIVA_BACKLIGHT is not set
CONFIG_FB_I740=y
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_BACKLIGHT is not set
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GENERIC_LCD is not set
CONFIG_FB_ATY_GX=y
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=y
# CONFIG_FB_S3_DDC is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
CONFIG_FB_VIA=y
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
# CONFIG_FB_PM3 is not set
CONFIG_FB_CARMINE=y
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
CONFIG_FB_GEODE=y
CONFIG_FB_GEODE_LX=y
CONFIG_FB_GEODE_GX=y
CONFIG_FB_GEODE_GX1=y
CONFIG_FB_TMIO=y
CONFIG_FB_TMIO_ACCELL=y
# CONFIG_FB_SM501 is not set
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y
CONFIG_FB_BROADSHEET=y
CONFIG_FB_AUO_K190X=y
CONFIG_FB_AUO_K1900=y
# CONFIG_FB_AUO_K1901 is not set
CONFIG_FB_SIMPLE=y
CONFIG_EXYNOS_VIDEO=y
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=y
CONFIG_LCD_LMS283GF05=y
# CONFIG_LCD_LTV350QV is not set
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
# CONFIG_LCD_TDO24M is not set
CONFIG_LCD_VGG2432A4=y
CONFIG_LCD_PLATFORM=y
# CONFIG_LCD_S6E63M0 is not set
CONFIG_LCD_LD9040=y
CONFIG_LCD_AMS369FG06=y
CONFIG_LCD_LMS501KF03=y
CONFIG_LCD_HX8357=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=y
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_WM831X=y
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_AAT2870 is not set
CONFIG_BACKLIGHT_LM3630=y
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_PANDORA=y
CONFIG_BACKLIGHT_TPS65217=y
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
# CONFIG_LOGO is not set
# CONFIG_FB_SSD1307 is not set
CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_PCM_OSS_PLUGINS=y
# CONFIG_SND_HRTIMER is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_RAWMIDI_SEQ is not set
# CONFIG_SND_OPL3_LIB_SEQ is not set
# CONFIG_SND_OPL4_LIB_SEQ is not set
# CONFIG_SND_SBAWE_SEQ is not set
# CONFIG_SND_EMU10K1_SEQ is not set
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_OPL4_LIB=y
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_WSS_LIB=y
CONFIG_SND_SB_COMMON=y
CONFIG_SND_SB8_DSP=y
CONFIG_SND_SB16_DSP=y
CONFIG_SND_ISA=y
CONFIG_SND_ADLIB=y
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT1605 is not set
# CONFIG_SND_AZT2316 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8328 is not set
CONFIG_SND_CMI8330=y
CONFIG_SND_CS4231=y
CONFIG_SND_CS4236=y
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_SC6000 is not set
CONFIG_SND_GUSCLASSIC=y
CONFIG_SND_GUSEXTREME=y
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_JAZZ16 is not set
CONFIG_SND_OPL3SA2=y
CONFIG_SND_OPTI92X_AD1848=y
CONFIG_SND_OPTI92X_CS4231=y
# CONFIG_SND_OPTI93X is not set
CONFIG_SND_MIRO=y
CONFIG_SND_SB8=y
CONFIG_SND_SB16=y
CONFIG_SND_SBAWE=y
CONFIG_SND_SB16_CSP=y
# CONFIG_SND_SSCAPE is not set
CONFIG_SND_WAVEFRONT=y
CONFIG_SND_MSND_PINNACLE=y
CONFIG_SND_MSND_CLASSIC=y
# CONFIG_SND_PCI is not set
# CONFIG_SND_SPI is not set
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=y
CONFIG_SND_FIREWIRE_SPEAKERS=y
# CONFIG_SND_ISIGHT is not set
# CONFIG_SND_SCS1X is not set
# CONFIG_SND_PCMCIA is not set
# CONFIG_SND_SOC is not set
# CONFIG_SOUND_PRIME is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=y
CONFIG_HID_PRODIKEYS=y
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=y
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
CONFIG_HID_GYRATION=y
# CONFIG_HID_ICADE is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=y
CONFIG_LOGITECH_FF=y
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=y
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_WACOM=y
CONFIG_HID_WIIMOTE=y
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=y

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_OMAP_CONTROL_USB is not set
# CONFIG_OMAP_USB3 is not set
# CONFIG_AM335X_PHY_USB is not set
# CONFIG_SAMSUNG_USB2PHY is not set
# CONFIG_SAMSUNG_USB3PHY is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_RCAR_GEN2_PHY is not set
# CONFIG_USB_GADGET is not set
# CONFIG_UWB is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
CONFIG_MEMSTICK_JMICRON_38X=y
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y

#
# LED drivers
#
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=y
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_BLINKM=y

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_MAX8907 is not set
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF2127=y
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=y
# CONFIG_RTC_DRV_M41T80 is not set
CONFIG_RTC_DRV_BQ32K=y
# CONFIG_RTC_DRV_TWL4030 is not set
# CONFIG_RTC_DRV_TPS65910 is not set
CONFIG_RTC_DRV_TPS80031=y
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
CONFIG_RTC_DRV_EM3027=y
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=y
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1305 is not set
CONFIG_RTC_DRV_DS1390=y
# CONFIG_RTC_DRV_MAX6902 is not set
CONFIG_RTC_DRV_R9701=y
CONFIG_RTC_DRV_RS5C348=y
CONFIG_RTC_DRV_DS3234=y
# CONFIG_RTC_DRV_PCF2123 is not set
CONFIG_RTC_DRV_RX4581=y

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DA9052=y
CONFIG_RTC_DRV_DA9055=y
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=y
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_WM831X=y
CONFIG_RTC_DRV_PCF50633=y

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_MC13XXX is not set
CONFIG_RTC_DRV_SNVS=y
CONFIG_RTC_DRV_MOXART=y

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
# CONFIG_INTEL_MID_DMAC is not set
CONFIG_INTEL_IOATDMA=y
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set
CONFIG_TIMB_DMA=y
# CONFIG_PCH_DMA is not set
CONFIG_DMA_ENGINE=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y

#
# DMA Clients
#
CONFIG_NET_DMA=y
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DCA=y
CONFIG_AUXDISPLAY=y
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=y
CONFIG_UIO_AEC=y
CONFIG_UIO_SERCOS3=y
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_MF624=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO=y

#
# Virtio drivers
#
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_MMIO=y
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
CONFIG_STAGING=y
# CONFIG_ET131X is not set
CONFIG_SLICOSS=y
CONFIG_ECHO=y
CONFIG_FB_OLPC_DCON=y
CONFIG_FB_OLPC_DCON_1_5=y
CONFIG_DX_SEP=y

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16204 is not set
CONFIG_ADIS16209=y
CONFIG_ADIS16220=y
# CONFIG_ADIS16240 is not set
# CONFIG_LIS3L02DQ is not set
CONFIG_SCA3000=y

#
# Analog to digital converters
#
# CONFIG_AD7291 is not set
CONFIG_AD7606=y
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD7606_IFACE_SPI=y
CONFIG_AD799X=y
CONFIG_AD799X_RING_BUFFER=y
CONFIG_AD7780=y
CONFIG_AD7816=y
CONFIG_AD7192=y
# CONFIG_AD7280 is not set
# CONFIG_LPC32XX_ADC is not set
# CONFIG_MXS_LRADC is not set
# CONFIG_SPEAR_ADC is not set

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
CONFIG_ADT7316_SPI=y
# CONFIG_ADT7316_I2C is not set

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7152 is not set
CONFIG_AD7746=y

#
# Direct Digital Synthesis
#
CONFIG_AD5930=y
# CONFIG_AD9832 is not set
CONFIG_AD9834=y
CONFIG_AD9850=y
# CONFIG_AD9852 is not set
CONFIG_AD9910=y
# CONFIG_AD9951 is not set

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16060 is not set

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=y

#
# Light sensors
#
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
CONFIG_TSL2583=y
CONFIG_TSL2x7x=y

#
# Magnetometer sensors
#
# CONFIG_SENSORS_HMC5843 is not set

#
# Active energy metering IC
#
CONFIG_ADE7753=y
CONFIG_ADE7754=y
CONFIG_ADE7758=y
CONFIG_ADE7759=y
# CONFIG_ADE7854 is not set

#
# Resolver to digital converters
#
CONFIG_AD2S90=y
CONFIG_AD2S1200=y
CONFIG_AD2S1210=y

#
# Triggers - standalone
#
CONFIG_IIO_PERIODIC_RTC_TRIGGER=y
# CONFIG_IIO_SIMPLE_DUMMY is not set
# CONFIG_ZSMALLOC is not set
# CONFIG_FB_SM7XX is not set
# CONFIG_CRYSTALHD is not set
CONFIG_FB_XGI=y
# CONFIG_ACPI_QUICKSTART is not set
CONFIG_FT1000=y
# CONFIG_FT1000_PCMCIA is not set

#
# Speakup console speech
#
# CONFIG_TOUCHSCREEN_CLEARPAD_TM1217 is not set
# CONFIG_TOUCHSCREEN_SYNAPTICS_I2C_RMI4 is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
CONFIG_ANDROID_LOGGER=y
# CONFIG_ANDROID_TIMED_OUTPUT is not set
CONFIG_ANDROID_LOW_MEMORY_KILLER=y
# CONFIG_ANDROID_INTF_ALARM_DEV is not set
# CONFIG_SYNC is not set
# CONFIG_NET_VENDOR_SILICOM is not set
CONFIG_DGRP=y
CONFIG_FIREWIRE_SERIAL=y
CONFIG_GOLDFISH_AUDIO=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_PCIE is not set
# CONFIG_XILLYBUS_OF is not set
# CONFIG_DGNC is not set
# CONFIG_DGAP is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_GOLDFISH_PIPE=y

#
# Hardware Spinlock drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_IOMMU_SUPPORT=y
CONFIG_OF_IOMMU=y
# CONFIG_INTEL_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_STE_MODEM_RPROC=y

#
# Rpmsg drivers
#
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y

#
# DEVFREQ Drivers
#
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_OF_EXTCON=y
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_ADC_JACK is not set
CONFIG_EXTCON_MAX77693=y
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
# CONFIG_IIO_BUFFER_CB is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2

#
# Accelerometers
#
CONFIG_BMA180=y
# CONFIG_HID_SENSOR_ACCEL_3D is not set
CONFIG_IIO_ST_ACCEL_3AXIS=y
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=y
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=y
# CONFIG_KXSD9 is not set

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
# CONFIG_AD7266 is not set
# CONFIG_AD7298 is not set
CONFIG_AD7476=y
CONFIG_AD7791=y
CONFIG_AD7793=y
CONFIG_AD7887=y
# CONFIG_AD7923 is not set
CONFIG_EXYNOS_ADC=y
CONFIG_MAX1363=y
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
CONFIG_NAU7802=y
# CONFIG_TI_ADC081C is not set
CONFIG_TI_AM335X_ADC=y
CONFIG_TWL6030_GPADC=y

#
# Amplifiers
#
# CONFIG_AD8366 is not set

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
# CONFIG_HID_SENSOR_ENUM_BASE_QUIRKS is not set
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
# CONFIG_AD5360 is not set
CONFIG_AD5380=y
CONFIG_AD5421=y
CONFIG_AD5446=y
# CONFIG_AD5449 is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
CONFIG_AD5686=y
# CONFIG_AD5755 is not set
# CONFIG_AD5764 is not set
CONFIG_AD5791=y
# CONFIG_AD7303 is not set
CONFIG_MAX517=y
CONFIG_MCP4725=y

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=y

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
# CONFIG_ADIS16130 is not set
CONFIG_ADIS16136=y
# CONFIG_ADIS16260 is not set
CONFIG_ADXRS450=y
CONFIG_HID_SENSOR_GYRO_3D=y
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=y

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16480 is not set
CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y
# CONFIG_INV_MPU6050_IIO is not set

#
# Light sensors
#
# CONFIG_ADJD_S311 is not set
# CONFIG_APDS9300 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
CONFIG_HID_SENSOR_ALS=y
# CONFIG_SENSORS_LM3533 is not set
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=y
# CONFIG_TSL4531 is not set
CONFIG_VCNL4000=y

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
# CONFIG_IIO_ST_MAGN_3AXIS is not set

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Pressure sensors
#
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_IIO_ST_PRESS_SPI=y

#
# Temperature sensors
#
CONFIG_TMP006=y
# CONFIG_NTB is not set
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=y
# CONFIG_VME_TSI148 is not set

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=y

#
# VME Device Drivers
#
# CONFIG_VME_USER is not set
CONFIG_VME_PIO2=y
# CONFIG_PWM is not set
CONFIG_IRQCHIP=y
# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
# CONFIG_FMC_TRIVIAL is not set
CONFIG_FMC_WRITE_EEPROM=y
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_PHY_EXYNOS_MIPI_VIDEO is not set
# CONFIG_PHY_EXYNOS_DP_VIDEO is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DELL_RBU=y
CONFIG_DCDBAS=y
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_GOOGLE_FIRMWARE=y

#
# Google Firmware Drivers
#
# CONFIG_GOOGLE_SMI is not set
# CONFIG_GOOGLE_MEMCONSOLE is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_FS_POSIX_ACL is not set
CONFIG_EXPORTFS=y
# CONFIG_FILE_LOCKING is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
# CONFIG_QUOTACTL is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=y
CONFIG_CUSE=y

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# Pseudo filesystems
#
# CONFIG_PROC_FS is not set
CONFIG_SYSFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_CONFIGFS_FS is not set
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
# CONFIG_PSTORE is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NCP_FS=y
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
CONFIG_NCPFS_STRONG=y
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
# CONFIG_NLS_UTF8 is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_DEFAULT_MESSAGE_LOGLEVEL=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_OBJECTS_WORK=y
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KMEMCHECK=y
# CONFIG_KMEMCHECK is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCKDEP=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_KOBJECT_RELEASE=y
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_WRITECOUNT is not set
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU_DELAY=y
# CONFIG_SPARSE_RCU_POINTER is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_CPU_STALL_VERBOSE=y
CONFIG_RCU_CPU_STALL_INFO=y
# CONFIG_RCU_TRACE is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_FP_TEST=y
CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_FUNCTION_TRACER is not set
CONFIG_IRQSOFF_TRACER=y
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_TRACING_BRANCHES=y
CONFIG_BRANCH_TRACER=y
# CONFIG_STACK_TRACER is not set
# CONFIG_UPROBE_EVENT is not set
# CONFIG_PROBE_EVENTS is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
CONFIG_MMIOTRACE=y
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set

#
# Runtime Testing
#
CONFIG_TEST_LIST_SORT=y
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_FIREWIRE_OHCI_REMOTE_DMA is not set
CONFIG_DMA_API_DEBUG=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_STRICT_DEVMEM=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_X86_PTDUMP is not set
CONFIG_DEBUG_RODATA=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_IOMMU_STRESS=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
CONFIG_DEBUG_NMI_SELFTEST=y
CONFIG_X86_DEBUG_STATIC_CPU_HAS=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEYS_DEBUG_PROC_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_PCOMP=y
CONFIG_CRYPTO_PCOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
# CONFIG_CRYPTO_AUTHENC is not set
CONFIG_CRYPTO_ABLK_HELPER_X86=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
# CONFIG_CRYPTO_GCM is not set
CONFIG_CRYPTO_SEQIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
# CONFIG_CRYPTO_SHA512 is not set
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_586=y
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_SALSA20_586=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_TEA=y
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_ZLIB=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
CONFIG_CRYPTO_DEV_GEODE=y
CONFIG_CRYPTO_DEV_HIFN_795X=y
CONFIG_CRYPTO_DEV_HIFN_795X_RNG=y
# CONFIG_ASYMMETRIC_KEY_TYPE is not set
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_APIC_ARCHITECTURE=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
# CONFIG_KVM_INTEL is not set
CONFIG_KVM_AMD=y
# CONFIG_KVM_MMU_AUDIT is not set
CONFIG_LGUEST=y
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_IO=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
# CONFIG_XZ_DEC is not set
# CONFIG_XZ_DEC_BCJ is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=y
# CONFIG_AVERAGE is not set
CONFIG_CORDIC=y
# CONFIG_DDR is not set

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--n8g4imXOkfNTN/H1--
