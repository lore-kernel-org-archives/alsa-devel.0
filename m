From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Fri, 29 May 2015 15:17:53 +0200
Message-ID: <20150529131753.GA339@asus>
References: <20150523163221.GA936@asus> <s5h7fruecx4.wl-tiwai@suse.de>
 <20150527085440.GA4445@dellaz> <1432752116.8235.25.camel@loki>
 <20150527201320.GA309@asus> <1432812668.2726.18.camel@loki>
 <20150528125325.GA418@asus> <1432819294.2726.33.camel@loki>
 <20150528191721.GA608@asus> <1432892521.2732.14.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 09D202602AD
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 15:18:10 +0200 (CEST)
Received: by wicmx19 with SMTP id mx19so15853854wic.0
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 06:18:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1432892521.2732.14.camel@loki>
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


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2015 at 10:42:01AM +0100, Liam Girdwood wrote:
> On Thu, 2015-05-28 at 21:17 +0200, Michele Curti wrote:
> 
> > to let the probe continue, the system become quite unusable but I get the 
> > logs.
> > 
> > May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: initialising Byt DSP IPC
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: initialising audio DSP id 0xf28
> > May 28 20:34:00 asus kernel: irq used for dsp = 6
> > 
> > ---> The IRQ number used is 6
> > 
> > May 28 20:34:00 asus kernel: [101B blob data]
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x160 bytes at offset 0xc0000 type 0
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block allocated 0:0 at offset 0xc0000
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x170 bytes at offset 0xc0400 type 0
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc0578 type 0
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc0598 type 0
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc05b8 type 0
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc05d8 type 0
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc05f8 type 0
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x8 bytes at offset 0xc0618 type 0
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 bytes at offset 0xc0638 type 0
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x30 bytes at offset 0xc0658 type 0
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10438 bytes at offset 0xc06a0 type 0
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block allocated 0:1 at offset 0xc8000
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block allocated 0:2 at offset 0xd0000
> > May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: Requesting IRQ 146
> > May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: Requesting gpio 0
> > May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: Fail gpio_request hp_det_gpio
> > May 28 20:34:00 asus kernel: gpiod_direction_input: invalid GPIO
> > May 28 20:34:00 asus kernel: rt5645 i2c-10EC5648:00: Fail gpio_direction hp_det_gpio
> > May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x1a310 bytes at offset 0x400000 type 3
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x5738 bytes at offset 0x100010 type 1
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block allocated 1:0 at offset 0x100000
> > May 28 20:34:00 asus kernel: Linux video capture interface: v2.00
> > May 28 20:34:00 asus kernel: intel_rapl: Found RAPL domain package
> > May 28 20:34:00 asus kernel: intel_rapl: Found RAPL domain core
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block request 0x10ad8 bytes at offset 0x105750 type 1
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block allocated 1:1 at offset 0x108000
> > May 28 20:34:00 asus kernel: baytrail-pcm-audio baytrail-pcm-audio: block allocated 1:2 at offset 0x110000
> > May 28 20:34:00 asus kernel: byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> 
> 
> This is confusing as we can see messages about the baytrail-pcm-audio
> device not being registered and then valid messages from said device ?
> I'm wondering if you have created 2 baytrail-pcm-audio devices ? The
> ordering is also confusing since the block allocation should come before
> the DSP boot....
> 
> Can you paste the diff for all the audio changes you have made and also
> the output of lsmod when this happens.
>

Sure, sorry for the number of attachments.. :p

I'm using linux-next next-20150528 and the (attached) kernel .config
kernel-config.txt.

Attached 3 patches:
 - 0001-add-baytrail-byt-rt5645-board.patch, which adds the board file and
   a couple of ACPI ID match
 - 0002-enable-debug.patch, which enables debug output for files in
   common/sst-*.c and baytrail/sst-*.c
 - 0003-ignore-dsp-boot-timeout.patch, used to ignore the dsp boot timeout
   and to let the baytrail-pcm-audio driver load

Applying all the three patches I got the dmesg output dmesg-ignore-dsp.txt
and the lsmod output lsmod-ignore-dsp.txt.

Applying only the first two patches, I got the output dmesg-normal.txt and
the lsmod output lsmod-normal.txt.

I attached also the content of /proc/interrupt in proc-interrupts.txt and
/proc/stat in proc-stat.txt, to maybe see the dsp interrupt..

Thanks!
Michele

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-ignore-dsp.txt"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.1.0-rc5-next-20150528-asus+ (zio@asus) (gcc =
version 5.1.0 (GCC) ) #5 SMP PREEMPT Fri May 29 14:22:50 CEST 2015
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-linux-asus root=3D/dev/m=
mcblk0p2 rw quiet
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'lazy' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x000000007bf13fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007bf14000-0x000000007bf43fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007bf44000-0x000000007bf77fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007bf78000-0x000000007c040fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007c041000-0x000000007c928fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007c929000-0x000000007c984fff] type =
20
[    0.000000] BIOS-e820: [mem 0x000000007c985000-0x000000007cbfffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed08fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ffb00000-0x00000000ffffffff] reser=
ved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.31 by American Megatrends
[    0.000000] efi:  ACPI=3D0x7bf77000  ACPI 2.0=3D0x7bf77014  SMBIOS=3D0x7=
c928190=20
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: ASUSTeK COMPUTER INC. X205TA/X205TA, BIOS X205TA.205 10=
/06/2014
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn =3D 0x7cc00 max_arch_pfn =3D 0x400000000
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
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC=
 =20
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
[    0.000000] ACPI: XSDT 0x000000007BF760F8 0000D4 (v01 _ASUS_ Notebook 00=
000003 MSFT 0100000D)
[    0.000000] ACPI: FACP 0x000000007BF72000 00010C (v05 _ASUS_ Notebook 00=
000003 AMI  0100000D)
[    0.000000] ACPI: DSDT 0x000000007BF5B000 0126F4 (v02 _ASUS_ Notebook 00=
000003 AMI  0100000D)
[    0.000000] ACPI: TCPA 0x000000007BF75000 000032 (v02                 00=
000000      00000000)
[    0.000000] ACPI: UEFI 0x000000007BFF4000 000042 (v01 _ASUS_ Notebook 00=
000000      00000000)
[    0.000000] ACPI: OEM0 0x000000007BF74000 000084 (v05 _ASUS_ BATTERY  00=
000003 AMI  0100000D)
[    0.000000] ACPI: DBG2 0x000000007BF73000 000072 (v00 _ASUS_ INTLDBG2 00=
000003 AMI  0100000D)
[    0.000000] ACPI: HPET 0x000000007BF71000 000038 (v01 _ASUS_ Notebook 00=
000003 AMI  0100000D)
[    0.000000] ACPI: LPIT 0x000000007BF70000 000104 (v01 _ASUS_ Notebook 00=
000003 AMI  0100000D)
[    0.000000] ACPI: APIC 0x000000007BF6F000 00006C (v03 _ASUS_ Notebook 00=
000003 AMI  0100000D)
[    0.000000] ACPI: MCFG 0x000000007BF6E000 00003C (v01 _ASUS_ Notebook 00=
000003 AMI  0100000D)
[    0.000000] ACPI: SSDT 0x000000007BF5A000 000603 (v01 _ASUS_ CpuDptf  00=
000003 AMI  0100000D)
[    0.000000] ACPI: SSDT 0x000000007BF58000 001BE2 (v01 _ASUS_ DptfTab  00=
000003 AMI  0100000D)
[    0.000000] ACPI: SSDT 0x000000007BF57000 000058 (v01 _ASUS_ LowPwrM  00=
000003 AMI  0100000D)
[    0.000000] ACPI: SSDT 0x000000007BF56000 0000FF (v01 _ASUS_ SoCDptf  00=
000003 AMI  0100000D)
[    0.000000] ACPI: FPDT 0x000000007BF55000 000044 (v01 _ASUS_ Notebook 01=
072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x000000007BF54000 000763 (v01 PmRef  CpuPm    00=
003000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x000000007BF53000 000290 (v01 PmRef  Cpu0Tst  00=
003000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x000000007BF52000 00017A (v01 PmRef  ApTst    00=
003000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x000000007BF51000 000427 (v01 Intel_ Tpm2Tabl 00=
001000 INTL 20061109)
[    0.000000] ACPI: TPM2 0x000000007BF50000 000034 (v03                 00=
000000      00000000)
[    0.000000] ACPI: BGRT 0x000000007BF4F000 000038 (v01 _ASUS_ Notebook 01=
072009 AMI  00010013)
[    0.000000] ACPI: CSRT 0x000000007BF4E000 00014C (v00 _ASUS_ Notebook 00=
000005 INTL 20120624)
[    0.000000] ACPI: MSDM 0x000000007BF42F90 000055 (v03 _ASUS_ Notebook 00=
000000 ASUS 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000]  [ffffea0000000000-ffffea0001ffffff] PMD -> [ffff880076c0000=
0-ffff880078bfffff] on node 0
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
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000007cbff=
fff]
[    0.000000] On node 0 totalpages: 507691
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 22 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7920 pages used for memmap
[    0.000000]   DMA32 zone: 503695 pages, LIFO batch:31
[    0.000000] x86/hpet: Will disable the HPET for this platform because it=
's not reliable
[    0.000000] Reserving Intel graphics stolen memory at 0x7cf00000-0x7eeff=
fff
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-=
86
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] e820: [mem 0x7ef00000-0xe00f7fff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource refined-jiffies: mask: 0xffffffff max_cycles: 0x=
ffffffff, max_idle_ns: 6370452778343963 ns
[    0.000000] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_no=
de_ids:1
[    0.000000] PERCPU: Embedded 34 pages/cpu @ffff88007ba00000 s99416 r8192=
 d31656 u524288
[    0.000000] pcpu-alloc: s99416 r8192 d31656 u524288 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 499685
[    0.000000] Kernel command line: BOOT_IMAGE=3D/vmlinuz-linux-asus root=
=3D/dev/mmcblk0p2 rw quiet
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 b=
ytes)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 by=
tes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 1936940K/2030764K available (6033K kernel code, 946K=
 rwdata, 1860K rodata, 1180K init, 1132K bss, 93824K reserved, 0K cma-reser=
ved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] NR_IRQS:4352 nr_irqs:1024 0
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] Maximum core-clock to bus-clock ratio: 0x10
[    0.000000] Resolved frequency ID: 0, frequency: 83200 KHz
[    0.000000] TSC runs at 1331200 KHz
[    0.000000] lapic_timer_frequency =3D 277333
[    0.000000] tsc: Detected 1331.200 MHz processor
[    0.000057] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 2663.33 BogoMIPS (lpj=3D4437333)
[    0.000065] pid_max: default: 32768 minimum: 301
[    0.000087] ACPI: Core revision 20150515
[    0.055787] ACPI: All ACPI Tables successfully acquired
[    0.057817] Security Framework initialized
[    0.057825] Yama: becoming mindful.
[    0.057857] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.057865] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 b=
ytes)
[    0.058290] Initializing cgroup subsys blkio
[    0.058300] Initializing cgroup subsys memory
[    0.058320] Initializing cgroup subsys devices
[    0.058329] Initializing cgroup subsys freezer
[    0.058336] Initializing cgroup subsys net_cls
[    0.058371] CPU: Physical Processor ID: 0
[    0.058375] CPU: Processor Core ID: 0
[    0.058382] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.058386] ENERGY_PERF_BIAS: View and update with x86_energy_perf_polic=
y(8)
[    0.063291] mce: CPU supports 6 MCE banks
[    0.063305] CPU0: Thermal monitoring enabled (TM1)
[    0.063311] process: using mwait in idle threads
[    0.063320] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
[    0.063324] Last level dTLB entries: 4KB 128, 2MB 16, 4MB 16, 1GB 0
[    0.063551] Freeing SMP alternatives memory: 20K (ffffffff81a15000 - fff=
fffff81a1a000)
[    0.065166] Ignoring BGRT: invalid status 0 (expected 1)
[    0.069707] ftrace: allocating 22992 entries in 90 pages
[    0.088429] TSC deadline timer enabled
[    0.088439] smpboot: CPU0: Intel(R) Atom(TM) CPU  Z3735F @ 1.33GHz (fam:=
 06, model: 37, stepping: 08)
[    0.088486] Performance Events: PEBS fmt2+, 8-deep LBR, Silvermont event=
s, full-width counters, Intel PMU driver.
[    0.088508] ... version:                3
[    0.088512] ... bit width:              40
[    0.088515] ... generic registers:      2
[    0.088519] ... value mask:             000000ffffffffff
[    0.088522] ... max period:             000000ffffffffff
[    0.088525] ... fixed-purpose events:   3
[    0.088529] ... event mask:             0000000700000003
[    0.101982] x86: Booting SMP configuration:
[    0.101990] .... node  #0, CPUs:      #1
[    0.110197] NMI watchdog: enabled on all CPUs, permanently consumes one =
hw-PMU counter.
[    0.113558]  #2 #3
[    0.133172] x86: Booted up 1 node, 4 CPUs
[    0.133179] smpboot: Total of 4 processors activated (10653.33 BogoMIPS)
[    0.134309] devtmpfs: initialized
[    0.143856] PM: Registering ACPI NVS region [mem 0x0008f000-0x0008ffff] =
(4096 bytes)
[    0.143863] PM: Registering ACPI NVS region [mem 0x7bf78000-0x7c040fff] =
(823296 bytes)
[    0.144094] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 6370867519511994 ns
[    0.144304] pinctrl core: initialized pinctrl subsystem
[    0.144368] RTC time: 12:27:34, date: 05/29/15
[    0.144723] NET: Registered protocol family 16
[    0.159868] cpuidle: using governor ladder
[    0.176555] cpuidle: using governor menu
[    0.176627] ACPI: bus type PCI registered
[    0.176633] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.176812] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.176819] PCI: not using MMCONFIG
[    0.176823] PCI: Using configuration type 1 for base access
[    0.187459] ACPI: Added _OSI(Module Device)
[    0.187466] ACPI: Added _OSI(Processor Device)
[    0.187470] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.187475] ACPI: Added _OSI(Processor Aggregator Device)
[    0.220000] ACPI: Dynamic OEM Table Load:
[    0.220028] ACPI: SSDT 0xFFFF880076BF1800 000501 (v01 PmRef  Cpu0Ist  00=
003000 INTL 20061109)
[    0.222298] ACPI: Dynamic OEM Table Load:
[    0.222321] ACPI: SSDT 0xFFFF880076BF2000 000433 (v01 PmRef  Cpu0Cst  00=
003001 INTL 20061109)
[    0.225209] ACPI: Dynamic OEM Table Load:
[    0.225230] ACPI: SSDT 0xFFFF880076BFAA00 00015F (v01 PmRef  ApIst    00=
003000 INTL 20061109)
[    0.227441] ACPI: Dynamic OEM Table Load:
[    0.227463] ACPI: SSDT 0xFFFF88007B45B000 00008D (v01 PmRef  ApCst    00=
003000 INTL 20061109)
[    0.231738] ACPI: Interpreter enabled
[    0.231759] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [=
\_S1_] (20150515/hwxface-580)
[    0.231773] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [=
\_S2_] (20150515/hwxface-580)
[    0.231785] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [=
\_S3_] (20150515/hwxface-580)
[    0.231809] ACPI: (supports S0 S5)
[    0.231814] ACPI: Using IOAPIC for interrupt routing
[    0.231876] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.242497] [Firmware Info]: PCI: MMCONFIG at [mem 0xe0000000-0xefffffff=
] not reserved in ACPI motherboard resources
[    0.242505] PCI: not using MMCONFIG
[    0.242544] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.247168] ACPI: Power Resource [USBC] (on)
[    0.254597] ACPI: Power Resource [PLPE] (on)
[    0.265843] ACPI: Power Resource [CLK0] (on)
[    0.265970] ACPI: Power Resource [CLK1] (on)
[    0.266639] ACPI: Power Resource [P28T] (off)
[    0.266771] ACPI: Power Resource [P18T] (off)
[    0.272239] ACPI: Power Resource [P28X] (off)
[    0.272368] ACPI: Power Resource [P18X] (off)
[    0.272496] ACPI: Power Resource [P28P] (off)
[    0.272621] ACPI: Power Resource [P18P] (off)
[    0.272759] ACPI: Power Resource [P1XT] (off)
[    0.274240] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.282290] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.282307] acpi PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments MS=
I]
[    0.282439] \_SB_.PCI0:_OSC invalid UUID
[    0.282444] _OSC request data:1 1e 0=20
[    0.282456] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    0.282855] acpi PNP0A08:00: fail to add MMCONFIG information, can't acc=
ess extended PCI configuration space under this bridge.
[    0.283370] PCI host bridge to bus 0000:00
[    0.283381] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.283387] pci_bus 0000:00: root bus resource [io  0x0070-0x0077]
[    0.283394] pci_bus 0000:00: root bus resource [io  0x0000-0x006f window]
[    0.283400] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7 window]
[    0.283406] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.283412] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.283418] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dfff=
f window]
[    0.283437] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000ffff=
f window]
[    0.283444] pci_bus 0000:00: root bus resource [mem 0x90c00000-0x90fffff=
f window]
[    0.283450] pci_bus 0000:00: root bus resource [mem 0x7cf00001-0x7ef0000=
0 window]
[    0.283456] pci_bus 0000:00: root bus resource [mem 0x80000000-0x908ffff=
e window]
[    0.283463] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed40ff=
f window]
[    0.283480] pci 0000:00:00.0: [8086:0f00] type 00 class 0x060000
[    0.283727] pci 0000:00:02.0: [8086:0f31] type 00 class 0x030000
[    0.283757] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x903fffff]
[    0.283775] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff pref]
[    0.283792] pci 0000:00:02.0: reg 0x20: [io  0x1000-0x1007]
[    0.284040] pci 0000:00:14.0: [8086:0f35] type 00 class 0x0c0330
[    0.284078] pci 0000:00:14.0: reg 0x10: [mem 0x90800000-0x9080ffff 64bit]
[    0.284145] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.284375] pci 0000:00:1a.0: [8086:0f18] type 00 class 0x108000
[    0.284416] pci 0000:00:1a.0: reg 0x10: [mem 0x90700000-0x907fffff]
[    0.284432] pci 0000:00:1a.0: reg 0x14: [mem 0x90600000-0x906fffff]
[    0.284516] pci 0000:00:1a.0: PME# supported from D0 D3hot
[    0.284738] pci 0000:00:1f.0: [8086:0f1c] type 00 class 0x060100
[    0.285011] pci_bus 0000:00: on NUMA node 0
[    0.285824] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15=
) *0, disabled.
[    0.286014] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15=
) *0, disabled.
[    0.286199] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15=
) *0, disabled.
[    0.286386] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15=
) *0, disabled.
[    0.286578] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15=
) *0, disabled.
[    0.286786] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15=
) *0, disabled.
[    0.286974] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15=
) *0, disabled.
[    0.287160] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15=
) *0, disabled.
[    0.300364] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.300372] vgaarb: device added: PCI:0000:00:02.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    0.300377] vgaarb: loaded
[    0.300381] vgaarb: bridge control possible 0000:00:02.0
[    0.300548] SCSI subsystem initialized
[    0.300573] ACPI: bus type USB registered
[    0.300634] usbcore: registered new interface driver usbfs
[    0.300668] usbcore: registered new interface driver hub
[    0.300738] usbcore: registered new device driver usb
[    0.316971] PCI: Using ACPI for IRQ routing
[    0.316981] PCI: pci_cache_line_size set to 64 bytes
[    0.317008] Expanded resource reserved due to conflict with PCI Bus 0000=
:00
[    0.317015] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.317020] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.317025] e820: reserve RAM buffer [mem 0x7bf14000-0x7bffffff]
[    0.317029] e820: reserve RAM buffer [mem 0x7cc00000-0x7fffffff]
[    0.317331] NetLabel: Initializing
[    0.317337] NetLabel:  domain hash size =3D 128
[    0.317340] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    0.317369] NetLabel:  unlabeled traffic allowed by default
[    0.317460] Switched to clocksource refined-jiffies
[    0.333118] pnp: PnP ACPI init
[    0.333273] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.333791] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.333800] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.333806] system 00:01: [io  0x0500-0x05fe] has been reserved
[    0.333813] system 00:01: [io  0x0600-0x061f] has been reserved
[    0.333820] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.333830] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.334102] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.335661] system 00:03: [io  0x0240-0x0259] has been reserved
[    0.335673] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.348549] pnp: PnP ACPI: found 4 devices
[    0.354405] pci_bus 0000:00: resource 4 [io  0x0070-0x0077]
[    0.354415] pci_bus 0000:00: resource 5 [io  0x0000-0x006f window]
[    0.354421] pci_bus 0000:00: resource 6 [io  0x0078-0x0cf7 window]
[    0.354427] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.354434] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff windo=
w]
[    0.354440] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff windo=
w]
[    0.354446] pci_bus 0000:00: resource 10 [mem 0x000e0000-0x000fffff wind=
ow]
[    0.354452] pci_bus 0000:00: resource 11 [mem 0x90c00000-0x90ffffff wind=
ow]
[    0.354459] pci_bus 0000:00: resource 12 [mem 0x7cf00001-0x7ef00000 wind=
ow]
[    0.354465] pci_bus 0000:00: resource 13 [mem 0x80000000-0x908ffffe wind=
ow]
[    0.354471] pci_bus 0000:00: resource 14 [mem 0xfed40000-0xfed40fff wind=
ow]
[    0.354547] NET: Registered protocol family 2
[    0.354858] TCP established hash table entries: 16384 (order: 5, 131072 =
bytes)
[    0.354933] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
[    0.355051] TCP: Hash tables configured (established 16384 bind 16384)
[    0.355108] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.355135] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.355252] NET: Registered protocol family 1
[    0.355291] pci 0000:00:02.0: Video device with shadowed ROM
[    0.355669] PCI: CLS 0 bytes, default 64
[    0.355797] Unpacking initramfs...
[    0.452320] Freeing initrd memory: 2368K (ffff880037b50000 - ffff880037d=
a0000)
[    0.452623] microcode: CPU0 sig=3D0x30678, pf=3D0x2, revision=3D0x829
[    0.452641] microcode: CPU1 sig=3D0x30678, pf=3D0x2, revision=3D0x829
[    0.452661] microcode: CPU2 sig=3D0x30678, pf=3D0x2, revision=3D0x829
[    0.452680] microcode: CPU3 sig=3D0x30678, pf=3D0x2, revision=3D0x829
[    0.452797] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.f=
snet.co.uk>, Peter Oruba
[    0.452868] Scanning for low memory corruption every 60 seconds
[    0.453577] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.453613] Initialise system trusted keyring
[    0.454364] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.458936] zpool: loaded
[    0.458944] zbud: loaded
[    0.459383] VFS: Disk quotas dquot_6.6.0
[    0.459492] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.460644] Key type big_key registered
[    0.461038] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 252)
[    0.461129] io scheduler noop registered
[    0.461137] io scheduler deadline registered
[    0.461233] io scheduler cfq registered (default)
[    0.461386] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.461435] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.461521] efifb: probing for efifb
[    0.461554] efifb: framebuffer at 0x80000000, mapped to 0xffffc900008000=
00, using 4160k, total 4160k
[    0.461559] efifb: mode is 1366x768x32, linelength=3D5504, pages=3D1
[    0.461562] efifb: scrolling: redraw
[    0.461568] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.472093] Console: switching to colour frame buffer device 170x48
[    0.482302] fb0: EFI VGA frame buffer device
[    0.482331] intel_idle: MWAIT substates: 0x33000020
[    0.482336] intel_idle: v0.4 model 0x37
[    0.482340] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.482868] GHES: HEST is not enabled!
[    0.483021] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.503320] 00:02: ttyS0 at I/O 0x3f8 (irq =3D 203, base_baud =3D 115200=
) is a 16550A
[    0.504233] hpet: number irqs doesn't agree with number of timers
[    0.504295] Linux agpgart interface v0.103
[    0.505283] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.505301] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[    0.505711] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
00 quirks 0x00009810
[    0.505723] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    0.506236] hub 1-0:1.0: USB hub found
[    0.506263] hub 1-0:1.0: 6 ports detected
[    0.507486] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.507498] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    0.507916] hub 2-0:1.0: USB hub found
[    0.507943] hub 2-0:1.0: 1 port detected
[    0.508349] usbcore: registered new interface driver usb-storage
[    0.508385] ACPI Warning: Could not enable fixed event - RealTimeClock (=
4) (20150515/evxface-654)
[    0.508596] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    0.508637] rtc_cmos 00:00: alarms up to one day, 242 bytes nvram
[    0.508663] i2c /dev entries driver
[    0.509107] Intel P-state driver initializing.
[    0.509542] sdhci: Secure Digital Host Controller Interface driver
[    0.509555] sdhci: Copyright(c) Pierre Ossman
[    0.510805] sdhci-acpi 80860F14:00: No vmmc regulator found
[    0.510823] sdhci-acpi 80860F14:00: No vqmmc regulator found
[    0.514196] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
[    0.515695] sdhci-acpi INT33BB:00: No vmmc regulator found
[    0.515712] sdhci-acpi INT33BB:00: No vqmmc regulator found
[    0.519052] mmc1: SDHCI controller on ACPI [INT33BB:00] using ADMA
[    0.520270] sdhci-acpi PNP0FFF:00: No vmmc regulator found
[    0.520278] sdhci-acpi PNP0FFF:00: No vqmmc regulator found
[    0.523479] mmc2: SDHCI controller on ACPI [PNP0FFF:00] using ADMA
[    0.523567] ledtrig-cpu: registered to indicate activity on CPUs
[    0.524653] NET: Registered protocol family 10
[    0.525302] NET: Registered protocol family 17
[    0.526501] Loading compiled-in X.509 certificates
[    0.526540] registered taskstats version 1
[    0.527024]   Magic number: 15:371:482
[    0.527213] rtc_cmos 00:00: setting system clock to 2015-05-29 12:27:35 =
UTC (1432902455)
[    0.528448] Freeing unused kernel memory: 1180K (ffffffff818ee000 - ffff=
ffff81a15000)
[    0.528461] Write protecting the kernel read-only data: 8192k
[    0.528863] Freeing unused kernel memory: 100K (ffff8800015e7000 - ffff8=
80001600000)
[    0.529012] Freeing unused kernel memory: 188K (ffff8800017d1000 - ffff8=
80001800000)
[    0.546026] random: systemd-tmpfile urandom read with 3 bits of entropy =
available
[    0.647185] mmc0: MAN_BKOPS_EN bit is not set
[    0.657258] mmc0: new HS200 MMC card at address 0001
[    0.657528] mmcblk0: mmc0:0001 HBG4e=05 29.1 GiB=20
[    0.657661] mmcblk0boot0: mmc0:0001 HBG4e=05 partition 1 4.00 MiB
[    0.657757] mmcblk0boot1: mmc0:0001 HBG4e=05 partition 2 4.00 MiB
[    0.657859] mmcblk0rpmb: mmc0:0001 HBG4e=05 partition 3 4.00 MiB
[    0.660329]  mmcblk0: p1 p2
[    0.745178] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    0.746699] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    0.748204] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    0.750936] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    0.810365] mmc1: queuing unknown CIS tuple 0x91 (3 bytes)
[    0.810402] mmc1: new ultra high speed DDR50 SDIO card at address 0001
[    0.851719] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mo=
de. Opts: (null)
[    0.877621] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    0.956247] systemd[1]: systemd 219 running in system mode. (+PAM -AUDIT=
 -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNU=
TLS +ACL +XZ +LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD +IDN)
[    0.956642] systemd[1]: Detected architecture 'x86-64'.
[    0.958442] systemd[1]: Set hostname to <asus>.
[    1.017378] systemd[1]: Unit type .busname is not supported on this syst=
em.
[    1.068428] systemd[1]: Unit type .swap is not supported on this system.
[    1.071971] systemd[1]: Cannot add dependency job for unit org.freedeskt=
op.resolve1.busname, ignoring: Unit org.freedesktop.resolve1.busname failed=
 to load: No such file or directory.
