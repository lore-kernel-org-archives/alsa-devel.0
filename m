From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 2/5] ASoC: sirf: add I2S CPU DAI driver
Date: Sun, 05 Jan 2014 12:52:47 +0100
Message-ID: <52C9478F.5030602@metafoo.de>
References: <1388729104-28643-1-git-send-email-rongjun.ying@csr.com>
 <1388729104-28643-3-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-079.synserver.de (smtp-out-019.synserver.de
 [212.40.185.19])
 by alsa0.perex.cz (Postfix) with ESMTP id 86A372602AD
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 12:52:30 +0100 (CET)
In-Reply-To: <1388729104-28643-3-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Workgroup.linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 01/03/2014 07:05 AM, RongJun Ying wrote:
> diff --git a/sound/soc/sirf/sirf-audio.h b/sound/soc/sirf/sirf-audio.h
> new file mode 100644
> index 0000000..b6fdf06
> --- /dev/null
> +++ b/sound/soc/sirf/sirf-audio.h
> @@ -0,0 +1,268 @@
> +#ifndef _SIRF_INNER_AUDIO_CTRL_H
> +#define _SIRF_INNER_AUDIO_CTRL_H
> +
> +#define AUDIO_CTRL_TX_FIFO_LEVEL_CHECK_MASK     0x3F
[...]

Adding a prefix like SIRF_ to all those defines wouldn't hurt.

> +
> +#define SIRF_I2S_EXT_CLK	0x0
> +#define SIRF_I2S_PWM_CLK	0x1
> +#endif /*__SIRF_INNER_AUDIO_CTRL_H*/
> diff --git a/sound/soc/sirf/sirf-i2s.c b/sound/soc/sirf/sirf-i2s.c
> new file mode 100644
> index 0000000..d8b8732
> --- /dev/null
> +++ b/sound/soc/sirf/sirf-i2s.c
> @@ -0,0 +1,435 @@
> +/*
> + * SiRF I2S driver
> + *
> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/clk.h>
> +
> +#include <sound/soc.h>
> +#include <sound/pcm_params.h>
> +#include <sound/dmaengine_pcm.h>
> +
> +#include "sirf-audio.h"
> +
> +struct sirf_i2s {
> +	void __iomem		*base;
> +	struct clk		*clk;
> +	u32			i2s_ctrl;
> +	u32			i2s_ctrl_tx_rx_en;
> +	spinlock_t		lock;
> +	struct platform_device	*sirf_pcm_pdev;
> +	bool			master;
> +	int			ext_clk;
> +	int			src_clk_rate;
> +};
> +
> +static struct snd_dmaengine_dai_dma_data dma_data[2];

This can be removed since you only use it to specify the channel names. But
since you use the default names there is no need to do that.

> +
> +static int sirf_i2s_dai_probe(struct snd_soc_dai *dai)
> +{
> +	dai->playback_dma_data = &dma_data[0];
> +	dai->capture_dma_data = &dma_data[1];
> +	return 0;
> +}
> +
> +static int sirf_i2s_trigger(struct snd_pcm_substream *substream,
> +		int cmd, struct snd_soc_dai *dai)
> +{
> +	struct sirf_i2s *si2s = snd_soc_dai_get_drvdata(dai);
> +	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		spin_lock(&si2s->lock);

This is the only place where you use the spinlock. The trigger callback is
already protected by the ALSA core and can not race against itself, so you
do not need the lock.

> +
> +		if (playback) {
> +			/* First start the FIFO, then enable the tx/rx */
> +			writel(AUDIO_FIFO_RESET,
> +				si2s->base + AUDIO_CTRL_EXT_TXFIFO1_OP);
> +			writel(AUDIO_FIFO_START,
> +				si2s->base + AUDIO_CTRL_EXT_TXFIFO1_OP);
> +
> +			writel(readl(si2s->base+AUDIO_CTRL_I2S_TX_RX_EN)
> +				| I2S_TX_ENABLE | I2S_DOUT_OE,
> +				si2s->base + AUDIO_CTRL_I2S_TX_RX_EN);

For better legibility this should probably be split into multiple
statements, like

	val = read()
	val |= ...
	write(val);

