From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: different return value from some ioctl commands
 for x86 binary executed on x86_64
Date: Thu, 17 Mar 2016 20:59:09 +0900
Message-ID: <56EA9C0D.9060307@sakamocchi.jp>
References: <56EA2A14.5000305@sakamocchi.jp> <s5hoaada0ut.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 10D6C261564
 for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2016 12:59:12 +0100 (CET)
In-Reply-To: <s5hoaada0ut.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mar 17 2016 18:51, Takashi Iwai wrote:
> On Thu, 17 Mar 2016 04:52:52 +0100,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> When testing ioctl compatibility layer for ALSA ctl interface, I found
>> that error code of some ioctl commands are different depending on binary
>> architecture.
>>
>> The commands are SNDRV_CTL_IOCTL_ELEM_READ/SNDRV_CTL_IOCTL_ELEM_WRITE.
>> When passing data for non-existent element, ENOENT is returned by the
>> core implementation. On the other hand, ENXIO is returned by the
>> compatibility layer.
>>
>> This code is for reproduction of this bug.
>>
>> (snip)
>>
>> I tested on x86_64 machine with enough support for multi-arch.
>>
>> $ gcc -Wall -m64 -o ./test ./test.c ; ./test
>> ioctl(SNDRV_CTL_IOCTL_ELEM_READ): No such file or directory
>> ioctl(SNDRV_CTL_IOCTL_ELEM_WRITE): No such file or directory
>>
>> $ gcc -Wall -m32 -o ./test ./test.c ; ./test
>> ioctl(SNDRV_CTL_IOCTL_ELEM_READ): No such device or address
>> ioctl(SNDRV_CTL_IOCTL_ELEM_WRITE): No such device or address
>>
>>
>> This bug is due to return value of condition statement for
>> 'snd_ctl_find()'. I wrote a patch to fix it.
>>
>>
>> >From d7a8fd14a1bc100dbaf9bf28af47094d5ccb882b Mon Sep 17 00:00:00 2001
>> From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> Date: Wed, 16 Mar 2016 13:40:31 +0900
>> Subject: [PATCH] ALSA: ctl: change error code in compatibility layer so that
>>  it's the same code as core implementation
>>
>> In control compatibility layer, when no elements are found by
>> ELEM_READ/ELEM_WRITE ioctl commands, ENXIO is returned. On the other
>> hand, in core implementation, ENOENT is returned. This is not good for
>> applications.
>>
>> This commit changes the return value from the compatibility layer so
>> that the same error code is returned.
>>
>> diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
>> index 0608f21..1fa7076 100644
>> --- a/sound/core/control_compat.c
>> +++ b/sound/core/control_compat.c
>> @@ -196,7 +196,7 @@ static int get_ctl_type(struct snd_card *card,
>> struct snd_ctl_elem_id *id,
>>         kctl = snd_ctl_find_id(card, id);
>>         if (! kctl) {
>>                 up_read(&card->controls_rwsem);
>> -               return -ENXIO;
>> +               return -ENOENT;
>>         }
>>         info = kzalloc(sizeof(*info), GFP_KERNEL);
>>         if (info == NULL) {
>>
>> Well, it's already in merge window for Linux 4.6. I don't mind to
>> postpone this patch to next developing cycle, while I also think it
>> better to fix the bug now. So I leave the decision to maintainers.
> 
> Looks good to me, and trivial enough to be merged for 4.6.
> Please resubmit with a proper sign off.

OK, thanks.


Takashi Sakamoto
