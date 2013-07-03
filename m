From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: atmel-pcm: use generic dmaengine
 framework
Date: Wed, 03 Jul 2013 09:36:34 +0200
Message-ID: <51D3D482.1050100@metafoo.de>
References: <1372755849-19546-1-git-send-email-voice.shen@atmel.com> <1372755849-19546-3-git-send-email-voice.shen@atmel.com> <51D2F306.7040603@metafoo.de> <51D37F87.2010008@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51D37F87.2010008@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, richard.genoud@gmail.com, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 07/03/2013 03:33 AM, Bo Shen wrote:
> Hi Lars-Peter,
> 
> On 7/2/2013 23:34, Lars-Peter Clausen wrote:
>> On 07/02/2013 11:04 AM, Bo Shen wrote:
>> [...]
>>> -/*--------------------------------------------------------------------------*\
>>> - * DMAENGINE operations
>>> -\*--------------------------------------------------------------------------*/
>>> -static bool filter(struct dma_chan *chan, void *slave)
>>> -{
>>> -    struct at_dma_slave *sl = slave;
>>> -
>>> -    if (sl->dma_dev == chan->device->dev) {
>>> -        chan->private = sl;
>>> -        return true;
>>> -    } else {
>>> -        return false;
>>> -    }
>>> -}
>>
>> I'm wondering why is filtering no longer required?
> 
> Now this is handled by at_dma_filter in at_hdmac driver. More information, you
> can reference: <driver/dma/at_hdmac.c> file

Ok, so the DMA channel is now supplied via devicetree. This is really a change
that should be listed in the changelog.

> 
>> [...]
>>> +        slave_config->dst_addr = (dma_addr_t)ssc->phybase + SSC_THR;
>> [...]
>>> +        slave_config->src_addr = (dma_addr_t)ssc->phybase + SSC_RHR;
>>
>> Change the type of phybase to dma_addr_t
> 
> It should be:
> slave_config->dst_addr = (dma_addr_t)(ssc->phybase + SSC_THR);
> slave_config->src_addr = (dma_addr_t)(ssc->phybase + SSC_RHR);

The type of phybase in the ssc_device struct should be changed from
resource_size_t to dma_addr_t.
