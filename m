From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-lib][PATCH] control: correct assertion in
 snd_ctl_elem_set_bytes()
Date: Mon, 22 Feb 2016 09:34:30 +0900
Message-ID: <56CA5796.5010108@sakamocchi.jp>
References: <1456073649-15885-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hfuwmvtv5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id D967126057F
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 01:34:36 +0100 (CET)
In-Reply-To: <s5hfuwmvtv5.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Feb 22 2016 02:46, Takashi Iwai wrote:
> On Sun, 21 Feb 2016 17:54:09 +0100,
> Takashi Sakamoto wrote:
>>
>> The assert(3) aborts running process when expression arguments is
>> false (zero). Although, the snd_ctl_elem_set_bytes() has return
>> statement after assert(3). It has meaningless.
> 
> Admittedly this isn't an optimal code, but it has its purpose.
> The intention of the original code was to perform the check always but
> triggers the assert signal unless NDEBUG is set (remember that
> assert() is nop when NDEBUG is defined).

Although I realized the effect of NDEBUG for calls of asset(3), I didn't
realize the intension to the code, because the other parts of
'src/control/control.c' are written without such intention. We can see
many assert(3)s are just used without conditional statements.

Hm. I think it better to keep consistency of whole codes rather than
such partial intensions. On the other hand, this patch changes library
behaviour. It's not generally allowed, but here, I think it better
because of the consistency and the actual effect.


Thanks

Takashi Sakamoto

>> This commit corrects the statements.
>>
>> Fixes: 7893ea238d5a('Added mode argument to open functions where it was missing. First part of CTL documentation')
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> ---
>>  src/control/control.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/src/control/control.c b/src/control/control.c
>> index 328920d..70d168d 100644
>> --- a/src/control/control.c
>> +++ b/src/control/control.c
>> @@ -2627,10 +2627,7 @@ void snd_ctl_elem_value_set_byte(snd_ctl_elem_value_t *obj, unsigned int idx, un
>>  void snd_ctl_elem_set_bytes(snd_ctl_elem_value_t *obj, void *data, size_t size)
>>  {
>>  	assert(obj);
>> -	if (size >= ARRAY_SIZE(obj->value.bytes.data)) {
>> -		assert(0);
>> -		return;
>> -	}
>> +	assert(size < ARRAY_SIZE(obj->value.bytes.data));
>>  	memcpy(obj->value.bytes.data, data, size);
>>  }
>>  
>> -- 
>> 2.5.0
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
