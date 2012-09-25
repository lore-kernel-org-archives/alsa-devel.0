From: Joao Bonina <bonina_2001@yahoo.com>
Subject: UAC2 device recognized during boot but won't output
	sound
Date: Tue, 25 Sep 2012 10:22:42 -0700 (PDT)
Message-ID: <1348593762.69561.YahooMailNeo@web121602.mail.ne1.yahoo.com>
References: <1347984234-9275-1-git-send-email-fabio.estevam@freescale.com>
 <1347984234-9275-2-git-send-email-fabio.estevam@freescale.com>
 <20120925125311.GA7782@opensource.wolfsonmicro.com>
Reply-To: Joao Bonina <bonina_2001@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm27-vm2.bullet.mail.ne1.yahoo.com
 (nm27-vm2.bullet.mail.ne1.yahoo.com [98.138.91.215])
 by alsa0.perex.cz (Postfix) with SMTP id AE83A261741
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2012 19:22:44 +0200 (CEST)
In-Reply-To: <20120925125311.GA7782@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello all,

I've noticed a strange behaviour. My UAC2 device is recognized correctly du=
ring boot, but won't output any sound. Tried restarting alsa, but to no ava=
il.

Removing/inserting the snd-usb-audio module didn't produce any effect.

Only removing/inserting the device physically solved the problem.

I'm on the 3.2.17 kernel, with alsa 1.0.25.

Dmesg output is as follows:




[=A0=A0=A0 0.000000] Initializing cgroup subsys cpuset
[=A0=A0=A0 0.000000] Initializing cgroup subsys cpu
[=A0=A0=A0 0.000000] Linux version 3.2.17-rt28 (root@debian) (gcc version 4=
.4.5 (Debian 4.4.5-8) ) #1 PREEMPT RT Thu Aug 23 01:09:05 WEST 2012
[=A0=A0=A0 0.000000] KERNEL supported cpus:
[=A0=A0=A0 0.000000]=A0=A0 AMD AuthenticAMD
[=A0=A0=A0 0.000000] BIOS-provided physical RAM map:
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 0000000000000000 - 000000000009e800 (usa=
ble)
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 000000000009e800 - 00000000000a0000 (res=
erved)
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000000f0000 - 0000000000100000 (res=
erved)
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 0000000000100000 - 000000000f7b0000 (usa=
ble)
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 000000000f7b0000 - 000000000f7b3000 (ACP=
I NVS)
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 000000000f7b3000 - 000000000f7c0000 (ACP=
I data)
[=A0=A0=A0 0.000000]=A0 BIOS-e820: 00000000ffff0000 - 0000000100000000 (res=
erved)
[=A0=A0=A0 0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[=A0=A0=A0 0.000000] DMI not present or invalid.
[=A0=A0=A0 0.000000] e820 update range: 0000000000000000 - 0000000000010000=
 (usable) =3D=3D> (reserved)
[=A0=A0=A0 0.000000] e820 remove range: 00000000000a0000 - 0000000000100000=
 (usable)
[=A0=A0=A0 0.000000] last_pfn =3D 0xf7b0 max_arch_pfn =3D 0x100000
[=A0=A0=A0 0.000000] initial memory mapped : 0 - 01800000
[=A0=A0=A0 0.000000] Base memory trampoline at [c009d000] 9d000 size 4096
[=A0=A0=A0 0.000000] init_memory_mapping: 0000000000000000-000000000f7b0000
[=A0=A0=A0 0.000000]=A0 0000000000 - 0000400000 page 4k
[=A0=A0=A0 0.000000]=A0 0000400000 - 000f400000 page 2M
[=A0=A0=A0 0.000000]=A0 000f400000 - 000f7b0000 page 4k
[=A0=A0=A0 0.000000] kernel direct mapping tables up to f7b0000 @ 17fb000-1=
800000
[=A0=A0=A0 0.000000] RAMDISK: 0b7c1000 - 0ba04000
[=A0=A0=A0 0.000000] ACPI: RSDP 000f6370 00014 (v00 AMDGX3)
[=A0=A0=A0 0.000000] ACPI: RSDT 0f7b3040 00028 (v01 AMDGX3 AWRDACPI 42302E3=
1 AWRD 00000000)
[=A0=A0=A0 0.000000] ACPI: FACP 0f7b30c0 00074 (v01 AMDGX3 AWRDACPI 42302E3=
1 AWRD 00000000)
[=A0=A0=A0 0.000000] ACPI Warning: Invalid length for Pm2ControlBlock: 16, =
using default 8 (20110623/tbfadt-610)
[=A0=A0=A0 0.000000] ACPI: DSDT 0f7b3180 02C19 (v01 AMDGX3 AWRDACPI 0000100=
0 MSFT 03000000)
[=A0=A0=A0 0.000000] ACPI: FACS 0f7b0000 00040
[=A0=A0=A0 0.000000] 0MB HIGHMEM available.
[=A0=A0=A0 0.000000] 247MB LOWMEM available.
[=A0=A0=A0 0.000000]=A0=A0 mapped low ram: 0 - 0f7b0000
[=A0=A0=A0 0.000000]=A0=A0 low ram: 0 - 0f7b0000
[=A0=A0=A0 0.000000] Zone PFN ranges:
[=A0=A0=A0 0.000000]=A0=A0 DMA=A0=A0=A0=A0=A0 0x00000010 -> 0x00001000
[=A0=A0=A0 0.000000]=A0=A0 Normal=A0=A0 0x00001000 -> 0x0000f7b0
[=A0=A0=A0 0.000000]=A0=A0 HighMem=A0 empty
[=A0=A0=A0 0.000000] Movable zone start PFN for each node
[=A0=A0=A0 0.000000] early_node_map[2] active PFN ranges
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 0: 0x00000010 -> 0x0000009e
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 0: 0x00000100 -> 0x0000f7b0
[=A0=A0=A0 0.000000] On node 0 totalpages: 63294
[=A0=A0=A0 0.000000] free_area_init_node: node 0, pgdat c1329a60, node_mem_=
map cf5bf200
[=A0=A0=A0 0.000000]=A0=A0 DMA zone: 32 pages used for memmap
[=A0=A0=A0 0.000000]=A0=A0 DMA zone: 0 pages reserved
[=A0=A0=A0 0.000000]=A0=A0 DMA zone: 3950 pages, LIFO batch:0
[=A0=A0=A0 0.000000]=A0=A0 Normal zone: 464 pages used for memmap
[=A0=A0=A0 0.000000]=A0=A0 Normal zone: 58848 pages, LIFO batch:15
[=A0=A0=A0 0.000000] ACPI: PM-Timer IO Port: 0x9c10
[=A0=A0=A0 0.000000] Allocating PCI resources starting at f7c0000 (gap: f7c=
0000:f0830000)
[=A0=A0=A0 0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
[=A0=A0=A0 0.000000] pcpu-alloc: [0] 0 =

[=A0=A0=A0 0.000000] Built 1 zonelists in Zone order, mobility grouping on.=
=A0 Total pages: 62798
[=A0=A0=A0 0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-3.2.17=
-rt28 root=3DUUID=3Ddb00af1b-7a21-4968-9087-92bb7cb92ee0 ro quiet clocksour=
ce=3Dacpi_pm maxcpus=3D1
[=A0=A0=A0 0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[=A0=A0=A0 0.000000] Dentry cache hash table entries: 32768 (order: 5, 1310=
72 bytes)
[=A0=A0=A0 0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536=
 bytes)
[=A0=A0=A0 0.000000] Initializing CPU#0
[=A0=A0=A0 0.000000] Initializing HighMem for node 0 (00000000:00000000)
[=A0=A0=A0 0.000000] Memory: 244808k/253632k available (2154k kernel code, =
8368k reserved, 1101k data, 260k init, 0k highmem)
[=A0=A0=A0 0.000000] virtual kernel memory layout:
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 fixmap=A0 : 0xfffe5000 - 0xfffff000=A0=A0 =
( 104 kB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 pkmap=A0=A0 : 0xff800000 - 0xffc00000=A0=
=A0 (4096 kB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 vmalloc : 0xcffb0000 - 0xff7fe000=A0=A0 ( =
760 MB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0 lowmem=A0 : 0xc0000000 - 0xcf7b0000=A0=A0 =
( 247 MB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0=A0=A0 .init : 0xc132e000 - 0xc136f000=A0=
=A0 ( 260 kB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0=A0=A0 .data : 0xc121ab05 - 0xc132e000=A0=
=A0 (1101 kB)
[=A0=A0=A0 0.000000]=A0=A0=A0=A0=A0=A0 .text : 0xc1000000 - 0xc121ab05=A0=
=A0 (2154 kB)
[=A0=A0=A0 0.000000] Checking if this processor honours the WP bit even in =
supervisor mode...Ok.
[=A0=A0=A0 0.000000] NR_IRQS:16 nr_irqs:16 16
[=A0=A0=A0 0.000000] CPU 0 irqstacks, hard=3Dcf008000 soft=3Dcf00a000
[=A0=A0=A0 0.000000] Console: colour VGA+ 80x25
[=A0=A0=A0 0.000000] console [tty0] enabled
[=A0=A0=A0 0.000000] Fast TSC calibration using PIT
[=A0=A0=A0 0.000000] Detected 498.079 MHz processor.
[=A0=A0=A0 0.001005] Calibrating delay loop (skipped), value calculated usi=
ng timer frequency.. 996.15 BogoMIPS (lpj=3D498079)
[=A0=A0=A0 0.001033] pid_max: default: 32768 minimum: 301
[=A0=A0=A0 0.001333] Mount-cache hash table entries: 512
[=A0=A0=A0 0.002233] Initializing cgroup subsys cpuacct
[=A0=A0=A0 0.002252] Initializing cgroup subsys devices
[=A0=A0=A0 0.002266] Initializing cgroup subsys freezer
[=A0=A0=A0 0.002279] Initializing cgroup subsys net_cls
[=A0=A0=A0 0.002396] CPU: Geode(TM) Integrated Processor by AMD PCS steppin=
g 02
[=A0=A0=A0 0.002469] ACPI: Core revision 20110623
[=A0=A0=A0 0.012197] ACPI: setting ELCR to 0200 (from 0c20)
[=A0=A0=A0 0.014141] Performance Events: no PMU driver, software events onl=
y.
[=A0=A0=A0 0.015182] devtmpfs: initialized
[=A0=A0=A0 0.015938] print_constraints: dummy: =

[=A0=A0=A0 0.016206] NET: Registered protocol family 16
[=A0=A0=A0 0.016615] ACPI: bus type pci registered
[=A0=A0=A0 0.018189] PCI: PCI BIOS revision 2.10 entry at 0xfa980, last bus=
=3D0
[=A0=A0=A0 0.021456] bio: create slab <bio-0> at 0
[=A0=A0=A0 0.021787] ACPI: Added _OSI(Module Device)
[=A0=A0=A0 0.021802] ACPI: Added _OSI(Processor Device)
[=A0=A0=A0 0.021816] ACPI: Added _OSI(3.0 _SCP Extensions)
[=A0=A0=A0 0.021832] ACPI: Added _OSI(Processor Aggregator Device)
[=A0=A0=A0 0.027790] ACPI: EC: Look up EC in DSDT
[=A0=A0=A0 0.039951] ACPI: Interpreter enabled
[=A0=A0=A0 0.039963] ACPI: (supports S0 S5)
[=A0=A0=A0 0.040055] ACPI: Using PIC for interrupt routing
[=A0=A0=A0 0.056047] PCI: Using host bridge windows from ACPI; if necessary=
, use "pci=3Dnocrs" and report a bug
[=A0=A0=A0 0.056390] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[=A0=A0=A0 0.057140] pci_root PNP0A03:00: host bridge window [io=A0 0x0000-=
0x0cf7]
[=A0=A0=A0 0.057162] pci_root PNP0A03:00: host bridge window [io=A0 0x0d00-=
0xac17]
[=A0=A0=A0 0.057182] pci_root PNP0A03:00: host bridge window [io=A0 0xac20-=
0xffff]
[=A0=A0=A0 0.057204] pci_root PNP0A03:00: host bridge window [mem 0x000a000=
0-0x000bffff]
[=A0=A0=A0 0.057225] pci_root PNP0A03:00: host bridge window [mem 0x000c800=
0-0x000dffff]
[=A0=A0=A0 0.057247] pci_root PNP0A03:00: host bridge window [mem 0x0f7c000=
0-0xfebfffff]
[=A0=A0=A0 0.057426] pci 0000:00:01.0: [1022:2080] type 0 class 0x000600
[=A0=A0=A0 0.057589] pci 0000:00:01.0: reg 10: [io=A0 0xac1c-0xac1f]
[=A0=A0=A0 0.057718] pci 0000:00:01.0: reg 14: [io=A0 0x9e00-0x9e07]
[=A0=A0=A0 0.058622] pci 0000:00:01.1: [1022:2081] type 0 class 0x000300
[=A0=A0=A0 0.059025] pci 0000:00:01.1: reg 10: [mem 0xee000000-0xeeffffff]
[=A0=A0=A0 0.059324] pci 0000:00:01.1: reg 14: [mem 0xefff4000-0xefff7fff]
[=A0=A0=A0 0.059622] pci 0000:00:01.1: reg 18: [mem 0xefff0000-0xefff3fff]
[=A0=A0=A0 0.059919] pci 0000:00:01.1: reg 1c: [mem 0xeffec000-0xeffeffff]
[=A0=A0=A0 0.060270] pci 0000:00:01.1: reg 20: [mem 0xeffe8000-0xeffebfff]
[=A0=A0=A0 0.061183] pci 0000:00:01.2: [1022:2082] type 0 class 0x001010
[=A0=A0=A0 0.061528] pci 0000:00:01.2: reg 10: [mem 0xefff8000-0xefffbfff]
[=A0=A0=A0 0.063446] pci 0000:00:0c.0: [1033:0035] type 0 class 0x000c03
[=A0=A0=A0 0.063542] pci 0000:00:0c.0: reg 10: [mem 0xeffff000-0xefffffff]
[=A0=A0=A0 0.063889] pci 0000:00:0c.0: supports D1 D2
[=A0=A0=A0 0.063907] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot
[=A0=A0=A0 0.063937] pci 0000:00:0c.0: PME# disabled
[=A0=A0=A0 0.064083] pci 0000:00:0c.1: [1033:00e0] type 0 class 0x000c03
[=A0=A0=A0 0.064179] pci 0000:00:0c.1: reg 10: [mem 0xefffe000-0xefffe0ff]
[=A0=A0=A0 0.064527] pci 0000:00:0c.1: supports D1 D2
[=A0=A0=A0 0.064544] pci 0000:00:0c.1: PME# supported from D0 D1 D2 D3hot
[=A0=A0=A0 0.064573] pci 0000:00:0c.1: PME# disabled
[=A0=A0=A0 0.064707] pci 0000:00:0d.0: [1106:3053] type 0 class 0x000200
[=A0=A0=A0 0.064803] pci 0000:00:0d.0: reg 10: [io=A0 0xfc00-0xfcff]
[=A0=A0=A0 0.064866] pci 0000:00:0d.0: reg 14: [mem 0xefffd000-0xefffd0ff]
[=A0=A0=A0 0.065202] pci 0000:00:0d.0: supports D1 D2
[=A0=A0=A0 0.065220] pci 0000:00:0d.0: PME# supported from D0 D1 D2 D3hot D=
3cold
[=A0=A0=A0 0.065250] pci 0000:00:0d.0: PME# disabled
[=A0=A0=A0 0.065428] pci 0000:00:0f.0: [1022:2090] type 0 class 0x000601
[=A0=A0=A0 0.065829] pci 0000:00:0f.0: reg 10: [io=A0 0x6000-0x6007]
[=A0=A0=A0 0.066194] pci 0000:00:0f.0: reg 14: [io=A0 0x6100-0x61ff]
[=A0=A0=A0 0.066536] pci 0000:00:0f.0: reg 18: [io=A0 0x6200-0x623f]
[=A0=A0=A0 0.066878] pci 0000:00:0f.0: reg 1c: [io=A0 0x0000-0x001f]
[=A0=A0=A0 0.067227] pci 0000:00:0f.0: reg 20: [io=A0 0x9d00-0x9d7f]
[=A0=A0=A0 0.067587] pci 0000:00:0f.0: reg 24: [io=A0 0x9c00-0x9c3f]
[=A0=A0=A0 0.068320] pci 0000:00:0f.2: [1022:209a] type 0 class 0x000101
[=A0=A0=A0 0.069710] pci 0000:00:0f.2: reg 20: [io=A0 0xff00-0xff0f]
[=A0=A0=A0 0.070710] pci 0000:00:0f.5: [1022:2095] type 0 class 0x000c03
[=A0=A0=A0 0.071207] pci 0000:00:0f.5: reg 10: [mem 0xefffc000-0xefffcfff]
[=A0=A0=A0 0.073185] pci 0000:00:0f.5: PME# supported from D0 D3hot D3cold
[=A0=A0=A0 0.073287] pci 0000:00:0f.5: PME# disabled
[=A0=A0=A0 0.073565] pci_bus 0000:00: on NUMA node 0
[=A0=A0=A0 0.073585] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[=A0=A0=A0 0.074293]=A0 pci0000:00: Unable to request _OSC control (_OSC su=
pport mask: 0x08)
[=A0=A0=A0 0.084172] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[=A0=A0=A0 0.084973] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 10 *11)
[=A0=A0=A0 0.085777] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 11) *0
[=A0=A0=A0 0.086568] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 11) *0
[=A0=A0=A0 0.087323] PCI: Using ACPI for IRQ routing
[=A0=A0=A0 0.087339] PCI: pci_cache_line_size set to 32 bytes
[=A0=A0=A0 0.087399] pci 0000:00:01.0: no compatible bridge window for [io=
=A0 0xac1c-0xac1f]
[=A0=A0=A0 0.087865] reserve RAM buffer: 000000000009e800 - 000000000009fff=
f =

[=A0=A0=A0 0.087884] reserve RAM buffer: 000000000f7b0000 - 000000000ffffff=
f =

[=A0=A0=A0 0.088473] Switching to clocksource pit
[=A0=A0=A0 0.088683] pnp: PnP ACPI init
[=A0=A0=A0 0.088741] ACPI: bus type pnp registered
[=A0=A0=A0 0.088741] pnp 00:00: [mem 0x000f0000-0x000fffff]
[=A0=A0=A0 0.088741] pnp 00:00: [mem 0x0f7b0000-0x0f7bffff]
[=A0=A0=A0 0.088741] pnp 00:00: [mem 0xffff0000-0xffffffff]
[=A0=A0=A0 0.088741] pnp 00:00: [mem 0x00000000-0x0009ffff]
[=A0=A0=A0 0.088741] pnp 00:00: [mem 0x00100000-0x0f7affff]
[=A0=A0=A0 0.088741] pnp 00:00: [mem 0xfee00000-0xfee00fff]
[=A0=A0=A0 0.088963] system 00:00: [mem 0x000f0000-0x000fffff] could not be=
 reserved
[=A0=A0=A0 0.088988] system 00:00: [mem 0x0f7b0000-0x0f7bffff] could not be=
 reserved
[=A0=A0=A0 0.089012] system 00:00: [mem 0xffff0000-0xffffffff] has been res=
erved
[=A0=A0=A0 0.089035] system 00:00: [mem 0x00000000-0x0009ffff] could not be=
 reserved
[=A0=A0=A0 0.089060] system 00:00: [mem 0x00100000-0x0f7affff] could not be=
 reserved
[=A0=A0=A0 0.089084] system 00:00: [mem 0xfee00000-0xfee00fff] has been res=
erved
[=A0=A0=A0 0.089109] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (=
active)
[=A0=A0=A0 0.089590] pnp 00:01: [bus 00-ff]
[=A0=A0=A0 0.089607] pnp 00:01: [io=A0 0x0cf8-0x0cff]
[=A0=A0=A0 0.089625] pnp 00:01: [io=A0 0x0000-0x0cf7 window]
[=A0=A0=A0 0.089643] pnp 00:01: [io=A0 0x0d00-0xac17 window]
[=A0=A0=A0 0.089662] pnp 00:01: [io=A0 0xac20-0xffff window]
[=A0=A0=A0 0.089681] pnp 00:01: [mem 0x000a0000-0x000bffff window]
[=A0=A0=A0 0.089700] pnp 00:01: [mem 0x000c8000-0x000dffff window]
[=A0=A0=A0 0.089720] pnp 00:01: [mem 0x0f7c0000-0xfebfffff window]
[=A0=A0=A0 0.089911] pnp 00:01: Plug and Play ACPI device, IDs PNP0a03 (act=
ive)
[=A0=A0=A0 0.091114] pnp 00:02: [io=A0 0x0010-0x001f]
[=A0=A0=A0 0.091132] pnp 00:02: [io=A0 0x0022-0x002d]
[=A0=A0=A0 0.091149] pnp 00:02: [io=A0 0x0030-0x003f]
[=A0=A0=A0 0.091166] pnp 00:02: [io=A0 0x0044-0x005f]
[=A0=A0=A0 0.091183] pnp 00:02: [io=A0 0x0062-0x0063]
[=A0=A0=A0 0.091200] pnp 00:02: [io=A0 0x0065-0x006f]
[=A0=A0=A0 0.091216] pnp 00:02: [io=A0 0x0074-0x007f]
[=A0=A0=A0 0.091233] pnp 00:02: [io=A0 0x0091-0x0093]
[=A0=A0=A0 0.091250] pnp 00:02: [io=A0 0x00a2-0x00bf]
[=A0=A0=A0 0.091276] pnp 00:02: [io=A0 0x00e0-0x00ef]
[=A0=A0=A0 0.091293] pnp 00:02: [io=A0 0x0b78-0x0b7b]
[=A0=A0=A0 0.091309] pnp 00:02: [io=A0 0x0f78-0x0f7b]
[=A0=A0=A0 0.091326] pnp 00:02: [io=A0 0x0a78-0x0a7b]
[=A0=A0=A0 0.091343] pnp 00:02: [io=A0 0x0e78-0x0e7b]
[=A0=A0=A0 0.091360] pnp 00:02: [io=A0 0x0bbc-0x0bbf]
[=A0=A0=A0 0.091377] pnp 00:02: [io=A0 0x0fbc-0x0fbf]
[=A0=A0=A0 0.091394] pnp 00:02: [io=A0 0x04d0-0x04d1]
[=A0=A0=A0 0.091491] pnp 00:02: disabling [io=A0 0x0010-0x001f] because it =
overlaps 0000:00:0f.0 BAR 3 [io=A0 0x0000-0x001f]
[=A0=A0=A0 0.091798] system 00:02: [io=A0 0x0b78-0x0b7b] has been reserved
[=A0=A0=A0 0.091820] system 00:02: [io=A0 0x0f78-0x0f7b] has been reserved
[=A0=A0=A0 0.091843] system 00:02: [io=A0 0x0a78-0x0a7b] has been reserved
[=A0=A0=A0 0.091865] system 00:02: [io=A0 0x0e78-0x0e7b] has been reserved
[=A0=A0=A0 0.091887] system 00:02: [io=A0 0x0bbc-0x0bbf] has been reserved
[=A0=A0=A0 0.091910] system 00:02: [io=A0 0x0fbc-0x0fbf] has been reserved
[=A0=A0=A0 0.091932] system 00:02: [io=A0 0x04d0-0x04d1] has been reserved
[=A0=A0=A0 0.091956] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (=
active)
[=A0=A0=A0 0.092036] pnp 00:03: [dma 4]
[=A0=A0=A0 0.092052] pnp 00:03: [io=A0 0x0000-0x000f]
[=A0=A0=A0 0.092069] pnp 00:03: [io=A0 0x0080-0x0090]
[=A0=A0=A0 0.092086] pnp 00:03: [io=A0 0x0094-0x009f]
[=A0=A0=A0 0.092103] pnp 00:03: [io=A0 0x00c0-0x00df]
[=A0=A0=A0 0.092276] pnp 00:03: Plug and Play ACPI device, IDs PNP0200 (act=
ive)
[=A0=A0=A0 0.092348] pnp 00:04: [io=A0 0x0070-0x0073]
[=A0=A0=A0 0.092366] pnp 00:04: [irq 8]
[=A0=A0=A0 0.092606] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (act=
ive)
[=A0=A0=A0 0.092667] pnp 00:05: [io=A0 0x0061]
[=A0=A0=A0 0.092846] pnp 00:05: Plug and Play ACPI device, IDs PNP0800 (act=
ive)
[=A0=A0=A0 0.092907] pnp 00:06: [io=A0 0x00f0-0x00ff]
[=A0=A0=A0 0.092924] pnp 00:06: [irq 13]
[=A0=A0=A0 0.093104] pnp 00:06: Plug and Play ACPI device, IDs PNP0c04 (act=
ive)
[=A0=A0=A0 0.095256] pnp 00:07: [io=A0 0x03f8-0x03ff]
[=A0=A0=A0 0.095274] pnp 00:07: [irq 4]
[=A0=A0=A0 0.095736] pnp 00:07: Plug and Play ACPI device, IDs PNP0501 (act=
ive)
[=A0=A0=A0 0.096757] pnp 00:08: [io=A0 0x02f8-0x02ff]
[=A0=A0=A0 0.096775] pnp 00:08: [irq 3]
[=A0=A0=A0 0.097168] pnp 00:08: Plug and Play ACPI device, IDs PNP0501 (act=
ive)
[=A0=A0=A0 0.098919] pnp 00:09: [io=A0 0x0378-0x037f]
[=A0=A0=A0 0.098936] pnp 00:09: [io=A0 0x0778-0x077b]
[=A0=A0=A0 0.098953] pnp 00:09: [irq 7]
[=A0=A0=A0 0.099337] pnp 00:09: Plug and Play ACPI device, IDs PNP0400 (act=
ive)
[=A0=A0=A0 0.099985] pnp: PnP ACPI: found 10 devices
[=A0=A0=A0 0.099998] ACPI: ACPI bus type pnp unregistered
[=A0=A0=A0 0.146822] Switching to clocksource acpi_pm
[=A0=A0=A0 0.146888] PCI: max bus depth: 0 pci_try_num: 1
[=A0=A0=A0 0.146941] pci 0000:00:0f.0: BAR 3: assigned [io=A0 0x1000-0x101f]
[=A0=A0=A0 0.147039] pci 0000:00:0f.0: BAR 3: set to [io=A0 0x1000-0x101f] =
(PCI address [0x1000-0x101f])
[=A0=A0=A0 0.147066] pci_bus 0000:00: resource 4 [io=A0 0x0000-0x0cf7]
[=A0=A0=A0 0.147086] pci_bus 0000:00: resource 5 [io=A0 0x0d00-0xac17]
[=A0=A0=A0 0.147107] pci_bus 0000:00: resource 6 [io=A0 0xac20-0xffff]
[=A0=A0=A0 0.147127] pci_bus 0000:00: resource 7 [mem 0x000a0000-0x000bffff]
[=A0=A0=A0 0.147149] pci_bus 0000:00: resource 8 [mem 0x000c8000-0x000dffff]
[=A0=A0=A0 0.147170] pci_bus 0000:00: resource 9 [mem 0x0f7c0000-0xfebfffff]
[=A0=A0=A0 0.147365] NET: Registered protocol family 2
[=A0=A0=A0 0.147596] IP route cache hash table entries: 2048 (order: 1, 819=
2 bytes)
[=A0=A0=A0 0.148092] TCP established hash table entries: 8192 (order: 4, 65=
536 bytes)
[=A0=A0=A0 0.148344] TCP bind hash table entries: 8192 (order: 5, 196608 by=
tes)
[=A0=A0=A0 0.149066] TCP: Hash tables configured (established 8192 bind 819=
2)
[=A0=A0=A0 0.149081] TCP reno registered
[=A0=A0=A0 0.149099] UDP hash table entries: 128 (order: 1, 8192 bytes)
[=A0=A0=A0 0.149172] UDP-Lite hash table entries: 128 (order: 1, 8192 bytes)
[=A0=A0=A0 0.149456] NET: Registered protocol family 1
[=A0=A0=A0 0.149575] pci 0000:00:01.1: Boot video device
[=A0=A0=A0 0.151825] ACPI: PCI Interrupt Link [LNKC] BIOS reported IRQ 0, u=
sing IRQ 11
[=A0=A0=A0 0.151844] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
[=A0=A0=A0 0.151859] PCI: setting IRQ 11 as level-triggered
[=A0=A0=A0 0.151886] pci 0000:00:0c.0: PCI INT A -> Link[LNKC] -> GSI 11 (l=
evel, low) -> IRQ 11
[=A0=A0=A0 0.151963] pci 0000:00:0c.0: PCI INT A disabled
[=A0=A0=A0 0.152014] pci 0000:00:0c.1: PCI INT A -> Link[LNKC] -> GSI 11 (l=
evel, low) -> IRQ 11
[=A0=A0=A0 0.152136] pci 0000:00:0c.1: PCI INT A disabled
[=A0=A0=A0 0.154327] ACPI: PCI Interrupt Link [LNKD] BIOS reported IRQ 0, u=
sing IRQ 10
[=A0=A0=A0 0.154346] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
[=A0=A0=A0 0.154360] PCI: setting IRQ 10 as level-triggered
[=A0=A0=A0 0.154386] pci 0000:00:0f.5: PCI INT D -> Link[LNKD] -> GSI 10 (l=
evel, low) -> IRQ 10
[=A0=A0=A0 0.154605] pci 0000:00:0f.5: PCI INT D disabled
[=A0=A0=A0 0.154652] PCI: CLS 32 bytes, default 32
[=A0=A0=A0 0.154935] Unpacking initramfs...
[=A0=A0=A0 0.624071] Freeing initrd memory: 2316k freed
[=A0=A0=A0 0.627274] scx200: NatSemi SCx200 Driver
[=A0=A0=A0 0.627953] audit: initializing netlink socket (disabled)
[=A0=A0=A0 0.627998] type=3D2000 audit(1348592489.626:1): initialized
[=A0=A0=A0 0.814907] HugeTLB registered 4 MB page size, pre-allocated 0 pag=
es
[=A0=A0=A0 0.815553] VFS: Disk quotas dquot_6.5.2
[=A0=A0=A0 0.815610] Dquot-cache hash table entries: 1024 (order 0, 4096 by=
tes)
[=A0=A0=A0 0.816130] msgmni has been set to 482
[=A0=A0=A0 0.816741] Block layer SCSI generic (bsg) driver version 0.4 load=
ed (major 253)
[=A0=A0=A0 0.816759] io scheduler noop registered
[=A0=A0=A0 0.816772] io scheduler deadline registered
[=A0=A0=A0 0.816834] io scheduler cfq registered (default)
[=A0=A0=A0 0.898318] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[=A0=A0=A0 0.919204] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[=A0=A0=A0 0.940086] serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
[=A0=A0=A0 0.962414] 00:07: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[=A0=A0=A0 0.983856] 00:08: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
[=A0=A0=A0 0.985301] i8042: PNP: No PS/2 controller found. Probing ports di=
rectly.
[=A0=A0=A0 0.987873] serio: i8042 KBD port at 0x60,0x64 irq 1
[=A0=A0=A0 0.987904] serio: i8042 AUX port at 0x60,0x64 irq 12
[=A0=A0=A0 0.989277] rtc_cmos 00:04: RTC can wake from S4
[=A0=A0=A0 0.989613] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[=A0=A0=A0 0.989769] rtc0: alarms up to one day, 242 bytes nvram
[=A0=A0=A0 0.990333] rtc-test rtc-test.0: rtc core: registered test as rtc1
[=A0=A0=A0 0.990688] rtc-test rtc-test.1: rtc core: registered test as rtc2
[=A0=A0=A0 0.990717] cpuidle: using governor ladder
[=A0=A0=A0 0.991200] TCP cubic registered
[=A0=A0=A0 0.991365] NET: Registered protocol family 10
[=A0=A0=A0 0.992100] Mobile IPv6
[=A0=A0=A0 0.992115] NET: Registered protocol family 17
[=A0=A0=A0 0.992140] Registering the dns_resolver key type
[=A0=A0=A0 0.992699] registered taskstats version 1
[=A0=A0=A0 0.993897] rtc_cmos 00:04: setting system clock to 2012-09-25 17:=
01:30 UTC (1348592490)
[=A0=A0=A0 0.994963] Freeing unused kernel memory: 260k freed
[=A0=A0=A0 0.995576] Write protecting the kernel text: 2156k
[=A0=A0=A0 0.995712] Write protecting the kernel read-only data: 936k
[=A0=A0=A0 1.087364] udev[45]: starting version 164
[=A0=A0=A0 1.632099] Refined TSC clocksource calibration: 498.050 MHz.
[=A0=A0=A0 1.886435] SCSI subsystem initialized
[=A0=A0=A0 2.404247] libata version 3.00 loaded.
[=A0=A0=A0 2.408866] pata_amd 0000:00:0f.2: version 0.4.1
[=A0=A0=A0 2.446107] scsi0 : pata_amd
[=A0=A0=A0 2.451097] scsi1 : pata_amd
[=A0=A0=A0 2.454916] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff=
00 irq 14
[=A0=A0=A0 2.454937] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff=
08 irq 15
[=A0=A0=A0 2.621389] ata1.00: CFA: TS4GCF133, 20110407, max UDMA/66
[=A0=A0=A0 2.621411] ata1.00: 7831152 sectors, multi 0: LBA =

[=A0=A0=A0 2.621579] ata1.01: ATA-9: INTEL SSDSC2CT120A3, 300i, max UDMA/133
[=A0=A0=A0 2.621601] ata1.01: 234441648 sectors, multi 16: LBA48 =

[=A0=A0=A0 2.628291] ata1.00: configured for UDMA/66
[=A0=A0=A0 2.647651] ata1.01: configured for UDMA/100
[=A0=A0=A0 2.648111] scsi 0:0:0:0: Direct-Access=A0=A0=A0=A0 ATA=A0=A0=A0=
=A0=A0 TS4GCF133=A0=A0=A0=A0=A0=A0=A0 2011 PQ: 0 ANSI: 5
[=A0=A0=A0 2.649923] scsi 0:0:1:0: Direct-Access=A0=A0=A0=A0 ATA=A0=A0=A0=
=A0=A0 INTEL SSDSC2CT12 300i PQ: 0 ANSI: 5
[=A0=A0=A0 2.652167] ata2: port disabled--ignoring
[=A0=A0=A0 2.700497] sd 0:0:0:0: [sda] 7831152 512-byte logical blocks: (4.=
00 GB/3.73 GiB)
[=A0=A0=A0 2.700751] sd 0:0:0:0: [sda] Write Protect is off
[=A0=A0=A0 2.700773] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[=A0=A0=A0 2.700886] sd 0:0:0:0: [sda] Write cache: disabled, read cache: e=
nabled, doesn't support DPO or FUA
[=A0=A0=A0 2.704792]=A0 sda: sda1 sda2
[=A0=A0=A0 2.707134] sd 0:0:0:0: [sda] Attached SCSI removable disk
[=A0=A0=A0 2.707369] sd 0:0:1:0: [sdb] 234441648 512-byte logical blocks: (=
120 GB/111 GiB)
[=A0=A0=A0 2.707701] sd 0:0:1:0: [sdb] Write Protect is off
[=A0=A0=A0 2.707722] sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
[=A0=A0=A0 2.707834] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: en=
abled, doesn't support DPO or FUA
[=A0=A0=A0 2.793599] ata1: drained 65536 bytes to clear DRQ
[=A0=A0=A0 2.793634] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action =
0x6 frozen
[=A0=A0=A0 2.793653] ata1.01: BMDMA stat 0x65
[=A0=A0=A0 2.793673] ata1.01: failed command: READ DMA
[=A0=A0=A0 2.793726] ata1.01: cmd c8/00:08:00:00:00/00:00:00:00:00/f0 tag 0=
 dma 4096 in
[=A0=A0=A0 2.793738]=A0=A0=A0=A0=A0=A0=A0=A0=A0 res 0a/0a:0a:0a:0a:0a/00:00=
:00:00:00/0a Emask 0x2 (HSM violation)
[=A0=A0=A0 2.796349] ata1.01: status: { DRQ }
[=A0=A0=A0 2.797079] ata1: soft resetting link
[=A0=A0=A0 3.181286] ata1.00: configured for UDMA/66
[=A0=A0=A0 3.200638] ata1.01: configured for UDMA/100
[=A0=A0=A0 3.200675] ata1: EH complete
[=A0=A0=A0 3.286076] ata1: drained 65536 bytes to clear DRQ
[=A0=A0=A0 3.286107] ata1.01: limiting speed to UDMA/66:PIO4
[=A0=A0=A0 3.286131] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action =
0x6 frozen
[=A0=A0=A0 3.286149] ata1.01: BMDMA stat 0x65
[=A0=A0=A0 3.286170] ata1.01: failed command: READ DMA
[=A0=A0=A0 3.286222] ata1.01: cmd c8/00:08:00:00:00/00:00:00:00:00/f0 tag 0=
 dma 4096 in
[=A0=A0=A0 3.286235]=A0=A0=A0=A0=A0=A0=A0=A0=A0 res 0a/0a:0a:0a:0a:0a/00:00=
:00:00:00/0a Emask 0x2 (HSM violation)
[=A0=A0=A0 3.286256] ata1.01: status: { DRQ }
[=A0=A0=A0 3.286928] ata1: soft resetting link
[=A0=A0=A0 3.671283] ata1.00: configured for UDMA/66
[=A0=A0=A0 3.690657] ata1.01: configured for UDMA/66
[=A0=A0=A0 3.690694] ata1: EH complete
[=A0=A0=A0 3.691246] ata1.01: limiting speed to UDMA/33:PIO4
[=A0=A0=A0 3.691270] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action =
0x6
[=A0=A0=A0 3.691287] ata1.01: BMDMA stat 0x64
[=A0=A0=A0 3.691308] ata1.01: failed command: READ DMA
[=A0=A0=A0 3.691360] ata1.01: cmd c8/00:08:00:00:00/00:00:00:00:00/f0 tag 0=
 dma 4096 in
[=A0=A0=A0 3.691372]=A0=A0=A0=A0=A0=A0=A0=A0=A0 res 51/84:00:08:00:00/00:00=
:00:00:00/f0 Emask 0x10 (ATA bus error)
[=A0=A0=A0 3.691394] ata1.01: status: { DRDY ERR }
[=A0=A0=A0 3.691411] ata1.01: error: { ICRC ABRT }
[=A0=A0=A0 3.692172] ata1: soft resetting link
[=A0=A0=A0 3.872284] ata1.00: configured for UDMA/66
[=A0=A0=A0 3.875638] ata1.01: configured for UDMA/33
[=A0=A0=A0 3.875673] ata1: EH complete
[=A0=A0=A0 3.876926] sda: detected capacity change from 0 to 4009549824
[=A0=A0=A0 3.877005]=A0 sdb: unknown partition table
[=A0=A0=A0 3.880353] sdb: detected capacity change from 0 to 120034123776
[=A0=A0=A0 3.881475] sda: detected capacity change from 0 to 4009549824
[=A0=A0=A0 3.881581] sd 0:0:1:0: [sdb] Attached SCSI disk
[=A0=A0=A0 3.889290] sdb: detected capacity change from 0 to 120034123776
[=A0=A0=A0 4.337095] EXT3-fs (sda1): mounted filesystem with ordered data m=
ode
[=A0=A0=A0 4.338238] kjournald starting.=A0 Commit interval 5 seconds
[=A0=A0=A0 4.437401] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action =
0x6
[=A0=A0=A0 4.437420] ata1.00: BMDMA stat 0x64
[=A0=A0=A0 4.437441] ata1.00: failed command: READ DMA
[=A0=A0=A0 4.437494] ata1.00: cmd c8/00:20:b9:ce:16/00:00:00:00:00/e0 tag 0=
 dma 16384 in
[=A0=A0=A0 4.437506]=A0=A0=A0=A0=A0=A0=A0=A0=A0 res 51/84:00:b9:ce:16/00:00=
:00:00:00/e0 Emask 0x10 (ATA bus error)
[=A0=A0=A0 4.437528] ata1.00: status: { DRDY ERR }
[=A0=A0=A0 4.437545] ata1.00: error: { ICRC ABRT }
[=A0=A0=A0 4.438277] ata1: soft resetting link
[=A0=A0=A0 4.602281] ata1.00: configured for UDMA/66
[=A0=A0=A0 4.621638] ata1.01: configured for UDMA/33
[=A0=A0=A0 4.621705] ata1: EH complete
[=A0=A0=A0 4.623320] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action =
0x6
[=A0=A0=A0 4.623338] ata1.00: BMDMA stat 0x64
[=A0=A0=A0 4.623358] ata1.00: failed command: READ DMA
[=A0=A0=A0 4.623410] ata1.00: cmd c8/00:20:b9:ce:16/00:00:00:00:00/e0 tag 0=
 dma 16384 in
[=A0=A0=A0 4.623422]=A0=A0=A0=A0=A0=A0=A0=A0=A0 res 51/84:00:b9:ce:16/00:00=
:00:00:00/e0 Emask 0x10 (ATA bus error)
[=A0=A0=A0 4.623443] ata1.00: status: { DRDY ERR }
[=A0=A0=A0 4.623460] ata1.00: error: { ICRC ABRT }
[=A0=A0=A0 4.624178] ata1: soft resetting link
[=A0=A0=A0 4.804280] ata1.00: configured for UDMA/66
[=A0=A0=A0 4.807636] ata1.01: configured for UDMA/33
[=A0=A0=A0 4.807697] ata1: EH complete
[=A0=A0=A0 4.809308] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action =
0x6
[=A0=A0=A0 4.809326] ata1.00: BMDMA stat 0x64
[=A0=A0=A0 4.809345] ata1.00: failed command: READ DMA
[=A0=A0=A0 4.809397] ata1.00: cmd c8/00:20:b9:ce:16/00:00:00:00:00/e0 tag 0=
 dma 16384 in
[=A0=A0=A0 4.809410]=A0=A0=A0=A0=A0=A0=A0=A0=A0 res 51/84:00:b9:ce:16/00:00=
:00:00:00/e0 Emask 0x10 (ATA bus error)
[=A0=A0=A0 4.809430] ata1.00: status: { DRDY ERR }
[=A0=A0=A0 4.809447] ata1.00: error: { ICRC ABRT }
[=A0=A0=A0 4.810162] ata1: soft resetting link
[=A0=A0=A0 4.990281] ata1.00: configured for UDMA/66
[=A0=A0=A0 4.993666] ata1.01: configured for UDMA/33
[=A0=A0=A0 4.993727] ata1: EH complete
[=A0=A0=A0 4.995335] ata1.00: limiting speed to UDMA/44:PIO4
[=A0=A0=A0 4.995359] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action =
0x6
[=A0=A0=A0 4.995377] ata1.00: BMDMA stat 0x64
[=A0=A0=A0 4.995396] ata1.00: failed command: READ DMA
[=A0=A0=A0 4.995448] ata1.00: cmd c8/00:20:b9:ce:16/00:00:00:00:00/e0 tag 0=
 dma 16384 in
[=A0=A0=A0 4.995461]=A0=A0=A0=A0=A0=A0=A0=A0=A0 res 51/84:00:b9:ce:16/00:00=
:00:00:00/e0 Emask 0x10 (ATA bus error)
[=A0=A0=A0 4.995482] ata1.00: status: { DRDY ERR }
[=A0=A0=A0 4.995498] ata1.00: error: { ICRC ABRT }
[=A0=A0=A0 4.996214] ata1: soft resetting link
[=A0=A0=A0 5.176281] ata1.00: configured for UDMA/44
[=A0=A0=A0 5.179635] ata1.01: configured for UDMA/33
[=A0=A0=A0 5.179696] ata1: EH complete
[=A0=A0=A0 5.907794] udev[207]: starting version 164
[=A0=A0=A0 6.338312] AMD Geode RNG detected
[=A0=A0=A0 6.446634] via_rhine: v1.10-LK1.5.0 2010-10-09 Written by Donald =
Becker
[=A0=A0=A0 6.500596] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
[=A0=A0=A0 6.500627] Geode LX AES 0000:00:01.2: PCI INT A -> Link[LNKA] -> =
GSI 10 (level, low) -> IRQ 10
[=A0=A0=A0 6.555602] geode-aes: GEODE AES engine enabled.
[=A0=A0=A0 6.558126] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
[=A0=A0=A0 6.558156] via-rhine 0000:00:0d.0: PCI INT A -> Link[LNKB] -> GSI=
 11 (level, low) -> IRQ 11
[=A0=A0=A0 6.558193] via-rhine 0000:00:0d.0: setting latency timer to 64
[=A0=A0=A0 6.691654] via-rhine 0000:00:0d.0: eth0: VIA Rhine III (Managemen=
t Adapter) at 0xefffd000, 00:0d:b9:0e:45:90, IRQ 11
[=A0=A0=A0 6.714784] via-rhine 0000:00:0d.0: eth0: MII PHY found at address=
 1, status 0x786d advertising 05e1 Link cde1
[=A0=A0=A0 6.793890] parport_pc 00:09: reported by Plug and Play ACPI
[=A0=A0=A0 6.793978] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[=A0=A0=A0 7.218201] usbcore: registered new interface driver usbfs
[=A0=A0=A0 7.218328] usbcore: registered new interface driver hub
[=A0=A0=A0 7.225371] usbcore: registered new device driver usb
[=A0=A0=A0 7.242280] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Dr=
iver
[=A0=A0=A0 7.242381] ehci_hcd 0000:00:0c.1: PCI INT A -> Link[LNKC] -> GSI =
11 (level, low) -> IRQ 11
[=A0=A0=A0 7.242458] ehci_hcd 0000:00:0c.1: EHCI Host Controller
[=A0=A0=A0 7.242556] ehci_hcd 0000:00:0c.1: new USB bus registered, assigne=
d bus number 1
[=A0=A0=A0 7.269610] ehci_hcd 0000:00:0c.1: irq 11, io mem 0xefffe000
[=A0=A0=A0 7.275106] ehci_hcd 0000:00:0c.1: USB 2.0 started, EHCI 1.00
[=A0=A0=A0 7.275229] usb usb1: New USB device found, idVendor=3D1d6b, idPro=
duct=3D0002
[=A0=A0=A0 7.275251] usb usb1: New USB device strings: Mfr=3D3, Product=3D2=
, SerialNumber=3D1
[=A0=A0=A0 7.275269] usb usb1: Product: EHCI Host Controller
[=A0=A0=A0 7.275286] usb usb1: Manufacturer: Linux 3.2.17-rt28 ehci_hcd
[=A0=A0=A0 7.275303] usb usb1: SerialNumber: 0000:00:0c.1
[=A0=A0=A0 7.276167] hub 1-0:1.0: USB hub found
[=A0=A0=A0 7.276197] hub 1-0:1.0: 3 ports detected
[=A0=A0=A0 7.276592] ehci_hcd 0000:00:0f.5: PCI INT D -> Link[LNKD] -> GSI =
10 (level, low) -> IRQ 10
[=A0=A0=A0 7.276772] ehci_hcd 0000:00:0f.5: setting latency timer to 64
[=A0=A0=A0 7.276842] ehci_hcd 0000:00:0f.5: EHCI Host Controller
[=A0=A0=A0 7.276894] ehci_hcd 0000:00:0f.5: new USB bus registered, assigne=
d bus number 2
[=A0=A0=A0 7.306200] ehci_hcd 0000:00:0f.5: irq 10, io mem 0xefffc000
[=A0=A0=A0 7.312095] ehci_hcd 0000:00:0f.5: USB 2.0 started, EHCI 1.00
[=A0=A0=A0 7.312219] usb usb2: New USB device found, idVendor=3D1d6b, idPro=
duct=3D0002
[=A0=A0=A0 7.312241] usb usb2: New USB device strings: Mfr=3D3, Product=3D2=
, SerialNumber=3D1
[=A0=A0=A0 7.312260] usb usb2: Product: EHCI Host Controller
[=A0=A0=A0 7.312277] usb usb2: Manufacturer: Linux 3.2.17-rt28 ehci_hcd
[=A0=A0=A0 7.312294] usb usb2: SerialNumber: 0000:00:0f.5
[=A0=A0=A0 7.313140] hub 2-0:1.0: USB hub found
[=A0=A0=A0 7.313170] hub 2-0:1.0: 4 ports detected
[=A0=A0=A0 7.342138] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[=A0=A0=A0 7.342251] ohci_hcd 0000:00:0c.0: PCI INT A -> Link[LNKC] -> GSI =
11 (level, low) -> IRQ 11
[=A0=A0=A0 7.342330] ohci_hcd 0000:00:0c.0: setting latency timer to 64
[=A0=A0=A0 7.342355] ohci_hcd 0000:00:0c.0: OHCI Host Controller
[=A0=A0=A0 7.342425] ohci_hcd 0000:00:0c.0: new USB bus registered, assigne=
d bus number 3
[=A0=A0=A0 7.352871] ohci_hcd 0000:00:0c.0: irq 11, io mem 0xeffff000
[=A0=A0=A0 7.405174] usb usb3: New USB device found, idVendor=3D1d6b, idPro=
duct=3D0001
[=A0=A0=A0 7.405197] usb usb3: New USB device strings: Mfr=3D3, Product=3D2=
, SerialNumber=3D1
[=A0=A0=A0 7.405216] usb usb3: Product: OHCI Host Controller
[=A0=A0=A0 7.405232] usb usb3: Manufacturer: Linux 3.2.17-rt28 ohci_hcd
[=A0=A0=A0 7.405249] usb usb3: SerialNumber: 0000:00:0c.0
[=A0=A0=A0 7.409455] hub 3-0:1.0: USB hub found
[=A0=A0=A0 7.409486] hub 3-0:1.0: 3 ports detected
[=A0=A0=A0 7.631128] usb 1-2: new high-speed USB device number 2 using ehci=
_hcd
[=A0=A0=A0 7.746128] usb 1-2: New USB device found, idVendor=3D249c, idProd=
uct=3D930b
[=A0=A0=A0 7.746151] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D3
[=A0=A0=A0 7.746170] usb 1-2: Product: M2Tech USB Audio 2.0
[=A0=A0=A0 7.746186] usb 1-2: Manufacturer: M2Tech =

[=A0=A0=A0 7.746201] usb 1-2: SerialNumber: 0000
[=A0=A0=A0 8.924107] cannot get ctl value: req =3D 0x83, wValue =3D 0x201, =
wIndex =3D 0xa00, type =3D 4
[=A0=A0=A0 8.924220] cannot get ctl value: req =3D 0x83, wValue =3D 0x200, =
wIndex =3D 0xa00, type =3D 4
[=A0=A0=A0 8.928883] usbcore: registered new interface driver snd-usb-audio
[=A0=A0 10.210111] EXT3-fs (sda1): using internal journal
[=A0=A0 10.405299] fuse init (API version 7.17)
[=A0=A0 10.472092] w83627hf: w83627hf: Found W83627HF chip at 0x290
[=A0=A0 10.507657] ppdev: user-space parallel port driver
[=A0=A0 12.080508] EXT4-fs (sdb): mounted filesystem with ordered data mode=
. Opts: errors=3Dremount-ro
[=A0=A0 13.888730] via-rhine 0000:00:0d.0: eth0: link up, 100Mbps, full-dup=
lex, lpa 0xCDE1
[=A0=A0 24.418047] eth0: no IPv6 routers present
[=A0=A0 41.926113] CIFS VFS: default security mechanism requested.=A0 The d=
efault security mechanism will be upgraded from ntlm to ntlmv2 in kernel re=
lease 3.3
