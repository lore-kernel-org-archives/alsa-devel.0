From: Zhihe Tu <tuzhihe@pcasl.com>
Subject: Intel Cherry Trail  --  No sound in linux
Date: Mon, 9 Nov 2015 11:21:23 +0800
Message-ID: <000501d11a9d$b5b6aa90$2123ffb0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.pcasl.com (unknown [118.194.228.23])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A7832606D8
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 04:21:28 +0100 (CET)
References: 
In-Reply-To: 
Content-Language: zh-cn
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi All,

I'm trying to make the CherryTrail tablet works in ubuntu14.04.3,  there's
no sound at all,  but it works in win8 & android.

Full dmesg:
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.19.0-25-generic (buildd@lgw01-20) (gcc
version 4.8.2 (Ubuntu 4.8.2-19ubuntu1) ) #26~14.04.1-Ubuntu SMP Fri Jul 24
21:16:20 UTC 2015 (Ubuntu 3.19.0-25.26~14.04.1-generic 3.19.8-ckt2)
[    0.000000] Command line:
BOOT_IMAGE=/boot/vmlinuz-3.19.0-25-generic.efi.signed
root=UUID=a6ccfb7f-4e13-429f-8f8e-fe3a4f2e00f2 ro console=tty0
console=ttyS0,115200 quiet splash
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI
NVS
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x000000003b120fff] usable
[    0.000000] BIOS-e820: [mem 0x000000003b121000-0x000000003b150fff]
reserved
[    0.000000] BIOS-e820: [mem 0x000000003b151000-0x000000003b274fff] usable
[    0.000000] BIOS-e820: [mem 0x000000003b275000-0x000000003b75dfff] ACPI
NVS
[    0.000000] BIOS-e820: [mem 0x000000003b75e000-0x000000003ba14fff]
reserved
[    0.000000] BIOS-e820: [mem 0x000000003ba15000-0x000000003ba6efff] type
20
[    0.000000] BIOS-e820: [mem 0x000000003ba6f000-0x000000003ba74fff] usable
[    0.000000] BIOS-e820: [mem 0x000000003ba75000-0x000000003ba75fff]
reserved
[    0.000000] BIOS-e820: [mem 0x000000003ba76000-0x000000003ba78fff] usable
[    0.000000] BIOS-e820: [mem 0x000000003ba79000-0x000000003ba79fff]
reserved
[    0.000000] BIOS-e820: [mem 0x000000003ba7a000-0x000000003bffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000e3ffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000feafffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed03000-0x00000000fed03fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed06000-0x00000000fed06fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed09fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1cfff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fedbffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff]
reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.40 by American Megatrends
[    0.000000] efi:  ACPI=0x3b2b9000  ACPI 2.0=0x3b2b9000  SMBIOS=0x3b918f98