[    1.073071] systemd[1]: Reached target Swap.
[    1.073103] systemd[1]: Starting Swap.
[    1.073599] systemd[1]: Created slice Root Slice.
[    1.073628] systemd[1]: Starting Root Slice.
[    1.073718] systemd[1]: Listening on udev Control Socket.
[    1.073745] systemd[1]: Starting udev Control Socket.
[    1.073837] systemd[1]: Listening on Journal Socket (/dev/log).
[    1.073863] systemd[1]: Starting Journal Socket (/dev/log).
[    1.073947] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    1.073973] systemd[1]: Starting Device-mapper event daemon FIFOs.
[    1.074038] systemd[1]: Listening on Delayed Shutdown Socket.
[    1.074064] systemd[1]: Starting Delayed Shutdown Socket.
[    1.074162] systemd[1]: Listening on Journal Socket.
[    1.074194] systemd[1]: Starting Journal Socket.
[    1.074270] systemd[1]: Listening on udev Kernel Socket.
[    1.074296] systemd[1]: Starting udev Kernel Socket.
[    1.074386] systemd[1]: Listening on /dev/initctl Compatibility Named Pi=
pe.
[    1.074413] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[    1.074454] systemd[1]: Reached target Encrypted Volumes.
[    1.074479] systemd[1]: Starting Encrypted Volumes.
[    1.084965] systemd[1]: Listening on Journal Audit Socket.
[    1.085115] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    1.085144] systemd[1]: Starting Forward Password Requests to Wall Direc=
tory Watch.
[    1.085255] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    1.085281] systemd[1]: Starting Dispatch Password Requests to Console D=
irectory Watch.
[    1.085319] systemd[1]: Reached target Paths.
[    1.085344] systemd[1]: Starting Paths.
[    1.085540] systemd[1]: Listening on networkd rtnetlink socket.
[    1.085567] systemd[1]: Starting networkd rtnetlink socket.
[    1.085604] systemd[1]: Reached target Remote File Systems.
[    1.085628] systemd[1]: Starting Remote File Systems.
[    1.085872] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    1.085904] systemd[1]: Starting Arbitrary Executable File Formats File =
System Automount Point.
[    1.086219] systemd[1]: Created slice System Slice.
[    1.086254] systemd[1]: Starting System Slice.
[    1.086820] systemd[1]: Started Set Up Additional Binary Formats.
[    1.087555] systemd[1]: Started Load Kernel Modules.
[    1.088781] systemd[1]: Mounting Debug File System...
[    1.090377] systemd[1]: Mounting Configuration File System...
[    1.091902] systemd[1]: Starting Journal Service...
[    1.093729] systemd[1]: Starting Create list of required static device n=
odes for the current kernel...
[    1.096168] systemd[1]: Starting udev Coldplug all Devices...
[    1.096645] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    1.096682] systemd[1]: Starting system-systemd\x2dfsck.slice.
[    1.098575] systemd[1]: Mounting Huge Pages File System...
[    1.098668] systemd[1]: Started File System Check on Root Device.
[    1.100711] systemd[1]: Mounting POSIX Message Queue File System...
[    1.101168] systemd[1]: Created slice system-wpa_supplicant.slice.
[    1.101203] systemd[1]: Starting system-wpa_supplicant.slice.
[    1.113604] systemd[1]: Mounting Temporary Directory...
[    1.117032] systemd[1]: Starting Apply Kernel Variables...
[    1.118759] systemd[1]: Starting Remount Root and Kernel File Systems...
[    1.119965] systemd[1]: Created slice system-getty.slice.
[    1.120005] systemd[1]: Starting system-getty.slice.
[    1.120066] systemd[1]: Mounted FUSE Control File System.
[    1.120196] systemd[1]: Listening on LVM2 metadata daemon socket.
[    1.120225] systemd[1]: Starting LVM2 metadata daemon socket.
[    1.120891] systemd-journald[124]: Failed to set file attributes: Inappr=
opriate ioctl for device
[    1.121625] systemd[1]: Starting Setup Virtual Console...
[    1.121988] systemd[1]: Created slice User and Session Slice.
[    1.122033] systemd[1]: Starting User and Session Slice.
[    1.122089] systemd[1]: Reached target Slices.
[    1.122115] systemd[1]: Starting Slices.
[    1.125731] EXT4-fs (mmcblk0p2): re-mounted. Opts: data=3Dordered,commit=
=3D60
[    1.126775] systemd[1]: Mounted Configuration File System.
[    1.126863] systemd[1]: Mounted POSIX Message Queue File System.
[    1.126923] systemd[1]: Mounted Debug File System.
[    1.126981] systemd[1]: Mounted Huge Pages File System.
[    1.127042] systemd[1]: Mounted Temporary Directory.
[    1.129152] systemd[1]: Started Create list of required static device no=
des for the current kernel.
[    1.132190] systemd[1]: Started Apply Kernel Variables.
[    1.132885] systemd[1]: Started Remount Root and Kernel File Systems.
[    1.156882] systemd[1]: Started udev Coldplug all Devices.
[    1.176447] systemd[1]: Started First Boot Wizard.
[    1.177851] systemd[1]: Starting Load/Save Random Seed...
[    1.180270] systemd[1]: Started Rebuild Hardware Database.
[    1.180363] systemd[1]: Started Rebuild Dynamic Linker Cache.
[    1.180424] systemd[1]: Started Create System Users.
[    1.181929] systemd[1]: Starting Create Static Device Nodes in /dev...
[    1.194212] systemd[1]: Started Load/Save Random Seed.
[    1.222186] systemd[1]: Started Create Static Device Nodes in /dev.
[    1.223818] systemd[1]: Starting udev Kernel Device Manager...
[    1.223911] systemd[1]: Reached target Local File Systems (Pre).
[    1.223969] systemd[1]: Starting Local File Systems (Pre).
[    1.239053] systemd[1]: Started Setup Virtual Console.
[    1.256850] systemd[1]: Started udev Kernel Device Manager.
[    1.273889] systemd[1]: Started Journal Service.
[    1.289090] 80860F0A:00: ttyS1 at MMIO 0x90941000 (irq =3D 191, base_bau=
d =3D 2764800) is a 16550A
[    1.289288] systemd-journald[124]: Received request to flush runtime jou=
rnal from PID 1
[    1.291622] 80860F0A:01: ttyS2 at MMIO 0x90947000 (irq =3D 193, base_bau=
d =3D 2764800) is a 16550A
[    1.400196] ACPI: AC Adapter [ADP1] (off-line)
[    1.406875] hidraw: raw HID events driver (C) Jiri Kosina
[    1.488854] ACPI: Battery Slot [BATC] (battery present)
[    1.495313] clocksource tsc: mask: 0xffffffffffffffff max_cycles: 0x1330=
3f810e3, max_idle_ns: 440795235405 ns
[    1.495348] Switched to clocksource tsc
[    1.505577] dw_dmac INTL9C60:00: DesignWare DMA Controller, 8 channels
[    1.506339] dw_dmac INTL9C60:01: DesignWare DMA Controller, 8 channels
[    1.526964] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input0
[    1.527029] ACPI: Lid Switch [LID]
[    1.527155] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[    1.527163] ACPI: Power Button [PWRB]
[    1.527276] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input2
[    1.527283] ACPI: Sleep Button [SLPB]
[    1.527661] [Firmware Bug]: No valid trip found
[    1.528132] wmi: Mapper loaded
[    1.676966] input: PC Speaker as /devices/platform/pcspkr/input/input3
[    1.768718] usb 1-2: new high-speed USB device number 3 using xhci_hcd
[    1.846053] SSE version of gcm_enc/dec engaged.
[    1.943886] hub 1-2:1.0: USB hub found
[    1.944178] hub 1-2:1.0: 4 ports detected
[    1.945095] usb: failed to peer 1-2-port1 and usb2-port1 by location (1-=
2-port1:none) (usb2-port1:usb1-port1)
[    1.945103] usb 1-2-port1: failed to peer to usb2-port1 (-16)
[    1.945106] usb: port power management may be unreliable
[    1.945243] usb: failed to peer 1-2-port2 and usb2-port1 by location (1-=
2-port2:none) (usb2-port1:usb1-port1)
[    1.945249] usb 1-2-port2: failed to peer to usb2-port1 (-16)
[    1.945469] rt5645 i2c-10EC5648:00: Fail gpio_request hp_det_gpio
[    1.945539] usb: failed to peer 1-2-port3 and usb2-port1 by location (1-=
2-port3:none) (usb2-port1:usb1-port1)
[    1.945542] usb 1-2-port3: failed to peer to usb2-port1 (-16)
[    1.945570] gpiod_direction_input: invalid GPIO
[    1.945575] rt5645 i2c-10EC5648:00: Fail gpio_direction hp_det_gpio
[    1.945706] usb: failed to peer 1-2-port4 and usb2-port1 by location (1-=
2-port4:none) (usb2-port1:usb1-port1)
[    1.945715] usb 1-2-port4: failed to peer to usb2-port1 (-16)
[    1.960105] mei_txe 0000:00:1a.0: can't derive routing for PCI INT A
[    1.960114] mei_txe 0000:00:1a.0: PCI INT A: no GSI
[    1.967820] media: Linux media interface: v0.10
[    1.979974] intel_rapl: Found RAPL domain package
[    1.979984] intel_rapl: Found RAPL domain core
[    2.001175] [drm] Initialized drm 1.1.0 20060810
[    2.011575] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    2.014733] Linux video capture interface: v2.00
[    2.029112] cfg80211: Calling CRDA to update world regulatory domain
[    2.032140] baytrail-pcm-audio baytrail-pcm-audio: initialising Byt DSP =
IPC
[    2.032267] baytrail-pcm-audio baytrail-pcm-audio: initialising audio DS=
P id 0xf28
[    2.032576] baytrail-pcm-audio baytrail-pcm-audio: header sign=3D$SST\xf=
fffffb4=0D=04 size=3D0x40db4 modules=3D0x1 fmt=3D0x100 size=3D32
[    2.032587] baytrail-pcm-audio baytrail-pcm-audio: block request 0x160 b=
ytes at offset 0xc0000 type 0
[    2.032595] baytrail-pcm-audio baytrail-pcm-audio: block allocated 0:0 a=
t offset 0xc0000
[    2.032630] baytrail-pcm-audio baytrail-pcm-audio: block request 0x170 b=
ytes at offset 0xc0400 type 0
[    2.032667] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 by=
tes at offset 0xc0578 type 0
[    2.032673] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 by=
tes at offset 0xc0598 type 0
[    2.032679] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 by=
tes at offset 0xc05b8 type 0
[    2.032684] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 by=
tes at offset 0xc05d8 type 0
[    2.032690] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 by=
tes at offset 0xc05f8 type 0
[    2.032696] baytrail-pcm-audio baytrail-pcm-audio: block request 0x8 byt=
es at offset 0xc0618 type 0
[    2.032701] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 by=
tes at offset 0xc0638 type 0
[    2.032707] baytrail-pcm-audio baytrail-pcm-audio: block request 0x30 by=
tes at offset 0xc0658 type 0
[    2.032713] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10438=
 bytes at offset 0xc06a0 type 0
[    2.032719] baytrail-pcm-audio baytrail-pcm-audio: block allocated 0:1 a=
t offset 0xc8000
[    2.032724] baytrail-pcm-audio baytrail-pcm-audio: block allocated 0:2 a=
t offset 0xd0000
[    2.045004] baytrail-pcm-audio baytrail-pcm-audio: block request 0x1a310=
 bytes at offset 0x400000 type 3
[    2.050582] uvcvideo: Found UVC 1.00 device USB2.0 VGA UVC WebCam (04f2:=
b483)
[    2.050634] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    2.053320] baytrail-pcm-audio baytrail-pcm-audio: block request 0x5738 =
bytes at offset 0x100010 type 1
[    2.053334] baytrail-pcm-audio baytrail-pcm-audio: block allocated 1:0 a=
t offset 0x100000
[    2.057664] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10ad8=
 bytes at offset 0x105750 type 1
