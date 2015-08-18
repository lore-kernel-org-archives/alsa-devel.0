From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v3 2/4] ASoC: rockchip: Add rockchip SPDIF transceiver driver
Date: Tue, 18 Aug 2015 20:25:38 +0200
Message-ID: <1463451.tH10lfH9Hm@phil>
References: <1438947854-3743-1-git-send-email-sjoerd.simons@collabora.co.uk> <1438947854-3743-3-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438947854-3743-3-git-send-email-sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Sjoerd,


> +static int rk_spdif_probe(struct platform_device *pdev)
> +{
> +	struct rk_spdif_dev *spdif;
> +	struct resource *res;
> +	void __iomem *regs;
> +	int ret;
> +
> +	spdif = devm_kzalloc(&pdev->dev, sizeof(*spdif), GFP_KERNEL);
> +	if (!spdif)
> +		return -ENOMEM;
> +
> +	spdif->hclk = devm_clk_get(&pdev->dev, "spdif_hclk");

I guess this could be named just "hclk" - as it is the identifier local to the 
spdif-ip. (Of course in the binding too)


> +	if (IS_ERR(spdif->hclk)) {
> +		dev_err(&pdev->dev, "Can't retrieve rk_spdif bus clock\n");
> +		return PTR_ERR(spdif->hclk);
> +	}
> +	ret = clk_prepare_enable(spdif->hclk);
> +	if (ret) {
> +		dev_err(spdif->dev, "hclock enable failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	spdif->mclk = devm_clk_get(&pdev->dev, "spdif_clk");

The Rockchip TRMs (and the rest of the driver as well) refer to this clock as 
"mclk", so I guess the identifier could just be named the same.


> +	if (IS_ERR(spdif->mclk)) {
> +		dev_err(&pdev->dev, "Can't retrieve rk_spdif master clock\n");
> +		return PTR_ERR(spdif->hclk);
> +	}
> +
> +	ret = clk_prepare_enable(spdif->mclk);
> +	if (ret) {
> +		dev_err(spdif->dev, "clock enable failed %d\n", ret);
> +		return ret;
> +	}

I guess this plays into what Mark already wrote, but as the code stands right 
now, you enable the mclk here and then through runtime_resume as well, so that 
it stays running all the time, as the refcount is either 2 or 1 but never 0.

Also I don't think mixing devm_clk_get + clk_prepare_enable calls works well. 
If the devm_clk_get(... "spdif_clk") fails, the hclk would stay running right 
now.


[...]

> +static int rk_spdif_remove(struct platform_device *pdev)
> +{
> +	struct rk_spdif_dev *spdif = dev_get_drvdata(&pdev->dev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	if (!pm_runtime_status_suspended(&pdev->dev))
> +		rk_spdif_runtime_suspend(&pdev->dev);
> +
> +	clk_disable_unprepare(spdif->mclk);
> +	clk_disable_unprepare(spdif->hclk);
> +	snd_dmaengine_pcm_unregister(&pdev->dev);
> +	snd_soc_unregister_component(&pdev->dev);

I think the ordering should stay symmetric to the probe function, where you 
have
	clk_enable
	snd_register
so here it should probably be
	snd_unregister 
	clk_disable



Heiko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
