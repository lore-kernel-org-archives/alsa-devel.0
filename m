From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH] ALSA: isa: gus: Fix a possible null-pointer dereference
 in snd_gf1_mem_xfree()
Date: Tue, 23 Jul 2019 21:51:28 +0800
Message-ID: <57696d77-922b-51d6-0623-5c6f4fe2b972@gmail.com>
References: <20190723134020.25972-1-baijiaju1990@gmail.com>
 <s5htvbc50cc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5htvbc50cc.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: huangfq.daxian@gmail.com, tglx@linutronix.de, allison@lohutok.net, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for the quick reply :)
I think you are right, and I did not consider "if (alloc->last == block)"
Sorry for the false report...


Best wishes,
Jia-Ju Bai

On 2019/7/23 21:47, Takashi Iwai wrote:
> On Tue, 23 Jul 2019 15:40:20 +0200,
> Jia-Ju Bai wrote:
>> In snd_gf1_mem_xfree(), there is an if statement on line 72 and line 74
>> to check whether block->next is NULL:
>>      if (block->next)
>>
>> When block->next is NULL, block->next is used on line 84:
>>      block->next->prev = block->prev;
>>
>> Thus, a possible null-pointer dereference may occur in this case.
> There is already a check beforehand:
>
> 	if (alloc->last == block) {
>
> and the code path you're referring to is only after this check fails,
> i.e. it's no last entry, hence block->next can be never NULL.
>
> So the current code is OK.
>
>
> thanks,
>
> Takashi
>
>> To fix this possible bug, block->next is checked before using it.
>>
>> This bug is found by a static analysis tool STCheck written by us.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   sound/isa/gus/gus_mem.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/isa/gus/gus_mem.c b/sound/isa/gus/gus_mem.c
>> index cb02d18dde60..ed6205b88057 100644
>> --- a/sound/isa/gus/gus_mem.c
>> +++ b/sound/isa/gus/gus_mem.c
>> @@ -81,7 +81,8 @@ int snd_gf1_mem_xfree(struct snd_gf1_mem * alloc, struct snd_gf1_mem_block * blo
>>   		if (block->prev)
>>   			block->prev->next = NULL;
>>   	} else {
>> -		block->next->prev = block->prev;
>> +		if (block->next)
>> +			block->next->prev = block->prev;
>>   		if (block->prev)
>>   			block->prev->next = block->next;
>>   	}
>> -- 
>> 2.17.0
>>
>>
