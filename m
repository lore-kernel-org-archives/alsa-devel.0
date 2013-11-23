From: James Le Cuirot <chewi@aura-online.co.uk>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Sat, 23 Nov 2013 15:40:09 +0000
Message-ID: <20131123154009.6c8c6e97@symphony.aura-online.co.uk>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
 <loom.20131122T215246-90@post.gmane.org> <529004F8.7070801@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/72Yww25VaXiRPLE3wcrxa_+"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 508A9261693
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 16:40:15 +0100 (CET)
In-Reply-To: <529004F8.7070801@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--MP_/72Yww25VaXiRPLE3wcrxa_+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 23 Nov 2013 03:29:28 +0200
Anssi Hannula <anssi.hannula@iki.fi> wrote:

> 23.11.2013 03:05, James Le Cuirot kirjoitti:
> > Anssi Hannula <anssi.hannula <at> iki.fi> writes:
> > 
> >> Here's another revision of the ATI/AMD multichannel+HBR patchset.
> > 
> > Hi Anssi. Many thanks for your work on this. I am very keen to test
> > this new code but have so far been unsuccessful. I have a Radeon
> > 4670 (Sapphire branded) connected to a Yamaha RX-V773. I am running
> > the sound/for-next kernel (82755ab) with your "missing PCM SAD"
> > patch applied.
> > 
> > The new kernel has allowed ALSA to recognise the card as
> > multichannel and I can issue the following speaker-test command but
> > I still only hear "Front Left" and "Front Right" and the Yahama
> > seems to report the signal as stereo.
> > 
> > # speaker-test -Dhdmi:CARD=HDMI,DEV=0 -c6 -t wav
> 
> I guess it is the same without "-t wav"?

Yes.

> > I have the HDMI cable plugged
> > into the secondary output as my speakerless DVI monitor is plugged
> > into the primary but I have also tried the HDMI cable in the
> > primary output by itself.
> 
> Hmm, I'm not sure what the behavior is supposed to be with multiple
> video outputs when we have only a single audio output (HDA pin)...
> 
> What happens if you plug both of your outputs to the A/V receiver,
> will only one output get audio?

I tried this and as I expected, it sent the same audio to both outputs.
Still stereo only though.

> ELD stuff is not necessary for playback, it is mostly for information
> (and providing the necessary info for ELD is disabled on radeon DRI
> drivers on some kernels on some GPUs ATM due to some issues).
> 
> Is there anything interesting in "dmesg"?

I have attached my dmesg. I enabled ALSA debug and verbose printk but
disabled the on-board HDA audio in the BIOS to make it less confusing,
and also to see if it made any difference, which it didn't. The only
entry I find noteworthy is about the ELD but you say this isn't
required.

There seems to be little to go on here. Would it be worth enabling
CONFIG_SND_DEBUG_VERBOSE? I gather it's very noisy but maybe that level
of detail is needed. Hopefully you have a better idea.

Regards,
James
--MP_/72Yww25VaXiRPLE3wcrxa_+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dmesg.txt

