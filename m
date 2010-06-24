From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [RFC 0/5] ASoC multi-component support : core
Date: Fri, 25 Jun 2010 11:38:13 +1200
Message-ID: <4C23EC65.9080601@bluewatersys.com>
References: <1277407467.3100.579.camel@odin>
	<4C23CFC0.6080700@bluewatersys.com>
	(sfid-20100624_223607_408551_609C17DE)
	<661928F7-0509-4E84-A296-0949E2D76EE3@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 17E2E24484
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 01:38:10 +0200 (CEST)
In-Reply-To: <661928F7-0509-4E84-A296-0949E2D76EE3@opensource.wolfsonmicro.com>
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
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Wan ZongShun <mcuos.com@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, jassisinghbrar <jassisinghbrar@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Cliff Cai <cliff.cai@analog.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "timur.tabi@gmail.com" <timur.tabi@gmail.com>, "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, "vaibhav.bedia" <vaibhav.bedia@ti.com>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 06/25/2010 11:12 AM, Mark Brown wrote:
> On 24 Jun 2010, at 22:36, Ryan Mallon wrote:
>
>   =

>> The following patch fixes the build errors and warnings for the
>> ep93xx/Snapper CL15. However, I still get 'No soundcards found' during
>>     =

> Please provide a proper changelog for patches.
>
>   =

Sorry, changelog should be: "Fix build errors and warnings for
ep93xx/snapper cl15 asoc multi-component support"
>> boot. The ep3xx-pcm-audio, ep93xx-i2s and soc-audio devices are all
>> present under /sys/bus/platform/devices. Any ideas?
>>     =

>
> Do you actually see sound cards appearing? The log message at boot
> is purely informational, cards can probe at any time.
>
> Define DEBUG at the top of soc-audio.c if the card never appears at all
> then look at the log messages - they will say why the card is not being
> instantiated.
>   =

