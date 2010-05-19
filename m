From: "mutenmaster@tiscali.it" <mutenmaster@tiscali.it>
Subject: snd_intel_hda : broken microphone
Date: Wed, 19 May 2010 11:33:07 +0200 (CEST)
Message-ID: <6105482.89601274261587178.JavaMail.defaultUser@defaultHost>
Reply-To: "mutenmaster@tiscali.it" <mutenmaster@tiscali.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_4247_2126588.1274261587176"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mrqout2.tiscali.it (mrqout2a.tiscali.it [195.130.225.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 15E3E1038C6
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 11:33:11 +0200 (CEST)
Received: from ps-wm3 (10.39.75.203) by mail-4.mail.tiscali.sys (8.0.031)
	id 4BED2358001CF891 for alsa-devel@alsa-project.org;
	Wed, 19 May 2010 11:33:07 +0200
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

------=_Part_4247_2126588.1274261587176
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

hello people,

i am really determined in letting you know, for the=20
third time,
that my front mic input does not work. i do not know if the=20
rear
one works, i suspect not, but it's not important, because
before=20
the following commit, the front mic input worked:

$ sudo git bisect=20
bad
f5271101faf1655d862849f42518c2a88ef394fb
is the first bad commit

commit f5271101faf1655d862849f42518c2a88ef394fb

Author: Lydia Wang=20
<lydiawang@viatech.com.cn>
Date:   Sat Oct 10 19:07:
35 2009 +0800

   =20
ALSA HDA VIA: Add VIA_CTL_WIDGET_ANALOG_MUTE
control type
  =20
    Enter=20
low power state if AA-Path volume is muted.

  =20
    Signed-off-by:=20
Lydia Wang <lydiawang@viatech.com.cn>
  =20
Signed-off-by: Logan Li=20
<loganli@viatech.com.cn>
    Signed-off-by:
Takashi Iwai <tiwai@suse.
de>

:040000 040000
ab1ae14ff67f0b08848faeb3ad68def7f3e727f0

0bfbfde11fe32e87e8edbdb3c4d03c2d30370393 M      sound

i'm copypasting=20
the lspci ouput, so that you can have a general idea
of what kind of=20
machine i have. please let me know if there is
any other info you need=20
to solve this bug.

more details on the problem:
doing=20
$ arecord -f cd=20
test.wav

produces a file of 44 bytes. it's as if no microphone is=20
attached
to the jack. this behaviour has been evolving from the commit

i showed you forth. at the beginning, a file with actual data was

produced, but no audio came out of the speakers when reproducing
it.=20
going on with the commits, the file became 44 bytes long.

yours,

vasilis

--

$ lspci -vvv

00:00.0 Host bridge: Advanced Micro Devices=20
[AMD] RS780 Host Bridge Alternate
=09Subsystem: ASUSTeK Computer Inc.=20
Device 83a2
=09Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=09Status: Cap+=20
66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort+=20
>SERR- <PERR- INTx-
=09Latency: 0
=09Capabilities: [c4] HyperTransport:=20
Slave or Primary Interface
=09=09Command: BaseUnitID=3D0 UnitCnt=3D12 MastHost-=20
DefDir- DUL-
=09=09Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO-=20
<CRCErr=3D0 IsocEn+ LSEn- ExtCTL- 64b-
=09=09Link Config 0: MLWI=3D16bit=20
DwFcIn- MLWO=3D16bit DwFcOut- LWI=3D16bit DwFcInEn- LWO=3D16bit DwFcOutEn-
=09=09
Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=3D0=20
IsocEn- LSEn- ExtCTL- 64b-
=09=09Link Config 1: MLWI=3D8bit DwFcIn- MLWO=3D8bit=20
DwFcOut- LWI=3D8bit DwFcInEn- LWO=3D8bit DwFcOutEn-
=09=09Revision ID: 3.00
=09=09
Link Frequency 0: [b]
=09=09Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
=09=09Link=20
Frequency Capability 0: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+=20
1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
=09=09Feature Capability: IsocFC-=20
LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
=09=09Link Frequency 1: 200MHz
=09=09Link=20
Error 1: <Prot- <Ovfl- <EOC- CTLTm-
=09=09Link Frequency Capability 1:=20
200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz-=20
1.6GHz- Vend-
=09=09Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE-=20
CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
=09=09
Prefetchable memory behind bridge Upper: 00-00
=09=09Bus Number: 00
=09
Capabilities: [54] HyperTransport: UnitID Clumping
=09Capabilities: [40]=20
HyperTransport: Retry Mode
=09Capabilities: [9c] HyperTransport: #1a
=09
Capabilities: [f8] HyperTransport: #1c

