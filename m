From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: Realtek ALC883 support on Albatron KI690-AM2
	motherboard
Date: Fri, 14 Dec 2007 17:32:54 -0500
Message-ID: <76366b180712141432t516582bl5411dfc6dc2ab860@mail.gmail.com>
References: <76366b180712021308n4d5fd0fk5906c8928795b0c3@mail.gmail.com>
	<s5hr6i3dcch.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 333FD24621
	for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2007 23:32:56 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so910693rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2007 14:32:54 -0800 (PST)
In-Reply-To: <s5hr6i3dcch.wl%tiwai@suse.de>
Content-Disposition: inline
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

Takashi,

Running with the hg alsa head with full debug, I see the following
output.. The 01:05.2 device is an ATI HDMI port. I appear to have a
card0 after this which is the ALC883 chip. Do you know why the HDMI
port is not correctly detected as an "ATI RS600 HDMI" according to the
patch_atihdmi.c file? Do I need to pass any parameters to the module?

Thanks,
-Andrew

ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 18
hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
ALSA /usr/src/alsa-driver/pci/hda/hda_codec.c:2792: autoconfig:
line_outs=3 (0x14/0x15/0x16/0x0/0x0)
ALSA /usr/src/alsa-driver/pci/hda/hda_codec.c:2796:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
ALSA /usr/src/alsa-driver/pci/hda/hda_codec.c:2800:    hp_outs=1
(0x1b/0x0/0x0/0x0/0x0)
ALSA /usr/src/alsa-driver/pci/hda/hda_codec.c:2808:    inputs:
mic=0x18, fmic=0x19, line=0x1a, fline=0x0, cd=0x0, aux=0x0
ALSA /usr/src/alsa-driver/acore/init.c:174: cannot find the slot for
index 0 (range 0-0), error: -16
ALSA /usr/src/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1885:
hda-intel: Error creating card!
HDA Intel: probe of 0000:01:05.2 failed with error -12

# lspci -vvs 00:14.2
00:14.2 Audio device: ATI Technologies Inc SB600 Azalia
        Subsystem: Albatron Corp. Unknown device 5000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 4 bytes
        Interrupt: pin ? routed to IRQ 18
        Region 0: Memory at fe024000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

# lspci -vvs 01:05.2
01:05.2 Audio device: ATI Technologies Inc Unknown device 7919
        Subsystem: Albatron Corp. Unknown device 5000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 4 bytes
        Interrupt: pin B routed to IRQ 5
        Region 0: Memory at fdefc000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

On Dec 3, 2007 10:31 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Sun, 2 Dec 2007 16:08:32 -0500,
> Andrew Paprocki wrote:
> >
> > Hello everyone,
> >
> > I'm currently trying to get the ALC883 on the Albatron KI690-AM2
> > motherboard working under ALSA and I'm running into problems with some
> > of the ports. From looking at the patch_realtek.c file inside the
> > intel_hda driver, it appears there are many variants of hookups to
> > this chipset which all require some manual configuration in the
> > driver. I've tried what appears to be the closest match
> > (ALC883_6ST_DIG or 6stack-dig), but it still does not enable all of
> > the ports.
> >
> > The motherboard webpage is here:
> > http://www.albatron.com.tw/English/product/mb/pro_detail.asp?rlink=Specification&no=239
> >
> > The board has two audio stacks on the back panel. Facing the jack
> > inputs, the left-hand stack contains:
> >     <S/PDIF output>
> >     <TOSLINK w/ green cover>
> >
> > Next to that stack is a larger 6-stack with the following configuration:
> >     <blue> <black>
> >     <green> <pink>
> >     <grey> <TOSLINK w/ pink cover>
> >
> > The box is running a stock debian 2.6.18-4-486 kernel.
>
> First of all, try the very latest ALSA version (from HG repo) if you
> want to debug HD-audio stuff.  It's the most actively changed part in
> ALSA drivers.  2.6.18 is way too old as a reference.  Also you should
> build the driver with debug option (in the case of alsa-driver tree,
> pass --with-debug=full to configure).
>
> If the latest version still doesn't work (with all available models),
> then check /proc/asound/card0/codec#* files.
>
> (Anyway, I'll be on vacation from tomorrow, so cannot work on your
>  problem.  Hopefully this will interest other guys...)
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
