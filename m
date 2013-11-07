From: Joe Perches <joe@perches.com>
Subject: Re: [RFC PATCH] hda_intel: ratelimit "spurious response" message
Date: Thu, 07 Nov 2013 12:28:18 -0800
Message-ID: <1383856098.9263.28.camel@joe-AO722>
References: <1383854115.9263.21.camel@joe-AO722>
	 <s5h61s4dkqs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h61s4dkqs.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2013-11-07 at 21:23 +0100, Takashi Iwai wrote:
> At Thu, 07 Nov 2013 11:55:15 -0800,
> Joe Perches wrote:
> > 
> > dmesg here has a 100+ consecutive lines of:
> > 
> > [ 1464.219446] hda-intel 0000:00:14.2: spurious response 0x0:0x0, last cmd=0x170500
> > [ 1464.219451] hda-intel 0000:00:14.2: spurious response 0x0:0x0, last cmd=0x170500
> > [ 1464.219454] hda-intel 0000:00:14.2: spurious response 0x0:0x0, last cmd=0x170500
> > ...
> > 
> > Ratelimit the message to reduce the dmesg log noise.
> > 
> > Coalesce the format while at it.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Thanks, applied.
> 
> BTW, which hardware shows this problem?
> I'm interested rather in that...

It's a little Acer netbook AO725

# lspci -v -v -s0:14.2
00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD] FCH Azalia Controller (rev 01)
	Subsystem: Acer Incorporated [ALI] Device 0740
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 46
	Region 0: Memory at f0240000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0300c  Data: 41b3
	Kernel driver in use: snd_hda_intel
