From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-next] ASoC:
 sound/soc/samsung/neo1973_wm8753.c build failure
Date: Thu, 15 Sep 2011 14:31:22 +0100
Message-ID: <20110915133122.GG7988@opensource.wolfsonmicro.com>
References: <1315991893.17271.2.camel@phoenix>
	<20110914191917.GA30518@flint.arm.linux.org.uk>
	<20110914232808.GC2953@opensource.wolfsonmicro.com>
	<20110914233838.GB22946@flint.arm.linux.org.uk>
	<20110915094640.GA7988@opensource.wolfsonmicro.com>
	<20110915110056.GA32615@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C5664103BD3
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 15:31:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110915110056.GA32615@flint.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+alsa@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, Axel Lin <axel.lin@gmail.com>, Liam Girdwood <lrg@ti.com>, Harald Welte <laforge@openezx.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 15, 2011 at 12:00:56PM +0100, Russell King wrote:

> We now have a sane policy: entries which aren't fully up to date are
> automatically dropped.  Entries for which there is no platform support
> file merged within 12 months of the entries last edit are dropped also
> automatically dropped.

Yes, yes - I'm aware of this.

> Face it, GTA01 is dead as far as mainline is concerned.

> If it's not dead then it needs sorting out.  Either way there's two
> valid states:  1. fully merged, or 2. none of it is merged.
> There's no real half-way house state - certainly not one which should
> persist for three years.  (It would be reasonable for maybe a couple
> of kernel releases but more than that is becoming very much a joke.)

I'm not really aware of what's going on with the arch/arm code but from
an ASoC point of view it's one of the platforms people seem to usefully
care about; there's more traffic than for most machines.  Obviously the
problems with s3c24xx aren't going to have been helpful either.
