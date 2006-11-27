From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: oops on usb soundcard removal
Date: Mon, 27 Nov 2006 11:31:58 -0500
Message-ID: <20061127163158.GA9875@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from linta.de (isilmar.linta.de [213.239.214.66])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8ECBB2F8
	for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2006 17:32:10 +0100 (MET)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org, linux-usb-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

A quite recent 2.6.19-rc6 got me this oops yesterday -- usually, plug + unplug
work just fine...

[30488.521000] usb 2-2.4: USB disconnect, address 4
[30488.616000] BUG: unable to handle kernel paging request at virtual address 00100100
[30488.616000]  printing eip:
[30488.616000] c02e0464
[30488.616000] *pde = 00000000
[30488.616000] Oops: 0000 [#1]
[30488.616000] PREEMPT 
[30488.616000] Modules linked in: usb_storage cbc uhci_hcd ehci_hcd ipw2100 cpufreq_ondemand pcmcia yenta_socket rsrc_nonstatic pcmcia_core speedstep_centrino freq_table processor
[30488.616000] CPU:    0
[30488.616000] EIP:    0060:[<c02e0464>]    Not tainted VLI
[30488.616000] EFLAGS: 00010246   (2.6.19-rc6 #3)
[30488.616000] EIP is at snd_ctl_dev_disconnect+0x81/0xb4
[30488.616000] eax: e24b3eac   ebx: 00100100   ecx: 00020004   edx: 0000001d
[30488.616000] esi: dfa62ad4   edi: dfa62c20   ebp: ef6b2e18   esp: ef6b2e04
[30488.616000] ds: 007b   es: 007b   ss: 0068
[30488.616000] Process khubd (pid: 168, ti=ef6b2000 task=ef603510 task.ti=ef6b2000)
[30488.616000] Stack: 00000000 ef6b2e18 c46b5ae4 dfa62ad4 00000000 ef6b2e34 c02e2285 00000000 
[30488.616000]        c02debed c0466afc c46b5ae4 dfa62ad4 ef6b2e50 c02e262e 00000000 dfa62cb0 
[30488.616000]        00000000 00000000 dfa62ad4 ef6b2e6c c02dec7f d473a510 c046bf80 dfa626c8 
[30488.616000] Call Trace:
[30488.616000]  [<c02e2285>] snd_device_disconnect+0x5d/0xaa
[30488.616000]  [<c02e262e>] snd_device_disconnect_all+0x43/0x69
[30488.616000]  [<c02dec7f>] snd_card_disconnect+0x115/0x13b
[30488.616000]  [<c0322b69>] usb_audio_disconnect+0x46/0xfa
[30488.616000]  [<c02bcc6b>] usb_unbind_interface+0x4c/0x94
[30488.616000]  [<c0272128>] __device_release_driver+0x63/0x79
[30488.616000]  [<c02724cf>] device_release_driver+0x2f/0x45
[30488.616000]  [<c0271baa>] bus_remove_device+0x73/0x82
[30488.616000]  [<c02706de>] device_del+0x15e/0x192
[30488.616000]  [<c02ba914>] usb_disable_device+0x5f/0xbc
[30488.616000]  [<c02b75f1>] usb_disconnect+0x94/0xf0
[30488.616000]  [<c02b823d>] hub_thread+0x3aa/0xa71
[30488.616000]  [<c01280c4>] kthread+0xb0/0xdc
[30488.616000]  [<c0103207>] kernel_thread_helper+0x7/0x10
[30488.616000] DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
[30488.616000] 
[30488.616000] Leftover inexact backtrace:
[30488.616000] 
[30488.616000]  [<c0103674>] show_trace_log_lvl+0x1a/0x2f
[30488.616000]  [<c0103726>] show_stack_log_lvl+0x9d/0xa5
[30488.616000]  [<c01038ef>] show_registers+0x1c1/0x25e
[30488.616000]  [<c0103b3b>] die+0x1af/0x2c1
[30488.616000]  [<c0110485>] do_page_fault+0x450/0x52b
[30488.616000]  [<c03b13a9>] error_code+0x39/0x40
[30488.616000]  [<c02e2285>] snd_device_disconnect+0x5d/0xaa
[30488.616000]  [<c02e262e>] snd_device_disconnect_all+0x43/0x69
[30488.616000]  [<c02dec7f>] snd_card_disconnect+0x115/0x13b
[30488.616000]  [<c0322b69>] usb_audio_disconnect+0x46/0xfa
[30488.616000]  [<c02bcc6b>] usb_unbind_interface+0x4c/0x94
[30488.616000]  [<c0272128>] __device_release_driver+0x63/0x79
[30488.616000]  [<c02724cf>] device_release_driver+0x2f/0x45
[30488.616000]  [<c0271baa>] bus_remove_device+0x73/0x82
[30488.616000]  [<c02706de>] device_del+0x15e/0x192
[30488.616000]  [<c02ba914>] usb_disable_device+0x5f/0xbc
[30488.616000]  [<c02b75f1>] usb_disconnect+0x94/0xf0
[30488.616000]  [<c02b823d>] hub_thread+0x3aa/0xa71
[30488.616000]  [<c01280c4>] kthread+0xb0/0xdc
[30488.616000]  [<c0103207>] kernel_thread_helper+0x7/0x10
[30488.616000]  =======================
[30488.616000] Code: 18 b9 01 00 00 00 ba 03 00 00 00 c7 04 24 00 00 00 00 e8 9d 37 e3 ff 8d 43 70 b9 04 00 02 00 ba 1d 00 00 00 e8 b2 68 e8 ff 8b 1b <8b> 03 0f 18 00 90 8d 86 c0 01 00 00 39 c3 75 c3 89 f8 e8 3d a8 
[30488.616000] EIP: [<c02e0464>] snd_ctl_dev_disconnect+0x81/0xb4 SS:ESP 0068:ef6b2e04
[30488.616000]  


Full dmesg:

[    0.000000] Linux version 2.6.19-rc6 (brodo@sternenlicht) (gcc-Version 4.1.1 (Gentoo 4.1.1)) #3 PREEMPT Thu Nov 16 15:47:49 EST 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000002f6e0000 (usable)
[    0.000000]  BIOS-e820: 000000002f6e0000 - 000000002f6ec000 (ACPI data)
[    0.000000]  BIOS-e820: 000000002f6ec000 - 000000002f700000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000002f700000 - 0000000030000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec10000 - 00000000fec20000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
[    0.000000]  BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
[    0.000000] 758MB LOWMEM available.
[    0.000000] Entering add_active_range(0, 0, 194272) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   194272
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   194272
[    0.000000] On node 0 totalpages: 194272
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1485 pages used for memmap
[    0.000000]   Normal zone: 188691 pages, LIFO batch:31
[    0.000000] DMI present.
[    0.000000] ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7e80
[    0.000000] ACPI: RSDT (v001 PTLTD  Montara  0x06040000  LTP 0x00000000) @ 0x2f6e7bc3
[    0.000000] ACPI: FADT (v001 INTEL  MONTARA  0x06040000 PTL  0x00000050) @ 0x2f6ebed2
[    0.000000] ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x2f6ebfd8
[    0.000000] ACPI: SSDT (v001 INTEL  CPU0CST  0x00000001 INTL 0x20020725) @ 0x2f6e800c
[    0.000000] ACPI: SSDT (v001  INTEL  EISTRef 0x00002000 INTL 0x02012044) @ 0x2f6e7bf7
[    0.000000] ACPI: DSDT (v001 INTEL  MONTARAG 0x06040000 MSFT 0x0100000e) @ 0x00000000
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] Allocating PCI resources starting at 40000000 (gap: 30000000:cec10000)
[    0.000000] Detected 1395.516 MHz processor.
[   11.646983] Built 1 zonelists.  Total pages: 192755
[   11.646988] Kernel command line: root=/dev/hda5 acpi_sleep=s3_mode psmouse.proto=imps resume=/dev/hda8
[   11.647263] Enabling fast FPU save and restore... done.
[   11.647267] Enabling unmasked SIMD FPU exception support... done.
[   11.647271] Initializing CPU#0
[   11.647443] CPU 0 irqstacks, hard=c0598000 soft=c0597000
[   11.647447] PID hash table entries: 4096 (order: 12, 16384 bytes)
[   11.649290] Console: colour VGA+ 80x25
[   11.650835] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[   11.650908] ... MAX_LOCKDEP_SUBCLASSES:    8
[   11.650960] ... MAX_LOCK_DEPTH:          30
[   11.651012] ... MAX_LOCKDEP_KEYS:        2048
[   11.651065] ... CLASSHASH_SIZE:           1024
[   11.651117] ... MAX_LOCKDEP_ENTRIES:     8192
[   11.651169] ... MAX_LOCKDEP_CHAINS:      8192
[   11.651221] ... CHAINHASH_SIZE:          4096
[   11.651273]  memory used by lock dependency info: 904 kB
[   11.651327]  per task-struct memory footprint: 1200 bytes
[   11.731359] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   11.731974] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   11.765024] Memory: 762768k/777088k available (2760k kernel code, 13932k reserved, 1320k data, 168k init, 0k highmem)
[   11.765116] virtual kernel memory layout:
[   11.765117]     fixmap  : 0xffff8000 - 0xfffff000   (  28 kB)
[   11.765119]     vmalloc : 0xf0000000 - 0xffff6000   ( 255 MB)
[   11.765121]     lowmem  : 0xc0000000 - 0xef6e0000   ( 758 MB)
[   11.765123]       .init : 0xc0568000 - 0xc0592000   ( 168 kB)
[   11.765125]       .data : 0xc03b20cc - 0xc04fc434   (1320 kB)
[   11.765127]       .text : 0xc0100000 - 0xc03b20cc   (2760 kB)
[   11.765504] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   11.826226] Calibrating delay using timer specific routine.. 2792.73 BogoMIPS (lpj=1396369)
[   11.826646] Mount-cache hash table entries: 512
[   11.830077] CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
[   11.830092] CPU: L1 I cache: 32K, L1 D cache: 32K
[   11.830174] CPU: L2 cache: 1024K
[   11.830234] CPU: After all inits, caps: a7e9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
[   11.830244] Intel machine check architecture supported.
[   11.830300] Intel machine check reporting enabled on CPU#0.
[   11.830367] CPU: Intel(R) Pentium(R) M processor 1400MHz stepping 05
[   11.830483] Checking 'hlt' instruction... OK.
[   11.834319] ACPI: Core revision 20060707
[   11.836792] ACPI (tbget-0289): Table [DSDT] replaced by host OS [20060707]
[   11.836914]  tbxface-0107 [01] load_tables           : ACPI Tables successfully acquired
[   11.845180] Parsing all Control Methods:
[   11.845373] Table [DSDT](id 0007) - 520 Objects with 56 Devices 154 Methods 20 Regions
[   11.845547] Parsing all Control Methods:
[   11.845686] Table [SSDT](id 0004) - 1 Objects with 0 Devices 1 Methods 0 Regions
[   11.845982] Parsing all Control Methods:
[   11.846122] Table [SSDT](id 0005) - 7 Objects with 0 Devices 4 Methods 0 Regions
[   11.846248] ACPI Namespace successfully loaded at root c07a74f0
[   11.846307] ACPI: setting ELCR to 0200 (from 0c20)
[   11.902826] evxfevnt-0089 [02] enable                : Transition to ACPI mode successful
[   11.907833] NET: Registered protocol family 16
[   11.909102] ACPI: bus type pci registered
[   11.912567] PCI: PCI BIOS revision 2.10 entry at 0xfd9b2, last bus=2
[   11.912624] PCI: Using configuration type 1
[   11.912677] Setting up standard PCI resources
[   11.935439] evgpeblk-0951 [04] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
[   11.936071] evgpeblk-1048 [03] ev_initialize_gpe_bloc: Found 3 Wake, Enabled 0 Runtime GPEs in this block
[   11.938641] Completing Region/Field/Buffer/Package initialization:.....................................................
[   11.943674] Initialized 20/20 Regions 0/0 Fields 21/21 Buffers 12/15 Packages (537 nodes)
[   11.944724] Initializing Device/Processor/Thermal objects by executing _INI methods:....
[   11.947418] Executed 4 _INI methods requiring 0 _STA executions (examined 60 objects)
[   11.947629] ACPI: Interpreter enabled
[   11.947680] ACPI: Using PIC for interrupt routing
[   11.954182] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   11.954335] PCI: Probing PCI hardware (bus 00)
[   11.961938] Boot video device is 0000:00:02.0
[   11.962642] PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
[   11.962703] PCI quirk: region 1180-11bf claimed by ICH4 GPIO
[   11.962841] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[   11.963777] PCI: Firmware left 0000:02:08.0 e100 interrupts enabled, disabling
[   11.963953] PCI: Transparent bridge - 0000:00:1e.0
[   11.964279] PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
[   11.964356] Please report the result to linux-kernel to fix this permanently
[   11.964636] PCI: Bus #07 (-#0a) is hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
[   11.964714] Please report the result to linux-kernel to fix this permanently
[   11.964802] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   11.994085] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[   11.998490] ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
[   11.999648] ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
[   12.000732] ACPI: PCI Interrupt Link [LNKC] (IRQs *11)
[   12.001853] ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
[   12.002926] ACPI: PCI Interrupt Link [LNKE] (IRQs *5)
[   12.004016] ACPI: PCI Interrupt Link [LNKF] (IRQs 5) *0, disabled.
[   12.005172] ACPI: PCI Interrupt Link [LNKG] (IRQs 10) *0, disabled.
[   12.006302] ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
[   12.016508] ACPI: Power Resource [PFAN] (on)
[   12.018841] SCSI subsystem initialized
[   12.019092] libata version 2.00 loaded.
[   12.019473] usbcore: registered new interface driver usbfs
[   12.019751] usbcore: registered new interface driver hub
[   12.020115] usbcore: registered new device driver usb
[   12.020767] PCI: Using ACPI for IRQ routing
[   12.020822] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   12.026658] Bluetooth: Core ver 2.11
[   12.027045] NET: Registered protocol family 31
[   12.027098] Bluetooth: HCI device and connection manager initialized
[   12.027247] Bluetooth: HCI socket layer initialized
[   12.029593] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[   12.029690] PCI: Bus 3, cardbus bridge: 0000:02:03.0
[   12.029744]   IO window: 00003400-000034ff
[   12.029800]   IO window: 00003800-000038ff
[   12.029856]   PREFETCH window: 40000000-41ffffff
[   12.029913]   MEM window: 46000000-47ffffff
[   12.029990] PCI: Bus 7, cardbus bridge: 0000:02:03.1
[   12.030044]   IO window: 00003c00-00003cff
[   12.030100]   IO window: 00001400-000014ff
[   12.030155]   PREFETCH window: 42000000-43ffffff
[   12.030212]   MEM window: 48000000-49ffffff
[   12.030267] PCI: Bridge: 0000:00:1e.0
[   12.030320]   IO window: 3000-3fff
[   12.030377]   MEM window: e0200000-e02fffff
[   12.030433]   PREFETCH window: 40000000-43ffffff
[   12.030505] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   12.031218] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
[   12.031277] PCI: setting IRQ 10 as level-triggered
[   12.031281] ACPI: PCI Interrupt 0000:02:03.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
[   12.031420] PCI: Setting latency timer of device 0000:02:03.0 to 64
[   12.031439] PCI: Enabling device 0000:02:03.1 (0000 -> 0003)
[   12.032105] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
[   12.032161] ACPI: PCI Interrupt 0000:02:03.1[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
[   12.032300] PCI: Setting latency timer of device 0000:02:03.1 to 64
[   12.032363] NET: Registered protocol family 2
[   12.042376] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[   12.043363] TCP established hash table entries: 65536 (order: 9, 2621440 bytes)
[   12.054246] TCP bind hash table entries: 32768 (order: 8, 1441792 bytes)
[   12.060749] TCP: Hash tables configured (established 65536 bind 32768)
[   12.060946] TCP reno registered
[   12.061906] Simple Boot Flag at 0x36 set to 0x1
[   12.062198] Machine check exception polling timer started.
[   12.063286] IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
[   12.064686] audit: initializing netlink socket (disabled)
[   12.064853] audit(1164541355.656:1): initialized
[   12.067130] fuse init (API version 7.7)
[   12.068210] io scheduler noop registered
[   12.068292] io scheduler anticipatory registered (default)
[   12.068404] io scheduler deadline registered
[   12.068513] io scheduler cfq registered
[   12.069906] ACPI: AC Adapter [ADP1] (on-line)
[   12.075219] ACPI: Battery Slot [BAT1] (battery present)
[   12.075322] ACPI: Power Button (FF) [PWRF]
[   12.075391] ACPI: Lid Switch [LID0]
[   12.075458] ACPI: Sleep Button (CM) [SLPB]
[   12.075537] ACPI: Power Button (CM) [PWRB]
[   12.075936] ACPI: Fan [FAN0] (on)
[   12.090298] Real Time Clock Driver v1.12ac
[   12.090354] Linux agpgart interface v0.101 (c) Dave Jones
[   12.090625] agpgart: Detected an Intel 855 Chipset.
[   12.091765] agpgart: Detected 8060K stolen memory.
[   12.100995] agpgart: AGP aperture is 128M @ 0xe8000000
[   12.101329] [drm] Initialized drm 1.0.1 20051102
[   12.101424] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
[   12.102010] [drm] Initialized i915 1.5.0 20060119 on minor 0
[   12.102385] [drm] Initialized i915 1.5.0 20060119 on minor 1
[   12.102447] intelfb: intelfb_init
[   12.102450] intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM chipsets
[   12.102528] intelfb: Version 0.9.4
[   12.102578] intelfb: intelfb_setup
[   12.102580] intelfb: no options
[   12.102773] intelfb: intelfb_pci_register
[   12.103282] intelfb: fb aperture: 0xe8000000/0x8000000, MMIO region: 0xe0000000/0x80000
[   12.103299] intelfb: 00:02.0: Intel(R) 855GM, aperture size 128MB, stolen memory 8060kB
[   12.104459] intelfb: fb: 0xe8000000(+ 0x0)/0x7df000 (0xf0180000)
[   12.104465] intelfb: MMIO: 0xe0000000/0x80000 (0xf3980000)
[   12.104470] intelfb: ring buffer: 0xeb001000/0x10000 (0xf3181000)
[   12.104473] intelfb: HW cursor: 0x0/0x0 (0x00000000) (offset 0x0) (phys 0x0)
[   12.104478] intelfb: options: vram = 4, accel = 1, hwcursor = 0, fixed = 0, noinit = 0
[   12.104482] intelfb: options: mode = ""
[   12.104486] intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode switching.
[   12.104623] intelfb: Video mode must be programmed at boot time.
[   12.104678] intelfb: cleanup
[   12.108149] loop: loaded (max 8 devices)
[   12.108207] e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
[   12.108264] e100: Copyright(c) 1999-2006 Intel Corporation
[   12.109301] ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 5
[   12.109358] PCI: setting IRQ 5 as level-triggered
[   12.109363] ACPI: PCI Interrupt 0000:02:08.0[A] -> Link [LNKE] -> GSI 5 (level, low) -> IRQ 5
[   12.134574] e100: eth0: e100_probe: addr 0xe0201000, irq 5, MAC addr 00:00:XX:XX:XX:XX
[   12.135702] PPP generic driver version 2.4.2
[   12.136088] PPP Deflate Compression module registered
[   12.136144] PPP BSD Compression module registered
[   12.136803] PPP MPPE Compression module registered
[   12.136874] tun: Universal TUN/TAP device driver, 1.6
[   12.136928] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   12.137412] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   12.137471] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   12.137637] ICH4: IDE controller at PCI slot 0000:00:1f.1
[   12.137697] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[   12.138402] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
[   12.138459] PCI: setting IRQ 11 as level-triggered
[   12.138463] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
[   12.138605] ICH4: chipset revision 1
[   12.138656] ICH4: not 100% native mode: will probe irqs later
[   12.138723]     ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
[   12.138896]     ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:DMA, hdd:pio
[   12.139038] Probing IDE interface ide0...
[   12.402644] hda: IC25N040ATMR04-0, ATA DISK drive
[   13.014170] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   13.014542] Probing IDE interface ide1...
[   13.685045] hdc: SAMSUNG CDRW/DVD SN-324F, ATAPI CD/DVD-ROM drive
[   14.299177] ide1 at 0x170-0x177,0x376 on irq 15
[   14.300310] hda: max request size: 512KiB
[   14.321522] hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=16383/255/63, UDMA(100)
[   14.321971] hda: cache flushes supported
[   14.322786]  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
[   14.469275] hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
[   14.469534] Uniform CD-ROM driver Revision: 3.20
[   14.492729] i8042.c: Detected active multiplexing controller, rev 1.1.
[   14.494543] serio: i8042 KBD port at 0x60,0x64 irq 1
[   14.495334] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[   14.495393] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[   14.495450] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[   14.495507] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[   14.496626] mice: PS/2 mouse device common for all mice
[   14.497973] input: PC Speaker as /class/input/input0
[   14.498659] i2c /dev entries driver
[   14.500670] device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
[   14.500843] Bluetooth: HCI USB driver ver 2.9
[   14.501109] usbcore: registered new interface driver hci_usb
[   14.501505] Advanced Linux Sound Architecture Driver Version 1.0.13 (Sun Oct 22 08:56:16 2006 UTC).
[   14.503939] ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
[   14.504135] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[   14.524297] input: AT Translated Set 2 keyboard as /class/input/input1
[   15.146132] input: ImPS/2 Synaptics TouchPad as /class/input/input2
[   15.318877] intel8x0_measure_ac97_clock: measured 50992 usecs
[   15.318935] intel8x0: clocking to 48000
[   15.323983] ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
[   15.324137] PCI: Setting latency timer of device 0000:00:1f.6 to 64
[   15.424790] MC'97 1 converters and GPIO not ready (0xf000)
[   15.427307] usbcore: registered new interface driver snd-usb-audio
[   15.427367] ALSA device list:
[   15.427416]   #0: Intel 82801DB-ICH4 with STAC9752,53 at 0xe0100c00, irq 10
[   15.427474]   #1: Intel 82801DB-ICH4 Modem at 0x2400, irq 10
[   15.427623] Netfilter messages via NETLINK v0.30.
[   15.427995] ip_conntrack version 2.4 (6071 buckets, 48568 max) - 228 bytes per conntrack
[   15.452899] ctnetlink v0.90: registering with nfnetlink.
[   15.453045] ip_conntrack_pptp version 3.1 loaded
[   15.453744] ip_nat_pptp version 3.0 loaded
[   15.453809] ip_tables: (C) 2000-2006 Netfilter Core Team
[   15.486881] TCP cubic registered
[   15.487868] Initializing XFRM netlink socket
[   15.488004] NET: Registered protocol family 1
[   15.488067] NET: Registered protocol family 17
[   15.488244] Bluetooth: L2CAP ver 2.8
[   15.488294] Bluetooth: L2CAP socket layer initialized
[   15.488351] Bluetooth: SCO (Voice Link) ver 0.5
[   15.488403] Bluetooth: SCO socket layer initialized
[   15.488457] Bluetooth: HIDP (Human Interface Emulation) ver 1.1
[   15.488513] ieee80211: 802.11 data/management/control stack, git-1.1.13
[   15.488569] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[   15.488681] ieee80211_crypt: registered algorithm 'NULL'
[   15.488686] ieee80211_crypt: registered algorithm 'WEP'
[   15.488690] ieee80211_crypt: registered algorithm 'CCMP'
[   15.488694] ieee80211_crypt: registered algorithm 'TKIP'
[   15.488699] Using IPI Shortcut mode
[   15.489657] Time: tsc clocksource has been installed.
[   15.516150] ACPI: (supports S0 S3 S4 S5)
[   15.553880] kjournald starting.  Commit interval 5 seconds
[   15.554594] EXT3-fs: mounted filesystem with ordered data mode.
[   15.555032] VFS: Mounted root (ext3 filesystem) readonly.
[   15.555302] Freeing unused kernel memory: 168k freed
[   15.555443] Write protecting the kernel read-only data: 554k
[   24.490195] EXT3 FS on hda5, internal journal
[   25.159826] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   25.159842] ACPI: Processor [CPU0] (supports 8 throttling states)
[   13.485000] Time: acpi_pm clocksource has been installed.
[   13.562000] acpi_processor-0742 [00] processor_preregister_: Error while parsing _PSD domain information. Assuming no coordination
[   13.731000] Yenta: CardBus bridge found at 0000:02:03.0 [144d:c009]
[   13.853000] Yenta: ISA IRQ mask 0x0098, PCI irq 10
[   13.853000] Socket status: 30000006
[   13.853000] Yenta: Raising subordinate bus# of parent bus (#02) from #02 to #06
[   13.853000] pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
[   13.853000] cs: IO port probe 0x3000-0x3fff: clean.
[   13.855000] pcmcia: parent PCI bridge Memory window: 0xe0200000 - 0xe02fffff
[   13.855000] pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x43ffffff
[   13.857000] Yenta: CardBus bridge found at 0000:02:03.1 [144d:c009]
[   13.981000] Yenta: ISA IRQ mask 0x0098, PCI irq 10
[   13.981000] Socket status: 30000006
[   13.981000] Yenta: Raising subordinate bus# of parent bus (#02) from #06 to #0a
[   13.981000] pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
[   13.981000] cs: IO port probe 0x3000-0x3fff: clean.
[   13.983000] pcmcia: parent PCI bridge Memory window: 0xe0200000 - 0xe02fffff
[   13.983000] pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x43ffffff
[   14.330000] cs: IO port probe 0xc00-0xcff: clean.
[   14.331000] cs: IO port probe 0x800-0x8ff: excluding 0x800-0x80f
[   14.336000] cs: IO port probe 0x100-0x4ff: excluding 0x4d0-0x4d7
[   14.340000] cs: IO port probe 0xa00-0xaff: clean.
[   14.342000] cs: IO port probe 0xc00-0xcff: clean.
[   14.343000] cs: IO port probe 0x800-0x8ff: excluding 0x800-0x80f
[   14.348000] cs: IO port probe 0x100-0x4ff: excluding 0x4d0-0x4d7
[   14.352000] cs: IO port probe 0xa00-0xaff: clean.
[   14.499000] ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, git-1.2.2
[   14.499000] ipw2100: Copyright(c) 2003-2006 Intel Corporation
[   14.501000] ACPI: PCI Interrupt 0000:02:07.0[A] -> Link [LNKE] -> GSI 5 (level, low) -> IRQ 5
[   14.508000] ipw2100: Detected Intel PRO/Wireless 2100 Network Connection
[   15.222000] ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
[   15.222000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
[   15.222000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   15.222000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   15.246000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[   15.246000] ehci_hcd 0000:00:1d.7: debug port 1
[   15.246000] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   15.246000] ehci_hcd 0000:00:1d.7: irq 10, io mem 0xe0100000
[   15.250000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   15.253000] usb usb1: configuration #1 chosen from 1 choice
[   15.255000] hub 1-0:1.0: USB hub found
[   15.255000] hub 1-0:1.0: 6 ports detected
[   15.387000] USB Universal Host Controller Interface driver v3.0
[   15.388000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
[   15.388000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   15.388000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   15.390000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[   15.391000] uhci_hcd 0000:00:1d.0: irq 10, io base 0x00001820
[   15.393000] usb usb2: configuration #1 chosen from 1 choice
[   15.394000] hub 2-0:1.0: USB hub found
[   15.394000] hub 2-0:1.0: 2 ports detected
[   15.497000] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[   15.497000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
[   15.497000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   15.497000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   15.499000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[   15.499000] uhci_hcd 0000:00:1d.1: irq 11, io base 0x00001840
[   15.501000] usb usb3: configuration #1 chosen from 1 choice
[   15.502000] hub 3-0:1.0: USB hub found
[   15.502000] hub 3-0:1.0: 2 ports detected
[   15.605000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
[   15.605000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   15.605000] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   15.606000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[   15.606000] uhci_hcd 0000:00:1d.2: irq 11, io base 0x00001860
[   15.608000] usb usb4: configuration #1 chosen from 1 choice
[   15.609000] hub 4-0:1.0: USB hub found
[   15.609000] hub 4-0:1.0: 2 ports detected
[   27.576000] kjournald starting.  Commit interval 5 seconds
[   27.576000] EXT3 FS on hda9, internal journal
[   27.576000] EXT3-fs: mounted filesystem with ordered data mode.
[   27.702000] Adding 1004020k swap on /dev/hda8.  Priority:-1 extents:1 across:1004020k
[  278.806000] kjournald starting.  Commit interval 5 seconds
[  278.808000] EXT3 FS on dm-0, internal journal
[  278.808000] EXT3-fs: mounted filesystem with ordered data mode.
[  697.218000] usb 2-2: new full speed USB device using uhci_hcd and address 2
[  697.376000] usb 2-2: configuration #1 chosen from 1 choice
[  697.380000] hub 2-2:1.0: USB hub found
[  697.383000] hub 2-2:1.0: 4 ports detected
[  718.939000] usb 2-2.4: new full speed USB device using uhci_hcd and address 3
[  719.049000] usb 2-2.4: configuration #1 chosen from 1 choice
[  719.055000] 3:1:1: add audio endpoint 0x1
[  719.057000] 3:2:1: add audio endpoint 0x82
[  719.563000] [13] FU [Mic Playback Switch] ch = 1, val = 0/1/1
[  719.576000] cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0xd00, type = 4, data = 0x18/0x0
[  719.581000] [13] FU [Mic Playback Volume] ch = 1, val = 0/12240/48
[  719.581000] [14] FU [Line Playback Switch] ch = 1, val = 0/1/1
[  719.594000] cannot set ctl value: req = 0x4, wValue = 0x201, wIndex = 0xe00, type = 4, data = 0x18/0x0
[  719.599000] [14] FU [Line Playback Volume] ch = 2, val = 0/12240/48
[  719.599000] [9] FU [Master Playback Switch] ch = 1, val = 0/1/1
[  719.612000] cannot set ctl value: req = 0x4, wValue = 0x201, wIndex = 0x900, type = 4, data = 0x18/0x0
[  719.617000] [9] FU [Master Playback Volume] ch = 2, val = -12256/-16/48
[  719.617000] [10] FU [Mic Capture Switch] ch = 1, val = 0/1/1
[  719.630000] cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0xa00, type = 4, data = 0x18/0x0
[  719.635000] [10] FU [Mic Capture Volume] ch = 1, val = -48/6096/48
[  719.635000] [10] FU [Mic Boost] ch = 1, val = 0/1/1
[  719.635000] [11] FU [Line Capture Switch] ch = 1, val = 0/1/1
[  719.648000] cannot set ctl value: req = 0x4, wValue = 0x201, wIndex = 0xb00, type = 4, data = 0x18/0x0
[  719.653000] [11] FU [Line Capture Volume] ch = 2, val = -48/6096/48
[  719.653000] [12] FU [Digital In Playback Switch] ch = 1, val = 0/1/1
[  719.653000] [8] SU [Capture Input Source] items = 3
[  738.249000] setting usb interface 1:1
[  795.323000] setting usb interface 1:1
[  922.837000] usb 1-1: new high speed USB device using ehci_hcd and address 3
[  922.978000] usb 1-1: configuration #1 chosen from 1 choice
[  924.695000] Initializing USB Mass Storage driver...
[  924.702000] scsi0 : SCSI emulation for USB Mass Storage devices
[  924.704000] usb-storage: device found at 3
[  924.704000] usb-storage: waiting for device to settle before scanning
[  924.704000] usbcore: registered new interface driver usb-storage
[  924.704000] USB Mass Storage support registered.
[  930.651000] scsi 0:0:0:0: Direct-Access     Maxtor   OneTouch III     0341 PQ: 0 ANSI: 4
[  930.843000] SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
[  930.845000] sda: Write Protect is off
[  930.845000] sda: Mode Sense: 17 00 00 00
[  930.845000] sda: assuming drive cache: write through
[  930.851000] SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
[  930.852000] sda: Write Protect is off
[  930.852000] sda: Mode Sense: 17 00 00 00
[  930.852000] sda: assuming drive cache: write through
[  930.852000]  sda: sda1 sda2 sda3
[  930.875000] sd 0:0:0:0: Attached scsi disk sda
[  930.884000] usb-storage: device scan complete
[  939.517000] kjournald starting.  Commit interval 5 seconds
[  939.519000] EXT3 FS on sda2, internal journal
[  939.520000] EXT3-fs: mounted filesystem with ordered data mode.
[  940.179000] kjournald starting.  Commit interval 5 seconds
[  940.180000] EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
[  940.182000] EXT3 FS on dm-1, internal journal
[  940.182000] EXT3-fs: mounted filesystem with ordered data mode.
[  975.110000] setting usb interface 1:1
[ 1037.372000] setting usb interface 1:1
[ 1083.422000] setting usb interface 1:1
[ 1089.917000] setting usb interface 1:1
[ 1100.482000] setting usb interface 2:1
[ 3419.295000] setting usb interface 1:1
[ 4866.841000] setting usb interface 1:1
[ 4868.072000] setting usb interface 1:1
[ 7960.348000] setting usb interface 1:1
[ 7966.532000] setting usb interface 2:1
[ 8271.167000] setting usb interface 1:1
[ 8294.975000] setting usb interface 1:1
[ 8306.828000] setting usb interface 2:1
[ 9033.818000] frame 0 active: -18
[ 9033.819000] frame 0 active: -18
[ 9343.203000] frame 0 active: -18
[ 9343.203000] frame 0 active: -18
[ 9343.205000] frame 0 active: -18
[12133.293000] setting usb interface 1:1
[12324.924000] setting usb interface 1:1
[12427.309000] setting usb interface 1:1
[16927.865000] ipw2100: Fatal interrupt. Scheduling firmware restart.
[17081.024000] setting usb interface 1:1
[17921.050000] spurious 8259A interrupt: IRQ7.
[20197.013000] setting usb interface 1:1
[24901.319000] ipw2100: Fatal interrupt. Scheduling firmware restart.
[24905.013000] ipw2100: Fatal interrupt. Scheduling firmware restart.
[24969.252000] ipw2100: Fatal interrupt. Scheduling firmware restart.
[24972.514000] ipw2100: Fatal interrupt. Scheduling firmware restart.
[25234.490000] ipw2100: Fatal interrupt. Scheduling firmware restart.
[25235.200000] ipw2100: Fatal interrupt. Scheduling firmware restart.
[25290.521000] usb 2-2.4: USB disconnect, address 3
[25291.591000] usb 2-2.4: new full speed USB device using uhci_hcd and address 4
[25291.700000] usb 2-2.4: configuration #1 chosen from 1 choice
[25291.704000] 4:1:1: add audio endpoint 0x1
[25291.706000] 4:2:1: add audio endpoint 0x82
[25292.155000] [13] FU [Mic Playback Switch] ch = 1, val = 0/1/1
[25292.168000] cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0xd00, type = 4, data = 0x18/0x0
[25292.173000] [13] FU [Mic Playback Volume] ch = 1, val = 0/12240/48
[25292.173000] [14] FU [Line Playback Switch] ch = 1, val = 0/1/1
[25292.186000] cannot set ctl value: req = 0x4, wValue = 0x201, wIndex = 0xe00, type = 4, data = 0x18/0x0
[25292.191000] [14] FU [Line Playback Volume] ch = 2, val = 0/12240/48
[25292.191000] [9] FU [Master Playback Switch] ch = 1, val = 0/1/1
[25292.204000] cannot set ctl value: req = 0x4, wValue = 0x201, wIndex = 0x900, type = 4, data = 0x18/0x0
[25292.209000] [9] FU [Master Playback Volume] ch = 2, val = -12256/-16/48
[25292.209000] [10] FU [Mic Capture Switch] ch = 1, val = 0/1/1
[25292.222000] cannot set ctl value: req = 0x4, wValue = 0x200, wIndex = 0xa00, type = 4, data = 0x18/0x0
[25292.227000] [10] FU [Mic Capture Volume] ch = 1, val = -48/6096/48
[25292.227000] [10] FU [Mic Boost] ch = 1, val = 0/1/1
[25292.227000] [11] FU [Line Capture Switch] ch = 1, val = 0/1/1
[25292.240000] cannot set ctl value: req = 0x4, wValue = 0x201, wIndex = 0xb00, type = 4, data = 0x18/0x0
[25292.245000] [11] FU [Line Capture Volume] ch = 2, val = -48/6096/48
[25292.245000] [12] FU [Digital In Playback Switch] ch = 1, val = 0/1/1
[25292.245000] [8] SU [Capture Input Source] items = 3
[25295.503000] setting usb interface 1:1
[25302.736000] setting usb interface 2:1
[26180.730000] ipw2100: Fatal interrupt. Scheduling firmware restart.
[26216.105000] setting usb interface 1:1
[26242.116000] setting usb interface 2:1
[29595.084000] kjournald starting.  Commit interval 5 seconds
[29595.091000] EXT3 FS on dm-1, internal journal
[29595.091000] EXT3-fs: mounted filesystem with ordered data mode.
[30488.521000] usb 2-2.4: USB disconnect, address 4
[30488.616000] BUG: unable to handle kernel paging request at virtual address 00100100
[30488.616000]  printing eip:
[30488.616000] c02e0464
[30488.616000] *pde = 00000000
[30488.616000] Oops: 0000 [#1]
[30488.616000] PREEMPT 
[30488.616000] Modules linked in: usb_storage cbc uhci_hcd ehci_hcd ipw2100 cpufreq_ondemand pcmcia yenta_socket rsrc_nonstatic pcmcia_core speedstep_centrino freq_table processor
[30488.616000] CPU:    0
[30488.616000] EIP:    0060:[<c02e0464>]    Not tainted VLI
[30488.616000] EFLAGS: 00010246   (2.6.19-rc6 #3)
[30488.616000] EIP is at snd_ctl_dev_disconnect+0x81/0xb4
[30488.616000] eax: e24b3eac   ebx: 00100100   ecx: 00020004   edx: 0000001d
[30488.616000] esi: dfa62ad4   edi: dfa62c20   ebp: ef6b2e18   esp: ef6b2e04
[30488.616000] ds: 007b   es: 007b   ss: 0068
[30488.616000] Process khubd (pid: 168, ti=ef6b2000 task=ef603510 task.ti=ef6b2000)
[30488.616000] Stack: 00000000 ef6b2e18 c46b5ae4 dfa62ad4 00000000 ef6b2e34 c02e2285 00000000 
[30488.616000]        c02debed c0466afc c46b5ae4 dfa62ad4 ef6b2e50 c02e262e 00000000 dfa62cb0 
[30488.616000]        00000000 00000000 dfa62ad4 ef6b2e6c c02dec7f d473a510 c046bf80 dfa626c8 
[30488.616000] Call Trace:
[30488.616000]  [<c02e2285>] snd_device_disconnect+0x5d/0xaa
[30488.616000]  [<c02e262e>] snd_device_disconnect_all+0x43/0x69
[30488.616000]  [<c02dec7f>] snd_card_disconnect+0x115/0x13b
[30488.616000]  [<c0322b69>] usb_audio_disconnect+0x46/0xfa
[30488.616000]  [<c02bcc6b>] usb_unbind_interface+0x4c/0x94
[30488.616000]  [<c0272128>] __device_release_driver+0x63/0x79
[30488.616000]  [<c02724cf>] device_release_driver+0x2f/0x45
[30488.616000]  [<c0271baa>] bus_remove_device+0x73/0x82
[30488.616000]  [<c02706de>] device_del+0x15e/0x192
[30488.616000]  [<c02ba914>] usb_disable_device+0x5f/0xbc
[30488.616000]  [<c02b75f1>] usb_disconnect+0x94/0xf0
[30488.616000]  [<c02b823d>] hub_thread+0x3aa/0xa71
[30488.616000]  [<c01280c4>] kthread+0xb0/0xdc
[30488.616000]  [<c0103207>] kernel_thread_helper+0x7/0x10
[30488.616000] DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
[30488.616000] 
[30488.616000] Leftover inexact backtrace:
[30488.616000] 
[30488.616000]  [<c0103674>] show_trace_log_lvl+0x1a/0x2f
[30488.616000]  [<c0103726>] show_stack_log_lvl+0x9d/0xa5
[30488.616000]  [<c01038ef>] show_registers+0x1c1/0x25e
[30488.616000]  [<c0103b3b>] die+0x1af/0x2c1
[30488.616000]  [<c0110485>] do_page_fault+0x450/0x52b
[30488.616000]  [<c03b13a9>] error_code+0x39/0x40
[30488.616000]  [<c02e2285>] snd_device_disconnect+0x5d/0xaa
[30488.616000]  [<c02e262e>] snd_device_disconnect_all+0x43/0x69
[30488.616000]  [<c02dec7f>] snd_card_disconnect+0x115/0x13b
[30488.616000]  [<c0322b69>] usb_audio_disconnect+0x46/0xfa
[30488.616000]  [<c02bcc6b>] usb_unbind_interface+0x4c/0x94
[30488.616000]  [<c0272128>] __device_release_driver+0x63/0x79
[30488.616000]  [<c02724cf>] device_release_driver+0x2f/0x45
[30488.616000]  [<c0271baa>] bus_remove_device+0x73/0x82
[30488.616000]  [<c02706de>] device_del+0x15e/0x192
[30488.616000]  [<c02ba914>] usb_disable_device+0x5f/0xbc
[30488.616000]  [<c02b75f1>] usb_disconnect+0x94/0xf0
[30488.616000]  [<c02b823d>] hub_thread+0x3aa/0xa71
[30488.616000]  [<c01280c4>] kthread+0xb0/0xdc
[30488.616000]  [<c0103207>] kernel_thread_helper+0x7/0x10
[30488.616000]  =======================
[30488.616000] Code: 18 b9 01 00 00 00 ba 03 00 00 00 c7 04 24 00 00 00 00 e8 9d 37 e3 ff 8d 43 70 b9 04 00 02 00 ba 1d 00 00 00 e8 b2 68 e8 ff 8b 1b <8b> 03 0f 18 00 90 8d 86 c0 01 00 00 39 c3 75 c3 89 f8 e8 3d a8 
[30488.616000] EIP: [<c02e0464>] snd_ctl_dev_disconnect+0x81/0xb4 SS:ESP 0068:ef6b2e04
[30488.616000]  

Of course, the soundcard failed to work afterwards.

	Dominik

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
