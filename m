From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] sound: asoc: Adding support for
 SPEAr13XX ASoC driver
Date: Thu, 17 Mar 2011 15:05:40 +0000
Message-ID: <20110317150539.GF31411@opensource.wolfsonmicro.com>
References: <1300361016-26242-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1300361016-26242-2-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 49D26243FF
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 16:05:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1300361016-26242-2-git-send-email-rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 17, 2011 at 04:53:35PM +0530, Rajeev Kumar wrote:

> This patch contains the following support as per the ASoC framework:
> 1. Platform Driver (I2S based).
> 2. Machine Driver.

These should be split into separate patches...

> The codec driver for STA529 is present in a separate patch.

...and this should come before the machine driver patch as the machine
driver depends on the CODEC.

> -config SND_SOC_CACHE_LZO
> -	bool "Support LZO compression for register caches"
> -	select LZO_COMPRESS
> -	select LZO_DECOMPRESS
> -	---help---
> -	   Select this to enable LZO compression for register caches.
> -	   This will allow machine or CODEC drivers to compress register
> -	   caches in memory, reducing the memory consumption at the
> -	   expense of performance.  If this is not present and is used
> -	   the system will fall back to uncompressed caches.
> -
> -	   Usually it is safe to disable this option, where cache
> -	   compression in used the rbtree option will typically perform
> -	   better.

Hrm?

> @@ -50,12 +35,11 @@ source "sound/soc/jz4740/Kconfig"
>  source "sound/soc/nuc900/Kconfig"
>  source "sound/soc/omap/Kconfig"
>  source "sound/soc/kirkwood/Kconfig"
> -source "sound/soc/mid-x86/Kconfig"
>  source "sound/soc/pxa/Kconfig"
> -source "sound/soc/samsung/Kconfig"
> +#source "sound/soc/s3c24xx/Kconfig"
>  source "sound/soc/s6000/Kconfig"
>  source "sound/soc/sh/Kconfig"
> -source "sound/soc/tegra/Kconfig"
> +source "sound/soc/spear/Kconfig"
>  source "sound/soc/txx9/Kconfig"
>  

Interesting too....

> +config SND_SPEAR_SOC_EVM
> +	tristate "SoC Audio support for Spear EVM"
> +	depends on SND_SPEAR_SOC
> +	select SND_SPEAR_SOC_I2S
> +	select SND_SOC_STA529
> +	help
> +	 Say Y if you want to add support for SoC audio on ST SPEAR
> +	 platform

The description here isn't terribly good, this is actually a driver for
the EVM machine.

> @@ -0,0 +1,6 @@
> +# SPEAR Platform Support
> +obj-$(CONFIG_SND_SPEAR_SOC) += spear13xx-pcm.o
> +obj-$(CONFIG_SND_SPEAR_SOC_I2S) += spear13xx-i2s.o
> +
> +# SPEAR Machine Support
> +obj-$(CONFIG_SND_SPEAR_SOC_EVM) += evb_sta529.o

The modules should always be snd-soc-whatever.

> + * Copyright (C) 2010 ST Microelectronics
> + * Rajeev Kumar<rajeev-dlh.kumar@st.com>

Space between your name and e-mail.

> +	format = params_format(params);
> +	rate = params_rate(params);
> +	channel = params_channels(params);
> +	freq = format * rate * channel * 8;
> +	ref_clock = freq * 8;

Use the utility functions in soc-util to do the format, rate and channel
number calculation.

> +	/* set the codec system clock for DAC */
> +	ret = snd_soc_dai_set_sysclk(codec_dai, 0 , ref_clock,
> +			SND_SOC_CLOCK_IN);
> +	if (ret < 0)
> +		return ret;

Should be "0, " not "0 , ".

> +	/*setting ref clock in 278 offset*/
> +	val = readl(PERIP2_CLK_ENB);
> +	val |= 0x80;
> +	writel(val, PERIP2_CLK_ENB);
> +
> +	/*setting mode 0 in conf regiter: 32c offset*/
> +	val = readl(PERIP_CFG);
> +	val |= 0x0;
> +	writel(val, PERIP_CFG);

These should be exposed by the relevant driver.

