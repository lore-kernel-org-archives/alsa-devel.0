From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v3 1/2] ASoC: cs35l35: Add support for
 Cirrus CS35L35 Amplifier
Date: Wed, 21 Dec 2016 10:53:50 +0000
Message-ID: <20161221105350.GR1867@localhost.localdomain>
References: <7566bac5-e4c4-49ff-91b3-bcd578cef21b@EX3.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7566bac5-e4c4-49ff-91b3-bcd578cef21b-XU/xxMRwCJnfk+Ne4bZl5AC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 13, 2016 at 10:59:03AM -0600, Li Xu wrote:
> Add driver support for Cirrus Logic CS35L35 boosted
> speaker amplifier
> 
> Signed-off-by: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
> ---

Mostly just some minor comments.

> +struct classh_cfg {
> +	/*
> +	 * Class H Algorithm Control Variables
> +	 * You can either have it done
> +	 * automatically or you can adjust
> +	 * these variables for tuning
> +	 *
> +	 * if you do not enable the internal algorithm
> +	 * you will get a set of mixer controls for
> +	 * Class H tuning
> +	 *
> +	 * Section 4.3 of the datasheet
> +	 */
> +	/* Internal ClassH Algorithm  */

Feels redundant to have this extra comment after the large comment
before it.

> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/version.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>

Do we need the workqueue header we don't seem to use any
workqueues?

> +static int cs35l35_sdin_event(struct snd_soc_dapm_widget *w,
> +		struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
> +	struct cs35l35_private *cs35l35 = snd_soc_codec_get_drvdata(codec);
> +	int ret = 0;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL1,
> +			CS35L35_MCLK_DIS_MASK, 0 << CS35L35_MCLK_DIS_SHIFT);
> +		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL1,
> +			CS35L35_DISCHG_FILT_MASK, 0 << CS35L35_DISCHG_FILT_SHIFT);
> +		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL1,
> +			CS35L35_PDN_ALL_MASK, 0);
> +	break;

Break should be indented for kernel coding style.

> +	case SND_SOC_DAPM_POST_PMD:
> +		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL1,
> +			CS35L35_PDN_ALL_MASK, 1);
> +		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL1,
> +			CS35L35_DISCHG_FILT_MASK, 1 << CS35L35_DISCHG_FILT_SHIFT);
> +
> +		ret = wait_for_completion_timeout(&cs35l35->pdn_done,
> +							msecs_to_jiffies(100));
> +		if (ret == 0) {
> +			dev_err(codec->dev, "TIMEOUT PDN_DONE did not complete in 100ms\n");
> +			ret = -ETIMEDOUT;
> +		}
> +
> +		regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL1,
> +			CS35L35_MCLK_DIS_MASK, 1 << CS35L35_MCLK_DIS_SHIFT);
> +	break;

Ditto.

> +	default:
> +		dev_err(codec->dev, "Invalid event = 0x%x\n", event);
> +		ret = -EINVAL;
> +	}
> +	return ret;
> +}
> +
> +static int cs35l35_main_amp_event(struct snd_soc_dapm_widget *w,
> +		struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
> +	struct cs35l35_private *cs35l35 = snd_soc_codec_get_drvdata(codec);
> +	unsigned int reg[4];
> +	int i;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		if (cs35l35->pdata.bst_pdn_fet_on)
> +			regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL2,
> +				CS35L35_PDN_BST_MASK, 0 << CS35L35_PDN_BST_FETON_SHIFT);
> +		else
> +			regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL2,
> +				CS35L35_PDN_BST_MASK, 0 << CS35L35_PDN_BST_FETOFF_SHIFT);
> +			regmap_update_bits(cs35l35->regmap, CS35L35_PROTECT_CTL,
> +				CS35L35_AMP_MUTE_MASK, 0 << CS35L35_AMP_MUTE_SHIFT);
> +		break;
> +	case SND_SOC_DAPM_POST_PMU:
> +		usleep_range(5000, 5100);
> +		/* If PDM mode we must use VP
> +		 * for Voltage control
> +		 */

Does this comment need to split across multiple lines?

