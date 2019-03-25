From: Timo Wischer <twischer@de.adit-jv.com>
Subject: Re: [PATCH 04/10] ALSA: aloop: Use always
 spin_lock_irqsave() for cable->lock
Date: Mon, 25 Mar 2019 17:40:23 +0100
Message-ID: <237e2d2d-9a8f-a273-4c40-db2c670c6858@de.adit-jv.com>
References: <1553529644-5654-1-git-send-email-twischer@de.adit-jv.com>
 <1553529644-5654-5-git-send-email-twischer@de.adit-jv.com>
 <s5htvfr6iqh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE0C8F80764
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2019 17:40:32 +0100 (CET)
In-Reply-To: <s5htvfr6iqh.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Best regards
*Timo Wischer*
Engineering Software Base (ADITG/ESB)

Tel. +49 5121 49 6938
On 3/25/19 17:07, Takashi Iwai wrote:
> On Mon, 25 Mar 2019 17:00:38 +0100,
> <twischer@de.adit-jv.com> wrote:
>> From: Timo Wischer <twischer@de.adit-jv.com>
>>
>> to allow the usage of timer callbacks from interrupt context.
>> For example the sound timer.
> The trigger callback is already irq-disabled.  And, open/close must
> not be irq-disabled OTOH.  So these changes must be superfluous.

Hello Takashi,

could you explain why open/close must not be irq-disabled?
I see a potential deadlock in case of free_cable() uses only spin_lock() 
instead of spin_lock_irqsave().
For example the following will be executed:

loopback_close()
free_cable()
spin_lock(&dpcm->cable->lock)
 >> Interrupted by jiffies timer IRQ before calling spin_unlock()

loopback_jiffies_timer_function()
spin_lock_irqsave(&dpcm->cable->lock)
 >> DEADLOCK due to dpcm->cable->lock is already locked

Do you also see this deadlock or do you see any reason why this could 
not happen?

Best regards

Timo

>
>
> thanks,
>
> Takashi
>
>
>> Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
>> ---
>>   sound/drivers/aloop.c | 33 +++++++++++++++++++--------------
>>   1 file changed, 19 insertions(+), 14 deletions(-)
>>
>> diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
>> index 11e8ed6..c6217c4 100644
>> --- a/sound/drivers/aloop.c
>> +++ b/sound/drivers/aloop.c
>> @@ -272,6 +272,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
>>   	struct loopback_pcm *dpcm = runtime->private_data;
>>   	struct loopback_cable *cable = dpcm->cable;
>>   	int err = 0, stream = 1 << substream->stream;
>> +	unsigned long flags;
>>   
>>   	switch (cmd) {
>>   	case SNDRV_PCM_TRIGGER_START:
>> @@ -281,39 +282,39 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
>>   		dpcm->last_jiffies = jiffies;
>>   		dpcm->pcm_rate_shift = 0;
>>   		dpcm->last_drift = 0;
>> -		spin_lock(&cable->lock);	
>> +		spin_lock_irqsave(&cable->lock, flags);
>>   		cable->running |= stream;
>>   		cable->pause &= ~stream;
>>   		err = loopback_timer_start(dpcm);
>> -		spin_unlock(&cable->lock);
>> +		spin_unlock_irqrestore(&cable->lock, flags);
>>   		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>   			loopback_active_notify(dpcm);
>>   		break;
>>   	case SNDRV_PCM_TRIGGER_STOP:
>> -		spin_lock(&cable->lock);	
>> +		spin_lock_irqsave(&cable->lock, flags);
>>   		cable->running &= ~stream;
>>   		cable->pause &= ~stream;
>>   		err = loopback_timer_stop(dpcm);
>> -		spin_unlock(&cable->lock);
>> +		spin_unlock_irqrestore(&cable->lock, flags);
>>   		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>   			loopback_active_notify(dpcm);
>>   		break;
>>   	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>>   	case SNDRV_PCM_TRIGGER_SUSPEND:
>> -		spin_lock(&cable->lock);	
>> +		spin_lock_irqsave(&cable->lock, flags);
>>   		cable->pause |= stream;
>>   		err = loopback_timer_stop(dpcm);
>> -		spin_unlock(&cable->lock);
>> +		spin_unlock_irqrestore(&cable->lock, flags);
>>   		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>   			loopback_active_notify(dpcm);
>>   		break;
>>   	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>>   	case SNDRV_PCM_TRIGGER_RESUME:
>> -		spin_lock(&cable->lock);
>> +		spin_lock_irqsave(&cable->lock, flags);
>>   		dpcm->last_jiffies = jiffies;
>>   		cable->pause &= ~stream;
>>   		err = loopback_timer_start(dpcm);
>> -		spin_unlock(&cable->lock);
>> +		spin_unlock_irqrestore(&cable->lock, flags);
>>   		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>   			loopback_active_notify(dpcm);
>>   		break;
>> @@ -557,12 +558,13 @@ static snd_pcm_uframes_t loopback_pointer(struct snd_pcm_substream *substream)
>>   {
>>   	struct snd_pcm_runtime *runtime = substream->runtime;
>>   	struct loopback_pcm *dpcm = runtime->private_data;
>> +	unsigned long flags;
>>   	snd_pcm_uframes_t pos;
>>   
>> -	spin_lock(&dpcm->cable->lock);
>> +	spin_lock_irqsave(&dpcm->cable->lock, flags);
>>   	loopback_pos_update(dpcm->cable);
>>   	pos = dpcm->buf_pos;
>> -	spin_unlock(&dpcm->cable->lock);
>> +	spin_unlock_irqrestore(&dpcm->cable->lock, flags);
>>   	return bytes_to_frames(runtime, pos);
>>   }
>>   
>> @@ -679,10 +681,12 @@ static void free_cable(struct snd_pcm_substream *substream)
>>   	if (!cable)
>>   		return;
>>   	if (cable->streams[!substream->stream]) {
>> +		unsigned long flags;
>> +
>>   		/* other stream is still alive */
>> -		spin_lock_irq(&cable->lock);
>> +		spin_lock_irqsave(&cable->lock, flags);
>>   		cable->streams[substream->stream] = NULL;
>> -		spin_unlock_irq(&cable->lock);
>> +		spin_unlock_irqrestore(&cable->lock, flags);
>>   	} else {
>>   		/* free the cable */
>>   		loopback->cables[substream->number][dev] = NULL;
>> @@ -698,6 +702,7 @@ static int loopback_open(struct snd_pcm_substream *substream)
>>   	struct loopback_cable *cable = NULL;
>>   	int err = 0;
>>   	int dev = get_cable_index(substream);
>> +	unsigned long flags;
>>   
>>   	mutex_lock(&loopback->cable_lock);
>>   	dpcm = kzalloc(sizeof(*dpcm), GFP_KERNEL);
>> @@ -753,9 +758,9 @@ static int loopback_open(struct snd_pcm_substream *substream)
>>   	else
>>   		runtime->hw = cable->hw;
>>   
>> -	spin_lock_irq(&cable->lock);
>> +	spin_lock_irqsave(&cable->lock, flags);
>>   	cable->streams[substream->stream] = dpcm;
>> -	spin_unlock_irq(&cable->lock);
>> +	spin_unlock_irqrestore(&cable->lock, flags);
>>   
>>    unlock:
>>   	if (err < 0) {
>> -- 
>> 2.7.4
>>
>>
