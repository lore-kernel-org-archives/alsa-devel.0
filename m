From: Andre Schramm <andre.schramm@iosono-sound.com>
Subject: Re: Issues with HDSPM
Date: Mon, 20 Jun 2011 15:29:31 +0200
Message-ID: <20110620152931.727d2369@revell.mafea.no-ip.org>
References: <20110606210425.0a4c2901@revell.mafea.no-ip.org>
	<4DEDDB0D.4000709@stackingdwarves.net>
	<4DEDF326.7080909@drcomp.erfurt.thur.de>
	<4DEE1D92.8030207@stackingdwarves.net>
	<4DEE1E02.10705@drcomp.erfurt.thur.de>
	<20110607185211.297a69f1@revell.mafea.no-ip.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/dq7BEGWJPCdAxeQZ_En9u8r"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 9606C24416
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 15:29:36 +0200 (CEST)
In-Reply-To: <20110607185211.297a69f1@revell.mafea.no-ip.org>
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
Cc: Robert Steffens <robert.steffens@iosono-sound.com>, Andreas Graefe <andreas.graefe@iosono-sound.com>
List-Id: alsa-devel@alsa-project.org

--MP_/dq7BEGWJPCdAxeQZ_En9u8r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 7 Jun 2011 18:52:11 +0200
Andre Schramm <andre.schramm@iosono-sound.com> wrote:

> On Tue, 07 Jun 2011 14:48:02 +0200
> Adrian Knoth <adi@drcomp.erfurt.thur.de> wrote:
> 
> > 
> > There's an easier way to acquire this information:
> > 
> >    $ cat /proc/asound/default/pcm0*/sub0/status
> > 
> I wouldn't swear it, but I'm fairly sure no one was using the card.
> I'll check on Friday and get back to you.
> 
Everything was reported as CLOSED. I tested again with 3 cards in
combinations of 2 (2x PCI and PCI and PCIe mixed), the results are
attached. Setting the rate on the PCIe card worked fine, but the PCI
versions reported bogus rates.
I built ALSA again from the sound-2.6 tree Adrian pointed me to with
the latest hdspm.c. One of the PCI cards had 205 as firmware revision,
I added it acc. to [1] as HDSPM_MADI_OLDEST_REV, which made the module
work for the card.


Cheers,
 Andre


[1]
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=blobdiff;f=sound/pci/rme9652/hdspm.c;h=3f08afc0f0d382b5b509c924abc2eb8532f4c822;hp=d03ef94d570e8d61a4b56967dbb047a704cea4f0;hb=efef054e8c4bc4fd48a0b4deb5491116d9f557c7;hpb=fedf1535ab5ee02acbbc235c2272d84bb9334758

--MP_/dq7BEGWJPCdAxeQZ_En9u8r
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=hdspm_pci_and_pci.txt

[root@localhost ~]# cat /proc/asound/cards
 0 [Default        ]: HDSPM - RME MADI_ffffff
                      RME MADI S/N 0xffffff at 0xfebf0000, irq 19
 1 [Default_1      ]: HDSPM - RME MADI_ffffff
                      RME MADI S/N 0xffffff at 0xfebe0000, irq 17


