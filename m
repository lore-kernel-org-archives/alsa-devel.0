From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 3/4] ASoC: qdsp6: q6afe-dai: Update max rate for slim
 and tdm dais
Date: Thu, 22 Aug 2019 11:45:48 +0100
Message-ID: <923f1d65-d908-c64c-3109-0da1938d3824@linaro.org>
References: <20190822095653.7200-1-srinivas.kandagatla@linaro.org>
 <20190822095653.7200-4-srinivas.kandagatla@linaro.org>
 <s5h7e75v7en.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h7e75v7en.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: broonie@kernel.org, spapothi@codeaurora.org, bgoswami@codeaurora.org, plai@codeaurora.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



On 22/08/2019 11:09, Takashi Iwai wrote:
> On Thu, 22 Aug 2019 11:56:52 +0200,
> Srinivas Kandagatla wrote:
>>
>> QDSP supports up to 384000 rates on SLIM dais and 352800 rate on TDM dais.
>> Add this missing rates.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/qcom/qdsp6/q6afe-dai.c | 92 +++++++++++---------------------
>>   1 file changed, 32 insertions(+), 60 deletions(-)
>>
>> diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
>> index c1a7624eaf17..ae2baefdb6e2 100644
>> --- a/sound/soc/qcom/qdsp6/q6afe-dai.c
>> +++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
>> @@ -18,14 +18,14 @@
>>   			.stream_name = pre" TDM"#num" Playback",	\
>>   			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
>>   				SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |\
>> -				SNDRV_PCM_RATE_176400,			\
>> +				SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_352800,\
> 
> This will support a lot more than advertised, e.g. it contains 64000Hz
> or 22050Hz.  Is this supposed?  If yes, mention it clearly in the
> changelog, too.

Some of the rates inbetween are not in the DSP supported rate list for TDM.

DSP should return error if we try to set any unsupported rate!

--srini
> 
> thanks,
> 
> Takashi
> 
