From: "SailajaReddy  K" <sailaja_reddi@rediffmail.com>
Subject: No Sound:Redhat linux 9.0,kernel 2.6.7, ALSA1.0.5a
Date: 24 Aug 2004 06:36:05 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040824063605.5877.qmail@mailweb34.rediffmail.com>
Reply-To: "SailajaReddy  K" <sailaja_reddi@rediffmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="Next_1093329358---0-203.199.83.247-5675"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 This is a multipart mime message


--Next_1093329358---0-203.199.83.247-5675
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0AHi,<BR>=0A<BR>=0AI don't hear any sound, when I am trying to listen (=
using headphones)the sound from out ports of my device,&nbsp; ICE1712 - M A=
udio Delta 1010 using &quot;aplay -t wav speech01.wav&quot;. <BR>=0AHad the=
 following:<BR>=0A- Redhat linux 9.0, upgraded the kernel to 2.6.7<BR>=0A- =
ALSA 1.0.5a driver, 1.0.5 lib and utils<BR>=0A- Digi drivers <BR>=0A- Cycla=
de drivers<BR>=0A- Intel(R) Pentium (R) 4 2800 MHz Processor<BR>=0A <BR>=0A=
Shall I need to install any intel driver?<BR>=0A<BR>=0AI have even unmuted =
the channels using &quot;alsamixer&quot;. After opening the<BR>=0Aalsamixer=
 GUI I just raised up all the volumes and removed MM (clicked 'm' to unmute=
 the channels). Please correct me If I need to do more.<BR>=0A<BR>=0AI trie=
d reading the FAQ and trouble shooting but, couldn't find the problem.<BR>=
=0A<BR>=0AThis mail alias is only my hope. Please give your ideas.<BR>=0APl=
ease let me know if more details are needed.<BR>=0A<BR>=0Aroot@aims-pc-100 =
root]# lsmod | grep snd_*<BR>=0Asnd_ice1712&nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; 65316&nbsp; - <BR>=0Asnd_ice17xx_ak4xxx&nbsp; &nbsp; &nbsp; 4004&=
nbsp; - <BR>=0Asnd_pcm&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; 96736&nbsp; - <BR>=0Asnd_page_alloc&nbsp; &nbsp; &nbsp; &nbsp;  11500&nb=
sp; - <BR>=0Asnd_timer&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 2502=
8&nbsp; - <BR>=0Asnd_ak4xxx_adda&nbsp; &nbsp; &nbsp; &nbsp;  5860&nbsp; - <=
BR>=0Asnd_cs8427&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  10660&nbsp; - <B=
R>=0Asnd_ac97_codec&nbsp; &nbsp; &nbsp; &nbsp;  71048&nbsp; - <BR>=0Asnd_i2=
c&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  5668&nbsp; - <BR>=
=0Asnd_mpu401_uart&nbsp; &nbsp; &nbsp; &nbsp;  7716&nbsp; - <BR>=0Asnd_rawm=
idi&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 24384&nbsp; - <BR>=0Asnd_seq_d=
evice&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 8136&nbsp; - <BR>=0Asnd&nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 55588&nbsp; - <BR=
>=0A**************************************************<BR>=0A[root@aims-pc-=
100 root]# cat /proc/asound/cards<BR>=0A0 [M1010&nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; ]: ICE1712 - M Audio Delta 1010<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  M Audio Delta 1010 at 0xb400, irq=
 9<BR>=0A1 [M1010_1&nbsp; &nbsp; &nbsp; &nbsp; ]: ICE1712 - M Audio Delta 1=
010<BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp;  M Audio Delta 1010 at 0xa000, irq 9<BR>=0A***************************=
**********************<BR>=0A[root@aims-pc-100 root]# cat /proc/asound/devi=
ces<BR>=0A&nbsp; 0: [0- 0]: ctl<BR>=0A&nbsp; 8: [0- 0]: raw midi<BR>=0A 16:=
 [0- 0]: digital audio playback<BR>=0A 24: [0- 0]: digital audio capture<BR=
>=0A 33:&nbsp; &nbsp; &nbsp;  : timer<BR>=0A 32: [1- 0]: ctl<BR>=0A 40: [1-=
 0]: raw midi<BR>=0A 48: [1- 0]: digital audio playback<BR>=0A 56: [1- 0]: =
digital audio capture<BR>=0A***********************************************=
*<BR>=0Aroot@aims-pc-100 root]# lspci -vv<BR>=0A00:00.0 Host bridge: Intel =
Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge (rev 03)<BR>=0A&nbsp; &nb=
sp; &nbsp;Subsystem: Asustek Computer, Inc.: Unknown device 80b2<BR>=0A&nbs=
p; &nbsp; &nbsp;Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- Stepping- SERR- FastB2B-<BR>=0A&nbsp; &nbsp; &nbsp;Status: Cap+ 66=
Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast &gt;TAbort- &lt;TAbort- &lt;MAbort=
+ &gt;SERR- &lt;PERR-<BR>=0A&nbsp; &nbsp; &nbsp;Latency: 0<BR>=0A&nbsp; &nb=
sp; &nbsp;Region 0: Memory at f8000000 (32-bit, prefetchable) [size=3D64M]<=
BR>=0A&nbsp; &nbsp; &nbsp;Capabilities: [e4] #09 [6105]<BR>=0A&nbsp; &nbsp;=
 &nbsp;Capabilities: [a0] AGP version 2.0<BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; =
