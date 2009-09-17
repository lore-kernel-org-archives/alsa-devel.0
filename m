From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] S3C64XX I2S: Added machine driver for
 WM8580
Date: Thu, 17 Sep 2009 14:11:02 +0100
Message-ID: <20090917131102.GA16720@rakim.wolfsonmicro.main>
References: <1253163253-10372-1-git-send-email-jassisinghbrar@gmail.com>
	<20090917110241.GC30736@rakim.wolfsonmicro.main>
	<1b68c6790909170435x2e4cd93an77fdb0bfef7feb18@mail.gmail.com>
	<20090917120353.GF20676@sirena.org.uk>
	<1b68c6790909170526s4bf9e0e0m726dfe771ca71015@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 33D32246A0
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Sep 2009 15:11:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1b68c6790909170526s4bf9e0e0m726dfe771ca71015@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, ben@trinity.fluff.org, Jassi <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 17, 2009 at 09:26:28PM +0900, jassi brar wrote:

> > > +       /* Currently, WM8580 driver doesn't support PLL-out rates
> > > +        * other than those mentioned in Table-52 Page-58 of WM8580A

> That very manual. And i don't say the WM8580 doesn't support, I said
> the WM8580 driver doesn't support: which can be verified looking at the
> CODEC driver.

Your comment says that only the output frequencies in table 52 are
supported.  Could you please provide more specific references to where
this is done in the driver?  I think you're confusing the fact that the
example table lists most of the common audio frequencies with what the
driver supports here.

> Theoretically all output clocks are possible but usually the PLL coefficients
> have limits on their value and thus final output. WM8580 driver too seems
> to enforce that.
> Though, you wud know better of WM8580.

So what you're actually saying is that 256fs doesn't give us the option
of an an in-range Fvco for the FLL at those frequencies (which is the
check I think you're talking about here)?  That's a limitation of the
chip.

Certainly, the comment is not accurate - the contents of table 52 aren't
relevant here, the driver is calculating what it can do dynamically so
the restrictions are a combination of the limits on Fvco and the pre and
post scaling dividers available.
