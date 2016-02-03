From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH RFC 01/15] ASoC: qcom: use
 snd_dma_alloc/free* apis
Date: Wed, 3 Feb 2016 08:48:27 +0000
Message-ID: <56B1BEDB.6060709@linaro.org>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1454347680-10307-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160203003507.GB14436@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B38D2614CB
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 09:48:28 +0100 (CET)
Received: by mail-wm0-f46.google.com with SMTP id r129so153901945wmr.0
 for <alsa-devel@alsa-project.org>; Wed, 03 Feb 2016 00:48:28 -0800 (PST)
In-Reply-To: <20160203003507.GB14436@kwestfie-linux.qualcomm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 03/02/16 00:35, Kenneth Westfield wrote:
> On Mon, Feb 01, 2016 at 09:27:59AM -0800, Srinivas Kandagatla wrote:
>> diff --git a/sound/soc/qcom/lpass-platform.c
>> b/sound/soc/qcom/lpass-platform.c
>> index 4aeb8e1..a6dce1b 100644
>> --- a/sound/soc/qcom/lpass-platform.c
>> +++ b/sound/soc/qcom/lpass-platform.c
>> @@ -439,39 +439,6 @@ static irqreturn_t lpass_platform_lpaif_irq(int irq,
>> void *data)
>>   	return IRQ_HANDLED;
>>   }
>>
>> -static int lpass_platform_alloc_buffer(struct snd_pcm_substream
>> *substream,
>> -		struct snd_soc_pcm_runtime *rt)
>> -{
>> -	struct snd_dma_buffer *buf = &substream->dma_buffer;
>> -	size_t size = lpass_platform_pcm_hardware.buffer_bytes_max;
>> -
>> -	buf->dev.type = SNDRV_DMA_TYPE_DEV;
>> -	buf->dev.dev = rt->platform->dev;
>> -	buf->private_data = NULL;
>> -	buf->area = dma_alloc_coherent(rt->platform->dev, size,
>> &buf->addr,
>> -			GFP_KERNEL);
>> -	if (!buf->area) {
>> -		dev_err(rt->platform->dev, "%s: Could not allocate DMA
>> buffer\n",
>> -				__func__);
>> -		return -ENOMEM;
>> -	}
>
> ...
>
>> @@ -499,7 +467,8 @@ static int lpass_platform_pcm_new(struct
>> snd_soc_pcm_runtime *soc_runtime)
>>
>>   	snd_soc_pcm_set_drvdata(soc_runtime, data);
>>
>> -	ret = lpass_platform_alloc_buffer(substream, soc_runtime);
>> +	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->card->dev,
>> +				size, &substream->dma_buffer);
>>   	if (ret)
>>   		return ret;
>>
>
> Is there a particular reason for using the soundcard device (pcm-card->dev)
> rather than the platform device (rt->platform->dev) for memory
> allocation?  Especially considering you posted a fix for this several
> weeks ago (ASoC: qcom: use correct device pointer in dma allocation).

Thanks for spotting this, I will fix it and resend it with platform->dev.

>
