From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001850]: source available
Date: Mon, 27 Mar 2006 05:16:44 +0200
Message-ID: <63caa2395239be15f2458ec0f4094865@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 95C041E6
	for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2006 05:16:44 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1850> 
======================================================================
Reported By:                coz
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1850
Category:                   PCI - echoaudio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               ubuntu/breezy/Debian
Kernel Version:             2.6.12.10.386
======================================================================
Date Submitted:             02-16-2006 13:05 CET
Last Modified:              03-27-2006 05:16 CEST
======================================================================
Summary:                    source available
Description: 
can't start layla24
======================================================================

----------------------------------------------------------------------
 coz - 03-27-06 05:04 
----------------------------------------------------------------------
Ok I installed the drive, the li, and the firmware, I got an error that
said to look in dmesg. The foloowing is the result;;

[4294667.296000] Linux version 2.6.15-19-386 (buildd@rothera) (gcc version
4.0.3 (Ubuntu 4.0.3-1ubuntu3)) #1 PREEMPT Mon Mar 20 16:46:02 UTC 2006
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[4294667.296000]  BIOS-e820: 000000000009fc00 - 00000000000a0000
(reserved)
[4294667.296000]  BIOS-e820: 00000000000e0000 - 0000000000100000
(reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000003ffc0000 (usable)
[4294667.296000]  BIOS-e820: 000000003ffc0000 - 000000003fff8000 (ACPI
data)
[4294667.296000]  BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI
NVS)
[4294667.296000]  BIOS-e820: 00000000fec00000 - 00000000fec01000
(reserved)
[4294667.296000]  BIOS-e820: 00000000fee00000 - 00000000fee01000
(reserved)
[4294667.296000]  BIOS-e820: 00000000ffb80000 - 00000000ffc00000
(reserved)
[4294667.296000]  BIOS-e820: 00000000fff00000 - 0000000100000000
(reserved)
[4294667.296000] 127MB HIGHMEM available.
[4294667.296000] 896MB LOWMEM available.
[4294667.296000] On node 0 totalpages: 262080
[4294667.296000]   DMA zone: 4096 pages, LIFO batch:0
[4294667.296000]   DMA32 zone: 0 pages, LIFO batch:0
[4294667.296000]   Normal zone: 225280 pages, LIFO batch:31
[4294667.296000]   HighMem zone: 32704 pages, LIFO batch:7
[4294667.296000] DMI 2.3 present.
[4294667.296000] ACPI: RSDP (v000 AMI                                   )
@ 0x000ff980
[4294667.296000] ACPI: RSDT (v001 D850GB G285010A 0x20011008 MSFT
0x00001011) @ 0x3fff0000
[4294667.296000] ACPI: FADT (v001 D850GB GB85010A 0x20011008 MSFT
0x00001011) @ 0x3fff1000
[4294667.296000] ACPI: MADT (v001 D850GB GB85010A 0x20011008 MSFT
0x00001011) @ 0x3ffe2e67
[4294667.296000] ACPI: DSDT (v001 D850GB GB85010A 0x00000002 MSFT
0x0100000b) @ 0x00000000
[4294667.296000] ACPI: PM-Timer IO Port: 0x408
[4294667.296000] ACPI: Local APIC address 0xfee00000
[4294667.296000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[4294667.296000] Processor #0 15:0 APIC version 20
[4294667.296000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
[4294667.296000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[4294667.296000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[4294667.296000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[4294667.296000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI
0-23
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high
level)
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[4294667.296000] ACPI: IRQ0 used by override.
[4294667.296000] ACPI: IRQ2 used by override.
[4294667.296000] ACPI: IRQ9 used by override.
[4294667.296000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[4294667.296000] Using ACPI (MADT) for SMP configuration information
[4294667.296000] Allocating PCI resources starting at 50000000 (gap:
40000000:bec00000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: root=/dev/sda1 ro quiet splash
[4294667.296000] mapped APIC to ffffd000 (fee00000)
[4294667.296000] mapped IOAPIC to ffffc000 (fec00000)
[4294667.296000] Initializing CPU#0
[4294667.296000] PID hash table entries: 4096 (order: 12, 65536 bytes)
[4294667.296000] Detected 1695.345 MHz processor.
[4294667.296000] Using pmtmr for high-res timesource
[4294667.296000] Console: colour VGA+ 80x25
[4294669.071000] Dentry cache hash table entries: 131072 (order: 7, 524288
bytes)
[4294669.072000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes)
[4294669.117000] Memory: 1028900k/1048320k available (1971k kernel code,
18700k reserved, 599k data, 288k init, 130816k highmem)
[4294669.117000] Checking if this processor honours the WP bit even in
supervisor mode... Ok.
[4294669.177000] Calibrating delay using timer specific routine.. 3399.13
BogoMIPS (lpj=1699566)
[4294669.177000] Security Framework v1.0.0 initialized
[4294669.177000] SELinux:  Disabled at boot.
[4294669.177000] Mount-cache hash table entries: 512
[4294669.177000] CPU: After generic identify, caps: 3febfbff 00000000
00000000 00000000 00000000 00000000 00000000
[4294669.177000] CPU: After vendor identify, caps: 3febfbff 00000000
00000000 00000000 00000000 00000000 00000000
[4294669.177000] CPU: Trace cache: 12K uops, L1 D cache: 8K
[4294669.177000] CPU: L2 cache: 256K
[4294669.177000] CPU: After all inits, caps: 3febfbff 00000000 00000000
00000080 00000000 00000000 00000000
[4294669.177000] mtrr: v2.0 (20020519)
[4294669.177000] CPU: Intel(R) Pentium(R) 4 CPU 1700MHz stepping 0a
[4294669.177000] Enabling fast FPU save and restore... done.
[4294669.177000] Enabling unmasked SIMD FPU exception support... done.
[4294669.177000] Checking 'hlt' instruction... OK.
[4294669.181000] checking if image is initramfs... it is
[4294670.011000] Freeing initrd memory: 6376k freed
[4294670.021000] ACPI: Looking for DSDT ... not found!
[4294670.025000] ENABLING IO-APIC IRQs
[4294670.025000] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[4294670.136000] NET: Registered protocol family 16
[4294670.136000] EISA bus registered
[4294670.136000] ACPI: bus type pci registered
[4294670.136000] PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=2
[4294670.136000] PCI: Using configuration type 1
[4294670.137000] ACPI: Subsystem revision 20051216
[4294670.143000] ACPI: Interpreter enabled
[4294670.143000] ACPI: Using IOAPIC for interrupt routing
[4294670.144000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[4294670.144000] PCI: Probing PCI hardware (bus 00)
[4294670.146000] PCI quirk: region 0400-047f claimed by ICH4
ACPI/GPIO/TCO
[4294670.146000] PCI quirk: region 0500-053f claimed by ICH4 GPIO
[4294670.146000] Boot video device is 0000:01:00.0
[4294670.147000] PCI: Transparent bridge - 0000:00:1e.0
[4294670.147000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[4294670.149000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
[4294670.150000] ACPI: Power Resource [FDDP] (off)
[4294670.150000] ACPI: Power Resource [URP1] (off)
[4294670.151000] ACPI: Power Resource [URP2] (off)
[4294670.151000] ACPI: Power Resource [LPTP] (off)
[4294670.152000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11
12 14 15)
[4294670.153000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11
12 14 15)
[4294670.153000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11
12 14 15) *0, disabled.
[4294670.153000] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 9 10 11
12 14 15)
[4294670.154000] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11
12 14 15) *0, disabled.
[4294670.154000] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 *7 9 10 11
12 14 15)
[4294670.154000] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11
12 14 15)
[4294670.155000] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11
12 14 15)
[4294670.155000] Linux Plug and Play Support v0.97 (c) Adam Belay
[4294670.155000] pnp: PnP ACPI init
[4294670.155000] pnp: PnPACPI: unknown resource type 7
[4294670.155000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0200
[4294670.155000] pnp: PnPACPI: unknown resource type 7
[4294670.155000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0b00
[4294670.155000] pnp: PnPACPI: unknown resource type 7
[4294670.155000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0800
[4294670.155000] pnp: PnPACPI: unknown resource type 7
[4294670.155000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c04
[4294670.155000] pnp: PnPACPI: unknown resource type 7
[4294670.155000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0f03
[4294670.155000] pnp: PnPACPI: unknown resource type 7
[4294670.155000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0303
[4294670.156000] pnp: PnPACPI: unknown resource type 7
[4294670.156000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0700
[4294670.156000] pnp: PnPACPI: unknown resource type 7
[4294670.156000] pnp: PnPACPI: METHOD_NAME__CRS failure for INT0800
[4294670.157000] pnp: PnPACPI: unknown resource type 7
[4294670.157000] pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c01
[4294670.157000] pnp: PnP ACPI: found 0 devices
[4294670.157000] PnPBIOS: Disabled by ACPI PNP
[4294670.157000] PCI: Using ACPI for IRQ routing
[4294670.157000] PCI: If a device doesn't work, try "pci=routeirq".  If it
helps, post a report
[4294670.165000] PCI: Bridge: 0000:00:01.0
[4294670.165000]   IO window: disabled.
[4294670.165000]   MEM window: fc700000-fe7fffff
[4294670.165000]   PREFETCH window: bc400000-dc4fffff
[4294670.165000] PCI: Bridge: 0000:00:1e.0
[4294670.165000]   IO window: d000-dfff
[4294670.165000]   MEM window: fe800000-feafffff
[4294670.165000]   PREFETCH window: dc500000-dc5fffff
[4294670.165000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[4294670.166000] audit: initializing netlink socket (disabled)
[4294670.166000] audit(1143377448.165:1): initialized
[4294670.166000] highmem bounce pool size: 64 pages
[4294670.166000] VFS: Disk quotas dquot_6.5.1
[4294670.166000] Dquot-cache hash table entries: 1024 (order 0, 4096
bytes)
[4294670.166000] Initializing Cryptographic API
[4294670.166000] io scheduler noop registered
[4294670.166000] io scheduler anticipatory registered
[4294670.166000] io scheduler deadline registered
[4294670.166000] io scheduler cfq registered
[4294670.167000] isapnp: Scanning for PnP cards...
[4294670.526000] isapnp: No Plug & Play device found
[4294670.552000] PNP: No PS/2 controller found. Probing ports directly.
[4294670.555000] serio: i8042 AUX port at 0x60,0x64 irq 12
[4294670.555000] serio: i8042 KBD port at 0x60,0x64 irq 1
[4294670.555000] Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ
sharing enabled
[4294670.559000] RAMDISK driver initialized: 16 RAM disks of 65536K size
1024 blocksize
[4294670.559000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4294670.559000] ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
[4294670.559000] ACPI: bus type ide registered
[4294670.559000] mice: PS/2 mouse device common for all mice
[4294670.560000] EISA: Probing bus 0 at eisa.0
[4294670.560000] EISA: Detected 0 cards.
[4294670.560000] NET: Registered protocol family 2
[4294670.569000] IP route cache hash table entries: 65536 (order: 6,
262144 bytes)
[4294670.569000] TCP established hash table entries: 262144 (order: 8,
1048576 bytes)
[4294670.570000] TCP bind hash table entries: 65536 (order: 6, 262144
bytes)
[4294670.571000] TCP: Hash tables configured (established 262144 bind
65536)
[4294670.571000] TCP reno registered
[4294670.571000] TCP bic registered
[4294670.571000] NET: Registered protocol family 1
[4294670.571000] NET: Registered protocol family 8
[4294670.571000] NET: Registered protocol family 20
[4294670.571000] Using IPI Shortcut mode
[4294670.571000] ACPI wakeup devices:
[4294670.571000] PBTN PCI1  USB USB2  AC9  SMB
[4294670.571000] ACPI: (supports S0 S1 S4 S5)
[4294670.571000] Freeing unused kernel memory: 288k freed
[4294670.677000] vga16fb: initializing
[4294670.677000] vga16fb: mapped to 0xc00a0000
[4294670.747000] input: AT Translated Set 2 keyboard as
/class/input/input0
[4294670.838000] Console: switching to colour frame buffer device 80x25
[4294670.838000] fb0: VGA16 VGA frame buffer device
[4294671.975000] Capability LSM initialized
[4294673.091000] SCSI subsystem initialized
[4294673.097000] ACPI: PCI Interrupt 0000:02:0d.0[A] -> GSI 21 (level,
low) -> IRQ 169
[4294688.309000] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev
7.0
[4294688.309000]         <Adaptec 3960D Ultra160 SCSI adapter>
[4294688.309000]         aic7899: Ultra160 Wide Channel A, SCSI Id=7,
32/253 SCBs
[4294688.309000]
[4294692.166000] ACPI: PCI Interrupt 0000:02:0d.1[B] -> GSI 22 (level,
low) -> IRQ 177
[4294707.377000] scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev
7.0
[4294707.377000]         <Adaptec 3960D Ultra160 SCSI adapter>
[4294707.377000]         aic7899: Ultra160 Wide Channel B, SCSI Id=7,
32/253 SCBs
[4294707.377000]
[4294708.152000]   Vendor: IBM       Model: DPSS-309170N      Rev: S96H
[4294708.152000]   Type:   Direct-Access                      ANSI SCSI
revision: 03
[4294708.152000] scsi1:A:3:0: Tagged Queuing enabled.  Depth 8
[4294708.152000]  target1:0:3: Beginning Domain Validation
[4294708.155000]  target1:0:3: wide asynchronous.
[4294708.157000]  target1:0:3: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns,
offset 63)
[4294708.169000]  target1:0:3: Ending Domain Validation
[4294708.686000] SCSI device sda: 17916240 512-byte hdwr sectors (9173
MB)
[4294709.201000] SCSI device sda: drive cache: write back
[4294709.716000] SCSI device sda: 17916240 512-byte hdwr sectors (9173
MB)
[4294710.231000] SCSI device sda: drive cache: write back
[4294710.231000]  sda: sda1 sda2 < sda5 >
[4294711.017000] sd 1:0:3:0: Attached scsi disk sda
[4294711.345000] ICH2: IDE controller at PCI slot 0000:00:1f.1
[4294711.345000] ICH2: chipset revision 4
[4294711.345000] ICH2: not 100% native mode: will probe irqs later
[4294711.345000]     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings:
hda:DMA, hdb:pio
[4294711.345000] Probing IDE interface ide0...
[4294712.017000] hda: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive
[4294712.323000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[4294712.337000] hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache,
UDMA(66)
[4294712.337000] Uniform CD-ROM driver Revision: 3.20
[4294712.462000] usbcore: registered new driver usbfs
[4294712.462000] usbcore: registered new driver hub
[4294712.465000] ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller
(OHCI) Driver (PCI)
[4294712.465000] ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 22 (level,
low) -> IRQ 177
[4294712.465000] ohci_hcd 0000:02:0a.0: OHCI Host Controller
[4294712.466000] ohci_hcd 0000:02:0a.0: new USB bus registered, assigned
bus number 1
[4294712.466000] ohci_hcd 0000:02:0a.0: irq 177, io mem 0xfeafc000
[4294712.509000] USB Universal Host Controller Interface driver v2.3
[4294712.510000] ACPI: PCI Interrupt 0000:00:1f.2[D] -> GSI 19 (level,
low) -> IRQ 185
[4294712.510000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[4294712.510000] uhci_hcd 0000:00:1f.2: UHCI Host Controller
[4294712.511000] uhci_hcd 0000:00:1f.2: new USB bus registered, assigned
bus number 2
[4294712.511000] uhci_hcd 0000:00:1f.2: irq 185, io base 0x0000ef40
[4294712.511000] hub 2-0:1.0: USB hub found
[4294712.511000] hub 2-0:1.0: 2 ports detected
[4294712.612000] ACPI: PCI Interrupt 0000:00:1f.4[C] -> GSI 23 (level,
low) -> IRQ 193
[4294712.612000] PCI: Setting latency timer of device 0000:00:1f.4 to 64
[4294712.612000] uhci_hcd 0000:00:1f.4: UHCI Host Controller
[4294712.612000] uhci_hcd 0000:00:1f.4: new USB bus registered, assigned
bus number 3
[4294712.612000] uhci_hcd 0000:00:1f.4: irq 193, io base 0x0000ef80
[4294712.612000] hub 3-0:1.0: USB hub found
[4294712.612000] hub 3-0:1.0: 2 ports detected
[4294712.713000] hub 1-0:1.0: USB hub found
[4294712.713000] hub 1-0:1.0: 3 ports detected
[4294712.814000] ACPI: PCI Interrupt 0000:02:0a.1[B] -> GSI 23 (level,
low) -> IRQ 193
[4294712.814000] ohci_hcd 0000:02:0a.1: OHCI Host Controller
[4294712.814000] ohci_hcd 0000:02:0a.1: new USB bus registered, assigned
bus number 4
[4294712.814000] ohci_hcd 0000:02:0a.1: irq 193, io mem 0xfeafd000
[4294712.818000] usb 2-1: new low speed USB device using uhci_hcd and
address 2
[4294712.895000] hub 4-0:1.0: USB hub found
[4294712.895000] hub 4-0:1.0: 2 ports detected
[4294713.001000] ACPI: PCI Interrupt 0000:02:0a.2[C] -> GSI 17 (level,
low) -> IRQ 201
[4294713.001000] ehci_hcd 0000:02:0a.2: EHCI Host Controller
[4294713.022000] ehci_hcd 0000:02:0a.2: new USB bus registered, assigned
bus number 5
[4294713.022000] ehci_hcd 0000:02:0a.2: irq 201, io mem 0xfeafec00
[4294713.022000] ehci_hcd 0000:02:0a.2: USB 2.0 started, EHCI 1.00, driver
10 Dec 2004
[4294713.022000] hub 5-0:1.0: USB hub found
[4294713.022000] hub 5-0:1.0: 5 ports detected
[4294713.204000] usb 2-2: new full speed USB device using uhci_hcd and
address 3[4294713.333000] usbcore: registered new driver hiddev
[4294713.991000] hiddev96: USB HID v1.10 Device [American Power Conversion
Back-UPS BR  800 FW:9.o2 .D USB FW:o2 ] on usb-0000:00:1f.2-1
[4294713.991000] usbcore: registered new driver usbhid
[4294713.991000] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[4294714.012000] Probing IDE interface ide1...
[4294714.301000] usb 5-2: new high speed USB device using ehci_hcd and
address 2[4294714.415000] hub 5-2:1.0: USB hub found
[4294714.416000] hub 5-2:1.0: 4 ports detected
[4294714.594000] Attempting manual resume
[4294714.630000] EXT3-fs: mounted filesystem with ordered data mode.
[4294714.668000] kjournald starting.  Commit interval 5 seconds
[4294714.849000] usb 5-2.1: new full speed USB device using ehci_hcd and
address 4
[4294715.135000] usb 5-2.4: new full speed USB device using ehci_hcd and
address 5
[4294715.447000] usb 1-3: new full speed USB device using ohci_hcd and
address 2[4294715.585000] hub 1-3:1.0: USB hub found
[4294715.588000] hub 1-3:1.0: 4 ports detected
[4294715.898000] usb 1-3.4: new low speed USB device using ohci_hcd and
address 3
[4294716.014000] input: Logitech USB-PS/2 Optical Mouse as
/class/input/input1
[4294716.014000] input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical
Mouse] on usb-0000:02:0a.0-3.4
[4294723.591000] ts: Compaq touchscreen protocol output
[4294724.972000] sd 1:0:3:0: Attached scsi generic sg0 type 0
[4294726.491000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[4294726.514000] shpchp: Standard Hot Plug PCI Controller Driver version:
0.4
[4294726.529000] Linux agpgart interface v0.101 (c) Dave Jones
[4294726.558000] agpgart: Detected an Intel i850 Chipset.
[4294726.574000] agpgart: AGP aperture is 256M @ 0xe0000000
[4294726.574000] hw_random hardware driver 1.0.0 loaded
[4294727.216000] nvidia: module license 'NVIDIA' taints kernel.
[4294727.257000] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level,
low) -> IRQ 209
[4294727.258000] NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module 
1.0-8178 Wed Dec 14 16:22:51 PST 2005
[4294727.465000] gameport: EMU10K1 is pci0000:02:09.1/gameport0, io
0xdff0, speed 917kHz
[4294728.040000] 8139too Fast Ethernet driver 0.9.27
[4294728.040000] ACPI: PCI Interrupt 0000:02:0c.0[A] -> GSI 17 (level,
low) -> IRQ 201
[4294728.041000] eth0: RealTek RTL8139 at 0xf89da800, 00:e0:4c:e2:5e:32,
IRQ 201[4294728.041000] eth0:  Identified 8139 chip type 'RTL-8139C'
[4294728.046000] ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 21 (level,
low) -> IRQ 169
[4294728.234000] 8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
[4294728.512000] input: Wacom Intuos3 9x12 as /class/input/input2
[4294728.541000] usbcore: registered new driver wacom
[4294728.541000] drivers/usb/input/wacom.c: v1.44:USB Wacom Graphire and
Wacom Intuos tablet driver
[4294729.342000] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[4294729.419000] drivers/usb/class/usblp.c: usblp0: USB Bidirectional
printer dev 5 if 0 alt 0 proto 2 vid 0x04B8 pid 0x0005
[4294729.419000] usbcore: registered new driver usblp
[4294729.419000] drivers/usb/class/usblp.c: v0.13: USB Printer Device
Class driver
[4294729.913000] lp: driver loaded but no devices found
[4294730.026000] Adding 401584k swap on /dev/sda5.  Priority:-1 extents:1
across:401584k
[4294730.336000] EXT3 FS on sda1, internal journal
[4294730.461000] NET: Registered protocol family 17
[4294730.690000] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[4294730.690000] md: bitmap version 4.39
[4294731.980000] device-mapper: 4.4.0-ioctl (2005-01-12) initialised:
dm-devel@redhat.com
[4294733.504000] cdrom: open failed.
[4294735.511000] NET: Registered protocol family 10
[4294735.511000] lo: Disabled Privacy Extensions
[4294735.511000] IPv6 over IPv4 tunneling driver
[4294736.723000] ACPI: Power Button (FF) [PWRF]
[4294736.723000] ACPI: Power Button (CM) [PBTN]
[4294736.872000] ibm_acpi: ec object not found
[4294745.700000] eth0: no IPv6 routers present
[4294745.734000] agpgart: Found an AGP 2.0 compliant device at
0000:00:00.0.
[4294745.734000] agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x
mode
[4294745.735000] agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x
mode
[4294746.175000] agpgart: Found an AGP 2.0 compliant device at
0000:00:00.0.
[4294746.175000] agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x
mode
[4294746.175000] agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x
mode
[4294748.664000] apm: BIOS version 1.2 Flags 0x0b (Driver version 1.16ac)
[4294748.665000] apm: overridden by ACPI.
[4294749.039000] hda: drive_cmd: status=0x51 { DriveReady SeekComplete
Error }
[4294749.039000] hda: drive_cmd: error=0x04 { AbortedCommand }
[4294749.039000] ide: failed opcode was: 0xec
[4294749.048000] hda: drive_cmd: status=0x41 { DriveReady Error }
[4294749.048000] hda: drive_cmd: error=0x04 { AbortedCommand }
[4294749.048000] ide: failed opcode was: 0xe3
[4294749.076000] hda: drive_cmd: status=0x51 { DriveReady SeekComplete
Error }
[4294749.076000] hda: drive_cmd: error=0x04 { AbortedCommand }
[4294749.076000] ide: failed opcode was: 0xec
[4294749.083000] hda: drive_cmd: status=0x41 { DriveReady Error }
[4294749.083000] hda: drive_cmd: error=0x04 { AbortedCommand }
[4294749.083000] ide: failed opcode was: 0xef
[4294751.054000] Bluetooth: Core ver 2.8
[4294751.054000] NET: Registered protocol family 31
[4294751.054000] Bluetooth: HCI device and connection manager initialized
[4294751.054000] Bluetooth: HCI socket layer initialized
[4294751.272000] Bluetooth: L2CAP ver 2.8
[4294751.272000] Bluetooth: L2CAP socket layer initialized
[4294751.284000] Bluetooth: RFCOMM socket layer initialized
[4294751.284000] Bluetooth: RFCOMM TTY layer initialized
[4294751.284000] Bluetooth: RFCOMM ver 1.7
[4294758.344000] eth0: no IPv6 routers present
[4296517.890000] agpgart: Found an AGP 2.0 compliant device at
0000:00:00.0.
[4296517.890000] agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x
mode
[4296517.890000] agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x
mode
[4297673.649000] Real Time Clock Driver v1.12
[4304406.292000] cdrom: This disc doesn't have any tracks I recognize!
[4343783.464000] scsi: unknown opcode 0xed
[4343783.509000] scsi: unknown opcode 0xe9
[4344578.158000] snd_layla24: disagrees about version of symbol
snd_rawmidi_receive
[4344578.158000] snd_layla24: Unknown symbol snd_rawmidi_receive
[4344578.159000] snd_layla24: disagrees about version of symbol
snd_rawmidi_transmit_empty
[4344578.159000] snd_layla24: Unknown symbol snd_rawmidi_transmit_empty
[4344578.159000] snd_layla24: disagrees about version of symbol
snd_ctl_add
[4344578.159000] snd_layla24: Unknown symbol snd_ctl_add
[4344578.159000] snd_layla24: disagrees about version of symbol
snd_pcm_new
[4344578.159000] snd_layla24: Unknown symbol snd_pcm_new
[4344578.160000] snd_layla24: disagrees about version of symbol
snd_card_register
[4344578.160000] snd_layla24: Unknown symbol snd_card_register
[4344578.160000] snd_layla24: disagrees about version of symbol
snd_card_free
[4344578.160000] snd_layla24: Unknown symbol snd_card_free
[4344578.160000] snd_layla24: disagrees about version of symbol
snd_interval_refine
[4344578.160000] snd_layla24: Unknown symbol snd_interval_refine
[4344578.161000] snd_layla24: disagrees about version of symbol
snd_pcm_format_physical_width
[4344578.161000] snd_layla24: Unknown symbol
snd_pcm_format_physical_width
[4344578.161000] snd_layla24: disagrees about version of symbol
snd_pcm_set_sync[4344578.161000] snd_layla24: Unknown symbol
snd_pcm_set_sync
[4344578.161000] snd_layla24: Unknown symbol snd_verbose_printk
[4344578.162000] snd_layla24: disagrees about version of symbol
snd_ctl_new1
[4344578.162000] snd_layla24: Unknown symbol snd_ctl_new1
[4344578.162000] snd_layla24: disagrees about version of symbol
snd_rawmidi_transmit_ack
[4344578.162000] snd_layla24: Unknown symbol snd_rawmidi_transmit_ack
[4344578.162000] snd_layla24: disagrees about version of symbol
snd_pcm_hw_rule_add
[4344578.162000] snd_layla24: Unknown symbol snd_pcm_hw_rule_add
[4344578.163000] snd_layla24: disagrees about version of symbol
snd_card_new
[4344578.163000] snd_layla24: Unknown symbol snd_card_new
[4344578.163000] snd_layla24: disagrees about version of symbol
snd_pcm_lib_malloc_pages
[4344578.163000] snd_layla24: Unknown symbol snd_pcm_lib_malloc_pages
[4344578.163000] snd_layla24: disagrees about version of symbol
snd_pcm_lib_ioctl
[4344578.163000] snd_layla24: Unknown symbol snd_pcm_lib_ioctl
[4344578.164000] snd_layla24: disagrees about version of symbol
snd_pcm_lib_free_pages
[4344578.164000] snd_layla24: Unknown symbol snd_pcm_lib_free_pages
[4344578.164000] snd_layla24: disagrees about version of symbol
snd_rawmidi_transmit_peek
[4344578.164000] snd_layla24: Unknown symbol snd_rawmidi_transmit_peek
[4344578.164000] snd_layla24: disagrees about version of symbol
snd_ctl_notify
[4344578.165000] snd_layla24: Unknown symbol snd_ctl_notify
[4344578.165000] snd_layla24: disagrees about version of symbol
snd_pcm_set_ops
[4344578.165000] snd_layla24: Unknown symbol snd_pcm_set_ops
[4344578.165000] snd_layla24: disagrees about version of symbol
snd_pcm_hw_constraint_list
[4344578.165000] snd_layla24: Unknown symbol snd_pcm_hw_constraint_list
[4344578.165000] snd_layla24: disagrees about version of symbol
snd_device_new
[4344578.166000] snd_layla24: Unknown symbol snd_device_new
[4344578.166000] snd_layla24: disagrees about version of symbol
snd_pcm_sgbuf_ops_page
[4344578.166000] snd_layla24: Unknown symbol snd_pcm_sgbuf_ops_page
[4344578.166000] snd_layla24: disagrees about version of symbol
snd_rawmidi_new
[4344578.166000] snd_layla24: Unknown symbol snd_rawmidi_new
[4344578.167000] snd_layla24: disagrees about version of symbol
snd_pcm_hw_constraint_integer
[4344578.167000] snd_layla24: Unknown symbol
snd_pcm_hw_constraint_integer
[4344578.167000] snd_layla24: disagrees about version of symbol
snd_rawmidi_set_ops
[4344578.168000] snd_layla24: Unknown symbol snd_rawmidi_set_ops
[4344578.168000] snd_layla24: disagrees about version of symbol
snd_pcm_lib_preallocate_pages
[4344578.168000] snd_layla24: Unknown symbol
snd_pcm_lib_preallocate_pages
[4344578.168000] snd_layla24: disagrees about version of symbol
snd_pcm_period_elapsed
[4344578.169000] snd_layla24: Unknown symbol snd_pcm_period_elapsed
[4344578.169000] snd_layla24: disagrees about version of symbol
snd_pcm_hw_constraint_step
[4344578.169000] snd_layla24: Unknown symbol snd_pcm_hw_constraint_step

----------------------------------------------------------------------
 rlrevell - 03-27-06 05:16 
----------------------------------------------------------------------
The "Unknown symbol" errors mean your build or install is incorrect.  Most
commonly it means you did not remove all the old ALSA modules before
installing new ones (none of the automated tools do this for you, you have
to remove all snd-* modules manually, then modprobe the new ones, or just
reboot)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-16-06 13:05 coz            New Issue                                    
02-16-06 13:05 coz            Distribution              => ubuntu/breezy/Debian
02-16-06 13:05 coz            Kernel Version            => 2.6.12.10.386   
02-18-06 13:34 pochini        Note Added: 0008119                          
02-20-06 03:30 coz            Note Added: 0008140                          
02-20-06 22:02 pochini        Note Added: 0008150                          
03-13-06 19:49 coz            Note Added: 0008456                          
03-13-06 22:38 pochini        Note Added: 0008465                          
03-13-06 23:02 johnrigg       Note Added: 0008466                          
03-16-06 14:54 coz            Note Added: 0008605                          
03-18-06 22:02 pochini        Note Added: 0008676                          
03-18-06 22:07 pochini        Note Edited: 0008676                         
03-19-06 16:05 coz            Note Added: 0008690                          
03-20-06 22:10 pochini        Note Added: 0008725                          
03-22-06 02:38 coz            Note Added: 0008781                          
03-22-06 02:48 rlrevell       Note Added: 0008787                          
03-25-06 12:04 pochini        Note Added: 0008945                          
03-27-06 05:04 coz            Note Added: 0008988                          
03-27-06 05:16 rlrevell       Note Added: 0008989                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
