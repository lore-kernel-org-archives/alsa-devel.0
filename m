From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: uniphier: fix an error code in
 uniphier_aio_comprdma_new()
Date: Wed, 14 Feb 2018 19:37:04 +0900
Message-ID: <264ac405-64a9-f14e-4c37-18dc2a789261@socionext.com>
References: <20180214071531.GB26677@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20180214071531.GB26677@mwanda>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


Hello,

Thank you for fixing, this patch works fine
on UniPhier LD20 board.

Tested-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>


On 2018年02月14日 16:15, Dan Carpenter wrote:
> The dma_mapping_error() returns true or false, but we want to return
> -ENOMEM if there was an error.
> 
> Fixes: e98131222ff9 ("ASoC: uniphier: add support for UniPhier AIO compress audio")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/sound/soc/uniphier/aio-compress.c b/sound/soc/uniphier/aio-compress.c
> index 7f7abe3ae99d..4751c8bdabec 100644
> --- a/sound/soc/uniphier/aio-compress.c
> +++ b/sound/soc/uniphier/aio-compress.c
> @@ -54,12 +54,11 @@ static int uniphier_aio_comprdma_new(struct snd_soc_pcm_runtime *rtd)
>   		dma_dir = DMA_TO_DEVICE;
>   
>   	sub->compr_addr = dma_map_single(dev, sub->compr_area, size, dma_dir);
> -	ret = dma_mapping_error(dev, sub->compr_addr);
> -	if (ret) {
> +	if (dma_mapping_error(dev, sub->compr_addr)) {
>   		kfree(sub->compr_area);
>   		sub->compr_area = NULL;
>   
> -		return ret;
> +		return -ENOMEM;
>   	}
>   
>   	sub->compr_bytes = size;
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