00:02.0 PCI bridge: Advanced=20
Micro Devices [AMD] RS780 PCI to PCI bridge (ext gfx port 0) (prog-if=20
00 [Normal decode])
=09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
=09Status: Cap+=20
66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <MAbort-=20
>SERR- <PERR- INTx-
=09Latency: 0, Cache Line Size: 64 bytes
=09Bus:=20
primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
=09I/O behind=20
bridge: 0000d000-0000dfff
=09Memory behind bridge: fea00000-feafffff
=09
Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
=09
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-=
=20
<MAbort- <SERR- <PERR-
=09BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort-=20
>Reset- FastB2B-
=09=09PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
=09
Capabilities: [50] Power Management version 3
=09=09Flags: PMEClk- DSI- D1-=20
D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
=09=09Status: D0 PME-
Enable- DSel=3D0 DScale=3D0 PME-
=09Capabilities: [58] Express (v2) Root Port=20
(Slot+), MSI 00
=09=09DevCap:=09MaxPayload 128 bytes, PhantFunc 0, Latency=20
L0s <64ns, L1 <1us
=09=09=09ExtTag+ RBE+ FLReset-
=09=09DevCtl:=09Report errors:=20
Correctable- Non-Fatal- Fatal- Unsupported-
=09=09=09RlxdOrd+ ExtTag-=20
PhantFunc- AuxPwr- NoSnoop+
=09=09=09MaxPayload 128 bytes, MaxReadReq 128=20
bytes
=09=09DevSta:=09CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-=20
TransPend-
=09=09LnkCap:=09Port #0, Speed 5GT/s, Width x16, ASPM L0s L1,=20
Latency L0 <64ns, L1 <1us
=09=09=09ClockPM- Suprise- LLActRep+ BwNot+
=09=09
LnkCtl:=09ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
=09=09=09
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
=09=09LnkSta:=09Speed 2.5GT/s,=20
Width x16, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
=09=09SltCap:=09
AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surpise-
=09=09=09Slot #  2,=20
PowerLimit 75.000000; Interlock- NoCompl+
=09=09SltCtl:=09Enable: AttnBtn-=20
PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
=09=09=09Control: AttnInd=20
Unknown, PwrInd Unknown, Power- Interlock-
=09=09SltSta:=09Status: AttnBtn-=20
PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
=09=09=09Changed: MRL- PresDet+=20
LinkState+
=09=09RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-=20
PMEIntEna- CRSVisible-
=09=09RootCap: CRSVisible-
=09=09RootSta: PME ReqID=20
0000, PMEStatus- PMEPending-
=09=09DevCap2: Completion Timeout: Not=20
Supported, TimeoutDis- ARIFwd-
=09=09DevCtl2: Completion Timeout: 50us to=20
50ms, TimeoutDis- ARIFwd-
=09=09LnkCtl2: Target Link Speed: 5GT/s,=20
EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
=09=09=09 Transmit=20
Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-

=09=09=09 Compliance De-emphasis: -6dB
=09=09LnkSta2: Current De-emphasis Level:=20
-3.5dB
=09Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit-=20
Count=3D1/1 Enable+
=09=09Address: fee0f00c  Data: 4159
=09Capabilities: [b0]=20
Subsystem: ASUSTeK Computer Inc. Device 83a2
=09Capabilities: [b8]=20
HyperTransport: MSI Mapping Enable+ Fixed+
=09Capabilities: [100] Vendor=20
Specific Information <?>
=09Capabilities: [110] Virtual Channel <?>
=09
Kernel driver in use: pcieport-driver

00:0a.0 PCI bridge: Advanced=20
Micro Devices [AMD] RS780 PCI to PCI bridge (PCIE port 5) (prog-if 00=20
[Normal decode])
=09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
=09Status: Cap+=20
66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <MAbort-=20
>SERR- <PERR- INTx-
=09Latency: 0, Cache Line Size: 64 bytes
=09Bus:=20
primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
=09I/O behind=20
bridge: 0000e000-0000efff
=09Memory behind bridge: feb00000-febfffff
=09
Prefetchable memory behind bridge: 00000000fdf00000-00000000fdffffff
=09
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-=
=20
<MAbort- <SERR- <PERR-
=09BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort-=20
>Reset- FastB2B-
=09=09PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
=09
Capabilities: [50] Power Management version 3
=09=09Flags: PMEClk- DSI- D1-=20
D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
=09=09Status: D0 PME-
Enable- DSel=3D0 DScale=3D0 PME-
=09Capabilities: [58] Express (v2) Root Port=20
(Slot+), MSI 00
=09=09DevCap:=09MaxPayload 128 bytes, PhantFunc 0, Latency=20
L0s <64ns, L1 <1us
=09=09=09ExtTag+ RBE+ FLReset-
=09=09DevCtl:=09Report errors:=20
Correctable- Non-Fatal- Fatal- Unsupported-
=09=09=09RlxdOrd+ ExtTag-=20
PhantFunc- AuxPwr- NoSnoop+
=09=09=09MaxPayload 128 bytes, MaxReadReq 128=20
bytes
=09=09DevSta:=09CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-=20
TransPend-
=09=09LnkCap:=09Port #1, Speed 5GT/s, Width x1, ASPM L0s L1,=20
Latency L0 <64ns, L1 <1us
=09=09=09ClockPM- Suprise- LLActRep+ BwNot+
=09=09
LnkCtl:=09ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
=09=09=09
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
=09=09LnkSta:=09Speed 2.5GT/s,=20
Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
=09=09SltCap:=09
AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surpise-
=09=09=09Slot #  a,=20
PowerLimit 25.000000; Interlock- NoCompl+
=09=09SltCtl:=09Enable: AttnBtn-=20
PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
=09=09=09Control: AttnInd=20
Unknown, PwrInd Unknown, Power- Interlock-
=09=09SltSta:=09Status: AttnBtn-=20
PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
=09=09=09Changed: MRL- PresDet+=20
LinkState+
=09=09RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-=20
PMEIntEna- CRSVisible-
=09=09RootCap: CRSVisible-
=09=09RootSta: PME ReqID=20
0000, PMEStatus- PMEPending-
=09=09DevCap2: Completion Timeout: Not=20
Supported, TimeoutDis- ARIFwd-
=09=09DevCtl2: Completion Timeout: 50us to=20
50ms, TimeoutDis- ARIFwd-
=09=09LnkCtl2: Target Link Speed: 2.5GT/s,=20
EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
=09=09=09 Transmit=20
Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-

