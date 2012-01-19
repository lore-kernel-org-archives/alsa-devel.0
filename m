From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: add driver for max9768 amplifier
Date: Thu, 19 Jan 2012 10:55:37 +0000
Message-ID: <20120119105537.GA29494@sirena.org.uk>
References: <1326901108-3435-1-git-send-email-w.sang@pengutronix.de>
	<20120118175305.GR8732@opensource.wolfsonmicro.com>
	<20120118193320.GB13708@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D9B924650
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 11:55:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120118193320.GB13708@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 18, 2012 at 08:33:20PM +0100, Wolfram Sang wrote:

> > Some documentation on what this does would be nice.  Is this something
> > that might usefully be changed at runtime?

> It only depends on the hardware design. Will a pointer to the section of the
> datasheet be enough for documentation?

Yes.

> > of DAPM support, even if it's just mapping out the pins.  Since you're
> > manually controlling the mute it'd be nice to make the unmute be (mute
> > && power) to save on pops and clicks from the CODEC being amplified.

> Sorry, not understood. Is there an example of what you mean here somewhere in
> the tree?

The WM2000 is doing something sort of similar, though it's quite a bit
more involved than just asserting a GPIO.

> > > +		err = gpio_request_one(pdata->mute_gpio, GPIOF_INIT_HIGH, "MAX9768 Mute");
> > > +		max9768->mute_gpio = err ?: pdata->mute_gpio;

> > I really don't like the ternery operator at the best of times...

> Can we agree to disagree? It is so convenient here and saves a few lines.

I'd rather not.
