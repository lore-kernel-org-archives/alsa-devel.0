From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 1/2] alsa: ASoC driver for s6000
	I2S	interface
Date: Thu, 26 Mar 2009 14:15:03 +0000
Message-ID: <20090326141503.GD3771@sirena.org.uk>
References: <1238074574-24734-1-git-send-email-dg@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 91CD310385B
	for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2009 15:15:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1238074574-24734-1-git-send-email-dg@emlix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Gl??ckner <dg@emlix.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 26, 2009 at 02:36:13PM +0100, Daniel Gl??ckner wrote:

> This patch adds a driver for the I2S interface found on Stretch s6000
> family processors.

Thanks for this.  It looks basically good - there's some issues below,
several of which appear to be due to this having been done against a
slightly old kernel version.  Please see the topic/asoc branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

for the most current code.

> +config SND_S6000_SOC
> +	tristate "SoC Audio for the Stretch s6000 family"
> +	depends on XTENSA_VARIANT_S6000 && SND_SOC
> +	help

I'm not seeing any hits on XTENSA_VARIANT_S6000 in next?  While that
shouldn't hurt immediately since it'll just never appear it'd be good to
make sure that the APIs this depends on are going into mainline in the
form they're in.  Do you know what the status is there?

The SND_SOC isn't required due to the use of menuconfig in the sound/soc
directory.

> +static int __devinit s6000_i2s_probe(struct platform_device *pdev,
> +				     struct snd_soc_dai *dai)
> +{
> +	struct s6000_i2s_dev *dev;
> +	struct resource *scbmem, *sifmem, *region, *dma_in, *dma_out;
> +	struct s6000_snd_platform_data *pdata;
> +	u8 __iomem *mmio;
> +	int ret;
> +
> +	pdata = pdev->dev.platform_data;
> +
> +	scbmem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!scbmem) {

With current ASoC it is now possible for the DAIs to be probed using the
regular device model and register with the core when that happens.  The
core will delay probe of the card until all components have registered
with it.  For CPU side stuff this means that you can provide a standard
set of resources for the device in your architecture code without having
to have all the machines replicate them in their soc-audio device.

Look at the PXA AC97 driver for an example of this on the platform side.

> +#define S6000_I2S_RATES	(SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_KNOT | \
> +			 SNDRV_PCM_RATE_5512 | SNDRV_PCM_RATE_8000_192000)

SND_PCM_RATE_KNOT doesn't work with ASoC (though it shouldn't do any
harm since it'll just get removed).

> +	.ops = {
> +		.set_fmt = s6000_i2s_set_dai_fmt,
> +		.set_clkdiv = s6000_i2s_set_clkdiv,
> +		.hw_params = s6000_i2s_hw_params,
> +	}

This won't build with current ASoC, the DAI ops have been moved out of
line.

> +static inline void s6_i2s_write_reg(struct s6000_i2s_dev *dev, int reg, u32 val)
> +{
> +	writel(val, dev->scbbase + reg);
> +}

Any reason to expose these to users? 

> +static inline void s6000_i2s_start_channel(struct s6000_i2s_dev *dev,
> +					   int channel)
> +{

This and the rest of the functions in the file look especially like it
should be in the body of the driver.  It also looks a little large to be
forcing inline?

> +#define S6000_PCM_DEBUG 0
> +#if S6000_PCM_DEBUG
> +#define DPRINTK(x...) printk(KERN_DEBUG x)
> +#else
> +#define DPRINTK(x...)
> +#endif

Use the standard pr_dbg() (or dev_dbg()), no need to reproduce it.

> +	if (unlikely(i2s_errors & S6_I2S_INT_ALIGNMENT)) {
> +		printk(KERN_ERR "s6000-i2s: Alignment Error\n");


> +	if (unlikely(i2s_errors & S6_I2S_INT_UNDERRUN) &&
> +	    playback->runtime &&
> +	    snd_pcm_running(playback)) {
> +		printk(KERN_WARNING "s6000-i2s: Tx Underrun\n");
> +		s6000_i2s_start(playback);
> +
> +		prtd = playback->runtime->private_data;
> +		spin_lock(&prtd->lock);
> +		s6000_pcm_enqueue_dma(playback);
> +		/* a second descriptor will be queued below */
> +		spin_unlock(&prtd->lock);

Hrm.  ALSA has underrun handling mechanisms as standard?

> +	for (i = 0; i < 2; ++i) {

Magic number here - ARRAY_SIZE()?

> +int s6000_pcm_start(struct snd_pcm_substream *substream)
> +{
> +	struct s6000_runtime_data *prtd = substream->runtime->private_data;
> +	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
> +	struct s6000_pcm_dma_params *par = soc_runtime->dai->cpu_dai->dma_data;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&prtd->lock, flags);
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		s6dmac_enable_chan(DMA_MASK_DMAC(par->dma_out),
> +				   DMA_INDEX_CHNL(par->dma_out),
> +				   1, 0, 1, 0, 0, 0, 0, 4, -1, 0, 0, 1);

Hrm.  Lots of magic numbers here but it seems to come from the API
you're using so not much doing I guess.
