From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Wed, 24 Jun 2015 20:21:20 +0200
Message-ID: <20150624182120.GA481@asus>
References: <20150528191721.GA608@asus> <1432892521.2732.14.camel@loki>
 <20150529131753.GA339@asus> <1433156768.2642.21.camel@loki>
 <20150608084951.GA7512@dellaz>
 <loom.20150613T153708-781@post.gmane.org>
 <20150615164623.GA693@asus> <1434387868.2434.50.camel@loki>
 <20150623090932.GA6856@dellaz> <20150624102157.GL19530@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 42419260606
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 20:21:28 +0200 (CEST)
Received: by wiga1 with SMTP id a1so143319088wig.0
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 11:21:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150624102157.GL19530@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Luka Karinja <luka.karinja@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Nikula, Jarkko" <jarkko.nikula@intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 24, 2015 at 03:51:57PM +0530, Vinod Koul wrote:
> On Tue, Jun 23, 2015 at 11:09:33AM +0200, Michele Curti wrote:
> > On Mon, Jun 15, 2015 at 06:04:28PM +0100, Liam Girdwood wrote:
> > > Michele, can you change your machine driver to use the Vinods BYT DSP
> > > PCM driver (base it on bytcr_rt5640.c). Please test probing/booting with
> > > the current FW release from Vinod too. That way you should be ready to
> > > integrate the new FW when it is released. Please also CC Vinod on any
> > > issues you have getting the FW to boot using the new driver/FW.
> > >
> > 
> > Hi,
> > an update, thanks to Vinod now the driver compiles enabling only the (new)
> > CONFIG_SND_SOC_INTEL_BYTCR_RT5645_MACH option.
> > 
> > The sound card shows up:
> > [zio@asus ~]$ aplay -l
> > **** List of PLAYBACK Hardware Devices ****
> > card 0: baytrailcraudio [baytrailcraudio], device 0: Baytrail Audio (*) []
> >   Subdevices: 1/1
> >   Subdevice #0: subdevice #0
> > 
> > There are a lot of errors about missing backend dai:
> > [    7.195570]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
> So in this driver we use DPCM, which means that you have to route Front End
> to a BackEnd and then only you can open a device. Without linking to BE it
> will fail
>

Yes, when Liam wrote about that I started to try to understand how to find the
right audio route/path, but I think it will take a while eheh :p

> For Playback you can try:
> 
> #DSP routing
> amixer -c0 sset 'codec_out0 mix 0 pcm0_in' on
> amixer -c0 sset 'media0_out mix 0 media1_in' on
> amixer -c0 sset 'media1_in Gain 0' 80% 
> amixer -c0 sset 'media1_in Gain 0 Ramp Delay' 50
> amixer -c0 sset 'media1_in Gain 0' off
> amixer -c0 sset 'pcm0_in Gain 0' 80% 
> amixer -c0 sset 'pcm0_in Gain 0 Ramp Delay' 50
> amixer -c0 sset 'pcm0_in Gain 0' off
> amixer -c0 sset 'codec_out0 Gain 0' 80%
> amixer -c0 sset 'codec_out0 Gain 0 Ramp Delay' 50
> amixer -c0 sset 'codec_out0 Gain 0' off
> 
> #Codec routin, if you have different one please modfiy
> amixer -c0 sset "DAC MIXL INF1" on
> amixer -c0 sset "DAC MIXR INF1" on
> amixer -c0 sset "Stereo DAC MIXL DAC L1" on
> amixer -c0 sset "Stereo DAC MIXR DAC R1" on
> amixer -c0 sset "SPK MIXL DAC L1" on
> amixer -c0 sset "SPK MIXR DAC R1" on
> amixer -c0 sset "SPOL MIX SPKVOL L" on
> amixer -c0 sset "SPOR MIX SPKVOL R" on
> amixer -c0 sset "SPOL MIX DAC L1" on
> amixer -c0 sset "SPOR MIX DAC R1" on
> amixer -c0 sset "Speaker L" on
> amixer -c0 sset "Speaker R" on
> amixer -c0 sset "Headphone" off
> amixer -c0 sset "Ext Spk" on
> 
> I have used this in T100.
> 
> -- 
> ~Vinod

Thanks!  So for now I tried to blindy launch these commands (apart for the 
"Speaker L" and "Speaker R" controls, not present in the rt5645 codec) and 
I got about a minute freeze at every boot and some new errors:

[    2.700127] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 0 doesn't have DAPM widget!!!
[    2.700177] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 1 doesn't have DAPM widget!!!
[    2.700226] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 2 doesn't have DAPM widget!!!
[    2.700276] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 3 doesn't have DAPM widget!!!
[    2.700321] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
[    2.700368] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
[    2.700417] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
[    2.700468] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!
...
[    7.970937] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[    7.970964] intel_sst_acpi 80860F28:00: fw returned err -16
...
[   53.538117]  Baytrail Audio Port: sst: error code = -22
[   53.541909] bytx205_rt5645 bytx205_rt5645: BUG: pcmC0D0p:0, pos = -22, buffer size = 203830, period size = 1199


