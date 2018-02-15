From: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] ASoC: dmic: Add optional wakeup delay
Date: Wed, 14 Feb 2018 18:44:22 -0800
Message-ID: <20180215024422.GA99727@google.com>
References: <20180214235156.81589-1-mka@chromium.org>
 <20180215002253.GA12697@rodete-desktop-imager.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180215002253.GA12697-rgVyoJUnxu4fQXCR9C5MjtfHHWVUegAGYJqu5kTmcBRl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, huang lin <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

El Wed, Feb 14, 2018 at 04:22:54PM -0800 Brian Norris ha dit:

> Hi Matthias,
> 
> On Wed, Feb 14, 2018 at 03:51:56PM -0800, Matthias Kaehlcke wrote:
> > On some systems a delay is needed after switching on the clocks, to allow
> > the DMIC output to stabilize and avoid a popping noise at the beginning
> > of the recording. Add the optional device tree property 'wakeup-delay-ms'
> > and apply the specified delay in the new dmic_daiops_prepare().
> > 
> > Signed-off-by: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > ---
> >  .../devicetree/bindings/sound/dmic.txt        |  2 +
> >  sound/soc/codecs/dmic.c                       | 54 ++++++++++++++-----
> >  2 files changed, 42 insertions(+), 14 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
> > index 54c8ef6498a8..de741c6609d0 100644
> > --- a/Documentation/devicetree/bindings/sound/dmic.txt
> > +++ b/Documentation/devicetree/bindings/sound/dmic.txt
> > @@ -7,10 +7,12 @@ Required properties:
> >  
> >  Optional properties:
> >  	- dmicen-gpios: GPIO specifier for dmic to control start and stop
> > +	- wakeup-delay-ms: Delay (in ms) after enabling the DMIC
> >  
> >  Example node:
> >  
> >  	dmic_codec: dmic@0 {
> >  		compatible = "dmic-codec";
> >  		dmicen-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
> > +		wakeup-delay-ms <50>;
> >  	};
> > diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
> > index b88a1ee66f80..11f6abf11074 100644
> > --- a/sound/soc/codecs/dmic.c
> > +++ b/sound/soc/codecs/dmic.c
> > @@ -19,6 +19,7 @@
> >   *
> >   */
> >  
> > +#include <linux/delay.h>
> >  #include <linux/gpio.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/platform_device.h>
> > @@ -29,24 +30,38 @@
> >  #include <sound/soc.h>
> >  #include <sound/soc-dapm.h>
> >  
> > +struct dmic {
> > +	struct gpio_desc *gpio_en;
> > +	int wakeup_delay;
> > +};
> > +
> > +static int dmic_daiops_prepare(struct snd_pcm_substream *substream,
> > +				struct snd_soc_dai *dai)
> > +{
> > +	struct dmic *dmic = snd_soc_dai_get_drvdata(dai);
> > +
> > +	if (dmic->gpio_en)
> > +		gpiod_set_value(dmic->gpio_en, 1);
> > +
> > +	if (dmic->wakeup_delay)
> > +		msleep(dmic->wakeup_delay);
> > +
> > +	return 0;
> > +}
> > +
> >  static int dmic_daiops_trigger(struct snd_pcm_substream *substream,
> >  		int cmd, struct snd_soc_dai *dai)
> >  {
> > -	struct gpio_desc *dmic_en = snd_soc_dai_get_drvdata(dai);
> > +	struct dmic *dmic = snd_soc_dai_get_drvdata(dai);
> >  
> > -	if (!dmic_en)
> > +	if (!dmic->gpio_en)
> >  		return 0;
> >  
> >  	switch (cmd) {
> > -	case SNDRV_PCM_TRIGGER_START:
> > -	case SNDRV_PCM_TRIGGER_RESUME:
> > -	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > -		gpiod_set_value(dmic_en, 1);
> > -		break;
> >  	case SNDRV_PCM_TRIGGER_STOP:
> >  	case SNDRV_PCM_TRIGGER_SUSPEND:
> >  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> > -		gpiod_set_value(dmic_en, 0);
> > +		gpiod_set_value(dmic->gpio_en, 0);
> >  		break;
> 
> N00b question: are you sure this is legit? Is it possible to get
> START/STOP/START (or similar) with no prepare() in between?

To be honest I can't answer this question with authority and have to
defer it to the experts.

> >  	}
> >  
> > @@ -54,6 +69,7 @@ static int dmic_daiops_trigger(struct snd_pcm_substream *substream,
> >  }
> >  
> >  static const struct snd_soc_dai_ops dmic_dai_ops = {
> > +	.prepare	= dmic_daiops_prepare,
> >  	.trigger	= dmic_daiops_trigger,
> >  };
> >  
> > @@ -73,14 +89,24 @@ static struct snd_soc_dai_driver dmic_dai = {
> >  
> >  static int dmic_codec_probe(struct snd_soc_codec *codec)
> >  {
> > -	struct gpio_desc *dmic_en;
> > +	struct dmic *dmic;
> > +	int err;
> > +
> > +	dmic = devm_kzalloc(codec->dev, sizeof(*dmic), GFP_KERNEL);
> > +	if (!dmic)
> > +		return -ENOMEM;
> > +
> > +	dmic->gpio_en = devm_gpiod_get_optional(codec->dev,
> > +						"dmicen", GPIOD_OUT_LOW);
> > +	if (IS_ERR(dmic->gpio_en))
> > +		return PTR_ERR(dmic->gpio_en);
> >  
> > -	dmic_en = devm_gpiod_get_optional(codec->dev,
> > -					"dmicen", GPIOD_OUT_LOW);
> > -	if (IS_ERR(dmic_en))
> > -		return PTR_ERR(dmic_en);
> > +	err = device_property_read_u32(codec->dev, "wakeup-delay-ms",
> > +				       &dmic->wakeup_delay);
> > +	if (err && (err != -EINVAL))
> 
> You really want to be strict about error codes? What about -ENXIO ("no
> suitable firmware interface is present")? Seems like we should ignore
> that one too.
> 
> In practice, it looks like many drivers that are reading optional
> properties like this just tend to ignore the return code entirely.

Ok, let's follow the common practice for optional properties
then. I'll update it in v2.

Thanks

Matthias

> > +		return err;
> >  
> > -	snd_soc_codec_set_drvdata(codec, dmic_en);
> > +	snd_soc_codec_set_drvdata(codec, dmic);
> >  
> >  	return 0;
> >  }
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
