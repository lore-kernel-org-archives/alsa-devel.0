From: Paul Handrigan <paul.handrigan@cirrus.com>
Subject: Re: [PATCH v3 1/2] ASoC: cs35l33: Initial commit of
 the cs35l33 CODEC driver.
Date: Mon, 16 May 2016 10:20:24 -0500
Message-ID: <alpine.DEB.2.10.1605161013100.5521@phandrigan>
References: <1463172629-559-1-git-send-email-Paul.Handrigan@cirrus.com>
 <20160513222848.GW22038@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id EE64A265AE7
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 17:19:56 +0200 (CEST)
In-Reply-To: <20160513222848.GW22038@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org



On Fri, 13 May 2016, Mark Brown wrote:

> On Fri, May 13, 2016 at 03:50:28PM -0500, Paul.Handrigan@cirrus.com wrote:
> 
> > +static struct regmap *cs35l33_get_regmap(struct device *dev)
> > +{
> > +	struct cs35l33_private *cs35l33 = dev_get_drvdata(dev);
> > +
> > +	return cs35l33->regmap;
> > +}
> 
> Doesn't the default work for you?
> 
I can remove this function.


> > +	for (i = 0; i < CS35L33_INT_ATTEMPTS; i++) {
> > +		/* ack the irq by reading both status registers */
> 
> Why do we need this...?

The we need to keep handling the unmasked interrupts until they are
all cleared.  We could get another interrupt while handling the first
triggered interrupt, but the interrupt line could be de-asserted due to
the read-to-clear nature of the interrupt status registers.
> 
> > +		if (sticky_val1 & CS35L33_AMP_SHORT) {
> > +			dev_err(codec->dev, "Amp short error\n");
> > +
>			if (!(current_val & CS35L33_AMP_SHORT)) {
> 
> dev_crit()

OK.

> 
> > +		if (sticky_val1 & CS35L33_OTE) {
> > +			dev_err(codec->dev, "Over temperature error\n");
> 
> 
> Same here - these are extremely serious and probably indicate very
> serious physical problems.

OK.

> 
> > +	} else if (IS_ERR(cs35l33->reset_gpio)) {
> > +	dev_err(&i2c_client->dev, "%s ERROR: Can't get reset GPIO\n",
> > +			__func__);
> > +		return PTR_ERR(cs35l33->reset_gpio);
> 
> Indentation is messed up here.

OK.  Thanks!
> 
