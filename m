From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Aureal issues on resume
Date: Fri, 16 Sep 2011 10:16:11 +0800
Message-ID: <CAN8ccibAsP2rPymiGR41O8W2FyT-6sBvRLh28rsBjjCFpH7qXw@mail.gmail.com>
References: <4E60F0C1.5020008@ladisch.de>
	<CAN8cciaL8O_wyESQSeYOr=bvmg=0vjBj0Cw0y09q2eQygs9ODQ@mail.gmail.com>
	<4E63E06C.9050109@ladisch.de> <s5hk49e8adj.wl%tiwai@suse.de>
	<s5hk49e6ko4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F400103C6F
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 04:16:13 +0200 (CEST)
Received: by fxe22 with SMTP id 22so1247790fxe.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 19:16:11 -0700 (PDT)
In-Reply-To: <s5hk49e6ko4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/9/12 Takashi Iwai <tiwai@suse.de>:
> At Mon, 12 Sep 2011 09:53:28 +0200,
> Takashi Iwai wrote:
>>
>> At Sun, 04 Sep 2011 22:32:44 +0200,
>> Clemens Ladisch wrote:
>> >
>> > Raymond Yau wrote:
>> > > The possible way is to save the contents of 128K memory mapped I/O
>> > > ports before suspend to non-volatile memory and restore them after
>> > > resume
>> > >
>> > > Is there any way for alsa driver to allocate non-volatile memory ?
>> >
>> > 'Normal' memory is saved over suspend. =A0Just use {k|v}malloc.
>>
>> If it's a 128kB bulk memory, vmalloc() is a more sensible choice.
>
> BTW, in many cases, you don't have to save/restore the whole mmio
> region. =A0Instead, stop the stream, save / restore some important
> registers and do the similar procedure for the normal prepare callback
> in the resume, and restart the stream again.
>
>
> Takashi
>

The current au8830 alsa driver seem use less than 192Kbytes out of
256Kbytes mmio

http://thread.gmane.org/gmane.linux.kernel/564963/focus=3D47907

your patch seem initialse the request queue in figure 16 of pat 6167465

and the driver need to restore mixer and equalizer mmio for au8830 in figur=
e 13


04:02.0 Multimedia audio controller: Aureal Semiconductor Vortex 2 (rev fe)
	Subsystem: Aureal Semiconductor AU8830 Vortex 3D Digital Audio Processor
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (1000ns min, 3000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at ff7c0000 (32-bit, non-prefetchable) [size=3D256K]
	Region 1: I/O ports at bc00 [size=3D8]
	Region 2: I/O ports at b880 [size=3D8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Kernel driver in use: au8830
	Kernel modules: snd-au8830
