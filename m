From: Toby <dryfter@gmail.com>
Subject: Re: State of the XFi driver on x86_64
Date: Mon, 3 Nov 2008 20:50:02 +1100
Message-ID: <8fe68c970811030150i40284cfega2298d06052ea974@mail.gmail.com>
References: <8fe68c970811021542j172985a5hd0a8d554f6cffb26@mail.gmail.com>
	<s5hej1twaiw.wl%tiwai@suse.de>
	<8fe68c970811030149j3de9ec8btb98e95a9f7ba8c4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by alsa0.perex.cz (Postfix) with ESMTP id A67EC24158
	for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2008 10:50:03 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 24so2532086wfg.23
	for <alsa-devel@alsa-project.org>; Mon, 03 Nov 2008 01:50:02 -0800 (PST)
In-Reply-To: <8fe68c970811030149j3de9ec8btb98e95a9f7ba8c4b@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/11/3 Takashi Iwai <tiwai@suse.de>:
> At Mon, 3 Nov 2008 10:42:55 +1100,
> Toby wrote:
>>
>> 2008/11/2 WILMES Andreas <administrator@webspace.ms>:
>> > Hello everbody,
>> >
>> > Can someone give the current state of the driver? What are his features,
>> > what is working?
>>
>> I've been watching this thread for a while, and occasionally trying
>> out new builds, as I have an original PCI X-Fi emu20k1.
>> Everyone else seems to be reporting decent successes, but I have never
>> managed it myself.
>>
>> Playing back sound files at any sample-rate results in a repeating
>> burst of static. Adjusting the period/buffer parameters to aplay will
>> cause the pitch/tone of the static burst to change, but never turn
>> into anything remotely like the desired sound.
>>
>> I'm running this on a 64-bit system (Ubuntu 8.04 with a custom
>> compiled kernel). Is anyone else having success on this platform?
>
> Maybe the difference of SB X-Fi model?
>
> IIRC, the boards people reported to work are either the original X-Fi,
> SB055x or SB077x model.  Is yours Vista-compatible one?
> It appears in /proc/asound/cards as UAA, and can be identified via PCI
> SSID.

I believe I have the original model, as I bought this card shortly
after the X-Fi was first announced.
According to lspci:
05:02.0 Multimedia audio controller [0401]: Creative Labs SB X-Fi [1102:0005]
       Subsystem: Creative Labs X-Fi Platinum [1102:0021]
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 32 (1000ns min, 1250ns max), Cache Line Size: 32 bytes
       Interrupt: pin A routed to IRQ 18
       Region 0: I/O ports at d000 [size=32]
       Region 1: Memory at fb000000 (64-bit, non-prefetchable) [size=2M]
       Region 3: Memory at fb200000 (64-bit, non-prefetchable) [size=2M]
       Capabilities: [40] Power Management version 2
               Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-
       Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
               Address: 0000000000000000  Data: 0000

Some dmesg output:
[  245.518854] SBXFI: Allocate SRC 0
[  245.537647] SBXFI: allocated TLB at 0 for 16 pages
[  245.537650] SBXFI: Setting TLB buffer page 0x7f9ea000
[  245.538174] SBXFI: PLAYBACK PREPARE: rate=48000, period_size=4096,
buffer_size=16384
[  245.538177] SBXFI: Pitch [0:fa6] = 0x1000000
[  245.538180] SBXFI: Pitch [1:fb6] = 0x1000000
[  245.538183] SBXFI: Amp [00:0001] = 0x7b6
[  245.538188] SBXFI: Amp [01:0011] = 0x7b6
[  245.545546] SBXFI: PLAY TRIGGER START
[  245.545550] SBXFI: SETUP SRC: ch=0x0, start=0x0, loop=0x10000,
cache=0x100, ctrl=0x1044c
[  245.545563] SBXFI: SETUP SRC: ch=0x1, start=0x0, loop=0x10000,
cache=0x100, ctrl=0x4c
[  245.545578] SBXFI: PLAY UPDATE TIMER
[  246.996338] SBXFI: PLAY TRIGGER STOP
[  246.996352] SBXFI: PLAY UPDATE TIMER
[  246.996782] SBXFI: release TLB at 0 for 16 pages
[  246.996785] SBXFI: Disabling TLB buffer
[  246.997359] SBXFI: Release SRC 0


How could I help debug this?

--
Turning and turning in the widening gyre
The falcon cannot hear the falconer
Things fall apart; the center cannot hold
Mere anarchy is loosed upon the world
