From: Jianqun <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH] ASoC: simple-card: Add mic and hp detect gpios.
Date: Wed, 22 Oct 2014 14:44:51 +0800
Message-ID: <54475263.8080004@rock-chips.com>
References: <1412198720-2326-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412198720-2326-1-git-send-email-dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


=E5=9C=A8 10/02/2014 05:25 AM, Dylan Reid =E5=86=99=E9=81=93:
> Allow Headphone and Microphone jack detect gpios to be specified in
> device tree.  This will allow a few systems including rk3288_max98090
> to use simple-card instead of having their own board file.
>
> Signed-off-by: Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/simple-card.txt      |  4 ++
>  sound/soc/generic/simple-card.c                    | 73 ++++++++++++=
++++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt =
b/Documentation/devicetree/bindings/sound/simple-card.txt
> index c2e9841..72d94b7 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.txt
> +++ b/Documentation/devicetree/bindings/sound/simple-card.txt
> @@ -17,6 +17,10 @@ Optional properties:
>  					  source.
>  - simple-audio-card,mclk-fs             : Multiplication factor betw=
een stream rate and codec
>    					  mclk.
> +- simple-audio-card,hp_det_gpio		: Reference to GPIO that signals wh=
en
> +					  headphones are attached.
> +- simple-audio-card,mic_det_gpio	: Reference to GPIO that signals wh=
en
> +					  a microphone is attached.
> =20
>  Optional subnodes:
> =20
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simp=
le-card.c
> index 709ce67..fcb431f 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -10,10 +10,13 @@
>   */
>  #include <linux/clk.h>
>  #include <linux/device.h>
> +#include <linux/gpio.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
>  #include <linux/string.h>
> +#include <sound/jack.h>
>  #include <sound/simple_card.h>
>  #include <sound/soc-dai.h>
>  #include <sound/soc.h>
> @@ -25,6 +28,8 @@ struct simple_card_data {
>  		struct asoc_simple_dai codec_dai;
>  	} *dai_props;
>  	unsigned int mclk_fs;
> +	int gpio_hp_det;
> +	int gpio_mic_det;
>  	struct snd_soc_dai_link dai_link[];	/* dynamically allocated */
>  };
> =20
> @@ -54,6 +59,32 @@ static struct snd_soc_ops asoc_simple_card_ops =3D=
 {
>  	.hw_params =3D asoc_simple_card_hw_params,
>  };
> =20
> +static struct snd_soc_jack simple_card_hp_jack;
> +static struct snd_soc_jack_pin simple_card_hp_jack_pins[] =3D {
> +	{
> +		.pin =3D "Headphones",
> +		.mask =3D SND_JACK_HEADPHONE,
> +	},
> +};
> +static struct snd_soc_jack_gpio simple_card_hp_jack_gpio =3D {
> +	.name =3D "Headphone detection",
> +	.report =3D SND_JACK_HEADPHONE,
> +	.debounce_time =3D 150,
I think some board needs "invert" trigger level, i.e need to add "inver=
t" property in dt ?
Pinky board do need it.
> +};
> +
> +static struct snd_soc_jack simple_card_mic_jack;
> +static struct snd_soc_jack_pin simple_card_mic_jack_pins[] =3D {
> +	{
> +		.pin =3D "Mic Jack",
> +		.mask =3D SND_JACK_MICROPHONE,
> +	},
> +};
> +static struct snd_soc_jack_gpio simple_card_mic_jack_gpio =3D {
> +	.name =3D "Mic detection",
> +	.report =3D SND_JACK_MICROPHONE,
> +	.debounce_time =3D 150,
> +};
> +
>  static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
>  				       struct asoc_simple_dai *set)
>  {
> @@ -109,6 +140,28 @@ static int asoc_simple_card_dai_init(struct snd_=
soc_pcm_runtime *rtd)
>  	if (ret < 0)
>  		return ret;
> =20
> +	if (gpio_is_valid(priv->gpio_hp_det)) {
> +		snd_soc_jack_new(codec->codec, "Headphones", SND_JACK_HEADPHONE,
> +				 &simple_card_hp_jack);
> +		snd_soc_jack_add_pins(&simple_card_hp_jack,
> +				      ARRAY_SIZE(simple_card_hp_jack_pins),
> +				      simple_card_hp_jack_pins);
> +
> +		simple_card_hp_jack_gpio.gpio =3D priv->gpio_hp_det;
> +		snd_soc_jack_add_gpios(&simple_card_hp_jack, 1,
> +				       &simple_card_hp_jack_gpio);
> +	}
> +
> +	if (gpio_is_valid(priv->gpio_mic_det)) {
> +		snd_soc_jack_new(codec->codec, "Mic Jack", SND_JACK_MICROPHONE,
> +				 &simple_card_mic_jack);
> +		snd_soc_jack_add_pins(&simple_card_mic_jack,
> +				      ARRAY_SIZE(simple_card_mic_jack_pins),
> +				      simple_card_mic_jack_pins);
> +		simple_card_mic_jack_gpio.gpio =3D priv->gpio_mic_det;
> +		snd_soc_jack_add_gpios(&simple_card_mic_jack, 1,
> +				       &simple_card_mic_jack_gpio);
> +	}
>  	return 0;
>  }
> =20
> @@ -383,6 +436,16 @@ static int asoc_simple_card_parse_of(struct devi=
ce_node *node,
>  			return ret;
>  	}
> =20
> +	priv->gpio_hp_det =3D of_get_named_gpio(node,
> +				"simple-audio-card,hp-det-gpio", 0);
> +	if (priv->gpio_hp_det =3D=3D -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
> +	priv->gpio_mic_det =3D of_get_named_gpio(node,
> +				"simple-audio-card,mic-det-gpio", 0);
> +	if (priv->gpio_mic_det =3D=3D -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
>  	if (!priv->snd_card.name)
>  		priv->snd_card.name =3D priv->snd_card.dai_link->name;
> =20
> @@ -502,6 +565,16 @@ err:
> =20
>  static int asoc_simple_card_remove(struct platform_device *pdev)
>  {
> +	struct snd_soc_card *card =3D platform_get_drvdata(pdev);
> +	struct simple_card_data *priv =3D snd_soc_card_get_drvdata(card);
> +
> +	if (gpio_is_valid(priv->gpio_hp_det))
> +		snd_soc_jack_free_gpios(&simple_card_hp_jack, 1,
> +					&simple_card_hp_jack_gpio);
> +	if (gpio_is_valid(priv->gpio_mic_det))
> +		snd_soc_jack_free_gpios(&simple_card_mic_jack, 1,
> +					&simple_card_mic_jack_gpio);
> +
>  	return asoc_simple_card_unref(pdev);
>  }
> =20

--=20
Jianqun Xu

***********************************************************************=
*****
*IMPORTANT NOTICE:*This email is from Fuzhou Rockchip Electronics Co.,
Ltd .The contents of this email and any attachments may contain
information that is privileged, confidential and/or exempt from
disclosure under applicable law and relevant NDA. If you are not the
intended recipient, you are hereby notified that any disclosure,
copying, distribution, or use of the information is STRICTLY PROHIBITED=
=2E
Please immediately contact the sender as soon as possible and destroy
the material in its entirety in any format. Thank you.
***********************************************************************=
*****


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
