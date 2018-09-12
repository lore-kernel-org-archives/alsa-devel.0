From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 3/3] ASoC: qdsp6: q6asm-dai: Add support to compress
 offload
Date: Wed, 12 Sep 2018 11:30:26 +0100
Message-ID: <4dfddf39-04f2-3d0a-221b-14e0970e489b@linaro.org>
References: <20180903123455.9290-1-srinivas.kandagatla@linaro.org>
 <20180903123455.9290-4-srinivas.kandagatla@linaro.org>
 <20180904135526.GK2322@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904135526.GK2322@vkoul-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod <vkoul@kernel.org>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, bgoswami@codeaurora.org, rohitkr@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz, devicetree@vger.kernel.org, mark.rutland@arm.com
List-Id: alsa-devel@alsa-project.org

Thanks for the review,

On 04/09/18 14:55, Vinod wrote:
> On 03-09-18, 13:34, Srinivas Kandagatla wrote:
> 
>> +static void compress_event_handler(uint32_t opcode, uint32_t token,
>> +				   uint32_t *payload, void *priv)
>> +{
>> +	struct q6asm_dai_rtd *prtd = priv;
>> +	struct snd_compr_stream *substream = prtd->cstream;
>> +	unsigned long flags;
>> +	uint64_t avail;
>> +
>> +	switch (opcode) {
>> +	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
>> +		spin_lock_irqsave(&prtd->lock, flags);
>> +		avail = prtd->bytes_received - prtd->bytes_sent;
>> +		if (!prtd->bytes_sent) {
>> +			if (avail < substream->runtime->fragment_size) {
>> +				prtd->xrun = 1;
> 
> so you are trying to detect xrun :) So in compress core we added support
> for .ack callback which tells driver how much data is valid in ring
> buffer and we can send this to DSP, so DSP "knows" valid data and should
> not overrun, ofcourse DSP needs support for it
> 
Thanks, I will take a closer look at ack callback.

>> +			} else {
>> +				q6asm_write_async(prtd->audio_client,
>> +						  prtd->pcm_count,
>> +						  0, 0, NO_TIMESTAMP);
>> +				prtd->bytes_sent += prtd->pcm_count;
>> +			}
>> +		}
>> +
>> +		spin_unlock_irqrestore(&prtd->lock, flags);
>> +		break;
> 
> empty line after break helps readability

Yes,  I will do.
> 
>> +	case ASM_CLIENT_EVENT_CMD_EOS_DONE:
>> +		prtd->state = Q6ASM_STREAM_STOPPED;
>> +		break;
>> +	case ASM_CLIENT_EVENT_DATA_WRITE_DONE:
>> +		spin_lock_irqsave(&prtd->lock, flags);
>> +		prtd->byte_offset += prtd->pcm_count;
>> +		prtd->copied_total += prtd->pcm_count;
> 
> so should you need two counters, copied_total should give you byte_offset
> as well, we know the ring buffer size

Yep, looks redundant to me too.
> 
>> +
>> +		if (prtd->byte_offset >= prtd->pcm_size)
>> +			prtd->byte_offset -= prtd->pcm_size;
> 
> :)
> 
>> +
>> +		snd_compr_fragment_elapsed(substream);
> 
> so will ASM_CLIENT_EVENT_DATA_WRITE_DONE be invoked on fragment bytes
> consumed?
Yes.
> 
>> +static int q6asm_dai_compr_set_params(struct snd_compr_stream *stream,
>> +				      struct snd_compr_params *params)
>> +{
>> +
> 
> redundant empty line
ya.
> 
>> +static int q6asm_dai_compr_trigger(struct snd_compr_stream *stream, int cmd)
>> +{
>> +	struct snd_compr_runtime *runtime = stream->runtime;
>> +	struct q6asm_dai_rtd *prtd = runtime->private_data;
>> +	int ret = 0;
>> +
>> +	switch (cmd) {
>> +	case SNDRV_PCM_TRIGGER_START:
>> +	case SNDRV_PCM_TRIGGER_RESUME:
>> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> +		ret = q6asm_run_nowait(prtd->audio_client, 0, 0, 0);
> 
> the triggers are not in atomic context, do we have q6asm_run()
> 
Yes, we do have q6asm_run() which is a blocking call.

>> +static int q6asm_dai_compr_copy(struct snd_compr_stream *stream,
>> +				char __user *buf, size_t count)
>> +{
>> +	struct snd_compr_runtime *runtime = stream->runtime;
>> +	struct q6asm_dai_rtd *prtd = runtime->private_data;
>> +	uint64_t avail = 0;
>> +	unsigned long flags;
>> +	size_t copy;
>> +	void *dstn;
>> +
>> +	dstn = prtd->buffer + prtd->copy_pointer;
>> +	if (count < prtd->pcm_size - prtd->copy_pointer) {
>> +		if (copy_from_user(dstn, buf, count))
>> +			return -EFAULT;
>> +
>> +		prtd->copy_pointer += count;
>> +	} else {
>> +		copy = prtd->pcm_size - prtd->copy_pointer;
>> +		if (copy_from_user(dstn, buf, copy))
>> +			return -EFAULT;
>> +
>> +		if (copy_from_user(prtd->buffer, buf + copy, count - copy))
>> +			return -EFAULT;
>> +		prtd->copy_pointer = count - copy;
>> +	}
>> +
>> +	spin_lock_irqsave(&prtd->lock, flags);
>> +	prtd->bytes_received += count;
> 
> why not use core copy method and..

Which core method are you referring to?
.
>> +
>> +	if (prtd->state == Q6ASM_STREAM_RUNNING && prtd->xrun) {
>> +		avail = prtd->bytes_received - prtd->copied_total;
>> +		if (avail >= runtime->fragment_size) {
>> +			prtd->xrun = 0;
>> +			q6asm_write_async(prtd->audio_client,
>> +				   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
>> +			prtd->bytes_sent += prtd->pcm_count;
>> +		}
>> +	}
...
> 
>> +static int q6asm_dai_compr_get_codec_caps(struct snd_compr_stream *stream,
>> +					  struct snd_compr_codec_caps *codec)
>> +{
>> +	switch (codec->codec) {
>> +	case SND_AUDIOCODEC_MP3:
>> +		codec->num_descriptors = 2;
>> +		codec->descriptor[0].max_ch = 2;
>> +		memcpy(codec->descriptor[0].sample_rates,
>> +		       supported_sample_rates,
>> +		       sizeof(supported_sample_rates));
>> +		codec->descriptor[0].num_sample_rates =
>> +			sizeof(supported_sample_rates)/sizeof(unsigned int);
>> +		codec->descriptor[0].bit_rate[0] = 320; /* 320kbps */
>> +		codec->descriptor[0].bit_rate[1] = 128;
>> +		codec->descriptor[0].num_bitrates = 2;
>> +		codec->descriptor[0].profiles = 0;
>> +		codec->descriptor[0].modes = SND_AUDIOCHANMODE_MP3_STEREO;
>> +		codec->descriptor[0].formats = 0;
> 
> since we are static here, how about using a table based approach and
> use that here
Sure, will do that in next version.

thanks,
srini
> 
