From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 1/2] ASoC: DaVinci: McASP driver enhacements
Date: Fri, 07 Aug 2009 12:59:05 -0700
Message-ID: <4A7C8789.40408@boundarydevices.com>
References: <1249654062-23634-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth00.csee.onr.siteprotect.com
	(smtpauth00.csee.onr.siteprotect.com [64.26.60.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 49AB624156
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 21:59:20 +0200 (CEST)
In-Reply-To: <1249654062-23634-1-git-send-email-chaithrika@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

Chaithrika U S wrote:
> ---
>  sound/soc/davinci/davinci-mcasp.c |  113 ++++++++++++++++++++++++++++++++++--
>  sound/soc/davinci/davinci-mcasp.h |    5 ++
>  sound/soc/davinci/davinci-pcm.c   |    4 +-
>  sound/soc/davinci/davinci-pcm.h   |    1 +
>  4 files changed, 115 insertions(+), 8 deletions(-)

.....
> diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
> index 8fd0c3c..1e2dfd0 100644
> --- a/sound/soc/davinci/davinci-pcm.c
> +++ b/sound/soc/davinci/davinci-pcm.c
> @@ -67,6 +67,7 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
>  	dma_addr_t src, dst;
>  	unsigned short src_bidx, dst_bidx;
>  	unsigned int data_type;
> +	unsigned short acnt;
>  	unsigned int count;
>  
>  	period_size = snd_pcm_lib_period_bytes(substream);
> @@ -91,11 +92,12 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
>  		dst_bidx = data_type;
>  	}
>  
> +	acnt = prtd->params->acnt;
>  	edma_set_src(lch, src, INCR, W8BIT);
>  	edma_set_dest(lch, dst, INCR, W8BIT);
>  	edma_set_src_index(lch, src_bidx, 0);
>  	edma_set_dest_index(lch, dst_bidx, 0);
> -	edma_set_transfer_params(lch, data_type, count, 1, 0, ASYNC);
> +	edma_set_transfer_params(lch, acnt, count, 1, 0, ASYNC);

Since I see no change to davinci-i2s, I think this will break any platform which
uses davinci-i2s.

>  
>  	prtd->period++;
>  	if (unlikely(prtd->period >= runtime->periods))
> diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
> index eb4287f..63d9625 100644
> --- a/sound/soc/davinci/davinci-pcm.h
> +++ b/sound/soc/davinci/davinci-pcm.h
> @@ -19,6 +19,7 @@
>  struct davinci_pcm_dma_params {
>  	char *name;			/* stream identifier */
>  	int channel;			/* sync dma channel ID */
> +	unsigned short acnt;
>  	dma_addr_t dma_addr;		/* device physical address for DMA */
>  	enum dma_event_q eventq_no;	/* event queue number */
>  	unsigned char data_type;	/* xfer data type */
