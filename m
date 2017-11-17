From: walter harms <wharms@bfs.de>
Subject: Re: [PATCH] ALSA: synth: emux: remove redundant test for r <= 13
Date: Fri, 17 Nov 2017 12:11:12 +0100
Message-ID: <5A0EC3D0.6020101@bfs.de>
References: <20171114172653.6690-1-colin.king@canonical.com> <s5hwp2pyxj7.wl-tiwai@suse.de> <8de4b3a4-9ab4-3d23-6664-afffb28d864e@canonical.com>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <8de4b3a4-9ab4-3d23-6664-afffb28d864e@canonical.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



Am 17.11.2017 12:07, schrieb Colin Ian King:
> On 17/11/17 11:06, Takashi Iwai wrote:
>> On Tue, 14 Nov 2017 18:26:53 +0100,
>> Colin King wrote:
>>>
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> The calculation r = (3 - ((rate >> 6) & 3)) * 3 results in r being
>>> 0, 3, 6 or 9 and so the check (13 > r) is always true and hence we
>>> can remove the redundant check and the else path.
>>>
>>> Detected by CoverityScan, CID#744415 ("Logically dead code")
>>>
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>
>> The calculation of t itself can be generic in case we may add a
>> support greater than the current r, so I don't think it's so much
>> beneficial with this code reduction.  Better to keep the code as
>> reference.
> 
> OK, that's a good decision.
> 

NTL is should be documented that this is intentional before the next
scanner finds it.

just my 2 cents,

re,
 wh




> Colin
>>
>>
>> thanks,
>>
>> Takashi
>>
>>> ---
>>>  sound/synth/emux/soundfont.c | 5 +----
>>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/sound/synth/emux/soundfont.c b/sound/synth/emux/soundfont.c
>>> index 31a4ea94830e..0beb5a737c8b 100644
>>> --- a/sound/synth/emux/soundfont.c
>>> +++ b/sound/synth/emux/soundfont.c
>>> @@ -858,10 +858,7 @@ calc_gus_envelope_time(int rate, int start, int end)
>>>  	p = rate & 0x3f;
>>>  	t = end - start;
>>>  	if (t < 0) t = -t;
>>> -	if (13 > r)
>>> -		t = t << (13 - r);
>>> -	else
>>> -		t = t >> (r - 13);
>>> +	t = t << (13 - r);
>>>  	return (t * 10) / (p * 441);
>>>  }
>>>  
>>> -- 
>>> 2.14.1
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
