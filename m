From: Bjoern Olausson <lkmlist@gmail.com>
Subject: Re: SB X-Fi driver fixes (Re: Testers wanted: New SB
	X-Fi driver)
Date: Sun, 28 Jun 2009 15:07:54 +0200
Message-ID: <5501535d0906280607t5d8017bbp6210dd54ec55eed2@mail.gmail.com>
References: <1244140942.4550.2.camel@polo-desktop>
	<s5h63f6f8qo.wl%tiwai@suse.de> <4A2DF1EC.9060104@googlemail.com>
	<s5hab4ix8wo.wl%tiwai@suse.de> <4A2DF6BD.6060004@googlemail.com>
	<s5h63f5ylee.wl%tiwai@suse.de> <s5hk53l3f6p.wl%tiwai@suse.de>
	<4A2E97A6.3090301@googlemail.com> <s5hy6rtejri.wl%tiwai@suse.de>
	<4A367404.80900@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f210.google.com (mail-bw0-f210.google.com
	[209.85.218.210])
	by alsa0.perex.cz (Postfix) with ESMTP id 5665724450
	for <alsa-devel@alsa-project.org>;
	Sun, 28 Jun 2009 15:07:56 +0200 (CEST)
Received: by bwz6 with SMTP id 6so205068bwz.32
	for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2009 06:07:55 -0700 (PDT)
In-Reply-To: <4A367404.80900@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 15, 2009 at 18:17, Gernot
Kohlhaas<gernot.kohlhaas@googlemail.com> wrote:
>
> No crashes. Everything's running fine now :)
> Thank you very much!
>

Just want to confirm that my card (listed below) works so far (with
2.6.31-rc1-git3)

On the first module load I got a mesage (I can't remember exactly)
something like that:
"XFI" "??" "  " ""
Unknown hardware... and something with initialization method, but I
could'nt reproduce this message.

But the first tests with aplay (using all sorts of samplerates) were promising!

01:00.0 Multimedia audio controller: Creative Labs SB X-Fi
        Subsystem: Creative Labs X-Fi Platinum
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64 (1000ns min, 1250ns max), Cache Line Size: 16
bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 8c00 [size=32]
        Region 1: Memory at eb800000 (64-bit, non-prefetchable)
[size=2M]
        Region 3: Memory at e4000000 (64-bit, non-prefetchable)
[size=64M]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
Count=1/1 Enable-
                Address: 0000000000000000  Data: 0000

01:00.0 0401: 1102:0005
        Subsystem: 1102:0021
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64 (1000ns min, 1250ns max), Cache Line Size: 16
bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 8c00 [size=32]
        Region 1: Memory at eb800000 (64-bit, non-prefetchable)
[size=2M]
        Region 3: Memory at e4000000 (64-bit, non-prefetchable)
[size=64M]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
Count=1/1 Enable-
                Address: 0000000000000000  Data: 0000

Thanks a lot

kind regrads
Bjoern