[    2.057675] baytrail-pcm-audio baytrail-pcm-audio: block allocated 1:1 a=
t offset 0x108000
[    2.057681] baytrail-pcm-audio baytrail-pcm-audio: block allocated 1:2 a=
t offset 0x110000
[    2.060940] asus_wmi: ASUS WMI generic driver loaded
[    2.062251] input: USB2.0 VGA UVC WebCam as /devices/pci0000:00/0000:00:=
14.0/usb1/1-1/1-1:1.0/input/input4
[    2.062424] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    2.062434] usbcore: registered new interface driver uvcvideo
[    2.062436] USB Video Class driver (1.1.1)
[    2.065648] asus_wmi: Initialization: 0x1
[    2.068982] asus_wmi: BIOS WMI version: 7.9
[    2.069087] asus_wmi: SFUN value: 0x37
[    2.075104] input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/inp=
ut/input5
[    2.098896] asus_wmi: Number of fans: 1
[    2.100126] iTCO_vendor_support: vendor-support=3D0
[    2.102220] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:7=
 / ret_size:4
[    2.104176] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    2.104285] iTCO_wdt: Found a Bay Trail SoC TCO device (Version=3D3, TCO=
BASE=3D0x0460)
[    2.104903] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[    2.105101] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    2.108718] Bluetooth: Core ver 2.20
[    2.108773] NET: Registered protocol family 31
[    2.108777] Bluetooth: HCI device and connection manager initialized
[    2.108787] Bluetooth: HCI socket layer initialized
[    2.108794] Bluetooth: L2CAP socket layer initialized
[    2.108808] Bluetooth: SCO socket layer initialized
[    2.108870] asus_wmi: Backlight controlled by ACPI video driver
[    2.110096] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    2.110408] Bluetooth: Generic Bluetooth SDIO driver ver 0.1
[    2.117132] [drm] Memory usable by graphics device =3D 2048M
[    2.117142] checking generic (80000000 410000) vs hw (80000000 10000000)
[    2.117146] fb: switching to inteldrmfb from EFI VGA
[    2.117207] Console: switching to colour dummy device 80x25
[    2.117388] [drm] Replacing VGA console driver
[    2.118497] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    2.120048] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.121590] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    2.122900] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:1=
9 / ret_size:4
[    2.122967] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.122974] [drm] Driver supports precise vblank timestamp query.
[    2.124383] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    2.127331] input: PDEC3393:00 0B05:8585 as /devices/platform/80860F41:0=
0/i2c-0/i2c-PDEC3393:00/0018:0B05:8585.0001/input/input6
[    2.142132] hid-generic 0018:0B05:8585.0001: input,hidraw0: <UNKNOWN> HI=
D v1.00 Keyboard [PDEC3393:00 0B05:8585] on=20
[    2.142210] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    2.187091] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    2.199163] brcmfmac: brcmf_sdio_drivestrengthinit: No SDIO Drive streng=
th init done for chip 43340 rev 2 pmurev 20
[    2.199536] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    2.199766] usbcore: registered new interface driver brcmfmac
[    2.200628] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    2.203617] random: nonblocking pool is initialized
[    2.208670] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[    2.211930] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:6=
33 / ret_size:7
[    2.221915] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:1=
31 / ret_size:7
[    2.222125] input: ELAN0100:00 04F3:0401 as /devices/platform/80860F41:0=
3/i2c-3/i2c-ELAN0100:00/0018:04F3:0401.0002/input/input7
[    2.222622] hid-generic 0018:04F3:0401.0002: input,hidraw1: <UNKNOWN> HI=
D v1.00 Mouse [ELAN0100:00 04F3:0401] on=20
[    2.222680] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    2.226775] mousedev: PS/2 mouse device common for all mice
[    2.259879] fbcon: inteldrmfb (fb0) is primary device
[    2.266415] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: n=
o)
[    2.269100] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input8
[    2.269582] [drm] Initialized i915 1.6.0 20150522 for 0000:00:02.0 on mi=
nor 0
[    2.269648] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    2.282308] (NULL device *): ipc: error DSP boot timeout, continue anyway
[    2.282352] (NULL device *): FW version: 04.05.13.a0
[    2.282353] (NULL device *): Build type: a0
[    2.282355] (NULL device *): Build date: Apr  2 2014 14:14:39
[    2.282365] baytrail-pcm-audio: probe success
[    2.287066] byt-rt5645 byt-rt5645: rt5645-aif1 <-> baytrail-pcm-audio ma=
pping ok
[    2.287116] byt-rt5645 byt-rt5645: ASoC: no source widget found for SPOLP
[    2.287120] byt-rt5645 byt-rt5645: ASoC: Failed to add route SPOLP -> di=
rect -> Speaker
[    2.287127] byt-rt5645 byt-rt5645: ASoC: no source widget found for SPOLN
[    2.287130] byt-rt5645 byt-rt5645: ASoC: Failed to add route SPOLN -> di=
rect -> Speaker
[    2.287138] byt-rt5645 byt-rt5645: ASoC: no source widget found for SPORP
[    2.287141] byt-rt5645 byt-rt5645: ASoC: Failed to add route SPORP -> di=
rect -> Speaker
[    2.287148] byt-rt5645 byt-rt5645: ASoC: no source widget found for SPORN
[    2.287151] byt-rt5645 byt-rt5645: ASoC: Failed to add route SPORN -> di=
rect -> Speaker
[    2.287566] rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 ADC1 Swap Mux h=
as no paths
[    2.287572] rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 ADC2 Swap Mux h=
as no paths
[    2.287577] rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 ADC3 Swap Mux h=
as no paths
[    2.287582] rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 ADC Mux has no =
paths
[    2.287653] rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 DAC1 L Mux has =
no paths
[    2.287661] rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 DAC1 R Mux has =
no paths
[    2.287666] rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 DAC2 L Mux has =
no paths
[    2.287671] rt5645 i2c-10EC5648:00: ASoC: mux RT5650 IF1 DAC2 R Mux has =
no paths
[    3.364959] Console: switching to colour frame buffer device 170x48
[    3.379111] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    3.379114] i915 0000:00:02.0: registered panic notifier
[    4.387212] brcmfmac: brcmf_c_preinit_dcmds: Firmware version =3D wl0: J=
un 17 2014 11:48:43 version 6.10.190.49 (r485840) FWID 01-8744bcd2
[    4.401801] brcmfmac: brcmf_cfg80211_reg_notifier: not a ISO3166 code
[    4.488779] brcmfmac: brcmf_add_if: ERROR: netdev:wlan0 already exists
[    4.488789] brcmfmac: brcmf_add_if: ignore IF event
[    5.154523]  Baytrail Audio: PCM: open
[    5.154659]  Baytrail Audio: PCM: hw_free
[    5.154665]  Baytrail Audio: PCM: close
[    5.155068]  Baytrail Audio: PCM: open
[    5.155168]  Baytrail Audio: PCM: hw_free
[    5.155174]  Baytrail Audio: PCM: close
[    5.157412]  Baytrail Audio: PCM: open
[    5.157550]  Baytrail Audio: PCM: hw_free
[    5.157555]  Baytrail Audio: PCM: close
[    5.158048]  Baytrail Audio: PCM: open
[    5.158531]  Baytrail Audio: PCM: hw_free
[    5.158537]  Baytrail Audio: PCM: close
[    5.164027]  Baytrail Audio: PCM: open
[    5.174961] cfg80211: Calling CRDA to update world regulatory domain
[    5.222824]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[    5.482176] cfg80211: Calling CRDA to update world regulatory domain
[    5.524355] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[    5.524378] (NULL device *): ipc: error stream commit failed
[    5.524394]  Baytrail Audio: PCM: failed stream commit -110
[    5.524411] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[    5.524433]  Baytrail Audio: PCM: hw_free
[    5.524542]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[    5.825764] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[    5.825788] (NULL device *): ipc: error stream commit failed
[    5.825803]  Baytrail Audio: PCM: failed stream commit -110
[    5.825821] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[    5.825844]  Baytrail Audio: PCM: hw_free
[    5.825971]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[    6.125682] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[    6.125705] (NULL device *): ipc: error stream commit failed
[    6.125726]  Baytrail Audio: PCM: failed stream commit -110
[    6.125737] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[    6.125751]  Baytrail Audio: PCM: hw_free
[    6.125868]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[    6.426511] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[    6.426535] (NULL device *): ipc: error stream commit failed
[    6.426550]  Baytrail Audio: PCM: failed stream commit -110
[    6.426568] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[    6.426592]  Baytrail Audio: PCM: hw_free
[    6.426706]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[    6.725373] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[    6.725396] (NULL device *): ipc: error stream commit failed
[    6.725412]  Baytrail Audio: PCM: failed stream commit -110
[    6.725429] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[    6.725451]  Baytrail Audio: PCM: hw_free
[    6.725644]  Baytrail Audio: PCM: hw_free
[    6.725663]  Baytrail Audio: PCM: close
[    6.726425]  Baytrail Audio: PCM: open
[    6.726649]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[    7.025913] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[    7.025936] (NULL device *): ipc: error stream commit failed
[    7.025952]  Baytrail Audio: PCM: failed stream commit -110
[    7.025969] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[    7.025990]  Baytrail Audio: PCM: hw_free
[    7.026188]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[    7.325431] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[    7.325454] (NULL device *): ipc: error stream commit failed
[    7.325469]  Baytrail Audio: PCM: failed stream commit -110
[    7.325487] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[    7.325508]  Baytrail Audio: PCM: hw_free
[    7.325706]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[    7.625236] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[    7.625259] (NULL device *): ipc: error stream commit failed
[    7.625275]  Baytrail Audio: PCM: failed stream commit -110
[    7.625295] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[    7.625309]  Baytrail Audio: PCM: hw_free
[    7.625425]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[    7.925525] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[    7.925548] (NULL device *): ipc: error stream commit failed
[    7.925565]  Baytrail Audio: PCM: failed stream commit -110
[    7.925583] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[    7.925597]  Baytrail Audio: PCM: hw_free
[    7.925702]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[    8.225047] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[    8.225070] (NULL device *): ipc: error stream commit failed
[    8.225086]  Baytrail Audio: PCM: failed stream commit -110
[    8.225103] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[    8.225124]  Baytrail Audio: PCM: hw_free
[    8.225267]  Baytrail Audio: PCM: hw_free
[    8.225279]  Baytrail Audio: PCM: close
[    8.226533]  Baytrail Audio: PCM: open
[    8.227112]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[    8.324941] cfg80211: Calling CRDA to update world regulatory domain
[    8.524980] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[    8.525004] (NULL device *): ipc: error stream commit failed
[    8.525020]  Baytrail Audio: PCM: failed stream commit -110
[    8.525038] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[    8.525059]  Baytrail Audio: PCM: hw_free
[    8.525636]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[    8.824860] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[    8.825222] (NULL device *): ipc: error stream commit failed
[    8.825373]  Baytrail Audio: PCM: failed stream commit -110
[    8.825522] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[    8.825752]  Baytrail Audio: PCM: hw_free
[    8.826110]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[    9.125040] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[    9.125370] (NULL device *): ipc: error stream commit failed
[    9.125507]  Baytrail Audio: PCM: failed stream commit -110
[    9.125642] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[    9.125852]  Baytrail Audio: PCM: hw_free
[    9.126147]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[    9.424718] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[    9.425074] (NULL device *): ipc: error stream commit failed
[    9.425230]  Baytrail Audio: PCM: failed stream commit -110
[    9.425384] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[    9.425615]  Baytrail Audio: PCM: hw_free
[    9.425927]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[    9.725912] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[    9.726479] (NULL device *): ipc: error stream commit failed
[    9.726599]  Baytrail Audio: PCM: failed stream commit -110
[    9.726716] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[    9.726901]  Baytrail Audio: PCM: hw_free
[    9.727002]  Baytrail Audio: PCM: hw_free
[    9.727011]  Baytrail Audio: PCM: close
[    9.727589]  Baytrail Audio: PCM: open
[    9.728584]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   10.027992] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   10.028354] (NULL device *): ipc: error stream commit failed
[   10.028505]  Baytrail Audio: PCM: failed stream commit -110
[   10.028651] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   10.028884]  Baytrail Audio: PCM: hw_free
[   10.029277]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   10.327763] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   10.328125] (NULL device *): ipc: error stream commit failed
[   10.328275]  Baytrail Audio: PCM: failed stream commit -110
[   10.328424] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   10.328655]  Baytrail Audio: PCM: hw_free
[   10.329047]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   10.628504] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   10.628772] (NULL device *): ipc: error stream commit failed
[   10.628904]  Baytrail Audio: PCM: failed stream commit -110
[   10.629019] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   10.629196]  Baytrail Audio: PCM: hw_free
[   10.629502]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   10.929081] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   10.929427] (NULL device *): ipc: error stream commit failed
[   10.929557]  Baytrail Audio: PCM: failed stream commit -110
[   10.929683] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   10.929878]  Baytrail Audio: PCM: hw_free
[   10.930146]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   11.231330] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   11.231659] (NULL device *): ipc: error stream commit failed
[   11.231809]  Baytrail Audio: PCM: failed stream commit -110
[   11.231958] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   11.232189]  Baytrail Audio: PCM: hw_free
[   11.232338]  Baytrail Audio: PCM: hw_free
[   11.232350]  Baytrail Audio: PCM: close
[   11.233250]  Baytrail Audio: PCM: open
[   11.233459]  Baytrail Audio: PCM: hw_free
[   11.233471]  Baytrail Audio: PCM: close
[   11.233930]  Baytrail Audio: PCM: open
[   11.234119]  Baytrail Audio: PCM: hw_free
[   11.234131]  Baytrail Audio: PCM: close
[   11.234609]  Baytrail Audio: PCM: open
[   11.234878]  Baytrail Audio: PCM: hw_free
[   11.234890]  Baytrail Audio: PCM: close
[   11.235375]  Baytrail Audio: PCM: open
[   11.236441]  Baytrail Audio: PCM: hw_free
[   11.236454]  Baytrail Audio: PCM: close
[   11.237029]  Baytrail Audio: PCM: open
[   11.237234]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   11.470310] cfg80211: Calling CRDA to update world regulatory domain
[   11.537412] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   11.537757] (NULL device *): ipc: error stream commit failed
[   11.537907]  Baytrail Audio: PCM: failed stream commit -110
[   11.538056] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   11.538288]  Baytrail Audio: PCM: hw_free
[   11.538415]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   11.836281] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   11.836593] (NULL device *): ipc: error stream commit failed
[   11.836743]  Baytrail Audio: PCM: failed stream commit -110
[   11.836892] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   11.845725]  Baytrail Audio: PCM: hw_free
[   11.845847]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   12.147454] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   12.155891] (NULL device *): ipc: error stream commit failed
[   12.162071]  Baytrail Audio: PCM: failed stream commit -110
[   12.167279] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   12.171555]  Baytrail Audio: PCM: hw_free
[   12.171626]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   12.470575] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   12.476948] (NULL device *): ipc: error stream commit failed
[   12.482951]  Baytrail Audio: PCM: failed stream commit -110
[   12.487699] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   12.492006]  Baytrail Audio: PCM: hw_free
[   12.492071]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   12.791081] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   12.800208] (NULL device *): ipc: error stream commit failed
[   12.806553]  Baytrail Audio: PCM: failed stream commit -110
[   12.811721] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   12.816187]  Baytrail Audio: PCM: hw_free
[   12.816259]  Baytrail Audio: PCM: hw_free
[   12.816265]  Baytrail Audio: PCM: close
[   12.816557]  Baytrail Audio: PCM: open
[   12.816673]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   13.117038] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   13.126163] (NULL device *): ipc: error stream commit failed
[   13.132525]  Baytrail Audio: PCM: failed stream commit -110
[   13.137747] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   13.141885]  Baytrail Audio: PCM: hw_free
[   13.141963]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   13.440267] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   13.449410] (NULL device *): ipc: error stream commit failed
[   13.455737]  Baytrail Audio: PCM: failed stream commit -110
[   13.460980] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   13.465113]  Baytrail Audio: PCM: hw_free
[   13.465192]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   13.764015] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   13.773153] (NULL device *): ipc: error stream commit failed
[   13.779746]  Baytrail Audio: PCM: failed stream commit -110
[   13.784949] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   13.789121]  Baytrail Audio: PCM: hw_free
[   13.789187]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   14.090066] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   14.099236] (NULL device *): ipc: error stream commit failed
[   14.105830]  Baytrail Audio: PCM: failed stream commit -110
[   14.111016] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   14.115646]  Baytrail Audio: PCM: hw_free
[   14.115707]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   14.416641] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   14.424773] (NULL device *): ipc: error stream commit failed
[   14.432666]  Baytrail Audio: PCM: failed stream commit -110
[   14.438172] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   14.443048]  Baytrail Audio: PCM: hw_free
[   14.443138]  Baytrail Audio: PCM: hw_free
[   14.443143]  Baytrail Audio: PCM: close
[   14.443456]  Baytrail Audio: PCM: open
[   14.443716]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   14.618770] cfg80211: Calling CRDA to update world regulatory domain
[   14.743268] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   14.752172] (NULL device *): ipc: error stream commit failed
[   14.757974]  Baytrail Audio: PCM: failed stream commit -110
[   14.763106] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   14.767140]  Baytrail Audio: PCM: hw_free
[   14.767321]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   15.066477] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   15.075377] (NULL device *): ipc: error stream commit failed
[   15.081196]  Baytrail Audio: PCM: failed stream commit -110
[   15.086538] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   15.090576]  Baytrail Audio: PCM: hw_free
[   15.090756]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   15.393169] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   15.401329] (NULL device *): ipc: error stream commit failed
[   15.409253]  Baytrail Audio: PCM: failed stream commit -110
[   15.414698] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   15.419591]  Baytrail Audio: PCM: hw_free
[   15.419770]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   15.719611] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   15.728539] (NULL device *): ipc: error stream commit failed
[   15.734364]  Baytrail Audio: PCM: failed stream commit -110
[   15.739330] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   15.743329]  Baytrail Audio: PCM: hw_free
[   15.743488]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   16.042804] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   16.051735] (NULL device *): ipc: error stream commit failed
[   16.057513]  Baytrail Audio: PCM: failed stream commit -110
[   16.062642] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   16.066694]  Baytrail Audio: PCM: hw_free
[   16.066768]  Baytrail Audio: PCM: hw_free
[   16.066774]  Baytrail Audio: PCM: close
[   16.067088]  Baytrail Audio: PCM: open
[   16.067691]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   16.366502] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   16.374058] (NULL device *): ipc: error stream commit failed
[   16.381480]  Baytrail Audio: PCM: failed stream commit -110
[   16.386944] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   16.391674]  Baytrail Audio: PCM: hw_free
[   16.391896]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   16.692631] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   16.701806] (NULL device *): ipc: error stream commit failed
[   16.708175]  Baytrail Audio: PCM: failed stream commit -110
[   16.713497] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   16.717686]  Baytrail Audio: PCM: hw_free
[   16.717882]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   17.016191] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   17.025427] (NULL device *): ipc: error stream commit failed
[   17.031789]  Baytrail Audio: PCM: failed stream commit -110
[   17.037109] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   17.041305]  Baytrail Audio: PCM: hw_free
[   17.041480]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   17.345804] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   17.355026] (NULL device *): ipc: error stream commit failed
[   17.361340]  Baytrail Audio: PCM: failed stream commit -110
[   17.366663] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   17.370845]  Baytrail Audio: PCM: hw_free
[   17.371016]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   17.669286] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   17.677008] (NULL device *): ipc: error stream commit failed
[   17.682800]  Baytrail Audio: PCM: failed stream commit -110
[   17.687808] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   17.691965]  Baytrail Audio: PCM: hw_free
[   17.692048]  Baytrail Audio: PCM: hw_free
[   17.692053]  Baytrail Audio: PCM: close
[   17.694092]  Baytrail Audio: PCM: open
[   17.694212]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   17.767276] cfg80211: Calling CRDA to update world regulatory domain
[   17.992846] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   18.002064] (NULL device *): ipc: error stream commit failed
[   18.008543]  Baytrail Audio: PCM: failed stream commit -110
[   18.013873] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   18.018041]  Baytrail Audio: PCM: hw_free
[   18.018110]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   18.319389] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   18.327819] (NULL device *): ipc: error stream commit failed
[   18.334019]  Baytrail Audio: PCM: failed stream commit -110
[   18.339262] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   18.343399]  Baytrail Audio: PCM: hw_free
[   18.343470]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   18.642045] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   18.651258] (NULL device *): ipc: error stream commit failed
[   18.657542]  Baytrail Audio: PCM: failed stream commit -110
[   18.662860] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   18.662868]  Baytrail Audio: PCM: hw_free
[   18.662942]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   18.962534] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   18.970852] (NULL device *): ipc: error stream commit failed
[   18.979052]  Baytrail Audio: PCM: failed stream commit -110
[   18.984297] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   18.988434]  Baytrail Audio: PCM: hw_free
[   18.988500]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   19.293094] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   19.302185] (NULL device *): ipc: error stream commit failed
[   19.308225]  Baytrail Audio: PCM: failed stream commit -110
[   19.313493] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   19.317645]  Baytrail Audio: PCM: hw_free
[   19.317717]  Baytrail Audio: PCM: hw_free
[   19.317722]  Baytrail Audio: PCM: close
[   19.318106]  Baytrail Audio: PCM: open
[   19.318225]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   19.619450] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   19.627085] (NULL device *): ipc: error stream commit failed
[   19.634499]  Baytrail Audio: PCM: failed stream commit -110
[   19.640314] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   19.645081]  Baytrail Audio: PCM: hw_free
[   19.645157]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   19.948334] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   19.957373] (NULL device *): ipc: error stream commit failed
[   19.963495]  Baytrail Audio: PCM: failed stream commit -110
[   19.968613] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   19.972715]  Baytrail Audio: PCM: hw_free
[   19.972783]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   20.274949] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   20.283206] (NULL device *): ipc: error stream commit failed
[   20.291120]  Baytrail Audio: PCM: failed stream commit -110
[   20.297171] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   20.302020]  Baytrail Audio: PCM: hw_free
[   20.302093]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   20.601604] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   20.610479] (NULL device *): ipc: error stream commit failed
[   20.619156]  Baytrail Audio: PCM: failed stream commit -110
[   20.625565] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   20.630700]  Baytrail Audio: PCM: hw_free
[   20.630774]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   20.926881] cfg80211: Calling CRDA to update world regulatory domain
[   20.934681] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   20.942097] (NULL device *): ipc: error stream commit failed
[   20.949237]  Baytrail Audio: PCM: failed stream commit -110
[   20.954539] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   20.959148]  Baytrail Audio: PCM: hw_free
[   20.959242]  Baytrail Audio: PCM: hw_free
[   20.959247]  Baytrail Audio: PCM: close
[   20.959657]  Baytrail Audio: PCM: open
[   20.959918]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   21.257944] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   21.266823] (NULL device *): ipc: error stream commit failed
[   21.272626]  Baytrail Audio: PCM: failed stream commit -110
[   21.277717] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   21.281740]  Baytrail Audio: PCM: hw_free
[   21.281919]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   21.584885] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   21.591411] (NULL device *): ipc: error stream commit failed
[   21.597047]  Baytrail Audio: PCM: failed stream commit -110
[   21.602338] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   21.606778]  Baytrail Audio: PCM: hw_free
[   21.606957]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   21.908077] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   21.915185] (NULL device *): ipc: error stream commit failed
[   21.920814]  Baytrail Audio: PCM: failed stream commit -110
[   21.925486] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   21.929617]  Baytrail Audio: PCM: hw_free
[   21.929777]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   22.228132] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   22.236551] (NULL device *): ipc: error stream commit failed
[   22.242479]  Baytrail Audio: PCM: failed stream commit -110
[   22.247483] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   22.251814]  Baytrail Audio: PCM: hw_free
[   22.251991]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   22.552083] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   22.559901] (NULL device *): ipc: error stream commit failed
[   22.565892]  Baytrail Audio: PCM: failed stream commit -110
[   22.571589] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   22.575827]  Baytrail Audio: PCM: hw_free
[   22.575901]  Baytrail Audio: PCM: hw_free
[   22.575906]  Baytrail Audio: PCM: close
[   22.576311]  Baytrail Audio: PCM: open
[   22.576920]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   22.877430] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   22.886816] (NULL device *): ipc: error stream commit failed
[   22.893652]  Baytrail Audio: PCM: failed stream commit -110
[   22.899014] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   22.903409]  Baytrail Audio: PCM: hw_free
[   22.903603]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   23.204633] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   23.214104] (NULL device *): ipc: error stream commit failed
[   23.220208]  Baytrail Audio: PCM: failed stream commit -110
[   23.226049] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   23.231346]  Baytrail Audio: PCM: hw_free
[   23.231539]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   23.530568] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   23.539923] (NULL device *): ipc: error stream commit failed
[   23.546644]  Baytrail Audio: PCM: failed stream commit -110
[   23.552046] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   23.556609]  Baytrail Audio: PCM: hw_free
[   23.556783]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   23.857138] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   23.866577] (NULL device *): ipc: error stream commit failed
[   23.873319]  Baytrail Audio: PCM: failed stream commit -110
[   23.878792] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   23.883112]  Baytrail Audio: PCM: hw_free
[   23.883282]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f80
[   24.075910] cfg80211: Calling CRDA to update world regulatory domain
[   24.184009] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002220 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   24.192599] (NULL device *): ipc: error stream commit failed
[   24.198697]  Baytrail Audio: PCM: failed stream commit -110
[   24.203891] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   24.208226]  Baytrail Audio: PCM: hw_free
[   24.208307]  Baytrail Audio: PCM: hw_free
[   24.208313]  Baytrail Audio: PCM: close
[   24.208774]  Baytrail Audio: PCM: open
[   24.208895]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   24.506958] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   24.516380] (NULL device *): ipc: error stream commit failed
[   24.523310]  Baytrail Audio: PCM: failed stream commit -110
[   24.528801] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   24.533140]  Baytrail Audio: PCM: hw_free
[   24.533208]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   24.833521] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   24.842952] (NULL device *): ipc: error stream commit failed
[   24.849705]  Baytrail Audio: PCM: failed stream commit -110
[   24.855170] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   24.859487]  Baytrail Audio: PCM: hw_free
[   24.859555]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   25.160134] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   25.169661] (NULL device *): ipc: error stream commit failed
[   25.175830]  Baytrail Audio: PCM: failed stream commit -110
[   25.181351] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   25.185680]  Baytrail Audio: PCM: hw_free
[   25.185744]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   25.486658] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   25.496113] (NULL device *): ipc: error stream commit failed
[   25.502443]  Baytrail Audio: PCM: failed stream commit -110
[   25.507883] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   25.512156]  Baytrail Audio: PCM: hw_free
[   25.512225]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   25.813280] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   25.823159] (NULL device *): ipc: error stream commit failed
[   25.829390]  Baytrail Audio: PCM: failed stream commit -110
[   25.834860] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   25.839167]  Baytrail Audio: PCM: hw_free
[   25.839238]  Baytrail Audio: PCM: hw_free
[   25.839244]  Baytrail Audio: PCM: close
[   25.839536]  Baytrail Audio: PCM: open
[   25.839662]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20
[   26.139815] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeou=
t-- ipcx 0x4000000000002120 isr 0x3 ipcd 0x80000000002c2081 imrx 0x0
[   26.148407] (NULL device *): ipc: error stream commit failed
[   26.154645]  Baytrail Audio: PCM: failed stream commit -110
[   26.160087] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-au=
dio hw params failed: -110
[   26.164351]  Baytrail Audio: PCM: hw_free
[   26.164420]  Baytrail Audio: PCM: hw_params, pcm_data ffff88007b7b3f20

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-normal.txt"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.1.0-rc5-next-20150528-asus+ (zio@asus) (gcc =
version 5.1.0 (GCC) ) #4 SMP PREEMPT Fri May 29 14:16:09 CEST 2015
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-linux-asus root=3D/dev/m=
mcblk0p2 rw quiet
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] x86/fpu: Using 'lazy' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x000000007bf13fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007bf14000-0x000000007bf43fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007bf44000-0x000000007bf77fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007bf78000-0x000000007c040fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007c041000-0x000000007c928fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007c929000-0x000000007c984fff] type =
20
[    0.000000] BIOS-e820: [mem 0x000000007c985000-0x000000007cbfffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed08fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ffb00000-0x00000000ffffffff] reser=
ved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.31 by American Megatrends
[    0.000000] efi:  ACPI=3D0x7bf77000  ACPI 2.0=3D0x7bf77014  SMBIOS=3D0x7=
c928190=20
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: ASUSTeK COMPUTER INC. X205TA/X205TA, BIOS X205TA.205 10=
/06/2014
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn =3D 0x7cc00 max_arch_pfn =3D 0x400000000
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
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC=
 =20
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
[    0.000000] ACPI: XSDT 0x000000007BF760F8 0000D4 (v01 _ASUS_ Notebook 00=
000003 MSFT 0100000D)
[    0.000000] ACPI: FACP 0x000000007BF72000 00010C (v05 _ASUS_ Notebook 00=
000003 AMI  0100000D)
[    0.000000] ACPI: DSDT 0x000000007BF5B000 0126F4 (v02 _ASUS_ Notebook 00=
000003 AMI  0100000D)
[    0.000000] ACPI: TCPA 0x000000007BF75000 000032 (v02                 00=
000000      00000000)
[    0.000000] ACPI: UEFI 0x000000007BFF4000 000042 (v01 _ASUS_ Notebook 00=
000000      00000000)
[    0.000000] ACPI: OEM0 0x000000007BF74000 000084 (v05 _ASUS_ BATTERY  00=
000003 AMI  0100000D)
[    0.000000] ACPI: DBG2 0x000000007BF73000 000072 (v00 _ASUS_ INTLDBG2 00=
000003 AMI  0100000D)
[    0.000000] ACPI: HPET 0x000000007BF71000 000038 (v01 _ASUS_ Notebook 00=
000003 AMI  0100000D)
[    0.000000] ACPI: LPIT 0x000000007BF70000 000104 (v01 _ASUS_ Notebook 00=
000003 AMI  0100000D)
[    0.000000] ACPI: APIC 0x000000007BF6F000 00006C (v03 _ASUS_ Notebook 00=
000003 AMI  0100000D)
[    0.000000] ACPI: MCFG 0x000000007BF6E000 00003C (v01 _ASUS_ Notebook 00=
000003 AMI  0100000D)
[    0.000000] ACPI: SSDT 0x000000007BF5A000 000603 (v01 _ASUS_ CpuDptf  00=
000003 AMI  0100000D)
[    0.000000] ACPI: SSDT 0x000000007BF58000 001BE2 (v01 _ASUS_ DptfTab  00=
000003 AMI  0100000D)
[    0.000000] ACPI: SSDT 0x000000007BF57000 000058 (v01 _ASUS_ LowPwrM  00=
000003 AMI  0100000D)
[    0.000000] ACPI: SSDT 0x000000007BF56000 0000FF (v01 _ASUS_ SoCDptf  00=
000003 AMI  0100000D)
[    0.000000] ACPI: FPDT 0x000000007BF55000 000044 (v01 _ASUS_ Notebook 01=
072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x000000007BF54000 000763 (v01 PmRef  CpuPm    00=
003000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x000000007BF53000 000290 (v01 PmRef  Cpu0Tst  00=
003000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x000000007BF52000 00017A (v01 PmRef  ApTst    00=
003000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x000000007BF51000 000427 (v01 Intel_ Tpm2Tabl 00=
001000 INTL 20061109)
[    0.000000] ACPI: TPM2 0x000000007BF50000 000034 (v03                 00=
000000      00000000)
[    0.000000] ACPI: BGRT 0x000000007BF4F000 000038 (v01 _ASUS_ Notebook 01=
072009 AMI  00010013)
[    0.000000] ACPI: CSRT 0x000000007BF4E000 00014C (v00 _ASUS_ Notebook 00=
000005 INTL 20120624)
[    0.000000] ACPI: MSDM 0x000000007BF42F90 000055 (v03 _ASUS_ Notebook 00=
000000 ASUS 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000]  [ffffea0000000000-ffffea0001ffffff] PMD -> [ffff880076c0000=
0-ffff880078bfffff] on node 0
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
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000007cbff=
fff]
[    0.000000] On node 0 totalpages: 507691
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 22 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7920 pages used for memmap
[    0.000000]   DMA32 zone: 503695 pages, LIFO batch:31
[    0.000000] x86/hpet: Will disable the HPET for this platform because it=
's not reliable
[    0.000000] Reserving Intel graphics stolen memory at 0x7cf00000-0x7eeff=
fff
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-=
86
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] e820: [mem 0x7ef00000-0xe00f7fff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource refined-jiffies: mask: 0xffffffff max_cycles: 0x=
ffffffff, max_idle_ns: 6370452778343963 ns
[    0.000000] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_no=
de_ids:1
[    0.000000] PERCPU: Embedded 34 pages/cpu @ffff88007ba00000 s99416 r8192=
 d31656 u524288
[    0.000000] pcpu-alloc: s99416 r8192 d31656 u524288 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 499685
[    0.000000] Kernel command line: BOOT_IMAGE=3D/vmlinuz-linux-asus root=
=3D/dev/mmcblk0p2 rw quiet
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 b=
ytes)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 by=
tes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 1936940K/2030764K available (6033K kernel code, 946K=
 rwdata, 1860K rodata, 1180K init, 1132K bss, 93824K reserved, 0K cma-reser=
ved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] NR_IRQS:4352 nr_irqs:1024 0
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] Maximum core-clock to bus-clock ratio: 0x10
[    0.000000] Resolved frequency ID: 0, frequency: 83200 KHz
[    0.000000] TSC runs at 1331200 KHz
[    0.000000] lapic_timer_frequency =3D 277333
[    0.000000] tsc: Detected 1331.200 MHz processor
[    0.000056] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 2663.33 BogoMIPS (lpj=3D4437333)
[    0.000064] pid_max: default: 32768 minimum: 301
[    0.000088] ACPI: Core revision 20150515
[    0.055852] ACPI: All ACPI Tables successfully acquired
[    0.057883] Security Framework initialized
[    0.057891] Yama: becoming mindful.
[    0.057925] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.057932] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 b=
ytes)
[    0.058356] Initializing cgroup subsys blkio
[    0.058366] Initializing cgroup subsys memory
[    0.058386] Initializing cgroup subsys devices
[    0.058394] Initializing cgroup subsys freezer
[    0.058402] Initializing cgroup subsys net_cls
[    0.058436] CPU: Physical Processor ID: 0
[    0.058440] CPU: Processor Core ID: 0
[    0.058448] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.058451] ENERGY_PERF_BIAS: View and update with x86_energy_perf_polic=
y(8)
[    0.063356] mce: CPU supports 6 MCE banks
[    0.063370] CPU0: Thermal monitoring enabled (TM1)
[    0.063376] process: using mwait in idle threads
[    0.063385] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
[    0.063389] Last level dTLB entries: 4KB 128, 2MB 16, 4MB 16, 1GB 0
[    0.063617] Freeing SMP alternatives memory: 20K (ffffffff81a15000 - fff=
fffff81a1a000)
[    0.065231] Ignoring BGRT: invalid status 0 (expected 1)
[    0.069771] ftrace: allocating 22992 entries in 90 pages
[    0.088493] TSC deadline timer enabled
[    0.088503] smpboot: CPU0: Intel(R) Atom(TM) CPU  Z3735F @ 1.33GHz (fam:=
 06, model: 37, stepping: 08)