Full dmesg:

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.1.0-next-20150624-asus+ (zio@asus) (gcc version 5.1.0 (GCC) ) #28 SMP PREEMPT Wed Jun 24 14:52:54 CEST 2015
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-linux-asus root=/dev/mmcblk0p2 rw rw
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
[    0.000000] efi:  ACPI=0x7bf77000  ACPI 2.0=0x7bf77014  ESRT=0x7bf43000  SMBIOS=0x7c928190 
[    0.000000] efi: requested map not found.
[    0.000000] esrt: ESRT header is not in the memory map.
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
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01b2b000, 0x01b2bfff] PGTABLE
[    0.000000] BRK [0x01b2c000, 0x01b2cfff] PGTABLE
[    0.000000] BRK [0x01b2d000, 0x01b2dfff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x7ba00000-0x7bbfffff]
[    0.000000]  [mem 0x7ba00000-0x7bbfffff] page 2M
[    0.000000] BRK [0x01b2e000, 0x01b2efff] PGTABLE
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
[    0.000000] BRK [0x01b2f000, 0x01b2ffff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x7c985000-0x7cbfffff]
[    0.000000]  [mem 0x7c985000-0x7c9fffff] page 4k
[    0.000000]  [mem 0x7ca00000-0x7cbfffff] page 2M
[    0.000000] BRK [0x01b30000, 0x01b30fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x379e6000-0x37ceafff]
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
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000007cbfffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x7bd17000-0x7bd1afff]
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
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0008f000-0x0008ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x7bf14000-0x7bf43fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7bf44000-0x7bf77fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7bf78000-0x7c040fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7c041000-0x7c928fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7c929000-0x7c984fff]
[    0.000000] e820: [mem 0x7ef00000-0xe00f7fff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.000000] setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 32 pages/cpu @ffff88007ba00000 s91480 r8192 d31400 u524288
[    0.000000] pcpu-alloc: s91480 r8192 d31400 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 499685
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-linux-asus root=/dev/mmcblk0p2 rw rw
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 1939348K/2030764K available (5406K kernel code, 891K rwdata, 1668K rodata, 1168K init, 1152K bss, 91416K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
[    0.000000] NR_IRQS:8448 nr_irqs:1024 0
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] Maximum core-clock to bus-clock ratio: 0x10
[    0.000000] Resolved frequency ID: 0, frequency: 83200 KHz
[    0.000000] TSC runs at 1331200 KHz
[    0.000000] lapic_timer_frequency = 277333
[    0.000000] tsc: Detected 1331.200 MHz processor
[    0.000057] Calibrating delay loop (skipped), value calculated using timer frequency.. 2663.33 BogoMIPS (lpj=4437333)
[    0.000084] pid_max: default: 32768 minimum: 301
[    0.000106] ACPI: Core revision 20150515
[    0.056915] ACPI: All ACPI Tables successfully acquired
[    0.059004] Security Framework initialized
[    0.059021] Yama: becoming mindful.
[    0.059410] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.060818] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.061472] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.061500] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.061993] Initializing cgroup subsys blkio
[    0.062016] Initializing cgroup subsys memory
[    0.062047] Initializing cgroup subsys devices
[    0.062065] Initializing cgroup subsys freezer
[    0.062081] Initializing cgroup subsys net_cls
[    0.062125] CPU: Physical Processor ID: 0
[    0.062138] CPU: Processor Core ID: 0
[    0.062154] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.062167] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.067083] mce: CPU supports 6 MCE banks
[    0.067105] CPU0: Thermal monitoring enabled (TM1)
[    0.067120] process: using mwait in idle threads
[    0.067137] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
[    0.067151] Last level dTLB entries: 4KB 128, 2MB 16, 4MB 16, 1GB 0
[    0.067357] Freeing SMP alternatives memory: 20K (ffffffff81a04000 - ffffffff81a09000)
[    0.068969] Ignoring BGRT: invalid status 0 (expected 1)
[    0.073466] ftrace: allocating 21328 entries in 84 pages
[    0.091663] TSC deadline timer enabled
[    0.091673] smpboot: CPU0: Intel(R) Atom(TM) CPU  Z3735F @ 1.33GHz (fam: 06, model: 37, stepping: 08)
[    0.091744] Performance Events: PEBS fmt2+, 8-deep LBR, Silvermont events, full-width counters, Intel PMU driver.
[    0.091785] ... version:                3
[    0.091796] ... bit width:              40
[    0.091807] ... generic registers:      2
[    0.091818] ... value mask:             000000ffffffffff
[    0.091830] ... max period:             000000ffffffffff
[    0.091842] ... fixed-purpose events:   3
[    0.091852] ... event mask:             0000000700000003
[    0.105223] x86: Booting SMP configuration:
[    0.105241] .... node  #0, CPUs:      #1
[    0.113513] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.116824]  #2 #3
[    0.136459] x86: Booted up 1 node, 4 CPUs
[    0.136481] smpboot: Total of 4 processors activated (10653.33 BogoMIPS)
[    0.137708] devtmpfs: initialized
[    0.147947] PM: Registering ACPI NVS region [mem 0x0008f000-0x0008ffff] (4096 bytes)
[    0.147969] PM: Registering ACPI NVS region [mem 0x7bf78000-0x7c040fff] (823296 bytes)
[    0.148234] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.148472] pinctrl core: initialized pinctrl subsystem
[    0.148555] RTC time: 17:12:27, date: 06/24/15
[    0.148926] NET: Registered protocol family 16
[    0.163153] cpuidle: using governor ladder
[    0.176501] cpuidle: using governor menu
[    0.176612] ACPI: bus type PCI registered
[    0.176627] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.176807] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.176831] PCI: not using MMCONFIG
[    0.176843] PCI: Using configuration type 1 for base access
[    0.190786] ACPI: Added _OSI(Module Device)
[    0.190803] ACPI: Added _OSI(Processor Device)
[    0.190815] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.190827] ACPI: Added _OSI(Processor Aggregator Device)
[    0.223407] ACPI: Dynamic OEM Table Load:
[    0.223446] ACPI: SSDT 0xFFFF880076729800 000501 (v01 PmRef  Cpu0Ist  00003000 INTL 20061109)
[    0.225709] ACPI: Dynamic OEM Table Load:
[    0.225742] ACPI: SSDT 0xFFFF88007672A000 000433 (v01 PmRef  Cpu0Cst  00003001 INTL 20061109)
[    0.228631] ACPI: Dynamic OEM Table Load:
[    0.228663] ACPI: SSDT 0xFFFF88007675CC00 00015F (v01 PmRef  ApIst    00003000 INTL 20061109)
[    0.230874] ACPI: Dynamic OEM Table Load:
[    0.230905] ACPI: SSDT 0xFFFF88007670AD80 00008D (v01 PmRef  ApCst    00003000 INTL 20061109)
[    0.235237] ACPI: Interpreter enabled
[    0.235267] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20150515/hwxface-580)
[    0.235299] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20150515/hwxface-580)
[    0.235329] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S3_] (20150515/hwxface-580)
[    0.235360] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S4_] (20150515/hwxface-580)
[    0.235398] ACPI: (supports S0 S5)
[    0.235411] ACPI: Using IOAPIC for interrupt routing
[    0.235484] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.246568] [Firmware Info]: PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] not reserved in ACPI motherboard resources
[    0.246594] PCI: not using MMCONFIG
[    0.246652] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.251427] ACPI: Power Resource [USBC] (on)
[    0.259144] ACPI: Power Resource [PLPE] (on)
[    0.270812] ACPI: Power Resource [CLK0] (on)
[    0.270959] ACPI: Power Resource [CLK1] (on)
[    0.271672] ACPI: Power Resource [P28T] (off)
[    0.271803] ACPI: Power Resource [P18T] (off)
[    0.277493] ACPI: Power Resource [P28X] (off)
[    0.277632] ACPI: Power Resource [P18X] (off)
[    0.277779] ACPI: Power Resource [P28P] (off)
[    0.277916] ACPI: Power Resource [P18P] (off)
[    0.278074] ACPI: Power Resource [P1XT] (off)
[    0.279593] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.287857] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.287885] acpi PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[    0.288025] \_SB_.PCI0:_OSC invalid UUID
[    0.288030] _OSC request data:1 1e 0 
[    0.288042] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    0.288467] acpi PNP0A08:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.289018] PCI host bridge to bus 0000:00
[    0.289036] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.289052] pci_bus 0000:00: root bus resource [io  0x0070-0x0077]
[    0.289068] pci_bus 0000:00: root bus resource [io  0x0000-0x006f window]
[    0.289083] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7 window]
[    0.289099] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.289115] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.289136] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.289156] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000fffff window]
[    0.289177] pci_bus 0000:00: root bus resource [mem 0x90c00000-0x90ffffff window]
[    0.289198] pci_bus 0000:00: root bus resource [mem 0x7cf00001-0x7ef00000 window]
[    0.289218] pci_bus 0000:00: root bus resource [mem 0x80000000-0x908ffffe window]
[    0.289239] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed40fff window]
[    0.289271] pci 0000:00:00.0: [8086:0f00] type 00 class 0x060000
[    0.289541] pci 0000:00:02.0: [8086:0f31] type 00 class 0x030000
[    0.289570] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x903fffff]
[    0.289589] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff pref]
[    0.289606] pci 0000:00:02.0: reg 0x20: [io  0x1000-0x1007]
[    0.289868] pci 0000:00:14.0: [8086:0f35] type 00 class 0x0c0330
[    0.289906] pci 0000:00:14.0: reg 0x10: [mem 0x90800000-0x9080ffff 64bit]
[    0.289974] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.290228] pci 0000:00:1a.0: [8086:0f18] type 00 class 0x108000
[    0.290269] pci 0000:00:1a.0: reg 0x10: [mem 0x90700000-0x907fffff]
[    0.290286] pci 0000:00:1a.0: reg 0x14: [mem 0x90600000-0x906fffff]
[    0.290370] pci 0000:00:1a.0: PME# supported from D0 D3hot
[    0.290610] pci 0000:00:1f.0: [8086:0f1c] type 00 class 0x060100
[    0.291714] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.291933] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.292143] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.292353] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.292569] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.292791] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.293001] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.293210] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.306787] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.306808] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.306828] vgaarb: loaded
[    0.306839] vgaarb: bridge control possible 0000:00:02.0
[    0.307194] PCI: Using ACPI for IRQ routing
[    0.307210] PCI: pci_cache_line_size set to 64 bytes
[    0.307236] Expanded resource reserved due to conflict with PCI Bus 0000:00
[    0.307253] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.307258] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.307263] e820: reserve RAM buffer [mem 0x7bf14000-0x7bffffff]
[    0.307268] e820: reserve RAM buffer [mem 0x7cc00000-0x7fffffff]
[    0.307584] NetLabel: Initializing
[    0.307597] NetLabel:  domain hash size = 128
[    0.307608] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.307645] NetLabel:  unlabeled traffic allowed by default
[    0.307738] clocksource: Switched to clocksource refined-jiffies
[    0.322495] pnp: PnP ACPI init
[    0.322662] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.323174] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.323194] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.323211] system 00:01: [io  0x0500-0x05fe] has been reserved
[    0.323227] system 00:01: [io  0x0600-0x061f] has been reserved
[    0.323243] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.323263] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.323566] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.325162] system 00:03: [io  0x0240-0x0259] has been reserved
[    0.325185] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.327139] pnp: PnP ACPI: found 4 devices
[    0.333180] pci_bus 0000:00: resource 4 [io  0x0070-0x0077]
[    0.333189] pci_bus 0000:00: resource 5 [io  0x0000-0x006f window]
[    0.333195] pci_bus 0000:00: resource 6 [io  0x0078-0x0cf7 window]
[    0.333202] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.333208] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.333214] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.333221] pci_bus 0000:00: resource 10 [mem 0x000e0000-0x000fffff window]
[    0.333227] pci_bus 0000:00: resource 11 [mem 0x90c00000-0x90ffffff window]
[    0.333233] pci_bus 0000:00: resource 12 [mem 0x7cf00001-0x7ef00000 window]
[    0.333239] pci_bus 0000:00: resource 13 [mem 0x80000000-0x908ffffe window]
[    0.333245] pci_bus 0000:00: resource 14 [mem 0xfed40000-0xfed40fff window]
[    0.333324] NET: Registered protocol family 2
[    0.333716] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.333856] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
[    0.333985] TCP: Hash tables configured (established 16384 bind 16384)
[    0.334058] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.334100] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.334239] NET: Registered protocol family 1
[    0.334289] pci 0000:00:02.0: Video device with shadowed ROM
[    0.334669] PCI: CLS 0 bytes, default 64
[    0.334815] Unpacking initramfs...
[    0.463592] Freeing initrd memory: 3092K (ffff8800379e6000 - ffff880037ceb000)
[    0.463900] microcode: CPU0 sig=0x30678, pf=0x2, revision=0x829
[    0.463929] microcode: CPU1 sig=0x30678, pf=0x2, revision=0x829
[    0.463963] microcode: CPU2 sig=0x30678, pf=0x2, revision=0x829
[    0.463994] microcode: CPU3 sig=0x30678, pf=0x2, revision=0x829
[    0.464128] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    0.464281] Scanning for low memory corruption every 60 seconds
[    0.465100] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.465151] Initialise system trusted keyring
[    0.465904] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.470726] zpool: loaded
[    0.470743] zbud: loaded
[    0.471315] VFS: Disk quotas dquot_6.6.0
[    0.471436] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.471880] Key type big_key registered
[    0.472217] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.472324] io scheduler noop registered
[    0.472342] io scheduler deadline registered
[    0.472452] io scheduler cfq registered (default)
[    0.472624] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.472658] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.472754] efifb: probing for efifb
[    0.472795] efifb: framebuffer at 0x80000000, mapped to 0xffffc90000800000, using 4160k, total 4160k
[    0.472817] efifb: mode is 1366x768x32, linelength=5504, pages=1
[    0.472829] efifb: scrolling: redraw
[    0.472841] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.482712] Console: switching to colour frame buffer device 170x48
[    0.492341] fb0: EFI VGA frame buffer device
[    0.492434] intel_idle: MWAIT substates: 0x33000020
[    0.492439] intel_idle: v0.4 model 0x37
[    0.492443] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.492964] GHES: HEST is not enabled!
[    0.493183] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.513579] 00:02: ttyS0 at I/O 0x3f8 (irq = 200, base_baud = 115200) is a 16550A
[    0.514619] hpet: number irqs doesn't agree with number of timers
[    0.514776] Linux agpgart interface v0.103
[    0.515611] ACPI Warning: Could not enable fixed event - RealTimeClock (4) (20150515/evxface-654)
[    0.515971] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    0.516106] rtc_cmos 00:00: alarms up to one day, 242 bytes nvram
[    0.516226] i2c /dev entries driver
[    0.516314] Intel P-state driver initializing.
[    0.516777] ledtrig-cpu: registered to indicate activity on CPUs
[    0.519159] NET: Registered protocol family 10
[    0.520600] NET: Registered protocol family 17
[    0.523030] Loading compiled-in X.509 certificates
[    0.523314] registered taskstats version 1
[    0.523547] zswap: loading zswap
[    0.523695] zswap: using zbud pool
[    0.523906] zswap: using lzo compressor
[    0.525112]   Magic number: 3:774:239
[    0.525398] rtc_cmos 00:00: setting system clock to 2015-06-24 17:12:27 UTC (1435165947)
[    0.525938] PM: Hibernation image not present or could not be loaded.
[    0.526790] Freeing unused kernel memory: 1168K (ffffffff818e0000 - ffffffff81a04000)
[    0.526951] Write protecting the kernel read-only data: 8192k
[    0.531732] Freeing unused kernel memory: 728K (ffff88000154a000 - ffff880001600000)
[    0.535931] Freeing unused kernel memory: 380K (ffff8800017a1000 - ffff880001800000)
[    0.559180] random: systemd-tmpfile urandom read with 0 bits of entropy available
[    0.660326] sdhci: Secure Digital Host Controller Interface driver
[    0.663028] sdhci: Copyright(c) Pierre Ossman
[    0.667241] sdhci-acpi 80860F14:00: No vmmc regulator found
[    0.669856] sdhci-acpi 80860F14:00: No vqmmc regulator found
[    0.675702] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
[    0.679565] sdhci-acpi INT33BB:00: No vmmc regulator found
[    0.682214] sdhci-acpi INT33BB:00: No vqmmc regulator found
[    0.688103] mmc1: SDHCI controller on ACPI [INT33BB:00] using ADMA
[    0.692053] sdhci-acpi PNP0FFF:00: No vmmc regulator found
[    0.694746] sdhci-acpi PNP0FFF:00: No vqmmc regulator found
[    0.701834] ACPI: bus type USB registered
[    0.702599] mmc2: SDHCI controller on ACPI [PNP0FFF:00] using ADMA
[    0.707509] usbcore: registered new interface driver usbfs
[    0.710126] usbcore: registered new interface driver hub
[    0.712776] usbcore: registered new device driver usb
[    0.717373] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.719924] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    0.722836] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x00009810
[    0.725414] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    0.725958] hub 1-0:1.0: USB hub found
[    0.728505] hub 1-0:1.0: 6 ports detected
[    0.732151] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.734633] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    0.737561] hub 2-0:1.0: USB hub found
[    0.740009] hub 2-0:1.0: 1 port detected
[    0.807872] mmc0: MAN_BKOPS_EN bit is not set
[    0.819825] mmc0: new HS200 MMC card at address 0001
[    0.824942] mmcblk0: mmc0:0001 HBG4e 29.1 GiB 
[    0.827343] mmcblk0boot0: mmc0:0001 HBG4e partition 1 4.00 MiB
[    0.829770] mmcblk0boot1: mmc0:0001 HBG4e partition 2 4.00 MiB
[    0.832952] mmcblk0rpmb: mmc0:0001 HBG4e partition 3 4.00 MiB
[    0.837843]  mmcblk0: p1 p2
[    0.913268] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    0.917205] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    0.921096] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    0.926167] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    0.988236] mmc1: queuing unknown CIS tuple 0x91 (3 bytes)
[    0.990568] mmc1: new ultra high speed DDR50 SDIO card at address 0001
[    1.020815] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[    1.114032] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    1.136914] systemd[1]: systemd 221 running in system mode. (+PAM -AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD +IDN)
[    1.141637] systemd[1]: Detected architecture x86-64.
[    1.154814] systemd[1]: Set hostname to <asus>.
[    1.290960] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    1.293259] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
[    1.298664] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    1.301366] systemd[1]: Starting Arbitrary Executable File Formats File System Automount Point.
[    1.307413] systemd[1]: Created slice Root Slice.
[    1.310137] systemd[1]: Starting Root Slice.
[    1.315712] systemd[1]: Listening on Journal Socket.
[    1.318445] systemd[1]: Starting Journal Socket.
[    1.324092] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    1.326891] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[    1.332819] systemd[1]: Created slice User and Session Slice.
[    1.335630] systemd[1]: Starting User and Session Slice.
[    1.341611] systemd[1]: Created slice System Slice.
[    1.344406] systemd[1]: Starting System Slice.
[    1.350084] systemd[1]: Reached target Slices.
[    1.352872] systemd[1]: Starting Slices.
[    1.355655] systemd[1]: Started File System Check on Root Device.
[    1.359747] systemd[1]: Starting Setup Virtual Console...
[    1.371150] systemd[1]: Started Load Kernel Modules.
[    1.375239] systemd[1]: Mounting POSIX Message Queue File System...
[    1.384307] systemd[1]: Listening on udev Control Socket.
[    1.387236] systemd[1]: Starting udev Control Socket.
[    1.393841] systemd[1]: Mounting Temporary Directory...
[    1.403336] systemd[1]: Listening on networkd rtnetlink socket.
[    1.406330] systemd[1]: Starting networkd rtnetlink socket.
[    1.410340] systemd[1]: Started Set Up Additional Binary Formats.
[    1.422340] systemd[1]: Listening on Journal Audit Socket.
[    1.426604] systemd[1]: Starting Apply Kernel Variables...
[    1.435233] systemd[1]: Listening on udev Kernel Socket.
[    1.437868] systemd[1]: Starting udev Kernel Socket.
[    1.443554] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    1.446230] systemd[1]: Starting system-systemd\x2dfsck.slice.
[    1.450236] systemd[1]: Starting Remount Root and Kernel File Systems...
[    1.457248] systemd[1]: Mounting Huge Pages File System...
[    1.458360] EXT4-fs (mmcblk0p2): re-mounted. Opts: data=ordered,commit=60
[    1.468208] systemd[1]: Listening on LVM2 metadata daemon socket.
[    1.470788] systemd[1]: Starting LVM2 metadata daemon socket.
[    1.476120] systemd[1]: Listening on Journal Socket (/dev/log).
[    1.478716] systemd[1]: Starting Journal Socket (/dev/log).
[    1.484377] systemd[1]: Created slice system-wpa_supplicant.slice.
[    1.486985] systemd[1]: Starting system-wpa_supplicant.slice.
[    1.491041] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    1.499781] systemd[1]: Created slice system-getty.slice.
[    1.502475] systemd[1]: Starting system-getty.slice.
[    1.508198] systemd[1]: Created slice system-dhcpcd.slice.
[    1.510889] systemd[1]: Starting system-dhcpcd.slice.
[    1.516378] systemd[1]: Reached target Encrypted Volumes.
[    1.519098] systemd[1]: Starting Encrypted Volumes.
[    1.519347] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x13303f810e3, max_idle_ns: 440795235405 ns
[    1.524573] clocksource: Switched to clocksource tsc
[    1.524721] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    1.524745] systemd[1]: Starting Dispatch Password Requests to Console Directory Watch.
[    1.535301] systemd[1]: Reached target Paths.
[    1.537734] systemd[1]: Starting Paths.
[    1.542805] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    1.545316] systemd[1]: Starting Device-mapper event daemon FIFOs.
[    1.550372] systemd[1]: Reached target Remote File Systems.
[    1.552878] systemd[1]: Starting Remote File Systems.
[    1.556463] systemd[1]: Starting Journal Service...
[    1.564183] systemd[1]: Mounting Debug File System...
[    1.570336] systemd[1]: Mounted FUSE Control File System.
[    1.574684] systemd[1]: Mounting Configuration File System...
[    1.583788] systemd[1]: Reached target Swap.
[    1.586669] systemd[1]: Starting Swap.
[    1.594130] systemd[1]: Mounted Configuration File System.
[    1.599982] systemd[1]: Mounted POSIX Message Queue File System.
[    1.605568] systemd[1]: Mounted Debug File System.
[    1.611238] systemd[1]: Mounted Huge Pages File System.
[    1.616370] systemd[1]: Mounted Temporary Directory.
[    1.622367] systemd[1]: Started Setup Virtual Console.
[    1.628757] systemd[1]: Started Apply Kernel Variables.
[    1.634661] systemd[1]: Started Remount Root and Kernel File Systems.
[    1.640367] systemd[1]: Started Create list of required static device nodes for the current kernel.
[    1.677553] systemd[1]: Starting Load/Save Random Seed...
[    1.683033] systemd[1]: Started Rebuild Dynamic Linker Cache.
[    1.688158] systemd[1]: Started Rebuild Hardware Database.
[    1.692414] systemd[1]: Starting udev Coldplug all Devices...
[    1.698034] systemd[1]: Started First Boot Wizard.
[    1.700857] systemd[1]: Started Create System Users.
[    1.705700] systemd[1]: Starting Create Static Device Nodes in /dev...
[    1.717561] systemd[1]: Started Load/Save Random Seed.
[    1.739378] systemd[1]: Started Create Static Device Nodes in /dev.
[    1.746338] systemd[1]: Starting udev Kernel Device Manager...
[    1.755167] systemd[1]: Reached target Local File Systems (Pre).
[    1.757971] systemd[1]: Starting Local File Systems (Pre).
[    1.760708] systemd[1]: Mounted Virtual Machine and Container Storage.
[    1.767848] systemd[1]: Started Journal Service.
[    1.785729] systemd-journald[180]: Received request to flush runtime journal from PID 1
[    2.011183] usb 1-2: new high-speed USB device number 3 using xhci_hcd
[    2.158085] 80860F0A:00: ttyS1 at MMIO 0x90941000 (irq = 191, base_baud = 2764800) is a 16550A
[    2.162107] 80860F0A:01: ttyS2 at MMIO 0x90947000 (irq = 193, base_baud = 2764800) is a 16550A
[    2.162810] ACPI: AC Adapter [ADP1] (on-line)
[    2.186517] hub 1-2:1.0: USB hub found
[    2.189744] hub 1-2:1.0: 4 ports detected
[    2.194252] usb: failed to peer 1-2-port1 and usb2-port1 by location (1-2-port1:none) (usb2-port1:usb1-port1)
[    2.197288] usb 1-2-port1: failed to peer to usb2-port1 (-16)
[    2.200241] usb: port power management may be unreliable
[    2.203418] usb: failed to peer 1-2-port2 and usb2-port1 by location (1-2-port2:none) (usb2-port1:usb1-port1)
[    2.206456] usb 1-2-port2: failed to peer to usb2-port1 (-16)
[    2.215006] usb: failed to peer 1-2-port3 and usb2-port1 by location (1-2-port3:none) (usb2-port1:usb1-port1)
[    2.218150] usb 1-2-port3: failed to peer to usb2-port1 (-16)
[    2.221549] usb: failed to peer 1-2-port4 and usb2-port1 by location (1-2-port4:none) (usb2-port1:usb1-port1)
[    2.224786] usb 1-2-port4: failed to peer to usb2-port1 (-16)
[    2.235497] dw_dmac INTL9C60:00: DesignWare DMA Controller, 8 channels
[    2.239132] hidraw: raw HID events driver (C) Jiri Kosina
[    2.243232] dw_dmac INTL9C60:01: DesignWare DMA Controller, 8 channels
[    2.253834] snd-soc-dummy snd-soc-dummy: codec register snd-soc-dummy
[    2.253852] snd-soc-dummy snd-soc-dummy: ASoC: dai register snd-soc-dummy #1
[    2.253858] snd-soc-dummy snd-soc-dummy: ASoC: Registered DAI 'snd-soc-dummy-dai'
[    2.253864] snd-soc-dummy snd-soc-dummy: ASoC: Registered codec 'snd-soc-dummy'
[    2.253869] snd-soc-dummy snd-soc-dummy: ASoC: platform register snd-soc-dummy
[    2.253876] snd-soc-dummy snd-soc-dummy: ASoC: Registered platform 'snd-soc-dummy'
[    2.264587] intel_sst_acpi 80860F28:00: for 80860F28
[    2.268616] intel_sst_acpi 80860F28:00: ACPI device id: 80860f28
[    2.268736] sst-mfld-platform sst-mfld-platform: ASoC: platform register sst-mfld-platform
[    2.268747] sst-mfld-platform sst-mfld-platform: ASoC: Registered platform 'sst-mfld-platform'
[    2.268754] sst-mfld-platform sst-mfld-platform: ASoC: dai register sst-mfld-platform #5
[    2.268760] sst-mfld-platform sst-mfld-platform: ASoC: Registered DAI 'media-cpu-dai'
[    2.268765] sst-mfld-platform sst-mfld-platform: ASoC: Registered DAI 'compress-cpu-dai'
[    2.268770] sst-mfld-platform sst-mfld-platform: ASoC: Registered DAI 'ssp0-port'
[    2.268775] sst-mfld-platform sst-mfld-platform: ASoC: Registered DAI 'ssp1-port'
[    2.268780] sst-mfld-platform sst-mfld-platform: ASoC: Registered DAI 'ssp2-port'
[    2.268858] intel_sst_acpi 80860F28:00: LPE base: 0x90a00000 size:0x200000
[    2.272150] intel_sst_acpi 80860F28:00: IRAM base: 0x90ac0000
[    2.275370] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    2.275379] intel_sst_acpi 80860F28:00: DRAM base: 0x90b00000
[    2.275389] intel_sst_acpi 80860F28:00: SHIM base: 0x90b40000
[    2.275398] intel_sst_acpi 80860F28:00: Mailbox base: 0x90b44000
[    2.275407] intel_sst_acpi 80860F28:00: DDR base: 0x20000000
[    2.275492] intel_sst_acpi 80860F28:00: Got drv data max stream 25
[    2.275579] intel_sst_acpi 80860F28:00: Registered IRQ 0x6
[    2.275585] intel_sst_acpi 80860F28:00: Requesting FW intel/fw_sst_0f28.bin now...
[    2.275595] intel_sst_acpi 80860F28:00: registering device Intel(R) SST LPE
[    2.279571] intel_sst_acpi 80860F28:00: LPE is already in RESET state, No action
[    2.289556] intel_sst_acpi 80860F28:00: Enter
[    2.289560] intel_sst_acpi 80860F28:00: Request Fw completed
[    2.289859] intel_sst_acpi 80860F28:00: copied fw to ffff88007ac00000
[    2.289862] intel_sst_acpi 80860F28:00: phys: 7ac00000
[    2.290233] intel_sst_acpi 80860F28:00: Enter
[    2.290238] intel_sst_acpi 80860F28:00: header sign=$SST\xffffff86\xffffffdf	 size=9df86 modules=1 fmt=100 size=20
[    2.290260] intel_sst_acpi 80860F28:00: module sign $SSTr\xffffffdf	 size 9df72 blocks 13 type ffff
[    2.290263] intel_sst_acpi 80860F28:00: module entrypoint 0x0
[    2.294153] ACPI: Lid Switch [LID]
[    2.297420] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    2.300648] ACPI: Power Button [PWRB]
[    2.300744] [Firmware Bug]: No valid trip found
[    2.307217] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    2.310401] ACPI: Sleep Button [SLPB]
[    2.314339] wmi: Mapper loaded
[    2.319506] mei_txe 0000:00:1a.0: can't derive routing for PCI INT A
[    2.323297] mei_txe 0000:00:1a.0: PCI INT A: no GSI
[    2.351526] media: Linux media interface: v0.10
[    2.355273] [drm] Initialized drm 1.1.0 20060810
[    2.368093] ACPI: Battery Slot [BATC] (battery present)
[    2.371755] input: PC Speaker as /devices/platform/pcspkr/input/input3
[    2.402990] rt5645 i2c-10EC5648:00: codec register i2c-10EC5648:00
[    2.403007] rt5645 i2c-10EC5648:00: ASoC: dai register i2c-10EC5648:00 #2
[    2.403013] rt5645 i2c-10EC5648:00: ASoC: Registered DAI 'rt5645-aif1'
[    2.403019] rt5645 i2c-10EC5648:00: ASoC: Registered DAI 'rt5645-aif2'
[    2.403027] rt5645 i2c-10EC5648:00: ASoC: Registered codec 'i2c-10EC5648:00'
[    2.403047] Linux video capture interface: v2.00
[    2.428469] cfg80211: Calling CRDA to update world regulatory domain
[    2.459102] SSE version of gcm_enc/dec engaged.
[    2.503239] uvcvideo: Found UVC 1.00 device USB2.0 VGA UVC WebCam (04f2:b483)
[    2.509474] [drm] Memory usable by graphics device = 2048M
[    2.512578] checking generic (80000000 410000) vs hw (80000000 10000000)
[    2.512597] fb: switching to inteldrmfb from EFI VGA
[    2.516893] Console: switching to colour dummy device 80x25
[    2.517101] [drm] Replacing VGA console driver
[    2.529402] Bluetooth: Core ver 2.20
[    2.529448] NET: Registered protocol family 31
[    2.529460] Bluetooth: HCI device and connection manager initialized
[    2.529477] Bluetooth: HCI socket layer initialized
[    2.529491] Bluetooth: L2CAP socket layer initialized
[    2.529515] Bluetooth: SCO socket layer initialized
[    2.533793] Bluetooth: Generic Bluetooth SDIO driver ver 0.1
[    2.534887] input: USB2.0 VGA UVC WebCam as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/input/input4
[    2.534997] usbcore: registered new interface driver uvcvideo
[    2.535010] USB Video Class driver (1.1.1)
[    2.549928] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    2.551494] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.553060] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.555616] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.555635] [drm] Driver supports precise vblank timestamp query.
[    2.555852] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    2.567955] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Audio Port at idx 0
[    2.567970] bytx205_rt5645 bytx205_rt5645: ASoC: binding Baytrail Compressed Port at idx 1
[    2.567977] bytx205_rt5645 bytx205_rt5645: ASoC: binding SSP1-Codec at idx 2
[    2.568029] sst-mfld-platform sst-mfld-platform: ASoC: adding ssp2 Tx widget
[    2.568036] sst-mfld-platform sst-mfld-platform: ASoC: adding ssp2 Rx widget
[    2.568042] sst-mfld-platform sst-mfld-platform: ASoC: adding ssp1 Tx widget
[    2.568048] sst-mfld-platform sst-mfld-platform: ASoC: adding ssp1 Rx widget
[    2.568055] sst-mfld-platform sst-mfld-platform: ASoC: adding ssp0 Tx widget
[    2.568068] sst-mfld-platform sst-mfld-platform: ASoC: adding ssp0 Rx widget
[    2.568074] sst-mfld-platform sst-mfld-platform: ASoC: adding Compress Playback widget
[    2.568081] sst-mfld-platform sst-mfld-platform: ASoC: adding Headset Playback widget
[    2.568087] sst-mfld-platform sst-mfld-platform: ASoC: adding Headset Capture widget
[    2.568105] snd-soc-dummy snd-soc-dummy: ASoC: adding Playback widget
[    2.568112] snd-soc-dummy snd-soc-dummy: ASoC: adding Capture widget
[    2.569166] sst-mfld-platform sst-mfld-platform: widget type=22 name=codec_in0
[    2.569191] sst-mfld-platform sst-mfld-platform: widget type=22 name=codec_in1
[    2.569211] sst-mfld-platform sst-mfld-platform: widget type=23 name=codec_out0
[    2.569239] sst-mfld-platform sst-mfld-platform: widget type=23 name=codec_out1
[    2.569266] sst-mfld-platform sst-mfld-platform: widget type=6 name=media0_in
[    2.569283] sst-mfld-platform sst-mfld-platform: widget type=6 name=media1_in
[    2.569299] sst-mfld-platform sst-mfld-platform: widget type=6 name=media2_in
[    2.569315] sst-mfld-platform sst-mfld-platform: widget type=6 name=media3_in
[    2.569334] sst-mfld-platform sst-mfld-platform: widget type=6 name=media0_out
[    2.569353] sst-mfld-platform sst-mfld-platform: widget type=6 name=media1_out
[    2.569372] sst-mfld-platform sst-mfld-platform: widget type=6 name=pcm0_in
[    2.569386] sst-mfld-platform sst-mfld-platform: widget type=6 name=pcm1_in
[    2.569401] sst-mfld-platform sst-mfld-platform: widget type=6 name=pcm0_out
[    2.569422] sst-mfld-platform sst-mfld-platform: widget type=6 name=pcm1_out
[    2.569450] sst-mfld-platform sst-mfld-platform: widget type=6 name=pcm2_out
[    2.569481] sst-mfld-platform sst-mfld-platform: widget type=6 name=sprot_loop_in
[    2.569494] sst-mfld-platform sst-mfld-platform: widget type=6 name=media_loop1_in
[    2.569516] sst-mfld-platform sst-mfld-platform: widget type=6 name=media_loop2_in
[    2.569534] sst-mfld-platform sst-mfld-platform: widget type=6 name=sprot_loop_out
[    2.569560] sst-mfld-platform sst-mfld-platform: widget type=6 name=media_loop1_out
[    2.569589] sst-mfld-platform sst-mfld-platform: widget type=6 name=media_loop2_out
[    2.569618] sst-mfld-platform sst-mfld-platform: widget type=4 name=media0_out mix 0
[    2.569637] sst-mfld-platform sst-mfld-platform: widget type=4 name=media1_out mix 0
[    2.569655] sst-mfld-platform sst-mfld-platform: widget type=4 name=pcm0_out mix 0
[    2.569676] sst-mfld-platform sst-mfld-platform: widget type=4 name=pcm1_out mix 0
[    2.569700] sst-mfld-platform sst-mfld-platform: widget type=4 name=pcm2_out mix 0
[    2.569723] sst-mfld-platform sst-mfld-platform: widget type=4 name=sprot_loop_out mix 0
[    2.569749] sst-mfld-platform sst-mfld-platform: widget type=4 name=media_loop1_out mix 0
[    2.569779] sst-mfld-platform sst-mfld-platform: widget type=4 name=media_loop2_out mix 0
[    2.569808] sst-mfld-platform sst-mfld-platform: widget type=4 name=codec_out0 mix 0
[    2.569835] sst-mfld-platform sst-mfld-platform: widget type=4 name=codec_out1 mix 0
[    2.570012] rt5645 i2c-10EC5648:00: ASoC: adding AIF2 Playback widget
[    2.570021] rt5645 i2c-10EC5648:00: ASoC: adding AIF2 Capture widget
[    2.570027] rt5645 i2c-10EC5648:00: ASoC: adding AIF1 Playback widget
[    2.570033] rt5645 i2c-10EC5648:00: ASoC: adding AIF1 Capture widget
[    2.575265] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 0 late -2
[    2.575276] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 1 late -2
[    2.575282] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 2 late -2
[    2.575287] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 0 late -1
[    2.575292] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 1 late -1
[    2.575297] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 2 late -1
[    2.575303] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 0 late 0
[    2.575308] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 1 late 0
[    2.575313] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 2 late 0
[    2.575319] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 0 late 1
[    2.575324] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 1 late 1
[    2.575329] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 2 late 1
[    2.575334] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 0 late 2
[    2.575448] bytx205_rt5645 bytx205_rt5645: ASoC: registered pcm #0 Baytrail Audio (*)
[    2.575535] bytx205_rt5645 bytx205_rt5645: snd-soc-dummy-dai <-> media-cpu-dai mapping ok
[    2.575559] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 1 late 2
[    2.575607] compress asoc: snd-soc-dummy-dai <-> compress-cpu-dai mapping ok
[    2.575682] bytx205_rt5645 bytx205_rt5645: ASoC: probe baytrailcraudio dai link 2 late 2
[    2.575741] bytx205_rt5645 bytx205_rt5645: ASoC: registered pcm #2 ((null))
[    2.575747] bytx205_rt5645 bytx205_rt5645: rt5645-aif1 <-> ssp1-port mapping ok
[    2.575813] rt5645 i2c-10EC5648:00: AIF2 Playback -> AIF2RX
[    2.575823] rt5645 i2c-10EC5648:00: AIF2TX -> AIF2 Capture
[    2.575831] rt5645 i2c-10EC5648:00: AIF1 Playback -> AIF1RX
[    2.575840] rt5645 i2c-10EC5648:00: AIF1TX -> AIF1 Capture
[    2.575848]  SSP1-Codec: connected DAI link sst-mfld-platform:ssp1 Tx -> i2c-10EC5648:00:AIF1 Playback
[    2.575853]  SSP1-Codec: connected DAI link i2c-10EC5648:00:AIF1 Capture -> sst-mfld-platform:ssp1 Rx
[    2.579409] asus_wmi: ASUS WMI generic driver loaded
[    2.583841] asus_wmi: Initialization: 0x1
[    2.584092] asus_wmi: BIOS WMI version: 7.9
[    2.584969] asus_wmi: SFUN value: 0x37
[    2.585704] iTCO_vendor_support: vendor-support=0
[    2.586955] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    2.587087] iTCO_wdt: Found a Bay Trail SoC TCO device (Version=3, TCOBASE=0x0460)
[    2.587351] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    2.594577] input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/input/input5
[    2.607756] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:7 / ret_size:4
[    2.609714] asus_wmi: Number of fans: 1
[    2.614412] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:19 / ret_size:4
[    2.614746] input: PDEC3393:00 0B05:8585 as /devices/platform/80860F41:00/i2c-0/i2c-PDEC3393:00/0018:0B05:8585.0001/input/input6
[    2.621738] intel_rapl: Found RAPL domain package
[    2.621766] intel_rapl: Found RAPL domain core
[    2.628067] hid-generic 0018:0B05:8585.0001: input,hidraw0: <UNKNOWN> HID v1.00 Keyboard [PDEC3393:00 0B05:8585] on 
[    2.631634] brcmfmac: brcmf_sdio_drivestrengthinit: No SDIO Drive strength init done for chip 43340 rev 2 pmurev 20
[    2.632950] usbcore: registered new interface driver brcmfmac
[    2.663765] random: nonblocking pool is initialized
[    2.667782] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    2.697713] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:633 / ret_size:7
[    2.698610] sst-mfld-platform sst-mfld-platform: media0_in: Ramp Delay5
[    2.698632] sst-mfld-platform sst-mfld-platform: media0_in: Mute 1
[    2.698675] sst-mfld-platform sst-mfld-platform: media0_in: Volume -1440, -1440
[    2.698699] sst-mfld-platform sst-mfld-platform: media1_in: Ramp Delay50
[    2.698717] sst-mfld-platform sst-mfld-platform: media1_in: Mute 0
[    2.698750] sst-mfld-platform sst-mfld-platform: media1_in: Volume 0, 0
[    2.698773] sst-mfld-platform sst-mfld-platform: media2_in: Ramp Delay5
[    2.698791] sst-mfld-platform sst-mfld-platform: media2_in: Mute 1
[    2.698825] sst-mfld-platform sst-mfld-platform: media2_in: Volume -1440, -1440
[    2.698849] sst-mfld-platform sst-mfld-platform: media3_in: Ramp Delay5
[    2.698867] sst-mfld-platform sst-mfld-platform: media3_in: Mute 1
[    2.698901] sst-mfld-platform sst-mfld-platform: media3_in: Volume -1440, -1440
[    2.698924] sst-mfld-platform sst-mfld-platform: pcm0_in: Ramp Delay50
[    2.698942] sst-mfld-platform sst-mfld-platform: pcm0_in: Mute 0
[    2.698975] sst-mfld-platform sst-mfld-platform: pcm0_in: Volume 0, 0
[    2.698999] sst-mfld-platform sst-mfld-platform: pcm1_in: Ramp Delay5
[    2.699017] sst-mfld-platform sst-mfld-platform: pcm1_in: Mute 1
[    2.699051] sst-mfld-platform sst-mfld-platform: pcm1_in: Volume -1440, -1440
[    2.699074] sst-mfld-platform sst-mfld-platform: pcm1_out: Ramp Delay5
[    2.699093] sst-mfld-platform sst-mfld-platform: pcm1_out: Mute 1
[    2.699126] sst-mfld-platform sst-mfld-platform: pcm1_out: Volume -1440, -1440
[    2.699151] sst-mfld-platform sst-mfld-platform: pcm2_out: Ramp Delay5
[    2.699169] sst-mfld-platform sst-mfld-platform: pcm2_out: Mute 1
[    2.699204] sst-mfld-platform sst-mfld-platform: pcm2_out: Volume -1440, -1440
[    2.699228] sst-mfld-platform sst-mfld-platform: codec_in0: Ramp Delay5
[    2.699246] sst-mfld-platform sst-mfld-platform: codec_in0: Mute 1
[    2.699280] sst-mfld-platform sst-mfld-platform: codec_in0: Volume -1440, -1440
[    2.699305] sst-mfld-platform sst-mfld-platform: codec_in1: Ramp Delay5
[    2.699323] sst-mfld-platform sst-mfld-platform: codec_in1: Mute 1
[    2.699358] sst-mfld-platform sst-mfld-platform: codec_in1: Volume -1440, -1440
[    2.699382] sst-mfld-platform sst-mfld-platform: codec_out0: Ramp Delay50
[    2.699401] sst-mfld-platform sst-mfld-platform: codec_out0: Mute 0
[    2.699435] sst-mfld-platform sst-mfld-platform: codec_out0: Volume 0, 0
[    2.699460] sst-mfld-platform sst-mfld-platform: codec_out1: Ramp Delay5
[    2.699478] sst-mfld-platform sst-mfld-platform: codec_out1: Mute 1
[    2.699514] sst-mfld-platform sst-mfld-platform: codec_out1: Volume -1440, -1440
[    2.699539] sst-mfld-platform sst-mfld-platform: media_loop1_out: Ramp Delay5
[    2.699558] sst-mfld-platform sst-mfld-platform: media_loop1_out: Mute 1
[    2.699594] sst-mfld-platform sst-mfld-platform: media_loop1_out: Volume -1440, -1440
[    2.699620] sst-mfld-platform sst-mfld-platform: media_loop2_out: Ramp Delay5
[    2.699640] sst-mfld-platform sst-mfld-platform: media_loop2_out: Mute 1
[    2.699676] sst-mfld-platform sst-mfld-platform: media_loop2_out: Volume -1440, -1440
[    2.699700] sst-mfld-platform sst-mfld-platform: sprot_loop_out: Ramp Delay5
[    2.699719] sst-mfld-platform sst-mfld-platform: sprot_loop_out: Mute 1
[    2.699755] sst-mfld-platform sst-mfld-platform: sprot_loop_out: Volume -1440, -1440
[    2.699780] sst-mfld-platform sst-mfld-platform: media0_in: Ramp Delay5
[    2.699799] sst-mfld-platform sst-mfld-platform: media0_in: Mute 1
[    2.699835] sst-mfld-platform sst-mfld-platform: media0_in: Volume -1440, -1440
[    2.699868] sst-mfld-platform sst-mfld-platform: control_name=media_loop1_out fir 0 params
[    2.699901] sst-mfld-platform sst-mfld-platform: control_name=media_loop1_out iir 0 params
[    2.699932] sst-mfld-platform sst-mfld-platform: control_name=media_loop1_out mdrp 0 params
[    2.699963] sst-mfld-platform sst-mfld-platform: control_name=media_loop2_out fir 0 params
[    2.699995] sst-mfld-platform sst-mfld-platform: control_name=media_loop2_out iir 0 params
[    2.700027] sst-mfld-platform sst-mfld-platform: control_name=media_loop2_out mdrp 0 params
[    2.700054] sst-mfld-platform sst-mfld-platform: control_name=sprot_loop_out lpro 0 params
[    2.700075] sst-mfld-platform sst-mfld-platform: control_name=codec_in0 dcr 0 params
[    2.700095] sst-mfld-platform sst-mfld-platform: control_name=codec_in1 dcr 0 params
[    2.700120] sst-mfld-platform sst-mfld-platform: tx channel codec_out0_0 map = 0x1
[    2.700127] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 0 doesn't have DAPM widget!!!
[    2.700172] sst-mfld-platform sst-mfld-platform: tx channel codec_out0_1 map = 0x2
[    2.700177] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 1 doesn't have DAPM widget!!!
[    2.700220] sst-mfld-platform sst-mfld-platform: tx channel codec_out1_0 map = 0x4
[    2.700226] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 2 doesn't have DAPM widget!!!
[    2.700271] sst-mfld-platform sst-mfld-platform: tx channel codec_out1_1 map = 0x8
[    2.700276] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 3 doesn't have DAPM widget!!!
[    2.700315] sst-mfld-platform sst-mfld-platform: rx slot slot 0 map = 0x1
[    2.700321] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
[    2.700363] sst-mfld-platform sst-mfld-platform: rx slot slot 1 map = 0x2
[    2.700368] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
[    2.700411] sst-mfld-platform sst-mfld-platform: rx slot slot 2 map = 0x4
[    2.700417] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
[    2.700462] sst-mfld-platform sst-mfld-platform: rx slot slot 3 map = 0x8
[    2.700468] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!
[    2.708420] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:131 / ret_size:7
[    2.708625] input: ELAN0100:00 04F3:0401 as /devices/platform/80860F41:03/i2c-3/i2c-ELAN0100:00/0018:04F3:0401.0002/input/input7
[    2.709225] hid-generic 0018:04F3:0401.0002: input,hidraw1: <UNKNOWN> HID v1.00 Mouse [ELAN0100:00 04F3:0401] on 
[    2.719861] mousedev: PS/2 mouse device common for all mice
[    2.723903] fbcon: inteldrmfb (fb0) is primary device
[    2.729295] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    2.729665] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input8
[    2.729905] [drm] Initialized i915 1.6.0 20150522 for 0000:00:02.0 on minor 0
[    3.848117] Console: switching to colour frame buffer device 170x48
[    3.861678] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    3.861681] i915 0000:00:02.0: registered panic notifier
[    3.897112] sst-mfld-platform sst-mfld-platform: media0_in: Ramp Delay5
[    3.897134] sst-mfld-platform sst-mfld-platform: media0_in: Mute 1
[    3.897173] sst-mfld-platform sst-mfld-platform: media0_in: Volume -1440, -1440
[    3.897198] sst-mfld-platform sst-mfld-platform: media1_in: Ramp Delay50
[    3.897216] sst-mfld-platform sst-mfld-platform: media1_in: Mute 0
[    3.897249] sst-mfld-platform sst-mfld-platform: media1_in: Volume 0, 0
[    3.897327] sst-mfld-platform sst-mfld-platform: media2_in: Ramp Delay5
[    3.897346] sst-mfld-platform sst-mfld-platform: media2_in: Mute 1
[    3.897381] sst-mfld-platform sst-mfld-platform: media2_in: Volume -1440, -1440
[    3.897405] sst-mfld-platform sst-mfld-platform: media3_in: Ramp Delay5
[    3.897424] sst-mfld-platform sst-mfld-platform: media3_in: Mute 1
[    3.897463] sst-mfld-platform sst-mfld-platform: media3_in: Volume -1440, -1440
[    3.897487] sst-mfld-platform sst-mfld-platform: pcm0_in: Ramp Delay50
[    3.897506] sst-mfld-platform sst-mfld-platform: pcm0_in: Mute 0
[    3.897540] sst-mfld-platform sst-mfld-platform: pcm0_in: Volume 0, 0
[    3.897564] sst-mfld-platform sst-mfld-platform: pcm1_in: Ramp Delay5
[    3.897583] sst-mfld-platform sst-mfld-platform: pcm1_in: Mute 1
[    3.897618] sst-mfld-platform sst-mfld-platform: pcm1_in: Volume -1440, -1440
[    3.897643] sst-mfld-platform sst-mfld-platform: pcm1_out: Ramp Delay5
[    3.897662] sst-mfld-platform sst-mfld-platform: pcm1_out: Mute 1
[    3.897697] sst-mfld-platform sst-mfld-platform: pcm1_out: Volume -1440, -1440
[    3.897722] sst-mfld-platform sst-mfld-platform: pcm2_out: Ramp Delay5
[    3.897740] sst-mfld-platform sst-mfld-platform: pcm2_out: Mute 1
[    3.897776] sst-mfld-platform sst-mfld-platform: pcm2_out: Volume -1440, -1440
[    3.897801] sst-mfld-platform sst-mfld-platform: codec_in0: Ramp Delay5
[    3.897819] sst-mfld-platform sst-mfld-platform: codec_in0: Mute 1
[    3.897854] sst-mfld-platform sst-mfld-platform: codec_in0: Volume -1440, -1440
[    3.897879] sst-mfld-platform sst-mfld-platform: codec_in1: Ramp Delay5
[    3.897897] sst-mfld-platform sst-mfld-platform: codec_in1: Mute 1
[    3.897932] sst-mfld-platform sst-mfld-platform: codec_in1: Volume -1440, -1440
[    3.897957] sst-mfld-platform sst-mfld-platform: codec_out0: Ramp Delay50
[    3.897976] sst-mfld-platform sst-mfld-platform: codec_out0: Mute 0
[    3.898012] sst-mfld-platform sst-mfld-platform: codec_out0: Volume 0, 0
[    3.898037] sst-mfld-platform sst-mfld-platform: codec_out1: Ramp Delay5
[    3.898056] sst-mfld-platform sst-mfld-platform: codec_out1: Mute 1
[    3.898092] sst-mfld-platform sst-mfld-platform: codec_out1: Volume -1440, -1440
[    3.898117] sst-mfld-platform sst-mfld-platform: media_loop1_out: Ramp Delay5
[    3.898137] sst-mfld-platform sst-mfld-platform: media_loop1_out: Mute 1
[    3.898174] sst-mfld-platform sst-mfld-platform: media_loop1_out: Volume -1440, -1440
[    3.898200] sst-mfld-platform sst-mfld-platform: media_loop2_out: Ramp Delay5
[    3.898220] sst-mfld-platform sst-mfld-platform: media_loop2_out: Mute 1
[    3.898257] sst-mfld-platform sst-mfld-platform: media_loop2_out: Volume -1440, -1440
[    3.898282] sst-mfld-platform sst-mfld-platform: sprot_loop_out: Ramp Delay5
[    3.898302] sst-mfld-platform sst-mfld-platform: sprot_loop_out: Mute 1
[    3.898338] sst-mfld-platform sst-mfld-platform: sprot_loop_out: Volume -1440, -1440
[    3.898364] sst-mfld-platform sst-mfld-platform: media0_in: Ramp Delay5
[    3.898384] sst-mfld-platform sst-mfld-platform: media0_in: Mute 1
[    3.898421] sst-mfld-platform sst-mfld-platform: media0_in: Volume -1440, -1440
[    3.898454] sst-mfld-platform sst-mfld-platform: control_name=media_loop1_out fir 0 params
[    3.898487] sst-mfld-platform sst-mfld-platform: control_name=media_loop1_out iir 0 params
[    3.898519] sst-mfld-platform sst-mfld-platform: control_name=media_loop1_out mdrp 0 params
[    3.898550] sst-mfld-platform sst-mfld-platform: control_name=media_loop2_out fir 0 params
[    3.898582] sst-mfld-platform sst-mfld-platform: control_name=media_loop2_out iir 0 params
[    3.898614] sst-mfld-platform sst-mfld-platform: control_name=media_loop2_out mdrp 0 params
[    3.898641] sst-mfld-platform sst-mfld-platform: control_name=sprot_loop_out lpro 0 params
[    3.898662] sst-mfld-platform sst-mfld-platform: control_name=codec_in0 dcr 0 params
[    3.898682] sst-mfld-platform sst-mfld-platform: control_name=codec_in1 dcr 0 params
[    3.898708] sst-mfld-platform sst-mfld-platform: tx channel codec_out0_0 map = 0x1
[    3.898714] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 0 doesn't have DAPM widget!!!
[    3.898890] sst-mfld-platform sst-mfld-platform: tx channel codec_out0_1 map = 0x2
[    3.898896] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 1 doesn't have DAPM widget!!!
[    3.899066] sst-mfld-platform sst-mfld-platform: tx channel codec_out1_0 map = 0x4
[    3.899072] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 2 doesn't have DAPM widget!!!
[    3.899243] sst-mfld-platform sst-mfld-platform: tx channel codec_out1_1 map = 0x8
[    3.899249] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 3 doesn't have DAPM widget!!!
[    3.899413] sst-mfld-platform sst-mfld-platform: rx slot slot 0 map = 0x1
[    3.899419] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
[    3.899591] sst-mfld-platform sst-mfld-platform: rx slot slot 1 map = 0x2
[    3.899597] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
[    3.899772] sst-mfld-platform sst-mfld-platform: rx slot slot 2 map = 0x4
[    3.899778] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
[    3.899954] sst-mfld-platform sst-mfld-platform: rx slot slot 3 map = 0x8
[    3.899960] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!
[    4.819217] brcmfmac: brcmf_c_preinit_dcmds: Firmware version = wl0: Jun 17 2014 11:48:43 version 6.10.190.49 (r485840) FWID 01-8744bcd2
[    4.833811] brcmfmac: brcmf_cfg80211_reg_notifier: not a ISO3166 code
[    4.923515] brcmfmac: brcmf_add_if: ERROR: netdev:wlan0 already exists
[    4.923525] brcmfmac: brcmf_add_if: ignore IF event
[    5.580422] cfg80211: Calling CRDA to update world regulatory domain
[    5.816139] cfg80211: Calling CRDA to update world regulatory domain
[    6.948275] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[    6.948286] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[    6.948293] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[    6.948298] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[    6.948304]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[    6.948308]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[    6.948312]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.948317]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.948409] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.948712]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.948745]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.948751]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.948910]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.948931]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.949136]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.949142]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.949210]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.949233]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.949347]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.949352]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.949398]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.949447]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.949454]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.949468] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[    6.949473] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[    6.949481] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.950318] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[    6.950331] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[    6.950338] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[    6.950345] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[    6.950351]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[    6.950356]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[    6.950361]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.950366]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.950377] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.950727]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.950766]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.950773]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.950971]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.950997]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.951245]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.951252]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.951334]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.951361]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.951505]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.951511]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.951569]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.951623]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.951631]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.951641] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[    6.951647] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[    6.951656] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.953831] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[    6.953843] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[    6.953851] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[    6.953858] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[    6.953864]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[    6.953869]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[    6.953874]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.953879]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.953890] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.954545]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.954582]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.954589]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.954942]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.954986]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.955181]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.955187]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.955359]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.955409]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.955527]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.955533]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.955584]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.955630]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.955638]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.955647] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[    6.955652] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[    6.955659] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.956825] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[    6.956835] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[    6.956845] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[    6.956851] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[    6.956856]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[    6.956860]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[    6.956864]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.956869]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.956878] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.957843]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.957879]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.957885]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.958198]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.958243]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.958430]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.958436]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.958622]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.958668]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 1 fmt 2
[    6.958800]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.958806]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.958863]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.958911]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.958918]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.958927] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[    6.958932] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[    6.958940] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.963261] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[    6.963271] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[    6.963277] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[    6.963282] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[    6.963286]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[    6.963290]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[    6.963293]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.963298]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.963307] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.963571]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.963607]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.963612]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.963777]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.963799]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.963985]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.963993]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.964060]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.964082]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.964189]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.964194]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.964238]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.964285]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.964294]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.964303] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[    6.964308] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[    6.964315] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.965220] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[    6.965229] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[    6.965235] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[    6.965240] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[    6.965246]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[    6.965250]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[    6.965254]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.965259]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.965268] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.965555]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.965590]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.965595]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.965759]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.965781]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.965962]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.965969]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.966036]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.966058]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.966173]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.966178]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.966228]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.966273]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.966280]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.966289] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[    6.966294] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[    6.966301] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.967207] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[    6.967217] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[    6.967223] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[    6.967229] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[    6.967234]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[    6.967238]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[    6.967242]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.967246]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.967255] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.967819]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.967857]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.967863]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.968165]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.968209]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.968395]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.968400]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.968574]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.968619]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.968732]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.968738]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.968792]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.968851]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.968857]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.968866] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[    6.968870] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[    6.968877] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.969486] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[    6.969495] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[    6.969500] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[    6.969505] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[    6.969509]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[    6.969513]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[    6.969517]  Baytrail Audio Port: ASoC: found 0 new BE paths
[    6.969524]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    6.969531] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.970405]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.970438]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.970444]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.970720]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.970759]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.970936]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.970942]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.971106]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.971147]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[    6.971258]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[    6.971264]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[    6.971318]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.971370]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    6.971377]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[    6.971386] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[    6.971391] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[    6.971398] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[    6.972023] sst-mfld-platform sst-mfld-platform: ASoC: added media1_in in widget list pos 0
[    6.972033] sst-mfld-platform sst-mfld-platform: ASoC: added media0_out mix 0 in widget list pos 1
[    6.972040] sst-mfld-platform sst-mfld-platform: ASoC: added media0_out in widget list pos 2
[    6.972048] sst-mfld-platform sst-mfld-platform: ASoC: added pcm0_in in widget list pos 3
[    6.972054] sst-mfld-platform sst-mfld-platform: ASoC: added codec_out0 mix 0 in widget list pos 4
[    6.972059] sst-mfld-platform sst-mfld-platform: ASoC: added codec_out0 in widget list pos 5
[    6.972065] sst-mfld-platform sst-mfld-platform: ASoC: added ssp1 Tx in widget list pos 6
[    6.972071] rt5645 i2c-10EC5648:00: ASoC: added AIF1 Playback in widget list pos 7
[    6.972077] rt5645 i2c-10EC5648:00: ASoC: added AIF1RX in widget list pos 8
[    6.972082] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC3 in widget list pos 9
[    6.972088] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC2 R Mux in widget list pos 10
[    6.972094] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC2 in widget list pos 11
[    6.972099] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC2 L Mux in widget list pos 12
[    6.972104] rt5645 i2c-10EC5648:00: ASoC: added DAC L2 Mux in widget list pos 13
[    6.972109] rt5645 i2c-10EC5648:00: ASoC: added DAC L2 Volume in widget list pos 14
[    6.972119] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC1 in widget list pos 15
[    6.972125] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC1 R Mux in widget list pos 16
[    6.972130] rt5645 i2c-10EC5648:00: ASoC: added DAC1 R Mux in widget list pos 17
[    6.972135] rt5645 i2c-10EC5648:00: ASoC: added DAC1 MIXR in widget list pos 18
[    6.972140] rt5645 i2c-10EC5648:00: ASoC: added Stereo DAC MIXR in widget list pos 19
[    6.972146] rt5645 i2c-10EC5648:00: ASoC: added DAC R1 in widget list pos 20
[    6.972151] rt5645 i2c-10EC5648:00: ASoC: added SPOR MIX in widget list pos 21
[    6.972156] rt5645 i2c-10EC5648:00: ASoC: added SPK amp in widget list pos 22
[    6.972161] rt5645 i2c-10EC5648:00: ASoC: added SPOR in widget list pos 23
[    6.972167] bytx205_rt5645 bytx205_rt5645: ASoC: added Ext Spk in widget list pos 24
[    6.972172] rt5645 i2c-10EC5648:00: ASoC: added SPOL in widget list pos 25
[    6.972178] rt5645 i2c-10EC5648:00: ASoC: added DAC 1 in widget list pos 26
[    6.972184] rt5645 i2c-10EC5648:00: ASoC: added SPK MIXR in widget list pos 27
[    6.972192] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC0 in widget list pos 28
[    6.972198] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC1 L Mux in widget list pos 29
[    6.972203] rt5645 i2c-10EC5648:00: ASoC: added DAC1 L Mux in widget list pos 30
[    6.972208] rt5645 i2c-10EC5648:00: ASoC: added DAC1 MIXL in widget list pos 31
[    6.972214] rt5645 i2c-10EC5648:00: ASoC: added Stereo DAC MIXL in widget list pos 32
[    6.972219] rt5645 i2c-10EC5648:00: ASoC: added DAC L1 in widget list pos 33
[    6.972224] rt5645 i2c-10EC5648:00: ASoC: added SPOL MIX in widget list pos 34
[    6.972230] rt5645 i2c-10EC5648:00: ASoC: added SPK MIXL in widget list pos 35
[    6.972237]  Baytrail Audio Port: ASoC: found 8 audio playback paths
[    6.972243]  Baytrail Audio Port: connected new DPCM playback path Baytrail Audio Port -> SSP1-Codec
[    6.972258]  Baytrail Audio Port: ASoC: found 1 new BE paths
[    6.972267]  SSP1-Codec: ASoC: open playback BE SSP1-Codec
[    6.972275] sst-mfld-platform sst-mfld-platform: enable=1, usage=0
[    6.972281] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[    6.972288] writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 55 00 00 00  ............U...
[    6.972295] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x8
[    6.972301] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[    6.972306] intel_sst_acpi 80860F28:00: length is 8
[    6.972311] intel_sst_acpi 80860F28:00: Enter
[    6.972316] intel_sst_acpi 80860F28:00: Enter: sync: 0
[    6.972324] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[    6.972328] intel_sst_acpi 80860F28:00: sst: size = 0x8
[    6.972334] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:8
[    6.972340] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[    7.970937] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[    7.970964] intel_sst_acpi 80860F28:00: fw returned err -16
[    7.970986] intel_sst_acpi 80860F28:00: Enter
[    7.970993] pvt_id freed --> 1
[    7.971011]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[    7.971028] intel_sst_acpi 80860F28:00: Enable: pm usage count: 1
[    7.971036] intel_sst_acpi 80860F28:00: sst_load_fw
[    7.971045] intel_sst_acpi 80860F28:00: Enter
[    7.971064] intel_sst_acpi 80860F28:00: sst: Resetting the DSP in mrfld
[    7.971076] intel_sst_acpi 80860F28:00: value:0x1e40001
[    7.971086] intel_sst_acpi 80860F28:00: value:0x1e40007
[    7.971096] intel_sst_acpi 80860F28:00: value:0x1e40006
[    8.010659] intel_sst_acpi 80860F28:00: config written to DCCM
[    8.010667] intel_sst_acpi 80860F28:00: sst: Starting the DSP in mrfld LALALALA
[    8.010673] intel_sst_acpi 80860F28:00: value:0x1e40006
[    8.010679] intel_sst_acpi 80860F28:00: value:0x1e40007
[    8.010685] intel_sst_acpi 80860F28:00: sst: Starting the DSP_merrifield:1e40802
[    8.010690] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 0 drv_id 1
[    8.725834] cfg80211: Calling CRDA to update world regulatory domain
[    9.009085] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x0 fw_state 0x1
[    9.009095] intel_sst_acpi 80860F28:00: fw download failed -16
[    9.009107] intel_sst_acpi 80860F28:00: Enter
[    9.009111] pvt_id freed --> 1
[    9.009117] intel_sst_acpi 80860F28:00: fw load successful!!!
[    9.009122] intel_sst_acpi 80860F28:00: FW download fail -16
[    9.009331]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[    9.009341]  SSP1-Codec: ASoC: close BE Baytrail Audio Port
[    9.009349] sst-mfld-platform sst-mfld-platform: Enter: enable=0 port_name=ssp1-port
[    9.009355] sst-mfld-platform sst-mfld-platform: ssp_id: 3
[    9.009361] writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00  ............u...
[    9.009365] writing to lpe: 00000010: 03 00 00 00 18 09 0f ff 0f ff 03 00 01 01 01 00  ................
[    9.009369] writing to lpe: 00000020: 00 00                                            ..
[    9.009377] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x1a
[    9.009383] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[    9.009388] intel_sst_acpi 80860F28:00: length is 26
[    9.009392] intel_sst_acpi 80860F28:00: Enter
[    9.009398] intel_sst_acpi 80860F28:00: Enter: sync: 0
[    9.009405] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[    9.009410] intel_sst_acpi 80860F28:00: sst: size = 0x1a
[    9.009420] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:26
[    9.009426] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   10.010271] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   10.010298] intel_sst_acpi 80860F28:00: fw returned err -16
[   10.010316] intel_sst_acpi 80860F28:00: Enter
[   10.010328] pvt_id freed --> 1
[   10.010352] sst-mfld-platform sst-mfld-platform: enable=0, usage=1
[   10.010369] writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 0e 00 00 00  ................
[   10.010391] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x8
[   10.010410] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   10.010425] intel_sst_acpi 80860F28:00: length is 8
[   10.010439] intel_sst_acpi 80860F28:00: Enter
[   10.010456] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   10.010480] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   10.010489] intel_sst_acpi 80860F28:00: sst: size = 0x8
[   10.010499] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:8
[   10.010509] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   11.010642] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   11.010671] intel_sst_acpi 80860F28:00: fw returned err -16
[   11.010682] intel_sst_acpi 80860F28:00: Enter
[   11.010689] pvt_id freed --> 1
[   11.010703] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[   11.010724]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[   11.010736] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[   11.010746] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[   11.010756] intel_sst_acpi 80860F28:00: Disable: pm usage count: 0
[   11.010768]  SSP1-Codec: ASoC: BE SSP1-Codec event 2 dir 0
[   11.011577]  Baytrail Audio Port: ASoC: BE playback disconnect check for SSP1-Codec
[   11.011589]  Baytrail Audio Port: freed DSP playback path Baytrail Audio Port -> SSP1-Codec
[   11.012253] sst-mfld-platform sst-mfld-platform: ASoC: added media1_in in widget list pos 0
[   11.012268] sst-mfld-platform sst-mfld-platform: ASoC: added media0_out mix 0 in widget list pos 1
[   11.012285] sst-mfld-platform sst-mfld-platform: ASoC: added media0_out in widget list pos 2
[   11.012296] sst-mfld-platform sst-mfld-platform: ASoC: added pcm0_in in widget list pos 3
[   11.012306] sst-mfld-platform sst-mfld-platform: ASoC: added codec_out0 mix 0 in widget list pos 4
[   11.012316] sst-mfld-platform sst-mfld-platform: ASoC: added codec_out0 in widget list pos 5
[   11.012326] sst-mfld-platform sst-mfld-platform: ASoC: added ssp1 Tx in widget list pos 6
[   11.012338] rt5645 i2c-10EC5648:00: ASoC: added AIF1 Playback in widget list pos 7
[   11.012348] rt5645 i2c-10EC5648:00: ASoC: added AIF1RX in widget list pos 8
[   11.012358] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC3 in widget list pos 9
[   11.012368] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC2 R Mux in widget list pos 10
[   11.012379] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC2 in widget list pos 11
[   11.012389] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC2 L Mux in widget list pos 12
[   11.012399] rt5645 i2c-10EC5648:00: ASoC: added DAC L2 Mux in widget list pos 13
[   11.012408] rt5645 i2c-10EC5648:00: ASoC: added DAC L2 Volume in widget list pos 14
[   11.012420] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC1 in widget list pos 15
[   11.012430] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC1 R Mux in widget list pos 16
[   11.012440] rt5645 i2c-10EC5648:00: ASoC: added DAC1 R Mux in widget list pos 17
[   11.012449] rt5645 i2c-10EC5648:00: ASoC: added DAC1 MIXR in widget list pos 18
[   11.012459] rt5645 i2c-10EC5648:00: ASoC: added Stereo DAC MIXR in widget list pos 19
[   11.012469] rt5645 i2c-10EC5648:00: ASoC: added DAC R1 in widget list pos 20
[   11.012479] rt5645 i2c-10EC5648:00: ASoC: added SPOR MIX in widget list pos 21
[   11.012488] rt5645 i2c-10EC5648:00: ASoC: added SPK amp in widget list pos 22
[   11.012499] rt5645 i2c-10EC5648:00: ASoC: added SPOR in widget list pos 23
[   11.012510] bytx205_rt5645 bytx205_rt5645: ASoC: added Ext Spk in widget list pos 24
[   11.012520] rt5645 i2c-10EC5648:00: ASoC: added SPOL in widget list pos 25
[   11.012530] rt5645 i2c-10EC5648:00: ASoC: added DAC 1 in widget list pos 26
[   11.012540] rt5645 i2c-10EC5648:00: ASoC: added SPK MIXR in widget list pos 27
[   11.012550] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC0 in widget list pos 28
[   11.012560] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC1 L Mux in widget list pos 29
[   11.012570] rt5645 i2c-10EC5648:00: ASoC: added DAC1 L Mux in widget list pos 30
[   11.012580] rt5645 i2c-10EC5648:00: ASoC: added DAC1 MIXL in widget list pos 31
[   11.012591] rt5645 i2c-10EC5648:00: ASoC: added Stereo DAC MIXL in widget list pos 32
[   11.012600] rt5645 i2c-10EC5648:00: ASoC: added DAC L1 in widget list pos 33
[   11.012610] rt5645 i2c-10EC5648:00: ASoC: added SPOL MIX in widget list pos 34
[   11.012621] rt5645 i2c-10EC5648:00: ASoC: added SPK MIXL in widget list pos 35
[   11.012631]  Baytrail Audio Port: ASoC: found 8 audio playback paths
[   11.012642]  Baytrail Audio Port: connected new DPCM playback path Baytrail Audio Port -> SSP1-Codec
[   11.012662]  Baytrail Audio Port: ASoC: found 1 new BE paths
[   11.012672]  SSP1-Codec: ASoC: open playback BE SSP1-Codec
[   11.012685] sst-mfld-platform sst-mfld-platform: enable=1, usage=0
[   11.012695] intel_sst_acpi 80860F28:00: Enable: pm usage count: -1
[   11.012706] writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 55 00 00 00  ............U...
[   11.012725] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x8
[   11.012735] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   11.012743] intel_sst_acpi 80860F28:00: length is 8
[   11.012751] intel_sst_acpi 80860F28:00: Enter
[   11.012761] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   11.012772] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   11.012780] intel_sst_acpi 80860F28:00: sst: size = 0x8
[   11.012789] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:8
[   11.012798] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   11.872132] cfg80211: Calling CRDA to update world regulatory domain
[   12.012547] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   12.012575] intel_sst_acpi 80860F28:00: fw returned err -16
[   12.012592] intel_sst_acpi 80860F28:00: Enter
[   12.012604] pvt_id freed --> 1
[   12.012635]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[   12.012661] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[   12.013114]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   12.013138]  SSP1-Codec: ASoC: close BE Baytrail Audio Port
[   12.013160] sst-mfld-platform sst-mfld-platform: Enter: enable=0 port_name=ssp1-port
[   12.013177] sst-mfld-platform sst-mfld-platform: ssp_id: 3
[   12.013193] writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00  ............u...
[   12.013207] writing to lpe: 00000010: 03 00 00 00 18 09 0f ff 0f ff 03 00 01 01 01 00  ................
[   12.013219] writing to lpe: 00000020: 00 00                                            ..
[   12.013241] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x1a
[   12.013258] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   12.013273] intel_sst_acpi 80860F28:00: length is 26
[   12.013288] intel_sst_acpi 80860F28:00: Enter
[   12.013304] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   12.013323] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   12.013337] intel_sst_acpi 80860F28:00: sst: size = 0x1a
[   12.013358] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:26
[   12.013375] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   13.012429] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   13.012457] intel_sst_acpi 80860F28:00: fw returned err -16
[   13.012475] intel_sst_acpi 80860F28:00: Enter
[   13.012487] pvt_id freed --> 1
[   13.012510] sst-mfld-platform sst-mfld-platform: enable=0, usage=1
[   13.012527] writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 0e 00 00 00  ................
[   13.012549] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x8
[   13.012568] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   13.012582] intel_sst_acpi 80860F28:00: length is 8
[   13.012597] intel_sst_acpi 80860F28:00: Enter
[   13.012613] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   13.012631] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   13.012646] intel_sst_acpi 80860F28:00: sst: size = 0x8
[   13.012662] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:8
[   13.012679] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   14.011556] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   14.011583] intel_sst_acpi 80860F28:00: fw returned err -16
[   14.011601] intel_sst_acpi 80860F28:00: Enter
[   14.011613] pvt_id freed --> 1
[   14.011634] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[   14.011663]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[   14.011684] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[   14.011699] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[   14.011716] intel_sst_acpi 80860F28:00: Disable: pm usage count: 0
[   14.011734]  SSP1-Codec: ASoC: BE SSP1-Codec event 2 dir 0
[   14.012648]  Baytrail Audio Port: ASoC: BE playback disconnect check for SSP1-Codec
[   14.012671]  Baytrail Audio Port: freed DSP playback path Baytrail Audio Port -> SSP1-Codec
[   14.013351] sst-mfld-platform sst-mfld-platform: ASoC: added media1_in in widget list pos 0
[   14.013366] sst-mfld-platform sst-mfld-platform: ASoC: added media0_out mix 0 in widget list pos 1
[   14.013376] sst-mfld-platform sst-mfld-platform: ASoC: added media0_out in widget list pos 2
[   14.013387] sst-mfld-platform sst-mfld-platform: ASoC: added pcm0_in in widget list pos 3
[   14.013397] sst-mfld-platform sst-mfld-platform: ASoC: added codec_out0 mix 0 in widget list pos 4
[   14.013407] sst-mfld-platform sst-mfld-platform: ASoC: added codec_out0 in widget list pos 5
[   14.013417] sst-mfld-platform sst-mfld-platform: ASoC: added ssp1 Tx in widget list pos 6
[   14.013429] rt5645 i2c-10EC5648:00: ASoC: added AIF1 Playback in widget list pos 7
[   14.013438] rt5645 i2c-10EC5648:00: ASoC: added AIF1RX in widget list pos 8
[   14.013448] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC3 in widget list pos 9
[   14.013458] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC2 R Mux in widget list pos 10
[   14.013469] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC2 in widget list pos 11
[   14.013479] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC2 L Mux in widget list pos 12
[   14.013488] rt5645 i2c-10EC5648:00: ASoC: added DAC L2 Mux in widget list pos 13
[   14.013498] rt5645 i2c-10EC5648:00: ASoC: added DAC L2 Volume in widget list pos 14
[   14.013510] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC1 in widget list pos 15
[   14.013520] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC1 R Mux in widget list pos 16
[   14.013530] rt5645 i2c-10EC5648:00: ASoC: added DAC1 R Mux in widget list pos 17
[   14.013540] rt5645 i2c-10EC5648:00: ASoC: added DAC1 MIXR in widget list pos 18
[   14.013549] rt5645 i2c-10EC5648:00: ASoC: added Stereo DAC MIXR in widget list pos 19
[   14.013559] rt5645 i2c-10EC5648:00: ASoC: added DAC R1 in widget list pos 20
[   14.013569] rt5645 i2c-10EC5648:00: ASoC: added SPOR MIX in widget list pos 21
[   14.013579] rt5645 i2c-10EC5648:00: ASoC: added SPK amp in widget list pos 22
[   14.013589] rt5645 i2c-10EC5648:00: ASoC: added SPOR in widget list pos 23
[   14.013599] bytx205_rt5645 bytx205_rt5645: ASoC: added Ext Spk in widget list pos 24
[   14.013609] rt5645 i2c-10EC5648:00: ASoC: added SPOL in widget list pos 25
[   14.013619] rt5645 i2c-10EC5648:00: ASoC: added DAC 1 in widget list pos 26
[   14.013629] rt5645 i2c-10EC5648:00: ASoC: added SPK MIXR in widget list pos 27
[   14.013639] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC0 in widget list pos 28
[   14.013649] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC1 L Mux in widget list pos 29
[   14.013659] rt5645 i2c-10EC5648:00: ASoC: added DAC1 L Mux in widget list pos 30
[   14.013669] rt5645 i2c-10EC5648:00: ASoC: added DAC1 MIXL in widget list pos 31
[   14.013679] rt5645 i2c-10EC5648:00: ASoC: added Stereo DAC MIXL in widget list pos 32
[   14.013689] rt5645 i2c-10EC5648:00: ASoC: added DAC L1 in widget list pos 33
[   14.013698] rt5645 i2c-10EC5648:00: ASoC: added SPOL MIX in widget list pos 34
[   14.013709] rt5645 i2c-10EC5648:00: ASoC: added SPK MIXL in widget list pos 35
[   14.013719]  Baytrail Audio Port: ASoC: found 8 audio playback paths
[   14.013730]  Baytrail Audio Port: connected new DPCM playback path Baytrail Audio Port -> SSP1-Codec
[   14.013750]  Baytrail Audio Port: ASoC: found 1 new BE paths
[   14.013760]  SSP1-Codec: ASoC: open playback BE SSP1-Codec
[   14.013772] sst-mfld-platform sst-mfld-platform: enable=1, usage=0
[   14.013782] intel_sst_acpi 80860F28:00: Enable: pm usage count: -1
[   14.013793] writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 55 00 00 00  ............U...
[   14.013806] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x8
[   14.013816] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   14.013825] intel_sst_acpi 80860F28:00: length is 8
[   14.013834] intel_sst_acpi 80860F28:00: Enter
[   14.013844] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   14.013856] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   14.013865] intel_sst_acpi 80860F28:00: sst: size = 0x8
[   14.013875] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:8
[   14.013885] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   15.012097] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   15.012124] intel_sst_acpi 80860F28:00: fw returned err -16
[   15.012142] intel_sst_acpi 80860F28:00: Enter
[   15.012153] pvt_id freed --> 1
[   15.012184]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[   15.012210] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[   15.012645]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   15.012660]  SSP1-Codec: ASoC: close BE Baytrail Audio Port
[   15.012674] sst-mfld-platform sst-mfld-platform: Enter: enable=0 port_name=ssp1-port
[   15.012684] sst-mfld-platform sst-mfld-platform: ssp_id: 3
[   15.012695] writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00  ............u...
[   15.012703] writing to lpe: 00000010: 03 00 00 00 18 09 0f ff 0f ff 03 00 01 01 01 00  ................
[   15.012710] writing to lpe: 00000020: 00 00                                            ..
[   15.012724] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x1a
[   15.012734] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   15.012743] intel_sst_acpi 80860F28:00: length is 26
[   15.012752] intel_sst_acpi 80860F28:00: Enter
[   15.012762] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   15.012774] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   15.012783] intel_sst_acpi 80860F28:00: sst: size = 0x1a
[   15.012798] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:26
[   15.012808] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   15.017620] cfg80211: Calling CRDA to update world regulatory domain
[   16.011814] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   16.011841] intel_sst_acpi 80860F28:00: fw returned err -16
[   16.011859] intel_sst_acpi 80860F28:00: Enter
[   16.011871] pvt_id freed --> 1
[   16.011895] sst-mfld-platform sst-mfld-platform: enable=0, usage=1
[   16.011912] writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 0e 00 00 00  ................
[   16.011934] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x8
[   16.011952] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   16.011966] intel_sst_acpi 80860F28:00: length is 8
[   16.011980] intel_sst_acpi 80860F28:00: Enter
[   16.012003] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   16.012015] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   16.012023] intel_sst_acpi 80860F28:00: sst: size = 0x8
[   16.012034] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:8
[   16.012044] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   16.020347]  Baytrail Audio Port: ASoC: pop wq checking: Playback status: active waiting: yes
[   17.011553] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   17.011580] intel_sst_acpi 80860F28:00: fw returned err -16
[   17.011603] intel_sst_acpi 80860F28:00: Enter
[   17.011611] pvt_id freed --> 1
[   17.011624] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[   17.011653]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[   17.011667] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[   17.011677] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[   17.011687] intel_sst_acpi 80860F28:00: Disable: pm usage count: 0
[   17.011700]  SSP1-Codec: ASoC: BE SSP1-Codec event 2 dir 0
[   17.011794]  SSP1-Codec: ASoC: pop wq checking: AIF1 Playback status: inactive waiting: yes
[   17.012191]  Baytrail Audio Port: ASoC: BE playback disconnect check for SSP1-Codec
[   17.012207]  Baytrail Audio Port: freed DSP playback path Baytrail Audio Port -> SSP1-Codec
[   17.012870] sst-mfld-platform sst-mfld-platform: ASoC: added media1_in in widget list pos 0
[   17.012885] sst-mfld-platform sst-mfld-platform: ASoC: added media0_out mix 0 in widget list pos 1
[   17.012896] sst-mfld-platform sst-mfld-platform: ASoC: added media0_out in widget list pos 2
[   17.012907] sst-mfld-platform sst-mfld-platform: ASoC: added pcm0_in in widget list pos 3
[   17.012917] sst-mfld-platform sst-mfld-platform: ASoC: added codec_out0 mix 0 in widget list pos 4
[   17.012927] sst-mfld-platform sst-mfld-platform: ASoC: added codec_out0 in widget list pos 5
[   17.012937] sst-mfld-platform sst-mfld-platform: ASoC: added ssp1 Tx in widget list pos 6
[   17.012949] rt5645 i2c-10EC5648:00: ASoC: added AIF1 Playback in widget list pos 7
[   17.012959] rt5645 i2c-10EC5648:00: ASoC: added AIF1RX in widget list pos 8
[   17.012969] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC3 in widget list pos 9
[   17.012979] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC2 R Mux in widget list pos 10
[   17.012990] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC2 in widget list pos 11
[   17.012999] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC2 L Mux in widget list pos 12
[   17.013009] rt5645 i2c-10EC5648:00: ASoC: added DAC L2 Mux in widget list pos 13
[   17.013019] rt5645 i2c-10EC5648:00: ASoC: added DAC L2 Volume in widget list pos 14
[   17.013030] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC1 in widget list pos 15
[   17.013040] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC1 R Mux in widget list pos 16
[   17.013050] rt5645 i2c-10EC5648:00: ASoC: added DAC1 R Mux in widget list pos 17
[   17.013060] rt5645 i2c-10EC5648:00: ASoC: added DAC1 MIXR in widget list pos 18
[   17.013069] rt5645 i2c-10EC5648:00: ASoC: added Stereo DAC MIXR in widget list pos 19
[   17.013079] rt5645 i2c-10EC5648:00: ASoC: added DAC R1 in widget list pos 20
[   17.013089] rt5645 i2c-10EC5648:00: ASoC: added SPOR MIX in widget list pos 21
[   17.013099] rt5645 i2c-10EC5648:00: ASoC: added SPK amp in widget list pos 22
[   17.013109] rt5645 i2c-10EC5648:00: ASoC: added SPOR in widget list pos 23
[   17.013120] bytx205_rt5645 bytx205_rt5645: ASoC: added Ext Spk in widget list pos 24
[   17.013130] rt5645 i2c-10EC5648:00: ASoC: added SPOL in widget list pos 25
[   17.013140] rt5645 i2c-10EC5648:00: ASoC: added DAC 1 in widget list pos 26
[   17.013150] rt5645 i2c-10EC5648:00: ASoC: added SPK MIXR in widget list pos 27
[   17.013160] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC0 in widget list pos 28
[   17.013170] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC1 L Mux in widget list pos 29
[   17.013180] rt5645 i2c-10EC5648:00: ASoC: added DAC1 L Mux in widget list pos 30
[   17.013190] rt5645 i2c-10EC5648:00: ASoC: added DAC1 MIXL in widget list pos 31
[   17.013200] rt5645 i2c-10EC5648:00: ASoC: added Stereo DAC MIXL in widget list pos 32
[   17.013210] rt5645 i2c-10EC5648:00: ASoC: added DAC L1 in widget list pos 33
[   17.013220] rt5645 i2c-10EC5648:00: ASoC: added SPOL MIX in widget list pos 34
[   17.013230] rt5645 i2c-10EC5648:00: ASoC: added SPK MIXL in widget list pos 35
[   17.013240]  Baytrail Audio Port: ASoC: found 8 audio playback paths
[   17.013251]  Baytrail Audio Port: connected new DPCM playback path Baytrail Audio Port -> SSP1-Codec
[   17.013273]  Baytrail Audio Port: ASoC: found 1 new BE paths
[   17.013283]  SSP1-Codec: ASoC: open playback BE SSP1-Codec
[   17.013296] sst-mfld-platform sst-mfld-platform: enable=1, usage=0
[   17.013307] intel_sst_acpi 80860F28:00: Enable: pm usage count: -1
[   17.013319] writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 55 00 00 00  ............U...
[   17.013370] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x8
[   17.013382] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   17.013391] intel_sst_acpi 80860F28:00: length is 8
[   17.013400] intel_sst_acpi 80860F28:00: Enter
[   17.013411] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   17.013423] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   17.013431] intel_sst_acpi 80860F28:00: sst: size = 0x8
[   17.013441] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:8
[   17.013452] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   18.011437] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   18.011454] intel_sst_acpi 80860F28:00: fw returned err -16
[   18.011465] intel_sst_acpi 80860F28:00: Enter
[   18.011472] pvt_id freed --> 1
[   18.011493]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[   18.011509] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[   18.012649]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   18.012665]  SSP1-Codec: ASoC: close BE Baytrail Audio Port
[   18.012678] sst-mfld-platform sst-mfld-platform: Enter: enable=0 port_name=ssp1-port
[   18.012689] sst-mfld-platform sst-mfld-platform: ssp_id: 3
[   18.012699] writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00  ............u...
[   18.012708] writing to lpe: 00000010: 03 00 00 00 18 09 0f ff 0f ff 03 00 01 01 01 00  ................
[   18.012715] writing to lpe: 00000020: 00 00                                            ..
[   18.012729] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x1a
[   18.012739] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   18.012748] intel_sst_acpi 80860F28:00: length is 26
[   18.012757] intel_sst_acpi 80860F28:00: Enter
[   18.012767] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   18.012779] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   18.012788] intel_sst_acpi 80860F28:00: sst: size = 0x1a
[   18.012803] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:26
[   18.012813] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   18.163474] cfg80211: Calling CRDA to update world regulatory domain
[   19.011192] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   19.011209] intel_sst_acpi 80860F28:00: fw returned err -16
[   19.011220] intel_sst_acpi 80860F28:00: Enter
[   19.011227] pvt_id freed --> 1
[   19.011243] sst-mfld-platform sst-mfld-platform: enable=0, usage=1
[   19.011253] writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 0e 00 00 00  ................
[   19.011267] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x8
[   19.011278] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   19.011287] intel_sst_acpi 80860F28:00: length is 8
[   19.011296] intel_sst_acpi 80860F28:00: Enter
[   19.011306] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   19.011318] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   19.011326] intel_sst_acpi 80860F28:00: sst: size = 0x8
[   19.011336] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:8
[   19.011346] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   20.010914] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   20.010932] intel_sst_acpi 80860F28:00: fw returned err -16
[   20.010943] intel_sst_acpi 80860F28:00: Enter
[   20.010950] pvt_id freed --> 1
[   20.010963] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[   20.010983]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[   20.010996] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[   20.011005] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[   20.011015] intel_sst_acpi 80860F28:00: Disable: pm usage count: 0
[   20.011027]  SSP1-Codec: ASoC: BE SSP1-Codec event 2 dir 0
[   20.011609]  Baytrail Audio Port: ASoC: BE playback disconnect check for SSP1-Codec
[   20.011621]  Baytrail Audio Port: freed DSP playback path Baytrail Audio Port -> SSP1-Codec
[   20.012312] sst-mfld-platform sst-mfld-platform: ASoC: added media1_in in widget list pos 0
[   20.012325] sst-mfld-platform sst-mfld-platform: ASoC: added media0_out mix 0 in widget list pos 1
[   20.012335] sst-mfld-platform sst-mfld-platform: ASoC: added media0_out in widget list pos 2
[   20.012344] sst-mfld-platform sst-mfld-platform: ASoC: added pcm0_in in widget list pos 3
[   20.012354] sst-mfld-platform sst-mfld-platform: ASoC: added codec_out0 mix 0 in widget list pos 4
[   20.012363] sst-mfld-platform sst-mfld-platform: ASoC: added codec_out0 in widget list pos 5
[   20.012372] sst-mfld-platform sst-mfld-platform: ASoC: added ssp1 Tx in widget list pos 6
[   20.012382] rt5645 i2c-10EC5648:00: ASoC: added AIF1 Playback in widget list pos 7
[   20.012391] rt5645 i2c-10EC5648:00: ASoC: added AIF1RX in widget list pos 8
[   20.012400] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC3 in widget list pos 9
[   20.012409] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC2 R Mux in widget list pos 10
[   20.012419] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC2 in widget list pos 11
[   20.012464] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC2 L Mux in widget list pos 12
[   20.012474] rt5645 i2c-10EC5648:00: ASoC: added DAC L2 Mux in widget list pos 13
[   20.012483] rt5645 i2c-10EC5648:00: ASoC: added DAC L2 Volume in widget list pos 14
[   20.012494] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC1 in widget list pos 15
[   20.012504] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC1 R Mux in widget list pos 16
[   20.012512] rt5645 i2c-10EC5648:00: ASoC: added DAC1 R Mux in widget list pos 17
[   20.012521] rt5645 i2c-10EC5648:00: ASoC: added DAC1 MIXR in widget list pos 18
[   20.012530] rt5645 i2c-10EC5648:00: ASoC: added Stereo DAC MIXR in widget list pos 19
[   20.012539] rt5645 i2c-10EC5648:00: ASoC: added DAC R1 in widget list pos 20
[   20.012548] rt5645 i2c-10EC5648:00: ASoC: added SPOR MIX in widget list pos 21
[   20.012557] rt5645 i2c-10EC5648:00: ASoC: added SPK amp in widget list pos 22
[   20.012566] rt5645 i2c-10EC5648:00: ASoC: added SPOR in widget list pos 23
[   20.012576] bytx205_rt5645 bytx205_rt5645: ASoC: added Ext Spk in widget list pos 24
[   20.012585] rt5645 i2c-10EC5648:00: ASoC: added SPOL in widget list pos 25
[   20.012594] rt5645 i2c-10EC5648:00: ASoC: added DAC 1 in widget list pos 26
[   20.012603] rt5645 i2c-10EC5648:00: ASoC: added SPK MIXR in widget list pos 27
[   20.012612] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC0 in widget list pos 28
[   20.012622] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC1 L Mux in widget list pos 29
[   20.012630] rt5645 i2c-10EC5648:00: ASoC: added DAC1 L Mux in widget list pos 30
[   20.012640] rt5645 i2c-10EC5648:00: ASoC: added DAC1 MIXL in widget list pos 31
[   20.012649] rt5645 i2c-10EC5648:00: ASoC: added Stereo DAC MIXL in widget list pos 32
[   20.012658] rt5645 i2c-10EC5648:00: ASoC: added DAC L1 in widget list pos 33
[   20.012666] rt5645 i2c-10EC5648:00: ASoC: added SPOL MIX in widget list pos 34
[   20.012676] rt5645 i2c-10EC5648:00: ASoC: added SPK MIXL in widget list pos 35
[   20.012686]  Baytrail Audio Port: ASoC: found 8 audio playback paths
[   20.012696]  Baytrail Audio Port: connected new DPCM playback path Baytrail Audio Port -> SSP1-Codec
[   20.012715]  Baytrail Audio Port: ASoC: found 1 new BE paths
[   20.012724]  SSP1-Codec: ASoC: open playback BE SSP1-Codec
[   20.012736] sst-mfld-platform sst-mfld-platform: enable=1, usage=0
[   20.012746] intel_sst_acpi 80860F28:00: Enable: pm usage count: -1
[   20.012756] writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 55 00 00 00  ............U...
[   20.012767] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x8
[   20.012777] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   20.012785] intel_sst_acpi 80860F28:00: length is 8
[   20.012793] intel_sst_acpi 80860F28:00: Enter
[   20.012869] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   20.012880] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   20.012888] intel_sst_acpi 80860F28:00: sst: size = 0x8
[   20.012897] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:8
[   20.012907] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   21.017343] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   21.017361] intel_sst_acpi 80860F28:00: fw returned err -16
[   21.017372] intel_sst_acpi 80860F28:00: Enter
[   21.017379] pvt_id freed --> 1
[   21.017399]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[   21.017415] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[   21.017969]  SSP1-Codec: ASoC: hw_params BE Baytrail Audio Port
[   21.040904] rt5645 i2c-10EC5648:00: Sysclk is 24576000Hz and clock id is 1
[   21.047698] rt5645 i2c-10EC5648:00: bypass=0 m=10 n=490 k=2
[   21.059456] rt5645 i2c-10EC5648:00: bclk is 1536000Hz and lrck is 48000Hz
[   21.059481] rt5645 i2c-10EC5648:00: bclk_ms is 0 and pre_div is 1 for iis 0
[   21.066168] sst-mfld-platform sst-mfld-platform: Enter: enable=1 port_name=ssp1-port
[   21.066180] sst-mfld-platform sst-mfld-platform: ssp_id: 3
[   21.066188] writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00  ............u...
[   21.066193] writing to lpe: 00000010: 03 00 03 00 18 09 0f ff 0f ff 03 00 01 01 01 00  ................
[   21.066198] writing to lpe: 00000020: 00 00                                            ..
[   21.066208] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x1a
[   21.066215] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   21.066221] intel_sst_acpi 80860F28:00: length is 26
[   21.066227] intel_sst_acpi 80860F28:00: Enter
[   21.066233] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   21.066242] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   21.066254] intel_sst_acpi 80860F28:00: sst: size = 0x1a
[   21.066266] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:26
[   21.066273] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   21.312624] cfg80211: Calling CRDA to update world regulatory domain
[   22.020434]  Baytrail Audio Port: ASoC: pop wq checking: Playback status: active waiting: yes
[   22.066372] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   22.066399] intel_sst_acpi 80860F28:00: fw returned err -16
[   22.066416] intel_sst_acpi 80860F28:00: Enter
[   22.066428] pvt_id freed --> 1
[   22.066467]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[   22.066571]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[   22.066589]  SSP1-Codec: ASoC: prepare BE Baytrail Audio Port
[   22.141384] intel_sst_acpi 80860F28:00: Enter
[   22.141401] intel_sst_acpi 80860F28:00: alloc tstamp location = 0xff34484c
[   22.141411] intel_sst_acpi 80860F28:00: assigned pipe id 0x90 to task 3
[   22.141420] intel_sst_acpi 80860F28:00: Alloc for str 1 pipe 0x90
[   22.141437] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   22.141450] intel_sst_acpi 80860F28:00: Enter
[   22.141458] intel_sst_acpi 80860F28:00: pvt_id = 1, pipe id = 144, task = 3 ipc_msg: 1
[   22.141465] intel_sst_acpi 80860F28:00: header:b0001301
[   22.141472] intel_sst_acpi 80860F28:00: response rqd: 1
[   22.141479] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:108
[   22.141486] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   22.141495] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001301
[   22.141502] intel_sst_acpi 80860F28:00: sst: size = 0x6c
[   22.141551] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   22.141569]  SSP1-Codec: ASoC: pop wq checking: AIF1 Playback status: active waiting: no
[   23.139726] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   23.144358] intel_sst_acpi 80860F28:00: Enter
[   23.144368] pvt_id freed --> 1
[   23.144380] intel_sst_acpi 80860F28:00: FW alloc failed ret -16
[   23.148990] intel_sst_acpi 80860F28:00: sst_get_stream returned err -5
[   23.152743] sst-mfld-platform sst-mfld-platform: ASoC: cpu DAI prepare error: -5
[   23.155468]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port failed
[   23.158448]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   23.158459]  SSP1-Codec: ASoC: hw_free BE Baytrail Audio Port
[   23.158485]  SSP1-Codec: ASoC: hw_params BE Baytrail Audio Port
[   23.158498] rt5645 i2c-10EC5648:00: bclk is 1536000Hz and lrck is 48000Hz
[   23.158504] rt5645 i2c-10EC5648:00: bclk_ms is 0 and pre_div is 1 for iis 0
[   23.158515] sst-mfld-platform sst-mfld-platform: Enter: enable=1 port_name=ssp1-port
[   23.161302] sst-mfld-platform sst-mfld-platform: ssp_id: 3
[   23.161309] writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00  ............u...
[   23.161314] writing to lpe: 00000010: 03 00 03 00 18 09 0f ff 0f ff 03 00 01 01 01 00  ................
[   23.161319] writing to lpe: 00000020: 00 00                                            ..
[   23.161328] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x1a
[   23.161334] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   23.161340] intel_sst_acpi 80860F28:00: length is 26
[   23.161345] intel_sst_acpi 80860F28:00: Enter
[   23.161351] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   23.161359] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   23.161364] intel_sst_acpi 80860F28:00: sst: size = 0x1a
[   23.161374] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:26
[   23.161380] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   24.159421] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   24.164264] intel_sst_acpi 80860F28:00: fw returned err -16
[   24.167631] intel_sst_acpi 80860F28:00: Enter
[   24.167638] pvt_id freed --> 1
[   24.167651]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[   24.167917]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[   24.167927]  SSP1-Codec: ASoC: prepare BE Baytrail Audio Port
[   24.168151] sst-mfld-platform sst-mfld-platform: Enter: widget=codec_out0
[   24.168162] writing to lpe: 00000000: 01 02 01 01 00 00 1e 00 ff ff ff ff 82 00 16 00  ................
[   24.168167] writing to lpe: 00000010: 82 00 12 00 03 00 01 02 04 08 10 20 40 80 01 02  ........... @...
[   24.168172] writing to lpe: 00000020: 04 08 10 20 40 80                                ... @.
[   24.168181] intel_sst_acpi 80860F28:00: type:1 ipc_msg:2 block:1 task_id:1 pipe: 0x0 length:0x1e
[   24.168188] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   24.168194] intel_sst_acpi 80860F28:00: length is 30
[   24.168199] intel_sst_acpi 80860F28:00: Enter
[   24.168206] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   24.168215] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001102
[   24.168221] intel_sst_acpi 80860F28:00: sst: size = 0x1e
[   24.168234] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:30
[   24.168240] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 2 drv_id 1
[   24.461700] cfg80211: Calling CRDA to update world regulatory domain
[   25.169163] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   25.174018] intel_sst_acpi 80860F28:00: fw returned err -16
[   25.178719] intel_sst_acpi 80860F28:00: Enter
[   25.178728] pvt_id freed --> 1
[   25.178745] sst-mfld-platform sst-mfld-platform: Enter: widget=codec_out0
[   25.178755] sst-mfld-platform sst-mfld-platform: control name=codec_out0 Gain 0 Volume
[   25.178764] sst-mfld-platform sst-mfld-platform: Enter
[   25.178774] writing to lpe: 00000000: 01 02 01 01 00 00 14 00 ff ff ff ff 21 00 0c 00  ............!...
[   25.178782] writing to lpe: 00000010: 01 00 00 02 67 00 00 00 00 00 32 00              ....g.....2.
[   25.178796] intel_sst_acpi 80860F28:00: type:1 ipc_msg:2 block:1 task_id:1 pipe: 0x0 length:0x14
[   25.178807] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   25.178816] intel_sst_acpi 80860F28:00: length is 20
[   25.178824] intel_sst_acpi 80860F28:00: Enter
[   25.178834] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   25.178846] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001102
[   25.178855] intel_sst_acpi 80860F28:00: sst: size = 0x14
[   25.178867] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:20
[   25.178876] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 2 drv_id 1
[   26.178738] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   26.183563] intel_sst_acpi 80860F28:00: fw returned err -16
[   26.188236] intel_sst_acpi 80860F28:00: Enter
[   26.188246] pvt_id freed --> 1
[   26.188268] sst-mfld-platform sst-mfld-platform: widget = codec_out0 mix 0
[   26.188279] sst-mfld-platform sst-mfld-platform: val = 0x2000
[   26.188288] sst-mfld-platform sst-mfld-platform: reg: 0x2000
[   26.188298] sst-mfld-platform sst-mfld-platform: input id: 0x8dff, nb_inputs: 1
[   26.188309] writing to lpe: 00000000: 01 01 01 01 00 00 14 00 ff ff ff ff 72 00 0c 00  ............r...
[   26.188317] writing to lpe: 00000010: ff 02 ff ff 03 00 01 00 ff 8d ff ff              ............
[   26.188331] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x14
[   26.188342] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   26.188351] intel_sst_acpi 80860F28:00: length is 20
[   26.188359] intel_sst_acpi 80860F28:00: Enter
[   26.188369] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   26.188381] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   26.188389] intel_sst_acpi 80860F28:00: sst: size = 0x14
[   26.188401] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:20
[   26.188411] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   27.188476] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   27.193257] intel_sst_acpi 80860F28:00: fw returned err -16
[   27.197966] intel_sst_acpi 80860F28:00: Enter
[   27.197976] pvt_id freed --> 1
[   27.197994] sst-mfld-platform sst-mfld-platform: widget = media0_out mix 0
[   27.198005] sst-mfld-platform sst-mfld-platform: val = 0x40000
[   27.198014] sst-mfld-platform sst-mfld-platform: reg: 0x40000
[   27.198024] sst-mfld-platform sst-mfld-platform: input id: 0x90ff, nb_inputs: 1
[   27.198034] writing to lpe: 00000000: 01 01 01 03 00 00 14 00 ff ff ff ff 72 00 0c 00  ............r...
[   27.198043] writing to lpe: 00000010: ff 12 ff ff 03 00 01 00 ff 90 ff ff              ............
[   27.198057] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:3 pipe: 0x0 length:0x14
[   27.198068] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   27.198077] intel_sst_acpi 80860F28:00: length is 20
[   27.198086] intel_sst_acpi 80860F28:00: Enter
[   27.198096] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   27.198107] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001301
[   27.198116] intel_sst_acpi 80860F28:00: sst: size = 0x14
[   27.198128] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:20
[   27.198138] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   27.614097] cfg80211: Calling CRDA to update world regulatory domain
[   28.198211] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   28.203181] intel_sst_acpi 80860F28:00: fw returned err -16
[   28.208093] intel_sst_acpi 80860F28:00: Enter
[   28.208103] pvt_id freed --> 1
[   28.208124] sst-mfld-platform sst-mfld-platform: widget=media0_out
[   28.208134] sst-mfld-platform sst-mfld-platform: task=3, location=0x12ff
[   28.208144] writing to lpe: 00000000: 01 01 01 03 00 00 0a 00 ff 12 ff ff 77 00 02 00  ............w...
[   28.208152] writing to lpe: 00000010: 01 00                                            ..
[   28.208166] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:3 pipe: 0x0 length:0xa
[   28.208177] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   28.208186] intel_sst_acpi 80860F28:00: length is 10
[   28.208194] intel_sst_acpi 80860F28:00: Enter
[   28.208205] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   28.208217] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001301
[   28.208225] intel_sst_acpi 80860F28:00: sst: size = 0xa
[   28.208236] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:10
[   28.208246] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   29.207874] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   29.212885] intel_sst_acpi 80860F28:00: fw returned err -16
[   29.216828] intel_sst_acpi 80860F28:00: Enter
[   29.216834] pvt_id freed --> 1
[   29.216844] sst-mfld-platform sst-mfld-platform: Enter: widget=media0_out
[   29.216852] sst-mfld-platform sst-mfld-platform: widget=pcm0_in
[   29.216858] sst-mfld-platform sst-mfld-platform: task=1, location=0x8dff
[   29.216865] writing to lpe: 00000000: 01 01 01 01 00 00 0a 00 ff 8d ff ff 77 00 02 00  ............w...
[   29.216869] writing to lpe: 00000010: 01 00                                            ..
[   29.216878] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0xa
[   29.216885] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   29.216890] intel_sst_acpi 80860F28:00: length is 10
[   29.216895] intel_sst_acpi 80860F28:00: Enter
[   29.216901] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   29.216909] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   29.216914] intel_sst_acpi 80860F28:00: sst: size = 0xa
[   29.216921] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:10
[   29.216927] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   30.217770] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   30.222899] intel_sst_acpi 80860F28:00: fw returned err -16
[   30.226439] intel_sst_acpi 80860F28:00: Enter
[   30.226445] pvt_id freed --> 1
[   30.226456] sst-mfld-platform sst-mfld-platform: Enter: widget=pcm0_in
[   30.226463] sst-mfld-platform sst-mfld-platform: control name=pcm0_in Gain 0 Volume
[   30.226468] sst-mfld-platform sst-mfld-platform: Enter
[   30.226475] writing to lpe: 00000000: 01 02 01 01 00 00 14 00 ff ff ff ff 21 00 0c 00  ............!...
[   30.226480] writing to lpe: 00000010: 01 00 00 8d 67 00 00 00 00 00 32 00              ....g.....2.
[   30.226489] intel_sst_acpi 80860F28:00: type:1 ipc_msg:2 block:1 task_id:1 pipe: 0x0 length:0x14
[   30.226497] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   30.226502] intel_sst_acpi 80860F28:00: length is 20
[   30.226507] intel_sst_acpi 80860F28:00: Enter
[   30.226514] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   30.226522] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001102
[   30.226527] intel_sst_acpi 80860F28:00: sst: size = 0x14
[   30.226536] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:20
[   30.226542] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 2 drv_id 1
[   30.766485] cfg80211: Calling CRDA to update world regulatory domain
[   31.227296] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   31.232549] intel_sst_acpi 80860F28:00: fw returned err -16
[   31.237772] intel_sst_acpi 80860F28:00: Enter
[   31.237782] pvt_id freed --> 1
[   31.240064] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[   31.240090] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[   31.240102] sst-mfld-platform sst-mfld-platform: send gains for widget=media1_in
[   31.240116] sst-mfld-platform sst-mfld-platform: control name=media1_in Gain 0 Volume
[   31.240125] sst-mfld-platform sst-mfld-platform: Enter
[   31.240135] writing to lpe: 00000000: 01 02 01 03 00 00 14 00 ff ff ff ff 21 00 0c 00  ............!...
[   31.240143] writing to lpe: 00000010: 01 00 00 90 67 00 00 00 00 00 32 00              ....g.....2.
[   31.240159] intel_sst_acpi 80860F28:00: type:1 ipc_msg:2 block:1 task_id:3 pipe: 0x0 length:0x14
[   31.240171] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   31.240181] intel_sst_acpi 80860F28:00: length is 20
[   31.240192] intel_sst_acpi 80860F28:00: Enter
[   31.240203] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   31.240215] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001302
[   31.240223] intel_sst_acpi 80860F28:00: sst: size = 0x14
[   31.240235] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:20
[   31.240245] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 2 drv_id 1
[   32.241494] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   32.245879] intel_sst_acpi 80860F28:00: fw returned err -16
[   32.250007] intel_sst_acpi 80860F28:00: Enter
[   32.250014] pvt_id freed --> 1
[   32.250028]  SSP1-Codec: ASoC: BE SSP1-Codec event 1 dir 0
[   32.252630]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[   32.252783] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[   32.252790] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[   32.252796] sst-mfld-platform sst-mfld-platform: send gains for widget=media1_in
[   32.252802] sst-mfld-platform sst-mfld-platform: control name=media1_in Gain 0 Volume
[   32.252806] sst-mfld-platform sst-mfld-platform: Enter
[   32.252812] writing to lpe: 00000000: 01 02 01 03 00 00 14 00 ff ff ff ff 21 00 0c 00  ............!...
[   32.252816] writing to lpe: 00000010: 01 00 00 90 67 00 00 00 00 00 32 00              ....g.....2.
[   32.252824] intel_sst_acpi 80860F28:00: type:1 ipc_msg:2 block:1 task_id:3 pipe: 0x0 length:0x14
[   32.252830] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   32.252835] intel_sst_acpi 80860F28:00: length is 20
[   32.252839] intel_sst_acpi 80860F28:00: Enter
[   32.252845] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   32.252852] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001302
[   32.252857] intel_sst_acpi 80860F28:00: sst: size = 0x14
[   32.252864] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:20
[   32.252870] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 2 drv_id 1
[   33.256772] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   33.262332] intel_sst_acpi 80860F28:00: fw returned err -16
[   33.266189] intel_sst_acpi 80860F28:00: Enter
[   33.266195] pvt_id freed --> 1
[   33.266207]  SSP1-Codec: ASoC: BE SSP1-Codec event 1 dir 0
[   33.315261] sst-mfld-platform sst-mfld-platform: rx slot - slot 0 map = 0x1
[   33.315313] sst-mfld-platform sst-mfld-platform: rx slot - slot 1 map = 0x2
[   33.315384] sst-mfld-platform sst-mfld-platform: rx slot - slot 2 map = 0x4
[   33.315431] sst-mfld-platform sst-mfld-platform: rx slot - slot 3 map = 0x8
[   33.315683] sst-mfld-platform sst-mfld-platform: tx channel - codec_out0_0 map = 0x1
[   33.315723] sst-mfld-platform sst-mfld-platform: tx channel - codec_out0_1 map = 0x2
[   33.315762] sst-mfld-platform sst-mfld-platform: tx channel - codec_out1_0 map = 0x4
[   33.315810] sst-mfld-platform sst-mfld-platform: tx channel - codec_out1_1 map = 0x8
[   33.322117]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   33.322131]  SSP1-Codec: ASoC: hw_free BE Baytrail Audio Port
[   33.322184]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   33.322192]  SSP1-Codec: ASoC: hw_free BE Baytrail Audio Port
[   33.322200]  SSP1-Codec: ASoC: close BE Baytrail Audio Port
[   33.322211] sst-mfld-platform sst-mfld-platform: Enter: enable=0 port_name=ssp1-port
[   33.325794] sst-mfld-platform sst-mfld-platform: ssp_id: 3
[   33.325802] writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00  ............u...
[   33.325808] writing to lpe: 00000010: 03 00 00 00 18 09 0f ff 0f ff 03 00 01 01 01 00  ................
[   33.325812] writing to lpe: 00000020: 00 00                                            ..
[   33.325823] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x1a
[   33.325830] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   33.325836] intel_sst_acpi 80860F28:00: length is 26
[   33.325842] intel_sst_acpi 80860F28:00: Enter
[   33.325849] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   33.325857] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   33.325862] intel_sst_acpi 80860F28:00: sst: size = 0x1a
[   33.325873] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:26
[   33.325880] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   33.922211] cfg80211: Calling CRDA to update world regulatory domain
[   34.325418] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   34.331527] intel_sst_acpi 80860F28:00: fw returned err -16
[   34.337223] intel_sst_acpi 80860F28:00: Enter
[   34.337233] pvt_id freed --> 1
[   34.337249] sst-mfld-platform sst-mfld-platform: enable=0, usage=1
[   34.337259] writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 0e 00 00 00  ................
[   34.337273] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x8
[   34.337284] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   34.337293] intel_sst_acpi 80860F28:00: length is 8
[   34.337302] intel_sst_acpi 80860F28:00: Enter
[   34.337312] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   34.337324] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   34.337332] intel_sst_acpi 80860F28:00: sst: size = 0x8
[   34.337342] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:8
[   34.337352] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   35.335105] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   35.341348] intel_sst_acpi 80860F28:00: fw returned err -16
[   35.347135] intel_sst_acpi 80860F28:00: Enter
[   35.347144] pvt_id freed --> 1
[   35.347159] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[   35.347178]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[   35.347191] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[   35.347201] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[   35.347211] sst-mfld-platform sst-mfld-platform: send gains for widget=media1_in
[   35.347221] sst-mfld-platform sst-mfld-platform: control name=media1_in Gain 0 Volume
[   35.347229] sst-mfld-platform sst-mfld-platform: Enter
[   35.347239] writing to lpe: 00000000: 01 02 01 03 00 00 14 00 ff ff ff ff 21 00 0c 00  ............!...
[   35.347247] writing to lpe: 00000010: 01 00 00 90 67 00 60 fa 60 fa 32 00              ....g.`.`.2.
[   35.347261] intel_sst_acpi 80860F28:00: type:1 ipc_msg:2 block:1 task_id:3 pipe: 0x0 length:0x14
[   35.347272] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   35.347281] intel_sst_acpi 80860F28:00: length is 20
[   35.347290] intel_sst_acpi 80860F28:00: Enter
[   35.347300] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   35.347312] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001302
[   35.347321] intel_sst_acpi 80860F28:00: sst: size = 0x14
[   35.347333] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:20
[   35.347343] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 2 drv_id 1
[   36.344804] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   36.351239] intel_sst_acpi 80860F28:00: fw returned err -16
[   36.355554] intel_sst_acpi 80860F28:00: Enter
[   36.355561] pvt_id freed --> 1
[   36.355575] intel_sst_acpi 80860F28:00: Disable: pm usage count: 0
[   36.355583] intel_sst_acpi 80860F28:00: SST DBG:sst_free_stream for 1
[   36.355589] intel_sst_acpi 80860F28:00: free stream returned err -19
[   36.359490] intel_sst_acpi 80860F28:00: Exit
[   36.359505]  SSP1-Codec: ASoC: BE SSP1-Codec event 2 dir 0
[   36.379340] sst-mfld-platform sst-mfld-platform: widget=pcm0_in
[   36.379368] sst-mfld-platform sst-mfld-platform: task=1, location=0x8dff
[   36.379387] writing to lpe: 00000000: 01 01 01 01 00 00 0a 00 ff 8d ff ff 77 00 02 00  ............w...
[   36.379400] writing to lpe: 00000010: 00 00                                            ..
[   36.379424] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0xa
[   36.379443] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   36.379459] intel_sst_acpi 80860F28:00: length is 10
[   36.379473] intel_sst_acpi 80860F28:00: Enter
[   36.379490] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   36.379508] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   36.379522] intel_sst_acpi 80860F28:00: sst: size = 0xa
[   36.379540] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:10
[   36.379556] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   37.084574] cfg80211: Exceeded CRDA call max attempts. Not calling CRDA
[   37.381147] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   37.387505] intel_sst_acpi 80860F28:00: fw returned err -16
[   37.391801] intel_sst_acpi 80860F28:00: Enter
[   37.391808] pvt_id freed --> 1
[   37.391822] sst-mfld-platform sst-mfld-platform: widget=media0_out
[   37.391829] sst-mfld-platform sst-mfld-platform: task=3, location=0x12ff
[   37.391836] writing to lpe: 00000000: 01 01 01 03 00 00 0a 00 ff 12 ff ff 77 00 02 00  ............w...
[   37.391841] writing to lpe: 00000010: 00 00                                            ..
[   37.391850] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:3 pipe: 0x0 length:0xa
[   37.391859] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   37.391865] intel_sst_acpi 80860F28:00: length is 10
[   37.391871] intel_sst_acpi 80860F28:00: Enter
[   37.391878] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   37.391892] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001301
[   37.391897] intel_sst_acpi 80860F28:00: sst: size = 0xa
[   37.391905] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:10
[   37.391911] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   38.390842] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   38.397305] intel_sst_acpi 80860F28:00: fw returned err -16
[   38.403321] intel_sst_acpi 80860F28:00: Enter
[   38.403330] pvt_id freed --> 1
[   38.403353] sst-mfld-platform sst-mfld-platform: widget = codec_out0 mix 0
[   38.403365] sst-mfld-platform sst-mfld-platform: val = 0x2000
[   38.403374] sst-mfld-platform sst-mfld-platform: reg: 0x2000
[   38.403384] sst-mfld-platform sst-mfld-platform: input id: 0x8dff, nb_inputs: 1
[   38.403395] writing to lpe: 00000000: 01 01 01 01 00 00 14 00 ff ff ff ff 72 00 0c 00  ............r...
[   38.403403] writing to lpe: 00000010: ff 02 ff ff 00 00 01 00 ff 8d ff ff              ............
[   38.403416] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x14
[   38.403428] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   38.403437] intel_sst_acpi 80860F28:00: length is 20
[   38.403445] intel_sst_acpi 80860F28:00: Enter
[   38.403455] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   38.403467] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   38.403476] intel_sst_acpi 80860F28:00: sst: size = 0x14
[   38.403488] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:20
[   38.403497] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   39.384905] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   39.391397] intel_sst_acpi 80860F28:00: fw returned err -16
[   39.397311] intel_sst_acpi 80860F28:00: Enter
[   39.397320] pvt_id freed --> 1
[   39.397339] sst-mfld-platform sst-mfld-platform: widget = media0_out mix 0
[   39.397351] sst-mfld-platform sst-mfld-platform: val = 0x40000
[   39.397367] sst-mfld-platform sst-mfld-platform: reg: 0x40000
[   39.397377] sst-mfld-platform sst-mfld-platform: input id: 0x90ff, nb_inputs: 1
[   39.397388] writing to lpe: 00000000: 01 01 01 03 00 00 14 00 ff ff ff ff 72 00 0c 00  ............r...
[   39.397396] writing to lpe: 00000010: ff 12 ff ff 00 00 01 00 ff 90 ff ff              ............
[   39.397410] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:3 pipe: 0x0 length:0x14
[   39.397421] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   39.397430] intel_sst_acpi 80860F28:00: length is 20
[   39.397439] intel_sst_acpi 80860F28:00: Enter
[   39.397449] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   39.397461] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001301
[   39.397470] intel_sst_acpi 80860F28:00: sst: size = 0x14
[   39.397483] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:20
[   39.397493] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   40.309450]  SSP1-Codec: ASoC: pop wq checking: AIF1 Playback status: inactive waiting: yes
[   40.354104] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   40.360521] intel_sst_acpi 80860F28:00: fw returned err -16
[   40.364665] intel_sst_acpi 80860F28:00: Enter
[   40.364671] pvt_id freed --> 1
[   40.384096] sst-mfld-platform sst-mfld-platform: Enter: widget=codec_out0
[   40.428696]  Baytrail Audio Port: ASoC: BE playback disconnect check for SSP1-Codec
[   40.428709]  Baytrail Audio Port: freed DSP playback path Baytrail Audio Port -> SSP1-Codec
[   40.432420] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[   40.432433] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[   40.432442] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[   40.432451] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[   40.432458]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[   40.432464]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[   40.432470]  Baytrail Audio Port: ASoC: found 0 new BE paths
[   40.432477]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[   40.432491] intel_sst_acpi 80860F28:00: Enable: pm usage count: -1
[   40.432897]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[   40.432944]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[   40.432952]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[   40.437819]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   40.437859]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[   40.438110]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[   40.438119]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[   40.442607]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   40.442644]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[   40.442872]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[   40.442880]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[   40.446483]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   40.446527]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   40.446533]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[   40.446542] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[   40.446547] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[   40.446554] intel_sst_acpi 80860F28:00: Disable: pm usage count: 0
[   40.447135] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[   40.447145] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[   40.447154] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[   40.447159] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[   40.447164]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[   40.447168]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[   40.447172]  Baytrail Audio Port: ASoC: found 0 new BE paths
[   40.447177]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[   40.447186] intel_sst_acpi 80860F28:00: Enable: pm usage count: -1
[   40.447468]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[   40.447501]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[   40.447507]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[   40.450567]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   40.450590]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[   40.450780]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[   40.450785]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[   40.453683]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   40.453709]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[   40.453887]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[   40.453894]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[   40.456462]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   40.456505]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   40.456512]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[   40.456523] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[   40.456528] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[   40.456536] intel_sst_acpi 80860F28:00: Disable: pm usage count: 0
[   40.457075] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[   40.457084] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[   40.457090] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[   40.457094] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[   40.457099]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[   40.457103]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[   40.457107]  Baytrail Audio Port: ASoC: found 0 new BE paths
[   40.457111]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[   40.457119] intel_sst_acpi 80860F28:00: Enable: pm usage count: -1
[   40.457618]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[   40.457651]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[   40.457656]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[   40.460376]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   40.460416]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[   40.460603]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[   40.460609]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[   40.463171]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   40.463223]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[   40.463447]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[   40.463453]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[   40.465846]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   40.465889]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   40.465895]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[   40.465903] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[   40.465908] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[   40.465915] intel_sst_acpi 80860F28:00: Disable: pm usage count: 0
[   40.466974] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out in widget list pos 0
[   40.466982] sst-mfld-platform sst-mfld-platform: ASoC: added pcm2_out mix 0 in widget list pos 1
[   40.466987] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out in widget list pos 2
[   40.466992] sst-mfld-platform sst-mfld-platform: ASoC: added pcm1_out mix 0 in widget list pos 3
[   40.466996]  Baytrail Audio Port: ASoC: found 0 audio capture paths
[   40.467000]  Baytrail Audio Port: ASoC: Baytrail Audio Port no valid capture route
[   40.467004]  Baytrail Audio Port: ASoC: found 0 new BE paths
[   40.467008]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[   40.467015] intel_sst_acpi 80860F28:00: Enable: pm usage count: -1
[   40.467853]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[   40.467885]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[   40.467890]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[   40.470433]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   40.470473]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[   40.470698]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[   40.470705]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[   40.473128]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   40.473173]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[   40.473375]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[   40.473381]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port
[   40.475642]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   40.475687]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   40.475693]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[   40.475701] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=1
[   40.475706] sst-mfld-platform sst-mfld-platform: Stream name=Headset Capture
[   40.475713] intel_sst_acpi 80860F28:00: Disable: pm usage count: 0
[   40.487107] sst-mfld-platform sst-mfld-platform: ASoC: added media1_in in widget list pos 0
[   40.487126] sst-mfld-platform sst-mfld-platform: ASoC: added media0_out mix 0 in widget list pos 1
[   40.487137] sst-mfld-platform sst-mfld-platform: ASoC: added media0_out in widget list pos 2
[   40.487148] sst-mfld-platform sst-mfld-platform: ASoC: added pcm0_in in widget list pos 3
[   40.487158] sst-mfld-platform sst-mfld-platform: ASoC: added codec_out0 mix 0 in widget list pos 4
[   40.487169] sst-mfld-platform sst-mfld-platform: ASoC: added codec_out0 in widget list pos 5
[   40.487179] sst-mfld-platform sst-mfld-platform: ASoC: added ssp1 Tx in widget list pos 6
[   40.487191] rt5645 i2c-10EC5648:00: ASoC: added AIF1 Playback in widget list pos 7
[   40.487201] rt5645 i2c-10EC5648:00: ASoC: added AIF1RX in widget list pos 8
[   40.487211] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC3 in widget list pos 9
[   40.487221] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC2 R Mux in widget list pos 10
[   40.487232] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC2 in widget list pos 11
[   40.487242] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC2 L Mux in widget list pos 12
[   40.487251] rt5645 i2c-10EC5648:00: ASoC: added DAC L2 Mux in widget list pos 13
[   40.487261] rt5645 i2c-10EC5648:00: ASoC: added DAC L2 Volume in widget list pos 14
[   40.487274] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC1 in widget list pos 15
[   40.487284] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC1 R Mux in widget list pos 16
[   40.487294] rt5645 i2c-10EC5648:00: ASoC: added DAC1 R Mux in widget list pos 17
[   40.487304] rt5645 i2c-10EC5648:00: ASoC: added DAC1 MIXR in widget list pos 18
[   40.487314] rt5645 i2c-10EC5648:00: ASoC: added Stereo DAC MIXR in widget list pos 19
[   40.487324] rt5645 i2c-10EC5648:00: ASoC: added DAC R1 in widget list pos 20
[   40.487334] rt5645 i2c-10EC5648:00: ASoC: added SPOR MIX in widget list pos 21
[   40.487343] rt5645 i2c-10EC5648:00: ASoC: added SPK amp in widget list pos 22
[   40.487354] rt5645 i2c-10EC5648:00: ASoC: added SPOR in widget list pos 23
[   40.487365] bytx205_rt5645 bytx205_rt5645: ASoC: added Ext Spk in widget list pos 24
[   40.487375] rt5645 i2c-10EC5648:00: ASoC: added SPOL in widget list pos 25
[   40.487385] rt5645 i2c-10EC5648:00: ASoC: added DAC 1 in widget list pos 26
[   40.487395] rt5645 i2c-10EC5648:00: ASoC: added SPK MIXR in widget list pos 27
[   40.487405] rt5645 i2c-10EC5648:00: ASoC: added IF1 DAC0 in widget list pos 28
[   40.487415] rt5645 i2c-10EC5648:00: ASoC: added RT5645 IF1 DAC1 L Mux in widget list pos 29
[   40.487425] rt5645 i2c-10EC5648:00: ASoC: added DAC1 L Mux in widget list pos 30
[   40.487436] rt5645 i2c-10EC5648:00: ASoC: added DAC1 MIXL in widget list pos 31
[   40.487446] rt5645 i2c-10EC5648:00: ASoC: added Stereo DAC MIXL in widget list pos 32
[   40.487455] rt5645 i2c-10EC5648:00: ASoC: added DAC L1 in widget list pos 33
[   40.487465] rt5645 i2c-10EC5648:00: ASoC: added SPOL MIX in widget list pos 34
[   40.487476] rt5645 i2c-10EC5648:00: ASoC: added SPK MIXL in widget list pos 35
[   40.487487]  Baytrail Audio Port: ASoC: found 8 audio playback paths
[   40.487499]  Baytrail Audio Port: connected new DPCM playback path Baytrail Audio Port -> SSP1-Codec
[   40.487522]  Baytrail Audio Port: ASoC: found 1 new BE paths
[   40.487532]  SSP1-Codec: ASoC: open playback BE SSP1-Codec
[   40.487546] sst-mfld-platform sst-mfld-platform: enable=1, usage=0
[   40.487557] intel_sst_acpi 80860F28:00: Enable: pm usage count: -1
[   40.487568] writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 55 00 00 00  ............U...
[   40.487581] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x8
[   40.487593] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   40.487602] intel_sst_acpi 80860F28:00: length is 8
[   40.487610] intel_sst_acpi 80860F28:00: Enter
[   40.487621] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   40.487633] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   40.487641] intel_sst_acpi 80860F28:00: sst: size = 0x8
[   40.487651] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:8
[   40.487661] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   41.292883]  Baytrail Audio Port: ASoC: pop wq checking: Playback status: inactive waiting: yes
[   41.449259] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   41.453911] intel_sst_acpi 80860F28:00: fw returned err -16
[   41.458134] intel_sst_acpi 80860F28:00: Enter
[   41.458143] pvt_id freed --> 1
[   41.458164]  Baytrail Audio Port: ASoC: open FE Baytrail Audio Port
[   41.458179] intel_sst_acpi 80860F28:00: Enable: pm usage count: 0
[   41.458710]  SSP1-Codec: ASoC: hw_params BE Baytrail Audio Port
[   41.458730] rt5645 i2c-10EC5648:00: bclk is 1536000Hz and lrck is 48000Hz
[   41.458739] rt5645 i2c-10EC5648:00: bclk_ms is 0 and pre_div is 1 for iis 0
[   41.458754] sst-mfld-platform sst-mfld-platform: Enter: enable=1 port_name=ssp1-port
[   41.462314] sst-mfld-platform sst-mfld-platform: ssp_id: 3
[   41.462321] writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00  ............u...
[   41.462326] writing to lpe: 00000010: 03 00 03 00 18 09 0f ff 0f ff 03 00 01 01 01 00  ................
[   41.462331] writing to lpe: 00000020: 00 00                                            ..
[   41.462339] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x1a
[   41.462352] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   41.462357] intel_sst_acpi 80860F28:00: length is 26
[   41.462363] intel_sst_acpi 80860F28:00: Enter
[   41.462369] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   41.462376] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   41.462381] intel_sst_acpi 80860F28:00: sst: size = 0x1a
[   41.462393] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:26
[   41.462398] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   42.428292] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   42.433151] intel_sst_acpi 80860F28:00: fw returned err -16
[   42.437817] intel_sst_acpi 80860F28:00: Enter
[   42.437827] pvt_id freed --> 1
[   42.437844]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[   42.437943]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[   42.437954]  SSP1-Codec: ASoC: prepare BE Baytrail Audio Port
[   42.525568] intel_sst_acpi 80860F28:00: Enter
[   42.525595] intel_sst_acpi 80860F28:00: alloc tstamp location = 0xff34484c
[   42.525613] intel_sst_acpi 80860F28:00: assigned pipe id 0x90 to task 3
[   42.525629] intel_sst_acpi 80860F28:00: Alloc for str 1 pipe 0x90
[   42.530360] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   42.530374] intel_sst_acpi 80860F28:00: Enter
[   42.530393] intel_sst_acpi 80860F28:00: pvt_id = 1, pipe id = 144, task = 3 ipc_msg: 1
[   42.530403] intel_sst_acpi 80860F28:00: header:b0001301
[   42.530411] intel_sst_acpi 80860F28:00: response rqd: 1
[   42.530420] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:108
[   42.530429] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   42.530441] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001301
[   42.530449] intel_sst_acpi 80860F28:00: sst: size = 0x6c
[   42.530501] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   43.502831] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   43.507607] intel_sst_acpi 80860F28:00: Enter
[   43.507617] pvt_id freed --> 1
[   43.507629] intel_sst_acpi 80860F28:00: FW alloc failed ret -16
[   43.510921] intel_sst_acpi 80860F28:00: sst_get_stream returned err -5
[   43.513837] sst-mfld-platform sst-mfld-platform: ASoC: cpu DAI prepare error: -5
[   43.516770]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port failed
[   43.519613]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   43.519621]  SSP1-Codec: ASoC: hw_free BE Baytrail Audio Port
[   43.519643]  SSP1-Codec: ASoC: hw_params BE Baytrail Audio Port
[   43.519653] rt5645 i2c-10EC5648:00: bclk is 1536000Hz and lrck is 48000Hz
[   43.519658] rt5645 i2c-10EC5648:00: bclk_ms is 0 and pre_div is 1 for iis 0
[   43.519667] sst-mfld-platform sst-mfld-platform: Enter: enable=1 port_name=ssp1-port
[   43.521820] sst-mfld-platform sst-mfld-platform: ssp_id: 3
[   43.521827] writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00  ............u...
[   43.521831] writing to lpe: 00000010: 03 00 03 00 18 09 0f ff 0f ff 03 00 01 01 01 00  ................
[   43.521834] writing to lpe: 00000020: 00 00                                            ..
[   43.521841] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x1a
[   43.521846] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   43.521850] intel_sst_acpi 80860F28:00: length is 26
[   43.521854] intel_sst_acpi 80860F28:00: Enter
[   43.521859] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   43.521866] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   43.521870] intel_sst_acpi 80860F28:00: sst: size = 0x1a
[   43.521879] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:26
[   43.521884] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   44.497123] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   44.501894] intel_sst_acpi 80860F28:00: fw returned err -16
[   44.506521] intel_sst_acpi 80860F28:00: Enter
[   44.506530] pvt_id freed --> 1
[   44.506548]  Baytrail Audio Port: ASoC: hw_params FE Baytrail Audio Port rate 48000 chan 2 fmt 2
[   44.506844]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[   44.506856]  SSP1-Codec: ASoC: prepare BE Baytrail Audio Port
[   44.509768] sst-mfld-platform sst-mfld-platform: Enter: widget=codec_out0
[   44.509783] writing to lpe: 00000000: 01 02 01 01 00 00 1e 00 ff ff ff ff 82 00 16 00  ................
[   44.509792] writing to lpe: 00000010: 82 00 12 00 03 00 01 02 04 08 10 20 40 80 01 02  ........... @...
[   44.509800] writing to lpe: 00000020: 04 08 10 20 40 80                                ... @.
[   44.509819] intel_sst_acpi 80860F28:00: type:1 ipc_msg:2 block:1 task_id:1 pipe: 0x0 length:0x1e
[   44.509832] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   44.509838] intel_sst_acpi 80860F28:00: length is 30
[   44.509843] intel_sst_acpi 80860F28:00: Enter
[   44.509850] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   44.509857] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001102
[   44.509862] intel_sst_acpi 80860F28:00: sst: size = 0x1e
[   44.509875] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:30
[   44.509881] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 2 drv_id 1
[   45.488022] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   45.492795] intel_sst_acpi 80860F28:00: fw returned err -16
[   45.497489] intel_sst_acpi 80860F28:00: Enter
[   45.497498] pvt_id freed --> 1
[   45.497514] sst-mfld-platform sst-mfld-platform: Enter: widget=codec_out0
[   45.497524] sst-mfld-platform sst-mfld-platform: control name=codec_out0 Gain 0 Volume
[   45.497533] sst-mfld-platform sst-mfld-platform: Enter
[   45.497543] writing to lpe: 00000000: 01 02 01 01 00 00 14 00 ff ff ff ff 21 00 0c 00  ............!...
[   45.497551] writing to lpe: 00000010: 01 00 00 02 67 00 00 00 00 00 32 00              ....g.....2.
[   45.497565] intel_sst_acpi 80860F28:00: type:1 ipc_msg:2 block:1 task_id:1 pipe: 0x0 length:0x14
[   45.497576] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   45.497585] intel_sst_acpi 80860F28:00: length is 20
[   45.497593] intel_sst_acpi 80860F28:00: Enter
[   45.497604] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   45.497615] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001102
[   45.497624] intel_sst_acpi 80860F28:00: sst: size = 0x14
[   45.497636] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:20
[   45.497646] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 2 drv_id 1
[   46.478414] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   46.483210] intel_sst_acpi 80860F28:00: fw returned err -16
[   46.487868] intel_sst_acpi 80860F28:00: Enter
[   46.487877] pvt_id freed --> 1
[   46.487899] sst-mfld-platform sst-mfld-platform: widget = codec_out0 mix 0
[   46.487910] sst-mfld-platform sst-mfld-platform: val = 0x2000
[   46.487919] sst-mfld-platform sst-mfld-platform: reg: 0x2000
[   46.487929] sst-mfld-platform sst-mfld-platform: input id: 0x8dff, nb_inputs: 1
[   46.487940] writing to lpe: 00000000: 01 01 01 01 00 00 14 00 ff ff ff ff 72 00 0c 00  ............r...
[   46.487948] writing to lpe: 00000010: ff 02 ff ff 03 00 01 00 ff 8d ff ff              ............
[   46.487962] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x14
[   46.487973] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   46.487982] intel_sst_acpi 80860F28:00: length is 20
[   46.487991] intel_sst_acpi 80860F28:00: Enter
[   46.488001] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   46.488012] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   46.488021] intel_sst_acpi 80860F28:00: sst: size = 0x14
[   46.488033] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:20
[   46.488042] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   47.471158] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   47.475515] intel_sst_acpi 80860F28:00: fw returned err -16
[   47.479676] intel_sst_acpi 80860F28:00: Enter
[   47.479685] pvt_id freed --> 1
[   47.479702] sst-mfld-platform sst-mfld-platform: widget = media0_out mix 0
[   47.479713] sst-mfld-platform sst-mfld-platform: val = 0x40000
[   47.479721] sst-mfld-platform sst-mfld-platform: reg: 0x40000
[   47.479730] sst-mfld-platform sst-mfld-platform: input id: 0x90ff, nb_inputs: 1
[   47.479739] writing to lpe: 00000000: 01 01 01 03 00 00 14 00 ff ff ff ff 72 00 0c 00  ............r...
[   47.479748] writing to lpe: 00000010: ff 12 ff ff 03 00 01 00 ff 90 ff ff              ............
[   47.479760] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:3 pipe: 0x0 length:0x14
[   47.479770] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   47.479778] intel_sst_acpi 80860F28:00: length is 20
[   47.479786] intel_sst_acpi 80860F28:00: Enter
[   47.479795] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   47.479806] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001301
[   47.479814] intel_sst_acpi 80860F28:00: sst: size = 0x14
[   47.479825] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:20
[   47.479834] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   48.466031] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   48.470720] intel_sst_acpi 80860F28:00: fw returned err -16
[   48.473976] intel_sst_acpi 80860F28:00: Enter
[   48.473982] pvt_id freed --> 1
[   48.473996] sst-mfld-platform sst-mfld-platform: widget=media0_out
[   48.474002] sst-mfld-platform sst-mfld-platform: task=3, location=0x12ff
[   48.474010] writing to lpe: 00000000: 01 01 01 03 00 00 0a 00 ff 12 ff ff 77 00 02 00  ............w...
[   48.474014] writing to lpe: 00000010: 01 00                                            ..
[   48.474023] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:3 pipe: 0x0 length:0xa
[   48.474031] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   48.474036] intel_sst_acpi 80860F28:00: length is 10
[   48.474042] intel_sst_acpi 80860F28:00: Enter
[   48.474049] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   48.474057] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001301
[   48.474062] intel_sst_acpi 80860F28:00: sst: size = 0xa
[   48.474069] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:10
[   48.474080] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   49.459380] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   49.464125] intel_sst_acpi 80860F28:00: fw returned err -16
[   49.468681] intel_sst_acpi 80860F28:00: Enter
[   49.468691] pvt_id freed --> 1
[   49.468707] sst-mfld-platform sst-mfld-platform: Enter: widget=media0_out
[   49.468721] sst-mfld-platform sst-mfld-platform: widget=pcm0_in
[   49.468730] sst-mfld-platform sst-mfld-platform: task=1, location=0x8dff
[   49.468747] writing to lpe: 00000000: 01 01 01 01 00 00 0a 00 ff 8d ff ff 77 00 02 00  ............w...
[   49.468754] writing to lpe: 00000010: 01 00                                            ..
[   49.468765] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0xa
[   49.468775] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   49.468782] intel_sst_acpi 80860F28:00: length is 10
[   49.468789] intel_sst_acpi 80860F28:00: Enter
[   49.468798] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   49.468808] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   49.468815] intel_sst_acpi 80860F28:00: sst: size = 0xa
[   49.468824] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:10
[   49.468832] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   50.457826] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   50.462527] intel_sst_acpi 80860F28:00: fw returned err -16
[   50.467183] intel_sst_acpi 80860F28:00: Enter
[   50.467193] pvt_id freed --> 1
[   50.467208] sst-mfld-platform sst-mfld-platform: Enter: widget=pcm0_in
[   50.467219] sst-mfld-platform sst-mfld-platform: control name=pcm0_in Gain 0 Volume
[   50.467227] sst-mfld-platform sst-mfld-platform: Enter
[   50.467237] writing to lpe: 00000000: 01 02 01 01 00 00 14 00 ff ff ff ff 21 00 0c 00  ............!...
[   50.467245] writing to lpe: 00000010: 01 00 00 8d 67 00 00 00 00 00 32 00              ....g.....2.
[   50.467259] intel_sst_acpi 80860F28:00: type:1 ipc_msg:2 block:1 task_id:1 pipe: 0x0 length:0x14
[   50.467271] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   50.467280] intel_sst_acpi 80860F28:00: length is 20
[   50.467288] intel_sst_acpi 80860F28:00: Enter
[   50.467298] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   50.467310] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001102
[   50.467318] intel_sst_acpi 80860F28:00: sst: size = 0x14
[   50.467331] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:20
[   50.467340] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 2 drv_id 1
[   51.457553] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   51.462278] intel_sst_acpi 80860F28:00: fw returned err -16
[   51.466843] intel_sst_acpi 80860F28:00: Enter
[   51.466853] pvt_id freed --> 1
[   51.467004] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[   51.467029] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[   51.467047] sst-mfld-platform sst-mfld-platform: send gains for widget=media1_in
[   51.467063] sst-mfld-platform sst-mfld-platform: control name=media1_in Gain 0 Volume
[   51.467078] sst-mfld-platform sst-mfld-platform: Enter
[   51.467095] writing to lpe: 00000000: 01 02 01 03 00 00 14 00 ff ff ff ff 21 00 0c 00  ............!...
[   51.467108] writing to lpe: 00000010: 01 00 00 90 67 00 00 00 00 00 32 00              ....g.....2.
[   51.467132] intel_sst_acpi 80860F28:00: type:1 ipc_msg:2 block:1 task_id:3 pipe: 0x0 length:0x14
[   51.467151] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   51.467166] intel_sst_acpi 80860F28:00: length is 20
[   51.467181] intel_sst_acpi 80860F28:00: Enter
[   51.467198] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   51.467216] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001302
[   51.467230] intel_sst_acpi 80860F28:00: sst: size = 0x14
[   51.467250] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:20
[   51.467266] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 2 drv_id 1
[   52.458606] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   52.463286] intel_sst_acpi 80860F28:00: fw returned err -16
[   52.466532] intel_sst_acpi 80860F28:00: Enter
[   52.466538] pvt_id freed --> 1
[   52.466549]  SSP1-Codec: ASoC: BE SSP1-Codec event 1 dir 0
[   52.467348]  Baytrail Audio Port: ASoC: prepare FE Baytrail Audio Port
[   52.468824] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[   52.468839] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[   52.468847] sst-mfld-platform sst-mfld-platform: send gains for widget=media1_in
[   52.468855] sst-mfld-platform sst-mfld-platform: control name=media1_in Gain 0 Volume
[   52.468863] sst-mfld-platform sst-mfld-platform: Enter
[   52.468876] writing to lpe: 00000000: 01 02 01 03 00 00 14 00 ff ff ff ff 21 00 0c 00  ............!...
[   52.468883] writing to lpe: 00000010: 01 00 00 90 67 00 00 00 00 00 32 00              ....g.....2.
[   52.468900] intel_sst_acpi 80860F28:00: type:1 ipc_msg:2 block:1 task_id:3 pipe: 0x0 length:0x14
[   52.468907] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   52.468913] intel_sst_acpi 80860F28:00: length is 20
[   52.468918] intel_sst_acpi 80860F28:00: Enter
[   52.468925] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   52.468933] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001302
[   52.468938] intel_sst_acpi 80860F28:00: sst: size = 0x14
[   52.468949] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:20
[   52.468955] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 2 drv_id 1
[   53.460691] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   53.465508] intel_sst_acpi 80860F28:00: fw returned err -16
[   53.468757] intel_sst_acpi 80860F28:00: Enter
[   53.468763] pvt_id freed --> 1
[   53.468775]  SSP1-Codec: ASoC: BE SSP1-Codec event 1 dir 0
[   53.502532] sst-mfld-platform sst-mfld-platform: rx slot - slot 0 map = 0x1
[   53.502586] sst-mfld-platform sst-mfld-platform: rx slot - slot 1 map = 0x2
[   53.502637] sst-mfld-platform sst-mfld-platform: rx slot - slot 2 map = 0x4
[   53.502686] sst-mfld-platform sst-mfld-platform: rx slot - slot 3 map = 0x8
[   53.502958] sst-mfld-platform sst-mfld-platform: tx channel - codec_out0_0 map = 0x1
[   53.503008] sst-mfld-platform sst-mfld-platform: tx channel - codec_out0_1 map = 0x2
[   53.503057] sst-mfld-platform sst-mfld-platform: tx channel - codec_out1_0 map = 0x4
[   53.503106] sst-mfld-platform sst-mfld-platform: tx channel - codec_out1_1 map = 0x8
[   53.538060]  Baytrail Audio Port: ASoC: pre trigger FE Baytrail Audio Port cmd 1
[   53.538074]  Baytrail Audio Port: sst_platform_pcm_trigger called
[   53.538080]  Baytrail Audio Port: sst: Trigger Start
[   53.538090]  SSP1-Codec: ASoC: trigger BE Baytrail Audio Port cmd 1
[   53.538096]  SSP1-Codec: sst_platform_pcm_trigger called
[   53.538117]  Baytrail Audio Port: sst: error code = -22
[   53.541909] bytx205_rt5645 bytx205_rt5645: BUG: pcmC0D0p:0, pos = -22, buffer size = 203830, period size = 1199
[   53.545882]  Baytrail Audio Port: sst: error code = -22
[   53.549197] bytx205_rt5645 bytx205_rt5645: BUG: pcmC0D0p:0, pos = -22, buffer size = 203830, period size = 1199
[   53.551953]  Baytrail Audio Port: sst: error code = -22
[   53.554218] bytx205_rt5645 bytx205_rt5645: BUG: pcmC0D0p:0, pos = -22, buffer size = 203830, period size = 1199
[   58.544436]  Baytrail Audio Port: sst: error code = -22
[   58.549708] bytx205_rt5645 bytx205_rt5645: BUG: pcmC0D0p:0, pos = -22, buffer size = 203830, period size = 1199
[   58.555281]  Baytrail Audio Port: ASoC: pre trigger FE Baytrail Audio Port cmd 0
[   58.555292]  Baytrail Audio Port: sst_platform_pcm_trigger called
[   58.555299]  Baytrail Audio Port: sst: in stop
[   58.555309]  SSP1-Codec: ASoC: trigger BE Baytrail Audio Port cmd 0
[   58.555316]  SSP1-Codec: sst_platform_pcm_trigger called
[   58.555484]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   58.555496]  SSP1-Codec: ASoC: hw_free BE Baytrail Audio Port
[   58.555547]  Baytrail Audio Port: ASoC: hw_free FE Baytrail Audio Port
[   58.555557]  SSP1-Codec: ASoC: hw_free BE Baytrail Audio Port
[   58.555567]  SSP1-Codec: ASoC: close BE Baytrail Audio Port
[   58.555579] sst-mfld-platform sst-mfld-platform: Enter: enable=0 port_name=ssp1-port
[   58.559339] sst-mfld-platform sst-mfld-platform: ssp_id: 3
[   58.559347] writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00  ............u...
[   58.559352] writing to lpe: 00000010: 03 00 00 00 18 09 0f ff 0f ff 03 00 01 01 01 00  ................
[   58.559356] writing to lpe: 00000020: 00 00                                            ..
[   58.559366] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x1a
[   58.559373] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   58.559378] intel_sst_acpi 80860F28:00: length is 26
[   58.559383] intel_sst_acpi 80860F28:00: Enter
[   58.559389] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   58.559397] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   58.559402] intel_sst_acpi 80860F28:00: sst: size = 0x1a
[   58.559413] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:26
[   58.559420] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   59.556431] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   59.562299] intel_sst_acpi 80860F28:00: fw returned err -16
[   59.566898] intel_sst_acpi 80860F28:00: Enter
[   59.566904] pvt_id freed --> 1
[   59.566914] sst-mfld-platform sst-mfld-platform: enable=0, usage=1
[   59.566921] writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 0e 00 00 00  ................
[   59.566929] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x8
[   59.566936] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   59.566941] intel_sst_acpi 80860F28:00: length is 8
[   59.566946] intel_sst_acpi 80860F28:00: Enter
[   59.566952] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   59.566960] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   59.566966] intel_sst_acpi 80860F28:00: sst: size = 0x8
[   59.566972] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:8
[   59.566979] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   60.572830] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   60.578889] intel_sst_acpi 80860F28:00: fw returned err -16
[   60.583484] intel_sst_acpi 80860F28:00: Enter
[   60.583490] pvt_id freed --> 1
[   60.583499] intel_sst_acpi 80860F28:00: Disable: pm usage count: 1
[   60.583513]  Baytrail Audio Port: ASoC: close FE Baytrail Audio Port
[   60.583521] sst-mfld-platform sst-mfld-platform: enter, dai-name=media-cpu-dai dir=0
[   60.583527] sst-mfld-platform sst-mfld-platform: Stream name=Headset Playback
[   60.583533] sst-mfld-platform sst-mfld-platform: send gains for widget=media1_in
[   60.583539] sst-mfld-platform sst-mfld-platform: control name=media1_in Gain 0 Volume
[   60.583544] sst-mfld-platform sst-mfld-platform: Enter
[   60.583551] writing to lpe: 00000000: 01 02 01 03 00 00 14 00 ff ff ff ff 21 00 0c 00  ............!...
[   60.583556] writing to lpe: 00000010: 01 00 00 90 67 00 60 fa 60 fa 32 00              ....g.`.`.2.
[   60.583565] intel_sst_acpi 80860F28:00: type:1 ipc_msg:2 block:1 task_id:3 pipe: 0x0 length:0x14
[   60.583576] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   60.583581] intel_sst_acpi 80860F28:00: length is 20
[   60.583586] intel_sst_acpi 80860F28:00: Enter
[   60.583592] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   60.583600] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001302
[   60.583606] intel_sst_acpi 80860F28:00: sst: size = 0x14
[   60.583614] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:20
[   60.583620] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 2 drv_id 1
[   61.583487] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   61.589215] intel_sst_acpi 80860F28:00: fw returned err -16
[   61.594911] intel_sst_acpi 80860F28:00: Enter
[   61.594920] pvt_id freed --> 1
[   61.594937] intel_sst_acpi 80860F28:00: Disable: pm usage count: 0
[   61.594947] intel_sst_acpi 80860F28:00: SST DBG:sst_free_stream for 1
[   61.594955] intel_sst_acpi 80860F28:00: free stream returned err -19
[   61.599414] intel_sst_acpi 80860F28:00: Exit
[   61.599426]  SSP1-Codec: ASoC: BE SSP1-Codec event 2 dir 0
[   61.624110] sst-mfld-platform sst-mfld-platform: widget=pcm0_in
[   61.624123] sst-mfld-platform sst-mfld-platform: task=1, location=0x8dff
[   61.624131] writing to lpe: 00000000: 01 01 01 01 00 00 0a 00 ff 8d ff ff 77 00 02 00  ............w...
[   61.624135] writing to lpe: 00000010: 00 00                                            ..
[   61.624145] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0xa
[   61.624153] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   61.624159] intel_sst_acpi 80860F28:00: length is 10
[   61.624165] intel_sst_acpi 80860F28:00: Enter
[   61.624172] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   61.624180] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   61.624185] intel_sst_acpi 80860F28:00: sst: size = 0xa
[   61.624193] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:10
[   61.624199] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   62.620641] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   62.626388] intel_sst_acpi 80860F28:00: fw returned err -16
[   62.630840] intel_sst_acpi 80860F28:00: Enter
[   62.630845] pvt_id freed --> 1
[   62.630858] sst-mfld-platform sst-mfld-platform: widget=media0_out
[   62.630864] sst-mfld-platform sst-mfld-platform: task=3, location=0x12ff
[   62.630870] writing to lpe: 00000000: 01 01 01 03 00 00 0a 00 ff 12 ff ff 77 00 02 00  ............w...
[   62.630875] writing to lpe: 00000010: 00 00                                            ..
[   62.630883] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:3 pipe: 0x0 length:0xa
[   62.630890] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   62.630896] intel_sst_acpi 80860F28:00: length is 10
[   62.630901] intel_sst_acpi 80860F28:00: Enter
[   62.630908] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   62.630915] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001301
[   62.630920] intel_sst_acpi 80860F28:00: sst: size = 0xa
[   62.630927] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:10
[   62.630933] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   63.631861] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   63.637537] intel_sst_acpi 80860F28:00: fw returned err -16
[   63.641688] intel_sst_acpi 80860F28:00: Enter
[   63.641693] pvt_id freed --> 1
[   63.641709] sst-mfld-platform sst-mfld-platform: widget = codec_out0 mix 0
[   63.641717] sst-mfld-platform sst-mfld-platform: val = 0x2000
[   63.641723] sst-mfld-platform sst-mfld-platform: reg: 0x2000
[   63.641728] sst-mfld-platform sst-mfld-platform: input id: 0x8dff, nb_inputs: 1
[   63.641735] writing to lpe: 00000000: 01 01 01 01 00 00 14 00 ff ff ff ff 72 00 0c 00  ............r...
[   63.641740] writing to lpe: 00000010: ff 02 ff ff 00 00 01 00 ff 8d ff ff              ............
[   63.641748] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:1 pipe: 0x0 length:0x14
[   63.641755] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   63.641761] intel_sst_acpi 80860F28:00: length is 20
[   63.641766] intel_sst_acpi 80860F28:00: Enter
[   63.641772] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   63.641780] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001101
[   63.641785] intel_sst_acpi 80860F28:00: sst: size = 0x14
[   63.641793] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:20
[   63.641799] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   64.640208] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   64.645888] intel_sst_acpi 80860F28:00: fw returned err -16
[   64.650337] intel_sst_acpi 80860F28:00: Enter
[   64.650343] pvt_id freed --> 1
[   64.650355] sst-mfld-platform sst-mfld-platform: widget = media0_out mix 0
[   64.650362] sst-mfld-platform sst-mfld-platform: val = 0x40000
[   64.650367] sst-mfld-platform sst-mfld-platform: reg: 0x40000
[   64.650373] sst-mfld-platform sst-mfld-platform: input id: 0x90ff, nb_inputs: 1
[   64.650380] writing to lpe: 00000000: 01 01 01 03 00 00 14 00 ff ff ff ff 72 00 0c 00  ............r...
[   64.650384] writing to lpe: 00000010: ff 12 ff ff 00 00 01 00 ff 90 ff ff              ............
[   64.650393] intel_sst_acpi 80860F28:00: type:1 ipc_msg:1 block:1 task_id:3 pipe: 0x0 length:0x14
[   64.650400] intel_sst_acpi 80860F28:00: pvt_id assigned --> 1
[   64.650406] intel_sst_acpi 80860F28:00: length is 20
[   64.650411] intel_sst_acpi 80860F28:00: Enter
[   64.650417] intel_sst_acpi 80860F28:00: Enter: sync: 0
[   64.650430] intel_sst_acpi 80860F28:00: sst: Post message: header = b0001301
[   64.650435] intel_sst_acpi 80860F28:00: sst: size = 0x14
[   64.650443] intel_sst_acpi 80860F28:00: msg->mrfld_header.p.header_low_payload:20
[   64.650449] intel_sst_acpi 80860F28:00: waiting for condition 0 ipc 1 drv_id 1
[   65.591364]  SSP1-Codec: ASoC: pop wq checking: AIF1 Playback status: inactive waiting: yes
[   65.652730] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   65.657306] intel_sst_acpi 80860F28:00: fw returned err -16
[   65.660983] intel_sst_acpi 80860F28:00: Enter
[   65.660988] pvt_id freed --> 1
[   65.685591] sst-mfld-platform sst-mfld-platform: Enter: widget=codec_out0
[   65.747449]  Baytrail Audio Port: ASoC: BE playback disconnect check for SSP1-Codec
[   65.747466]  Baytrail Audio Port: freed DSP playback path Baytrail Audio Port -> SSP1-Codec
[   66.603113]  Baytrail Audio Port: ASoC: pop wq checking: Playback status: inactive waiting: yes
[   68.160869] intel_sst_acpi 80860F28:00: LPE is already in RESET state, No action


