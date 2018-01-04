From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] ASoC: codecs: dmic: Use channel map for
 configs with a single mic
Date: Thu, 4 Jan 2018 11:54:38 -0800
Message-ID: <20180104195438.GA200397@google.com>
References: <20180104194848.198941-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f66.google.com (mail-pl0-f66.google.com
 [209.85.160.66])
 by alsa0.perex.cz (Postfix) with ESMTP id A642E267900
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 20:54:40 +0100 (CET)
Received: by mail-pl0-f66.google.com with SMTP id i6so1628645plt.13
 for <alsa-devel@alsa-project.org>; Thu, 04 Jan 2018 11:54:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180104194848.198941-1-mka@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, huang lin <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-kernel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>, Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

+ Brian & Dylan

El Thu, Jan 04, 2018 at 11:48:48AM -0800 Matthias Kaehlcke ha dit:

> The DMIC DAI driver specifies a number of 1 to 8 channels for each DAI.
> The actual number of mics can currently not be configured in the device
> tree or audio glue, but is derived from the min/max channels of the CPU
> and codec DAI. A typical CPU DAI has two or more channels, in consequence
> a single mic is treated as a stereo/multi channel device, even though
> only one channel carries audio data.
> 
> This change adds the option to specify the number of used DMIC channels
> in the device tree. If a single channel is used we export a channel map
> that marks all unused channels as invalid to indicate userspace that the
> capture device is mono.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  Documentation/devicetree/bindings/sound/dmic.txt |  2 +
>  sound/soc/codecs/dmic.c                          | 72 +++++++++++++++++++++---
>  2 files changed, 65 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
> index 54c8ef6498a8..f7bf65611453 100644
> --- a/Documentation/devicetree/bindings/sound/dmic.txt
> +++ b/Documentation/devicetree/bindings/sound/dmic.txt
> @@ -7,10 +7,12 @@ Required properties:
>  
>  Optional properties:
>  	- dmicen-gpios: GPIO specifier for dmic to control start and stop
> +	- num-channels: Number of microphones on this DAI
>  
>  Example node:
>  
>  	dmic_codec: dmic@0 {
>  		compatible = "dmic-codec";
>  		dmicen-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
> +		num-channels = <1>;
>  	};
> diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
> index b88a1ee66f80..c705a25b138e 100644
> --- a/sound/soc/codecs/dmic.c
> +++ b/sound/soc/codecs/dmic.c
> @@ -29,24 +29,29 @@
>  #include <sound/soc.h>
>  #include <sound/soc-dapm.h>
>  
> +struct dmic {
> +	struct gpio_desc *gpio_en;
> +	int channels;
> +};
> +
>  static int dmic_daiops_trigger(struct snd_pcm_substream *substream,
>  		int cmd, struct snd_soc_dai *dai)
>  {
> -	struct gpio_desc *dmic_en = snd_soc_dai_get_drvdata(dai);
> +	struct dmic *dmic = snd_soc_dai_get_drvdata(dai);
>  
> -	if (!dmic_en)
> +	if (!dmic || !dmic->gpio_en)
>  		return 0;
>  
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> -		gpiod_set_value(dmic_en, 1);
> +		gpiod_set_value(dmic->gpio_en, 1);
>  		break;
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> -		gpiod_set_value(dmic_en, 0);
> +		gpiod_set_value(dmic->gpio_en, 0);
>  		break;
>  	}
>  
> @@ -57,6 +62,42 @@ static const struct snd_soc_dai_ops dmic_dai_ops = {
>  	.trigger	= dmic_daiops_trigger,
>  };
>  
> +const struct snd_pcm_chmap_elem dmic_chmaps_single[] = {
> +	{ .channels = 1,
> +	  .map = { SNDRV_CHMAP_MONO } },
> +	{ .channels = 2,
> +	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_NA } },
> +	{ .channels = 4,
> +	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_NA,
> +		   SNDRV_CHMAP_NA, SNDRV_CHMAP_NA } },
> +	{ .channels = 6,
> +	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_NA,
> +		   SNDRV_CHMAP_NA, SNDRV_CHMAP_NA,
> +		   SNDRV_CHMAP_NA, SNDRV_CHMAP_NA } },
> +	{ .channels = 8,
> +	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_NA,
> +		   SNDRV_CHMAP_NA, SNDRV_CHMAP_NA,
> +		   SNDRV_CHMAP_NA, SNDRV_CHMAP_NA,
> +		   SNDRV_CHMAP_NA, SNDRV_CHMAP_NA } },
> +	{ }
> +};
> +
> +static int dmic_pcm_new(struct snd_soc_pcm_runtime *rtd,
> +			      struct snd_soc_dai *dai)
> +{
> +	struct dmic *dmic = snd_soc_dai_get_drvdata(dai);
> +	int err;
> +
> +	if (dmic->channels == 1) {
> +		err = snd_pcm_add_chmap_ctls(rtd->pcm, SNDRV_PCM_STREAM_CAPTURE,
> +					     dmic_chmaps_single, 8, 0, NULL);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct snd_soc_dai_driver dmic_dai = {
>  	.name = "dmic-hifi",
>  	.capture = {
> @@ -69,18 +110,31 @@ static struct snd_soc_dai_driver dmic_dai = {
>  			| SNDRV_PCM_FMTBIT_S16_LE,
>  	},
>  	.ops    = &dmic_dai_ops,
> +	.pcm_new = dmic_pcm_new,
>  };
>  
>  static int dmic_codec_probe(struct snd_soc_codec *codec)
>  {
> -	struct gpio_desc *dmic_en;
> +	struct dmic *dmic;
> +	int err;
> +	u32 pval;
> +
> +	dmic = devm_kzalloc(codec->dev, sizeof(*dmic), GFP_KERNEL);
> +	if (!dmic)
> +		return -ENOMEM;
>  
> -	dmic_en = devm_gpiod_get_optional(codec->dev,
> +	dmic->gpio_en = devm_gpiod_get_optional(codec->dev,
>  					"dmicen", GPIOD_OUT_LOW);
> -	if (IS_ERR(dmic_en))
> -		return PTR_ERR(dmic_en);
> +	if (IS_ERR(dmic->gpio_en))
> +		return PTR_ERR(dmic->gpio_en);
> +
> +	err = of_property_read_u32(codec->dev->of_node, "num-channels", &pval);
> +	if (!err)
> +		dmic->channels = (int)pval;
> +	else if (err != -ENOENT)
> +		return err;
>  
> -	snd_soc_codec_set_drvdata(codec, dmic_en);
> +	snd_soc_codec_set_drvdata(codec, dmic);
>  
>  	return 0;
>  }
