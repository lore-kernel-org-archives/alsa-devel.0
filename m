From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH V6 02/10] ASoC: SAMSUNG: Add DT support for i2s
Date: Thu, 14 Feb 2013 12:05:54 +0100
Message-ID: <1448282.P7VUi6gpBa@amdc1227>
References: <1358509629-20471-1-git-send-email-padma.v@samsung.com>
 <1358509629-20471-3-git-send-email-padma.v@samsung.com>
 <511CC11B.5030700@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <511CC11B.5030700@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Padmavathi Venna <padma.v@samsung.com>, padma.kvr@gmail.com, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, sbkim73@samsung.com, broonie@opensource.wolfsonmicro.com, vinod.koul@intel.com, grant.likely@secretlab.ca, swarren@nvidia.com, boojin.kim@samsung.com, kgene.kim@samsung.com, jassisinghbrar@gmail.com, thomas.abraham@linaro.org, lrg@ti.com, tiwai@suse.de, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Thursday 14 of February 2013 11:48:59 Sylwester Nawrocki wrote:
> On 01/18/2013 12:47 PM, Padmavathi Venna wrote:
> > Add support for device based discovery.
> > 
> > Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> > ---
> 
> ...
> 
> >  /* Lock for cross i/f checks */
> > 
> > @@ -997,19 +1006,76 @@ static struct i2s_dai *i2s_alloc_dai(struct
> > platform_device *pdev, bool sec)> 
> >  	return i2s;
> >  
> >  }
> > 
> > +#ifdef CONFIG_OF
> > +static int samsung_i2s_parse_dt_gpio(struct i2s_dai *i2s)
> > +{
> > +	struct device *dev = &i2s->pdev->dev;
> > +	int index, gpio, ret;
> > +
> > +	for (index = 0; index < 7; index++) {
> > +		gpio = of_get_gpio(dev->of_node, index);
> > +		if (!gpio_is_valid(gpio)) {
> > +			dev_err(dev, "invalid gpio[%d]: %d\n", index, gpio);
> > +			goto free_gpio;
> > +		}
> > +
> > +		ret = gpio_request(gpio, dev_name(dev));
> > +		if (ret) {
> > +			dev_err(dev, "gpio [%d] request failed\n", gpio);
> > +			goto free_gpio;
> > +		}
> > +		i2s->gpios[index] = gpio;
> > +	}
> > +	return 0;
> > +
> > +free_gpio:
> > +	while (--index >= 0)
> > +		gpio_free(i2s->gpios[index]);
> > +	return -EINVAL;
> > +}
> > +
> > +static void samsung_i2s_dt_gpio_free(struct i2s_dai *i2s)
> > +{
> > +	unsigned int index;
> > +	for (index = 0; index < 7; index++)
> > +		gpio_free(i2s->gpios[index]);
> > +}
> > +#else
> > +static int samsung_i2s_parse_dt_gpio(struct i2s_dai *dai)
> > +{
> > +	return -EINVAL;
> > +}
> > +
> > +static void samsung_i2s_dt_gpio_free(struct i2s_dai *dai)
> > +{
> > +}
> > +
> > +#endif
> 
> NAK.

+1

> 
> Why we should leave with this temporary code when there is already
> pinctrl support for Exynos SoCs ?
> 
> If the pinctrl driver for Exynos5 was updated you could instead just do
> 
> devm_pinctrl_get_select_default(&i2s->pdev->dev);

I said it already by the way of some other Exynos5 patches that Exynos5 
has to be migrated to pin control.

The legacy GPIO interface was supposed to be kept only for compatibility 
with existing code (until it gets migrated to pin control), not for adding 
new code relying on it.

If you intend to add new code which needs to configure pin muxes, you 
should migrate Exynos5 to pin control first. This won't be particularly 
hard, since pinctrl-exynos driver already supports Exynos5 and all that is 
missing are Device Tree nodes for it.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
