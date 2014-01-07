From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH] ASoC: atmel-pcm-dma: Remove
 SND_DMAENGINE_PCM_FLAG_NO_RESIDUE flag
Date: Tue, 7 Jan 2014 17:05:29 +0800
Message-ID: <52CBC359.7010906@atmel.com>
References: <1389018629-11513-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SJOEDG01.corp.atmel.com (nasmtp02.atmel.com [204.2.163.16])
 by alsa0.perex.cz (Postfix) with ESMTP id C259F26167D
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 10:05:55 +0100 (CET)
In-Reply-To: <1389018629-11513-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Elen Song <elen.song@atmel.com>, Mark Brown <broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Lars,

On 01/06/2014 10:30 PM, Lars-Peter Clausen wrote:
> Since commit d48de6f1a ("DMA: AT91: Get residual bytes in dma buffer") the
> at91-dma driver has support for residue reporting. So there is no need to
> specify the SND_DMAENGINE_PCM_FLAG_NO_RESIDUE flag. This allows for a finer
> grained resolution of the PCM pointer as well as avoids the race condition that
> can occur with the period counting that is used when the dmaengine driver does
> not support residue reporting.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>
> ---
> I don't have the hardware, so only compile tested. It should work though if the
> residue calculation in the dma driver is implemented correctly.
> ---
>   sound/soc/atmel/atmel-pcm-dma.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Thanks for your patch.

For the dma get residue code, we are improving it. So, I think we'd 
better waiting the improvement done and after let this patch go into 
mainline.

What do you think?

> diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
> index 06082e5..ba1366a 100644
> --- a/sound/soc/atmel/atmel-pcm-dma.c
> +++ b/sound/soc/atmel/atmel-pcm-dma.c
> @@ -129,8 +129,7 @@ static const struct snd_dmaengine_pcm_config atmel_dmaengine_pcm_config = {
>
>   int atmel_pcm_dma_platform_register(struct device *dev)
>   {
> -	return snd_dmaengine_pcm_register(dev, &atmel_dmaengine_pcm_config,
> -			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
> +	return snd_dmaengine_pcm_register(dev, &atmel_dmaengine_pcm_config, 0);
>   }
>   EXPORT_SYMBOL(atmel_pcm_dma_platform_register);
>
>

Best Regards,
Bo Shen