&nbsp; &nbsp;Status: RQ=3D31 SBA+ 64bit- FW+ Rate=3Dx1,x2,x4<BR>=0A&nbsp; &=
nbsp; &nbsp;&nbsp; &nbsp; &nbsp;Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=
=3D&lt;none&gt;<BR>=0A<BR>=0A00:01.0 PCI bridge: Intel Corp. 82845G/GL [Bro=
okdale-G] Chipset AGP Bridge (rev 03) (prog-if 00 [Normal decode])<BR>=0A&n=
bsp; &nbsp; &nbsp;Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoo=
p- ParErr- Stepping- SERR- FastB2B-<BR>=0A&nbsp; &nbsp; &nbsp;Status: Cap- =
66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast &gt;TAbort- &lt;TAbort- &lt;MAbo=
rt- &gt;SERR- &lt;PERR-<BR>=0A&nbsp; &nbsp; &nbsp;Latency: 64<BR>=0A&nbsp; =
&nbsp; &nbsp;Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-laten=
cy=3D0<BR>=0A&nbsp; &nbsp; &nbsp;Memory behind bridge: ee000000-efefffff<BR=
>=0A&nbsp; &nbsp; &nbsp;Prefetchable memory behind bridge: eff00000-f7fffff=
f<BR>=0A&nbsp; &nbsp; &nbsp;BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- &g=
t;Reset- FastB2B-<BR>=0A<BR>=0A00:1d.0 USB Controller: Intel Corp. 82801DB =
USB (Hub #1) (rev 02) (prog-if 00 [UHCI])<BR>=0A&nbsp; &nbsp; &nbsp;Subsyst=
em: Asustek Computer, Inc.: Unknown device 8089<BR>=0A&nbsp; &nbsp; &nbsp;C=
ontrol: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping=
- SERR- FastB2B-<BR>=0A&nbsp; &nbsp; &nbsp;Status: Cap- 66Mhz- UDF- FastB2B=
+ ParErr- DEVSEL=3Dmedium &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt=
;PERR-<BR>=0A&nbsp; &nbsp; &nbsp;Latency: 0<BR>=0A&nbsp; &nbsp; &nbsp;Inter=
rupt: pin A routed to IRQ 5<BR>=0A&nbsp; &nbsp; &nbsp;Region 4: I/O ports a=
t d800 [size=3D32]<BR>=0A<BR>=0A00:1d.1 USB Controller: Intel Corp. 82801DB=
 USB (Hub #2) (rev 02) (prog-if 00 [UHCI])<BR>=0A&nbsp; &nbsp; &nbsp;Subsys=
tem: Asustek Computer, Inc.: Unknown device 8089<BR>=0A&nbsp; &nbsp; &nbsp;=
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppin=
g- SERR- FastB2B-<BR>=0A&nbsp; &nbsp; &nbsp;Status: Cap- 66Mhz- UDF- FastB2=
B+ ParErr- DEVSEL=3Dmedium &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &l=
t;PERR-<BR>=0A&nbsp; &nbsp; &nbsp;Latency: 0<BR>=0A&nbsp; &nbsp; &nbsp;Inte=
rrupt: pin B routed to IRQ 9<BR>=0A&nbsp; &nbsp; &nbsp;Region 4: I/O ports =
at d400 [size=3D32]<BR>=0A<BR>=0A00:1d.2 USB Controller: Intel Corp. 82801D=
B USB (Hub #3) (rev 02) (prog-if 00 [UHCI])<BR>=0A&nbsp; &nbsp; &nbsp;Subsy=
stem: Asustek Computer, Inc.: Unknown device 8089<BR>=0A&nbsp; &nbsp; &nbsp=
;Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-<BR>=0A&nbsp; &nbsp; &nbsp;Status: Cap- 66Mhz- UDF- FastB=
2B+ ParErr- DEVSEL=3Dmedium &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &=
lt;PERR-<BR>=0A&nbsp; &nbsp; &nbsp;Latency: 0<BR>=0A&nbsp; &nbsp; &nbsp;Int=
errupt: pin C routed to IRQ 9<BR>=0A&nbsp; &nbsp; &nbsp;Region 4: I/O ports=
 at d000 [size=3D32]<BR>=0A<BR>=0A00:1e.0 PCI bridge: Intel Corp. 82801BA/C=
A/DB PCI Bridge (rev 82) (prog-if 00 [Normal decode])<BR>=0A&nbsp; &nbsp; &=
nbsp;Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- St=
epping- SERR+ FastB2B-<BR>=0A&nbsp; &nbsp; &nbsp;Status: Cap- 66Mhz- UDF- F=
astB2B+ ParErr- DEVSEL=3Dfast &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR-=
 &lt;PERR+<BR>=0A&nbsp; &nbsp; &nbsp;Latency: 0<BR>=0A&nbsp; &nbsp; &nbsp;B=
us: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D32<BR>=0A=
&nbsp; &nbsp; &nbsp;I/O behind bridge: 00009000-0000bfff<BR>=0A&nbsp; &nbsp=
; &nbsp;Memory behind bridge: eb000000-ed7fffff<BR>=0A&nbsp; &nbsp; &nbsp;B=
ridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- &gt;Reset- FastB2B-<BR>=0A<BR>=
=0A00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)<BR>=0A=
&nbsp; &nbsp; &nbsp;Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASn=
oop- ParErr- Stepping- SERR+ FastB2B-<BR>=0A&nbsp; &nbsp; &nbsp;Status: Cap=
- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium &gt;TAbort- &lt;TAbort- &lt;=
MAbort- &gt;SERR- &lt;PERR-<BR>=0A&nbsp; &nbsp; &nbsp;Latency: 0<BR>=0A<BR>=
=0A00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02) (prog-if 8a=
 [Master SecP PriP])<BR>=0A&nbsp; &nbsp; &nbsp;Subsystem: Asustek Computer,=
 Inc.: Unknown device 8089<BR>=0A&nbsp; &nbsp; &nbsp;Control: I/O+ Mem+ Bus=
Master+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-<BR>=
=0A&nbsp; &nbsp; &nbsp;Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dm=
edium &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR-<BR>=0A&nbsp; =
&nbsp; &nbsp;Latency: 0<BR>=0A&nbsp; &nbsp; &nbsp;Interrupt: pin A routed t=
o IRQ 9<BR>=0A&nbsp; &nbsp; &nbsp;Region 0: I/O ports at &lt;unassigned&gt;=
<BR>=0A&nbsp; &nbsp; &nbsp;Region 1: I/O ports at &lt;unassigned&gt;<BR>=0A=
&nbsp; &nbsp; &nbsp;Region 2: I/O ports at &lt;unassigned&gt;<BR>=0A&nbsp; =
&nbsp; &nbsp;Region 3: I/O ports at &lt;unassigned&gt;<BR>=0A&nbsp; &nbsp; =
&nbsp;Region 4: I/O ports at f000 [size=3D16]<BR>=0A&nbsp; &nbsp; &nbsp;Reg=
ion 5: Memory at 20000000 (32-bit, non-prefetchable) [size=3D1K]<BR>=0A<BR>=
=0A00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 02)<BR>=0A&nbsp; &nbsp; &n=
bsp;Subsystem: Asustek Computer, Inc.: Unknown device 8089<BR>=0A&nbsp; &nb=
sp; &nbsp;Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-<BR>=0A&nbsp; &nbsp; &nbsp;Status: Cap- 66Mhz- U=
DF- FastB2B+ ParErr- DEVSEL=3Dmedium &gt;TAbort- &lt;TAbort- &lt;MAbort- &g=
t;SERR- &lt;PERR-<BR>=0A&nbsp; &nbsp; &nbsp;Interrupt: pin B routed to IRQ =
0<BR>=0A&nbsp; &nbsp; &nbsp;Region 4: I/O ports at e800 [size=3D32]<BR>=0A<=
BR>=0A01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 =
MX 440 AGP 8x] (rev c1) (prog-if 00 [VGA])<BR>=0A&nbsp; &nbsp; &nbsp;Subsys=
tem: CardExpert Technology: Unknown device 0427<BR>=0A&nbsp; &nbsp; &nbsp;C=
ontrol: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping=
- SERR- FastB2B-<BR>=0A&nbsp; &nbsp; &nbsp;Status: Cap+ 66Mhz+ UDF- FastB2B=
+ ParErr- DEVSEL=3Dmedium &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt=
;PERR-<BR>=0A&nbsp; &nbsp; &nbsp;Latency: 64 (1250ns min, 250ns max)<BR>=0A=
&nbsp; &nbsp; &nbsp;Interrupt: pin A routed to IRQ 5<BR>=0A&nbsp; &nbsp; &n=
bsp;Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=3D16M]<BR=
>=0A&nbsp; &nbsp; &nbsp;Region 1: Memory at f0000000 (32-bit, prefetchable)=
 [size=3D128M]<BR>=0A&nbsp; &nbsp; &nbsp;Expansion ROM at effe0000 [disable=
d] [size=3D128K]<BR>=0A&nbsp; &nbsp; &nbsp;Capabilities: [60] Power Managem=
ent version 2<BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;Flags: PMEClk- =
DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)<BR>=0A&nbsp; =
&nbsp; &nbsp;&nbsp; &nbsp; &nbsp;Status: D0 PME-Enable- DSel=3D0 DScale=3D0=
 PME-<BR>=0A&nbsp; &nbsp; &nbsp;Capabilities: [44] AGP version 3.0<BR>=0A&n=
bsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;Status: RQ=3D31 SBA- 64bit- FW+ Rate=
=3Dx1,x2,x4<BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;Command: RQ=3D0 S=
BA- AGP- 64bit- FW- Rate=3D&lt;none&gt;<BR>=0A<BR>=0A02:05.0 Ethernet contr=
oller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)<BR>=
=0A&nbsp; &nbsp; &nbsp;Subsystem: Asustek Computer, Inc.: Unknown device 81=
09<BR>=0A&nbsp; &nbsp; &nbsp;Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWI=
NV- VGASnoop- ParErr- Stepping- SERR- FastB2B-<BR>=0A&nbsp; &nbsp; &nbsp;St=
atus: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium &gt;TAbort- &lt;TAb=
ort- &lt;MAbort- &gt;SERR- &lt;PERR-<BR>=0A&nbsp; &nbsp; &nbsp;Latency: 32 =
(8000ns min, 16000ns max)<BR>=0A&nbsp; &nbsp; &nbsp;Interrupt: pin A routed=
 to IRQ 10<BR>=0A&nbsp; &nbsp; &nbsp;Region 0: I/O ports at b800 [size=3D25=
6]<BR>=0A&nbsp; &nbsp; &nbsp;Region 1: Memory at ed000000 (32-bit, non-pref=
etchable) [size=3D256]<BR>=0A&nbsp; &nbsp; &nbsp;Capabilities: [50] Power M=
anagement version 2<BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;Flags: PM=
EClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)<BR>=
=0A&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;Status: D0 PME-Enable- DSel=3D0 =
DScale=3D0 PME-<BR>=0A<BR>=0A02:09.0 Multimedia audio controller: IC Ensemb=
le Inc ICE1712 [Envy24] (rev 02)<BR>=0A&nbsp; &nbsp; &nbsp;Subsystem: IC En=
semble Inc: Unknown device d630<BR>=0A&nbsp; &nbsp; &nbsp;Control: I/O+ Mem=
- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-=
<BR>=0A&nbsp; &nbsp; &nbsp;Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=
=3Dmedium &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR-<BR>=0A&nb=
sp; &nbsp; &nbsp;Latency: 32<BR>=0A&nbsp; &nbsp; &nbsp;Interrupt: pin A rou=
ted to IRQ 9<BR>=0A&nbsp; &nbsp; &nbsp;Region 0: I/O ports at b400 [size=3D=
32]<BR>=0A&nbsp; &nbsp; &nbsp;Region 1: I/O ports at b000 [size=3D16]<BR>=
=0A&nbsp; &nbsp; &nbsp;Region 2: I/O ports at a800 [size=3D16]<BR>=0A&nbsp;=
 &nbsp; &nbsp;Region 3: I/O ports at a400 [size=3D64]<BR>=0A&nbsp; &nbsp; &=
