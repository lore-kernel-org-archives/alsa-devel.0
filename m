From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH] ASoC: STI: Fix null ptr deference in IRQ
	handler
Date: Tue, 21 Mar 2017 13:55:43 +0100
Message-ID: <825b0c73-01be-6e59-7bad-009ed0c94e94@st.com>
References: <1490029755-15746-1-git-send-email-arnaud.pouliquen@st.com>
 <s5htw6nkfod.wl-tiwai@suse.de> <757acc2d-8586-3ed9-6f85-221458686e48@st.com>
 <s5ha88evrsf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 356812671BA
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 13:55:45 +0100 (CET)
In-Reply-To: <s5ha88evrsf.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "kernel@stlinux.com" <kernel@stlinux.com>
List-Id: alsa-devel@alsa-project.org



On 03/21/2017 11:38 AM, Takashi Iwai wrote:
> On Tue, 21 Mar 2017 11:32:51 +0100,
> Arnaud Pouliquen wrote:
>>
>>
>>
>> On 03/20/2017 06:42 PM, Takashi Iwai wrote:
>>> On Mon, 20 Mar 2017 18:09:15 +0100,
>>> Arnaud Pouliquen wrote:
>>>>
>>>> With RTlinux a race condition has been found that leads to NULL ptr crash:
>>>> - On CPU 0: uni_player_irq_handler is called to treat XRUN
>>>>  "(player->state == UNIPERIF_STATE_STOPPED)" is FALSE so status is checked,
>>>>  dev_err(player->dev, "FIFO underflow error detected") is printed
>>>> and then snd_pcm_stream_lock should be called to lock stream for stopping.
>>>> - On CPU 1: application stop and close the stream.
>>>> Issue is that the stop and shutdown functions are executed while
>>>> "FIFO underflow error detected" is printed.
>>>> So when CPU 0 call snd_pcm_stream_lock is player->substream is already null.
>>>
>>> Hrm, how the first call of snd_pcm_stream_lock() with
>>> player->substream to be guaranteed to be non-NULL?
>>
>> Not sure that it is possible to be 100% save, but player->substream
>> should not be null...
>>
>>  Use case at risk: Stop request occurs just before IRQ.
>> 1) IRQ handler locked on snd_pcm_stream_lock(player->substream)
>> 2) uni_player_stop clear IRQ flags and set player->state ==
>> UNIPERIF_STATE_STOPPED. So no more IRQs after UNIPERIF_STATE_STOPPED state.
>> 3) As stream is cleared after close, i guess that between stop and close
>> following IRQ handler code should be executed
>>
>>   	if (player->state == UNIPERIF_STATE_STOPPED) {
>>   		/* Unexpected IRQ: do nothing */
>>  		snd_pcm_stream_unlock(player->substream);
>>   		return IRQ_NONE;
>>   	}
>>
>> Anyway adding a check of player->substream in IRQ handler before locking
>> seems more save.
> 
> Well, if the PCM stop happens right after the call of
> uni_player_irq_handler() but just before the spinlock call, you may
> still hit NULL dereference.
For me this is not possible... please tell me if i missed something.

Substream is set to null in snd_pcm_release so after the close.
That why i set player->substream to NULL in uni_player_shutdown
that corresponds to DAI shutdown op.
So should not be possible to race the null condition.
Only way should be that stop and close is executed between
The uni_player_irq_handler call and the spinlock.

> 
> That is, it's not safe to refer to player->substream unless we ensure
> non-NULL in other way.
Not use it seems not possible as usage is to call snd_pcm_stop on underrun.

Thanks

Arnaud

