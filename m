From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: typo
Date: Mon, 22 Dec 2008 17:05:59 +0000
Message-ID: <1229965559.11643.35.camel@vega.slimlogic.co.uk>
References: <494FC30D.8060909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from slimlogic.co.uk (slimlogic.co.uk [89.16.172.20])
	by alsa0.perex.cz (Postfix) with ESMTP id E6429103811
	for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2008 18:06:00 +0100 (CET)
In-Reply-To: <494FC30D.8060909@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2008-12-22 at 17:40 +0100, Roel Kluin wrote:
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index acd68ef..227c865 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -97,7 +97,7 @@ static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
>  	prtd->dma_data = dma_data;
>  	err = omap_request_dma(dma_data->dma_req, dma_data->name,
>  			       omap_pcm_dma_irq, substream, &prtd->dma_ch);
> -	if (!err & !cpu_is_omap1510()) {
> +	if (!err && !cpu_is_omap1510()) {
>  		/*
>  		 * Link channel with itself so DMA doesn't need any
>  		 * reprogramming while looping the buffer

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>

Liam
