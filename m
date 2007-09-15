From: Pablo Yaggi <pyaggi@alsurdelsur.com>
Subject: Re: Sony VAIO FZ19VN (snd_hda_intel)
Date: Sat, 15 Sep 2007 12:04:19 -0300
Message-ID: <200709151204.19452.pyaggi@alsurdelsur.com>
References: <200709150634.31961.pyaggi@alsurdelsur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from alsurdelsur.com (59.42.80.200.host.ifxnw.com.ar [200.80.42.59])
	by alsa0.perex.cz (Postfix) with ESMTP id 9530D24655
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Sep 2007 17:04:25 +0200 (CEST)
In-Reply-To: <200709150634.31961.pyaggi@alsurdelsur.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I forget to attach the lspci -nv output as required in the Documentation, 
sorry, here it is.

00:00.0 0600: 8086:2a00 (rev 0c)
	Subsystem: 104d:9005
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:02.0 0300: 8086:2a02 (rev 0c) (prog-if 00 [VGA])
	Subsystem: 104d:9005
	Flags: bus master, fast devsel, latency 0, IRQ 5
	Memory at fc000000 (64-bit, non-prefetchable) [size=1M]
	Memory at d0000000 (64-bit, prefetchable) [size=256M]
	I/O ports at 1800 [size=8]
	Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 
Enable-
	Capabilities: [d0] Power Management version 3

00:02.1 0380: 8086:2a03 (rev 0c)
	Subsystem: 104d:9005
	Flags: bus master, fast devsel, latency 0
	Memory at fc100000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: [d0] Power Management version 3

00:1a.0 0c03: 8086:2834 (rev 03) (prog-if 00 [UHCI])
	Subsystem: 104d:9005
	Flags: bus master, medium devsel, latency 0, IRQ 17
	I/O ports at 1820 [size=32]

00:1a.1 0c03: 8086:2835 (rev 03) (prog-if 00 [UHCI])
	Subsystem: 104d:9005
	Flags: bus master, medium devsel, latency 0, IRQ 20
	I/O ports at 1840 [size=32]

00:1a.7 0c03: 8086:283a (rev 03) (prog-if 20 [EHCI])
	Subsystem: 104d:9005
	Flags: bus master, medium devsel, latency 0, IRQ 18
	Memory at fc604800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port

00:1b.0 0403: 8086:284b (rev 03)
	Subsystem: 104d:9005
	Flags: bus master, fast devsel, latency 0, IRQ 21
	Memory at fc400000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 
Enable-
	Capabilities: [70] Express Unknown type IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)

