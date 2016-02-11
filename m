From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 13/14] ASoC: qcom: add mic support
Date: Thu, 11 Feb 2016 11:34:35 +0000
Message-ID: <56BC71CB.7040308@linaro.org>
References: <1455099418-311-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1455099603-906-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160210201021.GB29575@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160210201021.GB29575@kwestfie-linux.qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 10/02/16 20:10, Kenneth Westfield wrote:
> On Wed, Feb 10, 2016 at 02:20:03AM -0800, Srinivas Kandagatla wrote:
>> diff --git a/sound/soc/qcom/lpass-platform.c
>> b/sound/soc/qcom/lpass-platform.c
>> index 26a046a..574aa33 100644
>> --- a/sound/soc/qcom/lpass-platform.c
>> +++ b/sound/soc/qcom/lpass-platform.c
>
> ...
>
>> @@ -92,7 +93,13 @@ static int lpass_platform_pcmops_hw_params(struct
>> snd_pcm_substream *substream,
>>   	unsigned int regval;
>>   	int dir = substream->stream;
>>   	int bitwidth;
>> -	int ret, rdma_port = pcm_data->i2s_port + v->dmactl_audif_start;
>> +	int ch, ret, dma_port = pcm_data->i2s_port +
>> v->dmactl_audif_start;
>
> IMO, changing rdma_port to dma_port should be in patch 3 (ASoC: qcom:
> rename rdmactl_audif_start to dmactrl_audif_start).  However, as I
> stated in my comments to your RFC submission, this is a nit.
>
Am ok to change it.
But, Its just a local variable whose sense only changes once we get the 
mic support in.

> ...
>
>> @@ -460,55 +483,106 @@ static int lpass_platform_pcm_new(struct
>> snd_soc_pcm_runtime *soc_runtime)
>>   	if (!data)
>>   		return -ENOMEM;
>>
>> -	if (v->alloc_dma_channel)
>> -		data->rdma_ch = v->alloc_dma_channel(drvdata,
>> -
>> SNDRV_PCM_STREAM_PLAYBACK);
>> +	data->i2s_port = cpu_dai->driver->id;
>> +	snd_soc_pcm_set_drvdata(soc_runtime, data);
>>
>> -	if (IS_ERR_VALUE(data->rdma_ch))
>> -		return data->rdma_ch;
>> +	psubstream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
>> +	if (psubstream) {
>> +		if (v->alloc_dma_channel)
>> +			data->rdma_ch = v->alloc_dma_channel(drvdata,
>> +
>> SNDRV_PCM_STREAM_PLAYBACK);
>>
>> -	drvdata->substream[data->rdma_ch] = substream;
>> -	data->i2s_port = cpu_dai->driver->id;
>> +		if (IS_ERR_VALUE(data->rdma_ch))
>> +			return data->rdma_ch;
>>
>> -	snd_soc_pcm_set_drvdata(soc_runtime, data);
>> +		drvdata->substream[data->rdma_ch] = psubstream;
>>
>> -	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
>> -				soc_runtime->platform->dev,
>> -				size, &substream->dma_buffer);
>> -	if (ret)
>> -		return ret;
>> +		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
>> pcm->card->dev,
>> +					size, &psubstream->dma_buffer);
>
> In patch 1 of this series (ASoC: qcom: use snd_dma_alloc/free* apis), you
> correctly used the platform device for memory allocation.  However, that is
> then replaced by the soundcard device here ...
>
Oops, I should have been careful.
Will fix it and send v2.



>> +	csubstream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
>> +	if (csubstream) {
>> +		if (v->alloc_dma_channel)
>> +			data->wrdma_ch = v->alloc_dma_channel(drvdata,
>> +						SNDRV_PCM_STREAM_CAPTURE);
>> +
>> +		if (IS_ERR_VALUE(data->wrdma_ch))
>> +			goto capture_alloc_err;
>> +
>> +		drvdata->substream[data->wrdma_ch] = csubstream;
>> +
>> +		ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
>> pcm->card->dev,
>> +					size, &csubstream->dma_buffer);
>> +		if (ret)
>> +			goto capture_alloc_err;
>
> ... and here as well.
same.

Thanks,
srini
>
