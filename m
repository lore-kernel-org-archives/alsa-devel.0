From: =?iso-8859-1?B?QXNiavhybiBT5mL4?= <asbjs@stud.ntnu.no>
Subject: Re: Re: [PATCH 2.6.17-rc2] ALSA: PCMCIA sound devices shouldn't depend on ISA
Date: Wed, 24 May 2006 16:58:00 +0200
Message-ID: <20060524145800.GA2621@stud.ntnu.no>
References: <20060419144008.GD24807@harddisk-recovery.com> <1148357665.12529.17.camel@mindpipe> <s5hbqtoyj5w.wl%tiwai@suse.de> <1148401671.12529.59.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from signal.itea.ntnu.no (signal.itea.ntnu.no [129.241.190.231])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6E736162
	for <alsa-devel@alsa-project.org>; Wed, 24 May 2006 16:57:45 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <1148401671.12529.59.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, Erik Mouw <erik@harddisk-recovery.com>, alsa-devel@alsa-project.org, =?iso-8859-1?B?QXNiavhybiBT5mL4?= <asbjs@q2s.ntnu.no>, Linux PCMCIA development <linux-pcmcia@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 23, 2006 at 12:27:50PM -0400, Lee Revell wrote:
> On Tue, 2006-05-23 at 15:17 +0200, Takashi Iwai wrote:
> > At Tue, 23 May 2006 00:14:24 -0400,
> > Lee Revell wrote:
> > >=20
> > > On Wed, 2006-04-19 at 16:40 +0200, Erik Mouw wrote:
> > > > The ALSA drivers for PCMCIA devices depend on ISA, but modern
> > > > laptops can have PCMCIA support without ISA. This patch removes
> > > > the dependency.
> > > >=20
> > >=20
> > > I am pretty sure I found a case where the VXPocket driver failed
> > > silently if CONFIG_ISAPNP is not set.  According to Takashi-san it =
is a
> > > PCMCIA bug not an ALSA bug.  It was a P4 laptop several years old. =
 I
> > > don't have access to it right now but can get it.
> > >=20
> > > What additional information do you need to debug it?
> >=20
> > The combination of actually used drivers (PCMCIA bridge, etc)?
> >=20
>=20
> Asbj=F8rn, please provide lsmod and dmesg output.

Here you are, lsmod, dmesg and lspci (for good measure)

Note that the vxpocket must be hotplugged to be recognised. =20
Cold-plugging it (having it already in the computer when booting) is not=20
sufficient.

Asbj=F8rn


lsmod
-----
Module                  Size  Used by
radeon                108576  1=20
drm                    70292  2 radeon
parport_pc             27372  1=20
lp                     11712  0=20
parport                37448  2 parport_pc,lp
thermal                13192  0=20
fan                     4740  0=20
button                  6544  0=20
processor              21824  1 thermal
ac                      4868  0=20
battery                 9476  0=20
ipv6                  255296  10=20
af_packet              21896  2=20
snd_seq_dummy           3844  0=20
snd_seq_oss            34532  0=20
snd_seq_midi            8608  0=20
snd_rawmidi            24864  1 snd_seq_midi
snd_seq_midi_event      7296  2 snd_seq_oss,snd_seq_midi
snd_seq                50380  6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,sn=
d_seq_midi_event
snd_seq_device          8332  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi,sn=
d_rawmidi,snd_seq
snd_vxpocket           15072  1=20
snd_vx_lib             32512  1 snd_vxpocket
joydev                  9920  0=20
mousedev               11584  1=20
tsdev                   7872  0=20
evdev                   9728  0=20
snd_intel8x0           32668  1=20
snd_ac97_codec         93216  1 snd_intel8x0
snd_ac97_bus            2304  1 snd_ac97_codec
snd_pcm_oss            40608  0=20
snd_mixer_oss          18048  2 snd_pcm_oss
snd_pcm                85000  4 snd_vx_lib,snd_intel8x0,snd_ac97_codec,sn=
d_pcm_oss
snd_timer              23556  2 snd_seq,snd_pcm
snd                    53120  13 snd_seq_dummy,snd_seq_oss,snd_rawmidi,sn=
d_seq,snd_seq_device,snd_vxpocket,snd_vx_lib,snd_intel8x0,snd_ac97_codec,=
snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               9952  2 snd
psmouse                38920  0=20
snd_page_alloc         10248  2 snd_intel8x0,snd_pcm
ohci1394               34608  0=20
ieee1394               96696  1 ohci1394
ohci_hcd               20484  0=20
serio_raw               7172  0=20
ehci_hcd               29832  0=20
sk98lin               165856  0=20
usbcore               125856  3 ohci_hcd,ehci_hcd
sis_agp                 8836  1=20
agpgart                32304  2 drm,sis_agp
unix                   28336  364=20


