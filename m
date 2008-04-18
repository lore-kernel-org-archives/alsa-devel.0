From: "Camilo Polymeris" <cpolymeris@gmx.net>
Subject: Re: Patchmix-style application for EMU cards
Date: Fri, 18 Apr 2008 15:44:46 -0400
Message-ID: <c812bae60804181244h70ad02f5n32e54bb2b016f76a@mail.gmail.com>
References: <c812bae60804150126j5258843em44849b3c5f367f8f@mail.gmail.com>
	<200804171807.21325.c.fertr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by alsa0.perex.cz (Postfix) with ESMTP id C46B7243F9
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 21:44:47 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so421451nfd.32
	for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2008 12:44:47 -0700 (PDT)
In-Reply-To: <200804171807.21325.c.fertr@gmail.com>
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
To: Ctirad Fertr <c.fertr@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello


> The basic idea is that we have two chips. One is custom FPGA, where all
> the
> physical inputs and outpusts are connected. The second chip is the emu10k
> which is conected to FPGA by a bunch of 32bit  buses. There are 32 buses
> from
> emu10k to FPGA called DSP0 to DSP31 used for playback and 21 buses in
> other
> direction called DSP0 to DSP15 (hexa numbering!) used for capture. 1 bus =
> one audio channel except for higher sample rates (e.g. 96kHz and 192kHz),
> where multiple buses are used to transfer one channel. The FPGA can assign
> any physical input (or playback DSP channel) to any capture DSP channel
> and
> same for outputs (see alsamixer). The multichannel capture on hw:0,2
> captures
> the first 16 channels (DSP0 to DSPD). The multichannel playback on hw:0,3
> is
> routed to DSP0 to DSP15.
> I hope it helps.


That is more or less what I had figured out, but it how are playback_1 to
_16 channels routed to DSP0-15? It seems that it depends on the setting of
Front, Surround, LFE, etc. mixer controls. If they are turned up, I don't
understand what happens, sound to playback channels appears on various DSP
buses, at different levels.
If I turn the Front/Surround/LFE/etc. faders down, I can mix playback
channels to DSP using the "Multichannel PCM Send/Routing/Volume" faders, in
a more or less intuitive way, besides that routing values do not map
directly to DSP buses (i.e. 14-15 map to DSP0-1, but 2-3 map to DSP2-3).
There is also a set of mixer controls called "EMU10k Routing", or similar,
which I haven't even looked at.

>
> >  or maybe the driver developer can help me out?
>
> Well, I'm not quite a driver developer, but I think I know E-mu cards well
> to
> answer any questions important for mixer appliacation ;)  So please ask.
> I'd
> like to help you to imporve alsa suport for these excellent cards.
>
> Best Regards,
>
> Ctirad
>
>
Thanks for your help, and sorry everyone for double-posting

Camilo