[    0.088550] Performance Events: PEBS fmt2+, 8-deep LBR, Silvermont event=
s, full-width counters, Intel PMU driver.
[    0.088573] ... version:                3
[    0.088577] ... bit width:              40
[    0.088580] ... generic registers:      2
[    0.088584] ... value mask:             000000ffffffffff
[    0.088587] ... max period:             000000ffffffffff
[    0.088590] ... fixed-purpose events:   3
[    0.088594] ... event mask:             0000000700000003
[    0.102046] x86: Booting SMP configuration:
[    0.102054] .... node  #0, CPUs:      #1
[    0.110261] NMI watchdog: enabled on all CPUs, permanently consumes one =
hw-PMU counter.
[    0.113621]  #2 #3
[    0.133237] x86: Booted up 1 node, 4 CPUs
[    0.133244] smpboot: Total of 4 processors activated (10653.33 BogoMIPS)
[    0.134374] devtmpfs: initialized
[    0.143921] PM: Registering ACPI NVS region [mem 0x0008f000-0x0008ffff] =
(4096 bytes)
[    0.143928] PM: Registering ACPI NVS region [mem 0x7bf78000-0x7c040fff] =
(823296 bytes)
[    0.144160] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 6370867519511994 ns
[    0.144369] pinctrl core: initialized pinctrl subsystem
[    0.144433] RTC time: 12:17:21, date: 05/29/15
[    0.144786] NET: Registered protocol family 16
[    0.159933] cpuidle: using governor ladder
[    0.176620] cpuidle: using governor menu
[    0.176693] ACPI: bus type PCI registered
[    0.176699] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.176877] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.176884] PCI: not using MMCONFIG
[    0.176888] PCI: Using configuration type 1 for base access
[    0.187529] ACPI: Added _OSI(Module Device)
[    0.187537] ACPI: Added _OSI(Processor Device)
[    0.187541] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.187545] ACPI: Added _OSI(Processor Aggregator Device)
[    0.220061] ACPI: Dynamic OEM Table Load:
[    0.220088] ACPI: SSDT 0xFFFF880076BF1800 000501 (v01 PmRef  Cpu0Ist  00=
003000 INTL 20061109)
[    0.222358] ACPI: Dynamic OEM Table Load:
[    0.222381] ACPI: SSDT 0xFFFF880076BF2000 000433 (v01 PmRef  Cpu0Cst  00=
003001 INTL 20061109)
[    0.225270] ACPI: Dynamic OEM Table Load:
[    0.225292] ACPI: SSDT 0xFFFF880076BFAA00 00015F (v01 PmRef  ApIst    00=
003000 INTL 20061109)
[    0.227503] ACPI: Dynamic OEM Table Load:
[    0.227524] ACPI: SSDT 0xFFFF88007B45B000 00008D (v01 PmRef  ApCst    00=
003000 INTL 20061109)
[    0.231806] ACPI: Interpreter enabled
[    0.231827] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [=
\_S1_] (20150515/hwxface-580)
[    0.231842] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [=
\_S2_] (20150515/hwxface-580)
[    0.231855] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [=
\_S3_] (20150515/hwxface-580)
[    0.231878] ACPI: (supports S0 S5)
[    0.231883] ACPI: Using IOAPIC for interrupt routing
[    0.231944] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    0.242574] [Firmware Info]: PCI: MMCONFIG at [mem 0xe0000000-0xefffffff=
] not reserved in ACPI motherboard resources
[    0.242582] PCI: not using MMCONFIG
[    0.242620] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.247247] ACPI: Power Resource [USBC] (on)
[    0.254665] ACPI: Power Resource [PLPE] (on)
[    0.265914] ACPI: Power Resource [CLK0] (on)
[    0.266040] ACPI: Power Resource [CLK1] (on)
[    0.266708] ACPI: Power Resource [P28T] (off)
[    0.266841] ACPI: Power Resource [P18T] (off)
[    0.272310] ACPI: Power Resource [P28X] (off)
[    0.272439] ACPI: Power Resource [P18X] (off)
[    0.272567] ACPI: Power Resource [P28P] (off)
[    0.272693] ACPI: Power Resource [P18P] (off)
[    0.272831] ACPI: Power Resource [P1XT] (off)
[    0.274314] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.282357] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.282373] acpi PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments MS=
I]
[    0.282505] \_SB_.PCI0:_OSC invalid UUID
[    0.282510] _OSC request data:1 1e 0=20
[    0.282522] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    0.282920] acpi PNP0A08:00: fail to add MMCONFIG information, can't acc=
ess extended PCI configuration space under this bridge.
[    0.283434] PCI host bridge to bus 0000:00
[    0.283444] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.283451] pci_bus 0000:00: root bus resource [io  0x0070-0x0077]
[    0.283457] pci_bus 0000:00: root bus resource [io  0x0000-0x006f window]
[    0.283463] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7 window]
[    0.283469] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.283475] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.283482] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dfff=
f window]
[    0.283501] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000ffff=
f window]
[    0.283508] pci_bus 0000:00: root bus resource [mem 0x90c00000-0x90fffff=
f window]
[    0.283514] pci_bus 0000:00: root bus resource [mem 0x7cf00001-0x7ef0000=
0 window]
[    0.283520] pci_bus 0000:00: root bus resource [mem 0x80000000-0x908ffff=
e window]
[    0.283526] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed40ff=
f window]
[    0.283543] pci 0000:00:00.0: [8086:0f00] type 00 class 0x060000
[    0.283792] pci 0000:00:02.0: [8086:0f31] type 00 class 0x030000
[    0.283822] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x903fffff]
[    0.283840] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff pref]
[    0.283857] pci 0000:00:02.0: reg 0x20: [io  0x1000-0x1007]
[    0.284106] pci 0000:00:14.0: [8086:0f35] type 00 class 0x0c0330
[    0.284143] pci 0000:00:14.0: reg 0x10: [mem 0x90800000-0x9080ffff 64bit]
[    0.284211] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.284439] pci 0000:00:1a.0: [8086:0f18] type 00 class 0x108000
[    0.284480] pci 0000:00:1a.0: reg 0x10: [mem 0x90700000-0x907fffff]
[    0.284497] pci 0000:00:1a.0: reg 0x14: [mem 0x90600000-0x906fffff]
[    0.284580] pci 0000:00:1a.0: PME# supported from D0 D3hot
[    0.284803] pci 0000:00:1f.0: [8086:0f1c] type 00 class 0x060100
[    0.285078] pci_bus 0000:00: on NUMA node 0
[    0.285888] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15=
) *0, disabled.
[    0.286078] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15=
) *0, disabled.
[    0.286263] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15=
) *0, disabled.
[    0.286448] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15=
) *0, disabled.
[    0.286640] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15=
) *0, disabled.
[    0.286847] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15=
) *0, disabled.
[    0.287035] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15=
) *0, disabled.
[    0.287220] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15=
) *0, disabled.
[    0.300417] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.300426] vgaarb: device added: PCI:0000:00:02.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    0.300432] vgaarb: loaded
[    0.300436] vgaarb: bridge control possible 0000:00:02.0
[    0.300603] SCSI subsystem initialized
[    0.300627] ACPI: bus type USB registered
[    0.300689] usbcore: registered new interface driver usbfs
[    0.300723] usbcore: registered new interface driver hub
[    0.300794] usbcore: registered new device driver usb
[    0.316845] PCI: Using ACPI for IRQ routing
[    0.316854] PCI: pci_cache_line_size set to 64 bytes
[    0.316884] Expanded resource reserved due to conflict with PCI Bus 0000=
:00
[    0.316891] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.316896] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.316901] e820: reserve RAM buffer [mem 0x7bf14000-0x7bffffff]
[    0.316905] e820: reserve RAM buffer [mem 0x7cc00000-0x7fffffff]
[    0.317237] NetLabel: Initializing
[    0.317243] NetLabel:  domain hash size =3D 128
[    0.317246] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    0.317275] NetLabel:  unlabeled traffic allowed by default
[    0.317375] Switched to clocksource refined-jiffies
[    0.333004] pnp: PnP ACPI init
[    0.333158] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.333661] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.333670] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.333676] system 00:01: [io  0x0500-0x05fe] has been reserved
[    0.333683] system 00:01: [io  0x0600-0x061f] has been reserved
[    0.333690] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.333700] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.333974] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.335561] system 00:03: [io  0x0240-0x0259] has been reserved
[    0.335573] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.348559] pnp: PnP ACPI: found 4 devices
[    0.354404] pci_bus 0000:00: resource 4 [io  0x0070-0x0077]
[    0.354413] pci_bus 0000:00: resource 5 [io  0x0000-0x006f window]
[    0.354420] pci_bus 0000:00: resource 6 [io  0x0078-0x0cf7 window]
[    0.354426] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.354432] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff windo=
w]
[    0.354438] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff windo=
w]
[    0.354444] pci_bus 0000:00: resource 10 [mem 0x000e0000-0x000fffff wind=
ow]
[    0.354451] pci_bus 0000:00: resource 11 [mem 0x90c00000-0x90ffffff wind=
ow]
[    0.354457] pci_bus 0000:00: resource 12 [mem 0x7cf00001-0x7ef00000 wind=
ow]
[    0.354463] pci_bus 0000:00: resource 13 [mem 0x80000000-0x908ffffe wind=
ow]
[    0.354469] pci_bus 0000:00: resource 14 [mem 0xfed40000-0xfed40fff wind=
ow]
[    0.354545] NET: Registered protocol family 2
[    0.354849] TCP established hash table entries: 16384 (order: 5, 131072 =
bytes)
[    0.354924] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
[    0.355043] TCP: Hash tables configured (established 16384 bind 16384)
[    0.355098] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.355126] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.355244] NET: Registered protocol family 1
[    0.355284] pci 0000:00:02.0: Video device with shadowed ROM
[    0.355665] PCI: CLS 0 bytes, default 64
[    0.355791] Unpacking initramfs...
[    0.452318] Freeing initrd memory: 2368K (ffff880037b50000 - ffff880037d=
a0000)
[    0.452615] microcode: CPU0 sig=3D0x30678, pf=3D0x2, revision=3D0x829
[    0.452643] microcode: CPU1 sig=3D0x30678, pf=3D0x2, revision=3D0x829
[    0.452662] microcode: CPU2 sig=3D0x30678, pf=3D0x2, revision=3D0x829
[    0.452681] microcode: CPU3 sig=3D0x30678, pf=3D0x2, revision=3D0x829
[    0.452796] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.f=
snet.co.uk>, Peter Oruba
[    0.452872] Scanning for low memory corruption every 60 seconds
[    0.453579] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.453615] Initialise system trusted keyring
[    0.454382] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.458969] zpool: loaded
[    0.458977] zbud: loaded
[    0.459411] VFS: Disk quotas dquot_6.6.0
[    0.459519] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.460668] Key type big_key registered
[    0.461081] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 252)
[    0.461175] io scheduler noop registered
[    0.461183] io scheduler deadline registered
[    0.461279] io scheduler cfq registered (default)
[    0.461425] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.461474] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.461561] efifb: probing for efifb
[    0.461594] efifb: framebuffer at 0x80000000, mapped to 0xffffc900008000=
00, using 4160k, total 4160k
[    0.461599] efifb: mode is 1366x768x32, linelength=3D5504, pages=3D1
[    0.461602] efifb: scrolling: redraw
[    0.461608] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.472127] Console: switching to colour frame buffer device 170x48
[    0.482334] fb0: EFI VGA frame buffer device
[    0.482363] intel_idle: MWAIT substates: 0x33000020
[    0.482368] intel_idle: v0.4 model 0x37
[    0.482372] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.482900] GHES: HEST is not enabled!
[    0.483054] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.503347] 00:02: ttyS0 at I/O 0x3f8 (irq =3D 203, base_baud =3D 115200=
) is a 16550A
[    0.504256] hpet: number irqs doesn't agree with number of timers
[    0.504321] Linux agpgart interface v0.103
[    0.505308] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.505326] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[    0.505736] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
00 quirks 0x00009810
[    0.505748] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    0.506267] hub 1-0:1.0: USB hub found
[    0.506294] hub 1-0:1.0: 6 ports detected
[    0.507533] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.507545] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[    0.507963] hub 2-0:1.0: USB hub found
[    0.507988] hub 2-0:1.0: 1 port detected
[    0.508395] usbcore: registered new interface driver usb-storage
[    0.508433] ACPI Warning: Could not enable fixed event - RealTimeClock (=
4) (20150515/evxface-654)
[    0.508645] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    0.508690] rtc_cmos 00:00: alarms up to one day, 242 bytes nvram
[    0.508716] i2c /dev entries driver
[    0.509152] Intel P-state driver initializing.
[    0.509591] sdhci: Secure Digital Host Controller Interface driver
[    0.509603] sdhci: Copyright(c) Pierre Ossman
[    0.510863] sdhci-acpi 80860F14:00: No vmmc regulator found
[    0.510881] sdhci-acpi 80860F14:00: No vqmmc regulator found
[    0.514244] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
[    0.515740] sdhci-acpi INT33BB:00: No vmmc regulator found
[    0.515759] sdhci-acpi INT33BB:00: No vqmmc regulator found
[    0.519139] mmc1: SDHCI controller on ACPI [INT33BB:00] using ADMA
[    0.520354] sdhci-acpi PNP0FFF:00: No vmmc regulator found
[    0.520363] sdhci-acpi PNP0FFF:00: No vqmmc regulator found
[    0.523540] mmc2: SDHCI controller on ACPI [PNP0FFF:00] using ADMA
[    0.523624] ledtrig-cpu: registered to indicate activity on CPUs
[    0.524686] NET: Registered protocol family 10
[    0.525369] NET: Registered protocol family 17
[    0.526560] Loading compiled-in X.509 certificates
[    0.526603] registered taskstats version 1
[    0.527090]   Magic number: 15:165:280
[    0.527138] tty tty17: hash matches
[    0.527280] rtc_cmos 00:00: setting system clock to 2015-05-29 12:17:21 =
UTC (1432901841)
[    0.528502] Freeing unused kernel memory: 1180K (ffffffff818ee000 - ffff=
ffff81a15000)
[    0.528510] Write protecting the kernel read-only data: 8192k
[    0.528922] Freeing unused kernel memory: 100K (ffff8800015e7000 - ffff8=
80001600000)
[    0.529075] Freeing unused kernel memory: 188K (ffff8800017d1000 - ffff8=
80001800000)
[    0.546132] random: systemd-tmpfile urandom read with 3 bits of entropy =
available
[    0.643798] mmc0: MAN_BKOPS_EN bit is not set
[    0.653908] mmc0: new HS200 MMC card at address 0001
[    0.654170] mmcblk0: mmc0:0001 HBG4e=05 29.1 GiB=20
[    0.654250] mmcblk0boot0: mmc0:0001 HBG4e=05 partition 1 4.00 MiB
[    0.654334] mmcblk0boot1: mmc0:0001 HBG4e=05 partition 2 4.00 MiB
[    0.654429] mmcblk0rpmb: mmc0:0001 HBG4e=05 partition 3 4.00 MiB
[    0.656899]  mmcblk0: p1 p2
[    0.740566] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    0.742081] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    0.743580] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    0.746276] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    0.805199] mmc1: queuing unknown CIS tuple 0x91 (3 bytes)
[    0.805237] mmc1: new ultra high speed DDR50 SDIO card at address 0001
[    0.836510] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mo=
de. Opts: (null)
[    0.882118] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    0.941661] systemd[1]: systemd 219 running in system mode. (+PAM -AUDIT=
 -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNU=
TLS +ACL +XZ +LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD +IDN)
[    0.942035] systemd[1]: Detected architecture 'x86-64'.
[    0.943874] systemd[1]: Set hostname to <asus>.
[    1.002513] systemd[1]: Unit type .busname is not supported on this syst=
em.
[    1.055202] systemd[1]: Unit type .swap is not supported on this system.
[    1.058791] systemd[1]: Cannot add dependency job for unit org.freedeskt=
op.resolve1.busname, ignoring: Unit org.freedesktop.resolve1.busname failed=
 to load: No such file or directory.
