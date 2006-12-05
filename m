From: Gian Jaskulski <gianfj@gmail.com>
Subject: Re: Asus W7j
Date: Tue, 05 Dec 2006 10:17:34 -0200
Message-ID: <1165321054.7405.0.camel@localhost>
References: <1165279947.3361.7.camel@localhost>
	<1165284357.32312.123.camel@razman> <1165319897.3988.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1165319897.3988.5.camel@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Results when model is setting to debug:

ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...
ALSA /root/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2175: autoconfig:
line_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /root/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2179:
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /root/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2183:    hp_outs=1
(0xb/0x0/0x0/0x0/0x0)
ALSA /root/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2191:    inputs:
mic=0xd, fmic=0x0, line=0x0, fline=0x0, cd=0x11, aux=0x0
ACPI: PCI interrupt for device 0000:00:1b.0 disabled


On Tue, 2006-12-05 at 09:58 -0200, Gian Jaskulski wrote:
> Tried use model asus-laptop. When I use model 3stack I can use the alsa
> interface with totem and I can change the master volume with software
> control (not the driver's control). With model asus-laptop just the OSS
> api works. And with both models my controls are completly messed up (can
> just mute and unmute the master and all others are disabled). Above are
> the dmesg results of loading and unloading the snd-hda-intel module:
> 
> ACPI: PCI interrupt for device 0000:00:1b.0 disabled
> ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 23
> PCI: Setting latency timer of device 0000:00:1b.0 to 64
> ALSA /root/alsa-hg/alsa-driver/pci/hda/hda_codec.c:1743: hda_codec:
> model 'asus-laptop' is selected
> 
> 
> 
> On Mon, 2006-12-04 at 18:05 -0800, Tobin Davis wrote:
> > Try loading the sound driver with "model=asus-laptop".   If this works
> > for you, I'll add your system to the driver source.  If not, let me
> > know and we can go further.
> > 
> > Tobin Davis
> > 
> > On Mon, 2006-12-04 at 22:52 -0200, Gian Jaskulski wrote: 
> > > Dears:
> > > 
> > > I am working on this nice piece for while and I can make the sound work
> > > using the snd-hda-intel module with the 3stack model but I can't change
> > > any volume and all the controls are messed up. I think it is something
> > > related to the sound card model (INTEL ICH7). Can anyone can help me?
> > > 
> > > Thanks in advice.
> > > 
> > > 
> > > Gian.
> > > 
> > > Some information above:
> > > 
> > > 
> > > Result of lspci -vn:
> > > 
> > > 00:00.0 0600: 8086:27a0 (rev 03)
> > >         Subsystem: 1043:12e7
> > >         Flags: bus master, fast devsel, latency 0
> > >         Capabilities: [e0] Vendor Specific Information
> > > 
> > > 00:01.0 0604: 8086:27a1 (rev 03)
> > >         Flags: bus master, fast devsel, latency 0
> > >         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> > >         Memory behind bridge: f6700000-fa7fffff
> > >         Prefetchable memory behind bridge:
> > > 000000009ff00000-00000000bfe00000
> > >         Capabilities: [88] #0d [0000]
> > >         Capabilities: [80] Power Management version 2
> > >         Capabilities: [90] Message Signalled Interrupts: 64bit-
> > > Queue=0/0 Enable+
> > >         Capabilities: [a0] Express Root Port (Slot+) IRQ 0
> > > 
> > > 00:1b.0 0403: 8086:27d8 (rev 02)
> > >         Subsystem: 1043:1253
> > >         Flags: bus master, fast devsel, latency 0, IRQ 23
> > >         Memory at febf8000 (64-bit, non-prefetchable) [size=16K]
> > >         Capabilities: [50] Power Management version 2
> > >         Capabilities: [60] Message Signalled Interrupts: 64bit+
> > > Queue=0/0 Enable-
> > >         Capabilities: [70] Express Unknown type IRQ 0
> > > 
> > > 00:1c.0 0604: 8086:27d0 (rev 02)
> > >         Flags: bus master, fast devsel, latency 0
> > >         Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
> > >         I/O behind bridge: 0000a000-0000bfff
> > >         Memory behind bridge: fa800000-fe7fffff
> > >         Prefetchable memory behind bridge:
> > > 00000000bff00000-00000000dfe00000
> > >         Capabilities: [40] Express Root Port (Slot+) IRQ 0
> > >         Capabilities: [80] Message Signalled Interrupts: 64bit-
> > > Queue=0/0 Enable+
> > >         Capabilities: [90] #0d [0000]
> > >         Capabilities: [a0] Power Management version 2
> > > 
> > > 00:1c.1 0604: 8086:27d2 (rev 02)
> > >         Flags: bus master, fast devsel, latency 0
> > >         Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
> > >         I/O behind bridge: 0000c000-0000cfff
> > >         Memory behind bridge: fe800000-fe8fffff
> > >         Capabilities: [40] Express Root Port (Slot+) IRQ 0
> > >         Capabilities: [80] Message Signalled Interrupts: 64bit-
> > > Queue=0/0 Enable+
> > >         Capabilities: [90] #0d [0000]
> > >         Capabilities: [a0] Power Management version 2
> > > 
> > > 00:1c.2 0604: 8086:27d4 (rev 02)
> > >         Flags: bus master, fast devsel, latency 0
> > >         Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
> > >         Memory behind bridge: fe900000-fe9fffff
> > >         Capabilities: [40] Express Root Port (Slot+) IRQ 0
> > >         Capabilities: [80] Message Signalled Interrupts: 64bit-
> > > Queue=0/0 Enable+
> > >         Capabilities: [90] #0d [0000]
> > >         Capabilities: [a0] Power Management version 2
> > > 
> > > 00:1d.0 0c03: 8086:27c8 (rev 02)
> > >         Subsystem: 1043:12e7
> > >         Flags: bus master, medium devsel, latency 0, IRQ 20
> > >         I/O ports at e080 [size=32]
> > > 
> > > 00:1d.1 0c03: 8086:27c9 (rev 02)
> > >         Subsystem: 1043:12e7
> > >         Flags: bus master, medium devsel, latency 0, IRQ 19
> > >         I/O ports at e000 [size=32]
> > > 
> > > 00:1d.2 0c03: 8086:27ca (rev 02)
> > >         Subsystem: 1043:12e7
> > >         Flags: bus master, medium devsel, latency 0, IRQ 18
> > >         I/O ports at dc00 [size=32]
> > > 
> > > 00:1d.3 0c03: 8086:27cb (rev 02)
> > >         Subsystem: 1043:12e7
> > >         Flags: bus master, medium devsel, latency 0, IRQ 21
> > >         I/O ports at d880 [size=32]
> > > 
> > > 00:1d.7 0c03: 8086:27cc (rev 02) (prog-if 20)
> > >         Subsystem: 1043:12e7
> > >         Flags: bus master, medium devsel, latency 0, IRQ 20
> > >         Memory at febff800 (32-bit, non-prefetchable) [size=1K]
> > >         Capabilities: [50] Power Management version 2
> > >         Capabilities: [58] Debug port
> > > 
> > > 00:1e.0 0604: 8086:2448 (rev e2) (prog-if 01)
> > >         Flags: bus master, fast devsel, latency 0
> > >         Bus: primary=00, secondary=07, subordinate=07, sec-latency=32
> > >         Memory behind bridge: fea00000-feafffff
> > >         Capabilities: [50] #0d [0000]
> > > 
> > > 00:1f.0 0601: 8086:27b9 (rev 02)
> > >         Subsystem: 1043:12e7
> > >         Flags: bus master, medium devsel, latency 0
> > >         Capabilities: [e0] Vendor Specific Information
> > > 
> > > 00:1f.1 0101: 8086:27df (rev 02) (prog-if 8a)
> > >         Subsystem: 1043:12e7
> > >         Flags: bus master, medium devsel, latency 0, IRQ 18
> > >         I/O ports at <unassigned>
> > >         I/O ports at <unassigned>
> > >         I/O ports at <unassigned>
> > >         I/O ports at <unassigned>
> > >         I/O ports at ffa0 [size=16]
> > > 
> > > 00:1f.2 0101: 8086:27c4 (rev 02) (prog-if 8f)
> > >         Subsystem: 1043:12e7
> > >         Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 19
> > >         I/O ports at ec00 [size=8]
> > >         I/O ports at e880 [size=4]
> > >         I/O ports at e800 [size=8]
> > >         I/O ports at e480 [size=4]
> > >         I/O ports at e400 [size=16]
> > >         Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
> > >         Capabilities: [70] Power Management version 2
> > > 
> > > 01:00.0 0300: 10de:01d8 (rev a1)
> > >         Subsystem: 1043:1211
> > >         Flags: bus master, fast devsel, latency 0, IRQ 16
> > >         Memory at f9000000 (32-bit, non-prefetchable) [size=16M]
> > >         Memory at a0000000 (64-bit, prefetchable) [size=256M]
> > >         Memory at f8000000 (64-bit, non-prefetchable) [size=16M]
> > >         [virtual] Expansion ROM at fa7e0000 [disabled] [size=128K]
> > >         Capabilities: [60] Power Management version 2
> > >         Capabilities: [68] Message Signalled Interrupts: 64bit+
> > > Queue=0/0 Enable-
> > >         Capabilities: [78] Express Endpoint IRQ 0
> > > 
> > > 05:00.0 0200: 10ec:8168 (rev 01)
> > >         Subsystem: 1043:11f5
> > >         Flags: bus master, fast devsel, latency 0, IRQ 17
> > >         I/O ports at c800 [size=256]
> > >         Memory at fe8ff000 (64-bit, non-prefetchable) [size=4K]
> > >         Expansion ROM at fe8e0000 [disabled] [size=64K]
> > >         Capabilities: [40] Power Management version 2
> > >         Capabilities: [48] Vital Product Data
> > >         Capabilities: [50] Message Signalled Interrupts: 64bit+
> > > Queue=0/1 Enable-
> > >         Capabilities: [60] Express Endpoint IRQ 0
> > >         Capabilities: [84] Vendor Specific Information
> > > 
> > > 06:00.0 0280: 8086:4222 (rev 02)
> > >         Subsystem: 8086:1001
> > >         Flags: bus master, fast devsel, latency 0, IRQ 18
> > >         Memory at fe9ff000 (32-bit, non-prefetchable) [size=4K]
> > >         Capabilities: [c8] Power Management version 2
> > >         Capabilities: [d0] Message Signalled Interrupts: 64bit+
> > > Queue=0/0 Enable-
> > >         Capabilities: [e0] Express Legacy Endpoint IRQ 0
> > > 
> > > 07:03.0 0c00: 1180:0832 (prog-if 10)
> > >         Subsystem: 1043:12e7
> > >         Flags: bus master, medium devsel, latency 64, IRQ 21
> > >         Memory at feaff800 (32-bit, non-prefetchable) [size=2K]
> > >         Capabilities: [dc] Power Management version 2
> > > 
> > > 07:03.1 0805: 1180:0822 (rev 19)
> > >         Subsystem: 1043:12e7
> > >         Flags: bus master, medium devsel, latency 64, IRQ 22
> > >         Memory at feaff400 (32-bit, non-prefetchable) [size=256]
> > >         Capabilities: [80] Power Management version 2
> > > 
> > > 07:03.2 0880: 1180:0843 (rev 01)
> > >         Subsystem: 1043:12e7
> > >         Flags: bus master, medium devsel, latency 0, IRQ 3
> > >         Memory at feaff000 (32-bit, non-prefetchable) [size=256]
> > >         Capabilities: [80] Power Management version 2
> > > 
> > > 07:03.3 0880: 1180:0592 (rev 0a)
> > >         Subsystem: 1043:12e7
> > >         Flags: medium devsel, IRQ 3
> > >         Memory at feafec00 (32-bit, non-prefetchable) [size=256]
> > >         Capabilities: [80] Power Management version 2
> > > 
> > > 07:03.4 0880: 1180:0852 (rev 05)
> > >         Subsystem: 1043:12e7
> > >         Flags: medium devsel, IRQ 3
> > >         Memory at feafe800 (32-bit, non-prefetchable) [size=256]
> > >         Capabilities: [80] Power Management version 2
> > > 
> > > 
> > > Results of lspci:
> > > 00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and
> > > 945GT Express Memory Controller Hub (rev 03)
> > > 00:01.0 PCI bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and
> > > 945GT Express PCI Express Root Port (rev 03)
> > > 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
> > > Definition Audio Controller (rev 02)
> > > 00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
> > > Port 1 (rev 02)
> > > 00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
> > > Port 2 (rev 02)
> > > 00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
> > > Port 3 (rev 02)
> > > 00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
> > > #1 (rev 02)
> > > 00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
> > > #2 (rev 02)
> > > 00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
> > > #3 (rev 02)
> > > 00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
> > > #4 (rev 02)
> > > 00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
> > > Controller (rev 02)
> > > 00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
> > > 00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface
> > > Bridge (rev 02)
> > > 00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
> > > Controller (rev 02)
> > > 00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family)
> > > Serial ATA Storage Controller IDE (rev 02)
> > > 01:00.0 VGA compatible controller: nVidia Corporation GeForce Go 7400
> > > (rev a1)
> > > 05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > > RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 01)
> > > 06:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG
> > > Network Connection (rev 02)
> > > 07:03.0 FireWire (IEEE 1394): Ricoh Co Ltd Unknown device 0832
> > > 07:03.1 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host
> > > Adapter (rev 19)
> > > 07:03.2 System peripheral: Ricoh Co Ltd Unknown device 0843 (rev 01)
> > > 07:03.3 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host
> > > Adapter (rev 0a)
> > > 07:03.4 System peripheral: Ricoh Co Ltd xD-Picture Card Controller (rev
> > > 05)
> > > 
> > > 
> > > Results of cat /proc/asound/card0/codec*
> > > 
> > > Codec: Realtek ALC660
> > > Address: 0
> > > Vendor Id: 0x10ec0861
> > > Subsystem Id: 0x10431205
> > > Revision Id: 0x100340
> > > Default PCM:
> > >     rates [0x140]: 48000 96000
> > >     bits [0xe]: 16 20 24
> > >     formats [0x1]: PCM
> > > Default Amp-In caps: N/A
> > > Default Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> > > Node 0x03 [Audio Output] wcaps 0x405: Stereo Amp-Out
> > >   Amp-Out caps: N/A
> > >   Amp-Out vals:  [0x00 0x00]
> > >   Power: 0x0
> > > Node 0x04 [Audio Output] wcaps 0x405: Stereo Amp-Out
> > >   Amp-Out caps: N/A
> > >   Amp-Out vals:  [0x00 0x00]
> > >   Power: 0x0
> > > Node 0x05 [Audio Output] wcaps 0x405: Stereo Amp-Out
> > >   Amp-Out caps: N/A
> > >   Amp-Out vals:  [0x00 0x00]
> > >   Power: 0x0
> > > Node 0x06 [Audio Output] wcaps 0x405: Stereo Amp-Out
> > >   Amp-Out caps: N/A
> > >   Amp-Out vals:  [0x00 0x00]
> > >   Power: 0x0
> > > Node 0x07 [Audio Output] wcaps 0x605: Stereo Digital Amp-Out
> > >   Amp-Out caps: N/A
> > >   Amp-Out vals:  [0x00 0x00]
> > >   Power: 0x0
> > > Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
> > >   Amp-In caps: ofs=0x02, nsteps=0x0d, stepsize=0x0b, mute=1
> > >   Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
> > > 0x00] [0x00 0x00]
> > >   PCM:
> > >     rates [0x140]: 48000 96000
> > >     bits [0x2]: 16
> > >     formats [0x1]: PCM
> > >   Power: 0x0
> > >   Connection: 6
> > >      0x0d 0x0c 0x0f 0x10 0x11* 0x15
> > > Node 0x09 [Vendor Defined Widget] wcaps 0xf00000: Mono
> > > Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
> > > Node 0x0b [Pin Complex] wcaps 0x400581: Stereo
> > >   Pincap 0x081f: OUT HP Detect
> > >   Pin Default 0x01214110: [Jack] HP Out at Ext Rear
> > >     Conn = 1/8, Color = Green
> > >   Pin-ctls: 0x40: OUT
> > >   Power: 0x0
> > >   Connection: 1
> > >      0x16
> > > Node 0x0c [Pin Complex] wcaps 0x400581: Stereo
> > >   Pincap 0x0837: IN OUT Detect
> > >   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
> > >     Conn = 1/8, Color = Black
> > >   Pin-ctls: 0x20: IN
> > >   Power: 0x0
> > >   Connection: 1
> > >      0x19
> > > Node 0x0d [Pin Complex] wcaps 0x400581: Stereo
> > >   Pincap 0x08337: IN OUT Detect
> > >   Pin Default 0x01a1993e: [Jack] Mic at Ext Rear
> > >     Conn = 1/8, Color = Pink
> > >   Pin-ctls: 0x24: IN
> > >   Power: 0x0
> > >   Connection: 1
> > >      0x18
> > > Node 0x0e [Pin Complex] wcaps 0x400581: Stereo
> > >   Pincap 0x0817: OUT Detect
> > >   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
> > >     Conn = 1/8, Color = Black
> > >   Pin-ctls: 0x00:
> > >   Power: 0x0
> > >   Connection: 1
> > >      0x19
> > > Node 0x0f [Pin Complex] wcaps 0x400581: Stereo
> > >   Pincap 0x0833f: IN OUT HP Detect
> > >   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
> > >     Conn = 1/8, Color = Black
> > >   Pin-ctls: 0xc0: OUT HP
> > >   Power: 0x0
> > >   Connection: 1
> > >      0x1a
> > > Node 0x10 [Pin Complex] wcaps 0x400581: Stereo
> > >   Pincap 0x0833f: IN OUT HP Detect
> > >   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
> > >     Conn = 1/8, Color = Black
> > >   Pin-ctls: 0x24: IN
> > >   Power: 0x0
> > >   Connection: 1
> > >      0x1b
> > > Node 0x11 [Pin Complex] wcaps 0x400001: Stereo
> > >   Pincap 0x0863: IN
> > >   Pin Default 0x99330130: [Fixed] CD at Int ATAPI
> > >     Conn = ATAPI, Color = Unknown
> > >   Pin-ctls: 0x00:
> > > Node 0x12 [Pin Complex] wcaps 0x400301: Stereo Digital
> > >   Pincap 0x0810: OUT
> > >   Pin Default 0x99430120: [Fixed] SPDIF Out at Int ATAPI
> > >     Conn = ATAPI, Color = Unknown
> > >   Pin-ctls: 0x40: OUT
> > >   Connection: 1
> > >      0x07
> > > Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
> > > Node 0x14 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
> > >   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> > >   Amp-In vals:  [0x00 0x00] [0x00 0x00]
> > >   Connection: 2
> > >      0x0d 0x10
> > > Node 0x15 [Audio Mixer] wcaps 0x20050f: Stereo Amp-In Amp-Out
> > >   Amp-In caps: ofs=0x0c, nsteps=0x17, stepsize=0x0b, mute=1
> > >   Amp-In vals:  [0x11 0x11] [0x80 0x80] [0x00 0x00]
> > >   Amp-Out caps: ofs=0x0c, nsteps=0x0c, stepsize=0x0b, mute=1
> > >   Amp-Out vals:  [0x0c 0x0c]
> > >   Power: 0x0
> > >   Connection: 3
> > >      0x11 0x14 0x1c
> > > Node 0x16 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
> > >   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> > >   Amp-In vals:  [0x00 0x00] [0x00 0x00]
> > >   Connection: 2
> > >      0x03 0x15
> > > Node 0x17 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
> > >   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> > >   Amp-In vals:  [0x00 0x00] [0x00 0x00]
> > >   Connection: 2
> > >      0x04 0x15
> > > Node 0x18 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
> > >   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> > >   Amp-In vals:  [0x00 0x00] [0x00 0x00]
> > >   Connection: 2
> > >      0x05 0x15
> > > Node 0x19 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
> > >   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> > >   Amp-In vals:  [0x00 0x00] [0x00 0x00]
> > >   Connection: 2
> > >      0x06 0x15
> > > Node 0x1a [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
> > >   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> > >   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x00 0x00] [0x00 0x00]
> > >   Connection: 4
> > >      0x04 0x06 0x15 0x03
> > > Node 0x1b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
> > >   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> > >   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
> > >   Connection: 4
> > >      0x04 0x06 0x15 0x03
> > > Node 0x1c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
> > >   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> > >   Amp-In vals:  [0x00 0x00] [0x00 0x00]
> > >   Connection: 2
> > >      0x0c 0x0f
> > > Node 0x1d [Vendor Defined Widget] wcaps 0xf00000: Mono
> > > Node 0x1e [Vendor Defined Widget] wcaps 0xf00000: Mono
> > > Node 0x1f [Pin Complex] wcaps 0x400581: Stereo
> > >   Pincap 0x0817: OUT Detect
> > >   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
> > >     Conn = 1/8, Color = Black
> > >   Pin-ctls: 0x00:
> > >   Power: 0x0
> > >   Connection: 1
> > >      0x18
> > > Node 0x20 [Pin Complex] wcaps 0x400581: Stereo
> > >   Pincap 0x0817: OUT Detect
> > >   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
> > >     Conn = 1/8, Color = Black
> > >   Pin-ctls: 0x00:
> > >   Power: 0x0
> > >   Connection: 1
> > >      0x17
> > > Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
> > > Node 0x22 [Vendor Defined Widget] wcaps 0xf00000: Mono
> > > Node 0x23 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
> > >   Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
> > >   Amp-Out vals:  [0x8f]
> > > Codec: Motorola Si3054
> > > Address: 1
> > > Vendor Id: 0x10573055
> > > Subsystem Id: 0x104310c6
> > > Revision Id: 0x100700
> > > 
> > > 
> > > 
> > > 
> > > -------------------------------------------------------------------------
> > > Take Surveys. Earn Cash. Influence the Future of IT
> > > Join SourceForge.net's Techsay panel and you'll get the chance to share your
> > > opinions on IT & business topics through brief surveys - and earn cash
> > > http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> > -- 
> > Tobin Davis <tdavis@dsl-only.net>


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