> +
> +		} else {
> +			/* First start the FIFO, then enable the tx/rx */
> +			writel(AUDIO_FIFO_RESET,
> +				si2s->base + AUDIO_CTRL_RXFIFO_OP);
> +			writel(AUDIO_FIFO_START,
> +				si2s->base + AUDIO_CTRL_RXFIFO_OP);
> +
> +			writel(readl(si2s->base+AUDIO_CTRL_I2S_TX_RX_EN)
> +				| I2S_RX_ENABLE,
> +				si2s->base + AUDIO_CTRL_I2S_TX_RX_EN);

Same here

> +		}
> +
> +		spin_unlock(&si2s->lock);
> +		break;
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		spin_lock(&si2s->lock);
> +
> +		if (playback) {
> +			writel(readl(si2s->base + AUDIO_CTRL_I2S_TX_RX_EN)
> +				& ~(I2S_TX_ENABLE),
> +				si2s->base + AUDIO_CTRL_I2S_TX_RX_EN);

and here

> +			/* First disable the tx/rx, then stop the FIFO */
> +			writel(0, si2s->base + AUDIO_CTRL_EXT_TXFIFO1_OP);
> +		} else {
> +			writel(readl(si2s->base + AUDIO_CTRL_I2S_TX_RX_EN)
> +				& ~(I2S_RX_ENABLE),
> +				si2s->base+AUDIO_CTRL_I2S_TX_RX_EN);
> +

and here

> +			/* First disable the tx/rx, then stop the FIFO */
> +			writel(0, si2s->base + AUDIO_CTRL_RXFIFO_OP);
> +		}
> +
> +		spin_unlock(&si2s->lock);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int sirf_i2s_hw_params(struct snd_pcm_substream *substream,
> +		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
> +{
> +	struct sirf_i2s *si2s = snd_soc_dai_get_drvdata(dai);
> +	u32 i2s_ctrl = readl(si2s->base + AUDIO_CTRL_I2S_CTRL);
> +	u32 i2s_tx_rx_ctrl = readl(si2s->base + AUDIO_CTRL_I2S_TX_RX_EN);
> +	u32 left_len, frame_len;
> +	int channels = params_channels(params);
> +	u32 bitclk;
> +	u32 bclk_div;
> +	u32 div;
> +
> +	/*
> +	 * SiRFSoC I2S controller only support 2 and 6 channells output.
> +	 * I2S_SIX_CHANNELS bit clear: select 2 channels mode.
> +	 * I2S_SIX_CHANNELS bit set: select 6 channels mode.
> +	 */
> +	switch (channels) {
> +	case 2:
> +		i2s_ctrl &= ~I2S_SIX_CHANNELS;
> +		break;
> +	case 6:
> +		i2s_ctrl |= I2S_SIX_CHANNELS;
> +		break;
> +	default:
> +		dev_err(dai->dev, "%d channels unsupported\n", channels);
> +		return -EINVAL;

Since you only support 2 and 6 for the number of channels you should add a
constraint to that in your hwparams callback. Otherwise userspace will think
you support any number of channels between 2 and 6. You can do this using
this snippet:

static unsigned int sirf_i2s_channels[] = {2, 6};
static struct snd_pcm_hw_constraint_list sirf_i2s_channel_constraints = {
    .count = ARRAY_SIZE(sirf_i2s_channels),
    .list = sirf_i2s_channels,
};

snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
&sirf_i2s_channel_constraints);

> +	}
> +
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S8:
> +		left_len = 8;
> +		break;
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		left_len = 16;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		left_len = 24;
> +		break;
> +	case SNDRV_PCM_FORMAT_S32_LE:
> +		left_len = 32;
> +		break;
> +	default:
> +		dev_err(dai->dev, "Format unsupported\n");
> +		return -EINVAL;
> +	}
> +
> +	frame_len = left_len * 2;
> +	i2s_ctrl &= ~(I2S_L_CHAN_LEN_MASK | I2S_FRAME_LEN_MASK);
> +	/* Fill the actual len - 1 */
> +	i2s_ctrl |= ((frame_len - 1) << 9) | ((left_len - 1) << 4)
> +		| (0 << 15) | (3 << 24);

You set the bclk_div to 3 here

> +
> +	if (si2s->master) {
> +		i2s_ctrl &= ~I2S_SLAVE_MODE;
> +		i2s_tx_rx_ctrl |= I2S_MCLK_EN;
> +		bitclk = params_rate(params) * frame_len;
> +		div = si2s->src_clk_rate / bitclk;
> +		/* MCLK divide-by-2 from source clk */
> +		div /= 2;
> +		bclk_div = div / 2 - 1;
> +		i2s_ctrl |= (bclk_div << 24);

and never clear it before setting it here again, this will probably not work.

> +		/*
> +		 * MCLK coefficient must set to 0, means
> +		 * divide-by-two from reference clock.
> +		 */
> +		i2s_ctrl &= ~(((1 << 10) - 1) << 15);
> +	} else {
> +		i2s_ctrl |= I2S_SLAVE_MODE;
> +		i2s_tx_rx_ctrl &= ~I2S_MCLK_EN;
> +	}
> +
> +	if (si2s->ext_clk)
> +		i2s_tx_rx_ctrl |= I2S_REF_CLK_SEL_EXT;
> +	else
> +		i2s_tx_rx_ctrl &= ~I2S_REF_CLK_SEL_EXT;
> +
> +	writel(i2s_ctrl, si2s->base + AUDIO_CTRL_I2S_CTRL);
> +	writel(i2s_tx_rx_ctrl, si2s->base + AUDIO_CTRL_I2S_TX_RX_EN);
> +	writel(readl(si2s->base + AUDIO_CTRL_MODE_SEL)
> +			| I2S_MODE,
> +			si2s->base + AUDIO_CTRL_MODE_SEL);

again, break this into multiple statements.

> +
> +	return 0;
> +}
> +
> +
> +static int sirf_i2s_set_clkdiv(struct snd_soc_dai *dai, int div_id, int src_rate)

