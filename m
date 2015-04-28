From: Glenn Golden <gdg@zplane.com>
Subject: Re: [pulseaudio-discuss] ThinkPad T-510 audio output
 mute LED non-workingness
Date: Mon, 27 Apr 2015 18:22:59 -0600
Message-ID: <20150428002258.GL550@huh.zplane.com>
References: <20150425013937.GB550@huh.zplane.com>
 <1429974719.3937109.258484493.7D74FAC6@webmail.messagingengine.com>
 <20150426152012.GE550@huh.zplane.com>
 <s5hvbgiho2o.wl-tiwai@suse.de>
 <CAN8cciZQBRz2Ty3YRt2+3KO9v1BWef-_8FU_d_SsE87mLdgY-w@mail.gmail.com>
 <s5hh9s2gj45.wl-tiwai@suse.de>
 <20150427135859.GI550@huh.zplane.com>
 <s5ha8xt4hsa.wl-tiwai@suse.de>
 <20150427175252.GJ550@huh.zplane.com>
 <s5h618h4dac.wl-tiwai@suse.de>
Reply-To: gdg@zplane.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Qrgsu6vtpU/OV/zm"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.indra.com (smtp.indra.com [209.169.0.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E1712614CA
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 02:23:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h618h4dac.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Alex Hung <alex.hung@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Raymond Yau <superquad.vortex2@gmail.com>, bruno.mueller@gmail.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(Full dmesg output attached.)

--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg_gdg02.txt"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.19.3-ARCH-gdg02 (gdg@ga) (gcc version 4.9.2 20150304 (prerelease) (GCC) ) #2 SMP PREEMPT Mon Apr 27 17:11:28 MDT 2015
[    0.000000] Command line: root=LABEL=archroot ro   resume=UUID=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX vga=773 
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000d2000-0x00000000000d3fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000dc000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bb27bfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bb27c000-0x00000000bb281fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bb282000-0x00000000bb35efff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bb35f000-0x00000000bb370fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bb371000-0x00000000bb3f1fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bb3f2000-0x00000000bb40efff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bb40f000-0x00000000bb46efff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bb46f000-0x00000000bb667fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bb668000-0x00000000bb6e7fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bb6e8000-0x00000000bb70efff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bb70f000-0x00000000bb716fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bb717000-0x00000000bb71efff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bb71f000-0x00000000bb76bfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bb76c000-0x00000000bb777fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bb778000-0x00000000bb77afff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bb77b000-0x00000000bb78afff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bb78b000-0x00000000bb78bfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bb78c000-0x00000000bb79efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bb79f000-0x00000000bb7fefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bb7ff000-0x00000000bb7fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bb800000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feaff000-0x00000000feafffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed003ff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000137ffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.6 present.
[    0.000000] DMI: LENOVO 4314DPU/4314DPU, BIOS 6MET81WW (1.41 ) 10/26/2010
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn = 0x138000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-D3FFF write-protect
[    0.000000]   D4000-DBFFF uncachable
[    0.000000]   DC000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 disabled
[    0.000000]   1 base 000000000 mask F80000000 write-back
[    0.000000]   2 base 080000000 mask FC0000000 write-back
[    0.000000]   3 base 100000000 mask FC0000000 write-back
[    0.000000]   4 base 138000000 mask FF8000000 uncachable
[    0.000000]   5 base 0BC000000 mask FFC000000 uncachable
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
[    0.000000] e820: update [mem 0xbc000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xbb800 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000f68b0-0x000f68bf] mapped at [ffff8800000f68b0]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01b32000, 0x01b32fff] PGTABLE
[    0.000000] BRK [0x01b33000, 0x01b33fff] PGTABLE
[    0.000000] BRK [0x01b34000, 0x01b34fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x137e00000-0x137ffffff]
[    0.000000]  [mem 0x137e00000-0x137ffffff] page 2M
[    0.000000] BRK [0x01b35000, 0x01b35fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x120000000-0x137dfffff]
[    0.000000]  [mem 0x120000000-0x137dfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x100000000-0x11fffffff]
[    0.000000]  [mem 0x100000000-0x11fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0xbb27bfff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0xbb1fffff] page 2M
[    0.000000]  [mem 0xbb200000-0xbb27bfff] page 4k
[    0.000000] init_memory_mapping: [mem 0xbb282000-0xbb35efff]
[    0.000000]  [mem 0xbb282000-0xbb35efff] page 4k
[    0.000000] init_memory_mapping: [mem 0xbb40f000-0xbb46efff]
[    0.000000]  [mem 0xbb40f000-0xbb46efff] page 4k
[    0.000000] BRK [0x01b36000, 0x01b36fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0xbb70f000-0xbb716fff]
[    0.000000]  [mem 0xbb70f000-0xbb716fff] page 4k
[    0.000000] BRK [0x01b37000, 0x01b37fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0xbb71f000-0xbb76bfff]
[    0.000000]  [mem 0xbb71f000-0xbb76bfff] page 4k
[    0.000000] init_memory_mapping: [mem 0xbb7ff000-0xbb7fffff]
[    0.000000]  [mem 0xbb7ff000-0xbb7fffff] page 4k
[    0.000000] RAMDISK: [mem 0x37c96000-0x37feffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F6870 000024 (v02 LENOVO)
[    0.000000] ACPI: XSDT 0x00000000BB7EF320 000094 (v01 LENOVO TP-6M    00001410  LTP 00000000)
[    0.000000] ACPI: FACP 0x00000000BB7EF400 0000F4 (v04 LENOVO TP-6M    00001410 LNVO 00000001)
[    0.000000] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Pm1aControlBlock: 16/32 (20141107/tbfadt-618)
[    0.000000] ACPI BIOS Warning (bug): Invalid length for FADT/Pm1aControlBlock: 32, using default 16 (20141107/tbfadt-699)
[    0.000000] ACPI: DSDT 0x00000000BB7EF7D1 00F310 (v01 LENOVO TP-6M    00001410 MSFT 03000001)
[    0.000000] ACPI: FACS 0x00000000BB6E7000 000040
[    0.000000] ACPI: SSDT 0x00000000BB7EF5B4 00021D (v01 LENOVO TP-6M    00001410 MSFT 03000001)
[    0.000000] ACPI: ECDT 0x00000000BB7FEAE1 000052 (v01 LENOVO TP-6M    00001410 LNVO 00000001)
[    0.000000] ACPI: APIC 0x00000000BB7FEB33 000084 (v01 LENOVO TP-6M    00001410 LNVO 00000001)
[    0.000000] ACPI: MCFG 0x00000000BB7FEBEF 00003C (v01 LENOVO TP-6M    00001410 LNVO 00000001)
[    0.000000] ACPI: HPET 0x00000000BB7FEC2B 000038 (v01 LENOVO TP-6M    00001410 LNVO 00000001)
[    0.000000] ACPI: ASF! 0x00000000BB7FEDBE 0000A4 (v16 LENOVO TP-6M    00001410 PTL  00000001)
[    0.000000] ACPI: SLIC 0x00000000BB7FEE62 000176 (v01 LENOVO TP-6M    00001410  LTP 00000000)
[    0.000000] ACPI: BOOT 0x00000000BB7FEFD8 000028 (v01 LENOVO TP-6M    00001410  LTP 00000001)
[    0.000000] ACPI: SSDT 0x00000000BB6E591A 00084B (v01 LENOVO TP-6M    00001410 INTL 20050513)
[    0.000000] ACPI: TCPA 0x00000000BB78B000 000032 (v02 PTL     CRESTLN 06040000      00005A52)
[    0.000000] ACPI: SSDT 0x00000000BB77A000 0009F1 (v01 PmRef  CpuPm    00003000 INTL 20060912)
[    0.000000] ACPI: SSDT 0x00000000BB779000 000259 (v01 PmRef  Cpu0Tst  00003000 INTL 20060912)
[    0.000000] ACPI: SSDT 0x00000000BB778000 00049F (v01 PmRef  ApTst    00003000 INTL 20060912)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x0000000137ffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x137ff9000-0x137ffcfff]
[    0.000000]  [ffffea0000000000-ffffea0004dfffff] PMD -> [ffff880133800000-ffff8801375fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x137ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009dfff]
[    0.000000]   node   0: [mem 0x00100000-0xbb27bfff]
[    0.000000]   node   0: [mem 0xbb282000-0xbb35efff]
[    0.000000]   node   0: [mem 0xbb40f000-0xbb46efff]
[    0.000000]   node   0: [mem 0xbb70f000-0xbb716fff]
[    0.000000]   node   0: [mem 0xbb71f000-0xbb76bfff]
[    0.000000]   node   0: [mem 0xbb7ff000-0xbb7fffff]
[    0.000000]   node   0: [mem 0x100000000-0x137ffffff]
[    0.000000] Initmem setup node 0 [mem 0x00001000-0x137ffffff]
[    0.000000] On node 0 totalpages: 996268
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 11921 pages used for memmap
[    0.000000]   DMA32 zone: 762895 pages, LIFO batch:31
[    0.000000]   Normal zone: 3584 pages used for memmap
[    0.000000]   Normal zone: 229376 pages, LIFO batch:31
[    0.000000] Reserving Intel graphics stolen memory at 0xbe000000-0xbfffffff
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000d1fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000d2000-0x000d3fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000d4000-0x000dbfff]
[    0.000000] PM: Registered nosave memory: [mem 0x000dc000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb27c000-0xbb281fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb35f000-0xbb370fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb371000-0xbb3f1fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb3f2000-0xbb40efff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb46f000-0xbb667fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb668000-0xbb6e7fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb6e8000-0xbb70efff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb717000-0xbb71efff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb76c000-0xbb777fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb778000-0xbb77afff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb77b000-0xbb78afff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb78b000-0xbb78bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb78c000-0xbb79efff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb79f000-0xbb7fefff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb800000-0xbfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc0000000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xfeafefff]
[    0.000000] PM: Registered nosave memory: [mem 0xfeaff000-0xfeafffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfeb00000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec10000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed8ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed90000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0xc0000000-0xdfffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 31 pages/cpu @ffff880137c00000 s86336 r8192 d32448 u524288
[    0.000000] pcpu-alloc: s86336 r8192 d32448 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 980678
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: root=LABEL=archroot ro   resume=UUID=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX vga=773 
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 3839752K/3985072K available (5534K kernel code, 917K rwdata, 1744K rodata, 1164K init, 1156K bss, 145320K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS:8448 nr_irqs:456 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2659.930 MHz processor
[    0.000030] Calibrating delay loop (skipped), value calculated using timer frequency.. 5321.52 BogoMIPS (lpj=8866433)
[    0.000037] pid_max: default: 32768 minimum: 301
[    0.000044] ACPI: Core revision 20141107
[    0.011527] ACPI: All ACPI Tables successfully acquired
[    0.018738] Security Framework initialized
[    0.018747] Yama: becoming mindful.
[    0.018975] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.020181] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.020809] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.020817] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.021046] Initializing cgroup subsys memory
[    0.021055] Initializing cgroup subsys devices
[    0.021060] Initializing cgroup subsys freezer
[    0.021064] Initializing cgroup subsys net_cls
[    0.021068] Initializing cgroup subsys blkio
[    0.021088] CPU: Physical Processor ID: 0
[    0.021091] CPU: Processor Core ID: 0
[    0.021098] mce: CPU supports 9 MCE banks
[    0.021110] CPU0: Thermal monitoring enabled (TM1)
[    0.021121] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
               Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.021208] Freeing SMP alternatives memory: 20K (ffffffff81a0a000 - ffffffff81a0f000)
