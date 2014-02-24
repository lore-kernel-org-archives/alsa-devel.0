From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: cs42888: Add codec driver support
Date: Mon, 24 Feb 2014 18:54:09 +0100
Message-ID: <530B8741.3010302@metafoo.de>
References: <1393224929-7555-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393224929-7555-1-git-send-email-Guangyu.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <Guangyu.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi,

Couple of trivial things.

On 02/24/2014 07:55 AM, Nicolin Chen wrote:
[...]
> +config SND_SOC_CS42888
> +	tristate "Cirrus Logic CS42888 CODEC"
> +	depends on I2C

should select REGMAP_I2C

> +
[...]
> +#define CS42888_NUM_SUPPLIES 4
> +static const char *cs42888_supply_names[CS42888_NUM_SUPPLIES] = {

const char *const

> +	"VA",
> +	"VD",
> +	"VLS",
> +	"VLC",
> +};
> +
> +static const char *cs42888_adc_single[] = { "Differential", "Single-Ended" };

const char * const

> +static const char *cs42888_szc[] = { "Immediate Change", "Zero Cross",
> +				     "Soft Ramp", "Soft Ramp on Zero Cross" };
> +

const char * constr

> +static const struct soc_enum cs42888_enum[] = {
> +	SOC_ENUM_SINGLE(CS42888_ADCCTL, 4, 2, cs42888_adc_single),
> +	SOC_ENUM_SINGLE(CS42888_ADCCTL, 3, 2, cs42888_adc_single),
> +	SOC_ENUM_SINGLE(CS42888_TXCTL, 5, 4, cs42888_szc),
> +	SOC_ENUM_SINGLE(CS42888_TXCTL, 0, 4, cs42888_szc),
> +};

Usually it makes things a bit more clearer when you have a variable with a 
unique name for each enum rather then putting them into one large array.

> +
[...]
> +static struct cs42888_ratios cs42888_ratios[] = {

const

[...]
> +static struct snd_soc_dai_ops cs42888_dai_ops = {

const

> +	.set_fmt	= cs42888_set_dai_fmt,
> +	.set_sysclk	= cs42888_set_dai_sysclk,
> +	.hw_params	= cs42888_hw_params,
> +	.digital_mute	= cs42888_digital_mute,
> +};
> +
[...]
> +
> +static struct reg_default cs42888_reg[] = {

const
[...]
> +
> +static struct snd_soc_codec_driver cs42888_driver = {

const

> +	.probe = cs42888_probe,
> +	.idle_bias_off = true,
> +
> +	.controls = cs42888_snd_controls,
> +	.num_controls = ARRAY_SIZE(cs42888_snd_controls),
> +	.dapm_widgets = cs42888_dapm_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(cs42888_dapm_widgets),
> +	.dapm_routes = cs42888_dapm_routes,
> +	.num_dapm_routes = ARRAY_SIZE(cs42888_dapm_routes),
> +};
> +

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
