From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: timer: fix ioctl compatibility for
 different data models
Date: Wed, 23 Mar 2016 00:03:28 +0900
Message-ID: <56F15EC0.9080405@sakamocchi.jp>
References: <1458395901-2223-1-git-send-email-o-takashi@sakamocchi.jp>
 <1458395901-2223-2-git-send-email-o-takashi@sakamocchi.jp>
 <s5h7fgxtw67.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 125F2260881
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2016 16:03:32 +0100 (CET)
In-Reply-To: <s5h7fgxtw67.wl-tiwai@suse.de>
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

On Mar 20 2016 17:01, Takashi Iwai wrote:
> On Sat, 19 Mar 2016 14:58:21 +0100,
> Takashi Sakamoto wrote:
>>
>> 'struct snd_timer_gparams' includes some members with 'unsigned long',
>> therefore its size differs depending on data models (ILP32/LP64). As a
>> result, x86/x32 applications fail to execute ioctl(2) with
>> SNDRV_TIMER_GPARAMS on x86_64 machine.
>>
>> This commit fixes this bug by adding a pair of structure and ioctl
>> command for the compatibility.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> ---
>>  sound/core/timer_compat.c | 29 ++++++++++++++++++++++++++++-
>>  1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/core/timer_compat.c b/sound/core/timer_compat.c
>> index 2e90822..5809387 100644
>> --- a/sound/core/timer_compat.c
>> +++ b/sound/core/timer_compat.c
>> @@ -22,6 +22,18 @@
>>  
>>  #include <linux/compat.h>
>>  
>> +/*
>> + * In LP64, 64 bit storage alignment is used, therefore the size of this
>> + * structure is expanded to multiple of 8.
> 
> You can't say the 8 bytes alignment as LP64 generic.  It rather
> depends on each architecture.  Write something like "64bit storage
> alignment may be used (e.g. x86-64)".
> 
>> But the size should be aligned to
>> + * multiple of 4 for ILP32.
> 
> Actually, this isn't guaranteed so but practically seen, all 32bit
> architectures on Linux are at most 4 bytes alignment.

Indeed. I had misunderstandings...

>> This is a reason to use 'packed' attribute.
>> + */
>> +struct snd_timer_gparams32 {
>> +	struct snd_timer_id tid;
>> +	u32 period_num;
>> +	u32 period_den;
>> +	unsigned char reserved[32];
>> +}__attribute__((packed));
>> +
>>  struct snd_timer_info32 {
>>  	u32 flags;
>>  	s32 card;
>> @@ -32,6 +44,19 @@ struct snd_timer_info32 {
>>  	unsigned char reserved[64];
>>  };
>>  
>> +static int snd_timer_user_gparams_compat(struct file *file,
>> +					struct snd_timer_gparams32 __user *user)
>> +{
>> +	struct snd_timer_gparams gparams;
>> +
>> +	if (copy_from_user(&gparams, user,
>> +		sizeof(struct snd_timer_id) + sizeof(u32) + sizeof(u32)))
>> +		return -EFAULT;
>> +	return snd_timer_user_gparams(file,
>> +				(struct snd_timer_gparams __user *)&gparams);
> 
> This is not correct in two ways:
> 
> - You didn't convert the data to the 64bit struct.  So the passed
>   values are garbled.
> 
> - Passing the instance on the stack as a user pointer is broken
>   (unless you do some hacks).
> 
> For the first, you'd need to copy each field one by one.  For the
> latter, snd_timer_user_gparams() needs to be split to two version, one
> for kernel pointer and one for user pointer with copy_from_user().

I was careless for address spaces. Thanks for your indication.

> thanks,
> 
> Takashi


Regards

Takashi Sakamoto
