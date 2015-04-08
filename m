From: Enrico Mioso <mrkiko.rs@gmail.com>
Subject: Re: Intel HDA audio on EEE PC 1101HGo
Date: Wed, 8 Apr 2015 22:25:45 +0200 (CEST)
Message-ID: <alpine.LNX.2.20.1504082223280.2631@localhost.localdomain>
References: <alpine.LNX.2.20.1504082130290.1715@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A23B72606E1
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 22:25:50 +0200 (CEST)
Received: by wgin8 with SMTP id n8so100149271wgi.0
 for <alsa-devel@alsa-project.org>; Wed, 08 Apr 2015 13:25:50 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.20.1504082130290.1715@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Enrico Mioso <mrkiko.rs@gmail.com>
Cc: alsa-devel@alsa-project.org, kailang@realtek.com, tiwai@suse.de, hui.wang@canonical.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

A note - my system is able to trigger an error message in the file 
<kernel_dir>/drivers/pci/access.c

[27938.703923] atl1c 0000:03:00.0: vpd r/w failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update

Enrico

On Wed, 8 Apr 2015, Enrico Mioso wrote:

==Date: Wed, 8 Apr 2015 21:40:53
==From: Enrico Mioso <mrkiko.rs@gmail.com>
==To: perex@perex.cz
==Cc: tiwai@suse.de, hui.wang@canonical.com, david.henningsson@canonical.com,
==    kailang@realtek.com, alsa-devel@alsa-project.org
==Subject: Intel HDA audio on EEE PC 1101HGo
==
==Hello guys.
==I am writing to you all to talk you about a strange behaviour of the Intel HDA
==Audio device on an EEE PC 1101H.
==The audio device at some point simply doesn't react to commands, giving in
==dmesgo utput like this:
==
==[22321.638079] snd_hda_intel 0000:00:1b.0: azx_get_response timeout, switching
==to polling mode: last cmd=0x00170503
==[22322.641410] snd_hda_intel 0000:00:1b.0: azx_get_response timeout, switching
==to single_cmd mode: last cmd=0x00170503
==
==This may happen when I boot the system up fresh (here there is no Windows and
==no hibernation), or when the controller goes to power-save.
==If I don't set a power save timeout, then the controller will not be
==recoverable if it gets stuck at boot. As a workaround, I set a very short
==timeout, so that when the controller fails to start audio, waiting some time
==and retrying will work.
==Preliminary infos:
==Card: HDA Intel MID
==Chip: Realtek ALC269;
==
==Thank you in advance for your help.
==Please keep me in CC - since I am not subscribed to any list.
==Enrico
==
==
==Here follows a lspci
==
==00:00.0 Host bridge: Intel Corporation System Controller Hub (SCH Poulsbo)
==(rev 07)
==	Subsystem: ASUSTeK Computer Inc. Device 83ce
==	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
==	Stepping- SERR- FastB2B- DisINTx-
==	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
==	<TAbort- <MAbort- >SERR- <PERR- INTx-
==	Latency: 0
==
==00:02.0 VGA compatible controller: Intel Corporation System Controller Hub
==(SCH Poulsbo) Graphics Controller (rev 07) (prog-if 00 [VGA controller])
==	Subsystem: ASUSTeK Computer Inc. Device 83ce
==	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
==	Stepping- SERR- FastB2B- DisINTx-
==	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
==	<TAbort- <MAbort- >SERR- <PERR- INTx-
==	Latency: 0
==	Interrupt: pin A routed to IRQ 5
==	Region 0: Memory at f3f80000 (32-bit, non-prefetchable) [size=512K]
==	Region 1: I/O ports at c880 [size=8]
==	Region 2: Memory at d0000000 (32-bit, non-prefetchable) [size=256M]
==	Region 3: Memory at f3f40000 (32-bit, non-prefetchable) [size=256K]
==	Expansion ROM at <unassigned> [disabled]
==	Capabilities: [d0] Power Management version 2
==		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
==		PME(D0-,D1-,D2-,D3hot-,D3cold-)
==		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
==	Capabilities: [b0] Vendor Specific Information: Len=07 <?>
==	Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
==		Address: 00000000  Data: 0000
==	Kernel modules: gma500_gfx
==
==00:1b.0 Audio device: Intel Corporation System Controller Hub (SCH Poulsbo) HD
==Audio Controller (rev 07)
==	Subsystem: ASUSTeK Computer Inc. Device 83ce
==	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
==	Stepping- SERR- FastB2B- DisINTx-
==	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
==	<TAbort- <MAbort- >SERR- <PERR- INTx-
==	Latency: 0, Cache Line Size: 32 bytes
==	Interrupt: pin A routed to IRQ 23
==	Region 0: Memory at f3f38000 (64-bit, non-prefetchable) [size=16K]
==	Capabilities: [50] Power Management version 2
==		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
==		PME(D0+,D1-,D2-,D3hot+,D3cold-)
==		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
==	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI
==	Capabilities: 00
==		DevCap:	MaxPayload 128 bytes, PhantFunc 0
==			ExtTag- RBE-
==		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
==		Unsupported-
==			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
==			MaxPayload 128 bytes, MaxReadReq 128 bytes
==		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
==		TransPend+
==	Capabilities: [100 v1] Virtual Channel
==		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
==		Arb:	Fixed- WRR32- WRR64- WRR128-
==		Ctrl:	ArbSelect=Fixed
==		Status:	InProgress-
==		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
==			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
==			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
==			Status:	NegoPending- InProgress-
==		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
==			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
==			Ctrl:	Enable- ID=0 ArbSelect=Fixed TC/VC=00
==			Status:	NegoPending- InProgress-
==	Capabilities: [130 v1] Root Complex Link
==		Desc:	PortNumber=0f ComponentID=00 EltType=Config
==		Link0:	Desc:	TargetPort=00 TargetComponent=00 AssocRCRB-
==		LinkType=MemMapped LinkValid+
==			Addr:	00000000f0000000
==	Kernel driver in use: snd_hda_intel
==	Kernel modules: snd_hda_intel
==
==00:1c.0 PCI bridge: Intel Corporation System Controller Hub (SCH Poulsbo) PCI
==Express Port 1 (rev 07) (prog-if 00 [Normal decode])
==	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
==	Stepping- SERR+ FastB2B- DisINTx-
==	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
==	<TAbort- <MAbort- >SERR- <PERR- INTx-
==	Latency: 0, Cache Line Size: 32 bytes
==	Interrupt: pin A routed to IRQ 16
==	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
==	I/O behind bridge: 0000e000-0000efff
==	Memory behind bridge: fbf00000-fbffffff
==	Prefetchable memory behind bridge: 80000000-801fffff
==	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
==	<TAbort- <MAbort+ <SERR- <PERR-
==	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
==		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
==	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
==		DevCap:	MaxPayload 128 bytes, PhantFunc 0
==			ExtTag- RBE+
==		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
==		Unsupported-
==			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
==			MaxPayload 128 bytes, MaxReadReq 128 bytes
==		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
==		TransPend-
==		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
==		Latency L0s <256ns, L1 <4us
==			ClockPM+ Surprise- LLActRep+ BwNot- ASPMOptComp-
==		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
==			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
==		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
==		DLActive+ BWMgmt- ABWMgmt-
==		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
==		Surprise+
==			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
==		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
==LinkChg-
==			Control: AttnInd Unknown, PwrInd Unknown, Power-
==		Interlock-
==		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
==Interlock-
==			Changed: MRL- PresDet+ LinkState+
==		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
==		CRSVisible-
==		RootCap: CRSVisible-
==		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
==	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 83ce
==	Capabilities: [a0] Power Management version 2
==		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
==		PME(D0+,D1-,D2-,D3hot+,D3cold+)
==		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
==	Kernel driver in use: pcieport
==	Kernel modules: shpchp
==
==00:1c.1 PCI bridge: Intel Corporation System Controller Hub (SCH Poulsbo) PCI
==Express Port 2 (rev 07) (prog-if 00 [Normal decode])
==	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
==	Stepping- SERR+ FastB2B- DisINTx-
==	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
==	<TAbort- <MAbort- >SERR- <PERR- INTx-
==	Latency: 0, Cache Line Size: 32 bytes
==	Interrupt: pin B routed to IRQ 17
==	Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
==	I/O behind bridge: 0000d000-0000dfff
==	Memory behind bridge: f4000000-fbefffff
==	Prefetchable memory behind bridge: cc000000-cfffffff
==	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
==	<TAbort- <MAbort+ <SERR- <PERR-
==	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
==		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
==	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
==		DevCap:	MaxPayload 128 bytes, PhantFunc 0
==			ExtTag- RBE+
==		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
==		Unsupported-
==			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
==			MaxPayload 128 bytes, MaxReadReq 128 bytes
==		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
==		TransPend-
==		LnkCap:	Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
==		Latency L0s <256ns, L1 <4us
==			ClockPM+ Surprise- LLActRep+ BwNot- ASPMOptComp-
==		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
==			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
==		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
==		DLActive+ BWMgmt- ABWMgmt-
==		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
==		Surprise+
==			Slot #0, PowerLimit 0.000W; Interlock- NoCompl-
==		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
==LinkChg-
==			Control: AttnInd Unknown, PwrInd Unknown, Power-
==		Interlock-
==		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
==Interlock-
==			Changed: MRL- PresDet+ LinkState+
==		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
==		CRSVisible-
==		RootCap: CRSVisible-
==		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
==	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 83ce
==	Capabilities: [a0] Power Management version 2
==		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
==		PME(D0+,D1-,D2-,D3hot+,D3cold+)
==		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
==	Kernel driver in use: pcieport
==	Kernel modules: shpchp
==
==00:1d.0 USB controller: Intel Corporation System Controller Hub (SCH Poulsbo)
==USB UHCI #1 (rev 07) (prog-if 00 [UHCI])
==	Subsystem: ASUSTeK Computer Inc. Device 83ce
==	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
==	Stepping- SERR- FastB2B- DisINTx-
==	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
==	<TAbort- <MAbort- >SERR- <PERR- INTx-
==	Latency: 0
==	Interrupt: pin A routed to IRQ 20
==	Region 4: I/O ports at b880 [size=32]
==	Kernel driver in use: uhci_hcd
==	Kernel modules: uhci_hcd
==
==00:1d.1 USB controller: Intel Corporation System Controller Hub (SCH Poulsbo)
==USB UHCI #2 (rev 07) (prog-if 00 [UHCI])
==	Subsystem: ASUSTeK Computer Inc. Device 83ce
==	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
==	Stepping- SERR- FastB2B- DisINTx-
==	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
==	<TAbort- <MAbort- >SERR- <PERR- INTx-
==	Latency: 0
==	Interrupt: pin B routed to IRQ 21
==	Region 4: I/O ports at c080 [size=32]
==	Kernel driver in use: uhci_hcd
==	Kernel modules: uhci_hcd
==
==00:1d.2 USB controller: Intel Corporation System Controller Hub (SCH Poulsbo)
==USB UHCI #3 (rev 07) (prog-if 00 [UHCI])
==	Subsystem: ASUSTeK Computer Inc. Device 83ce
==	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
==	Stepping- SERR- FastB2B- DisINTx-
==	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
==	<TAbort- <MAbort- >SERR- <PERR- INTx-
==	Latency: 0
==	Interrupt: pin C routed to IRQ 18
==	Region 4: I/O ports at c480 [size=32]
==	Kernel driver in use: uhci_hcd
==	Kernel modules: uhci_hcd
==
==00:1d.7 USB controller: Intel Corporation System Controller Hub (SCH Poulsbo)
==USB EHCI #1 (rev 07) (prog-if 20 [EHCI])
==	Subsystem: ASUSTeK Computer Inc. Device 83ce
==	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
==	Stepping- SERR- FastB2B- DisINTx-
==	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
==	<TAbort- <MAbort- >SERR- <PERR- INTx-
==	Latency: 0
==	Interrupt: pin D routed to IRQ 19
==	Region 0: Memory at f3f37c00 (32-bit, non-prefetchable) [size=1K]
==	Capabilities: [50] Power Management version 2
==		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
==		PME(D0+,D1-,D2-,D3hot+,D3cold+)
==		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
==	Capabilities: [58] Debug port: BAR=1 offset=00a0
==	Kernel driver in use: ehci-pci
==	Kernel modules: ehci_pci
==
==00:1f.0 ISA bridge: Intel Corporation System Controller Hub (SCH Poulsbo) LPC
==Bridge (rev 07)
==	Subsystem: ASUSTeK Computer Inc. Device 83ce
==	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
==	Stepping- SERR- FastB2B- DisINTx-
==	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
==	<TAbort- <MAbort- >SERR- <PERR- INTx-
==	Kernel driver in use: lpc_sch
==	Kernel modules: lpc_sch
==
==00:1f.1 IDE interface: Intel Corporation System Controller Hub (SCH Poulsbo)
==IDE Controller (rev 07) (prog-if 80 [Master])
==	Subsystem: ASUSTeK Computer Inc. Device 83ce
==	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
==	Stepping- SERR- FastB2B- DisINTx-
==	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
==	<TAbort- <MAbort- >SERR- <PERR- INTx-
==	Latency: 0
==	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable)
==	[size=8]
==	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable)
==	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable)
==	[size=8]
==	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable)
==	Region 4: I/O ports at ffa0 [size=16]
==	Kernel driver in use: pata_sch
==	Kernel modules: pata_sch, pata_acpi, ata_generic
==
==01:00.0 Network controller: Qualcomm Atheros AR9285 Wireless Network Adapter
==(PCI-Express) (rev 01)
==	Subsystem: AzureWave AW-NE785 / AW-NE785H 802.11bgn Wireless Full or
==	Half-size Mini PCIe Card
==	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
==	Stepping- SERR+ FastB2B- DisINTx-
==	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
==	<TAbort- <MAbort- >SERR- <PERR- INTx-
==	Latency: 0, Cache Line Size: 32 bytes
==	Interrupt: pin A routed to IRQ 17
==	Region 0: Memory at fbef0000 (64-bit, non-prefetchable) [size=64K]
==	Capabilities: [40] Power Management version 3
==		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA
==		PME(D0+,D1+,D2-,D3hot+,D3cold+)
==		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
==	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
==		Address: 00000000  Data: 0pcilib: sysfs_read_vpd: read failed:
==Connection timed out
==000
==	Capabilities: [60] Express (v2) Legacy Endpoint, MSI 00
==		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns,
==		L1 <64us
==			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
==		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
==		Unsupported-
==			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
==			MaxPayload 128 bytes, MaxReadReq 512 bytes
==		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+
==		TransPend-
==		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
==		Latency L0s <512ns, L1 <64us
==			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
==		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
==			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
==		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
==		DLActive- BWMgmt- ABWMgmt-
==		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-,
==		OBFF Not Supported
==		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
==		OBFF Disabled
==		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
==		SpeedDis-
==			 Transmit Margin: Normal Operating Range,
==			 EnterModifiedCompliance- ComplianceSOS-
==			 Compliance De-emphasis: -6dB
==		LnkSta2: Current De-emphasis Level: -6dB,
==		EqualizationComplete-, EqualizationPhase1-
==			 EqualizationPhase2-, EqualizationPhase3-,
==			 LinkEqualizationRequest-
==	Capabilities: [100 v1] Advanced Error Reporting
==		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
==		RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
==		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
==		RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
==		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
==		RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
==		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
==		NonFatalErr+
==		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
==		NonFatalErr+
==		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+
==		ChkEn-
==	Capabilities: [140 v1] Virtual Channel
==		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
==		Arb:	Fixed- WRR32- WRR64- WRR128-
==		Ctrl:	ArbSelect=Fixed
==		Status:	InProgress-
==		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
==			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
==			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
==			Status:	NegoPending- InProgress-
==	Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
==	Capabilities: [170 v1] Power Budgeting <?>
==	Kernel driver in use: ath9k
==	Kernel modules: ath9k
==
==03:00.0 Ethernet controller: Qualcomm Atheros AR8132 Fast Ethernet (rev c0)
==	Subsystem: ASUSTeK Computer Inc. Device 14e5
==	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
==	Stepping- SERR+ FastB2B- DisINTx-
==	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
==	<TAbort- <MAbort- >SERR- <PERR- INTx-
==	Latency: 0, Cache Line Size: 32 bytes
==	Interrupt: pin A routed to IRQ 24
==	Region 0: Memory at fbfc0000 (64-bit, non-prefetchable) [size=256K]
==	Region 2: I/O ports at e880 [size=128]
==	Capabilities: [40] Power Management version 3
==		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
==		PME(D0+,D1+,D2+,D3hot+,D3cold+)
==		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
==	Capabilities: [48] MSI: Enable+ Count=1/1 Maskable- 64bit+
==		Address: 00000000fee0300c  Data: 4122
==	Capabilities: [58] Express (v1) Endpoint, MSI 00
==		DevCap:	MaxPayload 4096 bytes, PhantFunc 0, Latency L0s <4us,
==		L1 unlimited
==			ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
==		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal-
==		Unsupported-
==			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
==			MaxPayload 128 bytes, MaxReadReq 512 bytes
==		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
==		TransPend-
==		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
==		Latency L0s unlimited, L1 unlimited
==			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
==		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
==			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
==		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
==		DLActive- BWMgmt- ABWMgmt-
==	Capabilities: [6c] Vital Product Data
==		Not readable
==	Capabilities: [100 v1] Advanced Error Reporting
==		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
==		RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
==		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
==		RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
==		UESvrt:	DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
==		RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
==		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
==		NonFatalErr-
==		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout-
==		NonFatalErr+
==		AERCap:	First Error Pointer: 14, GenCap+ CGenEn- ChkCap+
==		ChkEn-
==	Capabilities: [180 v1] Device Serial Number ff-25-f6-3a-90-e6-ba-ff
==	Kernel driver in use: atl1c
==	Kernel modules: atl1c
==
==