nbsp;Capabilities: [80] Power Management version 1<BR>=0A&nbsp; &nbsp; &nbs=
p;&nbsp; &nbsp; &nbsp;Flags: PMEClk- DSI- D1- D2+ AuxCurrent=3D0mA PME(D0-,=
D1-,D2-,D3hot-,D3cold-)<BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;Statu=
s: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-<BR>=0A<BR>=0A02:0a.0 Multimedia =
audio controller: IC Ensemble Inc ICE1712 [Envy24] (rev 02)<BR>=0A&nbsp; &n=
bsp; &nbsp;Subsystem: IC Ensemble Inc: Unknown device d630<BR>=0A&nbsp; &nb=
sp; &nbsp;Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B-<BR>=0A&nbsp; &nbsp; &nbsp;Status: Cap+ 66Mhz- U=
DF- FastB2B- ParErr- DEVSEL=3Dmedium &gt;TAbort- &lt;TAbort- &lt;MAbort- &g=
t;SERR- &lt;PERR-<BR>=0A&nbsp; &nbsp; &nbsp;Latency: 32<BR>=0A&nbsp; &nbsp;=
 &nbsp;Interrupt: pin A routed to IRQ 9<BR>=0A&nbsp; &nbsp; &nbsp;Region 0:=
 I/O ports at a000 [size=3D32]<BR>=0A&nbsp; &nbsp; &nbsp;Region 1: I/O port=
