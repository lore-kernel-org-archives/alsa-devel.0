From: Stefan Ringel <stefan.ringel@arcor.de>
Subject: HD-Audio device unsuppored (Nvidia G2xx-series GPU
	implemented)
Date: Fri, 11 Dec 2009 17:21:34 +0100
Message-ID: <4B22718E.3070100@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net
	[151.189.21.54]) by alsa0.perex.cz (Postfix) with ESMTP id 0632F24596
	for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2009 17:21:39 +0100 (CET)
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net
	[151.189.8.18]) by mx.arcor.de (Postfix) with ESMTP id C2B3D28B1F5
	for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2009 17:21:37 +0100 (CET)
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net
	[151.189.21.54])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id B78865C739
	for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2009 17:21:37 +0100 (CET)
Received: from [192.168.2.104] (dslb-094-222-013-143.pools.arcor-ip.net
	[94.222.13.143]) (Authenticated sender: stefan.ringel@arcor.de)
	by mail-in-14.arcor-online.net (Postfix) with ESMTPA id 086ED28B206
	for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2009 17:21:36 +0100 (CET)
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

Hello Developers,

I have an unsupported HD-audio device implemented in Nvidia G2xx-series
GPU. (Vendor-ID 0x10de Device-ID 0x0be3, additional 0x0be2 and 0x0be4).
I adding this id's in downloaded snapshot and tested it -> works.

hda_intel.c
...
    { PCI_DEVICE(0x10de, 0x0d97), .driver_data = AZX_DRIVER_NVIDIA },
    { PCI_DEVICE(0x10de, 0x0be2), .driver_data = AZX_DRIVER_NVIDIA },
    { PCI_DEVICE(0x10de, 0x0be3), .driver_data = AZX_DRIVER_NVIDIA },
    { PCI_DEVICE(0x10de, 0x0be4), .driver_data = AZX_DRIVER_NVIDIA },
    /* Teradici */
...

..., but the audio-codec 0x10de000b is also unsopported! In Nvidia
Windows driver 1.00.00.59 from 2009.10.01 more alsa-unsupported
audio-codecs id's.

4x
/proc/asound/card1/codec#0
Codec: Nvidia ID b
Address: 0
Function Id: 0x1
Vendor Id: 0x10de000b
Subsystem Id: 0x10de0101
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe CP
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
  Pincap 0x09000094: OUT Detect HDMI
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x04

Stefan Ringel wrote to alsa user mail list:

    I have a G210 Graphic-Card with implemented HD-Audio device.

    lspci list:

    01:00.0 VGA compatible controller: nVidia Corporation GT200 [GeForce
    210] (rev a2)
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
    Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
    <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at fb000000 (32-bit, non-prefetchable) [size=16M]
    Region 1: Memory at d0000000 (64-bit, prefetchable) [size=256M]
    Region 3: Memory at ee000000 (64-bit, prefetchable) [size=32M]
    Region 5: I/O ports at dc00 [size=128]
    [virtual] Expansion ROM at fcf00000 [disabled] [size=512K]
    Capabilities: [60] Power Management version 3
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
    PME(D0-,D1-,D2-,D3hot-,D3cold-)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [68] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0
    Enable-
    Address: 0000000000000000 Data: 0000
    Capabilities: [78] Express (v2) Endpoint, MSI 00
    DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1
    <64us
    ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
    DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
    RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
    MaxPayload 128 bytes, MaxReadReq 512 bytes
    DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
    LnkCap: Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency L0
    <512ns, L1 <4us
    ClockPM+ Suprise- LLActRep- BwNot-
    LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk+
    ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
    LnkSta: Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive-
    BWMgmt- ABWMgmt-
    Capabilities: [b4] Vendor Specific Information <?>
    Capabilities: [100] Virtual Channel <?>
    Capabilities: [128] Power Budgeting <?>
    Capabilities: [600] Vendor Specific Information <?>
    Kernel driver in use: nvidia
    Kernel modules: nvidia, nvidiafb

    01:00.1 Audio device: nVidia Corporation Device 0be3 (rev a1)
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
    Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
    <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Interrupt: pin A routed to IRQ 7
    Region 0: Memory at fcffc000 (32-bit, non-prefetchable) [size=16K]
    Capabilities: [60] Power Management version 3
    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
    PME(D0-,D1-,D2-,D3hot-,D3cold-)
    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [68] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0
    Enable-
    Address: 0000000000000000 Data: 0000
    Capabilities: [78] Express (v2) Endpoint, MSI 00
    DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
    ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
    DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
    RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
    MaxPayload 128 bytes, MaxReadReq 512 bytes
    DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
    LnkCap: Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency L0
    <512ns, L1 <1us
    ClockPM+ Suprise- LLActRep- BwNot-
    LnkCtl: ASPM L0s L1 Enabled; RCB 128 bytes Disabled- Retrain- CommClk-
    ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
    LnkSta: Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive-
    BWMgmt- ABWMgmt-


