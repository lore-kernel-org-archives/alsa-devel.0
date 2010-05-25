From: "mutenmaster@tiscali.it" <mutenmaster@tiscali.it>
Subject: Re: snd_intel_hda : broken microphone
Date: Tue, 25 May 2010 20:08:41 +0200 (CEST)
Message-ID: <26600671.238021274810921411.JavaMail.root@ps22>
Reply-To: "mutenmaster@tiscali.it" <mutenmaster@tiscali.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_11096_15971596.1274810921306"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mrqout1.tiscali.it (mrqout1-sorbs.tiscali.it [195.130.225.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A85D24366
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 20:08:44 +0200 (CEST)
Received: from ps22 (10.39.75.92) by mail-11.mail.tiscali.sys (8.0.031)
	id 4BF6A9110014B876 for alsa-devel@alsa-project.org;
	Tue, 25 May 2010 20:08:41 +0200
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

------=_Part_11096_15971596.1274810921306
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

ok you can find attached my codec0 output data. I hope
this helps. if=20

you or anyone else need any other piece of
info, please ask.

----

Messaggio originale----
=09Apparently (I assume) this is not for all via=20

sound chips so it's best
to expalin what your setup is. The output=20
from=20
lspci does not tell the
story on the codec at times. The best=20
output is

from /proc/asound/card0/codec#0

On Wed, 2010-05-19 at 11:33=20
+0200,=20
mutenmaster@tiscali.it wrote:
> hello people,
>=20
> i am really=20

determined in letting you know, for the=20
> third time,
> that my front=20

mic input does not work. i do not know if the=20
> rear
> one works, i=20

suspect not, but it's not important, because
> before=20
> the following=20

commit, the front mic input worked:
>=20
> $ sudo git bisect=20
> bad
>=20

f5271101faf1655d862849f42518c2a88ef394fb
> is the first bad commit
>=20

>=20
commit f5271101faf1655d862849f42518c2a88ef394fb
>=20
> Author: Lydia=20

Wang=20
> <lydiawang@viatech.com.cn>
> Date:   Sat Oct 10 19:07:
> 35=20

2009 +0800
>=20
>    =20
> ALSA HDA VIA: Add VIA_CTL_WIDGET_ANALOG_MUTE
>=20

control type
>   =20
>     Enter=20
> low power state if AA-Path volume is=20

muted.
>=20
>   =20
>     Signed-off-by:=20
> Lydia Wang <lydiawang@viatech.

com.cn>
>   =20
> Signed-off-by: Logan Li=20
> <loganli@viatech.com.cn>


>     Signed-off-by:
> Takashi Iwai <tiwai@suse.
> de>
>=20
> :040000=20

040000
> ab1ae14ff67f0b08848faeb3ad68def7f3e727f0
>=20
>=20

0bfbfde11fe32e87e8edbdb3c4d03c2d30370393 M      sound
>=20
> i'm=20

copypasting=20
> the lspci ouput, so that you can have a general idea
>=20

of what kind of=20
> machine i have. please let me know if there is
>=20
any=20
other info you need=20
> to solve this bug.
>=20
> more details on=20
the=20
problem:
> doing=20
> $ arecord -f cd=20
> test.wav
>=20
> produces a=20
file of=20
44 bytes. it's as if no microphone is=20
> attached
> to the=20
jack. this=20
behaviour has been evolving from the commit
>=20
> i showed=20
you forth. at=20
the beginning, a file with actual data was
>=20
>=20
produced, but no audio=20
came out of the speakers when reproducing
>=20
it.=20
> going on with the=20
commits, the file became 44 bytes long.
>=20
>=20
yours,
>=20
> vasilis
>=20
>=20
--
>=20
> $ lspci -vvv
>=20
> 00:00.0 Host=20
bridge: Advanced Micro Devices=20

> [AMD] RS780 Host Bridge Alternate
> =09
Subsystem: ASUSTeK Computer=20
Inc.=20
> Device 83a2
> =09Control: I/O- Mem+=20
BusMaster+ SpecCycle-=20
MemWINV-=20
> VGASnoop- ParErr- Stepping- SERR-=20
FastB2B- DisINTx-
> =09
Status: Cap+=20
> 66MHz+ UDF- FastB2B- ParErr-=20
DEVSEL=3Dmedium >TAbort-=20
<TAbort- <MAbort+=20
> >SERR- <PERR- INTx-
> =09
Latency: 0
> =09Capabilities:=20
[c4] HyperTransport:=20
> Slave or Primary=20
Interface
> =09=09Command:=20
BaseUnitID=3D0 UnitCnt=3D12 MastHost-=20
> DefDir-=20
DUL-
> =09=09Link Control 0:=20
CFlE- CST- CFE- <LkFail- Init+ EOC- TXO-=20
>=20
<CRCErr=3D0 IsocEn+ LSEn-=20
ExtCTL- 64b-
> =09=09Link Config 0: MLWI=3D16bit=20
>=20
DwFcIn- MLWO=3D16bit=20
DwFcOut- LWI=3D16bit DwFcInEn- LWO=3D16bit DwFcOutEn-

> =09=09
> Link Control=20
1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+=20
<CRCErr=3D0=20
> IsocEn- LSEn-=20
ExtCTL- 64b-
> =09=09Link Config 1: MLWI=3D8bit=20
DwFcIn- MLWO=3D8bit=20
> DwFcOut-=20
LWI=3D8bit DwFcInEn- LWO=3D8bit DwFcOutEn-

> =09=09Revision ID: 3.00
> =09=09
>=20
Link Frequency 0: [b]
> =09=09Link Error 0:=20
<Prot- <Ovfl- <EOC- CTLTm-
> =09=09
Link=20
> Frequency Capability 0: 200MHz+=20
300MHz- 400MHz+ 500MHz- 600MHz+=20
800MHz+=20
> 1.0GHz+ 1.2GHz- 1.4GHz- 1.6
GHz- Vend-
> =09=09Feature=20
Capability: IsocFC-=20
> LDTSTOP+ CRCTM- ECTLT-=20
64bA- UIDRD-
> =09=09Link=20
Frequency 1: 200MHz
> =09=09Link=20
> Error 1: <Prot-=20
<Ovfl- <EOC- CTLTm-
> =09=09
Link Frequency Capability 1:=20
> 200MHz-=20
300MHz- 400MHz- 500MHz- 600MHz-=20
800MHz- 1.0GHz- 1.2GHz- 1.4GHz-=20
> 1.6
GHz- Vend-
> =09=09Error Handling:=20
PFlE- OFlE- PFE- OFE- EOCFE- RFE-=20
>=20
CRCFE- SERRFE- CF- RE- PNFE- ONFE-=20
EOCNFE- RNFE- CRCNFE- SERRNFE-
> =09=09

> Prefetchable memory behind bridge=20
Upper: 00-00
> =09=09Bus Number: 00
> =09

