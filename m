From: Michal Bachraty <michal.bachraty@streamunlimited.com>
Subject: Re: [PATCH v2] davinci-mcasp: Add support for
	multichannel playback
Date: Wed, 06 Mar 2013 15:44:59 +0100
Message-ID: <2762675.av4Ym1Kxhq@ganymedes>
References: <1361983125-32717-1-git-send-email-michal.bachraty@streamunlimited.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3C660@DBDE01.ent.ti.com>
 <513616F7.2020201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.inode.at (mx09.lb01.inode.at [62.99.145.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 88F50265CAB
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 15:45:04 +0100 (CET)
In-Reply-To: <513616F7.2020201@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Bedia,
 Vaibhav" <vaibhav.bedia@ti.com>
List-Id: alsa-devel@alsa-project.org

 Hi Vaibhav,
 Hi Daniel.

Daniel, thaks for comments, Vaibhav thanks for review!
Please 
On Tuesday, March 05, 2013 17:01:59 Daniel Mack wrote:
> I'll let Michal comment on the rest, as it's his work. Note though that
> v3 of this patch has already been applied to Mark's tree, but we can
> easily fix the details you mentioned with another patch.
> 
This is part for me, so:

> 
> >>  			.rates 		= DAVINCI_MCASP_RATES,
> >>  			.formats	= DAVINCI_MCASP_PCM_FMTS,
> >>  		
> >>  		},
> >>  		.capture 	= {
> >>  		
> >>  			.channels_min 	= 2,
> >> 
> >> -			.channels_max 	= 2,
> >> +			.channels_max	= 8,
> > 
> > Same here.
> > 
> >>  			.rates 		= DAVINCI_MCASP_RATES,
> >>  			.formats	= DAVINCI_MCASP_PCM_FMTS,
> >>  		
> >>  		},
> >> 
> >> diff --git a/sound/soc/davinci/davinci-pcm.c
> >> b/sound/soc/davinci/davinci-pcm.c index bb57552..3af8b50 100644
> >> --- a/sound/soc/davinci/davinci-pcm.c
> >> +++ b/sound/soc/davinci/davinci-pcm.c
> >> @@ -182,6 +182,7 @@ static void davinci_pcm_enqueue_dma(struct
> >> snd_pcm_substream *substream)>> 
> >>  	unsigned short acnt;
> >>  	unsigned int count;
> >>  	unsigned int fifo_level;
> >> 
> >> +	unsigned char serializers = prtd->params->active_serializers;
> > 
> > Can you please describe what DMA configuration you want? I think you can
> > get rid of the active_serializers configuration by making use of
> > tx_num_evt.> 
> >>  	period_size = snd_pcm_lib_period_bytes(substream);
> >>  	dma_offset = prtd->period * period_size;
> >> 
> >> @@ -195,14 +196,14 @@ static void davinci_pcm_enqueue_dma(struct
> >> snd_pcm_substream *substream)>> 
> >>  	data_type = prtd->params->data_type;
> >>  	count = period_size / data_type;
> >>  	if (fifo_level)
> >> 
> >> -		count /= fifo_level;
> >> +		count /= fifo_level * serializers;
> > 
> > I think there's a problem is the way in which tx_num_evt is interpreted in
> > the current code. Instead of setting to fifo_level to tx_num_evt, if you
> > set it to tx_num_evt * num_serializers you can get rid of the additional
> > code to take care of the number of serializers.> 

Yes, threre is misleading with tx_num_evt in DT. This misleading is discussed 
in [alsa-devel] davici-mcasp: "tx-num-evt" confusion with number of 
serializers. thread. 

Also this code misleads fifo_level usage, so maybe that code can be upgraded. 

In davinci-mcasp code, there is fifo_level defined as txnum
	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
		fifo_level = dev->txnumevt;
	else
		fifo_level = dev->rxnumevt;



> >>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> >>  	
> >>  		src = dma_pos;
> >>  		dst = prtd->params->dma_addr;
> >>  		src_bidx = data_type;
> >> 
> >> -		dst_bidx = 0;
> >> -		src_cidx = data_type * fifo_level;
> >> +		dst_bidx = 4;
> > 
> > Err.. this will most likely break other audio configurations. You should
> > look at how to avoid this change by making use of the mask and rotation
> > operations in the McASP code.> 

McAsp FIFO and McASP data port reg. is 32 bit wide, each new sample is copied 
to McASP after McAsp send DMA event. McASP also do data rotations and masking. 
When more serializers are enabled, each new sample for new serializer should 
be placed to new data room at +4 address. After that new DMA event is 
generated.
I tested it with TDM slots = 2 and also 6 with one serializer and also two 
serializer enabled. 
Why do you think that brokes other audio configurations? 

> >> +		src_cidx = data_type * fifo_level * serializers;
> >> 
> >>  		dst_cidx = 0;
> >>  	
> >>  	} else {
> >>  	
> >>  		src = prtd->params->dma_addr;
> >> 
> >> @@ -210,7 +211,7 @@ static void davinci_pcm_enqueue_dma(struct
> >> snd_pcm_substream *substream)>> 
> >>  		src_bidx = 0;
> >>  		dst_bidx = data_type;
> >>  		src_cidx = 0;
> >> 
> >> -		dst_cidx = data_type * fifo_level;
> >> +		dst_cidx = data_type * fifo_level * serializers;
> > 
> > With the change in fifo_level as described above, this won't be necessary.

Described upper and also in Re: [alsa-devel] davici-mcasp: "tx-num-evt" 
confusion with number of serializers thread

Best 
Michal.
