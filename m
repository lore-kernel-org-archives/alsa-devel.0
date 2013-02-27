From: Michal Bachraty <michal.bachraty@streamunlimited.com>
Subject: Re: davici-mcasp: "tx-num-evt" confusion with number
	of serializers
Date: Wed, 27 Feb 2013 12:36:54 +0100
Message-ID: <4506811.gzuv2dFpKQ@ganymedes>
References: <1631475.f7GPhLiLxV@ganymedes> <512D01A5.8050206@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.inode.at (mx10.lb01.inode.at [62.99.145.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A4CA261739
 for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2013 12:36:55 +0100 (CET)
In-Reply-To: <512D01A5.8050206@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mike Looijmans <mike.looijmans@topic.nl>
List-Id: alsa-devel@alsa-project.org

Hi Mike, 

Thanks for your opinion.
 
>  From what I remember (I'm using the davinci to record from up to 8
> codecs chips simultaneously) the value sets a threshold for the DMA
> request (if the FIFO is enabled - and I can't think of a reason why
> anyone would NOT want to enable the fifo...).

Can you tell me, which processor are you using, how many serializers (data 
lines) do you use and which mode are you using (TDM - I2S?)?
 
> Postponing the DMA request until there are #channels data entries in the
> fifo buffer makes sense to me. Setting the txnumevt to a higher value
> might reduce the load on the memory controller (that's what TI claims),
> at the cost of a higher risk of overrunning the fifo, and increased
> latency. Setting it to less than the number of channels isn't useful
> either - which application would be interested in "half" the channel data?

AM335x FIFO waits for data for all enabled serializers. For I2S format, there 
are two (L/R) data samples for one sampling time. This data are sended one 
after another to dataline. Therefore Am335x serializer need only "half"sample 
data, but it works in double sampling time frequency. When more than two 
channels will be used, for example four, then two serializers are enabled. For 
this example, FIFO need to be filled with two samples in one DMA frame, each 
for one serializer. If not, no DMA event is generated.

Michal.
