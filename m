From: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Subject: Re: ASoC: WM8804: fsi-wm8804
Date: Mon, 15 Nov 2010 14:46:55 +0100
Message-ID: <4CE139CF.4070400@elproma.com.pl>
References: <4CE126FD.7000407@elproma.com.pl>
	<20101115123351.GB3338@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040508050604040905010407"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailmxout.mailmx.agnat.pl (mailmxout.mailmx.agnat.pl
	[193.239.44.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 19054103847
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 14:47:07 +0100 (CET)
In-Reply-To: <20101115123351.GB3338@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040508050604040905010407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mark Brown wrote:
> Did you register the I2C device for the CODEC with the I2C subsystem?
>   
I believe that is done in wm8804 codec driver (i2c_add_driver() call in 
wm8804_modinit() function).
> If that's not the issue could you please provide a kernel log with
> #define DEBUG at the top of soc-core.c?
>   
I'm sending the full kern.log as an attachment to this email.
>   
>>     if(substream->stream == SNDRV_PCM_STREAM_CAPTURE)
>>     {
>>         snd_soc_dai_set_pll(dai, 0, 0, 12000000, 94310400);
>>     }
>>     else if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>     {
>>         snd_soc_dai_set_pll(dai, 0, 0, 12000000, 98304000);
>>     }
>>     
>
> This is going to prevent simultaneous playback and record; this may not
> be an issue in your system but I wanted to be sure you were aware of it.
>
>   
Yes, I'm aware of that. However, in my system it is not going to be a 
problem.

Thank you for your help.

best regards,
Greg

--------------040508050604040905010407
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kern.log"

Nov 15 13:37:51 ecovec kernel: klogd 1.5.0#6, log source = /proc/kmsg started.
Nov 15 13:37:51 ecovec kernel: Linux version 2.6.37-rc1 (root@rakieta2) (gcc version 4.3.4 (Debian 4.3.4-1) ) #13 PREEMPT Mon Nov 15 13:35:32 UTC 2010
Nov 15 13:37:51 ecovec kernel: Boot params:
Nov 15 13:37:51 ecovec kernel: ... MOUNT_ROOT_RDONLY - 00000000
Nov 15 13:37:51 ecovec kernel: ... RAMDISK_FLAGS     - 00000000
Nov 15 13:37:51 ecovec kernel: ... ORIG_ROOT_DEV     - 00000000
Nov 15 13:37:51 ecovec kernel: ... LOADER_TYPE       - 00000000
Nov 15 13:37:51 ecovec kernel: ... INITRD_START      - 00000000
Nov 15 13:37:51 ecovec kernel: ... INITRD_SIZE       - 00000000
Nov 15 13:37:51 ecovec kernel: Memory limited to 248MB
Nov 15 13:37:51 ecovec kernel: Booting machvec: R0P7724 (EcoVec)
Nov 15 13:37:51 ecovec kernel: Node 0: start_pfn = 0x8000, low = 0x17800
Nov 15 13:37:51 ecovec kernel: Zone PFN ranges:
Nov 15 13:37:51 ecovec kernel:   Normal   0x00008000 -> 0x00017800
Nov 15 13:37:51 ecovec kernel: Movable zone start PFN for each node
Nov 15 13:37:51 ecovec kernel: early_node_map[1] active PFN ranges
Nov 15 13:37:51 ecovec kernel:     0: 0x00008000 -> 0x00017800
Nov 15 13:37:51 ecovec kernel: On node 0 totalpages: 63488
Nov 15 13:37:51 ecovec kernel: free_area_init_node: node 0, pgdat 883c43a8, node_mem_map 883ff000
Nov 15 13:37:51 ecovec kernel:   Normal zone: 496 pages used for memmap
Nov 15 13:37:51 ecovec kernel:   Normal zone: 0 pages reserved
Nov 15 13:37:51 ecovec kernel:   Normal zone: 62992 pages, LIFO batch:15
Nov 15 13:37:51 ecovec kernel: pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
Nov 15 13:37:51 ecovec kernel: pcpu-alloc: [0] 0 
Nov 15 13:37:51 ecovec kernel: Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 62992
Nov 15 13:37:51 ecovec kernel: Kernel command line: console=tty0, console=ttySC0,115200 root=/dev/mmcblk0p1 rootdelay=5 mem=248M memchunk.vpu=8m memchunk.veu0=4m
Nov 15 13:37:51 ecovec kernel: PID hash table entries: 1024 (order: 0, 4096 bytes)
Nov 15 13:37:51 ecovec kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Nov 15 13:37:51 ecovec kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Nov 15 13:37:51 ecovec kernel: PVR=10300b00 CVR=7144040d PRR=00002200
Nov 15 13:37:51 ecovec kernel: I-cache : n_ways=4 n_sets=256 way_incr=8192
Nov 15 13:37:51 ecovec kernel: I-cache : entry_mask=0x00001fe0 alias_mask=0x00001000 n_aliases=2
Nov 15 13:37:51 ecovec kernel: D-cache : n_ways=4 n_sets=256 way_incr=8192
Nov 15 13:37:51 ecovec kernel: D-cache : entry_mask=0x00001fe0 alias_mask=0x00001000 n_aliases=2
Nov 15 13:37:51 ecovec kernel: S-cache : n_ways=4 n_sets=2048 way_incr=65536
Nov 15 13:37:51 ecovec kernel: S-cache : entry_mask=0x0000ffe0 alias_mask=0x0000f000 n_aliases=16
Nov 15 13:37:51 ecovec kernel: Memory: 247632k/253952k available (2678k kernel code, 1176k data, 116k init)
Nov 15 13:37:51 ecovec kernel: virtual kernel memory layout:
Nov 15 13:37:51 ecovec kernel:     fixmap  : 0xdffd7000 - 0xdffff000   ( 160 kB)
Nov 15 13:37:51 ecovec kernel:     vmalloc : 0xc0000000 - 0xdffd5000   ( 511 MB)
Nov 15 13:37:51 ecovec kernel:     lowmem  : 0x88000000 - 0x97800000   ( 248 MB) (cached)
Nov 15 13:37:51 ecovec kernel:             : 0xa0000000 - 0xc0000000   ( 512 MB) (uncached)
Nov 15 13:37:51 ecovec kernel:       .init : 0x883c5000 - 0x883e2000   ( 116 kB)
Nov 15 13:37:51 ecovec kernel:       .data : 0x8829e974 - 0x883c4aa0   (1176 kB)
Nov 15 13:37:51 ecovec kernel:       .text : 0x88001000 - 0x8829e974   (2678 kB)
Nov 15 13:37:51 ecovec kernel: Preemptable hierarchical RCU implementation.
Nov 15 13:37:51 ecovec kernel: ^IRCU-based detection of stalled CPUs is disabled.
Nov 15 13:37:51 ecovec kernel: ^IVerbose stalled-CPUs detection is disabled.
Nov 15 13:37:51 ecovec kernel: NR_IRQS:512 nr_irqs:512 8
Nov 15 13:37:51 ecovec kernel: intc: Registered controller 'sh7724' with 83 IRQs
Nov 15 13:37:51 ecovec kernel: Console: colour dummy device 80x25
Nov 15 13:37:51 ecovec kernel: console [tty0] enabled
Nov 15 13:37:51 ecovec kernel:  sh_tmu.0: used for clock events
Nov 15 13:37:51 ecovec kernel:  sh_tmu.0: used for periodic clock events
Nov 15 13:37:51 ecovec kernel:  sh_tmu.1: used as clock source
Nov 15 13:37:51 ecovec kernel: Calibrating delay loop (skipped)... 499.99 BogoMIPS PRESET (lpj=999999)
Nov 15 13:37:51 ecovec kernel: pid_max: default: 32768 minimum: 301
Nov 15 13:37:51 ecovec kernel: Mount-cache hash table entries: 512
Nov 15 13:37:51 ecovec kernel: CPU: SH7724
Nov 15 13:37:51 ecovec kernel: NET: Registered protocol family 16
Nov 15 13:37:51 ecovec kernel: vpu: forcing memory chunk size to 0x00800000
Nov 15 13:37:51 ecovec kernel: veu0: forcing memory chunk size to 0x00400000
Nov 15 13:37:51 ecovec kernel: pfc: sh7724_pfc handling gpio 0 -> 486
Nov 15 13:37:51 ecovec kernel: Performance Events: sh4a support registered
Nov 15 13:37:51 ecovec kernel: HW Breakpoints: SH-4A UBC support registered
Nov 15 13:37:51 ecovec kernel: USB1 host is selected
Nov 15 13:37:51 ecovec kernel: bio: create slab <bio-0> at 0
Nov 15 13:37:51 ecovec kernel: SCSI subsystem initialized
Nov 15 13:37:51 ecovec kernel: usbcore: registered new interface driver usbfs
Nov 15 13:37:51 ecovec kernel: usbcore: registered new interface driver hub
Nov 15 13:37:51 ecovec kernel: usbcore: registered new device driver usb
Nov 15 13:37:51 ecovec kernel: Advanced Linux Sound Architecture Driver Version 1.0.23.
Nov 15 13:37:51 ecovec kernel: Switching to clocksource sh_tmu.1
Nov 15 13:37:51 ecovec kernel: NET: Registered protocol family 2
Nov 15 13:37:51 ecovec kernel: IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
Nov 15 13:37:51 ecovec kernel: TCP established hash table entries: 8192 (order: 4, 65536 bytes)
Nov 15 13:37:51 ecovec kernel: TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
Nov 15 13:37:51 ecovec kernel: TCP: Hash tables configured (established 8192 bind 8192)
Nov 15 13:37:51 ecovec kernel: TCP reno registered
Nov 15 13:37:51 ecovec kernel: UDP hash table entries: 256 (order: 0, 4096 bytes)
Nov 15 13:37:51 ecovec kernel: UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
Nov 15 13:37:51 ecovec kernel: NET: Registered protocol family 1
Nov 15 13:37:51 ecovec kernel: RPC: Registered udp transport module.
Nov 15 13:37:51 ecovec kernel: RPC: Registered tcp transport module.
Nov 15 13:37:51 ecovec kernel: RPC: Registered tcp NFSv4.1 backchannel transport module.
Nov 15 13:37:51 ecovec kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Nov 15 13:37:51 ecovec kernel: fuse init (API version 7.15)
Nov 15 13:37:51 ecovec kernel: msgmni has been set to 483
Nov 15 13:37:51 ecovec kernel: io scheduler noop registered
Nov 15 13:37:51 ecovec kernel: io scheduler deadline registered
Nov 15 13:37:51 ecovec kernel: io scheduler cfq registered (default)
Nov 15 13:37:51 ecovec kernel: Console: switching to colour frame buffer device 160x45
Nov 15 13:37:51 ecovec kernel: graphics fb0: registered sh_mobile_lcdc_fb/mainlcd as 1280x720 16bpp.
Nov 15 13:37:51 ecovec kernel: SuperH SCI(F) driver initialized
Nov 15 13:37:51 ecovec kernel: sh-sci.0: ttySC0 at MMIO 0xffe00000 (irq = 80) is a scif
Nov 15 13:37:51 ecovec kernel: console [ttySC0] enabled
Nov 15 13:37:51 ecovec kernel: sh-sci.1: ttySC1 at MMIO 0xffe10000 (irq = 81) is a scif
Nov 15 13:37:51 ecovec kernel: sh-sci.2: ttySC2 at MMIO 0xffe20000 (irq = 82) is a scif
Nov 15 13:37:51 ecovec kernel: sh-sci.3: ttySC3 at MMIO 0xa4e30000 (irq = 56) is a scifa
Nov 15 13:37:51 ecovec kernel: sh-sci.4: ttySC4 at MMIO 0xa4e40000 (irq = 88) is a scifa
Nov 15 13:37:51 ecovec kernel: sh-sci.5: ttySC5 at MMIO 0xa4e50000 (irq = 109) is a scifa
Nov 15 13:37:51 ecovec kernel: brd: module loaded
Nov 15 13:37:51 ecovec kernel: physmap platform flash device: 04000000 at 00000000
Nov 15 13:37:51 ecovec kernel: physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank. Manufacturer ID 0x00007f Chip ID 0x0022c9
Nov 15 13:37:51 ecovec kernel: physmap-flash.0: Found an alias at 0x800000 for the chip at 0x0
Nov 15 13:37:51 ecovec kernel: physmap-flash.0: Found an alias at 0x1000000 for the chip at 0x0
Nov 15 13:37:51 ecovec kernel: physmap-flash.0: Found an alias at 0x1800000 for the chip at 0x0
Nov 15 13:37:51 ecovec kernel: physmap-flash.0: Found an alias at 0x2000000 for the chip at 0x0
Nov 15 13:37:51 ecovec kernel: physmap-flash.0: Found an alias at 0x2800000 for the chip at 0x0
Nov 15 13:37:51 ecovec kernel: physmap-flash.0: Found an alias at 0x3000000 for the chip at 0x0
Nov 15 13:37:51 ecovec kernel: physmap-flash.0: Found an alias at 0x3800000 for the chip at 0x0
Nov 15 13:37:51 ecovec kernel: Amd/Fujitsu Extended Query Table at 0x0040
Nov 15 13:37:51 ecovec kernel:   Amd/Fujitsu Extended Query version 1.1.
Nov 15 13:37:51 ecovec kernel: physmap-flash.0: Swapping erase regions for top-boot CFI table.
Nov 15 13:37:51 ecovec kernel: number of CFI chips: 1
Nov 15 13:37:51 ecovec kernel: RedBoot partition parsing not available
Nov 15 13:37:51 ecovec kernel: Using physmap partition information
Nov 15 13:37:51 ecovec kernel: Creating 2 MTD partitions on "physmap-flash.0":
Nov 15 13:37:51 ecovec kernel: 0x000000000000-0x000000500000 : "boot loader"
Nov 15 13:37:51 ecovec kernel: 0x000000500000-0x000000800000 : "free-area"
Nov 15 13:37:51 ecovec kernel: sh_mii: probed
Nov 15 13:37:51 ecovec kernel: Base address at 0xa4600000, 00:00:87:11:22:33, IRQ 91.
Nov 15 13:37:51 ecovec kernel: PPP generic driver version 2.4.2
Nov 15 13:37:51 ecovec kernel: PPP Deflate Compression module registered
Nov 15 13:37:51 ecovec kernel: PPP BSD Compression module registered
Nov 15 13:37:51 ecovec kernel: r8a66597_hcd: driver r8a66597_hcd, 2009-05-26
Nov 15 13:37:51 ecovec kernel: r8a66597_hcd r8a66597_hcd.0: USB Host Controller
Nov 15 13:37:51 ecovec kernel: r8a66597_hcd r8a66597_hcd.0: new USB bus registered, assigned bus number 1
Nov 15 13:37:51 ecovec kernel: r8a66597_hcd r8a66597_hcd.0: irq 65, io base 0xa4d80000
Nov 15 13:37:51 ecovec kernel: hub 1-0:1.0: USB hub found
Nov 15 13:37:51 ecovec kernel: hub 1-0:1.0: 1 port detected
Nov 15 13:37:51 ecovec kernel: r8a66597_hcd r8a66597_hcd.1: USB Host Controller
Nov 15 13:37:51 ecovec kernel: r8a66597_hcd r8a66597_hcd.1: new USB bus registered, assigned bus number 2
Nov 15 13:37:51 ecovec kernel: r8a66597_hcd r8a66597_hcd.1: irq 66, io base 0xa4d90000
Nov 15 13:37:51 ecovec kernel: hub 2-0:1.0: USB hub found
Nov 15 13:37:51 ecovec kernel: hub 2-0:1.0: 1 port detected
Nov 15 13:37:51 ecovec kernel: usbcore: registered new interface driver cdc_acm
Nov 15 13:37:51 ecovec kernel: cdc_acm: v0.26:USB Abstract Control Model driver for USB modems and ISDN adapters
Nov 15 13:37:51 ecovec kernel: Initializing USB Mass Storage driver...
Nov 15 13:37:51 ecovec kernel: usbcore: registered new interface driver usb-storage
Nov 15 13:37:51 ecovec kernel: USB Mass Storage support registered.
Nov 15 13:37:51 ecovec kernel: usbcore: registered new interface driver usbserial
Nov 15 13:37:51 ecovec kernel: USB Serial support registered for generic
Nov 15 13:37:51 ecovec kernel: usbcore: registered new interface driver usbserial_generic
Nov 15 13:37:51 ecovec kernel: usbserial: USB Serial Driver core
Nov 15 13:37:51 ecovec kernel: USB Serial support registered for ch341-uart
Nov 15 13:37:51 ecovec kernel: usbcore: registered new interface driver ch341
Nov 15 13:37:51 ecovec kernel: rtc-ds1307 1-0068: rtc core: registered ds1338 as rtc0
Nov 15 13:37:51 ecovec kernel: rtc-ds1307 1-0068: 56 bytes nvram
Nov 15 13:37:51 ecovec kernel: i2c /dev entries driver
Nov 15 13:37:51 ecovec kernel: sdhci: Secure Digital Host Controller Interface driver
Nov 15 13:37:51 ecovec kernel: sdhci: Copyright(c) Pierre Ossman
Nov 15 13:37:51 ecovec kernel: mmc0 at 0xa4ce0000 irq 100
Nov 15 13:37:51 ecovec kernel: mmc1 at 0xa4cf0000 irq 23
Nov 15 13:37:51 ecovec kernel: sh_tmu sh_tmu.0: kept as earlytimer
Nov 15 13:37:51 ecovec kernel: sh_tmu sh_tmu.1: kept as earlytimer
Nov 15 13:37:51 ecovec kernel: usbcore: registered new interface driver usbhid
Nov 15 13:37:51 ecovec kernel: usbhid: USB HID core driver
Nov 15 13:37:51 ecovec kernel: usbcore: registered new interface driver snd-usb-audio
Nov 15 13:37:51 ecovec kernel: Asahi Kasei AK4104 ALSA SoC Codec Driver
Nov 15 13:37:51 ecovec kernel: Cirrus Logic CS4270 ALSA SoC Codec Driver
Nov 15 13:37:51 ecovec kernel: mmc0: host does not support reading read-only switch. assuming write-enable.
Nov 15 13:37:51 ecovec kernel: mmc0: new SD card at address ea28
Nov 15 13:37:51 ecovec kernel: mmcblk0: mmc0:ea28 SU02G 1.84 GiB 
Nov 15 13:37:51 ecovec kernel:  mmcblk0: p1
Nov 15 13:37:51 ecovec kernel: fsi_wm8804_sound_init
Nov 15 13:37:51 ecovec kernel: ALSA device list:
Nov 15 13:37:51 ecovec kernel:   No soundcards found.
Nov 15 13:37:51 ecovec kernel: heartbeat: version 0.1.2 loaded
Nov 15 13:37:51 ecovec kernel: heartbeat: leds register status: 0
Nov 15 13:37:51 ecovec kernel: TCP cubic registered
Nov 15 13:37:51 ecovec kernel: NET: Registered protocol family 17
Nov 15 13:37:51 ecovec kernel: rtc-ds1307 1-0068: setting system clock to 2010-11-15 13:37:23 UTC (1289828243)
Nov 15 13:37:51 ecovec kernel: Waiting 5sec before mounting root device...
Nov 15 13:37:51 ecovec kernel: EXT3-fs: barriers not enabled
Nov 15 13:37:51 ecovec kernel: kjournald starting.  Commit interval 5 seconds
Nov 15 13:37:51 ecovec kernel: EXT3-fs (mmcblk0p1): using internal journal
Nov 15 13:37:51 ecovec kernel: EXT3-fs (mmcblk0p1): recovery complete
Nov 15 13:37:51 ecovec kernel: EXT3-fs (mmcblk0p1): mounted filesystem with writeback data mode
Nov 15 13:37:51 ecovec kernel: VFS: Mounted root (ext3 filesystem) on device 179:1.
Nov 15 13:37:51 ecovec kernel: Freeing unused kernel memory: 116k freed
Nov 15 13:37:51 ecovec kernel: udevd (526): /proc/526/oom_adj is deprecated, please use /proc/526/oom_score_adj instead.
Nov 15 13:37:51 ecovec kernel: EXT3-fs (mmcblk0p1): using internal journal
Nov 15 13:37:51 ecovec kernel: net eth0: attached phy 0 to driver Davicom DM9161E
Nov 15 13:37:51 ecovec kernel: PHY: 0:00 - Link is Up - 100/Full

--------------040508050604040905010407
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040508050604040905010407--
