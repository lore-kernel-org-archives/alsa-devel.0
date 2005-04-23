From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: Re: au88x0_synth
Date: Sat, 23 Apr 2005 09:28:00 +0200
Message-ID: <200504230928.06494.alien999999999@users.sourceforge.net>
References: <423CCDAC.80401@netvigator.com> <200503301013.30400.alien999999999@users.sourceforge.net> <4269C953.4050504@netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2195056.ERJHWoV1GI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4269C953.4050504@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Raymond <rayau@netvigator.com>
List-Id: alsa-devel@alsa-project.org

--nextPart2195056.ERJHWoV1GI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op zaterdag 23 april 2005 06:04, schreef Raymond:
> Alien wrote:
> > while you guys are working on that driver, is there anyone that has a
> > 64bit setup? if not, i'd like to test out your driver in 64bit. i still
> > have a number of issues with it (my card is an au8810).
>
> I do not have any 64bit setup, are you sure that your 64bit patch is
> correct ?

well, i'm using it every day. and before the patch at modprobe time i got=20
kernel oops... so...

I don't do much special things with it, I use it for line in and PCM and=20
stereo output, i don't use the equalizer or anything fancy...

> http://kerneltrap.org/node/3848

I'm still using kernel 2.6.8, though it has a fairly large number of patche=
s,=20
but since i didn't decide this, it may very well be in there and I may have=
=20
just used this... you may want this implemented, since both PIO and MMIO is=
=20
used in your driver.

> snd-au88x0 use the following macros to perform read/write of 32bit data
> from/to Memory Mapped I/O
>
> #define	hwread(x,y) readl((x)+((y)>>2))
> #define	hwwrite(x,y,z) writel((z),(x)+((y)>>2))

i think the memory mapped I/O is 64bit in 64bit CPU's.

> Would you provide the result of "lspci -vvvn" to find out the content of
> PCI BAR0 of your au8810 card ?

ok:

[]# lspci -vvvn
00:00.0 Class 0600: 1106:3188 (rev 01)
	Subsystem: 1043:80a3
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at 00000000e0000000 (32-bit, prefetchable) [size=3D256M]
	Capabilities: [80] AGP version 3.5
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D2 SBA+ ITACoh- GART64- HTrans- 64bit=
=2D FW+=20
AGP3+ Rate=3Dx8
		Command: RQ=3D1 ArqSz=3D0 Cal=3D2 SBA+ AGP+ GART64- 64bit- FW- Rate=3Dx8
	Capabilities: [c0] #08 [0060]
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [58] #08 [8001]