Dark Shadow shadowofdarkness@gmail.com wrote to me:

    If there is any chance of this info helping here is my Laptop's
    unsupported hdmi audio device and the video card it is part of. Note
    the product id is a little different.

    01:00.0 VGA compatible controller: nVidia Corporation GT215 [GeForce
    GTS 250M] (rev a2)
    	Subsystem: Acer Incorporated [ALI] Device 026b
    	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
    Stepping- SERR- FastB2B- DisINTx-
    	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
    <TAbort- <MAbort- >SERR- <PERR- INTx-
    	Latency: 0
    	Interrupt: pin A routed to IRQ 16
    	Region 0: Memory at cc000000 (32-bit, non-prefetchable) [size=16M]
    	Region 1: Memory at d0000000 (64-bit, prefetchable) [size=256M]
    	Region 3: Memory at ce000000 (64-bit, prefetchable) [size=32M]
    	Region 5: I/O ports at 2000 [size=128]
    	[virtual] Expansion ROM at cd000000 [disabled] [size=512K]
    	Capabilities: [60] Power Management version 3
    		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
    		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    	Capabilities: [68] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
    		Address: 0000000000000000  Data: 0000
    	Capabilities: [78] Express (v2) Endpoint, MSI 00
    		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
    			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
    		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
    			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
    			MaxPayload 128 bytes, MaxReadReq 512 bytes
    		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
    		LnkCap:	Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency L0
    <256ns, L1 <4us
    			ClockPM+ Suprise- LLActRep- BwNot-
    		LnkCtl:	ASPM L1 Enabled; RCB 128 bytes Disabled- Retrain- CommClk+
    			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
    		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
    BWMgmt- ABWMgmt-
    	Capabilities: [b4] Vendor Specific Information <?>
    	Capabilities: [100] Virtual Channel <?>
    	Capabilities: [128] Power Budgeting <?>
    	Capabilities: [600] Vendor Specific Information <?>
    	Kernel driver in use: nvidia
    	Kernel modules: nvidia, nvidiafb

    01:00.1 Audio device: nVidia Corporation Device 0be4 (rev a1)
    	Subsystem: Acer Incorporated [ALI] Device 026b
    	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
    Stepping- SERR- FastB2B- DisINTx-
    	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
    <TAbort- <MAbort- >SERR- <PERR- INTx-
    	Latency: 0, Cache Line Size: 64 bytes
    	Interrupt: pin B routed to IRQ 10
    	Region 0: Memory at cdefc000 (32-bit, non-prefetchable) [size=16K]
    	Capabilities: [60] Power Management version 3
    		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
    		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    	Capabilities: [68] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
    		Address: 0000000000000000  Data: 0000
    	Capabilities: [78] Express (v2) Endpoint, MSI 00
    		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
    			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
    		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
    			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
    			MaxPayload 128 bytes, MaxReadReq 512 bytes
    		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
    		LnkCap:	Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency L0
    <256ns, L1 <1us
    			ClockPM+ Suprise- LLActRep- BwNot-
    		LnkCtl:	ASPM L0s L1 Enabled; RCB 128 bytes Disabled- Retrain- CommClk+
    			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
    		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-
    BWMgmt- ABWMgmt-
