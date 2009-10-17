From: Philippe <blastrock0@free.fr>
Subject: Re: Issue with creative Xfi PCIe ca0110-IBG
Date: Sat, 17 Oct 2009 12:30:12 +0200
Message-ID: <4AD99CB4.1020608@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by alsa0.perex.cz (Postfix) with ESMTP id 99A6E1037F1
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Oct 2009 12:30:07 +0200 (CEST)
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 4BF764C8139
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Oct 2009 12:30:04 +0200 (CEST)
Received: from [192.168.0.2] (vsg94-1-82-234-117-82.fbx.proxad.net
	[82.234.117.82])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 53C0D4C80F2
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Oct 2009 12:30:02 +0200 (CEST)
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

Takashi Iwai <tiwai <at> suse.de> writes:

>
> At Wed, 14 Oct 2009 18:03:15 +0200,
> Guillem Sol=E0 wrote:
> >
> > Takashi Iwai wrote:
> > > At Tue, 13 Oct 2009 18:59:23 +0200,
> > > Guillem Sol=E0 wrote:
> > >   =

> > >> Takashi Iwai wrote:
> > >>     =

> > >>> At Tue, 13 Oct 2009 17:01:35 +0200,
> > >>> Guillem Sol=E0 wrote:
> > >>>   =

> > >>>       =

> > >>>> Takashi Iwai wrote:
> > >>>>     =

> > >>>>         =

> > >>>>> At Tue, 13 Oct 2009 16:12:47 +0200,
> > >>>>> Guillem Sol=E0 wrote:
> > >>>>>   =

> > >>>>>       =

> > >>>>>           =

> > >>>>>> Takashi Iwai wrote:
> > >>>>>>     =

> > >>>>>>         =

> > >>>>>>             =

> > >>>>>>> At Tue, 13 Oct 2009 14:10:44 +0200,
> > >>>>>>> Guillem Sol=E0 wrote:
> > >>>>>>>   =

> > >>>>>>>      =

> > >>>>>>>> Takashi Iwai wrote:
> > >>>>>>>>     =

> > >>>>>>>>                =

> > >>>>>>>>                 =

> > >>>>>>>>> It shows the address 1.  So, my patch doesn't work, as it
assumes
> > >>>>>>>>> address 0.  Replace it with 1, and pass probe_mask=3D0x02.
> > >>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>> Takashi
> > >>>>>>>>>
> > >>>>>>>>>           =

> > >>>>>>>>>                   =

> > >>>>>>>> Yeah great, it's working again!
> > >>>>>>>>
> > >>>>>>>> I did modprobe snd-hda-intel probe_mask=3D0x03 instead of
mask=3D0x02 to
> > >>>>>>>> make it work
> > >>>>>>>>
> > >>>>>>>> and the patch let this way ( I changed both return 1 and
addr=3D1)
> > >>>>>>>>     =

> > >>>>>>>>         =

> > >>>>>>>>             =

> > >>>>>>>>                 =

> > >>>>>>> Now the question is whether probe_mask=3D0x03 (or 0x02) works
without
> > >>>>>>> this patch.  How is it?
> > >>>>>>>
> > >>>>>>>
> > >>>>>>> thanks,
> > >>>>>>>
> > >>>>>>>   =

> > >>>>>>>       =

> > >>>>>>>           =

> > >>>>>>>               =

> > >>>>>> Hi,
> > >>>>>>
> > >>>>>> after few tests I can conclude that it could work with and
without the
> > >>>>>> patch. The same happens with modprobe snd-hda-intel
probe_mask=3D0x03 or
> > >>>>>> 0x02 both can work.
> > >>>>>>     =

> > >>>>>>         =

> > >>>>>>             =

> > >>>>> OK, good to hear.
> > >>>>>
> > >>>>>   =

> > >>>>>       =

> > >>>>>           =

> > >>>>>> So it seems to be fickle because not all the times you
modprobe the
> > >>>>>> intel module it worked.
> > >>>>>>     =

> > >>>>>>             =

> > >>>>> Do you mean it's still unstable even with probe_mask option,
or it is
> > >>>>> when without?
> > >>>>>
> > >>>>> If probe_mask fixes its fickleness (or flirtation :), the
patch below
> > >>>>> should help.  It will set the default probe_mask for your device.
> > >>>>> Give it a try.
> > >>>>>
> > >>>>>
> > >>>>> Takashi
> > >>>>>           =

