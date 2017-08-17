From: Sam Mulvey <sam@vis.nu>
Subject: Digigram VX222e not seen as card
Date: Thu, 17 Aug 2017 16:18:11 -0700
Message-ID: <3c44e553-7b05-5d9f-8590-271e1176b3b5@vis.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.vis.nu (vac.vis.nu [167.114.122.66])
 by alsa0.perex.cz (Postfix) with ESMTP id A4CD126648D
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 01:18:14 +0200 (CEST)
Received: from smtp.vis.nu (vac [127.0.0.1])
 by smtp.vis.nu (Postfix) with ESMTP id 0F30D2005225
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 16:18:13 -0700 (PDT)
Received: from [100.82.1.0] (50-197-82-238-static.hfc.comcastbusiness.net
 [50.197.82.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: sam@vis.nu)
 by smtp.vis.nu (Postfix) with ESMTPSA id B4CA62005448
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 16:18:12 -0700 (PDT)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A radio station I'm working on has a machine with a Digigram VX222e
connected to it.

According to the Digigram site and the ALSA website, the sound card is
supported by ALSA. Unfortunately, it doesn't appear to be detected as a
sound card. Reading online, it requires some firmware, but it appears
that my system has the proper firmware installed.

The VX222e is a PCIe card, but it appears to be PCI on the card with a
PCIe to PCI bridge. According to Digigram's support site, they made a
hardware change in March of 2017, and I suspect that this might be the
problem.

I'm guessing it might be as simple enough as an ID match that I need to
add to a module, but I've never worked with the card before, and I'm a
little stuck.

There's nothing regarding the card in dmesg, but it is visible in lspci:

03:00.0 PCI bridge: PLX Technology, Inc. PEX 8111 PCI Express-to-PCI
Bridge (rev 21) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 3
        NUMA node: 0
        Bus: primary=03, secondary=04, subordinate=04, sec-latency=32
        I/O behind bridge: 0000e000-0000efff [size=4K]
        Memory behind bridge: fde00000-fdefffff [size=1M]
        Prefetchable memory behind bridge: fdd00000-fddfffff [size=1M]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [60] Express (v1) PCI-Express to PCI/PCI-X Bridge,
MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE-
SlotPowerLimit 25.000W
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
BrConfRtry-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr-
TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <1us, L1 <16us
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Power Budgeting <?>
        Kernel modules: shpchp

04:04.0 Multimedia audio controller: PLX Technology, Inc. PCI9056 32-bit
66MHz PCI <-> IOBus Bridge
        Subsystem: Digigram Device ba41
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 3
        NUMA node: 0
        Region 0: Memory at fdeff000 (32-bit, non-prefetchable) [size=512]
        Region 1: I/O ports at ec00 [size=256]
        Region 2: I/O ports at ef00 [size=128]
        Capabilities: [40] Power Management version 0
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] #00 [0000]
        Capabilities: [4c] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Input/output error



I'm also documenting what I've got and what I've tried here:
https://vis.nu/blog/digigram_vx222e_isn_t_seen_in_arch_linux

Any pointers would be helpful.   Thanks!

-Sam
