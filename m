From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [PATCH RFC 05/15] ASoC: qcom: ipq806x: add error in
 dma allocation.
Date: Wed, 3 Feb 2016 08:48:36 +0000
Message-ID: <56B1BEE4.9090406@linaro.org>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1454347723-10550-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160203003622.GF14436@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160203003622.GF14436@kwestfie-linux.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 03/02/16 00:36, Kenneth Westfield wrote:
> On Mon, Feb 01, 2016 at 09:28:43AM -0800, Srinivas Kandagatla wrote:
>> diff --git a/sound/soc/qcom/lpass-ipq806x.c
>> b/sound/soc/qcom/lpass-ipq806x.c
>> index 119048c..8bdcdcb 100644
>> --- a/sound/soc/qcom/lpass-ipq806x.c
>> +++ b/sound/soc/qcom/lpass-ipq806x.c
>> @@ -65,7 +65,10 @@ static struct snd_soc_dai_driver
>> ipq806x_lpass_cpu_dai_driver = {
>>
>>   static int ipq806x_lpass_alloc_dma_channel(struct lpass_data *drvdata,
>> int dir)
>>   {
>> -	return IPQ806X_LPAIF_RDMA_CHAN_MI2S;
>> +	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
>> +		return IPQ806X_LPAIF_RDMA_CHAN_MI2S;
>> +	else	/* Capture not supported */
>> +		return -EINVAL;
>>   }
>
> The comment could be read as "Capture not supported by hardware", which
> isn't true.  Maybe "Capture currently not implemented"?
Agreed, I will change this in next version.
>