[    1.059871] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    1.059899] systemd[1]: Starting Dispatch Password Requests to Console D=
irectory Watch.
[    1.060366] systemd[1]: Created slice Root Slice.
[    1.060392] systemd[1]: Starting Root Slice.
[    1.060553] systemd[1]: Listening on networkd rtnetlink socket.
[    1.060576] systemd[1]: Starting networkd rtnetlink socket.
[    1.060659] systemd[1]: Listening on Journal Socket (/dev/log).
[    1.060684] systemd[1]: Starting Journal Socket (/dev/log).
[    1.060743] systemd[1]: Listening on Delayed Shutdown Socket.
[    1.060765] systemd[1]: Starting Delayed Shutdown Socket.
[    1.061024] systemd[1]: Created slice System Slice.
[    1.061055] systemd[1]: Starting System Slice.
[    1.061315] systemd[1]: Created slice system-getty.slice.
[    1.061339] systemd[1]: Starting system-getty.slice.
[    1.061574] systemd[1]: Created slice system-wpa_supplicant.slice.
[    1.061599] systemd[1]: Starting system-wpa_supplicant.slice.
[    1.071910] systemd[1]: Listening on Journal Audit Socket.
[    1.071974] systemd[1]: Reached target Swap.
[    1.072002] systemd[1]: Starting Swap.
[    1.072248] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    1.072280] systemd[1]: Starting Arbitrary Executable File Formats File =
System Automount Point.
[    1.072363] systemd[1]: Listening on udev Kernel Socket.
[    1.072389] systemd[1]: Starting udev Kernel Socket.
[    1.072470] systemd[1]: Listening on udev Control Socket.
[    1.072497] systemd[1]: Starting udev Control Socket.
[    1.072857] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    1.072884] systemd[1]: Starting system-systemd\x2dfsck.slice.
[    1.072923] systemd[1]: Reached target Encrypted Volumes.
[    1.072949] systemd[1]: Starting Encrypted Volumes.
[    1.073067] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    1.073093] systemd[1]: Starting Forward Password Requests to Wall Direc=
tory Watch.
[    1.073186] systemd[1]: Listening on /dev/initctl Compatibility Named Pi=
pe.
[    1.073213] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[    1.073255] systemd[1]: Reached target Paths.
[    1.073280] systemd[1]: Starting Paths.
[    1.073361] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    1.073388] systemd[1]: Starting Device-mapper event daemon FIFOs.
[    1.073651] systemd[1]: Created slice User and Session Slice.
[    1.073677] systemd[1]: Starting User and Session Slice.
[    1.073714] systemd[1]: Reached target Remote File Systems.
[    1.073740] systemd[1]: Starting Remote File Systems.
[    1.073820] systemd[1]: Listening on LVM2 metadata daemon socket.
[    1.073847] systemd[1]: Starting LVM2 metadata daemon socket.
[    1.073950] systemd[1]: Listening on Journal Socket.
[    1.073985] systemd[1]: Starting Journal Socket.
[    1.075147] systemd[1]: Mounting POSIX Message Queue File System...
[    1.076647] systemd[1]: Starting Journal Service...
[    1.078141] systemd[1]: Started Load Kernel Modules.
[    1.078241] systemd[1]: Mounted FUSE Control File System.
[    1.082086] systemd[1]: Mounting Temporary Directory...
[    1.083659] systemd[1]: Starting Apply Kernel Variables...
[    1.083752] systemd[1]: Started File System Check on Root Device.
[    1.085505] systemd[1]: Starting udev Coldplug all Devices...
[    1.087607] systemd[1]: Started Set Up Additional Binary Formats.
[    1.089034] systemd[1]: Mounting Huge Pages File System...
[    1.090791] systemd[1]: Starting Setup Virtual Console...
[    1.093185] systemd[1]: Starting Remount Root and Kernel File Systems...
[    1.095573] systemd[1]: Mounting Configuration File System...
[    1.097569] systemd[1]: Starting Create list of required static device n=
odes for the current kernel...
[    1.101147] systemd[1]: Mounting Debug File System...
[    1.101212] systemd[1]: Reached target Slices.
[    1.101282] systemd[1]: Starting Slices.
[    1.103189] systemd[1]: Mounted POSIX Message Queue File System.
[    1.103279] systemd[1]: Mounted Debug File System.
[    1.103340] systemd[1]: Mounted Huge Pages File System.
[    1.103401] systemd[1]: Mounted Temporary Directory.
[    1.106333] EXT4-fs (mmcblk0p2): re-mounted. Opts: data=3Dordered,commit=
=3D60
[    1.111237] systemd-journald[125]: Failed to set file attributes: Inappr=
opriate ioctl for device
[    1.111299] systemd[1]: Started Remount Root and Kernel File Systems.
[    1.111748] systemd[1]: Mounted Configuration File System.
[    1.112417] systemd[1]: Started Create list of required static device no=
des for the current kernel.
[    1.133068] systemd[1]: Started Apply Kernel Variables.
[    1.139831] systemd[1]: Started udev Coldplug all Devices.
[    1.160940] systemd[1]: Started First Boot Wizard.
[    1.161028] systemd[1]: Started Rebuild Dynamic Linker Cache.
[    1.161075] systemd[1]: Started Create System Users.
[    1.162631] systemd[1]: Starting Create Static Device Nodes in /dev...
[    1.164191] systemd[1]: Starting Load/Save Random Seed...
[    1.165990] systemd[1]: Started Rebuild Hardware Database.
[    1.172627] systemd[1]: Started Load/Save Random Seed.
[    1.193389] systemd[1]: Started Create Static Device Nodes in /dev.
[    1.193585] systemd[1]: Reached target Local File Systems (Pre).
[    1.193616] systemd[1]: Starting Local File Systems (Pre).
[    1.195741] systemd[1]: Starting udev Kernel Device Manager...
[    1.200616] systemd[1]: Started Setup Virtual Console.
[    1.236364] systemd[1]: Started udev Kernel Device Manager.
[    1.259387] systemd[1]: Started Journal Service.
[    1.273025] hidraw: raw HID events driver (C) Jiri Kosina
[    1.273380] systemd-journald[125]: Received request to flush runtime jou=
rnal from PID 1
[    1.347305] 80860F0A:00: ttyS1 at MMIO 0x90941000 (irq =3D 191, base_bau=
d =3D 2764800) is a 16550A
[    1.347827] 80860F0A:01: ttyS2 at MMIO 0x90947000 (irq =3D 193, base_bau=
d =3D 2764800) is a 16550A
[    1.348824] dw_dmac INTL9C60:00: DesignWare DMA Controller, 8 channels
[    1.349553] dw_dmac INTL9C60:01: DesignWare DMA Controller, 8 channels
[    1.353797] ACPI: AC Adapter [ADP1] (off-line)
[    1.438306] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input0
[    1.438365] ACPI: Lid Switch [LID]
[    1.438491] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[    1.438499] ACPI: Power Button [PWRB]
[    1.438620] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input2
[    1.438628] ACPI: Sleep Button [SLPB]
[    1.439252] wmi: Mapper loaded
[    1.441199] [Firmware Bug]: No valid trip found
[    1.469635] ACPI: Battery Slot [BATC] (battery present)
[    1.500095] clocksource tsc: mask: 0xffffffffffffffff max_cycles: 0x1330=
3f810e3, max_idle_ns: 440795235405 ns
[    1.500127] Switched to clocksource tsc
[    1.642670] input: PC Speaker as /devices/platform/pcspkr/input/input3
[    1.705436] mei_txe 0000:00:1a.0: can't derive routing for PCI INT A
[    1.705445] mei_txe 0000:00:1a.0: PCI INT A: no GSI
[    1.705976] cfg80211: Calling CRDA to update world regulatory domain
[    1.715221] [drm] Initialized drm 1.1.0 20060810
[    1.719978] SSE version of gcm_enc/dec engaged.
[    1.770231] usb 1-2: new high-speed USB device number 3 using xhci_hcd
[    1.791633] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    1.805330] rt5645 i2c-10EC5648:00: Fail gpio_request hp_det_gpio
[    1.805434] gpiod_direction_input: invalid GPIO
[    1.805439] rt5645 i2c-10EC5648:00: Fail gpio_direction hp_det_gpio
[    1.805744] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    1.833041] Bluetooth: Core ver 2.20
[    1.833080] NET: Registered protocol family 31
[    1.833085] Bluetooth: HCI device and connection manager initialized
[    1.833094] Bluetooth: HCI socket layer initialized
[    1.833100] Bluetooth: L2CAP socket layer initialized
[    1.833114] Bluetooth: SCO socket layer initialized
[    1.843474] Bluetooth: Generic Bluetooth SDIO driver ver 0.1
[    1.848109] asus_wmi: ASUS WMI generic driver loaded
[    1.851051] asus_wmi: Initialization: 0x1
[    1.851205] asus_wmi: BIOS WMI version: 7.9
[    1.851374] asus_wmi: SFUN value: 0x37
[    1.853400] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    1.854576] input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/inp=
ut/input4
[    1.854919] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    1.856448] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    1.857800] asus_wmi: Number of fans: 1
[    1.859184] intel_rapl: Found RAPL domain package
[    1.859192] intel_rapl: Found RAPL domain core
[    1.859241] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    1.861666] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    1.863045] baytrail-pcm-audio baytrail-pcm-audio: initialising Byt DSP =
IPC
[    1.863550] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:7=
 / ret_size:4
