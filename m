From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: wm8731: initialize the hardware when
 loading the codec driver; use regmap for I/O
Date: Mon, 01 Jun 2015 11:03:09 +0200
Message-ID: <556C1FCD.1070905@metafoo.de>
References: <20150530003455.4c4d67eb444b1ceb45d3148c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-059.synserver.de (smtp-out-059.synserver.de
 [212.40.185.59])
 by alsa0.perex.cz (Postfix) with ESMTP id BB99B260420
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 11:03:11 +0200 (CEST)
In-Reply-To: <20150530003455.4c4d67eb444b1ceb45d3148c@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergey Kiselev <sergey.kiselev@intel.com>, alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, Girdwood@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam@alsa-project.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 05/30/2015 09:34 AM, Sergey Kiselev wrote:
> Hi,
>
> This patch moves the request supplies and hardware reset and initialization
> from wm8731_probe to wm8731_i2c_probe and wm8731_spi_probe. So that the
> codec hardware is initialized when loading the codec driver, and not when
> loading the machine driver.
> The I/O is converted to regmap_write and regmap_update_bits. (Mostly as a side
> effect, since snd_soc_write and friends won't work before snd_soc_register_codec
> is called)
>
> Signed-off-by: Sergey Kiselev <sergey.kiselev@intel.com>

Hi,

It looks like the patch has been made against an older tree. It will not 
apply on-top of ASoC for-next branch.

> ---
[...]
>   static const char *wm8731_input_select[] = {"Line In", "Mic"};
>
> @@ -118,7 +118,7 @@ static int wm8731_set_deemph(struct snd_soc_codec *codec)
>   	dev_dbg(codec->dev, "Set deemphasis %d (%dHz)\n",
>   		best, wm8731_deemph[best]);
>
> -	return snd_soc_update_bits(codec, WM8731_APDIGI, 0x6, val);
> +	return regmap_update_bits(wm8731->regmap, WM8731_APDIGI, 0x6, val);

There is no need to replace all the snd_soc_${io}() calls with 
regmap_${io}(). The snd_soc methods will just call the corresponding regmap 
method internally. But if you really want to do it this should be done in a 
separate patch.

>   }
>
[...]
> @@ -573,42 +571,53 @@ static struct snd_soc_dai_driver wm8731_dai = {
>
>   static int wm8731_probe(struct snd_soc_codec *codec)
>   {
> -	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
> -	int ret = 0, i;
> +	wm8731_set_bias_level(codec, SND_SOC_BIAS_STANDBY);

This is not necessary, the core will put the CODEC into BIAS_STANDBY mode, 
after the probe callback has been called. So the whole probe function can be 
dropped.

> +
> +	return 0;
> +}
[...]
>   static int wm8731_remove(struct snd_soc_codec *codec)
>   {
> -	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
> -
> -	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
> +	wm8731_set_bias_level(codec, SND_SOC_BIAS_OFF);

Same here, the core already puts the CODEC into BIAS_OFF mode before the 
remove callback is called.

>
>   	return 0;
>   }