[    0.000000] Linux version 3.12.0-gentoo (root@symphony.aura-online.co.uk) (gcc version 4.8.2 (Gentoo 4.8.2 p1.0, pie-0.5.8) ) #4 SMP PREEMPT Sat Nov 23 11:56:35 GMT 2013
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.12.0-gentoo root=/dev/sdb6 ro radeon.dpm=1 radeon.pcie_gen2=1 radeon.audio=1 modprobe.blacklist=fglrx
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000df7affff] usable
[    0.000000] BIOS-e820: [mem 0x00000000df7b0000-0x00000000df7e1fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000df7e2000-0x00000000df7effff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000df7f0000-0x00000000df7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f4000000-0x00000000f7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000021fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. P55A-UD6(C)/P55A-UD6(C), BIOS F10 06/30/2010
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn = 0x220000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CEFFF write-protect
[    0.000000]   CF000-EFFFF uncachable
[    0.000000]   F0000-FFFFF write-through
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F00000000 write-back
[    0.000000]   1 base 0E0000000 mask FE0000000 uncachable
[    0.000000]   2 base 100000000 mask F00000000 write-back
[    0.000000]   3 base 200000000 mask FE0000000 write-back
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820: update [mem 0xe0000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xdf7b0 max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [ffff880000097000] 97000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01871000, 0x01871fff] PGTABLE
[    0.000000] BRK [0x01872000, 0x01872fff] PGTABLE
[    0.000000] BRK [0x01873000, 0x01873fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x21fe00000-0x21fffffff]
[    0.000000]  [mem 0x21fe00000-0x21fffffff] page 2M
[    0.000000] BRK [0x01874000, 0x01874fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x21c000000-0x21fdfffff]
[    0.000000]  [mem 0x21c000000-0x21fdfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x200000000-0x21bffffff]
[    0.000000]  [mem 0x200000000-0x21bffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0xdf7affff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0xdf5fffff] page 2M
[    0.000000]  [mem 0xdf600000-0xdf7affff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x1ffffffff]
[    0.000000]  [mem 0x100000000-0x1ffffffff] page 2M
[    0.000000] BRK [0x01875000, 0x01875fff] PGTABLE
[    0.000000] BRK [0x01876000, 0x01876fff] PGTABLE
[    0.000000] ACPI: RSDP 00000000000f77a0 00014 (v00 GBT   )
[    0.000000] ACPI: RSDT 00000000df7e2040 00040 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: FACP 00000000df7e20c0 00074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: DSDT 00000000df7e2180 0543D (v01 GBT    GBTUACPI 00001000 MSFT 0100000C)
[    0.000000] ACPI: FACS 00000000df7b0000 00040
[    0.000000] ACPI: HPET 00000000df7e7700 00038 (v01 GBT    GBTUACPI 42302E31 GBTU 00000098)
[    0.000000] ACPI: MCFG 00000000df7e7780 0003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: EUDS 00000000df7e7840 00560 (v01 GBT             00000000      00000000)
[    0.000000] ACPI: TAMG 00000000df7e7da0 00A32 (v01 GBT    GBT   B0 5455312E BG?? 53450101)
[    0.000000] ACPI: APIC 00000000df7e7600 000BC (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.000000] ACPI: SSDT 00000000df7e8800 034FC (v01  INTEL PPM RCM  80000001 INTL 20061109)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000]  [ffffea0000000000-ffffea00087fffff] PMD -> [ffff880217600000-ffff88021f5fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x21fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009cfff]
[    0.000000]   node   0: [mem 0x00100000-0xdf7affff]
[    0.000000]   node   0: [mem 0x100000000-0x21fffffff]
[    0.000000] On node 0 totalpages: 2094924
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14239 pages used for memmap
[    0.000000]   DMA32 zone: 911280 pages, LIFO batch:31
[    0.000000]   Normal zone: 18432 pages used for memmap
[    0.000000]   Normal zone: 1179648 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] e820: [mem 0xdf800000-0xf3ffffff] available for PCI devices
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 26 pages/cpu @ffff88021fc00000 s75136 r8192 d23168 u262144
[    0.000000] pcpu-alloc: s75136 r8192 d23168 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2062168
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-3.12.0-gentoo root=/dev/sdb6 ro radeon.dpm=1 radeon.pcie_gen2=1 radeon.audio=1 modprobe.blacklist=fglrx
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Memory: 8160528K/8379696K available (4850K kernel code, 413K rwdata, 1544K rodata, 780K init, 1016K bss, 219168K reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Dump stacks of tasks blocking RCU-preempt GP.
[    0.000000] 	Offload RCU callbacks from all CPUs
[    0.000000] 	Offload RCU callbacks from CPUs: 0-7.
[    0.000000] NR_IRQS:4352 nr_irqs:744 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.001000] tsc: Detected 2930.995 MHz processor
[    0.000001] Calibrating delay loop (skipped), value calculated using timer frequency.. 5861.99 BogoMIPS (lpj=2930995)
[    0.000090] pid_max: default: 32768 minimum: 301
[    0.000147] Security Framework initialized
[    0.000193] Mount-cache hash table entries: 256
[    0.000351] CPU: Physical Processor ID: 0
[    0.000393] CPU: Processor Core ID: 0
[    0.000435] mce: CPU supports 9 MCE banks
[    0.000482] CPU0: Thermal monitoring enabled (TM1)
[    0.000530] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32
tlb_flushall_shift: 6
[    0.000671] Freeing SMP alternatives memory: 20K (ffffffff8176d000 - ffffffff81772000)
[    0.000719] ACPI: Core revision 20130725
[    0.001960] ACPI: All ACPI Tables successfully acquired
[    0.006125] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.016160] smpboot: CPU0: Intel(R) Core(TM) i7 CPU       K 875  @ 2.93GHz (fam: 06, model: 1e, stepping: 05)
[    0.117466] Performance Events: PEBS fmt1+, 16-deep LBR, Nehalem events, Intel PMU driver.
[    0.117619] perf_event_intel: CPU erratum AAJ80 worked around
[    0.117663] perf_event_intel: CPUID marked event: 'bus cycles' unavailable
[    0.117709] ... version:                3
[    0.117751] ... bit width:              48
[    0.117792] ... generic registers:      4
[    0.117833] ... value mask:             0000ffffffffffff
[    0.117876] ... max period:             000000007fffffff
[    0.117919] ... fixed-purpose events:   3
[    0.117959] ... event mask:             000000070000000f
[    0.123522] smpboot: Booting Node   0, Processors  #   1 #   2 #   3 #   4 #   5 #   6 #   7 OK
[    0.226723] Brought up 8 CPUs
[    0.226766] smpboot: Total of 8 processors activated (46895.92 BogoMIPS)
[    0.231508] devtmpfs: initialized
[    0.231809] NET: Registered protocol family 16
[    0.232016] cpuidle: using governor ladder
[    0.232058] cpuidle: using governor menu
[    0.232120] ACPI: bus type PCI registered
[    0.232172] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf4000000-0xf7ffffff] (base 0xf4000000)
[    0.232233] PCI: MMCONFIG at [mem 0xf4000000-0xf7ffffff] reserved in E820
[    0.234935] PCI: Using configuration type 1 for base access
[    0.237724] bio: create slab <bio-0> at 0
[    0.237877] ACPI: Added _OSI(Module Device)
[    0.237918] ACPI: Added _OSI(Processor Device)
[    0.237960] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.238003] ACPI: Added _OSI(Processor Aggregator Device)
[    0.238512] ACPI: EC: Look up EC in DSDT
[    0.241151] ACPI BIOS Warning (bug): Incorrect checksum in table [TAMG] - 0x10, should be 0x0F (20130725/tbprint-204)
[    0.241929] ACPI: Interpreter enabled
[    0.241973] ACPI: (supports S0 S5)
[    0.242013] ACPI: Using IOAPIC for interrupt routing
[    0.242085] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.242210] ACPI: No dock devices found.
[    0.246479] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    0.246526] acpi PNP0A03:00: ACPI _OSC support notification failed, disabling PCIe ASPM
[    0.246574] acpi PNP0A03:00: Unable to request _OSC control (_OSC support mask: 0x08)
[    0.246725] PCI host bridge to bus 0000:00
[    0.246768] pci_bus 0000:00: root bus resource [bus 00-3f]
[    0.246812] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    0.246857] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    0.246902] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.246947] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff]
[    0.246993] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff]
[    0.247039] pci_bus 0000:00: root bus resource [mem 0xdf800000-0xfebfffff]
[    0.247091] pci 0000:00:00.0: [8086:d131] type 00 class 0x060000
[    0.247184] pci 0000:00:03.0: [8086:d138] type 01 class 0x060400
[    0.247225] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.247290] pci 0000:00:08.0: [8086:d155] type 00 class 0x088000
[    0.247379] pci 0000:00:08.1: [8086:d156] type 00 class 0x088000
[    0.247469] pci 0000:00:08.2: [8086:d157] type 00 class 0x088000
[    0.247555] pci 0000:00:08.3: [8086:d158] type 00 class 0x088000
[    0.247636] pci 0000:00:10.0: [8086:d150] type 00 class 0x088000
[    0.247720] pci 0000:00:10.1: [8086:d151] type 00 class 0x088000
[    0.247811] pci 0000:00:1a.0: [8086:3b3b] type 00 class 0x0c0300
[    0.247848] pci 0000:00:1a.0: reg 0x20: [io  0xff00-0xff1f]
[    0.247942] pci 0000:00:1a.1: [8086:3b3e] type 00 class 0x0c0300
[    0.247979] pci 0000:00:1a.1: reg 0x20: [io  0xfe00-0xfe1f]
[    0.248072] pci 0000:00:1a.2: [8086:3b3f] type 00 class 0x0c0300
[    0.248108] pci 0000:00:1a.2: reg 0x20: [io  0xfd00-0xfd1f]
[    0.248208] pci 0000:00:1a.7: [8086:3b3c] type 00 class 0x0c0320
[    0.248227] pci 0000:00:1a.7: reg 0x10: [mem 0xfbfff000-0xfbfff3ff]
[    0.248306] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.248376] pci 0000:00:1c.0: [8086:3b42] type 01 class 0x060400
[    0.248435] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.248502] pci 0000:00:1c.1: [8086:3b44] type 01 class 0x060400
[    0.248562] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.248635] pci 0000:00:1d.0: [8086:3b36] type 00 class 0x0c0300
[    0.248674] pci 0000:00:1d.0: reg 0x20: [io  0xfc00-0xfc1f]
[    0.248768] pci 0000:00:1d.1: [8086:3b37] type 00 class 0x0c0300
[    0.248805] pci 0000:00:1d.1: reg 0x20: [io  0xfb00-0xfb1f]
[    0.248897] pci 0000:00:1d.2: [8086:3b38] type 00 class 0x0c0300
[    0.248934] pci 0000:00:1d.2: reg 0x20: [io  0xfa00-0xfa1f]
[    0.249027] pci 0000:00:1d.3: [8086:3b39] type 00 class 0x0c0300
[    0.249063] pci 0000:00:1d.3: reg 0x20: [io  0xf900-0xf91f]
[    0.249163] pci 0000:00:1d.7: [8086:3b34] type 00 class 0x0c0320
[    0.249181] pci 0000:00:1d.7: reg 0x10: [mem 0xfbffe000-0xfbffe3ff]
[    0.249260] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.249328] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.249433] pci 0000:00:1f.0: [8086:3b02] type 00 class 0x060100
[    0.249592] pci 0000:00:1f.2: [8086:3b22] type 00 class 0x010601
[    0.249608] pci 0000:00:1f.2: reg 0x10: [io  0xf800-0xf807]
[    0.249614] pci 0000:00:1f.2: reg 0x14: [io  0xf700-0xf703]
[    0.249620] pci 0000:00:1f.2: reg 0x18: [io  0xf600-0xf607]
[    0.249627] pci 0000:00:1f.2: reg 0x1c: [io  0xf500-0xf503]
[    0.249633] pci 0000:00:1f.2: reg 0x20: [io  0xf400-0xf41f]
[    0.249639] pci 0000:00:1f.2: reg 0x24: [mem 0xfbffd000-0xfbffd7ff]
[    0.249682] pci 0000:00:1f.2: PME# supported from D3hot
[    0.249754] pci 0000:00:1f.3: [8086:3b30] type 00 class 0x0c0500
[    0.249767] pci 0000:00:1f.3: reg 0x10: [mem 0xfbffc000-0xfbffc0ff 64bit]
[    0.249784] pci 0000:00:1f.3: reg 0x20: [io  0x0500-0x051f]
[    0.249907] pci 0000:01:00.0: [1002:9490] type 00 class 0x030000
[    0.249918] pci 0000:01:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.249927] pci 0000:01:00.0: reg 0x18: [mem 0xfbce0000-0xfbceffff 64bit]
[    0.249933] pci 0000:01:00.0: reg 0x20: [io  0xee00-0xeeff]
[    0.249943] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.249970] pci 0000:01:00.0: supports D1 D2
[    0.250012] pci 0000:01:00.1: [1002:aa38] type 00 class 0x040300
[    0.250023] pci 0000:01:00.1: reg 0x10: [mem 0xfbcfc000-0xfbcfffff 64bit]
[    0.250073] pci 0000:01:00.1: supports D1 D2
[    0.251673] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.251729] pci 0000:00:03.0:   bridge window [io  0xe000-0xefff]
[    0.251734] pci 0000:00:03.0:   bridge window [mem 0xfbc00000-0xfbcfffff]
[    0.251740] pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xefffffff 64bit pref]
[    0.251822] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000
[    0.251837] pci 0000:02:00.0: reg 0x10: [io  0xce00-0xceff]
[    0.251862] pci 0000:02:00.0: reg 0x18: [mem 0xfbaff000-0xfbafffff 64bit pref]
[    0.251877] pci 0000:02:00.0: reg 0x20: [mem 0xfbaf8000-0xfbafbfff 64bit pref]
[    0.251888] pci 0000:02:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.251947] pci 0000:02:00.0: supports D1 D2
[    0.251948] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.253676] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.253730] pci 0000:00:1c.0:   bridge window [io  0xc000-0xcfff]
[    0.253735] pci 0000:00:1c.0:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    0.253742] pci 0000:00:1c.0:   bridge window [mem 0xfba00000-0xfbafffff 64bit pref]
[    0.253824] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000
[    0.253839] pci 0000:03:00.0: reg 0x10: [io  0xbe00-0xbeff]
[    0.253864] pci 0000:03:00.0: reg 0x18: [mem 0xfbdff000-0xfbdfffff 64bit pref]
[    0.253880] pci 0000:03:00.0: reg 0x20: [mem 0xfbdf8000-0xfbdfbfff 64bit pref]
[    0.253891] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    0.253950] pci 0000:03:00.0: supports D1 D2
[    0.253951] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.255684] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.255739] pci 0000:00:1c.1:   bridge window [io  0xb000-0xbfff]
[    0.255744] pci 0000:00:1c.1:   bridge window [mem 0xfbe00000-0xfbefffff]
[    0.255751] pci 0000:00:1c.1:   bridge window [mem 0xfbd00000-0xfbdfffff 64bit pref]
[    0.255819] pci 0000:04:07.0: [1283:8213] type 00 class 0x010185
[    0.255833] pci 0000:04:07.0: reg 0x10: [io  0xdf00-0xdf07]
[    0.255841] pci 0000:04:07.0: reg 0x14: [io  0xde00-0xde03]
[    0.255848] pci 0000:04:07.0: reg 0x18: [io  0xdd00-0xdd07]
[    0.255856] pci 0000:04:07.0: reg 0x1c: [io  0xdc00-0xdc03]
[    0.255864] pci 0000:04:07.0: reg 0x20: [io  0xdb00-0xdb0f]
[    0.255957] pci 0000:00:1e.0: PCI bridge to [bus 04] (subtractive decode)
[    0.256005] pci 0000:00:1e.0:   bridge window [io  0xd000-0xdfff]
[    0.256010] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.256011] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.256014] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.256015] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    0.256016] pci 0000:00:1e.0:   bridge window [mem 0xfed40000-0xfed44fff] (subtractive decode)
[    0.256017] pci 0000:00:1e.0:   bridge window [mem 0xdf800000-0xfebfffff] (subtractive decode)
[    0.256037] pci_bus 0000:00: on NUMA node 0
[    0.256300] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.256727] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
[    0.257142] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 9 10 11 12 14 15)
[    0.257559] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    0.257976] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    0.258445] ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
[    0.258863] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[    0.259331] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[    0.259785] ACPI: \_SB_.PCI0: notify handler is installed
[    0.259808] Found 1 acpi root devices
[    0.259877] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.259925] vgaarb: loaded
[    0.259964] vgaarb: bridge control possible 0000:01:00.0
[    0.260075] SCSI subsystem initialized
[    0.260173] libata version 3.00 loaded.
[    0.260174] ACPI: bus type USB registered
[    0.260249] usbcore: registered new interface driver usbfs
[    0.260309] usbcore: registered new interface driver hub
[    0.260378] usbcore: registered new device driver usb
[    0.260467] Linux video capture interface: v2.00
[    0.260553] EDAC MC: Ver: 3.0.0
[    0.260717] PCI: Using ACPI for IRQ routing
[    0.262031] PCI: Discovered peer bus 3f
[    0.262072] PCI: root bus 3f: using default resources
[    0.262073] PCI: Probing PCI hardware (bus 3f)
[    0.262098] PCI host bridge to bus 0000:3f
[    0.262140] pci_bus 0000:3f: root bus resource [io  0x0000-0xffff]
[    0.262185] pci_bus 0000:3f: root bus resource [mem 0x00000000-0xfffffffff]
[    0.262231] pci_bus 0000:3f: No busn resource found for root bus, will use [bus 3f-ff]
[    0.262279] pci_bus 0000:3f: busn_res: can not insert [bus 3f-ff] under domain [bus 00-ff] (conflicts with (null) [bus 00-3f])
[    0.262283] pci 0000:3f:00.0: [8086:2c51] type 00 class 0x060000
[    0.262322] pci 0000:3f:00.1: [8086:2c81] type 00 class 0x060000
[    0.262361] pci 0000:3f:02.0: [8086:2c90] type 00 class 0x060000
[    0.262400] pci 0000:3f:02.1: [8086:2c91] type 00 class 0x060000
[    0.262437] pci 0000:3f:03.0: [8086:2c98] type 00 class 0x060000
[    0.262473] pci 0000:3f:03.1: [8086:2c99] type 00 class 0x060000
[    0.262511] pci 0000:3f:03.4: [8086:2c9c] type 00 class 0x060000
[    0.262547] pci 0000:3f:04.0: [8086:2ca0] type 00 class 0x060000
[    0.262583] pci 0000:3f:04.1: [8086:2ca1] type 00 class 0x060000
[    0.262619] pci 0000:3f:04.2: [8086:2ca2] type 00 class 0x060000
[    0.262658] pci 0000:3f:04.3: [8086:2ca3] type 00 class 0x060000
[    0.262698] pci 0000:3f:05.0: [8086:2ca8] type 00 class 0x060000
[    0.262734] pci 0000:3f:05.1: [8086:2ca9] type 00 class 0x060000
[    0.262770] pci 0000:3f:05.2: [8086:2caa] type 00 class 0x060000
[    0.262806] pci 0000:3f:05.3: [8086:2cab] type 00 class 0x060000
[    0.262851] pci_bus 0000:3f: busn_res: [bus 3f-ff] end is updated to 3f
[    0.262854] PCI: pci_cache_line_size set to 64 bytes
[    0.262913] e820: reserve RAM buffer [mem 0x0009dc00-0x0009ffff]
[    0.262914] e820: reserve RAM buffer [mem 0xdf7b0000-0xdfffffff]
[    0.263052] HPET: 8 timers in total, 5 timers will be used for per-cpu timer
[    0.263103] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 40, 41, 42, 43, 44, 0
[    0.263382] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.265456] hpet: hpet2 irq 40 for MSI
[    0.265488] hpet: hpet3 irq 41 for MSI
[    0.265518] hpet: hpet4 irq 42 for MSI
[    0.265548] hpet: hpet5 irq 43 for MSI
[    0.265575] hpet: hpet6 irq 44 for MSI
[    0.265640] Switched to clocksource hpet
[    0.268997] pnp: PnP ACPI init
[    0.269042] ACPI: bus type PNP registered
[    0.269204] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    0.269249] system 00:00: [io  0x0290-0x029f] has been reserved
[    0.269294] system 00:00: [io  0x0800-0x0805] has been reserved
[    0.269339] system 00:00: [io  0x0290-0x0294] has been reserved
[    0.269383] system 00:00: [io  0x0880-0x088f] has been reserved
[    0.269428] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.269436] pnp 00:01: [dma 4]
[    0.269476] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.269553] pnp 00:02: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.269612] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.269657] pnp 00:04: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.269703] pnp 00:05: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.269783] pnp 00:06: [dma 2]
[    0.269834] pnp 00:06: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.269998] pnp 00:07: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.270087] system 00:08: [io  0x0400-0x047f] could not be reserved
[    0.270133] system 00:08: [io  0x0580-0x05ff] has been reserved
[    0.270178] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.270337] system 00:09: [mem 0xf4000000-0xf7ffffff] has been reserved
[    0.270384] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.270537] system 00:0a: [mem 0x000d1a00-0x000d3fff] has been reserved
[    0.270583] system 00:0a: [mem 0x000f0000-0x000f7fff] could not be reserved
[    0.270629] system 00:0a: [mem 0x000f8000-0x000fbfff] could not be reserved
[    0.271230] system 00:0a: [mem 0x000fc000-0x000fffff] could not be reserved
[    0.271276] system 00:0a: [mem 0xdf7b0000-0xdf7effff] could not be reserved
[    0.271323] system 00:0a: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.271369] system 00:0a: [mem 0x00100000-0xdf7affff] could not be reserved
[    0.271415] system 00:0a: [mem 0xdf7f0000-0xdf7fffff] has been reserved
[    0.271460] system 00:0a: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.271507] system 00:0a: [mem 0xfed10000-0xfed1dfff] has been reserved
[    0.271552] system 00:0a: [mem 0xfed20000-0xfed8ffff] could not be reserved
[    0.271598] system 00:0a: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.271652] system 00:0a: [mem 0xffb00000-0xffb7ffff] has been reserved
[    0.271699] system 00:0a: [mem 0xfff00000-0xffffffff] has been reserved
[    0.271744] system 00:0a: [mem 0x000e0000-0x000effff] has been reserved
[    0.271790] system 00:0a: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.271846] pnp 00:0b: Plug and Play ACPI device, IDs INT0800 (active)
[    0.271850] pnp: PnP ACPI: found 12 devices
[    0.271891] ACPI: bus type PNP unregistered
[    0.276530] pci 0000:01:00.0: BAR 6: assigned [mem 0xfbc00000-0xfbc1ffff pref]
[    0.276578] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.276621] pci 0000:00:03.0:   bridge window [io  0xe000-0xefff]
[    0.276673] pci 0000:00:03.0:   bridge window [mem 0xfbc00000-0xfbcfffff]
[    0.276720] pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xefffffff 64bit pref]
[    0.276770] pci 0000:02:00.0: BAR 6: assigned [mem 0xfba00000-0xfba1ffff pref]
[    0.276816] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.276859] pci 0000:00:1c.0:   bridge window [io  0xc000-0xcfff]
[    0.276906] pci 0000:00:1c.0:   bridge window [mem 0xfbb00000-0xfbbfffff]
[    0.276953] pci 0000:00:1c.0:   bridge window [mem 0xfba00000-0xfbafffff 64bit pref]
[    0.277004] pci 0000:03:00.0: BAR 6: assigned [mem 0xfbd00000-0xfbd1ffff pref]
[    0.277050] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    0.277093] pci 0000:00:1c.1:   bridge window [io  0xb000-0xbfff]
[    0.277140] pci 0000:00:1c.1:   bridge window [mem 0xfbe00000-0xfbefffff]
[    0.277187] pci 0000:00:1c.1:   bridge window [mem 0xfbd00000-0xfbdfffff 64bit pref]
[    0.277238] pci 0000:00:1e.0: PCI bridge to [bus 04]
[    0.277281] pci 0000:00:1e.0:   bridge window [io  0xd000-0xdfff]
[    0.277333] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.277334] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.277335] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.277336] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff]
[    0.277337] pci_bus 0000:00: resource 8 [mem 0xfed40000-0xfed44fff]
[    0.277338] pci_bus 0000:00: resource 9 [mem 0xdf800000-0xfebfffff]
[    0.277339] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.277340] pci_bus 0000:01: resource 1 [mem 0xfbc00000-0xfbcfffff]
[    0.277341] pci_bus 0000:01: resource 2 [mem 0xe0000000-0xefffffff 64bit pref]
[    0.277342] pci_bus 0000:02: resource 0 [io  0xc000-0xcfff]
[    0.277343] pci_bus 0000:02: resource 1 [mem 0xfbb00000-0xfbbfffff]
[    0.277344] pci_bus 0000:02: resource 2 [mem 0xfba00000-0xfbafffff 64bit pref]
[    0.277345] pci_bus 0000:03: resource 0 [io  0xb000-0xbfff]
[    0.277346] pci_bus 0000:03: resource 1 [mem 0xfbe00000-0xfbefffff]
[    0.277347] pci_bus 0000:03: resource 2 [mem 0xfbd00000-0xfbdfffff 64bit pref]
[    0.277348] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
[    0.277349] pci_bus 0000:04: resource 4 [io  0x0000-0x0cf7]
[    0.277351] pci_bus 0000:04: resource 5 [io  0x0d00-0xffff]
[    0.277352] pci_bus 0000:04: resource 6 [mem 0x000a0000-0x000bffff]
[    0.277353] pci_bus 0000:04: resource 7 [mem 0x000c0000-0x000dffff]
[    0.277354] pci_bus 0000:04: resource 8 [mem 0xfed40000-0xfed44fff]
[    0.277355] pci_bus 0000:04: resource 9 [mem 0xdf800000-0xfebfffff]
[    0.277356] pci_bus 0000:3f: resource 4 [io  0x0000-0xffff]
[    0.277357] pci_bus 0000:3f: resource 5 [mem 0x00000000-0xfffffffff]
[    0.277373] NET: Registered protocol family 2
[    0.277497] TCP established hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.277787] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.278065] TCP: Hash tables configured (established 65536 bind 65536)
[    0.278125] TCP: reno registered
[    0.278167] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.278253] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.278376] NET: Registered protocol family 1
[    0.300744] pci 0000:01:00.0: Boot video device
[    0.300764] PCI: CLS 64 bytes, default 64
[    0.300789] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.300836] software IO TLB [mem 0xdb7b0000-0xdf7b0000] (64MB) mapped at [ffff8800db7b0000-ffff8800df7affff]
[    0.301936] microcode: CPU0 sig=0x106e5, pf=0x2, revision=0x4
[    0.301983] microcode: CPU1 sig=0x106e5, pf=0x2, revision=0x4
[    0.302031] microcode: CPU2 sig=0x106e5, pf=0x2, revision=0x4
[    0.302078] microcode: CPU3 sig=0x106e5, pf=0x2, revision=0x4
[    0.302125] microcode: CPU4 sig=0x106e5, pf=0x2, revision=0x4
[    0.302173] microcode: CPU5 sig=0x106e5, pf=0x2, revision=0x4
[    0.302220] microcode: CPU6 sig=0x106e5, pf=0x2, revision=0x4
[    0.302266] microcode: CPU7 sig=0x106e5, pf=0x2, revision=0x4
[    0.302359] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    0.306317] fuse init (API version 7.22)
[    0.306529] msgmni has been set to 15938
[    0.307060] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.307107] io scheduler noop registered
[    0.307191] io scheduler cfq registered (default)
[    0.330537] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.351115] 00:07: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.351793] intel_idle: MWAIT substates: 0x1120
[    0.351801] intel_idle: v0.4 model 0x1E
[    0.351801] intel_idle: lapic_timer_reliable_states 0x2
[    0.352013] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
[    0.352063] ACPI: Power Button [PWRB]
[    0.352159] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.352206] ACPI: Power Button [PWRF]
[    0.352345] ACPI: Requesting acpi_cpufreq
[    0.355541] brd: module loaded
[    0.355967] ahci 0000:00:1f.2: version 3.0
[    0.356060] ahci 0000:00:1f.2: irq 45 for MSI/MSI-X
[    0.356082] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    0.366577] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
[    0.366626] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part ems apst 
[    0.366687] ahci 0000:00:1f.2: setting latency timer to 64
[    0.378138] scsi0 : ahci
[    0.378276] scsi1 : ahci
[    0.378407] scsi2 : ahci
[    0.378540] scsi3 : ahci
[    0.378670] scsi4 : ahci
[    0.378801] scsi5 : ahci
[    0.378914] ata1: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd100 irq 45
[    0.378961] ata2: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd180 irq 45
[    0.379007] ata3: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd200 irq 45
[    0.379054] ata4: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd280 irq 45
[    0.379101] ata5: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd300 irq 45
[    0.379148] ata6: SATA max UDMA/133 abar m2048@0xfbffd000 port 0xfbffd380 irq 45
[    0.379448] pata_it8213 0000:04:07.0: version 0.0.3
[    0.379454] pci 0000:00:1e.0: setting latency timer to 64
[    0.379501] pata_it8213 0000:04:07.0: setting latency timer to 64
[    0.380316] scsi6 : pata_it8213
[    0.380605] scsi7 : pata_it8213
[    0.380864] ata7: PATA max UDMA/133 cmd 0xdf00 ctl 0xde00 bmdma 0xdb00 irq 16
[    0.380910] ata8: DUMMY
[    0.381418] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.381464] ehci-pci: EHCI PCI platform driver
[    0.381587] ehci-pci 0000:00:1a.7: setting latency timer to 64
[    0.381596] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    0.381642] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    0.381698] ehci-pci 0000:00:1a.7: debug port 2
[    0.385637] ehci-pci 0000:00:1a.7: cache line size of 64 is not supported
[    0.385647] ehci-pci 0000:00:1a.7: irq 18, io mem 0xfbfff000
[    0.391530] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    0.391789] hub 1-0:1.0: USB hub found
[    0.391840] hub 1-0:1.0: 6 ports detected
[    0.392072] ehci-pci 0000:00:1d.7: setting latency timer to 64
[    0.392078] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    0.392123] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    0.392177] ehci-pci 0000:00:1d.7: debug port 2
[    0.396144] ehci-pci 0000:00:1d.7: cache line size of 64 is not supported
[    0.396154] ehci-pci 0000:00:1d.7: irq 23, io mem 0xfbffe000
[    0.401629] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    0.401986] hub 2-0:1.0: USB hub found
[    0.402043] hub 2-0:1.0: 8 ports detected
[    0.402407] uhci_hcd: USB Universal Host Controller Interface driver
[    0.402641] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[    0.402643] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    0.402692] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    0.402756] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000ff00
[    0.403159] hub 3-0:1.0: USB hub found
[    0.403214] hub 3-0:1.0: 2 ports detected
[    0.403384] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[    0.403386] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    0.403431] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    0.403502] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000fe00
[    0.403910] hub 4-0:1.0: USB hub found
[    0.403968] hub 4-0:1.0: 2 ports detected
[    0.404143] uhci_hcd 0000:00:1a.2: setting latency timer to 64
[    0.404145] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    0.404190] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    0.404253] uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000fd00
[    0.404647] hub 5-0:1.0: USB hub found
[    0.404700] hub 5-0:1.0: 2 ports detected
[    0.404872] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    0.404874] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    0.404919] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    0.404982] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000fc00
[    0.405343] hub 6-0:1.0: USB hub found
[    0.405395] hub 6-0:1.0: 2 ports detected
[    0.405649] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    0.405652] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    0.405699] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    0.405770] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000fb00
[    0.406156] hub 7-0:1.0: USB hub found
[    0.406208] hub 7-0:1.0: 2 ports detected
[    0.406379] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    0.406381] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    0.406426] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    0.406490] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000fa00
[    0.406836] hub 8-0:1.0: USB hub found
[    0.406886] hub 8-0:1.0: 2 ports detected
[    0.407060] uhci_hcd 0000:00:1d.3: setting latency timer to 64
[    0.407062] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    0.407107] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 9
[    0.407172] uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000f900
[    0.407411] hub 9-0:1.0: USB hub found
[    0.407462] hub 9-0:1.0: 2 ports detected
[    0.407799] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    0.440801] i8042: Failed to disable AUX port, but continuing anyway... Is this a SiS?
[    0.440847] i8042: If AUX port is really absent please use the 'i8042.noaux' option
[    0.690320] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.691400] mousedev: PS/2 mouse device common for all mice
[    0.692827] rtc_cmos 00:03: RTC can wake from S4
[    0.693135] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    0.693217] rtc_cmos 00:03: alarms up to one month, 242 bytes nvram, hpet irqs
[    0.693501] i2c /dev entries driver
[    0.693836] i801_smbus 0000:00:1f.3: SMBus using PCI Interrupt
[    0.695092] it87: Found IT8720F chip at 0x290, revision 8
[    0.695141] it87: VID is disabled (pins used for GPIO)
[    0.695192] it87: Routing internal VCCH to in7
[    0.695242] it87: Beeping is supported
[    0.695790] it87_wdt: Chip IT8720 revision 8 initialized. timeout=60 sec (nowayout=0 testmode=0 exclusive=1 nogameport=0)
[    0.696398] device-mapper: ioctl: 4.26.0-ioctl (2013-08-15) initialised: dm-devel@redhat.com
[    0.697401] EDAC MC0: Giving out device to 'i7core_edac.c' 'i7 core #0': DEV 0000:3f:03.0
[    0.697546] EDAC PCI0: Giving out device to module 'i7core_edac' controller 'EDAC PCI controller': DEV '0000:3f:03.0' (POLLED)
[    0.697611] EDAC i7core: Driver loaded, 1 memory controller(s) found.
[    0.697774] hidraw: raw HID events driver (C) Jiri Kosina
[    0.698298] usbcore: registered new interface driver usbhid
[    0.698341] usbhid: USB HID core driver
[    0.698398] u32 classifier
[    0.698437]     Actions configured
[    0.698515] TCP: cubic registered
[    0.698555] Initializing XFRM netlink socket
[    0.698822] NET: Registered protocol family 10
[    0.698958] sit: IPv6 over IPv4 tunneling driver
[    0.699167] NET: Registered protocol family 17
[    0.699211] NET: Registered protocol family 15
[    0.699343] Bridge firewalling registered
[    0.699389] Key type dns_resolver registered
[    0.700558] registered taskstats version 1
[    0.701142] rtc_cmos 00:03: setting system clock to 2013-11-23 13:43:38 UTC (1385214218)
[    0.838213] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    0.838840] ata1.00: ATA-7: WDC WD400BD-75LRA0, 09.01D09, max UDMA/133
[    0.838886] ata1.00: 78125000 sectors, multi 0: LBA48 
[    0.839579] ata1.00: configured for UDMA/133
[    0.839816] scsi 0:0:0:0: Direct-Access     ATA      WDC WD400BD-75LR 09.0 PQ: 0 ANSI: 5
[    0.840959] sd 0:0:0:0: [sda] 78125000 512-byte logical blocks: (40.0 GB/37.2 GiB)
[    0.841063] sd 0:0:0:0: [sda] Write Protect is off
[    0.841201] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    0.841891] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.841903] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.848313] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    0.857574]  sda: sda1
[    0.858339] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.300761] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.301709] tsc: Refined TSC clocksource calibration: 2931.249 MHz
[    1.307362] ata2.00: ATA-7: SAMSUNG HD103UJ, 1AA01113, max UDMA7
[    1.307407] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    1.314098] ata2.00: configured for UDMA/133
[    1.314314] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD103UJ  1AA0 PQ: 0 ANSI: 5
[    1.315312] sd 1:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
[    1.315496] sd 1:0:0:0: [sdb] Write Protect is off
[    1.315544] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.315555] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    1.315559] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.403335]  sdb: sdb1 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 sdb11 >
[    1.405004] sd 1:0:0:0: [sdb] Attached SCSI disk
[    1.531501] usb 4-1: new low-speed USB device number 2 using uhci_hcd
[    1.775299] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.775946] ata3.00: ATAPI: ATAPI   iHOS104, WL0F, max UDMA/100
[    1.776830] ata3.00: configured for UDMA/100
[    1.781767] scsi 2:0:0:0: CD-ROM            ATAPI    iHOS104          WL0F PQ: 0 ANSI: 5
[    1.786124] sr0: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
[    1.786191] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.787049] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    1.787706] sr 2:0:0:0: Attached scsi generic sg2 type 5
[    1.842707] hid-generic 0003:0764:0501.0001: hiddev0,hidraw0: USB HID v1.10 Device [CPS DX600E] on usb-0000:00:1a.1-1/input0
[    2.048048] usb 8-1: new low-speed USB device number 2 using uhci_hcd
[    2.247839] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.248993] ata4.00: ATA-8: Hitachi HTS725016A9A362, PCBOC70E, max UDMA/133
[    2.249051] ata4.00: 312581808 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    2.250445] ata4.00: configured for UDMA/133
[    2.250851] scsi 3:0:0:0: Direct-Access     ATA      Hitachi HTS72501 PCBO PQ: 0 ANSI: 5
[    2.251606] sd 3:0:0:0: [sdc] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.251706] sd 3:0:0:0: [sdc] Write Protect is off
[    2.251760] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    2.251798] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.251972] sd 3:0:0:0: Attached scsi generic sg3 type 0
[    2.301258] Switched to clocksource tsc
[    2.429582] input: Logitech Optical USB Mouse as /devices/pci0000:00/0000:00:1d.2/usb8/8-1/8-1:1.0/input/input3
[    2.430523] hid-generic 0003:046D:C016.0002: input,hidraw1: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:1d.2-1/input0
[    2.556594] ata5: SATA link down (SStatus 0 SControl 300)
[    2.580990]  sdc: sdc1 < sdc5 >
[    2.581961] sd 3:0:0:0: [sdc] Attached SCSI disk
[    2.636471] usb 8-2: new low-speed USB device number 3 using uhci_hcd
[    2.861238] ata6: SATA link down (SStatus 0 SControl 300)
[    2.881961] EXT4-fs (sdb6): couldn't mount as ext3 due to feature incompatibilities
[    2.882425] EXT4-fs (sdb6): couldn't mount as ext2 due to feature incompatibilities
[    2.902097] EXT4-fs (sdb6): mounted filesystem with ordered data mode. Opts: (null)
[    2.902148] VFS: Mounted root (ext4 filesystem) readonly on device 8:22.
[    2.908843] devtmpfs: mounted
[    2.909198] Freeing unused kernel memory: 780K (ffffffff816aa000 - ffffffff8176d000)
[    2.936908] input:   USB Keyboard as /devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.0/input/input4
[    2.937368] hid-generic 0003:1241:1503.0003: input,hidraw2: USB HID v1.10 Keyboard [  USB Keyboard] on usb-0000:00:1d.2-2/input0
[    3.026231] input:   USB Keyboard as /devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.1/input/input5
[    3.026737] hid-generic 0003:1241:1503.0004: input,hidraw3: USB HID v1.10 Device [  USB Keyboard] on usb-0000:00:1d.2-2/input1
[    3.231836] usb 9-1: new full-speed USB device number 2 using uhci_hcd
[    4.701204] systemd-udevd[1643]: starting version 208
[    5.281869] Floppy drive(s): fd0 is 1.44M
[    5.296486] FDC 0 is a post-1991 82077
[    5.330641] [drm] Initialized drm 1.1.0 20060810
[    5.495120] [drm] radeon kernel modesetting enabled.
[    5.495158] pcieport 0000:00:03.0: driver skip pci_set_master, fix it!
[    5.495340] [drm] initializing kernel modesetting (RV730 0x1002:0x9490 0x174B:0xE880).
[    5.495351] [drm] register mmio base: 0xFBCE0000
[    5.495351] [drm] register mmio size: 65536
[    5.495387] ATOM BIOS: 
[    5.495419] radeon 0000:01:00.0: VRAM: 512M 0x0000000000000000 - 0x000000001FFFFFFF (512M used)
[    5.495420] radeon 0000:01:00.0: GTT: 1024M 0x0000000020000000 - 0x000000005FFFFFFF
[    5.495421] [drm] Detected VRAM RAM=512M, BAR=256M
[    5.495421] [drm] RAM width 128bits DDR
[    5.495527] [TTM] Zone  kernel: Available graphics memory: 4080664 kiB
[    5.495528] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    5.495528] [TTM] Initializing pool allocator
[    5.495531] [TTM] Initializing DMA pool allocator
[    5.495542] [drm] radeon: 512M of VRAM memory ready
[    5.495542] [drm] radeon: 1024M of GTT memory ready.
[    5.652444] r8168 Gigabit Ethernet driver 8.037.00-NAPI loaded
[    5.652457] pcieport 0000:00:1c.0: driver skip pci_set_master, fix it!
[    5.652547] r8168 0000:02:00.0: irq 46 for MSI/MSI-X
[    5.653202] eth%d: 0xffffc90000028000, 6c:f0:49:51:d7:f3, IRQ 46
[    5.653292] r8168: This product is covered by one or more of the following patents: US6,570,884, US6,115,776, and US6,327,625.
[    5.653295] r8168  Copyright (C) 2013  Realtek NIC software team <nicfae@realtek.com> 
 This program comes with ABSOLUTELY NO WARRANTY; for details, please see <http://www.gnu.org/licenses/>. 
 This is free software, and you are welcome to redistribute it under certain conditions; see <http://www.gnu.org/licenses/>. 
