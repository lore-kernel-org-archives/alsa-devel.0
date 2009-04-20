From: Ivan Mironov <mironov.ivan@gmail.com>
Subject: Re: No sound with Creative Sound Blaster X-Fi Xtreme
 Audio Notebook (CA0110-IBG)
Date: Mon, 20 Apr 2009 18:33:51 +0600
Message-ID: <1240230831.15240.18.camel@ivan-laptop.loc>
References: <1239979223.15687.6.camel@ivan-laptop.loc>
	<s5heivruymm.wl%tiwai@suse.de>
	<1239982297.16207.17.camel@ivan-laptop.loc>
	<s5hy6tztfk5.wl%tiwai@suse.de>
	<1239987706.15263.2.camel@ivan-laptop.loc>
	<s5htz4jogaz.wl%tiwai@suse.de>
Reply-To: mironov.ivan@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-6NGwTUjA1GCJZgYClN3A"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 8576C1037FC
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Apr 2009 14:34:59 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 22so472961fge.21
	for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2009 05:34:59 -0700 (PDT)
In-Reply-To: <s5htz4jogaz.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-6NGwTUjA1GCJZgYClN3A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=92 =D0=9F=D0=BD=D0=B4, 20/04/2009 =D0=B2 10:55 +0200, Takashi Iwai =D0=
=BF=D0=B8=D1=88=D0=B5=D1=82:
> At Fri, 17 Apr 2009 23:01:46 +0600,
> Ivan Mironov wrote:
> >=20
> > =D0=92 =D0=9F=D1=82=D0=BD, 17/04/2009 =D0=B2 18:23 +0200, Takashi Iwa=
i =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >=20
> > > OK, let's check first what the driver gets wrong.
> > > For example, try the patch below.  It'll give some debug prints.
> > >=20
> >=20
> > ALSA /home/ivan/stuff/alsa-driver/acore/pcm_native.c:1942: CHANNELS
> > minmax error
> > ALSA /home/ivan/stuff/alsa-driver/acore/pcm_native.c:2062:
> > snd_pcm_hw_constraints_complete failed
>=20
> Thanks.  I guess I fixed this problem now.
> Try the very latest alsa-driver snapshot again.
>     ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-dr=
iver-snapshot.tar.gz
>=20
>=20
> Takashi

The old error disappeared, but soundcard still doesn't play sound.

If I run speaker test with an odd number of channels (-c 1, -c 3, etc.),
it works without any errors (and without any sound =3D)):

----------------------------------------------------
$ speaker-test -D plughw:1,0

speaker-test 1.0.19

Playback device is plughw:1,0
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 64 to 16384
Period size range from 32 to 8192
Using max buffer size 16384
Periods =3D 4
was set period_size =3D 4096
was set buffer_size =3D 16384
 0 - Front Left
^C
----------------------------------------------------

But if I run it with even number of channels (-c 2, -c 4, etc.), it
exits with an error in a while (about five seconds):

----------------------------------------------------
$ speaker-test -c 4 -D plughw:1,0

speaker-test 1.0.19

Playback device is plughw:1,0
Stream parameters are 48000Hz, S16_LE, 4 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 32 to 8192
Period size range from 16 to 4096
Using max buffer size 8192
Periods =3D 4
was set period_size =3D 2048
was set buffer_size =3D 8192
 0 - Front Left
Write error: -5,Input/output error
xrun_recovery failed: -5,Input/output error
Transfer failed: Operation not permitted
----------------------------------------------------

At this time in dmesg writes the following error:

----------------------------------------------------
ALSA /home/ivan/stuff/alsa-driver/acore/../alsa-kernel/core/pcm_lib.c:162=
8: playback write error (DMA or IRQ trouble?)
----------------------------------------------------


--=-6NGwTUjA1GCJZgYClN3A
Content-Disposition: attachment; filename="dmesg"
Content-Type: text/plain; name="dmesg"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.29.1 (root@ivan-laptop) (gcc version 4.4.0-alpha20090407 (prerelease) (Gentoo 4.4.0_alpha20090407) ) #1 SMP PREEMPT Tue Apr 14 21:52:56 YEKST 2009
Command line: quiet real_root=LABEL=laptop-root vga=0x361
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
  Centaur CentaurHauls
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfed0000 (usable)
 BIOS-e820: 00000000bfed0000 - 00000000bfee1000 (ACPI NVS)
 BIOS-e820: 00000000bfee1000 - 00000000c0000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
DMI present.
last_pfn = 0xbfed0 max_arch_pfn = 0x100000000
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
init_memory_mapping: 0000000000000000-00000000bfed0000
 0000000000 - 00bfe00000 page 2M
 00bfe00000 - 00bfed0000 page 4k
kernel direct mapping tables up to bfed0000 @ 8000-d000
last_map_addr: bfed0000 end: bfed0000
RAMDISK: 3649c000 - 37fef8dc
ACPI: RSDP 000F7AE0, 0024 (r2 PTLTD )
ACPI: XSDT BFED3841, 007C (r1 ACRSYS ACRPRDCT  6040000  LTP        0)
ACPI: FACP BFEDDC2A, 00F4 (r3 INTEL  CRESTLNE  6040000 ALAN        1)
FADT: X_PM1a_EVT_BLK.bit_width (16) does not match PM1_EVT_LEN (4)
ACPI: DSDT BFED4DB5, 8E01 (r2 INTEL  CRESTLNE  6040000 MSFT  3000001)
ACPI: FACS BFEE0FC0, 0040
ACPI: APIC BFEDDD1E, 0068 (r1 INTEL  CRESTLNE  6040000 LOHR       5A)
ACPI: HPET BFEDDD86, 0038 (r1 INTEL  CRESTLNE  6040000 LOHR       5A)
ACPI: MCFG BFEDDDBE, 003C (r1 INTEL  CRESTLNE  6040000 LOHR       5A)
ACPI: APIC BFEDDDFA, 0068 (r1 PTLTD  	 APIC    6040000  LTP        0)
ACPI: BOOT BFEDDE62, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
ACPI: SLIC BFEDDE8A, 0176 (r1 ACRSYS ACRPRDCT  6040000 acer        0)
ACPI: SSDT BFED4AD8, 02DD (r1 SataRe SataAhci     1000 INTL 20050624)
ACPI: SSDT BFED3E79, 025F (r1  PmRef  Cpu0Tst     3000 INTL 20050624)
ACPI: SSDT BFED3DD3, 00A6 (r1  PmRef  Cpu1Tst     3000 INTL 20050624)
ACPI: SSDT BFED38BD, 0516 (r1  PmRef    CpuPm     3000 INTL 20050624)
ACPI: BIOS bug: multiple APIC/MADT found, using 0
ACPI: If "acpi_apic_instance=2" works better, notify linux-acpi@vger.kernel.org
ACPI: Local APIC address 0xfee00000
No NUMA configuration found
Faking a node at 0000000000000000-00000000bfed0000
Bootmem setup node 0 0000000000000000-00000000bfed0000
  NODE_DATA [000000000000b000 - 0000000000022fff]
  bootmap [0000000000023000 -  000000000003afdf] pages 18
(6 early reservations) ==> bootmem [0000000000 - 00bfed0000]
  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
  #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
  #2 [0000200000 - 0001413550]    TEXT DATA BSS ==> [0000200000 - 0001413550]
  #3 [003649c000 - 0037fef8dc]          RAMDISK ==> [003649c000 - 0037fef8dc]
  #4 [000009f800 - 0000100000]    BIOS reserved ==> [000009f800 - 0000100000]
  #5 [0000008000 - 000000b000]          PGTABLE ==> [0000008000 - 000000b000]
found SMP MP-table at [ffff8800000f7b10] 000f7b10
 [ffffe20000000000-ffffe20004dfffff] PMD -> [ffff880001600000-ffff8800063fffff] on node 0
