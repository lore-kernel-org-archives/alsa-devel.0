From: Susan Cragin <susancragin@earthlink.net>
Subject: Re: Should my Creative X-fi card be loading the
 snd-hda-intel module
Date: Wed, 24 Jun 2009 14:51:22 -0400 (GMT-04:00)
Message-ID: <32424532.1245869482713.JavaMail.root@elwamui-huard.atl.sa.earthlink.net>
Reply-To: Susan Cragin <susancragin@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-spurfowl.atl.sa.earthlink.net
	(elasmtp-spurfowl.atl.sa.earthlink.net [209.86.89.66])
	by alsa0.perex.cz (Postfix) with ESMTP id 024842484F
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 20:51:24 +0200 (CEST)
Received: from [209.86.224.35] (helo=elwamui-huard.atl.sa.earthlink.net)
	by elasmtp-spurfowl.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <susancragin@earthlink.net>) id 1MJXZ4-0001aw-Nv
	for alsa-devel@alsa-project.org; Wed, 24 Jun 2009 14:51:22 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Bill,
My creative x-fi card used to work great with the daily build, and the module I mentioned. 
I've been away for it for a couple of months because I need sound for wine programs and there were issues with wine sound, and I just got back. 
I was surprised to see such a big step backward. 
When I was last using a daily build, both unstable and stable worked for me. 
Susan

Susan,
I also had a CA110-IBG chip on my Creative X-Fi.
Never could get it to work, not under Ubuntu or Fedora, not with the Creative-supplied driver and also not with ctxfi.
So we dropped that card and went to using an Asus PCI-e sound card instead.
 
As for what module should load, here is what Takashi said on June 11:
 
Are you sure that your board has really emu20k1 or emu20k2 chip?
X-Fi isn't always with these chips. Some are HD-audio only (thus
snd-hda-intel is the right driver) and some are with CA0106 chip.

 

    -------- Original Message --------
    Shouldn't it be loading snd-hda-codec-ca0110 instead?
    I am using the 6/24 stable snapshot.

    lspci -vv gives me this.

    05:00.0 Audio device: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
    Subsystem: Creative Labs Device 0018
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 64 (500ns min, 5000ns max)
    Interrupt: pin A routed to IRQ 18
    Region 0: Memory at fdffc000 (32-bit, non-prefetchable) [size=16K]
    Capabilities: <access denied>
    Kernel driver in use: HDA Intel
    Kernel modules: snd-hda-intel