I think this should be set_sysclk not set_clkdiv.

> +{
> +	struct sirf_i2s *si2s = snd_soc_dai_get_drvdata(dai);
> +
> +	switch (div_id) {
> +	case SIRF_I2S_EXT_CLK:
> +		si2s->ext_clk = 1;
> +		break;
> +	case SIRF_I2S_PWM_CLK:
> +		si2s->ext_clk = 0;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	si2s->src_clk_rate = src_rate;
> +	return 0;
> +}
> +
> +struct snd_soc_dai_ops sirfsoc_i2s_dai_ops = {

static const

> +	.trigger	= sirf_i2s_trigger,
> +	.hw_params	= sirf_i2s_hw_params,
> +	.set_fmt	= sirf_i2s_set_dai_fmt,
> +	.set_clkdiv	= sirf_i2s_set_clkdiv,
> +};
> +
[...]
> +#ifdef CONFIG_PM_SLEEP
> +static int sirf_i2s_suspend(struct device *dev)
> +{
> +	struct sirf_i2s *si2s = dev_get_drvdata(dev);
> +
> +	if (!pm_runtime_status_suspended(dev)) {
> +		si2s->i2s_ctrl = readl(si2s->base + AUDIO_CTRL_I2S_CTRL);
> +		si2s->i2s_ctrl_tx_rx_en =
> +			readl(si2s->base + AUDIO_CTRL_I2S_TX_RX_EN);
> +		sirf_i2s_runtime_suspend(dev);

This will yield a compile error if CONFIG_PM_SLEEP is set, but
CONFIG_PM_RUNTIME is not set

> +	}
> +	return 0;
> +}
> +
> +static int sirf_i2s_resume(struct device *dev)
> +{
> +	struct sirf_i2s *si2s = dev_get_drvdata(dev);
> +	int ret;
> +	if (!pm_runtime_status_suspended(dev)) {
> +		ret = sirf_i2s_runtime_resume(dev);

Same here

> +		if (ret)
> +			return ret;
> +		writel(readl(si2s->base + AUDIO_CTRL_MODE_SEL)
> +				| I2S_MODE,
> +				si2s->base + AUDIO_CTRL_MODE_SEL);
> +		writel(si2s->i2s_ctrl, si2s->base + AUDIO_CTRL_I2S_CTRL);
> +		/*Restore MCLK enable and reference clock select bits.*/
> +		writel(si2s->i2s_ctrl_tx_rx_en &
> +			(I2S_MCLK_EN | I2S_REF_CLK_SEL_EXT),
> +			si2s->base + AUDIO_CTRL_I2S_TX_RX_EN);
> +
> +		writel(0, si2s->base + AUDIO_CTRL_EXT_TXFIFO1_INT_MSK);
> +		writel(0, si2s->base + AUDIO_CTRL_RXFIFO_INT_MSK);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct snd_soc_component_driver sirf_i2s_component = {
> +	.name       = "sirf-i2s",
> +};
> +
> +static int sirf_i2s_probe(struct platform_device *pdev)
> +{
> +	struct sirf_i2s *si2s;
> +	int ret;
> +	struct resource mem_res;
> +
> +	si2s = devm_kzalloc(&pdev->dev, sizeof(struct sirf_i2s),

sizeof(*si2s) is prefered by the coding style guidelines

> +			GFP_KERNEL);
> +	if (!si2s)
> +		return -ENOMEM;
> +
> +	si2s->sirf_pcm_pdev = platform_device_register_simple("sirf-pcm-audio",
> +			0, NULL, 0);
> +	if (IS_ERR(si2s->sirf_pcm_pdev))
> +		return PTR_ERR(si2s->sirf_pcm_pdev);
> +
> +	platform_set_drvdata(pdev, si2s);
> +
> +	spin_lock_init(&si2s->lock);
> +
> +	dma_data[0].chan_name = "tx";
> +	dma_data[1].chan_name = "rx";
> +
> +	ret = of_address_to_resource(pdev->dev.of_node, 0, &mem_res);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Unable to get i2s memory resource.\n");
> +		return ret;
> +	}
> +	si2s->base = devm_ioremap(&pdev->dev, mem_res.start,
> +		resource_size(&mem_res));

I think using devm_ioremap_resource() is better here. It will first request
the region before remapping it.

> +	if (!si2s->base)
> +		return -ENOMEM;
> +
> +	si2s->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(si2s->clk)) {
> +		dev_err(&pdev->dev, "Get clock failed.\n");
> +		ret = PTR_ERR(si2s->clk);
> +		goto err;
> +	}
> +
> +	pm_runtime_enable(&pdev->dev);
> +
> +	ret = devm_snd_soc_register_component(&pdev->dev, &sirf_i2s_component,
> +			&sirf_i2s_dai, 1);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Register Audio SoC dai failed.\n");
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	return ret;
> +}
[...]
> +
> +static const struct of_device_id sirf_i2s_of_match[] = {
> +	{ .compatible = "sirf,prima2-i2s", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sirf_i2s_of_match);

Binding documentation is missing.