s at 9800 [size=3D16]<BR>=0A&nbsp; &nbsp; &nbsp;Region 2: I/O ports at 9400=
 [size=3D16]<BR>=0A&nbsp; &nbsp; &nbsp;Region 3: I/O ports at 9000 [size=3D=
64]<BR>=0A&nbsp; &nbsp; &nbsp;Capabilities: [80] Power Management version 1=
<BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;Flags: PMEClk- DSI- D1- D2+ =
AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)<BR>=0A&nbsp; &nbsp; &nbsp;=
&nbsp; &nbsp; &nbsp;Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-<BR>=0A<=
BR>=0A02:0d.0 Communication controller: Digi International AccelePort Xp<BR=
>=0A&nbsp; &nbsp; &nbsp;Subsystem: Digi International: Unknown device 0045<=
BR>=0A&nbsp; &nbsp; &nbsp;Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+=
 VGASnoop- ParErr- Stepping- SERR- FastB2B-<BR>=0A&nbsp; &nbsp; &nbsp;Statu=
s: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium &gt;TAbort- &lt;TAbort=
- &lt;MAbort- &gt;SERR- &lt;PERR-<BR>=0A&nbsp; &nbsp; &nbsp;Latency: 32, ca=
che line size 08<BR>=0A&nbsp; &nbsp; &nbsp;Interrupt: pin A routed to IRQ 9=
<BR>=0A&nbsp; &nbsp; &nbsp;Region 0: Memory at ec800000 (32-bit, non-prefet=
chable) [size=3D2M]<BR>=0A&nbsp; &nbsp; &nbsp;Region 1: Memory at ec000000 =
(32-bit, non-prefetchable) [size=3D64K]<BR>=0A&nbsp; &nbsp; &nbsp;Capabilit=
ies: [44] Power Management version 1<BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; &nbsp=
; &nbsp;Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-=
,D3cold-)<BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;Status: D0 PME-Enab=
le- DSel=3D0 DScale=3D0 PME-<BR>=0A&nbsp; &nbsp; &nbsp;Capabilities: [4c] V=
ital Product Data<BR>=0A<BR>=0A02:0e.0 Communication controller: Digi Inter=
national AccelePort Xp<BR>=0A&nbsp; &nbsp; &nbsp;Subsystem: Digi Internatio=
nal: Unknown device 0045<BR>=0A&nbsp; &nbsp; &nbsp;Control: I/O- Mem+ BusMa=
ster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-<BR>=0A=
&nbsp; &nbsp; &nbsp;Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedi=
um &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR-<BR>=0A&nbsp; &nb=
sp; &nbsp;Latency: 32, cache line size 08<BR>=0A&nbsp; &nbsp; &nbsp;Interru=
pt: pin A routed to IRQ 9<BR>=0A&nbsp; &nbsp; &nbsp;Region 0: Memory at eb8=
00000 (32-bit, non-prefetchable) [size=3D2M]<BR>=0A&nbsp; &nbsp; &nbsp;Regi=
on 1: Memory at eb000000 (32-bit, non-prefetchable) [size=3D64K]<BR>=0A&nbs=
p; &nbsp; &nbsp;Capabilities: [44] Power Management version 1<BR>=0A&nbsp; =
&nbsp; &nbsp;&nbsp; &nbsp; &nbsp;Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0=
mA PME(D0-,D1-,D2-,D3hot-,D3cold-)<BR>=0A&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; =
&nbsp;Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-<BR>=0A&nbsp; &nbsp; &=
nbsp;Capabilities: [4c] Vital Product Data<BR>=0A**************************=
**************************<BR>=0AMy /etc/modules.conf<BR>=0A<BR>=0Aalias et=
h0 8139too<BR>=0Aalias usb-controller ehci-hcd<BR>=0Aalias usb-controller1 =
usb-uhci<BR>=0Aalias sound-slot-0 i810_audio<BR>=0Apost-install sound-slot-=
0 /bin/aumix-minimal -f /etc/.aumixrc -L &gt;/dev/null<BR>=0A2&gt;&amp;1 ||=
 :<BR>=0Apre-remove sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -S &gt=
;/dev/null 2&gt;&amp;1<BR>=0A|| :<BR>=0A# ALSA portion<BR>=0Aalias char-maj=
or-116 snd<BR>=0Aoptions snd snd_major=3D116 snd_cards_limit=3D2<BR>=0Aalia=
s snd-card-0 snd-ice1712<BR>=0Aalias snd-card-1 snd-ice1712<BR>=0A&nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0A# module options should go h=
ere<BR>=0A# OSS/Free portion<BR>=0Aalias char-major-14 soundcore<BR>=0A&nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0A# card #1<BR>=0Aalias s=
ound-service-0-0 snd-mixer-oss<BR>=0Aalias sound-service-0-1 snd-seq-oss<BR=
>=0Aalias sound-service-0-3 snd-pcm-oss<BR>=0Aalias sound-service-0-8 snd-s=
eq-oss<BR>=0Aalias sound-service-0-12 snd-pcm-oss<BR>=0A&nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp;  <BR>=0A# OSS/Free portion - card #2<BR>=0Aali=
as sound-service-1-0 snd-mixer-oss<BR>=0Aalias sound-service-1-3 snd-pcm-os=
s<BR>=0Aalias sound-service-1-12 snd-pcm-oss<BR>=0A<BR>=0ARegards,<BR>=0ASa=
ilaja=0A</P>=0A<br><br>=0A<A target=3D"_blank" HREF=3D"http://clients.redif=
f.com/signature/track_sig.asp"><IMG SRC=3D"http://ads.rediff.com/RealMedia/=
ads/adstream_nx.cgi/www.rediffmail.com/inbox.htm@Bottom" BORDER=3D0 VSPACE=
=3D0 HSPACE=3D0></a>=0A
--Next_1093329358---0-203.199.83.247-5675
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,=0A=0AI don't hear any sound, when I am trying to listen (using headphon=
es)the sound from out ports of my device,  ICE1712 - M Audio Delta 1010 usi=
ng "aplay -t wav speech01.wav". =0AHad the following:=0A- Redhat linux 9.0,=
 upgraded the kernel to 2.6.7=0A- ALSA 1.0.5a driver, 1.0.5 lib and utils=
