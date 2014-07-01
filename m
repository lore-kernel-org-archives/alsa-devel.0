From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: add driver for Rockchip RK3xxx I2S controller
Date: Tue, 1 Jul 2014 10:01:14 +0100
Message-ID: <20140701090114.GJ28740@leverpostej>
References: <1404203860-30712-1-git-send-email-xjq@rock-chips.com>
 <1404204458-30881-1-git-send-email-xjq@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404204458-30881-1-git-send-email-xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jianqun <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: "heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org" <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "tiwai-l3A5Bk7waGM@public.gmane.org" <tiwai-l3A5Bk7waGM@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, kfx@rock-chips
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 01, 2014 at 09:47:38AM +0100, jianqun wrote:
> From: Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>
> Add driver for I2S controller in Rockchip RK3xxx SoCs.
>
> This driver patch has been tested on the RK3288 SDK board.
>
> Signed-off-by: Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
>  sound/soc/Kconfig                 |    1 +
>  sound/soc/Makefile                |    1 +
>  sound/soc/rockchip/Kconfig        |   16 +
>  sound/soc/rockchip/Makefile       |    6 +
>  sound/soc/rockchip/i2s.h          |  222 +++++++++++++
>  sound/soc/rockchip/pcm.h          |   14 +
>  sound/soc/rockchip/rockchip_i2s.c |  622 +++++++++++++++++++++++++++++++++++++
>  sound/soc/rockchip/rockchip_pcm.c |   64 ++++
>  8 files changed, 946 insertions(+)
>  create mode 100644 sound/soc/rockchip/Kconfig
>  create mode 100644 sound/soc/rockchip/Makefile
>  create mode 100644 sound/soc/rockchip/i2s.h
>  create mode 100644 sound/soc/rockchip/pcm.h
>  create mode 100644 sound/soc/rockchip/rockchip_i2s.c
>  create mode 100644 sound/soc/rockchip/rockchip_pcm.c

[...]

> +static int rockchip_i2s_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct rk_i2s_dev *i2s;
> +       struct resource *res;
> +       int ret;
> +
> +       i2s = devm_kzalloc(&pdev->dev, sizeof(struct rk_i2s_dev),
> +                               GFP_KERNEL);

You can use sizeof(*i2s) here.

[...]

> +       /* Try to set the I2S Channel id from dt */
> +       pdev->id = of_alias_get_id(np, "i2s");
> +       dev_set_name(&pdev->dev, "%s.%d",
> +                               pdev->dev.driver->name,
> +                               pdev->id);

This wasn't mentioned in the binding.

Cheers,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
