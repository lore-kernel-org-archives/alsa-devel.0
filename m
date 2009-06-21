From: Brendan Pike <spike@spykes.net>
Subject: Re: Reenable support for Auzentech X-Fi Prelude in
 snd-ctxfi module
Date: Sun, 21 Jun 2009 04:33:30 -0400
Message-ID: <20090621043330.487c4fee@darius>
References: <aa85b9420906210112h1201127dj274a91344e0189cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.spykes.net (dsl.spykes.net [76.10.173.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 4374C1037F8
	for <alsa-devel@alsa-project.org>;
	Sun, 21 Jun 2009 10:33:32 +0200 (CEST)
In-Reply-To: <aa85b9420906210112h1201127dj274a91344e0189cb@mail.gmail.com>
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

This card works in the latest but of course the pci id needs changed. I
also have the same issue with the Auzentech X-Fi Forte, but changing
the pci id makes this card work fine. Just make sure to change the
appropriate id for 20k1 cards (pci models (Prelude)) vs 20k2 (pcie
models (Forte))

Info on card:


03:00.0 0403: 1102:000b (rev 03)
03:00.0 Audio device: Creative Labs X-Fi Titanium series [EMU20k2] (rev
03) Subsystem: Device 5431:0049
        Flags: bus master, fast devsel, latency 0, IRQ 30
        Memory at fbaf0000 (64-bit, non-prefetchable) [size=64K]
        Memory at fb800000 (64-bit, non-prefetchable) [size=2M]
        Memory at f4000000 (64-bit, non-prefetchable) [size=64M]
        Capabilities: [40] Power Management version 3
        Capabilities: [48] MSI: Mask- 64bit+ Count=1/1 Enable-
        Capabilities: [58] Express Endpoint, MSI 00
        Capabilities: [100] Device Serial Number ff-ff-ff-ff-ff-ff-ff-ff
        Capabilities: [300] Advanced Error Reporting
        Kernel driver in use: SB-XFi
        Kernel modules: ctxfi

Support for these pci id's need added to the driver.


On Sun, 21 Jun 2009 01:12:08 -0700
Kamil Kaminski <kamilkss@gmail.com> wrote:

> Hi guys,
> I noticed that latest alsa-driver-unstable does not detect my card as if PCI
> IDs were discarded or purposely disabled to only work on Creative cards, the
> earlier snapshots used to work fine. This is what I get:
> 
> ctatc: Card not recognised
> ctxfi: Something wrong!!!
> SB-XFi: probe of 0000:06:01.0 failed with error -2
> 
> This is the card:
> 
> 06:01.0 Multimedia audio controller: Creative Labs SB X-Fi
>     Subsystem: Auzentech, Inc. Device 0034
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>     Latency: 64 (1000ns min, 1250ns max)
>     Interrupt: pin A routed to IRQ 22
>     Region 0: I/O ports at 8f00 [size=32]
>     Region 1: Memory at dfc00000 (64-bit, non-prefetchable) [size=2M]
>     Region 3: Memory at d8000000 (64-bit, non-prefetchable) [size=64M]
>     Capabilities: [40] Power Management version 2
>         Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>         Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>     Capabilities: [50] MSI: Mask- 64bit+ Count=1/1 Enable-
>         Address: 0000000000000000  Data: 0000
>     Kernel driver in use: CTALSA
>     Kernel modules: ctxfi
> 
> I'm currently using v1.0 ctxfi alsa driver from Creative, It would be nice
> to have Auzentech X-Fi Prelude working in 2.6.31 kernel ;)
> 
> Thanks.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
