From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 1/2] ASoC: fsl_sai: Add clock control for SAI
Date: Fri, 4 Apr 2014 09:43:12 +0000
Message-ID: <f713ce2310f44ef883194429ba97d4a8@BY2PR03MB505.namprd03.prod.outlook.com>
References: <cover.1396352401.git.Guangyu.Chen@freescale.com>
 <87d225a25812d730c0865f9d0bb733c67d8b3ed1.1396352401.git.Guangyu.Chen@freescale.com>
 <49295d4f0f0f42c4b9c6de77583b978e@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140404092804.GA2735@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140404092804.GA2735@MrMyself>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@tabi.org" <timur@tabi.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob@landley.net" <rob@landley.net>, "galak@codeaurora.org" <galak@codeaurora.org>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org

> Subject: Re: [PATCH 1/2] ASoC: fsl_sai: Add clock control for SAI
> 
> Hi Xiubo,
> 
> On Fri, Apr 04, 2014 at 05:24:39PM +0800, Xiubo Li-B47053 wrote:
> > Hi,
> >
> > I have test this series on my Vybrid-TWR board and it works happily.
> 
> You just checked the wrong version. I've sent a mail to let people disregard
> this version and a newer v2.
> 

Sorry, I didn't receive these, I will search it in the web page.

> >
> > [...]
> > > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > > index 3847d2a..2d749df 100644
> > > --- a/sound/soc/fsl/fsl_sai.c
> > > +++ b/sound/soc/fsl/fsl_sai.c
> > > @@ -428,5 +428,18 @@ static int fsl_sai_startup(struct snd_pcm_substream
> > > *substream,
> > >  {
> > >  	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
> > > -	u32 reg;
> > > +	struct device *dev = &sai->pdev->dev;
> > > +	u32 reg, ret;
> > > +
> >
> > I'd prefer:
> >   +	int ret;
> 
> Just like last time I said, it would be converted to 'int' any way. There's
> no much difference between them.
> 

Yes, it is...

I have ever encounter something like this in the feature maybe someone will
do the following check:

If (ret < 0)
	...

Just one potential problem and one suggestion.

Thanks,


> >
> > > +	ret = clk_prepare_enable(sai->ipg_clk);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to prepare and enable ipg clock\n");
> > > +		return ret;
> > > +	}
> > > +
> >
> > [...]
> >
> > > @@ -609,5 +630,5 @@ static int fsl_sai_probe(struct platform_device *pdev)
> > >
> > >  	sai->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
> > > -			"sai", base, &fsl_sai_regmap_config);
> > > +			"ipg", base, &fsl_sai_regmap_config);
> > >  	if (IS_ERR(sai->regmap)) {
> > >  		dev_err(&pdev->dev, "regmap init failed\n");
> > > @@ -615,4 +636,16 @@ static int fsl_sai_probe(struct platform_device *pdev)
> > >  	}
> > >
> > > +	sai->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
> > > +	if (IS_ERR(sai->ipg_clk)) {
> > > +		dev_err(&pdev->dev, "failed to get ipg clock\n");
> > > +		return PTR_ERR(sai->ipg_clk);
> > > +	}
> > > +
> >
> > Since the 'ipg' clock is just intend to be used for registers accessing and
> > We are using the regmap_init_mmio_clk(), so we can just drop it here and
> > Let the regmap APIs to do the clock options properly.
> 
> This 'ipg' clock, which I renamed in v2 to 'bus clock', is not just used
> in the way you said but also able to drive bit clock as your own code in
> the fsl_sai_set_dai_sysclk_tr(), and as reference manual describes:
> 
> 52.3.1.3 Bus clock
> The bus clock is used by the control and configuration registers and to
> generate synchronous interrupts and DMA requests.
> 
> Thanks,
> Nicolin
> 
> >
> > Otherwise it look good to me.
> >
> > After this:
> > Acked-by: Xiubo Li <Li.Xiubo@freescale.com>
> >
> >
> >
> > Thanks,
> >
> > Brs,
> > Xiubo
> >
> >
> >
> >
> > > +	sai->sai_clk = devm_clk_get(&pdev->dev, "sai");
> > > +	if (IS_ERR(sai->sai_clk)) {
> > > +		dev_err(&pdev->dev, "failed to get sai clock\n");
> > > +		return PTR_ERR(sai->sai_clk);
> > > +	}
> > > +
> > >  	irq = platform_get_irq(pdev, 0);
> > >  	if (irq < 0) {
> > > diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> > > index 677670d..cbaf114 100644
> > > --- a/sound/soc/fsl/fsl_sai.h
> > > +++ b/sound/soc/fsl/fsl_sai.h
> > > @@ -127,4 +127,6 @@ struct fsl_sai {
> > >  	struct platform_device *pdev;
> > >  	struct regmap *regmap;
> > > +	struct clk *ipg_clk;
> > > +	struct clk *sai_clk;
> > >
> > >  	bool big_endian_regs;
> > > --
> > > 1.8.4
> > >
> >

