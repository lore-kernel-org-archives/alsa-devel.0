From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: davici-mcasp: "tx-num-evt" confusion with number
 of serializers
Date: Wed, 27 Feb 2013 13:05:14 +0100
Message-ID: <512DF67A.5030906@topic.nl>
References: <1631475.f7GPhLiLxV@ganymedes> <512D01A5.8050206@topic.nl>
 <4506811.gzuv2dFpKQ@ganymedes>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atl4mhob08.myregisteredsite.com
 (atl4mhob08.myregisteredsite.com [209.17.115.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 5037A262632
 for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2013 13:05:16 +0100 (CET)
Received: from mailpod.hostingplatform.com (mail.networksolutionsemail.com
 [205.178.146.50])
 by atl4mhob08.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 r1RC5EiK015755
 for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2013 07:05:15 -0500
In-Reply-To: <4506811.gzuv2dFpKQ@ganymedes>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michal Bachraty <michal.bachraty@streamunlimited.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/27/2013 12:36 PM, Michal Bachraty wrote:
> Hi Mike,
>
> Thanks for your opinion.
>
>>   From what I remember (I'm using the davinci to record from up to 8
>> codecs chips simultaneously) the value sets a threshold for the DMA
>> request (if the FIFO is enabled - and I can't think of a reason why
>> anyone would NOT want to enable the fifo...).
>
> Can you tell me, which processor are you using, how many serializers (data
> lines) do you use and which mode are you using (TDM - I2S?)?

I'm using an OMAP-L138. Using (up to) 8 serializers (8 AXR lines to 8 
codecs of 3 different types). I'm using the I2S protocol for the serial 
lines.

I patched the McASP driver and simply put my settings in there, because 
i'm on an old kernel (2.6.37).

I mapped the tdm mask function of the interface to actually 
enable/disable the serializers, and created a fake "multiplex" codec 
that exports switches to enable/disable the actual codecs and propagates 
the stream operations to the codecs that are enabled. This way, user 
space can set everything up via the mixer interface, and can then record 
from any subset of the 8 codecs.

>> Postponing the DMA request until there are #channels data entries in the
>> fifo buffer makes sense to me. Setting the txnumevt to a higher value
>> might reduce the load on the memory controller (that's what TI claims),
>> at the cost of a higher risk of overrunning the fifo, and increased
>> latency. Setting it to less than the number of channels isn't useful
>> either - which application would be interested in "half" the channel data?
>
> AM335x FIFO waits for data for all enabled serializers. For I2S format, there
> are two (L/R) data samples for one sampling time. This data are sended one
> after another to dataline. Therefore Am335x serializer need only "half"sample
> data, but it works in double sampling time frequency. When more than two
> channels will be used, for example four, then two serializers are enabled. For
> this example, FIFO need to be filled with two samples in one DMA frame, each
> for one serializer. If not, no DMA event is generated.

True. I forgot about the "stereo" part, the current code sets the FIFO 
to request DMA transfer when one half (L or R) of the data is complete.

If you have only few channels in use, it might improve memory 
performance to wait for both channels to arrive, as the DMA can then use 
larger blocks. I'd expect somewhat better results for 16-byte transfers 
than for 8 or 4 bytes, but I don't expect any improvement over that. TI 
is quit fuzzy on that too, and I didn't actually notice any measurable 
difference in my system. So you might want to set the tx_num_evt to "2" 
for systems with only few channels, and "1" when using 4 or more 
serializers (or TDM channels).

Maybe the misleading "rx_num_evt" should be renamed to "use_rx_fifo". I 
understand that not all McASP interfaces have a FIFO

Hmm. Just read some of this back, and noticed that I'm talking about 
recording data from codecs, while you're playing back data. Not that it 
makes much of a difference. The playback queue will wait for the buffer 
to fill to a certain level before starting to output it to the 
serializer. This increases latency, but may prevent underruns due to DMA 
congestion.

Mike.
