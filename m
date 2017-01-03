From: Enrico Mioso <mrkiko.rs@gmail.com>
Subject: Re: Intel HDA audio on EEE PC 1101HGo
Date: Tue, 3 Jan 2017 14:49:40 +0100 (CET)
Message-ID: <alpine.LNX.2.20.1701031449090.1620@localhost.localdomain>
References: <alpine.LNX.2.20.1504082130290.1715@localhost.localdomain>
 <s5hegntl2cs.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1611230916070.5938@localhost.localdomain>
 <s5hr35s0xh2.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1612011450060.7660@localhost.localdomain>
 <s5h4m2n21ll.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 183EC2666FE
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 14:49:47 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id u144so86710649wmu.0
 for <alsa-devel@alsa-project.org>; Tue, 03 Jan 2017 05:49:47 -0800 (PST)
In-Reply-To: <s5h4m2n21ll.wl-tiwai@suse.de>
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
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, kailang@realtek.com
List-Id: alsa-devel@alsa-project.org

hello Tahaski,
hello everyone reading this message.

Thank you for the patience you had with me. Now I finally came to set up this system for crash analysis, compiling the kernel with debug informations and frame pointers and so on. I set up kdump also. Unfortunately, I can get no useful output.
The last things the system wrote before dying have been reconstructed. I noted down decimal values with the help of my mum. She wrote them down on a piece of paper.
I am hitting the following messages:
azx_get_response timeout, switching to polling mode: last cmd=0x014ba000
azx_get_response timeout, switching to single_cmd mode: last cmd=0x014ba000

Unfortunately the system wasn't able to reboot via crashdump/kexec mechanism nor to print out more useful output.

power_save = 40
power_save_controller = Y

thank you very much,
Enrico

PS: I am using VERSA mode, should I switch back to standard VGA? No graphical user interface running.

My system dmesg appended:
Linux version 4.10.0-rc2ho+ (mrkiko@atlantide2) (gcc version 6.2.1 20160830 (GCC) ) #1 SMP Tue Jan 3 12:03:10 CET 2017
KERNEL supported cpus:
   Intel GenuineIntel
Atom PSE erratum detected, BIOS microcode update recommended
Disabled fast string operations
x86/fpu: Legacy x87 FPU detected.
e820: BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000e2000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x000000003f64ffff] usable
BIOS-e820: [mem 0x000000003f650000-0x000000003f65ffff] reserved
BIOS-e820: [mem 0x000000003f660000-0x000000003f66dfff] ACPI data
BIOS-e820: [mem 0x000000003f66e000-0x000000003f6affff] ACPI NVS
BIOS-e820: [mem 0x000000003f6b0000-0x000000003f6bffff] reserved
BIOS-e820: [mem 0x000000003f6c8000-0x000000003f7fffff] reserved
BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
BIOS-e820: [mem 0x00000000fff00000-0x00000000ffffffff] reserved
Notice: NX (Execute Disable) protection cannot be enabled: non-PAE kernel!
SMBIOS 2.5 present.
DMI: ASUSTeK Computer INC. 1101HAG/1101HAG, BIOS 0102    08/17/2009
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
e820: last_pfn = 0x3f650 max_arch_pfn = 0x100000
MTRR default type: uncachable
MTRR fixed ranges enabled:
   00000-9FFFF write-back
   A0000-DFFFF uncachable
   E0000-EFFFF write-through
   F0000-FFFFF write-protect
