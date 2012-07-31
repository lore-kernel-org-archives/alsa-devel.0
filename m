From: Daniel Mack <zonque@gmail.com>
Subject: Re: Alsa: USB Class 2 Audio soundcard device
 disappears suddenly
Date: Tue, 31 Jul 2012 13:38:20 +0200
Message-ID: <5017C3AC.4050302@gmail.com>
References: <1343687555.25545.YahooMailNeo@web121601.mail.ne1.yahoo.com>
 <50176C21.4080203@gmail.com>
 <1343729241.63273.YahooMailNeo@web121603.mail.ne1.yahoo.com>
 <1343729559.92141.YahooMailNeo@web121604.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090501050608070400070500"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 by alsa0.perex.cz (Postfix) with ESMTP id AD885265B6F
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 13:38:23 +0200 (CEST)
Received: by lban1 with SMTP id n1so3377316lba.38
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 04:38:25 -0700 (PDT)
In-Reply-To: <1343729559.92141.YahooMailNeo@web121604.mail.ne1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joao Bonina <bonina_2001@yahoo.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-usb <linux-usb@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090501050608070400070500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 31.07.2012 12:12, Joao Bonina wrote:
> 
> 
> It doesn't show anything when that happens.

Well, it shows:

[  349.789200] hub 1-0:1.0: port 4 disabled by hub (EMI?), re-enabling...

I guess this about the time when the streaming stops? How does your USB
wiring setup look like and what kind of system is that? Smells like a
hardware issue, to be honest. You could do some stress-testing by
transferring huge amounts of data from one USB storage media to another.
Also try replacing the cables maybe.

I'm Cc'ing the linux-usb list, maybe someone there has an idea.


Daniel


