From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] Blackfin I2S(TDM) CPU DAI driver
Date: Sat, 18 Jul 2009 11:12:54 +0100
Message-ID: <20090718101253.GA19473@sirena.org.uk>
References: <1247731207-26743-1-git-send-email-21cnbao@gmail.com>
	<1247731207-26743-3-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 385682452A
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Jul 2009 12:12:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1247731207-26743-3-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 16, 2009 at 04:00:06PM +0800, Barry Song wrote:
> Signed-off-by: Barry Song <21cnbao@gmail.com>
> Even though TDM mode can be as part of I2S DAI, but there
> are so much difference in configuration and data flow,
> it's very ugly to integrate I2S and TDM into a module.

This is broadly fine, though there are some issues below.

> +config SND_BF5XX_SOC_AD1938
> +	tristate "SoC AD1938 Audio support for Blackfin"
> +	depends on SND_BF5XX_TDM
> +	select SND_BF5XX_SOC_TDM
> +	select SND_SOC_AD1938
> +	help
> +	  Say Y if you want to add support for AD1938 codec on Blackfin.
> +

This should be in the following patch.

> +static void bf5xx_dma_irq(void *data)
> +{
> +	struct snd_pcm_substream *pcm = data;
> +	snd_pcm_period_elapsed(pcm);
> +}

> +static const struct snd_pcm_hardware bf5xx_pcm_hardware = {
> +	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_RESUME),

There are quite a few checkpatch issues such as this in the patch.

> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct sport_device *sport = runtime->private_data;
> +	int fragsize_bytes = frames_to_bytes(runtime, runtime->period_size);

> +	fragsize_bytes /= runtime->channels;
> +	fragsize_bytes *= 8;/* inflate the fragsize to match */

This could use some clarification - what is being matched here?

> +	snd_soc_set_runtime_hwparams(substream, &bf5xx_pcm_hardware);
> +
> +	ret = snd_pcm_hw_constraint_integer(runtime, \
> +			SNDRV_PCM_HW_PARAM_PERIODS);

There's no need to use a '\' here.

> +static int bf5xx_pcm_copy(struct snd_pcm_substream *substream, int channel,
> +		snd_pcm_uframes_t pos, void *buf, snd_pcm_uframes_t count)
> +{
> +	unsigned int *src;
> +	unsigned int *dst;
> +	int i;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		src = (unsigned int *)buf;
> +		dst = (unsigned int *)substream->runtime->dma_area;

You shouldn't need to cast away from void.

> +static int bf5xx_tdm_hw_params(struct snd_pcm_substream *substream,
> +		struct snd_pcm_hw_params *params,
> +		struct snd_soc_dai *dai)
> +{
> +	int ret = 0;
> +
> +	bf5xx_tdm.tcr2 &= ~0x1f;
> +	bf5xx_tdm.rcr2 &= ~0x1f;
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S32_LE:
> +		bf5xx_tdm.tcr2 |= 31;
> +		bf5xx_tdm.rcr2 |= 31;
> +		sport_handle->wdsize = 4;
> +		break;
> +	}

This ought to error out if it gets another format (though constraints
should prevent that).

> +	if (!bf5xx_tdm.configured) {
> +		/*
> +		 * TX and RX are not independent,they are enabled at the
> +		 * same time, even if only one side is running. So, we
> +		 * need to configure both of them at the time when the first
> +		 * stream is opened.
> +		 *
> +		 * CPU DAI:slave mode.

I can't see anywhere in the code where the configured flag is cleared.
If there's only one configuration that is supported you may as well just
set this up once on init rather than having this.

> +static int __init bfin_tdm_init(void)
> +{
> +	return snd_soc_register_dai(&bf5xx_tdm_dai);
> +}
> +module_init(bfin_tdm_init);

> +static void __exit bfin_tdm_exit(void)
> +{
> +	snd_soc_unregister_dai(&bf5xx_tdm_dai);
> +}
> +module_exit(bfin_tdm_exit);

This should be converted to use a platform device to probe the DAI, with
the DAI being registered in the probe() function of the platform device.
Most of the code in the existing probe() function to acquire resources
should also be merged into that probe function.

Doing this will be required at some point in the future since it is
needed to support some newer functionality such as better integration
with suspend and resume.
