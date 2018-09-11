From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: Fix UBSAN warning at
 snd_soc_get/put_volsw_sx()
Date: Tue, 11 Sep 2018 14:56:32 +0530
Message-ID: <3ac92f3a-059f-3513-4942-23eb41222490@codeaurora.org>
References: <1536600836-12153-1-git-send-email-rohitkr@codeaurora.org>
 <s5hzhwp2oqd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hzhwp2oqd.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks Takashi for reviewing.


On 9/10/2018 11:56 PM, Takashi Iwai wrote:
> On Mon, 10 Sep 2018 19:33:56 +0200,
> Rohit kumar wrote:
>> In functions snd_soc_get_volsw_sx() or snd_soc_put_volsw_sx(),
>> if the result of (min + max) is negative, then fls() returns
>> signed integer with value as 32. This leads to signed integer
>> overflow as complete operation is considered as signed integer.
>>
>> UBSAN: Undefined behaviour in sound/soc/soc-ops.c:382:50
>> signed integer overflow:
>> -2147483648 - 1 cannot be represented in type 'int'
>> Call trace:
>> [<ffffff852f746fe4>] __dump_stack lib/dump_stack.c:15 [inline]
>> [<ffffff852f746fe4>] dump_stack+0xec/0x158 lib/dump_stack.c:51
>> [<ffffff852f7b5f3c>] ubsan_epilogue+0x18/0x50 lib/ubsan.c:164
>> [<ffffff852f7b6840>] handle_overflow+0xf8/0x130 lib/ubsan.c:195
>> [<ffffff852f7b68f0>] __ubsan_handle_sub_overflow+0x34/0x44 lib/ubsan.c:211
>> [<ffffff85307971a0>] snd_soc_get_volsw_sx+0x1a8/0x1f8 sound/soc/soc-ops.c:382
>>
>> Typecast the operation to unsigned int to fix the issue.
>>
>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>> ---
>>   sound/soc/soc-ops.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
>> index 592efb3..f8e3190 100644
>> --- a/sound/soc/soc-ops.c
>> +++ b/sound/soc/soc-ops.c
>> @@ -373,7 +373,7 @@ int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
>>   	unsigned int rshift = mc->rshift;
>>   	int max = mc->max;
>>   	int min = mc->min;
>> -	unsigned int mask = (1 << (fls(min + max) - 1)) - 1;
>> +	unsigned int mask = ((unsigned int)(1 << (fls(min + max) - 1)) - 1);
> Cat it be simpler like below instead?
> 	unsigned int mask = (1U << (fls(min + max) - 1)) - 1;

Yes, let me just update it.
>
> thanks,
>
> Takashi
>
>>   	unsigned int val;
>>   	int ret;
>>   
>> @@ -418,7 +418,7 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
>>   	unsigned int rshift = mc->rshift;
>>   	int max = mc->max;
>>   	int min = mc->min;
>> -	unsigned int mask = (1 << (fls(min + max) - 1)) - 1;
>> +	unsigned int mask = ((unsigned int)(1 << (fls(min + max) - 1)) - 1);
>>   	int err = 0;
>>   	unsigned int val, val_mask, val2 = 0;
>>   
>> -- 
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
>> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>>
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
Thanks,
Rohit
