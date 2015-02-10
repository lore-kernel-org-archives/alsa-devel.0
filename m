From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: control: confirm to return all
 identical information in 'activate' event data
Date: Tue, 10 Feb 2015 14:24:41 +0900
Message-ID: <54D99619.4050308@sakamocchi.jp>
References: <1423494126-24054-1-git-send-email-o-takashi@sakamocchi.jp>	<s5hsiefrtni.wl-tiwai@suse.de>	<54D8D9CB.5080709@sakamocchi.jp>	<s5hh9uvrs2c.wl-tiwai@suse.de>
 <s5h8ug7rrbq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DDDD260648
 for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2015 06:24:44 +0100 (CET)
In-Reply-To: <s5h8ug7rrbq.wl-tiwai@suse.de>
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

On Feb 10 2015 01:18, Takashi Iwai wrote:
> At Mon, 09 Feb 2015 17:02:51 +0100,
> Takashi Iwai wrote:
>>
>> At Tue, 10 Feb 2015 01:01:15 +0900,
>> Takashi Sakamoto wrote:
>>>
>>> On Feb 10 2015 00:28, Takashi Iwai wrote:
>>>> At Tue, 10 Feb 2015 00:02:06 +0900,
>>>> Takashi Sakamoto wrote:
>>>>>
>>>>> When event originator doesn't set numerical ID in identical information,
>>>>> the event data includes no numerical ID, thus userspace applications
>>>>> cannot identify the control just by unique ID in event data.
>>>>>
>>>>> This commit fix this bug so as the event data includes all of identical
>>>>> information.
>>>>>
>>>>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>>>>
>>>> You can't overwrite id pointer in this case.  It's a caller's object.
>>>
>>> Exactly. I missed it...
>>>
>>>> One way to fix would be to copy the id instance.  Another way would be
>>>> to change up/down_write() with _read(), and include snd_ctl_notify()
>>>> call with kctl->id inside the semaphore lock.
>>>>
>>>> The former would be less changes but consume the stack significantly.
>>>
>>> If any sub-effects are allowed, we can use caller's data via the
>>> pointer, like:
>>> memcpy(id, &kctl->id, sizeof(struct snd_ctl_elem_id);
>>> Then:
>>> snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_INFO, id);
>>
>> That's what I suggested as the first example.

I misunderstood to use heap.

> ... and I think this is a better way in the end.  Simpler, better.
> The stack usage is very likely acceptable.

I think so. I'll submit again with some comments about the sub-effect to 
callers.


Thanks

Takashi Sakamoto