[    1.863777] baytrail-pcm-audio baytrail-pcm-audio: initialising audio DS=
P id 0xf28
[    1.864409] asus_wmi: Backlight controlled by ACPI video driver
[    1.864543] baytrail-pcm-audio baytrail-pcm-audio: header sign=3D$SST\xf=
fffffb4=0D=04 size=3D0x40db4 modules=3D0x1 fmt=3D0x100 size=3D32
[    1.864554] baytrail-pcm-audio baytrail-pcm-audio: block request 0x160 b=
ytes at offset 0xc0000 type 0
[    1.864561] baytrail-pcm-audio baytrail-pcm-audio: block allocated 0:0 a=
t offset 0xc0000
[    1.864597] baytrail-pcm-audio baytrail-pcm-audio: block request 0x170 b=
ytes at offset 0xc0400 type 0
[    1.864633] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 by=
tes at offset 0xc0578 type 0
[    1.864639] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 by=
tes at offset 0xc0598 type 0
[    1.864645] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 by=
tes at offset 0xc05b8 type 0
[    1.864651] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 by=
tes at offset 0xc05d8 type 0
[    1.864657] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 by=
tes at offset 0xc05f8 type 0
[    1.864662] baytrail-pcm-audio baytrail-pcm-audio: block request 0x8 byt=
es at offset 0xc0618 type 0
[    1.864668] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10 by=
tes at offset 0xc0638 type 0
[    1.864674] baytrail-pcm-audio baytrail-pcm-audio: block request 0x30 by=
tes at offset 0xc0658 type 0
[    1.864680] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10438=
 bytes at offset 0xc06a0 type 0
[    1.864686] baytrail-pcm-audio baytrail-pcm-audio: block allocated 0:1 a=
t offset 0xc8000
[    1.864691] baytrail-pcm-audio baytrail-pcm-audio: block allocated 0:2 a=
t offset 0xd0000
[    1.865040] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    1.871433] baytrail-pcm-audio baytrail-pcm-audio: block request 0x1a310=
 bytes at offset 0x400000 type 3
[    1.873358] [drm] Memory usable by graphics device =3D 2048M
[    1.873368] checking generic (80000000 410000) vs hw (80000000 10000000)
[    1.873372] fb: switching to inteldrmfb from EFI VGA
[    1.873416] Console: switching to colour dummy device 80x25
[    1.873636] [drm] Replacing VGA console driver
[    1.873691] baytrail-pcm-audio baytrail-pcm-audio: block request 0x5738 =
bytes at offset 0x100010 type 1
[    1.873698] baytrail-pcm-audio baytrail-pcm-audio: block allocated 1:0 a=
t offset 0x100000
[    1.875935] baytrail-pcm-audio baytrail-pcm-audio: block request 0x10ad8=
 bytes at offset 0x105750 type 1
[    1.875942] baytrail-pcm-audio baytrail-pcm-audio: block allocated 1:1 a=
t offset 0x108000
[    1.875947] baytrail-pcm-audio baytrail-pcm-audio: block allocated 1:2 a=
t offset 0x110000
[    1.877106] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:1=
9 / ret_size:4
[    1.878189] input: PDEC3393:00 0B05:8585 as /devices/platform/80860F41:0=
0/i2c-0/i2c-PDEC3393:00/0018:0B05:8585.0001/input/input5
[    1.879710] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.879717] [drm] Driver supports precise vblank timestamp query.
[    1.881107] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[    1.897076] iTCO_vendor_support: vendor-support=3D0
[    1.898194] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    1.898299] iTCO_wdt: Found a Bay Trail SoC TCO device (Version=3D3, TCO=
BASE=3D0x0460)
[    1.898616] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[    1.898770] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    1.914087] hid-generic 0018:0B05:8585.0001: input,hidraw0: <UNKNOWN> HI=
D v1.00 Keyboard [PDEC3393:00 0B05:8585] on=20
[    1.914161] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    1.919987] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    1.936166] fbcon: inteldrmfb (fb0) is primary device
[    1.936903] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: n=
o)
[    1.937296] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input6
[    1.937584] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    1.937594] [drm] Initialized i915 1.6.0 20150522 for 0000:00:02.0 on mi=
nor 0
[    1.937668] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    1.938182] brcmfmac: brcmf_sdio_drivestrengthinit: No SDIO Drive streng=
th init done for chip 43340 rev 2 pmurev 20
[    1.938648] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    1.939179] usbcore: registered new interface driver brcmfmac
[    1.943565] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    1.945535] hub 1-2:1.0: USB hub found
[    1.945829] hub 1-2:1.0: 4 ports detected
[    1.946823] usb: failed to peer 1-2-port1 and usb2-port1 by location (1-=
2-port1:none) (usb2-port1:usb1-port1)
[    1.946827] usb 1-2-port1: failed to peer to usb2-port1 (-16)
[    1.946828] usb: port power management may be unreliable
[    1.946963] usb: failed to peer 1-2-port2 and usb2-port1 by location (1-=
2-port2:none) (usb2-port1:usb1-port1)
[    1.946966] usb 1-2-port2: failed to peer to usb2-port1 (-16)
[    1.947103] usb: failed to peer 1-2-port3 and usb2-port1 by location (1-=
2-port3:none) (usb2-port1:usb1-port1)
[    1.947106] usb 1-2-port3: failed to peer to usb2-port1 (-16)
[    1.947237] usb: failed to peer 1-2-port4 and usb2-port1 by location (1-=
2-port4:none) (usb2-port1:usb1-port1)
[    1.947240] usb 1-2-port4: failed to peer to usb2-port1 (-16)
[    1.948647] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    1.954951] media: Linux media interface: v0.10
[    1.964168] Linux video capture interface: v2.00
[    1.983523] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:6=
33 / ret_size:7
[    1.993448] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:1=
31 / ret_size:7
[    1.994452] uvcvideo: Found UVC 1.00 device USB2.0 VGA UVC WebCam (04f2:=
b483)
[    1.994504] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    1.995237] input: ELAN0100:00 04F3:0401 as /devices/platform/80860F41:0=
3/i2c-3/i2c-ELAN0100:00/0018:04F3:0401.0002/input/input7
[    1.997100] random: nonblocking pool is initialized
[    1.997204] hid-generic 0018:04F3:0401.0002: input,hidraw1: <UNKNOWN> HI=
D v1.00 Mouse [ELAN0100:00 04F3:0401] on=20
[    1.997460] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    2.003923] input: USB2.0 VGA UVC WebCam as /devices/pci0000:00/0000:00:=
14.0/usb1/1-1/1-1:1.0/input/input8
[    2.004087] usbcore: registered new interface driver uvcvideo
[    2.004088] USB Video Class driver (1.1.1)
[    2.004993] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not =
registered
[    2.006240] mousedev: PS/2 mouse device common for all mice
[    2.080067] (NULL device *): ipc: error DSP boot timeout
[    2.080191] baytrail-pcm-audio: probe fail dsp
[    3.039777] Console: switching to colour frame buffer device 170x48
[    3.062743] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    3.062747] i915 0000:00:02.0: registered panic notifier
[    4.134945] brcmfmac: brcmf_c_preinit_dcmds: Firmware version =3D wl0: J=
un 17 2014 11:48:43 version 6.10.190.49 (r485840) FWID 01-8744bcd2
[    4.150446] brcmfmac: brcmf_cfg80211_reg_notifier: not a ISO3166 code
[    4.236523] brcmfmac: brcmf_add_if: ERROR: netdev:wlan0 already exists
[    4.236531] brcmfmac: brcmf_add_if: ignore IF event
[    4.855895] cfg80211: Calling CRDA to update world regulatory domain
[    5.265764] cfg80211: Calling CRDA to update world regulatory domain
[    8.008864] cfg80211: Calling CRDA to update world regulatory domain
[   11.158436] cfg80211: Calling CRDA to update world regulatory domain
[   14.304424] cfg80211: Calling CRDA to update world regulatory domain
[   17.449358] cfg80211: Calling CRDA to update world regulatory domain
[   20.595084] cfg80211: Calling CRDA to update world regulatory domain
[   23.742243] cfg80211: Calling CRDA to update world regulatory domain
[   26.886529] cfg80211: Calling CRDA to update world regulatory domain
[   30.032246] cfg80211: Calling CRDA to update world regulatory domain

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lsmod-ignore-dsp.txt"

Module                  Size  Used by
joydev                 20480  0 
mousedev               20480  0 
nls_iso8859_1          16384  1 
uvcvideo               86016  0 
videobuf2_vmalloc      16384  1 uvcvideo
nls_cp437              20480  1 
i915                 1060864  2 
iTCO_wdt               16384  0 
asus_nb_wmi            24576  0 
asus_wmi               24576  1 asus_nb_wmi
iTCO_vendor_support    16384  1 iTCO_wdt
evdev                  24576  4 
led_class              16384  1 asus_wmi
videobuf2_memops       16384  1 videobuf2_vmalloc
mac_hid                16384  0 
sparse_keymap          16384  1 asus_wmi
videobuf2_core         40960  1 uvcvideo
coretemp               16384  0 
btsdio                 16384  0 
hwmon                  16384  2 coretemp,asus_wmi
v4l2_common            16384  1 videobuf2_core
snd_soc_sst_baytrail_pcm    24576  2 
intel_rapl             20480  0 
i2c_algo_bit           16384  1 i915
vfat                   20480  1 
snd_soc_sst_ipc        16384  1 snd_soc_sst_baytrail_pcm
bluetooth             442368  2 btsdio
videodev              147456  3 uvcvideo,v4l2_common,videobuf2_core
fat                    65536  1 vfat
snd_soc_sst_dsp        36864  1 snd_soc_sst_baytrail_pcm
drm_kms_helper        102400  1 i915
intel_soc_dts_thermal    16384  0 
intel_powerclamp       16384  0 
snd_soc_sst_byt_rt5645_mach    16384  0 
hid_generic            16384  0 
kvm_intel             159744  0 
media                  20480  2 uvcvideo,videodev
mei_txe                20480  0 
lpc_ich                24576  0 
mei                    77824  1 mei_txe
drm                   290816  4 i915,drm_kms_helper
mfd_core               16384  1 lpc_ich
intel_gtt              20480  1 i915
kvm                   434176  1 kvm_intel
brcmfmac              225280  0 
crct10dif_pclmul       16384  0 
crc32_pclmul           16384  0 
crc32c_intel           24576  0 
ghash_clmulni_intel    16384  0 
cfg80211              471040  1 brcmfmac
snd_soc_rt5645        106496  1 
regmap_i2c             16384  1 snd_soc_rt5645
snd_soc_rl6231         16384  1 snd_soc_rt5645
snd_soc_core          155648  3 snd_soc_rt5645,snd_soc_sst_baytrail_pcm,snd_soc_sst_byt_rt5645_mach
rfkill                 20480  4 cfg80211,bluetooth,asus_wmi
brcmutil               16384  1 brcmfmac
aesni_intel           172032  0 
snd_compress           20480  1 snd_soc_core
snd_pcm                86016  4 snd_soc_rt5645,snd_soc_core,snd_soc_sst_baytrail_pcm
aes_x86_64             20480  1 aesni_intel
glue_helper            16384  1 aesni_intel
lrw                    16384  1 aesni_intel
gf128mul               16384  1 lrw
ablk_helper            16384  1 aesni_intel
cryptd                 20480  3 ghash_clmulni_intel,aesni_intel,ablk_helper
pcspkr                 16384  0 
tpm_crb                16384  0 
thermal                20480  0 
processor_thermal_device    16384  0 
tpm                    32768  1 tpm_crb
snd_timer              28672  1 snd_pcm
intel_soc_dts_iosf     16384  2 intel_soc_dts_thermal,processor_thermal_device
wmi                    20480  1 asus_wmi
iosf_mbi               16384  2 intel_soc_dts_iosf,intel_rapl
button                 16384  1 i915
video                  20480  2 i915,asus_wmi
snd                    57344  5 snd_soc_core,snd_timer,snd_pcm,snd_compress
dw_dmac                16384  0 
dw_dmac_core           24576  2 dw_dmac,snd_soc_sst_dsp
int3402_thermal        16384  0 
soundcore              16384  1 snd
acpi_pad               16384  0 
int3403_thermal        16384  0 
ac                     16384  0 
int340x_thermal_zone    16384  3 int3402_thermal,processor_thermal_device,int3403_thermal
int3400_thermal        16384  0 
acpi_thermal_rel       16384  1 int3400_thermal
battery                16384  0 
spi_pxa2xx_platform    24576  0 
snd_soc_sst_acpi       16384  0 
i2c_hid                20480  0 
hid                   110592  2 i2c_hid,hid_generic
8250_dw                16384  0 
processor              28672  0 
sch_fq_codel           20480  2 

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lsmod-normal.txt"

Module                  Size  Used by
nls_iso8859_1          16384  1 
nls_cp437              20480  1 
mousedev               20480  0 
iTCO_wdt               16384  0 
joydev                 20480  0 
iTCO_vendor_support    16384  1 iTCO_wdt
vfat                   20480  1 
fat                    65536  1 vfat
uvcvideo               86016  0 
btsdio                 16384  0 
videobuf2_vmalloc      16384  1 uvcvideo
videobuf2_memops       16384  1 videobuf2_vmalloc
asus_nb_wmi            24576  0 
mac_hid                16384  0 
bluetooth             442368  2 btsdio
coretemp               16384  0 
asus_wmi               24576  1 asus_nb_wmi
intel_rapl             20480  0 
videobuf2_core         40960  1 uvcvideo
hwmon                  16384  2 coretemp,asus_wmi
led_class              16384  1 asus_wmi
sparse_keymap          16384  1 asus_wmi
intel_soc_dts_thermal    16384  0 
v4l2_common            16384  1 videobuf2_core
intel_powerclamp       16384  0 
evdev                  24576  11 
videodev              147456  3 uvcvideo,v4l2_common,videobuf2_core
media                  20480  2 uvcvideo,videodev
kvm_intel             159744  0 
brcmfmac              225280  0 
kvm                   434176  1 kvm_intel
snd_soc_rt5645        106496  0 
cfg80211              471040  1 brcmfmac
snd_soc_sst_baytrail_pcm    24576  0 
snd_soc_sst_ipc        16384  1 snd_soc_sst_baytrail_pcm
crct10dif_pclmul       16384  0 
regmap_i2c             16384  1 snd_soc_rt5645
snd_soc_sst_dsp        36864  1 snd_soc_sst_baytrail_pcm
snd_soc_sst_byt_rt5645_mach    16384  0 
crc32_pclmul           16384  0 
snd_soc_rl6231         16384  1 snd_soc_rt5645
snd_soc_core          155648  3 snd_soc_rt5645,snd_soc_sst_baytrail_pcm,snd_soc_sst_byt_rt5645_mach
hid_generic            16384  0 
crc32c_intel           24576  0 
rfkill                 20480  4 cfg80211,bluetooth,asus_wmi
brcmutil               16384  1 brcmfmac
ghash_clmulni_intel    16384  0 
aesni_intel           172032  0 
lpc_ich                24576  0 
mfd_core               16384  1 lpc_ich
i915                 1060864  2 
i2c_algo_bit           16384  1 i915
drm_kms_helper        102400  1 i915
mei_txe                20480  0 
drm                   290816  4 i915,drm_kms_helper
mei                    77824  1 mei_txe
snd_compress           20480  1 snd_soc_core
intel_gtt              20480  1 i915
aes_x86_64             20480  1 aesni_intel
snd_pcm                86016  3 snd_soc_rt5645,snd_soc_core,snd_soc_sst_baytrail_pcm
glue_helper            16384  1 aesni_intel
lrw                    16384  1 aesni_intel
gf128mul               16384  1 lrw
ablk_helper            16384  1 aesni_intel
cryptd                 20480  3 ghash_clmulni_intel,aesni_intel,ablk_helper
pcspkr                 16384  0 
processor_thermal_device    16384  0 
dw_dmac                16384  0 
tpm_crb                16384  0 
thermal                20480  0 
tpm                    32768  1 tpm_crb
wmi                    20480  1 asus_wmi
snd_timer              28672  1 snd_pcm
intel_soc_dts_iosf     16384  2 intel_soc_dts_thermal,processor_thermal_device
dw_dmac_core           24576  2 dw_dmac,snd_soc_sst_dsp
video                  20480  2 i915,asus_wmi
button                 16384  1 i915
int3402_thermal        16384  0 
int3403_thermal        16384  0 
snd                    57344  4 snd_soc_core,snd_timer,snd_pcm,snd_compress
iosf_mbi               16384  2 intel_soc_dts_iosf,intel_rapl
int3400_thermal        16384  0 
acpi_thermal_rel       16384  1 int3400_thermal
int340x_thermal_zone    16384  3 int3402_thermal,processor_thermal_device,int3403_thermal
acpi_pad               16384  0 
soundcore              16384  1 snd
ac                     16384  0 
spi_pxa2xx_platform    24576  0 
battery                16384  0 
i2c_hid                20480  0 
8250_dw                16384  0 
snd_soc_sst_acpi       16384  0 
hid                   110592  2 i2c_hid,hid_generic
processor              28672  0 
sch_fq_codel           20480  2 

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kernel-config.txt"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 4.1.0-rc5 Kernel Configuration
#
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_MMU=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_X86_HT=y
CONFIG_ARCH_HWEIGHT_CFLAGS="-fcall-saved-rdi -fcall-saved-rsi -fcall-saved-rdx -fcall-saved-rcx -fcall-saved-r8 -fcall-saved-r9 -fcall-saved-r10 -fcall-saved-r11"
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION="-asus"
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_KDBUS is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_FHANDLE=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
# CONFIG_TASKS_RCU is not set
CONFIG_RCU_STALL_COMMON=y
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_RCU_EXPEDITE_BOOT is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=19
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
# CONFIG_BPF_SYSCALL is not set
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_USERFAULTFD=y
CONFIG_PCI_QUIRKS=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_ATTRS=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_CC_STACKPROTECTOR=y
CONFIG_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
CONFIG_CC_STACKPROTECTOR_REGULAR=y
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS=y
CONFIG_MODULE_COMPRESS_GZIP=y
# CONFIG_MODULE_COMPRESS_XZ is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_STOP_MACHINE=y
CONFIG_BLOCK=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_CMDLINE_PARSER is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=y
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLOCK_COMPAT=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_CFQ_GROUP_IOSCHED=y
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=m
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_XEN=y
CONFIG_XEN_DOM0=y
CONFIG_XEN_PVHVM=y
CONFIG_XEN_MAX_DOMAIN_MEMORY=500
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
CONFIG_XEN_PVH=y
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
CONFIG_MATOM=y
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
CONFIG_CALGARY_IOMMU=y
CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT=y
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS=4
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
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_MICROCODE_INTEL_EARLY=y
CONFIG_MICROCODE_EARLY=y
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_NUMA is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_CLEANCACHE=y
# CONFIG_CMA is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
# CONFIG_X86_INTEL_MPX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_AUTOSLEEP=y
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_INITRD_TABLE_OVERRIDE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
# CONFIG_ACPI_APEI_EINJ is not set
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_EXTLOG is not set
CONFIG_PMIC_OPREGION=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
CONFIG_INTEL_IDLE=y

#
# Memory power savings
#
# CONFIG_I7300_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
# CONFIG_PCIE_ECRC is not set
# CONFIG_PCIEAER_INJECT is not set
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_HT_IRQ=y
CONFIG_PCI_ATS=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y

