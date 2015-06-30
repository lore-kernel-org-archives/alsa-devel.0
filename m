From: Tyler Yeomans <tyeo098@gmail.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Tue, 30 Jun 2015 14:24:29 -0400
Message-ID: <5592DEDD.9040205@gmail.com>
References: <5589D025.7090700@gmail.com> <20150624101115.GI19530@localhost>
 <558ABDB6.4010702@gmail.com> <20150624160314.GM19530@localhost>
 <558BA1D8.8040508@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000101000506030300040105"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f179.google.com (mail-qk0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 69C9526055E
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 20:23:38 +0200 (CEST)
Received: by qkhu186 with SMTP id u186so12672940qkh.0
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 11:23:37 -0700 (PDT)
In-Reply-To: <558BA1D8.8040508@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@intel.com>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000101000506030300040105
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Vinod,

Sorry for the delay, took me a while to locate a config that would work 
for my machine when compiling the kernel.
I have changed the irqindex_host_ipc from 5 to 0 as described in 
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093129.html
However, now I am not getting any mention of the audio components in the 
dmesg output (attached)

lsmod shows the sound modules are loaded:

$ lsmod | grep sst
snd_intel_sst_acpi      4120  1
snd_intel_sst_core     44762  1 snd_intel_sst_acpi
snd_soc_sst_mfld_platform    55617  1 snd_intel_sst_core

Aplay still says no:

$ aplay -l
aplay: device_list:268: no soundcards found...

Any thoughts?

-Tyler

On 06/25/2015 02:38 AM, Jarkko Nikula wrote:
> On 06/24/2015 07:03 PM, Vinod Koul wrote:
>> On Wed, Jun 24, 2015 at 10:24:54AM -0400, Tyler Yeomans wrote:
>>> Vinod,
>>>
>>> Thank you for looking into this.
>>> I have attached the dmesg for this device.
>>> Please note I have tried kernels 3.16/19 4.0 and 4.1, all with same 
>>> result.
>>> The attached dmesg file is from booting kernel 4.1/amd64:
>>> Linux mykro 4.1.0-040100-generic #201506220235 SMP Mon Jun 22
>>> 06:36:19 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
>>> On Ubuntu 15.04
>> I can see these errors:
>> [    6.012196] (NULL device *): ipc: error DSP boot timeout
>> [    6.012386] byt-rt5640 byt-rt5640: ASoC: CPU DAI 
>> baytrail-pcm-audio not
>> registered
>>
>> Jarrko, can you see why DSP boot fails, perhpas some resources are
>> missing/wrong
>>
> Very likely BIOS defines the DSP-host interrupt in another index what 
> code is using currently. Could you try does changing irqindex_host_ipc 
> from 5 to 0 help? Like how it is done here:
>
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093129.html 
>
>


