From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 3/6] dma: Add a jz4740 dmaengine driver
Date: Mon, 10 Jun 2013 19:29:46 +0200
Message-ID: <51B60D0A.7040307@metafoo.de>
References: <1369931105-28065-1-git-send-email-lars@metafoo.de> <1369931105-28065-4-git-send-email-lars@metafoo.de> <20130530171225.GA3767@intel.com> <51A79E8F.4070209@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51A79E8F.4070209@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maarten ter Huurne <maarten@treewalker.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/30/2013 08:46 PM, Lars-Peter Clausen wrote:
>>> +static int jz4740_dma_alloc_chan_resources(struct dma_chan *c)
>>> +{
>>> +	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
>>> +
>>> +	chan->jz_chan = jz4740_dma_request(chan, NULL);
>>> +	if (!chan->jz_chan)
>>> +		return -EBUSY;
>>> +
>>> +	jz4740_dma_set_complete_cb(chan->jz_chan, jz4740_dma_complete_cb);
>>> +
>>> +	return 0;
>> Sorry, I didnt reply on this one. The API expects you to allocate a pool of
>> descriptors. These descriptors are to be used in .device_prep_xxx calls later.
> 
> The size of the descriptor is not fixed, so they can not be pre-allocated. And
> this is nothing new either, most of the more recently added dmaengine drivers
> allocate their descriptors on demand.

Vinod, are you ok with this explanation?

- Lars
