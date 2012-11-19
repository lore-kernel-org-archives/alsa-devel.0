From: Julian Wollrath <jwollrath@web.de>
Subject: Re: Hung task with trace after resume on kernel
 v3.7-rc6
Date: Mon, 19 Nov 2012 15:18:45 +0100
Message-ID: <20121119151845.1886ed58@ilfaris>
References: <20121118161803.58ca707c@ilfaris>
 <CAEUnVG7bFqrzfVDG5-2uL6OHGEJR-Jf35mx-OLiTx-K84P+dmA@mail.gmail.com>
 <s5h3906gcfe.wl%tiwai@suse.de> <20121119115632.0c41386f@ilfaris>
 <s5hmwydg7mq.wl%tiwai@suse.de> <20121119131504.71f3151b@ilfaris>
 <s5h8v9xaha1.wl%tiwai@suse.de> <20121119145645.30c681e5@ilfaris>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id A584F2616E3
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 15:18:49 +0100 (CET)
In-Reply-To: <20121119145645.30c681e5@ilfaris>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julian Wollrath <jwollrath@web.de>
Cc: Takashi Iwai <tiwai@suse.de>, Dylan Reid <dgreid@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > Hm, then something screwed up the communication...
> > 
> > At which moment do you see such a message?  In other words, how to
> > trigger the bug?
> I suspend my system to ram or to disk. Then I resume it, everthing
> comes up again and then, aprrox 4s after the resume was initiated, the
> spurious response messages hit the dmesg for approx. 0.07s as you can
> see in my first message. Hopefully this answer the question.
Hm, just got some messages, which did not appear before:
[  244.497999] snd_hda_intel 0000:00:14.2: wake-up capability disabled
by ACPI
[  244.498063] snd_hda_intel 0000:00:14.2: enabling device (0000 ->
0002)

lspci -nn output:
00:00.0 Host bridge [0600]: Advanced Micro Devices [AMD] Family 14h Processor Root Complex [1022:1510]
00:01.0 VGA compatible controller [0300]: Advanced Micro Devices [AMD] nee ATI Wrestler [Radeon HD 6320] [1002:9806]
00:01.1 Audio device [0403]: Advanced Micro Devices [AMD] nee ATI Wrestler HDMI Audio [Radeon HD 6250/6310] [1002:1314]
00:05.0 PCI bridge [0604]: Advanced Micro Devices [AMD] Family 14h Processor Root Port [1022:1513]
00:06.0 PCI bridge [0604]: Advanced Micro Devices [AMD] Family 14h Processor Root Port [1022:1514]
00:07.0 PCI bridge [0604]: Advanced Micro Devices [AMD] Family 14h Processor Root Port [1022:1515]
00:11.0 SATA controller [0106]: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] [1002:4391]
00:12.0 USB controller [0c03]: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB OHCI0 Controller [1002:4397]
00:12.2 USB controller [0c03]: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB EHCI Controller [1002:4396]
00:13.0 USB controller [0c03]: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB OHCI0 Controller [1002:4397]
00:13.2 USB controller [0c03]: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 USB EHCI Controller [1002:4396]
00:14.0 SMBus [0c05]: Advanced Micro Devices [AMD] nee ATI SBx00 SMBus Controller [1002:4385] (rev 42)
00:14.2 Audio device [0403]: Advanced Micro Devices [AMD] nee ATI SBx00 Azalia (Intel HDA) [1002:4383] (rev 40)
00:14.3 ISA bridge [0601]: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 LPC host controller [1002:439d] (rev 40)
00:14.4 PCI bridge [0604]: Advanced Micro Devices [AMD] nee ATI SBx00 PCI to PCI Bridge [1002:4384] (rev 40)
00:18.0 Host bridge [0600]: Advanced Micro Devices [AMD] Family 12h/14h Processor Function 0 [1022:1700] (rev 43)
00:18.1 Host bridge [0600]: Advanced Micro Devices [AMD] Family 12h/14h Processor Function 1 [1022:1701]
00:18.2 Host bridge [0600]: Advanced Micro Devices [AMD] Family 12h/14h Processor Function 2 [1022:1702]
00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] Family 12h/14h Processor Function 3 [1022:1703]
00:18.4 Host bridge [0600]: Advanced Micro Devices [AMD] Family 12h/14h Processor Function 4 [1022:1704]
00:18.5 Host bridge [0600]: Advanced Micro Devices [AMD] Family 12h/14h Processor Function 6 [1022:1718]
00:18.6 Host bridge [0600]: Advanced Micro Devices [AMD] Family 12h/14h Processor Function 5 [1022:1716]
00:18.7 Host bridge [0600]: Advanced Micro Devices [AMD] Family 12h/14h Processor Function 7 [1022:1719]
01:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. RTL8188CE 802.11b/g/n WiFi Adapter [10ec:8176] (rev 01)
02:00.0 Ethernet controller [0200]: Atheros Communications Inc. AR8151 v2.0 Gigabit Ethernet [1969:1083] (rev c0)
03:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5209 PCI Express Card Reader [10ec:5209] (rev 01)

