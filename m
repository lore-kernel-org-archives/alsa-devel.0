From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 5/5] ASoC: qdsp6: q6asm-dai: Add support to compress
 offload
Date: Fri, 5 Oct 2018 09:15:30 +0100
Message-ID: <dd8fe500-ce7c-4a50-48a4-ef4b5c53dccc@linaro.org>
References: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
 <20180926102349.23481-6-srinivas.kandagatla@linaro.org>
 <20181005003919.GH2372@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005003919.GH2372@vkoul-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod <vkoul@kernel.org>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, bgoswami@codeaurora.org, rohitkr@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org, mark.rutland@arm.com
List-Id: alsa-devel@alsa-project.org

Thanks Vinod for the Review!

On 05/10/18 01:39, Vinod wrote:
> On 26-09-18, 11:23, Srinivas Kandagatla wrote:
>> This patch adds MP3 playback support in q6asm dais, adding other codec
>> support should be pretty trivial.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/qcom/Kconfig           |   1 +
>>   sound/soc/qcom/qdsp6/q6asm-dai.c | 377 ++++++++++++++++++++++++++++++-
>>   2 files changed, 377 insertions(+), 1 deletion(-)
>>
...
>> +#define Q6ASM_DAI_RX	2
>> +
>> +
> 
> Unnecessary double space
> 

I did notice this just after I sent the patch!
>>   enum stream_state {
>>   	Q6ASM_STREAM_IDLE = 0,
>>   	Q6ASM_STREAM_STOPPED,
>> @@ -39,11 +51,22 @@ enum stream_state {
>>   
>>   struct q6asm_dai_rtd {
>>   	struct snd_pcm_substream *substream;
>> +	struct snd_compr_stream *cstream;
>> +	struct snd_compr_params codec_param;
>> +	struct snd_dma_buffer dma_buffer;
>> +
>>   	phys_addr_t phys;
>> +	spinlock_t lock;
> 
> why would we need a lock for compress case?
bytes_received counter is updated as part of Ack and referenced in the 
irq context in the event_handler callback from dsp, this lock is to 
protect it !

--srini
> 
