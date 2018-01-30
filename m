From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 116/186] ASoC: pcm179x: replace codec to
	component
Date: Tue, 30 Jan 2018 09:39:45 +0100
Message-ID: <CAOf5uwmKotnhJv-DHK1a5WZBoQ3W_Nrs1J1b0bKzphOqdCexxg@mail.gmail.com>
References: <87607l8k9i.wl%kuninori.morimoto.gx@renesas.com>
 <87inbl5q6q.wl%kuninori.morimoto.gx@renesas.com>
 <87tvv5xpum.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
 [209.85.214.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 8721A26706F
 for <alsa-devel@alsa-project.org>; Tue, 30 Jan 2018 09:39:47 +0100 (CET)
Received: by mail-it0-f66.google.com with SMTP id 68so12506358ite.4
 for <alsa-devel@alsa-project.org>; Tue, 30 Jan 2018 00:39:47 -0800 (PST)
In-Reply-To: <87tvv5xpum.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

HI

On Mon, Jan 29, 2018 at 5:16 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Now we can replace Codec to Component. Let's do it.
>
> Note:
>         xxx_codec_xxx()         ->      xxx_component_xxx()
>         .idle_bias_off = 0      ->      .idle_bias_on = 1
>         .ignore_pmdown_time = 0 ->      .use_pmdown_time = 1
>         -                       ->      .endianness = 1
>         -                       ->      .non_legacy_dai_naming = 1
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/codecs/pcm179x-i2c.c |  6 ------
>  sound/soc/codecs/pcm179x-spi.c |  6 ------
>  sound/soc/codecs/pcm179x.c     | 45 +++++++++++++++++++-----------------------
>  sound/soc/codecs/pcm179x.h     |  1 -
>  4 files changed, 20 insertions(+), 38 deletions(-)
>
> diff --git a/sound/soc/codecs/pcm179x-i2c.c b/sound/soc/codecs/pcm179x-i2c.c
> index 4118106..0374796 100644
> --- a/sound/soc/codecs/pcm179x-i2c.c
> +++ b/sound/soc/codecs/pcm179x-i2c.c
> @@ -39,11 +39,6 @@ static int pcm179x_i2c_probe(struct i2c_client *client,
>         return pcm179x_common_init(&client->dev, regmap);
>  }
>
> -static int pcm179x_i2c_remove(struct i2c_client *client)
> -{
> -       return pcm179x_common_exit(&client->dev);
> -}
> -
>  static const struct of_device_id pcm179x_of_match[] = {
>         { .compatible = "ti,pcm1792a", },
>         { }
> @@ -63,7 +58,6 @@ static int pcm179x_i2c_remove(struct i2c_client *client)
>         },
>         .id_table       = pcm179x_i2c_ids,
>         .probe          = pcm179x_i2c_probe,
> -       .remove         = pcm179x_i2c_remove,
>  };
>
>  module_i2c_driver(pcm179x_i2c_driver);
> diff --git a/sound/soc/codecs/pcm179x-spi.c b/sound/soc/codecs/pcm179x-spi.c
> index da924d4..89ad715 100644
> --- a/sound/soc/codecs/pcm179x-spi.c
> +++ b/sound/soc/codecs/pcm179x-spi.c
> @@ -38,11 +38,6 @@ static int pcm179x_spi_probe(struct spi_device *spi)
>         return pcm179x_common_init(&spi->dev, regmap);
>  }
>
> -static int pcm179x_spi_remove(struct spi_device *spi)
> -{
> -       return pcm179x_common_exit(&spi->dev);
> -}
> -
>  static const struct of_device_id pcm179x_of_match[] = {
>         { .compatible = "ti,pcm1792a", },
>         { }
> @@ -62,7 +57,6 @@ static int pcm179x_spi_remove(struct spi_device *spi)
>         },
>         .id_table = pcm179x_spi_ids,
>         .probe = pcm179x_spi_probe,
> -       .remove = pcm179x_spi_remove,
>  };
>
>  module_spi_driver(pcm179x_spi_driver);
> diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
> index 82a3d9d..4b311c0 100644
> --- a/sound/soc/codecs/pcm179x.c
> +++ b/sound/soc/codecs/pcm179x.c
> @@ -77,8 +77,8 @@ struct pcm179x_private {
>  static int pcm179x_set_dai_fmt(struct snd_soc_dai *codec_dai,
>                               unsigned int format)
>  {
> -       struct snd_soc_codec *codec = codec_dai->codec;
> -       struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
> +       struct snd_soc_component *component = codec_dai->component;
> +       struct pcm179x_private *priv = snd_soc_component_get_drvdata(component);
>
>         priv->format = format;
>
> @@ -87,8 +87,8 @@ static int pcm179x_set_dai_fmt(struct snd_soc_dai *codec_dai,
>
>  static int pcm179x_digital_mute(struct snd_soc_dai *dai, int mute)
>  {
> -       struct snd_soc_codec *codec = dai->codec;
> -       struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
> +       struct snd_soc_component *component = dai->component;
> +       struct pcm179x_private *priv = snd_soc_component_get_drvdata(component);
>         int ret;
>
>         ret = regmap_update_bits(priv->regmap, PCM179X_SOFT_MUTE,
> @@ -103,8 +103,8 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
>                              struct snd_pcm_hw_params *params,
>                              struct snd_soc_dai *dai)
>  {
> -       struct snd_soc_codec *codec = dai->codec;
> -       struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
> +       struct snd_soc_component *component = dai->component;
> +       struct pcm179x_private *priv = snd_soc_component_get_drvdata(component);
>         int val = 0, ret;
>
>         priv->rate = params_rate(params);
> @@ -137,7 +137,7 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
>                 }
>                 break;
>         default:
> -               dev_err(codec->dev, "Invalid DAI format\n");
> +               dev_err(component->dev, "Invalid DAI format\n");
>                 return -EINVAL;
>         }
>
> @@ -205,15 +205,17 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
>  };
>  EXPORT_SYMBOL_GPL(pcm179x_regmap_config);
>
> -static const struct snd_soc_codec_driver soc_codec_dev_pcm179x = {
> -       .component_driver = {
> -               .controls               = pcm179x_controls,
> -               .num_controls           = ARRAY_SIZE(pcm179x_controls),
> -               .dapm_widgets           = pcm179x_dapm_widgets,
> -               .num_dapm_widgets       = ARRAY_SIZE(pcm179x_dapm_widgets),
> -               .dapm_routes            = pcm179x_dapm_routes,
> -               .num_dapm_routes        = ARRAY_SIZE(pcm179x_dapm_routes),
> -       },
> +static const struct snd_soc_component_driver soc_component_dev_pcm179x = {
> +       .controls               = pcm179x_controls,
> +       .num_controls           = ARRAY_SIZE(pcm179x_controls),
> +       .dapm_widgets           = pcm179x_dapm_widgets,
> +       .num_dapm_widgets       = ARRAY_SIZE(pcm179x_dapm_widgets),
> +       .dapm_routes            = pcm179x_dapm_routes,
> +       .num_dapm_routes        = ARRAY_SIZE(pcm179x_dapm_routes),
> +       .idle_bias_on           = 1,
> +       .use_pmdown_time        = 1,
> +       .endianness             = 1,
> +       .non_legacy_dai_naming  = 1,
>  };
>
>  int pcm179x_common_init(struct device *dev, struct regmap *regmap)
> @@ -228,18 +230,11 @@ int pcm179x_common_init(struct device *dev, struct regmap *regmap)
>         pcm179x->regmap = regmap;
>         dev_set_drvdata(dev, pcm179x);
>
> -       return snd_soc_register_codec(dev,
> -                       &soc_codec_dev_pcm179x, &pcm179x_dai, 1);
> +       return devm_snd_soc_register_component(dev,
> +                       &soc_component_dev_pcm179x, &pcm179x_dai, 1);
>  }
>  EXPORT_SYMBOL_GPL(pcm179x_common_init);
>
> -int pcm179x_common_exit(struct device *dev)
> -{
> -       snd_soc_unregister_codec(dev);
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(pcm179x_common_exit);
> -
>  MODULE_DESCRIPTION("ASoC PCM179X driver");
>  MODULE_AUTHOR("Michael Trimarchi <michael@amarulasolutions.com>");
>  MODULE_LICENSE("GPL");
> diff --git a/sound/soc/codecs/pcm179x.h b/sound/soc/codecs/pcm179x.h
> index 11e3312..cf8681c9 100644
> --- a/sound/soc/codecs/pcm179x.h
> +++ b/sound/soc/codecs/pcm179x.h
> @@ -23,6 +23,5 @@
>  extern const struct regmap_config pcm179x_regmap_config;
>
>  int pcm179x_common_init(struct device *dev, struct regmap *regmap);
> -int pcm179x_common_exit(struct device *dev);
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

Give me time to test on some device.

Michael

>  #endif
> --
> 1.9.1
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
