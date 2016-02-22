From: Jacob Siverskog <jacob-EZCvousvhKUZux3j3Bed6dkegs52MxvZ@public.gmane.org>
Subject: Re: [PATCH V3] ASoC: pcm179x: Add support for pcm1795 and pcm1796
Date: Mon, 22 Feb 2016 09:17:42 +0100
Message-ID: <CAEnXRPugU1ghisiC7iCdJuAg74nYC9KtG1SNP_BN-u4Ni7SB2A@mail.gmail.com>
References: <1452382685-18009-1-git-send-email-michael@amarulasolutions.com>
 <1452382685-18009-4-git-send-email-michael@amarulasolutions.com>
 <20160110120045.GW6588@sirena.org.uk> <20160110173812.GA16304@panicking>
 <20160205172451.GA30542@panicking> <CAOf5uwnpY8J=NC82rtZ_q50mWmHqEf2gteJxZe+cXVs_3FNmrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOf5uwnpY8J=NC82rtZ_q50mWmHqEf2gteJxZe+cXVs_3FNmrw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 20, 2016 at 10:27 AM, Michael Trimarchi
<michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:
> Hi Jacob
>
> On Fri, Feb 5, 2016 at 6:24 PM, Michael Trimarchi
> <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:
>>
>> Signed-off-by: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
>> ---
>> Not get time to retest
>>
>
> Can you confirm that it works for you?

Hi Michael!

Sorry for not getting back to your earlier. I tried some time ago, and
it made me realize that our application has been using an incorrect
format setting (S32_LE) all along. Changing to the (more) correct
S24_LE doesn't work (due to some reason I yet have not confirmed - but
it doesn't look to be caused by this driver).

However, from the datasheet, the removal of S32_LE from
PCM1792A_FORMATS seems correct. For the logical changes, the driver
works for me if I manually re-add S32_LE again.

I was hoping to figure out the cause of my S24_LE issue and then be
able to test your patch without modifications, but I realize that it's
taking too much time.

A few comments below.

