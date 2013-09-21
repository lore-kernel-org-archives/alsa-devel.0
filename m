From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ASoC: kirkwood: clk: probe defer when clock not
	yet ready
Date: Sat, 21 Sep 2013 11:47:34 +0100
Message-ID: <20130921104734.GJ12758@n2100.arm.linux.org.uk>
References: <20130921120006.47b00fe7@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130921120006.47b00fe7@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 21, 2013 at 12:00:06PM +0200, Jean-Francois Moine wrote:
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index a004769..582abc8 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2181,7 +2181,7 @@ EXPORT_SYMBOL_GPL(of_clk_del_provider);
>  struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
>  {
>  	struct of_clk_provider *provider;
> -	struct clk *clk = ERR_PTR(-ENOENT);
> +	struct clk *clk = ERR_PTR(-EPROBE_DEFER);
>  
>  	/* Check if we have such a provider in our array */
>  	mutex_lock(&of_clk_lock);
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 442a313..f8b28d9 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -157,8 +157,13 @@ struct clk *clk_get(struct device *dev, const char *con_id)
>  
>  	if (dev) {
>  		clk = of_clk_get_by_name(dev->of_node, con_id);
> -		if (!IS_ERR(clk) && __clk_get(clk))
> -			return clk;
> +		if (!IS_ERR(clk)) {
> +			if (__clk_get(clk))
> +				return clk;
> +		} else {
> +			if (PTR_ERR(clk) == -EPROBE_DEFER)
> +				return clk;
> +		}

Another comment.  This is broken - it will never fall through if a
'dev' is given, because of_clk_get_by_name() will always return an
-EPROBE_DEFER error pointer in that case.

So this approach is unworkable.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