#
# PCI host controller drivers
#
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
CONFIG_HOTPLUG_PCI_CPCI=y
# CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
# CONFIG_HOTPLUG_PCI_CPCI_GENERIC is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
# CONFIG_X86_X32 is not set
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_KEYS_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_PMC_ATOM=y
CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
# CONFIG_NET_IP_TUNNEL is not set
CONFIG_IP_MROUTE=y
# CONFIG_IP_MROUTE_MULTIPLE_TABLES is not set
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
# CONFIG_NET_UDP_TUNNEL is not set
# CONFIG_NET_FOU is not set
# CONFIG_GENEVE_CORE is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
CONFIG_INET_LRO=y
# CONFIG_INET_DIAG is not set
CONFIG_TCP_CONG_ADVANCED=y
# CONFIG_TCP_CONG_BIC is not set
CONFIG_TCP_CONG_CUBIC=y
# CONFIG_TCP_CONG_WESTWOOD is not set
# CONFIG_TCP_CONG_HTCP is not set
# CONFIG_TCP_CONG_HSTCP is not set
# CONFIG_TCP_CONG_HYBLA is not set
# CONFIG_TCP_CONG_VEGAS is not set
# CONFIG_TCP_CONG_SCALABLE is not set
# CONFIG_TCP_CONG_LP is not set
# CONFIG_TCP_CONG_VENO is not set
# CONFIG_TCP_CONG_YEAH is not set
# CONFIG_TCP_CONG_ILLINOIS is not set
# CONFIG_TCP_CONG_DCTCP is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
# CONFIG_INET6_XFRM_MODE_BEET is not set
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_SIT is not set
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
# CONFIG_IPV6_MROUTE is not set
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_NETFILTER_ADVANCED=y

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_INGRESS is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
# CONFIG_NETFILTER_NETLINK_LOG is not set
# CONFIG_NF_CONNTRACK is not set
# CONFIG_NF_TABLES is not set
# CONFIG_NETFILTER_XTABLES is not set
# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
# CONFIG_NF_DEFRAG_IPV4 is not set
# CONFIG_NF_LOG_ARP is not set
# CONFIG_NF_LOG_IPV4 is not set
# CONFIG_NF_REJECT_IPV4 is not set
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_DEFRAG_IPV6 is not set
# CONFIG_NF_REJECT_IPV6 is not set
# CONFIG_NF_LOG_IPV6 is not set
# CONFIG_IP6_NF_IPTABLES is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
# CONFIG_NET_SCH_CBQ is not set
# CONFIG_NET_SCH_HTB is not set
# CONFIG_NET_SCH_HFSC is not set
# CONFIG_NET_SCH_PRIO is not set
# CONFIG_NET_SCH_MULTIQ is not set
# CONFIG_NET_SCH_RED is not set
# CONFIG_NET_SCH_SFB is not set
# CONFIG_NET_SCH_SFQ is not set
# CONFIG_NET_SCH_TEQL is not set
# CONFIG_NET_SCH_TBF is not set
# CONFIG_NET_SCH_GRED is not set
# CONFIG_NET_SCH_DSMARK is not set
# CONFIG_NET_SCH_NETEM is not set
# CONFIG_NET_SCH_DRR is not set
# CONFIG_NET_SCH_MQPRIO is not set
# CONFIG_NET_SCH_CHOKE is not set
# CONFIG_NET_SCH_QFQ is not set
# CONFIG_NET_SCH_CODEL is not set
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_FQ is not set
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
# CONFIG_NET_SCH_INGRESS is not set
# CONFIG_NET_SCH_PLUG is not set

#
# Classification
#
# CONFIG_NET_CLS_BASIC is not set
# CONFIG_NET_CLS_TCINDEX is not set
# CONFIG_NET_CLS_ROUTE4 is not set
# CONFIG_NET_CLS_FW is not set
# CONFIG_NET_CLS_U32 is not set
# CONFIG_NET_CLS_RSVP is not set
# CONFIG_NET_CLS_RSVP6 is not set
# CONFIG_NET_CLS_FLOW is not set
# CONFIG_NET_CLS_CGROUP is not set
# CONFIG_NET_CLS_BPF is not set
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_EMATCH is not set
CONFIG_NET_CLS_ACT=y
# CONFIG_NET_ACT_POLICE is not set
# CONFIG_NET_ACT_GACT is not set
# CONFIG_NET_ACT_MIRRED is not set
# CONFIG_NET_ACT_NAT is not set
# CONFIG_NET_ACT_PEDIT is not set
# CONFIG_NET_ACT_SIMP is not set
# CONFIG_NET_ACT_SKBEDIT is not set
# CONFIG_NET_ACT_CSUM is not set
# CONFIG_NET_ACT_VLAN is not set
# CONFIG_NET_ACT_BPF is not set
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
# CONFIG_DNS_RESOLVER is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_MMAP=y
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=y
# CONFIG_NET_MPLS_GSO is not set
# CONFIG_MPLS_ROUTING is not set
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_TCPPROBE is not set
# CONFIG_NET_DROP_MONITOR is not set
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
# CONFIG_AX25 is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
CONFIG_BT=m
CONFIG_BT_BREDR=y
# CONFIG_BT_RFCOMM is not set
# CONFIG_BT_BNEP is not set
# CONFIG_BT_HIDP is not set
CONFIG_BT_LE=y
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
CONFIG_BT_HCIBTSDIO=m
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
# CONFIG_BT_HCIVHCI is not set
# CONFIG_BT_MRVL is not set
# CONFIG_AF_RXRPC is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_REG_DEBUG is not set
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
# CONFIG_CFG80211_INTERNAL_REGDB is not set
CONFIG_CFG80211_WEXT=y
# CONFIG_LIB80211 is not set
# CONFIG_MAC80211 is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_HAVE_BPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
CONFIG_SYS_HYPERVISOR=y
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_REGMAP_MMIO=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_FENCE_TRACE is not set

#
# Bus devices
#
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_MTD is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_PMEM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_XEN_BLKDEV_FRONTEND is not set
# CONFIG_XEN_BLKDEV_BACKEND is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1780 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_TI_DAC7512 is not set
# CONFIG_VMWARE_BALLOON is not set
# CONFIG_BMP085_I2C is not set
# CONFIG_BMP085_SPI is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set

#
# Altera FPGA firmware download module
#
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
# CONFIG_INTEL_MEI_ME is not set
CONFIG_INTEL_MEI_TXE=m
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_CXL_BASE is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_NETLINK is not set
# CONFIG_SCSI_MQ_DEFAULT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
# CONFIG_MEGARAID_MM is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
# CONFIG_ATA is not set
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
# CONFIG_BCACHE is not set
# CONFIG_BLK_DEV_DM is not set
# CONFIG_TARGET_CORE is not set
CONFIG_FUSION=y
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_SAS is not set
CONFIG_FUSION_MAX_SGE=128
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=m
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#
# CONFIG_VHOST_NET is not set

#
# Distributed Switch Architecture drivers
#
# CONFIG_NET_DSA_MV88E6XXX is not set
# CONFIG_NET_DSA_MV88E6XXX_NEED_PPU is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
# CONFIG_ULI526X is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
# CONFIG_E1000 is not set
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_FM10K is not set
CONFIG_NET_VENDOR_I825XX=y
# CONFIG_IP1000 is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX4_CORE is not set
# CONFIG_MLX5_CORE is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
CONFIG_NET_VENDOR_QUALCOMM=y
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
# CONFIG_SFC is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_USB_NET_DRIVERS is not set
CONFIG_WLAN=y
# CONFIG_AIRO is not set
# CONFIG_ATMEL is not set
# CONFIG_PRISM54 is not set
# CONFIG_USB_ZD1201 is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_ATH_CARDS is not set
CONFIG_BRCMUTIL=m
CONFIG_BRCMFMAC=m
CONFIG_BRCMFMAC_PROTO_BCDC=y
CONFIG_BRCMFMAC_PROTO_MSGBUF=y
CONFIG_BRCMFMAC_SDIO=y
CONFIG_BRCMFMAC_USB=y
CONFIG_BRCMFMAC_PCIE=y
# CONFIG_BRCM_TRACING is not set
# CONFIG_BRCMDBG is not set
# CONFIG_HOSTAP is not set
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_LIBERTAS is not set
# CONFIG_HERMES is not set
CONFIG_WL_TI=y
# CONFIG_MWIFIEX is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_XEN_NETDEV_FRONTEND is not set
# CONFIG_XEN_NETDEV_BACKEND is not set
# CONFIG_VMXNET3 is not set
CONFIG_ISDN=y
# CONFIG_ISDN_I4L is not set
# CONFIG_ISDN_CAPI is not set
# CONFIG_ISDN_DRV_GIGASET is not set
# CONFIG_HYSDN is not set
# CONFIG_MISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_ATKBD is not set
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
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
# CONFIG_JOYSTICK_ZHENHUA is not set
# CONFIG_JOYSTICK_AS5011 is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_GTCO is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_MPU3050 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GP2A is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_TILT_POLLED is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_UINPUT is not set
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_XEN_KBDDEV_FRONTEND is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
# CONFIG_N_HDLC is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DW=m
# CONFIG_SERIAL_8250_FINTEK is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=m
# CONFIG_TCG_TIS is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=m
# CONFIG_TCG_TIS_ST33ZP24 is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX_DMA=y
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_DESIGNWARE is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set

#
# PPS support
#
# CONFIG_PPS is not set

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PINCTRL=y

#
# Pin controllers
#
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
CONFIG_GPIOLIB=y
CONFIG_GPIO_DEVRES=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_IT8761E is not set
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_VX855 is not set

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_SX150X is not set

#
# MFD GPIO expanders
#

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_INTEL_MID is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MCP23S08 is not set
# CONFIG_GPIO_MC33880 is not set

#
# USB GPIO expanders
#
# CONFIG_W1 is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_BATTERY_BQ27x00 is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_AVS=y
CONFIG_HWMON=m
# CONFIG_HWMON_VID is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7314 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7310 is not set
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_HTU21 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_ADCXX is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM70 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH56XX_COMMON is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS1015 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_POWERCLAMP=m
# CONFIG_X86_PKG_TEMP_THERMAL is not set
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
CONFIG_INTEL_SOC_DTS_THERMAL=m
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m

#
# Texas Instruments thermal drivers
#
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
CONFIG_ITCO_WDT=m
CONFIG_ITCO_VENDOR_SUPPORT=y
# CONFIG_IT8712F_WDT is not set
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_MEN_A21_WDT is not set
# CONFIG_XEN_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=m
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_AXP20X is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RTSX_PCI is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RTSX_USB is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RN5T618 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
# CONFIG_AB3100_CORE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_REGULATOR is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_RC_SUPPORT=y
CONFIG_MEDIA_CONTROLLER=y
# CONFIG_MEDIA_CONTROLLER_DVB is not set
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_DVB_CORE=m
CONFIG_DVB_NET=y
# CONFIG_TTPCI_EEPROM is not set
CONFIG_DVB_MAX_ADAPTERS=8
# CONFIG_DVB_DYNAMIC_MINORS is not set

#
# Media drivers
#
CONFIG_RC_CORE=m
# CONFIG_RC_MAP is not set
CONFIG_RC_DECODERS=y
# CONFIG_LIRC is not set
# CONFIG_IR_NEC_DECODER is not set
# CONFIG_IR_RC5_DECODER is not set
# CONFIG_IR_RC6_DECODER is not set
# CONFIG_IR_JVC_DECODER is not set
# CONFIG_IR_SONY_DECODER is not set
# CONFIG_IR_SANYO_DECODER is not set
# CONFIG_IR_SHARP_DECODER is not set
# CONFIG_IR_MCE_KBD_DECODER is not set
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_IR_ENE is not set
# CONFIG_IR_HIX5HD2 is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_IR_GPIO_CIR is not set
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
# CONFIG_USB_GSPCA is not set
# CONFIG_USB_PWC is not set
# CONFIG_VIDEO_CPIA2 is not set
# CONFIG_USB_ZR364XX is not set
# CONFIG_USB_STKWEBCAM is not set
# CONFIG_USB_S2255 is not set
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
# CONFIG_VIDEO_PVRUSB2 is not set
# CONFIG_VIDEO_HDPVR is not set
# CONFIG_VIDEO_USBVISION is not set
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
# CONFIG_VIDEO_AU0828 is not set
# CONFIG_VIDEO_CX231XX is not set
# CONFIG_VIDEO_TM6000 is not set

#
# Digital TV USB devices
#
# CONFIG_DVB_USB is not set
# CONFIG_DVB_USB_V2 is not set
# CONFIG_DVB_TTUSB_BUDGET is not set
# CONFIG_DVB_TTUSB_DEC is not set
# CONFIG_SMS_USB_DRV is not set
# CONFIG_DVB_B2C2_FLEXCOP_USB is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
# CONFIG_VIDEO_EM28XX is not set

#
# Software defined radio USB devices
#
# CONFIG_USB_AIRSPY is not set
# CONFIG_USB_HACKRF is not set
# CONFIG_USB_MSI2500 is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#

#
# Media capture/analog TV support
#
# CONFIG_VIDEO_IVTV is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
# CONFIG_VIDEO_CX18 is not set
# CONFIG_VIDEO_CX23885 is not set
# CONFIG_VIDEO_CX25821 is not set
# CONFIG_VIDEO_CX88 is not set
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_SAA7164 is not set

#
# Media digital TV PCI Adapters
#
# CONFIG_DVB_AV7110 is not set
# CONFIG_DVB_BUDGET_CORE is not set
# CONFIG_DVB_B2C2_FLEXCOP_PCI is not set
# CONFIG_DVB_PLUTO2 is not set
# CONFIG_DVB_DM1105 is not set
# CONFIG_DVB_PT1 is not set
# CONFIG_DVB_PT3 is not set
# CONFIG_MANTIS_CORE is not set
# CONFIG_DVB_NGENE is not set
# CONFIG_DVB_DDBRIDGE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
# CONFIG_VIDEO_MEM2MEM_DEINTERLACE is not set
# CONFIG_VIDEO_SH_VEU is not set
CONFIG_V4L_TEST_DRIVERS=y
# CONFIG_VIDEO_VIVID is not set
# CONFIG_VIDEO_VIM2M is not set

#
# Supported MMC/SDIO adapters
#
# CONFIG_SMS_SDIO_DRV is not set
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_SI470X=y
# CONFIG_USB_SI470X is not set
# CONFIG_I2C_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#
# CONFIG_CYPRESS_FIRMWARE is not set

#
# Media ancillary drivers (tuners, sensors, i2c, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

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
# Audio/Video compression chips
#

#
# Miscellaneous helper chips
#

#
# Sensors used on soc_camera driver
#
CONFIG_MEDIA_TUNER=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MC44S803=m

#
# Multistandard (satellite) frontends
#

#
# Multistandard (cable + terrestrial) frontends
#

#
# DVB-S (satellite) frontends
#

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_AS102_FE is not set

#
# DVB-C (cable) frontends
#

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#

#
# ISDB-T (terrestrial) frontends
#

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#

#
# Digital terrestrial only tuners/PLL
#

#
# SEC control devices for DVB-S
#

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set

#
# Graphics support
#
CONFIG_AGP=y
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_VIA is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_VGA_SWITCHEROO=y

#
# Direct Rendering Manager
#
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_LOAD_EDID_FIRMWARE=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_ADV7511 is not set
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_KMS=y
CONFIG_DRM_I915_FBDEV=y
# CONFIG_DRM_I915_PRELIMINARY_HW_SUPPORT is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#

#
# Frame buffer Devices
#
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CMDLINE=y
# CONFIG_FB_DDC is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
# CONFIG_FB_SYS_FILLRECT is not set
# CONFIG_FB_SYS_COPYAREA is not set
# CONFIG_FB_SYS_IMAGEBLIT is not set
# CONFIG_FB_FOREIGN_ENDIAN is not set
# CONFIG_FB_SYS_FOPS is not set
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
# CONFIG_FB_SIMPLE is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_VGASTATE is not set
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_LOGO is not set
CONFIG_SOUND=m
# CONFIG_SOUND_OSS_CORE is not set
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
# CONFIG_SND_SEQUENCER is not set
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_HRTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_RAWMIDI_SEQ is not set
# CONFIG_SND_OPL3_LIB_SEQ is not set
# CONFIG_SND_OPL4_LIB_SEQ is not set
# CONFIG_SND_SBAWE_SEQ is not set
# CONFIG_SND_EMU10K1_SEQ is not set
CONFIG_SND_DRIVERS=y
# CONFIG_SND_PCSP is not set
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_UA101 is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_USB_CAIAQ is not set
# CONFIG_SND_USB_US122L is not set
# CONFIG_SND_USB_6FIRE is not set
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
CONFIG_SND_SOC=m
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
CONFIG_SND_SOC_INTEL_SST=m
CONFIG_SND_SOC_INTEL_SST_ACPI=m
CONFIG_SND_SOC_INTEL_BAYTRAIL=m
# CONFIG_SND_SOC_INTEL_HASWELL_MACH is not set
# CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_RT5645_MACH=m
# CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH is not set
# CONFIG_SND_SOC_INTEL_BROADWELL_MACH is not set
# CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH is not set
# CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH is not set
# CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH is not set
# CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH is not set
# CONFIG_SND_SOC_QCOM is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_HDMI_CODEC is not set
# CONFIG_SND_SOC_ES8328 is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1792A is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
CONFIG_SND_SOC_RL6231=m
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5645=m
# CONFIG_SND_SOC_RT5677_SPI is not set
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
# CONFIG_SND_SOC_SSM4567 is not set
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
# CONFIG_SND_SOC_TS3A227E is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_TPA6130A2 is not set
# CONFIG_SND_SIMPLE_CARD is not set
# CONFIG_SOUND_PRIME is not set

#
# HID support
#
CONFIG_HID=m
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set

#
# USB HID support
#
# CONFIG_USB_HID is not set
CONFIG_HID_PID=y

#
# I2C HID support
#
CONFIG_I2C_HID=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_FSM is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_MON is not set
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_FUSBH200_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set

#
# USB Physical Layer drivers
#
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FOTG210_UDC is not set
# CONFIG_USB_GR_UDC is not set
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_PXA27X is not set
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_MV_U3D is not set
# CONFIG_USB_M66592 is not set
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_DUMMY_HCD is not set
# CONFIG_USB_CONFIGFS is not set
# CONFIG_USB_ZERO is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FUNCTIONFS is not set
# CONFIG_USB_MASS_STORAGE is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_G_WEBCAM is not set
CONFIG_USB_LED_TRIG=y
# CONFIG_UWB is not set
CONFIG_MMC=y
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_CLKGATE is not set

#
# MMC/SD/SDIO Card Drivers
#
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_MMC_BLOCK_BOUNCE=y
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_SDHCI=y
# CONFIG_MMC_SDHCI_PCI is not set
CONFIG_MMC_SDHCI_ACPI=y
# CONFIG_MMC_SDHCI_PLTFM is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=m
# CONFIG_LEDS_CLASS_FLASH is not set

#
# LED drivers
#
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_LP8860 is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_DELL_NETBOOKS is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_PM8941_WLED is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
CONFIG_ACCESSIBILITY=y
CONFIG_A11Y_BRAILLE_CONSOLE=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_MM_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_ISL12057 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_DS3234 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_MCP795 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
# CONFIG_INTEL_IOATDMA is not set
CONFIG_DW_DMAC_CORE=m
CONFIG_DW_DMAC=m
# CONFIG_DW_DMAC_PCI is not set
# CONFIG_HSU_DMA_PCI is not set
CONFIG_DMA_ENGINE=y
CONFIG_DMA_ACPI=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_AUXDISPLAY=y
# CONFIG_UIO is not set
# CONFIG_VFIO is not set
CONFIG_VIRT_DRIVERS=y

#
# Virtio drivers
#
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=y
CONFIG_XEN_BALLOON_MEMORY_HOTPLUG_LIMIT=512
CONFIG_XEN_SCRUB_PAGES=y
# CONFIG_XEN_DEV_EVTCHN is not set
CONFIG_XEN_BACKEND=y
# CONFIG_XENFS is not set
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_TMEM=m
# CONFIG_XEN_PCIDEV_BACKEND is not set
CONFIG_XEN_PRIVCMD=m
# CONFIG_XEN_ACPI_PROCESSOR is not set
# CONFIG_XEN_MCE_LOG is not set
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_STAGING=y
# CONFIG_SLICOSS is not set
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_R8723AU is not set
# CONFIG_RTS5208 is not set
# CONFIG_FB_SM7XX is not set
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set
# CONFIG_FT1000 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# CONFIG_TOUCHSCREEN_SYNAPTICS_I2C_RMI4 is not set
CONFIG_STAGING_MEDIA=y
# CONFIG_I2C_BCM2048 is not set
# CONFIG_DVB_CXD2099 is not set
# CONFIG_DVB_MN88472 is not set
# CONFIG_DVB_MN88473 is not set

