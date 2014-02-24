From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: cs42888: Add codec driver support
Date: Mon, 24 Feb 2014 23:47:09 +0800
Message-ID: <20140224154708.GA6132@MrMyself>
References: <1393224929-7555-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140224113011.GE25940@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C689261A22
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 16:57:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140224113011.GE25940@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, brian.austin@cirrus.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-doc@vger.kernel.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, rob@landley.net, galak@codeaurora.org, grant.likely@linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 24, 2014 at 08:30:11PM +0900, Mark Brown wrote:
> On Mon, Feb 24, 2014 at 02:55:29PM +0800, Nicolin Chen wrote:
> > This patch adds support for the Cirrus Logic CS42888 Audio CODEC that
> > has four 24-bit A/D and eight 24-bit D/A converters.
> 
> Looks generally good, some fairly small nits below.

I'll revise all of them.

Thank you.
Nicolin

----

> 
> > [ CS42888 supports both I2C and SPI control ports. As initial patch,
> >   this patch only adds the support for I2C. ]
> 
> >  5 files changed, 795 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/cs42888.txt
> >  create mode 100644 sound/soc/codecs/cs42888.c
> >  create mode 100644 sound/soc/codecs/cs42888.h
> 
> Given that we're starting to split out separate bus drivers for the I2C
> and SPI CODECs (look at the recent submissions from Lars-Peter) it'd be
> good to start this off with a separate bus driver for I2C even if the
> SPI one is still to be done - that way the Kconfig stuff for machine
> drivers is all in place and doesn't need updating.
> 
> > +  - clocks : phandle to the clock source for MCLK
> > +
> > +  - clock-names : must contain "mclk".
> 
> These should really be lists though there's only one documented element
> so it's purely a documentation update.
> 
> > +	/* Disable auto-mute */
> > +	regmap_update_bits(cs42888->regmap, CS42888_TXCTL,
> > +			   CS42888_TXCTL_AMUTE | CS42888_TXCTL_DAC_SZC_MASK,
> > +			   CS42888_TXCTL_DAC_SZC_SR);
> 
> Does this interfere with the manual mute controls or is it a separate
> thing?  If it plays nicely with the manual controls it's probably better
> to leave it enabled since it improves performance in some benchmarks
> (that's why hardware tends to have the feature).
> 
> > +	/*
> > +	 * We haven't marked the chip revision as volatile due to
> > +	 * sharing a register with the right input volume; explicitly
> > +	 * bypass the cache to read it.
> > +	 */
> > +	regcache_cache_bypass(cs42888->regmap, true);
> 
> The other option here is to just not provide a default so that the first
> time it's read it goes to hardware.  It doesn't make much difference
> either way though.
> 
> > +static int cs42888_i2c_remove(struct i2c_client *i2c_client)
> > +{
> > +	snd_soc_unregister_codec(&i2c_client->dev);
> > +	return 0;
> > +}
> 
> The driver ought to disable runtime PM, the clock and the regulators here.
> 
> > +	/*
> > +	 * In case the device was put to hard reset during sleep,
> > +	 * we need to wait 500ns here before any I2C communication
> > +	 */
> > +	mdelay(5);
> 
> Do we need 500ns or 5ms?  
> 
> > +	regcache_sync(cs42888->regmap);
> 
> Should really check the return value here.
> 
> > +	if (!IS_ERR(cs42888->clk))
> > +		clk_disable_unprepare(cs42888->clk);
> 
> Does the device work without MCLK?
