From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 3/6] dma: Add a jz4740 dmaengine driver
Date: Thu, 30 May 2013 20:46:39 +0200
Message-ID: <51A79E8F.4070209@metafoo.de>
References: <1369931105-28065-1-git-send-email-lars@metafoo.de> <1369931105-28065-4-git-send-email-lars@metafoo.de> <20130530171225.GA3767@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130530171225.GA3767@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maarten ter Huurne <maarten@treewalker.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/30/2013 07:12 PM, Vinod Koul wrote:
> On Thu, May 30, 2013 at 06:25:02PM +0200, Lars-Peter Clausen wrote:
>> This patch adds dmaengine support for the JZ4740 DMA controller. For now the
>> driver will be a wrapper around the custom JZ4740 DMA API. Once all users of the
>> custom JZ4740 DMA API have been converted to the dmaengine API the custom API
>> will be removed and direct hardware access will be added to the dmaengine
>> driver.
>>
>> +
>> +#include <asm/mach-jz4740/dma.h>
> Am bit worried about having header in arch. Why cant we have this drivers header
> in linux/. That way same IP block cna be reused across archs.
> I was hoping that you would have move it in 6th patch, but that isnt the case

At the end of this series the header only contains the slave ids used by the
various cores on the JZ4740. Since these ids differ from SoC to SoC it doesn't
make much sense to move the header to a generic location.

> 
> 
>> +static int jz4740_dma_alloc_chan_resources(struct dma_chan *c)
>> +{
>> +	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
>> +
>> +	chan->jz_chan = jz4740_dma_request(chan, NULL);
>> +	if (!chan->jz_chan)
>> +		return -EBUSY;
>> +
>> +	jz4740_dma_set_complete_cb(chan->jz_chan, jz4740_dma_complete_cb);
>> +
>> +	return 0;
> Sorry, I didnt reply on this one. The API expects you to allocate a pool of
> descriptors. These descriptors are to be used in .device_prep_xxx calls later.

The size of the descriptor is not fixed, so they can not be pre-allocated. And
this is nothing new either, most of the more recently added dmaengine drivers
allocate their descriptors on demand.

- Lars
