From: Mark Hollomon <markhollomon@comcast.net>
Subject: PROBLEM: snd: Unknown parameter `device_mode'
Date: Fri, 24 Jun 2005 16:25:23 -0400
Message-ID: <42BC6C33.3040700@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from rwcrmhc14.comcast.net (rwcrmhc14.comcast.net [216.148.227.89])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 85FAE222
	for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2005 22:25:36 +0200 (MEST)
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



Linux v2.6.12 or linus' HEAD (a8ad86f2dc46356f87be1327dabc18bdbda32f50) fails.

2.6.12-rc6 or below works.

When trying to start hotplug, I get the following messages in dmesg:


[17179604.960000] snd: Unknown parameter `device_mode'
[17179604.976000] snd: Unknown parameter `device_mode'
[17179604.984000] snd: Unknown parameter `device_mode'
[17179605.032000] snd: Unknown parameter `device_mode'

And these appear in syslog:

Jun 24 12:11:46 jupiter modprobe: WARNING: Error inserting snd (/lib/modules/2.6.12-git/kernel/sound/core/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
Jun 24 12:11:46 jupiter modprobe: WARNING: Error inserting snd_timer (/lib/modules/2.6.12-git/kernel/sound/core/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
Jun 24 12:11:46 jupiter modprobe: WARNING: Error inserting snd (/lib/modules/2.6.12-git/kernel/sound/core/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
Jun 24 12:11:46 jupiter modprobe: WARNING: Error inserting snd_timer (/lib/modules/2.6.12-git/kernel/sound/core/snd-timer.ko): Unknown symbol in module, or unknown parameter (see dmesg)
Jun 24 12:11:46 jupiter modprobe: FATAL: Error inserting snd_pcm (/lib/modules/2.6.12-git/kernel/sound/core/snd-pcm.ko): Unknown symbol in module, or unknown parameter (see dmesg)
Jun 24 12:11:46 jupiter modprobe: WARNING: Error inserting snd (/lib/modules/2.6.12-git/kernel/sound/core/snd.ko): Unknown symbol in module, or unknown parameter (see dmesg)
Jun 24 12:11:46 jupiter modprobe: WARNING: Error inserting snd_mixer_oss (/lib/modules/2.6.12-git/kernel/sound/core/oss/snd-mixer-oss.ko): Unknown symbol in module, or unknown parameter (see dmesg)


===== lspci -vvv output =====

00:00.0 Host bridge: Intel Corporation 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corporation 82865G/PE/P PCI to AGP Controller (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fc900000-fe9fffff
	Prefetchable memory behind bridge: e7f00000-f7efffff
	BridgeCtl: Parity+ SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7880
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at e000 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7880
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at e400 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7880
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at e800 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7880
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at ec00 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7880
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fea00000-feafffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7880
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at fc00 [size=16]
	Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7880
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 0c00 [size=32]

00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at dc00 [size=256]
	Region 1: I/O ports at d800 [size=64]
	Region 2: Memory at febffa00 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at febff900 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] (rev a1) (prog-if 00 [VGA])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 9110
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at fe9e0000 [disabled] [size=128K]
	Capabilities: <available only to root>

02:05.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at feaff800 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at cc00 [size=128]
	Capabilities: <available only to root>

02:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 788c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at c800 [size=256]
	Region 1: Memory at feaff700 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at fead0000 [disabled] [size=64K]
	Capabilities: <available only to root>

-- 
Mark Hollomon



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