> Capabilities: [54]=20
HyperTransport: UnitID Clumping
> =09Capabilities:=20
[40]=20
>=20
HyperTransport: Retry Mode
> =09Capabilities: [9c]=20
HyperTransport: #1a
> =09

> Capabilities: [f8] HyperTransport: #1c
>=20
>=20
00:02.0 PCI bridge:=20
Advanced=20
> Micro Devices [AMD] RS780 PCI to PCI=20
bridge (ext gfx port=20
0) (prog-if=20
> 00 [Normal decode])
> =09Control:=20
I/O+ Mem+ BusMaster+=20
SpecCycle- MemWINV-=20
> VGASnoop- ParErr-=20
Stepping- SERR+ FastB2B-=20
DisINTx+
> =09Status: Cap+=20
> 66MHz- UDF-=20
FastB2B- ParErr- DEVSEL=3Dfast=20
>TAbort- <TAbort- <MAbort-=20
> >SERR-=20
<PERR- INTx-
> =09Latency: 0, Cache=20
Line Size: 64 bytes
> =09Bus:=20
>=20
primary=3D00, secondary=3D01,=20
subordinate=3D01, sec-latency=3D0
> =09I/O behind=20

> bridge: 0000d000-
0000dfff
> =09Memory behind bridge: fea00000-feafffff

> =09
> Prefetchable=20
memory behind bridge: 00000000d0000000-
00000000dfffffff
> =09
> Secondary=20
status: 66MHz- FastB2B- ParErr-=20
DEVSEL=3Dfast >TAbort- <TAbort-=20
>=20
<MAbort- <SERR- <PERR-
> =09BridgeCtl:=20
Parity+ SERR+ NoISA- VGA+ MAbort-=20

> >Reset- FastB2B-
> =09=09PriDiscTmr-=20
SecDiscTmr- DiscTmrStat-=20
DiscTmrSERREn-
> =09
> Capabilities: [50] Power=20
Management version 3
> =09=09
Flags: PMEClk- DSI- D1-=20
> D2- AuxCurrent=3D0mA=20
PME(D0+,D1-,D2-,D3hot+,
D3cold+)
> =09=09Status: D0 PME-
> Enable- DSel=3D0=20
DScale=3D0 PME-
> =09
Capabilities: [58] Express (v2) Root Port=20
> (Slot+),=20
MSI 00
> =09=09
DevCap:=09MaxPayload 128 bytes, PhantFunc 0, Latency=20
> L0s=20
<64ns, L1=20
<1us
> =09=09=09ExtTag+ RBE+ FLReset-
> =09=09DevCtl:=09Report errors:=20

>=20
Correctable- Non-Fatal- Fatal- Unsupported-
> =09=09=09RlxdOrd+ ExtTag-=20

>=20
PhantFunc- AuxPwr- NoSnoop+
> =09=09=09MaxPayload 128 bytes, MaxReadReq=20
128=20

> bytes
> =09=09DevSta:=09CorrErr- UncorrErr- FatalErr- UnsuppReq-=20
AuxPwr-=20
>=20
TransPend-
> =09=09LnkCap:=09Port #0, Speed 5GT/s, Width x16,=20
ASPM L0s L1,=20
>=20
Latency L0 <64ns, L1 <1us
> =09=09=09ClockPM- Suprise-=20
LLActRep+ BwNot+
> =09=09

> LnkCtl:=09ASPM Disabled; RCB 64 bytes Disabled-=20
Retrain- CommClk+
> =09=09=09

> ExtSynch- ClockPM- AutWidDis- BWInt-=20
AutBWInt-
> =09=09LnkSta:=09Speed 2.5
GT/s,=20
> Width x16, TrErr- Train-=20
SlotClk+ DLActive+ BWMgmt+ ABWMgmt-

> =09=09SltCap:=09
> AttnBtn- PwrCtrl-=20
MRL- AttnInd- PwrInd- HotPlug-=20
Surpise-
> =09=09=09Slot #  2,=20
> PowerLimit=20
75.000000; Interlock- NoCompl+

> =09=09SltCtl:=09Enable: AttnBtn-=20
> PwrFlt-=20
MRL- PresDet- CmdCplt- HPIrq-=20
LinkChg-
> =09=09=09Control: AttnInd=20
>=20
Unknown, PwrInd Unknown, Power-=20
Interlock-
> =09=09SltSta:=09Status:=20
AttnBtn-=20
> PowerFlt- MRL- CmdCplt-=20
PresDet+ Interlock-
> =09=09=09Changed:=20
MRL- PresDet+=20
> LinkState+
> =09=09
RootCtl: ErrCorrectable- ErrNon-Fatal-=20
ErrFatal-=20
> PMEIntEna-=20
CRSVisible-
> =09=09RootCap: CRSVisible-
> =09=09
RootSta: PME ReqID=20
> 0000,=20
PMEStatus- PMEPending-
> =09=09DevCap2:=20
Completion Timeout: Not=20
>=20
Supported, TimeoutDis- ARIFwd-
> =09=09DevCtl2:=20
Completion Timeout: 50us=20
to=20
> 50ms, TimeoutDis- ARIFwd-
> =09=09LnkCtl2:=20
Target Link Speed: 5GT/s,=20

> EnterCompliance- SpeedDis-, Selectable De-
emphasis: -3.5dB
> =09=09=09=20
Transmit=20
> Margin: Normal Operating Range,=20
EnterModifiedCompliance-=20
ComplianceSOS-
>=20
> =09=09=09 Compliance De-
emphasis: -6dB
> =09=09LnkSta2:=20
Current De-emphasis Level:=20
> -3.5dB
> =09
Capabilities: [a0] Message=20
Signalled Interrupts: Mask- 64bit-=20
>=20
Count=3D1/1 Enable+
> =09=09Address:=20
fee0f00c  Data: 4159
> =09Capabilities:=20
[b0]=20
> Subsystem: ASUSTeK=20
Computer Inc. Device 83a2
> =09Capabilities:=20
[b8]=20
> HyperTransport: MSI=20
Mapping Enable+ Fixed+
> =09Capabilities:=20
[100] Vendor=20
> Specific=20
Information <?>
> =09Capabilities: [110]=20
Virtual Channel <?>
> =09
> Kernel=20
driver in use: pcieport-driver
>=20
>=20
00:0a.0 PCI bridge: Advanced=20
>=20
Micro Devices [AMD] RS780 PCI to PCI=20
bridge (PCIE port 5) (prog-if 00=20

> [Normal decode])
> =09Control: I/O+=20
Mem+ BusMaster+ SpecCycle-=20
MemWINV-=20
> VGASnoop- ParErr- Stepping-=20
SERR+ FastB2B- DisINTx+
> =09
Status: Cap+=20
> 66MHz- UDF- FastB2B-=20
ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort- <MAbort-=20
> >SERR- <PERR- INTx-

> =09Latency: 0, Cache Line=20
Size: 64 bytes
> =09Bus:=20
> primary=3D00,=20
secondary=3D02, subordinate=3D02, sec-
latency=3D0
> =09I/O behind=20
> bridge:=20
0000e000-0000efff
> =09Memory behind=20
bridge: feb00000-febfffff
> =09
>=20
Prefetchable memory behind bridge:=20
00000000fdf00000-00000000fdffffff

