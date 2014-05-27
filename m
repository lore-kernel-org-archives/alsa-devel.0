From: "Handrigan, Paul" <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: RE: [alsa-devel] [PATCH 2/2] ASoC: Add support for CS4265 CODEC
Date: Tue, 27 May 2014 17:09:19 +0000
Message-ID: <0CBF9AAF3CF9714282149D6CA9B22CF30B47F0AA@ex2.ad.cirrus.com>
References: <1400872614-21666-1-git-send-email-Paul.Handrigan@cirrus.com>
 <1400872614-21666-2-git-send-email-Paul.Handrigan@cirrus.com>,<5380C57A.9050603@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5380C57A.9050603-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Austin, Brian" <Brian.Austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


________________________________________
From: Lars-Peter Clausen [lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org]
Sent: Saturday, May 24, 2014 11:14 AM
To: Handrigan, Paul
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; Austin, Brian; pawel.moll-5wv7dgnIgG8@public.gmane.org; ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org; lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: Add support for CS4265 CODEC

On 05/23/2014 09:16 PM, Paul Handrigan wrote:
[...]

A couple of trivial bits:

> @@ -300,6 +301,10 @@ config SND_SOC_CS42L73
>       tristate "Cirrus Logic CS42L73 CODEC"
>       depends on I2C
>
> +config SND_SOC_CS4265
> +     tristate "Cirrus Logic CS4265 CODEC"
> +     depends on I2C

select REGMAP_I2C

> +
>   # Cirrus Logic CS4270 Codec
>   config SND_SOC_CS4270
>       tristate "Cirrus Logic CS4270 CODEC"
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index 1ccdaf0..b3c6b5f 100644
[...]
> diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
> new file mode 100644
> index 0000000..f7a6be9
> --- /dev/null
> +++ b/sound/soc/codecs/cs4265.c
> @@ -0,0 +1,716 @@
[...]
> +struct cs4265_private {
> +     struct cs4265_platform_data pdata;
> +     struct regmap *regmap;
> +     struct snd_soc_codec *codec;
> +     struct device *dev;

Both the codec and the dev field don't seem to be used.

> +     u8 format;
> +     u32 sysclk;
> +};
> +
[...]
> +
> +static const struct soc_enum digital_input_mux_enum =
> +     SOC_ENUM_SINGLE(CS4265_SIG_SEL, 7,
> +                     ARRAY_SIZE(digital_input_mux_text),
> +                     digital_input_mux_text);

SOC_ENUM_SINGLE_DECL(), same for the other enums below.

> +
[...]
> +static struct snd_soc_dai_ops cs4265_ops = {

const

> +     .hw_params      = cs4265_pcm_hw_params,
> +     .digital_mute   = cs4265_digital_mute,
> +     .set_fmt        = cs4265_set_fmt,
> +     .set_sysclk     = cs4265_set_sysclk,
> +};
[...]
> +static struct snd_soc_codec_driver soc_codec_dev_cs4265 = {

const

The soc_codec_dev_foobar naming scheme used in some older driver comes from
a time where there were no CODEC drivers. A better naming scheme for new
driver is foobar_codec_driver.

> +     .probe = cs4265_probe,
> +     .remove = cs4265_remove,
> +     .set_bias_level = cs4265_set_bias_level,
> +
> +     .dapm_widgets = cs4265_dapm_widgets,
> +     .num_dapm_widgets = ARRAY_SIZE(cs4265_dapm_widgets),
> +     .dapm_routes = cs4265_audio_map,
> +     .num_dapm_routes = ARRAY_SIZE(cs4265_audio_map),
> +
> +     .controls = cs4265_snd_controls,
> +     .num_controls = ARRAY_SIZE(cs4265_snd_controls),
> +};
> +
> +static struct regmap_config cs4265_regmap = {

const

> +     .reg_bits = 8,
> +     .val_bits = 8,
> +
> +     .max_register = CS4265_MAX_REGISTER,
> +     .reg_defaults = cs4265_reg_defaults,
> +     .num_reg_defaults = ARRAY_SIZE(cs4265_reg_defaults),
> +     .readable_reg = cs4265_readable_register,
> +     .volatile_reg = cs4265_volatile_register,
> +     .cache_type = REGCACHE_RBTREE,
> +};
> +
[...]

Thanks!  I will make these changes as well.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
