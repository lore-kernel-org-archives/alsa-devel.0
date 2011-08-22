From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Please review rt5631 driver on alsa 1.0.24 again
Date: Mon, 22 Aug 2011 23:47:58 +0100
Message-ID: <20110822224757.GA31272@opensource.wolfsonmicro.com>
References: <348C3C33CEB74E6681F0BC4EF5B616D1@realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2E3D624369
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 00:48:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <348C3C33CEB74E6681F0BC4EF5B616D1@realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: johnnyhsu <johnnyhsu@realtek.com>
Cc: alsa-devel@alsa-project.org, flove <flove@realtek.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 22, 2011 at 11:31:30AM +0800, johnnyhsu wrote:

> +/* MIC Input Type */
> +static const char *rt5631_input_mode[] = {
> +	"Single-end", "Differential"};

Single ended.

> +/* MIC Boost Volume */
> +static const char *rt5631_mic_boost[] = {"Bypass", "+20db", "+24db", "+30db",
> +			"+35db", "+40db", "+44db", "+50db", "+52db"};

TLV please.  I'm fairly sure I mentioned this last time.

> +/* Record Data Select */
> +static const char *rt5631_rec_sel[] = {"Disable", "MIC1", "MIC2", "Stereo"};
> +
> +static const SOC_ENUM_SINGLE_DECL(
> +	rt5631_rec_sel_enum, RT5631_INT_ST_IRQ_CTRL_2,
> +	RT5631_ADC_DATA_SEL_SHIFT, rt5631_rec_sel);

This looks like DAPM...

> +/* SPK Channel Volume Input Select */
> +static const char *rt5631_spkvol_sel[] = {"VMID", "SPKMIX"};

> +static const SOC_ENUM_DOUBLE_DECL(
> +	rt5631_spkvol_enum, RT5631_SPK_OUT_VOL,
> +	RT5631_L_EN_SHIFT, RT5631_R_EN_SHIFT, rt5631_spkvol_sel);

This too, and similarly for the other mixers.

> +static void rt5631_set_dmic_params(struct snd_soc_codec *codec,
> +	struct snd_pcm_hw_params *params)
> +{
> +	int rate;
> +
> +	snd_soc_update_bits(codec, RT5631_GPIO_CTRL,
> +		RT5631_GPIO_PIN_FUN_SEL_MASK |
> +		RT5631_GPIO_DMIC_FUN_SEL_MASK,
> +		RT5631_GPIO_PIN_FUN_SEL_GPIO_DIMC |
> +		RT5631_GPIO_DMIC_FUN_SEL_DIMC);

Shouldn't this be done once in th eprobe function?  DMICs aren't usually
hotplugged...

> +	snd_soc_update_bits(codec, RT5631_DIG_MIC_CTRL,
> +		RT5631_DMIC_ENA_MASK, RT5631_DMIC_ENA);

This looks like DAPM.

> +	snd_soc_update_bits(codec, RT5631_DIG_MIC_CTRL,
> +		RT5631_DMIC_L_CH_LATCH_MASK |
> +		RT5631_DMIC_R_CH_LATCH_MASK,
> +		RT5631_DMIC_L_CH_LATCH_FALLING |
> +		RT5631_DMIC_R_CH_LATCH_RISING);

This also looks like probe work.

> +	default:
> +		break;
> +	}

Should return an error if you don't know how to configure.

> +	snd_soc_update_bits(codec, RT5631_SDP_CTRL,
> +		RT5631_SDP_I2S_DL_MASK, iface);

> +	if (coeff >= 0)
> +		snd_soc_write(codec, RT5631_STEREO_AD_DA_CLK_CTRL,
> +					coeff_div[coeff].reg_val);

What if you didn't find coefficients?

> +static int rt5631_hifi_codec_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> +				int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
> +
> +	pr_info("enter %s, syclk=%d\n", __func__, freq);
> +	if ((freq >= (256 * 8000)) && (freq <= (512 * 96000))) {
> +		rt5631->sysclk = freq;
> +		return 0;
> +	}
> +
> +	pr_info("unsupported sysclk freq %u for audio i2s\n", freq);
> +	pr_info("set sysclk to 24.576Mhz by default\n");
> +
> +	rt5631->sysclk = 24576000;
> +	return 0;

No, return an error if the user specified something you don't
understand.  If that's the sysclk the user can always specify it
directly.

> +static int rt5631_codec_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
> +		int source, unsigned int freq_in, unsigned int freq_out)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
> +	int i, ret = -EINVAL;
> +
> +	printk(KERN_DEBUG "enter %s\n", __func__);
> +
> +	if (!freq_in || !freq_out)
> +		return 0;

Should stop the PLL if a zero output is requested.

> +/**
> + * rt5631_index_reg_show - sysfs file for dumping index registers of 2nd layer
> + */
> +#define IDX_REG_FMT "%02x: %04x\n"
> +#define IDX_REG_LEN 9
> +static ssize_t rt5631_index_reg_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)

You didn't answer any of my queries about this stuff on the prior
posting...

> +	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
> +	if (ret != 0) {
> +		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> +		return ret;
> +	}
> +	codec->cache_bypass = 1;

Why cache_bypass?

> +	/* speaker ratio is 1.44x */
> +	snd_soc_write(codec, RT5631_GEN_PUR_CTRL_REG, 0x4e00);

Hrm?
