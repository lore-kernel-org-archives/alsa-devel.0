From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/5] ARM: DaVinci: ASoC: Add mcasp
	support	for DM646x
Date: Thu, 2 Apr 2009 16:06:41 +0100
Message-ID: <20090402150641.GI4527@sirena.org.uk>
References: <1238723238-27360-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F0F18243F3
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 17:06:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1238723238-27360-1-git-send-email-naresh@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Naresh Medisetty <naresh@ti.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 02, 2009 at 09:47:18PM -0400, Naresh Medisetty wrote:

This all looks pretty good - the comments below are all pretty small,
mostly coding style and questions.

> +
> +	/* programming GBLCTL needs to read back from GBLCTL and verfiy */
> +	/* loop count is to avoid the lock-up */
> +	for (i = 0; (i < 1000) && ((mcasp_get_reg(regs) & val) != val); i++);

Should this warn if the loop times out?  For legibility I'd rewrite as:

	for (i = 0; i < 1000; i++)
		if ((mcasp_get_reg(regs) & val) == val)
			break;

The ; should be on a separate line at least.

> +int davinci_i2s_startup(struct snd_pcm_substream *substream,
> +							struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> +	struct davinci_audio_dev *dev = rtd->dai->cpu_dai->private_data;
> +
> +	cpu_dai->dma_data = dev->dma_params[substream->stream];

cpu_dai is passed in as the dai parameter, no need to look it up like
this (in the past it wasn't - most of the code hasn't yet been fixed up
to take advantage of this yet).

> +int davinci_i2s_mcasp_probe(struct platform_device *pdev,
> +							struct snd_soc_dai *dai)

Indentation?

> +		mem = platform_get_resource(pdev, IORESOURCE_MEM, link_cnt);
> +		if (!mem) {
> +			dev_err(&pdev->dev, "no mem resource?\n");
> +			ret = -ENODEV;
> +		}
> +		ioarea = request_mem_region(mem->start,
> +				(mem->end - mem->start) + 1, pdev->name);
> +		if (!ioarea) {
> +			dev_err(&pdev->dev, "Audio region already claimed\n");
> +			ret = -EBUSY;
> +		}

Should these be jumping to the unwind code?

> +
> +		dev = kzalloc(sizeof(struct davinci_audio_dev) *
> +			card->num_links, GFP_KERNEL);
> +		if (!dev) {
> +			return	-ENOMEM;
> +			goto err_release_region;
> +		}

return followed by goto?

> +		dma_data = kzalloc(sizeof(struct davinci_pcm_dma_params) *
> +					(card->num_links << 1), GFP_KERNEL);
> +		if (!dma_data)
> +				goto err_release_dev;

Do you need to set ret here?

> +	}
> +}
> +static void davinci_hw_iis_param(struct snd_pcm_substream *substream)

Blank line between functions, please.

> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		/* bit stream is MSB first */
> +		mcasp_set_bits(dev->base + DAVINCI_MCASP_AHCLKXCTL_REG,
> +				AHCLKXE);

For I2S you should have one BCLK before MSB - is that happening (it may
well be, I've no knowledge of your hardware)?

> +	} else {
> +		/* bit stream is MSB first with no delay */
> +		mcasp_set_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
> +				FSRDLY(1) | RXORD);

The comment and code don't look like they match up (but again, I don't
have any knowledge of this specific hardware).
