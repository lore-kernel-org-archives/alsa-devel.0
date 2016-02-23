From: Giacomo Comes <comes@naic.edu>
Subject: Re: Compute Stick baytrail audio problem
Date: Mon, 22 Feb 2016 21:15:39 -0400
Message-ID: <20160223011539.GA18239@monopoli.naic.edu>
References: <20160219203900.GA5202@monopoli.naic.edu>
 <56C8826A.3030303@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.naic.edu (mailserver.naic.edu [192.65.176.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 24A83260515
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 02:15:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56C8826A.3030303@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Giacomo Comes <comes@naic.edu>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 20, 2016 at 09:12:42AM -0600, Pierre-Louis Bossart wrote:
> On 02/19/2016 02:39 PM, Giacomo Comes wrote:
> > Hi,
> > I have recently bought a Intel Compute Stick and I am having trouble with the audio.
> > Intel provides a custom Ubuntu release that support audio, but I want to run the 
> > linux distribution of my choice on it (openSUSE 13.2 for the moment).
> > 
> > In order to have HDMI audio support it is necessary to compile a kernel with this patch
> > (https://raw.githubusercontent.com/01org/baytrailaudio/master/hdmi_audio_20150319.patch)
> > provided by Intel for kernel 3.16.7 (https://01.org/ubuntu-hdmi)
> > 
> > I compiled the openSUSE kernel using the default openSUSE .config plus the following:
> > CONFIG_SUPPORT_HDMI=y
> > CONFIG_SND_SOC=m
> > CONFIG_SND_SOC_INTEL_SST=m
> > CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH=m
> > 
> > I booted the new kernel and aplay -l gives this output:
> > **** List of PLAYBACK Hardware Devices ****
> > card 0: IntelHDMI [IntelHDMI], device 0: IntelHDMI [IntelHDMI]
> >   Subdevices: 0/1
> >   Subdevice #0: subdevice #0
> > 
> > but when I run:
> >   aplay /usr/share/sounds/alsa/test.wav
> > the audio plays for .2 seconds and then nothing more.
> > Sometime it will play later a little bit more and stop again.
> > At some point these messages appears:
> > underrun!!! (at least 29325.946 ms long)
> > underrun!!! (at least 1535.889 ms long)
> > underrun!!! (at least 3196.213 ms long)
> > 
> > 
> > I have looked around on google for a hint on how to fix this issue but I found nothing.
> > Any idea where to look for a solution?
> > 
> > Attached there are the dmesg and lsmod output for ubuntu
> > with the working audio and openSUSE 13.2 plus patch
> > without the working audio.
> > I can provide any other information you need.

Thank you for answering. I'm glad that at Intel you are trying to make
this work properly. I think a proper linux support for your device can only
increase his sales. I myself intend to buy at least 5 more for personal use,
and, being a system administrator, I have plan to deploy about 20 Compute Stick
in my work place. But before that happens, a better linux support is advisable.
 
> There are enough messages that make me believe something is very wrong from the start
> 
> 19.664486] had: ******** HAD DRIVER loading.. Ver: 0.01.003
> [   19.664549] hdmi_audio_probe dma_mask: 0
> [   19.664937] card->dev is NULL!!!!! Should not be this case
> [   19.668176] [drm] mid_hdmi_audio_register: Scheduling HDMI audio work queue
> [   19.670745] [drm:i915_had_wq] *ERROR* Checking for HDMI connection at boot
> 
> Some of us at Intel are trying to clean this up but it'll take time. 

I think the issue I'm having is not with the driver itself. I have followed another 
path. Instead of patching and recompiling the kernel, I have used this source:
http://oem.archive.canonical.com/updates/pool/public/o/oem-audio-i915-baytrail-dkms/oem-audio-i915-baytrail-dkms_0.20150605.tar.gz
and installed the hdmi_audio module using dkms.
After reboot the message:
  card->dev is NULL!!!!! Should not be this case
is missing (see attached dmesg output) but still when I try to play a sound aplay hangs as before.
Can anybody tell me were to look for the problem I'm having?
I suspect a configuration/initialization problem.
The same module works with the ubuntu image for the Compute Stick.

Giacomo

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.suse.dkms"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.16.7-32-default (geeko@buildhost) (gcc version 4.8.3 20140627 [gcc-4_8-branch revision 212064] (SUSE Linux) ) #1 SMP Wed Jan 20 14:05:33 UTC 2016 (d4df98a)
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.16.7-32-default root=UUID=646f82c8-40d4-40fd-97d7-8f2a6db7feff ro modprobe.blacklist=floppy resume=/dev/disk/by-uuid/0b44ddb4-82e5-4aeb-b21f-08708266165f splash=verbose quiet showopts
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x0000000079f08fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000079f09000-0x0000000079f38fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000079f39000-0x0000000079f66fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000079f67000-0x000000007a01afff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007a01b000-0x000000007a1defff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007a1df000-0x000000007a1e9fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a1ea000-0x000000007a1eafff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007a1eb000-0x000000007acfffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed08fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff990000-0x00000000ffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.31 by American Megatrends
[    0.000000] efi:  ACPI=0x79f66000  ACPI 2.0=0x79f66014  SMBIOS=0x7a092c18 
[    0.000000] efi: mem00: type=7, attr=0xf, range=[0x0000000000000000-0x0000000000001000) (0MB)
[    0.000000] efi: mem01: type=2, attr=0xf, range=[0x0000000000001000-0x0000000000002000) (0MB)
[    0.000000] efi: mem02: type=7, attr=0xf, range=[0x0000000000002000-0x000000000008f000) (0MB)
[    0.000000] efi: mem03: type=10, attr=0xf, range=[0x000000000008f000-0x0000000000090000) (0MB)
[    0.000000] efi: mem04: type=7, attr=0xf, range=[0x0000000000090000-0x000000000009e000) (0MB)
[    0.000000] efi: mem05: type=0, attr=0xf, range=[0x000000000009e000-0x00000000000a0000) (0MB)
[    0.000000] efi: mem06: type=7, attr=0xf, range=[0x0000000000100000-0x0000000001000000) (15MB)
[    0.000000] efi: mem07: type=2, attr=0xf, range=[0x0000000001000000-0x00000000022ac000) (18MB)
[    0.000000] efi: mem08: type=7, attr=0xf, range=[0x00000000022ac000-0x0000000020000000) (477MB)
[    0.000000] efi: mem09: type=0, attr=0xf, range=[0x0000000020000000-0x0000000020200000) (2MB)
[    0.000000] efi: mem10: type=7, attr=0xf, range=[0x0000000020200000-0x000000003f7a2000) (501MB)
[    0.000000] efi: mem11: type=2, attr=0xf, range=[0x000000003f7a2000-0x0000000040000000) (8MB)
[    0.000000] efi: mem12: type=7, attr=0xf, range=[0x0000000040000000-0x0000000055bda000) (347MB)
[    0.000000] efi: mem13: type=2, attr=0xf, range=[0x0000000055bda000-0x000000007341a000) (472MB)
[    0.000000] efi: mem14: type=7, attr=0xf, range=[0x000000007341a000-0x0000000073420000) (0MB)
[    0.000000] efi: mem15: type=2, attr=0xf, range=[0x0000000073420000-0x00000000735e3000) (1MB)
[    0.000000] efi: mem16: type=1, attr=0xf, range=[0x00000000735e3000-0x0000000073708000) (1MB)
[    0.000000] efi: mem17: type=4, attr=0xf, range=[0x0000000073708000-0x0000000076d20000) (54MB)
[    0.000000] efi: mem18: type=7, attr=0xf, range=[0x0000000076d20000-0x0000000079d05000) (47MB)
[    0.000000] efi: mem19: type=3, attr=0xf, range=[0x0000000079d05000-0x0000000079f09000) (2MB)
[    0.000000] efi: mem20: type=0, attr=0xf, range=[0x0000000079f09000-0x0000000079f39000) (0MB)
[    0.000000] efi: mem21: type=9, attr=0xf, range=[0x0000000079f39000-0x0000000079f67000) (0MB)
[    0.000000] efi: mem22: type=10, attr=0xf, range=[0x0000000079f67000-0x000000007a01b000) (0MB)
[    0.000000] efi: mem23: type=6, attr=0x800000000000000f, range=[0x000000007a01b000-0x000000007a16c000) (1MB)
[    0.000000] efi: mem24: type=5, attr=0x800000000000000f, range=[0x000000007a16c000-0x000000007a1df000) (0MB)
[    0.000000] efi: mem25: type=7, attr=0xf, range=[0x000000007a1df000-0x000000007a1e0000) (0MB)
[    0.000000] efi: mem26: type=4, attr=0xf, range=[0x000000007a1e0000-0x000000007a1ea000) (0MB)
[    0.000000] efi: mem27: type=6, attr=0x800000000000000f, range=[0x000000007a1ea000-0x000000007a1eb000) (0MB)
[    0.000000] efi: mem28: type=4, attr=0xf, range=[0x000000007a1eb000-0x000000007acf5000) (11MB)
[    0.000000] efi: mem29: type=2, attr=0xf, range=[0x000000007acf5000-0x000000007acf6000) (0MB)
[    0.000000] efi: mem30: type=4, attr=0xf, range=[0x000000007acf6000-0x000000007ad00000) (0MB)
[    0.000000] efi: mem31: type=11, attr=0x8000000000000001, range=[0x00000000e00f8000-0x00000000e00f9000) (0MB)
[    0.000000] efi: mem32: type=11, attr=0x8000000000000001, range=[0x00000000fed01000-0x00000000fed02000) (0MB)
[    0.000000] efi: mem33: type=11, attr=0x8000000000000001, range=[0x00000000fed08000-0x00000000fed09000) (0MB)
[    0.000000] efi: mem34: type=11, attr=0x8000000000000001, range=[0x00000000ff990000-0x0000000100000000) (6MB)
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: Intel Corporation STCK1A32WFC/STCK1A32WFC, BIOS FCBYT10H.86A.0031.2015.1027.1417 10/27/2015
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn = 0x7ad00 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FC0000000 write-back
[    0.000000]   1 base 040000000 mask FE0000000 write-back
[    0.000000]   2 base 060000000 mask FF0000000 write-back
[    0.000000]   3 base 070000000 mask FF8000000 write-back
[    0.000000]   4 base 070000000 mask FF8000000 write-back
[    0.000000]   5 base 078000000 mask FFC000000 write-back
[    0.000000]   6 base 07B000000 mask FFF000000 uncachable
[    0.000000]   7 base 07AE00000 mask FFFE00000 uncachable
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01ffe000, 0x01ffefff] PGTABLE
[    0.000000] BRK [0x01fff000, 0x01ffffff] PGTABLE
[    0.000000] BRK [0x02000000, 0x02000fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x79a00000-0x79bfffff]
[    0.000000]  [mem 0x79a00000-0x79bfffff] page 2M
[    0.000000] BRK [0x02001000, 0x02001fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x78000000-0x799fffff]
[    0.000000]  [mem 0x78000000-0x799fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x1fffffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x1fffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x20200000-0x77ffffff]
[    0.000000]  [mem 0x20200000-0x77ffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x79c00000-0x79f08fff]
[    0.000000]  [mem 0x79c00000-0x79dfffff] page 2M
[    0.000000]  [mem 0x79e00000-0x79f08fff] page 4k
[    0.000000] BRK [0x02002000, 0x02002fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x7a1df000-0x7a1e9fff]
[    0.000000]  [mem 0x7a1df000-0x7a1e9fff] page 4k
[    0.000000] BRK [0x02003000, 0x02003fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x7a1eb000-0x7acfffff]
[    0.000000]  [mem 0x7a1eb000-0x7a1fffff] page 4k
[    0.000000]  [mem 0x7a200000-0x7abfffff] page 2M
[    0.000000]  [mem 0x7ac00000-0x7acfffff] page 4k
[    0.000000] RAMDISK: [mem 0x3f7a2000-0x3fffafff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x0000000079F66014 000024 (v02 INTEL )
[    0.000000] ACPI: XSDT 0x0000000079F65100 00009C (v01 INTEL  FCBYT10H 00000003 MSFT 0100000D)
[    0.000000] ACPI: FACP 0x0000000079F62000 00010C (v05 INTEL  FCBYT10H 00000003 AMI  0100000D)
[    0.000000] ACPI: DSDT 0x0000000079F4E000 00F991 (v02 INTEL  FCBYT10H 00000003 AMI  0100000D)
[    0.000000] ACPI: FACS 0x0000000079FD4000 000040
[    0.000000] ACPI: UEFI 0x0000000079FD6000 000042 (v01 INTEL  FCBYT10H 00000000      00000000)
[    0.000000] ACPI: OEM0 0x0000000079F64000 000084 (v05 INTEL  BATTERY  00000003 AMI  0100000D)
[    0.000000] ACPI: DBG2 0x0000000079F63000 000072 (v00 INTEL  INTLDBG2 00000003 AMI  0100000D)
[    0.000000] ACPI: HPET 0x0000000079F61000 000038 (v01 INTEL  FCBYT10H 00000003 AMI  0100000D)
[    0.000000] ACPI: LPIT 0x0000000079F60000 000104 (v01 INTEL  FCBYT10H 00000003 AMI  0100000D)
[    0.000000] ACPI: APIC 0x0000000079F5F000 00006C (v03 INTEL  FCBYT10H 00000003 AMI  0100000D)
[    0.000000] ACPI: MCFG 0x0000000079F5E000 00003C (v01 INTEL  FCBYT10H 00000003 AMI  0100000D)
[    0.000000] ACPI: FPDT 0x0000000079F47000 000044 (v01 INTEL  FCBYT10H 01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x0000000079F46000 000763 (v01 PmRef  CpuPm    00003000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x0000000079F45000 000290 (v01 PmRef  Cpu0Tst  00003000 INTL 20061109)
[    0.000000] ACPI: SSDT 0x0000000079F44000 00017A (v01 PmRef  ApTst    00003000 INTL 20061109)
[    0.000000] ACPI: BGRT 0x0000000079F43000 000038 (v01 INTEL  FCBYT10H 01072009 AMI  00010013)
[    0.000000] ACPI: CSRT 0x0000000079F4D000 00014C (v00 INTEL  FCBYT10H 00000005 INTL 20120624)
[    0.000000] ACPI: MSDM 0x0000000079F4C000 000055 (v03 Intel  COMSTKFC 01072009 AMI  1D000000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000007acfffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x7acfffff]
[    0.000000]   NODE_DATA [mem 0x79cf1000-0x79d04fff]
[    0.000000]  [ffffea0000000000-ffffea0001bfffff] PMD -> [ffff880077400000-ffff880078ffffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0008efff]
[    0.000000]   node   0: [mem 0x00090000-0x0009dfff]
[    0.000000]   node   0: [mem 0x00100000-0x1fffffff]
[    0.000000]   node   0: [mem 0x20200000-0x79f08fff]
[    0.000000]   node   0: [mem 0x7a1df000-0x7a1e9fff]
[    0.000000]   node   0: [mem 0x7a1eb000-0x7acfffff]
[    0.000000] On node 0 totalpages: 501701
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 6822 pages used for memmap
[    0.000000]   DMA32 zone: 497705 pages, LIFO batch:31
[    0.000000] tboot: non-0 tboot_addr but it is not of type E820_RESERVED
[    0.000000] x86/hpet: Will disable the HPET for this platform because it's not reliable
[    0.000000] Reserving Intel graphics stolen memory at 0x7b000000-0x7effffff
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-86
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 103
[    0.000000] PM: Registered nosave memory: [mem 0x0008f000-0x0008ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x79f09000-0x79f38fff]
[    0.000000] PM: Registered nosave memory: [mem 0x79f39000-0x79f66fff]
[    0.000000] PM: Registered nosave memory: [mem 0x79f67000-0x7a01afff]
[    0.000000] PM: Registered nosave memory: [mem 0x7a01b000-0x7a1defff]
[    0.000000] PM: Registered nosave memory: [mem 0x7a1ea000-0x7a1eafff]
[    0.000000] e820: [mem 0x7f000000-0xe00f7fff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 27 pages/cpu @ffff880079a00000 s78656 r8192 d23744 u524288
[    0.000000] pcpu-alloc: s78656 r8192 d23744 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 494802
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.16.7-32-default root=UUID=646f82c8-40d4-40fd-97d7-8f2a6db7feff ro modprobe.blacklist=floppy resume=/dev/disk/by-uuid/0b44ddb4-82e5-4aeb-b21f-08708266165f splash=verbose quiet showopts
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] Memory: 1883484K/2006804K available (5982K kernel code, 966K rwdata, 4548K rodata, 1556K init, 1528K bss, 123320K reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=4.
[    0.000000] 	Offload RCU callbacks from all CPUs
[    0.000000] 	Offload RCU callbacks from CPUs: 0-3.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS:33024 nr_irqs:1024 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 8388608 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] Maximum core-clock to bus-clock ratio: 0x10
[    0.000000] Resolved frequency ID: 0, frequency: 83200 KHz
[    0.000000] TSC runs at 1331200 KHz
[    0.000000] lapic_timer_frequency = 332800
[    0.000000] tsc: Detected 1331.200 MHz processor
[    0.000050] Calibrating delay loop (skipped), value calculated using timer frequency.. 2662.40 BogoMIPS (lpj=5324800)
[    0.000058] pid_max: default: 32768 minimum: 301
[    0.000091] ACPI: Core revision 20140424
[    0.061408] ACPI: All ACPI Tables successfully acquired
[    0.062622] Security Framework initialized
[    0.062646] AppArmor: AppArmor initialized
[    0.063048] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.064467] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.065114] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.065129] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.065694] Initializing cgroup subsys memory
[    0.065767] Initializing cgroup subsys devices
[    0.065789] Initializing cgroup subsys freezer
[    0.065799] Initializing cgroup subsys net_cls
[    0.065815] Initializing cgroup subsys blkio
[    0.065829] Initializing cgroup subsys perf_event
[    0.065837] Initializing cgroup subsys net_prio
[    0.065858] Initializing cgroup subsys hugetlb
[    0.065900] CPU: Physical Processor ID: 0
[    0.065905] CPU: Processor Core ID: 0
[    0.065912] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.070850] mce: CPU supports 6 MCE banks
[    0.070864] CPU0: Thermal monitoring enabled (TM1)
[    0.070877] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
Last level dTLB entries: 4KB 128, 2MB 16, 4MB 16, 1GB 0
tlb_flushall_shift: 6
[    0.071058] Freeing SMP alternatives memory: 24K (ffffffff81e78000 - ffffffff81e7e000)
[    0.079099] ftrace: allocating 23603 entries in 93 pages
[    0.097101] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
[    0.136784] smpboot: CPU0: Intel(R) Atom(TM) CPU  Z3735F @ 1.33GHz (fam: 06, model: 37, stepping: 08)
[    0.136815] TSC deadline timer enabled
[    0.136860] Performance Events: PEBS fmt2+, 8-deep LBR, Silvermont events, full-width counters, Intel PMU driver.
[    0.136881] ... version:                3
[    0.136885] ... bit width:              40
[    0.136888] ... generic registers:      2
[    0.136891] ... value mask:             000000ffffffffff
[    0.136894] ... max period:             000000ffffffffff
[    0.136897] ... fixed-purpose events:   3
[    0.136900] ... event mask:             0000000700000003
[    0.141197] x86: Booting SMP configuration:
[    0.141205] .... node  #0, CPUs:      #1 #2 #3
[    0.195706] x86: Booted up 1 node, 4 CPUs
[    0.195714] smpboot: Total of 4 processors activated (10649.60 BogoMIPS)
[    0.196429] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.196994] devtmpfs: initialized
[    0.207570] PM: Registering ACPI NVS region [mem 0x0008f000-0x0008ffff] (4096 bytes)
[    0.207577] PM: Registering ACPI NVS region [mem 0x79f67000-0x7a01afff] (737280 bytes)
[    0.210571] pinctrl core: initialized pinctrl subsystem
[    0.210645] RTC time: 23:41:22, date: 02/22/16
[    0.210815] NET: Registered protocol family 16
[    0.211255] cpuidle: using governor ladder
[    0.211264] cpuidle: using governor menu
[    0.211439] ACPI: bus type PCI registered
[    0.211445] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.211687] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.211694] PCI: not using MMCONFIG
[    0.211698] PCI: Using configuration type 1 for base access
[    0.220482] ACPI: Added _OSI(Module Device)
[    0.220488] ACPI: Added _OSI(Processor Device)
[    0.220493] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.220496] ACPI: Added _OSI(Processor Aggregator Device)
[    0.261485] ACPI: Dynamic OEM Table Load:
[    0.261508] ACPI: SSDT 0xFFFF88007A83D800 00047D (v01 PmRef  Cpu0Ist  00003000 INTL 20061109)
[    0.263766] ACPI: Dynamic OEM Table Load:
[    0.263785] ACPI: SSDT 0xFFFF88007A83D000 000433 (v01 PmRef  Cpu0Cst  00003001 INTL 20061109)
[    0.276570] ACPI: Dynamic OEM Table Load:
[    0.276587] ACPI: SSDT 0xFFFF88007A82D400 00015F (v01 PmRef  ApIst    00003000 INTL 20061109)
[    0.283591] ACPI: Dynamic OEM Table Load:
[    0.283608] ACPI: SSDT 0xFFFF88007A85FC40 00008D (v01 PmRef  ApCst    00003000 INTL 20061109)
[    0.291482] ACPI: Interpreter enabled
[    0.291500] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20140424/hwxface-580)
[    0.291515] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20140424/hwxface-580)
[    0.291528] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S3_] (20140424/hwxface-580)
[    0.291541] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S4_] (20140424/hwxface-580)
[    0.291564] ACPI: (supports S0 S5)
[    0.291569] ACPI: Using IOAPIC for interrupt routing
[    0.291663] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.308247] [Firmware Info]: PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] not reserved in ACPI motherboard resources
[    0.308254] PCI: not using MMCONFIG
[    0.308299] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.316021] ACPI: Power Resource [USBC] (on)
[    0.317040] ACPI: Power Resource [WWPR] (off)
[    0.330069] ACPI: Power Resource [PLPE] (on)
[    0.344232] ACPI: Power Resource [CLK0] (on)
[    0.344391] ACPI: Power Resource [CLK1] (on)
[    0.345440] ACPI: Power Resource [P28X] (off)
[    0.345610] ACPI: Power Resource [P18X] (off)
[    0.347241] ACPI: Power Resource [P28P] (off)
[    0.347417] ACPI: Power Resource [P18P] (off)
[    0.348559] ACPI: Power Resource [P28T] (off)
[    0.348729] ACPI: Power Resource [P18T] (off)
[    0.349380] ACPI: Power Resource [P1XT] (off)
[    0.360747] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.360765] acpi PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[    0.360993] \_SB_.PCI0:_OSC invalid UUID
[    0.360998] _OSC request data:1 1e 0 
[    0.361009] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    0.362514] acpi PNP0A08:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.363332] PCI host bridge to bus 0000:00
[    0.363342] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.363349] pci_bus 0000:00: root bus resource [io  0x0000-0x006f]
[    0.363356] pci_bus 0000:00: root bus resource [io  0x0078-0x0cf7]
[    0.363361] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.363368] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.363373] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff]
[    0.363379] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000fffff]
[    0.363385] pci_bus 0000:00: root bus resource [mem 0x90c00000-0x90ffffff]
[    0.363391] pci_bus 0000:00: root bus resource [mem 0x7b000001-0x7f000000]
[    0.363397] pci_bus 0000:00: root bus resource [mem 0x80000000-0x908ffffe]
[    0.363403] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed40fff]
[    0.363421] pci 0000:00:00.0: [8086:0f00] type 00 class 0x060000
[    0.363734] pci 0000:00:02.0: [8086:0f31] type 00 class 0x030000
[    0.363757] pci 0000:00:02.0: reg 0x10: [mem 0x90000000-0x903fffff]
[    0.363774] pci 0000:00:02.0: reg 0x18: [mem 0x80000000-0x8fffffff pref]
[    0.363790] pci 0000:00:02.0: reg 0x20: [io  0x1000-0x1007]
[    0.364129] pci 0000:00:1a.0: [8086:0f18] type 00 class 0x108000
[    0.364164] pci 0000:00:1a.0: reg 0x10: [mem 0x90700000-0x907fffff]
[    0.364183] pci 0000:00:1a.0: reg 0x14: [mem 0x90600000-0x906fffff]
[    0.364305] pci 0000:00:1a.0: PME# supported from D0 D3hot
[    0.364610] pci 0000:00:1d.0: [8086:0f34] type 00 class 0x0c0320
[    0.364646] pci 0000:00:1d.0: reg 0x10: [mem 0x90811000-0x908113ff]
[    0.364782] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.365079] pci 0000:00:1f.0: [8086:0f1c] type 00 class 0x060100
[    0.366824] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.367165] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.367514] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.367851] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.368195] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.368534] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.368873] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.369211] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.386921] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.386929] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.386934] vgaarb: loaded
[    0.386938] vgaarb: bridge control possible 0000:00:02.0
[    0.387214] SCSI subsystem initialized
[    0.387358] libata version 3.00 loaded.
[    0.387609] PCI: Using ACPI for IRQ routing
[    0.387616] PCI: pci_cache_line_size set to 64 bytes
[    0.387643] Expanded resource reserved due to conflict with PCI Bus 0000:00
[    0.387650] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.387656] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.387661] e820: reserve RAM buffer [mem 0x79f09000-0x7bffffff]
[    0.387666] e820: reserve RAM buffer [mem 0x7a1ea000-0x7bffffff]
[    0.387671] e820: reserve RAM buffer [mem 0x7ad00000-0x7bffffff]
[    0.387992] NetLabel: Initializing
[    0.387997] NetLabel:  domain hash size = 128
[    0.388000] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.388035] NetLabel:  unlabeled traffic allowed by default
[    0.388171] Switched to clocksource refined-jiffies
[    0.404498] AppArmor: AppArmor Filesystem Enabled
[    0.404585] pnp: PnP ACPI init
[    0.404633] ACPI: bus type PNP registered
[    0.404775] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.405145] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.405154] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.405161] system 00:01: [io  0x0500-0x05fe] has been reserved
[    0.405168] system 00:01: [io  0x0600-0x061f] has been reserved
[    0.405175] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.405184] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.412200] pnp 00:02: unknown resource type 17 in _CRS
[    0.412208] pnp 00:02: can't evaluate _CRS: 1
[    0.412301] pnp 00:02: Plug and Play ACPI device, IDs INTcfd9 PNP0c40 (active)
[    0.412441] pnp: PnP ACPI: found 3 devices
[    0.412446] ACPI: bus type PNP unregistered
[    0.423594] Switched to clocksource acpi_pm
[    0.423618] pci_bus 0000:00: resource 4 [io  0x0000-0x006f]
[    0.423625] pci_bus 0000:00: resource 5 [io  0x0078-0x0cf7]
[    0.423631] pci_bus 0000:00: resource 6 [io  0x0d00-0xffff]
[    0.423637] pci_bus 0000:00: resource 7 [mem 0x000a0000-0x000bffff]
[    0.423642] pci_bus 0000:00: resource 8 [mem 0x000c0000-0x000dffff]
[    0.423648] pci_bus 0000:00: resource 9 [mem 0x000e0000-0x000fffff]
[    0.423654] pci_bus 0000:00: resource 10 [mem 0x90c00000-0x90ffffff]
[    0.423660] pci_bus 0000:00: resource 11 [mem 0x7b000001-0x7f000000]
[    0.423665] pci_bus 0000:00: resource 12 [mem 0x80000000-0x908ffffe]
[    0.423671] pci_bus 0000:00: resource 13 [mem 0xfed40000-0xfed40fff]
[    0.423856] NET: Registered protocol family 2
[    0.424484] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.424599] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
[    0.424718] TCP: Hash tables configured (established 16384 bind 16384)
[    0.424774] TCP: reno registered
[    0.424788] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.424822] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.425024] NET: Registered protocol family 1
[    0.425063] pci 0000:00:02.0: Video device with shadowed ROM
[    0.425525] PCI: CLS 0 bytes, default 64
[    0.425721] Unpacking initramfs...
[    2.487523] Freeing initrd memory: 8548K (ffff88003f7a2000 - ffff88003fffb000)
[    2.488182] microcode: CPU0 sig=0x30678, pf=0x2, revision=0x832
[    2.488204] microcode: CPU1 sig=0x30678, pf=0x2, revision=0x832
[    2.488220] microcode: CPU2 sig=0x30678, pf=0x2, revision=0x832
[    2.488241] microcode: CPU3 sig=0x30678, pf=0x2, revision=0x832
[    2.488420] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    2.488496] Scanning for low memory corruption every 60 seconds
[    2.489340] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    2.489438] audit: initializing netlink subsys (disabled)
[    2.489485] audit: type=2000 audit(1456184483.479:1): initialized
[    2.490194] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.490337] zbud: loaded
[    2.490899] VFS: Disk quotas dquot_6.5.2
[    2.490951] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.491564] msgmni has been set to 3829
[    2.491676] Key type big_key registered
[    2.492634] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    2.492785] io scheduler noop registered
[    2.492795] io scheduler deadline registered
[    2.492917] io scheduler cfq registered (default)
[    2.493142] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    2.493194] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    2.493353] efifb: probing for efifb
[    2.493411] efifb: framebuffer at 0x80000000, mapped to 0xffffc90000480000, using 8100k, total 8100k
[    2.493416] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    2.493419] efifb: scrolling: redraw
[    2.493424] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    2.513955] Console: switching to colour frame buffer device 240x67
[    2.534201] fb0: EFI VGA frame buffer device
[    2.534230] intel_idle: MWAIT substates: 0x33000020
[    2.534235] intel_idle: v0.4 model 0x37
[    2.534238] intel_idle: lapic_timer_reliable_states 0xffffffff
[    2.534993] GHES: HEST is not enabled!
[    2.535151] Serial: 8250/16550 driver, 32 ports, IRQ sharing disabled
[    2.555343] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.561330] hpet: number irqs doesn't agree with number of timers
[    2.561534] Non-volatile memory driver v1.3
[    2.561545] Linux agpgart interface v0.103
[    2.561973] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    3.597273] i8042: No controller found
[    3.597422] tsc: Refined TSC clocksource calibration: 1333.333 MHz
[    3.597697] mousedev: PS/2 mouse device common for all mice
[    3.598471] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    3.598512] rtc_cmos 00:00: alarms up to one month, y3k, 242 bytes nvram
[    3.598541] Intel P-state driver initializing.
[    3.598574] Intel pstate controlling: cpu 0
[    3.598701] Intel pstate controlling: cpu 1
[    3.598809] Intel pstate controlling: cpu 2
[    3.598912] Intel pstate controlling: cpu 3
[    3.599134] ledtrig-cpu: registered to indicate activity on CPUs
[    3.599160] EFI Variables Facility v0.08 2004-May-17
[    3.608415] hidraw: raw HID events driver (C) Jiri Kosina
[    3.608685] TCP: cubic registered
[    3.609489] NET: Registered protocol family 10
[    3.612728] registered taskstats version 1
[    3.612835] AppArmor: AppArmor sha1 policy hashing enabled
[    3.613476]   Magic number: 4:203:707
[    3.613808] rtc_cmos 00:00: setting system clock to 2016-02-22 23:41:25 UTC (1456184485)
[    3.614199] PM: Checking hibernation image partition /dev/disk/by-uuid/0b44ddb4-82e5-4aeb-b21f-08708266165f
[    3.614207] PM: Hibernation image not present or could not be loaded.
[    3.617392] Freeing unused kernel memory: 1556K (ffffffff81cf3000 - ffffffff81e78000)
[    3.617399] Write protecting the kernel read-only data: 12288k
[    3.618933] Freeing unused kernel memory: 152K (ffff8800015da000 - ffff880001600000)
[    3.627085] Freeing unused kernel memory: 1596K (ffff880001a71000 - ffff880001c00000)
[    3.633952] random: systemd urandom read with 1 bits of entropy available
[    4.113856] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    4.114049] ACPI: Power Button [PWRF]
[    4.118483] sdhci: Secure Digital Host Controller Interface driver
[    4.118489] sdhci: Copyright(c) Pierre Ossman
[    4.120187] mmc0: no vqmmc regulator found
[    4.120193] mmc0: no vmmc regulator found
[    4.121680] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
[    4.122973] mmc1: no vqmmc regulator found
[    4.122978] mmc1: no vmmc regulator found
[    4.124838] mmc1: SDHCI controller on ACPI [INT33BB:00] using ADMA
[    4.126631] mmc2: no vqmmc regulator found
[    4.126639] mmc2: no vmmc regulator found
[    4.135650] mmc2: SDHCI controller on ACPI [80860F14:02] using ADMA
[    4.164145] ACPI: bus type USB registered
[    4.164152] [drm] Initialized drm 1.1.0 20060810
[    4.164213] usbcore: registered new interface driver usbfs
[    4.164240] usbcore: registered new interface driver hub
[    4.175034] usbcore: registered new device driver usb
[    4.177517] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.177919] ehci-pci: EHCI PCI platform driver
[    4.178180] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    4.178198] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 1
[    4.178220] ehci-pci 0000:00:1d.0: debug port 2
[    4.183133] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    4.183173] ehci-pci 0000:00:1d.0: irq 23, io mem 0x90811000
[    4.193238] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    4.193419] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    4.193425] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.193429] usb usb1: Product: EHCI Host Controller
[    4.193434] usb usb1: Manufacturer: Linux 3.16.7-32-default ehci_hcd
[    4.193438] usb usb1: SerialNumber: 0000:00:1d.0
[    4.194572] hub 1-0:1.0: USB hub found
[    4.194602] hub 1-0:1.0: 8 ports detected
[    4.198918] [drm] Memory usable by graphics device = 2048M
[    4.198929] checking generic (80000000 7e9000) vs hw (80000000 10000000)
[    4.198933] fb: switching to inteldrmfb from EFI VGA
[    4.198990] Console: switching to colour dummy device 80x25
[    4.199142] [drm] Replacing VGA console driver
[    4.215739] i915 0000:00:02.0: irq 107 for MSI/MSI-X
[    4.215769] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    4.215773] [drm] Driver supports precise vblank timestamp query.
[    4.296861] mmc0: BKOPS_EN bit is not set
[    4.337789] mmc0: new HS200 MMC card at address 0001
[    4.340139] mmcblk0: mmc0:0001 S10032 28.5 GiB 
[    4.340455] mmcblk0boot0: mmc0:0001 S10032 partition 1 4.00 MiB
[    4.340571] mmcblk0boot1: mmc0:0001 S10032 partition 2 4.00 MiB
[    4.341095] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    4.342210] mmcblk0rpmb: mmc0:0001 S10032 partition 3 4.00 MiB
[    4.347786]  mmcblk0: p1 p2 p3 p4
[    4.352913]  mmcblk0boot1: unknown partition table
[    4.355399]  mmcblk0boot0: unknown partition table
[    4.409061] mmc1: new high speed SDIO card at address 0001
[    4.492968] [drm] GMBUS [i915 gmbus vga] timed out, falling back to bit banging on pin 2
[    4.504979] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    4.521959] mmc2: new high speed SDHC card at address 0001
[    4.522385] mmcblk1: mmc2:0001 MS 7.38 GiB 
[    4.523808]  mmcblk1: p1
[    4.597348] Switched to clocksource tsc
[    4.637490] usb 1-1: New USB device found, idVendor=8087, idProduct=07e6
[    4.637513] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.638566] hub 1-1:1.0: USB hub found
[    4.638723] hub 1-1:1.0: 4 ports detected
[    4.913620] usb 1-1.1: new high-speed USB device number 3 using ehci-pci
[    4.925613] [drm] GMBUS [i915 gmbus dpc] timed out, falling back to bit banging on pin 4
[    4.930957] fbcon: inteldrmfb (fb0) is primary device
[    5.006867] usb 1-1.1: New USB device found, idVendor=0409, idProduct=005a
[    5.006878] usb 1-1.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.008129] hub 1-1.1:1.0: USB hub found
[    5.008451] hub 1-1.1:1.0: 4 ports detected
[    5.250183] Console: switching to colour frame buffer device 240x67
[    5.298029] usb 1-1.1.1: new high-speed USB device number 4 using ehci-pci
[    5.299463] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    5.299473] i915 0000:00:02.0: registered panic notifier
[    5.308887] ACPI Exception: AE_NOT_FOUND, Evaluating _DOD (20140424/video-1385)
[    5.311195] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    5.320437] acpi device:09: registered as cooling_device0
[    5.320796] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input1
[    5.321698] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[    5.399804] PM: Marking nosave pages: [mem 0x0008f000-0x0008ffff]
[    5.399823] PM: Marking nosave pages: [mem 0x0009e000-0x000fffff]
[    5.399843] PM: Marking nosave pages: [mem 0x20000000-0x201fffff]
[    5.399894] PM: Marking nosave pages: [mem 0x79f09000-0x7a1defff]
[    5.399961] PM: Marking nosave pages: [mem 0x7a1ea000-0x7a1eafff]
[    5.399970] PM: Basic memory bitmaps created
[    5.411465] usb 1-1.1.1: New USB device found, idVendor=0409, idProduct=005a
[    5.411486] usb 1-1.1.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.412428] hub 1-1.1.1:1.0: USB hub found
[    5.412637] hub 1-1.1.1:1.0: 4 ports detected
[    5.476874] PM: Basic memory bitmaps freed
[    5.476926] video LNXVIDEO:00: Restoring backlight state
[    5.490705] PM: Starting manual resume from disk
[    5.490716] PM: Hibernation image partition 179:3 present
[    5.490720] PM: Looking for hibernation image.
[    5.491195] PM: Image not found (code -22)
[    5.491199] PM: Hibernation image not present or could not be loaded.
[    5.502264] usb 1-1.1.2: new low-speed USB device number 5 using ehci-pci
[    5.597233] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
[    5.600765] XFS (mmcblk0p4): Mounting V5 Filesystem
[    5.629526] usb 1-1.1.2: New USB device found, idVendor=04d9, idProduct=1603
[    5.629548] usb 1-1.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.629563] usb 1-1.1.2: Product: USB Keyboard
[    5.629576] usb 1-1.1.2: Manufacturer:  
[    5.663073] usbcore: registered new interface driver usbhid
[    5.663089] usbhid: USB HID core driver
[    5.666625] input:   USB Keyboard as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.0/0003:04D9:1603.0001/input/input2
[    5.667336] hid-generic 0003:04D9:1603.0001: input,hidraw0: USB HID v1.10 Keyboard [  USB Keyboard] on usb-0000:00:1d.0-1.1.2/input0
[    5.670488] input:   USB Keyboard as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.1/0003:04D9:1603.0002/input/input3
[    5.671110] hid-generic 0003:04D9:1603.0002: input,hidraw1: USB HID v1.10 Device [  USB Keyboard] on usb-0000:00:1d.0-1.1.2/input1
[    5.718519] usb 1-1.1.4: new high-speed USB device number 6 using ehci-pci
[    5.826931] [drm] Enabling RC6 states: RC6 on, RC6p off, RC6pp off
[    5.828184] usb 1-1.1.4: New USB device found, idVendor=0409, idProduct=005a
[    5.828205] usb 1-1.1.4: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.829507] hub 1-1.1.4:1.0: USB hub found
[    5.829771] hub 1-1.1.4:1.0: 4 ports detected
[    5.918896] usb 1-1.1.1.1: new high-speed USB device number 7 using ehci-pci
[    6.030644] usb 1-1.1.1.1: New USB device found, idVendor=03f0, idProduct=da07
[    6.030665] usb 1-1.1.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    6.030679] usb 1-1.1.1.1: Product: x702w
[    6.030692] usb 1-1.1.1.1: Manufacturer: HP
[    6.030704] usb 1-1.1.1.1: SerialNumber: 3966793238
[    6.031621] random: nonblocking pool is initialized
[    6.041745] usb-storage 1-1.1.1.1:1.0: USB Mass Storage device detected
[    6.042497] scsi0 : usb-storage 1-1.1.1.1:1.0
[    6.043179] usbcore: registered new interface driver usb-storage
[    6.045255] usbcore: registered new interface driver uas
[    6.119187] usb 1-1.1.1.4: new low-speed USB device number 8 using ehci-pci
[    6.232152] usb 1-1.1.1.4: New USB device found, idVendor=413c, idProduct=3012
[    6.232173] usb 1-1.1.1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    6.232188] usb 1-1.1.1.4: Product: Dell USB Optical Mouse
[    6.232201] usb 1-1.1.1.4: Manufacturer: Dell
[    6.237001] input: Dell Dell USB Optical Mouse as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1.1/1-1.1.1/1-1.1.1.4/1-1.1.1.4:1.0/0003:413C:3012.0003/input/input4
[    6.238707] hid-generic 0003:413C:3012.0003: input,hidraw2: USB HID v1.11 Mouse [Dell Dell USB Optical Mouse] on usb-0000:00:1d.0-1.1.1.4/input0
[    6.375782] XFS (mmcblk0p4): Ending clean mount
[    7.046467] scsi 0:0:0:0: Direct-Access     hp       x702w            1.00 PQ: 0 ANSI: 6
[    7.047825] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    7.050141] sd 0:0:0:0: [sda] 499998720 512-byte logical blocks: (255 GB/238 GiB)
[    7.051222] sd 0:0:0:0: [sda] Write Protect is off
[    7.051232] sd 0:0:0:0: [sda] Mode Sense: 23 00 00 00
[    7.054443] sd 0:0:0:0: [sda] Write cache: disabled, read cache: disabled, doesn't support DPO or FUA
[    7.065515]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
[    7.068540] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    7.423296] device-mapper: uevent: version 1.0.3
[    7.423677] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised: dm-devel@redhat.com
[    7.524423] systemd-gpt-auto-generator[330]: Failed to verify GPT partition /dev/mmcblk0rpmb: Input/output error
[    7.967161] 80860F0A:00: ttyS4 at MMIO 0x90947000 (irq = 39, base_baud = 2764800) is a 16550A
[    7.967604] 80860F0A:01: ttyS5 at MMIO 0x9094d000 (irq = 40, base_baud = 2764800) is a 16550A
[    7.973164] sst-acpi 80860F28:00: No matching ASoC machine driver found
[    8.046507] [Firmware Bug]: No valid trip found
[    8.050161] mei_txe 0000:00:1a.0: can't derive routing for PCI INT A
[    8.050163] mei_txe 0000:00:1a.0: PCI INT A: no GSI
[    8.050251] mei_txe 0000:00:1a.0: irq 108 for MSI/MSI-X
[    8.090130] input: PC Speaker as /devices/platform/pcspkr/input/input5
[    8.127130] SSE version of gcm_enc/dec engaged.
[    8.222062] had: ******** HAD DRIVER loading.. Ver: 0.01.003
[    8.223441] [drm] mid_hdmi_audio_register: Scheduling HDMI audio work queue
[    8.223873] [drm:i915_had_wq] *ERROR* Checking for HDMI connection at boot
[    8.243949] iTCO_vendor_support: vendor-support=0
[    8.244343] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    8.244424] iTCO_wdt: Found a Bay Trail SoC TCO device (Version=3, TCOBASE=0x0460)
[    8.252591] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    8.308007] intel_soc_dts_thermal: request_threaded_irq ret -22
[    8.352058] intel_soc_dts_thermal: request_threaded_irq ret -22
[    8.426336] Adding 2112508k swap on /dev/mmcblk0p3.  Priority:-1 extents:1 across:2112508k SSFS
[    8.486524] FAT-fs (mmcblk0p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   10.271320] audit: type=1305 audit(1456184492.142:2): audit_pid=1160 old=0 auid=4294967295 ses=4294967295 res=1
[   11.167936] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   11.187730] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[   11.193374] ip_tables: (C) 2000-2006 Netfilter Core Team
[   11.501305] No iBFT detected.
[   77.835556] Bluetooth: Core ver 2.19
[   77.835594] NET: Registered protocol family 31
[   77.835598] Bluetooth: HCI device and connection manager initialized
[   77.835612] Bluetooth: HCI socket layer initialized
[   77.835618] Bluetooth: L2CAP socket layer initialized
[   77.835644] Bluetooth: SCO socket layer initialized
[   77.848176] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   77.848194] Bluetooth: BNEP filters: protocol multicast
[   77.848226] Bluetooth: BNEP socket layer initialized
[   82.801731] fuse init (API version 7.23)
[  214.047085] XFS (sda1): Mounting V4 Filesystem
[  214.207260] XFS (sda1): Ending clean mount

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--IJpNTDwzlM2Ie8A6--