Sound card controls are: 

[zio@asus ~]$ amixer -c0 controls
numid=132,iface=MIXER,name='Headphone Channel Switch'
numid=150,iface=MIXER,name='Headphone Switch'
numid=133,iface=MIXER,name='Headphone Playback Volume'
numid=145,iface=MIXER,name='Mono ADC Capture Switch'
numid=146,iface=MIXER,name='Mono ADC Capture Volume'
numid=170,iface=MIXER,name='Mono ADC L1 Mux'
numid=169,iface=MIXER,name='Mono ADC L2 Mux'
numid=177,iface=MIXER,name='Mono ADC MIXL ADC1 Switch'
numid=178,iface=MIXER,name='Mono ADC MIXL ADC2 Switch'
numid=179,iface=MIXER,name='Mono ADC MIXR ADC1 Switch'
numid=180,iface=MIXER,name='Mono ADC MIXR ADC2 Switch'
numid=171,iface=MIXER,name='Mono ADC R1 Mux'
numid=172,iface=MIXER,name='Mono ADC R2 Mux'
numid=205,iface=MIXER,name='Mono DAC MIXL DAC L1 Switch'
numid=206,iface=MIXER,name='Mono DAC MIXL DAC L2 Switch'
numid=207,iface=MIXER,name='Mono DAC MIXL DAC R2 Switch'
numid=210,iface=MIXER,name='Mono DAC MIXR DAC L2 Switch'
numid=208,iface=MIXER,name='Mono DAC MIXR DAC R1 Switch'
numid=209,iface=MIXER,name='Mono DAC MIXR DAC R2 Switch'
numid=139,iface=MIXER,name='Mono DAC Playback Volume'
numid=167,iface=MIXER,name='Mono DMIC L Mux'
numid=168,iface=MIXER,name='Mono DMIC R Mux'
numid=143,iface=MIXER,name='ADC Capture Switch'
numid=144,iface=MIXER,name='ADC Capture Volume'
numid=149,iface=MIXER,name='I2S2 Func Switch'
numid=195,iface=MIXER,name='DAC L2 Mux'
numid=212,iface=MIXER,name='DAC MIXL DAC L2 Switch'
numid=213,iface=MIXER,name='DAC MIXL DAC R2 Switch'
numid=211,iface=MIXER,name='DAC MIXL Sto DAC Mix L Switch'
numid=216,iface=MIXER,name='DAC MIXR DAC L2 Switch'
numid=215,iface=MIXER,name='DAC MIXR DAC R2 Switch'
numid=214,iface=MIXER,name='DAC MIXR Sto DAC Mix R Switch'
numid=196,iface=MIXER,name='DAC R2 Mux'
numid=197,iface=MIXER,name='DAC1 L Mux'
numid=192,iface=MIXER,name='DAC1 MIXL DAC1 Switch'
numid=191,iface=MIXER,name='DAC1 MIXL Stereo ADC Switch'
numid=194,iface=MIXER,name='DAC1 MIXR DAC1 Switch'
numid=193,iface=MIXER,name='DAC1 MIXR Stereo ADC Switch'
numid=138,iface=MIXER,name='DAC1 Playback Volume'
numid=198,iface=MIXER,name='DAC1 R Mux'
numid=137,iface=MIXER,name='DAC2 Playback Switch'
numid=153,iface=MIXER,name='Ext Spk Switch'
numid=251,iface=MIXER,name='HPO MIX DAC1 Switch'
numid=252,iface=MIXER,name='HPO MIX HPVOL Switch'
numid=243,iface=MIXER,name='HPOVOL L Switch'
numid=238,iface=MIXER,name='HPOVOL MIXL BST1 Switch'
numid=235,iface=MIXER,name='HPOVOL MIXL DAC1 Switch'
numid=236,iface=MIXER,name='HPOVOL MIXL DAC2 Switch'
numid=237,iface=MIXER,name='HPOVOL MIXL INL Switch'
numid=242,iface=MIXER,name='HPOVOL MIXR BST2 Switch'
numid=239,iface=MIXER,name='HPOVOL MIXR DAC1 Switch'
numid=240,iface=MIXER,name='HPOVOL MIXR DAC2 Switch'
numid=241,iface=MIXER,name='HPOVOL MIXR INR Switch'
numid=244,iface=MIXER,name='HPOVOL R Switch'
numid=151,iface=MIXER,name='Headset Mic Switch'
numid=185,iface=MIXER,name='IF2 ADC Mux'
numid=142,iface=MIXER,name='IN Capture Volume'
numid=140,iface=MIXER,name='IN1 Boost'
numid=141,iface=MIXER,name='IN2 Boost'
numid=152,iface=MIXER,name='Int Mic Switch'
numid=253,iface=MIXER,name='LOUT MIX DAC L1 Switch'
numid=254,iface=MIXER,name='LOUT MIX DAC R1 Switch'
numid=255,iface=MIXER,name='LOUT MIX OUTMIX L Switch'
numid=256,iface=MIXER,name='LOUT MIX OUTMIX R Switch'
numid=135,iface=MIXER,name='OUT Channel Switch'
numid=225,iface=MIXER,name='OUT MIXL BST1 Switch'
numid=228,iface=MIXER,name='OUT MIXL DAC L1 Switch'
numid=227,iface=MIXER,name='OUT MIXL DAC L2 Switch'
numid=226,iface=MIXER,name='OUT MIXL INL Switch'
numid=229,iface=MIXER,name='OUT MIXR BST2 Switch'
numid=232,iface=MIXER,name='OUT MIXR DAC R1 Switch'
numid=231,iface=MIXER,name='OUT MIXR DAC R2 Switch'
numid=230,iface=MIXER,name='OUT MIXR INR Switch'
numid=134,iface=MIXER,name='OUT Playback Switch'
numid=136,iface=MIXER,name='OUT Playback Volume'
numid=257,iface=MIXER,name='PDM1 L Mux'
numid=259,iface=MIXER,name='PDM1 L Switch'
numid=258,iface=MIXER,name='PDM1 R Mux'
numid=260,iface=MIXER,name='PDM1 R Switch'
numid=157,iface=MIXER,name='RECMIXL BST1 Switch'
numid=156,iface=MIXER,name='RECMIXL BST2 Switch'
numid=154,iface=MIXER,name='RECMIXL HPOL Switch'
numid=155,iface=MIXER,name='RECMIXL INL Switch'
numid=158,iface=MIXER,name='RECMIXL OUT MIXL Switch'
numid=162,iface=MIXER,name='RECMIXR BST1 Switch'
numid=161,iface=MIXER,name='RECMIXR BST2 Switch'
numid=159,iface=MIXER,name='RECMIXR HPOR Switch'
numid=160,iface=MIXER,name='RECMIXR INR Switch'
numid=163,iface=MIXER,name='RECMIXR OUT MIXR Switch'
numid=184,iface=MIXER,name='RT5645 IF1 ADC Mux'
numid=181,iface=MIXER,name='RT5645 IF1 ADC1 Swap Mux'
numid=182,iface=MIXER,name='RT5645 IF1 ADC2 Swap Mux'
numid=183,iface=MIXER,name='RT5645 IF1 ADC3 Swap Mux'
numid=186,iface=MIXER,name='RT5645 IF1 DAC1 L Mux'
numid=187,iface=MIXER,name='RT5645 IF1 DAC1 R Mux'
numid=188,iface=MIXER,name='RT5645 IF1 DAC2 L Mux'
numid=189,iface=MIXER,name='RT5645 IF1 DAC2 R Mux'
numid=220,iface=MIXER,name='SPK MIXL BST1 Switch'
numid=217,iface=MIXER,name='SPK MIXL DAC L1 Switch'
numid=218,iface=MIXER,name='SPK MIXL DAC L2 Switch'
numid=219,iface=MIXER,name='SPK MIXL INL Switch'
numid=224,iface=MIXER,name='SPK MIXR BST2 Switch'
numid=221,iface=MIXER,name='SPK MIXR DAC R1 Switch'
numid=222,iface=MIXER,name='SPK MIXR DAC R2 Switch'
numid=223,iface=MIXER,name='SPK MIXR INR Switch'
numid=233,iface=MIXER,name='SPKVOL L Switch'
numid=234,iface=MIXER,name='SPKVOL R Switch'
numid=246,iface=MIXER,name='SPOL MIX DAC L1 Switch'
numid=245,iface=MIXER,name='SPOL MIX DAC R1 Switch'
numid=248,iface=MIXER,name='SPOL MIX SPKVOL L Switch'
numid=247,iface=MIXER,name='SPOL MIX SPKVOL R Switch'
numid=249,iface=MIXER,name='SPOR MIX DAC R1 Switch'
numid=250,iface=MIXER,name='SPOR MIX SPKVOL R Switch'
numid=147,iface=MIXER,name='STO1 ADC Boost Gain'
numid=148,iface=MIXER,name='STO2 ADC Boost Gain'
numid=130,iface=MIXER,name='Speaker Channel Switch'
numid=131,iface=MIXER,name='Speaker Playback Volume'
numid=199,iface=MIXER,name='Stereo DAC MIXL DAC L1 Switch'
numid=200,iface=MIXER,name='Stereo DAC MIXL DAC L2 Switch'
numid=201,iface=MIXER,name='Stereo DAC MIXL DAC R1 Switch'
numid=204,iface=MIXER,name='Stereo DAC MIXR DAC L1 Switch'
numid=202,iface=MIXER,name='Stereo DAC MIXR DAC R1 Switch'
numid=203,iface=MIXER,name='Stereo DAC MIXR DAC R2 Switch'
numid=166,iface=MIXER,name='Stereo1 ADC1 Mux'
numid=165,iface=MIXER,name='Stereo1 ADC2 Mux'
numid=164,iface=MIXER,name='Stereo1 DMIC Mux'
numid=173,iface=MIXER,name='Sto1 ADC MIXL ADC1 Switch'
numid=174,iface=MIXER,name='Sto1 ADC MIXL ADC2 Switch'
numid=175,iface=MIXER,name='Sto1 ADC MIXR ADC1 Switch'
numid=176,iface=MIXER,name='Sto1 ADC MIXR ADC2 Switch'
numid=190,iface=MIXER,name='VAD ADC Mux'
numid=126,iface=MIXER,name='codec_in rx deinterleaver codec_in0_0'
numid=127,iface=MIXER,name='codec_in rx deinterleaver codec_in0_1'
numid=128,iface=MIXER,name='codec_in rx deinterleaver codec_in1_0'
numid=129,iface=MIXER,name='codec_in rx deinterleaver codec_in1_1'
numid=89,iface=MIXER,name='codec_in0 Gain 0 Ramp Delay'
numid=90,iface=MIXER,name='codec_in0 Gain 0 Switch'
numid=91,iface=MIXER,name='codec_in0 Gain 0 Volume'
numid=120,iface=MIXER,name='codec_in0 dcr 0 params'
numid=92,iface=MIXER,name='codec_in1 Gain 0 Ramp Delay'
numid=93,iface=MIXER,name='codec_in1 Gain 0 Switch'
numid=94,iface=MIXER,name='codec_in1 Gain 0 Volume'
numid=121,iface=MIXER,name='codec_in1 dcr 0 params'
numid=122,iface=MIXER,name='codec_out tx interleaver slot 0'
numid=123,iface=MIXER,name='codec_out tx interleaver slot 1'
numid=124,iface=MIXER,name='codec_out tx interleaver slot 2'
numid=125,iface=MIXER,name='codec_out tx interleaver slot 3'
numid=95,iface=MIXER,name='codec_out0 Gain 0 Ramp Delay'
numid=96,iface=MIXER,name='codec_out0 Gain 0 Switch'
numid=97,iface=MIXER,name='codec_out0 Gain 0 Volume'
numid=51,iface=MIXER,name='codec_out0 mix 0 codec_in0 Switch'
numid=52,iface=MIXER,name='codec_out0 mix 0 codec_in1 Switch'
numid=54,iface=MIXER,name='codec_out0 mix 0 media_loop1_in Switch'
numid=55,iface=MIXER,name='codec_out0 mix 0 media_loop2_in Switch'
numid=56,iface=MIXER,name='codec_out0 mix 0 pcm0_in Switch'
numid=57,iface=MIXER,name='codec_out0 mix 0 pcm1_in Switch'
numid=53,iface=MIXER,name='codec_out0 mix 0 sprot_loop_in Switch'
numid=98,iface=MIXER,name='codec_out1 Gain 0 Ramp Delay'
numid=99,iface=MIXER,name='codec_out1 Gain 0 Switch'
numid=100,iface=MIXER,name='codec_out1 Gain 0 Volume'
numid=58,iface=MIXER,name='codec_out1 mix 0 codec_in0 Switch'
numid=59,iface=MIXER,name='codec_out1 mix 0 codec_in1 Switch'
numid=61,iface=MIXER,name='codec_out1 mix 0 media_loop1_in Switch'
numid=62,iface=MIXER,name='codec_out1 mix 0 media_loop2_in Switch'
numid=63,iface=MIXER,name='codec_out1 mix 0 pcm0_in Switch'
numid=64,iface=MIXER,name='codec_out1 mix 0 pcm1_in Switch'
numid=60,iface=MIXER,name='codec_out1 mix 0 sprot_loop_in Switch'
numid=65,iface=MIXER,name='media0_in Gain 0 Ramp Delay'
numid=66,iface=MIXER,name='media0_in Gain 0 Switch'
numid=67,iface=MIXER,name='media0_in Gain 0 Volume'
numid=110,iface=MIXER,name='media0_in Volume 0 Ramp Delay'
numid=111,iface=MIXER,name='media0_in Volume 0 Switch'
numid=112,iface=MIXER,name='media0_in Volume 0 Volume'
numid=1,iface=MIXER,name='media0_out mix 0 media0_in Switch'
numid=2,iface=MIXER,name='media0_out mix 0 media1_in Switch'
numid=3,iface=MIXER,name='media0_out mix 0 media2_in Switch'
numid=4,iface=MIXER,name='media0_out mix 0 media3_in Switch'
numid=68,iface=MIXER,name='media1_in Gain 0 Ramp Delay'
numid=69,iface=MIXER,name='media1_in Gain 0 Switch'
numid=70,iface=MIXER,name='media1_in Gain 0 Volume'
numid=5,iface=MIXER,name='media1_out mix 0 media0_in Switch'
numid=6,iface=MIXER,name='media1_out mix 0 media1_in Switch'
numid=7,iface=MIXER,name='media1_out mix 0 media2_in Switch'
numid=8,iface=MIXER,name='media1_out mix 0 media3_in Switch'
numid=71,iface=MIXER,name='media2_in Gain 0 Ramp Delay'
numid=72,iface=MIXER,name='media2_in Gain 0 Switch'
numid=73,iface=MIXER,name='media2_in Gain 0 Volume'
numid=74,iface=MIXER,name='media3_in Gain 0 Ramp Delay'
numid=75,iface=MIXER,name='media3_in Gain 0 Switch'
numid=76,iface=MIXER,name='media3_in Gain 0 Volume'
numid=101,iface=MIXER,name='media_loop1_out Gain 0 Ramp Delay'
numid=102,iface=MIXER,name='media_loop1_out Gain 0 Switch'
numid=103,iface=MIXER,name='media_loop1_out Gain 0 Volume'
numid=113,iface=MIXER,name='media_loop1_out fir 0 params'
numid=114,iface=MIXER,name='media_loop1_out iir 0 params'
numid=115,iface=MIXER,name='media_loop1_out mdrp 0 params'
numid=37,iface=MIXER,name='media_loop1_out mix 0 codec_in0 Switch'
numid=38,iface=MIXER,name='media_loop1_out mix 0 codec_in1 Switch'
numid=40,iface=MIXER,name='media_loop1_out mix 0 media_loop1_in Switch'
numid=41,iface=MIXER,name='media_loop1_out mix 0 media_loop2_in Switch'
numid=42,iface=MIXER,name='media_loop1_out mix 0 pcm0_in Switch'
numid=43,iface=MIXER,name='media_loop1_out mix 0 pcm1_in Switch'
numid=39,iface=MIXER,name='media_loop1_out mix 0 sprot_loop_in Switch'
numid=104,iface=MIXER,name='media_loop2_out Gain 0 Ramp Delay'
numid=105,iface=MIXER,name='media_loop2_out Gain 0 Switch'
numid=106,iface=MIXER,name='media_loop2_out Gain 0 Volume'
numid=116,iface=MIXER,name='media_loop2_out fir 0 params'
numid=117,iface=MIXER,name='media_loop2_out iir 0 params'
numid=118,iface=MIXER,name='media_loop2_out mdrp 0 params'
numid=44,iface=MIXER,name='media_loop2_out mix 0 codec_in0 Switch'
numid=45,iface=MIXER,name='media_loop2_out mix 0 codec_in1 Switch'
numid=47,iface=MIXER,name='media_loop2_out mix 0 media_loop1_in Switch'
numid=48,iface=MIXER,name='media_loop2_out mix 0 media_loop2_in Switch'
numid=49,iface=MIXER,name='media_loop2_out mix 0 pcm0_in Switch'
numid=50,iface=MIXER,name='media_loop2_out mix 0 pcm1_in Switch'
numid=46,iface=MIXER,name='media_loop2_out mix 0 sprot_loop_in Switch'
numid=77,iface=MIXER,name='pcm0_in Gain 0 Ramp Delay'
numid=78,iface=MIXER,name='pcm0_in Gain 0 Switch'
numid=79,iface=MIXER,name='pcm0_in Gain 0 Volume'
numid=9,iface=MIXER,name='pcm0_out mix 0 codec_in0 Switch'
numid=10,iface=MIXER,name='pcm0_out mix 0 codec_in1 Switch'
numid=12,iface=MIXER,name='pcm0_out mix 0 media_loop1_in Switch'
numid=13,iface=MIXER,name='pcm0_out mix 0 media_loop2_in Switch'
numid=14,iface=MIXER,name='pcm0_out mix 0 pcm0_in Switch'
numid=15,iface=MIXER,name='pcm0_out mix 0 pcm1_in Switch'
numid=11,iface=MIXER,name='pcm0_out mix 0 sprot_loop_in Switch'
numid=80,iface=MIXER,name='pcm1_in Gain 0 Ramp Delay'
numid=81,iface=MIXER,name='pcm1_in Gain 0 Switch'
numid=82,iface=MIXER,name='pcm1_in Gain 0 Volume'
numid=83,iface=MIXER,name='pcm1_out Gain 0 Ramp Delay'
numid=84,iface=MIXER,name='pcm1_out Gain 0 Switch'
numid=85,iface=MIXER,name='pcm1_out Gain 0 Volume'
numid=16,iface=MIXER,name='pcm1_out mix 0 codec_in0 Switch'
numid=17,iface=MIXER,name='pcm1_out mix 0 codec_in1 Switch'
numid=19,iface=MIXER,name='pcm1_out mix 0 media_loop1_in Switch'
numid=20,iface=MIXER,name='pcm1_out mix 0 media_loop2_in Switch'
numid=21,iface=MIXER,name='pcm1_out mix 0 pcm0_in Switch'
numid=22,iface=MIXER,name='pcm1_out mix 0 pcm1_in Switch'
numid=18,iface=MIXER,name='pcm1_out mix 0 sprot_loop_in Switch'
numid=86,iface=MIXER,name='pcm2_out Gain 0 Ramp Delay'
numid=87,iface=MIXER,name='pcm2_out Gain 0 Switch'
numid=88,iface=MIXER,name='pcm2_out Gain 0 Volume'
numid=23,iface=MIXER,name='pcm2_out mix 0 codec_in0 Switch'
numid=24,iface=MIXER,name='pcm2_out mix 0 codec_in1 Switch'
numid=26,iface=MIXER,name='pcm2_out mix 0 media_loop1_in Switch'
numid=27,iface=MIXER,name='pcm2_out mix 0 media_loop2_in Switch'
numid=28,iface=MIXER,name='pcm2_out mix 0 pcm0_in Switch'
numid=29,iface=MIXER,name='pcm2_out mix 0 pcm1_in Switch'
numid=25,iface=MIXER,name='pcm2_out mix 0 sprot_loop_in Switch'
numid=107,iface=MIXER,name='sprot_loop_out Gain 0 Ramp Delay'
numid=108,iface=MIXER,name='sprot_loop_out Gain 0 Switch'
numid=109,iface=MIXER,name='sprot_loop_out Gain 0 Volume'
numid=119,iface=MIXER,name='sprot_loop_out lpro 0 params'
numid=30,iface=MIXER,name='sprot_loop_out mix 0 codec_in0 Switch'
numid=31,iface=MIXER,name='sprot_loop_out mix 0 codec_in1 Switch'
numid=33,iface=MIXER,name='sprot_loop_out mix 0 media_loop1_in Switch'
numid=34,iface=MIXER,name='sprot_loop_out mix 0 media_loop2_in Switch'
numid=35,iface=MIXER,name='sprot_loop_out mix 0 pcm0_in Switch'
numid=36,iface=MIXER,name='sprot_loop_out mix 0 pcm1_in Switch'
numid=32,iface=MIXER,name='sprot_loop_out mix 0 sprot_loop_in Switch'

Thank you,
Michele