=09=09=09 Compliance De-emphasis: -6dB
=09=09LnkSta2: Current De-emphasis Level:=20
-6dB
=09Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit-=20
Count=3D1/1 Enable+
=09=09Address: fee0f00c  Data: 4161
=09Capabilities: [b0]=20
Subsystem: ASUSTeK Computer Inc. Device 83a2
=09Capabilities: [b8]=20
HyperTransport: MSI Mapping Enable+ Fixed+
=09Capabilities: [100] Vendor=20
Specific Information <?>
=09Capabilities: [110] Virtual Channel <?>
=09
Kernel driver in use: pcieport-driver

00:11.0 SATA controller: ATI=20
Technologies Inc SB700/SB800 SATA Controller [AHCI mode] (prog-if 01=20
[AHCI 1.0])
=09Subsystem: ASUSTeK Computer Inc. Device 8389
=09Control:=20
I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-=20
SERR+ FastB2B- DisINTx-
=09Status: Cap+ 66MHz+ UDF- FastB2B- ParErr-=20
DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=09Latency:=20
64, Cache Line Size: 64 bytes
=09Interrupt: pin A routed to IRQ 22
=09
Region 0: I/O ports at c000 [size=3D8]
=09Region 1: I/O ports at b000=20
[size=3D4]
=09Region 2: I/O ports at a000 [size=3D8]
=09Region 3: I/O ports at=20
9000 [size=3D4]
=09Region 4: I/O ports at 8000 [size=3D16]
=09Region 5: Memory=20
at fe9ffc00 (32-bit, non-prefetchable) [size=3D1K]
=09Capabilities: [60]=20
Power Management version 2
=09=09Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
=09=09Status: D0 PME-Enable- DSel=3D0=20
DScale=3D0 PME-
=09Capabilities: [70] SATA HBA <?>
=09Kernel driver in use:=20
ahci

00:12.0 USB Controller: ATI Technologies Inc SB700/SB800 USB=20
OHCI0 Controller (prog-if 10 [OHCI])
=09Subsystem: ASUSTeK Computer Inc.=20
Device 8389
=09Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
=09Status: Cap-=20
66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort-=20
>SERR- <PERR- INTx-
=09Latency: 64, Cache Line Size: 64 bytes
=09Interrupt:=20
pin A routed to IRQ 16
=09Region 0: Memory at fe9fe000 (32-bit, non-
prefetchable) [size=3D4K]
=09Kernel driver in use: ohci_hcd
=09Kernel=20
modules: ohci-hcd

00:12.1 USB Controller: ATI Technologies Inc SB700=20
USB OHCI1 Controller (prog-if 10 [OHCI])
=09Subsystem: ASUSTeK Computer=20
Inc. Device 8389
=09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+=20
VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
=09Status: Cap-=20
66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort-=20
>SERR- <PERR- INTx-
=09Latency: 64, Cache Line Size: 64 bytes
=09Interrupt:=20
pin A routed to IRQ 16
=09Region 0: Memory at fe9fd000 (32-bit, non-
prefetchable) [size=3D4K]
=09Kernel driver in use: ohci_hcd
=09Kernel=20
modules: ohci-hcd

00:12.2 USB Controller: ATI Technologies Inc=20
SB700/SB800 USB EHCI Controller (prog-if 20 [EHCI])
=09Subsystem: ASUSTeK=20
Computer Inc. Device 8389
=09Control: I/O- Mem+ BusMaster+ SpecCycle-=20
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
=09Status:=20
Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-=20
<MAbort- >SERR- <PERR- INTx-
=09Latency: 64, Cache Line Size: 64 bytes
=09
Interrupt: pin B routed to IRQ 17
=09Region 0: Memory at fe9ff800 (32-
bit, non-prefetchable) [size=3D256]
=09Capabilities: [c0] Power Management=20
version 2
=09=09Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,
D3hot+,D3cold-)
=09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
=09=09Bridge:=20
PM- B3+
=09Capabilities: [e4] Debug port: BAR=3D1 offset=3D00e0
=09Kernel=20
driver in use: ehci_hcd
=09Kernel modules: ehci-hcd