> +static int __init spear_init(void)
> +{
> +	int ret;
> +
> +	/* Create and register platform device */
> +	evb_snd_device = platform_device_alloc("soc-audio", 0);
> +	if (!evb_snd_device) {
> +		printk(KERN_ERR "platform_device_alloc fails\n");
> +		return -ENOMEM;
> +	}

Please register the machine using snd_soc_register_card() rather than
soc-audio.  soc-audio is being phased out.

> +static int
> +spear13xx_i2s_set_dai_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
> +		unsigned int freq, int dir)
> +{
> +	struct spear13xx_i2s_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
> +	struct clk *sclk_clk, *src_clk;
> +	int ret = -EINVAL;
> +
> +	sclk_clk = clk_get_sys(NULL, "i2s_sclk_clk");
> +	if (IS_ERR(sclk_clk)) {
> +		dev_err(dev->dev, "couldn't get i2s_sclk\n");
> +		return PTR_ERR(sclk_clk);
> +	}
> +
> +	src_clk = clk_get_sys(NULL, "i2s_src_clk");
> +	if (IS_ERR(src_clk)) {
> +		ret = PTR_ERR(src_clk);
> +		dev_err(dev->dev, "couldn't get i2s_src_sclk\n");
> +		goto put_sclk_clk;
> +	}
> +
> +	if (clk_set_parent(sclk_clk, src_clk))
> +		goto put_src_clk;
> +
> +	ret = clk_enable(sclk_clk);
> +	if (ret < 0) {
> +		dev_err(dev->dev, "enable i2s_sclk fail\n");
> +		goto put_src_clk;
> +	}
> +	return 0;

The clock requests should be being done as part of the probe, not here -
think what will happen when the driver is unloaded, the references will
never be released.  Similarly, the clock should be being enabled and
disabled as part of the normal driver flow.

Since the driver is just completely ignoring the clock rate that's
configured there probably shouldn't be a set_sysclk() function at all.

> +void
> +i2s_start_play(struct spear13xx_i2s_dev *dev,
> +		struct snd_pcm_substream *substream)
> +{

Non-exported functions should be static.

> +	/* for 2.0 audio*/
> +	if (dev->mode <= 2) {
> +		i2s_write_reg(dev->i2s_base, CCR, 0x00);
> +		if (!val) {
> +			i2s_write_reg(dev->i2s_base, RCR0, 0x2);

Some of these register writes are also done by the playback path but
there's no synchronisation between the playback and record paths.

> +void
> +i2s_stop(struct spear13xx_i2s_dev *dev, struct snd_pcm_substream *substream)
> +{
> +	i2s_write_reg(dev->i2s_base, IER, 0);
> +	i2s_write_reg(dev->i2s_base, IMR0, 0x33);
> +	i2s_write_reg(dev->i2s_base, IMR1, 0x33);
> +	i2s_write_reg(dev->i2s_base, ITER, 0);
> +	i2s_write_reg(dev->i2s_base, IRER, 0);
> +	i2s_write_reg(dev->i2s_base, CER, 0);
> +}

This appears to stop both playback and capture streams but the two
should be independant.

> +static irqreturn_t i2s_play_irq(int irq, void *_dev)
> +{
> +	struct spear13xx_i2s_dev *dev = (struct spear13xx_i2s_dev *)_dev;
> +	u32 ch0, ch1;
> +
> +	/* check for the tx data overrun condition */
> +	ch0 = i2s_read_reg(dev->i2s_base, ISR0) & 0x20;
> +	ch1 = i2s_read_reg(dev->i2s_base, ISR1) & 0x20;
> +	if (ch0 || ch1) {
> +
> +		/* disable i2s block */
> +		i2s_write_reg(dev->i2s_base, IER, 0);
> +
> +		/* disable tx block */
> +		i2s_write_reg(dev->i2s_base, ITER, 0);
> +
> +		/* flush all the tx fifo */
> +		i2s_write_reg(dev->i2s_base, TXFFR, 1);
> +
> +		/* clear tx data overrun interrupt: channel 0 */
> +		i2s_read_reg(dev->i2s_base, TOR0);
> +
> +		/* clear tx data overrun interrupt: channel 1 */
> +		i2s_read_reg(dev->i2s_base, TOR1);
> +	}

If we're overrunning or underrunning I'd expect to see some sort of
error report happening even if it's just a log.

> +static int
> +spear13xx_i2s_startup(struct snd_pcm_substream *substream,
> +		struct snd_soc_dai *cpu_dai)
> +{
> +	struct spear13xx_i2s_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
> +	u32 ret = 0;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		ret = request_irq(dev->play_irq, i2s_play_irq, 0,
> +				"spear13xx-i2s", dev);
> +	} else {
> +		ret = request_irq(dev->capture_irq, i2s_capture_irq,
> +				0, "spear13xx-i2s", dev);
> +	}

The interrupts should be acquired on probe, constantly requesting and
releasing them is undesirable.

> +	if (ret) {
> +		dev_err(dev->dev, "irq registration failure\n");
> +		iounmap(dev->i2s_base);
> +		clk_disable(dev->clk);
> +		clk_put(dev->clk);
> +		kfree(dev);
> +		release_mem_region(dev->res->start, resource_size(dev->res));
> +		return ret;
> +	}

This error handling is not associated with anything the startup()
function has done...

> +static int spear13xx_i2s_hw_params(struct snd_pcm_substream *substream,
> +		struct snd_pcm_hw_params *params,
> +		struct snd_soc_dai *dai)
> +{
> +	struct spear13xx_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
> +	u32 channel;
> +
> +	channel = params_channels(params);
> +
> +	dev->mode = channel;

Having channel here isn't doing a lot...

> +	/* mask i2s interrupt for channel 0 */
> +	i2s_write_reg(dev->i2s_base, IMR0, 0x33);
> +
> +	/* mask i2s interrupt for channel 1 */
> +	i2s_write_reg(dev->i2s_base, IMR1, 0x33);
> +
> +	i2s_stop(dev, substream);

Again, simultaneous playback and capture.

> +MODULE_AUTHOR("Rajeev Kumar");
> +MODULE_DESCRIPTION("SPEAr I2S SoC Interface");
> +MODULE_LICENSE("GPL");

Should have a MODULE_ALIAS() for autoloading.

> +#ifndef SPEAR_I2S_H
> +#define SPEAR_I2S_H
> +
> +#define MAX_CHANNEL_NUM		2
> +#define MIN_CHANNEL_NUM		2

These need namespacing.

> +	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
> +			SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
> +			SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
> +			SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
> +			SNDRV_PCM_RATE_KNOT),
> +	.rate_min = 48000,
> +	.rate_max = 48000,

These constraints don't agree with each other - the rate limits claim to
support 48kHz only, the rates setting tells a different story.

> +static int spear13xx_pcm_hw_params(struct snd_pcm_substream *substream,
> +		struct snd_pcm_hw_params *params)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct spear13xx_runtime_data *prtd = runtime->private_data;
> +	int ret;
> +
> +	ret = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
> +	if (ret < 0)
> +		return ret;
> +
> +	prtd->substream = substream;
> +	prtd->pos = 0;
> +	return 0;
> +}

Rather than passing the channel count through from the I2S driver you
could just get it directly here.

> +static void dma_configure(struct snd_pcm_substream *substream)
> +{
> +	struct spear13xx_runtime_data *prtd = substream->runtime->private_data;
> +
> +	dma_cap_zero(prtd->mask);
> +	dma_cap_set(DMA_SLAVE, prtd->mask);
> +
> +	prtd->slaves = &data;
> +	/* we need to pass physical address here */
> +	prtd->slaves->mem2i2s_slave.tx_reg = (dma_addr_t)prtd->txdma;
> +	prtd->slaves->mem2i2s_slave.rx_reg = 0;
> +	prtd->slaves->i2s2mem_slave.tx_reg = 0;
> +	prtd->slaves->i2s2mem_slave.rx_reg = (dma_addr_t)prtd->rxdma;
> +
> +	substream->runtime->private_data = prtd;
> +}
> +static bool filter(struct dma_chan *chan, void *slave)

Blank lines between functions please.

> +	dev_info(buf->dev.dev,
> +			" preallocate_dma_buffer: area=%p, addr=%p, size=%d\n",
> +			(void *)buf->area, (void *)buf->addr, size);

dev_dbg()

> +static struct platform_driver spear13xx_pcm_driver = {
> +	.driver = {
> +			.name = "spear-pcm-audio",
> +			.owner = THIS_MODULE,
> +	},

Fix indentation here.

> +MODULE_AUTHOR("Rajeev Kumar");
> +MODULE_DESCRIPTION("spear PCM DMA module");
> +MODULE_LICENSE("GPL");

MODULE_ALIAS() again please.
