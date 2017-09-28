From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC] ASoC: codecs: msm8916-wcd-analog: use btn0 released
 detection
Date: Thu, 28 Sep 2017 12:56:52 -0700
Message-ID: <061955ae-7216-238c-52d4-4b1f83cdeab1@linaro.org>
References: <20170913204355.26186-1-damien.riegel@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170913204355.26186-1-damien.riegel@savoirfairelinux.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org



On 13/09/17 13:43, Damien Riegel wrote:
> msm8916-wcd-analog uses button0 to differentiate between headphone and
> headset. Under some circumstances, button pressed and released
> interrupts are not fired as the driver expects it.
> 
> For instance, with some connectors, there are spurious button-pressed
> interrupts when unplugging a headphone, without the corresponding
> button-released interrupt. But the codec always alternates between
> button pressed and released interrupts, it cannot fire two interrupts of
> the same kind in a row. That means that when the headphone is plugged
> back, only a button-released interrupt will be fired instead of pressed
> then released. This causes the driver to report headphone as headset.
> 
> By changing the logic and relying on button 0 release interrupt, the
> driver could be made more robust for connectors that differ from the one
> used on the Dragonboard's audio mezzanine.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>


Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---


>   sound/soc/codecs/msm8916-wcd-analog.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
> index 549c269acc7d..f562f2d86907 100644
> --- a/sound/soc/codecs/msm8916-wcd-analog.c
> +++ b/sound/soc/codecs/msm8916-wcd-analog.c
> @@ -285,7 +285,7 @@ struct pm8916_wcd_analog_priv {
>   	u16 codec_version;
>   	bool	mbhc_btn_enabled;
>   	/* special event to detect accessory type */
> -	bool	mbhc_btn0_pressed;
> +	int	mbhc_btn0_released;
>   	bool	detect_accessory_type;
>   	struct clk *mclk;
>   	struct snd_soc_codec *codec;
> @@ -483,7 +483,7 @@ static void pm8916_wcd_setup_mbhc(struct pm8916_wcd_analog_priv *wcd)
>   
>   	snd_soc_update_bits(codec, CDC_D_INT_EN_CLR, int_en_mask, 0);
>   	snd_soc_update_bits(codec, CDC_D_INT_EN_SET, int_en_mask, int_en_mask);
> -	wcd->mbhc_btn0_pressed = false;
> +	wcd->mbhc_btn0_released = false;
>   	wcd->detect_accessory_type = true;
>   }
>   
> @@ -950,7 +950,7 @@ static irqreturn_t mbhc_btn_release_irq_handler(int irq, void *arg)
>   
>   		/* check if its BTN0 thats released */
>   		if ((val != -1) && !(val & CDC_A_MBHC_RESULT_1_BTN_RESULT_MASK))
> -			priv->mbhc_btn0_pressed = false;
> +			priv->mbhc_btn0_released = true;
>   
>   	} else {
>   		snd_soc_jack_report(priv->jack, 0, btn_mask);
> @@ -983,9 +983,7 @@ static irqreturn_t mbhc_btn_press_irq_handler(int irq, void *arg)
>   		break;
>   	case 0x0:
>   		/* handle BTN_0 specially for type detection */
> -		if (priv->detect_accessory_type)
> -			priv->mbhc_btn0_pressed = true;
> -		else
> +		if (!priv->detect_accessory_type)
>   			snd_soc_jack_report(priv->jack,
>   					    SND_JACK_BTN_0, btn_mask);
>   		break;
> @@ -1029,19 +1027,19 @@ static irqreturn_t pm8916_mbhc_switch_irq_handler(int irq, void *arg)
>   		 * both press and release event received then its
>   		 * a headset.
>   		 */
> -		if (priv->mbhc_btn0_pressed)
> +		if (priv->mbhc_btn0_released)
>   			snd_soc_jack_report(priv->jack,
> -					    SND_JACK_HEADPHONE, hs_jack_mask);
> +					    SND_JACK_HEADSET, hs_jack_mask);
>   		else
>   			snd_soc_jack_report(priv->jack,
> -					    SND_JACK_HEADSET, hs_jack_mask);
> +					    SND_JACK_HEADPHONE, hs_jack_mask);
>   
>   		priv->detect_accessory_type = false;
>   
>   	} else { /* removal */
>   		snd_soc_jack_report(priv->jack, 0, hs_jack_mask);
>   		priv->detect_accessory_type = true;
> -		priv->mbhc_btn0_pressed = false;
> +		priv->mbhc_btn0_released = false;
>   	}
>   
>   	return IRQ_HANDLED;
> 