MTRR variable ranges enabled:
   0 base 000000000 mask 0C0000000 write-back
   1 base 03F700000 mask 0FFF00000 uncachable
   2 base 03F800000 mask 0FF800000 uncachable
   3 disabled
   4 disabled
   5 disabled
   6 disabled
   7 disabled
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT 
initial memory mapped: [mem 0x00000000-0x0bffffff]
Base memory trampoline at [c009b000] 9b000 size 16384
BRK [0x0bad5000, 0x0bad5fff] PGTABLE
BRK [0x0bad6000, 0x0bad6fff] PGTABLE
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000FBFD0 000024 (v02 ACPIAM)
ACPI: XSDT 0x000000003F660100 00005C (v01 081709 XSDT1643 20090817 MSFT 00000097)
ACPI: FACP 0x000000003F660290 0000F4 (v04 081709 FACP1643 20090817 MSFT 00000097)
ACPI: DSDT 0x000000003F660430 0094D3 (v02 A1453  A1453000 00000000 INTL 20060113)
ACPI: FACS 0x000000003F66E000 000040
ACPI: FACS 0x000000003F66E000 000040
ACPI: APIC 0x000000003F660390 00005C (v02 081709 APIC1643 20090817 MSFT 00000097)
ACPI: MCFG 0x000000003F6603F0 00003C (v01 081709 OEMMCFG  20090817 MSFT 00000097)
ACPI: OEMB 0x000000003F66E040 00012C (v01 081709 OEMB1643 20090817 MSFT 00000097)
ACPI: HPET 0x000000003F669910 000038 (v01 081709 OEMHPET  20090817 MSFT 00000097)
ACPI: GSCI 0x000000003F66E170 002024 (v01 081709 GMCHSCI  20090817 MSFT 00000097)
ACPI: SSDT 0x000000003F670B60 0004F0 (v01 PmRef  CpuPm    00003000 INTL 20060113)
ACPI: Local APIC address 0xfee00000
126MB HIGHMEM available.
887MB LOWMEM available.
   mapped low ram: 0 - 377fe000
   low ram: 0 - 377fe000
Reserving 64MB of memory at 448MB for crashkernel (System RAM: 1013MB)
BRK [0x0bad7000, 0x0bad7fff] PGTABLE
Zone ranges:
   Normal   [mem 0x0000000000001000-0x00000000377fdfff]
   HighMem  [mem 0x00000000377fe000-0x000000003f64ffff]
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x0000000000001000-0x000000000009efff]
   node   0: [mem 0x0000000000100000-0x000000003f64ffff]
Initmem setup node 0 [mem 0x0000000000001000-0x000000003f64ffff]
On node 0 totalpages: 259566
free_area_init_node: node 0, pgdat cb9cc0c0, node_mem_map f6968028
   Normal zone: 2220 pages used for memmap
   Normal zone: 0 pages reserved
   Normal zone: 227228 pages, LIFO batch:31
   HighMem zone: 32338 pages, LIFO batch:7