00:13.0 USB=20
Controller: ATI Technologies Inc SB700/SB800 USB OHCI0 Controller (prog-
if 10 [OHCI])
=09Subsystem: ASUSTeK Computer Inc. Device 8389
=09Control:=20
I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-=20
SERR+ FastB2B- DisINTx-
=09Status: Cap- 66MHz+ UDF- FastB2B+ ParErr-=20
DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=09Latency:=20
64, Cache Line Size: 64 bytes
=09Interrupt: pin A routed to IRQ 18
=09
Region 0: Memory at fe9fc000 (32-bit, non-prefetchable) [size=3D4K]
=09
Kernel driver in use: ohci_hcd
=09Kernel modules: ohci-hcd

00:13.1 USB=20
Controller: ATI Technologies Inc SB700 USB OHCI1 Controller (prog-if 10=20
[OHCI])
=09Subsystem: ASUSTeK Computer Inc. Device 8389
=09Control: I/O+=20
Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+=20
FastB2B- DisINTx-
=09Status: Cap- 66MHz+ UDF- FastB2B+ ParErr-=20
DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=09Latency:=20
64, Cache Line Size: 64 bytes
=09Interrupt: pin A routed to IRQ 18
=09
Region 0: Memory at fe9fb000 (32-bit, non-prefetchable) [size=3D4K]
=09
Kernel driver in use: ohci_hcd
=09Kernel modules: ohci-hcd

00:13.2 USB=20
Controller: ATI Technologies Inc SB700/SB800 USB EHCI Controller (prog-
if 20 [EHCI])
=09Subsystem: ASUSTeK Computer Inc. Device 8389
=09Control:=20
I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-=20
SERR+ FastB2B- DisINTx-
=09Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr-=20
DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=09Latency:=20
64, Cache Line Size: 64 bytes
=09Interrupt: pin B routed to IRQ 19
=09
Region 0: Memory at fe9ff400 (32-bit, non-prefetchable) [size=3D256]
=09
Capabilities: [c0] Power Management version 2
=09=09Flags: PMEClk- DSI- D1+=20
D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
=09=09Status: D0 PME-
Enable- DSel=3D0 DScale=3D0 PME-
=09=09Bridge: PM- B3+
=09Capabilities: [e4]=20
Debug port: BAR=3D1 offset=3D00e0
=09Kernel driver in use: ehci_hcd
=09Kernel=20
modules: ehci-hcd

00:14.0 SMBus: ATI Technologies Inc SBx00 SMBus=20
Controller (rev 3c)
=09Subsystem: ASUSTeK Computer Inc. Device 8389
=09
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx+
=09Status: Cap+ 66MHz+ UDF- FastB2B-=20
ParErr- DEVSEL=3Dmedium >TAbort- <TAbort+ <MAbort- >SERR- <PERR- INTx-
=09
Capabilities: [b0] HyperTransport: MSI Mapping Enable- Fixed+

00:14.1=20
IDE interface: ATI Technologies Inc SB700/SB800 IDE Controller (prog-if=20
8a [Master SecP PriP])
=09Subsystem: ASUSTeK Computer Inc. Device 8389
=09
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B- DisINTx-
=09Status: Cap+ 66MHz+ UDF- FastB2B-=20
ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=09
Latency: 64
=09Interrupt: pin A routed to IRQ 16
=09Region 0: I/O ports at=20
01f0 [size=3D8]
=09Region 1: I/O ports at 03f4 [size=3D1]
=09Region 2: I/O=20
ports at 0170 [size=3D8]
=09Region 3: I/O ports at 0374 [size=3D1]
=09Region 4:=20
I/O ports at ff00 [size=3D16]
=09Capabilities: [70] Message Signalled=20
Interrupts: Mask- 64bit- Count=3D1/1 Enable-
=09=09Address: 00000000  Data:=20
0000
=09Kernel driver in use: pata_atiixp

00:14.2 Audio device: ATI=20
Technologies Inc SBx00 Azalia (Intel HDA)
=09Subsystem: ASUSTeK Computer=20
Inc. Device 836c
=09Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=09Status: Cap+=20
66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- <TAbort- <MAbort-=20
>SERR- <PERR- INTx-
=09Latency: 64, Cache Line Size: 64 bytes
=09Interrupt:=20
pin ? routed to IRQ 16
=09Region 0: Memory at fe9f4000 (64-bit, non-
prefetchable) [size=3D16K]
=09Capabilities: [50] Power Management version 2

=09=09Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA PME(D0+,D1-,D2-,D3hot+,
D3cold+)
=09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
=09Kernel driver=20
in use: HDA Intel
=09Kernel modules: snd-hda-intel

00:14.3 ISA bridge:=20
ATI Technologies Inc SB700/SB800 LPC host controller
=09Subsystem:=20
ASUSTeK Computer Inc. Device 8389
=09Control: I/O+ Mem+ BusMaster+=20
SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-

=09Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
=09Latency: 0

00:14.4 PCI bridge:=20
ATI Technologies Inc SBx00 PCI to PCI Bridge (prog-if 01 [Subtractive=20
decode])
=09Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR+ FastB2B- DisINTx-
=09Status: Cap- 66MHz+ UDF-=20
FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-=
=20
INTx-
=09Latency: 64
=09Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-
latency=3D64
=09I/O behind bridge: 0000f000-00000fff
=09Memory behind bridge:=20
fff00000-000fffff
=09Prefetchable memory behind bridge: fff00000-000fffff