[    0.021972] ftrace: allocating 21171 entries in 83 pages
[    0.031424] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.064434] smpboot: CPU0: Intel(R) Core(TM) i7 CPU       M 620  @ 2.67GHz (fam: 06, model: 25, stepping: 05)
[    0.170716] Performance Events: PEBS fmt1+, 16-deep LBR, Westmere events, Intel PMU driver.
[    0.170734] perf_event_intel: CPUID marked event: 'bus cycles' unavailable
[    0.170739] ... version:                3
[    0.170740] ... bit width:              48
[    0.170742] ... generic registers:      4
[    0.170744] ... value mask:             0000ffffffffffff
[    0.170746] ... max period:             000000007fffffff
[    0.170749] ... fixed-purpose events:   3
[    0.170751] ... event mask:             000000070000000f
[    0.190786] x86: Booting SMP configuration:
[    0.190795] .... node  #0, CPUs:      #1
[    0.204012] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.210761]  #2 #3
[    0.243921] x86: Booted up 1 node, 4 CPUs
[    0.243932] smpboot: Total of 4 processors activated (21287.08 BogoMIPS)
[    0.246439] devtmpfs: initialized
[    0.248755] PM: Registering ACPI NVS region [mem 0xbb371000-0xbb3f1fff] (528384 bytes)
[    0.248766] PM: Registering ACPI NVS region [mem 0xbb668000-0xbb6e7fff] (524288 bytes)
[    0.248775] PM: Registering ACPI NVS region [mem 0xbb76c000-0xbb777fff] (49152 bytes)
[    0.248778] PM: Registering ACPI NVS region [mem 0xbb77b000-0xbb78afff] (65536 bytes)
[    0.248782] PM: Registering ACPI NVS region [mem 0xbb78c000-0xbb79efff] (77824 bytes)
[    0.248925] pinctrl core: initialized pinctrl subsystem
[    0.248970] RTC time: 23:31:15, date: 04/27/15
[    0.249067] NET: Registered protocol family 16
[    0.260716] cpuidle: using governor ladder
[    0.274047] cpuidle: using governor menu
[    0.274081] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.274085] ACPI: bus type PCI registered
[    0.274088] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.274150] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.274156] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.274589] PCI: Using configuration type 1 for base access
[    0.287702] ACPI: Added _OSI(Module Device)
[    0.287706] ACPI: Added _OSI(Processor Device)
[    0.287708] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.287711] ACPI: Added _OSI(Processor Aggregator Device)
[    0.288886] ACPI : EC: EC description table is found, configuring boot EC
[    0.292254] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.365992] ACPI: Dynamic OEM Table Load:
[    0.366001] ACPI: SSDT 0xFFFF880132938800 0004F3 (v01 PmRef  Cpu0Ist  00003000 INTL 20060912)
[    0.366393] ACPI: Dynamic OEM Table Load:
[    0.366399] ACPI: SSDT 0xFFFF880132939000 0006B2 (v01 PmRef  Cpu0Cst  00003001 INTL 20060912)
[    0.366921] ACPI: Dynamic OEM Table Load:
[    0.366927] ACPI: SSDT 0xFFFF880132AD5000 000303 (v01 PmRef  ApIst    00003000 INTL 20060912)
[    0.367323] ACPI: Dynamic OEM Table Load:
[    0.367329] ACPI: SSDT 0xFFFF880132ACA000 000119 (v01 PmRef  ApCst    00003000 INTL 20060912)
[    0.369037] ACPI: Interpreter enabled
[    0.369044] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20141107/hwxface-580)
[    0.369051] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20141107/hwxface-580)
[    0.369065] ACPI: (supports S0 S3 S4 S5)
[    0.369068] ACPI: Using IOAPIC for interrupt routing
[    0.369089] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.374351] ACPI: Power Resource [PUBS] (on)
[    0.375083] acpi PNP0C0A:01: ACPI dock station (docks/bays count: 1)
[    0.376955] acpi LNXIOBAY:00: ACPI dock station (docks/bays count: 2)
[    0.378770] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
[    0.378842] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
[    0.378897] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
[    0.378967] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
[    0.379036] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
[    0.379105] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11)
[    0.379160] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
[    0.379231] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
[    0.379300] ACPI: PCI Root Bridge [UNCR] (domain 0000 [bus ff])
[    0.379306] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.379312] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.379355] PCI host bridge to bus 0000:ff
[    0.379359] pci_bus 0000:ff: root bus resource [bus ff]
[    0.379366] pci 0000:ff:00.0: [8086:2c62] type 00 class 0x060000
[    0.379411] pci 0000:ff:00.1: [8086:2d01] type 00 class 0x060000
[    0.379453] pci 0000:ff:02.0: [8086:2d10] type 00 class 0x060000
[    0.379489] pci 0000:ff:02.1: [8086:2d11] type 00 class 0x060000
[    0.379525] pci 0000:ff:02.2: [8086:2d12] type 00 class 0x060000
[    0.379560] pci 0000:ff:02.3: [8086:2d13] type 00 class 0x060000
[    0.379618] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.379623] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.379759] acpi PNP0A08:00: _OSC: platform does not support [PCIeCapability]
[    0.379822] acpi PNP0A08:00: _OSC: not requesting control; platform does not support [PCIeCapability]
[    0.379828] acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug PME AER PCIeCapability]
[    0.379832] acpi PNP0A08:00: _OSC: platform willing to grant [PCIeHotplug PME AER]
[    0.379835] acpi PNP0A08:00: _OSC failed (AE_SUPPORT); disabling ASPM
[    0.379977] PCI host bridge to bus 0000:00
[    0.379981] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.379984] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.379987] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.379990] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.379993] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff]
[    0.379996] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff]
[    0.379999] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff]
[    0.380007] pci 0000:00:00.0: [8086:0044] type 00 class 0x060000
[    0.380022] DMAR: BIOS has allocated no shadow GTT; disabling IOMMU for graphics
[    0.380075] pci 0000:00:02.0: [8086:0046] type 00 class 0x030000
[    0.380086] pci 0000:00:02.0: reg 0x10: [mem 0xf2000000-0xf23fffff 64bit]
[    0.380091] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.380094] pci 0000:00:02.0: reg 0x20: [io  0x1800-0x1807]
[    0.380191] pci 0000:00:16.0: [8086:3b64] type 00 class 0x078000
[    0.380218] pci 0000:00:16.0: reg 0x10: [mem 0xf2827800-0xf282780f 64bit]
[    0.380316] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.380395] pci 0000:00:19.0: [8086:10ea] type 00 class 0x020000
[    0.380419] pci 0000:00:19.0: reg 0x10: [mem 0xf2600000-0xf261ffff]
[    0.380430] pci 0000:00:19.0: reg 0x14: [mem 0xf2625000-0xf2625fff]
[    0.380442] pci 0000:00:19.0: reg 0x18: [io  0x1820-0x183f]
[    0.380531] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.380563] pci 0000:00:19.0: System wakeup disabled by ACPI
[    0.380606] pci 0000:00:1a.0: [8086:3b3c] type 00 class 0x0c0320
[    0.380635] pci 0000:00:1a.0: reg 0x10: [mem 0xf2828000-0xf28283ff]
[    0.380746] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.380780] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    0.380825] pci 0000:00:1b.0: [8086:3b56] type 00 class 0x040300
[    0.380848] pci 0000:00:1b.0: reg 0x10: [mem 0xf2620000-0xf2623fff 64bit]
[    0.380957] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.380996] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    0.381037] pci 0000:00:1c.0: [8086:3b42] type 01 class 0x060400
[    0.381144] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.381180] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    0.381219] pci 0000:00:1c.1: [8086:3b44] type 01 class 0x060400
[    0.381324] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.381360] pci 0000:00:1c.1: System wakeup disabled by ACPI
[    0.381399] pci 0000:00:1c.3: [8086:3b48] type 01 class 0x060400
[    0.381504] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.381540] pci 0000:00:1c.3: System wakeup disabled by ACPI
[    0.381577] pci 0000:00:1c.4: [8086:3b4a] type 01 class 0x060400
[    0.381683] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.381718] pci 0000:00:1c.4: System wakeup disabled by ACPI
[    0.381765] pci 0000:00:1d.0: [8086:3b34] type 00 class 0x0c0320
[    0.381789] pci 0000:00:1d.0: reg 0x10: [mem 0xf2828400-0xf28287ff]
[    0.381898] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.381930] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    0.381967] pci 0000:00:1e.0: [8086:2448] type 01 class 0x060401
[    0.382087] pci 0000:00:1f.0: [8086:3b07] type 00 class 0x060100
[    0.382249] pci 0000:00:1f.2: [8086:3b2f] type 00 class 0x010601
[    0.382275] pci 0000:00:1f.2: reg 0x10: [io  0x1860-0x1867]
[    0.382286] pci 0000:00:1f.2: reg 0x14: [io  0x1814-0x1817]
[    0.382296] pci 0000:00:1f.2: reg 0x18: [io  0x1818-0x181f]
[    0.382307] pci 0000:00:1f.2: reg 0x1c: [io  0x1810-0x1813]
[    0.382317] pci 0000:00:1f.2: reg 0x20: [io  0x1840-0x185f]
[    0.382328] pci 0000:00:1f.2: reg 0x24: [mem 0xf2827000-0xf28277ff]
[    0.382394] pci 0000:00:1f.2: PME# supported from D3hot
[    0.382456] pci 0000:00:1f.3: [8086:3b30] type 00 class 0x0c0500
[    0.382477] pci 0000:00:1f.3: reg 0x10: [mem 0xf2828800-0xf28288ff 64bit]
[    0.382506] pci 0000:00:1f.3: reg 0x20: [io  0x1880-0x189f]
[    0.382589] pci 0000:00:1f.6: [8086:3b32] type 00 class 0x118000
[    0.382615] pci 0000:00:1f.6: reg 0x10: [mem 0xf2626000-0xf2626fff 64bit]
[    0.382810] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.382966] pci 0000:03:00.0: [8086:0084] type 00 class 0x028000
[    0.383029] pci 0000:03:00.0: reg 0x10: [mem 0xf2400000-0xf2401fff 64bit]
[    0.383273] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.390729] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.390739] pci 0000:00:1c.1:   bridge window [mem 0xf2400000-0xf24fffff]
[    0.390832] acpiphp: Slot [1] registered
[    0.390840] pci 0000:00:1c.3: PCI bridge to [bus 05-0c]
[    0.390846] pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
[    0.390851] pci 0000:00:1c.3:   bridge window [mem 0xf0000000-0xf1ffffff]
[    0.390858] pci 0000:00:1c.3:   bridge window [mem 0xf2900000-0xf29fffff 64bit pref]
[    0.390992] pci 0000:0d:00.0: [1180:e822] type 00 class 0x080500
[    0.391013] pci 0000:0d:00.0: MMC controller base frequency changed to 50Mhz.
[    0.391037] pci 0000:0d:00.0: reg 0x10: [mem 0xf2500000-0xf25000ff]
[    0.391215] pci 0000:0d:00.0: supports D1 D2
[    0.391216] pci 0000:0d:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.391340] pci 0000:0d:00.1: [1180:e230] type 00 class 0x088000
[    0.391367] pci 0000:0d:00.1: reg 0x10: [mem 0xf2500400-0xf25004ff]
[    0.391534] pci 0000:0d:00.1: supports D1 D2
[    0.391535] pci 0000:0d:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.391657] pci 0000:0d:00.3: [1180:e832] type 00 class 0x0c0010
[    0.391683] pci 0000:0d:00.3: reg 0x10: [mem 0xf2500800-0xf2500fff]
[    0.391850] pci 0000:0d:00.3: supports D1 D2
[    0.391851] pci 0000:0d:00.3: PME# supported from D0 D1 D2 D3hot D3cold
[    0.400712] pci 0000:00:1c.4: PCI bridge to [bus 0d]
[    0.400722] pci 0000:00:1c.4:   bridge window [mem 0xf2500000-0xf25fffff]
[    0.400808] pci 0000:00:1e.0: PCI bridge to [bus 0e] (subtractive decode)
[    0.400823] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.400824] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.400826] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.400827] pci 0000:00:1e.0:   bridge window [mem 0x000d4000-0x000d7fff] (subtractive decode)
[    0.400828] pci 0000:00:1e.0:   bridge window [mem 0x000d8000-0x000dbfff] (subtractive decode)
[    0.400830] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xfebfffff] (subtractive decode)
[    0.402426] ACPI: Enabled 3 GPEs in block 00 to 3F
[    0.402482] ACPI : EC: GPE = 0x11, I/O: command/status = 0x66, data = 0x62
[    0.402579] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.402583] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.402588] vgaarb: loaded
[    0.402590] vgaarb: bridge control possible 0000:00:02.0
[    0.402670] PCI: Using ACPI for IRQ routing
[    0.412409] PCI: pci_cache_line_size set to 64 bytes
[    0.412613] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
[    0.412614] e820: reserve RAM buffer [mem 0xbb27c000-0xbbffffff]
[    0.412616] e820: reserve RAM buffer [mem 0xbb35f000-0xbbffffff]
[    0.412619] e820: reserve RAM buffer [mem 0xbb46f000-0xbbffffff]
[    0.412620] e820: reserve RAM buffer [mem 0xbb717000-0xbbffffff]
[    0.412622] e820: reserve RAM buffer [mem 0xbb76c000-0xbbffffff]
[    0.412624] e820: reserve RAM buffer [mem 0xbb800000-0xbbffffff]
[    0.412724] NetLabel: Initializing
[    0.412727] NetLabel:  domain hash size = 128
[    0.412729] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.412741] NetLabel:  unlabeled traffic allowed by default
[    0.412770] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.412776] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.414808] Switched to clocksource hpet
[    0.419465] pnp: PnP ACPI init
[    0.420799] system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.420804] system 00:00: [mem 0x000c0000-0x000c3fff] could not be reserved
[    0.420808] system 00:00: [mem 0x000c4000-0x000c7fff] could not be reserved
[    0.420811] system 00:00: [mem 0x000c8000-0x000cbfff] has been reserved
[    0.420815] system 00:00: [mem 0x000cc000-0x000cffff] has been reserved
[    0.420818] system 00:00: [mem 0x000d0000-0x000d3fff] could not be reserved
[    0.420821] system 00:00: [mem 0x000dc000-0x000dffff] could not be reserved
[    0.420825] system 00:00: [mem 0x000e0000-0x000e3fff] could not be reserved
[    0.420828] system 00:00: [mem 0x000e4000-0x000e7fff] could not be reserved
[    0.420832] system 00:00: [mem 0x000e8000-0x000ebfff] could not be reserved
[    0.420835] system 00:00: [mem 0x000ec000-0x000effff] could not be reserved
[    0.420838] system 00:00: [mem 0x000f0000-0x000fffff] could not be reserved
[    0.420842] system 00:00: [mem 0x00100000-0xbfffffff] could not be reserved
[    0.420845] system 00:00: [mem 0xfec00000-0xfed3ffff] could not be reserved
[    0.420849] system 00:00: [mem 0xfed4c000-0xffffffff] could not be reserved
[    0.420854] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.421146] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.421150] system 00:01: [io  0x1000-0x107f] could not be reserved
[    0.421154] system 00:01: [io  0x1180-0x11ff] has been reserved
[    0.421158] system 00:01: [io  0x0800-0x080f] has been reserved
[    0.421161] system 00:01: [io  0x15e0-0x15ef] has been reserved
[    0.421164] system 00:01: [io  0x1600-0x1641] has been reserved
[    0.421167] system 00:01: [io  0x1644-0x167f] could not be reserved
[    0.421171] system 00:01: [mem 0xe0000000-0xefffffff] has been reserved
[    0.421174] system 00:01: [mem 0xfeaff000-0xfeafffff] has been reserved
[    0.421178] system 00:01: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.421181] system 00:01: [mem 0xfed10000-0xfed13fff] has been reserved
[    0.421184] system 00:01: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.421188] system 00:01: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.421191] system 00:01: [mem 0xfed45000-0xfed4bfff] has been reserved
[    0.421195] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.421250] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.421273] pnp 00:03: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.421296] pnp 00:04: Plug and Play ACPI device, IDs LEN0015 PNP0f13 (active)
[    0.421577] pnp 00:05: Plug and Play ACPI device, IDs SMO1200 PNP0c31 (active)
[    0.422413] pnp: PnP ACPI: found 6 devices
[    0.429364] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.429382] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.429389] pci 0000:00:1c.1:   bridge window [mem 0xf2400000-0xf24fffff]
[    0.429401] pci 0000:00:1c.3: PCI bridge to [bus 05-0c]
[    0.429405] pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
[    0.429413] pci 0000:00:1c.3:   bridge window [mem 0xf0000000-0xf1ffffff]
[    0.429419] pci 0000:00:1c.3:   bridge window [mem 0xf2900000-0xf29fffff 64bit pref]
[    0.429428] pci 0000:00:1c.4: PCI bridge to [bus 0d]
[    0.429435] pci 0000:00:1c.4:   bridge window [mem 0xf2500000-0xf25fffff]
[    0.429446] pci 0000:00:1e.0: PCI bridge to [bus 0e]
[    0.429462] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.429464] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.429465] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.429467] pci_bus 0000:00: resource 7 [mem 0x000d4000-0x000d7fff]
[    0.429468] pci_bus 0000:00: resource 8 [mem 0x000d8000-0x000dbfff]
[    0.429469] pci_bus 0000:00: resource 9 [mem 0xc0000000-0xfebfffff]
[    0.429471] pci_bus 0000:03: resource 1 [mem 0xf2400000-0xf24fffff]
[    0.429473] pci_bus 0000:05: resource 0 [io  0x2000-0x2fff]
[    0.429474] pci_bus 0000:05: resource 1 [mem 0xf0000000-0xf1ffffff]
[    0.429476] pci_bus 0000:05: resource 2 [mem 0xf2900000-0xf29fffff 64bit pref]
[    0.429477] pci_bus 0000:0d: resource 1 [mem 0xf2500000-0xf25fffff]
[    0.429479] pci_bus 0000:0e: resource 4 [io  0x0000-0x0cf7]
[    0.429480] pci_bus 0000:0e: resource 5 [io  0x0d00-0xffff]
[    0.429482] pci_bus 0000:0e: resource 6 [mem 0x000a0000-0x000bffff]
[    0.429483] pci_bus 0000:0e: resource 7 [mem 0x000d4000-0x000d7fff]
[    0.429485] pci_bus 0000:0e: resource 8 [mem 0x000d8000-0x000dbfff]
[    0.429486] pci_bus 0000:0e: resource 9 [mem 0xc0000000-0xfebfffff]
[    0.429514] NET: Registered protocol family 2
[    0.429699] TCP established hash table entries: 32768 (order: 6, 262144 bytes)
[    0.429803] TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
[    0.429955] TCP: Hash tables configured (established 32768 bind 32768)
[    0.429986] TCP: reno registered
[    0.429993] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.430017] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    0.430071] NET: Registered protocol family 1
[    0.430092] pci 0000:00:02.0: Video device with shadowed ROM
[    0.430418] PCI: CLS 64 bytes, default 64
[    0.430470] Unpacking initramfs...
[    0.482356] Freeing initrd memory: 3432K (ffff880037c96000 - ffff880037ff0000)
[    0.482374] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.482378] software IO TLB [mem 0xb727c000-0xbb27c000] (64MB) mapped at [ffff8800b727c000-ffff8800bb27bfff]
[    0.482405] Simple Boot Flag at 0x35 set to 0x1
[    0.482628] microcode: CPU0 sig=0x20655, pf=0x10, revision=0x2
[    0.482637] microcode: CPU1 sig=0x20655, pf=0x10, revision=0x2
[    0.482642] microcode: CPU2 sig=0x20655, pf=0x10, revision=0x2
[    0.482651] microcode: CPU3 sig=0x20655, pf=0x10, revision=0x2
[    0.482718] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    0.482743] Scanning for low memory corruption every 60 seconds
[    0.482991] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.483020] Initialise system trusted keyring
[    0.483358] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.484458] zpool: loaded
[    0.484462] zbud: loaded
[    0.484612] VFS: Disk quotas dquot_6.5.2
[    0.484643] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.484785] Key type big_key registered
[    0.485052] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.485111] io scheduler noop registered
[    0.485115] io scheduler deadline registered
[    0.485147] io scheduler cfq registered (default)
[    0.485644] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.485660] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.485675] vesafb: mode is 1024x768x8, linelength=1024, pages=41
[    0.485678] vesafb: scrolling: redraw
[    0.485680] vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
[    0.485697] vesafb: framebuffer at 0xd0000000, mapped to 0xffffc90010780000, using 1536k, total 32704k
[    0.512943] Console: switching to colour frame buffer device 128x48
[    0.540424] fb0: VESA VGA frame buffer device
[    0.540660] intel_idle: MWAIT substates: 0x1120
[    0.540661] intel_idle: v0.4 model 0x25
[    0.540662] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.540830] GHES: HEST is not enabled!
[    0.541086] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.541793] Linux agpgart interface v0.103
[    0.542055] rtc_cmos 00:02: RTC can wake from S4
[    0.542425] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    0.542767] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.543164] ledtrig-cpu: registered to indicate activity on CPUs
[    0.543744] TCP: cubic registered
[    0.543988] NET: Registered protocol family 10
[    0.544444] NET: Registered protocol family 17
[    0.544983] Loading compiled-in X.509 certificates
[    0.545237] registered taskstats version 1
[    0.546045]   Magic number: 11:934:555
[    0.546284] acpi PNP0C0F:06: hash matches
[    0.546550] rtc_cmos 00:02: setting system clock to 2015-04-27 23:31:15 UTC (1430177475)
[    0.547046] PM: Checking hibernation image partition UUID=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
[    0.547049] PM: Hibernation image not present or could not be loaded.
[    0.547439] Freeing unused kernel memory: 1164K (ffffffff818e7000 - ffffffff81a0a000)
[    0.547838] Write protecting the kernel read-only data: 8192k
[    0.548502] Freeing unused kernel memory: 600K (ffff88000156a000 - ffff880001600000)
[    0.549030] Freeing unused kernel memory: 304K (ffff8800017b4000 - ffff880001800000)
[    0.557444] random: systemd-tmpfile urandom read with 5 bits of entropy available
[    0.614050] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.629148] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.639977] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.650834] ACPI: bus type USB registered
[    0.661353] usbcore: registered new interface driver usbfs
[    0.671824] usbcore: registered new interface driver hub
[    0.682403] usbcore: registered new device driver usb
[    0.693990] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.707382] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.718231] ehci-pci: EHCI PCI platform driver
[    0.732260] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    0.747139] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    0.747271] sdhci: Secure Digital Host Controller Interface driver
[    0.747272] sdhci: Copyright(c) Pierre Ossman
[    0.793343] ehci-pci 0000:00:1a.0: debug port 2
[    0.808059] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[    0.808093] firewire_ohci 0000:0d:00.3: added OHCI v1.10 device as card 0, 4 IR + 4 IT contexts, quirks 0x11
[    0.808292] ehci-pci 0000:00:1a.0: irq 23, io mem 0xf2828000
[    0.808822] SCSI subsystem initialized
[    0.818234] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    0.818579] hub 1-0:1.0: USB hub found
[    0.818592] hub 1-0:1.0: 3 ports detected
[    0.818955] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    0.818961] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    0.818977] ehci-pci 0000:00:1d.0: debug port 2
[    0.822911] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    0.822919] ehci-pci 0000:00:1d.0: irq 19, io mem 0xf2828400
[    0.831571] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    0.831903] hub 2-0:1.0: USB hub found
[    0.831920] hub 2-0:1.0: 3 ports detected
[    0.922061] libata version 3.00 loaded.
[    0.996879] sdhci-pci 0000:0d:00.0: SDHCI controller found [1180:e822] (rev 1)
[    1.007587] sdhci-pci 0000:0d:00.0: Will use DMA mode even though HW doesn't fully claim to support it.
[    1.022991] sdhci-pci 0000:0d:00.0: No vmmc regulator found
[    1.038261] sdhci-pci 0000:0d:00.0: No vqmmc regulator found
[    1.053610] ahci 0000:00:1f.2: version 3.0
[    1.053872] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    1.054735] mmc0: SDHCI controller on PCI [0000:0d:00.0] using DMA
[    1.085157] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0x33 impl SATA mode
[    1.100872] ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck stag pm led clo pio slum part ems sxs apst 
[    1.136144] scsi host0: ahci
[    1.147222] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    1.148475] scsi host1: ahci
[    1.148636] scsi host2: ahci
[    1.148812] scsi host3: ahci
[    1.148987] scsi host4: ahci
[    1.149175] scsi host5: ahci
[    1.149258] ata1: SATA max UDMA/133 abar m2048@0xf2827000 port 0xf2827100 irq 24
[    1.149262] ata2: SATA max UDMA/133 abar m2048@0xf2827000 port 0xf2827180 irq 24
[    1.149263] ata3: DUMMY
[    1.149264] ata4: DUMMY
[    1.149266] ata5: SATA max UDMA/133 abar m2048@0xf2827000 port 0xf2827300 irq 24
[    1.149268] ata6: SATA max UDMA/133 abar m2048@0xf2827000 port 0xf2827380 irq 24
[    1.270103] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    1.403031] hub 1-1:1.0: USB hub found
[    1.412709] hub 2-1:1.0: USB hub found
[    1.422420] hub 2-1:1.0: 8 ports detected
[    1.432073] hub 1-1:1.0: 6 ports detected
[    1.468331] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.482460] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[    1.482466] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[    1.484965] tsc: Refined TSC clocksource calibration: 2660.000 MHz
[    1.495231] firewire_core 0000:0d:00.3: created device fw0: GUID f0def1ff49c298ff, S400
[    1.524053] ata1.00: ACPI cmd ef/5f:00:00:00:00:a0 (SET FEATURES) succeeded
[    1.524059] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[    1.535033] ata1.00: ATA-8: HITACHI HTS725050A9A364, PC4ZC70F, max UDMA/100
[    1.548087] ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.561406] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[    1.561414] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[    1.573755] ata1.00: ACPI cmd ef/5f:00:00:00:00:a0 (SET FEATURES) succeeded
[    1.573761] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[    1.586941] ata1.00: configured for UDMA/100
[    1.596861] scsi 0:0:0:0: Direct-Access     ATA      HITACHI HTS72505 C70F PQ: 0 ANSI: 5
[    1.725169] usb 1-1.6: new high-speed USB device number 3 using ehci-pci
[    1.928391] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.944804] ata2.00: ACPI cmd e3/00:1f:00:00:00:a0 (IDLE) succeeded
[    1.945073] ata2.00: ACPI cmd e3/00:02:00:00:00:a0 (IDLE) succeeded
[    1.946637] ata2.00: ATAPI: HL-DT-STDVDRAM GT33N, LT20, max UDMA/66
[    1.959578] ata2.00: ACPI cmd e3/00:1f:00:00:00:a0 (IDLE) succeeded
[    1.959859] ata2.00: ACPI cmd e3/00:02:00:00:00:a0 (IDLE) succeeded
[    1.961405] ata2.00: configured for UDMA/66
[    1.977127] scsi 1:0:0:0: CD-ROM            HL-DT-ST DVDRAM GT33N     LT20 PQ: 0 ANSI: 5
[    2.321758] ata5: SATA link down (SStatus 0 SControl 300)
[    2.485345] Switched to clocksource tsc
[    2.655114] ata6: SATA link down (SStatus 0 SControl 300)
[    2.669235] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    2.679972] sd 0:0:0:0: [sda] Write Protect is off
[    2.690636] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.690650] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.692895] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[    2.692896] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.693039] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    2.862092]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 sda15 sda16 >
[    2.881313] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.089078] random: nonblocking pool is initialized
[    4.676083] EXT4-fs (sda10): mounting ext3 file system using the ext4 subsystem
[    4.700091] EXT4-fs (sda10): mounted filesystem with ordered data mode. Opts: (null)
[    6.129972] systemd[1]: systemd 218 running in system mode. (+PAM -AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD +IDN)
[    6.155206] systemd[1]: Detected architecture 'x86-64'.
[    6.233944] systemd[1]: Set hostname to <ga>.
[    8.022526] systemd[1]: Cannot add dependency job for unit crond.service, ignoring: Unit crond.service failed to load: No such file or directory.
[    8.060352] systemd[1]: Cannot add dependency job for unit netfs.service, ignoring: Unit netfs.service is masked.
[    8.079967] systemd[1]: Cannot add dependency job for unit nfs-common.service, ignoring: Unit nfs-common.service failed to load: No such file or directory.
[    8.119625] systemd[1]: Starting Encrypted Volumes.
[    8.158278] systemd[1]: Reached target Encrypted Volumes.
[    8.177498] systemd[1]: Expecting device dev-disk-by\x2dlabel-uswap.device...
[    8.216318] systemd[1]: Starting Arbitrary Executable File Formats File System Automount Point.
[    8.256378] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    8.276583] systemd[1]: Expecting device dev-disk-by\x2dlabel-archhome.device...
[    8.316988] systemd[1]: Expecting device dev-disk-by\x2dlabel-archvar.device...
[    8.357984] systemd[1]: Starting Root Slice.
[    8.398825] systemd[1]: Created slice Root Slice.
[    8.419075] systemd[1]: Starting System Slice.
[    8.459267] systemd[1]: Created slice System Slice.
[    8.479206] systemd[1]: Starting Journal Socket.
[    8.518435] systemd[1]: Listening on Journal Socket.
[    8.560357] systemd[1]: Mounting Temporary Directory...
[    8.603255] systemd[1]: tmp.mount: Directory /tmp to mount over is not empty, mounting anyway.
[    8.700067] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    8.739962] systemd[1]: Mounting POSIX Message Queue File System...
[    8.780260] systemd[1]: Starting Delayed Shutdown Socket.
[    8.820018] systemd[1]: Listening on Delayed Shutdown Socket.
[    8.840067] systemd[1]: Starting Remote File Systems.
[    8.879983] systemd[1]: Reached target Remote File Systems.
[    8.899889] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[    8.939308] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    8.958559] systemd[1]: Starting Device-mapper event daemon FIFOs.
[    8.996855] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    9.016324] systemd[1]: Starting User and Session Slice.
[    9.055833] systemd[1]: Created slice User and Session Slice.
[    9.115465] systemd[1]: Started Set Up Additional Binary Formats.
[    9.270674] systemd[1]: Listening on Journal Audit Socket.
[    9.289374] systemd[1]: Mounting Huge Pages File System...
[    9.326753] systemd[1]: Starting Setup Virtual Console...
[    9.363667] systemd[1]: Starting Load modules defined in rc.conf...
[    9.395538] systemd[1]: Starting Dispatch Password Requests to Console Directory Watch.
[    9.413440] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    9.431741] systemd[1]: Starting Journal Socket (/dev/log).
[    9.467455] systemd[1]: Listening on Journal Socket (/dev/log).
[    9.485077] systemd[1]: Starting Journal Service...
[    9.520270] systemd[1]: Starting File System Check on Root Device...
[    9.555178] systemd[1]: Starting system-systemd\x2dfsck.slice.
[    9.589697] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    9.607330] systemd[1]: Starting udev Control Socket.
[    9.642245] systemd[1]: Listening on udev Control Socket.
[    9.659958] systemd[1]: Starting Slices.
[    9.694650] systemd[1]: Reached target Slices.
[    9.712269] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
[    9.730222] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    9.747925] systemd[1]: Starting Paths.
[    9.782125] systemd[1]: Reached target Paths.
[    9.798878] systemd[1]: Starting system-getty.slice.
[    9.832342] systemd[1]: Created slice system-getty.slice.
[    9.848956] systemd[1]: Starting LVM2 metadata daemon socket.
[    9.882186] systemd[1]: Listening on LVM2 metadata daemon socket.
[    9.899109] systemd[1]: Mounting Debug File System...
[    9.932976] systemd[1]: Expecting device dev-disk-by\x2dlabel-mainboot.device...
[    9.966340] systemd[1]: Starting udev Kernel Socket.
[    9.997505] systemd[1]: Listening on udev Kernel Socket.
[   10.009258] systemd[1]: Starting udev Coldplug all Devices...
[   10.058229] systemd[1]: Mounted Huge Pages File System.
[   10.091233] systemd[1]: Mounted Debug File System.
[   10.124410] systemd[1]: Mounted POSIX Message Queue File System.
[   10.157489] systemd[1]: Mounted Temporary Directory.
[   10.190931] systemd[1]: Started Journal Service.
[   10.543974] FS-Cache: Loaded
[   10.618001] RPC: Registered named UNIX socket transport module.
[   10.634052] RPC: Registered udp transport module.
[   10.649792] RPC: Registered tcp transport module.
[   10.665214] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   10.814999] FS-Cache: Netfs 'nfs' registered for caching
[   11.019373] EXT4-fs (sda10): re-mounted. Opts: (null)
[   12.024414] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
[   12.035775] ACPI: Lid Switch [LID]
[   12.046824] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input3
[   12.058220] ACPI: Sleep Button [SLPB]
[   12.069653] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
[   12.081208] ACPI: Power Button [PWRF]
[   12.201380] ACPI Warning: SystemIO range 0x0000000000001028-0x000000000000102f conflicts with OpRegion 0x0000000000001000-0x000000000000107f (\_SB_.PCI0.LPC_.PMIO) (20141107/utaddress-258)
[   12.226052] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   12.238478] ACPI Warning: SystemIO range 0x00000000000011c0-0x00000000000011cf conflicts with OpRegion 0x0000000000001180-0x00000000000011ff (\_SB_.PCI0.LPC_.LPIO) (20141107/utaddress-258)
[   12.263925] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   12.277214] ACPI Warning: SystemIO range 0x00000000000011b0-0x00000000000011bf conflicts with OpRegion 0x0000000000001180-0x00000000000011ff (\_SB_.PCI0.LPC_.LPIO) (20141107/utaddress-258)
[   12.304344] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   12.318382] ACPI Warning: SystemIO range 0x0000000000001180-0x00000000000011af conflicts with OpRegion 0x0000000000001180-0x00000000000011ff (\_SB_.PCI0.LPC_.LPIO) (20141107/utaddress-258)
[   12.346954] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   12.361637] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   12.362374] wmi: Mapper loaded
[   12.391549] agpgart-intel 0000:00:00.0: Intel HD Graphics Chipset
[   12.399345] ACPI: AC Adapter [AC] (on-line)
[   12.420799] agpgart-intel 0000:00:00.0: detected gtt size: 2097152K total, 262144K mappable
[   12.420823] pps_core: LinuxPPS API ver. 1 registered
[   12.420824] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   12.466891] agpgart-intel 0000:00:00.0: detected 32768K stolen memory
[   12.482373] PTP clock support registered
[   12.482533] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[   12.513391] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   12.544618] ACPI: Battery Slot [BAT0] (battery present)
[   12.561194] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[   12.561981] tpm_tis 00:05: 1.2 TPM (device-id 0x0, rev-id 78)
[   12.593262] Non-volatile memory driver v1.3
[   12.616055] tpm_tis 00:05: TPM is disabled/deactivated (0x6)
[   12.648764] thermal LNXTHERM:00: registered as thermal_zone0
[   12.664249] ACPI: Thermal Zone [THM0] (60 C)
[   12.690839] [drm] Initialized drm 1.1.0 20060810
[   12.849578] cfg80211: Calling CRDA to update world regulatory domain
[   12.872231] thinkpad_acpi: ThinkPad ACPI Extras v0.25
[   12.887777] thinkpad_acpi: http://ibm-acpi.sf.net/
[   12.903307] thinkpad_acpi: ThinkPad BIOS 6MET81WW (1.41 ), EC 6MHT43WW-1.18
[   12.918931] thinkpad_acpi: Lenovo ThinkPad T510, model 4314DPU
[   12.934919] intel ips 0000:00:1f.6: CPU TDP doesn't match expected value (found 25, expected 29)
[   12.935226] thinkpad_acpi: detected a 16-level brightness capable ThinkPad
[   12.936046] thinkpad_acpi: radio switch found; radios are enabled
[   12.936129] thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
[   12.936129] thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
[   12.936782] input: PC Speaker as /devices/platform/pcspkr/input/input6
[   13.022745] thinkpad_acpi: Standard ACPI backlight interface available, not loading native one
[   13.048649] intel ips 0000:00:1f.6: failed to get i915 symbols, graphics turbo disabled until i915 loads
[   13.052787] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_acpi/input/input5
[   13.081798] intel ips 0000:00:1f.6: IPS driver initialized, MCP temp limit 90
[   13.138802] Intel(R) Wireless WiFi driver for Linux, in-tree:
[   13.155067] Copyright(c) 2003- 2014 Intel Corporation
[   13.171185] iwlwifi 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[   13.214421] [drm] Memory usable by graphics device = 2048M
[   13.230051] checking generic (d0000000 1ff0000) vs hw (d0000000 10000000)
[   13.230053] fb: switching to inteldrmfb from VESA VGA
[   13.245385] Console: switching to colour dummy device 80x25
[   13.245474] [drm] Replacing VGA console driver
[   13.266183] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   13.266193] [drm] Driver supports precise vblank timestamp query.
[   13.266569] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   13.300080] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[   13.300993] acpi device:01: registered as cooling_device4
[   13.301065] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input7
[   13.301169] [drm] Initialized i915 1.6.0 20141121 for 0000:00:02.0 on minor 0
[   13.362741] [drm] GMBUS [i915 gmbus dpb] timed out, falling back to bit banging on pin 5
[   13.378040] fbcon: inteldrmfb (fb0) is primary device
[   13.400079] e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
[   13.400079] e1000e: Copyright(c) 1999 - 2014 Intel Corporation.
[   13.400263] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   13.550660] iwlwifi 0000:03:00.0: loaded firmware version 39.31.5.1 build 35138 op_mode iwldvm
[   13.575672] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) f0:de:f1:49:c2:98
[   13.575677] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[   13.575744] e1000e 0000:00:19.0 eth0: MAC: 9, PHY: 10, PBA No: A002FF-0FF
[   13.588165] media: Linux media interface: v0.10
[   13.721216] sound hdaudioC0D0: CX20585: BIOS auto-probing.
[   13.721712] sound hdaudioC0D0: autoconfig: line_outs=1 (0x1f/0x0/0x0/0x0/0x0) type:speaker
[   13.721714] sound hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   13.721716] sound hdaudioC0D0:    hp_outs=2 (0x1c/0x19/0x0/0x0/0x0)
[   13.721717] sound hdaudioC0D0:    mono: mono_out=0x0
[   13.721718] sound hdaudioC0D0:    inputs:
[   13.721720] sound hdaudioC0D0:      Internal Mic=0x23
[   13.721722] sound hdaudioC0D0:      Mic=0x1b
[   13.721723] sound hdaudioC0D0:      Dock Mic=0x1a
[   13.722754] sound hdaudioC0D0: Enable sync_write for stable communication
[   13.722755] sound hdaudioC0D0: XXX hda_fixup_thinkpad_acpi init...
[   13.724366] sound hdaudioC0D0: XXX ok, this is thinkpad
[   13.724373] sound hdaudioC0D0: XXX mute LED NOT WORKING!
[   13.724374] sound hdaudioC0D0: XXX ok, mic LED is hooked
[   13.760256] SSE version of gcm_enc/dec engaged.
[   13.974775] Linux video capture interface: v2.00
[   14.239682] Console: switching to colour frame buffer device 200x56
[   14.243259] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[   14.243283] i915 0000:00:02.0: registered panic notifier
[   14.352828] psmouse serio1: synaptics: Touchpad model: 1, fw: 7.2, id: 0x1c0b1, caps: 0xd047b3/0xb40000/0xa0000, board id: 71, fw id: 578367
[   14.352977] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
[   14.411948] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input8
[   14.531939] uvcvideo: Found UVC 1.00 device Integrated Camera (17ef:480f)
[   14.534662] input: Integrated Camera as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.6/1-1.6:1.0/input/input11
[   14.536111] usbcore: registered new interface driver uvcvideo
[   14.537477] USB Video Class driver (1.1.1)
[   14.646486] kvm: disabled by bios
[   14.690270] kvm: disabled by bios
[   14.737052] kvm: disabled by bios
[   14.827253] kvm: disabled by bios
[   14.898484] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card0/hdaudioC0D0/input9
[   14.900257] input: HDA Intel MID Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[   14.902010] input: HDA Intel MID Dock Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[   14.903523] input: HDA Intel MID Dock Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[   14.904992] input: HDA Intel MID Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[   14.906665] input: HDA Intel MID HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input16
[   14.908521] input: HDA Intel MID HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input17
[   14.910394] input: HDA Intel MID HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input18
[   14.921100] iTCO_vendor_support: vendor-support=0
[   14.955722] mousedev: PS/2 mouse device common for all mice
[   14.976529] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   14.977937] iTCO_wdt: Found a QM57 TCO device (Version=2, TCOBASE=0x1060)
[   14.979350] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   15.274724] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEBUG disabled
[   15.276050] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEBUGFS disabled
[   15.277346] iwlwifi 0000:03:00.0: CONFIG_IWLWIFI_DEVICE_TRACING enabled
[   15.278648] iwlwifi 0000:03:00.0: Detected Intel(R) Centrino(R) Wireless-N 1000 BGN, REV=0x6C
[   15.280077] iwlwifi 0000:03:00.0: L1 Enabled - LTR Disabled
[   15.386527] ppdev: user-space parallel port driver
[   15.444772] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
[   16.049731] Adding 4194208k swap on /dev/sda14.  Priority:-1 extents:1 across:4194208k FS
[   17.030555] EXT4-fs (sda11): mounting ext3 file system using the ext4 subsystem
[   17.207461] EXT4-fs (sda11): mounted filesystem with ordered data mode. Opts: (null)
[   17.223348] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[   17.308011] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[   17.330143] EXT4-fs (sda16): mounting ext3 file system using the ext4 subsystem
[   17.415684] EXT4-fs (sda16): mounted filesystem with ordered data mode. Opts: (null)
[   17.609166] systemd-journald[170]: Received request to flush runtime journal from PID 1
[   18.303476] intel ips 0000:00:1f.6: i915 driver attached, reenabling gpu turbo
[   20.262626] psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3
[   20.554809] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/serio1/serio2/input/input10
[   23.607222] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready

--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Qrgsu6vtpU/OV/zm--
