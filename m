From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/4] ASoC: Staticise jz4740_pcm_new()
Date: Wed, 21 Sep 2011 16:09:18 +0200
Message-ID: <4E79F00E.7030306@metafoo.de>
References: <1316587205.2824.1.camel@phoenix> <1316587310.2824.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316587310.2824.3.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/21/2011 08:41 AM, Axel Lin wrote:
> It is not used outside this driver so no need to make the symbol global.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>  sound/soc/jz4740/jz4740-pcm.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/jz4740/jz4740-pcm.c b/sound/soc/jz4740/jz4740-pcm.c
> index a7c9578..d1989cd 100644
> --- a/sound/soc/jz4740/jz4740-pcm.c
> +++ b/sound/soc/jz4740/jz4740-pcm.c
> @@ -299,7 +299,7 @@ static void jz4740_pcm_free(struct snd_pcm *pcm)
>  
>  static u64 jz4740_pcm_dmamask = DMA_BIT_MASK(32);
>  
> -int jz4740_pcm_new(struct snd_soc_pcm_runtime *rtd)
> +static int jz4740_pcm_new(struct snd_soc_pcm_runtime *rtd)
>  {
>  	struct snd_card *card = rtd->card->snd_card;
>  	struct snd_soc_dai *dai = rtd->cpu_dai;
