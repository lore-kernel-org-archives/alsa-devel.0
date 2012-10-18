From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: davinci: replace private sram
	api with genalloc
Date: Thu, 18 Oct 2012 17:24:50 +0200
Message-ID: <50801F42.4050107@gmail.com>
References: <1349991229-32107-1-git-send-email-mporter@ti.com>
 <1349991229-32107-2-git-send-email-mporter@ti.com> <50785049.50108@gmail.com>
 <20121018152149.GC25164@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 04D83265308
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 17:30:02 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so3436231bku.38
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 08:30:02 -0700 (PDT)
In-Reply-To: <20121018152149.GC25164@beef>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Porter <mporter@ti.com>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Alsa Devel List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 18.10.2012 17:21, Matt Porter wrote:
> On Fri, Oct 12, 2012 at 07:15:53PM +0200, Daniel Mack wrote:
>> Hi Matt,
>>
>> On 11.10.2012 23:33, Matt Porter wrote:
>>> Removes the DaVinci private SRAM API and replaces it with
>>> the genalloc API. The SRAM gen_pool is passed in pdata since
>>> DaVinci is in the early stages of DT conversion.
>>>
>>> Signed-off-by: Matt Porter <mporter@ti.com>
>>> ---
>>>  include/linux/platform_data/davinci_asp.h |    3 +++
>>>  sound/soc/davinci/davinci-mcasp.c         |    2 ++
>>>  sound/soc/davinci/davinci-pcm.c           |   18 ++++++++++++------
>>>  sound/soc/davinci/davinci-pcm.h           |    2 ++
>>>  4 files changed, 19 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/linux/platform_data/davinci_asp.h b/include/linux/platform_data/davinci_asp.h
>>> index d0c5825..f3d6e4f 100644
>>> --- a/include/linux/platform_data/davinci_asp.h
>>> +++ b/include/linux/platform_data/davinci_asp.h
>>> @@ -16,6 +16,8 @@
>>>  #ifndef __DAVINCI_ASP_H
>>>  #define __DAVINCI_ASP_H
>>>  
>>> +#include <linux/genalloc.h>
>>> +
>>>  struct snd_platform_data {
>>>  	u32 tx_dma_offset;
>>>  	u32 rx_dma_offset;
>>> @@ -30,6 +32,7 @@ struct snd_platform_data {
>>>  	unsigned enable_channel_combine:1;
>>>  	unsigned sram_size_playback;
>>>  	unsigned sram_size_capture;
>>> +	struct gen_pool *sram_pool;
>>>  
>>>  	/*
>>>  	 * If McBSP peripheral gets the clock from an external pin,
>>> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
>>> index 714e51e..52194bb 100644
>>> --- a/sound/soc/davinci/davinci-mcasp.c
>>> +++ b/sound/soc/davinci/davinci-mcasp.c
>>> @@ -1098,6 +1098,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>>>  	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
>>>  	dma_data->asp_chan_q = pdata->asp_chan_q;
>>>  	dma_data->ram_chan_q = pdata->ram_chan_q;
>>> +	dma_data->sram_pool = pdata->sram_pool;
>>>  	dma_data->sram_size = pdata->sram_size_playback;
>>>  	dma_data->dma_addr = (dma_addr_t) (pdata->tx_dma_offset +
>>>  							mem->start);
>>> @@ -1115,6 +1116,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>>>  	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_CAPTURE];
>>>  	dma_data->asp_chan_q = pdata->asp_chan_q;
>>>  	dma_data->ram_chan_q = pdata->ram_chan_q;
>>> +	dma_data->sram_pool = pdata->sram_pool;
>>>  	dma_data->sram_size = pdata->sram_size_capture;
>>>  	dma_data->dma_addr = (dma_addr_t)(pdata->rx_dma_offset +
>>>  							mem->start);
>>> diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
>>> index 93ea3bf..d2cc169 100644
>>> --- a/sound/soc/davinci/davinci-pcm.c
>>> +++ b/sound/soc/davinci/davinci-pcm.c
>>> @@ -16,6 +16,7 @@
>>>  #include <linux/slab.h>
>>>  #include <linux/dma-mapping.h>
>>>  #include <linux/kernel.h>
>>> +#include <linux/genalloc.h>
>>>  
>>>  #include <sound/core.h>
>>>  #include <sound/pcm.h>
>>> @@ -23,7 +24,6 @@
>>>  #include <sound/soc.h>
>>>  
>>>  #include <asm/dma.h>
>>> -#include <mach/sram.h>
>>>  
>>>  #include "davinci-pcm.h"
>>>  
>>> @@ -259,7 +259,8 @@ static void davinci_pcm_dma_irq(unsigned link, u16 ch_status, void *data)
>>>  	}
>>>  }
>>>  
>>> -static int allocate_sram(struct snd_pcm_substream *substream, unsigned size,
>>> +static int allocate_sram(struct snd_pcm_substream *substream,
>>> +		struct gen_pool *sram_pool, unsigned size,
>>>  		struct snd_pcm_hardware *ppcm)
>>>  {
>>>  	struct snd_dma_buffer *buf = &substream->dma_buffer;
>>> @@ -271,9 +272,10 @@ static int allocate_sram(struct snd_pcm_substream *substream, unsigned size,
>>>  		return 0;
>>>  
>>>  	ppcm->period_bytes_max = size;
>>> -	iram_virt = sram_alloc(size, &iram_phys);
>>> +	iram_virt = (void *)gen_pool_alloc(sram_pool, size);
>>
>> Did you see my patch that stubs out all functions that use gen_pool_*
>> functions for !CONFIG_GENERIC_ALLOCATOR configs? It should still apply
>> nicely on top of this one, and is necessary for AM33xx-only builds.
> 
> Sorry, I've had the last week of list traffic go to /dev/null. Catching
> up now and I do see that. I'm assuming that will all be in your updated
> series with these patches squashed in?

Yes, exactly. I already sent them out yesterday.


Daniel