[    5.653303] r8168 Gigabit Ethernet driver 8.037.00-NAPI loaded
[    5.653395] pcieport 0000:00:1c.1: driver skip pci_set_master, fix it!
[    5.653474] r8168 0000:03:00.0: irq 47 for MSI/MSI-X
[    5.654125] eth%d: 0xffffc900044f2000, 6c:f0:49:51:d7:e3, IRQ 47
[    5.654198] r8168: This product is covered by one or more of the following patents: US6,570,884, US6,115,776, and US6,327,625.
[    5.654200] r8168  Copyright (C) 2013  Realtek NIC software team <nicfae@realtek.com> 
 This program comes with ABSOLUTELY NO WARRANTY; for details, please see <http://www.gnu.org/licenses/>. 
 This is free software, and you are welcome to redistribute it under certain conditions; see <http://www.gnu.org/licenses/>. 
[    5.862247] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    5.863226] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
[    5.884969] [drm] Loading RV730 Microcode
[    5.935640] [drm] PCIE GART of 1024M enabled (table at 0x000000000025D000).
[    5.935692] radeon 0000:01:00.0: WB enabled
[    5.935694] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000020000c00 and cpu addr 0xffff880213cedc00
[    5.935695] radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000020000c0c and cpu addr 0xffff880213cedc0c
[    5.936389] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x000000000005c598 and cpu addr 0xffffc9000491c598
[    5.936391] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[    5.936391] [drm] Driver supports precise vblank timestamp query.
[    5.936404] radeon 0000:01:00.0: irq 48 for MSI/MSI-X
[    5.936411] radeon 0000:01:00.0: radeon: using MSI.
[    5.936432] [drm] radeon: irq initialized.
[    5.983174] [drm] ring test on 0 succeeded in 1 usecs
[    5.983233] [drm] ring test on 3 succeeded in 1 usecs
[    5.990767] usb-storage 2-1:1.0: USB Mass Storage device detected
[    5.990839] scsi8 : usb-storage 2-1:1.0
[    5.990927] usb-storage 9-1:1.0: USB Mass Storage device detected
[    5.990964] scsi9 : usb-storage 9-1:1.0
[    5.990996] usbcore: registered new interface driver usb-storage
[    6.023315] systemd-udevd[1661]: renamed network interface eth0 to lan0
[    6.035245] systemd-udevd[1670]: renamed network interface eth1 to wan0
[    6.079307] kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work properly. Using workaround
[    6.169128] [drm] ring test on 5 succeeded in 1 usecs
[    6.169131] [drm] UVD initialized successfully.
[    6.169282] [drm] Enabling audio 0 support
[    6.169300] [drm] ib test on ring 0 succeeded in 0 usecs
[    6.169318] [drm] ib test on ring 3 succeeded in 0 usecs
[    6.319946] [drm] ib test on ring 5 succeeded
[    6.320314] [drm] Radeon Display Connectors
[    6.320315] [drm] Connector 0:
[    6.320315] [drm]   DVI-I-1
[    6.320316] [drm]   HPD2
[    6.320317] [drm]   DDC: 0x7f10 0x7f10 0x7f14 0x7f14 0x7f18 0x7f18 0x7f1c 0x7f1c
[    6.320318] [drm]   Encoders:
[    6.320318] [drm]     CRT2: INTERNAL_KLDSCP_DAC2
[    6.320319] [drm]     DFP2: INTERNAL_UNIPHY1
[    6.320319] [drm] Connector 1:
[    6.320320] [drm]   DIN-1
[    6.320320] [drm]   Encoders:
[    6.320321] [drm]     TV1: INTERNAL_KLDSCP_DAC2
[    6.320321] [drm] Connector 2:
[    6.320321] [drm]   DVI-I-2
[    6.320322] [drm]   HPD1
[    6.320323] [drm]   DDC: 0x7e20 0x7e20 0x7e24 0x7e24 0x7e28 0x7e28 0x7e2c 0x7e2c
[    6.320323] [drm]   Encoders:
[    6.320324] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    6.320324] [drm]     DFP1: INTERNAL_UNIPHY
[    6.320341] [drm] Internal thermal controller with fan control
[    6.320359] == power state 0 ==
[    6.320360] 	ui class: none
[    6.320361] 	internal class: boot 
[    6.320362] 	caps: video 
[    6.320363] 	uvd    vclk: 0 dclk: 0
[    6.320364] 		power level 0    sclk: 75000 mclk: 100000 vddc: 1250
[    6.320365] 		power level 1    sclk: 75000 mclk: 100000 vddc: 1250
[    6.320365] 		power level 2    sclk: 75000 mclk: 100000 vddc: 1250
[    6.320366] 	status: c r b 
[    6.320367] == power state 1 ==
[    6.320367] 	ui class: performance
[    6.320368] 	internal class: none
[    6.320369] 	caps: single_disp video 
[    6.320370] 	uvd    vclk: 0 dclk: 0
[    6.320371] 		power level 0    sclk: 30000 mclk: 100000 vddc: 1250
[    6.320371] 		power level 1    sclk: 30000 mclk: 100000 vddc: 1250
[    6.320372] 		power level 2    sclk: 75000 mclk: 100000 vddc: 1250
[    6.320372] 	status: 
[    6.320373] == power state 2 ==
[    6.320373] 	ui class: none
[    6.320374] 	internal class: uvd 
[    6.320374] 	caps: video 
[    6.320375] 	uvd    vclk: 53300 dclk: 40000
[    6.320376] 		power level 0    sclk: 75000 mclk: 100000 vddc: 1250
[    6.320377] 		power level 1    sclk: 75000 mclk: 100000 vddc: 1250
[    6.320377] 		power level 2    sclk: 75000 mclk: 100000 vddc: 1250
[    6.320378] 	status: 
[    6.320378] == power state 3 ==
[    6.320378] 	ui class: performance
[    6.320379] 	internal class: none
[    6.320380] 	caps: video 
[    6.320381] 	uvd    vclk: 0 dclk: 0
[    6.320381] 		power level 0    sclk: 30000 mclk: 100000 vddc: 1250
[    6.320382] 		power level 1    sclk: 30000 mclk: 100000 vddc: 1250
[    6.320383] 		power level 2    sclk: 75000 mclk: 100000 vddc: 1250
[    6.320383] 	status: 
[    6.324820] switching from power state:
[    6.324820] 	ui class: none
[    6.324821] 	internal class: boot 
[    6.324822] 	caps: video 
[    6.324823] 	uvd    vclk: 0 dclk: 0
[    6.324823] 		power level 0    sclk: 75000 mclk: 100000 vddc: 1250
[    6.324824] 		power level 1    sclk: 75000 mclk: 100000 vddc: 1250
[    6.324824] 		power level 2    sclk: 75000 mclk: 100000 vddc: 1250
[    6.324825] 	status: c b 
[    6.324826] switching to power state:
[    6.324826] 	ui class: performance
[    6.324827] 	internal class: none
[    6.324827] 	caps: single_disp video 
[    6.324829] 	uvd    vclk: 0 dclk: 0
[    6.324829] 		power level 0    sclk: 30000 mclk: 100000 vddc: 1250
[    6.324830] 		power level 1    sclk: 30000 mclk: 100000 vddc: 1250
[    6.324830] 		power level 2    sclk: 75000 mclk: 100000 vddc: 1250
[    6.324831] 	status: r 
[    6.325174] [drm] radeon: dpm initialized
[    6.425137] [drm] fb mappable at 0xE045E000
[    6.425138] [drm] vram apper at 0xE0000000
[    6.425138] [drm] size 8294400
[    6.425139] [drm] fb depth is 24
[    6.425139] [drm]    pitch is 7680
[    6.425172] fbcon: radeondrmfb (fb0) is primary device
[    6.430511] switching from power state:
[    6.430511] 	ui class: performance
[    6.430512] 	internal class: none
[    6.430513] 	caps: single_disp video 
[    6.430513] 	uvd    vclk: 0 dclk: 0
[    6.430513] 		power level 0    sclk: 30000 mclk: 100000 vddc: 1250
[    6.430514] 		power level 1    sclk: 30000 mclk: 100000 vddc: 1250
[    6.430514] 		power level 2    sclk: 75000 mclk: 100000 vddc: 1250
[    6.430515] 	status: c 
[    6.430515] switching to power state:
[    6.430515] 	ui class: performance
[    6.430516] 	internal class: none
[    6.430516] 	caps: video 
[    6.430516] 	uvd    vclk: 0 dclk: 0
[    6.430517] 		power level 0    sclk: 30000 mclk: 100000 vddc: 1250
[    6.430517] 		power level 1    sclk: 30000 mclk: 100000 vddc: 1250
[    6.430518] 		power level 2    sclk: 75000 mclk: 100000 vddc: 1250
[    6.430518] 	status: r 
[    6.438291] Console: switching to colour frame buffer device 160x64
[    6.440909] radeon 0000:01:00.0: fb0: radeondrmfb frame buffer device
[    6.440910] radeon 0000:01:00.0: registered panic notifier
[    6.440912] [drm] Initialized radeon 2.34.0 20080528 for 0000:01:00.0 on minor 0
[    6.441119] ALSA sound/pci/hda/hda_intel.c:3378 0000:01:00.1: Using LPIB position fix
[    6.441144] snd_hda_intel 0000:01:00.1: irq 49 for MSI/MSI-X
[    6.443583] ALSA sound/pci/hda/hda_intel.c:1799 0000:01:00.1: Enable sync_write for stable communication
[    6.512361] ALSA sound/pci/hda/hda_eld.c:684 HDMI ATI/AMD: no speaker allocation for ELD
[    6.512486] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/0000:01:00.1/sound/card0/input6
[    6.992188] scsi 8:0:0:0: Direct-Access     Lexar    USB Flash Drive  8.07 PQ: 0 ANSI: 4
[    6.992497] sd 8:0:0:0: Attached scsi generic sg4 type 0
[    6.993964] sd 8:0:0:0: [sdd] 15659008 512-byte logical blocks: (8.01 GB/7.46 GiB)
[    6.995125] sd 8:0:0:0: [sdd] Write Protect is off
[    6.995131] sd 8:0:0:0: [sdd] Mode Sense: 23 00 00 00
[    6.996525] sd 8:0:0:0: [sdd] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    7.001863]  sdd: sdd1
[    7.006214] sd 8:0:0:0: [sdd] Attached SCSI removable disk
[    7.314644] scsi 9:0:0:0: Direct-Access     Motorola K1               2.31 PQ: 0 ANSI: 2
[    7.314868] sd 9:0:0:0: Attached scsi generic sg5 type 0
[    7.634309] sd 9:0:0:0: [sde] Attached SCSI removable disk
[    7.941631] loop: module loaded
[    7.981604] PPP generic driver version 2.4.2
[    8.471421] bio: create slab <bio-1> at 1
[   10.058169] usb 4-1: USB disconnect, device number 2
[   11.403947] usb 4-1: new low-speed USB device number 3 using uhci_hcd
[   11.715913] hid-generic 0003:0764:0501.0005: hiddev0,hidraw0: USB HID v1.10 Device [CPS DX600E] on usb-0000:00:1a.1-1/input0
[   13.787987] bio: create slab <bio-2> at 2
[   16.309926] EXT4-fs (sdb6): re-mounted. Opts: barrier=0,commit=30,acl
[   16.709805] Adding 5242876k swap on /dev/mapper/symphony-swap.  Priority:-1 extents:1 across:5242876k 
[   16.781483] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: barrier=1,commit=15
[   16.813388] EXT4-fs (dm-10): mounted filesystem with ordered data mode. Opts: barrier=1,commit=30
[   16.856788] EXT4-fs (dm-3): mounted filesystem with ordered data mode. Opts: barrier=1,commit=30
[   16.884705] REISERFS (device dm-14): found reiserfs format "3.6" with standard journal
[   16.884713] REISERFS (device dm-14): using ordered data mode
[   16.889449] REISERFS (device dm-14): journal params: device dm-14, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   16.889674] REISERFS (device dm-14): checking transaction log (dm-14)
[   16.926468] REISERFS (device dm-14): Using r5 hash to sort names
[   16.998670] EXT4-fs (dm-2): barriers disabled
[   17.007714] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: barrier=0,commit=30
[   17.030005] EXT4-fs (dm-11): barriers disabled
[   17.039373] EXT4-fs (dm-11): mounted filesystem with ordered data mode. Opts: barrier=0,commit=30
[   17.083511] EXT4-fs (dm-5): barriers disabled
[   17.093808] EXT4-fs (dm-5): mounted filesystem with writeback data mode. Opts: barrier=0,commit=30,data=writeback
[   17.118251] EXT4-fs (dm-15): barriers disabled
[   17.126644] EXT4-fs (dm-15): mounted filesystem with ordered data mode. Opts: barrier=0,commit=30,acl
[   17.292691] ISO 9660 Extensions: Microsoft Joliet Level 3
[   17.305162] ISO 9660 Extensions: RRIP_1991A
[   17.386748] ISO 9660 Extensions: Microsoft Joliet Level 3
[   17.395161] ISO 9660 Extensions: RRIP_1991A
[   18.764870] microcode: CPU0 sig=0x106e5, pf=0x2, revision=0x4
[   18.765467] microcode: CPU0 updated to revision 0x6, date = 2013-07-01
[   18.765623] microcode: CPU1 sig=0x106e5, pf=0x2, revision=0x4
[   18.765816] microcode: CPU1 updated to revision 0x6, date = 2013-07-01
[   18.766056] microcode: CPU2 sig=0x106e5, pf=0x2, revision=0x4
[   18.766284] microcode: CPU2 updated to revision 0x6, date = 2013-07-01
[   18.766531] microcode: CPU3 sig=0x106e5, pf=0x2, revision=0x4
[   18.766757] microcode: CPU3 updated to revision 0x6, date = 2013-07-01
[   18.767001] microcode: CPU4 sig=0x106e5, pf=0x2, revision=0x4
[   18.767504] microcode: CPU4 updated to revision 0x6, date = 2013-07-01
[   18.767656] microcode: CPU5 sig=0x106e5, pf=0x2, revision=0x4
[   18.767839] microcode: CPU5 updated to revision 0x6, date = 2013-07-01
[   18.768046] microcode: CPU6 sig=0x106e5, pf=0x2, revision=0x4
[   18.768541] microcode: CPU6 updated to revision 0x6, date = 2013-07-01
[   18.768802] microcode: CPU7 sig=0x106e5, pf=0x2, revision=0x4
[   18.769026] microcode: CPU7 updated to revision 0x6, date = 2013-07-01
[   19.206607] IPv6: ADDRCONF(NETDEV_UP): wan0: link is not ready
[   21.365817] Bluetooth: Core ver 2.16
[   21.365822] NET: Registered protocol family 31
[   21.365899] Bluetooth: HCI device and connection manager initialized
[   21.365907] Bluetooth: HCI socket layer initialized
[   21.365910] Bluetooth: L2CAP socket layer initialized
[   21.365913] Bluetooth: SCO socket layer initialized
[   21.402371] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   21.402372] Bluetooth: BNEP filters: protocol multicast
[   21.402375] Bluetooth: BNEP socket layer initialized
[   22.121398] FS-Cache: Loaded
[   22.138881] CacheFiles: Loaded
[   22.402325] FS-Cache: Cache "mycache" added (type cachefiles)
[   22.402328] CacheFiles: File cache on sdb6 registered
[   23.280878] r8168: wan0: link up
[   23.280899] IPv6: ADDRCONF(NETDEV_CHANGE): wan0: link becomes ready
[   32.285734] usb 4-1: USB disconnect, device number 3
[   32.821791] ALSA sound/pci/hda/hda_eld.c:684 HDMI ATI/AMD: no speaker allocation for ELD
[   33.121906] ALSA sound/pci/hda/hda_eld.c:684 HDMI ATI/AMD: no speaker allocation for ELD
[   33.407632] usb 4-1: new low-speed USB device number 4 using uhci_hcd
[   33.422643] ALSA sound/pci/hda/hda_eld.c:684 HDMI ATI/AMD: no speaker allocation for ELD
[   33.606813] ALSA sound/pci/hda/hda_eld.c:684 HDMI ATI/AMD: no speaker allocation for ELD
[   33.649626] switching from power state:
[   33.649628] 	ui class: performance
[   33.649629] 	internal class: none
[   33.649631] 	caps: video 
[   33.649633] 	uvd    vclk: 0 dclk: 0
[   33.649634] 		power level 0    sclk: 30000 mclk: 100000 vddc: 1250
[   33.649635] 		power level 1    sclk: 30000 mclk: 100000 vddc: 1250
[   33.649636] 		power level 2    sclk: 75000 mclk: 100000 vddc: 1250
[   33.649637] 	status: c 
[   33.649638] switching to power state:
[   33.649638] 	ui class: performance
[   33.649639] 	internal class: none
[   33.649641] 	caps: single_disp video 
[   33.649643] 	uvd    vclk: 0 dclk: 0
[   33.649644] 		power level 0    sclk: 30000 mclk: 100000 vddc: 1250
[   33.649645] 		power level 1    sclk: 30000 mclk: 100000 vddc: 1250
[   33.649646] 		power level 2    sclk: 75000 mclk: 100000 vddc: 1250
[   33.649646] 	status: r 
[   33.658123] switching from power state:
[   33.658124] 	ui class: performance
[   33.658125] 	internal class: none
[   33.658126] 	caps: single_disp video 
[   33.658127] 	uvd    vclk: 0 dclk: 0
[   33.658128] 		power level 0    sclk: 30000 mclk: 100000 vddc: 1250
[   33.658128] 		power level 1    sclk: 30000 mclk: 100000 vddc: 1250
[   33.658129] 		power level 2    sclk: 75000 mclk: 100000 vddc: 1250
[   33.658129] 	status: c 
[   33.658130] switching to power state:
[   33.658130] 	ui class: performance
[   33.658130] 	internal class: none
[   33.658131] 	caps: video 
[   33.658132] 	uvd    vclk: 0 dclk: 0
[   33.658133] 		power level 0    sclk: 30000 mclk: 100000 vddc: 1250
[   33.658133] 		power level 1    sclk: 30000 mclk: 100000 vddc: 1250
[   33.658134] 		power level 2    sclk: 75000 mclk: 100000 vddc: 1250
[   33.658134] 	status: r 
[   33.664290] ALSA sound/pci/hda/hda_eld.c:684 HDMI ATI/AMD: no speaker allocation for ELD
[   33.720682] hid-generic 0003:0764:0501.0006: hiddev0,hidraw0: USB HID v1.10 Device [CPS DX600E] on usb-0000:00:1a.1-1/input0
[   33.723224] ALSA sound/pci/hda/hda_eld.c:684 HDMI ATI/AMD: no speaker allocation for ELD
[   34.023971] ALSA sound/pci/hda/hda_eld.c:684 HDMI ATI/AMD: no speaker allocation for ELD
[   34.297094] RPC: Registered named UNIX socket transport module.
[   34.297095] RPC: Registered udp transport module.
[   34.297096] RPC: Registered tcp transport module.
[   34.297097] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   34.324619] ALSA sound/pci/hda/hda_eld.c:684 HDMI ATI/AMD: no speaker allocation for ELD
[   34.625483] ALSA sound/pci/hda/hda_eld.c:684 HDMI ATI/AMD: no speaker allocation for ELD
[   34.866736] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   34.926125] ALSA sound/pci/hda/hda_eld.c:684 HDMI ATI/AMD: no speaker allocation for ELD
[   35.226909] ALSA sound/pci/hda/hda_eld.c:684 HDMI ATI/AMD: no speaker allocation for ELD
[   35.583740] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[   35.599336] NFSD: starting 90-second grace period (net ffffffff81690e00)
[   36.037803] ip_tables: (C) 2000-2006 Netfilter Core Team
[   38.720168] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[   39.650672] EXT4-fs (sdb6): Unrecognized mount option "commit=-1" or missing value
[   40.165493] EXT4-fs (dm-1): Unrecognized mount option "commit=-1" or missing value
[   40.175371] EXT4-fs (dm-10): Unrecognized mount option "commit=-1" or missing value
[   40.177546] EXT4-fs (dm-3): Unrecognized mount option "commit=-1" or missing value
[   40.191102] EXT4-fs (dm-2): Unrecognized mount option "commit=-1" or missing value
[   40.193204] EXT4-fs (dm-11): Unrecognized mount option "commit=-1" or missing value
[   40.195672] EXT4-fs (dm-5): Unrecognized mount option "commit=-1" or missing value
[   40.198505] EXT4-fs (dm-15): Unrecognized mount option "commit=-1" or missing value
[   40.216199] ipt_ULOG: ULOG is deprecated and it will be removed soon, use NFLOG instead
[   41.988738] switching from power state:
[   41.988739] 	ui class: performance
[   41.988740] 	internal class: none
[   41.988740] 	caps: video 
[   41.988741] 	uvd    vclk: 0 dclk: 0
[   41.988741] 		power level 0    sclk: 30000 mclk: 100000 vddc: 1250
[   41.988742] 		power level 1    sclk: 30000 mclk: 100000 vddc: 1250
[   41.988742] 		power level 2    sclk: 75000 mclk: 100000 vddc: 1250
[   41.988743] 	status: c 
[   41.988743] switching to power state:
[   41.988743] 	ui class: performance
[   41.988744] 	internal class: none
[   41.988744] 	caps: single_disp video 
[   41.988745] 	uvd    vclk: 0 dclk: 0
[   41.988745] 		power level 0    sclk: 30000 mclk: 100000 vddc: 1250
[   41.988745] 		power level 1    sclk: 30000 mclk: 100000 vddc: 1250
[   41.988746] 		power level 2    sclk: 75000 mclk: 100000 vddc: 1250
[   41.988746] 	status: r 
[   42.001343] switching from power state:
[   42.001343] 	ui class: performance
[   42.001344] 	internal class: none
[   42.001344] 	caps: single_disp video 
[   42.001345] 	uvd    vclk: 0 dclk: 0
[   42.001345] 		power level 0    sclk: 30000 mclk: 100000 vddc: 1250
[   42.001345] 		power level 1    sclk: 30000 mclk: 100000 vddc: 1250
[   42.001346] 		power level 2    sclk: 75000 mclk: 100000 vddc: 1250
[   42.001346] 	status: c 
[   42.001346] switching to power state:
[   42.001347] 	ui class: performance
[   42.001347] 	internal class: none
[   42.001348] 	caps: video 
[   42.001348] 	uvd    vclk: 0 dclk: 0
[   42.001348] 		power level 0    sclk: 30000 mclk: 100000 vddc: 1250
[   42.001349] 		power level 1    sclk: 30000 mclk: 100000 vddc: 1250
[   42.001349] 		power level 2    sclk: 75000 mclk: 100000 vddc: 1250
[   42.001349] 	status: r 

--MP_/72Yww25VaXiRPLE3wcrxa_+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--MP_/72Yww25VaXiRPLE3wcrxa_+--
