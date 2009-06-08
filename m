From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/7] Alchemy: DB1200 AC97+I2S audio	support.
Date: Mon, 8 Jun 2009 16:24:20 +0100
Message-ID: <20090608152420.GC6413@rakim.wolfsonmicro.main>
References: <20090608092521.GA7858@sirena.org.uk>
	<f861ec6f0906080243g6be8e613p7ab9c2df66576be8@mail.gmail.com>
	<20090608102018.GA6547@rakim.wolfsonmicro.main>
	<f861ec6f0906080425i388a99a1kb89667c749a815c8@mail.gmail.com>
	<20090608115336.GA25827@rakim.wolfsonmicro.main>
	<f861ec6f0906080521y4443b888gb81a78305dfca5e2@mail.gmail.com>
	<20090608124411.GA3396@rakim.wolfsonmicro.main>
	<f861ec6f0906080611i2c03709cg621aeb87d084dd00@mail.gmail.com>
	<20090608134541.GA4765@rakim.wolfsonmicro.main>
	<f861ec6f0906080748x4b9fd196m27c1ef3a8af9542d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CDD34244AE
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 17:24:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f861ec6f0906080748x4b9fd196m27c1ef3a8af9542d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 08, 2009 at 04:48:23PM +0200, Manuel Lauss wrote:

> What annoys me most is the need to actually have the machine code file
> in the first place.  Or more precisely, the location of it.  It should
> be located
> where the rest of the board code lives.

Like I say, review and API changes are the main factors here at the
minute.  You will also always get some machines that are substantial
enough to warrant "real" drivers too due to having controls plus complex
and configurable clocking and routing (few of these make it mainline
ATM).

> The other thing is the "soc_audio" platform device itself.  Instead of reg-
> istering a platform device for soc audio, how about a function call to
> setup an asoc device.   Multiple calls create multiple alsa devices,
> the argument describes the audio fabric.

This is waiting for the multiple card support - if you take a look at
how the soc-audio device is implemented at the minute you'll see it
calls a function snd_soc_register_card() that's currently not exported.
Once multi-card support is there the interface to it will be changed a
bit and it will be exposed directly to machine drivers and the soc-audio
device will go away, though I'll leave it there for a while in order to
provide a transition period for machine drivers.

At the minute you can probably create multiple soc-audio devices and
it's likely to work in some configurations but not supported.

> > Please submit anyway but at some point someone is going to have to
> > convert the driver - I'm intending to leave as long a transition period
> > as I can but at some point it's going to block other enhancements.

> I attached an untested patch (an addon to the patch which started this thread)
> which does this.  Please have a look and tell me if this is what
> suggested initially?

Pretty much, though I suspect there's some confusion between the probe
functions going on there (there's far too many of them in ASoC at the
minute - I intend to streamline things a bit in the future but first I
want to get the new models implemented).

I'd expect it's possible to have standard platform devices declared in
the CPU definitions for each PSC that the individual boards can just
reference (rather than having to copy out the resources, which
presumably are fixed for each CPU) but I'm not sure if that's idiomatic
for MIPS code or not.  Most of ARM works that way.

I'd be tempted to not bother creating the separate device for the DMA
driver in au1xpsc_pcm_add() but that's just my personal preference.

Also, you've missed a name for your audio_dev.