=09Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=20
<TAbort- <MAbort+ <SERR- <PERR-
=09BridgeCtl: Parity+ SERR+ NoISA+ VGA-=20
MAbort- >Reset- FastB2B-
=09=09PriDiscTmr- SecDiscTmr- DiscTmrStat-=20
DiscTmrSERREn-

00:14.5 USB Controller: ATI Technologies Inc=20
SB700/SB800 USB OHCI2 Controller (prog-if 10 [OHCI])
=09Subsystem:=20
ASUSTeK Computer Inc. Device 8389
=09Control: I/O- Mem+ BusMaster+=20
SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-

=09Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
=09Latency: 64, Cache Line Size: 64=20
bytes
=09Interrupt: pin C routed to IRQ 18
=09Region 0: Memory at fe9fa000=20
(32-bit, non-prefetchable) [size=3D4K]
=09Kernel driver in use: ohci_hcd
=09
Kernel modules: ohci-hcd

00:18.0 Host bridge: Advanced Micro Devices=20
[AMD] Family 10h [Opteron, Athlon64, Sempron] HyperTransport=20
Configuration
=09Control: I/O- Mem- BusMaster- SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=09Status: Cap+=20
66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <MAbort-=20
>SERR- <PERR- INTx-
=09Capabilities: [80] HyperTransport: Host or=20
Secondary Interface
=09=09Command: WarmRst+ DblEnd- DevNum=3D0 ChainSide-=20
HostHide+ Slave- <EOCErr- DUL-
=09=09Link Control: CFlE- CST- CFE- <LkFail-=20
Init+ EOC- TXO- <CRCErr=3D0 IsocEn+ LSEn+ ExtCTL- 64b-
=09=09Link Config:=20
MLWI=3D16bit DwFcIn- MLWO=3D16bit DwFcOut- LWI=3D16bit DwFcInEn- LWO=3D16bi=
t=20
DwFcOutEn-
=09=09Revision ID: 3.00
=09=09Link Frequency: [b]
=09=09Link Error:=20
<Prot- <Ovfl- <EOC- CTLTm-
=09=09Link Frequency Capability: 200MHz+ 300MHz-=20
400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
=09=09
Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS-=20
UCnfE-

00:18.1 Host bridge: Advanced Micro Devices [AMD] Family 10h=20
[Opteron, Athlon64, Sempron] Address Map
=09Control: I/O- Mem- BusMaster-=20
SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-

=09Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced=20
Micro Devices [AMD] Family 10h [Opteron, Athlon64, Sempron] DRAM=20
Controller
=09Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B- DisINTx-
=09Status: Cap- 66MHz- UDF-=20
FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR- <PERR-=20
INTx-
=09Kernel modules: amd64_edac_mod

00:18.3 Host bridge: Advanced=20
Micro Devices [AMD] Family 10h [Opteron, Athlon64, Sempron]=20
Miscellaneous Control
=09Control: I/O- Mem- BusMaster- SpecCycle-=20
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
=09Status:=20
Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-=20
<MAbort- >SERR- <PERR- INTx-
=09Capabilities: [f0] Secure device <?>

00:
18.4 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron,=20
Athlon64, Sempron] Link Control
=09Control: I/O- Mem- BusMaster-=20
SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-

=09Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-

01:00.0 VGA compatible=20
controller: ATI Technologies Inc Device 954f (prog-if 00 [VGA=20
controller])
=09Subsystem: ASUSTeK Computer Inc. Device 02a8
=09Control:=20
I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-=20
SERR+ FastB2B- DisINTx-
=09Status: Cap+ 66MHz- UDF- FastB2B- ParErr-=20
DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=09Latency: 0,=20
Cache Line Size: 64 bytes
=09Interrupt: pin A routed to IRQ 18
=09Region 0:=20
Memory at d0000000 (64-bit, prefetchable) [size=3D256M]
=09Region 2: Memory=20
at feaf0000 (64-bit, non-prefetchable) [size=3D64K]
=09Region 4: I/O ports=20
at d000 [size=3D256]
=09Expansion ROM at feac0000 [disabled] [size=3D128K]
=09
Capabilities: [50] Power Management version 3
=09=09Flags: PMEClk- DSI- D1+=20
D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
=09=09Status: D0 PME-
Enable- DSel=3D0 DScale=3D0 PME-
=09Capabilities: [58] Express (v2) Legacy=20
Endpoint, MSI 00
=09=09DevCap:=09MaxPayload 128 bytes, PhantFunc 0, Latency=20
L0s <4us, L1 unlimited
=09=09=09ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+=20
FLReset-
=09=09DevCtl:=09Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
=09=09=09RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
=09=09=09
MaxPayload 128 bytes, MaxReadReq 128 bytes
=09=09DevSta:=09CorrErr-=20
UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
=09=09LnkCap:=09Port #0,=20
Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency L0 <64ns, L1 <1us
=09=09=09
ClockPM- Suprise- LLActRep- BwNot-
=09=09LnkCtl:=09ASPM Disabled; RCB 64=20
bytes Disabled- Retrain- CommClk+
=09=09=09ExtSynch- ClockPM- AutWidDis-=20
BWInt- AutBWInt-
=09=09LnkSta:=09Speed 2.5GT/s, Width x16, TrErr- Train-=20
SlotClk+ DLActive- BWMgmt- ABWMgmt-
=09=09DevCap2: Completion Timeout: Not=20
Supported, TimeoutDis-
=09=09DevCtl2: Completion Timeout: 50us to 50ms,=20
TimeoutDis-
=09=09LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-=20
SpeedDis-, Selectable De-emphasis: -6dB
=09=09=09 Transmit Margin: Normal=20
Operating Range, EnterModifiedCompliance- ComplianceSOS-
=09=09=09 Compliance=20
De-emphasis: -6dB
=09=09LnkSta2: Current De-emphasis Level: -6dB
=09
Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit+ Count=3D1/1=
=20
Enable-
=09=09Address: 0000000000000000  Data: 0000
=09Capabilities: [100]=20
Vendor Specific Information <?>

