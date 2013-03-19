From: Bo Shen <voice.shen@atmel.com>
Subject: Re: ASoC: atmel-pcm-dma: Leaking memory in
	atmel_pcm_hw_params
Date: Tue, 19 Mar 2013 09:18:43 +0800
Message-ID: <5147BCF3.6060106@atmel.com>
References: <5145D5BE.3090501@metafoo.de> <51469121.3070902@atmel.com>
 <51473462.7030605@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id D90E1265CA9
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2013 02:19:46 +0100 (CET)
In-Reply-To: <51473462.7030605@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: alsa-devel@alsa-project.org

Hi Lars,

On 3/18/2013 23:36, Lars-Peter Clausen wrote:
> On 03/18/2013 04:59 AM, Bo Shen wrote:
>> Hi Lars,
>>
>> On 3/17/2013 22:39, Lars-Peter Clausen wrote:
>>> Hi,
>>>
>>> The dmaengine based pcm driver for atmel calls snd_dmaengine_pcm_open from
>>> it's hw_params callback. There is nothing preventing an application calling
>>> hw_params more than once. snd_dmaengine_pcm_open allocates a new prtd struct
>>> each time it gets called. So in case hw_params is called multiple times we
>>> leak memory here.
>>
>> I use alsa utils and don't meet this issue. Please point out which software
>> you use meet this issue.
>
> I found the issue by looking at the code, but I think any application using
> the oss compatibility layer of ALSA will trigger this.

Thanks for this information.

>
>>
>>> Is there any specific reason why snd_dmaengine_pcm_open() needs to be called
>>> from the hw_params callback and why it can't be called from the open
>>> callback?
>>
>> This is because dma data setting and usage.
>>
>> The filter function depends on the data returned by
>>> snd_soc_dai_get_dma_data(), but as far as I can see the DAI driver calls
>>> snd_soc_dai_set_dma_data() from its startup() callback, so the data is
>>> available in the PCM drivers open callback.
>>
>> Have you test this yet?
>
> I don't have the hardware. I just looked at the code again, and it looks
> like I must have misread it the first time. snd_soc_dai_set_dma_data() is
> called from the DAI drivers hwparams callback. But the data that gets passed
> to snd_soc_dai_set_dma_data() doesn't really depend on anything that's only
> available in the hwparams callback. So the snd_soc_dai_set_dma_data() could
> easily be move to the DAI driver startup() callback.

I will implement this, and send patch for this.

Thanks again.

> - Lars
>

Best Regards,
Bo Shen
