From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH 06/14] ASoC: atmel-pcm-dma: No need to wrap
	snd_dmaengine_pcm_close()
Date: Mon, 25 Mar 2013 16:37:53 +0800
Message-ID: <51500CE1.7000804@atmel.com>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
 <1363957934-20059-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 652BE261688
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2013 09:38:53 +0100 (CET)
In-Reply-To: <1363957934-20059-7-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Lars,

On 3/22/2013 21:12, Lars-Peter Clausen wrote:
> If a PCM driver using the dmaengine PCM helper functions doesn't need to do
> anything special in its pcm_close callback, snd_dmaengine_pcm_close can be used
> directly for as the pcm_close callback and there is no need to wrap it in a
> custom function.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Bo Shen <voice.shen@atmel.com>

Tested-by: Bo Shen <voice.shen@atmel.com>
Acked-by: Bo Shen <voice.shen@atmel.com>

> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>   sound/soc/atmel/atmel-pcm-dma.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
> index 30184a4..396bf78 100644
> --- a/sound/soc/atmel/atmel-pcm-dma.c
> +++ b/sound/soc/atmel/atmel-pcm-dma.c
> @@ -199,16 +199,9 @@ static int atmel_pcm_open(struct snd_pcm_substream *substream)
>   	return 0;
>   }
>
> -static int atmel_pcm_close(struct snd_pcm_substream *substream)
> -{
> -	snd_dmaengine_pcm_close(substream);
> -
> -	return 0;
> -}
> -
>   static struct snd_pcm_ops atmel_pcm_ops = {
>   	.open		= atmel_pcm_open,
> -	.close		= atmel_pcm_close,
> +	.close		= snd_dmaengine_pcm_close,
>   	.ioctl		= snd_pcm_lib_ioctl,
>   	.hw_params	= atmel_pcm_hw_params,
>   	.prepare	= atmel_pcm_dma_prepare,
>