>
> Michael
>
>> Changes v3 -> v2:
>>         - rebase after i2c support
>>
>> Changes v1 -> v2:
>>         - Use switch for support new variants
>>         - sort the compatible list
>>
>>  sound/soc/codecs/pcm179x-i2c.c |  6 ----
>>  sound/soc/codecs/pcm179x-spi.c |  6 ----
>>  sound/soc/codecs/pcm179x.c     | 62 ++++++++++++++++++++++++++++++++++++++++--
>>  sound/soc/codecs/pcm179x.h     |  9 ++++--
>>  4 files changed, 66 insertions(+), 17 deletions(-)
>>
>> diff --git a/sound/soc/codecs/pcm179x-i2c.c b/sound/soc/codecs/pcm179x-i2c.c
>> index 4118106..609f07f 100644
>> --- a/sound/soc/codecs/pcm179x-i2c.c
>> +++ b/sound/soc/codecs/pcm179x-i2c.c
>> @@ -44,12 +44,6 @@ static int pcm179x_i2c_remove(struct i2c_client *client)
>>         return pcm179x_common_exit(&client->dev);
>>  }
>>
>> -static const struct of_device_id pcm179x_of_match[] = {
>> -       { .compatible = "ti,pcm1792a", },
>> -       { }
>> -};
>> -MODULE_DEVICE_TABLE(of, pcm179x_of_match);
>> -
>>  static const struct i2c_device_id pcm179x_i2c_ids[] = {
>>         { "pcm179x", 0 },
>>         { }
>> diff --git a/sound/soc/codecs/pcm179x-spi.c b/sound/soc/codecs/pcm179x-spi.c
>> index da924d4..6ae0e4d 100644
>> --- a/sound/soc/codecs/pcm179x-spi.c
>> +++ b/sound/soc/codecs/pcm179x-spi.c
>> @@ -43,12 +43,6 @@ static int pcm179x_spi_remove(struct spi_device *spi)
>>         return pcm179x_common_exit(&spi->dev);
>>  }
>>
>> -static const struct of_device_id pcm179x_of_match[] = {
>> -       { .compatible = "ti,pcm1792a", },
>> -       { }
>> -};
>> -MODULE_DEVICE_TABLE(of, pcm179x_of_match);
>> -
>>  static const struct spi_device_id pcm179x_spi_ids[] = {
>>         { "pcm179x", 0 },
>>         { },
>> diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
>> index 06a6657..73c80d3 100644
>> --- a/sound/soc/codecs/pcm179x.c
>> +++ b/sound/soc/codecs/pcm179x.c
>> @@ -20,6 +20,8 @@
>>  #include <linux/slab.h>
>>  #include <linux/kernel.h>
>>  #include <linux/device.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>>
>>  #include <sound/core.h>
>>  #include <sound/pcm.h>
>> @@ -72,8 +74,31 @@ struct pcm179x_private {
>>         struct regmap *regmap;
>>         unsigned int format;
>>         unsigned int rate;
>> +#define PCM1795        1
>> +       unsigned int codec_model;
>>  };
>>
>> +static int pcm179x_startup(struct snd_pcm_substream *substream,
>> +                           struct snd_soc_dai *dai)
>> +{
>> +       struct snd_soc_codec *codec = dai->codec;
>> +       struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
>> +       u64 formats = PCM1792A_FORMATS;

How does this work? Are formats always overwritten here (and hence
PCM179X_FORMATS never really used)?

>> +
>> +       switch (priv->codec_model) {
>> +       case PCM1795:
>> +               formats = PCM1795_FORMATS;
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +
>> +       snd_pcm_hw_constraint_mask64(substream->runtime,
>> +                                    SNDRV_PCM_HW_PARAM_FORMAT, formats);
>> +
>> +       return 0;
>> +}
>> +
>>  static int pcm179x_set_dai_fmt(struct snd_soc_dai *codec_dai,
>>                               unsigned int format)
>>  {
>> @@ -112,8 +137,10 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
>>         switch (priv->format & SND_SOC_DAIFMT_FORMAT_MASK) {
>>         case SND_SOC_DAIFMT_RIGHT_J:
>>                 switch (params_width(params)) {
>> -               case 24:
>>                 case 32:
>> +                       val = 1;
>> +                       break;
>> +               case 24:
>>                         val = 2;
>>                         break;
>>                 case 16:
>> @@ -125,8 +152,10 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
>>                 break;
>>         case SND_SOC_DAIFMT_I2S:
>>                 switch (params_width(params)) {
>> -               case 24:
>>                 case 32:
>> +                       val = 4;
>> +                       break;
>> +               case 24:
>>                         val = 5;
>>                         break;
>>                 case 16:
>> @@ -152,6 +181,7 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
>>  }
>>
>>  static const struct snd_soc_dai_ops pcm179x_dai_ops = {
>> +       .startup        = pcm179x_startup,
>>         .set_fmt        = pcm179x_set_dai_fmt,
>>         .hw_params      = pcm179x_hw_params,
>>         .digital_mute   = pcm179x_digital_mute,
>> @@ -190,7 +220,7 @@ static struct snd_soc_dai_driver pcm179x_dai = {
>>                 .rates = SNDRV_PCM_RATE_CONTINUOUS,
>>                 .rate_min = 10000,
>>                 .rate_max = 200000,
>> -               .formats = PCM1792A_FORMATS, },
>> +               .formats = PCM179X_FORMATS, },
>>         .ops = &pcm179x_dai_ops,
>>  };
>>
>> @@ -214,15 +244,41 @@ static struct snd_soc_codec_driver soc_codec_dev_pcm179x = {
>>         .num_dapm_routes        = ARRAY_SIZE(pcm179x_dapm_routes),
>>  };
>>
>> +static const unsigned int codec_model = PCM1795;
>> +
>> +const struct of_device_id pcm179x_of_match[] = {
>> +       { .compatible = "ti,pcm1792a", },
>> +       { .compatible = "ti,pcm1795",
>> +         .data = &codec_model,
>> +       },
>> +       { .compatible = "ti,pcm1796", },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, pcm179x_of_match);
>> +EXPORT_SYMBOL_GPL(pcm179x_of_match);
>> +
>>  int pcm179x_common_init(struct device *dev, struct regmap *regmap)
>>  {
>>         struct pcm179x_private *pcm179x;
>> +       struct device_node *np = dev->of_node;
>> +       const unsigned int *codec_model = NULL;
>>
>>         pcm179x = devm_kzalloc(dev, sizeof(struct pcm179x_private),
>>                                 GFP_KERNEL);
>>         if (!pcm179x)
>>                 return -ENOMEM;
>>
>> +       if (np) {
>> +               const struct of_device_id *of_id;
>> +
>> +               of_id = of_match_device(pcm179x_of_match, dev);
>> +               if (of_id)
>> +                       codec_model = of_id->data;
>> +       }
>> +
>> +       if (codec_model)
>> +               pcm179x->codec_model =  *codec_model;

Double space.

>> +
>>         pcm179x->regmap = regmap;
>>         dev_set_drvdata(dev, pcm179x);
>>
>> diff --git a/sound/soc/codecs/pcm179x.h b/sound/soc/codecs/pcm179x.h
>> index 11e3312..4c00047 100644
>> --- a/sound/soc/codecs/pcm179x.h
>> +++ b/sound/soc/codecs/pcm179x.h
>> @@ -17,10 +17,15 @@
>>  #ifndef __PCM179X_H__
>>  #define __PCM179X_H__
>>
>> -#define PCM1792A_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE | \
>> -                         SNDRV_PCM_FMTBIT_S16_LE)
>> +#define PCM179X_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE | \
>> +                        SNDRV_PCM_FMTBIT_S16_LE)
>> +
>> +#define PCM1792A_FORMATS (SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE)
>> +
>> +#define PCM1795_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE)
>>
>>  extern const struct regmap_config pcm179x_regmap_config;
>> +extern const struct of_device_id pcm179x_of_match[];
>>
>>  int pcm179x_common_init(struct device *dev, struct regmap *regmap);
>>  int pcm179x_common_exit(struct device *dev);
>> --
>> 2.7.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
