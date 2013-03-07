From: Stefan de Konink <stefan@konink.de>
Subject: Creative CA0132 1102:0012 (rev 01)
Date: Thu, 7 Mar 2013 03:27:48 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1303070300100.29097@kinkrsoftware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kinkrsoftware.nl (kinkrsoftware.nl [37.122.130.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 94102265CFD
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2013 03:27:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by kinkrsoftware.nl (Postfix) with ESMTPSA id 112642F12
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2013 03:27:51 +0100 (CET)
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

I've been the proud owner of a Creative PCIe soundcard, sadly getting 
anything else but static noise out of it while playing a file seems 
impossible. After the device is closed the noise stops again.

The mixer does function in all aspects, muting, volume etc.

HDAAnalyzer shows that I should get output from CA0132 Analog, I have 
validated this by manipulating the PIN Widget Controls.


Is there any documentation available on this specific device? It seemed 
that some DSP work was done recently by Creative. I wouldn't mind to do 
some hacking myself, but it is hard for me to believe that a driver was 
posted in the 1.0.25 release that didn't have any normal functioning 
analogue output.

Stefan

03:00.0 0403: 1102:0012 (rev 01)
         Subsystem: 1102:0013
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 18
         Region 0: Memory at f7104000 (64-bit, non-prefetchable) [size=16K]
         Region 2: Memory at f7100000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
                 Address: 0000000000000000  Data: 0000
                 Masking: 00000000  Pending: 00000000
         Capabilities: [70] Express (v2) Endpoint, MSI 00
                 DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
<1us, L1 <8us
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Latency L0 <512ns, L1 <16us
                         ClockPM- Surprise- LLActRep- BwNot-
                 LnkCtl: ASPM L0s Enabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Not Supported, TimeoutDis+, 
LTR-, OBFF Not Supported
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, 
LTR-, OBFF Disabled
                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
SpeedDis-
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
         Capabilities: [100 v1] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                 AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ 
ChkEn-
         Capabilities: [140 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                 Arb:    Fixed- WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                         Status: NegoPending- InProgress-
                 VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable- ID=1 ArbSelect=Fixed TC/VC=00
                         Status: NegoPending- InProgress-
         Capabilities: [170 v1] Device Serial Number 
00-00-00-00-00-00-00-00
         Capabilities: [180 v1] Power Budgeting <?>
         Kernel driver in use: snd_hda_intel



snd                    49214  11 
snd_hwdep,snd_timer,snd_pcm,snd_hda_codec,snd_hda_intel,snd_hda_codec_ca0132
