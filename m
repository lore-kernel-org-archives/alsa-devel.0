From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCHv3 7/9] WM8971 improves the function of
	regmap
Date: Wed, 03 Sep 2014 21:19:22 +0200
Message-ID: <540769BA.8010606@metafoo.de>
References: <1409628470-13059-1-git-send-email-xavier.hsu@linaro.org>
 <1409628470-13059-7-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-246.synserver.de (smtp-out-246.synserver.de
 [212.40.185.246])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E9FB265677
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 21:19:24 +0200 (CEST)
In-Reply-To: <1409628470-13059-7-git-send-email-xavier.hsu@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xavier Hsu <xavier.hsu@linaro.org>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, patches@linaro.org
Cc: Andy Green <andy.green@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 09/02/2014 05:27 AM, Xavier Hsu wrote:
> This patch improves WM8971.
> We modify the function of regmap.
>
> Any comments about improving the patch are welcome.
> Thanks.
>
> Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> ---
>   sound/soc/codecs/wm8971.c |   26 +++++++++++++++++++++-----
>   1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
> index 68b4f52..95e7c39 100755
> --- a/sound/soc/codecs/wm8971.c
> +++ b/sound/soc/codecs/wm8971.c
> @@ -38,6 +38,7 @@
>
>   /* codec private data */
>   struct wm8971_priv {
> +	struct regmap *regmap;
>   	unsigned int sysclk;
>   	struct snd_pcm_hw_constraint_list *sysclk_constraints;
>   	int playback_fs;
> @@ -716,6 +717,7 @@ static int wm8971_mute(struct snd_soc_dai *dai, int mute)
>   static int wm8971_set_bias_level(struct snd_soc_codec *codec,
>   				 enum snd_soc_bias_level level)
>   {
> +	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
>   	u16 pwr_reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
>
>   	switch (level) {
> @@ -727,7 +729,7 @@ static int wm8971_set_bias_level(struct snd_soc_codec *codec,
>   		break;
>   	case SND_SOC_BIAS_STANDBY:
>   		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
> -			snd_soc_cache_sync(codec);
> +			regcache_sync(wm8971->regmap);

This is a bugfix and it should be noted in the commit message, what is 
broken, why it is broken and since when it has been broken.

>
>   		/* mute dac and set vmid to 500k, enable VREF */
>   		snd_soc_write(codec, WM8971_PWR1, pwr_reg | 0x0140);
> @@ -774,7 +776,11 @@ static struct snd_soc_dai_driver wm8971_dai = {
>
>   static int wm8971_suspend(struct snd_soc_codec *codec)
>   {
> +	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
> +
>   	wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +	regcache_mark_dirty(wm8971->regmap);

The core already marks the regcache dirty after calling the suspend 
callback, no need to do this from hand.

> +
>   	return 0;
>   }
>
> @@ -797,9 +803,12 @@ static int wm8971_resume(struct snd_soc_codec *codec)
>
>   static int wm8971_probe(struct snd_soc_codec *codec)
>   {
> +	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
>   	int ret = 0;
>   	u16 reg;
>
> +	codec->control_data = wm8971->regmap;
> +
>   	wm8971_reset(codec);
>
>   	/* charge output caps - set vmid to 5k for quick power up */
> @@ -830,12 +839,20 @@ static int wm8971_remove(struct snd_soc_codec *codec)
>   	return 0;
>   }
>
> +struct regmap *wm8971_get_regmap(struct device *dev)
> +{
> +	struct wm8971_priv *priv = dev_get_drvdata(dev);
> +
> +	return priv->regmap;
> +}

This is unnecessary, since the regmap has been registered with the device of 
the CODEC the core is able to figure out the correct regmap itself.

[...]