#
# Android
#
# CONFIG_USB_WPAN_HCD is not set
# CONFIG_WIMAX_GDM72XX is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_LUSTRE_FS is not set
# CONFIG_DGNC is not set
# CONFIG_DGAP is not set
# CONFIG_GS_FPGABOOT is not set
CONFIG_CRYPTO_SKEIN=y
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000 is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACERHDF is not set
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_DELL_WMI is not set
# CONFIG_DELL_WMI_AIO is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_HP_WMI is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_COMPAL_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_EEEPC_LAPTOP is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_EEEPC_WMI is not set
CONFIG_ACPI_WMI=m
# CONFIG_MSI_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_IBM_RTL is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_MXM_WMI is not set
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
CONFIG_INTEL_SMARTCONNECT=y
# CONFIG_PVPANIC is not set
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
# CONFIG_CHROMEOS_PSTORE is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_CDCE706 is not set

#
# Hardware Spinlock drivers
#

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IOVA=y
CONFIG_AMD_IOMMU=y
# CONFIG_AMD_IOMMU_STATS is not set
# CONFIG_AMD_IOMMU_V2 is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y

#
# Remoteproc drivers
#
# CONFIG_STE_MODEM_RPROC is not set

#
# Rpmsg drivers
#

#
# SOC (System On Chip) specific Drivers
#
# CONFIG_SUNXI_SRAM is not set
# CONFIG_SOC_TI is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
# CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND is not set
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set
# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=m
# CONFIG_MCB is not set
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
# CONFIG_ISCSI_IBFT is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_RUNTIME_MAP=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_UEFI_CPER=y

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT23=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_ENCRYPTION is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_FILE_LOCKING=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_LOGFS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
# CONFIG_PSTORE_RAM is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_CEPH_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x0
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KMEMCHECK=y
CONFIG_HAVE_ARCH_KASAN=y
# CONFIG_KASAN is not set
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_TIMER_STATS=y
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
# CONFIG_SPARSE_RCU_POINTER is not set
# CONFIG_TORTURE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_CPU_STALL_INFO is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS=y
# CONFIG_DEBUG_STRICT_USER_COPY_CHECKS is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_FP_TEST=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENT=y
CONFIG_UPROBE_EVENT=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
CONFIG_MMIOTRACE=y
# CONFIG_MMIOTRACE_TEST is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_TRACE_ENUM_MAP_FILE is not set

#
# Runtime Testing
#
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_MEMTEST is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_STRICT_DEVMEM=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
CONFIG_EARLY_PRINTK_EFI=y
# CONFIG_X86_PTDUMP is not set
CONFIG_DEBUG_RODATA=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_SET_MODULE_RONX=y
# CONFIG_DEBUG_NX_TEST is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
# CONFIG_IOMMU_STRESS is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
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
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_STATIC_CPU_HAS is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_SECURITY_PATH=y
# CONFIG_INTEL_TXT is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
CONFIG_SECURITY_YAMA=y
CONFIG_SECURITY_YAMA_STACKED=y
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
# CONFIG_DEFAULT_SECURITY_YAMA is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=m
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_PCOMP2=y
CONFIG_CRYPTO_MANAGER=m
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=m
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
# CONFIG_CRYPTO_MCRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_ABLK_HELPER=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_SEQIV is not set
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
# CONFIG_CRYPTO_CBC is not set
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# CONFIG_CRYPTO_GHASH is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
# CONFIG_CRYPTO_SHA1_MB is not set
CONFIG_CRYPTO_SHA256=m
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_X86_64=m
CONFIG_CRYPTO_AES_NI_INTEL=m
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SALSA20_X86_64 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_ZLIB is not set
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
# CONFIG_CRYPTO_DRBG_MENU is not set
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
CONFIG_CRYPTO_DEV_CCP=y
# CONFIG_CRYPTO_DEV_CCP_DD is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_APIC_ARCHITECTURE=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_KVM_DEVICE_ASSIGNMENT=y
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_IO=y
CONFIG_PERCPU_RWSEM=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
# CONFIG_CRC8 is not set
# CONFIG_CRC64_ECMA is not set
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=y
CONFIG_AVERAGE=y
# CONFIG_CORDIC is not set
CONFIG_DDR=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONTS=y
# CONFIG_FONT_8x8 is not set
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_6x10 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_10x18 is not set
CONFIG_FONT_AUTOSELECT=y
CONFIG_ARCH_HAS_SG_CHAIN=y

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="proc-stat.txt"
Content-Transfer-Encoding: quoted-printable

cpu  318 0 341 36929 347 0 105 0 0 0
cpu0 25 0 82 9368 63 0 83 0 0 0
cpu1 63 0 89 9336 82 0 5 0 0 0
cpu2 101 0 89 9237 115 0 8 0 0 0
cpu3 127 0 79 8986 85 0 7 0 0 0
intr 240261 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3884 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 9321 100901 0 0 0 0 0 0 4464 40 0 955 0 0 259 1 0 0 0 0 57 20 0=
 185 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
ctxt 264279
btime 1432903797
processes 365
procs_running 1
procs_blocked 0
softirq 339610 2 114130 0 116 0 0 105806 76223 0 43333

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="proc-interrupts.txt"

            CPU0       CPU1       CPU2       CPU3       
   8:          0          0          0          0  BYT-GPIO    0  rtc0
  86:       3884          0          0          0  BYT-GPIO   78  soc_dts
 146:          0          0          0          0  BYT-GPIO    4  rt5645
 160:          0          0          0          0  BYT-GPIO   18  ACPI:Event
 186:       9321          0          0          0   IO-APIC   44-fasteoi   mmc0
 187:     100901          0          0          0   IO-APIC   46-fasteoi   mmc1
 188:          0          0          0          0   IO-APIC   47-fasteoi   mmc2
 189:          0          0          0          0   IO-APIC   42-fasteoi   dw_dmac
 190:          0          0          0          0   IO-APIC   43-fasteoi   dw_dmac
 194:       4464          0          0          0   IO-APIC   32-fasteoi   80860F41:00
 195:         40          0          0          0   IO-APIC   33-fasteoi   80860F41:01
 196:          0          0          0          0   IO-APIC   34-fasteoi   80860F41:02
 197:        955          0          0          0   IO-APIC   35-fasteoi   80860F41:03
 198:          0          0          0          0   IO-APIC   36-fasteoi   80860F41:04
 200:        259          0          0          0   IO-APIC   71-edge      PDEC3393:00
 201:          1          0          0          0   IO-APIC   72-fasteoi   ELAN0100:00
 206:         57          0          0          0   PCI-MSI 327680-edge      xhci_hcd
 207:         20          0          0          0   PCI-MSI 425984-edge      mei_txe
 209:        185          0          0          0   PCI-MSI 32768-edge      i915
 NMI:          0          1          0          0   Non-maskable interrupts
 LOC:      28874      28736      28663      27862   Local timer interrupts
 SPU:          0          0          0          0   Spurious interrupts
 PMI:          0          1          0          0   Performance monitoring interrupts
 IWI:          0          0          0          0   IRQ work interrupts
 RTR:          0          0          0          0   APIC ICR read retries
 RES:        899        817        872        929   Rescheduling interrupts
 CAL:        633        599        561        618   Function call interrupts
 TLB:         56         25         16         13   TLB shootdowns
 TRM:          0          0          0          0   Thermal event interrupts
 THR:          0          0          0          0   Threshold APIC interrupts
 MCE:          0          0          0          0   Machine check exceptions
 MCP:          1          1          1          1   Machine check polls
 HYP:          0          0          0          0   Hypervisor callback interrupts
 ERR:          0
 MIS:          0
 PIN:          0          0          0          0   Posted-interrupt notification event
 PIW:          0          0          0          0   Posted-interrupt wakeup event

--OXfL5xGRrasGEqWY
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-add-baytrail-byt-rt5645-board.patch"

>From e0af65e61c24c659cfabed664e0e4c8973454c72 Mon Sep 17 00:00:00 2001
From: Michele Curti <michele.curti@gmail.com>
Date: Fri, 29 May 2015 07:26:28 +0200
Subject: [PATCH 1/3] add baytrail byt-rt5645 board

add board file and a cople of ACPI id where needed

Signed-off-by: Michele Curti <michele.curti@gmail.com>
---
 sound/soc/codecs/rt5645.c           |   2 +
 sound/soc/intel/Kconfig             |   9 +++
 sound/soc/intel/boards/Makefile     |   2 +
 sound/soc/intel/boards/byt-rt5645.c | 149 ++++++++++++++++++++++++++++++++++++
 sound/soc/intel/common/sst-acpi.c   |   1 +
 5 files changed, 163 insertions(+)
 create mode 100644 sound/soc/intel/boards/byt-rt5645.c

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index e9544c6..9ec416f 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3190,6 +3190,7 @@ static const struct regmap_config rt5645_regmap = {
 
 static const struct i2c_device_id rt5645_i2c_id[] = {
 	{ "rt5645", 0 },
+	{ "rt5648", 0 },
 	{ "rt5650", 0 },
 	{ }
 };
@@ -3198,6 +3199,7 @@ MODULE_DEVICE_TABLE(i2c, rt5645_i2c_id);
 #ifdef CONFIG_ACPI
 static struct acpi_device_id rt5645_acpi_match[] = {
 	{ "10EC5645", 0 },
+	{ "10EC5648", 0 },
 	{ "10EC5650", 0 },
 	{},
 };
diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 4419d76..1332e94 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -65,6 +65,15 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
 	  This adds audio driver for Intel Baytrail platform based boards
 	  with the RT5640 audio codec.
 
+config SND_SOC_INTEL_BYT_RT5645_MACH
+	tristate "ASoC Audio driver for Intel Baytrail with RT5645 codec"
+	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && I2C
+	select SND_SOC_INTEL_BAYTRAIL
+	select SND_SOC_RT5645
+	help
+	  This adds audio driver for Intel Baytrail platform based boards
+	  with the RT5645 audio codec.
+
 config SND_SOC_INTEL_BYT_MAX98090_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
 	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && I2C
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index cb94895..24685c5 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -1,5 +1,6 @@
 snd-soc-sst-haswell-objs := haswell.o
 snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
+snd-soc-sst-byt-rt5645-mach-objs := byt-rt5645.o
 snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
 snd-soc-sst-broadwell-objs := broadwell.o
 snd-soc-sst-bytcr-rt5640-objs := bytcr_rt5640.o
@@ -9,6 +10,7 @@ snd-soc-sst-cht-bsw-max98090_ti-objs := cht_bsw_max98090_ti.o
 
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
+obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5645_MACH) += snd-soc-sst-byt-rt5645-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH) += snd-soc-sst-bytcr-rt5640.o
diff --git a/sound/soc/intel/boards/byt-rt5645.c b/sound/soc/intel/boards/byt-rt5645.c
new file mode 100644
index 0000000..15a4e67
--- /dev/null
+++ b/sound/soc/intel/boards/byt-rt5645.c
@@ -0,0 +1,149 @@
+/*
+ * Intel Baytrail SST RT5645 machine driver
+ * Copyright (c) 2014, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/dmi.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+#include "../../codecs/rt5645.h"
+
+#include "../common/sst-dsp.h"
+
+static const struct snd_soc_dapm_widget byt_rt5645_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Internal Mic", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+};
+
+static const struct snd_soc_dapm_route byt_rt5645_audio_map[] = {
+	{"IN1P", NULL, "Internal Mic"},
+	{"IN2P", NULL, "Headset Mic"},
+	{"Headphone", NULL, "HPOL"},
+	{"Headphone", NULL, "HPOR"},
+	{"Speaker", NULL, "SPOLP"},
+	{"Speaker", NULL, "SPOLN"},
+	{"Speaker", NULL, "SPORP"},
+	{"Speaker", NULL, "SPORN"},
+};
+
+static const struct snd_kcontrol_new byt_rt5645_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Internal Mic"),
+	SOC_DAPM_PIN_SWITCH("Speaker"),
+};
+
+static int byt_rt5645_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5645_SCLK_S_PLL1,
+				     params_rate(params) * 256,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "can't set codec clock %d\n", ret);
+		return ret;
+	}
+	ret = snd_soc_dai_set_pll(codec_dai, 0, RT5645_PLL1_S_BCLK1,
+				  params_rate(params) * 64,
+				  params_rate(params) * 256);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "can't set codec pll: %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int byt_rt5645_init(struct snd_soc_pcm_runtime *runtime)
+{
+	int ret;
+	struct snd_soc_card *card = runtime->card;
+
+	card->dapm.idle_bias_off = true;
+
+	ret = snd_soc_add_card_controls(card, byt_rt5645_controls,
+					ARRAY_SIZE(byt_rt5645_controls));
+	if (ret) {
+		dev_err(card->dev, "unable to add card controls\n");
+		return ret;
+	}
+
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Headphone");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Speaker");
+
+	return ret;
+}
+
+static struct snd_soc_ops byt_rt5645_ops = {
+	.hw_params = byt_rt5645_hw_params,
+};
+
+static struct snd_soc_dai_link byt_rt5645_dais[] = {
+	{
+		.name = "Baytrail Audio",
+		.stream_name = "Audio",
+		.cpu_dai_name = "baytrail-pcm-audio",
+		.codec_dai_name = "rt5645-aif1",
+		.codec_name = "i2c-10EC5648:00",
+		.platform_name = "baytrail-pcm-audio",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			   SND_SOC_DAIFMT_CBS_CFS,
+		.init = byt_rt5645_init,
+		.ops = &byt_rt5645_ops,
+	},
+};
+
+static struct snd_soc_card byt_rt5645_card = {
+	.name = "byt-rt5645",
+	.dai_link = byt_rt5645_dais,
+	.num_links = ARRAY_SIZE(byt_rt5645_dais),
+	.dapm_widgets = byt_rt5645_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(byt_rt5645_widgets),
+	.dapm_routes = byt_rt5645_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(byt_rt5645_audio_map),
+	.fully_routed = true,
+};
+
+static int byt_rt5645_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &byt_rt5645_card;
+
+	card->dev = &pdev->dev;
+	return devm_snd_soc_register_card(&pdev->dev, card);
+}
+
+static struct platform_driver byt_rt5645_audio = {
+	.probe = byt_rt5645_probe,
+	.driver = {
+		.name = "byt-rt5645",
+		.pm = &snd_soc_pm_ops,
+	},
+};
+module_platform_driver(byt_rt5645_audio)
+
+MODULE_DESCRIPTION("ASoC Intel(R) Baytrail Machine driver");
+MODULE_AUTHOR("Omair Md Abdullah, Jarkko Nikula");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:byt-rt5645");
diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index 42f293f..bb28e84 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -248,6 +248,7 @@ static struct sst_acpi_desc sst_acpi_broadwell_desc = {
 
 static struct sst_acpi_mach baytrail_machines[] = {
 	{ "10EC5640", "byt-rt5640", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
+	{ "10EC5648", "byt-rt5645", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
 	{ "193C9890", "byt-max98090", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
 	{}
 };
-- 
2.4.2


--OXfL5xGRrasGEqWY
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0002-enable-debug.patch"

>From 3d8174ddcd02c61ee40bf46da6a92650f8f0de2f Mon Sep 17 00:00:00 2001
From: Michele Curti <michele.curti@gmail.com>
Date: Fri, 29 May 2015 14:04:38 +0200
Subject: [PATCH 2/3] enable debug

enable debug for common sst and baytrail sst

Signed-off-by: Michele Curti <michele.curti@gmail.com>
---
 sound/soc/intel/baytrail/sst-baytrail-dsp.c |  1 +
 sound/soc/intel/baytrail/sst-baytrail-ipc.c |  1 +
 sound/soc/intel/baytrail/sst-baytrail-pcm.c | 14 +++++++++++---
 sound/soc/intel/boards/byt-rt5645.c         |  1 +
 sound/soc/intel/common/sst-acpi.c           |  1 +
 sound/soc/intel/common/sst-dsp.c            |  1 +
 sound/soc/intel/common/sst-firmware.c       |  1 +
 sound/soc/intel/common/sst-ipc.c            |  1 +
 8 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-dsp.c b/sound/soc/intel/baytrail/sst-baytrail-dsp.c
index 01d023c..be9d7ac 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-dsp.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-dsp.c
@@ -12,6 +12,7 @@
  * more details.
  */
 
+#define DEBUG 1
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
diff --git a/sound/soc/intel/baytrail/sst-baytrail-ipc.c b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
index 4c01bb4..32b0310 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-ipc.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
@@ -12,6 +12,7 @@
  * more details.
  */
 
+#define DEBUG 1
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
diff --git a/sound/soc/intel/baytrail/sst-baytrail-pcm.c b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
index 79547be..3776759 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
@@ -12,6 +12,7 @@
  * more details.
  */
 
+#define DEBUG 1
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
@@ -456,18 +457,25 @@ static int sst_byt_pcm_dev_probe(struct platform_device *pdev)
 	int ret;
 
 	ret = sst_byt_dsp_init(&pdev->dev, sst_pdata);
-	if (ret < 0)
+	if (ret < 0) {
+		pr_info("baytrail-pcm-audio: probe fail dsp\n");
 		return -ENODEV;
+	}
 
 	ret = snd_soc_register_platform(&pdev->dev, &byt_soc_platform);
-	if (ret < 0)
+	if (ret < 0) {
+		pr_info("baytrail-pcm-audio: probe fail reg platform\n");
 		goto err_plat;
+	}
 
 	ret = snd_soc_register_component(&pdev->dev, &byt_dai_component,
 					 byt_dais, ARRAY_SIZE(byt_dais));
-	if (ret < 0)
+	if (ret < 0) {
+		pr_info("baytrail-pcm-audio: probe fail reg components\n");
 		goto err_comp;
+	}
 
+	pr_info("baytrail-pcm-audio: probe success\n");
 	return 0;
 
 err_comp:
diff --git a/sound/soc/intel/boards/byt-rt5645.c b/sound/soc/intel/boards/byt-rt5645.c
index 15a4e67..2f54dbc 100644
--- a/sound/soc/intel/boards/byt-rt5645.c
+++ b/sound/soc/intel/boards/byt-rt5645.c
@@ -12,6 +12,7 @@
  * more details.
  */
 
+#define DEBUG 1
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index bb28e84..e7014a2 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -14,6 +14,7 @@
  *
  */
 
+#define DEBUG 1
 #include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
index 64e9421..a1b0894 100644
--- a/sound/soc/intel/common/sst-dsp.c
+++ b/sound/soc/intel/common/sst-dsp.c
@@ -14,6 +14,7 @@
  *
  */
 
+#define DEBUG 1
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index ebcca6d..1fd4bb8 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -14,6 +14,7 @@
  *
  */
 
+#define DEBUG 1
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
diff --git a/sound/soc/intel/common/sst-ipc.c b/sound/soc/intel/common/sst-ipc.c
index a7699f3..339f171 100644
--- a/sound/soc/intel/common/sst-ipc.c
+++ b/sound/soc/intel/common/sst-ipc.c
@@ -14,6 +14,7 @@
  *
  */
 
+#define DEBUG 1
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
-- 
2.4.2


--OXfL5xGRrasGEqWY
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0003-ignore-dsp-boot-timeout.patch"

>From 32dba9d9fed6992c2ec44a7faf1296bcfa66db93 Mon Sep 17 00:00:00 2001
From: Michele Curti <michele.curti@gmail.com>
Date: Fri, 29 May 2015 14:24:51 +0200
Subject: [PATCH 3/3] ignore dsp boot timeout

and let the driver probe

Signed-off-by: Michele Curti <michele.curti@gmail.com>
---
 sound/soc/intel/baytrail/sst-baytrail-ipc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-ipc.c b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
index 32b0310..e49ea847 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-ipc.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
@@ -745,8 +745,8 @@ int sst_byt_dsp_init(struct device *dev, struct sst_pdata *pdata)
 				 msecs_to_jiffies(IPC_BOOT_MSECS));
 	if (err == 0) {
 		err = -EIO;
-		dev_err(byt->dev, "ipc: error DSP boot timeout\n");
-		goto boot_err;
+		dev_err(byt->dev, "ipc: error DSP boot timeout, continue anyway\n");
+		//goto boot_err;
 	}
 
 	/* show firmware information */
-- 
2.4.2


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--OXfL5xGRrasGEqWY--
