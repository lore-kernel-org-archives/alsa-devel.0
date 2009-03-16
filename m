From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/9] ARM: DaVinci: ASoC: Adds ALSA
	SoC	McASP Audio Layer for TI DM646X processor
Date: Mon, 16 Mar 2009 15:11:32 +0000
Message-ID: <20090316151129.GD16539@sirena.org.uk>
References: <1237204977-30075-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DB1982433E
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 16:11:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1237204977-30075-1-git-send-email-naresh@ti.com>
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

On Mon, Mar 16, 2009 at 08:02:57AM -0400, Naresh Medisetty wrote:
> Adds ALSA SoC McASP Audio Layer for TI DM646X processor.

This patch should come before the machine support that uses it in your
patch series.

> 
> Signed-off-by: Naresh Medisetty <naresh@ti.com>
> ---
> This patch applies on the ASoC tree available at http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-asoc.git;a=commit;h=168776ef58d38503f8ac4f8a7eb1039137208032.

Please submit ASoC patches against ALSA mainline - that's the topic/asoc
branch of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
(specifying which branch you're working against in that form rather than
a gitweb URL is more common, BTW).

> +#include "davinci-pcm.h"
> +#include "davinci-i2s-mcasp.h"

This file isn't present in the tree?  You should try to submit patches
in an order where all the bits required for the patch are in the tree
when it's applied.

> +static inline void mcasp_set_ctl_reg(void __iomem *regs, u32 val)
> +{
> +	mcasp_set_bits(regs, val);
> +	while ((mcasp_get_reg(regs) & val) != val)
> +		;
> +}

This will lock up hard if the write fails...  Also, there should be a
blank line between this and the following function.

> +int davinci_i2s_startup(struct snd_pcm_substream *substream,
> +							struct snd_soc_dai *dai)

Indentation.

> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> +	struct davinci_audio_dev *dev = rtd->dai->cpu_dai->private_data;
> +
> +	cpu_dai->dma_data = dev->dma_params[substream->stream];
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(davinci_i2s_startup);

Why is this being exported?

Please also note that all ASoC core APIs are EXPORT_SYMBOL_GPL.

> +		cpu_dai = card->dai_link[link_cnt].cpu_dai;
> +		cpu_dai->private_data = &dev[link_cnt];
> +		pdata = &parray[link_cnt];
> +		dev[link_cnt].clk = clk_get(&pdev->dev, NULL);

I'd really expect to have a name for the clock here.

> +		if (IS_ERR(dev[link_cnt].clk)) {
> +			ret = -ENODEV;
> +			backup_count = 2;

This backup count stuff is very obscure - it really either needs some
comments to explain what it's doing or a restructuring of the code.  I
suspect that having a probe_one() fuction which you call in a loop and
which does its own unwinding is the most sensible approach, it looks
like what you're trying to simulate here.

> +EXPORT_SYMBOL(davinci_i2s_mcasp_remove);

Again, why is this being exported?

> +	/* wait for TX ready */
> +	while (!(mcasp_get_reg(dev->base + DAVINCI_MCASP_XRSRCTL_REG(0))
> +				& TXSTATE))
> +		;

This is also going to lock up on error...

> +struct snd_soc_dai davinci_iis_mcasp_dai[] = {
> +	{
> +		.name = "davinci-i2s",
> +		.id = 0,
> +		.probe = davinci_i2s_mcasp_probe,
> +		.remove = davinci_i2s_mcasp_remove,
> +		.playback = {
> +			.channels_min = 1,
> +			.channels_max = 384,
> +			.rates = DAVINCI_I2S_RATES,
> +			.formats = SNDRV_PCM_FMTBIT_S16_LE,
> +		},

The code above suggested that you supported rather more sample sizes
than this?

> +		.ops = {
> +			.startup = davinci_i2s_startup,
> +			.trigger = davinci_i2s_mcasp_trigger,
> +			.hw_params = davinci_i2s_mcasp_hw_params,
> +			.set_fmt = davinci_i2s_mcasp_set_dai_fmt,
> +		},

This needs to be updated for current ASoC.