01:00.1 Audio device: ATI Technologies=20
Inc Device aa38
=09Subsystem: ASUSTeK Computer Inc. Device aa38
=09Control:=20
I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-=20
SERR+ FastB2B- DisINTx+
=09Status: Cap+ 66MHz- UDF- FastB2B- ParErr-=20
DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
=09Latency: 0,=20
Cache Line Size: 64 bytes
=09Interrupt: pin B routed to IRQ 28
=09Region 0:=20
Memory at feaec000 (64-bit, non-prefetchable) [size=3D16K]
=09Capabilities:=20
[50] Power Management version 3
=09=09Flags: PMEClk- DSI- D1+ D2+=20
AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
=09=09Status: D0 PME-Enable-=20
DSel=3D0 DScale=3D0 PME-
=09Capabilities: [58] Express (v2) Legacy Endpoint,=20
MSI 00
=09=09DevCap:=09MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us,=20
L1 unlimited
=09=09=09ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
=09=09
DevCtl:=09Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
=09=09=09
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
=09=09=09MaxPayload 128 bytes,=20
MaxReadReq 128 bytes
=09=09DevSta:=09CorrErr- UncorrErr- FatalErr- UnsuppReq-=20
AuxPwr- TransPend-
=09=09LnkCap:=09Port #0, Speed 2.5GT/s, Width x16, ASPM=20
L0s L1, Latency L0 <64ns, L1 <1us
=09=09=09ClockPM- Suprise- LLActRep- BwNot-

=09=09LnkCtl:=09ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
=09=09=09
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
=09=09LnkSta:=09Speed 2.5GT/s,=20
Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
=09=09DevCap2:=20
Completion Timeout: Not Supported, TimeoutDis-
=09=09DevCtl2: Completion=20
Timeout: 50us to 50ms, TimeoutDis-
=09=09LnkCtl2: Target Link Speed: 2.5
GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
=09=09=09=20
Transmit Margin: Normal Operating Range, EnterModifiedCompliance-=20
ComplianceSOS-
=09=09=09 Compliance De-emphasis: -6dB
=09=09LnkSta2: Current De-
emphasis Level: -6dB
=09Capabilities: [a0] Message Signalled Interrupts:=20
Mask- 64bit+ Count=3D1/1 Enable+
=09=09Address: 00000000fee0f00c  Data: 4189
=09
Capabilities: [100] Vendor Specific Information <?>
=09Kernel driver in=20
use: HDA Intel
=09Kernel modules: snd-hda-intel

