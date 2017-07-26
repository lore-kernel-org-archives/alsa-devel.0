From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: Re: [PATCH v1 2/3] ASoC: codecs: msm8916-analog: support jack
 detection
Date: Wed, 26 Jul 2017 15:44:09 -0400
Message-ID: <20170726194409.fbnctbsjwfejimiu@workotop.localdomain>
References: <20170725175126.26578-1-damien.riegel@savoirfairelinux.com>
 <20170725175126.26578-3-damien.riegel@savoirfairelinux.com>
 <0b426298-9814-1a29-9a88-6cd972ea1ad0@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0b426298-9814-1a29-9a88-6cd972ea1ad0@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, kernel@savoirfairelinux.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 26, 2017 at 05:44:14PM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 25/07/17 18:51, Damien Riegel wrote:
> > The audio codec in the PM8916 has a feature called Multi-Button Headset
> > Control (MBHC). It can support of up to five buttons on a headset, and
> > jack insertion/removal detection.
> > 
> > This patch only supports the jack detection. A complete implementation
> > is available in the Android kernel [1] for reference.
> > 
> > [1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/sound/soc/codecs/wcd-mbhc-v2.c?h=LA.BR.1.2.4-00310-8x16.0
> > 
> > Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> 
> If you have noticed it or not, but in the dai_shutdown patch the codec is
> put in reset state, so this code only works for one time.
> Once you do a playback session and end it this code will stop working.

Right, I haven't tested that workflow, thanks.

> 
> 
> > ---
> >   sound/soc/codecs/msm8916-wcd-analog.c | 103 ++++++++++++++++++++++++++++++++++
> >   sound/soc/codecs/msm8916-wcd-analog.h |  18 ++++++
> >   2 files changed, 121 insertions(+)
> >   create mode 100644 sound/soc/codecs/msm8916-wcd-analog.h
> > 
> > diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
> > 
> ...
> > +
> > +
> > +/**
> > + * pm8916_wcd_analog_jack_detect - Enable jack detection.
> > + *
> > + * @codec:         msm8916 codec
> > + * @jack:          jack to report detection events on
> > + *
> > + * Enables jack detection of the pm8916-analog. It is capable of reporting
> > + * mechanical insertion.
> > + */
> > +int pm8916_wcd_analog_jack_detect(struct snd_soc_codec *codec,
> > +				  struct snd_soc_jack *jack)
> > +{
> > +	struct pm8916_wcd_analog_priv *priv = snd_soc_codec_get_drvdata(codec);
> > +
> > +	priv->jack = jack;
> > +
> > +	snd_soc_update_bits(codec, CDC_D_CDC_RST_CTL,
> > +			    RST_CTL_DIG_SW_RST_N_MASK,
> > +			    RST_CTL_DIG_SW_RST_N_REMOVE_RESET);
> Why do you need this?
> 
> > +	snd_soc_write(codec, CDC_A_MBHC_DET_CTL_1, 0xB5);
> 
> > +	snd_soc_write(codec, CDC_A_MBHC_DET_CTL_2, 0xE1);
> 
> > +	snd_soc_write(codec, CDC_A_MBHC_DBNC_TIMER, 0x98);
> What do these values mean?

Right, define would definitely be better.

> > +	snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
> > +			    DIG_CLK_CTL_MBHC_EN_MASK,
> > +			    DIG_CLK_CTL_MBHC_EN);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(pm8916_wcd_analog_jack_detect);
> > +
> >   static const struct snd_soc_dapm_route pm8916_wcd_analog_audio_map[] = {
> >   	{"PDM_RX1", NULL, "PDM Playback"},
> > @@ -799,6 +873,14 @@ static struct snd_soc_codec_driver pm8916_wcd_analog = {
> >   	},
> >   };
> > +static struct jack_detect_irq {
> > +	const char *name;
> > +	irqreturn_t (*handler)(int, void *);
> > +} jack_detect_irqs[] = {
> > +	{ "mbhc_switch_int", pm8916_wcd_analog_mbhc_switch_handler },
> > +	/* other MBHC related interrupts are not handled yet */
> > +};
> > +
> >   static int pm8916_wcd_analog_parse_dt(struct device *dev,
> >   				       struct pm8916_wcd_analog_priv *priv)
> >   {
> > @@ -846,6 +928,27 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
> >   		return ret;
> >   	}
> > +	for (i = 0; i < ARRAY_SIZE(jack_detect_irqs); i++) {
> > +		int irq;
> > +
> > +		irq = platform_get_irq_byname(pdev, jack_detect_irqs[i].name);
> > +		if (irq < 0) {
> > +			dev_warn(dev, "failed to get irq '%s', jack insertion detection disabled\n",
> > +				 jack_detect_irqs[i].name);
> > +			break;
> > +		}
> > +
> > +		ret = devm_request_threaded_irq(dev, irq, NULL,
> > +						jack_detect_irqs[i].handler,
> > +						IRQF_ONESHOT,
> > +						jack_detect_irqs[i].name, priv);
> > +		if (ret) {
> > +			dev_err(dev, "failed to request irq '%s': %d\n",
> > +				jack_detect_irqs[i].name, ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> Not sure how it would work, Where are these interrupts enabled in the pmic?

Not sure I understand the question as this is very similar to what you
did in your patches. Anyway, as you sent a version that is more feature
complete than mine, I don't think there is much value in reviewing my
series of patches.


Regards,
-- 
Damien
