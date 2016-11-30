From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/1] ALSA: SOC: DMA: increment buffer pointer atomically
Date: Wed, 30 Nov 2016 10:16:08 +0100
Message-ID: <73b575c4-685f-7658-bd2b-3e517d9fbed4@metafoo.de>
References: <20161130082221.15399-1-jiada_wang@mentor.com>
 <36d5025d-d327-878d-7f2e-5bf0c457581d@metafoo.de>
 <ef0cef5f-4f79-919c-c040-5d67b9280977@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ef0cef5f-4f79-919c-c040-5d67b9280977@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, apape@de.adit-jv.com
List-Id: alsa-devel@alsa-project.org

On 11/30/2016 09:36 AM, Lars-Peter Clausen wrote:
> On 11/30/2016 09:30 AM, Lars-Peter Clausen wrote:
>> On 11/30/2016 09:22 AM, Jiada Wang wrote:
>>> From: Andreas Pape <apape@de.adit-jv.com>
>>>
>>> Setting pointer and afterwards check for wrap around leads
>>> to the possibility of returning the inconsistent pointer position.
>>> This patch increments buffer pointer atomically to avoid this issue.
>>
>> Makes sense.
>>
>>>
>>> Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
>>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>>> ---
>>>  sound/core/pcm_dmaengine.c | 8 +++++---
>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
>>> index 8eb58c7..6f6da11 100644
>>> --- a/sound/core/pcm_dmaengine.c
>>> +++ b/sound/core/pcm_dmaengine.c
>>> @@ -139,12 +139,14 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_set_config_from_dai_data);
>>>  
>>>  static void dmaengine_pcm_dma_complete(void *arg)
>>>  {
>>> +	unsigned int new_pos;
>>>  	struct snd_pcm_substream *substream = arg;
>>>  	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
>>>  
>>> -	prtd->pos += snd_pcm_lib_period_bytes(substream);
>>> -	if (prtd->pos >= snd_pcm_lib_buffer_bytes(substream))
>>> -		prtd->pos = 0;
>>> +	new_pos = prtd->pos + snd_pcm_lib_period_bytes(substream);
>>> +	if (new_pos >= snd_pcm_lib_buffer_bytes(substream))
>>> +		new_pos = 0;
>>> +	prtd->pos = new_pos;
>>
>> But to really make it atomic I think this needs READ_ONCE/WRITE_ONCE.
> 
> And the access to prtd->pos in snd_dmaengine_pcm_pointer_no_residue() should
> also use READ_ONCE(). It is very unlikely that the code gets mis-compiled to
> generate more than one access, but having READ_ONCE() acts as a annotation
> that makes it explicit that this is data that can be updated concurrently
> without further synchronization.

Having given this some additional thoughts, I think a READ_ONCE() in
dmaengine_pcm_dma_complete() is not necessary. dmaengine_pcm_dma_complete()
is the only writer of prtd->pos and it is not running concurrently to
itself. So we'll always observe consistent state, even if the compiler
decides to issue multiple reads. The WRITE_ONCE() is required to make sure
that the prtd->pos state stays consistent to concurrent readers. And the
READ_ONCE() in snd_dmaengine_pcm_pointer_no_residue() is required to make
sure that consistent state is observed from concurrent writers.
