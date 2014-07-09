From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH RESEND v7 2/3] ASoC: add es8328 codec driver
Date: Wed, 9 Jul 2014 10:45:27 +0100
Message-ID: <20140709094527.GA21251@opensource.wolfsonmicro.com>
References: <1404353989-19580-1-git-send-email-xobs@kosagi.com> <1404353989-19580-3-git-send-email-xobs@kosagi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404353989-19580-3-git-send-email-xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 03, 2014 at 10:19:48AM +0800, Sean Cross wrote:
> Add a codec driver for the Everest ES8328.  It supports two separate audio
> outputs and two separate audio inputs.
> 
> Signed-off-by: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
> ---

<snip>

> +
> +static int es8328_codec_probe(struct snd_soc_codec *codec)
> +{
> +	struct es8328_priv *es8328;
> +	int ret;
> +	int i;
> +
> +	es8328 = snd_soc_codec_get_drvdata(codec);
> +
> +	for (i = 0; i < ARRAY_SIZE(es8328->supplies); i++)
> +		es8328->supplies[i].supply = supply_names[i];
> +
> +	ret = devm_regulator_bulk_get(codec->dev, ARRAY_SIZE(es8328->supplies),
> +				es8328->supplies);

Is it safe to use devm_ from the ASoC level probe here? I think
there was a discussion recently that this can cause problems on
driver unbinding.

Otherwise this looks pretty good to me.

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