Zone PFN ranges:
  DMA      0x00000000 -> 0x00001000
  DMA32    0x00001000 -> 0x00100000
  Normal   0x00100000 -> 0x00100000
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0: 0x00000000 -> 0x0000009f
    0: 0x00000100 -> 0x000bfed0
On node 0 totalpages: 786031
  DMA zone: 104 pages used for memmap
  DMA zone: 104 pages reserved
  DMA zone: 3791 pages, LIFO batch:0
  DMA32 zone: 19857 pages used for memmap
  DMA32 zone: 762175 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 0, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
SMP: Allowing 2 CPUs, 0 hotplug CPUs
nr_irqs_gsi: 24
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000ce000
PM: Registered nosave memory: 00000000000ce000 - 00000000000d0000
PM: Registered nosave memory: 00000000000d0000 - 00000000000e0000
PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
Allocating PCI resources starting at c2000000 (gap: c0000000:20000000)
NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:2 nr_node_ids:1
PERCPU: Allocating 1892352 bytes of per cpu data
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 765966
Policy zone: DMA32
Kernel command line: quiet real_root=LABEL=laptop-root vga=0x361
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Extended CMOS year: 2000
Fast TSC calibration using PIT
Detected 2399.880 MHz processor.
Console: colour dummy device 80x25
console [tty0] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      16384
... CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 4351 kB
 per task-struct memory footprint: 2688 bytes
allocated 31457280 bytes of page_cgroup
please try cgroup_disable=memory option if you don't want
Checking aperture...
No AGP bridge found
Calgary: detecting Calgary via BIOS EBDA area
Calgary: Unable to locate Rio Grande table in EBDA - bailing!
Memory: 2982816k/3144512k available (3828k kernel code, 388k absent, 161308k reserved, 2361k data, 3012k init)
SLUB: Genslabs=13, HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
hpet clockevent registered
HPET: 3 timers in total, 0 timers will be used for per-cpu timer
Calibrating delay loop (skipped), value calculated using timer frequency.. 4799.76 BogoMIPS (lpj=2399880)
Security Framework initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 256
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys net_cls
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 3072K
[ds] using Core 2/Atom configuration
CPU 0/0x0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring handled by SMI
using mwait in idle threads.
ACPI: Core revision 20081204
ftrace: converting mcount calls to 0f 1f 44 00 00
ftrace: allocating 18582 entries in 147 pages
Setting APIC routing to flat
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: Intel(R) Core(TM)2 Duo CPU     T8300  @ 2.40GHz stepping 06
lockdep: fixing up alternatives.
Booting processor 1 APIC 0x1 ip 0x6000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4800.03 BogoMIPS (lpj=2400018)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 3072K
[ds] using Core 2/Atom configuration
CPU 1/0x1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM2)
x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
CPU1: Intel(R) Core(TM)2 Duo CPU     T8300  @ 2.40GHz stepping 06
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
Total of 2 processors activated (9599.79 BogoMIPS).
CPU0 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 0 1
CPU1 attaching sched-domain:
 domain 0: span 0-1 level MC
  groups: 1 0
