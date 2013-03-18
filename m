From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: atmel-pcm-dma: Leaking memory in
	atmel_pcm_hw_params
Date: Mon, 18 Mar 2013 16:36:02 +0100
Message-ID: <51473462.7030605@metafoo.de>
References: <5145D5BE.3090501@metafoo.de> <51469121.3070902@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-073.synserver.de (smtp-out-073.synserver.de
 [212.40.185.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 1030F26535F
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2013 16:34:10 +0100 (CET)
In-Reply-To: <51469121.3070902@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: alsa-devel@alsa-project.org

On 03/18/2013 04:59 AM, Bo Shen wrote:
> Hi Lars,
> 
> On 3/17/2013 22:39, Lars-Peter Clausen wrote:
>> Hi,
>>
>> The dmaengine based pcm driver for atmel calls snd_dmaengine_pcm_open from
>> it's hw_params callback. There is nothing preventing an application calling
>> hw_params more than once. snd_dmaengine_pcm_open allocates a new prtd struct
>> each time it gets called. So in case hw_params is called multiple times we
>> leak memory here. 
> 
> I use alsa utils and don't meet this issue. Please point out which software
> you use meet this issue.

I found the issue by looking at the code, but I think any application using
the oss compatibility layer of ALSA will trigger this.

> 
>> Is there any specific reason why snd_dmaengine_pcm_open() needs to be called
>> from the hw_params callback and why it can't be called from the open
>> callback?
> 
> This is because dma data setting and usage.
> 
> The filter function depends on the data returned by
>> snd_soc_dai_get_dma_data(), but as far as I can see the DAI driver calls
>> snd_soc_dai_set_dma_data() from its startup() callback, so the data is
>> available in the PCM drivers open callback.
> 
> Have you test this yet?

I don't have the hardware. I just looked at the code again, and it looks
like I must have misread it the first time. snd_soc_dai_set_dma_data() is
called from the DAI drivers hwparams callback. But the data that gets passed
to snd_soc_dai_set_dma_data() doesn't really depend on anything that's only
available in the hwparams callback. So the snd_soc_dai_set_dma_data() could
easily be move to the DAI driver startup() callback.

- Lars
