From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Re: [PATCH v2] davinci-mcasp: Add support for
 multichannel playback
Date: Thu, 7 Mar 2013 11:59:10 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED3E15B@DBDE01.ent.ti.com>
References: <1361983125-32717-1-git-send-email-michal.bachraty@streamunlimited.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3C660@DBDE01.ent.ti.com>
 <513616F7.2020201@gmail.com> <2762675.av4Ym1Kxhq@ganymedes>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F506265D75
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2013 12:59:24 +0100 (CET)
In-Reply-To: <2762675.av4Ym1Kxhq@ganymedes>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michal Bachraty <michal.bachraty@streamunlimited.com>, Daniel Mack <zonque@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 06, 2013 at 20:14:59, Michal Bachraty wrote:
[...]
> 
> Yes, threre is misleading with tx_num_evt in DT. This misleading is discussed 
> in [alsa-devel] davici-mcasp: "tx-num-evt" confusion with number of 
> serializers. thread. 
> 

I responded to that thread yesterday. Can you please check that.
 
> > >>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> > >>  	
> > >>  		src = dma_pos;
> > >>  		dst = prtd->params->dma_addr;
> > >>  		src_bidx = data_type;
> > >> 
> > >> -		dst_bidx = 0;
> > >> -		src_cidx = data_type * fifo_level;
> > >> +		dst_bidx = 4;
> > > 
> > > Err.. this will most likely break other audio configurations. You should
> > > look at how to avoid this change by making use of the mask and rotation
> > > operations in the McASP code.> 
> 
> McAsp FIFO and McASP data port reg. is 32 bit wide, each new sample is copied 
> to McASP after McAsp send DMA event. McASP also do data rotations and masking. 
> When more serializers are enabled, each new sample for new serializer should 
> be placed to new data room at +4 address. After that new DMA event is 
> generated.
> I tested it with TDM slots = 2 and also 6 with one serializer and also two 
> serializer enabled. 
> Why do you think that brokes other audio configurations? 
> 

Refer to section 22.3.10.1.2 of the AM335x TRM.

"To access through the data port, simply have the CPU or DMA access the XRBUF
through its data port location. Through the data port, the DMA/CPU can service
all the serializers through a single address. The McASP automatically cycles
through the appropriate serializers.

For transmit operations through the data port, the DMA/CPU should write to the
same XBUF data port address to service all of the active transmit serializers.
In addition, the DMA/CPU should write to the XBUF for all active transmit
serializers"

The DMA controller is expected to write to the same address. I am a bit
surprised the +4 thing works without issue. Still, you should not rely
on that since that's not supported as per the specs.

Regards,
Vaibhav