> =09
> Secondary status: 66MHz-=20
FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=20
<TAbort-=20
> <MAbort- <SERR-=20
<PERR-
> =09BridgeCtl: Parity+ SERR+ NoISA+=20
VGA- MAbort-=20
> >Reset-=20
FastB2B-
> =09=09PriDiscTmr- SecDiscTmr-=20
DiscTmrStat- DiscTmrSERREn-
> =09
>=20
Capabilities: [50] Power Management=20
version 3
> =09=09Flags: PMEClk- DSI-=20
D1-=20
> D2- AuxCurrent=3D0mA PME(D0+,D1-
,D2-,D3hot+,D3cold+)
> =09=09Status:=20
D0 PME-
> Enable- DSel=3D0 DScale=3D0=20
PME-
> =09Capabilities: [58] Express=20
(v2) Root Port=20
> (Slot+), MSI 00

> =09=09DevCap:=09MaxPayload 128 bytes,=20
PhantFunc 0, Latency=20
> L0s <64ns,=20
L1 <1us
> =09=09=09ExtTag+ RBE+ FLReset-

> =09=09DevCtl:=09Report errors:=20
>=20
Correctable- Non-Fatal- Fatal-=20
Unsupported-
> =09=09=09RlxdOrd+ ExtTag-=20
>=20
PhantFunc- AuxPwr- NoSnoop+
> =09=09=09
MaxPayload 128 bytes, MaxReadReq 128=20

> bytes
> =09=09DevSta:=09CorrErr-=20
UncorrErr- FatalErr- UnsuppReq- AuxPwr-=20

> TransPend-
> =09=09LnkCap:=09Port=20
#1, Speed 5GT/s, Width x1, ASPM L0s L1,=20

> Latency L0 <64ns, L1 <1us
> =09
=09=09ClockPM- Suprise- LLActRep+ BwNot+
> =09
=09
> LnkCtl:=09ASPM Disabled; RCB=20
64 bytes Disabled- Retrain- CommClk+
> =09
=09=09
> ExtSynch- ClockPM-=20
AutWidDis- BWInt- AutBWInt-
> =09=09LnkSta:=09Speed=20
2.5GT/s,=20
> Width x1,=20
TrErr- Train- SlotClk+ DLActive+ BWMgmt+=20
ABWMgmt-
> =09=09SltCap:=09
>=20
AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-=20
HotPlug- Surpise-
> =09=09=09Slot # =20
a,=20
> PowerLimit 25.000000; Interlock-=20
NoCompl+
> =09=09SltCtl:=09Enable:=20
AttnBtn-=20
> PwrFlt- MRL- PresDet-=20
CmdCplt- HPIrq- LinkChg-
> =09=09=09
Control: AttnInd=20
> Unknown, PwrInd=20
Unknown, Power- Interlock-
> =09=09
SltSta:=09Status: AttnBtn-=20
> PowerFlt-=20
MRL- CmdCplt- PresDet+ Interlock-

> =09=09=09Changed: MRL- PresDet+=20
>=20
LinkState+
> =09=09RootCtl: ErrCorrectable-=20
ErrNon-Fatal- ErrFatal-=20
>=20
PMEIntEna- CRSVisible-
> =09=09RootCap:=20
CRSVisible-
> =09=09RootSta: PME=20
ReqID=20
> 0000, PMEStatus- PMEPending-
> =09=09
DevCap2: Completion Timeout:=20
Not=20
> Supported, TimeoutDis- ARIFwd-
> =09=09
DevCtl2: Completion Timeout:=20
50us to=20
> 50ms, TimeoutDis- ARIFwd-
> =09=09
LnkCtl2: Target Link Speed:=20
2.5GT/s,=20
> EnterCompliance- SpeedDis-,=20
Selectable De-emphasis: -6dB

> =09=09=09 Transmit=20
> Margin: Normal Operating=20
Range,=20
EnterModifiedCompliance- ComplianceSOS-
>=20
> =09=09=09 Compliance De-

emphasis: -6dB
> =09=09LnkSta2: Current De-emphasis Level:=20
> -6dB
> =09

Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit-=20
>=20

Count=3D1/1 Enable+
> =09=09Address: fee0f00c  Data: 4161
> =09Capabilities:=20

[b0]=20
> Subsystem: ASUSTeK Computer Inc. Device 83a2
> =09Capabilities:=20

[b8]=20
> HyperTransport: MSI Mapping Enable+ Fixed+
> =09Capabilities:=20

[100] Vendor=20
> Specific Information <?>
> =09Capabilities: [110]=20
Virtual=20
Channel <?>
> =09
> Kernel driver in use: pcieport-driver
>=20
>=20
00:11.0=20
SATA controller: ATI=20
> Technologies Inc SB700/SB800 SATA=20
Controller=20
[AHCI mode] (prog-if 01=20
> [AHCI 1.0])
> =09Subsystem:=20
ASUSTeK Computer=20
Inc. Device 8389
> =09Control:=20
> I/O+ Mem+ BusMaster+=20
SpecCycle-=20
MemWINV- VGASnoop- ParErr- Stepping-=20
> SERR+ FastB2B-=20
DisINTx-
> =09
Status: Cap+ 66MHz+ UDF- FastB2B- ParErr-=20
> DEVSEL=3Dmedium=20
>TAbort-=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
> =09Latency:=20
> 64,=20
Cache Line=20
Size: 64 bytes
> =09Interrupt: pin A routed to IRQ 22
> =09
>=20
Region 0: I/O=20
ports at c000 [size=3D8]
> =09Region 1: I/O ports at b000=20
>=20
[size=3D4]
> =09
Region 2: I/O ports at a000 [size=3D8]
> =09Region 3: I/O=20
ports at=20
> 9000=20
[size=3D4]
> =09Region 4: I/O ports at 8000 [size=3D16]
> =09
Region 5: Memory=20

> at fe9ffc00 (32-bit, non-prefetchable) [size=3D1K]

> =09Capabilities:=20
[60]=20
> Power Management version 2
> =09=09Flags: PMEClk-=20
DSI+ D1- D2-=20
AuxCurrent=3D0mA=20
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
> =09=09
Status: D0 PME-
Enable- DSel=3D0=20
> DScale=3D0 PME-
> =09Capabilities: [70]=20
SATA HBA <?>
> =09
Kernel driver in use:=20
> ahci
>=20
> 00:12.0 USB=20
Controller: ATI=20
Technologies Inc SB700/SB800 USB=20
> OHCI0 Controller=20
(prog-if 10=20
[OHCI])
> =09Subsystem: ASUSTeK Computer Inc.=20
> Device 8389

