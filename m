From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv5 2/9] ASOC: wm8971: modify the control of
	deemphasis
Date: Wed, 29 Oct 2014 09:46:39 +0000
Message-ID: <20141029094638.GH23178@opensource.wolfsonmicro.com>
References: <1414130435-14183-1-git-send-email-xavier.hsu@linaro.org>
 <1414130435-14183-2-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8825B2604CE
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 10:46:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1414130435-14183-2-git-send-email-xavier.hsu@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xavier Hsu <xavier.hsu@linaro.org>
Cc: Andy Green <andy.green@linaro.org>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lars@metafoo.de, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 24, 2014 at 02:00:28PM +0800, Xavier Hsu wrote:
> We add a switch for automatic updating
> the frequency of wm8971.
> 
> Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> ---
>  sound/soc/codecs/wm8971.c |   77 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 75 insertions(+), 2 deletions(-)
>  mode change 100644 => 100755 sound/soc/codecs/wm8971.c
> 
> diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
> old mode 100644
> new mode 100755
> index 01c76a4..6df0a3b
> --- a/sound/soc/codecs/wm8971.c
> +++ b/sound/soc/codecs/wm8971.c
> @@ -7,6 +7,10 @@
>   *
>   * Based on wm8753.c by Liam Girdwood
>   *
> + * WM8971 Improve Copyright (C) 2014 Linaro, Ltd
> + * Author: Xavier Hsu <xavier.hsu@linaro.org>
> + *         Andy Green <andy.green@linaro.org>
> + *
>   *  This program is free software; you can redistribute  it and/or modify it
>   *  under  the terms of  the GNU General  Public License as published by the
>   *  Free Software Foundation;  either version 2 of the  License, or (at your
> @@ -36,6 +40,11 @@ static struct workqueue_struct *wm8971_workq;
>  /* codec private data */
>  struct wm8971_priv {
>  	unsigned int sysclk;
> +
> +	/* De-emphasis */
> +	struct mutex deemph_mutex;
> +	int playback_fs;
> +	bool deemph;
>  };
>  
>  /*
> @@ -100,7 +109,6 @@ static const char const *wm8971_alc_func[] = {"Off", "Right",
>  					      "Left", "Stereo"};
>  static const char const *wm8971_ng_type[] = {"Constant PGA Gain",
>  					     "Mute ADC Output"};
> -static const char const *wm8971_deemp[] = {"None", "32kHz", "44.1kHz", "48kHz"};
>  static const char const *wm8971_mono_mux[] = {"Stereo", "Mono (Left)",
>  					      "Mono (Right)", "Digital Mono"};
>  static const char const *wm8971_dac_phase[] = {"Non Inverted", "Inverted"};
> @@ -114,6 +122,66 @@ static const char const *wm8971_rpga_sel[] = {"Line", "Mic", "NC",
>  					      "Differential"};
>  static const char const *wm8971_adcpol[] = {"Normal", "L Invert",
>  					    "R Invert", "L + R Invert"};
> +static const char const *wm8971_deemp[] = {"None", "32kHz",
> +					   "44.1kHz", "48kHz"};
> +
> +static int wm8971_set_deemph(struct snd_soc_codec *codec)
> +{
> +	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
> +	int val = 0, i, best = 0;
> +
> +	/* If we're using deemphasis select the nearest available sample
> +	 * rate.
> +	*/
> +	if (wm8971->deemph) {
> +		best = 1;
> +		for (i = 2; i < ARRAY_SIZE(wm8971_deemp); i++) {
> +			if (abs(wm8971_deemp[i] - wm8971->playback_fs) <
> +			    abs(wm8971_deemp[best] - wm8971->playback_fs))

I am not quite clear on how this is working, we seem to be
subtracting an int (playback_fs) from a char * (wm8971_deemp[i])?
Also playback_fs is never set anywhere in the driver so will
always be zero? Has this patch been tested?

> +				best = i;
> +		}
> +		val = best << 1;
> +	}
> +
> +	dev_dbg(codec->dev, "Set deemphasis %d (%dHz)\n",
> +		best, wm8971_deemp[best]);
> +
> +	return snd_soc_update_bits(codec, WM8971_ADCDAC, 0x6, val);
> +}
> +
> +static int wm8971_get_deemph(struct snd_kcontrol *kcontrol,
> +			     struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
> +	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
> +
> +	ucontrol->value.enumerated.item[0] = wm8971->deemph;
> +
> +	return 0;
> +}
> +
> +static int wm8971_put_deemph(struct snd_kcontrol *kcontrol,
> +			     struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
> +	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
> +	int deemph = ucontrol->value.enumerated.item[0];
> +	int ret = 0;
> +
> +	if (deemph > 1)
> +		return -EINVAL;
> +
> +	mutex_lock(&wm8971->deemph_mutex);
> +	if (wm8971->deemph != deemph) {
> +		wm8971->deemph = deemph;
> +		wm8971_set_deemph(codec);
> +
> +		ret = 1;
> +	}
> +	mutex_unlock(&wm8971->deemph_mutex);
> +
> +	return ret;
> +}
>  
>  static const struct soc_enum wm8971_enum[] = {
>  	SOC_ENUM_SINGLE(WM8971_BASS, 7, 2, wm8971_bass),	/* 0 */
> @@ -184,7 +252,8 @@ static const struct snd_kcontrol_new wm8971_snd_controls[] = {
>  	SOC_SINGLE("Capture 6dB Attenuate", WM8971_ADCDAC, 8, 1, 0),
>  	SOC_SINGLE("Playback 6dB Attenuate", WM8971_ADCDAC, 7, 1, 0),
>  
> -	SOC_ENUM("Playback De-emphasis", wm8971_enum[5]),

You are removing the only user of wm8971_enum[5], probably should
remove that entry in the array as well. Ah I see you then remove
it in patch 2 perhaps reorder those two patches and explicitly
remove it in this patch, would be more clear.

> +	SOC_SINGLE_BOOL_EXT("Playback De-emphasis Switch", 0,
> +			    wm8971_get_deemph, wm8971_put_deemph),
>  	SOC_ENUM("Playback Function", wm8971_enum[6]),
>  	SOC_ENUM("Playback Phase", wm8971_enum[7]),
>  
> @@ -534,6 +603,8 @@ static int wm8971_pcm_hw_params(struct snd_pcm_substream *substream,
>  		break;
>  	}
>  
> +	wm8971_set_deemph(codec);
> +
>  	/* set iface & srate */
>  	snd_soc_write(codec, WM8971_IFACE, iface);
>  	if (coeff >= 0)
> @@ -727,6 +798,8 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
>  	if (wm8971 == NULL)
>  		return -ENOMEM;
>  
> +	mutex_init(&wm8971->deemph_mutex);
> +
>  	regmap = devm_regmap_init_i2c(i2c, &wm8971_regmap);
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
> -- 
> 1.7.9.5
> 

Also I tried to apply this against the current ASoC for next and
it fails to apply. Is this generated against the right tree?

Thanks,
Charles
