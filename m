From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v4] ASoC: fsl_sai: Add clock controls for SAI
Date: Thu, 10 Apr 2014 15:46:36 +0800
Message-ID: <20140410074635.GA14658@MrMyself>
References: <1397041577-9580-1-git-send-email-Guangyu.Chen@freescale.com>
 <fe26bf436e1846fca85415fc4c8bb67e@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fe26bf436e1846fca85415fc4c8bb67e@BY2PR03MB505.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li-B47053 <Li.Xiubo@freescale.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@tabi.org" <timur@tabi.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob@landley.net" <rob@landley.net>, "galak@codeaurora.org" <galak@codeaurora.org>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 10, 2014 at 03:39:51PM +0800, Xiubo Li-B47053 wrote:
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index db9f75e..7cd4af9 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -401,7 +401,23 @@ static int fsl_sai_startup(struct snd_pcm_substream
> > *substream,
> >  		struct snd_soc_dai *cpu_dai)
> >  {
> >  	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
> > -	u32 reg;
> > +	struct device *dev = &sai->pdev->dev;
> > +	u32 reg, i;
> > +	int ret;
> > +
> > +	ret = clk_prepare_enable(sai->bus_clk);
> > +	if (ret) {
> > +		dev_err(dev, "failed to enable bus clock\n");
> > +		return ret;
> > +	}
> > +
> > +	for (i = 0; i < FSL_SAI_MCLK_MAX; i++) {
> > +		ret = clk_prepare_enable(sai->mclk_clk[i]);
> > +		if (ret) {
> > +			dev_err(dev, "failed to enable mclk%d clock\n", i + 1);
> > +			goto err;
> > +		}
> > +	}
> > 
> 
> Why prepare and enable all the mclks here ?
> And at last only one of 'bus', 'mclk1', 'mclk2' and 'mclk3' will be selected
> To generate the bit clock. How about just prepare and enable the selected
> one ?
 
That's a fair suggestion. I'll do the revise.

But in this way. We can provisionally drop the clock enabling part and add
them later after my clock dividing patch is ready.

Thank you,
Nicolin