=0A- Digi drivers =0A- Cyclade drivers=0A- Intel(R) Pentium (R) 4 2800 MHz =
Processor=0A =0AShall I need to install any intel driver?=0A=0AI have even =
unmuted the channels using "alsamixer". After opening the=0Aalsamixer GUI I=
 just raised up all the volumes and removed MM (clicked 'm' to unmute the c=
hannels). Please correct me If I need to do more.=0A=0AI tried reading the =
FAQ and trouble shooting but, couldn't find the problem.=0A=0AThis mail ali=
as is only my hope. Please give your ideas.=0APlease let me know if more de=
tails are needed.=0A=0Aroot@aims-pc-100 root]# lsmod | grep snd_*=0Asnd_ice=
1712            65316  - =0Asnd_ice17xx_ak4xxx      4004  - =0Asnd_pcm     =
           96736  - =0Asnd_page_alloc         11500  - =0Asnd_timer        =
      25028  - =0Asnd_ak4xxx_adda         5860  - =0Asnd_cs8427            =
 10660  - =0Asnd_ac97_codec         71048  - =0Asnd_i2c                 566=
8  - =0Asnd_mpu401_uart         7716  - =0Asnd_rawmidi            24384  - =
=0Asnd_seq_device          8136  - =0Asnd                    55588  - =0A**=
************************************************=0A[root@aims-pc-100 root]#=
 cat /proc/asound/cards=0A0 [M1010          ]: ICE1712 - M Audio Delta 1010=
=0A                     M Audio Delta 1010 at 0xb400, irq 9=0A1 [M1010_1   =
     ]: ICE1712 - M Audio Delta 1010=0A                     M Audio Delta 1=
010 at 0xa000, irq 9=0A*************************************************=0A=
[root@aims-pc-100 root]# cat /proc/asound/devices=0A  0: [0- 0]: ctl=0A  8:=
 [0- 0]: raw midi=0A 16: [0- 0]: digital audio playback=0A 24: [0- 0]: digi=