02:00.0 Ethernet=20
controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express=20
Gigabit Ethernet controller (rev 03)
=09Subsystem: ASUSTeK Computer Inc.=20
Device 83a3
=09Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-=20
VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
=09Status: Cap+=20
66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <MAbort-=20
>SERR- <PERR- INTx-
=09Latency: 0, Cache Line Size: 64 bytes
=09Interrupt:=20
pin A routed to IRQ 27
=09Region 0: I/O ports at e800 [size=3D256]
=09Region=20
2: Memory at fdfff000 (64-bit, prefetchable) [size=3D4K]
=09Region 4:=20
Memory at fdff8000 (64-bit, prefetchable) [size=3D16K]
=09Expansion ROM at=20
febf0000 [disabled] [size=3D64K]
=09Capabilities: [40] Power Management=20
version 3
=09=09Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,
D2+,D3hot+,D3cold+)
=09=09Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
=09
Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Count=3D1/1=
=20
Enable+
=09=09Address: 00000000fee0f00c  Data: 4179
=09Capabilities: [70]=20
Express (v2) Endpoint, MSI 01
=09=09DevCap:=09MaxPayload 256 bytes, PhantFunc=20
0, Latency L0s <512ns, L1 <64us
=09=09=09ExtTag- AttnBtn- AttnInd- PwrInd-=20
RBE+ FLReset-
=09=09DevCtl:=09Report errors: Correctable- Non-Fatal- Fatal-=20
Unsupported-
=09=09=09RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
=09=09=09
MaxPayload 128 bytes, MaxReadReq 4096 bytes
=09=09DevSta:=09CorrErr+=20
UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
=09=09LnkCap:=09Port #0,=20
Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <64us
=09=09=09
ClockPM+ Suprise- LLActRep- BwNot-
=09=09LnkCtl:=09ASPM Disabled; RCB 64=20
bytes Disabled- Retrain- CommClk+
=09=09=09ExtSynch- ClockPM- AutWidDis-=20
BWInt- AutBWInt-
=09=09LnkSta:=09Speed 2.5GT/s, Width x1, TrErr- Train-=20
SlotClk+ DLActive- BWMgmt- ABWMgmt-
=09=09DevCap2: Completion Timeout: Not=20
Supported, TimeoutDis+
=09=09DevCtl2: Completion Timeout: 50us to 50ms,=20
TimeoutDis-
=09=09LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-=20
SpeedDis-, Selectable De-emphasis: -6dB
=09=09=09 Transmit Margin: Normal=20
Operating Range, EnterModifiedCompliance- ComplianceSOS-
=09=09=09 Compliance=20
De-emphasis: -6dB
=09=09LnkSta2: Current De-emphasis Level: -6dB
=09
Capabilities: [ac] MSI-X: Enable- Mask- TabSize=3D4
=09=09Vector table: BAR=3D4=20
offset=3D00000000
=09=09PBA: BAR=3D4 offset=3D00000800
=09Capabilities: [cc] Vital=20
Product Data <?>
=09Capabilities: [100] Advanced Error Reporting
=09=09UESta:=09
DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC-=20
UnsupReq- ACSVoil-
=09=09UEMsk:=09DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-=20
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSVoil-
=09=09UESvrt:=09DLP+ SDES+=20
TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq-=20
ACSVoil-
=09=09CESta:=09RxErr- BadTLP- BadDLLP- Rollover- Timeout-=20
NonFatalErr+
=09=09CESta:=09RxErr- BadTLP- BadDLLP- Rollover- Timeout-=20
NonFatalErr+
=09=09AERCap:=09First Error Pointer: 00, GenCap+ CGenEn- ChkCap+=20
ChkEn-
=09Capabilities: [140] Virtual Channel <?>
=09Capabilities: [160]=20
Device Serial Number 00-00-00-00-00-00-00-00
=09Kernel driver in use:=20
r8169




Risparmia con Tutto Incluso Light: telefono + adsl 8 mega a soli 14,95 =E2=
=82=AC al mese.

Gratis la Sim Tiscali Mobile con 25 euro di traffico!=20

L'offerta =C3=A8 valida solo se attivi entro il 20/05/10

http://abbonati.tiscali.it/telefono-adsl/prodotti/tc/tuttoincluso_light/?WT=
.mc_id=3D01fw
------=_Part_4247_2126588.1274261587176
Content-Type: APPLICATION/OCTET-STREAM; name=lspci
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=lspci; size=24941

00:00.0 Host bridge: Advanced Micro Devices [AMD] RS780 Host Bridge Alternate
	Subsystem: ASUSTeK Computer Inc. Device 83a2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [c4] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=0 UnitCnt=12 MastHost- DefDir- DUL-
		Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn+ LSEn- ExtCTL- 64b-
		Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 3.00
		Link Frequency 0: [b]
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
		Link Frequency 1: 200MHz
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
		Prefetchable memory behind bridge Upper: 00-00
		Bus Number: 00
	Capabilities: [54] HyperTransport: UnitID Clumping
	Capabilities: [40] HyperTransport: Retry Mode
	Capabilities: [9c] HyperTransport: #1a
	Capabilities: [f8] HyperTransport: #1c

00:02.0 PCI bridge: Advanced Micro Devices [AMD] RS780 PCI to PCI bridge (ext gfx port 0) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fea00000-feafffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Latency L0 <64ns, L1 <1us
			ClockPM- Suprise- LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surpise-
			Slot #  2, PowerLimit 75.000000; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -3.5dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB
	Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit- Count=1/1 Enable+
		Address: fee0f00c  Data: 4159
	Capabilities: [b0] Subsystem: ASUSTeK Computer Inc. Device 83a2
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100] Vendor Specific Information <?>
	Capabilities: [110] Virtual Channel <?>
	Kernel driver in use: pcieport-driver

00:0a.0 PCI bridge: Advanced Micro Devices [AMD] RS780 PCI to PCI bridge (PCIE port 5) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: feb00000-febfffff
	Prefetchable memory behind bridge: 00000000fdf00000-00000000fdffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Latency L0 <64ns, L1 <1us
			ClockPM- Suprise- LLActRep+ BwNot+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surpise-
			Slot #  a, PowerLimit 25.000000; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit- Count=1/1 Enable+
		Address: fee0f00c  Data: 4161
	Capabilities: [b0] Subsystem: ASUSTeK Computer Inc. Device 83a2
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100] Vendor Specific Information <?>
	Capabilities: [110] Virtual Channel <?>
	Kernel driver in use: pcieport-driver

00:11.0 SATA controller: ATI Technologies Inc SB700/SB800 SATA Controller [AHCI mode] (prog-if 01 [AHCI 1.0])
	Subsystem: ASUSTeK Computer Inc. Device 8389
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at c000 [size=8]
	Region 1: I/O ports at b000 [size=4]
	Region 2: I/O ports at a000 [size=8]
	Region 3: I/O ports at 9000 [size=4]
	Region 4: I/O ports at 8000 [size=16]
	Region 5: Memory at fe9ffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [70] SATA HBA <?>
	Kernel driver in use: ahci

