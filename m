From: Steven Young <sdyoung@miranda.org>
Subject: Sound trouble with MCP61 chipset.
Date: Tue, 18 Sep 2007 14:02:21 -0400
Message-ID: <20070918180221.GI29734@miranda.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from miranda.org (miranda.org [216.93.242.2])
	by alsa0.perex.cz (Postfix) with SMTP id E481910388A
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 20:02:27 +0200 (CEST)
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


  Hi,

  I had sent a message a couple of weeks ago regarding a somewhat
reproducible error I'm having with onboard audio for systems with the
MCP61 chipset.  Specifically, the left channel doesn't work, and emits a
high-pitched tone whenever the audio device is open.  Also, adjusting
the volume disables all sound until the kernel modules for sound are all
reloaded.  

  I didn't receive any response to that message; is this the right place
to ask? I have two machines, both with the MCP61 chipset, and both with
the same problem.  I have included the lspci -v output of one of them
below.

  Thanks,
  Steve.

00:00.0 RAM memory: nVidia Corporation MCP61 Memory Controller (rev a1)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8234
	Flags: bus master, 66MHz, fast devsel, latency 0
	Capabilities: [44] HyperTransport: Slave or Primary Interface
	Capabilities: [dc] HyperTransport: MSI Mapping

00:01.0 ISA bridge: nVidia Corporation MCP61 LPC Bridge (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8234
	Flags: bus master, 66MHz, fast devsel, latency 0

00:01.1 SMBus: nVidia Corporation MCP61 SMBus (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8234
	Flags: 66MHz, fast devsel, IRQ 10
	I/O ports at dc00 [size=64]
	I/O ports at 0600 [size=64]
	I/O ports at 0700 [size=64]
	Capabilities: [44] Power Management version 2

00:01.2 RAM memory: nVidia Corporation MCP61 Memory Controller (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8234
	Flags: 66MHz, fast devsel

00:01.3 Co-processor: nVidia Corporation MCP61 SMU (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8234
	Flags: 66MHz, fast devsel
	Memory at 40100000 (32-bit, non-prefetchable) [disabled]
[size=512K]

00:02.0 USB Controller: nVidia Corporation MCP61 USB Controller (rev a2)
(prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8234
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 16
	Memory at dfe7f000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2

00:02.1 USB Controller: nVidia Corporation MCP61 USB Controller (rev a2)
(prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8234
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 19
	Memory at dfe7ec00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] Debug port
	Capabilities: [80] Power Management version 2

00:04.0 PCI bridge: nVidia Corporation MCP61 PCI bridge (rev a1)
(prog-if 01 [Subtractive decode])
	Flags: bus master, 66MHz, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: dff00000-dfffffff
	Prefetchable memory behind bridge: 40000000-400fffff
	Capabilities: [b8] Subsystem: nVidia Corporation Unknown device
cb84
	Capabilities: [8c] HyperTransport: MSI Mapping

00:05.0 Audio device: nVidia Corporation MCP61 High Definition Audio
(rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8234
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 19
	Memory at dfe78000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+
Queue=0/0 Enable-
	Capabilities: [6c] HyperTransport: MSI Mapping

00:06.0 IDE interface: nVidia Corporation MCP61 IDE (rev a2) (prog-if 8a
[Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8234
	Flags: bus master, 66MHz, fast devsel, latency 0
	[virtual] Memory at 000001f0 (32-bit, non-prefetchable)
[disabled] [size=8]
	[virtual] Memory at 000003f0 (type 3, non-prefetchable)
[disabled] [size=1]
	[virtual] Memory at 00000170 (32-bit, non-prefetchable)
[disabled] [size=8]
	[virtual] Memory at 00000370 (type 3, non-prefetchable)
[disabled] [size=1]
	I/O ports at ffa0 [size=16]
	Capabilities: [44] Power Management version 2

00:07.0 Bridge: nVidia Corporation MCP61 Ethernet (rev a2)
	Subsystem: ASUSTeK Computer Inc. Unknown device 8234
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 17
	Memory at dfe7d000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at d480 [size=8]
	Capabilities: [44] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+
Queue=0/3 Enable-
	Capabilities: [6c] HyperTransport: MSI Mapping

00:08.0 IDE interface: nVidia Corporation MCP61 SATA Controller (rev a2)
(prog-if 85 [Master SecO PriO])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8234
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 20
	I/O ports at d400 [size=8]
	I/O ports at d080 [size=4]
	I/O ports at d000 [size=8]
	I/O ports at cc00 [size=4]
	I/O ports at c880 [size=16]
	Memory at dfe7c000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
	Capabilities: [b0] Message Signalled Interrupts: Mask- 64bit+
Queue=0/2 Enable-
	Capabilities: [cc] HyperTransport: MSI Mapping

00:08.1 IDE interface: nVidia Corporation MCP61 SATA Controller (rev a2)
(prog-if 85 [Master SecO PriO])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8234
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 16
	I/O ports at c800 [size=8]
	I/O ports at c480 [size=4]
	I/O ports at c400 [size=8]
	I/O ports at c080 [size=4]
	I/O ports at c000 [size=16]
	Memory at dfe73000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
	Capabilities: [b0] Message Signalled Interrupts: Mask- 64bit+
Queue=0/2 Enable-
	Capabilities: [cc] HyperTransport: MSI Mapping

00:09.0 PCI bridge: nVidia Corporation MCP61 PCI Express bridge (rev a2)
(prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Capabilities: [40] Subsystem: nVidia Corporation Unknown device
0000
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
Queue=0/1 Enable-
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0

00:0b.0 PCI bridge: nVidia Corporation MCP61 PCI Express bridge (rev a2)
(prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	Capabilities: [40] Subsystem: nVidia Corporation Unknown device
0000
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
Queue=0/1 Enable-
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0

00:0c.0 PCI bridge: nVidia Corporation MCP61 PCI Express bridge (rev a2)
(prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	Capabilities: [40] Subsystem: nVidia Corporation Unknown device
0000
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
Queue=0/1 Enable-
	Capabilities: [60] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0

00:0d.0 VGA compatible controller: nVidia Corporation GeForce 6100
nForce 430 (rev a2) (prog-if 00 [VGA])
	Subsystem: ASUSTeK Computer Inc. Unknown device 8234
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 17
	Memory at de000000 (32-bit, non-prefetchable) [size=16M]
	Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Memory at dd000000 (64-bit, non-prefetchable) [size=16M]
	[virtual] Expansion ROM at dfe40000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
	Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
	Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
	Flags: fast devsel
	Capabilities: [f0] #0f [0010]

01:06.0 Ethernet controller: ADMtek NC100 Network Everywhere Fast
Ethernet 10/100 (rev 11)
	Subsystem: Accton Technology Corporation Unknown device 1216
	Flags: bus master, medium devsel, latency 64, IRQ 18
	I/O ports at e800 [size=256]
	Memory at dffffc00 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at 40000000 [disabled] [size=128K]
	Capabilities: [c0] Power Management version 2

01:07.0 FireWire (IEEE 1394): NEC Corporation uPD72874 IEEE1394 OHCI 1.1
3-port PHY-Link Ctrlr (rev 01) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation uPD72874 IEEE1394 OHCI 1.1 3-port
PHY-Link Ctrlr
	Flags: bus master, medium devsel, latency 64, IRQ 21
	Memory at dfffe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