--------------000101000506030300040105
Content-Type: text/plain; charset=UTF-8;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.txt"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.1.0 (mvix@mykro) (gcc version 4.9.2 (Ubuntu 4.9.2-10ubuntu13) ) #1 SMP Tue Jun 30 18:05:35 EDT 2015
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.1.0 root=/dev/mmcblk0p2 ro quiet splash vt.handoff=7
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
[    0.000000] efi: No EFI runtime due to 32/64-bit mismatch with kernel
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI:   F1/F1, BIOS 5.6.5 04/23/2015
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
[    0.000000] Base memory trampoline at [ffff88000005f000] 5f000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x026fa000, 0x026fafff] PGTABLE
[    0.000000] BRK [0x026fb000, 0x026fbfff] PGTABLE
[    0.000000] BRK [0x026fc000, 0x026fcfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x7bc00000-0x7bdfffff]
[    0.000000]  [mem 0x7bc00000-0x7bdfffff] page 2M
[    0.000000] BRK [0x026fd000, 0x026fdfff] PGTABLE
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
[    0.000000] BRK [0x026fe000, 0x026fefff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x7c6a9000-0x7cbfffff]
[    0.000000]  [mem 0x7c6a9000-0x7c7fffff] page 4k
[    0.000000]  [mem 0x7c800000-0x7cbfffff] page 2M
[    0.000000] BRK [0x026ff000, 0x026fffff] PGTABLE
[    0.000000] RAMDISK: [mem 0x36ccc000-0x3765dfff]
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
[    0.000000] clocksource refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] efi: Setup done, disabling due to 32/64-bit mismatch
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 33 pages/cpu @ffff88007bc00000 s94296 r8192 d32680 u524288
[    0.000000] pcpu-alloc: s94296 r8192 d32680 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 500621
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.1.0 root=/dev/mmcblk0p2 ro quiet splash vt.handoff=7
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.000000] Memory: 1926200K/2034728K available (8788K kernel code, 1075K rwdata, 2736K rodata, 1044K init, 884K bss, 108528K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	CONFIG_RCU_FANOUT set to non-default value of 32
[    0.000000] 	Additional per-CPU info printed with stalls.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS:4352 nr_irqs:1024 0
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] Maximum core-clock to bus-clock ratio: 0x10
[    0.000000] Resolved frequency ID: 0, frequency: 83200 KHz
[    0.000000] TSC runs at 1331200 KHz
[    0.000000] lapic_timer_frequency = 83200
[    0.000000] tsc: Detected 1331.200 MHz processor
[    0.000005] Calibrating delay loop (skipped), value calculated using timer frequency.. 2662.40 BogoMIPS (lpj=1331200)
[    0.000011] pid_max: default: 32768 minimum: 301
[    0.000023] ACPI: Core revision 20150410
[    0.030115] ACPI: All ACPI Tables successfully acquired
[    0.030168] Security Framework initialized
[    0.030175] SELinux:  Initializing.
[    0.030187] SELinux:  Starting in permissive mode
[    0.030209] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.030216] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.030586] Initializing cgroup subsys freezer
[    0.030621] CPU: Physical Processor ID: 0
[    0.030625] CPU: Processor Core ID: 0
[    0.030631] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.030634] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.035539] mce: CPU supports 6 MCE banks
[    0.035552] CPU0: Thermal monitoring enabled (TM1)
[    0.035557] process: using mwait in idle threads
[    0.035565] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
[    0.035568] Last level dTLB entries: 4KB 128, 2MB 16, 4MB 16, 1GB 0
[    0.035752] Freeing SMP alternatives memory: 32K (ffffffff82013000 - ffffffff8201b000)
[    0.035920] TSC deadline timer enabled
[    0.035927] smpboot: CPU0: Intel(R) Atom(TM) CPU  Z3735F @ 1.33GHz (fam: 06, model: 37, stepping: 08)
[    0.035971] Performance Events: PEBS fmt2+, 8-deep LBR, Silvermont events, full-width counters, Intel PMU driver.
[    0.035992] ... version:                3
[    0.035996] ... bit width:              40
[    0.035999] ... generic registers:      2
[    0.036002] ... value mask:             000000ffffffffff
[    0.036005] ... max period:             000000ffffffffff
[    0.036008] ... fixed-purpose events:   3
[    0.036011] ... event mask:             0000000700000003
[    0.036797] x86: Booting SMP configuration:
[    0.036805] .... node  #0, CPUs:      #1 #2 #3
[    0.091402] x86: Booted up 1 node, 4 CPUs
[    0.091410] smpboot: Total of 4 processors activated (10649.60 BogoMIPS)
[    0.092317] devtmpfs: initialized
[    0.092832] PM: Registering ACPI NVS region [mem 0x0008f000-0x0008ffff] (4096 bytes)
[    0.092838] PM: Registering ACPI NVS region [mem 0x7c074000-0x7c560fff] (5165056 bytes)
[    0.093199] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.093252] kworker/u8:0 (26) used greatest stack depth: 14208 bytes left
[    0.093395] pinctrl core: initialized pinctrl subsystem
[    0.093458] RTC time: 18:12:37, date: 06/30/15
[    0.093769] NET: Registered protocol family 16
[    0.094270] kworker/u8:0 (31) used greatest stack depth: 14120 bytes left
[    0.099438] cpuidle: using governor ladder
[    0.105448] cpuidle: using governor menu
[    0.105594] ACPI: bus type PCI registered
[    0.105722] PCI: Using configuration type 1 for base access
[    0.114551] kworker/u8:0 (368) used greatest stack depth: 14016 bytes left
[    0.123335] ACPI: Added _OSI(Module Device)
[    0.123343] ACPI: Added _OSI(Processor Device)
[    0.123347] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.123351] ACPI: Added _OSI(Processor Aggregator Device)
[    0.147702] ACPI: Dynamic OEM Table Load:
[    0.147725] ACPI: SSDT 0xFFFF880075DA8800 000501 (v01 PmRef  Cpu0Ist  00003000 INTL 20061109)
[    0.149454] ACPI: Dynamic OEM Table Load:
[    0.149473] ACPI: SSDT 0xFFFF880075DA9000 000433 (v01 PmRef  Cpu0Cst  00003001 INTL 20061109)
[    0.151805] ACPI: Dynamic OEM Table Load:
[    0.151823] ACPI: SSDT 0xFFFF880075DFB200 00015F (v01 PmRef  ApIst    00003000 INTL 20061109)
[    0.153493] ACPI: Dynamic OEM Table Load:
[    0.153510] ACPI: SSDT 0xFFFF880075DBE0C0 00008D (v01 PmRef  ApCst    00003000 INTL 20061109)
[    0.157072] ACPI: Interpreter enabled
[    0.157089] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20150410/hwxface-580)
[    0.157103] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20150410/hwxface-580)
[    0.157114] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S3_] (20150410/hwxface-580)
[    0.157126] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S4_] (20150410/hwxface-580)
[    0.157146] ACPI: (supports S0 S5)
[    0.157150] ACPI: Using IOAPIC for interrupt routing
[    0.157254] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.163073] ACPI: Power Resource [USBC] (on)
[    0.164452] ACPI: Power Resource [WWPR] (off)
[    0.170258] ACPI: Power Resource [PLPE] (on)
[    0.181076] ACPI: Power Resource [CLK0] (on)
[    0.181195] ACPI: Power Resource [CLK1] (on)
[    0.187485] ACPI: Power Resource [P28X] (off)
[    0.187610] ACPI: Power Resource [P18X] (off)
[    0.187734] ACPI: Power Resource [P28P] (off)
[    0.187857] ACPI: Power Resource [P18P] (off)
[    0.187974] ACPI: Power Resource [P28T] (off)
[    0.188095] ACPI: Power Resource [P18T] (off)
[    0.188212] ACPI: Power Resource [P1XT] (off)
[    0.191085] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.191101] acpi PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[    0.191223] \_SB_.PCI0:_OSC invalid UUID
[    0.191227] _OSC request data:1 1e 0 
[    0.191239] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    0.191685] PCI host bridge to bus 0000:00
[    0.191694] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.191701] pci_bus 0000:00: root bus resource [io  0x0070-0x0077]
[    0.191708] pci_bus 0000:00: root bus resource [io  0x0000-0x006f window]
[    0.191714] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7 window]
[    0.191720] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.191726] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.191732] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.191739] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000fffff window]
[    0.191753] pci_bus 0000:00: root bus resource [mem 0x90c00000-0x90ffffff window]
[    0.191760] pci_bus 0000:00: root bus resource [mem 0x7cf00001-0x7ef00000 window]
[    0.191766] pci_bus 0000:00: root bus resource [mem 0x80000000-0x908ffffe window]
[    0.191772] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed40fff window]
[    0.191790] pci 0000:00:00.0: [8086:0f00] type 00 class 0x060000
[    0.192034] pci 0000:00:02.0: [8086:0f31] type 00 class 0x030000
[    0.192055] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x903fffff]
[    0.192072] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff pref]
[    0.192089] pci 0000:00:02.0: reg 0x20: [io  0x1000-0x1007]
[    0.192342] pci 0000:00:14.0: [8086:0f35] type 00 class 0x0c0330
[    0.192369] pci 0000:00:14.0: reg 0x10: [mem 0x90800000-0x9080ffff 64bit]
[    0.192446] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.192664] pci 0000:00:1a.0: [8086:0f18] type 00 class 0x108000
[    0.192691] pci 0000:00:1a.0: reg 0x10: [mem 0x90700000-0x907fffff]
[    0.192707] pci 0000:00:1a.0: reg 0x14: [mem 0x90600000-0x906fffff]
[    0.192811] pci 0000:00:1a.0: PME# supported from D0 D3hot
[    0.193025] pci 0000:00:1f.0: [8086:0f1c] type 00 class 0x060100
[    0.193292] pci_bus 0000:00: on NUMA node 0
[    0.194189] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.194370] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.194548] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.194726] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.194916] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.195095] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.195275] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.195454] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.206567] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.206578] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.206584] vgaarb: loaded
[    0.206587] vgaarb: bridge control possible 0000:00:02.0
[    0.206919] SCSI subsystem initialized
[    0.207054] libata version 3.00 loaded.
[    0.207181] ACPI: bus type USB registered
[    0.207265] usbcore: registered new interface driver usbfs
[    0.207305] usbcore: registered new interface driver hub
[    0.207364] usbcore: registered new device driver usb
[    0.207493] pps_core: LinuxPPS API ver. 1 registered
[    0.207497] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.207526] PTP clock support registered
[    0.207908] Advanced Linux Sound Architecture Driver Initialized.
[    0.207978] PCI: Using ACPI for IRQ routing
[    0.207986] PCI: pci_cache_line_size set to 64 bytes
[    0.208012] Expanded resource reserved due to conflict with PCI Bus 0000:00
[    0.208020] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.208026] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.208030] e820: reserve RAM buffer [mem 0x7c017000-0x7fffffff]
[    0.208036] e820: reserve RAM buffer [mem 0x7cc00000-0x7fffffff]
[    0.208573] cfg80211: Calling CRDA to update world regulatory domain
[    0.208632] NetLabel: Initializing
[    0.208636] NetLabel:  domain hash size = 128
[    0.208640] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.208669] NetLabel:  unlabeled traffic allowed by default
[    0.208937] Switched to clocksource refined-jiffies
[    0.225521] pnp: PnP ACPI init
[    0.225660] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.225983] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.225991] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.225998] system 00:01: [io  0x0500-0x05fe] has been reserved
[    0.226004] system 00:01: [io  0x0600-0x061f] has been reserved
[    0.226011] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.226021] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.226281] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.229423] pnp: PnP ACPI: found 3 devices
[    0.235128] pci_bus 0000:00: resource 4 [io  0x0070-0x0077]
[    0.235138] pci_bus 0000:00: resource 5 [io  0x0000-0x006f window]
[    0.235144] pci_bus 0000:00: resource 6 [io  0x0078-0x0cf7 window]
[    0.235151] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.235157] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.235163] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.235169] pci_bus 0000:00: resource 10 [mem 0x000e0000-0x000fffff window]
[    0.235175] pci_bus 0000:00: resource 11 [mem 0x90c00000-0x90ffffff window]
[    0.235181] pci_bus 0000:00: resource 12 [mem 0x7cf00001-0x7ef00000 window]
[    0.235187] pci_bus 0000:00: resource 13 [mem 0x80000000-0x908ffffe window]
[    0.235194] pci_bus 0000:00: resource 14 [mem 0xfed40000-0xfed40fff window]
[    0.235262] NET: Registered protocol family 2
[    0.235689] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.235765] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
[    0.235883] TCP: Hash tables configured (established 16384 bind 16384)
[    0.235939] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.235966] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.236091] NET: Registered protocol family 1
[    0.236247] RPC: Registered named UNIX socket transport module.
[    0.236253] RPC: Registered udp transport module.
[    0.236256] RPC: Registered tcp transport module.
[    0.236259] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.236282] pci 0000:00:02.0: Video device with shadowed ROM
[    0.236637] PCI: CLS 0 bytes, default 64
[    0.236762] Unpacking initramfs...
[    0.604709] Freeing initrd memory: 9800K (ffff880036ccc000 - ffff88003765e000)
[    0.605085] microcode: CPU0 sig=0x30678, pf=0x2, revision=0x82f
[    0.605104] microcode: CPU1 sig=0x30678, pf=0x2, revision=0x82f
[    0.605118] microcode: CPU2 sig=0x30678, pf=0x2, revision=0x82f
[    0.605134] microcode: CPU3 sig=0x30678, pf=0x2, revision=0x82f
[    0.605270] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    0.606038] Scanning for low memory corruption every 60 seconds
[    0.606808] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.606876] audit: initializing netlink subsys (disabled)
[    0.606904] audit: type=2000 audit(1435687957.552:1): initialized
[    0.607437] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.612214] VFS: Disk quotas dquot_6.6.0
[    0.612322] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.613830] NFS: Registering the id_resolver key type
[    0.613856] Key type id_resolver registered
[    0.613860] Key type id_legacy registered
[    0.614162] SELinux:  Registering netfilter hooks
[    0.615400] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.615412] io scheduler noop registered
[    0.615420] io scheduler deadline registered
[    0.615580] io scheduler cfq registered (default)
[    0.615757] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.615847] efifb: probing for efifb
[    0.615895] efifb: framebuffer at 0x80000000, mapped to 0xffffc90000800000, using 8128k, total 8128k
[    0.615900] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    0.615903] efifb: scrolling: redraw
[    0.615908] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.634925] Console: switching to colour frame buffer device 240x67
[    0.652614] fb0: EFI VGA frame buffer device
[    0.656085] Monitor-Mwait will be used to enter C-1 state
[    0.656112] Monitor-Mwait will be used to enter C-2 state
[    0.656133] Monitor-Mwait will be used to enter C-3 state
[    0.656158] ACPI: acpi_idle registered with cpuidle
[    0.658832] [Firmware Bug]: No valid trip found
[    0.658992] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.679293] 00:02: ttyS0 at I/O 0x3f8 (irq = 198, base_baud = 115200) is a 16550A
[    0.680211] hpet: number irqs doesn't agree with number of timers
[    0.680377] Non-volatile memory driver v1.3
[    0.680489] Linux agpgart interface v0.103
[    0.680644] [drm] Initialized drm 1.1.0 20060810
[    0.681916] [drm] Memory usable by graphics device = 2048M
[    0.681925] checking generic (80000000 7f0000) vs hw (80000000 10000000)
[    0.681930] fb: switching to inteldrmfb from EFI VGA
[    0.681975] Console: switching to colour dummy device 80x25
[    0.682155] [drm] Replacing VGA console driver
[    0.684542] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    0.684548] [drm] Driver supports precise vblank timestamp query.
[    0.778834] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    0.795074] [drm] failed to retrieve link info, disabling eDP
[    0.838395] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    0.839705] acpi device:09: registered as cooling_device4
[    0.839888] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input0
[    0.839991] [drm] Initialized i915 1.6.0 20150327 for 0000:00:02.0 on minor 0
[    0.843528] loop: module loaded
[    0.844052] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    0.844058] e100: Copyright(c) 1999-2006 Intel Corporation
[    0.844142] usbcore: registered new interface driver r8152
[    0.844598] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.844717] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    0.845125] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00009810
[    0.845137] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    0.845298] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.845305] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.845311] usb usb1: Product: xHCI Host Controller
[    0.845316] usb usb1: Manufacturer: Linux 4.1.0 xhci-hcd
[    0.845321] usb usb1: SerialNumber: 0000:00:14.0
[    0.845641] hub 1-0:1.0: USB hub found
[    0.845667] hub 1-0:1.0: 6 ports detected
[    0.879711] fbcon: inteldrmfb (fb0) is primary device
[    1.095270] Console: switching to colour frame buffer device 240x67
[    1.112971] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    1.112976] i915 0000:00:02.0: registered panic notifier
[    1.429151] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.429264] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    1.429470] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    1.429478] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.429483] usb usb2: Product: xHCI Host Controller
[    1.429488] usb usb2: Manufacturer: Linux 4.1.0 xhci-hcd
[    1.429493] usb usb2: SerialNumber: 0000:00:14.0
[    1.429828] hub 2-0:1.0: USB hub found
[    1.429860] hub 2-0:1.0: 1 port detected
[    1.430235] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.430243] ehci-pci: EHCI PCI platform driver
[    1.430293] ehci-platform: EHCI generic platform driver
[    1.430348] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.430363] ohci-pci: OHCI PCI platform driver
[    1.430398] uhci_hcd: USB Universal Host Controller Interface driver
[    1.430493] usbcore: registered new interface driver cdc_acm
[    1.430497] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    1.430540] usbcore: registered new interface driver usblp
[    1.430575] usbcore: registered new interface driver cdc_wdm
[    1.430632] usbcore: registered new interface driver usb-storage
[    1.430735] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    1.743944] clocksource tsc: mask: 0xffffffffffffffff max_cycles: 0x13303f810e3, max_idle_ns: 440795235405 ns
[    2.473081] i8042: No controller found
[    2.473174] Switched to clocksource tsc
[    2.473212] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    2.473376] mousedev: PS/2 mouse device common for all mice
[    2.473671] ACPI Warning: Could not enable fixed event - RealTimeClock (4) (20150410/evxface-654)
[    2.473893] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    2.474005] rtc_cmos: probe of 00:00 failed with error -22
[    2.474404] device-mapper: ioctl: 4.31.0-ioctl (2015-3-12) initialised: dm-devel@redhat.com
[    2.474520] sdhci: Secure Digital Host Controller Interface driver
[    2.474525] sdhci: Copyright(c) Pierre Ossman
[    2.475703] sdhci-acpi 80860F14:00: No vmmc regulator found
[    2.475710] sdhci-acpi 80860F14:00: No vqmmc regulator found
[    2.479482] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
[    2.480659] sdhci-acpi INT33BB:00: No vmmc regulator found
[    2.480666] sdhci-acpi INT33BB:00: No vqmmc regulator found
[    2.484476] mmc1: SDHCI controller on ACPI [INT33BB:00] using ADMA
[    2.485850] sdhci-acpi 80860F14:02: No vmmc regulator found
[    2.485857] sdhci-acpi 80860F14:02: No vqmmc regulator found
[    2.489555] mmc2: SDHCI controller on ACPI [80860F14:02] using ADMA
[    2.489627] wbsd: Winbond W83L51xD SD/MMC card interface driver
[    2.489631] wbsd: Copyright(c) Pierre Ossman
[    2.489796] VUB300 Driver rom wait states = 1C irqpoll timeout = 0400
[    2.490031] usbcore: registered new interface driver vub300
[    2.490070] usbcore: registered new interface driver ushc
[    2.490146] sdhci-pltfm: SDHCI platform and OF driver helper
[    2.490204] hidraw: raw HID events driver (C) Jiri Kosina
[    2.490856] usbcore: registered new interface driver usbhid
[    2.490861] usbhid: USB HID core driver
[    2.491770] Netfilter messages via NETLINK v0.30.
[    2.491801] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[    2.492032] ctnetlink v0.93: registering with nfnetlink.
[    2.492257] ip_tables: (C) 2000-2006 Netfilter Core Team
[    2.492312] Initializing XFRM netlink socket
[    2.492716] NET: Registered protocol family 10
[    2.493256] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    2.493357] sit: IPv6 over IPv4 tunneling driver
[    2.493696] NET: Registered protocol family 17
[    2.493818] Key type dns_resolver registered
[    2.494828] registered taskstats version 1
[    2.495172]   Magic number: 3:333:242
[    2.495292] console [netcon0] enabled
[    2.495295] netconsole: network logging started
[    2.497278] PM: Hibernation image not present or could not be loaded.
[    2.497302] ALSA device list:
[    2.497306]   No soundcards found.
[    2.497922] Freeing unused kernel memory: 1044K (ffffffff81f0e000 - ffffffff82013000)
[    2.497929] Write protecting the kernel read-only data: 14336k
[    2.500517] Freeing unused kernel memory: 1444K (ffff880001e97000 - ffff880002000000)
[    2.501323] Freeing unused kernel memory: 1360K (ffff8800022ac000 - ffff880002400000)
[    2.540845] random: systemd-udevd urandom read with 7 bits of entropy available
[    2.593105] mmc0: MAN_BKOPS_EN bit is not set
[    2.598100] usb 1-1: New USB device found, idVendor=0bda, idProduct=8152
[    2.598109] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.598115] usb 1-1: Product: USB 10/100 LAN
[    2.598120] usb 1-1: Manufacturer: Realtek
[    2.598125] usb 1-1: SerialNumber: 00E04C360027
[    2.602785] mmc0: new HS200 MMC card at address 0001
[    2.602997] mmcblk0: mmc0:0001 SEM32G 29.1 GiB 
[    2.603089] mmcblk0boot0: mmc0:0001 SEM32G partition 1 4.00 MiB
[    2.603179] mmcblk0boot1: mmc0:0001 SEM32G partition 2 4.00 MiB
[    2.603628] mmcblk0rpmb: mmc0:0001 SEM32G partition 3 4.00 MiB
[    2.607526]  mmcblk0: p1 p2 p3
[    2.679530] mmc1: new high speed SDIO card at address 0001
[    2.754435] usb 1-2: new high-speed USB device number 3 using xhci_hcd
[    2.810787] loadkeys (1160) used greatest stack depth: 13320 bytes left
[    2.883154] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[    2.920468] usb 1-2: New USB device found, idVendor=05e3, idProduct=0608
[    2.920477] usb 1-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    2.920482] usb 1-2: Product: USB2.0 Hub
[    2.921113] hub 1-2:1.0: USB hub found
[    2.921363] hub 1-2:1.0: 4 ports detected
[    3.072472] usb 1-1: reset high-speed USB device number 2 using xhci_hcd
[    3.260167] r8152 1-1:1.0 eth0: v1.08.0 (2015/01/13)
[    3.298481] usb 1-2.2: new low-speed USB device number 4 using xhci_hcd
[    3.382461] usb 1-2.2: New USB device found, idVendor=1c4f, idProduct=0002
[    3.382469] usb 1-2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.382475] usb 1-2.2: Product: USB Keykoard
[    3.382480] usb 1-2.2: Manufacturer: USB
[    3.382699] usb 1-2.2: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
[    3.382712] usb 1-2.2: ep 0x82 - rounding interval to 64 microframes, ep desc says 80 microframes
[    3.385685] input: USB USB Keykoard as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.2/1-2.2:1.0/0003:1C4F:0002.0001/input/input1
[    3.436378] hid-generic 0003:1C4F:0002.0001: input,hidraw0: USB HID v1.10 Keyboard [USB USB Keykoard] on usb-0000:00:14.0-2.2/input0
[    3.439011] input: USB USB Keykoard as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.2/1-2.2:1.1/0003:1C4F:0002.0002/input/input2
[    3.490372] hid-generic 0003:1C4F:0002.0002: input,hidraw1: USB HID v1.10 Device [USB USB Keykoard] on usb-0000:00:14.0-2.2/input1
[    3.553401] usb 1-2.3: new low-speed USB device number 5 using xhci_hcd
[    3.594919] systemd[1]: RTC configured in localtime, applying delta of -240 minutes to system time.
[    3.642050] usb 1-2.3: New USB device found, idVendor=0755, idProduct=3317
[    3.642059] usb 1-2.3: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    3.642065] usb 1-2.3: Product: iRFmedia_cIR
[    3.645333] input: iRFmedia_cIR as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.3/1-2.3:1.0/0003:0755:3317.0003/input/input3
[    3.662902] systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT -GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID -ELFUTILS +KMOD -IDN)
[    3.663378] systemd[1]: Detected architecture x86-64.
[    3.664222] systemd[1]: Set hostname to <mykro>.
[    3.668129] cfg80211: Calling CRDA to update world regulatory domain
[    3.696343] hid-generic 0003:0755:3317.0003: input,hidraw2: USB HID v1.10 Keyboard [iRFmedia_cIR] on usb-0000:00:14.0-2.3/input0
[    3.700675] input: iRFmedia_cIR as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.3/1-2.3:1.1/0003:0755:3317.0004/input/input4
[    3.751400] hid-generic 0003:0755:3317.0004: input,hidraw3: USB HID v1.10 Mouse [iRFmedia_cIR] on usb-0000:00:14.0-2.3/input1
[    3.763966] systemd-sysv-ge (1235) used greatest stack depth: 13240 bytes left
[    3.814305] usb 1-2.4: new high-speed USB device number 6 using xhci_hcd
[    3.864999] systemd[1]: Created slice Root Slice.
[    3.865037] systemd[1]: Starting Root Slice.
[    3.865255] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    3.865288] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[    3.865505] systemd[1]: Created slice User and Session Slice.
[    3.865536] systemd[1]: Starting User and Session Slice.
[    3.865789] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    3.865820] systemd[1]: Starting Device-mapper event daemon FIFOs.
[    3.866017] systemd[1]: Listening on udev Control Socket.
[    3.866058] systemd[1]: Starting udev Control Socket.
[    3.866235] systemd[1]: Listening on Delayed Shutdown Socket.
[    3.866266] systemd[1]: Starting Delayed Shutdown Socket.
[    3.866515] systemd[1]: Listening on Journal Socket.
[    3.866560] systemd[1]: Starting Journal Socket.
[    3.866708] systemd[1]: Reached target Encrypted Volumes.
[    3.866738] systemd[1]: Starting Encrypted Volumes.
[    3.866971] systemd[1]: Created slice System Slice.
[    3.867017] systemd[1]: Starting System Slice.
[    3.868116] systemd[1]: Starting Uncomplicated firewall...
[    3.869414] systemd[1]: Starting Increase datagram queue length...
[    3.869698] systemd[1]: Reached target Slices.
[    3.869755] systemd[1]: Starting Slices.
[    3.871159] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    3.872598] systemd[1]: Starting Setup Virtual Console...
[    3.883918] systemd[1]: Starting Load Kernel Modules...
[    3.885414] systemd[1]: Mounting Huge Pages File System...
[    3.885865] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.885921] systemd[1]: Starting Journal Socket (/dev/log).
[    3.887247] systemd[1]: Mounting Debug File System...
[    3.888626] systemd[1]: Starting Nameserver information manager...
[    3.889099] systemd[1]: Reached target Remote File Systems (Pre).
[    3.889160] systemd[1]: Starting Remote File Systems (Pre).
[    3.889594] systemd[1]: Listening on udev Kernel Socket.
[    3.889632] systemd[1]: Starting udev Kernel Socket.
[    3.890899] systemd[1]: Starting udev Coldplug all Devices...
[    3.892496] systemd[1]: Mounting POSIX Message Queue File System...
[    3.892938] systemd[1]: Listening on fsck to fsckd communication Socket.
[    3.893002] systemd[1]: Starting fsck to fsckd communication Socket.
[    3.893883] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    3.893931] systemd[1]: Starting system-systemd\x2dfsck.slice.
[    3.894282] systemd[1]: Created slice system-getty.slice.
[    3.894314] systemd[1]: Starting system-getty.slice.
[    3.895768] systemd[1]: Started Braille Device Support.
[    3.896284] systemd[1]: Starting Braille Device Support...
[    3.898066] systemd[1]: Started Read required files in advance.
[    3.899755] systemd[1]: Starting Read required files in advance...
[    3.900204] usb 1-2.4: New USB device found, idVendor=05e3, idProduct=0608
[    3.900213] usb 1-2.4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    3.900219] usb 1-2.4: Product: USB2.0 Hub
[    3.900643] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    3.900690] systemd[1]: Starting Arbitrary Executable File Formats File System Automount Point.
[    3.900931] hub 1-2.4:1.0: USB hub found
[    3.901179] hub 1-2.4:1.0: 4 ports detected
[    3.907169] systemd[1]: Started Set Up Additional Binary Formats.
[    3.907365] systemd[1]: Listening on Journal Audit Socket.
[    3.907400] systemd[1]: Starting Journal Audit Socket.
[    3.907556] systemd[1]: Listening on LVM2 metadata daemon socket.
[    3.907591] systemd[1]: Starting LVM2 metadata daemon socket.
[    3.908873] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    3.909212] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    3.909262] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
[    3.911110] systemd[1]: Mounted Debug File System.
[    3.911376] systemd[1]: Mounted Huge Pages File System.
[    3.911585] systemd[1]: Mounted POSIX Message Queue File System.
[    3.912342] systemd[1]: Started Uncomplicated firewall.
[    3.913088] systemd[1]: Started Increase datagram queue length.
[    3.913773] systemd[1]: Started Create list of required static device nodes for the current kernel.
[    3.914434] systemd[1]: Started Setup Virtual Console.
[    3.914816] systemd[1]: systemd-modules-load.service: main process exited, code=exited, status=1/FAILURE
[    3.915450] systemd[1]: Failed to start Load Kernel Modules.
[    3.915485] systemd[1]: Unit systemd-modules-load.service entered failed state.
[    3.915534] systemd[1]: systemd-modules-load.service failed.
[    3.932558] systemd[1]: Started Nameserver information manager.
[    3.958270] systemd[1]: Started udev Coldplug all Devices.
[    4.012747] systemd[1]: Starting udev Wait for Complete Device Initialization...
[    4.014269] systemd[1]: Mounting Configuration File System...
[    4.014514] systemd[1]: Mounted FUSE Control File System.
[    4.015929] systemd[1]: Starting Apply Kernel Variables...
[    4.017554] systemd[1]: Starting Create Static Device Nodes in /dev...
[    4.017960] systemd[1]: Listening on Syslog Socket.
[    4.018067] systemd[1]: Starting Syslog Socket.
[    4.019525] systemd[1]: Starting Journal Service...
[    4.021783] systemd[1]: Mounted Configuration File System.
[    4.033108] systemd[1]: Started Apply Kernel Variables.
[    4.087083] systemd[1]: Started Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
[    4.106889] systemd[1]: Started Create Static Device Nodes in /dev.
[    4.107729] systemd[1]: Started Journal Service.
[    4.178200] usb 1-2.4.1: new low-speed USB device number 7 using xhci_hcd
[    4.249065] intel_sst_acpi 80860F28:00: LPE base: 0x90a00000 size:0x200000
[    4.249074] intel_sst_acpi 80860F28:00: IRAM base: 0x90ac0000
[    4.249108] intel_sst_acpi 80860F28:00: DRAM base: 0x90b00000
[    4.249121] intel_sst_acpi 80860F28:00: SHIM base: 0x90b40000
[    4.249133] intel_sst_acpi 80860F28:00: Mailbox base: 0x90b44000
[    4.249145] intel_sst_acpi 80860F28:00: DDR base: 0x20000000
[    4.249245] intel_sst_acpi 80860F28:00: Got drv data max stream 25
[    4.261947] usb 1-2.4.1: New USB device found, idVendor=192f, idProduct=0416
[    4.261957] usb 1-2.4.1: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    4.261963] usb 1-2.4.1: Product: USB Optical Mouse
[    4.263324] usb 1-2.4.1: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
[    4.268653] input: USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.4/1-2.4.1/1-2.4.1:1.0/0003:192F:0416.0005/input/input5
[    4.271205] hid-generic 0003:192F:0416.0005: input,hidraw4: USB HID v1.11 Mouse [USB Optical Mouse] on usb-0000:00:14.0-2.4.1/input0
[    4.402483] Adding 1091580k swap on /dev/mmcblk0p3.  Priority:-1 extents:1 across:1091580k SS
[    5.634535] ureadahead (1278) used greatest stack depth: 13144 bytes left
[    5.692608] EXT4-fs (mmcblk0p2): re-mounted. Opts: errors=remount-ro
[    5.723231] systemd-journald[1291]: Received request to flush runtime journal from PID 1
[    5.796779] random: nonblocking pool is initialized
[    6.140173] cgroup: new mount options do not match the existing superblock, will be ignored
[    6.820183] cfg80211: Calling CRDA to update world regulatory domain
[    6.826026] cfg80211: World regulatory domain updated:
[    6.826035] cfg80211:  DFS Master region: unset
[    6.826039] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp), (dfs_cac_time)
[    6.826046] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
[    6.826052] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
[    6.826057] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm), (N/A)
[    6.826062] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
[    6.826067] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
[  466.336037] mconf (3410) used greatest stack depth: 12912 bytes left

--------------000101000506030300040105
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000101000506030300040105--