> =09Control:=20
I/O- Mem+ BusMaster+ SpecCycle- MemWINV-=20
> VGASnoop-=20
ParErr- Stepping-=20
SERR+ FastB2B- DisINTx-
> =09Status: Cap-=20
> 66MHz+=20
UDF- FastB2B+ ParErr-=20
DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort-=20
>=20
>SERR- <PERR- INTx-
> =09
Latency: 64, Cache Line Size: 64 bytes
> =09
Interrupt:=20
> pin A routed to=20
IRQ 16
> =09Region 0: Memory at fe9fe000=20
(32-bit, non-
> prefetchable)=20
[size=3D4K]
> =09Kernel driver in use:=20
ohci_hcd
> =09Kernel=20
> modules: ohci-
hcd
>=20
> 00:12.1 USB Controller:=20
ATI Technologies Inc SB700=20
> USB=20
OHCI1 Controller (prog-if 10 [OHCI])

> =09Subsystem: ASUSTeK Computer=20
>=20
Inc. Device 8389
> =09Control: I/O+=20
Mem+ BusMaster+ SpecCycle- MemWINV+=20

> VGASnoop- ParErr- Stepping-=20
SERR+ FastB2B- DisINTx-
> =09Status: Cap-=20

> 66MHz+ UDF- FastB2B+=20
ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-=20
<MAbort-=20
> >SERR- <PERR-=20
INTx-
> =09Latency: 64, Cache Line Size: 64=20
bytes
> =09Interrupt:=20
> pin A=20
routed to IRQ 16
> =09Region 0: Memory at=20
fe9fd000 (32-bit, non-
>=20
prefetchable) [size=3D4K]
> =09Kernel driver in=20
use: ohci_hcd
> =09Kernel=20
>=20
modules: ohci-hcd
>=20
> 00:12.2 USB=20
Controller: ATI Technologies Inc=20
>=20
SB700/SB800 USB EHCI Controller=20
(prog-if 20 [EHCI])
> =09Subsystem:=20
ASUSTeK=20
> Computer Inc. Device 8389

> =09Control: I/O- Mem+ BusMaster+=20
SpecCycle-=20
> MemWINV+ VGASnoop-=20
ParErr- Stepping- SERR+ FastB2B-=20
DisINTx-
> =09Status:=20
> Cap+ 66MHz+=20
UDF- FastB2B+ ParErr- DEVSEL=3Dmedium=20
>TAbort- <TAbort-=20
> <MAbort-=20
>SERR- <PERR- INTx-
> =09Latency: 64,=20
Cache Line Size: 64 bytes
> =09
>=20
Interrupt: pin B routed to IRQ 17
> =09
Region 0: Memory at fe9ff800 (32-

> bit, non-prefetchable) [size=3D256]

> =09Capabilities: [c0] Power=20
Management=20
> version 2
> =09=09Flags: PMEClk-=20
DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,
> D3hot+,D3cold-)
> =09=09
Status: D0 PME-Enable- DSel=3D0=20
DScale=3D0 PME-
> =09=09Bridge:=20
> PM- B3+
> =09
Capabilities: [e4] Debug port:=20
BAR=3D1 offset=3D00e0
> =09Kernel=20
> driver=20
in use: ehci_hcd
> =09Kernel=20
modules: ehci-hcd
>=20
> 00:13.0 USB=20
>=20
Controller: ATI Technologies Inc=20
SB700/SB800 USB OHCI0 Controller=20
(prog-
> if 10 [OHCI])
> =09Subsystem:=20
ASUSTeK Computer Inc. Device 8389

> =09Control:=20
> I/O- Mem+ BusMaster+=20
SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping-=20
> SERR+ FastB2B-=20
DisINTx-
> =09Status: Cap- 66MHz+=20
UDF- FastB2B+ ParErr-=20
> DEVSEL=3Dmedium=20
>TAbort- <TAbort- <MAbort-=20
>SERR- <PERR- INTx-
> =09Latency:=20
> 64, Cache=20
Line Size: 64 bytes
> =09
Interrupt: pin A routed to IRQ 18
> =09
> Region=20
0: Memory at fe9fc000=20
(32-bit, non-prefetchable) [size=3D4K]
> =09
> Kernel=20
driver in use:=20
ohci_hcd
> =09Kernel modules: ohci-hcd
>=20
> 00:13.1 USB=20
>=20
Controller:=20
ATI Technologies Inc SB700 USB OHCI1 Controller (prog-if=20
10=20
> [OHCI])

> =09Subsystem: ASUSTeK Computer Inc. Device 8389
> =09
Control: I/O+=20
>=20
Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=20
Stepping- SERR+=20

> FastB2B- DisINTx-
> =09Status: Cap- 66MHz+ UDF-=20
FastB2B+ ParErr-=20
>=20
DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR-=20
<PERR- INTx-
> =09
Latency:=20
> 64, Cache Line Size: 64 bytes
> =09Interrupt:=20
pin A routed=20
to IRQ 18
> =09
> Region 0: Memory at fe9fb000 (32-bit, non-

prefetchable) [size=3D4K]
> =09
> Kernel driver in use: ohci_hcd
> =09Kernel=20

modules: ohci-hcd
>=20
> 00:13.2 USB=20
> Controller: ATI Technologies Inc=20

SB700/SB800 USB EHCI Controller (prog-
> if 20 [EHCI])
> =09Subsystem:=20

ASUSTeK Computer Inc. Device 8389
> =09Control:=20
> I/O- Mem+ BusMaster+=20

SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-=20
> SERR+ FastB2B-=20

DisINTx-
> =09Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr-=20
> DEVSEL=3Dmedium=20

>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> =09Latency:=20
> 64,=20
Cache=20
Line Size: 64 bytes
> =09Interrupt: pin B routed to IRQ 19
> =09
>=20
Region=20
0: Memory at fe9ff400 (32-bit, non-prefetchable) [size=3D256]
> =09

>=20
Capabilities: [c0] Power Management version 2
> =09=09Flags: PMEClk-=20
DSI-=20
D1+=20
> D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
> =09=09
Status:=20
D0 PME-
> Enable- DSel=3D0 DScale=3D0 PME-
> =09=09Bridge: PM- B3+
> =09

Capabilities: [e4]=20
> Debug port: BAR=3D1 offset=3D00e0
> =09Kernel driver=20
in=20
use: ehci_hcd
> =09Kernel=20
> modules: ehci-hcd
>=20
> 00:14.0 SMBus:=20
ATI=20
Technologies Inc SBx00 SMBus=20
> Controller (rev 3c)
> =09Subsystem:=20

ASUSTeK Computer Inc. Device 8389
> =09
> Control: I/O+ Mem+ BusMaster-=20

SpecCycle- MemWINV- VGASnoop- ParErr-=20
> Stepping- SERR- FastB2B-=20

DisINTx+
> =09Status: Cap+ 66MHz+ UDF- FastB2B-=20
> ParErr- DEVSEL=3Dmedium=20

>TAbort- <TAbort+ <MAbort- >SERR- <PERR- INTx-
> =09
> Capabilities:=20
[b0]=20
HyperTransport: MSI Mapping Enable- Fixed+
>=20
> 00:14.1=20
> IDE=20

