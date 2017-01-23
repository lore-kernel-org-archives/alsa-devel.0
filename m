From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v3 1/2] ASoC: cs35l35: Add support for Cirrus
 CS35L35 Amplifier
Date: Mon, 23 Jan 2017 08:02:34 -0600
Message-ID: <57f44a20-6028-4c73-b7b5-0a3d2cefcbc2@EX4.ad.cirrus.com>
References: <7566bac5-e4c4-49ff-91b3-bcd578cef21b@EX3.ad.cirrus.com> <20161221105350.GR1867@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161221105350.GR1867-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Handrigan, Paul" <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Dec 2016, Charles Keepax wrote:

> 
> Feels redundant to have this extra comment after the large comment
> before it.
I'll remove it
> 
> > +
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
> > +#include <linux/version.h>
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/slab.h>
> > +#include <linux/workqueue.h>
> 
> Do we need the workqueue header we don't seem to use any
> workqueues?
Nope
> 
> > +static int cs35l35_sdin_event(struct snd_soc_dapm_widget *w,
> > +		struct snd_kcontrol *kcontrol, int event)
> > +{
> > +	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
> > +	struct cs35l35_private *cs35l35 = snd_soc_codec_get_drvdata(codec);
> > +	int ret = 0;
> > +
> > +	switch (event) {
> > +	case SND_SOC_DAPM_PRE_PMU:
> > +		regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL1,
> > +			CS35L35_MCLK_DIS_MASK, 0 << CS35L35_MCLK_DIS_SHIFT);
> > +		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL1,
> > +			CS35L35_DISCHG_FILT_MASK, 0 << CS35L35_DISCHG_FILT_SHIFT);
> > +		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL1,
> > +			CS35L35_PDN_ALL_MASK, 0);
> > +	break;
> 
> Break should be indented for kernel coding style.
> 
> > + case SND_SOC_DAPM_POST_PMD: + regmap_update_bits(cs35l35->regmap, 
> > CS35L35_PWRCTL1, + CS35L35_PDN_ALL_MASK, 1); + 
> > regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL1, + 
> > CS35L35_DISCHG_FILT_MASK, 1 << CS35L35_DISCHG_FILT_SHIFT); + + ret = 
> > wait_for_completion_timeout(&cs35l35->pdn_done, + 
> > msecs_to_jiffies(100)); + if (ret == 0) { + dev_err(codec->dev, 
> > "TIMEOUT PDN_DONE did not complete in 100ms\n"); + ret = -ETIMEDOUT; + 
> > } + + regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL1, + 
> > CS35L35_MCLK_DIS_MASK, 1 << CS35L35_MCLK_DIS_SHIFT); + break;
> 
> Ditto.
Thanks
> > +		usleep_range(5000, 5100);
> > +		/* If PDM mode we must use VP
> > +		 * for Voltage control
> > +		 */
> 
> Does this comment need to split across multiple lines?
Nope
> > +		break;
> > +	case SND_SOC_DAIFMT_PDM:
> > +		cs35l35->pdm_mode = true;
> > +		cs35l35->i2s_mode = false;
> 
> Feels a bit redundant to have both of these if they are only ever
> a logical inversion of each other.
Certain features are only available in these modes and once TDM is added 
will make it easier to adjust settings based on mode
> 
> > +static int cs35l35_get_clk_config(int sysclk, int srate)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(cs35l35_clk_ctl); i++) {
> > +		if (cs35l35_clk_ctl[i].sysclk == sysclk &&
> > +			cs35l35_clk_ctl[i].srate == srate)
> > +			return cs35l35_clk_ctl[i].clk_cfg;
> > +	}
> > +	return -EINVAL;
> > +}
> > +
> > +static int cs35l35_pcm_hw_params(struct snd_pcm_substream *substream,
> > +				 struct snd_pcm_hw_params *params,
> > +				 struct snd_soc_dai *dai)
> > +{
> > +	struct snd_soc_codec *codec = dai->codec;
> > +	struct cs35l35_private *cs35l35 = snd_soc_codec_get_drvdata(codec);
> > +	struct classh_cfg *classh = &cs35l35->pdata.classh_algo;
> > +	int srate = params_rate(params);
> > +	int ret = 0;
> > +	u8 sp_sclks;
> > +	int audin_format;
> > +	int errata_chk;
> > +
> > +	int clk_ctl = cs35l35_get_clk_config(cs35l35->sysclk, srate);
> > +
> > +	if (clk_ctl < 0) {
> > +		dev_err(codec->dev, "Invalid CLK:Rate %d:%d\n",
> > +			cs35l35->sysclk, srate);
> > +		return -EINVAL;
> > +	}
> 
> It would normally be slightly better to set constraints in
> startup based on the SYSCLK rather than returning an error in
> hw_params. This allows user-space to negotiate a rate that is
> actually supported and do any sample rate conversion required.
> 
We talked about this and it made sense up to the point where I have to 
know the actual sample rate in order to determine if the sysclk is valid.
Also there are several clocks that are common to several sample rates so 
I'm not sure if I will be able to take advantage of this idea to the 
extent I/we would like.

> > +			};
> > +		} else {
> > +			/* Only certain ratios supported in I2S MASTER Mode */
> > +			switch (sp_sclks) {
> > +			case CS35L35_SP_SCLKS_32FS:
> > +			case CS35L35_SP_SCLKS_64FS:
> > +			break;
> > +			default:
> > +				dev_err(codec->dev, "ratio not supported\n");
> > +				return -EINVAL;
> > +			};
> > +		}
> > +		ret = regmap_update_bits(cs35l35->regmap,
> > +			CS35L35_CLK_CTL3, CS35L35_SP_SCLKS_MASK,
> > +			sp_sclks << CS35L35_SP_SCLKS_SHIFT);
> > +		if (ret != 0) {
> > +			dev_err(codec->dev, "Failed to set fsclk %d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +	if (cs35l35->pdm_mode) {
> > +		regmap_update_bits(cs35l35->regmap, CS35L35_AMP_INP_DRV_CTL,
> > +			CS35L35_PDM_MODE_MASK, 1 << CS35L35_PDM_MODE_SHIFT);
> > +	} else {
> > +		regmap_update_bits(cs35l35->regmap, CS35L35_AMP_INP_DRV_CTL,
> > +			CS35L35_PDM_MODE_MASK, 0 << CS35L35_PDM_MODE_SHIFT);
> > +	}
> 
> This if could be combined with the one above since pdm_mode ==
> !i2s_mode.

Got it thanks
> 
> > +	return ret;
> > +}
> > +
> > +
> > +static const struct snd_soc_dai_ops cs35l35_ops = {
> > +	.startup = cs35l35_pcm_startup,
> > +	.set_fmt = cs35l35_set_dai_fmt,
> > +	.hw_params = cs35l35_pcm_hw_params,
> > +	.set_sysclk = cs35l35_dai_set_sysclk,
> > +};
> > +
> > +static const struct snd_soc_dai_ops cs35l35_pdm_ops = {
> > +	.startup = cs35l35_pdm_startup,
> > +	.set_fmt = cs35l35_set_dai_fmt,
> > +	.hw_params = cs35l35_pcm_hw_params,
> 
> I would be tempted to rename the function to just
> cs35l35_hw_params if it is shared between both PCM and PDM.
> 
Done. Thanks

> > +	.set_sysclk = cs35l35_dai_set_sysclk,
Since it's only 1 stream at a time I am removing the dia_set_sysclk

> > +
> > +	if (cs35l35->pdata.bst_ipk)
> > +		regmap_update_bits(cs35l35->regmap, CS35L35_BST_PEAK_I,
> > +			CS35L35_BST_IPK_MASK,
> > +			cs35l35->pdata.bst_ipk << CS35L35_BST_IPK_SHIFT);
> 
> I believe zero is a valid value for this field, but not the
> default. Are we happy that the user can never set this value?
> 
So here I can just AND in a set high bit that way the check will show true 
even if 0. Isn't that what we thought would be the easiest?

> > +
> > +	if (cs35l35->pdata.gain_zc)
> > +		regmap_update_bits(cs35l35->regmap, CS35L35_PROTECT_CTL,
> > +			CS35L35_AMP_GAIN_ZC_MASK,
> > +			cs35l35->pdata.gain_zc << CS35L35_AMP_GAIN_ZC_SHIFT);
> > +
> > +	if (cs35l35->pdata.aud_channel)
> > +		regmap_update_bits(cs35l35->regmap,
> > +			CS35L35_AUDIN_RXLOC_CTL,
> > +			CS35L35_AUD_IN_LR_MASK,
> > +			cs35l35->pdata.aud_channel << CS35L35_AUD_IN_LR_SHIFT);
> > +
> > +	if (cs35l35->pdata.stereo) {
> > +		regmap_update_bits(cs35l35->regmap,
> > +			CS35L35_ADVIN_RXLOC_CTL, CS35L35_ADV_IN_LR_MASK,
> > +			cs35l35->pdata.adv_channel << CS35L35_ADV_IN_LR_SHIFT);
> > +		if (cs35l35->pdata.shared_bst)
> > +			regmap_update_bits(cs35l35->regmap, CS35L35_CLASS_H_CTL,
> > +				CS35L35_CH_STEREO_MASK, 1 << CS35L35_CH_STEREO_SHIFT);
> > +		ret = snd_soc_add_codec_controls(codec, cs35l35_adv_controls,
> > +					ARRAY_SIZE(cs35l35_adv_controls));
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	if (cs35l35->pdata.sp_drv_str)
> > +		regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL1,
> > +			CS35L35_SP_DRV_MASK,
> > +			cs35l35->pdata.sp_drv_str << CS35L35_SP_DRV_SHIFT);
> > +
> > +	if (classh->classh_algo_enable) {
> > +		if (classh->classh_bst_override)
> > +			regmap_update_bits(cs35l35->regmap,
> > +				CS35L35_CLASS_H_CTL, CS35L35_CH_BST_OVR_MASK,
> > +				classh->classh_bst_override << CS35L35_CH_BST_OVR_SHIFT);
> > +		if (classh->classh_bst_max_limit)
> > +			regmap_update_bits(cs35l35->regmap,
> > +				CS35L35_CLASS_H_CTL, CS35L35_CH_BST_LIM_MASK,
> > +				classh->classh_bst_max_limit << CS35L35_CH_BST_LIM_SHIFT);
> 
> This is a single bit, but the default bit is 1, so this code can
> never change the value of the field.
This one and the rest apply to previous statement correct?

> > +
> > +	/* returning NULL can be an option if in stereo mode */
> > +	cs35l35->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
> > +		"reset", GPIOD_OUT_LOW);
> > +	if (IS_ERR(cs35l35->reset_gpio))
> > +		return PTR_ERR(cs35l35->reset_gpio);
> 
> This should be a goto err;
>
OK 
> > +
> > +	if (cs35l35->reset_gpio)
> > +		gpiod_set_value_cansleep(cs35l35->reset_gpio, 1);
> 
> gpiod_set_value_can_sleep does an internal NULL check on the GPIO
> desc I would be tempted to just rely on that one.
> 
That works for me
> > +
> > +	init_completion(&cs35l35->pdn_done);
> > +
> > +	ret = regmap_register_patch(cs35l35->regmap, cs35l35_errata_patch,
> > +				    ARRAY_SIZE(cs35l35_errata_patch));
> > +	if (ret < 0) {
> > +		dev_err(&i2c_client->dev, "Failed to apply errata patch\n");
> > +		return ret;
> 
> This should be a goto err;
> 
OK

> clientdata was allocated with devm this kfree will cause a double
> free.
got it thanks
> 
> > +	return 0;
> > +}
> 
> Thanks,
> Charles
> 
Thanks,
Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
