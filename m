From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/2] ASoC: dmaengine-pcm: Add support
 for querying DMA capabilities
Date: Tue, 08 Oct 2013 18:40:36 +0200
Message-ID: <52543584.1030408@metafoo.de>
References: <1381237680-32654-1-git-send-email-lars@metafoo.de>
 <20131008150612.GR2954@intel.com> <52542F44.4030604@metafoo.de>
 <20131008153024.GS2954@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F90B2610A9
 for <alsa-devel@alsa-project.org>; Tue,  8 Oct 2013 18:39:50 +0200 (CEST)
In-Reply-To: <20131008153024.GS2954@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/08/2013 05:30 PM, Vinod Koul wrote:
> On Tue, Oct 08, 2013 at 06:13:56PM +0200, Lars-Peter Clausen wrote:
>> On 10/08/2013 05:06 PM, Vinod Koul wrote:
>>> On Tue, Oct 08, 2013 at 03:07:59PM +0200, Lars-Peter Clausen wrote:
>>>> Currently each platform making use the the generic dmaengine PCM driver still
>>>> needs to provide a custom snd_pcm_hardware struct which specifies the
>>>> capabilities of the DMA controller, e.g. the maximum period size that can be
>>>> supported. This patch adds code which uses the newly introduced
>>>> dma_get_slave_caps() API to query this information from the dmaengine driver.
>>>> The new code path will only be taken if the 'pcm_hardware' field of the
>>>> snd_dmaengine_pcm_config struct is NULL.
>>>>
>>>> The patch also introduces a new 'fifo_size' field to the
>>>> snd_dmaengine_dai_dma_data struct which is used to initialize the
>>>> snd_pcm_hardware 'fifo_size' field and needs to be set by the DAI driver.
>>>>
>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>>>
>>>> ---
>>>> Changes since v1:
>>>> 	* Use dma_get_max_seg_size() to get the maximum size of one period
>>>> 	* Assume that a DMA engine driver is able to support an infinite number of
>>>> 	  periods
>>>> 	* Increase min_period_bytes from 16 to 256.
>>>> ---
>>>>   include/sound/dmaengine_pcm.h         |  2 ++
>>>>   sound/soc/soc-generic-dmaengine-pcm.c | 55 ++++++++++++++++++++++++++++-------
>>>>   2 files changed, 47 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
>>>> index f11c35c..83b2c3e 100644
>>>> --- a/include/sound/dmaengine_pcm.h
>>>> +++ b/include/sound/dmaengine_pcm.h
>>>> @@ -61,6 +61,7 @@ struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream)
>>>>    * @slave_id: Slave requester id for the DMA channel.
>>>>    * @filter_data: Custom DMA channel filter data, this will usually be used when
>>>>    * requesting the DMA channel.
>>>> + * @fifo_size: FIFO size of the DAI controller in bytes
>>> is this supposed to be DMA FIFO or I2S FIFO?
>>
>> This field is the internal FIFO of the audio core.
>>
>>>
>>> And second question for Takakshi or Mark. I see that this value ends up in
>>> usermode, what is the intented usage of this?
>>
>> I think it is supposed to help to calculate the audio delay, but I
>> don't think it is actually that widely used at the moment. And yes,
>> in order to make this more accurate we should probably add support
>> for incorporating also the fifo size of the DMA channel.
> But then why dont add to delay field, why report to usermode

I don't now :)

>
>> [...]
>>>> +	hw.periods_min = 2;
>>>> +	hw.periods_max = UINT_MAX;
>>>> +	hw.period_bytes_min = 256;
>>>> +	hw.period_bytes_max = dma_get_max_seg_size(dma_dev);
>>> I think you should check if the driver has set this, if not goto some default
>>>
>>
>> I don't think we are supposed to directly peak at the dma_parms
>> field. If the DMA driver does not work with the default, and it did
>> not set up a proper value, it is a bug in the DMA driver.
> Well i didnt mean to peek but to check the value returned by
> dma_get_max_seg_size(). Also, while buggy driver get fixed we need this :)

The default value, if the DMA driver did not setup something explicitly, is 
65535, which is a legitimate value. So we won't be able to tell if this is a 
wrong default or a correct default. But the DAI driver has to explicitly enable 
this new functionality (by not setting any static hw_params). So we hopefully 
won't hit this path for DMA drivers which do not initialize their segment size 
correctly.

- Lars