[    0.000000] efi: mem00: [Conventional Memory|   |  |  |  |
|WB|WT|WC|UC] range=[0x0000000000000000-0x000000000008f000) (0MB)
[    0.000000] efi: mem01: [ACPI Memory NVS    |   |  |  |  |
|WB|WT|WC|UC] range=[0x000000000008f000-0x0000000000090000) (0MB)
[    0.000000] efi: mem02: [Conventional Memory|   |  |  |  |
|WB|WT|WC|UC] range=[0x0000000000090000-0x000000000009e000) (0MB)
[    0.000000] efi: mem03: [Reserved           |   |  |  |  |
|WB|WT|WC|UC] range=[0x000000000009e000-0x00000000000a0000) (0MB)
[    0.000000] efi: mem04: [Loader Data        |   |  |  |  |
|WB|WT|WC|UC] range=[0x0000000000100000-0x00000000014d6000) (19MB)
[    0.000000] efi: mem05: [Conventional Memory|   |  |  |  |
|WB|WT|WC|UC] range=[0x00000000014d6000-0x0000000002000000) (11MB)
[    0.000000] efi: mem06: [Loader Data        |   |  |  |  |
|WB|WT|WC|UC] range=[0x0000000002000000-0x00000000033d6000) (19MB)
[    0.000000] efi: mem07: [Conventional Memory|   |  |  |  |
|WB|WT|WC|UC] range=[0x00000000033d6000-0x0000000011ebe000) (234MB)
[    0.000000] efi: mem08: [Loader Data        |   |  |  |  |
|WB|WT|WC|UC] range=[0x0000000011ebe000-0x0000000020000000) (225MB)
[    0.000000] efi: mem09: [Reserved           |   |  |  |  |
|WB|WT|WC|UC] range=[0x0000000020000000-0x0000000020200000) (2MB)
[    0.000000] efi: mem10: [Conventional Memory|   |  |  |  |
|WB|WT|WC|UC] range=[0x0000000020200000-0x0000000035a2c000) (344MB)
[    0.000000] efi: mem11: [Loader Data        |   |  |  |  |
|WB|WT|WC|UC] range=[0x0000000035a2c000-0x0000000036d0e000) (18MB)
[    0.000000] efi: mem12: [Conventional Memory|   |  |  |  |
|WB|WT|WC|UC] range=[0x0000000036d0e000-0x0000000037894000) (11MB)
[    0.000000] efi: mem13: [Loader Code        |   |  |  |  |
|WB|WT|WC|UC] range=[0x0000000037894000-0x000000003797e000) (0MB)
[    0.000000] efi: mem14: [Boot Data          |   |  |  |  |
|WB|WT|WC|UC] range=[0x000000003797e000-0x000000003a020000) (38MB)
[    0.000000] efi: mem15: [Conventional Memory|   |  |  |  |
|WB|WT|WC|UC] range=[0x000000003a020000-0x000000003ae76000) (14MB)
[    0.000000] efi: mem16: [Boot Code          |   |  |  |  |
|WB|WT|WC|UC] range=[0x000000003ae76000-0x000000003b121000) (2MB)
[    0.000000] efi: mem17: [Reserved           |   |  |  |  |
|WB|WT|WC|UC] range=[0x000000003b121000-0x000000003b151000) (0MB)
[    0.000000] efi: mem18: [Conventional Memory|   |  |  |  |
|WB|WT|WC|UC] range=[0x000000003b151000-0x000000003b26b000) (1MB)
[    0.000000] efi: mem19: [Loader Data        |   |  |  |  |
|WB|WT|WC|UC] range=[0x000000003b26b000-0x000000003b275000) (0MB)
[    0.000000] efi: mem20: [ACPI Memory NVS    |   |  |  |  |
|WB|WT|WC|UC] range=[0x000000003b275000-0x000000003b75e000) (4MB)
[    0.000000] efi: mem21: [Runtime Data       |RUN|  |  |  |
|WB|WT|WC|UC] range=[0x000000003b75e000-0x000000003ba15000) (2MB)
[    0.000000] efi: mem22: [Runtime Code       |RUN|  |  |  |
|WB|WT|WC|UC] range=[0x000000003ba15000-0x000000003ba6f000) (0MB)
[    0.000000] efi: mem23: [Conventional Memory|   |  |  |  |
|WB|WT|WC|UC] range=[0x000000003ba6f000-0x000000003ba70000) (0MB)
[    0.000000] efi: mem24: [Boot Data          |   |  |  |  |
|WB|WT|WC|UC] range=[0x000000003ba70000-0x000000003ba75000) (0MB)
[    0.000000] efi: mem25: [Runtime Data       |RUN|  |  |  |
|WB|WT|WC|UC] range=[0x000000003ba75000-0x000000003ba76000) (0MB)
[    0.000000] efi: mem26: [Boot Data          |   |  |  |  |
|WB|WT|WC|UC] range=[0x000000003ba76000-0x000000003ba79000) (0MB)
[    0.000000] efi: mem27: [Runtime Data       |RUN|  |  |  |
|WB|WT|WC|UC] range=[0x000000003ba79000-0x000000003ba7a000) (0MB)
[    0.000000] efi: mem28: [Boot Data          |   |  |  |  |
|WB|WT|WC|UC] range=[0x000000003ba7a000-0x000000003c000000) (5MB)
[    0.000000] efi: mem29: [MMIO Port Space    |RUN|  |  |  |   |  |  |
|UC] range=[0x00000000e0000000-0x00000000e4000000) (64MB)
[    0.000000] efi: mem30: [Memory Mapped I/O  |RUN|  |  |  |   |  |  |
|UC] range=[0x00000000fea00000-0x00000000feb00000) (1MB)
[    0.000000] efi: mem31: [Memory Mapped I/O  |RUN|  |  |  |   |  |  |
|UC] range=[0x00000000fec00000-0x00000000fec01000) (0MB)
[    0.000000] efi: mem32: [Memory Mapped I/O  |RUN|  |  |  |   |  |  |
|UC] range=[0x00000000fed01000-0x00000000fed02000) (0MB)
[    0.000000] efi: mem33: [Memory Mapped I/O  |RUN|  |  |  |   |  |  |
|UC] range=[0x00000000fed03000-0x00000000fed04000) (0MB)
[    0.000000] efi: mem34: [Memory Mapped I/O  |RUN|  |  |  |   |  |  |
|UC] range=[0x00000000fed06000-0x00000000fed07000) (0MB)
[    0.000000] efi: mem35: [Memory Mapped I/O  |RUN|  |  |  |   |  |  |
|UC] range=[0x00000000fed08000-0x00000000fed0a000) (0MB)
[    0.000000] efi: mem36: [Memory Mapped I/O  |RUN|  |  |  |   |  |  |
|UC] range=[0x00000000fed1c000-0x00000000fed1d000) (0MB)
[    0.000000] efi: mem37: [Memory Mapped I/O  |RUN|  |  |  |   |  |  |
|UC] range=[0x00000000fed80000-0x00000000fedc0000) (0MB)
[    0.000000] efi: mem38: [Memory Mapped I/O  |RUN|  |  |  |   |  |  |
|UC] range=[0x00000000fee00000-0x00000000fee01000) (0MB)
[    0.000000] efi: mem39: [Memory Mapped I/O  |RUN|  |  |  |   |  |  |
|UC] range=[0x00000000ffc00000-0x0000000100000000) (4MB)
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: To be filled by O.E.M. To be filled by O.E.M./Cherry
Trail CR, BIOS 5.011 10/28/2015
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn = 0x3c000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FC0000000 write-back
[    0.000000]   1 base 03E000000 mask FFE000000 uncachable
[    0.000000]   2 base 03D000000 mask FFF000000 uncachable
[    0.000000]   3 base 03C800000 mask FFF800000 uncachable
[    0.000000]   4 base 03C400000 mask FFFC00000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC  
[    0.000000] original variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 1GB, type WB
[    0.000000] reg 1, base: 992MB, range: 32MB, type UC
[    0.000000] reg 2, base: 976MB, range: 16MB, type UC
[    0.000000] reg 3, base: 968MB, range: 8MB, type UC
[    0.000000] reg 4, base: 964MB, range: 4MB, type UC
[    0.000000] total RAM covered: 964M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K 	chunk_size: 64K 	num_reg: 5  	lose
cover RAM: 0G
[    0.000000] New variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 512MB, type WB
[    0.000000] reg 1, base: 512MB, range: 256MB, type WB
[    0.000000] reg 2, base: 768MB, range: 128MB, type WB
[    0.000000] reg 3, base: 896MB, range: 64MB, type WB
[    0.000000] reg 4, base: 960MB, range: 4MB, type WB
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x02fd4000, 0x02fd4fff] PGTABLE
[    0.000000] BRK [0x02fd5000, 0x02fd5fff] PGTABLE
[    0.000000] BRK [0x02fd6000, 0x02fd6fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x3ac00000-0x3adfffff]
[    0.000000]  [mem 0x3ac00000-0x3adfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x20200000-0x3abfffff]
[    0.000000]  [mem 0x20200000-0x3abfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x1fffffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x1fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x3ae00000-0x3b120fff]
[    0.000000]  [mem 0x3ae00000-0x3affffff] page 2M
[    0.000000]  [mem 0x3b000000-0x3b120fff] page 4k
[    0.000000] BRK [0x02fd7000, 0x02fd7fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x3b151000-0x3b274fff]
[    0.000000]  [mem 0x3b151000-0x3b274fff] page 4k
[    0.000000] BRK [0x02fd8000, 0x02fd8fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x3ba6f000-0x3ba74fff]
[    0.000000]  [mem 0x3ba6f000-0x3ba74fff] page 4k
[    0.000000] BRK [0x02fd9000, 0x02fd9fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x3ba76000-0x3ba78fff]
[    0.000000]  [mem 0x3ba76000-0x3ba78fff] page 4k
[    0.000000] init_memory_mapping: [mem 0x3ba7a000-0x3bffffff]
[    0.000000]  [mem 0x3ba7a000-0x3bbfffff] page 4k
[    0.000000]  [mem 0x3bc00000-0x3bffffff] page 2M
[    0.000000] RAMDISK: [mem 0x35a2c000-0x36d0dfff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000003B2B9000 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x000000003B2B90A8 0000CC (v01 ALASKA A M I
01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x000000003B2D5180 00010C (v05 ALASKA A M I
01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x000000003B2B9208 01BF77 (v02 ALASKA A M I
01072009 INTL 20120913)
[    0.000000] ACPI: FACS 0x000000003B75DF80 000040
[    0.000000] ACPI: APIC 0x000000003B2D5290 000084 (v03 ALASKA A M I
01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x000000003B2D5318 000044 (v01 ALASKA A M I
01072009 AMI  00010013)
[    0.000000] ACPI: FIDT 0x000000003B2D5360 00009C (v01 ALASKA A M I
01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x000000003B2D5400 00003C (v01 ALASKA A M I
01072009 MSFT 00000097)
[    0.000000] ACPI: SSDT 0x000000003B2D5440 003FD8 (v01 DptfTb DptfTab
00001000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x000000003B2D9418 000654 (v01 CpuDpf CpuDptf
00001000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x000000003B2D9A70 000058 (v01 LowPM  LowPwrM
00001000 INTL 20120913)
[    0.000000] ACPI: UEFI 0x000000003B2D9AC8 000042 (v01 ALASKA A M I
00000000      00000000)
[    0.000000] ACPI: HPET 0x000000003B2D9B10 000038 (v01 ALASKA A M I
01072009 AMI. 00000005)
[    0.000000] ACPI: SSDT 0x000000003B2D9B48 000763 (v01 PmRef  CpuPm
00003000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x000000003B2DA2B0 000290 (v01 PmRef  Cpu0Tst
00003000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x000000003B2DA540 00017A (v01 PmRef  ApTst
00003000 INTL 20120913)
[    0.000000] ACPI: SSDT 0x000000003B2DA6C0 00043A (v01 Intel_ Tpm2Tabl
00001000 INTL 20120913)
[    0.000000] ACPI: TPM2 0x000000003B2DAB00 000034 (v03
00000000      00000000)
[    0.000000] ACPI: LPIT 0x000000003B2DAB38 000104 (v01 ALASKA A M I
00000005 MSFT 0100000D)
[    0.000000] ACPI: BCFG 0x000000003B2DAC40 000139 (v01 INTEL  BATTCONF
00000001 INTL 00000000)
[    0.000000] ACPI: PRAM 0x000000003B2DAD80 000030 (v01
00000001      00000000)
[    0.000000] ACPI: BGRT 0x000000003B2DADB0 000038 (v01 ALASKA A M I
01072009 AMI  00010013)
[    0.000000] ACPI: CSRT 0x000000003B2DADE8 00014C (v00 INTEL  LANFORDC
00000005 MSFT 0100000D)
[    0.000000] ACPI: WDAT 0x000000003B2DAF38 000104 (v01
00000000      00000000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000003bffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x3b270000-0x3b274fff]
[    0.000000]  [ffffea0000000000-ffffea0000ffffff] PMD ->
[ffff880034a00000-ffff8800359fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0x3bffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0008efff]
[    0.000000]   node   0: [mem 0x00090000-0x0009dfff]
[    0.000000]   node   0: [mem 0x00100000-0x1fffffff]
[    0.000000]   node   0: [mem 0x20200000-0x3b120fff]
[    0.000000]   node   0: [mem 0x3b151000-0x3b274fff]
[    0.000000]   node   0: [mem 0x3ba6f000-0x3ba74fff]
[    0.000000]   node   0: [mem 0x3ba76000-0x3ba78fff]
[    0.000000]   node   0: [mem 0x3ba7a000-0x3bffffff]
[    0.000000] Initmem setup node 0 [mem 0x00001000-0x3bffffff]
[    0.000000] On node 0 totalpages: 243056
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 22 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 3776 pages used for memmap
[    0.000000]   DMA32 zone: 239060 pages, LIFO batch:31
[    0.000000] Reserving Intel graphics stolen memory at
0x3cc00000-0x3ebfffff
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI
0-114
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0008f000-0x0008ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x3b121000-0x3b150fff]
[    0.000000] PM: Registered nosave memory: [mem 0x3b275000-0x3b75dfff]
[    0.000000] PM: Registered nosave memory: [mem 0x3b75e000-0x3ba14fff]
[    0.000000] PM: Registered nosave memory: [mem 0x3ba15000-0x3ba6efff]
[    0.000000] PM: Registered nosave memory: [mem 0x3ba75000-0x3ba75fff]
[    0.000000] PM: Registered nosave memory: [mem 0x3ba79000-0x3ba79fff]
[    0.000000] e820: [mem 0x3ec00000-0xdfffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:4
nr_node_ids:1
[    0.000000] PERCPU: Embedded 31 pages/cpu @ffff88003ac00000 s86144 r8192
d32640 u524288
[    0.000000] pcpu-alloc: s86144 r8192 d32640 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total
pages: 239194
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line:
BOOT_IMAGE=/boot/vmlinuz-3.19.0-25-generic.efi.signed
root=UUID=a6ccfb7f-4e13-429f-8f8e-fe3a4f2e00f2 ro console=tty0
console=ttyS0,115200 quiet splash
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 871436K/972224K available (7918K kernel code, 1172K
rwdata, 3752K rodata, 1408K init, 1292K bss, 100788K reserved, 0K
cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS:16640 nr_irqs:1024 16
[    0.000000] 	Offload RCU callbacks from all CPUs
[    0.000000] 	Offload RCU callbacks from CPUs: 0-3.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration failed
[    0.000000] tsc: PIT calibration matches HPET. 1 loops
[    0.000000] tsc: Detected 1439.756 MHz processor
[    0.000055] Calibrating delay loop (skipped), value calculated using
timer frequency.. 2879.51 BogoMIPS (lpj=5759024)
[    0.000064] pid_max: default: 32768 minimum: 301
[    0.000077] ACPI: Core revision 20141107
[    0.059843] ACPI: All ACPI Tables successfully acquired
[    0.061748] Security Framework initialized
[    0.061783] AppArmor: AppArmor initialized
[    0.061788] Yama: becoming mindful.
[    0.062025] Dentry cache hash table entries: 131072 (order: 8, 1048576
bytes)
[    0.062690] Inode-cache hash table entries: 65536 (order: 7, 524288
bytes)
[    0.062998] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
[    0.063010] Mountpoint-cache hash table entries: 2048 (order: 2, 16384
bytes)
[    0.063466] Initializing cgroup subsys memory
[    0.063485] Initializing cgroup subsys devices
[    0.063493] Initializing cgroup subsys freezer
[    0.063500] Initializing cgroup subsys net_cls
[    0.063507] Initializing cgroup subsys blkio
[    0.063513] Initializing cgroup subsys perf_event
[    0.063520] Initializing cgroup subsys net_prio
[    0.063527] Initializing cgroup subsys hugetlb
[    0.063569] CPU: Physical Processor ID: 0
[    0.063574] CPU: Processor Core ID: 0
[    0.063581] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.063581] ENERGY_PERF_BIAS: View and update with
x86_energy_perf_policy(8)
[    0.069096] mce: CPU supports 6 MCE banks
[    0.069112] CPU0: Thermal monitoring enabled (TM1)
[    0.069117] process: using mwait in idle threads
[    0.069128] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
[    0.069128] Last level dTLB entries: 4KB 256, 2MB 16, 4MB 16, 1GB 0
[    0.069299] Freeing SMP alternatives memory: 32K (ffffffff81e87000 -
ffffffff81e8f000)
[    0.076136] ftrace: allocating 29988 entries in 118 pages
[    0.100956] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
[    0.140637] smpboot: CPU0: Intel(R) Atom(TM) x5-Z8300  CPU @ 1.44GHz
(fam: 06, model: 4c, stepping: 03)
[    0.140658] TSC deadline timer enabled
[    0.140713] Performance Events: PEBS fmt2+, 8-deep LBR, Silvermont
events, full-width counters, Intel PMU driver.
[    0.140735] ... version:                3
[    0.140738] ... bit width:              40
[    0.140740] ... generic registers:      2
[    0.140743] ... value mask:             000000ffffffffff
[    0.140746] ... max period:             000000ffffffffff
[    0.140749] ... fixed-purpose events:   3
[    0.140751] ... event mask:             0000000700000003
[    0.143082] x86: Booting SMP configuration:
[    0.143090] .... node  #0, CPUs:      #1
[    0.161790] NMI watchdog: enabled on all CPUs, permanently consumes one
hw-PMU counter.
[    0.162136]  #2 #3
[    0.199497] x86: Booted up 1 node, 4 CPUs
[    0.199504] smpboot: Total of 4 processors activated (11518.04 BogoMIPS)
[    0.200858] devtmpfs: initialized
[    0.210027] evm: security.selinux
[    0.210032] evm: security.SMACK64
[    0.210034] evm: security.SMACK64EXEC
[    0.210037] evm: security.SMACK64TRANSMUTE
[    0.210041] evm: security.SMACK64MMAP
[    0.210045] evm: security.ima
[    0.210047] evm: security.capability
[    0.210216] PM: Registering ACPI NVS region [mem 0x0008f000-0x0008ffff]
(4096 bytes)
[    0.210223] PM: Registering ACPI NVS region [mem 0x3b275000-0x3b75dfff]
(5148672 bytes)
[    0.210808] pinctrl core: initialized pinctrl subsystem
[    0.211083] RTC time:  3:38:58, date: 11/05/15
[    0.211431] NET: Registered protocol family 16
[    0.217704] cpuidle: using governor ladder
[    0.221718] cpuidle: using governor menu
[    0.221896] ACPI: bus type PCI registered
[    0.221904] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.222125] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xe0000000-0xefffffff] (base 0xe0000000)
[    0.222134] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.222140] PCI: MMCONFIG for 0000 [bus00-3f] at [mem
0xe0000000-0xe3ffffff] (base 0xe0000000) (size reduced!)
[    0.222425] PCI: Using configuration type 1 for base access
[    0.228718] ACPI: Added _OSI(Module Device)
[    0.228725] ACPI: Added _OSI(Processor Device)
[    0.228729] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.228732] ACPI: Added _OSI(Processor Aggregator Device)
[    0.268886] ACPI: Dynamic OEM Table Load:
[    0.268908] ACPI: SSDT 0xFFFF8800377E2800 00057B (v01 PmRef  Cpu0Ist
00003000 INTL 20120913)
[    0.271345] ACPI: Dynamic OEM Table Load:
[    0.271359] ACPI: SSDT 0xFFFF88003A0A0400 0003A5 (v01 PmRef  Cpu0Cst
00003001 INTL 20120913)
[    0.274269] ACPI: Dynamic OEM Table Load:
[    0.274284] ACPI: SSDT 0xFFFF88003A037E00 00015F (v01 PmRef  ApIst
00003000 INTL 20120913)
[    0.276658] ACPI: Dynamic OEM Table Load:
[    0.276671] ACPI: SSDT 0xFFFF88003A0813C0 00008D (v01 PmRef  ApCst
00003000 INTL 20120913)
[    0.281297] ACPI: Interpreter enabled
[    0.281317] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State
[\_S1_] (20141107/hwxface-580)
[    0.281330] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State
[\_S2_] (20141107/hwxface-580)
[    0.281341] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State
[\_S3_] (20141107/hwxface-580)
[    0.281371] ACPI: (supports S0 S4 S5)
[    0.281375] ACPI: Using IOAPIC for interrupt routing
[    0.281464] PCI: Using host bridge windows from ACPI; if necessary, use
"pci=nocrs" and report a bug
[    0.282483] ACPI: Power Resource [P06X] (off)
[    0.284598] ACPI: Power Resource [ID3C] (on)
[    0.287328] ACPI: Power Resource [USBC] (on)
[    0.288525] ACPI: Power Resource [WWPR] (off)
[    0.289310] ACPI: Power Resource [WWPR] (off)
[    0.290498] ACPI: Power Resource [WWPR] (off)
[    0.291238] ACPI: Power Resource [WWPR] (off)
[    0.292024] ACPI: Power Resource [WWPR] (off)
[    0.292859] ACPI: Power Resource [WWPR] (off)
[    0.308580] ACPI: Power Resource [CLK3] (on)
[    0.308696] ACPI: Power Resource [CLK4] (on)
[    0.320804] ACPI: Power Resource [CLK2] (on)
[    0.321372] ACPI: Power Resource [CLK1] (on)
[    0.323522] ACPI: Power Resource [CLK0] (on)
[    0.323640] ACPI: Power Resource [CLK1] (on)
[    0.325796] ACPI: Power Resource [P19X] (off)
[    0.338506] ACPI: Power Resource [P28X] (off)
[    0.338620] ACPI: Power Resource [P18X] (off)
[    0.338738] ACPI: Power Resource [P12X] (off)
[    0.338847] ACPI: Power Resource [P28P] (off)
[    0.338961] ACPI: Power Resource [P18P] (off)
[    0.339098] ACPI: Power Resource [P28T] (off)
[    0.339207] ACPI: Power Resource [P18D] (off)
[    0.339330] ACPI: Power Resource [P18T] (off)
[    0.339440] ACPI: Power Resource [P3P3] (off)
[    0.339556] ACPI: Power Resource [P12T] (off)
[    0.339666] ACPI: Power Resource [P28W] (off)
[    0.339798] ACPI: Power Resource [P18W] (off)
[    0.339908] ACPI: Power Resource [P12W] (off)
[    0.340024] ACPI: Power Resource [P33W] (off)
[    0.340137] ACPI: Power Resource [P33X] (off)
[    0.340360]  (null): Returned _DSD data is not valid, skipping
[    0.347658] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.347675] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
[    0.348234] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER
PCIeCapability]
[    0.349008] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000
[bus 00-3f] only partially covers this bridge
[    0.349848] PCI host bridge to bus 0000:00
[    0.349858] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.349864] pci_bus 0000:00: root bus resource [io  0x0000-0x006f]
[    0.349869] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7]
[    0.349875] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.349880] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff]
[    0.349885] pci_bus 0000:00: root bus resource [mem
0x000c0000-0x000dffff]
[    0.349890] pci_bus 0000:00: root bus resource [mem
0x000e0000-0x000fffff]
[    0.349895] pci_bus 0000:00: root bus resource [mem
0x20000000-0x201fffff]
[    0.349900] pci_bus 0000:00: root bus resource [mem
0x3cc00001-0x3ec00000]
[    0.349905] pci_bus 0000:00: root bus resource [mem
0x40000000-0xdfffffff]
[    0.349923] pci 0000:00:00.0: [8086:2280] type 00 class 0x060000
[    0.350308] pci 0000:00:02.0: [8086:22b0] type 00 class 0x030000
[    0.350347] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x90ffffff 64bit]
[    0.350365] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff 64bit
pref]
[    0.350378] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.350742] pci 0000:00:0b.0: [8086:22dc] type 00 class 0x118000
[    0.350776] pci 0000:00:0b.0: reg 0x10: [mem 0x9153b000-0x9153bfff 64bit]
[    0.351186] pci 0000:00:14.0: [8086:22b5] type 00 class 0x0c0330
[    0.351228] pci 0000:00:14.0: reg 0x10: [mem 0x91500000-0x9150ffff 64bit]
[    0.351352] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.351659] pci 0000:00:1a.0: [8086:2298] type 00 class 0x108000
[    0.351690] pci 0000:00:1a.0: reg 0x10: [mem 0x91300000-0x913fffff]
[    0.351708] pci 0000:00:1a.0: reg 0x14: [mem 0x91200000-0x912fffff]
[    0.351833] pci 0000:00:1a.0: PME# supported from D0 D3hot
[    0.352123] pci 0000:00:1c.0: [8086:22c8] type 01 class 0x060400
[    0.352261] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.352564] pci 0000:00:1f.0: [8086:229c] type 00 class 0x060100
[    0.353150] pci 0000:01:00.0: [10ec:8168] type 00 class 0x020000
[    0.353186] pci 0000:01:00.0: reg 0x10: [io  0xe000-0xe0ff]
[    0.353234] pci 0000:01:00.0: reg 0x18: [mem 0x91404000-0x91404fff 64bit]
[    0.353264] pci 0000:01:00.0: reg 0x20: [mem 0x91400000-0x91403fff 64bit
pref]
[    0.353410] pci 0000:01:00.0: supports D1 D2
[    0.353415] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.359785] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.359796] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
[    0.359804] pci 0000:00:1c.0:   bridge window [mem 0x91400000-0x914fffff]
[    0.371990] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15)
*0, disabled.
[    0.372160] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15)
*0, disabled.
[    0.372324] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15)
*0, disabled.
[    0.372488] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15)
*0, disabled.
[    0.372657] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15)
*0, disabled.
[    0.372822] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15)
*0, disabled.
[    0.372991] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15)
*0, disabled.
[    0.373157] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15)
*0, disabled.
[    0.377673] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.377681] vgaarb: device added:
PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.377687] vgaarb: loaded
[    0.377691] vgaarb: bridge control possible 0000:00:02.0
[    0.378320] SCSI subsystem initialized
[    0.378451] libata version 3.00 loaded.
[    0.378528] ACPI: bus type USB registered
[    0.378588] usbcore: registered new interface driver usbfs
[    0.378616] usbcore: registered new interface driver hub
[    0.378673] usbcore: registered new device driver usb
[    0.379233] PCI: Using ACPI for IRQ routing
[    0.381966] PCI: pci_cache_line_size set to 64 bytes
[    0.382028] Expanded resource reserved due to conflict with PCI Bus
0000:00
[    0.382035] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.382040] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.382044] e820: reserve RAM buffer [mem 0x3b121000-0x3bffffff]
[    0.382048] e820: reserve RAM buffer [mem 0x3b275000-0x3bffffff]
[    0.382052] e820: reserve RAM buffer [mem 0x3ba75000-0x3bffffff]
[    0.382056] e820: reserve RAM buffer [mem 0x3ba79000-0x3bffffff]
[    0.382369] NetLabel: Initializing
[    0.382375] NetLabel:  domain hash size = 128
[    0.382378] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.382410] NetLabel:  unlabeled traffic allowed by default
[    0.382619] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.382630] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.384727] Switched to clocksource hpet
[    0.399118] AppArmor: AppArmor Filesystem Enabled
[    0.399314] pnp: PnP ACPI init
[    0.399604] system 00:00: [io  0x0680-0x069f] has been reserved
[    0.399613] system 00:00: [io  0x0400-0x047f] could not be reserved
[    0.399619] system 00:00: [io  0x0500-0x05fe] has been reserved
[    0.399629] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.399846] pnp 00:01: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.406549] system 00:02: [mem 0x91539000-0x91539fff] has been reserved
[    0.406560] system 00:02: [mem 0x91537000-0x91537fff] has been reserved
[    0.406566] system 00:02: [mem 0x91535000-0x91535fff] has been reserved
[    0.406572] system 00:02: [mem 0x91524000-0x91524fff] has been reserved
[    0.406578] system 00:02: [mem 0x91522000-0x91522fff] has been reserved
[    0.406584] system 00:02: [mem 0x91520000-0x91520fff] has been reserved
[    0.406590] system 00:02: [mem 0x9151e000-0x9151efff] has been reserved
[    0.406596] system 00:02: [mem 0x9151c000-0x9151cfff] has been reserved
[    0.406602] system 00:02: [mem 0x9151a000-0x9151afff] has been reserved
[    0.406607] system 00:02: [mem 0x91518000-0x91518fff] has been reserved
[    0.406613] system 00:02: [mem 0x91533000-0x91533fff] has been reserved
[    0.406619] system 00:02: [mem 0x91531000-0x91531fff] has been reserved
[    0.406625] system 00:02: [mem 0x9152f000-0x9152ffff] has been reserved
[    0.406631] system 00:02: [mem 0x9152d000-0x9152dfff] has been reserved
[    0.406637] system 00:02: [mem 0x9152b000-0x9152bfff] has been reserved
[    0.406643] system 00:02: [mem 0x91529000-0x91529fff] has been reserved
[    0.406649] system 00:02: [mem 0x91527000-0x91527fff] has been reserved
[    0.406655] system 00:02: [mem 0x91525000-0x91525fff] has been reserved
[    0.406664] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.406910] system 00:03: [mem 0xe0000000-0xefffffff] could not be
reserved
[    0.406918] system 00:03: [mem 0xfea00000-0xfeafffff] has been reserved
[    0.406926] system 00:03: [mem 0xfed01000-0xfed01fff] has been reserved
[    0.406932] system 00:03: [mem 0xfed03000-0xfed03fff] has been reserved
[    0.406938] system 00:03: [mem 0xfed06000-0xfed06fff] has been reserved
[    0.406944] system 00:03: [mem 0xfed08000-0xfed09fff] has been reserved
[    0.406950] system 00:03: [mem 0xfed80000-0xfedbffff] could not be
reserved
[    0.406956] system 00:03: [mem 0xfed1c000-0xfed1cfff] has been reserved
[    0.406962] system 00:03: [mem 0xfee00000-0xfeefffff] could not be
reserved
[    0.406969] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.407350] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.408815] pnp: PnP ACPI: found 5 devices
[    0.420099] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.420110] pci 0000:00:1c.0:   bridge window [io  0xe000-0xefff]
[    0.420123] pci 0000:00:1c.0:   bridge window [mem 0x91400000-0x914fffff]
[    0.420143] pci_bus 0000:00: resource 4 [io  0x0000-0x006f]
[    0.420148] pci_bus 0000:00: resource 5 [io  0x0078-0x0cf7]
[    0.420153] pci_bus 0000:00: resource 6 [io  0x0d00-0xffff]
[    0.420158] pci_bus 0000:00: resource 7 [mem 0x000a0000-0x000bffff]
[    0.420163] pci_bus 0000:00: resource 8 [mem 0x000c0000-0x000dffff]
[    0.420168] pci_bus 0000:00: resource 9 [mem 0x000e0000-0x000fffff]
[    0.420173] pci_bus 0000:00: resource 10 [mem 0x20000000-0x201fffff]
[    0.420178] pci_bus 0000:00: resource 11 [mem 0x3cc00001-0x3ec00000]
[    0.420183] pci_bus 0000:00: resource 12 [mem 0x40000000-0xdfffffff]
[    0.420188] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.420193] pci_bus 0000:01: resource 1 [mem 0x91400000-0x914fffff]
[    0.420257] NET: Registered protocol family 2
[    0.420691] TCP established hash table entries: 8192 (order: 4, 65536
bytes)
[    0.420774] TCP bind hash table entries: 8192 (order: 5, 131072 bytes)
[    0.420831] TCP: Hash tables configured (established 8192 bind 8192)
[    0.420888] TCP: reno registered
[    0.420899] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.420916] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.421020] NET: Registered protocol family 1
[    0.421061] pci 0000:00:02.0: Video device with shadowed ROM
[    0.421524] PCI: CLS 64 bytes, default 64
[    0.421658] Trying to unpack rootfs image as initramfs...
[    1.119592] Freeing initrd memory: 19336K (ffff880035a2c000 -
ffff880036d0e000)
[    1.120212] microcode: CPU0 sig=0x406c3, pf=0x1, revision=0x34f
[    1.120231] microcode: CPU1 sig=0x406c3, pf=0x1, revision=0x34f
[    1.120253] microcode: CPU2 sig=0x406c3, pf=0x1, revision=0x34f
[    1.120273] microcode: CPU3 sig=0x406c3, pf=0x1, revision=0x34f
[    1.120420] microcode: Microcode Update Driver: v2.00
<tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    1.120540] Scanning for low memory corruption every 60 seconds
[    1.121493] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    1.121531] Initialise system trusted keyring
[    1.121591] audit: initializing netlink subsys (disabled)
[    1.121637] audit: type=2000 audit(1446694739.116:1): initialized
[    1.122361] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.126700] zpool: loaded
[    1.126708] zbud: loaded
[    1.127112] VFS: Disk quotas dquot_6.5.2
[    1.127218] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
bytes)
[    1.128655] fuse init (API version 7.23)
[    1.129071] Key type big_key registered
[    1.130403] Key type asymmetric registered
[    1.130413] Asymmetric key parser 'x509' registered
[    1.130541] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 252)
[    1.130674] io scheduler noop registered
[    1.130683] io scheduler deadline registered (default)
[    1.130780] io scheduler cfq registered
[    1.131457] pcieport 0000:00:1c.0: Signaling PME through PCIe PME
interrupt
[    1.131465] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    1.131475] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme loaded
[    1.131493] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.131537] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.131654] intel_idle: does not run on family 6 model 76
[    1.132323] ACPI: AC Adapter [ADP1] (on-line)
[    1.133021] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.133032] ACPI: Power Button [PWRB]
[    1.133154] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.133162] ACPI: Power Button [PWRF]
[    1.136254] Monitor-Mwait will be used to enter C-1 state
[    1.136269] Monitor-Mwait will be used to enter C-2 state
[    1.136278] Monitor-Mwait will be used to enter C-3 state
[    1.136303] ACPI: acpi_idle registered with cpuidle
[    1.139572] thermal LNXTHERM:00: registered as thermal_zone0
[    1.139579] ACPI: Thermal Zone [TZ00] (0 C)
[    1.139740] GHES: HEST is not enabled!
[    1.140058] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.160432] 00:01: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a
16550A
[    1.165306] Linux agpgart interface v0.103
[    1.169348] brd: module loaded
[    1.171356] loop: module loaded
[    1.171959] libphy: Fixed MDIO Bus: probed
[    1.171970] tun: Universal TUN/TAP device driver, 1.6
[    1.171973] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.172105] PPP generic driver version 2.4.2
[    1.172621] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.172639] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus
number 1
[    1.172872] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    1.173077] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.173083] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.173089] usb usb1: Product: xHCI Host Controller
[    1.173094] usb usb1: Manufacturer: Linux 3.19.0-25-generic xhci-hcd
[    1.173098] usb usb1: SerialNumber: 0000:00:14.0
[    1.173443] hub 1-0:1.0: USB hub found
[    1.173477] hub 1-0:1.0: 7 ports detected
[    1.175216] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.175228] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus
number 2
[    1.175337] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003
[    1.175343] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.175348] usb usb2: Product: xHCI Host Controller
[    1.175352] usb usb2: Manufacturer: Linux 3.19.0-25-generic xhci-hcd
[    1.175356] usb usb2: SerialNumber: 0000:00:14.0
[    1.175649] hub 2-0:1.0: USB hub found
[    1.175679] hub 2-0:1.0: 6 ports detected
[    1.177265] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.177287] ehci-pci: EHCI PCI platform driver
[    1.177325] ehci-platform: EHCI generic platform driver
[    1.177382] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.177398] ohci-pci: OHCI PCI platform driver
[    1.177431] ohci-platform: OHCI generic platform driver
[    1.177460] uhci_hcd: USB Universal Host Controller Interface driver
[    1.177594] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    1.708758] i8042: Can't read CTR while initializing i8042
[    1.714923] i8042: probe of i8042 failed with error -5
[    1.715258] mousedev: PS/2 mouse device common for all mice
[    1.715960] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    1.716030] rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram,
hpet irqs
[    1.716081] i2c /dev entries driver
[    1.716277] device-mapper: uevent: version 1.0.3
[    1.716626] device-mapper: ioctl: 4.29.0-ioctl (2014-10-28) initialised:
dm-devel@redhat.com
[    1.716653] Intel P-state driver initializing.
[    1.717035] Consider also installing thermald for improved thermal
control.
[    1.717075] ledtrig-cpu: registered to indicate activity on CPUs
[    1.717100] EFI Variables Facility v0.08 2004-May-17
[    1.721916] PCCT header not found.
[    1.721920] ACPI PCC probe failed.
[    1.725933] TCP: cubic registered
[    1.726180] NET: Registered protocol family 10
[    1.727180] NET: Registered protocol family 17
[    1.727206] Key type dns_resolver registered
[    1.728224] Loading compiled-in X.509 certificates
[    1.730298] Loaded X.509 cert 'Magrathea: Glacier signing key:
6aaa11d18c2d3a40b1b4dbe5bf8ad656ddf51838'
[    1.730329] registered taskstats version 1
[    1.735935] Key type trusted registered
[    1.745812] Key type encrypted registered
[    1.745831] AppArmor: AppArmor sha1 policy hashing enabled
[    1.745839] ima: No TPM chip found, activating TPM-bypass!
[    1.745888] evm: HMAC attrs: 0x1
[    1.746817]   Magic number: 7:302:613
[    1.747405] rtc_cmos 00:04: setting system clock to 2015-11-05 03:38:59
UTC (1446694739)
[    1.747688] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    1.747692] EDD information not available.
[    1.748166] PM: Hibernation image not present or could not be loaded.
[    1.749602] Freeing unused kernel memory: 1408K (ffffffff81d27000 -
ffffffff81e87000)
[    1.749609] Write protecting the kernel read-only data: 12288k
[    1.750902] Freeing unused kernel memory: 260K (ffff8800027bf000 -
ffff880002800000)
[    1.751232] Freeing unused kernel memory: 344K (ffff880002baa000 -
ffff880002c00000)
[    1.779223] systemd-udevd[118]: starting version 204
[    1.833258] sdhci: Secure Digital Host Controller Interface driver
[    1.833265] sdhci: Copyright(c) Pierre Ossman
[    1.837817] sdhci-acpi 80860F14:00: No vmmc regulator found
[    1.837825] sdhci-acpi 80860F14:00: No vqmmc regulator found
[    1.841112] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
[    1.841568] sdhci-acpi 80860F14:03: failed to setup card detect gpio
[    1.842585] sdhci-acpi 80860F14:03: No vmmc regulator found
[    1.842590] sdhci-acpi 80860F14:03: No vqmmc regulator found
[    1.845869] mmc1: SDHCI controller on ACPI [80860F14:03] using ADMA
[    1.882366] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    1.883236] r8169 0000:01:00.0 eth0: RTL8168evl/8111evl at
0xffffc900001fe000, 24:1c:04:02:20:a8, XID 0c900800 IRQ 117
[    1.883244] r8169 0000:01:00.0 eth0: jumbo features [frames: 9200 bytes,
tx checksumming: ko]
[    1.920549] usb 1-2: new high-speed USB device number 2 using xhci_hcd
[    1.974261] mmc0: BKOPS_EN bit is not set
[    1.983350] mmc0: new HS200 MMC card at address 0001
[    1.988056] Driver 'mmcblk' needs updating - please use bus_type methods
[    1.988445] mmcblk0: mmc0:0001 008GE0 7.28 GiB 
[    1.988586] mmcblk0boot0: mmc0:0001 008GE0 partition 1 4.00 MiB
[    1.988771] mmcblk0boot1: mmc0:0001 008GE0 partition 2 4.00 MiB
[    1.989032] mmcblk0rpmb: mmc0:0001 008GE0 partition 3 4.00 MiB
[    1.992025]  mmcblk0: p1 p2 p3
[    2.092201] EXT4-fs (mmcblk0p2): INFO: recovery required on readonly
filesystem
[    2.092210] EXT4-fs (mmcblk0p2): write access will be enabled during
recovery
[    2.097865] EXT4-fs (mmcblk0p2): recovery complete
[    2.102291] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data
mode. Opts: (null)
[    2.117147] tsc: Refined TSC clocksource calibration: 1439.952 MHz
[    2.827564] usb 1-2: New USB device found, idVendor=174c, idProduct=1153
[    2.827580] usb 1-2: New USB device strings: Mfr=2, Product=3,
SerialNumber=1
[    2.827585] usb 1-2: Product: AS2115
[    2.827588] usb 1-2: Manufacturer: ASMedia
[    2.827591] usb 1-2: SerialNumber: 00000000000000000000
[    2.940544] usb 1-4: new high-speed USB device number 3 using xhci_hcd
[    3.071550] usb 1-4: New USB device found, idVendor=05e3, idProduct=0608
[    3.071559] usb 1-4: New USB device strings: Mfr=0, Product=1,
SerialNumber=0
[    3.071564] usb 1-4: Product: USB2.0 Hub
[    3.073272] hub 1-4:1.0: USB hub found
[    3.073607] hub 1-4:1.0: 4 ports detected
[    3.116441] Switched to clocksource tsc
[    3.208481] random: init urandom read with 25 bits of entropy available
[    3.256075] init: plymouth-upstart-bridge main process (178) terminated
with status 1
[    3.256111] init: plymouth-upstart-bridge main process ended, respawning
[    3.272117] init: plymouth-upstart-bridge main process (188) terminated
with status 1
[    3.272150] init: plymouth-upstart-bridge main process ended, respawning
[    3.284089] init: plymouth-upstart-bridge main process (191) terminated
with status 1
[    3.284122] init: plymouth-upstart-bridge main process ended, respawning
[    3.348435] usb 1-4.1: new low-speed USB device number 4 using xhci_hcd
[    3.439526] usb 1-4.1: New USB device found, idVendor=0461,
idProduct=4d81
[    3.439534] usb 1-4.1: New USB device strings: Mfr=0, Product=2,
SerialNumber=0
[    3.439539] usb 1-4.1: Product: USB Optical Mouse
[    3.439756] usb 1-4.1: ep 0x81 - rounding interval to 64 microframes, ep
desc says 80 microframes
[    3.512419] usb 1-4.2: new low-speed USB device number 5 using xhci_hcd
[    3.606272] usb 1-4.2: New USB device found, idVendor=413c,
idProduct=2003
[    3.606281] usb 1-4.2: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[    3.606286] usb 1-4.2: Product: Dell USB Keyboard
[    3.606290] usb 1-4.2: Manufacturer: Dell
[    3.606532] usb 1-4.2: ep 0x81 - rounding interval to 128 microframes, ep
desc says 192 microframes
[    3.640338] Adding 970748k swap on /dev/mmcblk0p3.  Priority:-1 extents:1
across:970748k SSFS
[    3.680388] usb 1-4.3: new high-speed USB device number 6 using xhci_hcd
[    3.769360] usb 1-4.3: New USB device found, idVendor=0bda,
idProduct=8179
[    3.769369] usb 1-4.3: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[    3.769374] usb 1-4.3: Product: 802.11n NIC
[    3.769378] usb 1-4.3: Manufacturer: Realtek
[    3.769382] usb 1-4.3: SerialNumber: 8C18D9CA30B7
[    3.907161] systemd-udevd[305]: starting version 204
[    4.015323] lp: driver loaded but no devices found
[    4.033848] ppdev: user-space parallel port driver
[    4.058009] EXT4-fs (mmcblk0p2): re-mounted. Opts: errors=remount-ro
[    4.195005] GPIO chip INT33FF:00: failed to get GPIO descriptor
[    4.201670] cherryview-pinctrl INT33FF:00: Failed to request GPIO
[    4.291667] 8086228A:00: ttyS4 at MMIO 0x91521000 (irq = 39, base_baud =
2764800) is a 16550A
[    4.292352] 8086228A:01: ttyS5 at MMIO 0x9151f000 (irq = 40, base_baud =
2764800) is a 16550A
[    4.382448] axp20x i2c-INT33F4:00: AXP20x variant AXP288 found
[    4.443370] axp20x i2c-INT33F4:00: Failed to request IRQ -1 for
axp288_irq_chip: -22
[    4.452092] axp20x i2c-INT33F4:00: failed to add irq chip: -22
[    4.501844] axp20x: probe of i2c-INT33F4:00 failed with error -22
[    4.506906] dw_dmac INTL9C60:00: DesignWare DMA Controller, 8 channels
[    4.508438] dw_dmac INTL9C60:01: DesignWare DMA Controller, 8 channels
[    4.570505] Bluetooth: Core ver 2.20
[    4.570551] NET: Registered protocol family 31
[    4.570555] Bluetooth: HCI device and connection manager initialized
[    4.570565] Bluetooth: HCI socket layer initialized
[    4.570572] Bluetooth: L2CAP socket layer initialized
[    4.570587] Bluetooth: SCO socket layer initialized
[    4.582232] hidraw: raw HID events driver (C) Jiri Kosina
[    4.593034] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.593041] Bluetooth: BNEP filters: protocol multicast
[    4.593051] Bluetooth: BNEP socket layer initialized
[    4.609849] Bluetooth: RFCOMM TTY layer initialized
[    4.609866] Bluetooth: RFCOMM socket layer initialized
[    4.609883] Bluetooth: RFCOMM ver 1.11
[    4.635305] audit: type=1400 audit(1446694742.384:2): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="/usr/lib/cups/backend/cups-pdf" pid=511 comm="apparmor_parser"
[    4.635323] audit: type=1400 audit(1446694742.384:3): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="/usr/sbin/cupsd" pid=511
comm="apparmor_parser"
[    4.636748] audit: type=1400 audit(1446694742.388:4): apparmor="STATUS"
operation="profile_replace" profile="unconfined" name="/usr/sbin/cupsd"
pid=511 comm="apparmor_parser"
[    4.649358] proc_thermal 0000:00:0b.0: enabling device (0000 -> 0002)
[    4.701121] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    4.706660] [drm] Initialized drm 1.1.0 20060810
[    4.720159] intel_sst_acpi 808622A8:00: LPE base: 0x91000000
size:0x200000
[    4.720167] intel_sst_acpi 808622A8:00: IRAM base: 0x910c0000
[    4.720215] intel_sst_acpi 808622A8:00: DRAM base: 0x91100000
[    4.720227] intel_sst_acpi 808622A8:00: SHIM base: 0x91140000
[    4.720240] intel_sst_acpi 808622A8:00: Mailbox base: 0x91144000
[    4.720251] intel_sst_acpi 808622A8:00: DDR base: 0x20000000
[    4.734153] intel_sst_acpi 808622A8:00: Got drv data max stream 25
[    4.861511] usb-storage 1-2:1.0: USB Mass Storage device detected
[    4.871676] usbcore: registered new interface driver usbhid
[    4.871684] usbhid: USB HID core driver
[    4.872347] scsi host0: usb-storage 1-2:1.0
[    4.872630] usbcore: registered new interface driver usb-storage
[    4.880552] r8188eu: module is from the staging directory, the quality is
unknown, you have been warned.
[    4.895379] Chip Version Info:
CHIP_8188E_Normal_Chip_TSMC_D_CUT_1T1R_RomVer(0)
[    4.895620] usbcore: registered new interface driver uas
[    4.927588] audit: type=1400 audit(1446694742.676:5): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="/sbin/dhclient" pid=550
comm="apparmor_parser"
[    4.927608] audit: type=1400 audit(1446694742.676:6): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=550
comm="apparmor_parser"
[    4.927619] audit: type=1400 audit(1446694742.676:7): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="/usr/lib/connman/scripts/dhclient-script" pid=550
comm="apparmor_parser"
[    4.929084] audit: type=1400 audit(1446694742.680:8): apparmor="STATUS"
operation="profile_replace" profile="unconfined"
name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=550
comm="apparmor_parser"
[    4.929101] audit: type=1400 audit(1446694742.680:9): apparmor="STATUS"
operation="profile_replace" profile="unconfined"
name="/usr/lib/connman/scripts/dhclient-script" pid=550
comm="apparmor_parser"
[    4.929843] audit: type=1400 audit(1446694742.680:10): apparmor="STATUS"
operation="profile_replace" profile="unconfined"
name="/usr/lib/connman/scripts/dhclient-script" pid=550
comm="apparmor_parser"
[    4.951727] usbcore: registered new interface driver r8188eu
[    4.955295] [drm] Memory usable by graphics device = 2048M
[    4.955306] [drm] Replacing VGA console driver
[    4.961060] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    4.961068] [drm] Driver supports precise vblank timestamp query.
[    4.998028] SSE version of gcm_enc/dec engaged.
[    5.016454] vgaarb: device changed decodes:
PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    5.087464] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post:
no)
[    5.091130] acpi device:01: registered as cooling_device5
[    5.097790] acpi device:02: registered as cooling_device6
[    5.098626] acpi device:03: registered as cooling_device7
[    5.099681] acpi device:04: registered as cooling_device8
[    5.101166] acpi device:05: registered as cooling_device9
[    5.102115] acpi device:06: registered as cooling_device10
[    5.103058] acpi device:07: registered as cooling_device11
[    5.105954] acpi device:08: registered as cooling_device12
[    5.106285] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input2
[    5.120213] [drm] Initialized i915_bpo 1.6.0 20150522 for 0000:00:02.0 on
minor 0
[    5.147861] [drm] GMBUS [i915 gmbus dpb] timed out, falling back to bit
banging on pin 5
[    5.182476] intel_rapl: Found RAPL domain package
[    5.182484] intel_rapl: Found RAPL domain core
[    5.255993] [drm] GMBUS [i915 gmbus dpc] timed out, falling back to bit
banging on pin 4
[    5.301837] input: gpio-keys as
/devices/platform/gpio-keys.0.auto/input/input3
[    5.303634] input: gpio-keys as
/devices/platform/gpio-keys.1.auto/input/input4
[    5.317576] fbcon: inteldrmfb (fb0) is primary device
[    5.365439] random: nonblocking pool is initialized
[    5.369766] init: failsafe main process (594) killed by TERM signal
[    5.440768] input: USB Optical Mouse as
/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.1/1-4.1:1.0/0003:0461:4D81.000
1/input/input5
[    5.442390] hid-generic 0003:0461:4D81.0001: input,hidraw0: USB HID v1.11
Mouse [USB Optical Mouse] on usb-0000:00:14.0-4.1/input0
[    5.443708] input: Dell Dell USB Keyboard as
/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.2/1-4.2:1.0/0003:413C:2003.000
2/input/input6
[    5.463371] cht-bsw-rt5672 cht-bsw-rt5672: snd-soc-dummy-dai <->
media-cpu-dai mapping ok
[    5.463406] compress asoc: snd-soc-dummy-dai <-> compress-cpu-dai mapping
ok
[    5.475786] cht-bsw-rt5672 cht-bsw-rt5672: rt5670-aif1 <-> ssp2-port
mapping ok
[    5.507355] hid-generic 0003:413C:2003.0002: input,hidraw1: USB HID v1.10
Keyboard [Dell Dell USB Keyboard] on usb-0000:00:14.0-4.2/input0
[    5.695892] Console: switching to colour frame buffer device 170x48
[    5.712458] i915_bpo 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    5.712461] i915_bpo 0000:00:02.0: registered panic notifier
[    5.725983] cfg80211: Calling CRDA to update world regulatory domain
[    5.872710] scsi 0:0:0:0: Direct-Access     ASMT     2115             0
PQ: 0 ANSI: 6
[    5.873522] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    5.875671] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    5.907038] sst-mfld-platform sst-mfld-platform: Slot control: codec_out
tx interleaver slot 0 doesn't have DAPM widget!!!
[    5.922073] sst-mfld-platform sst-mfld-platform: Slot control: codec_out
tx interleaver slot 1 doesn't have DAPM widget!!!
[    5.935876] sst-mfld-platform sst-mfld-platform: Slot control: codec_out
tx interleaver slot 2 doesn't have DAPM widget!!!
[    5.949941] sst-mfld-platform sst-mfld-platform: Slot control: codec_out
tx interleaver slot 3 doesn't have DAPM widget!!!
[    5.968241] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
[    5.968267] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
[    5.968292] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
[    5.968318] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!
[    6.155728] audit_printk_skb: 51 callbacks suppressed
[    6.155736] audit: type=1400 audit(1446694743.908:28): apparmor="STATUS"
operation="profile_replace" profile="unconfined" name="pxgsettings" pid=816
comm="apparmor_parser"
[    6.155751] audit: type=1400 audit(1446694743.908:29): apparmor="STATUS"
operation="profile_replace" profile="unconfined" name="sanitized_helper"
pid=816 comm="apparmor_parser"
[    6.155764] audit: type=1400 audit(1446694743.908:30): apparmor="STATUS"
operation="profile_replace" profile="unconfined"
name="/usr/lib/telepathy/telepathy-ofono" pid=816 comm="apparmor_parser"
[    6.155826] audit: type=1400 audit(1446694743.908:31): apparmor="STATUS"
operation="profile_replace" profile="unconfined"
name="/usr/lib/cups/backend/cups-pdf" pid=818 comm="apparmor_parser"
[    6.155848] audit: type=1400 audit(1446694743.908:32): apparmor="STATUS"
operation="profile_replace" profile="unconfined" name="/usr/sbin/cupsd"
pid=818 comm="apparmor_parser"
[    6.155914] audit: type=1400 audit(1446694743.908:33): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="/usr/sbin/tcpdump"
pid=820 comm="apparmor_parser"
[    6.157244] audit: type=1400 audit(1446694743.908:34): apparmor="STATUS"
operation="profile_replace" profile="unconfined" name="/usr/sbin/cupsd"
pid=818 comm="apparmor_parser"
[    6.157790] audit: type=1400 audit(1446694743.908:35): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="/usr/bin/evince" pid=814
comm="apparmor_parser"
[    6.157804] audit: type=1400 audit(1446694743.908:36): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="sanitized_helper"
pid=814 comm="apparmor_parser"
[    6.157815] audit: type=1400 audit(1446694743.908:37): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="/usr/bin/evince-previewer" pid=814 comm="apparmor_parser"
[    6.279854] MAC Address = 8c:18:d9:ca:30:b7
[    6.281275] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[    6.284438] R8188EU: ERROR indicate disassoc
[    6.284756] cfg80211: World regulatory domain updated:
[    6.284763] cfg80211:  DFS Master region: unset
[    6.284767] cfg80211:   (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[    6.284773] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (300
mBi, 2000 mBm), (N/A)
[    6.284778] cfg80211:   (2457000 KHz - 2482000 KHz @ 40000 KHz), (300
mBi, 2000 mBm), (N/A)
[    6.284782] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (300
mBi, 2000 mBm), (N/A)
[    6.284786] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz), (300
mBi, 2000 mBm), (N/A)
[    6.284790] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz), (300
mBi, 2000 mBm), (N/A)
[    6.285245] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[    6.441750] r8169 0000:01:00.0 eth0: link down
[    6.441840] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    6.617144] sst-mfld-platform sst-mfld-platform: Slot control: codec_out
tx interleaver slot 0 doesn't have DAPM widget!!!
[    6.632519] sst-mfld-platform sst-mfld-platform: Slot control: codec_out
tx interleaver slot 1 doesn't have DAPM widget!!!
[    6.647501] sst-mfld-platform sst-mfld-platform: Slot control: codec_out
tx interleaver slot 2 doesn't have DAPM widget!!!
[    6.662176] sst-mfld-platform sst-mfld-platform: Slot control: codec_out
tx interleaver slot 3 doesn't have DAPM widget!!!
[    6.677049] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
[    6.692739] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
[    6.692765] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
[    6.692792] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!
[    7.541669] init: plymouth-upstart-bridge main process ended, respawning
[    9.804555]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.811916]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.819327]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.827341]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.834913]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.844113]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.851496]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.858845]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.866614]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.874281]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.884480]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.892266]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.899762]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.907476]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.915306]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.924078]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.932106]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.940442]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.949569]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.959182]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.977089]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.987402]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[    9.996602]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.005384]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.016121]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.025183]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.034474]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.041833]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.055318]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.066303]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.074727]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.082143]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.090646]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.100117]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.107906]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.116587]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.124249]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.132162]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.139952]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.147834]  Audio Port: ASoC: no backend DAIs enabled for Audio Port
[   10.159472] sst-mfld-platform sst-mfld-platform: Enter: enable=1
port_name=ssp2-port
[   10.162179] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[   10.163874] sst-mfld-platform sst-mfld-platform: Enter: enable=1
port_name=ssp2-port
[   10.164488] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[   10.165994] sst-mfld-platform sst-mfld-platform: Enter: enable=1
port_name=ssp2-port
[   10.166626] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[   10.168438] sst-mfld-platform sst-mfld-platform: Enter: enable=1
port_name=ssp2-port
[   10.169549] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[   10.171607] sst-mfld-platform sst-mfld-platform: Enter: enable=1
port_name=ssp2-port
[   10.189856] intel_sst_acpi 808622A8:00: Alloc for str 1 pipe 0x90
[   10.204244] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[   10.205026] intel_sst_acpi 808622A8:00: Free for str 1 pipe 0x90
[   10.215195] sst-mfld-platform sst-mfld-platform: Enter: enable=1
port_name=ssp2-port
[   10.216190] intel_sst_acpi 808622A8:00: Alloc for str 1 pipe 0x90
[   15.265583] sst-mfld-platform sst-mfld-platform: Enter: enable=0
port_name=ssp2-port
[   15.266794] intel_sst_acpi 808622A8:00: Free for str 1 pipe 0x90



I got intel sst firmware fw_sst_22a8.bin from
https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/tre
e/intel,  I guess this firmware is designed for ssp2, but the ssp0 is
connected to AIF1 of RT5672 , ssp2 is conneted to AIF2.  

Can anyone help to solve this? 


................
Thanks
Tu

 

__________ Information from ESET Smart Security, version of virus signature
database 4468 (20090929) __________

The message was checked by ESET Smart Security.

http://www.eset.com
 