khelper used greatest stack depth: 5368 bytes left
net_namespace: 2232 bytes
regulator: core version 0.5
Time: 17:36:45  Date: 04/20/09
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
PCI: MCFG area at e0000000 reserved in E820
PCI: Using MMCONFIG at e0000000 - efffffff
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: BIOS _OSI(Linux) query ignored
ACPI: EC: non-query interrupt received, switching to interrupt mode
ACPI: EC: missing confirmations, switch off interrupt mode.
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: EC: GPE = 0x18, I/O: command/status = 0x66, data = 0x62
ACPI: EC: driver started in poll mode
ACPI: No dock devices found.
ACPI Error (psargs-0359): [CDW1] Namespace lookup failure, AE_NOT_FOUND
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0._OSC] (Node ffff8800bf673068), AE_NOT_FOUND
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
pci 0000:00:01.0: PME# disabled
pci 0000:00:1a.0: reg 20 io port: [0x1800-0x181f]
pci 0000:00:1a.1: reg 20 io port: [0x1820-0x183f]
pci 0000:00:1a.7: reg 10 32bit mmio: [0xf3604800-0xf3604bff]
pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1a.7: PME# disabled
pci 0000:00:1b.0: reg 10 64bit mmio: [0xf3600000-0xf3603fff]
pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1b.0: PME# disabled
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: PME# disabled
pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.3: PME# disabled
pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.5: PME# disabled
pci 0000:00:1d.0: reg 20 io port: [0x1840-0x185f]
pci 0000:00:1d.1: reg 20 io port: [0x1860-0x187f]
pci 0000:00:1d.2: reg 20 io port: [0x1880-0x189f]
pci 0000:00:1d.7: reg 10 32bit mmio: [0xf3604c00-0xf3604fff]
pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.7: PME# disabled
pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region 1180-11bf claimed by ICH6 GPIO
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0680 (mask 007f)
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 0600 (mask 003f)
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 4 PIO at 0068 (mask 0007)
pci 0000:00:1f.1: reg 10 io port: [0x00-0x07]
pci 0000:00:1f.1: reg 14 io port: [0x00-0x03]
pci 0000:00:1f.1: reg 18 io port: [0x00-0x07]
pci 0000:00:1f.1: reg 1c io port: [0x00-0x03]
pci 0000:00:1f.1: reg 20 io port: [0x18a0-0x18af]
pci 0000:00:1f.2: reg 10 io port: [0x18d8-0x18df]
pci 0000:00:1f.2: reg 14 io port: [0x18cc-0x18cf]
pci 0000:00:1f.2: reg 18 io port: [0x18d0-0x18d7]
pci 0000:00:1f.2: reg 1c io port: [0x18c8-0x18cb]
pci 0000:00:1f.2: reg 20 io port: [0x18e0-0x18ff]
pci 0000:00:1f.2: reg 24 32bit mmio: [0xf3604000-0xf36047ff]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.2: PME# disabled
pci 0000:00:1f.3: reg 10 32bit mmio: [0x000000-0x0000ff]
pci 0000:00:1f.3: reg 20 io port: [0x1c00-0x1c1f]
pci 0000:01:00.0: reg 10 32bit mmio: [0xf2000000-0xf2ffffff]
pci 0000:01:00.0: reg 14 64bit mmio: [0xd0000000-0xdfffffff]
pci 0000:01:00.0: reg 1c 64bit mmio: [0xf0000000-0xf1ffffff]
pci 0000:01:00.0: reg 24 io port: [0x2000-0x207f]
pci 0000:01:00.0: reg 30 32bit mmio: [0x000000-0x01ffff]
pci 0000:00:01.0: bridge io port: [0x2000-0x2fff]
pci 0000:00:01.0: bridge 32bit mmio: [0xf0000000-0xf2ffffff]
pci 0000:00:01.0: bridge 64bit mmio pref: [0xd0000000-0xdfffffff]
pci 0000:02:00.0: supports D1 D2
pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
pci 0000:00:1c.0: bridge io port: [0x00-0xfff]
pci 0000:00:1c.0: bridge 32bit mmio: [0x000000-0x0fffff]
pci 0000:00:1c.0: bridge 64bit mmio pref: [0x000000-0x0fffff]
pci 0000:03:00.0: reg 10 32bit mmio: [0xf3100000-0xf3103fff]
pci 0000:03:00.0: supports D1 D2
pci 0000:02:00.0: bridge io port: [0x00-0xfff]
pci 0000:02:00.0: bridge 32bit mmio: [0x000000-0x0fffff]
pci 0000:02:00.0: bridge 64bit mmio pref: [0x000000-0x0fffff]
pci 0000:06:00.0: reg 10 32bit mmio: [0x000000-0x000fff]
pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
pci 0000:06:00.0: PME# disabled
pci 0000:06:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
pci 0000:00:1c.3: bridge io port: [0x00-0xfff]
pci 0000:00:1c.3: bridge 32bit mmio: [0x000000-0x0fffff]
pci 0000:00:1c.3: bridge 64bit mmio pref: [0x000000-0x0fffff]
pci 0000:08:00.0: reg 10 64bit mmio: [0x000000-0x00ffff]
pci 0000:08:00.0: PME# supported from D3hot D3cold
pci 0000:08:00.0: PME# disabled
pci 0000:00:1c.5: bridge io port: [0x00-0xfff]
pci 0000:00:1c.5: bridge 32bit mmio: [0x000000-0x0fffff]
pci 0000:00:1c.5: bridge 64bit mmio pref: [0x000000-0x0fffff]
pci 0000:0a:09.0: reg 10 32bit mmio: [0xf3300000-0xf33007ff]
pci 0000:0a:09.0: supports D1 D2
pci 0000:0a:09.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:0a:09.0: PME# disabled
pci 0000:0a:09.1: reg 10 32bit mmio: [0xf3300800-0xf33008ff]
pci 0000:0a:09.1: supports D1 D2
pci 0000:0a:09.1: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:0a:09.1: PME# disabled
pci 0000:0a:09.2: reg 10 32bit mmio: [0xf3300c00-0xf3300cff]
pci 0000:0a:09.2: supports D1 D2
pci 0000:0a:09.2: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:0a:09.2: PME# disabled
pci 0000:0a:09.3: reg 10 32bit mmio: [0xf3301000-0xf33010ff]
pci 0000:0a:09.3: supports D1 D2
pci 0000:0a:09.3: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:0a:09.3: PME# disabled
pci 0000:0a:09.4: reg 10 32bit mmio: [0xf3301400-0xf33014ff]
pci 0000:0a:09.4: supports D1 D2
pci 0000:0a:09.4: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:0a:09.4: PME# disabled
pci 0000:00:1e.0: transparent bridge
pci 0000:00:1e.0: bridge 32bit mmio: [0xf3300000-0xf33fffff]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP06._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI Error (psargs-0359): [CDW1] Namespace lookup failure, AE_NOT_FOUND
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0._OSC] (Node ffff8800bf673068), AE_NOT_FOUND
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 *7 11 12 14 15)
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
pci 0000:00:1c.0: BAR 7: can't allocate resource
pci 0000:00:1c.0: BAR 8: can't allocate resource
pci 0000:00:1c.0: BAR 9: can't allocate resource
pci 0000:02:00.0: BAR 7: can't allocate resource
pci 0000:02:00.0: BAR 8: can't allocate resource
pci 0000:02:00.0: BAR 9: can't allocate resource
pci 0000:00:1c.3: BAR 7: can't allocate resource
pci 0000:00:1c.3: BAR 8: can't allocate resource
pci 0000:00:1c.3: BAR 9: can't allocate resource
pci 0000:00:1c.5: BAR 7: can't allocate resource
pci 0000:00:1c.5: BAR 8: can't allocate resource
pci 0000:00:1c.5: BAR 9: can't allocate resource
pci 0000:03:00.0: BAR 0: can't allocate resource
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 comparators, 64-bit 14.318180 MHz counter
Switched to high resolution mode on CPU 0
Switched to high resolution mode on CPU 1
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 11 devices
ACPI: ACPI bus type pnp unregistered
system 00:01: iomem range 0xfed1c000-0xfed1ffff has been reserved
system 00:01: iomem range 0xfed14000-0xfed17fff has been reserved
system 00:01: iomem range 0xfed18000-0xfed18fff has been reserved
system 00:01: iomem range 0xfed19000-0xfed19fff has been reserved
system 00:01: iomem range 0xe0000000-0xefffffff has been reserved
system 00:01: iomem range 0xfed20000-0xfed3ffff has been reserved
system 00:01: iomem range 0xfed40000-0xfed44fff has been reserved
system 00:01: iomem range 0xfed45000-0xfed8ffff has been reserved
system 00:04: iomem range 0xfed00000-0xfed003ff has been reserved
system 00:06: ioport range 0x680-0x69f has been reserved
system 00:06: ioport range 0x800-0x80f has been reserved
system 00:06: ioport range 0x1000-0x107f has been reserved
system 00:06: ioport range 0x1180-0x11bf has been reserved
system 00:06: ioport range 0x1640-0x164f has been reserved
system 00:06: ioport range 0xfe00-0xfe00 has been reserved
pci 0000:01:00.0: BAR 6: can't allocate mem resource [0xe0000000-0xdfffffff]
pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
pci 0000:00:01.0:   IO window: 0x2000-0x2fff
pci 0000:00:01.0:   MEM window: 0xf0000000-0xf2ffffff
pci 0000:00:01.0:   PREFETCH window: 0x000000d0000000-0x000000dfffffff
pci 0000:02:00.0: PCI bridge, secondary bus 0000:03
pci 0000:02:00.0:   IO window: disabled
pci 0000:02:00.0:   MEM window: 0xc2000000-0xc20fffff
pci 0000:02:00.0:   PREFETCH window: disabled
pci 0000:00:1c.0: PCI bridge, secondary bus 0000:02
pci 0000:00:1c.0:   IO window: disabled
pci 0000:00:1c.0:   MEM window: 0xc2000000-0xc20fffff
pci 0000:00:1c.0:   PREFETCH window: disabled
pci 0000:00:1c.3: PCI bridge, secondary bus 0000:06
pci 0000:00:1c.3:   IO window: disabled
pci 0000:00:1c.3:   MEM window: 0xc2100000-0xc21fffff
pci 0000:00:1c.3:   PREFETCH window: disabled
pci 0000:00:1c.5: PCI bridge, secondary bus 0000:08
pci 0000:00:1c.5:   IO window: disabled
pci 0000:00:1c.5:   MEM window: 0xc2200000-0xc22fffff
pci 0000:00:1c.5:   PREFETCH window: disabled
pci 0000:00:1e.0: PCI bridge, secondary bus 0000:0a
pci 0000:00:1e.0:   IO window: disabled
pci 0000:00:1e.0:   MEM window: 0xf3300000-0xf33fffff
pci 0000:00:1e.0:   PREFETCH window: disabled
  alloc irq_desc for 16 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:01.0: setting latency timer to 64
pci 0000:00:1c.0: enabling device (0000 -> 0002)
  alloc irq_desc for 17 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
pci 0000:00:1c.0: setting latency timer to 64
pci 0000:02:00.0: enabling device (0010 -> 0012)
pci 0000:02:00.0: setting latency timer to 64
pci 0000:00:1c.3: enabling device (0000 -> 0002)
  alloc irq_desc for 19 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