tal audio capture=0A 33:       : timer=0A 32: [1- 0]: ctl=0A 40: [1- 0]: ra=
w midi=0A 48: [1- 0]: digital audio playback=0A 56: [1- 0]: digital audio c=
apture=0A************************************************=0Aroot@aims-pc-10=
0 root]# lspci -vv=0A00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-=
G] Chipset Host Bridge (rev 03)=0A	Subsystem: Asustek Computer, Inc.: Unkno=
wn device 80b2=0A	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoo=
p- ParErr- Stepping- SERR- FastB2B-=0A	Status: Cap+ 66Mhz- UDF- FastB2B+ Pa=
rErr- DEVSEL=3Dfast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-=0A	Latency: 0=
=0A	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=3D64M]=0A	Cap=
abilities: [e4] #09 [6105]=0A	Capabilities: [a0] AGP version 2.0=0A		Status=
: RQ=3D31 SBA+ 64bit- FW+ Rate=3Dx1,x2,x4=0A		Command: RQ=3D0 SBA- AGP- 64b=
it- FW- Rate=3D<none>=0A=0A00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brook=
dale-G] Chipset AGP Bridge (rev 03) (prog-if 00 [Normal decode])=0A	Control=
: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR=
- FastB2B-=0A	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbo=
rt- <TAbort- <MAbort- >SERR- <PERR-=0A	Latency: 64=0A	Bus: primary=3D00, se=
condary=3D01, subordinate=3D01, sec-latency=3D0=0A	Memory behind bridge: ee=
000000-efefffff=0A	Prefetchable memory behind bridge: eff00000-f7ffffff=0A	=
BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-=0A=0A00:1d.0 =
USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02) (prog-if 00 [UHCI=
])=0A	Subsystem: Asustek Computer, Inc.: Unknown device 8089=0A	Control: I/=
O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- Fa=
stB2B-=0A	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-=0A	Latency: 0=0A	Interrupt: pin A routed =
to IRQ 5=0A	Region 4: I/O ports at d800 [size=3D32]=0A=0A00:1d.1 USB Contro=
ller: Intel Corp. 82801DB USB (Hub #2) (rev 02) (prog-if 00 [UHCI])=0A	Subs=
ystem: Asustek Computer, Inc.: Unknown device 8089=0A	Control: I/O+ Mem- Bu=
sMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-=0A	=
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-=
 <MAbort- >SERR- <PERR-=0A	Latency: 0=0A	Interrupt: pin B routed to IRQ 9=
=0A	Region 4: I/O ports at d400 [size=3D32]=0A=0A00:1d.2 USB Controller: In=
tel Corp. 82801DB USB (Hub #3) (rev 02) (prog-if 00 [UHCI])=0A	Subsystem: A=
sustek Computer, Inc.: Unknown device 8089=0A	Control: I/O+ Mem- BusMaster+=
 SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-=0A	Status: =
Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort=
- >SERR- <PERR-=0A	Latency: 0=0A	Interrupt: pin C routed to IRQ 9=0A	Region=
 4: I/O ports at d000 [size=3D32]=0A=0A00:1e.0 PCI bridge: Intel Corp. 8280=
1BA/CA/DB PCI Bridge (rev 82) (prog-if 00 [Normal decode])=0A	Control: I/O+=
 Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ Fast=
B2B-=0A	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR+=0A	Latency: 0=0A	Bus: primary=3D00, secondary=
=3D02, subordinate=3D02, sec-latency=3D32=0A	I/O behind bridge: 00009000-00=
00bfff=0A	Memory behind bridge: eb000000-ed7fffff=0A	BridgeCtl: Parity- SER=
R+ NoISA+ VGA- MAbort- >Reset- FastB2B-=0A=0A00:1f.0 ISA bridge: Intel Corp=
. 82801DB ISA Bridge (LPC) (rev 02)=0A	Control: I/O+ Mem+ BusMaster+ SpecCy=
cle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-=0A	Status: Cap- 66=
Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR=
- <PERR-=0A	Latency: 0=0A=0A00:1f.1 IDE interface: Intel Corp. 82801DB ICH4=
 IDE (rev 02) (prog-if 8a [Master SecP PriP])=0A	Subsystem: Asustek Compute=
r, Inc.: Unknown device 8089=0A	Control: I/O+ Mem+ BusMaster+ SpecCycle- Me=
mWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-=0A	Status: Cap- 66Mhz- UD=
F- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR=
-=0A	Latency: 0=0A	Interrupt: pin A routed to IRQ 9=0A	Region 0: I/O ports =
at <unassigned>=0A	Region 1: I/O ports at <unassigned>=0A	Region 2: I/O por=
ts at <unassigned>=0A	Region 3: I/O ports at <unassigned>=0A	Region 4: I/O =
ports at f000 [size=3D16]=0A	Region 5: Memory at 20000000 (32-bit, non-pref=
etchable) [size=3D1K]=0A=0A00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 02=
)=0A	Subsystem: Asustek Computer, Inc.: Unknown device 8089=0A	Control: I/O=
+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- Fas=
tB2B-=0A	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
 <TAbort- <MAbort- >SERR- <PERR-=0A	Interrupt: pin B routed to IRQ 0=0A	Reg=
ion 4: I/O ports at e800 [size=3D32]=0A=0A01:00.0 VGA compatible controller=
: nVidia Corporation NV18 [GeForce4 MX 440 AGP 8x] (rev c1) (prog-if 00 [VG=
A])=0A	Subsystem: CardExpert Technology: Unknown device 0427=0A	Control: I/=
O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- Fa=
stB2B-=0A	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR-=0A	Latency: 64 (1250ns min, 250ns max)=0A=
	Interrupt: pin A routed to IRQ 5=0A	Region 0: Memory at ee000000 (32-bit, =
non-prefetchable) [size=3D16M]=0A	Region 1: Memory at f0000000 (32-bit, pre=
fetchable) [size=3D128M]=0A	Expansion ROM at effe0000 [disabled] [size=3D12=
8K]=0A	Capabilities: [60] Power Management version 2=0A		Flags: PMEClk- DSI=
- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A		Status: D0 P=
ME-Enable- DSel=3D0 DScale=3D0 PME-=0A	Capabilities: [44] AGP version 3.0=
=0A		Status: RQ=3D31 SBA- 64bit- FW+ Rate=3Dx1,x2,x4=0A		Command: RQ=3D0 SB=
A- AGP- 64bit- FW- Rate=3D<none>=0A=0A02:05.0 Ethernet controller: Realtek =
Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)=0A	Subsystem: Asuste=
k Computer, Inc.: Unknown device 8109=0A	Control: I/O+ Mem+ BusMaster+ Spec=
Cycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-=0A	Status: Cap+ =
66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SE=
RR- <PERR-=0A	Latency: 32 (8000ns min, 16000ns max)=0A	Interrupt: pin A rou=
ted to IRQ 10=0A	Region 0: I/O ports at b800 [size=3D256]=0A	Region 1: Memo=
ry at ed000000 (32-bit, non-prefetchable) [size=3D256]=0A	Capabilities: [50=
] Power Management version 2=0A		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D3=
75mA PME(D0-,D1+,D2+,D3hot+,D3cold+)=0A		Status: D0 PME-Enable- DSel=3D0 DS=
cale=3D0 PME-=0A=0A02:09.0 Multimedia audio controller: IC Ensemble Inc ICE=
1712 [Envy24] (rev 02)=0A	Subsystem: IC Ensemble Inc: Unknown device d630=
=0A	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B-=0A	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=
=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-=0A	Latency: 32=0A	Interr=
upt: pin A routed to IRQ 9=0A	Region 0: I/O ports at b400 [size=3D32]=0A	Re=
gion 1: I/O ports at b000 [size=3D16]=0A	Region 2: I/O ports at a800 [size=
=3D16]=0A	Region 3: I/O ports at a400 [size=3D64]=0A	Capabilities: [80] Pow=
er Management version 1=0A		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=3D0mA PM=
E(D0-,D1-,D2-,D3hot-,D3cold-)=0A		Status: D0 PME-Enable- DSel=3D0 DScale=3D=
0 PME-=0A=0A02:0a.0 Multimedia audio controller: IC Ensemble Inc ICE1712 [E=
nvy24] (rev 02)=0A	Subsystem: IC Ensemble Inc: Unknown device d630=0A	Contr=
ol: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SE=
RR- FastB2B-=0A	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >=
TAbort- <TAbort- <MAbort- >SERR- <PERR-=0A	Latency: 32=0A	Interrupt: pin A =
routed to IRQ 9=0A	Region 0: I/O ports at a000 [size=3D32]=0A	Region 1: I/O=
 ports at 9800 [size=3D16]=0A	Region 2: I/O ports at 9400 [size=3D16]=0A	Re=
