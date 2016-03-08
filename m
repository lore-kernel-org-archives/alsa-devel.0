From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v4] ASoC: imx-wm8958: add imx-wm8958
 machine driver
Date: Tue, 8 Mar 2016 11:21:10 -0800
Message-ID: <20160308192109.GA6466@Asurada-Nvidia>
References: <4db703a76e01f1c9ad3eda78758f3e121098e515.1457417904.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id A80492606D2
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2016 20:21:15 +0100 (CET)
Received: by mail-pa0-f48.google.com with SMTP id bj10so18966590pad.2
 for <alsa-devel@alsa-project.org>; Tue, 08 Mar 2016 11:21:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4db703a76e01f1c9ad3eda78758f3e121098e515.1457417904.git.zidan.wang@freescale.com>
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

On Tue, Mar 08, 2016 at 02:27:56PM +0800, Zidan Wang wrote:
> This is an initial imx-wm8958 device-tree-only machine driver.
> The sound card driver support three dai link, HIFI, VOICE and BT.
> We can configure the cpu dai from device tree, if present it
> will create corresponding sound card subdevice. So at least
> one cpu dai phandle should be set from device tree.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---
> v3->v4: remove the dummy cpu dai, support set cpu dai1/2/3 from device tree.
> 	When cpu-dai1/2/3 present it will create croresponding sound card
> 	subdevice. At least one cpu dai should be configured.

> +++ b/Documentation/devicetree/bindings/sound/imx-audio-wm8958.txt
> +Optional properties:
> +
> + - cpu-dai1		   : The phandle of CPU DAI1 controller. At least one
> +			     cpu dai is required.

Should indicate that it's for the aif1 of WM8958.

> +
> + - cpu-dai2                : The phandle of CPU DAI2 controller. At least one
> +			     cpu dai is required.
> +
> + - cpu-dai3                : The phandle of CPU DAI3 controller. At least one
> +			     cpu dai is required.

Ditto

> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 978c5de..7ac5856 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -251,6 +251,7 @@ CONFIG_SND_SOC_FSL_ASRC=y
>  CONFIG_SND_IMX_SOC=y
>  CONFIG_SND_SOC_PHYCORE_AC97=y
>  CONFIG_SND_SOC_EUKREA_TLV320=y
> +CONFIG_SND_SOC_IMX_WM8958=y
>  CONFIG_SND_SOC_IMX_WM8962=y
>  CONFIG_SND_SOC_IMX_SGTL5000=y
>  CONFIG_SND_SOC_IMX_SPDIF=y

Shouldn't include this here.

> diff --git a/sound/soc/fsl/imx-wm8958.c b/sound/soc/fsl/imx-wm8958.c

> +#define HIFI_DAI (0)
> +#define VOICE_DAI (1)
> +#define BT_DAI (2)

We don't necessarily limit each AIF's role *unless* each AIF can only
act as the one listed above -- In general, AIF1_DAI, AIF2_DAI would be
more flexible for users IMO.

If you really want each role of the AIF to be clear, I suggest you to
add an extra property (eg. dai-link-name) in the DT bindings because
it does reflect the hardware connections according to the schematics.

> +struct imx_wm8958_data {
> +	struct snd_soc_dai_link dai_link[DAI_LINK_NUM];
> +	int num_links;
> +	struct snd_soc_card card;
> +	struct clk *mclk[WM8958_MCLK_MAX];

Since the Codec driver handles the mclk now, we don't need to maintain
it in the private data here any more.

> +	u32 mclk_freq[WM8958_MCLK_MAX];

unsigned long

> +
> +static struct snd_soc_ops imx_hifi_ops = {
> +	.hw_params = imx_wm8958_hw_params,
> +	.hw_free   = imx_wm8958_hw_free,
> +};
> +
> +static struct snd_soc_ops imx_voice_ops = {
> +	.hw_params = imx_wm8958_hw_params,
> +	.hw_free   = imx_wm8958_hw_free,
> +};

What's the difference between these two ops?

> +static int imx_wm8958_probe(struct platform_device *pdev)
> +{
> +	struct device_node *cpu_np[DAI_LINK_NUM], *codec_np;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct platform_device *cpu_pdev[DAI_LINK_NUM];
> +	struct i2c_client *codec_dev;
> +	struct imx_wm8958_data *data;
> +	char tmp[8];
> +	int ret, i;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < DAI_LINK_NUM; i++) {
> +		sprintf(tmp, "cpu-dai%d", i + 1);
> +		cpu_np[i] = of_parse_phandle(np, tmp, 0);
> +		if (cpu_np[i]) {
> +			cpu_pdev[i] = of_find_device_by_node(cpu_np[i]);
> +			if (!cpu_pdev[i]) {
> +				dev_err(&pdev->dev,
> +					"failed to get cpu dai%d platform device\n", i);
> +				ret = -EINVAL;
> +				goto fail;
> +			}
> +
> +			data->dai_link[data->num_links] = imx_wm8958_dai_link[i];
> +			data->dai_link[data->num_links].cpu_dai_name = dev_name(&cpu_pdev[i]->dev);
> +			data->dai_link[data->num_links++].platform_of_node = cpu_np[i];

Some lines here crossed 80-characters. If I were you, I would use:
		if (!cpu_np[i])
			continue;

And we don't necessarily maintain num_links in the private data since
it's not being used in any other function and we may still fetch it
from data->card.num_links even if we somehow need it later.