interface: ATI Technologies Inc SB700/SB800 IDE Controller (prog-if=20
>=20

8a [Master SecP PriP])
> =09Subsystem: ASUSTeK Computer Inc. Device 8389


> =09
> Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-=20

ParErr-=20
> Stepping- SERR- FastB2B- DisINTx-
> =09Status: Cap+ 66MHz+=20

UDF- FastB2B-=20
> ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort-=20

>SERR- <PERR- INTx-
> =09
> Latency: 64
> =09Interrupt: pin A routed to=20
IRQ=20
16
> =09Region 0: I/O ports at=20
> 01f0 [size=3D8]
> =09Region 1: I/O=20
ports at=20
03f4 [size=3D1]
> =09Region 2: I/O=20
> ports at 0170 [size=3D8]
> =09
Region 3:=20
I/O ports at 0374 [size=3D1]
> =09Region 4:=20
> I/O ports at ff00=20
[size=3D16]

> =09Capabilities: [70] Message Signalled=20
> Interrupts: Mask-=20
64bit-=20
Count=3D1/1 Enable-
> =09=09Address: 00000000  Data:=20
> 0000
> =09
Kernel driver=20
in use: pata_atiixp
>=20
> 00:14.2 Audio device: ATI=20
>=20
Technologies Inc=20
SBx00 Azalia (Intel HDA)
> =09Subsystem: ASUSTeK=20
Computer=20
> Inc. Device=20
836c
> =09Control: I/O- Mem+ BusMaster+=20
SpecCycle- MemWINV-=20
> VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-=20
DisINTx-
> =09Status: Cap+=20
> 66MHz-=20
UDF- FastB2B- ParErr- DEVSEL=3Dslow=20
>TAbort- <TAbort- <MAbort-=20
> >SERR-=20
<PERR- INTx-
> =09Latency: 64,=20
Cache Line Size: 64 bytes
> =09Interrupt:=20
>=20
pin ? routed to IRQ 16
> =09
Region 0: Memory at fe9f4000 (64-bit, non-
>=20
prefetchable) [size=3D16K]

> =09Capabilities: [50] Power Management version=20
2
>=20
> =09=09Flags: PMEClk-=20
DSI- D1- D2- AuxCurrent=3D55mA PME(D0+,D1-,D2-,
D3hot+,
> D3cold+)
> =09=09
Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
> =09
Kernel driver=20
> in=20
use: HDA Intel
> =09Kernel modules: snd-hda-intel
>=20

> 00:14.3 ISA=20
bridge:=20
> ATI Technologies Inc SB700/SB800 LPC host=20
controller
> =09
Subsystem:=20
> ASUSTeK Computer Inc. Device 8389
> =09
Control: I/O+ Mem+=20
BusMaster+=20
> SpecCycle+ MemWINV- VGASnoop- ParErr-=20
Stepping- SERR-=20
FastB2B- DisINTx-
>=20
> =09Status: Cap- 66MHz+ UDF-=20
FastB2B- ParErr-=20
DEVSEL=3Dmedium >TAbort-=20
> <TAbort- <MAbort- >SERR-=20
<PERR- INTx-
> =09
Latency: 0
>=20
> 00:14.4 PCI bridge:=20
> ATI Technologies=20
Inc SBx00 PCI=20
to PCI Bridge (prog-if 01 [Subtractive=20
> decode])
> =09
Control: I/O+=20
Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
> ParErr-=20
Stepping-=20
SERR+ FastB2B- DisINTx-
> =09Status: Cap- 66MHz+ UDF-=20
>=20
FastB2B+=20
ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR-=20
<PERR-=20
>=20
INTx-
> =09Latency: 64
> =09Bus: primary=3D00, secondary=3D03,=20
subordinate=3D03,=20
sec-
> latency=3D64
> =09I/O behind bridge: 0000f000-
00000fff
> =09Memory=20
behind bridge:=20
> fff00000-000fffff
> =09Prefetchable=20
memory behind=20
bridge: fff00000-000fffff
>=20
> =09Secondary status: 66MHz-=20
FastB2B+=20
ParErr- DEVSEL=3Dmedium >TAbort-=20
> <TAbort- <MAbort+ <SERR-=20
<PERR-
> =09
BridgeCtl: Parity+ SERR+ NoISA+ VGA-=20
> MAbort- >Reset-=20
FastB2B-
> =09=09
PriDiscTmr- SecDiscTmr- DiscTmrStat-=20
> DiscTmrSERREn-
>=20

> 00:14.5=20
USB Controller: ATI Technologies Inc=20
> SB700/SB800 USB OHCI2=20

Controller (prog-if 10 [OHCI])
> =09Subsystem:=20
> ASUSTeK Computer Inc.=20

Device 8389
> =09Control: I/O- Mem+ BusMaster+=20
> SpecCycle- MemWINV-=20

VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
>=20
> =09Status: Cap-=20

66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=20
> <TAbort-=20

<MAbort- >SERR- <PERR- INTx-
> =09Latency: 64, Cache Line Size: 64=20
>=20

bytes
> =09Interrupt: pin C routed to IRQ 18
> =09Region 0: Memory at=20

fe9fa000=20
> (32-bit, non-prefetchable) [size=3D4K]
> =09Kernel driver in=20

use: ohci_hcd
> =09
> Kernel modules: ohci-hcd
>=20
> 00:18.0 Host bridge:=20

Advanced Micro Devices=20
> [AMD] Family 10h [Opteron, Athlon64,=20
Sempron]=20
HyperTransport=20
> Configuration
> =09Control: I/O- Mem-=20
BusMaster-=20
SpecCycle- MemWINV-=20
> VGASnoop- ParErr- Stepping- SERR-=20
FastB2B-=20
DisINTx-
> =09Status: Cap+=20
> 66MHz- UDF- FastB2B- ParErr-=20
DEVSEL=3Dfast=20
>TAbort- <TAbort- <MAbort-=20
> >SERR- <PERR- INTx-
> =09
Capabilities: [80]=20
HyperTransport: Host or=20
> Secondary Interface
> =09=09
Command: WarmRst+=20
DblEnd- DevNum=3D0 ChainSide-=20
> HostHide+ Slave-=20
<EOCErr- DUL-
> =09=09Link=20
Control: CFlE- CST- CFE- <LkFail-=20
> Init+ EOC-=20
TXO- <CRCErr=3D0 IsocEn+=20
LSEn+ ExtCTL- 64b-
> =09=09Link Config:=20
>=20
MLWI=3D16bit DwFcIn- MLWO=3D16bit=20
DwFcOut- LWI=3D16bit DwFcInEn- LWO=3D16bit=20

