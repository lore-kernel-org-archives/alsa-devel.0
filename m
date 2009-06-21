From: Kamil Kaminski <kamilkss@gmail.com>
Subject: Reenable support for Auzentech X-Fi Prelude in
	snd-ctxfi module
Date: Sun, 21 Jun 2009 01:12:08 -0700
Message-ID: <aa85b9420906210112h1201127dj274a91344e0189cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 838031037FB
	for <alsa-devel@alsa-project.org>;
	Sun, 21 Jun 2009 10:12:09 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so1130598ywq.2
	for <alsa-devel@alsa-project.org>; Sun, 21 Jun 2009 01:12:08 -0700 (PDT)
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

Hi guys,
I noticed that latest alsa-driver-unstable does not detect my card as if PCI
IDs were discarded or purposely disabled to only work on Creative cards, the
earlier snapshots used to work fine. This is what I get:

ctatc: Card not recognised
ctxfi: Something wrong!!!
SB-XFi: probe of 0000:06:01.0 failed with error -2

This is the card:

06:01.0 Multimedia audio controller: Creative Labs SB X-Fi
    Subsystem: Auzentech, Inc. Device 0034
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 64 (1000ns min, 1250ns max)
    Interrupt: pin A routed to IRQ 22
    Region 0: I/O ports at 8f00 [size=32]
    Region 1: Memory at dfc00000 (64-bit, non-prefetchable) [size=2M]
    Region 3: Memory at d8000000 (64-bit, non-prefetchable) [size=64M]
    Capabilities: [40] Power Management version 2
        Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Mask- 64bit+ Count=1/1 Enable-
        Address: 0000000000000000  Data: 0000
    Kernel driver in use: CTALSA
    Kernel modules: ctxfi

I'm currently using v1.0 ctxfi alsa driver from Creative, It would be nice
to have Auzentech X-Fi Prelude working in 2.6.31 kernel ;)

Thanks.
