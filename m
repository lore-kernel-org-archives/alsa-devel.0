From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH V2] ASoC: fsl: add imx-wm8962 machine driver
Date: Thu, 6 Jun 2013 20:49:53 +0800
Message-ID: <20130606124952.GA19153@MrMyself>
References: <1370420501-8410-1-git-send-email-b42378@freescale.com>
 <20130605115544.GX31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 by alsa0.perex.cz (Postfix) with ESMTP id D90BE261AAB
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 15:04:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130605115544.GX31367@sirena.org.uk>
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
Cc: grant.likely@linaro.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 05, 2013 at 12:55:44PM +0100, Mark Brown wrote:
> > +		/* assuming clock enabled by default */
> > +		data->codec_clk = NULL;
> > +		ret = of_property_read_u32(codec_np, "clock-frequency",
> > +					&data->clk_frequency);
> > +		if (ret) {
> > +			dev_err(&codec_dev->dev,
> > +				"clock-frequency missing or invalid\n");
> > +			goto fail;
> > +		}
> 
> Since it's easy to define a fixed rate clock (there's a generic driver
> for that) I'd just require the user to provide a clock API clock and fix
> the rate using that.  This is going to be less error prone and makes the
> code simpler.

I tried to use fixed rate clock as below:

	data->codec_clk = devm_clk_get(&codec_dev->dev, NULL);
	if (IS_ERR(data->codec_clk)) {
		of_fixed_clk_setup(codec_np);
		data->codec_clk = clk_get(NULL, codec_np->name);
		if (IS_ERR(data->codec_clk)) {
			dev_err(&pdev->dev, "failed to create fixed clk\n");
			ret = IS_ERR(data->codec_clk);
			goto fail;
		}
	}

	data->clk_frequency = clk_get_rate(data->codec_clk);
	clk_prepare_enable(data->codec_clk);

But I always got "failed to create fixed clk" error during system booting.
So I think it's pretty different to get a fixed clock with normal since
it's on the root_list of clock tree.
How can I get the clock here, or more specifically, any way to get the 
rate of the fixed-rate-clk?

Thanks.
