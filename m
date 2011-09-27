From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH] ASoC: Flush Samsung DMA on free
Date: Tue, 27 Sep 2011 09:05:15 +0900
Message-ID: <003b01cc7ca9$228b3f10$67a1bd30$%kim@samsung.com>
References: <1316557614-32044-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 89938103902
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 02:05:20 +0200 (CEST)
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0LS500LR1MWR6LB0@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 27 Sep 2011 09:05:16 +0900 (KST)
Received: from kgenekim ([12.23.120.114])
	by mmp2.samsung.com (Oracle Communications Messaging Exchange Server
	7u4-19.01 64bit (built Sep 7 2010)) with ESMTPA id
	<0LS500FWQMWRZH00@mmp2.samsung.com>
	for alsa-devel@alsa-project.org; Tue, 27 Sep 2011 09:05:15 +0900 (KST)
In-reply-to: <1316557614-32044-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Liam Girdwood' <lrg@ti.com>, 'Boojin Kim' <boojin.kim@samsung.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> 
> Ever since it was written the Samsung DMA driver has had a TODO in the
> hw_free() function wondering if we need to flush the DMA buffers. Up until
> now the answer has been no but with the recent improvements Boojin has
> done to the DMA infrastructure for the Samsung port the answer has changed
> to yes for at least S3C6410 systems.
> 
> If we don't then when we next prepare() the channel the API will get
> confused trying to run callbacks on the transfers hanging around from the
> previous time the stream was open and oops.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> Kukjin, this should probably get added to your branch assuming it's OK
> for other CPUs.
> 
Looks ok to me, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

>  sound/soc/samsung/dma.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
> index 851346f..2d622b6 100644
> --- a/sound/soc/samsung/dma.c
> +++ b/sound/soc/samsung/dma.c
> @@ -198,10 +198,10 @@ static int dma_hw_free(struct snd_pcm_substream
> *substream)
> 
>  	pr_debug("Entered %s\n", __func__);
> 
> -	/* TODO - do we need to ensure DMA flushed */
>  	snd_pcm_set_runtime_buffer(substream, NULL);
> 
>  	if (prtd->params) {
> +		prtd->params->ops->flush(prtd->params->ch);
>  		prtd->params->ops->release(prtd->params->ch,
>  					prtd->params->client);
>  		prtd->params = NULL;
> --
> 1.7.6.3