Hmm. If I define DEBUG at the top of sound/soc/soc-core.c I get this
(boots fine without DEBUG, but have no sound cards):
---

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.35-rc1-00115-g0682e62-dirty (ryan@okiwi) (gcc version 4.4=
.1 (Sourcery G++ Lite 2009q3-67) ) #713 Fri Jun 25 11:34:15 NZST 2010
CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=3Dc0007177
CPU: VIVT data cache, VIVT instruction cache
Machine: Bluewater Systems Snapper CL15
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 15952
Kernel command line: console=3DttyAM0,115200 lcd=3Dsony baseboard=3DRig200 =
snapper_baseboard=3DRig200 baseboard_rev=3D ethaddr=3D00:50:C2:41:A5:41 ip=
=3Dany nfsroot=3D/export/root,v3,rsize=3D1024,wsize=3D1024
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 8MB 8MB 8MB 8MB 8MB 8MB 8MB 8MB =3D 64MB total
Memory: 61332k/61332k available, 4204k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xce000000 - 0xfe800000   ( 776 MB)
    lowmem  : 0xc0000000 - 0xcd800000   ( 216 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc0020000   (  96 kB)
      .text : 0xc0020000 - 0xc0341000   (3204 kB)
      .data : 0xc035a000 - 0xc0378480   ( 122 kB)
Hierarchical RCU implementation.
	RCU-based detection of stalled CPUs is disabled.
	Verbose stalled-CPUs detection is disabled.
NR_IRQS:120
VIC @fefb0000: id 0x00041190, vendor 0x41
VIC @fefc0000: id 0x00041190, vendor 0x41
Calibrating delay loop... 99.73 BogoMIPS (lpj=3D498688)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
ep93xx clock: PLL1 running at 199 MHz, PLL2 at 192 MHz
ep93xx clock: FCLK 199 MHz, HCLK 99 MHz, PCLK 49 MHz
ep93xx dma_m2p: M2P DMA subsystem initialized
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c-gpio i2c-gpio.0: using pins 49 (SDA) and 48 (SCL)
Advanced Linux Sound Architecture Driver Version 1.0.23.
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 3, 40960 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
UDP hash table entries: 128 (order: 0, 6144 bytes)
UDP-Lite hash table entries: 128 (order: 0, 6144 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NetWinder Floating Point Emulator V0.97 (extended precision)
JFFS2 version 2.2. (NAND) =A9 2001-2006 Red Hat, Inc.
msgmni has been set to 119
io scheduler noop registered
io scheduler deadline registered (default)
Serial: AMBA driver
apb:uart1: ttyAM0 at MMIO 0x808c0000 (irq =3D 52) is a AMBA
console [ttyAM0] enabled
apb:uart2: ttyAM1 at MMIO 0x808d0000 (irq =3D 54) is a AMBA
apb:uart3: ttyAM2 at MMIO 0x808e0000 (irq =3D 55) is a AMBA
nbd: registered device at major 43
ep93xx-eth version 0.1 loading
eth0: ep93xx on-chip ethernet, IRQ 39, 00:50:c2:41:a5:41
rtl8150: v0.6.2 (2004/08/27):rtl8150 based usb-ethernet driver
usbcore: registered new interface driver rtl8150
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ep93xx-ohci ep93xx-ohci: EP93xx OHCI
ep93xx-ohci ep93xx-ohci: new USB bus registered, assigned bus number 1
ep93xx-ohci ep93xx-ohci: irq 56, io mem 0x80020000
usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0001
usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: EP93xx OHCI
usb usb1: Manufacturer: Linux 2.6.35-rc1-00115-g0682e62-dirty ohci_hcd
usb usb1: SerialNumber: ep93xx
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbserial
usbserial: USB Serial Driver core
USB Serial support registered for pl2303
usbcore: registered new interface driver pl2303
pl2303: Prolific PL2303 USB to serial adaptor driver
ep93xx-rtc ep93xx-rtc: rtc core: registered ep93xx-rtc as rtc0
i2c /dev entries driver
ep93xx_wdt: EP93XX watchdog, driver version 0.3
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd =3D c0004000
[00000000] *pgd=3D00000000
Internal error: Oops: 5 [#1]
last sysfs file: =

Modules linked in:
CPU: 0    Not tainted  (2.6.35-rc1-00115-g0682e62-dirty #713)
PC is at snd_soc_instantiate_cards+0x210/0x9b8
LR is at snd_soc_instantiate_cards+0x1f4/0x9b8
pc : [<c01d1a5c>]    lr : [<c01d1a40>]    psr: 60000013
sp : cd41be58  ip : 22222222  fp : cd54c328
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : cd555de0  r6 : 00000002  r5 : c0371164  r4 : c03710c8
r3 : 00000000  r2 : cd554740  r1 : c031de15  r0 : c031d7ee
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: c000717f  Table: c0004000  DAC: 00000017
Process swapper (pid: 1, stack limit =3D 0xcd41a270)
Stack: (0xcd41be58 to 0xcd41c000)
be40:                                                       c03674b0 000000=
00
be60: 00000000 cd405b24 c03710e0 c03674c0 cd41bec4 c01440a8 000000a5 cd40de=
60
be80: 00000000 c008a288 cd4080a0 000080d0 cd4080a0 000080d0 c03674a0 cd562b=
18
bea0: c0367478 c028981c cd400440 cd555dc0 c01d226c c0089edc 000000a5 cd4004=
40
bec0: cd41bed0 c0370afc c0370afc c0289a84 22222222 22222222 22222222 c03710=
c8
bee0: c0370a60 c03710d8 c0370a74 00000000 00000000 00000000 00000000 c01d23=
08
bf00: cd54c328 cd54c328 00000000 c0168d08 c0168cf0 c0167e48 c0168e8c cd54c3=
28
bf20: c0167f7c 00000000 00000000 c016743c cd429f28 cd563964 cd54c35c cd54c3=
28
bf40: c036a940 c0168030 00000001 cd54c328 cd54c330 c0167274 cd54c328 c0165f=
18
bf60: cd54c330 00000000 00000000 00000000 00000000 c0145050 cd54c320 cd54c3=
20
bf80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 c01691=
b8
bfa0: ffffffff c0385aa4 00000000 00000000 00000000 c0015558 c0378520 c00155=
0c
bfc0: 00000000 c002038c c001550c c02f8205 c0378520 c001c0e0 c001c078 000000=
00
bfe0: 00000000 00000000 00000000 c0008570 00000000 c0021e94 114c33c4 338c33=
cc
[<c01d1a5c>] (snd_soc_instantiate_cards+0x210/0x9b8) from [<c01d2308>] (soc=
_probe+0x104/0x180)
[<c01d2308>] (soc_probe+0x104/0x180) from [<c0168d08>] (platform_drv_probe+=
0x18/0x1c)
[<c0168d08>] (platform_drv_probe+0x18/0x1c) from [<c0167e48>] (driver_probe=
_device+0xb0/0x168)
[<c0167e48>] (driver_probe_device+0xb0/0x168) from [<c016743c>] (bus_for_ea=
ch_drv+0x48/0x84)
[<c016743c>] (bus_for_each_drv+0x48/0x84) from [<c0168030>] (device_attach+=
0x50/0x68)
[<c0168030>] (device_attach+0x50/0x68) from [<c0167274>] (bus_probe_device+=
0x24/0x40)
[<c0167274>] (bus_probe_device+0x24/0x40) from [<c0165f18>] (device_add+0x3=
c8/0x50c)
[<c0165f18>] (device_add+0x3c8/0x50c) from [<c01691b8>] (platform_device_ad=
d+0x104/0x15c)
[<c01691b8>] (platform_device_add+0x104/0x15c) from [<c0015558>] (snappercl=
15_init+0x4c/0x70)
[<c0015558>] (snappercl15_init+0x4c/0x70) from [<c002038c>] (do_one_initcal=
l+0x5c/0x1b8)
[<c002038c>] (do_one_initcall+0x5c/0x1b8) from [<c0008570>] (kernel_init+0x=
94/0x140)
[<c0008570>] (kernel_init+0x94/0x140) from [<c0021e94>] (kernel_thread_exit=
+0x0/0x8)
Code: e59f0754 e3520000 05932008 e5953024 (e5933000) =

---[ end trace 6c9baca808808ee5 ]---
Kernel panic - not syncing: Attempted to kill init!
[<c0026474>] (unwind_backtrace+0x0/0xec) from [<c028895c>] (panic+0x54/0xdc)
[<c028895c>] (panic+0x54/0xdc) from [<c003fe30>] (do_exit+0x64/0x580)
[<c003fe30>] (do_exit+0x64/0x580) from [<c0024858>] (die+0x190/0x1c0)
[<c0024858>] (die+0x190/0x1c0) from [<c00274ac>] (__do_kernel_fault+0x64/0x=
84)
[<c00274ac>] (__do_kernel_fault+0x64/0x84) from [<c002767c>] (do_page_fault=
+0x1b0/0x1c4)
[<c002767c>] (do_page_fault+0x1b0/0x1c4) from [<c00202d0>] (do_DataAbort+0x=
34/0x94)
[<c00202d0>] (do_DataAbort+0x34/0x94) from [<c0020a00>] (__dabt_svc+0x40/0x=
60)
Exception stack(0xcd41be10 to 0xcd41be58)
be00:                                     c031d7ee c031de15 cd554740 000000=
00
be20: c03710c8 c0371164 00000002 cd555de0 00000000 00000000 00000000 cd54c3=
28
be40: 22222222 cd41be58 c01d1a40 c01d1a5c 60000013 ffffffff
[<c0020a00>] (__dabt_svc+0x40/0x60) from [<c01d1a5c>] (snd_soc_instantiate_=
cards+0x210/0x9b8)
[<c01d1a5c>] (snd_soc_instantiate_cards+0x210/0x9b8) from [<c01d2308>] (soc=
_probe+0x104/0x180)
[<c01d2308>] (soc_probe+0x104/0x180) from [<c0168d08>] (platform_drv_probe+=
0x18/0x1c)
[<c0168d08>] (platform_drv_probe+0x18/0x1c) from [<c0167e48>] (driver_probe=
_device+0xb0/0x168)
[<c0167e48>] (driver_probe_device+0xb0/0x168) from [<c016743c>] (bus_for_ea=
ch_drv+0x48/0x84)
[<c016743c>] (bus_for_each_drv+0x48/0x84) from [<c0168030>] (device_attach+=
0x50/0x68)
[<c0168030>] (device_attach+0x50/0x68) from [<c0167274>] (bus_probe_device+=
0x24/0x40)
[<c0167274>] (bus_probe_device+0x24/0x40) from [<c0165f18>] (device_add+0x3=
c8/0x50c)
[<c0165f18>] (device_add+0x3c8/0x50c) from [<c01691b8>] (platform_device_ad=
d+0x104/0x15c)
[<c01691b8>] (platform_device_add+0x104/0x15c) from [<c0015558>] (snappercl=
15_init+0x4c/0x70)
[<c0015558>] (snappercl15_init+0x4c/0x70) from [<c002038c>] (do_one_initcal=
l+0x5c/0x1b8)
[<c002038c>] (do_one_initcall+0x5c/0x1b8) from [<c0008570>] (kernel_init+0x=
94/0x140)
[<c0008570>] (kernel_init+0x94/0x140) from [<c0021e94>] (kernel_thread_exit=
+0x0/0x8)