00:12.0 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI0 Controller (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. Device 8389
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fe9fe000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci_hcd
	Kernel modules: ohci-hcd

00:12.1 USB Controller: ATI Technologies Inc SB700 USB OHCI1 Controller (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. Device 8389
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fe9fd000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci_hcd
	Kernel modules: ohci-hcd

00:12.2 USB Controller: ATI Technologies Inc SB700/SB800 USB EHCI Controller (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. Device 8389
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at fe9ff800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Capabilities: [e4] Debug port: BAR=1 offset=00e0
	Kernel driver in use: ehci_hcd
	Kernel modules: ehci-hcd

00:13.0 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI0 Controller (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. Device 8389
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fe9fc000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci_hcd
	Kernel modules: ohci-hcd

00:13.1 USB Controller: ATI Technologies Inc SB700 USB OHCI1 Controller (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. Device 8389
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fe9fb000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci_hcd
	Kernel modules: ohci-hcd

00:13.2 USB Controller: ATI Technologies Inc SB700/SB800 USB EHCI Controller (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. Device 8389
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 19
	Region 0: Memory at fe9ff400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Capabilities: [e4] Debug port: BAR=1 offset=00e0
	Kernel driver in use: ehci_hcd
	Kernel modules: ehci-hcd

00:14.0 SMBus: ATI Technologies Inc SBx00 SMBus Controller (rev 3c)
	Subsystem: ASUSTeK Computer Inc. Device 8389
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort- >SERR- <PERR- INTx-
	Capabilities: [b0] HyperTransport: MSI Mapping Enable- Fixed+

00:14.1 IDE interface: ATI Technologies Inc SB700/SB800 IDE Controller (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc. Device 8389
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4 [size=1]
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374 [size=1]
	Region 4: I/O ports at ff00 [size=16]
	Capabilities: [70] Message Signalled Interrupts: Mask- 64bit- Count=1/1 Enable-
		Address: 00000000  Data: 0000
	Kernel driver in use: pata_atiixp

00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA)
	Subsystem: ASUSTeK Computer Inc. Device 836c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin ? routed to IRQ 16
	Region 0: Memory at fe9f4000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: HDA Intel
	Kernel modules: snd-hda-intel

00:14.3 ISA bridge: ATI Technologies Inc SB700/SB800 LPC host controller
	Subsystem: ASUSTeK Computer Inc. Device 8389
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:14.4 PCI bridge: ATI Technologies Inc SBx00 PCI to PCI Bridge (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

00:14.5 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI2 Controller (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. Device 8389
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at fe9fa000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci_hcd
	Kernel modules: ohci-hcd

00:18.0 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, Athlon64, Sempron] HyperTransport Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [80] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- <EOCErr- DUL-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn+ LSEn+ ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 3.00
		Link Frequency: [b]
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- ExtRS- UCnfE-

00:18.1 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, Athlon64, Sempron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, Athlon64, Sempron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel modules: amd64_edac_mod

00:18.3 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, Athlon64, Sempron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [f0] Secure device <?>

00:18.4 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, Athlon64, Sempron] Link Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-

01:00.0 VGA compatible controller: ATI Technologies Inc Device 954f (prog-if 00 [VGA controller])
	Subsystem: ASUSTeK Computer Inc. Device 02a8
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 2: Memory at feaf0000 (64-bit, non-prefetchable) [size=64K]
	Region 4: I/O ports at d000 [size=256]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency L0 <64ns, L1 <1us
			ClockPM- Suprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit+ Count=1/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [100] Vendor Specific Information <?>

01:00.1 Audio device: ATI Technologies Inc Device aa38
	Subsystem: ASUSTeK Computer Inc. Device aa38
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 28
	Region 0: Memory at feaec000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency L0 <64ns, L1 <1us
			ClockPM- Suprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit+ Count=1/1 Enable+
		Address: 00000000fee0f00c  Data: 4189
	Capabilities: [100] Vendor Specific Information <?>
	Kernel driver in use: HDA Intel
	Kernel modules: snd-hda-intel

02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 03)
	Subsystem: ASUSTeK Computer Inc. Device 83a3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 27
	Region 0: I/O ports at e800 [size=256]
	Region 2: Memory at fdfff000 (64-bit, prefetchable) [size=4K]
	Region 4: Memory at fdff8000 (64-bit, prefetchable) [size=16K]
	Expansion ROM at febf0000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Count=1/1 Enable+
		Address: 00000000fee0f00c  Data: 4179
	Capabilities: [70] Express (v2) Endpoint, MSI 01
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <64us
			ClockPM+ Suprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB
	Capabilities: [ac] MSI-X: Enable- Mask- TabSize=4
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00000800
	Capabilities: [cc] Vital Product Data <?>
	Capabilities: [100] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSVoil-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSVoil-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSVoil-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140] Virtual Channel <?>
	Capabilities: [160] Device Serial Number 00-00-00-00-00-00-00-00
	Kernel driver in use: r8169


------=_Part_4247_2126588.1274261587176
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_4247_2126588.1274261587176--
