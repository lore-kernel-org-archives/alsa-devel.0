From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] ASoC: imx-wm8958: add imx-wm8958
 machine driver
Date: Fri, 26 Feb 2016 12:52:09 -0800
Message-ID: <20160226205208.GA25515@Asurada-Nvidia>
References: <6f90780124a7f5bf31452623fdf04225873fc711.1456457898.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 67CAD261298
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 21:52:05 +0100 (CET)
Received: by mail-pa0-f53.google.com with SMTP id yy13so56511771pab.3
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 12:52:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <6f90780124a7f5bf31452623fdf04225873fc711.1456457898.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 26, 2016 at 11:42:42AM +0800, Zidan Wang wrote:
> This is the initial imx-wm8958 device-tree-only machine driver working
> with fsl_sai driver. This sound card has three dai link, HIFI, VOICE
> and BT dai. HIFI dai link will support codec master and slave mode.
> VOICE an BT dai link have dummy cpu dai, and just support codec
> master mode.

Why VOICE and BT are using dummy cpu dai? Where can I find the
schematics for wm8958 from NXP website?

> diff --git a/Documentation/devicetree/bindings/sound/imx-audio-wm8958.txt
> +Example:
> +
> +sound {
> +		compatible = "fsl,imx6ul-evk-wm8958",
> +			   "fsl,imx-audio-wm8958";
> +		model = "wm8960-audio";

8960?

> diff --git a/arch/arm/configs/imx_v6_v7_defconfig
> +config SND_SOC_IMX_WM8958
> +	tristate "SoC Audio support for i.MX boards with wm8958"
> +	depends on OF && I2C
> +	select MFD_WM8994
> +	select SND_SOC_WM8994
> +	select SND_SOC_IMX_PCM_DMA
> +	select SND_SOC_FSL_SAI
> +	select SND_SOC_FSL_UTILS
> +	select SND_KCTL_JACK

The driver doesn't seem to use kcontrol....

> +static u32 imx_wm8958_rates[] = { 8000, 16000, 32000, 48000 };
> +
> +static struct snd_pcm_hw_constraint_list imx_wm8958_rate_constraints = {
> +	.count = ARRAY_SIZE(imx_wm8958_rates),
> +	.list = imx_wm8958_rates,
> +};

Where are these rate constraints coming from?

> +static int imx_wm8958_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params)
> +{
> +	if (data->mclk_freq[id])
> +		mclk_id = WM8994_FLL_SRC_MCLK(id);
> +	else if (id == HIFI_DAI)
> +		mclk_id = WM8994_FLL_SRC_MCLK2;
> +	else
> +		mclk_id = WM8994_FLL_SRC_MCLK1;

I can barely follow the MCLK assigning logic here...

Is it trying to use the alternative MCLK if the corresponding one
is unavailable? (Since id could be only 0 or 1). And what if both
are unavailable?

> +	if (id == HIFI_DAI) {
> +		/*
> +		 * Set GPIO1 pin function to reserve, so that DAC1 and ADC1
> +		 * using shared LRCLK from DACLRCK1.
> +		 */
> +		snd_soc_update_bits(codec, WM8994_GPIO_1, 0x1f, 0x2);

I don't see any reverse operation against this GPIO configuration here.
So is it really an operation that has to be done every hw_params()?

> +	} else if (id == VOICE_DAI) {
> +		/*
> +		 * Set GPIO6 pin function to reserve, so that DAC2 and ADC2
> +		 * using shared LRCLK from DACLRCK2.
> +		 */
> +		snd_soc_update_bits(codec, WM8994_GPIO_6, 0x1f, 0x2);

Same here.

> +static int imx_wm8958_set_bias_level(struct snd_soc_card *card,
> +				struct snd_soc_dapm_context *dapm,
> +				enum snd_soc_bias_level level)
> +{
> +	struct snd_soc_pcm_runtime *rtd;
> +	struct snd_soc_dai *codec_dai;
> +	struct imx_wm8958_data *data = snd_soc_card_get_drvdata(card);
> +	int ret, i;
> +
> +	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
> +	codec_dai = rtd->codec_dai;
> +
> +	if (dapm->dev != codec_dai->dev)
> +		return 0;
> +
> +	switch (level) {
> +	case SND_SOC_BIAS_STANDBY:
> +		if (card->dapm.bias_level == SND_SOC_BIAS_OFF) {

Using
		if (card->dapm.bias_level != SND_SOC_BIAS_OFF)
			break;

may save one \t for each line below.

> +			/* need to enable mclk to write/read wm8958 register */
> +			for (i = 0; i < WM8958_MCLK_MAX; i++) {
> +				if (!IS_ERR(data->mclk[i])) {
> +					ret = clk_prepare_enable(data->mclk[i]);
> +					if (ret)
> +						dev_warn(card->dev,
> +							 "Failed to enable MCLK%d: %d\n",
> +							 i + 1, ret);
> +				}
> +			}
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx_wm8958_set_bias_level_post(struct snd_soc_card *card,
> +				     struct snd_soc_dapm_context *dapm,
> +				     enum snd_soc_bias_level level)
> +{
> +	struct snd_soc_pcm_runtime *rtd;
> +	struct snd_soc_dai *codec_dai;
> +	struct imx_wm8958_data *data = snd_soc_card_get_drvdata(card);
> +	int i;
> +
> +	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
> +	codec_dai = rtd->codec_dai;
> +
> +	if (dapm->dev != codec_dai->dev)
> +		return 0;
> +
> +	switch (level) {
> +	case SND_SOC_BIAS_OFF:
> +		if (card->dapm.bias_level == SND_SOC_BIAS_STANDBY)
> +			for (i = 0; i < WM8958_MCLK_MAX; i++) {
> +				if (!IS_ERR(data->mclk[i]))
> +					clk_disable_unprepare(data->mclk[i]);

The set_bias() funcs are merely en/disabling mclk. Would be possible to
do it in the codec driver?

> +static struct snd_soc_dai_link imx_wm8958_dai_link[] = {
> +	[HIFI_DAI] =	{
> +			.name = "HiFi",
> +			.stream_name = "HiFi",
> +			.codec_name = "wm8994-codec",
> +			.codec_dai_name = "wm8994-aif1",
> +			.ops = &imx_hifi_ops,
> +			.dai_fmt = SND_SOC_DAIFMT_I2S |
> +				   SND_SOC_DAIFMT_NB_NF,
> +	},
> +	[VOICE_DAI] =   {
> +			.name = "Voice",
> +			.stream_name = "Voice",
> +			.cpu_dai_name = "snd-soc-dummy-dai",
> +			.codec_name = "wm8994-codec",
> +			.codec_dai_name = "wm8994-aif2",
> +			.platform_name = "snd-soc-dummy",
> +			.ignore_pmdown_time = 1,
> +			.ops = &imx_voice_ops,
> +			.dai_fmt = SND_SOC_DAIFMT_I2S |
> +				   SND_SOC_DAIFMT_NB_NF |
> +				   SND_SOC_DAIFMT_CBM_CFM,
> +	},
> +	[BT_DAI] =	{
> +			.name = "Bluetooth",
> +			.stream_name = "Bluetooth",
> +			.cpu_dai_name = "snd-soc-dummy-dai",
> +			.codec_name = "wm8994-codec",
> +			.codec_dai_name = "wm8994-aif3",
> +			.platform_name = "snd-soc-dummy",
> +			.ignore_pmdown_time = 1,
> +	},

A little curious...how is the BT gonna work for you?

> +};
> +
> +static int imx_wm8958_probe(struct platform_device *pdev)
> +{
> +	for (i = 0; i < WM8958_MCLK_MAX; i++) {
> +		sprintf(tmp, "mclk%d", i + 1);
> +		data->mclk[i] = devm_clk_get(&codec_dev->dev, tmp);
> +		if (IS_ERR(data->mclk[i])) {
> +			ret = PTR_ERR(data->mclk[i]);
> +			dev_err(&pdev->dev, "failed to get mclk%d clock: %d\n",
> +				i + 1, ret);

What's the point to have ret = PTR_ERR without doing any error out?

> +		} else {
> +			data->mclk_freq[i] = clk_get_rate(data->mclk[i]);
> +		}
> +	}

Thanks
Nicolin