pci 0000:00:1c.3: setting latency timer to 64
pci 0000:00:1c.5: enabling device (0000 -> 0002)
pci 0000:00:1c.5: PCI INT B -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:1c.5: setting latency timer to 64
pci 0000:00:1e.0: setting latency timer to 64
pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
pci_bus 0000:01: resource 0 io:  [0x2000-0x2fff]
pci_bus 0000:01: resource 1 mem: [0xf0000000-0xf2ffffff]
pci_bus 0000:01: resource 2 mem: [0xd0000000-0xdfffffff]
pci_bus 0000:01: resource 3 mem: [0x0-0x0]
pci_bus 0000:02: resource 0 mem: [0x0-0xfff]
pci_bus 0000:02: resource 1 mem: [0xc2000000-0xc20fffff]
pci_bus 0000:02: resource 2 mem: [0x0-0xfffff]
pci_bus 0000:02: resource 3 mem: [0x0-0x0]
pci_bus 0000:03: resource 0 mem: [0x0-0xfff]
pci_bus 0000:03: resource 1 mem: [0xc2000000-0xc20fffff]
pci_bus 0000:03: resource 2 mem: [0x0-0xfffff]
pci_bus 0000:03: resource 3 mem: [0x0-0x0]
pci_bus 0000:06: resource 0 mem: [0x0-0xfff]
pci_bus 0000:06: resource 1 mem: [0xc2100000-0xc21fffff]
pci_bus 0000:06: resource 2 mem: [0x0-0xfffff]
pci_bus 0000:06: resource 3 mem: [0x0-0x0]
pci_bus 0000:08: resource 0 mem: [0x0-0xfff]
pci_bus 0000:08: resource 1 mem: [0xc2200000-0xc22fffff]
pci_bus 0000:08: resource 2 mem: [0x0-0xfffff]
pci_bus 0000:08: resource 3 mem: [0x0-0x0]
pci_bus 0000:0a: resource 0 mem: [0x0-0x0]
pci_bus 0000:0a: resource 1 mem: [0xf3300000-0xf33fffff]
pci_bus 0000:0a: resource 2 mem: [0x0-0x0]
pci_bus 0000:0a: resource 3 io:  [0x00-0xffff]
pci_bus 0000:0a: resource 4 mem: [0x000000-0xffffffffffffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 10, 4718592 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
NET: Registered protocol family 1
checking if image is initramfs... it is
Freeing initrd memory: 27982k freed
Simple Boot Flag at 0x35 set to 0x1
audit: initializing netlink socket (disabled)
type=2000 audit(1240249009.009:1): initialized
HugeTLB registered 2 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
msgmni has been set to 5880
SELinux:  Registering netfilter hooks
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler cfq registered (default)
pci 0000:01:00.0: Boot video device
pcieport-driver 0000:00:01.0: setting latency timer to 64
  alloc irq_desc for 24 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
pcieport-driver 0000:00:01.0: irq 24 for MSI/MSI-X
pcieport-driver 0000:00:1c.0: setting latency timer to 64
  alloc irq_desc for 25 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
pcieport-driver 0000:00:1c.0: irq 25 for MSI/MSI-X
pcieport-driver 0000:00:1c.3: setting latency timer to 64
  alloc irq_desc for 26 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
pcieport-driver 0000:00:1c.3: irq 26 for MSI/MSI-X
pcieport-driver 0000:00:1c.5: setting latency timer to 64
  alloc irq_desc for 27 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
pcieport-driver 0000:00:1c.5: irq 27 for MSI/MSI-X
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI Error (psargs-0359): [CDW1] Namespace lookup failure, AE_NOT_FOUND
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0._OSC] (Node ffff8800bf673068), AE_NOT_FOUND
ACPI Error (psargs-0359): [CDW1] Namespace lookup failure, AE_NOT_FOUND
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0._OSC] (Node ffff8800bf673068), AE_NOT_FOUND
ACPI Error (psargs-0359): [CDW1] Namespace lookup failure, AE_NOT_FOUND
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0._OSC] (Node ffff8800bf673068), AE_NOT_FOUND
ACPI Error (psargs-0359): [CDW1] Namespace lookup failure, AE_NOT_FOUND
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0._OSC] (Node ffff8800bf673068), AE_NOT_FOUND
ACPI Error (psargs-0359): [CDW1] Namespace lookup failure, AE_NOT_FOUND
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0._OSC] (Node ffff8800bf673068), AE_NOT_FOUND
ACPI Error (psargs-0359): [CDW1] Namespace lookup failure, AE_NOT_FOUND
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0._OSC] (Node ffff8800bf673068), AE_NOT_FOUND
ACPI Error (psargs-0359): [CDW1] Namespace lookup failure, AE_NOT_FOUND
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0._OSC] (Node ffff8800bf673068), AE_NOT_FOUND
ACPI Error (psargs-0359): [CDW1] Namespace lookup failure, AE_NOT_FOUND
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0._OSC] (Node ffff8800bf673068), AE_NOT_FOUND
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
acpiphp_glue: can't get bus number, assuming 0
decode_hpp: Could not get hotplug parameters. Use defaults
acpiphp: Slot [1] registered
vesafb: framebuffer at 0xf1000000, mapped to 0xffffc20011480000, using 8000k, total 14336k
vesafb: mode is 1280x800x32, linelength=5120, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Console: switching to colour frame buffer device 160x50
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [ACAD] (off-line)
ACPI: Battery Slot [BAT1] (battery present)
input: Power Button (FF) as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: Power Button (FF) [PWRF]
input: Lid Switch as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input1
ACPI: Lid Switch [LID]
input: Power Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input2
ACPI: Power Button (CM) [PWRB]
input: Sleep Button (CM) as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input3
ACPI: Sleep Button (CM) [SLPB]
ACPI: SSDT BFED4754, 02BC (r1  PmRef  Cpu0Ist     3000 INTL 20050624)
ACPI: SSDT BFED40D8, 05F7 (r1  PmRef  Cpu0Cst     3001 INTL 20050624)
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
Monitor-Mwait will be used to enter C-3 state
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
processor ACPI_CPU:00: registered as cooling_device0
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: SSDT BFED4A10, 00C8 (r1  PmRef  Cpu1Ist     3000 INTL 20050624)
ACPI: SSDT BFED46CF, 0085 (r1  PmRef  Cpu1Cst     3000 INTL 20050624)
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
processor ACPI_CPU:01: registered as cooling_device1
ACPI: Processor [CPU1] (supports 8 throttling states)
thermal LNXTHERM:01: registered as thermal_zone0
ACPI: Thermal Zone [THRM] (53 C)
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
brd: module loaded
loop: module loaded
Fixed MDIO Bus: probed
input: Macintosh mouse button emulation as /devices/virtual/input/input4
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
  alloc irq_desc for 28 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
