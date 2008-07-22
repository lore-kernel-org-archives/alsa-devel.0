From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 0/3] ALSA SoC: MPC5200 audio driver
Date: Tue, 22 Jul 2008 19:39:28 +0100
Message-ID: <20080722183928.GB6432@sirena.org.uk>
References: <fa686aa40807212358p17c824ia1d6516a87a7aac1@mail.gmail.com>
	<20080722092646.GA7251@sirena.org.uk>
	<9e4733910807220638u5cf48424l92ba780ecd9e3d9d@mail.gmail.com>
	<20080722141027.GB12555@sirena.org.uk>
	<9e4733910807220752o4d220f90o770d55e70f493642@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DC3761038AC
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 20:39:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807220752o4d220f90o770d55e70f493642@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 22, 2008 at 10:52:20AM -0400, Jon Smirl wrote:

> I'm just going to ignore 2.6.27 and wait for 2.6.28.  This driver only

If you want to get changes in for 2.6.28 it's probably best to be
working on them now - it's not clear if this driver will be merged for
2.6.27 at all and the sooner the stuff gets in the safer it is for
2.6.28 and the closer the code base will be to 2.6.26.  It's up to you
obviously but I think it may work best.

> partially implement i2s support and assumes external clocking. There's
> no way to add a ASOC machine driver. It's not a general purpose
> driver. Adding the rest of the features probably means device tree
> changes.

of-soc is a machine driver - other machine drivers should be able to
bind to the driver as normal (though I'd expect that users would want to
add more configurablilty to the driver prior to using it).  Or at least
that was the usage I was expecting, anyway.

Implementing only partial support for devices is pretty much normal when
the driver isn't contributed by the vendor - people tend to only work on
the features they're using.
