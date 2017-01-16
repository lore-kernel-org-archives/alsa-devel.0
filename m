From: Daniel Baluta <daniel.baluta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 3/4] ASoC: rockchip: Add machine driver
 for ES8388 codecs
Date: Mon, 16 Jan 2017 12:27:31 +0200
Message-ID: <CAEnQRZDiwJpUJ+9UkGz0M9MjaTjCH6u5K-B2a_CzPr-zW8ET0g@mail.gmail.com>
References: <20170116081753.13666-1-romain.perier@collabora.com> <20170116081753.13666-4-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170116081753.13666-4-romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Two nits, see below.

<snip>

> +static int snd_rk_mc_probe(struct platform_device *pdev)
> +{
> +       int ret = 0;
> +       struct snd_soc_card *card = &snd_soc_card_rk;
> +       struct device_node *np = pdev->dev.of_node;
> +       struct rk_es8388_drvdata *machine;
> +
> +       machine = devm_kzalloc(&pdev->dev, sizeof(struct rk_es8388_drvdata),
> +                              GFP_KERNEL);
> +

You don't need this new line here.
> +       if (!machine)
> +               return -ENOMEM;
> +

<snip>

> +module_platform_driver(snd_rk_es8388_driver);
> +
> +MODULE_AUTHOR("Sjoerd Simons");

You should also add your email address near name.

> +MODULE_DESCRIPTION("Rockchip es8388 machine ASoC driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" DRV_NAME);

thanks,
Daniel.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
