From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: control: confirm to return all
 identical information in 'activate' event data
Date: Tue, 10 Feb 2015 01:01:15 +0900
Message-ID: <54D8D9CB.5080709@sakamocchi.jp>
References: <1423494126-24054-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hsiefrtni.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id C3B5C260506
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 17:01:17 +0100 (CET)
In-Reply-To: <s5hsiefrtni.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Feb 10 2015 00:28, Takashi Iwai wrote:
> At Tue, 10 Feb 2015 00:02:06 +0900,
> Takashi Sakamoto wrote:
>>
>> When event originator doesn't set numerical ID in identical information,
>> the event data includes no numerical ID, thus userspace applications
>> cannot identify the control just by unique ID in event data.
>>
>> This commit fix this bug so as the event data includes all of identical
>> information.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>
> You can't overwrite id pointer in this case.  It's a caller's object.

Exactly. I missed it...

> One way to fix would be to copy the id instance.  Another way would be
> to change up/down_write() with _read(), and include snd_ctl_notify()
> call with kctl->id inside the semaphore lock.
>
> The former would be less changes but consume the stack significantly.

If any sub-effects are allowed, we can use caller's data via the 
pointer, like:
memcpy(id, &kctl->id, sizeof(struct snd_ctl_elem_id);
Then:
snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_INFO, id);

But this is not better. Mmm...

> thanks,
>
> Takashi
>
>
>> ---
>>   sound/core/control.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/core/control.c b/sound/core/control.c
>> index 6a72b3e..884fddd 100644
>> --- a/sound/core/control.c
>> +++ b/sound/core/control.c
>> @@ -587,6 +587,7 @@ int snd_ctl_activate_id(struct snd_card *card, struct snd_ctl_elem_id *id,
>>   	}
>>   	ret = 1;
>>    unlock:
>> +	*id = kctl->id;
>>   	up_write(&card->controls_rwsem);
>>   	if (ret > 0)
>>   		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_INFO, id);
>> --
>> 2.1.0