dmesg output from the resume:
[  244.337608] pciehp 0000:00:07.0:pcie04: pciehp_suspend ENTRY
[  244.337745] PM: suspend of devices complete after 1020.300 msecs
[  244.338027] PM: late suspend of devices complete after 0.275 msecs
[  244.349960] PM: noirq suspend of devices complete after 11.943 msecs
[  244.350021] ACPI: Preparing to enter system sleep state S3
[  244.364595] PM: Saving platform NVS memory
[  244.372195] Disabling non-boot CPUs ...
[  244.373765] smpboot: CPU 1 is now offline
[  244.375157] ACPI: Low-level resume complete
[  244.375255] PM: Restoring platform NVS memory
[  244.382089] microcode: CPU0: new patch_level=0x0500010d
[  244.382157] Enabling non-boot CPUs ...
[  244.382356] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  244.393455] LVT offset 0 assigned for vector 0x400
[  244.401990] microcode: CPU1: new patch_level=0x0500010d
[  244.402134] CPU1 is up
[  244.402701] ACPI: Waking up from system sleep state S3
[  244.497181] PM: noirq resume of devices complete after 55.142 msecs
[  244.497395] PM: early resume of devices complete after 0.124 msecs
[  244.497661] snd_hda_intel 0000:00:01.1: irq 43 for MSI/MSI-X
[  244.497830] pciehp 0000:00:07.0:pcie04: pciehp_resume ENTRY
[  244.497999] snd_hda_intel 0000:00:14.2: wake-up capability disabled by ACPI
[  244.498063] snd_hda_intel 0000:00:14.2: enabling device (0000 -> 0002)
[  244.521449] atl1c 0000:02:00.0: irq 45 for MSI/MSI-X
[  244.598573] pciehp 0000:00:07.0:pcie04: Device 0000:03:00.0 already exists at 0000:03:00, cannot hot-add
[  244.598587] pciehp 0000:00:07.0:pcie04: Cannot add device at 0000:03:00
[  244.598689] rts_pstor 0000:03:00.0: rtsx_acquire_irq: chip->msi_en = 0, pci->irq = 19
[  245.003310] irq 16: nobody cared (try booting with the "irqpoll" option)
[  245.003318] Pid: 691, comm: kworker/u:3 Tainted: G         C   3.7.0-rc6-wl+ #3
[  245.003321] Call Trace:
[  245.003342]  <IRQ>  [<ffffffff810a3c86>] ? __report_bad_irq+0x36/0xd0
[  245.003350]  [<ffffffff810a3f8d>] ? note_interrupt+0x1cd/0x220
[  245.003359]  [<ffffffff810a19ae>] ? handle_irq_event_percpu+0x8e/0x1c0
[  245.003367]  [<ffffffff81040415>] ? __do_softirq+0x105/0x1e0
[  245.003374]  [<ffffffff810a1b16>] ? handle_irq_event+0x36/0x60
[  245.003383]  [<ffffffff810a49ac>] ? handle_fasteoi_irq+0x4c/0xe0
[  245.003390]  [<ffffffff810045c5>] ? handle_irq+0x15/0x20
[  245.003396]  [<ffffffff810042b2>] ? do_IRQ+0x52/0xd0
[  245.003404]  [<ffffffff81405b2a>] ? common_interrupt+0x6a/0x6a
[  245.003430]  <EOI>  [<ffffffffa0349380>] ? ttm_bo_move_memcpy+0x3a0/0x4e0 [ttm]
[  245.003443]  [<ffffffffa03492e4>] ? ttm_bo_move_memcpy+0x304/0x4e0 [ttm]
[  245.003457]  [<ffffffffa0346c24>] ? ttm_bo_handle_move_mem+0x234/0x3e0 [ttm]
[  245.003469]  [<ffffffffa0347910>] ? ttm_bo_mem_space+0x170/0x350 [ttm]
[  245.003503]  [<ffffffffa047f200>] ? atom_execute_table_locked+0x70/0x2d0 [radeon]
[  245.003516]  [<ffffffffa0347c3f>] ? ttm_bo_move_buffer+0x14f/0x160 [ttm]
[  245.003528]  [<ffffffffa0347ce5>] ? ttm_bo_validate+0x95/0x120 [ttm]
[  245.003559]  [<ffffffffa0484bbc>] ? radeon_bo_pin_restricted+0x10c/0x1b0 [radeon]
[  245.003590]  [<ffffffffa0485a43>] ? radeon_gart_table_vram_pin+0x33/0xb0 [radeon]
[  245.003619]  [<ffffffffa0481835>] ? atom_execute_table+0x55/0x70 [radeon]
[  245.003649]  [<ffffffffa04c8c86>] ? evergreen_startup+0x386/0x1610 [radeon]
[  245.003677]  [<ffffffffa0481c05>] ? atom_asic_init+0x145/0x1a0 [radeon]
[  245.003706]  [<ffffffffa04ca1d2>] ? evergreen_resume+0x32/0x80 [radeon]
[  245.003730]  [<ffffffffa046e118>] ? radeon_resume_kms+0x68/0x190 [radeon]
[  245.003737]  [<ffffffff81254190>] ? pci_pm_restore+0xe0/0xe0
[  245.003745]  [<ffffffff812e4314>] ? dpm_run_callback.isra.5+0x14/0x40
[  245.003752]  [<ffffffff812e4844>] ? device_resume+0xb4/0x140
[  245.003759]  [<ffffffff812e48e4>] ? async_resume+0x14/0x40
[  245.003767]  [<ffffffff81060666>] ? async_run_entry_fn+0x86/0x1b0
[  245.003775]  [<ffffffff81052f06>] ? process_one_work+0x126/0x490
[  245.003782]  [<ffffffff810605e0>] ? async_unregister_domain+0x70/0x70
[  245.003788]  [<ffffffff81054c3d>] ? worker_thread+0x15d/0x450
[  245.003795]  [<ffffffff81054ae0>] ? flush_delayed_work+0x40/0x40
[  245.003801]  [<ffffffff810599a3>] ? kthread+0xb3/0xc0
[  245.003807]  [<ffffffff810598f0>] ? kthread_create_on_node+0x110/0x110
[  245.003814]  [<ffffffff814061ac>] ? ret_from_fork+0x7c/0xb0
[  245.003820]  [<ffffffff810598f0>] ? kthread_create_on_node+0x110/0x110
[  245.003823] handlers:
[  245.003838] [<ffffffffa0267050>] azx_interrupt [snd_hda_intel]
[  245.003841] Disabling IRQ #16
[  245.011208] [drm] PCIE GART of 512M enabled (table at 0x0000000000040000).
[  245.011501] radeon 0000:00:01.0: WB enabled
[  245.011511] radeon 0000:00:01.0: fence driver on ring 0 use gpu addr 0x0000000018000c00 and cpu addr 0xffff8801186d4c00
[  245.028285] [drm] ring test on 0 succeeded in 1 usecs
[  245.028339] [drm] ib test on ring 0 succeeded in 0 usecs
[  247.044935] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  247.194206] ata1.00: failed to get Identify Device Data, Emask 0x1
[  247.198079] ata1.00: failed to get Identify Device Data, Emask 0x1
[  247.198088] ata1.00: configured for UDMA/133
[  247.198632] sd 0:0:0:0: [sda] Starting disk
[  247.244490] PM: resume of devices complete after 2752.559 msecs
[  247.245608] Restarting tasks ... done.
[  247.259222] video LNXVIDEO:01: Restoring backlight state
[  247.296953] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[  247.297228] ehci_hcd 0000:00:12.2: EHCI Host Controller
[  247.297361] ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 1
[  247.297391] QUIRK: Enable AMD PLL fix
[  247.297400] ehci_hcd 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[  247.297521] ehci_hcd 0000:00:12.2: debug port 1
[  247.297565] ehci_hcd 0000:00:12.2: irq 17, io mem 0xf034a500
[  247.303404] ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
[  247.303486] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[  247.303496] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  247.303504] usb usb1: Product: EHCI Host Controller
[  247.303512] usb usb1: Manufacturer: Linux 3.7.0-rc6-wl+ ehci_hcd
[  247.303519] usb usb1: SerialNumber: 0000:00:12.2
[  247.304278] hub 1-0:1.0: USB hub found
[  247.304302] hub 1-0:1.0: 5 ports detected
[  247.305508] ehci_hcd 0000:00:13.2: EHCI Host Controller
[  247.305541] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
[  247.305561] ehci_hcd 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[  247.305679] ehci_hcd 0000:00:13.2: debug port 1
[  247.305716] ehci_hcd 0000:00:13.2: irq 17, io mem 0xf034a400
[  247.311179] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
[  247.311296] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[  247.311306] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  247.311315] usb usb2: Product: EHCI Host Controller
[  247.311322] usb usb2: Manufacturer: Linux 3.7.0-rc6-wl+ ehci_hcd
[  247.311329] usb usb2: SerialNumber: 0000:00:13.2
[  247.312127] hub 2-0:1.0: USB hub found
[  247.312146] hub 2-0:1.0: 5 ports detected
[  247.324229] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[  247.324459] ohci_hcd 0000:00:12.0: OHCI Host Controller
[  247.324901] ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 3
[  247.324977] ohci_hcd 0000:00:12.0: irq 18, io mem 0xf0349000
[  247.379687] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[  247.379696] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  247.379700] usb usb3: Product: OHCI Host Controller
[  247.379704] usb usb3: Manufacturer: Linux 3.7.0-rc6-wl+ ohci_hcd
[  247.379708] usb usb3: SerialNumber: 0000:00:12.0
[  247.380468] hub 3-0:1.0: USB hub found
[  247.380531] hub 3-0:1.0: 5 ports detected
[  247.384340] ohci_hcd 0000:00:13.0: OHCI Host Controller
[  247.384361] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 4
[  247.384451] ohci_hcd 0000:00:13.0: irq 18, io mem 0xf0348000
[  247.439222] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[  247.439237] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  247.439246] usb usb4: Product: OHCI Host Controller
[  247.439254] usb usb4: Manufacturer: Linux 3.7.0-rc6-wl+ ohci_hcd
[  247.439261] usb usb4: SerialNumber: 0000:00:13.0
[  247.439775] hub 4-0:1.0: USB hub found
[  247.439793] hub 4-0:1.0: 5 ports detected
[  247.478458] rtl8192ce:_rtl92ce_read_chip_version():<0-0> Chip Version ID: B_CHIP_88C
[  247.488454] rtl8192ce: Using firmware rtlwifi/rtl8192cfw.bin
[  247.490288] ieee80211 phy2: Selected rate control algorithm 'rtl_rc'
[  247.492029] rtlwifi: wireless switch is on
[  247.510767] usbcore: registered new interface driver uvcvideo
[  247.510774] USB Video Class driver (1.1.1)
[  247.613565] usb 2-5: new high-speed USB device number 2 using ehci_hcd
[  247.734314] usb 2-5: New USB device found, idVendor=5986, idProduct=01a6
[  247.734330] usb 2-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  247.734338] usb 2-5: Product: Integrated Camera
[  247.734346] usb 2-5: Manufacturer: Image Processor
[  247.734353] usb 2-5: SerialNumber: Integrated Camera
[  247.735749] uvcvideo: Found UVC 1.00 device Integrated Camera (5986:01a6)
[  247.853992] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[  248.248264] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248279] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248285] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248290] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248296] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248301] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248306] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248310] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248315] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248320] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248325] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248329] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248334] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248339] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248344] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248349] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248353] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248358] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248363] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248368] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248372] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248377] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248382] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248387] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248391] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248396] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248401] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248406] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248410] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248415] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248420] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248425] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248429] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248434] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248439] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248444] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248448] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248453] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248458] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248463] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248468] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248472] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248477] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248482] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248487] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248491] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248496] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248501] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248506] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248510] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248515] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248520] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248525] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248529] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248534] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248539] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248544] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248549] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248553] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248558] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248563] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248568] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248572] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248577] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248582] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248587] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248591] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248596] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248601] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248606] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248611] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248615] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248620] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248625] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248630] hda-intel: spurious response 0x7fffffff:0x0, last cmd=0x1970700
[  248.248635] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248639] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248644] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248649] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248654] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248658] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248663] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248668] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248673] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248677] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248682] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248687] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248692] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248697] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248701] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248706] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248711] hda-intel: spurious response 0x7fffffff:0x0, last cmd=0x1970700
[  248.248716] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248721] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248725] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248730] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248735] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248740] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248744] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248749] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248754] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248759] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248763] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248768] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248773] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248778] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248783] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248787] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248792] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248797] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248802] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248806] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248811] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248816] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248821] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248826] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248830] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248835] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248840] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248845] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248849] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248854] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248859] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248864] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248868] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248873] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248878] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248883] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248887] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248892] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248897] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248902] hda-intel: spurious response 0x2:0x0, last cmd=0x1970700
[  248.248906] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248911] hda-intel: spurious response 0x2:0x0, last cmd=0x1970700
[  248.248916] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248921] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248925] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248930] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248935] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248940] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248945] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248949] hda-intel: spurious response 0x233:0x0, last cmd=0x1970700
[  248.248954] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248959] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248964] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248968] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248973] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248978] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248983] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248988] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248992] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.248997] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249002] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249007] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249011] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249016] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249021] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249026] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249030] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249035] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249040] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249045] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249049] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249054] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249059] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249064] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249068] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249073] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249078] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249083] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249087] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249092] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249097] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249102] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249106] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249111] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249116] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249121] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249126] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249131] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249136] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249141] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249146] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249150] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249155] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249160] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249165] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249169] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249174] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249179] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249184] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249188] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249193] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249198] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249203] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249207] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249212] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249217] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249222] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249226] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249231] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249236] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249241] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249245] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249250] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249255] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249259] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249264] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249269] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249274] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249278] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249283] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249288] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249293] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249297] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249302] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249307] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249312] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249317] hda-intel: spurious response 0x7fffffff:0x0, last cmd=0x1970700
[  248.249321] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249326] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249331] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249336] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249340] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249345] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249350] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249355] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249360] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249365] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249369] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249374] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249379] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249384] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249388] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249393] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249398] hda-intel: spurious response 0x7fffffff:0x0, last cmd=0x1970700
[  248.249403] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249408] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249412] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249417] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249422] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249427] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249431] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249436] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249441] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249446] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249451] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249456] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249460] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249465] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249470] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249475] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.249479] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  248.310253] psmouse serio4: synaptics: Touchpad model: 1, fw: 8.0, id: 0x1e2b1, caps: 0xd001a3/0x940300/0x123c00, board id: 1917, fw id: 864720
[  248.310280] psmouse serio4: synaptics: serio: Synaptics pass-through port at isa0060/serio4/input0
[  248.349885] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input17
[  248.420008] input: Integrated Camera as /devices/pci0000:00/0000:00:13.2/usb2/2-5/2-5:1.0/input/input18
[  254.295195] psmouse serio7: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3
[  254.500060] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/serio4/serio7/input/input19
[  754.245525] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245539] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245546] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245551] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245556] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245562] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245566] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245571] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245576] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245581] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245586] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245590] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245595] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245600] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245605] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245610] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245614] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245619] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245624] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245629] hda-intel: spurious response 0x2:0x0, last cmd=0x1370a00
[  754.245634] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245638] hda-intel: spurious response 0x2:0x0, last cmd=0x1370a00
[  754.245643] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245648] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245653] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245657] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245662] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245667] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245672] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245677] hda-intel: spurious response 0x233:0x0, last cmd=0x1370a00
[  754.245681] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245686] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245691] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245696] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245700] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245705] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245710] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245715] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245720] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245724] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245729] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245734] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245739] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245743] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245748] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245753] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245758] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245762] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245767] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245772] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245777] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245782] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245786] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245791] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245796] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245801] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245805] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245810] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245815] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245820] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245824] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245829] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245834] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245839] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245844] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245848] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245853] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245858] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245863] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245868] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245872] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245877] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245882] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245887] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245891] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245896] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245901] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245906] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245910] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245915] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245920] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245925] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245929] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245934] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245939] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245944] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245948] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245953] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245958] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245963] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245967] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245972] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245977] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245982] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245986] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245991] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.245996] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246001] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246006] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246010] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246015] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246020] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246025] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246029] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246034] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246039] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246044] hda-intel: spurious response 0x7fffffff:0x0, last cmd=0x1370a00
[  754.246049] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246053] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246058] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246063] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246068] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246072] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246077] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246082] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246087] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246092] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246096] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246101] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246106] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246111] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246116] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246120] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246125] hda-intel: spurious response 0x7fffffff:0x0, last cmd=0x1370a00
[  754.246130] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246135] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246140] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246144] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246149] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246154] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246159] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246163] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246168] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246173] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246178] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246182] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246187] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246192] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246197] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246201] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  754.246206] hda-intel: spurious response 0x0:0x0, last cmd=0x1370a00
[  756.129634] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129649] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129655] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129660] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129665] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129671] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129676] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129680] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129685] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129690] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129695] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129700] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129704] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129709] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129714] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129719] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129723] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129728] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129733] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129738] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129742] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129747] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129752] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129757] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129761] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129766] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129771] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129776] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129781] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129785] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129790] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129795] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129800] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129804] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129809] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129814] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129819] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129824] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129828] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129833] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129838] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129843] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129847] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129852] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129857] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129862] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129867] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129871] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129876] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129881] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129886] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129890] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129895] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129900] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129905] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129909] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129914] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129919] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129924] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129928] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129933] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129938] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129943] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129947] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129952] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129957] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129962] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129966] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129971] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129976] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129981] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129985] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129990] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.129995] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130000] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130005] hda-intel: spurious response 0x7fffffff:0x0, last cmd=0x1970700
[  756.130010] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130014] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130019] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130024] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130029] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130033] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130038] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130043] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130048] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130052] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130057] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130062] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130067] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130071] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130076] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130081] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130086] hda-intel: spurious response 0x7fffffff:0x0, last cmd=0x1970700
[  756.130091] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130096] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130100] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130105] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130110] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130115] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130120] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130124] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130129] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130134] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130139] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130143] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130148] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130153] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130158] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130162] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130167] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130172] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130177] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130181] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130186] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130191] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130196] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130200] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130205] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130210] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130215] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130219] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130224] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130229] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130234] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130238] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130243] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130248] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130253] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130258] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130262] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130267] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130272] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130277] hda-intel: spurious response 0x2:0x0, last cmd=0x1970700
[  756.130281] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130286] hda-intel: spurious response 0x2:0x0, last cmd=0x1970700
[  756.130291] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130296] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130300] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130305] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130310] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130315] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130319] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130324] hda-intel: spurious response 0x233:0x0, last cmd=0x1970700
[  756.130329] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130334] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130339] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130343] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130348] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130353] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130358] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130363] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130368] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130372] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130377] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130382] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130387] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130391] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130396] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130401] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130406] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130411] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130415] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130420] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130425] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130430] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130434] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130439] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130444] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130449] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130453] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130458] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130463] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130468] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130473] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130477] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130482] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130487] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130492] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130496] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130501] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130506] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130511] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130515] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130520] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130525] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130530] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130535] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130539] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130544] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130549] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130554] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130558] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130563] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130568] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130573] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130577] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130582] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130587] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130592] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130596] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130601] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130606] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130611] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130616] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130620] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130625] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130630] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130635] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130640] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130644] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130649] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130654] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130659] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130663] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130668] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130673] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130678] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130682] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130687] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130692] hda-intel: spurious response 0x7fffffff:0x0, last cmd=0x1970700
[  756.130697] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130702] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130707] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130711] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130716] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130721] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130726] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130730] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130735] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130740] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130745] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130750] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130754] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130759] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130764] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130769] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130774] hda-intel: spurious response 0x7fffffff:0x0, last cmd=0x1970700
[  756.130778] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130783] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130788] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130793] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130797] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130802] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130807] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130812] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130817] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130821] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130826] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130831] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130836] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130840] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130845] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130850] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  756.130855] hda-intel: spurious response 0x0:0x0, last cmd=0x1970700
[  757.131144] hda_intel: azx_get_response timeout, switching to single_cmd mode: last cmd=0x01a70700
[  764.205783] azx_single_send_cmd: 992 callbacks suppressed
[ 1203.317626] azx_single_send_cmd: 221 callbacks suppressed
[ 1209.500319] azx_single_send_cmd: 456 callbacks suppressed


With best regards,
Julian