> +static int cs35l35_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct cs35l35_private *cs35l35 = snd_soc_codec_get_drvdata(codec);
> +
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL1,
> +				    CS35L35_MS_MASK, 1 << CS35L35_MS_SHIFT);
> +		cs35l35->slave_mode = false;
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL1,
> +				    CS35L35_MS_MASK, 0 << CS35L35_MS_SHIFT);
> +		cs35l35->slave_mode = true;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		cs35l35->i2s_mode = true;
> +		cs35l35->pdm_mode = false;
> +		break;
> +	case SND_SOC_DAIFMT_PDM:
> +		cs35l35->pdm_mode = true;
> +		cs35l35->i2s_mode = false;

Feels a bit redundant to have both of these if they are only ever
a logical inversion of each other.

> +static int cs35l35_get_clk_config(int sysclk, int srate)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(cs35l35_clk_ctl); i++) {
> +		if (cs35l35_clk_ctl[i].sysclk == sysclk &&
> +			cs35l35_clk_ctl[i].srate == srate)
> +			return cs35l35_clk_ctl[i].clk_cfg;
> +	}
> +	return -EINVAL;
> +}
> +
> +static int cs35l35_pcm_hw_params(struct snd_pcm_substream *substream,
> +				 struct snd_pcm_hw_params *params,
> +				 struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct cs35l35_private *cs35l35 = snd_soc_codec_get_drvdata(codec);
> +	struct classh_cfg *classh = &cs35l35->pdata.classh_algo;
> +	int srate = params_rate(params);
> +	int ret = 0;
> +	u8 sp_sclks;
> +	int audin_format;
> +	int errata_chk;
> +
> +	int clk_ctl = cs35l35_get_clk_config(cs35l35->sysclk, srate);
> +
> +	if (clk_ctl < 0) {
> +		dev_err(codec->dev, "Invalid CLK:Rate %d:%d\n",
> +			cs35l35->sysclk, srate);
> +		return -EINVAL;
> +	}

It would normally be slightly better to set constraints in
startup based on the SYSCLK rather than returning an error in
hw_params. This allows user-space to negotiate a rate that is
actually supported and do any sample rate conversion required.

> +
> +	ret = regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL2,
> +			  CS35L35_CLK_CTL2_MASK, clk_ctl);
> +	if (ret != 0) {
> +		dev_err(codec->dev, "Failed to set port config %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Rev A0 Errata
> +	 *
> +	 * When configured for the weak-drive detection path (CH_WKFET_DIS = 0)
> +	 * the Class H algorithm does not enable weak-drive operation for
> +	 * nonzero values of CH_WKFET_DELAY if SP_RATE = 01 or 10
> +	 *
> +	 */
> +	errata_chk = clk_ctl & CS35L35_SP_RATE_MASK;
> +
> +	if (classh->classh_wk_fet_disable == 0x00 &&
> +		(errata_chk == 0x01 || errata_chk == 0x03)) {
> +		ret = regmap_update_bits(cs35l35->regmap,
> +			CS35L35_CLASS_H_FET_DRIVE_CTL, CS35L35_CH_WKFET_DEL_MASK,
> +			0 << CS35L35_CH_WKFET_DEL_SHIFT);
> +		if (ret != 0) {
> +			dev_err(codec->dev, "Failed to set fet config %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +/*
> + * You can pull more Monitor data from the SDOUT pin than going to SDIN
> + * Just make sure your SCLK is fast enough to fill the frame
> + */
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		switch (params_width(params)) {
> +		case 8:
> +			audin_format = CS35L35_SDIN_DEPTH_8;
> +			break;
> +		case 16:
> +			audin_format = CS35L35_SDIN_DEPTH_16;
> +			break;
> +		case 24:
> +			audin_format = CS35L35_SDIN_DEPTH_24;
> +			break;
> +		default:
> +			dev_err(codec->dev, "Unsupported Width %d\n",
> +				params_width(params));
> +		}
> +		regmap_update_bits(cs35l35->regmap,
> +			CS35L35_AUDIN_DEPTH_CTL, CS35L35_AUDIN_DEPTH_MASK,
> +			audin_format << CS35L35_AUDIN_DEPTH_SHIFT);
> +		if (cs35l35->pdata.stereo) {
> +			regmap_update_bits(cs35l35->regmap,
> +				CS35L35_AUDIN_DEPTH_CTL, CS35L35_ADVIN_DEPTH_MASK,
> +				audin_format << CS35L35_ADVIN_DEPTH_SHIFT);
> +		}
> +	}
> +/* We have to take the SCLK to derive num sclks
> + * to configure the CLOCK_CTL3 register correctly
> + */
> +	if ((cs35l35->sclk / srate) % 4) {
> +		dev_err(codec->dev, "Unsupported sclk/fs ratio %d:%d\n",
> +					cs35l35->sclk, srate);
> +		return -EINVAL;
> +	}

Again here it might be slightly better to constraints in startup.

> +	sp_sclks = ((cs35l35->sclk / srate) / 4) - 1;
> +
> +	if (cs35l35->i2s_mode) {
> +		/* Only certain ratios are supported in I2S Slave Mode */
> +		if (cs35l35->slave_mode) {
> +			switch (sp_sclks) {
> +			case CS35L35_SP_SCLKS_32FS:
> +			case CS35L35_SP_SCLKS_48FS:
> +			case CS35L35_SP_SCLKS_64FS:
> +			break;
> +			default:
> +				dev_err(codec->dev, "ratio not supported\n");
> +				return -EINVAL;
> +			};
> +		} else {
> +			/* Only certain ratios supported in I2S MASTER Mode */
> +			switch (sp_sclks) {
> +			case CS35L35_SP_SCLKS_32FS:
> +			case CS35L35_SP_SCLKS_64FS:
> +			break;
> +			default:
> +				dev_err(codec->dev, "ratio not supported\n");
> +				return -EINVAL;
> +			};
> +		}
> +		ret = regmap_update_bits(cs35l35->regmap,
> +			CS35L35_CLK_CTL3, CS35L35_SP_SCLKS_MASK,
> +			sp_sclks << CS35L35_SP_SCLKS_SHIFT);
> +		if (ret != 0) {
> +			dev_err(codec->dev, "Failed to set fsclk %d\n", ret);
> +			return ret;
> +		}
> +	}
> +	if (cs35l35->pdm_mode) {
> +		regmap_update_bits(cs35l35->regmap, CS35L35_AMP_INP_DRV_CTL,
> +			CS35L35_PDM_MODE_MASK, 1 << CS35L35_PDM_MODE_SHIFT);
> +	} else {
> +		regmap_update_bits(cs35l35->regmap, CS35L35_AMP_INP_DRV_CTL,
> +			CS35L35_PDM_MODE_MASK, 0 << CS35L35_PDM_MODE_SHIFT);
> +	}

This if could be combined with the one above since pdm_mode ==
!i2s_mode.

> +	return ret;
> +}
> +
> +
> +static const struct snd_soc_dai_ops cs35l35_ops = {
> +	.startup = cs35l35_pcm_startup,
> +	.set_fmt = cs35l35_set_dai_fmt,
> +	.hw_params = cs35l35_pcm_hw_params,
> +	.set_sysclk = cs35l35_dai_set_sysclk,
> +};
> +
> +static const struct snd_soc_dai_ops cs35l35_pdm_ops = {
> +	.startup = cs35l35_pdm_startup,
> +	.set_fmt = cs35l35_set_dai_fmt,
> +	.hw_params = cs35l35_pcm_hw_params,

I would be tempted to rename the function to just
cs35l35_hw_params if it is shared between both PCM and PDM.

> +	.set_sysclk = cs35l35_dai_set_sysclk,
> +};
> +
> +
> +static int cs35l35_codec_probe(struct snd_soc_codec *codec)
> +{
> +	struct cs35l35_private *cs35l35 = snd_soc_codec_get_drvdata(codec);
> +	struct classh_cfg *classh = &cs35l35->pdata.classh_algo;
> +	struct monitor_cfg *monitor_config = &cs35l35->pdata.mon_cfg;
> +	int ret;
> +
> +	cs35l35->codec = codec;
> +
> +	/* Set Platform Data */
> +	if (cs35l35->pdata.bst_vctl)
> +		regmap_update_bits(cs35l35->regmap, CS35L35_BST_CVTR_V_CTL,
> +			CS35L35_BST_CTL_MASK, cs35l35->pdata.bst_vctl);
> +
> +	if (cs35l35->pdata.bst_ipk)
> +		regmap_update_bits(cs35l35->regmap, CS35L35_BST_PEAK_I,
> +			CS35L35_BST_IPK_MASK,
> +			cs35l35->pdata.bst_ipk << CS35L35_BST_IPK_SHIFT);

I believe zero is a valid value for this field, but not the
default. Are we happy that the user can never set this value?

> +
> +	if (cs35l35->pdata.gain_zc)
> +		regmap_update_bits(cs35l35->regmap, CS35L35_PROTECT_CTL,
> +			CS35L35_AMP_GAIN_ZC_MASK,
> +			cs35l35->pdata.gain_zc << CS35L35_AMP_GAIN_ZC_SHIFT);
> +
> +	if (cs35l35->pdata.aud_channel)
> +		regmap_update_bits(cs35l35->regmap,
> +			CS35L35_AUDIN_RXLOC_CTL,
> +			CS35L35_AUD_IN_LR_MASK,
> +			cs35l35->pdata.aud_channel << CS35L35_AUD_IN_LR_SHIFT);
> +
> +	if (cs35l35->pdata.stereo) {
> +		regmap_update_bits(cs35l35->regmap,
> +			CS35L35_ADVIN_RXLOC_CTL, CS35L35_ADV_IN_LR_MASK,
> +			cs35l35->pdata.adv_channel << CS35L35_ADV_IN_LR_SHIFT);
> +		if (cs35l35->pdata.shared_bst)
> +			regmap_update_bits(cs35l35->regmap, CS35L35_CLASS_H_CTL,
> +				CS35L35_CH_STEREO_MASK, 1 << CS35L35_CH_STEREO_SHIFT);
> +		ret = snd_soc_add_codec_controls(codec, cs35l35_adv_controls,
> +					ARRAY_SIZE(cs35l35_adv_controls));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (cs35l35->pdata.sp_drv_str)
> +		regmap_update_bits(cs35l35->regmap, CS35L35_CLK_CTL1,
> +			CS35L35_SP_DRV_MASK,
> +			cs35l35->pdata.sp_drv_str << CS35L35_SP_DRV_SHIFT);
> +
> +	if (classh->classh_algo_enable) {
> +		if (classh->classh_bst_override)
> +			regmap_update_bits(cs35l35->regmap,
> +				CS35L35_CLASS_H_CTL, CS35L35_CH_BST_OVR_MASK,
> +				classh->classh_bst_override << CS35L35_CH_BST_OVR_SHIFT);
> +		if (classh->classh_bst_max_limit)
> +			regmap_update_bits(cs35l35->regmap,
> +				CS35L35_CLASS_H_CTL, CS35L35_CH_BST_LIM_MASK,
> +				classh->classh_bst_max_limit << CS35L35_CH_BST_LIM_SHIFT);

This is a single bit, but the default bit is 1, so this code can
never change the value of the field.

> +		if (classh->classh_mem_depth)
> +			regmap_update_bits(cs35l35->regmap,
> +				CS35L35_CLASS_H_CTL, CS35L35_CH_MEM_DEPTH_MASK,
> +				classh->classh_mem_depth << CS35L35_CH_MEM_DEPTH_SHIFT);

Again zero is a valid value, and not the default.

> +		if (classh->classh_headroom)
> +			regmap_update_bits(cs35l35->regmap,
> +				CS35L35_CLASS_H_HEADRM_CTL, CS35L35_CH_HDRM_CTL_MASK,
> +				classh->classh_headroom << CS35L35_CH_HDRM_CTL_SHIFT);
> +		if (classh->classh_release_rate)
> +			regmap_update_bits(cs35l35->regmap,
> +				CS35L35_CLASS_H_RELEASE_RATE, CS35L35_CH_REL_RATE_MASK,
> +				classh->classh_release_rate << CS35L35_CH_REL_RATE_SHIFT);
> +		if (classh->classh_wk_fet_disable)
> +			regmap_update_bits(cs35l35->regmap,
> +				CS35L35_CLASS_H_FET_DRIVE_CTL, CS35L35_CH_WKFET_DIS_MASK,
> +				classh->classh_wk_fet_disable << CS35L35_CH_WKFET_DIS_SHIFT);
> +		if (classh->classh_wk_fet_delay)
> +			regmap_update_bits(cs35l35->regmap,
> +				CS35L35_CLASS_H_FET_DRIVE_CTL, CS35L35_CH_WKFET_DEL_MASK,
> +				classh->classh_wk_fet_delay << CS35L35_CH_WKFET_DEL_SHIFT);

Again zero is a valid value, and not the default.

> +		if (classh->classh_wk_fet_thld)
> +			regmap_update_bits(cs35l35->regmap,
> +				CS35L35_CLASS_H_FET_DRIVE_CTL, CS35L35_CH_WKFET_THLD_MASK,
> +				classh->classh_wk_fet_thld << CS35L35_CH_WKFET_THLD_SHIFT);
> +		if (classh->classh_vpch_auto)
> +			regmap_update_bits(cs35l35->regmap,
> +				CS35L35_CLASS_H_VP_CTL, CS35L35_CH_VP_AUTO_MASK,
> +				classh->classh_vpch_auto << CS35L35_CH_VP_AUTO_SHIFT);

Again single bit with a default of 1.

> +		if (classh->classh_vpch_rate)
> +			regmap_update_bits(cs35l35->regmap,
> +				CS35L35_CLASS_H_VP_CTL, CS35L35_CH_VP_RATE_MASK,
> +				classh->classh_vpch_rate << CS35L35_CH_VP_RATE_SHIFT);

Again zero is a valid value, and not the default.

> +		if (classh->classh_vpch_man)
> +			regmap_update_bits(cs35l35->regmap,
> +				CS35L35_CLASS_H_VP_CTL, CS35L35_CH_VP_MAN_MASK,
> +				classh->classh_vpch_man << CS35L35_CH_VP_MAN_SHIFT);
> +	}
> +
<snip>
> +static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
> +			      const struct i2c_device_id *id)
> +{
> +	struct cs35l35_private *cs35l35;
> +	struct cs35l35_platform_data *pdata =
> +		dev_get_platdata(&i2c_client->dev);
> +	int i;
> +	int ret;
> +	unsigned int devid = 0;
> +	unsigned int reg;
> +
> +	cs35l35 = devm_kzalloc(&i2c_client->dev,
> +			       sizeof(struct cs35l35_private),
> +			       GFP_KERNEL);
> +	if (!cs35l35) {
> +		dev_err(&i2c_client->dev, "could not allocate codec\n");
> +		return -ENOMEM;
> +	}
> +
> +	i2c_set_clientdata(i2c_client, cs35l35);
> +	cs35l35->regmap = devm_regmap_init_i2c(i2c_client, &cs35l35_regmap);
> +	if (IS_ERR(cs35l35->regmap)) {
> +		ret = PTR_ERR(cs35l35->regmap);
> +		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
> +		goto err;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(cs35l35_supplies); i++)
> +		cs35l35->supplies[i].supply = cs35l35_supplies[i];
> +		cs35l35->num_supplies = ARRAY_SIZE(cs35l35_supplies);
> +
> +	ret = devm_regulator_bulk_get(&i2c_client->dev,
> +			cs35l35->num_supplies,
> +			cs35l35->supplies);
> +	if (ret != 0) {
> +		dev_err(&i2c_client->dev,
> +			"Failed to request core supplies: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	if (pdata) {
> +		cs35l35->pdata = *pdata;
> +	} else {
> +		pdata = devm_kzalloc(&i2c_client->dev,
> +				     sizeof(struct cs35l35_platform_data),
> +				GFP_KERNEL);
> +		if (!pdata) {
> +			dev_err(&i2c_client->dev,
> +				"could not allocate pdata\n");
> +			return -ENOMEM;
> +		}
> +		if (i2c_client->dev.of_node) {
> +			ret = cs35l35_handle_of_data(i2c_client, pdata);
> +			if (ret != 0)
> +				return ret;
> +
> +		}
> +		cs35l35->pdata = *pdata;
> +	}
> +
> +	ret = regulator_bulk_enable(cs35l35->num_supplies,
> +					cs35l35->supplies);
> +	if (ret != 0) {
> +		dev_err(&i2c_client->dev,
> +			"Failed to enable core supplies: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/* returning NULL can be an option if in stereo mode */
> +	cs35l35->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
> +		"reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(cs35l35->reset_gpio))
> +		return PTR_ERR(cs35l35->reset_gpio);

This should be a goto err;

> +
> +	if (cs35l35->reset_gpio)
> +		gpiod_set_value_cansleep(cs35l35->reset_gpio, 1);

gpiod_set_value_can_sleep does an internal NULL check on the GPIO
desc I would be tempted to just rely on that one.

> +
> +	init_completion(&cs35l35->pdn_done);
> +
> +	ret = regmap_register_patch(cs35l35->regmap, cs35l35_errata_patch,
> +				    ARRAY_SIZE(cs35l35_errata_patch));
> +	if (ret < 0) {
> +		dev_err(&i2c_client->dev, "Failed to apply errata patch\n");
> +		return ret;

This should be a goto err;

> +	}
> +
> +	ret = devm_request_threaded_irq(&i2c_client->dev, i2c_client->irq, NULL,
> +			cs35l35_irq, IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> +			"cs35l35", cs35l35);
> +	if (ret != 0) {
> +		dev_err(&i2c_client->dev, "Failed to request IRQ: %d\n", ret);
> +		goto err;
> +	}
> +	/* initialize codec */
> +	ret = regmap_read(cs35l35->regmap, CS35L35_DEVID_AB, &reg);
> +
> +	devid = (reg & 0xFF) << 12;
> +	ret = regmap_read(cs35l35->regmap, CS35L35_DEVID_CD, &reg);
> +	devid |= (reg & 0xFF) << 4;
> +	ret = regmap_read(cs35l35->regmap, CS35L35_DEVID_E, &reg);
> +	devid |= (reg & 0xF0) >> 4;
> +
> +	if (devid != CS35L35_CHIP_ID) {
> +		dev_err(&i2c_client->dev,
> +			"CS35L35 Device ID (%X). Expected ID %X\n",
> +			devid, CS35L35_CHIP_ID);
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	ret = regmap_read(cs35l35->regmap, CS35L35_REV_ID, &reg);
> +	if (ret < 0) {
> +		dev_err(&i2c_client->dev, "Get Revision ID failed\n");
> +		goto err;
> +	}
> +
> +	dev_info(&i2c_client->dev,
> +		 "Cirrus Logic CS35L35 (%x), Revision: %02X\n", devid,
> +		ret & 0xFF);
> +
> +	/* Set the INT Masks for critical errors */
> +	regmap_write(cs35l35->regmap, CS35L35_INT_MASK_1, CS35L35_INT1_CRIT_MASK);
> +	regmap_write(cs35l35->regmap, CS35L35_INT_MASK_2, CS35L35_INT2_CRIT_MASK);
> +	regmap_write(cs35l35->regmap, CS35L35_INT_MASK_3, CS35L35_INT3_CRIT_MASK);
> +	regmap_write(cs35l35->regmap, CS35L35_INT_MASK_4, CS35L35_INT4_CRIT_MASK);
> +
> +	regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL2,
> +		CS35L35_PWR2_PDN_MASK, CS35L35_PWR2_PDN_MASK);
> +
> +	if (cs35l35->pdata.bst_pdn_fet_on)
> +		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL2,
> +			CS35L35_PDN_BST_MASK, 1 << CS35L35_PDN_BST_FETON_SHIFT);
> +	else
> +		regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL2,
> +			CS35L35_PDN_BST_MASK, 1 << CS35L35_PDN_BST_FETOFF_SHIFT);
> +
> +	regmap_update_bits(cs35l35->regmap, CS35L35_PWRCTL3,
> +		CS35L35_PWR3_PDN_MASK, CS35L35_PWR3_PDN_MASK);
> +
> +	regmap_update_bits(cs35l35->regmap, CS35L35_PROTECT_CTL,
> +		CS35L35_AMP_MUTE_MASK, 1 << CS35L35_AMP_MUTE_SHIFT);
> +
> +	ret =  snd_soc_register_codec(&i2c_client->dev,
> +			&soc_codec_dev_cs35l35, cs35l35_dai,
> +			ARRAY_SIZE(cs35l35_dai));
> +	if (ret < 0) {
> +		dev_err(&i2c_client->dev,
> +			"%s: Register codec failed\n", __func__);
> +		goto err;
> +	}
> +
> +err:
> +	regulator_bulk_disable(cs35l35->num_supplies,
> +			       cs35l35->supplies);
> +	return ret;
> +}
> +
> +static int cs35l35_i2c_remove(struct i2c_client *client)
> +{
> +	snd_soc_unregister_codec(&client->dev);
> +	kfree(i2c_get_clientdata(client));

clientdata was allocated with devm this kfree will cause a double
free.

> +	return 0;
> +}

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
