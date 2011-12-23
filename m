From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 5/5] ASoC: mxs: correct 'direction' of
 device_prep_dma_cyclic
Date: Fri, 23 Dec 2011 21:37:00 +0530
Message-ID: <1324656420.1633.15.camel@vkoul-udesk3>
References: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
	<1323848866-19768-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id B3BB510405A
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 17:07:00 +0100 (CET)
In-Reply-To: <1323848866-19768-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Dong Aisheng <dong.aisheng@linaro.org>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-12-14 at 15:47 +0800, Shawn Guo wrote:
> The commit 49920bc (dmaengine: add new enum dma_transfer_direction)
> changes the type of parameter 'direction' of device_prep_dma_cyclic
> from dma_data_direction to dma_transfer_direction.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  sound/soc/mxs/mxs-pcm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
> index 0e12f4e..105f42a 100644
> --- a/sound/soc/mxs/mxs-pcm.c
> +++ b/sound/soc/mxs/mxs-pcm.c
> @@ -136,7 +136,7 @@ static int snd_mxs_pcm_hw_params(struct snd_pcm_substream *substream,
>  			iprtd->period_bytes * iprtd->periods,
>  			iprtd->period_bytes,
>  			substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
> -			DMA_TO_DEVICE : DMA_FROM_DEVICE);
> +			DMA_MEM_TO_DEV : DMA_DEV_TO_MEM);
>  	if (!iprtd->desc) {
>  		dev_err(&chan->dev->device, "cannot prepare slave dma\n");
>  		return -EINVAL;

Has this been applied in soc tree? I don't see it in linux-next or do
you want this to go thru slave-dma?

-- 
~Vinod