Using APIC driver default
ACPI: PM-Timer IO Port: 0x908
ACPI: Local APIC address 0xfee00000
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
smpboot: Allowing 2 CPUs, 0 hotplug CPUs
e820: [mem 0x3f800000-0xfedfffff] available for PCI devices
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
setup_percpu: NR_CPUS:2 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
percpu: Embedded 19 pages/cpu @f77d5000 s45900 r0 d31924 u77824
pcpu-alloc: s45900 r0 d31924 u77824 alloc=19*4096
pcpu-alloc: [0] 0 [0] 1 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 257346
Kernel command line: auto BOOT_IMAGE=ArchCrash root=801 crashkernel=64M
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Initializing CPU#0
Initializing HighMem for node 0 (000377fe:0003f650)
Initializing Movable for node 0 (00000000:00000000)
Memory: 953840K/1038264K available (4294K kernel code, 198K rwdata, 1464K rodata, 348K init, 456K bss, 84424K reserved, 0K cma-reserved, 129352K highmem)
virtual kernel memory layout:
     fixmap  : 0xfff8f000 - 0xfffff000   ( 448 kB)
     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
     vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
     lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
       .init : 0xcb9d5000 - 0xcba2c000   ( 348 kB)
       .data : 0xcb831bfa - 0xcb9d3a00   (1671 kB)
       .text : 0xcb400000 - 0xcb831bfa   (4294 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Hierarchical RCU implementation.
 	Build-time adjustment of leaf fanout to 32.
NR_IRQS:2304 nr_irqs:440 16
CPU 0 irqstacks, hard=c0010000 soft=c0012000
Console: colour dummy device 80x25
console [tty0] enabled
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
hpet clockevent registered
tsc: Fast TSC calibration using PIT
tsc: Detected 1331.312 MHz processor
Calibrating delay loop (skipped), value calculated using timer frequency.. 2662.62 BogoMIPS (lpj=1331312)
pid_max: default: 32768 minimum: 301
ACPI: Core revision 20160930
ACPI: 2 ACPI AML tables successfully acquired and loaded
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
Atom PSE erratum detected, BIOS microcode update recommended
Disabled fast string operations
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
mce: CPU supports 5 MCE banks
CPU0: Thermal monitoring enabled (TM2)
process: using mwait in idle threads
Last level iTLB entries: 4KB 32, 2MB 0, 4MB 0
Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
Freeing SMP alternatives memory: 24K
smpboot: Max logical packages: 2
Enabling APIC mode:  Flat.  Using 1 I/O APICs
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
smpboot: CPU0: Intel(R) Atom(TM) CPU Z520   @ 1.33GHz (family: 0x6, model: 0x1c, stepping: 0x2)
Performance Events: PEBS fmt0+, LBR disabled due to erratumAtom events, Intel PMU driver.
... version:                3
... bit width:              40
... generic registers:      2
... value mask:             000000ffffffffff
... max period:             000000007fffffff
... fixed-purpose events:   3
... event mask:             0000000700000003
smp: Bringing up secondary CPUs ...
CPU 1 irqstacks, hard=c0114000 soft=c0116000
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1
Initializing CPU#1
Atom PSE erratum detected, BIOS microcode update recommended
Disabled fast string operations
smp: Brought up 1 node, 2 CPUs
smpboot: Total of 2 processors activated (5325.09 BogoMIPS)
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
NET: Registered protocol family 16
cpuidle: using governor menu
ACPI: bus type PCI registered
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
PCI: not using MMCONFIG
PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=3
PCI: Using configuration type 1 for base access
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Executed 1 blocks of module-level executable AML code
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0x00000000C0096800 0001FA (v01 PmRef  Cpu0Ist  00003000 INTL 20060113)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0x00000000C008B000 00065D (v01 PmRef  Cpu0Cst  00003001 INTL 20060113)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0x00000000C005CE00 0000CC (v01 PmRef  Cpu1Ist  00003000 INTL 20060113)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0x00000000C004E6C0 000085 (v01 PmRef  Cpu1Cst  00003000 INTL 20060113)
ACPI : EC: EC started
ACPI: \_SB_.PCI0.SBRG.EC0_: Used as first EC
ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0xd, EC_CMD/EC_SC=0x66, EC_DATA=0x62
ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions
ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
PCI: Using MMCONFIG for extended config space
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff window]
pci_bus 0000:00: root bus resource [mem 0x3f800000-0xdfffffff window]
pci_bus 0000:00: root bus resource [mem 0xf0000000-0xffffffff window]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:00.0: [8086:8100] type 00 class 0x060000
pci 0000:00:02.0: [8086:8108] type 00 class 0x030000
pci 0000:00:02.0: reg 0x10: [mem 0xf3f80000-0xf3ffffff]
pci 0000:00:02.0: reg 0x14: [io  0xc880-0xc887]
pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff]
pci 0000:00:02.0: reg 0x1c: [mem 0xf3f40000-0xf3f7ffff]
pci 0000:00:1b.0: [8086:811b] type 00 class 0x040300
pci 0000:00:1b.0: reg 0x10: [mem 0xf3f38000-0xf3f3bfff 64bit]
pci 0000:00:1b.0: PME# supported from D0 D3hot
pci 0000:00:1c.0: [8086:8110] type 01 class 0x060400
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.1: [8086:8112] type 01 class 0x060400
pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.0: [8086:8114] type 00 class 0x0c0300
pci 0000:00:1d.0: reg 0x20: [io  0xb880-0xb89f]
pci 0000:00:1d.1: [8086:8115] type 00 class 0x0c0300
pci 0000:00:1d.1: reg 0x20: [io  0xc080-0xc09f]
pci 0000:00:1d.2: [8086:8116] type 00 class 0x0c0300
pci 0000:00:1d.2: reg 0x20: [io  0xc480-0xc49f]
pci 0000:00:1d.7: [8086:8117] type 00 class 0x0c0320
pci 0000:00:1d.7: reg 0x10: [mem 0xf3f37c00-0xf3f37fff]
pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1f.0: [8086:8119] type 00 class 0x060100
pci 0000:00:1f.1: [8086:811a] type 00 class 0x010180
pci 0000:00:1f.1: reg 0x20: [io  0xffa0-0xffaf]
pci 0000:00:1f.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
pci 0000:00:1f.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
pci 0000:00:1f.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
pci 0000:00:1f.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
pci 0000:03:00.0: [1969:1062] type 00 class 0x020000
pci 0000:03:00.0: reg 0x10: [mem 0xfbfc0000-0xfbffffff 64bit]
pci 0000:03:00.0: reg 0x18: [io  0xe880-0xe8ff]
pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:1c.0: PCI bridge to [bus 03]
pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:1c.0:   bridge window [mem 0xfbf00000-0xfbffffff]
pci 0000:01:00.0: [168c:002b] type 00 class 0x028000
pci 0000:01:00.0: reg 0x10: [mem 0xfbef0000-0xfbefffff 64bit]
pci 0000:01:00.0: supports D1
pci 0000:01:00.0: PME# supported from D0 D1 D3hot D3cold
pci 0000:00:1c.1: PCI bridge to [bus 01-02]
pci 0000:00:1c.1:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.1:   bridge window [mem 0xf4000000-0xfbefffff]
pci 0000:00:1c.1:   bridge window [mem 0xcc000000-0xcfffffff pref]
pci_bus 0000:00: on NUMA node 0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 *4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 *6 7 10 11 12 14 15)
ACPI: Enabled 2 GPEs in block 00 to 1F
ACPI : EC: event unblocked
ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0xd, EC_CMD/EC_SC=0x66, EC_DATA=0x62
ACPI: \_SB_.PCI0.SBRG.EC0_: Used as boot DSDT EC to handle transactions and events
SCSI subsystem initialized
libata version 3.00 loaded.
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
e820: reserve RAM buffer [mem 0x3f650000-0x3fffffff]
HPET: 3 timers in total, 0 timers will be used for per-cpu timer
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 comparators, 64-bit 14.318180 MHz counter
clocksource: Switched to clocksource hpet
hugetlbfs: disabling because there are no supported hugepage sizes
pnp: PnP ACPI init
system 00:00: [mem 0x40000000-0x7fffffff] has been reserved
system 00:00: [mem 0x3f800000-0x3fffffff] has been reserved
system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
pnp 00:02: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
system 00:03: [io  0x0374-0x0375] has been reserved
system 00:03: [io  0x03f4-0x03f5] has been reserved
system 00:03: [io  0x0380-0x0387] has been reserved
system 00:03: [io  0x09f4-0x09ff] has been reserved
system 00:03: [io  0x04d0-0x04d1] has been reserved
system 00:03: [io  0x0900-0x09f3] has been reserved
system 00:03: [io  0x0400-0x043f] has been reserved
system 00:03: [io  0x0480-0x04bf] has been reserved
system 00:03: [mem 0xf0000000-0xf0003fff] has been reserved
system 00:03: [mem 0x00000384-0x00000387] could not be reserved
system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
system 00:05: [mem 0xfec00000-0xfec00fff] could not be reserved
system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
pnp 00:06: Plug and Play ACPI device, IDs SYN0a13 SYN0a01 SYN0a04 SYN0002 PNP0f13 (active)
system 00:07: [mem 0xe0000000-0xefffffff] has been reserved
system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
system 00:08: [mem 0x00000000-0x0009ffff] could not be reserved
system 00:08: [mem 0x000c0000-0x000cffff] could not be reserved
system 00:08: [mem 0x000e0000-0x000fffff] could not be reserved
system 00:08: [mem 0x00100000-0x3f7fffff] could not be reserved
system 00:08: Plug and Play ACPI device, IDs PNP0c01 (active)
pnp: PnP ACPI: found 9 devices
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff pref] to [bus 03] add_size 200000 add_align 100000
pci 0000:00:1c.0: res[9]=[mem 0x00100000-0x000fffff pref] res_to_dev_res add_size 200000 min_align 100000
pci 0000:00:1c.0: res[9]=[mem 0x00100000-0x002fffff pref] res_to_dev_res add_size 200000 min_align 100000
pci 0000:00:1c.0: BAR 9: assigned [mem 0x80000000-0x801fffff pref]
pci 0000:00:1c.0: PCI bridge to [bus 03]
pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:1c.0:   bridge window [mem 0xfbf00000-0xfbffffff]
pci 0000:00:1c.0:   bridge window [mem 0x80000000-0x801fffff pref]
pci 0000:00:1c.1: PCI bridge to [bus 01-02]
pci 0000:00:1c.1:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.1:   bridge window [mem 0xf4000000-0xfbefffff]
pci 0000:00:1c.1:   bridge window [mem 0xcc000000-0xcfffffff pref]
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff window]
pci_bus 0000:00: resource 8 [mem 0x3f800000-0xdfffffff window]
pci_bus 0000:00: resource 9 [mem 0xf0000000-0xffffffff window]
pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
pci_bus 0000:03: resource 1 [mem 0xfbf00000-0xfbffffff]
pci_bus 0000:03: resource 2 [mem 0x80000000-0x801fffff pref]
pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
pci_bus 0000:01: resource 1 [mem 0xf4000000-0xfbefffff]
pci_bus 0000:01: resource 2 [mem 0xcc000000-0xcfffffff pref]
NET: Registered protocol family 2
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
pci 0000:03:00.0: [Firmware Bug]: disabling VPD access (can't determine size of non-standard VPD format)
PCI: CLS 32 bytes, default 64
futex hash table entries: 512 (order: 3, 32768 bytes)
workingset: timestamp_bits=14 max_order=18 bucket_order=4
Key type asymmetric registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler cfq registered (default)
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
vesafb: framebuffer at 0x3f800000, mapped to 0xf8400000, using 3072k, total 7872k
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [AC0] (on-line)
input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
ACPI: Lid Switch [LID]
input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
ACPI: Sleep Button [SLPB]
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
ACPI: Power Button [PWRB]
pata_sch 0000:00:1f.1: version 0.2
scsi host0: pata_sch
scsi host1: pata_sch
ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-pci 0000:00:1d.7: EHCI Host Controller
ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci-pci 0000:00:1d.7: debug port 1
ehci-pci 0000:00:1d.7: cache line size of 32 is not supported
ehci-pci 0000:00:1d.7: irq 19, io mem 0xf3f37c00
ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 4.10.0-rc2ho+ ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
uhci_hcd: USB Universal Host Controller Interface driver
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000b880
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 4.10.0-rc2ho+ uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ata1.00: ATA-9: WDC WD5000LPVX-00V0TT0, 01.01A01, max UDMA/133
ata1.00: 976773168 sectors, multi 16: LBA48 
ata1.00: configured for UDMA/100
ACPI: Battery Slot [BAT0] (battery present)
scsi 0:0:0:0: Direct-Access     ATA      WDC WD5000LPVX-0 1A01 PQ: 0 ANSI: 5
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 21, io base 0x0000c080
usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 4.10.0-rc2ho+ uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000c480
sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
sd 0:0:0:0: [sda] 4096-byte physical blocks
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sda: sda1 sda2
sd 0:0:0:0: [sda] Attached SCSI disk
usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
usb 1-1: new high-speed USB device number 2 using ehci-pci
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 4.10.0-rc2ho+ uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.2
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
rtc_cmos 00:01: RTC can wake from S4
rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
hidraw: raw HID events driver (C) Jiri Kosina
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
microcode: sig=0x106c2, pf=0x1, revision=0x0
microcode: Microcode Update Driver: v2.2.
Using IPI Shortcut mode
usb 1-1: New USB device found, idVendor=05ac, idProduct=1006
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: Keyboard Hub
usb 1-1: Manufacturer: Apple, Inc.
usb 1-1: SerialNumber: 000000000000
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 3 ports detected
random: fast init done
registered taskstats version 1
Key type big_key registered
Key type encrypted registered
usb 1-3: new high-speed USB device number 3 using ehci-pci
rtc_cmos 00:01: setting system clock to 2017-01-03 13:28:15 UTC (1483450095)
EXT4-fs (sda1): couldn't mount as ext3 due to feature incompatibilities
EXT4-fs (sda1): couldn't mount as ext2 due to feature incompatibilities
EXT4-fs (sda1): mounted filesystem without journal. Opts: (null)
VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
devtmpfs: mounted
Freeing unused kernel memory: 348K
Write protecting the kernel text: 4296k
usb 1-3: New USB device found, idVendor=05e3, idProduct=0608
usb 1-3: New USB device strings: Mfr=0, Product=1, SerialNumber=0
usb 1-3: Product: USB2.0 Hub
hub 1-3:1.0: USB hub found
hub 1-3:1.0: 4 ports detected
Write protecting the kernel read-only data: 1472k
usb 1-1.2: new low-speed USB device number 4 using ehci-pci
tsc: Refined TSC clocksource calibration: 1331.297 MHz
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x13309b1c550, max_idle_ns: 440795236824 ns
usb 1-1.2: New USB device found, idVendor=05ac, idProduct=0250
usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1.2: Product: Apple Keyboard
usb 1-1.2: Manufacturer: Apple Inc.
usb 1-4: new high-speed USB device number 5 using ehci-pci
usb 1-4: New USB device found, idVendor=12d1, idProduct=1001
usb 1-4: New USB device strings: Mfr=2, Product=1, SerialNumber=0
usb 1-4: Product: HUAWEI Mobile
usb 1-4: Manufacturer: HUAWEI Technology
usb 1-3.3: new high-speed USB device number 6 using ehci-pci
usb 1-3.3: New USB device found, idVendor=05e3, idProduct=0608
usb 1-3.3: New USB device strings: Mfr=0, Product=1, SerialNumber=0
usb 1-3.3: Product: USB2.0 Hub
hub 1-3.3:1.0: USB hub found
hub 1-3.3:1.0: 4 ports detected
random: crng init done
usb 4-2: new full-speed USB device number 2 using uhci_hcd
usb 4-2: New USB device found, idVendor=0b05, idProduct=b700
usb 4-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 4-2: Product: BT-253
usb 4-2: Manufacturer: Broadcom Corp
usb 4-2: SerialNumber: 002243FA5A5C
clocksource: Switched to clocksource tsc
usb 1-3.4: new high-speed USB device number 8 using ehci-pci
usb 1-3.4: New USB device found, idVendor=15a4, idProduct=9016
usb 1-3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-3.4: Product: DVB-T 2
usb 1-3.4: Manufacturer: Afatech
usb 1-3.4: SerialNumber: 010101010600001
Afatech DVB-T 2: Fixing fullspeed to highspeed interval: 10 -> 7
input: Afatech DVB-T 2 as /devices/pci0000:00/0000:00:1d.7/usb1/1-3/1-3.4/1-3.4:1.1/0003:15A4:9016.0003/input/input3
usb 1-7: new high-speed USB device number 9 using ehci-pci
hid-generic 0003:15A4:9016.0003: input,hidraw0: USB HID v1.01 Keyboard [Afatech DVB-T 2] on usb-0000:00:1d.7-3.4/input1
usb 1-7: New USB device found, idVendor=13d3, idProduct=5071
usb 1-7: New USB device strings: Mfr=2, Product=3, SerialNumber=0
usb 1-7: Product: USB2.0 UVC 1.3M WebCam
usb 1-7: Manufacturer: GenesysLogic Technology Co. III, Ltd.
usb 1-8: new high-speed USB device number 10 using ehci-pci
usb 1-8: New USB device found, idVendor=058f, idProduct=6335
usb 1-8: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-8: Product: Mass Storage Device
usb 1-8: Manufacturer: Generic
usb 1-8: SerialNumber: 058F63356336
NET: Registered protocol family 10
Segment Routing with IPv6
ip_tables: (C) 2000-2006 Netfilter Core Team
systemd[1]: systemd 232 running in system mode. (+PAM -AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
systemd[1]: Detected architecture x86.
systemd[1]: Set hostname to <gatosaldo>.
systemd[1]: [/usr/lib/systemd/system/rc-local.service:18] Support for option SysVStartPriority= has been removed and it is ignored
systemd[1]: Listening on Journal Socket.
systemd[1]: Started Forward Password Requests to Wall Directory Watch.
systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
systemd[1]: Listening on Journal Socket (/dev/log).
systemd[1]: Listening on Process Core Dump Socket.
EXT4-fs (sda1): re-mounted. Opts: nobarrier,noauto_da_alloc
systemd-journald[649]: Received request to flush runtime journal from PID 1
Bluetooth: Core ver 2.22
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM ver 1.11
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
Monitor-Mwait will be used to enter C-3 state
Monitor-Mwait will be used to enter C-3 state
tsc: Marking TSC unstable due to TSC halts in idle
clocksource: Switched to clocksource hpet
i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
thermal LNXTHERM:00: registered as thermal_zone0
wmi: Mapper loaded
ACPI: Thermal Zone [TZ00] (58 C)
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
atl1c 0000:03:00.0: version 1.0.1.1-NAPI
input: Apple Inc. Apple Keyboard as /devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1.2/1-1.2:1.0/0003:05AC:0250.0001/input/input4
apple 0003:05AC:0250.0001: input,hidraw1: USB HID v1.11 Keyboard [Apple Inc. Apple Keyboard] on usb-0000:00:1d.7-1.2/input0
input: Apple Inc. Apple Keyboard as /devices/pci0000:00/0000:00:1d.7/usb1/1-1/1-1.2/1-1.2:1.1/0003:05AC:0250.0002/input/input5
apple 0003:05AC:0250.0002: input,hidraw2: USB HID v1.11 Device [Apple Inc. Apple Keyboard] on usb-0000:00:1d.7-1.2/input1
usbcore: registered new interface driver btusb
media: Linux media interface: v0.10
usb-storage 1-4:1.0: USB Mass Storage device detected
usb-storage 1-4:1.1: USB Mass Storage device detected
usb-storage 1-4:1.2: USB Mass Storage device detected
usb-storage 1-8:1.0: USB Mass Storage device detected
scsi host2: usb-storage 1-8:1.0
usbcore: registered new interface driver usb-storage
Adding 2894868k swap on /dev/sda2.  Priority:-1 extents:1 across:2894868k 
usbcore: registered new interface driver usbserial
scsi 2:0:0:0: Direct-Access     Single   Flash Reader     1.00 PQ: 0 ANSI: 0
sd 2:0:0:0: [sdb] 124735488 512-byte logical blocks: (63.9 GB/59.5 GiB)
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] Mode Sense: 03 00 00 00
Linux video capture interface: v2.00
sd 2:0:0:0: [sdb] No Caching mode page found
sd 2:0:0:0: [sdb] Assuming drive cache: write through
usbcore: registered new interface driver option
usbcore: registered new interface driver uas
usbserial: USB Serial support registered for GSM modem (1-port)
option 1-4:1.0: GSM modem (1-port) converter detected
usb 1-4: GSM modem (1-port) converter now attached to ttyUSB0
option 1-4:1.1: GSM modem (1-port) converter detected
usb 1-4: GSM modem (1-port) converter now attached to ttyUSB1
option 1-4:1.2: GSM modem (1-port) converter detected
usb 1-4: GSM modem (1-port) converter now attached to ttyUSB2
  sdb: sdb1
sd 2:0:0:0: [sdb] Attached SCSI removable disk
usb 1-3.4: dvb_usb_v2: found a 'Afatech AF9015 reference design' in warm state
usb 1-3.4: dvb_usb_v2: will pass the complete MPEG2 transport stream to the software demuxer
dvbdev: DVB: registering new adapter (Afatech AF9015 reference design)
usb 1-3.4: media controller created
dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
atl1c 0000:03:00.0 enp3s0: renamed from eth0
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input6
i2c i2c-0: af9013: firmware version 5.24.0.0
usb 1-3.4: DVB: registering adapter 0 frontend 0 (Afatech AF9013)...
dvbdev: dvb_create_media_entity: media entity 'Afatech AF9013' registered.
i2c i2c-0: tda18218: NXP TDA18218HN successfully identified
usb 1-3.4: dvb_usb_v2: 'Afatech AF9015 reference design' successfully initialized and connected
usbcore: registered new interface driver dvb_usb_af9015
asus_wmi: ASUS WMI generic driver loaded
eeepc_wmi: Found legacy ATKD device (ASUS010)
eeepc_wmi: WMI device present, but legacy ATKD device is also present and enabled
eeepc_wmi: You probably booted with acpi_osi="Linux" or acpi_osi="!Windows 2009"
eeepc_wmi: Can't load eeepc-wmi, use default acpi_osi (preferred) or eeepc-laptop
eeepc-wmi: probe of eeepc-wmi failed with error -16
snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC269: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
snd_hda_codec_realtek hdaudioC0D0:    inputs:
snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
uvcvideo: Found UVC 1.00 device USB2.0 UVC 1.3M WebCam (13d3:5071)
uvcvideo 1-7:1.0: Entity type for entity Extension 2 was not initialized!
uvcvideo 1-7:1.0: Entity type for entity Processing 3 was not initialized!
uvcvideo 1-7:1.0: Entity type for entity Camera 1 was not initialized!
input: USB2.0 UVC 1.3M WebCam as /devices/pci0000:00/0000:00:1d.7/usb1/1-7/1-7:1.0/input/input9
usbcore: registered new interface driver uvcvideo
USB Video Class driver (1.1.1)
input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
input: HDA Intel MID Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
input: HDA Intel MID Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: BNEP socket layer initialized
ath: phy0: ASPM enabled: 0x42
ath: EEPROM regdomain: 0x60
ath: EEPROM indicates we should expect a direct regpair map
ath: Country alpha2 being used: 00
ath: Regpair used: 0x60
ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
ieee80211 phy0: Atheros AR9285 Rev:2 mem=0xf9920000, irq=17
ath9k 0000:01:00.0 wlp1s0: renamed from wlan0
EXT4-fs (sda1): re-mounted. Opts: nobarrier,noauto_da_alloc
atl1c 0000:03:00.0: atl1c: enp3s0 NIC Link is Up<100 Mbps Full Duplex>
NET: Registered protocol family 17
