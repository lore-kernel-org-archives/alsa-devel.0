From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/2] ASoC: wm8985: add support for WM8758
Date: Fri, 20 May 2016 17:11:43 +0100
Message-ID: <20160520161143.GQ1646@localhost.localdomain>
References: <1463489334-17549-1-git-send-email-petr@barix.com>
 <1463489334-17549-3-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 7856E267920
 for <alsa-devel@alsa-project.org>; Fri, 20 May 2016 18:11:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1463489334-17549-3-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>
Cc: plamen@barix.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 17, 2016 at 02:48:54PM +0200, Petr Kulhavy wrote:
> The WM8758 chip is almost identical to WM8985 with the difference that it
> doesn't feature the AUX input. This patch adds the WM8758 support into the
> WM8985 driver.
> 
> The chip selection is done by the I2C name. The SPI probe supports only
> the WM8985.
> 
> Signed-off-by: Petr Kulhavy <petr@barix.com>
> ---
> +
> +static int wm8985_add_widgets(struct snd_soc_codec *codec)
> +{
> +	struct wm8985_priv *wm8985 = snd_soc_codec_get_drvdata(codec);
> +	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
> +
> +	snd_soc_dapm_new_controls(dapm, wm8985_common_dapm_widgets,
> +		ARRAY_SIZE(wm8985_common_dapm_widgets));
> +	snd_soc_dapm_add_routes(dapm, wm8985_common_dapm_routes,
> +		ARRAY_SIZE(wm8985_common_dapm_routes));
> +
> +	switch (wm8985->dev_type) {
> +	case WM8758:
> +		snd_soc_add_codec_controls(codec, wm8985_alc_snd_controls,
> +			ARRAY_SIZE(wm8985_alc_snd_controls));
> +		snd_soc_add_codec_controls(codec, wm8985_adc_snd_controls,
> +			ARRAY_SIZE(wm8985_adc_snd_controls));
> +		snd_soc_add_codec_controls(codec, wm8985_dac_snd_controls,
> +			ARRAY_SIZE(wm8985_dac_snd_controls));
> +		snd_soc_add_codec_controls(codec, wm8985_eq_snd_controls,
> +			ARRAY_SIZE(wm8985_eq_snd_controls));
> +		snd_soc_add_codec_controls(codec, wm8985_3d_snd_controls,
> +			ARRAY_SIZE(wm8985_3d_snd_controls));

Why not just put all these in a common controls array? They seem
to all be used on 8985 as well.

> +
> +		snd_soc_dapm_new_controls(dapm, wm8758_dapm_widgets,
> +					  ARRAY_SIZE(wm8758_dapm_widgets));
> +		break;
> +
> +	case WM8985:
> +		snd_soc_add_codec_controls(codec, wm8985_alc_snd_controls,
> +			ARRAY_SIZE(wm8985_alc_snd_controls));
> +		snd_soc_add_codec_controls(codec, wm8985_adc_snd_controls,
> +			ARRAY_SIZE(wm8985_adc_snd_controls));
> +		snd_soc_add_codec_controls(codec, wm8985_dac_snd_controls,
> +			ARRAY_SIZE(wm8985_dac_snd_controls));
> +		snd_soc_add_codec_controls(codec, wm8985_aux_snd_controls,
> +			ARRAY_SIZE(wm8985_aux_snd_controls));
> +		snd_soc_add_codec_controls(codec, wm8985_eq_snd_controls,
> +			ARRAY_SIZE(wm8985_eq_snd_controls));
> +		snd_soc_add_codec_controls(codec, wm8985_3d_snd_controls,
> +			ARRAY_SIZE(wm8985_3d_snd_controls));

> +		snd_soc_add_codec_controls(codec, wm8985_spkr_snd_controls,
> +			ARRAY_SIZE(wm8985_spkr_snd_controls));

And why not put aux and spkr in a wm8985 array? Then you only
need two arrays.

> +
> +		snd_soc_dapm_new_controls(dapm, wm8985_dapm_widgets,
> +			ARRAY_SIZE(wm8985_dapm_widgets));
> +		snd_soc_dapm_add_routes(dapm, wm8985_aux_dapm_routes,
> +			ARRAY_SIZE(wm8985_aux_dapm_routes));
> +		break;
> +	}
> +
> +	return 0;
> +}
>  
>  static int eqmode_get(struct snd_kcontrol *kcontrol,
>  		      struct snd_ctl_elem_value *ucontrol)
> @@ -1005,6 +1120,8 @@ static int wm8985_probe(struct snd_soc_codec *codec)
>  	snd_soc_update_bits(codec, WM8985_BIAS_CTRL, WM8985_BIASCUT,
>  			    WM8985_BIASCUT);
>  
> +	wm8985_add_widgets(codec);
> +
>  	return 0;
>  
>  err_reg_enable:
> @@ -1047,13 +1164,6 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8985 = {
>  	.probe = wm8985_probe,
>  	.set_bias_level = wm8985_set_bias_level,
>  	.suspend_bias_off = true,
> -
> -	.controls = wm8985_snd_controls,
> -	.num_controls = ARRAY_SIZE(wm8985_snd_controls),
> -	.dapm_widgets = wm8985_dapm_widgets,
> -	.num_dapm_widgets = ARRAY_SIZE(wm8985_dapm_widgets),
> -	.dapm_routes = wm8985_dapm_routes,
> -	.num_dapm_routes = ARRAY_SIZE(wm8985_dapm_routes),

I think you should still be able to use these for the common
functionality.

Thanks,
Charles
