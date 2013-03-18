From: Bo Shen <voice.shen@atmel.com>
Subject: Re: ASoC: atmel-pcm-dma: Leaking memory in
	atmel_pcm_hw_params
Date: Mon, 18 Mar 2013 11:59:29 +0800
Message-ID: <51469121.3070902@atmel.com>
References: <5145D5BE.3090501@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id B72F6265229
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2013 05:00:34 +0100 (CET)
In-Reply-To: <5145D5BE.3090501@metafoo.de>
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

On 3/17/2013 22:39, Lars-Peter Clausen wrote:
> Hi,
>
> The dmaengine based pcm driver for atmel calls snd_dmaengine_pcm_open from
> it's hw_params callback. There is nothing preventing an application calling
> hw_params more than once. snd_dmaengine_pcm_open allocates a new prtd struct
> each time it gets called. So in case hw_params is called multiple times we
> leak memory here.

I use alsa utils and don't meet this issue. Please point out which 
software you use meet this issue.

> Is there any specific reason why snd_dmaengine_pcm_open() needs to be called
> from the hw_params callback and why it can't be called from the open
> callback?

This is because dma data setting and usage.

The filter function depends on the data returned by
> snd_soc_dai_get_dma_data(), but as far as I can see the DAI driver calls
> snd_soc_dai_set_dma_data() from its startup() callback, so the data is
> available in the PCM drivers open callback.

Have you test this yet?

>
> - Lars
>

Best Regards,
Bo Shen