00:1c.0 0604: 8086:283f (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=03, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: f6000000-f7ffffff
	Prefetchable memory behind bridge: 00000000f0000000-00000000f1ffffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 
Enable+
	Capabilities: [90] Subsystem: 104d:9005
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.1 0604: 8086:2841 (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=05, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f8000000-f9ffffff
	Prefetchable memory behind bridge: 00000000f2000000-00000000f3ffffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 
Enable+
	Capabilities: [90] Subsystem: 104d:9005
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.2 0604: 8086:2843 (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=06, subordinate=07, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: fa000000-fbffffff
	Prefetchable memory behind bridge: 00000000f4000000-00000000f5ffffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 
Enable+
	Capabilities: [90] Subsystem: 104d:9005
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.4 0604: 8086:2847 (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: fc200000-fc2fffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 
Enable+
	Capabilities: [90] Subsystem: 104d:9005
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1d.0 0c03: 8086:2830 (rev 03) (prog-if 00 [UHCI])
	Subsystem: 104d:9005
	Flags: bus master, medium devsel, latency 0, IRQ 22
	I/O ports at 1860 [size=32]

00:1d.1 0c03: 8086:2831 (rev 03) (prog-if 00 [UHCI])
	Subsystem: 104d:9005
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at 1880 [size=32]

00:1d.2 0c03: 8086:2832 (rev 03) (prog-if 00 [UHCI])
	Subsystem: 104d:9005
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at 18a0 [size=32]

00:1d.7 0c03: 8086:2836 (rev 03) (prog-if 20 [EHCI])
	Subsystem: 104d:9005
	Flags: bus master, medium devsel, latency 0, IRQ 22
	Memory at fc604c00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port

00:1e.0 0604: 8086:2448 (rev f3) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=09, subordinate=0d, sec-latency=56
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: fc300000-fc3fffff
	Prefetchable memory behind bridge: 0000000088000000-000000008bffffff
	Capabilities: [50] Subsystem: 104d:9005

00:1f.0 0601: 8086:2815 (rev 03)
	Subsystem: 104d:9005
	Flags: bus master, medium devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:1f.1 0101: 8086:2850 (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: 104d:9005
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at 01f0 [size=8]
	I/O ports at 03f4 [size=1]
	I/O ports at 0170 [size=8]
	I/O ports at 0374 [size=1]
	I/O ports at 1810 [size=16]

00:1f.2 0106: 8086:2829 (rev 03) (prog-if 01 [AHCI 1.0])
	Subsystem: 104d:9005
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 219
	I/O ports at 1c00 [size=8]
	I/O ports at 18d4 [size=4]
	I/O ports at 18d8 [size=8]
	I/O ports at 18d0 [size=4]
	I/O ports at 18e0 [size=32]
	Memory at fc604000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/2 
Enable+
	Capabilities: [70] Power Management version 3
	Capabilities: [a8] #12 [0010]

00:1f.3 0c05: 8086:283e (rev 03)
	Subsystem: 104d:9005
	Flags: medium devsel, IRQ 19
	Memory at 8c000000 (32-bit, non-prefetchable) [size=256]
	I/O ports at 1c20 [size=32]

06:00.0 0280: 8086:4222 (rev 02)
	Subsystem: 8086:1051
	Flags: bus master, fast devsel, latency 0, IRQ 10
	Memory at fa000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [c8] Power Management version 2
	Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 
Enable-
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number ba-8c-73-ff-ff-77-1b-00

08:00.0 0200: 11ab:4351 (rev 16)
	Subsystem: 104d:9005
	Flags: bus master, fast devsel, latency 0, IRQ 218
	Memory at fc200000 (64-bit, non-prefetchable) [size=16K]
	I/O ports at 5000 [size=256]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 
Enable+
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
	Capabilities: [100] Advanced Error Reporting

09:03.0 0607: 104c:8039
	Subsystem: 104d:9005
	Flags: bus master, medium devsel, latency 168, IRQ 17
	Memory at fc300000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=09, secondary=0a, subordinate=0d, sec-latency=176
	Memory window 0: 88000000-8bfff000 (prefetchable)
	Memory window 1: 90000000-93fff000
	I/O window 0: 00006000-000060ff
	I/O window 1: 00006400-000064ff
	16-bit legacy interface ports at 0001

09:03.1 0c00: 104c:803a (prog-if 10 [OHCI])
	Subsystem: 104d:9005
	Flags: bus master, medium devsel, latency 32, IRQ 16
	Memory at fc302000 (32-bit, non-prefetchable) [size=2K]
	Memory at fc304000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2

09:03.2 0180: 104c:803b
	Subsystem: 104d:9005
	Flags: bus master, medium devsel, latency 57, IRQ 18
	Memory at fc301000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2


On Saturday 15 September 2007 06:34:31 you wrote:
> Hi,
> 	i bought a sony vaio fz19vn, i try both modes for the snd_hda_intel, vaio
> and vaio-ar, the same problem happen with them, when i plugin the headset
> internal speakers are not muted, so here is the card info. I read the
> changelog for version 1.0.15 and it says automute  was added
> for the AD1986 which has jack detection, but this is a different codec.
> I have programming skills but i'm not familiarized with alsa internals, so
> ask me anything you need and i try to help.
> It would be nice a control to enable/disable automute and another
> two to enable/disable internal and external speakers.
> Best Regards
> Pablo
>
>
>
> ***************************
> /proc/asound/card0/codec#1:
> ***************************
>
> Codec: Conexant ID 2c06
> Address: 1
> Vendor Id: 0x14f12c06
> Subsystem Id: 0x104d1700
> Revision Id: 0x100000
> Modem Function Group: 0x2
>
>
> ***************************
> /proc/asound/card0/codec#0 :
> ***************************
> Codec: SigmaTel STAC9872AK
> Address: 0
> Vendor Id: 0x83847662
> Subsystem Id: 0x104d2300
> Revision Id: 0x100201
> No Modem Function Group found
> Default PCM:
>     rates [0x7e0]: 44100 48000 88200 96000 176400 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
> Default Amp-In caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
> Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
> Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
>   Amp-Out caps: N/A
>   Amp-Out vals:  [0x7f 0x7f]
>   Power: 0x0
> Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
>   Amp-Out caps: N/A
>   Amp-Out vals:  [0xff 0xff]
>   Power: 0x0
> Node 0x04 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
>   Amp-Out caps: N/A
>   Amp-Out vals:  [0xff 0xff]
>   Power: 0x0
> Node 0x05 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
>   Amp-Out caps: N/A
>   Amp-Out vals:  [0x7f 0x7f]
>   Power: 0x0
> Node 0x06 [Audio Input] wcaps 0x1d0541: Stereo
>   Power: 0x0
>   Connection: 1
>      0x07
> Node 0x07 [Audio Selector] wcaps 0x300903: Stereo Amp-In
>   Amp-In caps: N/A
>   Amp-In vals:  [0x00 0x00]
>   Connection: 1
>      0x0e
> Node 0x08 [Audio Input] wcaps 0x1d0541: Stereo
>   Power: 0x0
>   Connection: 1
>      0x09
> Node 0x09 [Audio Selector] wcaps 0x300903: Stereo Amp-In
>   Amp-In caps: N/A
>   Amp-In vals:  [0x0c 0x0c]
>   Connection: 1
>      0x15
> Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
>   Pincap 0x08173c: IN OUT HP Detect
>   Pin Default 0x04214020: [Jack] HP Out at Ext Right
>     Conn = 1/8, Color = Green
>   Pin-ctls: 0xc0: OUT HP
>   Connection: 1
>      0x02
> Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
>   Pincap 0x0814: OUT Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x00:
>   Connection: 1
>      0x04
> Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
>   Pincap 0x0814: OUT Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x00:
>   Connection: 1
>      0x03
> Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
>   Pincap 0x08173c: IN OUT HP Detect
>   Pin Default 0x04a15030: [Jack] Mic at Ext Right
>     Conn = 1/8, Color = Red
>   Pin-ctls: 0x24: IN
>   Connection: 1
>      0x02
> Node 0x0e [Pin Complex] wcaps 0x400081: Stereo
>   Pincap 0x0824: IN Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x20: IN
> Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
>   Pincap 0x0814: OUT Detect
>   Pin Default 0x90170110: [Fixed] Speaker at Int N/A
>     Conn = Analog, Color = Unknown
>   Pin-ctls: 0x40: OUT
>   Connection: 1
>      0x05
> Node 0x10 [Audio Output] wcaps 0x40211: Stereo Digital
>   PCM:
>     rates [0x3e0]: 44100 48000 88200 96000 176400
>     bits [0xe]: 16 20 24
>     formats [0x5]: PCM AC3
> Node 0x11 [Pin Complex] wcaps 0x400301: Stereo Digital
>   Pincap 0x0810: OUT
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x00:
>   Connection: 2
>      0x10* 0x09
> Node 0x12 [Audio Input] wcaps 0x140311: Stereo Digital
>   PCM:
>     rates [0x160]: 44100 48000 96000
>     bits [0xe]: 16 20 24
>     formats [0x5]: PCM AC3
>   Connection: 1
>      0x13
> Node 0x13 [Pin Complex] wcaps 0x440381: Stereo Digital
>   Pincap 0x0834: IN OUT Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x00:
>   Connection: 1
>      0x18
> Node 0x14 [Pin Complex] wcaps 0x400001: Stereo
>   Pincap 0x0820: IN
>   Pin Default 0x90a7013e: [Fixed] Mic at Int N/A
>     Conn = Analog, Color = Unknown
>   Pin-ctls: 0x20: IN
> Node 0x15 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 4
>      0x0a 0x0d* 0x14 0x02
> Node 0x16 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
>   Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=0
>   Amp-Out vals:  [0x00]
> Node 0x17 [Volume Knob Widget] wcaps 0x600000: Mono
> Node 0x18 [Audio Output] wcaps 0x40201: Stereo Digital