> DwFcOutEn-
> =09=09Revision ID:=20
3.00
> =09=09Link Frequency: [b]
> =09=09Link=20
Error:=20
> <Prot- <Ovfl- <EOC-=20
CTLTm-
> =09=09Link Frequency Capability:=20
200MHz+ 300MHz-=20
> 400MHz+=20
500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4
GHz- 1.6GHz- Vend-
> =09=09
>=20
Feature Capability: IsocFC+ LDTSTOP+ CRCTM-=20
ECTLT- 64bA+ UIDRD- ExtRS-=20

> UCnfE-
>=20
> 00:18.1 Host bridge:=20
Advanced Micro Devices [AMD] Family=20
10h=20
> [Opteron, Athlon64,=20
Sempron] Address Map
> =09Control: I/O- Mem-=20
BusMaster-=20
> SpecCycle-=20
MemWINV- VGASnoop- ParErr- Stepping- SERR-=20
FastB2B- DisINTx-
>=20
> =09
Status: Cap- 66MHz- UDF- FastB2B- ParErr-=20
DEVSEL=3Dfast >TAbort-=20
>=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
>=20
> 00:
18.2 Host bridge:=20
Advanced=20
> Micro Devices [AMD] Family 10h [Opteron,=20
Athlon64,=20
Sempron] DRAM=20
> Controller
> =09Control: I/O- Mem- BusMaster-=20

SpecCycle- MemWINV- VGASnoop-=20
> ParErr- Stepping- SERR- FastB2B-=20

DisINTx-
> =09Status: Cap- 66MHz- UDF-=20
> FastB2B- ParErr- DEVSEL=3Dfast=20

>TAbort- <TAbort- <MAbort- >SERR- <PERR-=20
> INTx-
> =09Kernel modules:=20

amd64_edac_mod
>=20
> 00:18.3 Host bridge: Advanced=20
> Micro Devices=20

[AMD] Family 10h [Opteron, Athlon64, Sempron]=20
> Miscellaneous Control


> =09Control: I/O- Mem- BusMaster- SpecCycle-=20
> MemWINV- VGASnoop-=20

ParErr- Stepping- SERR- FastB2B- DisINTx-
> =09Status:=20
> Cap+ 66MHz-=20

UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-=20
> <MAbort- >SERR-=20

<PERR- INTx-
> =09Capabilities: [f0] Secure device <?>
>=20
> 00:
> 18.4=20

Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron,=20
>=20

Athlon64, Sempron] Link Control
> =09Control: I/O- Mem- BusMaster-=20
>=20

SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-


>=20
> =09Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-=20

>=20
<TAbort- <MAbort- >SERR- <PERR- INTx-
>=20
> 01:00.0 VGA compatible=20

>=20
controller: ATI Technologies Inc Device 954f (prog-if 00 [VGA=20
>=20

controller])
> =09Subsystem: ASUSTeK Computer Inc. Device 02a8
> =09

Control:=20
> I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20

Stepping-=20
> SERR+ FastB2B- DisINTx-
> =09Status: Cap+ 66MHz- UDF-=20

FastB2B- ParErr-=20
> DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR-=20

<PERR- INTx-
> =09Latency: 0,=20
> Cache Line Size: 64 bytes
> =09Interrupt:=20

pin A routed to IRQ 18
> =09Region 0:=20
> Memory at d0000000 (64-bit,=20

prefetchable) [size=3D256M]
> =09Region 2: Memory=20
> at feaf0000 (64-bit,=20

non-prefetchable) [size=3D64K]
> =09Region 4: I/O ports=20
> at d000=20

[size=3D256]
> =09Expansion ROM at feac0000 [disabled] [size=3D128K]
> =09
>=20

Capabilities: [50] Power Management version 3
> =09=09Flags: PMEClk- DSI-=20

D1+=20
> D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> =09=09Status:=20

D0 PME-
> Enable- DSel=3D0 DScale=3D0 PME-
> =09Capabilities: [58] Express=20

(v2) Legacy=20
> Endpoint, MSI 00
> =09=09DevCap:=09MaxPayload 128 bytes,=20

PhantFunc 0, Latency=20
> L0s <4us, L1 unlimited
> =09=09=09ExtTag+ AttnBtn-=20

AttnInd- PwrInd- RBE+=20
> FLReset-
> =09=09DevCtl:=09Report errors:=20

Correctable- Non-Fatal- Fatal-=20
> Unsupported-
> =09=09=09RlxdOrd+ ExtTag-=20

PhantFunc- AuxPwr- NoSnoop+
> =09=09=09
> MaxPayload 128 bytes, MaxReadReq=20

128 bytes
> =09=09DevSta:=09CorrErr-=20
> UncorrErr- FatalErr- UnsuppReq-=20

AuxPwr- TransPend-
> =09=09LnkCap:=09Port #0,=20
> Speed 2.5GT/s, Width x16,=20

ASPM L0s L1, Latency L0 <64ns, L1 <1us
> =09=09=09
> ClockPM- Suprise-=20

LLActRep- BwNot-
> =09=09LnkCtl:=09ASPM Disabled; RCB 64=20
> bytes Disabled-=20

Retrain- CommClk+
> =09=09=09ExtSynch- ClockPM- AutWidDis-=20
> BWInt-=20

AutBWInt-
> =09=09LnkSta:=09Speed 2.5GT/s, Width x16, TrErr- Train-=20
>=20

SlotClk+ DLActive- BWMgmt- ABWMgmt-
> =09=09DevCap2: Completion Timeout:=20

Not=20
> Supported, TimeoutDis-
> =09=09DevCtl2: Completion Timeout: 50us to=20

50ms,=20
> TimeoutDis-
> =09=09LnkCtl2: Target Link Speed: 2.5GT/s,=20

EnterCompliance-=20
> SpeedDis-, Selectable De-emphasis: -6dB
> =09=09=09=20

Transmit Margin: Normal=20
> Operating Range, EnterModifiedCompliance-=20

ComplianceSOS-
> =09=09=09 Compliance=20
> De-emphasis: -6dB
> =09=09LnkSta2:=20

Current De-emphasis Level: -6dB
> =09
> Capabilities: [a0] Message=20

Signalled Interrupts: Mask- 64bit+ Count=3D1/1=20
> Enable-
> =09=09Address:=20

0000000000000000  Data: 0000
> =09Capabilities: [100]=20
> Vendor Specific=20

Information <?>
>=20
> 01:00.1 Audio device: ATI Technologies=20
> Inc=20

Device aa38
> =09Subsystem: ASUSTeK Computer Inc. Device aa38
> =09

Control:=20
> I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20

Stepping-=20
> SERR+ FastB2B- DisINTx+
> =09Status: Cap+ 66MHz- UDF-=20

FastB2B- ParErr-=20
> DEVSEL=3Dfast >TAbort- <TAbort- <MAbort- >SERR-=20

<PERR- INTx-
> =09Latency: 0,=20
> Cache Line Size: 64 bytes
> =09Interrupt:=20

pin B routed to IRQ 28
> =09Region 0:=20
> Memory at feaec000 (64-bit, non-

prefetchable) [size=3D16K]
> =09Capabilities:=20
> [50] Power Management=20

