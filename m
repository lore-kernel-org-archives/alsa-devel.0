From: Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH 1/3] ALSA: timer: fix NULL pointer dereference in
 read()/ioctl() race
Date: Fri, 2 Sep 2016 14:34:47 +0200
Message-ID: <14739ff0-b415-08e5-5f5c-a29a99fe473e@oracle.com>
References: <20160828223351.32489-1-vegard.nossum@oracle.com>
 <s5hr39883ch.wl-tiwai@suse.de>
 <0560accf-2461-8205-6377-32b464bfce7e@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0560accf-2461-8205-6377-32b464bfce7e@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, syzkaller <syzkaller@googlegroups.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08/29/2016 09:14 AM, Vegard Nossum wrote:
> On 08/29/2016 09:02 AM, Takashi Iwai wrote:
>> On Mon, 29 Aug 2016 00:33:49 +0200,
>> Vegard Nossum wrote:
>>> @@ -1602,15 +1602,25 @@ static int snd_timer_user_tselect(struct file
>>> *file,
>>>      kfree(tu->tqueue);
>>>      tu->tqueue = NULL;
>>>      if (tu->tread) {
>>> -        tu->tqueue = kmalloc(tu->queue_size * sizeof(struct
>>> snd_timer_tread),
>>> +        struct snd_timer_tread *ttr;
>>> +        ttr = kmalloc(tu->queue_size * sizeof(struct snd_timer_tread),
>>>                       GFP_KERNEL);
>>> -        if (tu->tqueue == NULL)
>>> +        if (ttr) {
>>> +            kfree(tu->tqueue);
>>> +            tu->tqueue = ttr;
>>
>> This looks like the double-tree, as you didn't remove the kfree() call
>> in the above.  But, I guess this change is superfluous when you
>> introduce the mutex at...
>
> You're right, this hunk is garbage.
>
> Please see the new patch (attached), I also changed the patch
> description slightly to match the changes.
>
> I'll start running some tests on the new patch.

I tested the new patch (from the email I'm replying to). It seems to
work for me.

Thanks,


Vegard