> > >>>> Hi,
> > >>>>
> > >>>> By fickle I mean that when modprobing hda-intel module
sometimes it
> > >>>> works fine and others cannot get audio although the system
seems to
> > >>>> always recognize the card, and yes, I'm always using
probe_mask=3D0x02 option.
> > >>>>
> > >>>> Actually, about one of five times I can successfully load the
module. As
> > >>>> I said the first patch doesn't affect, it has been only the
casualty
> > >>>> that made me believe it did something.
> > >>>>    =

> > >>>>         =

> > >>> Hm, then it's still puzzling what causes the problem in the recent
> > >>> kernel.  Or is it coincidence?
> > >>>
> > >>>       =

> > >> Uff, really don't know what to say, when I thought I saw some
light...
> > >> I've been testing with 2.6.31-rc6 and 2.6.31 (final) with and
without
> > >> patches and maybe is only the probe_mask option what make it work
sometimes.
> > >>
> > >> Perhaps I did bisect bad and wasn't
> > >> deadff1665491afce124a8ff83f00f784161f660 first bad commit?
> > >>     =

> > >
> > > Possible.  But, before bisecting, we should be really sure which
> > > release was really OK.  Did 2.6.30 work without any problems?
> > >
> > >   =

> >
> > Hi,
> >
> > AFAIK in 2.6.30 ca0110 was not implemented. I see it start working in
> > 2.6.31-rc3 and did a two weeks running test with 2.6.31-rc5.
> >
> > So I bisected from 2.6.31-rc6 to 2.6.31-rc5
>
> OK.  It's possible that a regression occurs at rc6 because of the
> core HD-audio changes.  But, I still wonder why the patch doesn't
> change anything.
>
> At least, it'd be nice if you can reconfirm that rc5 is really working
> stably.  You can just copy sound/pci/hda/* over any newer kernels.
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel <at> alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


Hi,

I have the same model of sound card and can't make it work. I saw that
this conversation has stalled so I'm going to give informations about
what I've tested.

First thing, using one of the latest alsa-driver snapshots with a
2.6.31-gentoo-r2 kernel, I got this in dmesg when loading the
snd-hda-intel driver :
[  111.287946] ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
[  111.287968] HDA Intel 0000:03:00.0: PCI INT A -> Link[APC2] -> GSI 17
(level, low) -> IRQ 17
[  111.567237] hda-intel: spurious response 0x0:0x0, last cmd=3D0x000000
[  112.575093] hda-intel: azx_get_response timeout, switching to polling
mode: last cmd=3D0x107f0d00
[  113.583158] hda_intel: azx_get_response timeout, switching to
single_cmd mode: last cmd=3D0x107f0d00

And then, when I tried to play a sound a few times :
[  167.997029] hda_codec: rates =3D=3D 0 (nid=3D0x12, val=3D0x0, ovrd=3D0)
[  173.053323] __ratelimit: 1 callbacks suppressed
[  174.124799] hda_codec: rates =3D=3D 0 (nid=3D0x12, val=3D0x0, ovrd=3D0)
[  287.496606] hda_codec: rates =3D=3D 0 (nid=3D0x12, val=3D0x0, ovrd=3D0)
[  287.496934] __ratelimit: 20 callbacks suppressed

I made my tests with aplay and mplayer, they just stall and I don't get
any sound.

Today, after reading this thread I tried making it work with the 2.6.31
kernel from rc3 to rc6 (without gentoo patches), none of them worked. I
compiled them with debug and this is the output of dmesg when I load the
driver :
[ 1778.639675] HDA Intel 0000:03:00.0: PCI INT A -> Link[APC2] -> GSI 17
(level, low) -> IRQ 17
[ 1778.639778] ALSA sound/pci/hda/hda_intel.c:2334: chipset global
capabilities =3D 0x3300
[ 1778.663717] ALSA sound/pci/hda/hda_intel.c:823: codec_mask =3D 0x2
[ 1778.663830] ALSA sound/pci/hda/hda_intel.c:1252: codec #1 probed OK
[ 1778.695745] ALSA sound/pci/hda/hda_codec.c:3857: autoconfig:
line_outs=3D4 (0xb/0xd/0xc/0xe/0x0)
[ 1778.695753] ALSA sound/pci/hda/hda_codec.c:3861:    speaker_outs=3D0
(0x0/0x0/0x0/0x0/0x0)
[ 1778.695760] ALSA sound/pci/hda/hda_codec.c:3865:    hp_outs=3D1
(0xf/0x0/0x0/0x0/0x0)
[ 1778.695767] ALSA sound/pci/hda/hda_codec.c:3866:    mono: mono_out=3D0x0
[ 1778.695772] ALSA sound/pci/hda/hda_codec.c:3869:    dig-out=3D0x12/0x0
[ 1778.695777] ALSA sound/pci/hda/hda_codec.c:3877:    inputs: mic=3D0x11,
fmic=3D0x0, line=3D0x10, fline=3D0x0, cd=3D0x0, aux=3D0x0
[ 1778.695785] ALSA sound/pci/hda/hda_codec.c:3879:    dig-in=3D0x13

And when I try to play a sound :
[ 1845.100435] ALSA sound/pci/hda/hda_intel.c:1557: azx_pcm_prepare:
bufsize=3D0x8000, format=3D0x13
[ 1845.100457] ALSA sound/pci/hda/hda_codec.c:1076:
hda_codec_cleanup_stream: NID=3D0x12
[ 1845.100466] ALSA sound/pci/hda/hda_codec.c:1063:
hda_codec_setup_stream: NID=3D0x2, stream=3D0x4, channel=3D0, format=3D0x13
[ 1845.108003] ALSA sound/pci/hda/hda_codec.c:1063:
hda_codec_setup_stream: NID=3D0x6, stream=3D0x4, channel=3D0, format=3D0x13
[ 1845.116000] ALSA sound/pci/hda/hda_codec.c:1063:
hda_codec_setup_stream: NID=3D0x4, stream=3D0x4, channel=3D2, format=3D0x13
[ 1845.124001] ALSA sound/pci/hda/hda_codec.c:1063:
hda_codec_setup_stream: NID=3D0x3, stream=3D0x4, channel=3D0, format=3D0x13
[ 1845.132001] ALSA sound/pci/hda/hda_codec.c:1063:
hda_codec_setup_stream: NID=3D0x5, stream=3D0x4, channel=3D0, format=3D0x13
[ 1851.730678] ALSA sound/pci/hda/hda_codec.c:1076:
hda_codec_cleanup_stream: NID=3D0x2
[ 1851.730691] ALSA sound/pci/hda/hda_codec.c:1076:
hda_codec_cleanup_stream: NID=3D0x4
[ 1851.730705] ALSA sound/pci/hda/hda_codec.c:1076:
hda_codec_cleanup_stream: NID=3D0x3
[ 1851.730717] ALSA sound/pci/hda/hda_codec.c:1076:
hda_codec_cleanup_stream: NID=3D0x5
[ 1851.730724] ALSA sound/pci/hda/hda_codec.c:1076:
hda_codec_cleanup_stream: NID=3D0x6

I tried using your patch Takashi, the driver wouldn't load until I put 1
in the address like Guillem did. But even with that sound doesn't work
no matter the probe_mask setting I use.

And a last note, I did my tests on the rc versions without rebooting,
just removing the module and modprobing it again, but I don't think it
matters.

Here's my lspci  -vvnn :
02:00.0 PCI bridge [0604]: Creative Labs Device [1102:7006] (prog-if 00
[Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 32 bytes
    Bus: primary=3D02, secondary=3D03, subordinate=3D03, sec-latency=3D32
    Memory behind bridge: fdf00000-fdffffff
    Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Bridge: PM- B3+
    Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
Count=3D1/16 Enable-
        Address: 0000000000000000  Data: 0000
    Capabilities: [80] Subsystem: Creative Labs Device [1102:0010]
    Capabilities: [90] Express (v1) PCI/PCI-X Bridge, MSI 00
        DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s <4us,
L1 <64us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+ BrConfRtry-
            MaxPayload 512 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr-
TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <1us, L1 <16us
            ClockPM- Suprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [100] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq+ ACSVoil-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSVoil-
        UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSVoil-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        AERCap:    First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-

03:00.0 Audio device [0403]: Creative Labs [SB X-Fi Xtreme Audio]
CA0110-IBG [1102:0009]
    Subsystem: Creative Labs Device [1102:0018]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 32 (500ns min, 5000ns max)
    Interrupt: pin A routed to IRQ 17
    Region 0: Memory at fdffc000 (32-bit, non-prefetchable) [size=3D16K]
    Capabilities: [dc] Power Management version 3
        Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
    Kernel driver in use: HDA Intel
    Kernel modules: snd-hda-intel

Output from alsa-info :
http://www.alsa-project.org/db/?f=3D473df043d8633b85a0a5319d2e7a73c4a13d2761

Hope this gives you some hint to solve our problem.

Regards,

Philippe
