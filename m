From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: davinci-pcm: trivial: replace link
 with actual chan/link
Date: Tue, 13 Sep 2011 17:16:18 +0100
Message-ID: <1315930578.5157.17.camel@odin>
References: <1315602365-30105-1-git-send-email-bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog111.obsmtp.com (na3sys009aog111.obsmtp.com
	[74.125.149.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F9DC103993
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 18:16:23 +0200 (CEST)
Received: by mail-ww0-f43.google.com with SMTP id 27so783735wwf.24
	for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2011 09:16:22 -0700 (PDT)
In-Reply-To: <1315602365-30105-1-git-send-email-bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sekhar Nori <nsekhar@ti.com>, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-09-09 at 17:06 -0400, Ben Gardiner wrote:
> The ambiguously named variable 'link' is used as a temporary throughout
> davinci-pcm -- its presence makes grepping (and groking) the code
> difficult.
> 
> Replace link with the value of link in almost all sites. The exception
> is a couple places where the last-assigned link/chan needs to be
> returned by a function -- in these cases, rename to last_link.
> 
> Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>

Acked-by: Liam Girdwood <lrg@ti.com>

> ---
>  sound/soc/davinci/davinci-pcm.c |  123 +++++++++++++++++++--------------------
>  1 files changed, 59 insertions(+), 64 deletions(-)
> 
> diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
> index a49e667..d5fe08c 100644
> --- a/sound/soc/davinci/davinci-pcm.c
> +++ b/sound/soc/davinci/davinci-pcm.c
> @@ -180,7 +180,6 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
>  {
>  	struct davinci_runtime_data *prtd = substream->runtime->private_data;
>  	struct snd_pcm_runtime *runtime = substream->runtime;
> -	int link = prtd->asp_link[0];
>  	unsigned int period_size;
>  	unsigned int dma_offset;
>  	dma_addr_t dma_pos;
> @@ -198,7 +197,8 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
>  	fifo_level = prtd->params->fifo_level;
>  
>  	pr_debug("davinci_pcm: audio_set_dma_params_play channel = %d "
> -		"dma_ptr = %x period_size=%x\n", link, dma_pos, period_size);
> +		"dma_ptr = %x period_size=%x\n", prtd->asp_link[0], dma_pos,
> +		period_size);
>  
>  	data_type = prtd->params->data_type;
>  	count = period_size / data_type;
> @@ -222,17 +222,19 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
>  	}
>  
>  	acnt = prtd->params->acnt;
> -	edma_set_src(link, src, INCR, W8BIT);
> -	edma_set_dest(link, dst, INCR, W8BIT);
> +	edma_set_src(prtd->asp_link[0], src, INCR, W8BIT);
> +	edma_set_dest(prtd->asp_link[0], dst, INCR, W8BIT);
>  
> -	edma_set_src_index(link, src_bidx, src_cidx);
> -	edma_set_dest_index(link, dst_bidx, dst_cidx);
> +	edma_set_src_index(prtd->asp_link[0], src_bidx, src_cidx);
> +	edma_set_dest_index(prtd->asp_link[0], dst_bidx, dst_cidx);
>  
>  	if (!fifo_level)
> -		edma_set_transfer_params(link, acnt, count, 1, 0, ASYNC);
> +		edma_set_transfer_params(prtd->asp_link[0], acnt, count, 1, 0,
> +							ASYNC);
>  	else
> -		edma_set_transfer_params(link, acnt, fifo_level, count,
> -							fifo_level, ABSYNC);
> +		edma_set_transfer_params(prtd->asp_link[0], acnt, fifo_level,
> +							count, fifo_level,
> +							ABSYNC);
>  }
>  
>  static void davinci_pcm_dma_irq(unsigned link, u16 ch_status, void *data)
> @@ -305,7 +307,6 @@ static int ping_pong_dma_setup(struct snd_pcm_substream *substream)
>  	unsigned int acnt = params->acnt;
>  	/* divide by 2 for ping/pong */
>  	unsigned int ping_size = snd_pcm_lib_period_bytes(substream) >> 1;
> -	int link = prtd->asp_link[1];
>  	unsigned int fifo_level = prtd->params->fifo_level;
>  	unsigned int count;
>  	if ((data_type == 0) || (data_type > 4)) {
> @@ -316,28 +317,26 @@ static int ping_pong_dma_setup(struct snd_pcm_substream *substream)
>  		dma_addr_t asp_src_pong = iram_dma->addr + ping_size;
>  		ram_src_cidx = ping_size;
>  		ram_dst_cidx = -ping_size;
> -		edma_set_src(link, asp_src_pong, INCR, W8BIT);
> +		edma_set_src(prtd->asp_link[1], asp_src_pong, INCR, W8BIT);
>  
> -		link = prtd->asp_link[0];
> -		edma_set_src_index(link, data_type, data_type * fifo_level);
> -		link = prtd->asp_link[1];
> -		edma_set_src_index(link, data_type, data_type * fifo_level);
> +		edma_set_src_index(prtd->asp_link[0], data_type,
> +				data_type * fifo_level);
> +		edma_set_src_index(prtd->asp_link[1], data_type,
> +				data_type * fifo_level);
>  
> -		link = prtd->ram_link;
> -		edma_set_src(link, runtime->dma_addr, INCR, W32BIT);
> +		edma_set_src(prtd->ram_link, runtime->dma_addr, INCR, W32BIT);
>  	} else {
>  		dma_addr_t asp_dst_pong = iram_dma->addr + ping_size;
>  		ram_src_cidx = -ping_size;
>  		ram_dst_cidx = ping_size;
> -		edma_set_dest(link, asp_dst_pong, INCR, W8BIT);
> +		edma_set_dest(prtd->asp_link[1], asp_dst_pong, INCR, W8BIT);
>  
> -		link = prtd->asp_link[0];
> -		edma_set_dest_index(link, data_type, data_type * fifo_level);
> -		link = prtd->asp_link[1];
> -		edma_set_dest_index(link, data_type, data_type * fifo_level);
> +		edma_set_dest_index(prtd->asp_link[0], data_type,
> +				data_type * fifo_level);
> +		edma_set_dest_index(prtd->asp_link[1], data_type,
> +				data_type * fifo_level);
>  
> -		link = prtd->ram_link;
> -		edma_set_dest(link, runtime->dma_addr, INCR, W32BIT);
> +		edma_set_dest(prtd->ram_link, runtime->dma_addr, INCR, W32BIT);
>  	}
>  
>  	if (!fifo_level) {
> @@ -354,10 +353,9 @@ static int ping_pong_dma_setup(struct snd_pcm_substream *substream)
>  				count, fifo_level, ABSYNC);
>  	}
>  
> -	link = prtd->ram_link;
> -	edma_set_src_index(link, ping_size, ram_src_cidx);
> -	edma_set_dest_index(link, ping_size, ram_dst_cidx);
> -	edma_set_transfer_params(link, ping_size, 2,
> +	edma_set_src_index(prtd->ram_link, ping_size, ram_src_cidx);
> +	edma_set_dest_index(prtd->ram_link, ping_size, ram_dst_cidx);
> +	edma_set_transfer_params(prtd->ram_link, ping_size, 2,
>  			runtime->periods, 2, ASYNC);
>  
>  	/* init master params */
> @@ -406,32 +404,32 @@ static int request_ping_pong(struct snd_pcm_substream *substream,
>  {
>  	dma_addr_t asp_src_ping;
>  	dma_addr_t asp_dst_ping;
> -	int link;
> +	int ret;
>  	struct davinci_pcm_dma_params *params = prtd->params;
>  
>  	/* Request ram master channel */
> -	link = prtd->ram_channel = edma_alloc_channel(EDMA_CHANNEL_ANY,
> +	ret = prtd->ram_channel = edma_alloc_channel(EDMA_CHANNEL_ANY,
>  				  davinci_pcm_dma_irq, substream,
>  				  prtd->params->ram_chan_q);
> -	if (link < 0)
> +	if (ret < 0)
>  		goto exit1;
>  
>  	/* Request ram link channel */
> -	link = prtd->ram_link = edma_alloc_slot(
> +	ret = prtd->ram_link = edma_alloc_slot(
>  			EDMA_CTLR(prtd->ram_channel), EDMA_SLOT_ANY);
> -	if (link < 0)
> +	if (ret < 0)
>  		goto exit2;
>  
> -	link = prtd->asp_link[1] = edma_alloc_slot(
> +	ret = prtd->asp_link[1] = edma_alloc_slot(
>  			EDMA_CTLR(prtd->asp_channel), EDMA_SLOT_ANY);
> -	if (link < 0)
> +	if (ret < 0)
>  		goto exit3;
>  
>  	prtd->ram_link2 = -1;
>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -		link = prtd->ram_link2 = edma_alloc_slot(
> +		ret = prtd->ram_link2 = edma_alloc_slot(
>  			EDMA_CTLR(prtd->ram_channel), EDMA_SLOT_ANY);
> -		if (link < 0)
> +		if (ret < 0)
>  			goto exit4;
>  	}
>  	/* circle ping-pong buffers */
> @@ -448,36 +446,33 @@ static int request_ping_pong(struct snd_pcm_substream *substream,
>  		asp_dst_ping = iram_dma->addr;
>  	}
>  	/* ping */
> -	link = prtd->asp_link[0];
> -	edma_set_src(link, asp_src_ping, INCR, W16BIT);
> -	edma_set_dest(link, asp_dst_ping, INCR, W16BIT);
> -	edma_set_src_index(link, 0, 0);
> -	edma_set_dest_index(link, 0, 0);
> +	edma_set_src(prtd->asp_link[0], asp_src_ping, INCR, W16BIT);
> +	edma_set_dest(prtd->asp_link[0], asp_dst_ping, INCR, W16BIT);
> +	edma_set_src_index(prtd->asp_link[0], 0, 0);
> +	edma_set_dest_index(prtd->asp_link[0], 0, 0);
>  
> -	edma_read_slot(link, &prtd->asp_params);
> +	edma_read_slot(prtd->asp_link[0], &prtd->asp_params);
>  	prtd->asp_params.opt &= ~(TCCMODE | EDMA_TCC(0x3f) | TCINTEN);
>  	prtd->asp_params.opt |= TCCHEN |
>  		EDMA_TCC(prtd->ram_channel & 0x3f);
> -	edma_write_slot(link, &prtd->asp_params);
> +	edma_write_slot(prtd->asp_link[0], &prtd->asp_params);
>  
>  	/* pong */
> -	link = prtd->asp_link[1];
> -	edma_set_src(link, asp_src_ping, INCR, W16BIT);
> -	edma_set_dest(link, asp_dst_ping, INCR, W16BIT);
> -	edma_set_src_index(link, 0, 0);
> -	edma_set_dest_index(link, 0, 0);
> +	edma_set_src(prtd->asp_link[1], asp_src_ping, INCR, W16BIT);
> +	edma_set_dest(prtd->asp_link[1], asp_dst_ping, INCR, W16BIT);
> +	edma_set_src_index(prtd->asp_link[1], 0, 0);
> +	edma_set_dest_index(prtd->asp_link[1], 0, 0);
>  
> -	edma_read_slot(link, &prtd->asp_params);
> +	edma_read_slot(prtd->asp_link[1], &prtd->asp_params);
>  	prtd->asp_params.opt &= ~(TCCMODE | EDMA_TCC(0x3f));
>  	/* interrupt after every pong completion */
>  	prtd->asp_params.opt |= TCINTEN | TCCHEN |
>  		EDMA_TCC(prtd->ram_channel & 0x3f);
> -	edma_write_slot(link, &prtd->asp_params);
> +	edma_write_slot(prtd->asp_link[1], &prtd->asp_params);
>  
>  	/* ram */
> -	link = prtd->ram_link;
> -	edma_set_src(link, iram_dma->addr, INCR, W32BIT);
> -	edma_set_dest(link, iram_dma->addr, INCR, W32BIT);
> +	edma_set_src(prtd->ram_link, iram_dma->addr, INCR, W32BIT);
> +	edma_set_dest(prtd->ram_link, iram_dma->addr, INCR, W32BIT);
>  	pr_debug("%s: audio dma channels/slots in use for ram:%u %u %u,"
>  		"for asp:%u %u %u\n", __func__,
>  		prtd->ram_channel, prtd->ram_link, prtd->ram_link2,
> @@ -494,7 +489,7 @@ exit2:
>  	edma_free_channel(prtd->ram_channel);
>  	prtd->ram_channel = -1;
>  exit1:
> -	return link;
> +	return ret;
>  }
>  
>  static int davinci_pcm_dma_request(struct snd_pcm_substream *substream)
> @@ -502,22 +497,22 @@ static int davinci_pcm_dma_request(struct snd_pcm_substream *substream)
>  	struct snd_dma_buffer *iram_dma;
>  	struct davinci_runtime_data *prtd = substream->runtime->private_data;
>  	struct davinci_pcm_dma_params *params = prtd->params;
> -	int link;
> +	int ret;
>  
>  	if (!params)
>  		return -ENODEV;
>  
>  	/* Request asp master DMA channel */
> -	link = prtd->asp_channel = edma_alloc_channel(params->channel,
> +	ret = prtd->asp_channel = edma_alloc_channel(params->channel,
>  			davinci_pcm_dma_irq, substream,
>  			prtd->params->asp_chan_q);
> -	if (link < 0)
> +	if (ret < 0)
>  		goto exit1;
>  
>  	/* Request asp link channels */
> -	link = prtd->asp_link[0] = edma_alloc_slot(
> +	ret = prtd->asp_link[0] = edma_alloc_slot(
>  			EDMA_CTLR(prtd->asp_channel), EDMA_SLOT_ANY);
> -	if (link < 0)
> +	if (ret < 0)
>  		goto exit2;
>  
>  	iram_dma = (struct snd_dma_buffer *)substream->dma_buffer.private_data;
> @@ -537,17 +532,17 @@ static int davinci_pcm_dma_request(struct snd_pcm_substream *substream)
>  	 * the buffer and its length (ccnt) ... use it as a template
>  	 * so davinci_pcm_enqueue_dma() takes less time in IRQ.
>  	 */
> -	edma_read_slot(link, &prtd->asp_params);
> +	edma_read_slot(prtd->asp_link[0], &prtd->asp_params);
>  	prtd->asp_params.opt |= TCINTEN |
>  		EDMA_TCC(EDMA_CHAN_SLOT(prtd->asp_channel));
> -	prtd->asp_params.link_bcntrld = EDMA_CHAN_SLOT(link) << 5;
> -	edma_write_slot(link, &prtd->asp_params);
> +	prtd->asp_params.link_bcntrld = EDMA_CHAN_SLOT(prtd->asp_link[0]) << 5;
> +	edma_write_slot(prtd->asp_link[0], &prtd->asp_params);
>  	return 0;
>  exit2:
>  	edma_free_channel(prtd->asp_channel);
>  	prtd->asp_channel = -1;
>  exit1:
> -	return link;
> +	return ret;
>  }
>  
>  static int davinci_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
