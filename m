From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC] ASoC: codecs: msm8916-wcd-analog: use btn0 released
 detection
Date: Thu, 28 Sep 2017 11:18:26 -0700
Message-ID: <8bc3ca17-ea40-bedf-0d2f-8f08b66b6f6e@linaro.org>
References: <20170913204355.26186-1-damien.riegel@savoirfairelinux.com>
 <3485d646-12fd-4435-1bae-87af9a1a857e@linaro.org>
 <20170919121147.wtpebx6p377cctvc@sirena.co.uk>
 <20170919132237.ctjcpe27pmwu36mm@workotop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170919132237.ctjcpe27pmwu36mm@workotop.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org



On 19/09/17 06:22, Damien Riegel wrote:
> Definitely. I also noticed an issue with the first very detection
> because the micbias will only be set the first time the driver gets a
> mechanical insertion interrupt. Following snippet seems to solve the
> problem:
Does that mean that you do not need the "ASoC: codecs: 
msm8916-wcd-analog: use btn0 released detection" patch anymore?

Below changes seems to fine as it is.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


> diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
> index f562f2d86907..5045dabd9ea9 100644
> --- a/sound/soc/codecs/msm8916-wcd-analog.c
> +++ b/sound/soc/codecs/msm8916-wcd-analog.c
> @@ -446,6 +446,7 @@ static int pm8916_wcd_analog_enable_micbias_int1(struct
>   static void pm8916_wcd_setup_mbhc(struct pm8916_wcd_analog_priv *wcd)
>   {
>          struct snd_soc_codec *codec = wcd->codec;
> +       bool micbias_enabled = false;
>          u32 plug_type = 0;
>          u32 int_en_mask;
> 
> @@ -477,6 +478,11 @@ static void pm8916_wcd_setup_mbhc(struct pm8916_wcd_analog_priv *wcd)
>                              DIG_CLK_CTL_D_MBHC_CLK_EN_MASK,
>                              DIG_CLK_CTL_D_MBHC_CLK_EN);
> 
> +       if (snd_soc_read(codec, CDC_A_MICB_2_EN) & CDC_A_MICB_2_EN_ENABLE)
> +               micbias_enabled = true;
> +
> +       pm8916_mbhc_configure_bias(priv, micbias_enabled);
> +
>          int_en_mask = MBHC_SWITCH_INT;
>          if (wcd->mbhc_btn_enabled)
>                  int_en_mask |= MBHC_BUTTON_PRESS_DET | MBHC_BUTTON_RELEASE_DET;
> 
