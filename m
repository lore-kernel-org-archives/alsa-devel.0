From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Wed, 27 May 2015 22:13:20 +0200
Message-ID: <20150527201320.GA309@asus>
References: <20150521145232.GA12157@dellaz> <20150523163221.GA936@asus>
 <s5h7fruecx4.wl-tiwai@suse.de> <20150527085440.GA4445@dellaz>
 <1432752116.8235.25.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id E5616260412
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 22:13:27 +0200 (CEST)
Received: by wicmx19 with SMTP id mx19so123905149wic.0
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 13:13:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1432752116.8235.25.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 27, 2015 at 07:41:56PM +0100, Liam Girdwood wrote:
> 
> > > > 
> > > > And dmesg tells me: 
> > > > [  +1.386847] rt5645 i2c-10EC5648:00: Failed to reguest IRQ: -22
> > > > [  +0.000102] rt5645 i2c-10EC5648:00: Fail gpio_request hp_det_gpio
> > > > [  +0.000094] rt5645 i2c-10EC5648:00: Fail gpio_direction hp_det_gpio
> 
> Looks like the codec has no platform data and is failing to get a valid
> IRQ number. Do you know what IRQ the code is actually requesting as it
> could be bogus ?

The IRQ was indeed -1, using the latest linux-next the IRQ is now 146, so I'll
keep using linux-next for my tests.  The gpio requested is 0.

[    1.419012] rt5645 i2c-10EC5648:00: Requesting IRQ 146
[    1.419134] rt5645 i2c-10EC5648:00: Requesting gpio 0
[    1.419141] rt5645 i2c-10EC5648:00: Fail gpio_request hp_det_gpio
[    1.419156] gpiod_direction_input: invalid GPIO
[    1.419161] rt5645 i2c-10EC5648:00: Fail gpio_direction hp_det_gpio

> > So instead of adapting the boards/byt-rt5640.c I tried to adapt
> > boards/bytcr_rt5640.c that uses
> >   .cpu_dai_name = "ssp2-port",
> >   .platform_name = "sst-mfld-platform",
> > 
> > I got a "dummy sound card" but no hardware sound card..
> 
> There are 2 BYT DSP driver upstream, they are for different HW
> configurations. Can you stick with boards/byt-rt5640.c for the moment
> until we can debug further.
> 
> > 
> > I remember that the errors
> > > > [  +1.386847] rt5645 i2c-10EC5648:00: Failed to reguest IRQ: -22
> > > > [  +0.000102] rt5645 i2c-10EC5648:00: Fail gpio_request hp_det_gpio
> > > > [  +0.000094] rt5645 i2c-10EC5648:00: Fail gpio_direction hp_det_gpio
> > remain.  Now I don't have access to the laptop, so I cannot post the new 
> > errors that showed up, but if you want me to make some experiments, I'll 
> > do :)
> > 
> 
> Ok, lets get the dev_dbg() output enabled for sst-baytrail*.c and we can
> take it from there.

Sure, these new lines appeared:

[    1.515886] baytrail-pcm-audio baytrail-pcm-audio: initialising Byt DSP IPC
[    1.519619] baytrail-pcm-audio baytrail-pcm-audio: header sign=$SST\xffffffb4^M^D size=0x40db4 modules=0x1 fmt=0x100 size=32

