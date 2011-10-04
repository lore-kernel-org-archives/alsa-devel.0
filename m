From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: omap-pcm: Fix the no period wakeup
	implementation
Date: Tue, 04 Oct 2011 11:34:28 +0300
Message-ID: <4E8AC514.1030002@bitmer.com>
References: <1317715792-30279-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E4F82457D
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 10:34:40 +0200 (CEST)
In-Reply-To: <1317715792-30279-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 10/04/2011 11:09 AM, Peter Ujfalusi wrote:
> After omap_request_dma the BLOCK_IRQ is enabled as default
> configuration for the channel.
> If we are requested for no period wakeup, we need to disable
> the BLOCK_IRQ in order to not receive any interrupts.
>
> Signed-off-by: Peter Ujfalusi<peter.ujfalusi@ti.com>
> ---
>   sound/soc/omap/omap-pcm.c |    8 ++++++++
>   1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index 9b5c88a..5e37ec9 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -198,6 +198,14 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
>   			      OMAP_DMA_LAST_IRQ | OMAP_DMA_BLOCK_IRQ);
>   	else if (!substream->runtime->no_period_wakeup)
>   		omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ);
> +	else {
> +		/*
> +		 * No period wakeup:
> +		 * we need to disable BLOCK_IRQ, which is enabled by the omap
> +		 * dma core at request dma time.
> +		 */
> +		omap_disable_dma_irq(prtd->dma_ch, OMAP_DMA_BLOCK_IRQ);
> +	}
>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

while it would be more clear to fix this in omap dma core.