ahci 0000:00:1f.2: irq 28 for MSI/MSI-X
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x7 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part 
ahci 0000:00:1f.2: setting latency timer to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
ata1: SATA max UDMA/133 irq_stat 0x00000040, connection status changed irq 28
ata2: SATA max UDMA/133 abar m2048@0xf3604000 port 0xf3604180 irq 28
ata3: SATA max UDMA/133 abar m2048@0xf3604000 port 0xf3604200 irq 28
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ACPI Warning (nspredef-0934): \_SB_.PCI0.SATA.PRT0._GTF: Return type mismatch - found Integer, expected Buffer [20081204]
ata1.00: _GTF unexpected object type 0x1
ata1.00: ATA-8: Hitachi HTS542525K9SA00, BBFOC31P, max UDMA/133
ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: _GTF unexpected object type 0x1
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS54252 BBFO PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors: (250 GB/232 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors: (250 GB/232 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 < sda5 sda6 > sda4
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata_piix 0000:00:1f.1: version 2.12
ata_piix 0000:00:1f.1: PCI INT A -> GSI 19 (level, low) -> IRQ 19
ata_piix 0000:00:1f.1: setting latency timer to 64
scsi3 : ata_piix
scsi4 : ata_piix
ata4: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x18a0 irq 14
ata5: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x18a8 irq 15
ata4.00: ATAPI: HL-DT-ST DVDRAM GSA-T40N, JP01, max UDMA/33
ata4.00: configured for UDMA/33
isa bounce pool size: 16 pages
scsi 3:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-T40N  JP01 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 3:0:0:0: Attached scsi CD-ROM sr0
sr 3:0:0:0: Attached scsi generic sg1 type 5
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
  alloc irq_desc for 18 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
ehci_hcd 0000:00:1a.7: setting latency timer to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.7: debug port 1
ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xf3604800
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.29.1 ehci_hcd
usb usb1: SerialNumber: 0000:00:1a.7
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
  alloc irq_desc for 23 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: setting latency timer to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf3604c00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: EHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.29.1 ehci_hcd
usb usb2: SerialNumber: 0000:00:1d.7
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
uhci_hcd: USB Universal Host Controller Interface driver
uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1a.0: setting latency timer to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.0: irq 16, io base 0x00001800
usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.29.1 uhci_hcd
usb usb3: SerialNumber: 0000:00:1a.0
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
  alloc irq_desc for 21 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:1a.1: setting latency timer to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1a.1: irq 21, io base 0x00001820
usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.29.1 uhci_hcd
usb usb4: SerialNumber: 0000:00:1a.1
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001840
usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.29.1 uhci_hcd
usb usb5: SerialNumber: 0000:00:1d.0
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: setting latency timer to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001860
usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb6: Product: UHCI Host Controller
usb usb6: Manufacturer: Linux 2.6.29.1 uhci_hcd
usb usb6: SerialNumber: 0000:00:1d.1
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: setting latency timer to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001880
usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb7: Product: UHCI Host Controller
usb usb7: Manufacturer: Linux 2.6.29.1 uhci_hcd
usb usb7: SerialNumber: 0000:00:1d.2
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
rtc_cmos 00:07: RTC can wake from S4
rtc_cmos 00:07: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
cpuidle: using governor ladder
cpuidle: using governor menu
Marking TSC unstable due to TSC halts in idle
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Please use
nf_conntrack.acct=1 kernel paramater, acct=1 nf_conntrack module option or
sysctl net.netfilter.nf_conntrack_acct=1 to enable it.
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 17
registered taskstats version 1
  Magic number: 5:873:643
Freeing unused kernel memory: 3012k freed
Write protecting the kernel read-only data: 1880k
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input5
ata1: hard resetting link
usb 1-2: new high speed USB device using ehci_hcd and address 2
Clocksource tsc unstable (delta = -179780005 ns)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: _GTF unexpected object type 0x1
ata1.00: _GTF unexpected object type 0x1
ata1.00: configured for UDMA/133
ata1: EH complete
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors: (250 GB/232 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sda: detected capacity change from 0 to 250059350016
usb 1-2: New USB device found, idVendor=064e, idProduct=a101
usb 1-2: New USB device strings: Mfr=2, Product=1, SerialNumber=3
usb 1-2: Product: Acer CrystalEye webcam
usb 1-2: Manufacturer: SuYin
usb 1-2: SerialNumber: CN0314-OV03-VA-R02.00.00
usb 1-2: configuration #1 chosen from 1 choice
usb 7-1: new full speed USB device using uhci_hcd and address 2
Synaptics Touchpad, model: 1, fw: 6.5, id: 0x1e0b1, caps: 0xc04751/0xe0500f
input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio3/input/input6
usb 7-1: New USB device found, idVendor=0a5c, idProduct=2101
usb 7-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 7-1: Product: Acer Module
usb 7-1: Manufacturer: Broadcom Corp
usb 7-1: configuration #1 chosen from 1 choice
mdev used greatest stack depth: 4992 bytes left
Synaptics Touchpad, model: 1, fw: 6.5, id: 0x81a0b1, caps: 0xa04711/0xa04000
input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input7
GDT-HA: Storage RAID Controller Driver. Version: 3.05
Fusion MPT base driver 3.04.07
Copyright (c) 1999-2008 LSI Corporation
Fusion MPT SPI Host driver 3.04.07
Fusion MPT FC Host driver 3.04.07
Fusion MPT SAS Host driver 3.04.07
3ware Storage Controller device driver for Linux v1.26.02.002.
3ware 9000 Storage Controller device driver for Linux v2.26.02.011.
Compaq SMART2 Driver (v 2.6.0)
HP CISS Driver (v 3.6.20)
Adaptec aacraid driver 1.1-5[2456]-ms
megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 2006)
megasas: 00.00.04.01 Thu July 24 11:41:51 PST 2008
QLogic Fibre Channel HBA Driver: 8.03.00-k4
Emulex LightPulse Fibre Channel SCSI driver 8.3.0
Copyright(c) 2004-2008 Emulex.  All rights reserved.
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
sl811: driver sl811-hcd, 19 May 2005
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
async_tx: api initialized (async)
xor: automatically using best checksumming function: generic_sse
   generic_sse:  8900.000 MB/sec
xor: using function: generic_sse (8900.000 MB/sec)
raid6: int64x1   2089 MB/s
raid6: int64x2   2324 MB/s
raid6: int64x4   1972 MB/s
raid6: int64x8   1542 MB/s
raid6: sse2x1    4277 MB/s
raid6: sse2x2    4390 MB/s
raid6: sse2x4    7335 MB/s
raid6: using algorithm sse2x4 (7335 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
md: raid10 personality registered for level 10
JFS: nTxBlock = 8192, nTxLock = 65536
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
SGI XFS with ACLs, security attributes, large block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
fuse init (API version 7.11)
Intel(R) PRO/1000 Network Driver - version 7.3.21-k3-NAPI
Copyright (c) 1999-2006 Intel Corporation.
tg3.c:v3.97 (December 10, 2008)
tg3 0000:08:00.0: enabling device (0000 -> 0002)
tg3 0000:08:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
tg3 0000:08:00.0: setting latency timer to 64
tg3 0000:08:00.0: wake-up capability disabled by ACPI
tg3 0000:08:00.0: PME# disabled
eth0: Tigon3 [partno(BCM95787m) rev b002] (PCI Express) MAC address 00:1e:68:3f:33:e0
eth0: attached PHY is 5787 (10/100/1000Base-T Ethernet) (WireSpeed[1])
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
EXT3-fs: sda6: couldn't mount because of unsupported optional features (240).
EXT4-fs: barriers enabled
EXT4-fs: delayed allocation enabled
EXT4-fs: file extents enabled
EXT4-fs: mballoc enabled
EXT4-fs: mounted filesystem sda6 with ordered data mode
kjournald2 starting: pid 9560, dev sda6:8, commit interval 5 seconds
init-early.sh used greatest stack depth: 4344 bytes left
udev: starting version 141
udevd used greatest stack depth: 4304 bytes left
udev: renamed network interface eth0 to lan
acpi device:04: registered as cooling_device2
input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A08:00/device:02/device:03/input/input8
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
modprobe used greatest stack depth: 4056 bytes left
ACPI: WMI: Mapper loaded
iTCO_vendor_support: vendor-support=0
ricoh-mmc: Ricoh MMC Controller disabling driver
ricoh-mmc: Copyright(c) Philip Langdale
ricoh-mmc: Ricoh MMC controller found at 0000:0a:09.2 [1180:0843] (rev 12)
ricoh-mmc: Controller is now disabled.
input: PC Speaker as /devices/platform/pcspkr/input/input9
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.05
iTCO_wdt: Found a ICH8M TCO device (Version=2, TCOBASE=0x1060)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
i801_smbus 0000:00:1f.3: PCI INT C -> GSI 19 (level, low) -> IRQ 19
ACPI: I/O resource 0000:00:1f.3 [0x1c00-0x1c1f] conflicts with ACPI region SMBI [0x1c00-0x1c0f]
ACPI: Device needs an ACPI driver
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
cfg80211: Calling CRDA to update world regulatory domain
lib80211: common routines for IEEE802.11 drivers
lib80211_crypt: registered algorithm 'NULL'
Bluetooth: Core ver 2.14
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
acer-wmi: Acer Laptop ACPI-WMI Extras
acer-wmi: Brightness must be controlled by generic video driver
Linux video capture interface: v2.00
Bluetooth: Generic Bluetooth USB driver ver 0.4
usbcore: registered new interface driver btusb
firewire_ohci 0000:0a:09.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
firewire_ohci: Added fw-ohci device 0000:0a:09.0, OHCI version 1.10
sdhci-pci 0000:0a:09.1: SDHCI controller found [1180:0822] (rev 22)
sdhci-pci 0000:0a:09.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
sdhci-pci 0000:0a:09.1: Will use DMA mode even though HW doesn't fully claim to support it.
Registered led device: mmc0::
mmc0: SDHCI controller on PCI [0000:0a:09.1] using DMA
uvcvideo: Found UVC 1.00 device Acer CrystalEye webcam (064e:a101)
input: Acer CrystalEye webcam as /devices/pci0000:00/0000:00:1a.7/usb1/1-2/1-2:1.0/input/input10
usbcore: registered new interface driver uvcvideo
USB Video Class driver (v0.1.0)
firewire_core: created device fw0: GUID 00241b00bc6ad300, S400
  alloc irq_desc for 22 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
HDA Intel 0000:00:1b.0: setting latency timer to 64
input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input11
HDA Intel 0000:03:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
nvidia: module license 'NVIDIA' taints kernel.
iwl3945: Intel(R) PRO/Wireless 3945ABG/BG Network Connection driver for Linux, 1.2.26kds
iwl3945: Copyright(c) 2003-2008 Intel Corporation
ALSA /home/ivan/stuff/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:3798: autoconfig: line_outs=4 (0xb/0xd/0xc/0xe/0x0)
ALSA /home/ivan/stuff/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:3802:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /home/ivan/stuff/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:3806:    hp_outs=1 (0xf/0x0/0x0/0x0/0x0)
ALSA /home/ivan/stuff/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:3807:    mono: mono_out=0x0
ALSA /home/ivan/stuff/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:3818:    inputs: mic=0x11, fmic=0x0, line=0x0, fline=0x0, cd=0x0, aux=0x0
iwl3945 0000:06:00.0: enabling device (0000 -> 0002)
iwl3945 0000:06:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
iwl3945 0000:06:00.0: setting latency timer to 64
iwl3945: Tunable channels: 13 802.11bg, 23 802.11a channels
iwl3945: Detected Intel Wireless WiFi Link 3945ABG
iwl3945 0000:06:00.0: PCI INT A disabled
wmaster0 (iwl3945): not using net_device_ops yet
phy0: Selected rate control algorithm 'iwl-3945-rs'
wlan0 (iwl3945): not using net_device_ops yet
nvidia 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
nvidia 0000:01:00.0: setting latency timer to 64
NVRM: loading NVIDIA UNIX x86_64 Kernel Module  180.51  Fri Apr 17 00:08:33 PDT 2009
udev: renamed network interface wlan0 to wlan
vboxdrv: Trying to deactivate the NMI watchdog permanently...
vboxdrv: Successfully done.
vboxdrv: Found 2 processor cores.
VBoxDrv: dbg - g_abExecMemory=ffffffffa0fb7360
vboxdrv: fAsync=0 offMin=0x174 offMax=0x1824
vboxdrv: TSC mode is 'synchronous', kernel timer mode is 'normal'.
vboxdrv: Successfully loaded version 2.2.0 (interface 0x000a0009).
VBoxNetFlt: dbg - g_abExecMemory=ffffffffa1151280
vboxnet0 (): not using net_device_ops yet
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
EXT4-fs warning: mounting fs with errors, running e2fsck is recommended
EXT4 FS on sda6, internal journal on sda6:8
EXT4-fs: barriers enabled
kjournald2 starting: pid 14098, dev sda4:8, commit interval 5 seconds
EXT4 FS on sda4, internal journal on sda4:8
EXT4-fs: delayed allocation enabled
EXT4-fs: file extents enabled
EXT4-fs: mballoc enabled
EXT4-fs: mounted filesystem sda4 with ordered data mode
swap_cgroup: uses 16416 bytes of vmalloc for pointer array space and 8404992 bytes to hold mem_cgroup pointers on swap
swap_cgroup can be disabled by noswapaccount boot option.
Adding 4200956k swap on /dev/sda5.  Priority:-1 extents:1 across:4200956k 
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ip6_tables: (C) 2000-2006 Netfilter Core Team
Bluetooth: L2CAP ver 2.11
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.10
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bridge firewalling registered
IRQ 16/nvidia: IRQF_DISABLED is not guaranteed on shared IRQs
tg3 0000:08:00.0: wake-up capability disabled by ACPI
tg3 0000:08:00.0: PME# disabled
  alloc irq_desc for 29 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
tg3 0000:08:00.0: irq 29 for MSI/MSI-X
ADDRCONF(NETDEV_UP): lan: link is not ready
iwl3945 0000:06:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
iwl3945 0000:06:00.0: restoring config space at offset 0x1 (was 0x100002, writing 0x100006)
  alloc irq_desc for 30 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
iwl3945 0000:06:00.0: irq 30 for MSI/MSI-X
iwl3945 0000:06:00.0: firmware: requesting iwlwifi-3945-2.ucode
iwl3945 loaded firmware version 15.28.2.8
Registered led device: iwl-phy0:radio
Registered led device: iwl-phy0:assoc
Registered led device: iwl-phy0:RX
Registered led device: iwl-phy0:TX
ADDRCONF(NETDEV_UP): wlan: link is not ready
CE: hpet increasing min_delta_ns to 15000 nsec
ALSA /home/ivan/stuff/alsa-driver/acore/../alsa-kernel/core/pcm_lib.c:1628: playback write error (DMA or IRQ trouble?)
ALSA /home/ivan/stuff/alsa-driver/acore/../alsa-kernel/core/pcm_lib.c:1628: playback write error (DMA or IRQ trouble?)
ALSA /home/ivan/stuff/alsa-driver/acore/../alsa-kernel/core/pcm_lib.c:1628: playback write error (DMA or IRQ trouble?)
ALSA /home/ivan/stuff/alsa-driver/acore/../alsa-kernel/core/pcm_lib.c:1628: playback write error (DMA or IRQ trouble?)
ALSA /home/ivan/stuff/alsa-driver/acore/../alsa-kernel/core/pcm_lib.c:1628: playback write error (DMA or IRQ trouble?)
ALSA /home/ivan/stuff/alsa-driver/acore/../alsa-kernel/core/pcm_lib.c:1628: playback write error (DMA or IRQ trouble?)
ALSA /home/ivan/stuff/alsa-driver/acore/../alsa-kernel/core/pcm_lib.c:1628: playback write error (DMA or IRQ trouble?)

--=-6NGwTUjA1GCJZgYClN3A
Content-Disposition: attachment; filename="alsa-info.txt"
Content-Type: text/plain; name="alsa-info.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.56
!!################################

!!Script ran on: Mon Apr 20 11:49:25 UTC 2009


!!Linux Distribution
!!------------------

Gentoo Base System release 2.0.0 DISTRIB_ID="Gentoo"


!!Kernel Information
!!------------------

Kernel release:    2.6.29.1
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         Intel(R) Core(TM)2 Duo CPU T8300 @ 2.40GHz
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.19
Library version:    1.0.19
Utilities version:  1.0.19


!!Loaded ALSA modules
!!-------------------

snd_hda_intel
snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - No

ESound Daemon:
      Installed - Yes (/usr/bin/esd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xf3600000 irq 22
 1 [Generic        ]: HDA-Intel - HD-Audio Generic
                      HD-Audio Generic at 0xc2000000 irq 16


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 03)
03:00.0 Audio device: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:284b (rev 03)
	Subsystem: 1025:0121
--
03:00.0 0403: 1102:0009
	Subsystem: 1102:0018


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
bdl_pos_adj : 1,32,-1,-1,-1,-1,-1,-1
enable : Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : 0
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
index : -1,-1,-1,-1,-1,-1,-1,-1
model : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
position_fix : 0,0,0,0,0,0,0,0
power_save : 0
power_save_controller : Y
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1
probe_only : N,N,N,N,N,N,N,N
single_cmd : N

!!Module: snd_hda_intel
bdl_pos_adj : 1,32,-1,-1,-1,-1,-1,-1
enable : Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : 0
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
index : -1,-1,-1,-1,-1,-1,-1,-1
model : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
position_fix : 0,0,0,0,0,0,0,0
power_save : 0
power_save_controller : Y
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1
probe_only : N,N,N,N,N,N,N,N
single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC1200
Address: 0
Function Id: 0x1
Vendor Id: 0x10ec0888
Subsystem Id: 0x10250121
Revision Id: 0x100101
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=2, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x04 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x05 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x18 0x18]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x22
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x16 0x16]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x05 0x0b
Node 0x10 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x11 [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x00000010: OUT
  Pin Default 0x1856e130: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = White
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x10
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000003e: IN OUT HP Detect Trigger
  Pin Default 0x0221101f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=04, enabled=1
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000003e: IN OUT HP Detect Trigger
  Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000036: IN OUT Detect Trigger
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000036: IN OUT Detect Trigger
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c 0x0d 0x0e 0x0f* 0x26
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x02a19840: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x4, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x99a30941: [Fixed] Mic at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x4, Sequence = 0x1
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x0281304f: [Jack] Line In at Ext Front
    Conn = 1/8, Color = Blue
    DefAssociation = 0x4, Sequence = 0xf
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000373e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x40159505: [N/A] Speaker at Ext N/A
    Conn = Optical, Color = Pink
    DefAssociation = 0x0, Sequence = 0x5
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x00000010: OUT
  Pin Default 0x02451120: [Jack] SPDIF Out at Ext Front
    Conn = Optical, Color = Black
    DefAssociation = 0x2, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=0, ncoeff=17
  Processing Coefficient: 0x00
  Coefficient Index: 0x09
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x25 0x0b
Codec: Conexant ID 2c06
Address: 1
Function Id: 0x2
Vendor Id: 0x14f12c06
Subsystem Id: 0x10250121
Revision Id: 0x100000
Modem Function Group: 0x2
Codec: Creative CA0110-IBG
Address: 1
Function Id: 0x1
Vendor Id: 0x1102000a
Subsystem Id: 0x11021001
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xa]: 16 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x67, nsteps=0x73, stepsize=0x01, mute=0
Default Amp-Out caps: ofs=0x67, nsteps=0x67, stepsize=0x01, mute=0
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x5: Stereo Amp-Out
  Amp-Out caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
  Amp-Out vals:  [0x67 0x67]
  Converter: stream=0, channel=0
Node 0x03 [Audio Output] wcaps 0x5: Stereo Amp-Out
  Amp-Out caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
  Amp-Out vals:  [0x67 0x00]
  Converter: stream=0, channel=0
Node 0x04 [Audio Output] wcaps 0x5: Stereo Amp-Out
  Amp-Out caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
  Amp-Out vals:  [0x67 0x67]
  Converter: stream=0, channel=0
Node 0x05 [Audio Output] wcaps 0x5: Stereo Amp-Out
  Amp-Out caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
  Amp-Out vals:  [0x67 0x67]
  Converter: stream=0, channel=0
Node 0x06 [Audio Output] wcaps 0x5: Stereo Amp-Out
  Amp-Out caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
  Amp-Out vals:  [0x67 0x67]
  Converter: stream=0, channel=0
Node 0x07 [Audio Output] wcaps 0x205: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
  Amp-Out vals:  [0x67 0x67]
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
Node 0x08 [Audio Input] wcaps 0x10010b: Stereo Amp-In
  Amp-In caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
  Amp-In vals:  [0x67 0x67]
  Converter: stream=0, channel=0
  SDI-Select: 1
  Connection: 1
     0x10
Node 0x09 [Audio Input] wcaps 0x10010b: Stereo Amp-In
  Amp-In caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
  Amp-In vals:  [0x7f 0x7f]
  Converter: stream=0, channel=0
  SDI-Select: 1
  Connection: 1
     0x11
Node 0x0a [Audio Input] wcaps 0x100313: Stereo Digital Amp-In
  Amp-In caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
  Amp-In vals:  [0x67 0x67]
  Converter: stream=0, channel=0
  SDI-Select: 1
  Digital: Non-Audio Pro GenLevel
  Digital category: 0x7f
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Connection: 1
     0x13
Node 0x0b [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000001e: OUT HP Detect Trigger
  Pin Default 0x21014010: [Jack] Line Out at Sep Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x02
Node 0x0c [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000001e: OUT HP Detect Trigger
  Pin Default 0x21016011: [Jack] Line Out at Sep Rear
    Conn = 1/8, Color = Orange
    DefAssociation = 0x1, Sequence = 0x1
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x03
Node 0x0d [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000001e: OUT HP Detect Trigger
  Pin Default 0x21011012: [Jack] Line Out at Sep Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0x2
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x04
Node 0x0e [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000001e: OUT HP Detect Trigger
  Pin Default 0x21012014: [Jack] Line Out at Sep Rear
    Conn = 1/8, Color = Grey
    DefAssociation = 0x1, Sequence = 0x4
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x05
Node 0x0f [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000001e: OUT HP Detect Trigger
  Pin Default 0x0221e020: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = White
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x06
Node 0x10 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000026: IN Detect Trigger
  Pin Default 0x41813030: [N/A] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0xa0: IN HP
  Unsolicited: tag=00, enabled=0
Node 0x11 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000026: IN Detect Trigger
  Pin Default 0x02a1e040: [Jack] Mic at Ext Front
    Conn = 1/8, Color = White
    DefAssociation = 0x4, Sequence = 0x0
  Pin-ctls: 0x24: IN
  Unsolicited: tag=00, enabled=0
Node 0x12 [Pin Complex] wcaps 0x40038d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000010: OUT
  Pin Default 0x4245e150: [N/A] SPDIF Out at Ext Front
    Conn = Optical, Color = White
    DefAssociation = 0x5, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x07
Node 0x13 [Pin Complex] wcaps 0x40028b: Stereo Digital Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x42c5e160: [N/A] SPDIF In at Ext Front
    Conn = Optical, Color = White
    DefAssociation = 0x6, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0xa0: IN HP
  Unsolicited: tag=00, enabled=0
Node 0x14 [Vendor Defined Widget] wcaps 0xf00080: Mono
  Unsolicited: tag=00, enabled=0
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116,  0 Apr 20  2009 /dev/snd/controlC0
crw-rw---- 1 root audio 116, 32 Apr 20  2009 /dev/snd/controlC1
crw-rw---- 1 root audio 116,  4 Apr 20  2009 /dev/snd/hwC0D0
crw-rw---- 1 root audio 116,  5 Apr 20  2009 /dev/snd/hwC0D1
crw-rw---- 1 root audio 116, 37 Apr 20  2009 /dev/snd/hwC1D1
crw-rw---- 1 root audio 116, 24 Apr 20  2009 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116, 16 Apr 20  2009 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116, 17 Apr 20  2009 /dev/snd/pcmC0D1p
crw-rw---- 1 root audio 116, 26 Apr 20  2009 /dev/snd/pcmC0D2c
crw-rw---- 1 root audio 116, 56 Apr 20  2009 /dev/snd/pcmC1D0c
crw-rw---- 1 root audio 116, 48 Apr 20 17:47 /dev/snd/pcmC1D0p
crw-rw---- 1 root audio 116,  1 Apr 20 17:37 /dev/snd/seq
crw-rw---- 1 root audio 116, 33 Apr 20  2009 /dev/snd/timer


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

pcm.!default {
	type pulse
}

ctl.!default {
	type pulse
}



!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC1200 Analog [ALC1200 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: ALC1200 Digital [ALC1200 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Generic [HD-Audio Generic], device 0: CA0110 Analog [CA0110 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC1200 Analog [ALC1200 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 2: ALC1200 Analog [ALC1200 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Generic [HD-Audio Generic], device 0: CA0110 Analog [CA0110 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xf3600000 irq 22'
  Mixer name	: 'Realtek ALC1200'
  Components	: 'HDA:10ec0888,10250121,00100101 HDA:14f12c06,10250121,00100000'
  Controls      : 24
  Simple ctrls  : 14
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 22 [71%] [-13.50dB] [off]
Simple mixer control 'Headphone',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [0.00dB] [on]
  Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%]
  Front Right: 0 [0%]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 24 [77%] [19.50dB] [on]
  Front Right: Capture 24 [77%] [19.50dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 0 [0%] [-16.50dB] [off]
  Front Right: Capture 0 [0%] [-16.50dB] [off]
Simple mixer control 'Beep',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Mic'

!!-------Mixer controls for card 1 [Generic]

Card hw:1 'Generic'/'HD-Audio Generic at 0xc2000000 irq 16'
  Mixer name	: 'Creative CA0110-IBG'
  Components	: 'HDA:1102000a,11021001,00100000'
  Controls      : 14
  Simple ctrls  : 7
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 103
  Mono:
  Front Left: Playback 103 [100%] [0.00dB] [on]
  Front Right: Playback 103 [100%] [0.00dB] [on]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 103
  Mono:
  Front Left: Playback 103 [100%] [0.00dB] [on]
  Front Right: Playback 103 [100%] [0.00dB] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 103
  Mono:
  Front Left: Playback 103 [100%] [0.00dB] [on]
  Front Right: Playback 103 [100%] [0.00dB] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 103
  Mono: Playback 103 [100%] [0.00dB] [on]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 103
  Mono: Playback 103 [100%] [0.00dB] [on]
Simple mixer control 'Side',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 103
  Mono:
  Front Left: Playback 103 [100%] [0.00dB] [on]
  Front Right: Playback 103 [100%] [0.00dB] [on]
Simple mixer control 'Mic',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 127
  Front Left: Capture 127 [100%] [12.00dB] [on]
  Front Right: Capture 127 [100%] [12.00dB] [on]


!!Alsactl output
!!-------------

--startcollapse--
state.Intel {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'Front Playback Volume'
		value.0 31
		value.1 31
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Line Playback Volume'
		value.0 0
		value.1 0
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Line Playback Switch'
		value.0 false
		value.1 false
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Mic Playback Volume'
		value.0 0
		value.1 0
	}
	control.7 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Mic Boost'
		value.0 0
		value.1 0
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.10 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 false
		value.1 false
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -1650
		comment.dbmax 3000
		iface MIXER
		name 'Capture Volume'
		value.0 24
		value.1 24
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -1650
		comment.dbmax 3000
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.13 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Front Mic'
		comment.item.2 Line
		comment.item.3 CD
		iface MIXER
		name 'Input Source'
		value Mic
	}
	control.14 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Front Mic'
		comment.item.2 Line
		comment.item.3 CD
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
	}
	control.15 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.16 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.17 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
	control.19 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value true
	}
	control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Beep Playback Volume'
		value.0 0
		value.1 0
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Beep Playback Switch'
		value.0 false
		value.1 false
	}
	control.22 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value 22
	}
	control.23 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value false
	}
	control.24 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		comment.tlv '0000000100000008ffffec1400000014'
		comment.dbmin -5100
		comment.dbmax 0
		iface MIXER
		name 'PCM Playback Volume'
		value.0 255
		value.1 255
	}
}
state.Generic {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 103'
		comment.dbmin -5150
		comment.dbmax 0
		iface MIXER
		name 'Front Playback Volume'
		value.0 103
		value.1 103
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Surround Playback Switch'
		value.0 true
		value.1 true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 103'
		comment.dbmin -5150
		comment.dbmax 0
		iface MIXER
		name 'Surround Playback Volume'
		value.0 103
		value.1 103
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Center Playback Switch'
		value true
	}
	control.6 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'LFE Playback Switch'
		value true
	}
	control.7 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 103'
		comment.dbmin -5150
		comment.dbmax 0
		iface MIXER
		name 'Center Playback Volume'
		value 103
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 103'
		comment.dbmin -5150
		comment.dbmax 0
		iface MIXER
		name 'LFE Playback Volume'
		value 103
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Side Playback Switch'
		value.0 true
		value.1 true
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 103'
		comment.dbmin -5150
		comment.dbmax 0
		iface MIXER
		name 'Side Playback Volume'
		value.0 103
		value.1 103
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 103'
		comment.dbmin -5150
		comment.dbmax 0
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 103
		value.1 103
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Mic Capture Switch'
		value.0 true
		value.1 true
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 127'
		comment.dbmin -5150
		comment.dbmax 1200
		iface MIXER
		name 'Mic Capture Volume'
		value.0 127
		value.1 127
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
cpufreq_conservative
snd_pcm_oss
snd_mixer_oss
snd_seq_dummy
snd_seq_oss
snd_seq_midi_event
snd_seq
snd_seq_device
coretemp
hwmon
bridge
stp
llc
bnep
rfcomm
l2cap
nf_conntrack_ipv6
ip6table_filter
ip6_tables
ipv6
iptable_nat
nf_nat
acpi_cpufreq
freq_table
tun
vboxnetflt
vboxdrv
nf_conntrack_pptp
nf_conntrack_proto_gre
nf_conntrack_ftp
nf_conntrack_irc
nvidiafb
fb_ddc
i2c_algo_bit
vgastate
arc4
ecb
snd_hda_codec_ca0110
iwl3945
nvidia
snd_hda_codec_realtek
snd_hda_intel
mac80211
snd_hda_codec
snd_hwdep
snd_pcm
snd_timer
uvcvideo
snd
sdhci_pci
sdhci
firewire_ohci
btusb
videodev
mmc_core
acer_wmi
bluetooth
firewire_core
v4l1_compat
lib80211
v4l2_compat_ioctl32
cfg80211
rfkill
shpchp
i2c_i801
serio_raw
iTCO_wdt
soundcore
joydev
pcspkr
ricoh_mmc
snd_page_alloc
iTCO_vendor_support
crc_itu_t
i2c_core
wmi
video
output
tg3
e1000
fuse
xfs
exportfs
nfs
auth_rpcgss
nfs_acl
lockd
sunrpc
jfs
reiserfs
ext2
raid10
raid456
async_memcpy
async_xor
xor
async_tx
raid1
raid0
scsi_wait_scan
sl811_hcd
usb_storage
lpfc
qla2xxx
megaraid_sas
megaraid_mbox
megaraid_mm
megaraid
aacraid
sx8
DAC960
cciss
3w_9xxx
3w_xxxx
mptsas
scsi_transport_sas
mptfc
scsi_transport_fc
scsi_tgt
mptspi
mptscsih
mptbase
atp870u
dc395x
qla1280
sym53c8xx
gdth
initio
BusLogic
arcmsr
aic7xxx
aic79xx
scsi_transport_spi
pdc_adma
sata_inic162x
sata_mv
sata_qstor
sata_vsc
sata_uli
sata_sis
sata_sx4
sata_nv
sata_via
sata_svw
sata_sil24
sata_sil
sata_promise
pata_sl82c105
pata_cs5530
pata_cs5520
pata_via
pata_jmicron
pata_marvell
pata_sis
pata_netcell
pata_pdc202xx_old
pata_triflex
pata_atiixp
pata_opti
pata_amd
pata_ali
pata_it8213
pata_pcmcia
pata_ns87415
pata_ns87410
pata_serverworks
pata_cypress
pata_oldpiix
pata_artop
pata_it821x
pata_optidma
pata_hpt3x2n
pata_hpt3x3
pata_hpt37x
pata_hpt366
pata_cmd64x
pata_efar
pata_sil680
pata_pdc2027x
pata_mpiix


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x11 0x1856e130
0x14 0x0221101f
0x15 0x99130110
0x16 0x411111f0
0x17 0x411111f0
0x18 0x02a19840
0x19 0x99a30941
0x1a 0x0281304f
0x1b 0x411111f0
0x1c 0x411111f0
0x1d 0x40159505
0x1e 0x02451120
0x1f 0x411111f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D1/init_pin_configs:
0x73 0x016a10f0

/sys/class/sound/hwC0D1/driver_pin_configs:

/sys/class/sound/hwC0D1/user_pin_configs:

/sys/class/sound/hwC0D1/init_verbs:

/sys/class/sound/hwC1D1/init_pin_configs:
0x0b 0x21014010
0x0c 0x21016011
0x0d 0x21011012
0x0e 0x21012014
0x0f 0x0221e020
0x10 0x41813030
0x11 0x02a1e040
0x12 0x4245e150
0x13 0x42c5e160

/sys/class/sound/hwC1D1/driver_pin_configs:

/sys/class/sound/hwC1D1/user_pin_configs:

/sys/class/sound/hwC1D1/init_verbs:



--=-6NGwTUjA1GCJZgYClN3A
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-6NGwTUjA1GCJZgYClN3A--