dmesg:
------
Linux version 2.6.16.11-vanilla (root@dhcp91) (gcc version 4.0.3 (Debian =
4.0.3-1)) #1 PREEMPT Sat Apr 29 10:13:31 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fffa000 (usable)
 BIOS-e820: 000000003fffa000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6410
ACPI: RSDT (v001 ASUS   L5C      0x42302e31 MSFT 0x31313031) @ 0x3fffa000
ACPI: FADT (v001 ASUS   L5C      0x42302e31 MSFT 0x31313031) @ 0x3fffa0b6
ACPI: BOOT (v001 ASUS   L5C      0x42302e31 MSFT 0x31313031) @ 0x3fffa030
ACPI: MADT (v001 ASUS   L5C      0x42302e31 MSFT 0x31313031) @ 0x3fffa058
ACPI: DSDT (v001   ASUS L5C      0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 128, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Built 1 zonelists
Kernel command line: root=3D/dev/hdc1 ro=20
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2800.647 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 906328k/917504k available (1756k kernel code, 10748k reserved, 57=
4k data, 168k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... =
Ok.
Calibrating delay using timer specific routine.. 5605.84 BogoMIPS (lpj=3D=
2802924)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00=
004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 000=
04400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 =
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf1670, last bus=3D1
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 *11 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 *11 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 11 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Uncovering SIS963 that hid as a SIS503 (compatible=3D1)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [FN0] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a=
 report
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: e7800000-e7ffffff
  PREFETCH window: eff00000-febfffff
PCI: Bus 2, cardbus bridge: 0000:00:0a.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 50000000-51ffffff
  MEM window: 52000000-53ffffff
PCI: Bus 6, cardbus bridge: 0000:00:0a.1
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 54000000-55ffffff
  MEM window: 56000000-57ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:0a.1[B] -> GSI 17 (level, low) -> IRQ 177
Simple Boot Flag at 0x3a set to 0x1
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: No PS/2 controller found. Probing ports directly.
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
ACPI: PCI Interrupt 0000:00:02.6[C] -> GSI 18 (level, low) -> IRQ 185
ACPI: PCI interrupt for device 0000:00:02.6 disabled
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA DVD-ROM SD-R6112, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: IC25N080ATMR04-0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 512KiB
hdc: 156301488 sectors (80026 MB) w/7884KiB Cache, CHS=3D16383/255/63, UD=
MA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 hdc8 >
hda: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 16 (level, low) -> IRQ 169
Yenta: CardBus bridge found at 0000:00:0a.0 [1043:1734]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0a.0, mfunc 0x01000222, devctl 0x44
Yenta: ISA IRQ mask 0x04b0, PCI irq 169
Socket status: 30000006
ACPI: PCI Interrupt 0000:00:0a.1[B] -> GSI 17 (level, low) -> IRQ 177
Yenta: CardBus bridge found at 0000:00:0a.1 [1043:1734]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0a.1, mfunc 0x01000222, devctl 0x44
Yenta: ISA IRQ mask 0x0810, PCI irq 177
Socket status: 30000010
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
Using IPI Shortcut mode
ACPI wakeup devices:=20
PCI1 USB0 USB1 USB2 USB3 MC97  LAN MPCI=20
ACPI: (supports S0 S1 S3 S4 S5)
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 168k freed
kjournald starting.  Commit interval 5 seconds
input: AT Translated Set 2 keyboard as /class/input/input0
pccard: PCMCIA card inserted into slot 1
NET: Registered protocol family 1
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected SiS 648 chipset
agpgart: AGP aperture is 64M @ 0xe8000000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 185
eth0: 3Com Gigabit LOM (3C940)
      PrefPort:A  RlmtMode:Check Link State
ACPI: PCI Interrupt 0000:00:03.3[D] -> GSI 23 (level, low) -> IRQ 193
ehci_hcd 0000:00:03.3: EHCI Host Controller
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:03.3: irq 193, io mem 0xe5000000
ehci_hcd 0000:00:03.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
cs: IO port probe 0x100-0x3af: excluding 0x378-0x37f
cs: IO port probe 0x3e0-0x4ff: excluding 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: excluding 0x880-0x887
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI=
)
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 201
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:03.0: irq 201, io mem 0xe6800000
ieee1394: Initialized config rom entry `ip1394'
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 209
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:03.1: irq 209, io mem 0xe6000000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:03.2[C] -> GSI 22 (level, low) -> IRQ 217
ohci_hcd 0000:00:03.2: OHCI Host Controller
ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:03.2: irq 217, io mem 0xe5800000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:02.3[B] -> GSI 17 (level, low) -> IRQ 177
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=3D[177]  MMIO=3D[e7000000-e7=
0007ff]  Max Packet=3D[2048]  IR/IT contexts=3D[4/6]
ACPI: PCI Interrupt 0000:00:02.7[C] -> GSI 18 (level, low) -> IRQ 185
cs: IO port probe 0x100-0x3af: excluding 0x378-0x37f
cs: IO port probe 0x3e0-0x4ff: excluding 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: excluding 0x880-0x887
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
pcmcia: registering new device pcmcia1.0
Synaptics Touchpad, model: 1, fw: 4.6, id: 0x925ea1, caps: 0x80471b/0x0
input: SynPS/2 Synaptics TouchPad as /class/input/input1
intel8x0_measure_ac97_clock: measured 50419 usecs
intel8x0: clocking to 48000
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000311cfba]
ts: Compaq touchscreen protocol output
mice: PS/2 mouse device common for all mice
ALSA /home/asbjorn/alsa/alsa_1.0.11/alsa-driver-1.0.11/drivers/vx/../../a=
lsa-kernel/drivers/vx/vx_hwdep.c:62: vx: can't load firmware vx/bx_1_vxp.=
b56
Adding 1951884k swap on /dev/hdc2.  Priority:-1 extents:1 across:1951884k
EXT3 FS on hdc1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ds: ds_open(socket 0)
pcmcia: Detected deprecated PCMCIA ioctl usage.
pcmcia: This interface will soon be removed from the kernel; please expec=
t breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.ht=
ml for details.
ds: ds_open(socket 1)
ds: ds_open(socket 2)
ds: ds_release(socket 0)
ds: ds_release(socket 1)
NET: Registered protocol family 17
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        none
    irq moderation:  disabled
    scatter-gather:  disabled
    tx-checksum:     disabled
    rx-checksum:     disabled
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
ACPI: Battery Slot [BAT0] (battery present)
ACPI: AC Adapter [AC] (on-line)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (on)
ACPI: Thermal Zone [THRM] (28 C)
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
[drm] Initialized radeon 1.22.0 20051229 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: SiS delay workaround: giving bridge time to recover.
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
APIC error on CPU0: 00(40)
pccard: card ejected from slot 1
pccard: PCMCIA card inserted into slot 1
pcmcia: registering new device pcmcia1.0



lspci:
------
0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 645xx (rev 03)
0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-=
PCI bridge (AGP)
0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS963 [MuTIOL =
Media IO] (rev 14)
0000:00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireW=
ire Controller
0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
0000:00:02.6 Modem: Silicon Integrated Systems [SiS] AC'97 Modem Controll=
er (rev a0)
0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS=
] Sound Controller (rev a0)
0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Con=
troller (rev 0f)
0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Con=
troller (rev 0f)
0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Con=
troller (rev 0f)
0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Con=
troller
0000:00:0a.0 CardBus bridge: ENE Technology Inc CB-720/2/4 Cardbus Contro=
ller (rev 01)
0000:00:0a.1 CardBus bridge: ENE Technology Inc CB-720/2/4 Cardbus Contro=
ller (rev 01)
0000:00:0a.2 FLASH memory: ENE Technology Inc CB710 Memory Card Reader Co=
ntroller
0000:00:0c.0 Network controller: Broadcom Corporation BCM4303 802.11b Wir=
eless LAN Controller (rev 02)
0000:00:0d.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-=
T [Marvell] (rev 12)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 =
Lf [FireGL 9000] (rev 01)


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
