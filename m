From: Tyler Yeomans <tyeo098@gmail.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Wed, 24 Jun 2015 10:24:54 -0400
Message-ID: <558ABDB6.4010702@gmail.com>
References: <5589D025.7090700@gmail.com> <20150624101115.GI19530@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090206090901050804040906"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f43.google.com (mail-qg0-f43.google.com
 [209.85.192.43])
 by alsa0.perex.cz (Postfix) with ESMTP id DC3F22605A2
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 16:24:44 +0200 (CEST)
Received: by qgev13 with SMTP id v13so14449823qge.1
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 07:24:43 -0700 (PDT)
In-Reply-To: <20150624101115.GI19530@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@intel.com, jarkko.nikula@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090206090901050804040906
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Vinod,

Thank you for looking into this.
I have attached the dmesg for this device.
Please note I have tried kernels 3.16/19 4.0 and 4.1, all with same result.
The attached dmesg file is from booting kernel 4.1/amd64:
Linux mykro 4.1.0-040100-generic #201506220235 SMP Mon Jun 22 06:36:19 
UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
On Ubuntu 15.04

I can give your direct access to the device through service like 
Teamviewer if need be.

Again, thank you for looking into this.

Tyler

On 06/24/2015 06:11 AM, Vinod Koul wrote:
> On Tue, Jun 23, 2015 at 05:31:17PM -0400, Tyler Yeomans wrote:
>> Hello Vinod,
> Pls cc relevant mailing list, in this case alsa. I have cced Liam and Jarrko
> as well
>> I am writing to you because unfortunately I have exhausted my search
>> and I am unable to get ALSA sound working on my Baytrail minipc.
>> My dmesg only reports that: byt-rt5640 byt-rt5640: ASoC: CPU DAI
>> baytrail-pcm-audio not registered
>> aplay -l rightfully says there are no sound cards as the driver is
>> not registered.
> Can you give more details of your, does this enable HDA audio or I2S audio?
>
>> I have acquired the firmware file from the chromium repo here (https://kernel.googlesource.com/pub/scm/linux/kernel/git/firmware/linux-firmware/+/refs/heads/master/intel/fw_sst_0f28.bin-48kHz_i2s_master)
>> as was directed by the OP in this forum post:
>> http://ubuntuforums.org/showthread.php?t=2254631
>>
>> But unfortunately it seems the driver is still not loading
>> correctly, even on Ubuntu 15.04 with ALSA 1.0.28
> Do you have dmesg for us to look at so that we can see what might be going
> wrong
>
>> I see on gmane you are working on Skylake driver, could your work
>> there possibly be backported to the Baytrail/RT5640 chipset?
> No they are entirely different hw, so it will not work. We have uostream BYT
> driver and they should work
>


--------------090206090901050804040906
Content-Type: text/plain; charset=UTF-8;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.txt"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.1.0-040100-generic (kernel@gomeisa) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201506220235 SMP Mon Jun 22 06:36:19 UTC 2015
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.1.0-040100-generic root=/dev/mmcblk0p2 ro quiet splash vt.handoff=7
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x000000007c016fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007c017000-0x000000007c046fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007c047000-0x000000007c073fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007c074000-0x000000007c560fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007c561000-0x000000007c664fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007c665000-0x000000007c6a8fff] type 20
[    0.000000] BIOS-e820: [mem 0x000000007c6a9000-0x000000007cbfffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed08fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffc80000-0x00000000ffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.31 by American Megatrends
[    0.000000] efi:  ACPI=0x7c073000  ACPI 2.0=0x7c073014  SMBIOS=0x7c664310 
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI:   F1/F1, BIOS 5.6.5 04/23/2015
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
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
[    0.000000] original variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 2GB, type WB
[    0.000000] reg 1, base: 2016MB, range: 32MB, type UC
[    0.000000] reg 2, base: 2000MB, range: 16MB, type UC
[    0.000000] reg 3, base: 1998MB, range: 2MB, type UC
[    0.000000] reg 4, base: 1998MB, range: 2MB, type UC
[    0.000000] reg 5, base: 1997MB, range: 1MB, type UC
[    0.000000] total RAM covered: 1997M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K 	chunk_size: 64M 	num_reg: 5  	lose cover RAM: 0G
[    0.000000] New variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 2GB, type WB
[    0.000000] reg 1, base: 1997MB, range: 1MB, type UC
[    0.000000] reg 2, base: 1998MB, range: 2MB, type UC
[    0.000000] reg 3, base: 2000MB, range: 16MB, type UC
[    0.000000] reg 4, base: 2016MB, range: 32MB, type UC
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff88000005f000] 5f000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x031ea000, 0x031eafff] PGTABLE
[    0.000000] BRK [0x031eb000, 0x031ebfff] PGTABLE
[    0.000000] BRK [0x031ec000, 0x031ecfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x7bc00000-0x7bdfffff]
[    0.000000]  [mem 0x7bc00000-0x7bdfffff] page 2M
[    0.000000] BRK [0x031ed000, 0x031edfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x60000000-0x7bbfffff]
[    0.000000]  [mem 0x60000000-0x7bbfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x40000000-0x5fffffff]
[    0.000000]  [mem 0x40000000-0x5fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x1fffffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x1fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x20200000-0x3fffffff]
[    0.000000]  [mem 0x20200000-0x3fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x7be00000-0x7c016fff]
[    0.000000]  [mem 0x7be00000-0x7bffffff] page 2M
[    0.000000]  [mem 0x7c000000-0x7c016fff] page 4k
[    0.000000] BRK [0x031ee000, 0x031eefff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x7c6a9000-0x7cbfffff]
[    0.000000]  [mem 0x7c6a9000-0x7c7fffff] page 4k
[    0.000000]  [mem 0x7c800000-0x7cbfffff] page 2M
[    0.000000] BRK [0x031ef000, 0x031effff] PGTABLE
[    0.000000] RAMDISK: [mem 0x350cc000-0x3685dfff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000007C073014 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x000000007C072100 0000AC (v01 ALASKA A M I    00000003 MSFT 0100000D)
[    0.000000] ACPI: FACP 0x000000007C06D000 00010C (v05 ALASKA A M I    00000003 AMI  0100000D)
[    0.000000] ACPI: DSDT 0x000000007C05A000 00E5EF (v02 ALASKA A M I    00000003 AMI  0100000D)
[    0.000000] ACPI: TCPA 0x000000007C071000 000032 (v02                 00000000      00000000)
[    0.000000] ACPI: UEFI 0x000000007C514000 000042 (v01 ALASKA A M I    00000000      00000000)
[    0.000000] ACPI: BCFG 0x000000007C070000 0000BD (v01 ALASKA BATTCON  00000003 AMI  0100000D)
[    0.000000] ACPI: OEM0 0x000000007C06F000 000084 (v05 ALASKA BATTERY  00000003 AMI  0100000D)
[    0.000000] ACPI: DBG2 0x000000007C06E000 000072 (v00 ALASKA INTLDBG2 00000003 AMI  0100000D)
[    0.000000] ACPI: HPET 0x000000007C06C000 000038 (v01 ALASKA A M I    00000003 AMI  0100000D)
[    0.000000] ACPI: LPIT 0x000000007C06B000 000104 (v01 ALASKA A M I    00000003 AMI  0100000D)
[    0.000000] ACPI: APIC 0x000000007C06A000 00006C (v03 ALASKA A M I    00000003 AMI  0100000D)
[    0.000000] ACPI: MCFG 0x000000007C069000 00003C (v01 ALASKA A M I    00000003 AMI  0100000D)
[    0.000000] ACPI: FPDT 0x000000007C053000 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x000000007C052000 000763 (v01 PmRef  CpuPm    00003000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x000000007C051000 000290 (v01 PmRef  Cpu0Tst  00003000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x000000007C050000 00017A (v01 PmRef  ApTst    00003000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x000000007C04F000 000427 (v01 Intel_ Tpm2Tabl 00001000 INTL 20061109)
[    0.000000] ACPI: TPM2 0x000000007C04E000 000034 (v03                 00000000      00000000)
[    0.000000] ACPI: CSRT 0x000000007C059000 00014C (v00 ALASKA A M I    00000005 INTL 20120624)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000007cbfffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x7be9a000-0x7be9efff]
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
[    0.000000]   node   0: [mem 0x0000000020200000-0x000000007c016fff]
[    0.000000]   node   0: [mem 0x000000007c6a9000-0x000000007cbfffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000007cbfffff]
[    0.000000] On node 0 totalpages: 508682
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 77 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7920 pages used for memmap
[    0.000000]   DMA32 zone: 504686 pages, LIFO batch:31
[    0.000000] x86/hpet: Will disable the HPET for this platform because it's not reliable
[    0.000000] Reserving Intel graphics stolen memory at 0x7cf00000-0x7eefffff
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-86
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0008f000-0x0008ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x7c017000-0x7c046fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7c047000-0x7c073fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7c074000-0x7c560fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7c561000-0x7c664fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7c665000-0x7c6a8fff]
[    0.000000] e820: [mem 0x7ef00000-0xe00f7fff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 34 pages/cpu @ffff88007bc00000 s100312 r8192 d30760 u524288
[    0.000000] pcpu-alloc: s100312 r8192 d30760 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 500621
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.1.0-040100-generic root=/dev/mmcblk0p2 ro quiet splash vt.handoff=7
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 1913796K/2034728K available (8264K kernel code, 1235K rwdata, 3860K rodata, 1440K init, 1292K bss, 120932K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS:16640 nr_irqs:1024 0
[    0.000000] 	Offload RCU callbacks from all CPUs
[    0.000000] 	Offload RCU callbacks from CPUs: 0-3.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] Maximum core-clock to bus-clock ratio: 0x10
[    0.000000] Resolved frequency ID: 0, frequency: 83200 KHz
[    0.000000] TSC runs at 1331200 KHz
[    0.000000] lapic_timer_frequency = 332800
[    0.000000] tsc: Detected 1331.200 MHz processor
[    0.000058] Calibrating delay loop (skipped), value calculated using timer frequency.. 2662.40 BogoMIPS (lpj=5324800)
[    0.000066] pid_max: default: 32768 minimum: 301
[    0.000080] ACPI: Core revision 20150410
[    0.037503] ACPI: All ACPI Tables successfully acquired
[    0.039196] Security Framework initialized
[    0.039220] AppArmor: AppArmor initialized
[    0.039224] Yama: becoming mindful.
[    0.039669] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.041072] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.041720] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.041737] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.042225] Initializing cgroup subsys blkio
[    0.042237] Initializing cgroup subsys memory
[    0.042259] Initializing cgroup subsys devices
[    0.042269] Initializing cgroup subsys freezer
[    0.042276] Initializing cgroup subsys net_cls
[    0.042283] Initializing cgroup subsys perf_event
[    0.042292] Initializing cgroup subsys net_prio
[    0.042300] Initializing cgroup subsys hugetlb
[    0.042347] CPU: Physical Processor ID: 0
[    0.042352] CPU: Processor Core ID: 0
[    0.042360] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.042364] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.047270] mce: CPU supports 6 MCE banks
[    0.047284] CPU0: Thermal monitoring enabled (TM1)
[    0.047291] process: using mwait in idle threads
[    0.047300] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
[    0.047304] Last level dTLB entries: 4KB 128, 2MB 16, 4MB 16, 1GB 0
[    0.047605] Freeing SMP alternatives memory: 28K (ffffffff8209e000 - ffffffff820a5000)
[    0.054679] ftrace: allocating 33528 entries in 131 pages
[    0.084274] TSC deadline timer enabled
[    0.084285] smpboot: CPU0: Intel(R) Atom(TM) CPU  Z3735F @ 1.33GHz (fam: 06, model: 37, stepping: 08)
[    0.084339] Performance Events: PEBS fmt2+, 8-deep LBR, Silvermont events, full-width counters, Intel PMU driver.
[    0.084361] ... version:                3
[    0.084365] ... bit width:              40
[    0.084368] ... generic registers:      2
[    0.084371] ... value mask:             000000ffffffffff
[    0.084374] ... max period:             000000ffffffffff
[    0.084378] ... fixed-purpose events:   3
[    0.084381] ... event mask:             0000000700000003
[    0.086629] x86: Booting SMP configuration:
[    0.086637] .... node  #0, CPUs:      #1
[    0.104733] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.105119]  #2 #3
[    0.141332] x86: Booted up 1 node, 4 CPUs
[    0.141340] smpboot: Total of 4 processors activated (10649.60 BogoMIPS)
[    0.142711] devtmpfs: initialized
[    0.155606] evm: security.selinux
[    0.155611] evm: security.SMACK64
[    0.155615] evm: security.SMACK64EXEC
[    0.155618] evm: security.SMACK64TRANSMUTE
[    0.155621] evm: security.SMACK64MMAP
[    0.155624] evm: security.ima
[    0.155627] evm: security.capability
[    0.155797] PM: Registering ACPI NVS region [mem 0x0008f000-0x0008ffff] (4096 bytes)
[    0.155804] PM: Registering ACPI NVS region [mem 0x7c074000-0x7c560fff] (5165056 bytes)
[    0.156212] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.156433] pinctrl core: initialized pinctrl subsystem
[    0.156709] RTC time: 20:30:07, date: 06/23/15
[    0.157089] NET: Registered protocol family 16
[    0.161377] cpuidle: using governor ladder
[    0.165380] cpuidle: using governor menu
[    0.165554] ACPI: bus type PCI registered
[    0.165561] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.165774] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.165782] PCI: not using MMCONFIG
[    0.165787] PCI: Using configuration type 1 for base access
[    0.174537] ACPI: Added _OSI(Module Device)
[    0.174544] ACPI: Added _OSI(Processor Device)
[    0.174549] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.174553] ACPI: Added _OSI(Processor Aggregator Device)
[    0.200971] ACPI: Dynamic OEM Table Load:
[    0.200995] ACPI: SSDT 0xFFFF880076B2A800 000501 (v01 PmRef  Cpu0Ist  00003000 INTL 20061109)
[    0.202904] ACPI: Dynamic OEM Table Load:
[    0.202925] ACPI: SSDT 0xFFFF880076B2B000 000433 (v01 PmRef  Cpu0Cst  00003001 INTL 20061109)
[    0.205468] ACPI: Dynamic OEM Table Load:
[    0.205487] ACPI: SSDT 0xFFFF880076B90A00 00015F (v01 PmRef  ApIst    00003000 INTL 20061109)
[    0.207314] ACPI: Dynamic OEM Table Load:
[    0.207333] ACPI: SSDT 0xFFFF880076BA6600 00008D (v01 PmRef  ApCst    00003000 INTL 20061109)
[    0.211162] ACPI: Interpreter enabled
[    0.211180] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20150410/hwxface-580)
[    0.211194] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20150410/hwxface-580)
[    0.211206] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S3_] (20150410/hwxface-580)
[    0.211218] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S4_] (20150410/hwxface-580)
[    0.211239] ACPI: (supports S0 S5)
[    0.211244] ACPI: Using IOAPIC for interrupt routing
[    0.211308] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.220843] [Firmware Info]: PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] not reserved in ACPI motherboard resources
[    0.220850] PCI: not using MMCONFIG
[    0.220889] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.227101] ACPI: Power Resource [USBC] (on)
[    0.228550] ACPI: Power Resource [WWPR] (off)
[    0.234610] ACPI: Power Resource [PLPE] (on)
[    0.246157] ACPI: Power Resource [CLK0] (on)
[    0.246285] ACPI: Power Resource [CLK1] (on)
[    0.252980] ACPI: Power Resource [P28X] (off)
[    0.253112] ACPI: Power Resource [P18X] (off)
[    0.253247] ACPI: Power Resource [P28P] (off)
[    0.253380] ACPI: Power Resource [P18P] (off)
[    0.253520] ACPI: Power Resource [P28T] (off)
[    0.253654] ACPI: Power Resource [P18T] (off)
[    0.253781] ACPI: Power Resource [P1XT] (off)
[    0.256849] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.256866] acpi PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[    0.256995] \_SB_.PCI0:_OSC invalid UUID
[    0.257000] _OSC request data:1 1e 0 
[    0.257012] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    0.257408] acpi PNP0A08:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.257955] PCI host bridge to bus 0000:00
[    0.257965] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.257972] pci_bus 0000:00: root bus resource [io  0x0070-0x0077]
[    0.257978] pci_bus 0000:00: root bus resource [io  0x0000-0x006f window]
[    0.257984] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7 window]
[    0.257990] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.257997] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.258003] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.258009] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000fffff window]
[    0.258015] pci_bus 0000:00: root bus resource [mem 0x90c00000-0x90ffffff window]
[    0.258021] pci_bus 0000:00: root bus resource [mem 0x7cf00001-0x7ef00000 window]
[    0.258027] pci_bus 0000:00: root bus resource [mem 0x80000000-0x908ffffe window]
[    0.258033] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed40fff window]
[    0.258050] pci 0000:00:00.0: [8086:0f00] type 00 class 0x060000
[    0.258313] pci 0000:00:02.0: [8086:0f31] type 00 class 0x030000
[    0.258335] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x903fffff]
[    0.258352] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff pref]
[    0.258369] pci 0000:00:02.0: reg 0x20: [io  0x1000-0x1007]
[    0.258642] pci 0000:00:14.0: [8086:0f35] type 00 class 0x0c0330
[    0.258670] pci 0000:00:14.0: reg 0x10: [mem 0x90800000-0x9080ffff 64bit]
[    0.258748] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.258990] pci 0000:00:1a.0: [8086:0f18] type 00 class 0x108000
[    0.259018] pci 0000:00:1a.0: reg 0x10: [mem 0x90700000-0x907fffff]
[    0.259034] pci 0000:00:1a.0: reg 0x14: [mem 0x90600000-0x906fffff]
[    0.259132] pci 0000:00:1a.0: PME# supported from D0 D3hot
[    0.259371] pci 0000:00:1f.0: [8086:0f1c] type 00 class 0x060100
[    0.260595] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.260791] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.260984] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.261178] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.261370] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.261586] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.261779] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.261973] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.274045] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.274054] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.274059] vgaarb: loaded
[    0.274063] vgaarb: bridge control possible 0000:00:02.0
[    0.274760] SCSI subsystem initialized
[    0.274890] libata version 3.00 loaded.
[    0.274981] ACPI: bus type USB registered
[    0.275048] usbcore: registered new interface driver usbfs
[    0.275085] usbcore: registered new interface driver hub
[    0.275146] usbcore: registered new device driver usb
[    0.275726] PCI: Using ACPI for IRQ routing
[    0.275733] PCI: pci_cache_line_size set to 64 bytes
[    0.275760] Expanded resource reserved due to conflict with PCI Bus 0000:00
[    0.275767] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.275773] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.275777] e820: reserve RAM buffer [mem 0x7c017000-0x7fffffff]
[    0.275783] e820: reserve RAM buffer [mem 0x7cc00000-0x7fffffff]
[    0.276107] NetLabel: Initializing
[    0.276112] NetLabel:  domain hash size = 128
[    0.276115] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.276147] NetLabel:  unlabeled traffic allowed by default
[    0.276418] Switched to clocksource refined-jiffies
[    0.294056] AppArmor: AppArmor Filesystem Enabled
[    0.294262] pnp: PnP ACPI init
[    0.294418] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.294741] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.294750] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.294757] system 00:01: [io  0x0500-0x05fe] has been reserved
[    0.294763] system 00:01: [io  0x0600-0x061f] has been reserved
[    0.294770] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.294781] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.295065] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.298335] pnp: PnP ACPI: found 3 devices
[    0.304674] pci_bus 0000:00: resource 4 [io  0x0070-0x0077]
[    0.304683] pci_bus 0000:00: resource 5 [io  0x0000-0x006f window]
[    0.304690] pci_bus 0000:00: resource 6 [io  0x0078-0x0cf7 window]
[    0.304696] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.304702] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.304708] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.304714] pci_bus 0000:00: resource 10 [mem 0x000e0000-0x000fffff window]
[    0.304721] pci_bus 0000:00: resource 11 [mem 0x90c00000-0x90ffffff window]
[    0.304727] pci_bus 0000:00: resource 12 [mem 0x7cf00001-0x7ef00000 window]
[    0.304733] pci_bus 0000:00: resource 13 [mem 0x80000000-0x908ffffe window]
[    0.304739] pci_bus 0000:00: resource 14 [mem 0xfed40000-0xfed40fff window]
[    0.304823] NET: Registered protocol family 2
[    0.305277] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.305395] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
[    0.305513] TCP: Hash tables configured (established 16384 bind 16384)
[    0.305580] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.305619] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.305778] NET: Registered protocol family 1
[    0.305820] pci 0000:00:02.0: Video device with shadowed ROM
[    0.306191] PCI: CLS 0 bytes, default 64
[    0.306345] Trying to unpack rootfs image as initramfs...
[    1.353129] Freeing initrd memory: 24136K (ffff8800350cc000 - ffff88003685e000)
[    1.353520] microcode: CPU0 sig=0x30678, pf=0x2, revision=0x82f
[    1.353539] microcode: CPU1 sig=0x30678, pf=0x2, revision=0x82f
[    1.353559] microcode: CPU2 sig=0x30678, pf=0x2, revision=0x82f
[    1.353578] microcode: CPU3 sig=0x30678, pf=0x2, revision=0x82f
[    1.353735] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    1.353860] Scanning for low memory corruption every 60 seconds
[    1.354898] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    1.354935] Initialise system trusted keyring
[    1.354994] audit: initializing netlink subsys (disabled)
[    1.355037] audit: type=2000 audit(1435091408.276:1): initialized
[    1.355820] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.361050] zpool: loaded
[    1.361057] zbud: loaded
[    1.361460] VFS: Disk quotas dquot_6.6.0
[    1.361579] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.363179] fuse init (API version 7.23)
[    1.363623] Key type big_key registered
[    1.364458] Key type asymmetric registered
[    1.364467] Asymmetric key parser 'x509' registered
[    1.364591] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    1.364690] io scheduler noop registered
[    1.364700] io scheduler deadline registered (default)
[    1.364839] io scheduler cfq registered
[    1.365097] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.365155] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.365272] efifb: probing for efifb
[    1.365337] efifb: framebuffer at 0x80000000, mapped to 0xffffc90000800000, using 8128k, total 8128k
[    1.365343] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    1.365346] efifb: scrolling: redraw
[    1.365351] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.384418] Console: switching to colour frame buffer device 240x67
[    1.403159] fb0: EFI VGA frame buffer device
[    1.403191] intel_idle: MWAIT substates: 0x33000020
[    1.403197] intel_idle: v0.4 model 0x37
[    1.403201] intel_idle: lapic_timer_reliable_states 0xffffffff
[    1.408552] [Firmware Bug]: No valid trip found
[    1.408666] GHES: HEST is not enabled!
[    1.408948] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.429095] 00:02: ttyS0 at I/O 0x3f8 (irq = 198, base_baud = 115200) is a 16550A
[    1.433748] hpet: number irqs doesn't agree with number of timers
[    1.433916] Linux agpgart interface v0.103
[    1.441322] brd: module loaded
[    1.444489] loop: module loaded
[    1.445144] libphy: Fixed MDIO Bus: probed
[    1.445155] tun: Universal TUN/TAP device driver, 1.6
[    1.445159] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.445317] PPP generic driver version 2.4.2
[    1.445755] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.445780] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    1.446198] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00009810
[    1.446210] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    1.446406] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.446414] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.446419] usb usb1: Product: xHCI Host Controller
[    1.446425] usb usb1: Manufacturer: Linux 4.1.0-040100-generic xhci-hcd
[    1.446430] usb usb1: SerialNumber: 0000:00:14.0
[    1.446774] hub 1-0:1.0: USB hub found
[    1.446803] hub 1-0:1.0: 6 ports detected
[    1.953480] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.953495] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    1.953628] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    1.953635] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.953641] usb usb2: Product: xHCI Host Controller
[    1.953646] usb usb2: Manufacturer: Linux 4.1.0-040100-generic xhci-hcd
[    1.953651] usb usb2: SerialNumber: 0000:00:14.0
[    1.954109] hub 2-0:1.0: USB hub found
[    1.954136] hub 2-0:1.0: 1 port detected
[    1.954532] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.954551] ehci-pci: EHCI PCI platform driver
[    1.954594] ehci-platform: EHCI generic platform driver
[    1.954644] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.954658] ohci-pci: OHCI PCI platform driver
[    1.954692] ohci-platform: OHCI generic platform driver
[    1.954725] uhci_hcd: USB Universal Host Controller Interface driver
[    1.954874] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    2.253713] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    2.327166] clocksource tsc: mask: 0xffffffffffffffff max_cycles: 0x13303f810e3, max_idle_ns: 440795235405 ns
[    2.989170] i8042: No controller found
[    2.989257] Switched to clocksource tsc
[    2.989764] mousedev: PS/2 mouse device common for all mice
[    2.989944] ACPI Warning: Could not enable fixed event - RealTimeClock (4) (20150410/evxface-654)
[    2.990218] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    2.990385] rtc_cmos: probe of 00:00 failed with error -22
[    2.990484] i2c /dev entries driver
[    2.990640] device-mapper: uevent: version 1.0.3
[    2.990892] device-mapper: ioctl: 4.31.0-ioctl (2015-3-12) initialised: dm-devel@redhat.com
[    2.990923] Intel P-state driver initializing.
[    2.991164] ledtrig-cpu: registered to indicate activity on CPUs
[    2.991174] EFI Variables Facility v0.08 2004-May-17
[    2.995382] PCCT header not found.
[    2.995825] NET: Registered protocol family 10
[    2.996247] NET: Registered protocol family 17
[    2.996273] Key type dns_resolver registered
[    2.997845] Loading compiled-in X.509 certificates
[    3.000154] Loaded X.509 cert 'Build time autogenerated kernel key: a8a881c200cacfb3caeacfaf74c5469c22796873'
[    3.000186] registered taskstats version 1
[    3.010406] Key type trusted registered
[    3.010984] usb 1-1: New USB device found, idVendor=0bda, idProduct=8152
[    3.010990] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.010995] usb 1-1: Product: USB 10/100 LAN
[    3.010999] usb 1-1: Manufacturer: Realtek
[    3.011002] usb 1-1: SerialNumber: 00E04C360027
[    3.032829] Key type encrypted registered
[    3.032848] AppArmor: AppArmor sha1 policy hashing enabled
[    3.032856] ima: No TPM chip found, activating TPM-bypass!
[    3.032906] evm: HMAC attrs: 0x1
[    3.033611]   Magic number: 3:329:549
[    3.033648] tty ttyS25: hash matches
[    3.033664] clockevents clockevent0: hash matches
[    3.033723] acpi PNP0C0F:00: hash matches
[    3.033758] hctosys: unable to open rtc device (rtc0)
[    3.034108] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    3.034111] EDD information not available.
[    3.034369] PM: Hibernation image not present or could not be loaded.
[    3.036259] Freeing unused kernel memory: 1440K (ffffffff81f36000 - ffffffff8209e000)
[    3.036265] Write protecting the kernel read-only data: 14336k
[    3.038990] Freeing unused kernel memory: 1964K (ffff880002815000 - ffff880002a00000)
[    3.039897] Freeing unused kernel memory: 236K (ffff880002dc5000 - ffff880002e00000)
[    3.086508] random: systemd-udevd urandom read with 2 bits of entropy available
[    3.120797] sdhci: Secure Digital Host Controller Interface driver
[    3.120803] sdhci: Copyright(c) Pierre Ossman
[    3.127797] sdhci-acpi 80860F14:00: No vmmc regulator found
[    3.127806] sdhci-acpi 80860F14:00: No vqmmc regulator found
[    3.132735] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
[    3.133958] sdhci-acpi INT33BB:00: No vmmc regulator found
[    3.133964] sdhci-acpi INT33BB:00: No vqmmc regulator found
[    3.137513] mmc1: SDHCI controller on ACPI [INT33BB:00] using ADMA
[    3.138896] sdhci-acpi 80860F14:02: No vmmc regulator found
[    3.138903] sdhci-acpi 80860F14:02: No vqmmc regulator found
[    3.142539] mmc2: SDHCI controller on ACPI [80860F14:02] using ADMA
[    3.164947] [drm] Initialized drm 1.1.0 20060810
[    3.177078] usb 1-2: new high-speed USB device number 3 using xhci_hcd
[    3.227386] [drm] Memory usable by graphics device = 2048M
[    3.227396] checking generic (80000000 7f0000) vs hw (80000000 10000000)
[    3.227400] fb: switching to inteldrmfb from EFI VGA
[    3.227445] Console: switching to colour dummy device 80x25
[    3.227680] [drm] Replacing VGA console driver
[    3.231367] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.231374] [drm] Driver supports precise vblank timestamp query.
[    3.241959] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    3.277610] [drm] failed to retrieve link info, disabling eDP
[    3.308933] mmc0: MAN_BKOPS_EN bit is not set
[    3.309843] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    3.310164] usb 1-2: New USB device found, idVendor=05e3, idProduct=0608
[    3.310188] usb 1-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    3.310203] usb 1-2: Product: USB2.0 Hub
[    3.311206] acpi device:09: registered as cooling_device4
[    3.311399] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input0
[    3.312053] [drm] Initialized i915 1.6.0 20150327 for 0000:00:02.0 on minor 0
[    3.313684] hub 1-2:1.0: USB hub found
[    3.314070] hub 1-2:1.0: 4 ports detected
[    3.319571] mmc0: new HS200 MMC card at address 0001
[    3.324592] mmcblk0: mmc0:0001 SEM32G 29.1 GiB 
[    3.324781] mmcblk0boot0: mmc0:0001 SEM32G partition 1 4.00 MiB
[    3.325214] mmcblk0boot1: mmc0:0001 SEM32G partition 2 4.00 MiB
[    3.325390] mmcblk0rpmb: mmc0:0001 SEM32G partition 3 4.00 MiB
[    3.328197]  mmcblk0: p1 p2 p3
[    3.360673] fbcon: inteldrmfb (fb0) is primary device
[    3.412489] mmc1: new high speed SDIO card at address 0001
[    3.589147] usb 1-2.1: new low-speed USB device number 4 using xhci_hcd
[    3.617394] Console: switching to colour frame buffer device 240x67
[    3.631621] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    3.631625] i915 0000:00:02.0: registered panic notifier
[    3.685317] usb 1-2.1: New USB device found, idVendor=192f, idProduct=0916
[    3.685321] usb 1-2.1: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    3.685327] usb 1-2.1: Product: USB Optical Mouse
[    3.685637] usb 1-2.1: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
[    3.694436] hidraw: raw HID events driver (C) Jiri Kosina
[    3.701988] usbcore: registered new interface driver usbhid
[    3.701994] usbhid: USB HID core driver
[    3.705593] input: USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.1/1-2.1:1.0/0003:192F:0916.0001/input/input1
[    3.706156] hid-generic 0003:192F:0916.0001: input,hidraw0: USB HID v1.11 Mouse [USB Optical Mouse] on usb-0000:00:14.0-2.1/input0
[    3.765483] usb 1-2.2: new low-speed USB device number 5 using xhci_hcd
[    3.869974] usb 1-2.2: New USB device found, idVendor=1c4f, idProduct=0002
[    3.869982] usb 1-2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.869986] usb 1-2.2: Product: USB Keykoard
[    3.869990] usb 1-2.2: Manufacturer: USB
[    3.870511] usb 1-2.2: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
[    3.870523] usb 1-2.2: ep 0x82 - rounding interval to 64 microframes, ep desc says 80 microframes
[    3.874131] input: USB USB Keykoard as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.2/1-2.2:1.0/0003:1C4F:0002.0002/input/input2
[    3.930155] hid-generic 0003:1C4F:0002.0002: input,hidraw1: USB HID v1.10 Keyboard [USB USB Keykoard] on usb-0000:00:14.0-2.2/input0
[    3.934924] input: USB USB Keykoard as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.2/1-2.2:1.1/0003:1C4F:0002.0003/input/input3
[    3.989962] hid-generic 0003:1C4F:0002.0003: input,hidraw2: USB HID v1.10 Device [USB USB Keykoard] on usb-0000:00:14.0-2.2/input1
[    4.061760] usb 1-2.3: new low-speed USB device number 6 using xhci_hcd
[    4.122148] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[    4.157636] usb 1-2.3: New USB device found, idVendor=0755, idProduct=3317
[    4.157644] usb 1-2.3: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    4.157649] usb 1-2.3: Product: iRFmedia_cIR
[    4.162599] input: iRFmedia_cIR as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.3/1-2.3:1.0/0003:0755:3317.0004/input/input4
[    4.221773] hid-generic 0003:0755:3317.0004: input,hidraw3: USB HID v1.10 Keyboard [iRFmedia_cIR] on usb-0000:00:14.0-2.3/input0
[    4.227332] input: iRFmedia_cIR as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.3/1-2.3:1.1/0003:0755:3317.0005/input/input5
[    4.286801] hid-generic 0003:0755:3317.0005: input,hidraw4: USB HID v1.10 Mouse [iRFmedia_cIR] on usb-0000:00:14.0-2.3/input1
[    4.361509] usb 1-2.4: new high-speed USB device number 7 using xhci_hcd
[    4.368617] systemd[1]: RTC configured in localtime, applying delta of -240 minutes to system time.
[    4.399789] systemd[1]: Inserted module 'autofs4'
[    4.426718] systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT -GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID -ELFUTILS +KMOD -IDN)
[    4.427109] systemd[1]: Detected architecture x86-64.
[    4.428407] systemd[1]: Set hostname to <mykro>.
[    4.449786] usb 1-2.4: New USB device found, idVendor=05e3, idProduct=0608
[    4.449794] usb 1-2.4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    4.449799] usb 1-2.4: Product: USB2.0 Hub
[    4.450556] hub 1-2.4:1.0: USB hub found
[    4.450825] hub 1-2.4:1.0: 4 ports detected
[    4.625665] systemd[1]: Reached target Remote File Systems (Pre).
[    4.625695] systemd[1]: Starting Remote File Systems (Pre).
[    4.625858] systemd[1]: Created slice Root Slice.
[    4.625883] systemd[1]: Starting Root Slice.
[    4.626037] systemd[1]: Listening on udev Control Socket.
[    4.626061] systemd[1]: Starting udev Control Socket.
[    4.626246] systemd[1]: Listening on Journal Socket.
[    4.626281] systemd[1]: Starting Journal Socket.
[    4.626598] systemd[1]: Created slice System Slice.
[    4.626634] systemd[1]: Starting System Slice.
[    4.628039] systemd[1]: Starting Uncomplicated firewall...
[    4.629675] systemd[1]: Starting Nameserver information manager...
[    4.631561] systemd[1]: Started Read required files in advance.
[    4.632077] systemd[1]: Starting Read required files in advance...
[    4.634030] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    4.636056] systemd[1]: Starting Setup Virtual Console...
[    4.638210] systemd[1]: Mounting Debug File System...
[    4.638826] systemd[1]: Created slice system-getty.slice.
[    4.638893] systemd[1]: Starting system-getty.slice.
[    4.639137] systemd[1]: Listening on LVM2 metadata daemon socket.
[    4.639177] systemd[1]: Starting LVM2 metadata daemon socket.
[    4.639413] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    4.639441] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[    4.639718] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    4.639747] systemd[1]: Starting Device-mapper event daemon FIFOs.
[    4.640410] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    4.640450] systemd[1]: Starting Arbitrary Executable File Formats File System Automount Point.
[    4.640701] systemd[1]: Listening on Journal Audit Socket.
[    4.640730] systemd[1]: Starting Journal Audit Socket.
[    4.641143] systemd[1]: Created slice User and Session Slice.
[    4.641171] systemd[1]: Starting User and Session Slice.
[    4.641323] systemd[1]: Reached target Slices.
[    4.641350] systemd[1]: Starting Slices.
[    4.643116] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    4.645178] systemd[1]: Mounting Huge Pages File System...
[    4.647173] systemd[1]: Mounting POSIX Message Queue File System...
[    4.647476] systemd[1]: Reached target Encrypted Volumes.
[    4.647527] systemd[1]: Starting Encrypted Volumes.
[    4.662706] systemd[1]: Started Set Up Additional Binary Formats.
[    4.662970] systemd[1]: Listening on Delayed Shutdown Socket.
[    4.663002] systemd[1]: Starting Delayed Shutdown Socket.
[    4.663445] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    4.663474] systemd[1]: Starting system-systemd\x2dfsck.slice.
[    4.663662] systemd[1]: Listening on Journal Socket (/dev/log).
[    4.663689] systemd[1]: Starting Journal Socket (/dev/log).
[    4.663854] systemd[1]: Listening on fsck to fsckd communication Socket.
[    4.663882] systemd[1]: Starting fsck to fsckd communication Socket.
[    4.673158] systemd[1]: Starting Load Kernel Modules...
[    4.673493] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    4.673535] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
[    4.675314] systemd[1]: Starting Increase datagram queue length...
[    4.677576] systemd[1]: Started Braille Device Support.
[    4.677859] systemd[1]: Starting Braille Device Support...
[    4.678156] systemd[1]: Listening on udev Kernel Socket.
[    4.678187] systemd[1]: Starting udev Kernel Socket.
[    4.680026] systemd[1]: Starting udev Coldplug all Devices...
[    4.682800] systemd[1]: Mounted Debug File System.
[    4.683117] systemd[1]: Mounted Huge Pages File System.
[    4.683358] systemd[1]: Mounted POSIX Message Queue File System.
[    4.684188] systemd[1]: Started Uncomplicated firewall.
[    4.686425] systemd[1]: Started Create list of required static device nodes for the current kernel.
[    4.687353] systemd[1]: Started Setup Virtual Console.
[    4.692963] systemd[1]: Started Increase datagram queue length.
[    4.701388] systemd[1]: Started Nameserver information manager.
[    4.753726] systemd[1]: Listening on Syslog Socket.
[    4.753765] systemd[1]: Starting Syslog Socket.
[    4.755826] systemd[1]: Starting Journal Service...
[    4.757946] systemd[1]: Starting Create Static Device Nodes in /dev...
[    4.763492] lp: driver loaded but no devices found
[    4.772114] systemd[1]: Started udev Coldplug all Devices.
[    4.774285] systemd[1]: Starting udev Wait for Complete Device Initialization...
[    4.776297] ppdev: user-space parallel port driver
[    4.861086] systemd[1]: Started Load Kernel Modules.
[    4.863232] systemd[1]: Starting Apply Kernel Variables...
[    4.863541] systemd[1]: Mounted Configuration File System.
[    4.865337] systemd[1]: Mounting FUSE Control File System...
[    4.872033] systemd[1]: Mounted FUSE Control File System.
[    4.880063] systemd[1]: Started Apply Kernel Variables.
[    4.893385] systemd[1]: Started Create Static Device Nodes in /dev.
[    4.895548] systemd[1]: Starting udev Kernel Device Manager...
[    4.915450] systemd[1]: Started Journal Service.
[    5.105927] 80860F0A:00: ttyS4 at MMIO 0x9093b000 (irq = 191, base_baud = 2764800) is a 16550A
[    5.106881] dw_dmac INTL9C60:00: DesignWare DMA Controller, 8 channels
[    5.107698] dw_dmac INTL9C60:01: DesignWare DMA Controller, 8 channels
[    5.108688] 80860F0A:01: ttyS5 at MMIO 0x90941000 (irq = 192, base_baud = 2764800) is a 16550A
[    5.121000] axp20x i2c-INT33F4:00: AXP20x variant AXP288 found
[    5.210183] mei_txe 0000:00:1a.0: can't derive routing for PCI INT A
[    5.210191] mei_txe 0000:00:1a.0: PCI INT A: no GSI
[    5.272947] axp20x i2c-INT33F4:00: AXP20X driver loaded
[    5.274282] [Firmware Bug]: No valid trip found
[    5.310051] usbcore: registered new interface driver r8152
[    5.320447] Goodix-TS i2c-GDIX1001:00: i2c test failed attempt 1: -121
[    5.348270] usbcore: registered new interface driver cdc_ether
[    5.360403] Goodix-TS i2c-GDIX1001:00: i2c test failed attempt 2: -121
[    5.384394] Goodix-TS i2c-GDIX1001:00: I2C communication failure: -121
[    5.408613] Goodix-TS: probe of i2c-GDIX1001:00 failed with error -121
[    5.476574] usb 1-1: reset high-speed USB device number 2 using xhci_hcd
[    5.554794] SSE version of gcm_enc/dec engaged.
[    5.631399] r8152 1-1:1.0 eth0: v1.08.0 (2015/01/13)
[    5.641349] input: gpio-keys as /devices/platform/gpio-keys.0.auto/input/input6
[    5.641692] input: gpio-keys as /devices/platform/gpio-keys.1.auto/input/input7
[    5.778611] Adding 1091580k swap on /dev/mmcblk0p3.  Priority:-1 extents:1 across:1091580k SSFS
[    5.839297] intel_rapl: Found RAPL domain package
[    5.839306] intel_rapl: Found RAPL domain core
[    6.012196] (NULL device *): ipc: error DSP boot timeout
[    6.012386] byt-rt5640 byt-rt5640: ASoC: CPU DAI baytrail-pcm-audio not registered
[    6.795575] EXT4-fs (mmcblk0p2): re-mounted. Opts: errors=remount-ro
[    6.831433] systemd-journald[284]: Received request to flush runtime journal from PID 1
[    6.873892] random: nonblocking pool is initialized
[    7.046149] audit: type=1400 audit(1435105814.011:2): apparmor="STATUS" operation="profile_load" name="/usr/lib/lightdm/lightdm-guest-session" pid=517 comm="apparmor_parser"
[    7.046172] audit: type=1400 audit(1435105814.011:3): apparmor="STATUS" operation="profile_load" name="chromium" pid=517 comm="apparmor_parser"
[    7.052422] audit: type=1400 audit(1435105814.019:4): apparmor="STATUS" operation="profile_load" name="/sbin/dhclient" pid=517 comm="apparmor_parser"
[    7.052445] audit: type=1400 audit(1435105814.019:5): apparmor="STATUS" operation="profile_load" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=517 comm="apparmor_parser"
[    7.052461] audit: type=1400 audit(1435105814.019:6): apparmor="STATUS" operation="profile_load" name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=517 comm="apparmor_parser"
[    7.052476] audit: type=1400 audit(1435105814.019:7): apparmor="STATUS" operation="profile_load" name="/usr/lib/connman/scripts/dhclient-script" pid=517 comm="apparmor_parser"
[    7.083090] audit: type=1400 audit(1435105814.047:8): apparmor="STATUS" operation="profile_load" name="/usr/bin/evince" pid=517 comm="apparmor_parser"
[    7.083112] audit: type=1400 audit(1435105814.047:9): apparmor="STATUS" operation="profile_load" name="sanitized_helper" pid=517 comm="apparmor_parser"
[    7.083127] audit: type=1400 audit(1435105814.047:10): apparmor="STATUS" operation="profile_load" name="/usr/bin/evince-previewer" pid=517 comm="apparmor_parser"
[    7.083142] audit: type=1400 audit(1435105814.047:11): apparmor="STATUS" operation="profile_load" name="sanitized_helper" pid=517 comm="apparmor_parser"
[    7.382457] cgroup: new mount options do not match the existing superblock, will be ignored
[    7.707466] cfg80211: Calling CRDA to update world regulatory domain
[    7.714543] cfg80211: World regulatory domain updated:
[    7.714552] cfg80211:  DFS Master region: unset
[    7.714555] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp), (dfs_cac_time)
[    7.714562] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
[    7.714567] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
[    7.714571] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm), (N/A)
[    7.714575] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
[    7.714587] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
[18313.314146] perf interrupt took too long (2537 > 2500), lowering kernel.perf_event_max_sample_rate to 50000
[42661.156746] perf interrupt took too long (5008 > 5000), lowering kernel.perf_event_max_sample_rate to 25000

--------------090206090901050804040906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090206090901050804040906--