version 3
> =09=09Flags: PMEClk- DSI- D1+ D2+=20
> AuxCurrent=3D0mA PME(D0-,D1-
,
D2-,D3hot-,D3cold-)
> =09=09Status: D0 PME-Enable-=20
> DSel=3D0 DScale=3D0=20
PME-

> =09Capabilities: [58] Express (v2) Legacy Endpoint,=20
> MSI 00
> =09=09

DevCap:=09MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us,=20
> L1=20

unlimited
> =09=09=09ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> =09=09
>=20

DevCtl:=09Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> =09=09=09


> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
> =09=09=09MaxPayload 128=20

bytes,=20
> MaxReadReq 128 bytes
> =09=09DevSta:=09CorrErr- UncorrErr-=20

FatalErr- UnsuppReq-=20
> AuxPwr- TransPend-
> =09=09LnkCap:=09Port #0, Speed=20

2.5GT/s, Width x16, ASPM=20
> L0s L1, Latency L0 <64ns, L1 <1us
> =09=09=09

ClockPM- Suprise- LLActRep- BwNot-
>=20
> =09=09LnkCtl:=09ASPM Disabled; RCB=20
64=20
bytes Disabled- Retrain- CommClk+
> =09=09=09
> ExtSynch- ClockPM-=20
AutWidDis-=20
BWInt- AutBWInt-
> =09=09LnkSta:=09Speed 2.5GT/s,=20
> Width x16,=20
TrErr- Train-=20
SlotClk+ DLActive- BWMgmt- ABWMgmt-
> =09=09DevCap2:=20
>=20
Completion Timeout:=20
Not Supported, TimeoutDis-
> =09=09DevCtl2:=20
Completion=20
> Timeout: 50us to=20
50ms, TimeoutDis-
> =09=09LnkCtl2: Target=20
Link Speed: 2.5
> GT/s,=20
EnterCompliance- SpeedDis-, Selectable De-
emphasis: -6dB
> =09=09=09=20
>=20
Transmit Margin: Normal Operating Range,=20
EnterModifiedCompliance-=20
>=20
ComplianceSOS-
> =09=09=09 Compliance De-
emphasis: -6dB
> =09=09LnkSta2: Current=20
De-
> emphasis Level: -6dB
> =09
Capabilities: [a0] Message Signalled=20
Interrupts:=20
> Mask- 64bit+=20
Count=3D1/1 Enable+
> =09=09Address:=20
00000000fee0f00c  Data: 4189
> =09
>=20
Capabilities: [100] Vendor Specific=20
Information <?>
> =09Kernel driver=20
in=20
> use: HDA Intel
> =09Kernel=20
modules: snd-hda-intel
>=20
> 02:00.0=20
Ethernet=20
> controller: Realtek=20
Semiconductor Co., Ltd. RTL8111/8168B=20
PCI Express=20
> Gigabit Ethernet=20
controller (rev 03)
> =09Subsystem:=20
ASUSTeK Computer Inc.=20
> Device 83a3

> =09Control: I/O+ Mem+ BusMaster+=20
SpecCycle- MemWINV-=20
> VGASnoop-=20
ParErr- Stepping- SERR+ FastB2B-=20
DisINTx+
> =09Status: Cap+=20
> 66MHz-=20
UDF- FastB2B- ParErr- DEVSEL=3Dfast=20
>TAbort- <TAbort- <MAbort-=20
> >SERR-=20
<PERR- INTx-
> =09Latency: 0, Cache=20
Line Size: 64 bytes
> =09Interrupt:=20
>=20
pin A routed to IRQ 27
> =09Region=20
0: I/O ports at e800 [size=3D256]
> =09
Region=20
> 2: Memory at fdfff000 (64-
bit, prefetchable) [size=3D4K]
> =09
Region 4:=20
> Memory at fdff8000 (64-
bit, prefetchable) [size=3D16K]
> =09
Expansion ROM at=20
> febf0000=20
[disabled] [size=3D64K]
> =09Capabilities:=20
[40] Power Management=20
>=20
version 3
> =09=09Flags: PMEClk- DSI- D1+ D2+=20
AuxCurrent=3D375mA PME(D0+,
D1+,
> D2+,D3hot+,D3cold+)
> =09=09Status: D0 PME-
Enable- DSel=3D0 DScale=3D0=20
PME-
> =09
> Capabilities: [50] Message Signalled=20
Interrupts: Mask-=20
64bit+ Count=3D1/1=20
> Enable+
> =09=09Address:=20
00000000fee0f00c  Data: 4179

> =09Capabilities: [70]=20
> Express (v2)=20
Endpoint, MSI 01
> =09=09DevCap:=09
MaxPayload 256 bytes, PhantFunc=20
> 0,=20
Latency L0s <512ns, L1 <64us
> =09=09
=09ExtTag- AttnBtn- AttnInd- PwrInd-=20
>=20
RBE+ FLReset-
> =09=09DevCtl:=09Report=20
errors: Correctable- Non-Fatal-=20
Fatal-=20
> Unsupported-
> =09=09=09RlxdOrd-=20
ExtTag- PhantFunc- AuxPwr-=20
NoSnoop-
> =09=09=09
> MaxPayload 128 bytes,=20
MaxReadReq 4096 bytes
> =09=09
DevSta:=09CorrErr+=20
> UncorrErr- FatalErr-=20
UnsuppReq+ AuxPwr+ TransPend-

