From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Subject: Re: Plugging in headphones doesn't mute speakers,
	internal microphone does not work
Date: Tue, 3 Mar 2009 16:38:23 -0200
Message-ID: <d54969c50903031038g7639e8c3uce05dabb222fd563@mail.gmail.com>
References: <d54969c50902280727i58fc689dib97a1fe9658b88ab@mail.gmail.com>
	<d54969c50902280838i4f48aa43w6630bfc87105890c@mail.gmail.com>
	<s5hd4czdfv9.wl%tiwai@suse.de>
	<d54969c50903021546t1912e136jab3fb6354c36520b@mail.gmail.com>
	<s5hy6vmokm0.wl%tiwai@suse.de>
	<d54969c50903030918k4de6c626pf2cf6f2675308fc4@mail.gmail.com>
	<s5hzlg24j0e.wl%tiwai@suse.de>
	<d54969c50903030928k52583265keb18ee28c8c987a8@mail.gmail.com>
	<s5hwsb64i5v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.158])
	by alsa0.perex.cz (Postfix) with ESMTP id D63C710387F
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 19:38:24 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so1938234yxh.2
	for <alsa-devel@alsa-project.org>; Tue, 03 Mar 2009 10:38:23 -0800 (PST)
In-Reply-To: <s5hwsb64i5v.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Is there any way I can get the correct model then? lspci says:

00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio
Controller (rev 03)
    Subsystem: Acer Incorporated [ALI] Device 015e
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t-
<MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 22
    Region 0: Memory at f0700000 (64-bit, non-prefetchable) [size=3D16K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=3D0=
/0
Enable-
        Address: 0000000000000000  Data: 0000
    Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1
<1us
            ExtTag- RBE- FLReset+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
        LnkCap:    Port #0, Speed unknown, Width x0, ASPM unknown, Latency
L0 <64ns, L1 <1us
            ClockPM- Suprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive-
BWMgmt- ABWMgmt-
    Capabilities: [100] Virtual Channel <?>
    Capabilities: [130] Root Complex Link <?>
    Kernel driver in use: HDA Intel
    Kernel modules: snd-hda-intel


And about the microphone, is there any posibility of it working?

2009/3/3 Takashi Iwai <tiwai@suse.de>

> At Tue, 3 Mar 2009 15:28:44 -0200,
> Emilio L=F3pez wrote:
> >
> > Any idea then on what's going on?
>
> BIOS is crap, as always :)
>
> > I can live with having to mute the speakers
> > manually (the headphones seem to be controllable with 'Subwoofer'), but
> having
> > to carry an external mic when I have an integrated one is not very good
> :/
> >
> > I've read on forums and blogs that, for other acer versions, to make the
> mic
> > work they use position_fix=3D0, enable_dma=3D1 or things like that, but=
 I
> tried
> > them and no luck :( can you suggest anything else?
>
> These options are usually irrelevant if you can play back.
>
>
> Takashi
>