Full dmesg output:

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.1.0-rc5-next-20150527-asus+ (zio@asus) (gcc version 5.1.0 (GCC) ) #12 SMP PREEMPT Wed May 27 21:45:00 CEST 2015
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-linux-asus root=/dev/mmcblk0p2 rw quiet
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'lazy' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x000000007bf13fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007bf14000-0x000000007bf43fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007bf44000-0x000000007bf77fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007bf78000-0x000000007c040fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007c041000-0x000000007c928fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007c929000-0x000000007c984fff] type 20
[    0.000000] BIOS-e820: [mem 0x000000007c985000-0x000000007cbfffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed08fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffb00000-0x00000000ffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.31 by American Megatrends
[    0.000000] efi:  ACPI=0x7bf77000  ACPI 2.0=0x7bf77014  SMBIOS=0x7c928190 
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: ASUSTeK COMPUTER INC. X205TA/X205TA, BIOS X205TA.205 10/06/2014
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x7cc00 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F80000000 write-back
[    0.000000]   1 base 07E000000 mask FFE000000 uncachable
[    0.000000]   2 base 07D000000 mask FFF000000 uncachable
[    0.000000]   3 base 07CE00000 mask FFFE00000 uncachable
[    0.000000]   4 base 07CE00000 mask FFFE00000 uncachable
[    0.000000]   5 base 07CD00000 mask FFFF00000 uncachable
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01b36000, 0x01b36fff] PGTABLE
[    0.000000] BRK [0x01b37000, 0x01b37fff] PGTABLE
[    0.000000] BRK [0x01b38000, 0x01b38fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x7ba00000-0x7bbfffff]
[    0.000000]  [mem 0x7ba00000-0x7bbfffff] page 2M
[    0.000000] BRK [0x01b39000, 0x01b39fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x60000000-0x7b9fffff]
[    0.000000]  [mem 0x60000000-0x7b9fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x40000000-0x5fffffff]
[    0.000000]  [mem 0x40000000-0x5fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x1fffffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x1fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x20200000-0x3fffffff]
[    0.000000]  [mem 0x20200000-0x3fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x7bc00000-0x7bf13fff]
[    0.000000]  [mem 0x7bc00000-0x7bdfffff] page 2M
[    0.000000]  [mem 0x7be00000-0x7bf13fff] page 4k
[    0.000000] BRK [0x01b3a000, 0x01b3afff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x7c985000-0x7cbfffff]
[    0.000000]  [mem 0x7c985000-0x7c9fffff] page 4k
[    0.000000]  [mem 0x7ca00000-0x7cbfffff] page 2M
[    0.000000] BRK [0x01b3b000, 0x01b3bfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x37b50000-0x37d9ffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000007BF77014 000024 (v02 _ASUS_)
[    0.000000] ACPI: XSDT 0x000000007BF760F8 0000D4 (v01 _ASUS_ Notebook 00000003 MSFT 0100000D)
[    0.000000] ACPI: FACP 0x000000007BF72000 00010C (v05 _ASUS_ Notebook 00000003 AMI  0100000D)
[    0.000000] ACPI: DSDT 0x000000007BF5B000 0126F4 (v02 _ASUS_ Notebook 00000003 AMI  0100000D)
[    0.000000] ACPI: TCPA 0x000000007BF75000 000032 (v02                 00000000      00000000)
[    0.000000] ACPI: UEFI 0x000000007BFF4000 000042 (v01 _ASUS_ Notebook 00000000      00000000)
[    0.000000] ACPI: OEM0 0x000000007BF74000 000084 (v05 _ASUS_ BATTERY  00000003 AMI  0100000D)
[    0.000000] ACPI: DBG2 0x000000007BF73000 000072 (v00 _ASUS_ INTLDBG2 00000003 AMI  0100000D)
[    0.000000] ACPI: HPET 0x000000007BF71000 000038 (v01 _ASUS_ Notebook 00000003 AMI  0100000D)
[    0.000000] ACPI: LPIT 0x000000007BF70000 000104 (v01 _ASUS_ Notebook 00000003 AMI  0100000D)
[    0.000000] ACPI: APIC 0x000000007BF6F000 00006C (v03 _ASUS_ Notebook 00000003 AMI  0100000D)
[    0.000000] ACPI: MCFG 0x000000007BF6E000 00003C (v01 _ASUS_ Notebook 00000003 AMI  0100000D)
[    0.000000] ACPI: SSDT 0x000000007BF5A000 000603 (v01 _ASUS_ CpuDptf  00000003 AMI  0100000D)
[    0.000000] ACPI: SSDT 0x000000007BF58000 001BE2 (v01 _ASUS_ DptfTab  00000003 AMI  0100000D)
[    0.000000] ACPI: SSDT 0x000000007BF57000 000058 (v01 _ASUS_ LowPwrM  00000003 AMI  0100000D)
[    0.000000] ACPI: SSDT 0x000000007BF56000 0000FF (v01 _ASUS_ SoCDptf  00000003 AMI  0100000D)
[    0.000000] ACPI: FPDT 0x000000007BF55000 000044 (v01 _ASUS_ Notebook 01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x000000007BF54000 000763 (v01 PmRef  CpuPm    00003000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x000000007BF53000 000290 (v01 PmRef  Cpu0Tst  00003000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x000000007BF52000 00017A (v01 PmRef  ApTst    00003000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x000000007BF51000 000427 (v01 Intel_ Tpm2Tabl 00001000 INTL 20061109)
[    0.000000] ACPI: TPM2 0x000000007BF50000 000034 (v03                 00000000      00000000)
[    0.000000] ACPI: BGRT 0x000000007BF4F000 000038 (v01 _ASUS_ Notebook 01072009 AMI  00010013)
[    0.000000] ACPI: CSRT 0x000000007BF4E000 00014C (v00 _ASUS_ Notebook 00000005 INTL 20120624)
[    0.000000] ACPI: MSDM 0x000000007BF42F90 000055 (v03 _ASUS_ Notebook 00000000 ASUS 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000]  [ffffea0000000000-ffffea0001ffffff] PMD -> [ffff880076c00000-ffff880078bfffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x000000007cbfffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000008efff]
[    0.000000]   node   0: [mem 0x0000000000090000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001fffffff]
[    0.000000]   node   0: [mem 0x0000000020200000-0x000000007bf13fff]
[    0.000000]   node   0: [mem 0x000000007c985000-0x000000007cbfffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000007cbfffff]
[    0.000000] On node 0 totalpages: 507691
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 22 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7920 pages used for memmap
[    0.000000]   DMA32 zone: 503695 pages, LIFO batch:31
[    0.000000] x86/hpet: Will disable the HPET for this platform because it's not reliable
[    0.000000] Reserving Intel graphics stolen memory at 0x7cf00000-0x7eefffff
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-86
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] e820: [mem 0x7ef00000-0xe00f7fff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.000000] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 34 pages/cpu @ffff88007ba00000 s98840 r8192 d32232 u524288
[    0.000000] pcpu-alloc: s98840 r8192 d32232 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 499685
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-linux-asus root=/dev/mmcblk0p2 rw quiet
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 1936940K/2030764K available (6031K kernel code, 947K rwdata, 1860K rodata, 1180K init, 1132K bss, 93824K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] NR_IRQS:4352 nr_irqs:1024 0
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] Maximum core-clock to bus-clock ratio: 0x10
[    0.000000] Resolved frequency ID: 0, frequency: 83200 KHz
[    0.000000] TSC runs at 1331200 KHz
[    0.000000] lapic_timer_frequency = 277333
[    0.000000] tsc: Detected 1331.200 MHz processor
[    0.000058] Calibrating delay loop (skipped), value calculated using timer frequency.. 2663.33 BogoMIPS (lpj=4437333)
[    0.000066] pid_max: default: 32768 minimum: 301
[    0.000088] ACPI: Core revision 20150515
[    0.057400] ACPI: All ACPI Tables successfully acquired
[    0.059395] Security Framework initialized
[    0.059403] Yama: becoming mindful.
[    0.059437] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.059444] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.059869] Initializing cgroup subsys blkio
[    0.059879] Initializing cgroup subsys memory
[    0.059899] Initializing cgroup subsys devices
[    0.059907] Initializing cgroup subsys freezer
[    0.059915] Initializing cgroup subsys net_cls
[    0.059949] CPU: Physical Processor ID: 0
[    0.059954] CPU: Processor Core ID: 0
[    0.059961] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.059965] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.064870] mce: CPU supports 6 MCE banks
[    0.064883] CPU0: Thermal monitoring enabled (TM1)
[    0.064890] process: using mwait in idle threads
[    0.064898] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
[    0.064902] Last level dTLB entries: 4KB 128, 2MB 16, 4MB 16, 1GB 0
[    0.065130] Freeing SMP alternatives memory: 20K (ffffffff81a15000 - ffffffff81a1a000)
[    0.066745] Ignoring BGRT: invalid status 0 (expected 1)
[    0.071289] ftrace: allocating 22974 entries in 90 pages
[    0.089998] TSC deadline timer enabled
[    0.090008] smpboot: CPU0: Intel(R) Atom(TM) CPU  Z3735F @ 1.33GHz (fam: 06, model: 37, stepping: 08)
[    0.090056] Performance Events: PEBS fmt2+, 8-deep LBR, Silvermont events, full-width counters, Intel PMU driver.
[    0.090078] ... version:                3
[    0.090081] ... bit width:              40
[    0.090084] ... generic registers:      2
[    0.090088] ... value mask:             000000ffffffffff
[    0.090091] ... max period:             000000ffffffffff
[    0.090094] ... fixed-purpose events:   3
[    0.090098] ... event mask:             0000000700000003
[    0.103551] x86: Booting SMP configuration:
[    0.103561] .... node  #0, CPUs:      #1
[    0.111767] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.115127]  #2 #3
[    0.134740] x86: Booted up 1 node, 4 CPUs
[    0.134748] smpboot: Total of 4 processors activated (10653.33 BogoMIPS)
[    0.135883] devtmpfs: initialized
[    0.145429] PM: Registering ACPI NVS region [mem 0x0008f000-0x0008ffff] (4096 bytes)
[    0.145436] PM: Registering ACPI NVS region [mem 0x7bf78000-0x7c040fff] (823296 bytes)
[    0.145670] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.145878] pinctrl core: initialized pinctrl subsystem
[    0.145942] RTC time: 19:45:47, date: 05/27/15
[    0.146292] NET: Registered protocol family 16
[    0.161436] cpuidle: using governor ladder
[    0.178126] cpuidle: using governor menu
[    0.178199] ACPI: bus type PCI registered
[    0.178205] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.178388] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.178395] PCI: not using MMCONFIG
[    0.178400] PCI: Using configuration type 1 for base access
[    0.189014] ACPI: Added _OSI(Module Device)
[    0.189021] ACPI: Added _OSI(Processor Device)
[    0.189025] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.189029] ACPI: Added _OSI(Processor Aggregator Device)
[    0.221347] ACPI: Dynamic OEM Table Load:
[    0.221375] ACPI: SSDT 0xFFFF880076BE9800 000501 (v01 PmRef  Cpu0Ist  00003000 INTL 20061109)
[    0.223644] ACPI: Dynamic OEM Table Load:
[    0.223668] ACPI: SSDT 0xFFFF880076BEA000 000433 (v01 PmRef  Cpu0Cst  00003001 INTL 20061109)
[    0.226530] ACPI: Dynamic OEM Table Load:
[    0.226552] ACPI: SSDT 0xFFFF880076BF2A00 00015F (v01 PmRef  ApIst    00003000 INTL 20061109)
[    0.228749] ACPI: Dynamic OEM Table Load:
[    0.228771] ACPI: SSDT 0xFFFF88007B453000 00008D (v01 PmRef  ApCst    00003000 INTL 20061109)
[    0.233025] ACPI: Interpreter enabled
[    0.233046] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20150515/hwxface-580)
[    0.233060] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20150515/hwxface-580)
[    0.233073] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S3_] (20150515/hwxface-580)
[    0.233096] ACPI: (supports S0 S5)
[    0.233101] ACPI: Using IOAPIC for interrupt routing
[    0.233163] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.243802] [Firmware Info]: PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] not reserved in ACPI motherboard resources
[    0.243810] PCI: not using MMCONFIG
[    0.243847] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.248476] ACPI: Power Resource [USBC] (on)
[    0.255908] ACPI: Power Resource [PLPE] (on)
[    0.267169] ACPI: Power Resource [CLK0] (on)
[    0.267296] ACPI: Power Resource [CLK1] (on)
[    0.267968] ACPI: Power Resource [P28T] (off)
[    0.268090] ACPI: Power Resource [P18T] (off)
[    0.273573] ACPI: Power Resource [P28X] (off)
[    0.273702] ACPI: Power Resource [P18X] (off)
[    0.273830] ACPI: Power Resource [P28P] (off)
[    0.273957] ACPI: Power Resource [P18P] (off)
[    0.274095] ACPI: Power Resource [P1XT] (off)
[    0.275581] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.283629] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.283645] acpi PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[    0.283776] \_SB_.PCI0:_OSC invalid UUID
[    0.283781] _OSC request data:1 1e 0 
[    0.283793] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    0.284188] acpi PNP0A08:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.284704] PCI host bridge to bus 0000:00
[    0.284714] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.284721] pci_bus 0000:00: root bus resource [io  0x0070-0x0077]
[    0.284727] pci_bus 0000:00: root bus resource [io  0x0000-0x006f window]
[    0.284733] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7 window]
[    0.284739] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.284745] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.284751] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.284757] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000fffff window]
[    0.284764] pci_bus 0000:00: root bus resource [mem 0x90c00000-0x90ffffff window]
[    0.284770] pci_bus 0000:00: root bus resource [mem 0x7cf00001-0x7ef00000 window]
[    0.284776] pci_bus 0000:00: root bus resource [mem 0x80000000-0x908ffffe window]
[    0.284782] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed40fff window]
[    0.284799] pci 0000:00:00.0: [8086:0f00] type 00 class 0x060000
[    0.285060] pci 0000:00:02.0: [8086:0f31] type 00 class 0x030000
[    0.285090] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x903fffff]
[    0.285108] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff pref]
[    0.285125] pci 0000:00:02.0: reg 0x20: [io  0x1000-0x1007]
[    0.285376] pci 0000:00:14.0: [8086:0f35] type 00 class 0x0c0330
[    0.285413] pci 0000:00:14.0: reg 0x10: [mem 0x90800000-0x9080ffff 64bit]
[    0.285481] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.285709] pci 0000:00:1a.0: [8086:0f18] type 00 class 0x108000
[    0.285750] pci 0000:00:1a.0: reg 0x10: [mem 0x90700000-0x907fffff]
[    0.285766] pci 0000:00:1a.0: reg 0x14: [mem 0x90600000-0x906fffff]
[    0.285850] pci 0000:00:1a.0: PME# supported from D0 D3hot
[    0.286073] pci 0000:00:1f.0: [8086:0f1c] type 00 class 0x060100
[    0.286347] pci_bus 0000:00: on NUMA node 0
[    0.287160] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.287346] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.287531] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.287716] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.287905] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.288098] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.288283] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.288482] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.301673] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.301681] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.301687] vgaarb: loaded
[    0.301691] vgaarb: bridge control possible 0000:00:02.0
[    0.301874] SCSI subsystem initialized
[    0.301898] ACPI: bus type USB registered
[    0.301961] usbcore: registered new interface driver usbfs
[    0.301994] usbcore: registered new interface driver hub
[    0.302065] usbcore: registered new device driver usb
[    0.318337] PCI: Using ACPI for IRQ routing
[    0.318346] PCI: pci_cache_line_size set to 64 bytes
[    0.318375] Expanded resource reserved due to conflict with PCI Bus 0000:00
[    0.318381] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.318386] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.318391] e820: reserve RAM buffer [mem 0x7bf14000-0x7bffffff]
[    0.318395] e820: reserve RAM buffer [mem 0x7cc00000-0x7fffffff]
[    0.318723] NetLabel: Initializing
[    0.318728] NetLabel:  domain hash size = 128
[    0.318732] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.318760] NetLabel:  unlabeled traffic allowed by default
[    0.318867] Switched to clocksource refined-jiffies
[    0.334447] pnp: PnP ACPI init
[    0.334603] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.335107] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.335116] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.335123] system 00:01: [io  0x0500-0x05fe] has been reserved
[    0.335129] system 00:01: [io  0x0600-0x061f] has been reserved
[    0.335136] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.335147] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.335421] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.337003] system 00:03: [io  0x0240-0x0259] has been reserved
[    0.337015] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.350055] pnp: PnP ACPI: found 4 devices
[    0.355915] pci_bus 0000:00: resource 4 [io  0x0070-0x0077]
[    0.355924] pci_bus 0000:00: resource 5 [io  0x0000-0x006f window]
[    0.355930] pci_bus 0000:00: resource 6 [io  0x0078-0x0cf7 window]
[    0.355937] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.355943] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.355949] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.355955] pci_bus 0000:00: resource 10 [mem 0x000e0000-0x000fffff window]
[    0.355962] pci_bus 0000:00: resource 11 [mem 0x90c00000-0x90ffffff window]
[    0.355968] pci_bus 0000:00: resource 12 [mem 0x7cf00001-0x7ef00000 window]
[    0.355974] pci_bus 0000:00: resource 13 [mem 0x80000000-0x908ffffe window]
[    0.355980] pci_bus 0000:00: resource 14 [mem 0xfed40000-0xfed40fff window]
[    0.356056] NET: Registered protocol family 2
[    0.356358] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.356434] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
[    0.356552] TCP: Hash tables configured (established 16384 bind 16384)
[    0.356608] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.356635] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.356744] NET: Registered protocol family 1
[    0.356783] pci 0000:00:02.0: Video device with shadowed ROM
[    0.357165] PCI: CLS 0 bytes, default 64
[    0.357293] Unpacking initramfs...
[    0.453874] Freeing initrd memory: 2368K (ffff880037b50000 - ffff880037da0000)
[    0.454168] microcode: CPU0 sig=0x30678, pf=0x2, revision=0x829
[    0.454185] microcode: CPU1 sig=0x30678, pf=0x2, revision=0x829
[    0.454215] microcode: CPU2 sig=0x30678, pf=0x2, revision=0x829
[    0.454234] microcode: CPU3 sig=0x30678, pf=0x2, revision=0x829
[    0.454350] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    0.454424] Scanning for low memory corruption every 60 seconds
[    0.455140] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.455178] Initialise system trusted keyring
[    0.455919] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.460427] zpool: loaded
[    0.460435] zbud: loaded
[    0.460863] VFS: Disk quotas dquot_6.6.0
[    0.460969] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.462110] Key type big_key registered
[    0.462513] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.462611] io scheduler noop registered
[    0.462619] io scheduler deadline registered
[    0.462714] io scheduler cfq registered (default)
[    0.462866] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.462916] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.463000] efifb: probing for efifb
[    0.463050] efifb: framebuffer at 0x80000000, mapped to 0xffffc90000800000, using 4160k, total 4160k
[    0.463055] efifb: mode is 1366x768x32, linelength=5504, pages=1
[    0.463058] efifb: scrolling: redraw
[    0.463064] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.473496] Console: switching to colour frame buffer device 170x48
[    0.483635] fb0: EFI VGA frame buffer device
[    0.483664] intel_idle: MWAIT substates: 0x33000020
[    0.483669] intel_idle: v0.4 model 0x37
[    0.483673] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.484191] GHES: HEST is not enabled!
[    0.484356] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.504648] 00:02: ttyS0 at I/O 0x3f8 (irq = 203, base_baud = 115200) is a 16550A
[    0.505555] hpet: number irqs doesn't agree with number of timers
[    0.505616] Linux agpgart interface v0.103
[    0.506592] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.506610] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    0.507020] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00009810
[    0.507032] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    0.507550] hub 1-0:1.0: USB hub found
[    0.507577] hub 1-0:1.0: 6 ports detected
[    0.508818] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.508832] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    0.509254] hub 2-0:1.0: USB hub found
[    0.509278] hub 2-0:1.0: 1 port detected
[    0.509681] usbcore: registered new interface driver usb-storage
[    0.509716] ACPI Warning: Could not enable fixed event - RealTimeClock (4) (20150515/evxface-654)
[    0.509929] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    0.509976] rtc_cmos 00:00: alarms up to one day, 242 bytes nvram
[    0.510002] i2c /dev entries driver
[    0.510438] Intel P-state driver initializing.
[    0.510870] sdhci: Secure Digital Host Controller Interface driver
[    0.510883] sdhci: Copyright(c) Pierre Ossman
[    0.512127] sdhci-acpi 80860F14:00: No vmmc regulator found
[    0.512145] sdhci-acpi 80860F14:00: No vqmmc regulator found
[    0.515518] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
[    0.517019] sdhci-acpi INT33BB:00: No vmmc regulator found
[    0.517037] sdhci-acpi INT33BB:00: No vqmmc regulator found
[    0.520382] mmc1: SDHCI controller on ACPI [INT33BB:00] using ADMA
[    0.521601] sdhci-acpi PNP0FFF:00: No vmmc regulator found
[    0.521610] sdhci-acpi PNP0FFF:00: No vqmmc regulator found
[    0.524787] mmc2: SDHCI controller on ACPI [PNP0FFF:00] using ADMA
[    0.524882] ledtrig-cpu: registered to indicate activity on CPUs
[    0.525914] NET: Registered protocol family 10
[    0.526609] NET: Registered protocol family 17
[    0.527783] Loading compiled-in X.509 certificates
[    0.527825] registered taskstats version 1
[    0.528337]   Magic number: 15:275:800
[    0.528519] rtc_cmos 00:00: setting system clock to 2015-05-27 19:45:48 UTC (1432755948)
[    0.529747] Freeing unused kernel memory: 1180K (ffffffff818ee000 - ffffffff81a15000)
[    0.529760] Write protecting the kernel read-only data: 8192k
[    0.530169] Freeing unused kernel memory: 100K (ffff8800015e7000 - ffff880001600000)
[    0.530317] Freeing unused kernel memory: 188K (ffff8800017d1000 - ffff880001800000)
[    0.546232] random: systemd-tmpfile urandom read with 3 bits of entropy available
[    0.650930] mmc0: MAN_BKOPS_EN bit is not set
[    0.660949] mmc0: new HS200 MMC card at address 0001
[    0.661208] mmcblk0: mmc0:0001 HBG4e 29.1 GiB 
[    0.661312] mmcblk0boot0: mmc0:0001 HBG4e partition 1 4.00 MiB
[    0.661404] mmcblk0boot1: mmc0:0001 HBG4e partition 2 4.00 MiB
[    0.661495] mmcblk0rpmb: mmc0:0001 HBG4e partition 3 4.00 MiB
[    0.663975]  mmcblk0: p1 p2
[    0.758300] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    0.759806] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    0.761314] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    0.764022] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    0.823789] mmc1: queuing unknown CIS tuple 0x91 (3 bytes)
[    0.823876] mmc1: new ultra high speed DDR50 SDIO card at address 0001
[    0.834535] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[    0.880619] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    0.936213] systemd[1]: systemd 219 running in system mode. (+PAM -AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD +IDN)
[    0.936593] systemd[1]: Detected architecture 'x86-64'.
[    0.938700] systemd[1]: Set hostname to <asus>.
[    0.997699] systemd[1]: Unit type .busname is not supported on this system.
[    1.047901] systemd[1]: Unit type .swap is not supported on this system.
[    1.051443] systemd[1]: Cannot add dependency job for unit org.freedesktop.resolve1.busname, ignoring: Unit org.freedesktop.resolve1.busname failed to load: No such file or directory.
[    1.052455] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    1.052488] systemd[1]: Starting Dispatch Password Requests to Console Directory Watch.
[    1.052752] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    1.052785] systemd[1]: Starting Arbitrary Executable File Formats File System Automount Point.
[    1.052836] systemd[1]: Reached target Swap.
[    1.052861] systemd[1]: Starting Swap.
[    1.052897] systemd[1]: Reached target Encrypted Volumes.
[    1.052922] systemd[1]: Starting Encrypted Volumes.
[    1.052958] systemd[1]: Reached target Remote File Systems.
[    1.052983] systemd[1]: Starting Remote File Systems.
[    1.053468] systemd[1]: Created slice Root Slice.
[    1.053496] systemd[1]: Starting Root Slice.
[    1.053587] systemd[1]: Listening on LVM2 metadata daemon socket.
[    1.053613] systemd[1]: Starting LVM2 metadata daemon socket.
[    1.053723] systemd[1]: Listening on Journal Socket.
[    1.053756] systemd[1]: Starting Journal Socket.
[    1.053849] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    1.053876] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[    1.054055] systemd[1]: Listening on networkd rtnetlink socket.
[    1.054081] systemd[1]: Starting networkd rtnetlink socket.
[    1.054157] systemd[1]: Listening on udev Control Socket.
[    1.054183] systemd[1]: Starting udev Control Socket.
[    1.054259] systemd[1]: Listening on Journal Socket (/dev/log).
[    1.054285] systemd[1]: Starting Journal Socket (/dev/log).
[    1.063434] systemd[1]: Listening on Journal Audit Socket.
[    1.063551] systemd[1]: Listening on Delayed Shutdown Socket.
[    1.063580] systemd[1]: Starting Delayed Shutdown Socket.
[    1.063913] systemd[1]: Created slice System Slice.
[    1.063949] systemd[1]: Starting System Slice.
[    1.064711] systemd[1]: Started Load Kernel Modules.
[    1.065071] systemd[1]: Created slice system-wpa_supplicant.slice.
[    1.065099] systemd[1]: Starting system-wpa_supplicant.slice.
[    1.066188] systemd[1]: Starting Journal Service...
[    1.066261] systemd[1]: Started File System Check on Root Device.
[    1.067486] systemd[1]: Starting Remount Root and Kernel File Systems...
[    1.068727] systemd[1]: Mounting Huge Pages File System...
[    1.068800] systemd[1]: Mounted FUSE Control File System.
[    1.070109] systemd[1]: Mounting POSIX Message Queue File System...
[    1.075913] systemd[1]: Mounting Temporary Directory...
[    1.077398] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    1.078879] systemd[1]: Mounting Configuration File System...
[    1.079977] systemd[1]: Started Set Up Additional Binary Formats.
[    1.081334] systemd[1]: Starting Apply Kernel Variables...
[    1.082794] systemd[1]: Starting Setup Virtual Console...
[    1.082982] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    1.083016] systemd[1]: Starting Device-mapper event daemon FIFOs.
[    1.083121] systemd[1]: Listening on udev Kernel Socket.
[    1.083148] systemd[1]: Starting udev Kernel Socket.
[    1.084510] systemd[1]: Starting udev Coldplug all Devices...
[    1.085964] systemd[1]: Mounting Debug File System...
[    1.086377] systemd[1]: Created slice system-getty.slice.
[    1.086411] systemd[1]: Starting system-getty.slice.
[    1.086709] systemd[1]: Created slice User and Session Slice.
[    1.086745] systemd[1]: Starting User and Session Slice.
[    1.086790] systemd[1]: Reached target Slices.
[    1.086816] systemd[1]: Starting Slices.
[    1.086961] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    1.086988] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
[    1.087035] systemd[1]: Reached target Paths.
[    1.087071] systemd[1]: Starting Paths.
[    1.089515] systemd[1]: Started Create list of required static device nodes for the current kernel.
[    1.093659] EXT4-fs (mmcblk0p2): re-mounted. Opts: data=ordered,commit=60
[    1.095730] systemd[1]: Mounted Configuration File System.
[    1.095850] systemd[1]: Mounted POSIX Message Queue File System.
[    1.095926] systemd[1]: Mounted Debug File System.
[    1.096000] systemd[1]: Mounted Huge Pages File System.
[    1.096073] systemd[1]: Mounted Temporary Directory.
[    1.102781] systemd-journald[122]: Failed to set file attributes: Inappropriate ioctl for device
[    1.105752] systemd[1]: Started Remount Root and Kernel File Systems.
[    1.107177] systemd[1]: Started Apply Kernel Variables.
[    1.134954] systemd[1]: Started udev Coldplug all Devices.
[    1.135972] systemd[1]: Started Journal Service.
[    1.175094] systemd-journald[122]: Received request to flush runtime journal from PID 1
[    1.240284] 80860F0A:00: ttyS1 at MMIO 0x90941000 (irq = 191, base_baud = 2764800) is a 16550A
[    1.240825] 80860F0A:01: ttyS2 at MMIO 0x90947000 (irq = 193, base_baud = 2764800) is a 16550A
[    1.246965] hidraw: raw HID events driver (C) Jiri Kosina
[    1.275359] dw_dmac INTL9C60:00: DesignWare DMA Controller, 8 channels
[    1.276041] dw_dmac INTL9C60:01: DesignWare DMA Controller, 8 channels
[    1.289084] ACPI: AC Adapter [ADP1] (off-line)
[    1.289617] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    1.290132] ACPI: Lid Switch [LID]
[    1.290288] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    1.290297] ACPI: Power Button [PWRB]
[    1.290415] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    1.290423] ACPI: Sleep Button [SLPB]
[    1.300506] [Firmware Bug]: No valid trip found
[    1.313691] wmi: Mapper loaded
[    1.334865] mei_txe 0000:00:1a.0: can't derive routing for PCI INT A
[    1.334875] mei_txe 0000:00:1a.0: PCI INT A: no GSI
[    1.357266] [drm] Initialized drm 1.1.0 20060810
[    1.414702] [drm] Memory usable by graphics device = 2048M
[    1.414713] checking generic (80000000 410000) vs hw (80000000 10000000)
[    1.414717] fb: switching to inteldrmfb from EFI VGA
[    1.414764] Console: switching to colour dummy device 80x25
[    1.415001] [drm] Replacing VGA console driver
[    1.415624] cfg80211: Calling CRDA to update world regulatory domain
[    1.418683] ACPI: Battery Slot [BATC] (battery present)
[    1.419012] rt5645 i2c-10EC5648:00: Requesting IRQ 146
[    1.419134] rt5645 i2c-10EC5648:00: Requesting gpio 0
[    1.419141] rt5645 i2c-10EC5648:00: Fail gpio_request hp_det_gpio
[    1.419156] gpiod_direction_input: invalid GPIO
[    1.419161] rt5645 i2c-10EC5648:00: Fail gpio_direction hp_det_gpio
[    1.426917] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.426924] [drm] Driver supports precise vblank timestamp query.
[    1.441445] input: PC Speaker as /devices/platform/pcspkr/input/input3
[    1.482674] FAT-fs (mmcblk0p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[    1.499177] clocksource tsc: mask: 0xffffffffffffffff max_cycles: 0x13303f810e3, max_idle_ns: 440795235405 ns
[    1.499220] Switched to clocksource tsc
[    1.508338] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[    1.515886] baytrail-pcm-audio baytrail-pcm-audio: initialising Byt DSP IPC
[    1.519619] baytrail-pcm-audio baytrail-pcm-audio: header sign=$SST\xffffffb4
 size=0x40db4 modules=0x1 fmt=0x100 size=32
[    1.526275] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    1.529122] SSE version of gcm_enc/dec engaged.
[    1.530339] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    1.531892] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    1.532802] Bluetooth: Core ver 2.20
[    1.532836] NET: Registered protocol family 31
[    1.532841] Bluetooth: HCI device and connection manager initialized
[    1.532850] Bluetooth: HCI socket layer initialized
[    1.532856] Bluetooth: L2CAP socket layer initialized
[    1.532870] Bluetooth: SCO socket layer initialized
[    1.533454] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    1.534229] Bluetooth: Generic Bluetooth SDIO driver ver 0.1
[    1.536497] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    1.559748] asus_wmi: ASUS WMI generic driver loaded
[    1.570437] asus_wmi: Initialization: 0x1
[    1.570544] asus_wmi: BIOS WMI version: 7.9
[    1.570630] asus_wmi: SFUN value: 0x37
[    1.573418] iTCO_vendor_support: vendor-support=0
[    1.573421] input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/input/input4
[    1.575579] asus_wmi: Number of fans: 1
[    1.577758] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    1.577862] iTCO_wdt: Found a Bay Trail SoC TCO device (Version=3, TCOBASE=0x0460)
[    1.578156] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    1.578231] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[    1.589329] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:7 / ret_size:4
[    1.595373] fbcon: inteldrmfb (fb0) is primary device
[    1.595888] asus_wmi: Backlight controlled by ACPI video driver
[    1.597220] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[    1.597943] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    1.598895] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input5
[    1.599235] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[    1.599239] [drm] Initialized i915 1.6.0 20150522 for 0000:00:02.0 on minor 0
[    1.599336] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[    1.607711] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[    1.609333] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:19 / ret_size:4
[    1.609640] input: PDEC3393:00 0B05:8585 as /devices/platform/80860F41:00/i2c-0/i2c-PDEC3393:00/0018:0B05:8585.0001/input/input6
[    1.619160] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[    1.624110] brcmfmac: brcmf_sdio_drivestrengthinit: No SDIO Drive strength init done for chip 43340 rev 2 pmurev 20
[    1.626307] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[    1.626520] usbcore: registered new interface driver brcmfmac
[    1.640675] hid-generic 0018:0B05:8585.0001: input,hidraw0: <UNKNOWN> HID v1.00 Keyboard [PDEC3393:00 0B05:8585] on 
[    1.640752] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[    1.641545] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[    1.643140] intel_rapl: Found RAPL domain package
[    1.643145] intel_rapl: Found RAPL domain core
[    1.654055] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[    1.710397] random: nonblocking pool is initialized
[    1.710444] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:633 / ret_size:7
[    1.719259] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:131 / ret_size:7
[    1.719519] input: ELAN0100:00 04F3:0401 as /devices/platform/80860F41:03/i2c-3/i2c-ELAN0100:00/0018:04F3:0401.0002/input/input7
[    1.720122] hid-generic 0018:04F3:0401.0002: input,hidraw1: <UNKNOWN> HID v1.00 Mouse [ELAN0100:00 04F3:0401] on 
[    1.720312] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[    1.727315] mousedev: PS/2 mouse device common for all mice
[    1.749656] (NULL device *): ipc: error DSP boot timeout
[    1.775944] usb 1-2: new high-speed USB device number 3 using xhci_hcd
[    1.951699] hub 1-2:1.0: USB hub found
[    1.951996] hub 1-2:1.0: 4 ports detected
[    1.953022] usb: failed to peer 1-2-port1 and usb2-port1 by location (1-2-port1:none) (usb2-port1:usb1-port1)
[    1.953035] usb 1-2-port1: failed to peer to usb2-port1 (-16)
[    1.953036] usb: port power management may be unreliable
[    1.953276] usb: failed to peer 1-2-port2 and usb2-port1 by location (1-2-port2:none) (usb2-port1:usb1-port1)
[    1.953279] usb 1-2-port2: failed to peer to usb2-port1 (-16)
[    1.953501] usb: failed to peer 1-2-port3 and usb2-port1 by location (1-2-port3:none) (usb2-port1:usb1-port1)
[    1.953513] usb 1-2-port3: failed to peer to usb2-port1 (-16)
[    1.953731] usb: failed to peer 1-2-port4 and usb2-port1 by location (1-2-port4:none) (usb2-port1:usb1-port1)
[    1.953743] usb 1-2-port4: failed to peer to usb2-port1 (-16)
[    1.955514] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[    1.969571] media: Linux media interface: v0.10
[    1.979049] Linux video capture interface: v2.00
[    1.991877] uvcvideo: Found UVC 1.00 device USB2.0 VGA UVC WebCam (04f2:b483)
[    1.991966] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[    2.000462] input: USB2.0 VGA UVC WebCam as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/input/input8
[    2.000642] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[    2.000725] usbcore: registered new interface driver uvcvideo
[    2.000726] USB Video Class driver (1.1.1)
[    2.722322] Console: switching to colour frame buffer device 170x48
[    2.734139] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    2.734141] i915 0000:00:02.0: registered panic notifier
[    3.815318] brcmfmac: brcmf_proto_bcdc_query_dcmd: brcmf_proto_bcdc_msg failed w/status -110
[    3.815328] brcmfmac: brcmf_c_preinit_dcmds: Retreiving cur_etheraddr failed, -52
[    3.815332] brcmfmac: brcmf_bus_start: failed: -52
[    3.815341] brcmfmac: brcmf_sdio_firmware_callback: dongle is not responding
[    3.815830] mmc1:0001:1: pending IRQ with no handler
[    4.566694] cfg80211: Calling CRDA to update world regulatory domain
[    7.715740] cfg80211: Calling CRDA to update world regulatory domain
[   10.863260] cfg80211: Calling CRDA to update world regulatory domain
[   14.017185] cfg80211: Calling CRDA to update world regulatory domain
[   17.163251] cfg80211: Calling CRDA to update world regulatory domain
[   20.308619] cfg80211: Calling CRDA to update world regulatory domain
[   23.454905] cfg80211: Calling CRDA to update world regulatory domain
[   26.600074] cfg80211: Calling CRDA to update world regulatory domain
[   29.749141] cfg80211: Calling CRDA to update world regulatory domain
[   32.898187] cfg80211: Calling CRDA to update world regulatory domain
[   36.047250] cfg80211: Exceeded CRDA call max attempts. Not calling CRDA


Thanks,
Michele
