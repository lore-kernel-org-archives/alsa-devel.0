From: Tyler Yeomans <tyeo098@gmail.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Tue, 30 Jun 2015 18:57:44 -0400
Message-ID: <55931EE8.5000604@gmail.com>
References: <5589D025.7090700@gmail.com> <20150624101115.GI19530@localhost>
 <558ABDB6.4010702@gmail.com> <20150624160314.GM19530@localhost>
 <558BA1D8.8040508@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070304070706060407020609"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f171.google.com (mail-qk0-f171.google.com
 [209.85.220.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A00C26044D
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2015 00:56:52 +0200 (CEST)
Received: by qkeo142 with SMTP id o142so17850554qke.1
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 15:56:51 -0700 (PDT)
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
--------------070304070706060407020609
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Jarkko-

Quick update.
I was able to recompile the distribution kernel after a long wait, and 
with the changes that were made I was able to get some semblance of an 
audio device registered.

I've attached the dmesg.

$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: bytrt5640 [byt-rt5640], device 0: Audio rt5640-aif1-0 []
   Subdevices: 1/1
   Subdevice #0: subdevice #0

I've also attached a screenshot of what I am seeing.
No HDMI audio though, and when I attach a headphone to the speaker 
jack... I get nothing but very faint buzzing when I put my ear to it and 
hit 'test sound'

Thanks-

Tyler


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


--------------070304070706060407020609
Content-Type: text/plain; charset=UTF-8;
 name="dmesg.txt.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.txt.1"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.1.03.19.21audio (mvix@mykro) (gcc version 4.9.2 (Ubuntu 4.9.2-10ubuntu13) ) #2 SMP Tue Jun 30 22:16:03 EDT 2015
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.1.03.19.21audio root=/dev/mmcblk0p2 ro quiet splash vt.handoff=7
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
[    0.000000] BRK [0x02ffa000, 0x02ffafff] PGTABLE
[    0.000000] BRK [0x02ffb000, 0x02ffbfff] PGTABLE
[    0.000000] BRK [0x02ffc000, 0x02ffcfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x7bc00000-0x7bdfffff]
[    0.000000]  [mem 0x7bc00000-0x7bdfffff] page 2M
[    0.000000] BRK [0x02ffd000, 0x02ffdfff] PGTABLE
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
[    0.000000] BRK [0x02ffe000, 0x02ffefff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x7c6a9000-0x7cbfffff]
[    0.000000]  [mem 0x7c6a9000-0x7c7fffff] page 4k
[    0.000000]  [mem 0x7c800000-0x7cbfffff] page 2M
[    0.000000] BRK [0x02fff000, 0x02ffffff] PGTABLE
[    0.000000] RAMDISK: [mem 0x12125000-0x1fffffff]
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
[    0.000000] PERCPU: Embedded 34 pages/cpu @ffff88007bc00000 s101400 r8192 d29672 u524288
[    0.000000] pcpu-alloc: s101400 r8192 d29672 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 500621
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.1.03.19.21audio root=/dev/mmcblk0p2 ro quiet splash vt.handoff=7
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 1711712K/2034728K available (8061K kernel code, 1305K rwdata, 3768K rodata, 1420K init, 1300K bss, 323016K reserved, 0K cma-reserved)
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
[    0.000056] Calibrating delay loop (skipped), value calculated using timer frequency.. 2662.40 BogoMIPS (lpj=5324800)
[    0.000064] pid_max: default: 32768 minimum: 301
[    0.000078] ACPI: Core revision 20150410
[    0.035899] ACPI: All ACPI Tables successfully acquired
[    0.037474] Security Framework initialized
[    0.037497] AppArmor: AppArmor initialized
[    0.037501] Yama: becoming mindful.
[    0.037909] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.039290] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.039937] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.039951] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.040425] Initializing cgroup subsys blkio
[    0.040437] Initializing cgroup subsys memory
[    0.040460] Initializing cgroup subsys devices
[    0.040469] Initializing cgroup subsys freezer
[    0.040476] Initializing cgroup subsys net_cls
[    0.040484] Initializing cgroup subsys perf_event
[    0.040492] Initializing cgroup subsys net_prio
[    0.040500] Initializing cgroup subsys hugetlb
[    0.040543] CPU: Physical Processor ID: 0
[    0.040548] CPU: Processor Core ID: 0
[    0.040555] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.040559] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.045465] mce: CPU supports 6 MCE banks
[    0.045479] CPU0: Thermal monitoring enabled (TM1)
[    0.045486] process: using mwait in idle threads
[    0.045494] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
[    0.045498] Last level dTLB entries: 4KB 128, 2MB 16, 4MB 16, 1GB 0
[    0.045745] Freeing SMP alternatives memory: 32K (ffffffff81eab000 - ffffffff81eb3000)
[    0.052539] ftrace: allocating 30193 entries in 118 pages
[    0.077323] TSC deadline timer enabled
[    0.077332] smpboot: CPU0: Intel(R) Atom(TM) CPU  Z3735F @ 1.33GHz (fam: 06, model: 37, stepping: 08)
[    0.077386] Performance Events: PEBS fmt2+, 8-deep LBR, Silvermont events, full-width counters, Intel PMU driver.
[    0.077408] ... version:                3
[    0.077412] ... bit width:              40
[    0.077415] ... generic registers:      2
[    0.077418] ... value mask:             000000ffffffffff
[    0.077421] ... max period:             000000ffffffffff
[    0.077424] ... fixed-purpose events:   3
[    0.077427] ... event mask:             0000000700000003
[    0.079519] x86: Booting SMP configuration:
[    0.079527] .... node  #0, CPUs:      #1
[    0.097617] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.097977]  #2 #3
[    0.134176] x86: Booted up 1 node, 4 CPUs
[    0.134184] smpboot: Total of 4 processors activated (10649.60 BogoMIPS)
[    0.135446] devtmpfs: initialized
[    0.145336] evm: security.selinux
[    0.145341] evm: security.SMACK64
[    0.145344] evm: security.SMACK64EXEC
[    0.145347] evm: security.SMACK64TRANSMUTE
[    0.145350] evm: security.SMACK64MMAP
[    0.145353] evm: security.ima
[    0.145356] evm: security.capability
[    0.145524] PM: Registering ACPI NVS region [mem 0x0008f000-0x0008ffff] (4096 bytes)
[    0.145530] PM: Registering ACPI NVS region [mem 0x7c074000-0x7c560fff] (5165056 bytes)
[    0.145929] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.146153] pinctrl core: initialized pinctrl subsystem
[    0.146434] RTC time: 22:45:20, date: 06/30/15
[    0.146798] NET: Registered protocol family 16
[    0.150212] cpuidle: using governor ladder
[    0.154212] cpuidle: using governor menu
[    0.154377] ACPI: bus type PCI registered
[    0.154384] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.154597] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.154604] PCI: not using MMCONFIG
[    0.154608] PCI: Using configuration type 1 for base access
[    0.163327] ACPI: Added _OSI(Module Device)
[    0.163334] ACPI: Added _OSI(Processor Device)
[    0.163339] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.163343] ACPI: Added _OSI(Processor Aggregator Device)
[    0.189082] ACPI: Dynamic OEM Table Load:
[    0.189106] ACPI: SSDT 0xFFFF880076B22800 000501 (v01 PmRef  Cpu0Ist  00003000 INTL 20061109)
[    0.190975] ACPI: Dynamic OEM Table Load:
[    0.190994] ACPI: SSDT 0xFFFF880076B23000 000433 (v01 PmRef  Cpu0Cst  00003001 INTL 20061109)
[    0.193482] ACPI: Dynamic OEM Table Load:
[    0.193500] ACPI: SSDT 0xFFFF880076B84A00 00015F (v01 PmRef  ApIst    00003000 INTL 20061109)
[    0.195309] ACPI: Dynamic OEM Table Load:
[    0.195327] ACPI: SSDT 0xFFFF880076B9D540 00008D (v01 PmRef  ApCst    00003000 INTL 20061109)
[    0.199078] ACPI: Interpreter enabled
[    0.199096] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20150410/hwxface-580)
[    0.199110] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20150410/hwxface-580)
[    0.199122] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S3_] (20150410/hwxface-580)
[    0.199134] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S4_] (20150410/hwxface-580)
[    0.199155] ACPI: (supports S0 S5)
[    0.199160] ACPI: Using IOAPIC for interrupt routing
[    0.199223] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.208699] [Firmware Info]: PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] not reserved in ACPI motherboard resources
[    0.208706] PCI: not using MMCONFIG
[    0.208744] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.214786] ACPI: Power Resource [USBC] (on)
[    0.216201] ACPI: Power Resource [WWPR] (off)
[    0.222081] ACPI: Power Resource [PLPE] (on)
[    0.233416] ACPI: Power Resource [CLK0] (on)
[    0.233541] ACPI: Power Resource [CLK1] (on)
[    0.240142] ACPI: Power Resource [P28X] (off)
[    0.240272] ACPI: Power Resource [P18X] (off)
[    0.240404] ACPI: Power Resource [P28P] (off)
[    0.240527] ACPI: Power Resource [P18P] (off)
[    0.240656] ACPI: Power Resource [P28T] (off)
[    0.240784] ACPI: Power Resource [P18T] (off)
[    0.240907] ACPI: Power Resource [P1XT] (off)
[    0.243915] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.243931] acpi PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[    0.244055] \_SB_.PCI0:_OSC invalid UUID
[    0.244060] _OSC request data:1 1e 0 
[    0.244072] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    0.244461] acpi PNP0A08:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.244988] PCI host bridge to bus 0000:00
[    0.244998] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.245005] pci_bus 0000:00: root bus resource [io  0x0070-0x0077]
[    0.245011] pci_bus 0000:00: root bus resource [io  0x0000-0x006f window]
[    0.245017] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7 window]
[    0.245023] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.245030] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.245036] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.245042] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000fffff window]
[    0.245048] pci_bus 0000:00: root bus resource [mem 0x90c00000-0x90ffffff window]
[    0.245054] pci_bus 0000:00: root bus resource [mem 0x7cf00001-0x7ef00000 window]
[    0.245060] pci_bus 0000:00: root bus resource [mem 0x80000000-0x908ffffe window]
[    0.245066] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed40fff window]
[    0.245084] pci 0000:00:00.0: [8086:0f00] type 00 class 0x060000
[    0.245338] pci 0000:00:02.0: [8086:0f31] type 00 class 0x030000
[    0.245360] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x903fffff]
[    0.245378] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff pref]
[    0.245395] pci 0000:00:02.0: reg 0x20: [io  0x1000-0x1007]
[    0.245661] pci 0000:00:14.0: [8086:0f35] type 00 class 0x0c0330
[    0.245688] pci 0000:00:14.0: reg 0x10: [mem 0x90800000-0x9080ffff 64bit]
[    0.245766] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.246002] pci 0000:00:1a.0: [8086:0f18] type 00 class 0x108000
[    0.246034] pci 0000:00:1a.0: reg 0x10: [mem 0x90700000-0x907fffff]
[    0.246054] pci 0000:00:1a.0: reg 0x14: [mem 0x90600000-0x906fffff]
[    0.246174] pci 0000:00:1a.0: PME# supported from D0 D3hot
[    0.246425] pci 0000:00:1f.0: [8086:0f1c] type 00 class 0x060100
[    0.247619] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.247812] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.248000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.248190] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.248379] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.248575] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.248764] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.248953] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.260751] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.260759] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.260765] vgaarb: loaded
[    0.260769] vgaarb: bridge control possible 0000:00:02.0
[    0.261418] SCSI subsystem initialized
[    0.261549] libata version 3.00 loaded.
[    0.261635] ACPI: bus type USB registered
[    0.261700] usbcore: registered new interface driver usbfs
[    0.261736] usbcore: registered new interface driver hub
[    0.261802] usbcore: registered new device driver usb
[    0.262339] PCI: Using ACPI for IRQ routing
[    0.262346] PCI: pci_cache_line_size set to 64 bytes
[    0.262389] Expanded resource reserved due to conflict with PCI Bus 0000:00
[    0.262396] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.262402] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.262406] e820: reserve RAM buffer [mem 0x7c017000-0x7fffffff]
[    0.262411] e820: reserve RAM buffer [mem 0x7cc00000-0x7fffffff]
[    0.262716] NetLabel: Initializing
[    0.262721] NetLabel:  domain hash size = 128
[    0.262724] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.262754] NetLabel:  unlabeled traffic allowed by default
[    0.263019] Switched to clocksource refined-jiffies
[    0.279731] AppArmor: AppArmor Filesystem Enabled
[    0.279927] pnp: PnP ACPI init
[    0.280073] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.280395] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.280404] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.280411] system 00:01: [io  0x0500-0x05fe] has been reserved
[    0.280417] system 00:01: [io  0x0600-0x061f] has been reserved
[    0.280424] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.280434] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.280701] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.283955] pnp: PnP ACPI: found 3 devices
[    0.289980] pci_bus 0000:00: resource 4 [io  0x0070-0x0077]
[    0.289988] pci_bus 0000:00: resource 5 [io  0x0000-0x006f window]
[    0.289995] pci_bus 0000:00: resource 6 [io  0x0078-0x0cf7 window]
[    0.290001] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.290007] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.290013] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.290019] pci_bus 0000:00: resource 10 [mem 0x000e0000-0x000fffff window]
[    0.290025] pci_bus 0000:00: resource 11 [mem 0x90c00000-0x90ffffff window]
[    0.290031] pci_bus 0000:00: resource 12 [mem 0x7cf00001-0x7ef00000 window]
[    0.290037] pci_bus 0000:00: resource 13 [mem 0x80000000-0x908ffffe window]
[    0.290043] pci_bus 0000:00: resource 14 [mem 0xfed40000-0xfed40fff window]
[    0.290123] NET: Registered protocol family 2
[    0.290580] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.290694] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
[    0.290813] TCP: Hash tables configured (established 16384 bind 16384)
[    0.290876] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.290913] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.291047] NET: Registered protocol family 1
[    0.291087] pci 0000:00:02.0: Video device with shadowed ROM
[    0.291451] PCI: CLS 0 bytes, default 64
[    0.291602] Trying to unpack rootfs image as initramfs...
[    9.799439] Freeing initrd memory: 228204K (ffff880012125000 - ffff880020000000)
[    9.799812] microcode: CPU0 sig=0x30678, pf=0x2, revision=0x82f
[    9.799827] microcode: CPU1 sig=0x30678, pf=0x2, revision=0x82f
[    9.799847] microcode: CPU2 sig=0x30678, pf=0x2, revision=0x82f
[    9.799871] microcode: CPU3 sig=0x30678, pf=0x2, revision=0x82f
[    9.800018] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    9.800135] Scanning for low memory corruption every 60 seconds
[    9.801085] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    9.801120] Initialise system trusted keyring
[    9.801189] audit: initializing netlink subsys (disabled)
[    9.801232] audit: type=2000 audit(1435704330.548:1): initialized
[    9.801976] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    9.806938] zpool: loaded
[    9.806946] zbud: loaded
[    9.807323] VFS: Disk quotas dquot_6.6.0
[    9.807437] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    9.808921] fuse init (API version 7.23)
[    9.809348] Key type big_key registered
[    9.810213] Key type asymmetric registered
[    9.810223] Asymmetric key parser 'x509' registered
[    9.810345] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    9.810442] io scheduler noop registered
[    9.810452] io scheduler deadline registered (default)
[    9.810569] io scheduler cfq registered
[    9.810752] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    9.810800] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    9.810930] efifb: probing for efifb
[    9.810994] efifb: framebuffer at 0x80000000, mapped to 0xffffc90000800000, using 8128k, total 8128k
[    9.811000] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    9.811003] efifb: scrolling: redraw
[    9.811008] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    9.830358] Console: switching to colour frame buffer device 240x67
[    9.849039] fb0: EFI VGA frame buffer device
[    9.849069] intel_idle: MWAIT substates: 0x33000020
[    9.849074] intel_idle: v0.4 model 0x37
[    9.849078] intel_idle: lapic_timer_reliable_states 0xffffffff
[    9.854262] [Firmware Bug]: No valid trip found
[    9.854376] GHES: HEST is not enabled!
[    9.854653] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    9.874805] 00:02: ttyS0 at I/O 0x3f8 (irq = 198, base_baud = 115200) is a 16550A
[    9.879249] hpet: number irqs doesn't agree with number of timers
[    9.879407] Linux agpgart interface v0.103
[    9.886530] brd: module loaded
[    9.889565] loop: module loaded
[    9.890194] libphy: Fixed MDIO Bus: probed
[    9.890204] tun: Universal TUN/TAP device driver, 1.6
[    9.890208] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    9.890343] PPP generic driver version 2.4.2
[    9.890765] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    9.890784] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    9.891201] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00009810
[    9.891213] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    9.891401] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    9.891408] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.891414] usb usb1: Product: xHCI Host Controller
[    9.891419] usb usb1: Manufacturer: Linux 4.1.03.19.21audio xhci-hcd
[    9.891424] usb usb1: SerialNumber: 0000:00:14.0
[    9.891773] hub 1-0:1.0: USB hub found
[    9.891801] hub 1-0:1.0: 6 ports detected
[   10.323930] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   10.323966] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[   10.324275] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[   10.324294] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   10.324309] usb usb2: Product: xHCI Host Controller
[   10.324323] usb usb2: Manufacturer: Linux 4.1.03.19.21audio xhci-hcd
[   10.324336] usb usb2: SerialNumber: 0000:00:14.0
[   10.324775] hub 2-0:1.0: USB hub found
[   10.324801] hub 2-0:1.0: 1 port detected
[   10.325180] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   10.325197] ehci-pci: EHCI PCI platform driver
[   10.325239] ehci-platform: EHCI generic platform driver
[   10.325303] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   10.325317] ohci-pci: OHCI PCI platform driver
[   10.325350] ohci-platform: OHCI generic platform driver
[   10.325382] uhci_hcd: USB Universal Host Controller Interface driver
[   10.325525] i8042: PNP: No PS/2 controller found. Probing ports directly.
[   10.627811] clocksource tsc: mask: 0xffffffffffffffff max_cycles: 0x13303f810e3, max_idle_ns: 440795235405 ns
[   11.359838] i8042: No controller found
[   11.359932] Switched to clocksource tsc
[   11.360026] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[   11.360173] mousedev: PS/2 mouse device common for all mice
[   11.360448] ACPI Warning: Could not enable fixed event - RealTimeClock (4) (20150410/evxface-654)
[   11.360661] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[   11.360834] rtc_cmos: probe of 00:00 failed with error -22
[   11.360925] i2c /dev entries driver
[   11.361051] device-mapper: uevent: version 1.0.3
[   11.361318] device-mapper: ioctl: 4.31.0-ioctl (2015-3-12) initialised: dm-devel@redhat.com
[   11.361348] Intel P-state driver initializing.
[   11.361820] ledtrig-cpu: registered to indicate activity on CPUs
[   11.361847] EFI Variables Facility v0.08 2004-May-17
[   11.366313] PCCT header not found.
[   11.366738] NET: Registered protocol family 10
[   11.367332] NET: Registered protocol family 17
[   11.367361] Key type dns_resolver registered
[   11.368370] Loading compiled-in X.509 certificates
[   11.370578] Loaded X.509 cert 'Build time autogenerated kernel key: cdaa656d02bce505332ee0b997ce18e4a26726a9'
[   11.370623] registered taskstats version 1
[   11.378694] Key type trusted registered
[   11.396674] Key type encrypted registered
[   11.396696] AppArmor: AppArmor sha1 policy hashing enabled
[   11.396706] ima: No TPM chip found, activating TPM-bypass!
[   11.396761] evm: HMAC attrs: 0x1
[   11.397793]   Magic number: 3:825:806
[   11.397924] hctosys: unable to open rtc device (rtc0)
[   11.398296] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[   11.398299] EDD information not available.
[   11.398541] PM: Hibernation image not present or could not be loaded.
[   11.400209] Freeing unused kernel memory: 1420K (ffffffff81d48000 - ffffffff81eab000)
[   11.400217] Write protecting the kernel read-only data: 12288k
[   11.402829] Freeing unused kernel memory: 120K (ffff8800027e2000 - ffff880002800000)
[   11.403669] Freeing unused kernel memory: 328K (ffff880002bae000 - ffff880002c00000)
[   11.449753] random: systemd-udevd urandom read with 2 bits of entropy available
[   11.463692] timekeeping watchdog: Marking clocksource 'tsc' as unstable, because the skew is too large:
[   11.463715] 	'refined-jiffies' wd_now: fffee748 wd_last: fffee6cb mask: ffffffff
[   11.463727] 	'tsc' cs_now: a63a10290 cs_last: a41c4f310 mask: ffffffffffffffff
[   11.464507] Switched to clocksource refined-jiffies
[   11.492984] sdhci: Secure Digital Host Controller Interface driver
[   11.492990] sdhci: Copyright(c) Pierre Ossman
[   11.502212] sdhci-acpi 80860F14:00: No vmmc regulator found
[   11.502220] sdhci-acpi 80860F14:00: No vqmmc regulator found
[   11.503257] usb 1-1: New USB device found, idVendor=0bda, idProduct=8152
[   11.503266] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   11.503271] usb 1-1: Product: USB 10/100 LAN
[   11.503276] usb 1-1: Manufacturer: Realtek
[   11.503280] usb 1-1: SerialNumber: 00E04C360027
[   11.506429] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
[   11.507632] sdhci-acpi INT33BB:00: No vmmc regulator found
[   11.507639] sdhci-acpi INT33BB:00: No vqmmc regulator found
[   11.510985] mmc1: SDHCI controller on ACPI [INT33BB:00] using ADMA
[   11.512395] sdhci-acpi 80860F14:02: No vmmc regulator found
[   11.512401] sdhci-acpi 80860F14:02: No vqmmc regulator found
[   11.515853] mmc2: SDHCI controller on ACPI [80860F14:02] using ADMA
[   11.613348] mmc0: MAN_BKOPS_EN bit is not set
[   11.621547] usb 1-2: new high-speed USB device number 3 using xhci_hcd
[   11.622597] mmc0: new HS200 MMC card at address 0001
[   11.638942] mmcblk0: mmc0:0001 SEM32G 29.1 GiB 
[   11.639051] mmcblk0boot0: mmc0:0001 SEM32G partition 1 4.00 MiB
[   11.639210] mmcblk0boot1: mmc0:0001 SEM32G partition 2 4.00 MiB
[   11.639298] mmcblk0rpmb: mmc0:0001 SEM32G partition 3 4.00 MiB
[   11.642454]  mmcblk0: p1 p2 p3
[   11.682856] mmc1: new high speed SDIO card at address 0001
[   11.697674] [drm] Initialized drm 1.1.0 20060810
[   11.745316] usb 1-2: New USB device found, idVendor=05e3, idProduct=0608
[   11.745325] usb 1-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[   11.745331] usb 1-2: Product: USB2.0 Hub
[   11.745957] hub 1-2:1.0: USB hub found
[   11.746203] hub 1-2:1.0: 4 ports detected
[   11.931840] usb 1-2.2: new low-speed USB device number 4 using xhci_hcd
[   12.014858] usb 1-2.2: New USB device found, idVendor=1c4f, idProduct=0002
[   12.014867] usb 1-2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   12.014872] usb 1-2.2: Product: USB Keykoard
[   12.014877] usb 1-2.2: Manufacturer: USB
[   12.015175] usb 1-2.2: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
[   12.015187] usb 1-2.2: ep 0x82 - rounding interval to 64 microframes, ep desc says 80 microframes
[   12.041584] hidraw: raw HID events driver (C) Jiri Kosina
[   12.067309] usbcore: registered new interface driver usbhid
[   12.067316] usbhid: USB HID core driver
[   12.074804] input: USB USB Keykoard as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.2/1-2.2:1.0/0003:1C4F:0002.0001/input/input0
[   12.080002] usb 1-2.3: new low-speed USB device number 5 using xhci_hcd
[   12.109655] hid-generic 0003:1C4F:0002.0001: input,hidraw0: USB HID v1.10 Keyboard [USB USB Keykoard] on usb-0000:00:14.0-2.2/input0
[   12.110032] input: USB USB Keykoard as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.2/1-2.2:1.1/0003:1C4F:0002.0002/input/input1
[   12.143085] usb 1-2.3: New USB device found, idVendor=0755, idProduct=3317
[   12.143091] usb 1-2.3: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[   12.143096] usb 1-2.3: Product: iRFmedia_cIR
[   12.146663] input: iRFmedia_cIR as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.3/1-2.3:1.0/0003:0755:3317.0003/input/input2
[   12.146945] hid-generic 0003:1C4F:0002.0002: input,hidraw1: USB HID v1.10 Device [USB USB Keykoard] on usb-0000:00:14.0-2.2/input1
[   12.183004] hid-generic 0003:0755:3317.0003: input,hidraw2: USB HID v1.10 Keyboard [iRFmedia_cIR] on usb-0000:00:14.0-2.3/input0
[   12.187243] input: iRFmedia_cIR as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.3/1-2.3:1.1/0003:0755:3317.0004/input/input3
[   12.207372] [drm] Memory usable by graphics device = 2048M
[   12.207382] checking generic (80000000 7f0000) vs hw (80000000 10000000)
[   12.207386] fb: switching to inteldrmfb from EFI VGA
[   12.207432] Console: switching to colour dummy device 80x25
[   12.207616] [drm] Replacing VGA console driver
[   12.210692] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   12.210698] [drm] Driver supports precise vblank timestamp query.
[   12.223985] hid-generic 0003:0755:3317.0004: input,hidraw3: USB HID v1.10 Mouse [iRFmedia_cIR] on usb-0000:00:14.0-2.3/input1
[   12.279770] usb 1-2.4: new high-speed USB device number 6 using xhci_hcd
[   12.286004] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   12.307058] [drm] failed to retrieve link info, disabling eDP
[   12.339902] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   12.340905] acpi device:09: registered as cooling_device4
[   12.341055] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input4
[   12.341274] [drm] Initialized i915 1.6.0 20150327 for 0000:00:02.0 on minor 0
[   12.347287] usb 1-2.4: New USB device found, idVendor=05e3, idProduct=0608
[   12.347296] usb 1-2.4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[   12.347301] usb 1-2.4: Product: USB2.0 Hub
[   12.348008] hub 1-2.4:1.0: USB hub found
[   12.348263] hub 1-2.4:1.0: 4 ports detected
[   12.384640] fbcon: inteldrmfb (fb0) is primary device
[   12.534521] usb 1-2.4.1: new low-speed USB device number 7 using xhci_hcd
[   12.549201] Console: switching to colour frame buffer device 240x67
[   12.563833] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[   12.563837] i915 0000:00:02.0: registered panic notifier
[   12.603567] usb 1-2.4.1: New USB device found, idVendor=192f, idProduct=0416
[   12.603576] usb 1-2.4.1: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[   12.603581] usb 1-2.4.1: Product: USB Optical Mouse
[   12.603805] usb 1-2.4.1: ep 0x81 - rounding interval to 64 microframes, ep desc says 80 microframes
[   12.606662] input: USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.4/1-2.4.1/1-2.4.1:1.0/0003:192F:0416.0005/input/input5
[   12.607033] hid-generic 0003:192F:0416.0005: input,hidraw4: USB HID v1.11 Mouse [USB Optical Mouse] on usb-0000:00:14.0-2.4.1/input0
[   13.014912] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[   13.293730] systemd[1]: RTC configured in localtime, applying delta of -240 minutes to system time.
[   13.357825] systemd[1]: Inserted module 'autofs4'
[   13.381389] systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT -GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID -ELFUTILS +KMOD -IDN)
[   13.381824] systemd[1]: Detected architecture x86-64.
[   13.382865] systemd[1]: Set hostname to <mykro>.
[   13.574380] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   13.574419] systemd[1]: Starting Arbitrary Executable File Formats File System Automount Point.
[   13.574606] systemd[1]: Reached target Encrypted Volumes.
[   13.574633] systemd[1]: Starting Encrypted Volumes.
[   13.574761] systemd[1]: Reached target Remote File Systems (Pre).
[   13.574787] systemd[1]: Starting Remote File Systems (Pre).
[   13.574978] systemd[1]: Created slice Root Slice.
[   13.575006] systemd[1]: Starting Root Slice.
[   13.575252] systemd[1]: Listening on Journal Socket.
[   13.575291] systemd[1]: Starting Journal Socket.
[   13.575479] systemd[1]: Listening on Journal Audit Socket.
[   13.575505] systemd[1]: Starting Journal Audit Socket.
[   13.575673] systemd[1]: Listening on Journal Socket (/dev/log).
[   13.575700] systemd[1]: Starting Journal Socket (/dev/log).
[   13.575872] systemd[1]: Listening on udev Control Socket.
[   13.575899] systemd[1]: Starting udev Control Socket.
[   13.576261] systemd[1]: Created slice System Slice.
[   13.576304] systemd[1]: Starting System Slice.
[   13.577904] systemd[1]: Starting Uncomplicated firewall...
[   13.579741] systemd[1]: Starting Nameserver information manager...
[   13.581769] systemd[1]: Mounting Debug File System...
[   13.589079] systemd[1]: Starting Load Kernel Modules...
[   13.591137] systemd[1]: Starting Setup Virtual Console...
[   13.593207] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[   13.593780] systemd[1]: Created slice system-getty.slice.
[   13.593820] systemd[1]: Starting system-getty.slice.
[   13.595565] systemd[1]: Mounting POSIX Message Queue File System...
[   13.597643] systemd[1]: Starting Increase datagram queue length...
[   13.608388] systemd[1]: Started Set Up Additional Binary Formats.
[   13.608924] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   13.608959] systemd[1]: Starting system-systemd\x2dfsck.slice.
[   13.611111] systemd[1]: Started Read required files in advance.
[   13.611592] systemd[1]: Starting Read required files in advance...
[   13.614585] systemd[1]: Mounting Huge Pages File System...
[   13.616925] systemd[1]: Started Braille Device Support.
[   13.617640] systemd[1]: Starting Braille Device Support...
[   13.617973] systemd[1]: Listening on fsck to fsckd communication Socket.
[   13.618004] systemd[1]: Starting fsck to fsckd communication Socket.
[   13.618195] systemd[1]: Listening on Delayed Shutdown Socket.
[   13.618232] systemd[1]: Starting Delayed Shutdown Socket.
[   13.618464] systemd[1]: Listening on udev Kernel Socket.
[   13.618496] systemd[1]: Starting udev Kernel Socket.
[   13.620366] systemd[1]: Starting udev Coldplug all Devices...
[   13.620887] systemd[1]: Created slice User and Session Slice.
[   13.620929] systemd[1]: Starting User and Session Slice.
[   13.621123] systemd[1]: Reached target Slices.
[   13.621168] systemd[1]: Starting Slices.
[   13.621423] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[   13.621451] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[   13.621668] systemd[1]: Listening on LVM2 metadata daemon socket.
[   13.621696] systemd[1]: Starting LVM2 metadata daemon socket.
[   13.621858] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   13.621887] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
[   13.622195] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   13.622226] systemd[1]: Starting Device-mapper event daemon FIFOs.
[   13.624345] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[   13.627469] systemd[1]: Mounted Debug File System.
[   13.627784] systemd[1]: Mounted Huge Pages File System.
[   13.628017] systemd[1]: Mounted POSIX Message Queue File System.
[   13.628885] systemd[1]: Started Uncomplicated firewall.
[   13.631803] systemd[1]: Started Setup Virtual Console.
[   13.632769] systemd[1]: Started Create list of required static device nodes for the current kernel.
[   13.633813] systemd[1]: Started Increase datagram queue length.
[   13.650183] systemd[1]: Started Nameserver information manager.
[   13.703335] systemd[1]: Started udev Coldplug all Devices.
[   13.703581] lp: driver loaded but no devices found
[   13.720060] systemd[1]: Starting udev Wait for Complete Device Initialization...
[   13.720460] systemd[1]: Listening on Syslog Socket.
[   13.720521] systemd[1]: Starting Syslog Socket.
[   13.722392] systemd[1]: Starting Journal Service...
[   13.724563] systemd[1]: Starting Create Static Device Nodes in /dev...
[   13.726975] ppdev: user-space parallel port driver
[   13.816453] systemd[1]: Started Load Kernel Modules.
[   13.818545] systemd[1]: Starting Apply Kernel Variables...
[   13.820365] systemd[1]: Mounting FUSE Control File System...
[   13.820645] systemd[1]: Mounted Configuration File System.
[   13.826076] systemd[1]: Mounted FUSE Control File System.
[   13.835104] systemd[1]: Started Apply Kernel Variables.
[   13.847524] systemd[1]: Started Create Static Device Nodes in /dev.
[   13.849652] systemd[1]: Starting udev Kernel Device Manager...
[   13.897151] systemd[1]: Started Journal Service.
[   14.069065] 80860F0A:00: ttyS4 at MMIO 0x9093b000 (irq = 191, base_baud = 2764800) is a 16550A
[   14.069557] 80860F0A:01: ttyS5 at MMIO 0x90941000 (irq = 192, base_baud = 2764800) is a 16550A
[   14.109687] axp20x i2c-INT33F4:00: AXP20x variant AXP288 found
[   14.181834] axp20x i2c-INT33F4:00: AXP20X driver loaded
[   14.183178] [Firmware Bug]: No valid trip found
[   14.183793] dw_dmac INTL9C60:00: DesignWare DMA Controller, 8 channels
[   14.184501] dw_dmac INTL9C60:01: DesignWare DMA Controller, 8 channels
[   14.287137] Goodix-TS i2c-GDIX1001:00: i2c test failed attempt 1: -121
[   14.345780] Goodix-TS i2c-GDIX1001:00: i2c test failed attempt 2: -121
[   14.359932] Goodix-TS i2c-GDIX1001:00: I2C communication failure: -121
[   14.385817] Goodix-TS: probe of i2c-GDIX1001:00 failed with error -121
[   14.425121] mei_txe 0000:00:1a.0: can't derive routing for PCI INT A
[   14.425130] mei_txe 0000:00:1a.0: PCI INT A: no GSI
[   14.539764] usbcore: registered new interface driver r8152
[   14.571915] SSE version of gcm_enc/dec engaged.
[   14.660870] usb 1-1: reset high-speed USB device number 2 using xhci_hcd
[   14.701611] usbcore: registered new interface driver cdc_ether
[   14.796838] input: gpio-keys as /devices/platform/gpio-keys.0.auto/input/input6
[   14.797263] input: gpio-keys as /devices/platform/gpio-keys.1.auto/input/input7
[   14.797739] r8152 1-1:1.0 eth0: v1.08.0 (2015/01/13)
[   14.921251] Adding 1091580k swap on /dev/mmcblk0p3.  Priority:-1 extents:1 across:1091580k SSFS
[   15.505799] intel_rapl: Found RAPL domain package
[   15.505807] intel_rapl: Found RAPL domain core
[   15.552097] byt-rt5640 byt-rt5640: ASoC: CPU DAI baytrail-pcm-audio not registered
[   15.632979] (NULL device *): FW version: 04.05.13.a0
[   15.632986] (NULL device *): Build type: a0
[   15.632990] (NULL device *): Build date: Apr  2 2014 14:14:39
[   15.691461] byt-rt5640 byt-rt5640: rt5640-aif1 <-> baytrail-pcm-audio mapping ok
[   16.179222] random: nonblocking pool is initialized
[   16.270756] EXT4-fs (mmcblk0p2): re-mounted. Opts: errors=remount-ro
[   16.306013] systemd-journald[287]: Received request to flush runtime journal from PID 1
[   16.516770] audit: type=1400 audit(1435718741.025:2): apparmor="STATUS" operation="profile_load" name="/usr/lib/lightdm/lightdm-guest-session" pid=523 comm="apparmor_parser"
[   16.516789] audit: type=1400 audit(1435718741.025:3): apparmor="STATUS" operation="profile_load" name="chromium" pid=523 comm="apparmor_parser"
[   16.522137] audit: type=1400 audit(1435718741.037:4): apparmor="STATUS" operation="profile_load" name="/sbin/dhclient" pid=523 comm="apparmor_parser"
[   16.522157] audit: type=1400 audit(1435718741.037:5): apparmor="STATUS" operation="profile_load" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=523 comm="apparmor_parser"
[   16.522170] audit: type=1400 audit(1435718741.037:6): apparmor="STATUS" operation="profile_load" name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=523 comm="apparmor_parser"
[   16.522183] audit: type=1400 audit(1435718741.037:7): apparmor="STATUS" operation="profile_load" name="/usr/lib/connman/scripts/dhclient-script" pid=523 comm="apparmor_parser"
[   16.547958] audit: type=1400 audit(1435718741.085:8): apparmor="STATUS" operation="profile_load" name="/usr/bin/evince" pid=523 comm="apparmor_parser"
[   16.547978] audit: type=1400 audit(1435718741.085:9): apparmor="STATUS" operation="profile_load" name="sanitized_helper" pid=523 comm="apparmor_parser"
[   16.547992] audit: type=1400 audit(1435718741.085:10): apparmor="STATUS" operation="profile_load" name="/usr/bin/evince-previewer" pid=523 comm="apparmor_parser"
[   16.548005] audit: type=1400 audit(1435718741.085:11): apparmor="STATUS" operation="profile_load" name="sanitized_helper" pid=523 comm="apparmor_parser"
[   16.777595] cgroup: new mount options do not match the existing superblock, will be ignored
[   17.394209] cfg80211: Calling CRDA to update world regulatory domain
[   17.403553] cfg80211: World regulatory domain updated:
[   17.403562] cfg80211:  DFS Master region: unset
[   17.403565] cfg80211:   (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp), (dfs_cac_time)
[   17.403571] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
[   17.403576] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
[   17.403581] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm), (N/A)
[   17.403585] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
[   17.403589] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm), (N/A)
[   25.449656] [drm:fw_domains_get [i915]] *ERROR* render: timed out waiting for forcewake ack request.
[   57.570361] [drm:fw_domains_get [i915]] *ERROR* render: timed out waiting for forcewake ack request.
[   57.631661] [drm:fw_domains_get [i915]] *ERROR* render: timed out waiting for forcewake ack request.

--------------070304070706060407020609
Content-Type: image/png;
 name="Screenshot from 2015-06-30 18:51:52.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="Screenshot from 2015-06-30 18:51:52.png"

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
YII=
--------------070304070706060407020609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070304070706060407020609--
