From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/4] ASoc: kirkwood: add DT support
Date: Fri, 26 Jul 2013 00:05:33 +0100
Message-ID: <20130725230533.GH24642@n2100.arm.linux.org.uk>
References: <20130725111459.145a4aa4@armhf>
 <20130725191905.GR9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 32FEF2610B1
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 01:05:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130725191905.GR9858@sirena.org.uk>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2013 at 08:19:05PM +0100, Mark Brown wrote:
> On Thu, Jul 25, 2013 at 11:14:59AM +0200, Jean-Francois Moine wrote:
> 
> > +	if (np) {
> > +		priv->burst = 128;		/* might be 32 or 128 */
> > +	} else if (data) {
> 
> When you posted this before I queried how and why the value might vary -
> I see the code is the same and I don't recall a reply.

This is the DMA burst size, and can be either 32 or 128 bytes according
to the docs.  Everyone seems to pass this as 128 bytes in their platform
data to date, which I guess is why its ended up being hard coded as 128.

However, whether it needs to be configurable or not is debatable - obviously
the hardware allows it, but that doesn't mean it has to be exposed.  If
ALSA has some kind of way of specifying a "low latency" mode where 128
byte vs 32 byte fetches would make a significant difference, then it may
be something to look at.

I'll retract my previous comment on this (about it being a DT property) -
given what it does, it isn't describing the hardware capabilities as I
first thought it was.

> > -	priv->clk = devm_clk_get(&pdev->dev, NULL);
> > +	priv->clk = devm_clk_get(&pdev->dev, "internal");
> >  	if (IS_ERR(priv->clk)) {
> > -		dev_err(&pdev->dev, "no clock\n");
> > +		dev_err(&pdev->dev, "no internal clock\n");
> >  		return PTR_ERR(priv->clk);
> >  	}
> 
> Does the code providing it already name the clock?  If not are updates
> needed to do that?
> 
> > -	priv->extclk = clk_get(&pdev->dev, "extclk");
> > +	priv->extclk = clk_get(&pdev->dev, "external");
> 
> Is the clock actually called extclk in the datasheet and so on?  If so
> it seems better to stick with that name.  Do any boards need updates for
> the new name?

"AU_EXTCLK" is the exact name (pasted out of the documentation).
I don't see any purpose to this name changing.
