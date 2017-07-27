From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RFT 2/2] ASoC: samsung: Add proper error paths to
 s3c24xx I2S driver
Date: Thu, 27 Jul 2017 18:51:13 +0200
Message-ID: <20170727165113.dkqx2djk2b2rgbp4@kozik-lap>
References: <20170726185729.28897-1-krzk@kernel.org>
 <20170726185729.28897-2-krzk@kernel.org>
 <49f6f3df-f7c9-cf7e-95ad-e3d6fdc78014@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id AF517266A8A
 for <alsa-devel@alsa-project.org>; Thu, 27 Jul 2017 18:51:16 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id t138so5588218wmt.4
 for <alsa-devel@alsa-project.org>; Thu, 27 Jul 2017 09:51:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49f6f3df-f7c9-cf7e-95ad-e3d6fdc78014@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 27, 2017 at 10:41:35AM +0530, Arvind Yadav wrote:
> Hi,
> 
> 
> On Thursday 27 July 2017 12:27 AM, Krzysztof Kozlowski wrote:
> > s3c2412_i2s_probe() might fail so driver has to revert work done by
> > s3c_i2sv2_probe() (clock enabling).  Missing doing this would lead to
> > clock enable in-balance.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Please, kindly test on S3C24xx hardware.
> > ---
> >   sound/soc/samsung/s3c-i2s-v2.c  |  9 +++++++++
> >   sound/soc/samsung/s3c-i2s-v2.h  |  7 +++++++
> >   sound/soc/samsung/s3c2412-i2s.c | 11 +++++++++--
> >   3 files changed, 25 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
> > index 9b28046eea8e..df83f2730a53 100644
> > --- a/sound/soc/samsung/s3c-i2s-v2.c
> > +++ b/sound/soc/samsung/s3c-i2s-v2.c
> > @@ -651,6 +651,15 @@ int s3c_i2sv2_probe(struct snd_soc_dai *dai,
> >   }
> >   EXPORT_SYMBOL_GPL(s3c_i2sv2_probe);
> > +void s3c_i2sv2_cleanup(struct snd_soc_dai *dai,
> > +		      struct s3c_i2sv2_info *i2s)
> > +{
> > +	clk_disable(i2s->iis_pclk);
> > +	clk_put(i2s->iis_pclk);
> > +	i2s->iis_pclk = NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(s3c_i2sv2_cleanup);
> > +
> >   #ifdef CONFIG_PM
> >   static int s3c2412_i2s_suspend(struct snd_soc_dai *dai)
> >   {
> > diff --git a/sound/soc/samsung/s3c-i2s-v2.h b/sound/soc/samsung/s3c-i2s-v2.h
> > index 182d80564e37..3fca20f7a853 100644
> > --- a/sound/soc/samsung/s3c-i2s-v2.h
> > +++ b/sound/soc/samsung/s3c-i2s-v2.h
> > @@ -92,6 +92,13 @@ extern int s3c_i2sv2_probe(struct snd_soc_dai *dai,
> >   			   unsigned long base);
> >   /**
> > + * s3c_i2sv2_cleanup - cleanup resources allocated in s3c_i2sv2_probe
> > + * @dai: The ASoC DAI structure supplied to the original probe.
> > + * @i2s: Our local i2s structure to fill in.
> > + */
> > +extern void s3c_i2sv2_cleanup(struct snd_soc_dai *dai,
> > +			      struct s3c_i2sv2_info *i2s);
> > +/**
> >    * s3c_i2sv2_register_component - register component and dai with soc core
> >    * @dev: DAI device
> >    * @id: DAI ID
> > diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
> > index bcd1cbdeac93..005cd6db7d07 100644
> > --- a/sound/soc/samsung/s3c2412-i2s.c
> > +++ b/sound/soc/samsung/s3c2412-i2s.c
> > @@ -65,7 +65,8 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
> >   	s3c2412_i2s.iis_cclk = devm_clk_get(dai->dev, "i2sclk");
> >   	if (IS_ERR(s3c2412_i2s.iis_cclk)) {
> >   		pr_err("failed to get i2sclk clock\n");
> > -		return PTR_ERR(s3c2412_i2s.iis_cclk);
> > +		ret = PTR_ERR(s3c2412_i2s.iis_cclk);
> > +		goto err;
> >   	}
> >   	/* Set MPLL as the source for IIS CLK */
> > @@ -73,7 +74,7 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
> >   	clk_set_parent(s3c2412_i2s.iis_cclk, clk_get(NULL, "mpll"));
> we can use devm_clk_get for "mpll" clock.

This should be rather separate change from the fix... unless it is a fix
by itself.

> >   	ret = clk_prepare_enable(s3c2412_i2s.iis_cclk);
> >   	if (ret)
> > -		return ret;
> > +		goto err;
> >   	s3c2412_i2s.iis_cclk = s3c2412_i2s.iis_pclk;
> Now s3c2412_i2s.iis_cclk and s3c2412_i2s.iis_pclk are holding "iis" clock.
> Now no one handling "mpll" clock. If we will call s3c2412_i2s_remove.
> It's means. we are disabling "iis" clock twice. Which is not correct.

Right, what a obfuscated code is this... Thanks for pointing this out.
Also the s3c_i2sv2_probe() misses clk_prepare().

Best regards,
Krzysztof


> > @@ -82,11 +83,17 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
> >   			      S3C_GPIO_PULL_NONE);
> >   	return 0;
> > +
> > +err:
> > +	s3c_i2sv2_cleanup(dai, &s3c2412_i2s);
> > +
> > +	return ret;
> >   }
> >   static int s3c2412_i2s_remove(struct snd_soc_dai *dai)
> >   {
> >   	clk_disable_unprepare(s3c2412_i2s.iis_cclk);
> > +	s3c_i2sv2_cleanup(dai, &s3c2412_i2s);
> here, We are disabling "iis" clock twice. please check my previous comment.
> >   	return 0;
> >   }
> ~arvind
