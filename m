From: "Camilo Polymeris" <cpolymeris@gmx.net>
Subject: Re: Patchmix-style application for EMU cards
Date: Mon, 21 Apr 2008 00:42:39 -0400
Message-ID: <c812bae60804202142y1d59905fib7721089fc701fef@mail.gmail.com>
References: <c812bae60804150126j5258843em44849b3c5f367f8f@mail.gmail.com>
	<200804171807.21325.c.fertr@gmail.com>
	<c812bae60804181244h70ad02f5n32e54bb2b016f76a@mail.gmail.com>
	<200804201916.00941.c.fertr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 7340D2446D
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 06:42:40 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so5159125fka.0
	for <alsa-devel@alsa-project.org>; Sun, 20 Apr 2008 21:42:39 -0700 (PDT)
In-Reply-To: <200804201916.00941.c.fertr@gmail.com>
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
Cc: ALSA Developers Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello

> That is more or less what I had figured out, but it how are playback_1 to
> > _16 channels routed to DSP0-15? It seems that it depends on the setting
> of
> > Front, Surround, LFE, etc. mixer controls. If they are turned up, I
> don't
> > understand what happens, sound to playback channels appears on various
> DSP
> > buses, at different levels.
>
> Really? Well, I didn't much experiment with surround mode. In source code,
> I
> can see that there are up to playback 8 channels at hw:0,0 with can be
> controlled by faders in alsamixer. I tried surround40 and surroun51 on my
> emu1616m and it worked as expected. The channles were mapped to first
> couple
> of DSP ports in a correct order. In fact this should work the same as
> audigy
> does, except the result is passed to DSP ports instead of physical
> outputs.
>

On my card, playback channels 1 & 2 (hw:0,3) appear on all DSP busses
associated with surround.
Say you turn up the "Side" fader in alsamixer, channels 1 & 2 will appear at
the relevant DSPs (6-7, I think)
Whatever, for now I am just keeping all surround controls down (that is,
Front, Surround, Center, Side & LFE).


> Anyway, I think if there is another layer of routing done in audigy DSP,
> it
> shouldn't be used in EMU specific application. Or at least not for now.
> The
> most important thing is to provide all the switches and FPGA routing
> scheme
> for each EMU model. Or, to be precise, three routing schemes for each EMU
> model, because for "double speed" (e.g. 96kHz) and "quadro speed" (e.g.
> 192kHz) modes of operation the numebr of both physical and virtual
> channels
> changes.
>

I think the switches and enums for the card models are rather trivial, one
can handle it with a customized version
of qamix (done with a simple XML file), for example. A separate application
would not be necessary for only that.


> > If I turn the Front/Surround/LFE/etc. faders down, I can mix playback
> > channels to DSP using the "Multichannel PCM Send/Routing/Volume" faders,
> in
> > a more or less intuitive way, besides that routing values do not map
> > directly to DSP buses (i.e. 14-15 map to DSP0-1, but 2-3 map to DSP2-3).
>

Handling of this controls motivated me to write the application in the first
place.
No sound at all will appear if I don't set the appropiate controls for each
playback channel: Multichannel PCM Volume (full), Multichannel PCM Send (an
index of 8 controls, the first 4 select the target DSP) & Multichannel PCM
Send Volume (again faders 0-3 of 8)
By the way, only DSP0-7 work in this way. I have no idea how to make DSP8-31
work.

On which card you did tested it? The driver was primary written for the
> 1820M/1212M V1, so some things may not work well on other models and need
> to
> be fixed.


I have a 1212m, don't know which version, but I think it's V1-- it does have
firewire.
I am using driver version 1.0.16.

Thanks,
Camilo.