> 
> 
> thanks,
> 
> Takashi
> 
>>
>> I will add it in a V2
>>
>> Thanks
>>
>> Arnaud
>>
>>>
>>>
>>> Takashi
>>>
>>>
>>>>
>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>>>> ---
>>>>  sound/soc/sti/uniperif_player.c | 9 +++------
>>>>  sound/soc/sti/uniperif_reader.c | 8 +++++---
>>>>  2 files changed, 8 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
>>>> index 60ae31a..6fa9eee 100644
>>>> --- a/sound/soc/sti/uniperif_player.c
>>>> +++ b/sound/soc/sti/uniperif_player.c
>>>> @@ -65,8 +65,10 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
>>>>  	unsigned int status;
>>>>  	unsigned int tmp;
>>>>  
>>>> +	snd_pcm_stream_lock(player->substream);
>>>>  	if (player->state == UNIPERIF_STATE_STOPPED) {
>>>>  		/* Unexpected IRQ: do nothing */
>>>> +		snd_pcm_stream_unlock(player->substream);
>>>>  		return IRQ_NONE;
>>>>  	}
>>>>  
>>>> @@ -88,9 +90,7 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
>>>>  			SET_UNIPERIF_ITM_BCLR_FIFO_ERROR(player);
>>>>  
>>>>  			/* Stop the player */
>>>> -			snd_pcm_stream_lock(player->substream);
>>>>  			snd_pcm_stop(player->substream, SNDRV_PCM_STATE_XRUN);
>>>> -			snd_pcm_stream_unlock(player->substream);
>>>>  		}
>>>>  
>>>>  		ret = IRQ_HANDLED;
>>>> @@ -104,9 +104,7 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
>>>>  		SET_UNIPERIF_ITM_BCLR_DMA_ERROR(player);
>>>>  
>>>>  		/* Stop the player */
>>>> -		snd_pcm_stream_lock(player->substream);
>>>>  		snd_pcm_stop(player->substream, SNDRV_PCM_STATE_XRUN);
>>>> -		snd_pcm_stream_unlock(player->substream);
>>>>  
>>>>  		ret = IRQ_HANDLED;
>>>>  	}
>>>> @@ -138,13 +136,12 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
>>>>  		dev_err(player->dev, "Underflow recovery failed\n");
>>>>  
>>>>  		/* Stop the player */
>>>> -		snd_pcm_stream_lock(player->substream);
>>>>  		snd_pcm_stop(player->substream, SNDRV_PCM_STATE_XRUN);
>>>> -		snd_pcm_stream_unlock(player->substream);
>>>>  
>>>>  		ret = IRQ_HANDLED;
>>>>  	}
>>>>  
>>>> +	snd_pcm_stream_unlock(player->substream);
>>>>  	return ret;
>>>>  }
>>>>  
>>>> diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
>>>> index 5992c6a..9273f59 100644
>>>> --- a/sound/soc/sti/uniperif_reader.c
>>>> +++ b/sound/soc/sti/uniperif_reader.c
>>>> @@ -46,9 +46,11 @@ static irqreturn_t uni_reader_irq_handler(int irq, void *dev_id)
>>>>  	struct uniperif *reader = dev_id;
>>>>  	unsigned int status;
>>>>  
>>>> +	snd_pcm_stream_lock(reader->substream);
>>>>  	if (reader->state == UNIPERIF_STATE_STOPPED) {
>>>>  		/* Unexpected IRQ: do nothing */
>>>>  		dev_warn(reader->dev, "unexpected IRQ\n");
>>>> +		snd_pcm_stream_unlock(reader->substream);
>>>>  		return IRQ_HANDLED;
>>>>  	}
>>>>  
>>>> @@ -60,13 +62,13 @@ static irqreturn_t uni_reader_irq_handler(int irq, void *dev_id)
>>>>  	if (unlikely(status & UNIPERIF_ITS_FIFO_ERROR_MASK(reader))) {
>>>>  		dev_err(reader->dev, "FIFO error detected\n");
>>>>  
>>>> -		snd_pcm_stream_lock(reader->substream);
>>>>  		snd_pcm_stop(reader->substream, SNDRV_PCM_STATE_XRUN);
>>>> -		snd_pcm_stream_unlock(reader->substream);
>>>>  
>>>> -		return IRQ_HANDLED;
>>>> +		ret = IRQ_HANDLED;
>>>>  	}
>>>>  
>>>> +	snd_pcm_stream_unlock(reader->substream);
>>>> +
>>>>  	return ret;
>>>>  }
>>>>  
>>>> -- 
>>>> 1.9.1
>>>>
>>
