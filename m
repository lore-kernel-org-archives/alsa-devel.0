From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 3/3] sound: dummy, avoid races with timer
Date: Mon, 19 Jan 2015 10:53:55 +0100
Message-ID: <54BCD433.3070407@suse.cz>
References: <1421660576-8435-1-git-send-email-jslaby@suse.cz>	<1421660576-8435-3-git-send-email-jslaby@suse.cz> <s5hwq4jqewi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hwq4jqewi.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/19/2015, 10:49 AM, Takashi Iwai wrote:
>> @@ -322,12 +325,14 @@ static snd_pcm_uframes_t
>>  dummy_systimer_pointer(struct snd_pcm_substream *substream)
>>  {
>>  	struct dummy_systimer_pcm *dpcm = substream->runtime->private_data;
>> +	unsigned long flags;
>>  	snd_pcm_uframes_t pos;
>>  
>> -	spin_lock(&dpcm->lock);
>> +	spin_lock_irqsave(&dpcm->lock, flags);
>>  	dummy_systimer_update(dpcm);
>>  	pos = dpcm->frac_pos / HZ;
>> -	spin_unlock(&dpcm->lock);
>> +	spin_unlock_irqrestore(&dpcm->lock, flags);
>> +
> 
> This chunk is superfluous.  The pointer callback is guaranteed to be
> called in the irq-disabled context.

Oh, my bad, I was looking at snd_compr_ops->pointer which is not the case.

-- 
js
suse labs