> =09=09LnkCap:=09Port #0,=20
> Speed 2.5GT/s,=20
Width x1, ASPM L0s L1, Latency=20
L0 <512ns, L1 <64us
> =09=09=09
> ClockPM+=20
Suprise- LLActRep- BwNot-
> =09=09
LnkCtl:=09ASPM Disabled; RCB 64=20
> bytes=20
Disabled- Retrain- CommClk+
> =09=09=09
ExtSynch- ClockPM- AutWidDis-=20
>=20
BWInt- AutBWInt-
> =09=09LnkSta:=09Speed 2.5
GT/s, Width x1, TrErr- Train-=20
>=20
SlotClk+ DLActive- BWMgmt- ABWMgmt-
> =09
=09DevCap2: Completion Timeout:=20
Not=20
> Supported, TimeoutDis+
> =09=09
DevCtl2: Completion Timeout: 50us to=20
50ms,=20
> TimeoutDis-
> =09=09LnkCtl2:=20
Target Link Speed: 2.5GT/s,=20
EnterCompliance-=20
> SpeedDis-, Selectable=20
De-emphasis: -6dB
> =09=09=09=20
Transmit Margin: Normal=20
> Operating Range,=20
EnterModifiedCompliance-=20
ComplianceSOS-
> =09=09=09 Compliance=20
> De-
emphasis: -6dB
> =09=09LnkSta2:=20
Current De-emphasis Level: -6dB
> =09
>=20
Capabilities: [ac] MSI-X:=20
Enable- Mask- TabSize=3D4
> =09=09Vector table:=20
BAR=3D4=20
> offset=3D00000000
> =09=09
PBA: BAR=3D4 offset=3D00000800
> =09
Capabilities: [cc] Vital=20
> Product Data=20
<?>
> =09Capabilities: [100]=20
Advanced Error Reporting
> =09=09UESta:=09
> DLP-=20
SDES- TLP- FCP- CmpltTO-=20
CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC-=20
>=20
UnsupReq- ACSVoil-
> =09=09
UEMsk:=09DLP- SDES- TLP- FCP- CmpltTO-=20
CmpltAbrt-=20
> UnxCmplt- RxOF-=20
MalfTLP- ECRC- UnsupReq- ACSVoil-
> =09=09
UESvrt:=09DLP+ SDES+=20
> TLP- FCP+=20
CmpltTO- CmpltAbrt- UnxCmplt- RxOF+=20
MalfTLP+ ECRC- UnsupReq-=20
>=20
ACSVoil-
> =09=09CESta:=09RxErr- BadTLP-=20
BadDLLP- Rollover- Timeout-=20
>=20
NonFatalErr+
> =09=09CESta:=09RxErr- BadTLP-=20
BadDLLP- Rollover- Timeout-=20
>=20
NonFatalErr+
> =09=09AERCap:=09First Error=20
Pointer: 00, GenCap+ CGenEn-=20
ChkCap+=20
> ChkEn-
> =09Capabilities: [140]=20
Virtual Channel <?>
> =09
Capabilities: [160]=20
> Device Serial Number 00-
00-00-00-00-00-00-00
> =09
Kernel driver in use:=20
> r8169
>=20
>=20
>=20
>=20
>=20
Risparmia con Tutto=20
Incluso Light: telefono + adsl 8 mega a soli 14,95=20
=E2=82=AC al mese.
>=20
>=20
Gratis la Sim Tiscali Mobile con 25 euro di traffico!=20

>=20
> L'offerta =C3=A8=20
valida solo se attivi entro il 20/05/10
>=20
> http:
//abbonati.tiscali.
it/telefono-adsl/prodotti/tc/tuttoincluso_light/?WT.
mc_id=3D01fw
>=20
_______________________________________________ Alsa-
devel mailing list=20
Alsa-devel@alsa-project.org http://mailman.alsa-
project.
org/mailman/listinfo/alsa-devel







Trova Casa sul portale=20
immobiliare n=C2=B01 in Italia

http://tiscali.casa.it




Trova Casa sul portale immobiliare n=C2=B01 in Italia

http://tiscali.casa.it
------=_Part_11096_15971596.1274810921306
Content-Type: APPLICATION/OCTET-STREAM; name=proccodec0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=proccodec0; size=11947

Codec: VIA VT1708S
Address: 0
Function Id: 0x1
Vendor Id: 0x11060397
Subsystem Id: 0x1043836c
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=1, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x10 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Front Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="VT1708S Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
  Amp-Out vals:  [0x2a 0x2a]
  Converter: stream=0, channel=0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
Node 0x11 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Surround Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
  Amp-Out vals:  [0x2a 0x2a]
  Converter: stream=0, channel=0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
Node 0x12 [Audio Output] wcaps 0x611: Stereo Digital
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
  Device: name="VT1708S Digital", type="SPDIF", device=1
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
Node 0x13 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="VT1708S Analog", type="Audio", device=0
  Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x13 0x13]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 1
     0x17
Node 0x14 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Control: name="Capture Volume", index=1, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=1, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x13 0x13]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 1
     0x1e
Node 0x15 [Audio Output] wcaps 0x611: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
Node 0x16 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Control: name="Master Front Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Master Front Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Front Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=4, ofs=0
  Control: name="Front Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=4, ofs=0
  Control: name="Line Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=3, ofs=0
  Control: name="Line Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=3, ofs=0
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x1e 0x1e] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x1f 0x1f] [0x97 0x97] [0x97 0x97]
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 7
     0x10 0x1f 0x1a 0x1b 0x1e 0x1d 0x25
Node 0x17 [Audio Selector] wcaps 0x300501: Stereo
  Control: name="Input Source", index=0, device=0
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 6
     0x1f 0x1a 0x1b 0x1e* 0x1d 0x16
Node 0x18 [Audio Selector] wcaps 0x30050d: Stereo Amp-Out
  Control: name="Surround Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 1
     0x11
Node 0x19 [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x00000014: OUT Detect
  Pin Default 0x01011012: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0x2
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 1
     0x18
Node 0x1a [Pin Complex] wcaps 0x400581: Stereo
  Control: name="Mic Boost Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Smart 5.1", index=0, device=0
  Pincap 0x00002334: IN OUT Detect
    Vref caps: HIZ 50 100
  Pin Default 0x01a19036: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x3, Sequence = 0x6
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 1
     0x26
Node 0x1b [Pin Complex] wcaps 0x400581: Stereo
  Control: name="Independent HP", index=0, device=0
  Control: name="Smart 5.1", index=0, device=0
  Pincap 0x00002334: IN OUT Detect
    Vref caps: HIZ 50 100
  Pin Default 0x0181303e: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x3, Sequence = 0xe
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 1
     0x18
Node 0x1c [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Front Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001001c: OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x16
Node 0x1d [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Independent HP", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000233c: IN OUT HP Detect
    Vref caps: HIZ 50 100
  Pin Default 0x0221401f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=05, enabled=1
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 2
     0x16* 0x25
Node 0x1e [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Front Mic Boost Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Smart 5.1", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000233c: IN OUT HP Detect
    Vref caps: HIZ 50 100
  Pin Default 0x02a19038: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x3, Sequence = 0x8
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 2
     0x16 0x25*
Node 0x1f [Pin Complex] wcaps 0x400401: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x503701f7: [N/A] CD at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x7
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
Node 0x20 [Pin Complex] wcaps 0x400701: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x074311f0: [Jack] SPDIF Out at Ext Rear Panel
    Conn = ATAPI, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x12
Node 0x21 [Pin Complex] wcaps 0x400701: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x074521f0: [Jack] SPDIF Out at Ext Rear Panel
    Conn = Optical, Color = Grey
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x15
Node 0x22 [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x00000014: OUT Detect
  Pin Default 0x01016011: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Orange
    DefAssociation = 0x1, Sequence = 0x1
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 1
     0x26
Node 0x23 [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x00000014: OUT Detect
  Pin Default 0x01012014: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Grey
    DefAssociation = 0x1, Sequence = 0x4
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 1
     0x27
Node 0x24 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Center Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Volume", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
  Amp-Out vals:  [0x2a 0x2a]
  Converter: stream=0, channel=0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
Node 0x25 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Side Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
  Amp-Out vals:  [0x2a 0x2a]
  Converter: stream=0, channel=0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
Node 0x26 [Audio Selector] wcaps 0x30050d: Stereo Amp-Out
  Control: name="Center Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Switch", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 1
     0x24
Node 0x27 [Audio Selector] wcaps 0x30050d: Stereo Amp-Out
  Control: name="Side Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x25

------=_Part_11096_15971596.1274810921306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_11096_15971596.1274810921306--
