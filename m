From: Petr Cvek <petr.cvek@tul.cz>
Subject: Re: [PATCH v4] Sound: PXA: Fix settings of PXAxxx DMA
Date: Fri, 27 Feb 2015 13:15:18 +0100
Message-ID: <54F05FD6.6080702@tul.cz>
References: <54CA125D.7010908@tul.cz> <54CA2B7E.5010003@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bubo.tul.cz (bubo.tul.cz [147.230.16.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BB8B260703
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 13:12:15 +0100 (CET)
In-Reply-To: <54CA2B7E.5010003@tul.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, haojian.zhuang@gmail.com, daniel@zonque.org, robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

bump

On 29.1.2015 13:45, Petr Cvek wrote:
> Fix PXA DMA autoincrementation, so capture will not use playback settings
> (incrementation in register space instead in target buffer).
> 
> Regression from:
>   'commit d65a14587a9be853a887a1407db133df1fb68e29 ("ASoC: pxa: use snd_dmaengine_dai_dma_data")'
> 
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> Acked-by: Daniel Mack <daniel@zonque.org>
> ---
>  sound/arm/pxa2xx-pcm-lib.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
> index 01f8fdc..f8ca3ca 100644
> --- a/sound/arm/pxa2xx-pcm-lib.c
> +++ b/sound/arm/pxa2xx-pcm-lib.c
> @@ -45,7 +45,12 @@ int __pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
>  	size_t period = params_period_bytes(params);
>  	pxa_dma_desc *dma_desc;
>  	dma_addr_t dma_buff_phys, next_desc_phys;
> -	u32 dcmd = DCMD_INCSRCADDR | DCMD_FLOWTRG;
> +	u32 dcmd = 0;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		dcmd = DCMD_INCSRCADDR | DCMD_FLOWTRG;
> +	else
> +		dcmd = DCMD_INCTRGADDR | DCMD_FLOWSRC;
>  
>  	/* temporary transition hack */
>  	switch (rtd->params->addr_width) {
> 
