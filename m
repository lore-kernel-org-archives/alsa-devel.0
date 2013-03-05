From: Michal Bachraty <michal.bachraty@streamunlimited.com>
Subject: Re: [PATCH v2] davinci-mcasp: Add support for
	multichannel	playback
Date: Tue, 05 Mar 2013 12:41:20 +0100
Message-ID: <2365072.cAK26ghdqV@ganymedes>
References: <1361983125-32717-1-git-send-email-michal.bachraty@streamunlimited.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3C660@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.inode.at (mx06.lb01.inode.at [62.99.145.6])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BDBD265224
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2013 12:41:21 +0100 (CET)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED3C660@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Vaibhav,

Please look at  [alsa-devel] [PATCH v3] davinci-mcasp: Add support for 
multichannel playback thread. 
There was some changes about computing number of channels. There is also 
described, how this driver works.
Also please look at [alsa-devel] davici-mcasp: "tx-num-evt" confusion with 
number of serializers thread, where are discussed using "tx-num-evt".

I tested driver with 2 - 4 - 6 - 8 channnels I2S (2 slots TDM) with using 1 -2 
-3 -4 serializers. and S16_LE (will do S24_3LE) audio.

Best,
Michal


On Tuesday, March 05, 2013 11:06:16 Bedia, Vaibhav wrote:
> Hi Michal,
> 
> On Wed, Feb 27, 2013 at 22:08:45, Michal Bachraty wrote:
> > Davinci McASP has support for I2S multichannel playback.
> > For I2S playback/receive, each serializer is capable to play 2 channels
> > (L/R) audio data.Serializer function (Playback-receive-none) is configured
> > in DT, depending on hardware specification. It is possible to play less
> > channels than configured in DT. For that purpose,only specific number of
> > active serializers are enabled. McASP FIFO need to have DMA transfer Bcnt
> > set to number of enabled serializers, otherwise no data are transfered to
> > McASP and Alsa generates "DMA/IRQ playback write error (DMA or IRQ
> > trouble?)" error.
> 
> Thanks for looking into this. Before going into details, a few generic
> comments. All serializers configured in Tx (or Rx) work off common clock
> generators and hence the serializers will be operating in sync. I assume
> the setup that you have matches this requirement. Based on the DMA
> programming assumed in the implementation the user needs to ensure that
> buffer has the data in the right format. Can you please describe the setup
> that you have and how you tested this?
> > Signed-off-by: Michal Bachraty <michal.bachraty@streamunlimited.com>
> > ---
> > 
> >  sound/soc/davinci/davinci-mcasp.c |   56
> >  ++++++++++++++++++++++++++++++++----- sound/soc/davinci/davinci-pcm.c  
> >  |   16 ++++++-----
> >  sound/soc/davinci/davinci-pcm.h   |    1 +
> >  3 files changed, 59 insertions(+), 14 deletions(-)
> > 
> > diff --git a/sound/soc/davinci/davinci-mcasp.c
> > b/sound/soc/davinci/davinci-mcasp.c index afef3fb..b84bb73 100644
> > --- a/sound/soc/davinci/davinci-mcasp.c
> > +++ b/sound/soc/davinci/davinci-mcasp.c
> > @@ -235,6 +235,10 @@
> > 
> >  #define DISMOD		(val)(val<<2)
> >  #define TXSTATE		BIT(4)
> >  #define RXSTATE		BIT(5)
> > 
> > +#define SRMOD_MASK	3
> > +#define SRMOD_INACTIVE	0
> > +#define SRMOD_TX	1
> > +#define SRMOD_RX	2
> 
> I don't see SRMOD_TX/RX being used anywhere.
> 
> >  /*
> >  
> >   * DAVINCI_MCASP_LBCTL_REG - Loop Back Control Register Bits
> > 
> > @@ -657,12 +661,15 @@ static int davinci_config_channel_size(struct
> > davinci_audio_dev *dev,> 
> >  	return 0;
> >  
> >  }
> > 
> > -static void davinci_hw_common_param(struct davinci_audio_dev *dev, int
> > stream) +static int davinci_hw_common_param(struct davinci_audio_dev
> > *dev, int stream, +				    int channels)
> > 
> >  {
> >  
> >  	int i;
> >  	u8 tx_ser = 0;
> >  	u8 rx_ser = 0;
> > 
> > -
> > +	u8 ser;
> > +	u8 slots = dev->tdm_slots;
> > +	u8 max_active_serializers = (channels + slots - 1) / slots;
> > 
> >  	/* Default configuration */
> >  	mcasp_set_bits(dev->base + DAVINCI_MCASP_PWREMUMGT_REG, MCASP_SOFT);
> > 
> > @@ -680,16 +687,42 @@ static void davinci_hw_common_param(struct
> > davinci_audio_dev *dev, int stream)> 
> >  	}
> >  	
> >  	for (i = 0; i < dev->num_serializer; i++) {
> > 
> > +		if (dev->serial_dir[i] == TX_MODE)
> > +			tx_ser++;
> > +		if (dev->serial_dir[i] == RX_MODE)
> > +			rx_ser++;
> > +	}
> > +
> > +	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
> > +		ser = tx_ser;
> > +	else
> > +		ser = rx_ser;
> > +
> > +	if (ser < max_active_serializers) {
> > +		dev_warn(dev->dev, "stream has more channels (%d) than are "
> > +			"enabled in mcasp (%d)\n", channels, ser * slots);
> > +		return -EINVAL;
> > +	}
> > +
> > +	tx_ser = 0;
> > +	rx_ser = 0;
> 
> The number of active serializers is already being calculated below.
> 
> > +
> > +	for (i = 0; i < dev->num_serializer; i++) {
> > 
> >  		mcasp_set_bits(dev->base + DAVINCI_MCASP_XRSRCTL_REG(i),
> >  		
> >  					dev->serial_dir[i]);
> > 
> > -		if (dev->serial_dir[i] == TX_MODE) {
> > +		if (dev->serial_dir[i] == TX_MODE &&
> > +					tx_ser < max_active_serializers) {
> > 
> >  			mcasp_set_bits(dev->base + DAVINCI_MCASP_PDIR_REG,
> >  			
> >  					AXR(i));
> >  			
> >  			tx_ser++;
> > 
> > -		} else if (dev->serial_dir[i] == RX_MODE) {
> > +		} else if (dev->serial_dir[i] == RX_MODE &&
> > +					rx_ser < max_active_serializers) {
> > 
> >  			mcasp_clr_bits(dev->base + DAVINCI_MCASP_PDIR_REG,
> >  			
> >  					AXR(i));
> >  			
> >  			rx_ser++;
> > 
> > +		} else {
> > +			mcasp_mod_bits(dev->base + DAVINCI_MCASP_XRSRCTL_REG(i),
> > +					SRMOD_INACTIVE, SRMOD_MASK);
> 
> Sorry I don't follow what you are trying to do here.
> 
> >  		}
> >  	
> >  	}
> > 
> > @@ -729,6 +762,8 @@ static void davinci_hw_common_param(struct
> > davinci_audio_dev *dev, int stream)> 
> >  				((dev->rxnumevt * rx_ser) << 8), NUMEVT_MASK);
> >  		
> >  		}
> >  	
> >  	}
> > 
> > +
> > +	return 0;
> > 
> >  }
> >  
> >  static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
> > 
> > @@ -812,8 +847,14 @@ static int davinci_mcasp_hw_params(struct
> > snd_pcm_substream *substream,> 
> >  					&dev->dma_params[substream->stream];
> >  	
> >  	int word_length;
> >  	u8 fifo_level;
> > 
> > +	u8 slots = dev->tdm_slots;
> > +	int channels;
> > +	struct snd_interval *pcm_channels = hw_param_interval(params,
> > +					SNDRV_PCM_HW_PARAM_CHANNELS);
> > +	channels = pcm_channels->min;
> > 
> > -	davinci_hw_common_param(dev, substream->stream);
> > +	if (davinci_hw_common_param(dev, substream->stream, channels))
> > +		return -EINVAL;
> > 
> >  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> >  	
> >  		fifo_level = dev->txnumevt;
> >  	
> >  	else
> > 
> > @@ -862,6 +903,7 @@ static int davinci_mcasp_hw_params(struct
> > snd_pcm_substream *substream,> 
> >  		dma_params->acnt = dma_params->data_type;
> >  	
> >  	dma_params->fifo_level = fifo_level;
> > 
> > +	dma_params->active_serializers = (channels + slots - 1) / slots;
> > 
> >  	davinci_config_channel_size(dev, word_length);
> >  	
> >  	return 0;
> > 
> > @@ -936,13 +978,13 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[]
> > = {> 
> >  		.name		= "davinci-mcasp.0",
> >  		.playback	= {
> >  		
> >  			.channels_min	= 2,
> > 
> > -			.channels_max 	= 2,
> > +			.channels_max	= 8,
> 
> Why are you setting this to 8?
> 
> >  			.rates 		= DAVINCI_MCASP_RATES,
> >  			.formats	= DAVINCI_MCASP_PCM_FMTS,
> >  		
> >  		},
> >  		.capture 	= {
> >  		
> >  			.channels_min 	= 2,
> > 
> > -			.channels_max 	= 2,
> > +			.channels_max	= 8,
> 
> Same here.
> 
> >  			.rates 		= DAVINCI_MCASP_RATES,
> >  			.formats	= DAVINCI_MCASP_PCM_FMTS,
> >  		
> >  		},
> > 
> > diff --git a/sound/soc/davinci/davinci-pcm.c
> > b/sound/soc/davinci/davinci-pcm.c index bb57552..3af8b50 100644
> > --- a/sound/soc/davinci/davinci-pcm.c
> > +++ b/sound/soc/davinci/davinci-pcm.c
> > @@ -182,6 +182,7 @@ static void davinci_pcm_enqueue_dma(struct
> > snd_pcm_substream *substream)> 
> >  	unsigned short acnt;
> >  	unsigned int count;
> >  	unsigned int fifo_level;
> > 
> > +	unsigned char serializers = prtd->params->active_serializers;
> 
> Can you please describe what DMA configuration you want? I think you can
> get rid of the active_serializers configuration by making use of tx_num_evt.
> >  	period_size = snd_pcm_lib_period_bytes(substream);
> >  	dma_offset = prtd->period * period_size;
> > 
> > @@ -195,14 +196,14 @@ static void davinci_pcm_enqueue_dma(struct
> > snd_pcm_substream *substream)> 
> >  	data_type = prtd->params->data_type;
> >  	count = period_size / data_type;
> >  	if (fifo_level)
> > 
> > -		count /= fifo_level;
> > +		count /= fifo_level * serializers;
> 
> I think there's a problem is the way in which tx_num_evt is interpreted in
> the current code. Instead of setting to fifo_level to tx_num_evt, if you
> set it to tx_num_evt * num_serializers you can get rid of the additional
> code to take care of the number of serializers.
> >  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> >  	
> >  		src = dma_pos;
> >  		dst = prtd->params->dma_addr;
> >  		src_bidx = data_type;
> > 
> > -		dst_bidx = 0;
> > -		src_cidx = data_type * fifo_level;
> > +		dst_bidx = 4;
> 
> Err.. this will most likely break other audio configurations. You should
> look at how to avoid this change by making use of the mask and rotation
> operations in the McASP code.
> > +		src_cidx = data_type * fifo_level * serializers;
> > 
> >  		dst_cidx = 0;
> >  	
> >  	} else {
> >  	
> >  		src = prtd->params->dma_addr;
> > 
> > @@ -210,7 +211,7 @@ static void davinci_pcm_enqueue_dma(struct
> > snd_pcm_substream *substream)> 
> >  		src_bidx = 0;
> >  		dst_bidx = data_type;
> >  		src_cidx = 0;
> > 
> > -		dst_cidx = data_type * fifo_level;
> > +		dst_cidx = data_type * fifo_level * serializers;
> 
> With the change in fifo_level as described above, this won't be necessary.
> 
> >  	}
> >  	
> >  	acnt = prtd->params->acnt;
> > 
> > @@ -224,9 +225,10 @@ static void davinci_pcm_enqueue_dma(struct
> > snd_pcm_substream *substream)> 
> >  		edma_set_transfer_params(prtd->asp_link[0], acnt, count, 1, 0,
> >  		
> >  							ASYNC);
> >  	
> >  	else
> > 
> > -		edma_set_transfer_params(prtd->asp_link[0], acnt, fifo_level,
> > -							count, fifo_level,
> > -							ABSYNC);
> > +		edma_set_transfer_params(prtd->asp_link[0], acnt,
> > +						fifo_level * serializers,
> > +						count, fifo_level * serializers,
> > +						ABSYNC);
> 
> Same comment applies here.
> 
> Regards,
> Vaibhav