gion 3: I/O ports at 9000 [size=3D64]=0A	Capabilities: [80] Power Managemen=
t version 1=0A		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot-,D3cold-)=0A		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=0A=
02:0d.0 Communication controller: Digi International AccelePort Xp=0A	Subsy=
stem: Digi International: Unknown device 0045=0A	Control: I/O- Mem+ BusMast=
er+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-=0A	Statu=
s: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort- <MAb=
ort- >SERR- <PERR-=0A	Latency: 32, cache line size 08=0A	Interrupt: pin A r=
outed to IRQ 9=0A	Region 0: Memory at ec800000 (32-bit, non-prefetchable) [=
size=3D2M]=0A	Region 1: Memory at ec000000 (32-bit, non-prefetchable) [size=
=3D64K]=0A	Capabilities: [44] Power Management version 1=0A		Flags: PMEClk-=
 DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A		Status: =
D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A	Capabilities: [4c] Vital Product=
 Data=0A=0A02:0e.0 Communication controller: Digi International AccelePort =
Xp=0A	Subsystem: Digi International: Unknown device 0045=0A	Control: I/O- M=
em+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2=
B-=0A	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-=0A	Latency: 32, cache line size 08=0A	Interru=
pt: pin A routed to IRQ 9=0A	Region 0: Memory at eb800000 (32-bit, non-pref=
etchable) [size=3D2M]=0A	Region 1: Memory at eb000000 (32-bit, non-prefetch=
able) [size=3D64K]=0A	Capabilities: [44] Power Management version 1=0A		Fla=
gs: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)=
=0A		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A	Capabilities: [4c] =
Vital Product Data=0A****************************************************=
=0AMy /etc/modules.conf=0A=0Aalias eth0 8139too=0Aalias usb-controller ehci=
-hcd=0Aalias usb-controller1 usb-uhci=0Aalias sound-slot-0 i810_audio=0Apos=
t-install sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -L >/dev/null=0A=
2>&1 || :=0Apre-remove sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -S =
>/dev/null 2>&1=0A|| :=0A# ALSA portion=0Aalias char-major-116 snd=0Aoption=
s snd snd_major=3D116 snd_cards_limit=3D2=0Aalias snd-card-0 snd-ice1712=0A=
alias snd-card-1 snd-ice1712=0A                                            =
                                   =0A# module options should go here=0A# O=
SS/Free portion=0Aalias char-major-14 soundcore=0A                         =
                                                      =0A# card #1=0Aalias =
sound-service-0-0 snd-mixer-oss=0Aalias sound-service-0-1 snd-seq-oss=0Aali=
as sound-service-0-3 snd-pcm-oss=0Aalias sound-service-0-8 snd-seq-oss=0Aal=
ias sound-service-0-12 snd-pcm-oss=0A                                      =
                                         =0A# OSS/Free portion - card #2=0A=
alias sound-service-1-0 snd-mixer-oss=0Aalias sound-service-1-3 snd-pcm-oss=
=0Aalias sound-service-1-12 snd-pcm-oss=0A=0ARegards,=0ASailaja
--Next_1093329358---0-203.199.83.247-5675--



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
