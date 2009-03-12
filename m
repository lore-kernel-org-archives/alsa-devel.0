From: "Christian P. Schmidt" <schmidt@digadd.de>
Subject: How can PCI resource allocation fail?
Date: Fri, 13 Mar 2009 02:07:11 +0300
Message-ID: <49B9959F.1080705@digadd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.digadd.de (mx2.digadd.de [195.47.195.236])
	by alsa0.perex.cz (Postfix) with ESMTP id F08E11038BE
	for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2009 00:05:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm toying with the alsa-driver for the Creative Labs X-Fi. I'm working on the PCI Express version of this card, though, which is
the same as the PCI version plus a PCIe to PCI bridge but has a different ID:

          +-1c.2-[0000:03-04]----00.0-[0000:04]----00.0  1102:0009

03:00.0 PCI bridge: Creative Labs Device 7006
04:00.0 Audio device: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG

Now, after adding the ID, the driver fails:

[46833.487579] CA0106 0000:04:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[46833.487586] CA0106 0000:04:00.0: PCI INT A disabled
[46833.487588] cannot allocate the port
[46833.487594] CA0106: probe of 0000:04:00.0 failed with error -16

The actual error is occurring in

	chip->port = pci_resource_start(pci, 0);
	chip->res_port = request_region(chip->port, pci_resource_len(pci,0), "snd_ca0106");
	if (!chip->res_port) {
		snd_ca0106_free(chip);
		printk(KERN_ERR "cannot allocate the port\n");
		return -EBUSY;
	}

This from /proc/iomem:

f9f00000-f9ffffff : PCI Bus 0000:03
  f9f00000-f9ffffff : PCI Bus 0000:04
    f9ffc000-f9ffffff : 0000:04:00.0

Some additional debug output tells me that the code is actually trying to allocate 16k starting from f9ffc000. What could be
potential reasons for the failure? Do I have to do something with the bridge before I can try to request the region?

Regards,
Christian

PS: lcpci -vv output afterwards, can't see anything special here.

03:00.0 PCI bridge: Creative Labs Device 7006 (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=03, secondary=04, subordinate=04, sec-latency=64
	Memory behind bridge: f9f00000-f9ffffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Capabilities: [60] MSI: Mask- 64bit+ Count=1/16 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [80] Subsystem: Creative Labs Device 0010
	Capabilities: [90] Express (v1) PCI/PCI-X Bridge, MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ BrConfRtry-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <16us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-

04:00.0 Audio device: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
	Subsystem: Creative Labs Device 0018
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at f9ffc000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [dc] Power Management version 3
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel modules: snd-ca0106