> 
> Looking at dmesg (I'm attaching it), it shows this:
> [  350.170478] usb 1-4: config 1 has an invalid interface number: 3 but max is 2
> [  350.170500] usb 1-4: config 1 has no interface number 2
> [  350.170843] usb 1-4: config 1 has an invalid interface number: 3 but max is 2
> [  350.170864] usb 1-4: config 1 has no interface number 2
> [  350.171344] usb 1-4: New USB device found, idVendor=21b4, idProduct=0230
> 
> [  350.171366] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [  350.171385] usb 1-4: Product: Ayre USB Interface
> [  350.171401] usb 1-4: Manufacturer: Ayre Acoustics
> [  350.171418] usb 1-4: SerialNumber: (C) 2010 XMOS/Wavelength Audio
> 
> 
> Don't know if those 'invalid interface number' messages are relevant for the issue.
> 
> Joao
> 
> 
> ----- Original Message -----
> From: Daniel Mack <zonque@gmail.com>
> To: Joao Bonina <bonina_2001@yahoo.com>
> Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
> Sent: Tuesday, 31 July 2012, 6:24
> Subject: Re: [alsa-devel] Alsa: USB Class 2 Audio soundcard device disappears suddenly
> 
> On 31.07.2012 00:32, Joao Bonina wrote:
>> Hi,
>>
>> I'm using an USB Class 2 Audio DAC (basically a soundcard) with my Linux box and MPD software.
>>
>> It works great when playing files stored in a remote share, but when 
>> playing files from an USB pen, it stops playing in a few minutes.
>>
>> Mpd.log shows this:
>>
>> Code:
>> Jul 30 13:03 : output: "USB" [alsa] failed to play: No such device
>> Jul 30 13:03 : output: closed plugin=alsa name="USB"
>> ALSA lib pcm_hw.c:1401:(_snd_pcm_hw_open) Invalid value for card
>> Jul 30 13:03 : output: Failed to open "USB" [alsa]: Failed to open ALSA device "hw:0,0": No such file or directoryIt seems to be somewhat related to the USB bus not being able to 
>> cope with both PCM streaming to the soundcard and reading from the flash pen simultaneously, I guess.
>>
>> So, anybody faced this issue previously and can provide some hints to solve this?
>>
>> MPD is 0.17, kernel is 3.2.17, alsa-utils is 1.0.25.
> 
> Does the kernel log or 'dmesg' show anything weird what that happens?
> 
> 
> Daniel
> 


--------------090501050608070400070500
Content-Type: text/plain; charset=UTF-8;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.txt"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.2.17-rt28 (root@debian) (gcc version 4.4.5 (Debian 4.4.5-8) ) #1 PREEMPT RT Sat Jul 28 23:51:42 WEST 2012
[    0.000000] KERNEL supported cpus:
[    0.000000]   AMD AuthenticAMD
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
[    0.000000]  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000000f7c0000 (usable)
[    0.000000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] DMI not present or invalid.
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] last_pfn = 0xf7c0 max_arch_pfn = 0x100000
[    0.000000] initial memory mapped : 0 - 01800000
[    0.000000] Base memory trampoline at [c009d000] 9d000 size 4096
[    0.000000] init_memory_mapping: 0000000000000000-000000000f7c0000
[    0.000000]  0000000000 - 0000400000 page 4k
[    0.000000]  0000400000 - 000f400000 page 2M
[    0.000000]  000f400000 - 000f7c0000 page 4k
[    0.000000] kernel direct mapping tables up to f7c0000 @ 17fb000-1800000
[    0.000000] RAMDISK: 0b7cd000 - 0ba10000
[    0.000000] ACPI Error: A valid RSDP was not found (20110623/tbxfroot-219)
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 247MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 0f7c0000
[    0.000000]   low ram: 0 - 0f7c0000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x0000f7c0
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009e
[    0.000000]     0: 0x00000100 -> 0x0000f7c0
[    0.000000] On node 0 totalpages: 63310
[    0.000000] free_area_init_node: node 0, pgdat c13303e0, node_mem_map cf5cf200
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3950 pages, LIFO batch:0
[    0.000000]   Normal zone: 464 pages used for memmap
[    0.000000]   Normal zone: 58864 pages, LIFO batch:15
[    0.000000] Allocating PCI resources starting at f7c0000 (gap: f7c0000:f0830000)
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 62814
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.2.17-rt28 root=UUID=db00af1b-7a21-4968-9087-92bb7cb92ee0 ro quiet clocksource=acpi_pm maxcpus=1
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (00000000:00000000)
[    0.000000] Memory: 244832k/253696k available (2169k kernel code, 8408k reserved, 1112k data, 260k init, 0k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfffe5000 - 0xfffff000   ( 104 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xcffc0000 - 0xff7fe000   ( 760 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xcf7c0000   ( 247 MB)
[    0.000000]       .init : 0xc1335000 - 0xc1376000   ( 260 kB)
[    0.000000]       .data : 0xc121e645 - 0xc1334980   (1112 kB)
[    0.000000]       .text : 0xc1000000 - 0xc121e645   (2169 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] CPU 0 irqstacks, hard=cf008000 soft=cf00a000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 498.120 MHz processor.
[    0.002005] Calibrating delay loop (skipped), value calculated using timer frequency.. 996.24 BogoMIPS (lpj=498120)
[    0.002033] pid_max: default: 32768 minimum: 301
[    0.002333] Mount-cache hash table entries: 512
[    0.003245] Initializing cgroup subsys cpuacct
[    0.003264] Initializing cgroup subsys devices
[    0.003278] Initializing cgroup subsys freezer
[    0.003292] Initializing cgroup subsys net_cls
[    0.003408] CPU: Geode(TM) Integrated Processor by AMD PCS stepping 02
[    0.003630] Performance Events: no PMU driver, software events only.
[    0.004660] devtmpfs: initialized
[    0.005498] print_constraints: dummy: 
[    0.005739] NET: Registered protocol family 16
[    0.007809] PCI: PCI BIOS revision 2.10 entry at 0xfa980, last bus=0
[    0.011107] bio: create slab <bio-0> at 0
[    0.011435] ACPI: Interpreter disabled.
[    0.011763] PCI: Probing PCI hardware
[    0.011777] PCI: Probing PCI hardware (bus 00)
[    0.012136] pci 0000:00:01.0: [1022:2080] type 0 class 0x000600
[    0.012302] pci 0000:00:01.0: reg 10: [io  0xac1c-0xac1f]
[    0.013302] pci 0000:00:01.1: [1022:2081] type 0 class 0x000300
[    0.013698] pci 0000:00:01.1: reg 10: [mem 0xee000000-0xeeffffff]
[    0.014029] pci 0000:00:01.1: reg 14: [mem 0xeffec000-0xeffeffff]
[    0.014327] pci 0000:00:01.1: reg 18: [mem 0xeffe8000-0xeffebfff]
[    0.014625] pci 0000:00:01.1: reg 1c: [mem 0xefff8000-0xefffbfff]
[    0.014923] pci 0000:00:01.1: reg 20: [mem 0xefff4000-0xefff7fff]
[    0.015824] pci 0000:00:01.2: [1022:2082] type 0 class 0x001010
[    0.016241] pci 0000:00:01.2: reg 10: [mem 0xefff0000-0xefff3fff]
[    0.018178] pci 0000:00:0d.0: [1106:3053] type 0 class 0x000200
[    0.018275] pci 0000:00:0d.0: reg 10: [io  0xfc00-0xfcff]
[    0.018337] pci 0000:00:0d.0: reg 14: [mem 0xeffff000-0xeffff0ff]
[    0.018649] pci 0000:00:0d.0: supports D1 D2
[    0.018666] pci 0000:00:0d.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.018698] pci 0000:00:0d.0: PME# disabled
[    0.018874] pci 0000:00:0f.0: [1022:2090] type 0 class 0x000601
[    0.019226] pci 0000:00:0f.0: reg 10: [io  0x6000-0x6007]
[    0.019568] pci 0000:00:0f.0: reg 14: [io  0x6100-0x61ff]
[    0.019910] pci 0000:00:0f.0: reg 18: [io  0x6200-0x623f]
[    0.020348] pci 0000:00:0f.0: reg 1c: [io  0x0000-0x001f]
[    0.020696] pci 0000:00:0f.0: reg 20: [io  0x9d00-0x9d7f]
[    0.021025] pci 0000:00:0f.0: reg 24: [io  0x9c00-0x9c3f]
[    0.021699] pci 0000:00:0f.2: [1022:209a] type 0 class 0x000101
[    0.023147] pci 0000:00:0f.2: reg 20: [io  0xff00-0xff0f]
[    0.024176] pci 0000:00:0f.5: [1022:2095] type 0 class 0x000c03
[    0.024640] pci 0000:00:0f.5: reg 10: [mem 0xefffe000-0xefffefff]
[    0.026638] pci 0000:00:0f.5: PME# supported from D0 D3hot D3cold
[    0.026741] pci 0000:00:0f.5: PME# disabled
[    0.028580] pci 0000:00:0f.0: NatSemi IRQ router [1022:2090]
[    0.028818] PCI: pci_cache_line_size set to 32 bytes
[    0.029267] reserve RAM buffer: 000000000009e800 - 000000000009ffff 
[    0.029285] reserve RAM buffer: 000000000f7c0000 - 000000000fffffff 
[    0.029781] Switching to clocksource pit
[    0.029945] pnp: PnP ACPI: disabled
[    0.040779] PCI: max bus depth: 0 pci_try_num: 1
[    0.040824] pci 0000:00:0f.0: BAR 3: assigned [io  0x1000-0x101f]
[    0.040922] pci 0000:00:0f.0: BAR 3: set to [io  0x1000-0x101f] (PCI address [0x1000-0x101f])
[    0.040948] pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
[    0.040969] pci_bus 0000:00: resource 1 [mem 0x00000000-0xffffffff]
[    0.041151] NET: Registered protocol family 2
[    0.041367] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.041814] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    0.042067] TCP bind hash table entries: 8192 (order: 5, 196608 bytes)
[    0.042795] TCP: Hash tables configured (established 8192 bind 8192)
[    0.042810] TCP reno registered
[    0.042829] UDP hash table entries: 128 (order: 1, 8192 bytes)
[    0.042902] UDP-Lite hash table entries: 128 (order: 1, 8192 bytes)
[    0.043221] NET: Registered protocol family 1
[    0.043341] pci 0000:00:01.1: Boot video device
[    0.043825] PCI: setting IRQ 5 as level-triggered
[    0.043844] pci 0000:00:0f.5: assigned PCI INT D -> IRQ 5
[    0.044355] PCI: CLS 32 bytes, default 32
[    0.044636] Unpacking initramfs...
[    0.515824] Freeing initrd memory: 2316k freed
[    0.518564] platform rtc_cmos: registered platform RTC device (no PNP device found)
[    0.519194] scx200: NatSemi SCx200 Driver
[    0.519876] audit: initializing netlink socket (disabled)
[    0.519921] type=2000 audit(1343728315.518:1): initialized
[    0.708277] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.708903] VFS: Disk quotas dquot_6.5.2
[    0.708975] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.709449] msgmni has been set to 482
[    0.710148] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.710166] io scheduler noop registered
[    0.710179] io scheduler deadline registered
[    0.710236] io scheduler cfq registered (default)
[    0.791206] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.812106] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.832959] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    0.834642] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    0.837231] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.837273] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.838001] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[    0.838225] rtc0: alarms up to one day, 114 bytes nvram
[    0.838693] rtc-test rtc-test.0: rtc core: registered test as rtc1
[    0.839112] rtc-test rtc-test.1: rtc core: registered test as rtc2
[    0.839141] cpuidle: using governor ladder
[    0.839570] TCP cubic registered
[    0.839727] NET: Registered protocol family 10
[    0.840468] Mobile IPv6
[    0.840483] NET: Registered protocol family 17
[    0.840508] Registering the dns_resolver key type
[    0.841224] registered taskstats version 1
[    0.842190] rtc_cmos rtc_cmos: setting system clock to 2012-07-31 09:51:56 UTC (1343728316)
[    0.842994] Freeing unused kernel memory: 260k freed
[    0.843603] Write protecting the kernel text: 2172k
[    0.843737] Write protecting the kernel read-only data: 948k
[    0.933920] udev[44]: starting version 164
[    1.523045] Switching to clocksource tsc
[    1.567124] SCSI subsystem initialized
[    2.094375] libata version 3.00 loaded.
[    2.104990] pata_amd 0000:00:0f.2: version 0.4.1
[    2.112743] scsi0 : pata_amd
[    2.113658] scsi1 : pata_amd
[    2.113959] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
[    2.113980] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
[    2.267206] spurious 8259A interrupt: IRQ7.
[    2.276376] ata1.00: CFA: TS4GCF133, 20110407, max UDMA/66
[    2.276397] ata1.00: 7831152 sectors, multi 0: LBA 
[    2.276438] ata1.01: ATA-0: PQI IDE DiskOnModule, YUAN1026, max UDMA/33
[    2.276460] ata1.01: 1015056 sectors, multi 0: LBA 
[    2.283283] ata1.00: configured for UDMA/66
[    2.286273] ata1.01: configured for UDMA/33
[    2.297413] scsi 0:0:0:0: Direct-Access     ATA      TS4GCF133        2011 PQ: 0 ANSI: 5
[    2.299255] scsi 0:0:1:0: Direct-Access     ATA      PQI IDE DiskOnMo YUAN PQ: 0 ANSI: 5
[    2.301427] ata2: port disabled--ignoring
[    2.350975] sd 0:0:0:0: [sda] 7831152 512-byte logical blocks: (4.00 GB/3.73 GiB)
[    2.351297] sd 0:0:0:0: [sda] Write Protect is off
[    2.351319] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.351430] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    2.354674] sd 0:0:1:0: [sdb] 1015056 512-byte logical blocks: (519 MB/495 MiB)
[    2.354919] sd 0:0:1:0: [sdb] Write Protect is off
[    2.354940] sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
[    2.355347] sd 0:0:1:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    2.356127]  sda: sda1 sda2
[    2.359915]  sdb: unknown partition table
[    2.364252] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    2.364290] sd 0:0:1:0: [sdb] Attached SCSI disk
[    2.854524] EXT3-fs (sda1): mounted filesystem with ordered data mode
[    2.855667] kjournald starting.  Commit interval 5 seconds
[    3.651393] udev[161]: starting version 164
[    4.021770] AMD Geode RNG detected
[    4.055504] cs5535-mfd 0000:00:0f.0: 5 devices registered.
[    4.063278] PCI: setting IRQ 11 as level-triggered
[    4.063301] Geode LX AES 0000:00:01.2: found PCI INT A -> IRQ 11
[    4.064184] pci 0000:00:01.1: IRQ routing conflict: have IRQ 10, want IRQ 11
[    4.064240] Geode LX AES 0000:00:01.2: IRQ routing conflict: have IRQ 10, want IRQ 11
[    4.086509] via_rhine: v1.10-LK1.5.0 2010-10-09 Written by Donald Becker
[    4.106113] geode-aes: GEODE AES engine enabled.
[    4.106844] PCI: setting IRQ 10 as level-triggered
[    4.106866] via-rhine 0000:00:0d.0: found PCI INT A -> IRQ 10
[    4.107002] via-rhine 0000:00:0d.0: IRQ routing conflict: have IRQ 11, want IRQ 10
[    4.107192] via-rhine 0000:00:0d.0: setting latency timer to 64
[    4.184403] via-rhine 0000:00:0d.0: eth0: VIA Rhine III (Management Adapter) at 0xeffff000, 00:0d:b9:0e:0d:28, IRQ 11
[    4.199971] via-rhine 0000:00:0d.0: eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link cde1
[    4.464417] cs5535-mfgpt cs5535-mfgpt: reserved resource region [io  0x6200-0x623f]
[    4.464446] cs5535-mfgpt cs5535-mfgpt: 4 MFGPT timers available
[    4.592612] cs5535-gpio cs5535-gpio: reserved resource region [io  0x6100-0x61ff]
[    4.592761] cs5535-gpio cs5535-gpio: GPIO support successfully loaded.
[    4.630513] cs5535-smb cs5535-smb: SCx200 device 'CS5535 ACB0' registered
[    4.731332] usbcore: registered new interface driver usbfs
[    4.731454] usbcore: registered new interface driver hub
[    4.741190] usbcore: registered new device driver usb
[    4.775581] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.775826] ehci_hcd 0000:00:0f.5: found PCI INT D -> IRQ 5
[    4.785390] ehci_hcd 0000:00:0f.5: setting latency timer to 64
[    4.785462] ehci_hcd 0000:00:0f.5: EHCI Host Controller
[    4.785558] ehci_hcd 0000:00:0f.5: new USB bus registered, assigned bus number 1
[    4.814153] ehci_hcd 0000:00:0f.5: irq 5, io mem 0xefffe000
[    4.820074] ehci_hcd 0000:00:0f.5: USB 2.0 started, EHCI 1.00
[    4.820198] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    4.820220] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.820239] usb usb1: Product: EHCI Host Controller
[    4.820255] usb usb1: Manufacturer: Linux 3.2.17-rt28 ehci_hcd
[    4.820272] usb usb1: SerialNumber: 0000:00:0f.5
[    4.825364] hub 1-0:1.0: USB hub found
[    4.825394] hub 1-0:1.0: 4 ports detected
[    5.127110] usb 1-2: new high-speed USB device number 2 using ehci_hcd
[    5.241789] usb 1-2: New USB device found, idVendor=1a40, idProduct=0201
[    5.241812] usb 1-2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    5.241831] usb 1-2: Product: USB 2.0 Hub [MTT]
[    5.242719] hub 1-2:1.0: USB hub found
[    5.242905] hub 1-2:1.0: 7 ports detected
[    5.346116] usb 1-3: new high-speed USB device number 3 using ehci_hcd
[    5.465393] usb 1-3: New USB device found, idVendor=0951, idProduct=1643
[    5.465416] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    5.465434] usb 1-3: Product: DataTraveler G3
[    5.465450] usb 1-3: Manufacturer: Kingston
[    5.465466] usb 1-3: SerialNumber: 001CC0EC346CBC51171B0070
[    5.569072] usb 1-4: new high-speed USB device number 4 using ehci_hcd
[    5.683467] usb 1-4: config 1 has an invalid interface number: 3 but max is 2
[    5.683489] usb 1-4: config 1 has no interface number 2
[    5.683837] usb 1-4: config 1 has an invalid interface number: 3 but max is 2
[    5.683858] usb 1-4: config 1 has no interface number 2
[    5.684338] usb 1-4: New USB device found, idVendor=21b4, idProduct=0230
[    5.684360] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    5.684379] usb 1-4: Product: Ayre USB Interface
[    5.684395] usb 1-4: Manufacturer: Ayre Acoustics
[    5.684411] usb 1-4: SerialNumber: (C) 2010 XMOS/Wavelength Audio
[    5.796093] Initializing USB Mass Storage driver...
[    5.796584] scsi2 : usb-storage 1-3:1.0
[    5.798866] usbcore: registered new interface driver usb-storage
[    5.798882] USB Mass Storage support registered.
[    6.022209] usbcore: registered new interface driver snd-usb-audio
[    6.878244] scsi 2:0:0:0: Direct-Access     Kingston DataTraveler G3  PMAP PQ: 0 ANSI: 0 CCS
[    7.070956] EXT3-fs (sda1): using internal journal
[    7.256508] fuse init (API version 7.17)
[    8.436629] sd 2:0:0:0: [sdc] 61408128 512-byte logical blocks: (31.4 GB/29.2 GiB)
[    8.437229] sd 2:0:0:0: [sdc] Write Protect is off
[    8.437251] sd 2:0:0:0: [sdc] Mode Sense: 23 00 00 00
[    8.437860] sd 2:0:0:0: [sdc] No Caching mode page present
[    8.437878] sd 2:0:0:0: [sdc] Assuming drive cache: write through
[    8.443364] sd 2:0:0:0: [sdc] No Caching mode page present
[    8.443383] sd 2:0:0:0: [sdc] Assuming drive cache: write through
[    8.464206]  sdc: sdc1
[    8.470498] sd 2:0:0:0: [sdc] No Caching mode page present
[    8.470517] sd 2:0:0:0: [sdc] Assuming drive cache: write through
[    8.470538] sd 2:0:0:0: [sdc] Attached SCSI removable disk
[    8.535321] w83627hf: w83627hf: Found W83627HF chip at 0x290
[    8.583768] ppdev: user-space parallel port driver
[    8.611663] parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
[    8.612355] parport0: irq 7 detected
[    9.621503] EXT3-fs (sdb): warning: maximal mount count reached, running e2fsck is recommended
[    9.621645] kjournald starting.  Commit interval 5 seconds
[    9.635548] EXT3-fs (sdb): using internal journal
[    9.635571] EXT3-fs (sdb): mounted filesystem with ordered data mode
[    9.643714] EXT3-fs (sda2): mounted filesystem with ordered data mode
[    9.646086] kjournald starting.  Commit interval 5 seconds
[   11.183985] via-rhine 0000:00:0d.0: eth0: link up, 100Mbps, full-duplex, lpa 0xCDE1
[   11.805579] FAT-fs (sdc1): utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
[   22.082042] eth0: no IPv6 routers present
[  123.396170] hub 1-0:1.0: port 4 disabled by hub (EMI?), re-enabling...
[  123.396194] usb 1-4: USB disconnect, device number 4
[  123.661067] usb 1-4: new high-speed USB device number 5 using ehci_hcd
[  123.775498] usb 1-4: config 1 has an invalid interface number: 3 but max is 2
[  123.775520] usb 1-4: config 1 has no interface number 2
[  123.775865] usb 1-4: config 1 has an invalid interface number: 3 but max is 2
[  123.775886] usb 1-4: config 1 has no interface number 2
[  123.776366] usb 1-4: New USB device found, idVendor=21b4, idProduct=0230
[  123.776387] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  123.776406] usb 1-4: Product: Ayre USB Interface
[  123.776422] usb 1-4: Manufacturer: Ayre Acoustics
[  123.776439] usb 1-4: SerialNumber: (C) 2010 XMOS/Wavelength Audio
[  293.957030] sched: RT throttling activated
[  349.789200] hub 1-0:1.0: port 4 disabled by hub (EMI?), re-enabling...
[  349.789224] usb 1-4: USB disconnect, device number 5
[  350.056082] usb 1-4: new high-speed USB device number 6 using ehci_hcd
[  350.170478] usb 1-4: config 1 has an invalid interface number: 3 but max is 2
[  350.170500] usb 1-4: config 1 has no interface number 2
[  350.170843] usb 1-4: config 1 has an invalid interface number: 3 but max is 2
[  350.170864] usb 1-4: config 1 has no interface number 2
[  350.171344] usb 1-4: New USB device found, idVendor=21b4, idProduct=0230
[  350.171366] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  350.171385] usb 1-4: Product: Ayre USB Interface
[  350.171401] usb 1-4: Manufacturer: Ayre Acoustics
[  350.171418] usb 1-4: SerialNumber: (C) 2010 XMOS/Wavelength Audio

--------------090501050608070400070500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090501050608070400070500--