[root@localhost ~]# cat /proc/asound/card0/hdspm
RME MADI (Card #1) Rev.cf Status2first3bits: 1
HW Serial: 0xffffffffffff
IRQ: 19 Registers bus: 0xfebf0000 VM: 0xf84c0000
--- System ---
IRQ Pending: Audio=0, MIDI0=0, MIDI1=0, IRQcount=0
HW pointer: id = 0, rawptr = 0 (0->16320) estimated= 0 (bytes)
MIDI FIFO: Out1=0x0, Out2=0x0, In1=0x0, In2=0x0
MIDIoverMADI FIFO: In=0x0, Out=0x0
Register: ctrl1=0x10044da, ctrl2=0x0, status1=0x2800004, status2=0xffff0701
No TCO module detected.
--- Settings ---
Size (Latency): 2048 samples (2 periods of 8192 bytes)
Line out: on
ClearTrackMarker = off, Transmit in 64 Channel Mode, Auto Input off
AutoSync Reference: Master
Preferred Sync Reference: Word Clock
System Clock Frequency: 48000
--- Status:
Inputs MADI=NoLock, WordClock=NoLock
AutoSync: Reference= Input not valid, Freq=0 (MADI = 10, Word = 0)
Input: Coax, Mode=56 channels


[root@localhost ~]# cat /proc/asound/card1/hdspm
RME MADI (Card #2) Rev.cd Status2first3bits: 1
HW Serial: 0xffffffffffff
IRQ: 17 Registers bus: 0xfebe0000 VM: 0xf84e0000
--- System ---
IRQ Pending: Audio=0, MIDI0=0, MIDI1=0, IRQcount=0
HW pointer: id = 0, rawptr = 0 (0->16320) estimated= 0 (bytes)
MIDI FIFO: Out1=0x0, Out2=0x0, In1=0x0, In2=0x0
MIDIoverMADI FIFO: In=0x0, Out=0x0
Register: ctrl1=0x10044da, ctrl2=0x0, status1=0x1800004, status2=0xffff0701
No TCO module detected.
--- Settings ---
Size (Latency): 2048 samples (2 periods of 8192 bytes)
Line out: on
ClearTrackMarker = off, Transmit in 64 Channel Mode, Auto Input off
AutoSync Reference: Master
Preferred Sync Reference: Word Clock
System Clock Frequency: 48000
--- Status:
Inputs MADI=NoLock, WordClock=NoLock
AutoSync: Reference= Input not valid, Freq=0 (MADI = 6, Word = 0)
Input: Coax, Mode=56 channels


[root@localhost ~]# amixer -c0 cset numid=3 0
numid=3,iface=MIXER,name='System Clock Mode'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Master'
  ; Item #1 'AutoSync'
  : values=0

[root@localhost ~]# amixer -c1 cset numid=3 0
numid=3,iface=MIXER,name='System Clock Mode'
  ; type=ENUMERATED,access=rw------,values=1,items=2
  ; Item #0 'Master'
  ; Item #1 'AutoSync'
  : values=0

[root@localhost ~]# amixer -c0 cset numid=2 2
numid=2,iface=MIXER,name='Internal Clock'
  ; type=ENUMERATED,access=rw------,values=1,items=9
  ; Item #0 '32 kHz'
  ; Item #1 '44.1 kHz'
  ; Item #2 '48 kHz'
  ; Item #3 '64 kHz'
  ; Item #4 '88.2 kHz'
  ; Item #5 '96 kHz'
  ; Item #6 '128 kHz'
  ; Item #7 '176.4 kHz'
  ; Item #8 '192 kHz'
  : values=2

[root@localhost ~]# amixer -c1 cset numid=2 2
numid=2,iface=MIXER,name='Internal Clock'
  ; type=ENUMERATED,access=rw------,values=1,items=9
  ; Item #0 '32 kHz'
  ; Item #1 '44.1 kHz'
  ; Item #2 '48 kHz'
  ; Item #3 '64 kHz'
  ; Item #4 '88.2 kHz'
  ; Item #5 '96 kHz'
  ; Item #6 '128 kHz'
  ; Item #7 '176.4 kHz'
  ; Item #8 '192 kHz'
  : values=2

[root@localhost ~]# amixer -c0 cget numid=6
numid=6,iface=MIXER,name='System Sample Rate'
  ; type=INTEGER,access=r-------,values=1,min=27000,max=207000,step=1
  : values=2624256

[root@localhost ~]# amixer -c1 cget numid=6
numid=6,iface=MIXER,name='System Sample Rate'
  ; type=INTEGER,access=r-------,values=1,min=27000,max=207000,step=1
  : values=4373760


[root@localhost ~]# diff -yw --suppress-common-lines /proc/asound/card0/hdspm /proc/asound/card1/hdspm
RME MADI (Card #1) Rev.cf Status2first3bits: 1                | RME MADI (Card #2) Rev.cd Status2first3bits: 1
IRQ: 19 Registers bus: 0xfebf0000 VM: 0xf84c0000              | IRQ: 17 Registers bus: 0xfebe0000 VM: 0xf84e0000
Register: ctrl1=0x10044da, ctrl2=0x0, status1=0x2800004, stat | Register: ctrl1=0x10044da, ctrl2=0x0, status1=0x1800004, stat
AutoSync: Reference= Input not valid, Freq=0 (MADI = 10, Word | AutoSync: Reference= Input not valid, Freq=0 (MADI = 6, Word


[root@localhost ~]# lspci |grep Mult
04:09.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall DSP MADI (rev cf)
04:0f.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall DSP MADI (rev cd)


[root@localhost ~]# lspci -n |grep 10ee
04:09.0 0401: 10ee:3fc6 (rev cf)
04:0f.0 0401: 10ee:3fc6 (rev cd)


04:09.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall DSP MADI (rev cf)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at febf0000 (32-bit, non-prefetchable) [size=64K]

04:0f.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall DSP MADI (rev cd)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at febe0000 (32-bit, non-prefetchable) [size=64K]

--MP_/dq7BEGWJPCdAxeQZ_En9u8r
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=hdspm_pci_and_pcie.txt

=E2=80=8B[root@localhost ~]# cat /proc/asound/cards
 0 [Default        ]: HDSPM - RME MADI_b1c606
                      RME MADI S/N 0xb1c606 at 0xfe9f0000, irq 16
 1 [Default_1      ]: HDSPM - RME MADI_ffffff
                      RME MADI S/N 0xffffff at 0xfebf0000, irq 17


[root@localhost ~]# cat /proc/asound/card0/hdspm
RME MADI (Card #1) Rev.d2 Status2first3bits: 1
HW Serial: 0x000001b1c606
IRQ: 16 Registers bus: 0xfe9f0000 VM: 0xf84e0000
--- System ---
IRQ Pending: Audio=3D0, MIDI0=3D0, MIDI1=3D0, IRQcount=3D0
HW pointer: id =3D 0, rawptr =3D 0 (0->16320) estimated=3D 0 (bytes)
MIDI FIFO: Out1=3D0x0, Out2=3D0x0, In1=3D0x0, In2=3D0x0
MIDIoverMADI FIFO: In=3D0x0, Out=3D0x0
Register: ctrl1=3D0x10044da, ctrl2=3D0x0, status1=3D0x1400004, status2=3D0x=
c0020701
No TCO module detected.
--- Settings ---
Size (Latency): 2048 samples (2 periods of 8192 bytes)
Line out: on
ClearTrackMarker =3D off, Transmit in 64 Channel Mode, Auto Input off
AutoSync Reference: Master
Preferred Sync Reference: Word Clock
System Clock Frequency: 48000
--- Status:
Inputs MADI=3DNoLock, WordClock=3DNoLock
AutoSync: Reference=3D Input not valid, Freq=3D0 (MADI =3D 5, Word =3D 0)
Input: Coax, Mode=3D56 channels


[root@localhost ~]# cat /proc/asound/card1/hdspm
RME MADI (Card #2) Rev.cd Status2first3bits: 1
HW Serial: 0xffffffffffff
IRQ: 17 Registers bus: 0xfebf0000 VM: 0xf8860000
--- System ---
IRQ Pending: Audio=3D0, MIDI0=3D0, MIDI1=3D0, IRQcount=3D0
HW pointer: id =3D 0, rawptr =3D 0 (0->16320) estimated=3D 0 (bytes)
MIDI FIFO: Out1=3D0x0, Out2=3D0x0, In1=3D0x0, In2=3D0x0
MIDIoverMADI FIFO: In=3D0x0, Out=3D0x0
Register: ctrl1=3D0x10044da, ctrl2=3D0x0, status1=3D0x1800004, status2=3D0x=
ffff0701
No TCO module detected.
--- Settings ---
Size (Latency): 2048 samples (2 periods of 8192 bytes)
Line out: on
ClearTrackMarker =3D off, Transmit in 64 Channel Mode, Auto Input off
AutoSync Reference: Master
Preferred Sync Reference: Word Clock
System Clock Frequency: 48000
--- Status:
Inputs MADI=3DNoLock, WordClock=3DNoLock
AutoSync: Reference=3D Input not valid, Freq=3D0 (MADI =3D 6, Word =3D 0)
Input: Coax, Mode=3D56 channels


[root@localhost ~]# amixer -c0 cset numid=3D3 0
numid=3D3,iface=3DMIXER,name=3D'System Clock Mode'
  ; type=3DENUMERATED,access=3Drw------,values=3D1,items=3D2
  ; Item #0 'Master'
  ; Item #1 'AutoSync'
  : values=3D0

[root@localhost ~]# amixer -c1 cset numid=3D3 0
numid=3D3,iface=3DMIXER,name=3D'System Clock Mode'
  ; type=3DENUMERATED,access=3Drw------,values=3D1,items=3D2
  ; Item #0 'Master'
  ; Item #1 'AutoSync'
  : values=3D0

[root@localhost ~]# amixer -c0 cset numid=3D2 2
numid=3D2,iface=3DMIXER,name=3D'Internal Clock'
  ; type=3DENUMERATED,access=3Drw------,values=3D1,items=3D9
  ; Item #0 '32 kHz'
  ; Item #1 '44.1 kHz'
  ; Item #2 '48 kHz'
  ; Item #3 '64 kHz'
  ; Item #4 '88.2 kHz'
  ; Item #5 '96 kHz'
  ; Item #6 '128 kHz'
  ; Item #7 '176.4 kHz'
  ; Item #8 '192 kHz'
  : values=3D2

[root@localhost ~]# amixer -c1 cset numid=3D2 2
numid=3D2,iface=3DMIXER,name=3D'Internal Clock'
  ; type=3DENUMERATED,access=3Drw------,values=3D1,items=3D9
  ; Item #0 '32 kHz'
  ; Item #1 '44.1 kHz'
  ; Item #2 '48 kHz'
  ; Item #3 '64 kHz'
  ; Item #4 '88.2 kHz'
  ; Item #5 '96 kHz'
  ; Item #6 '128 kHz'
  ; Item #7 '176.4 kHz'
  ; Item #8 '192 kHz'
  : values=3D2

[root@localhost ~]# amixer -c0 cget numid=3D6
numid=3D6,iface=3DMIXER,name=3D'System Sample Rate'
  ; type=3DINTEGER,access=3Dr-------,values=3D1,min=3D27000,max=3D207000,st=
ep=3D1
  : values=3D48000

[root@localhost ~]# amixer -c1 cget numid=3D6
numid=3D6,iface=3DMIXER,name=3D'System Sample Rate'
  ; type=3DINTEGER,access=3Dr-------,values=3D1,min=3D27000,max=3D207000,st=
ep=3D1
  : values=3D4373760


[root@localhost ~]# diff -yw --suppress-common-lines /proc/asound/card0/hds=
pm /proc/asound/card1/hdspm
RME MADI (Card #1) Rev.d2 Status2first3bits: 1                | RME MADI (C=
ard #2) Rev.cd Status2first3bits: 1
HW Serial: 0x000001b1c606                                     | HW Serial: =
0xffffffffffff
IRQ: 16 Registers bus: 0xfe9f0000 VM: 0xf84e0000              | IRQ: 17 Reg=
isters bus: 0xfebf0000 VM: 0xf8860000
Register: ctrl1=3D0x10044da, ctrl2=3D0x0, status1=3D0x1400004, stat | Regis=
ter: ctrl1=3D0x10044da, ctrl2=3D0x0, status1=3D0x1800004, stat
AutoSync: Reference=3D Input not valid, Freq=3D0 (MADI =3D 5, Word  | AutoS=
ync: Reference=3D Input not valid, Freq=3D0 (MADI =3D 6, Word


[root@localhost alsa-driver]# lspci |grep Mult
01:00.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall DSP =
MADI (rev d2)
04:0f.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall DSP =
MADI (rev cd)


[root@localhost alsa-driver]# lspci -n |grep 10ee
01:00.0 0401: 10ee:3fc6 (rev d2)
04:0f.0 0401: 10ee:3fc6 (rev cd)


01:00.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall DSP =
MADI (rev d2)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fe9f0000 (32-bit, non-prefetchable) [size=3D64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2=
+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=3D0/0=
 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [58] Express Endpoint IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTa=
g-
                Device: Latency L0s unlimited, L1 unlimited
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 0
                Link: Latency L0s <4us, L1 <64us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x1
        Capabilities: [100] Device Serial Number 35-0a-00-01-01-00-00-00


04:0f.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall DSP =
MADI (rev cd)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at febf0000 (32-bit, non-prefetchable) [size=3D64K]

--MP_/dq7BEGWJPCdAxeQZ_En9u8r
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--MP_/dq7BEGWJPCdAxeQZ_En9u8r--
