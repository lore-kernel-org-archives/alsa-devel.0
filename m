From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 03/17] ASoC: Add a generic dmaengine_pcm
	driver
Date: Mon, 15 Apr 2013 17:15:30 -0600
Message-ID: <516C8A12.4020405@wwwdotorg.org>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id C718F2625D9
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 01:15:36 +0200 (CEST)
In-Reply-To: <1366046404-8759-4-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Laxman Dewangan <ldewangan@nvidia.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 04/15/2013 11:19 AM, Lars-Peter Clausen wrote:
> This patch adds a generic dmaengine PCM driver. It builds on top of the
> dmaengine PCM library and adds the missing pieces like DMA channel management,
> buffer management and channel configuration. It will be able to replace the
> majority of the existing platform specific dmaengine based PCM drivers.

> Devicetree is used to map the DMA channels to the PCM device.
...
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
...
> +static const char * const dmaengine_pcm_dma_channel_names[] = {
> +	[SNDRV_PCM_STREAM_PLAYBACK] = "tx",
> +	[SNDRV_PCM_STREAM_CAPTURE] = "rx",
> +};
...
> +int snd_dmaengine_pcm_register(struct device *dev,
> +	const struct snd_dmaengine_pcm_config *config, unsigned int flags)
...
> +	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
> +		pcm->chan[i] = of_dma_request_slave_channel(dev->of_node,
> +					dmaengine_pcm_dma_channel_names[i]);

That all means that the Tegra patch won't work yet. Tegra currently uses
a custom DT binding for DMA since we haven't fully converted everything
over the very new DT DMA bindings. So, the patches for Tegra may well be
fine /if/ staged in the correct order with some .dts file changes too.

I wonder if all the other platforms this series modifies already have
the appropriate DMA properties set up? A very quick look implies that
(at least some) imx and omap do, but I'm not sure about spear, ep93xx,
ux500?

Perhaps Laxman can provide appropriate DT fixes for Tegra while I'm on
vacation, and test out this series, if I don't get to it in the next 2
days before my vacation.