00:01.0 Class 0604: 1106:b188
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: faf00000-fd0fffff
	Prefetchable memory behind bridge: bfb00000-dfafffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.0 Class 0c00: 1106:3044 (rev 80) (prog-if 10)
	Subsystem: 1043:808a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64 (8000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 0000000040000000 (32-bit, non-prefetchable) [size=3D2K]
	Region 1: I/O ports at 1000 [size=3D128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:09.0 Class 0400: 109e:036e (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 00000000dfe00000 (32-bit, prefetchable) [size=3D4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:09.1 Class 0480: 109e:0878 (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 00000000dff00000 (32-bit, prefetchable) [size=3D4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0a.0 Class 0200: 11ab:4320 (rev 13)
	Subsystem: 1043:811a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng-=20
SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64 (5750ns min, 7750ns max), cache line size 40
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 00000000fd900000 (32-bit, non-prefetchable) [size=3D16=
K]
	Region 1: I/O ports at bc00 [size=3D256]
	Expansion ROM at 00000000fd800000 [disabled] [size=3D128K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [50] Vital Product Data

00:0c.0 Class 0401: 12eb:0003 (rev 02)
	Subsystem: 12eb:0003
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 20750ns max), cache line size 40
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 00000000fdc00000 (32-bit, non-prefetchable) [size=3D25=
6K]
	Region 1: I/O ports at dc00 [size=3D8]
	Region 2: I/O ports at cc00 [size=3D8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2+,D3hot+,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0d.0 Class 0401: 1102:0002 (rev 0a)
	Subsystem: 1102:8066
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at ec00 [size=3D32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0d.1 Class 0980: 1102:7002 (rev 0a)
	Subsystem: 1102:0020
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at b000 [size=3D8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0e.0 Class 0200: 10b7:9004 (rev 04)
	Subsystem: 10b7:9004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng-=20
SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 12000ns max), cache line size 40
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at b400 [size=3D128]
	Region 1: Memory at 00000000fde00000 (32-bit, non-prefetchable) [size=3D12=
8]
	Expansion ROM at 00000000fdd00000 [disabled] [size=3D128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0f.0 Class 0104: 1106:3149 (rev 80)
	Subsystem: 1043:80ed
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at e400 [size=3D8]
	Region 1: I/O ports at e000 [size=3D4]
	Region 2: I/O ports at d800 [size=3D8]
	Region 3: I/O ports at d400 [size=3D4]
	Region 4: I/O ports at d000 [size=3D16]
	Region 5: I/O ports at c800 [size=3D256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0f.1 Class 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: 1043:80ed
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at fc00 [size=3D16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.0 Class 0c03: 1106:3038 (rev 81)
	Subsystem: 1043:80ed
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64, cache line size 40
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at b800 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.1 Class 0c03: 1106:3038 (rev 81)
	Subsystem: 1043:80ed
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64, cache line size 40
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at c000 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.2 Class 0c03: 1106:3038 (rev 81)
	Subsystem: 1043:80ed
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64, cache line size 40
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at c400 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.4 Class 0c03: 1106:3104 (rev 86) (prog-if 20)
	Subsystem: 1043:80ed
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 64, cache line size 40
	Interrupt: pin C routed to IRQ 3
	Region 0: Memory at 00000000fdf00000 (32-bit, non-prefetchable) [size=3D25=
6]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.0 Class 0601: 1106:3227
	Subsystem: 1043:80ed
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+=20
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:18.0 Class 0600: 1022:1100
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-=
=20
<MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]

00:18.1 Class 0600: 1022:1101
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-=
=20
<MAbort- >SERR- <PERR-

00:18.2 Class 0600: 1022:1102
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-=
=20
<MAbort- >SERR- <PERR-

00:18.3 Class 0600: 1022:1103
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-=
=20
<MAbort- >SERR- <PERR-

01:00.0 Class 0300: 10de:0322 (rev a1)
	Subsystem: 10b0:0427
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng-=20
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
=2D=20
<MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 00000000fb000000 (32-bit, non-prefetchable) [size=3D16=
M]
	Region 1: Memory at 00000000c0000000 (32-bit, prefetchable) [size=3D256M]
	Expansion ROM at 00000000fd000000 [disabled] [size=3D128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [44] AGP version 3.0
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D3 SBA+ ITACoh- GART64- HTrans- 64bit=
=2D FW+=20
AGP3+ Rate=3Dx4,x8
		Command: RQ=3D32 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64bit- FW- Rate=3Dx8



> What is the model of your au8810 card (e.g. Vortex Advantage, SQ1500,
> SoundCom V90) ?

bulk model, Aureal Vortex something or other...
lspci gives: 00:0c.0 Multimedia audio controller: Aureal Semiconductor AU88=
10=20
Vortex Digital Audio Processor (rev 02)

> Do your 64bit machine has more than 4Gb memory ?

no

> > sometimes i start playing a song, and it starts playing a few second
> > or so and hangs, then i kill the application and modprobe -r all sound
> > modules and modprobe them again to make it work again.
>
> Do your configure all the sound-apps to use ALSA instead of OSS ?

all of them do, but I do have a few that use OSS-emulation too

> > BUT: sometimes not only that happens, but also when i try to kill the
> > apps it will not kill. when that happens, all kill, killall, top, ps
> > aux commands hang at the command line and cannot be killed by CTRL-C
> > or otherwise, i have been able to see that when i stopped my display
> > managener I did an lsmod and it gave something like this:
> >
> > snd-pcm-oss            59752  11
> > snd-mixer-oss          20480  1 snd-pcm-oss
> > snd-au8810             43760  220
> > snd-ac97-codec         83408  1 snd-au8810
> > snd-pcm               108172  112 snd-pcm-oss,snd-au8810,snd-ac97-codec
> > snd-page-alloc         10384  1 snd-pcm
> > gameport                3840  1 snd-au8810
> > snd-mpu401-uart        11904  1 snd-au8810
> >
> >
> > as you can see the snd-au8810 module seem to have an impossible number
> > of "dependencies" (i think has to do with the number of unclosed
> > sound-apps trying to be played; this could be since gaim is programmed
> > to execute an 'aplay %s')
>
> This is abnormal, au8810 has 16 SRC and snd-au8810 can play either 16
> mono streams or 8 stereo streams concurrently.

of course it is abnormal...

> Use alsamixer to find out which ac97 codec on your au8810.

chip: Wolfson WM9701A

> Do you have any application using gameport, mpu401 or OSS  ?

haven't gotten any gameport to work, not on the emu10k1 nor the au8810, nev=
er=20
use MPU401 and i use OSS emulation on games like AA, ET, OpenAL...

> > i've had this major crash below only 3 times; and the logs didn't
> > detect anything specific at the time. the only thing the logs
> > mentioned at that time was an ntpd sync going on; so the only thing i
> > can think of is that at a certain moment when a sync is going on, some
> > kind of lock is holding cause this to happen... the only thing that i
> > can do to fix this is reset...
>
> Do the log indicate the snd-au8810 is loaded properly ?

yes of course: it gives

vortex: reg error

as always ;-)

> > it is interesting to note that i also have an snd-emu10k1 as second
> > card, which never gave problems like this, and i am always able to
> > "modprobe -r snd-emu10k1" ...
>
> snd-emu10k1 use PIO.
>
> Would you post the content of /etc/modprobe.conf ?

I'm not using that right now:

if i want to use sound after bootup (which doesn't happen often at all), I =
do:

modprobe snd-au8810
modprobe snd-emu10k1
modprobe snd-pcm-oss
alsactl restore -f /data/path/mixer

--nextPart2195056.ERJHWoV1GI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCafkGuBWKXETrtdcRArhlAKDSIHf+REqyj+61iEA48u6SpyW5OwCgmR+I
FF7/+I/8JsZ/qQCJs3DtyzE=
=AXsZ
-----END PGP SIGNATURE-----

--nextPart2195056.ERJHWoV1GI--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
