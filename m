From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [Xen-devel] [PATCH] ALSA: xen-front: fix unintention integer
 overflow on left shifts
Date: Mon, 1 Jul 2019 08:46:02 +0300
Message-ID: <de93db15-c85f-3108-22c3-75b89a3a2e59@gmail.com>
References: <20190627165853.21864-1-colin.king@canonical.com>
 <s5hv9wq6qrg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hv9wq6qrg.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Colin King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, xen-devel@lists.xenproject.org
List-Id: alsa-devel@alsa-project.org

On 6/28/19 11:46 AM, Takashi Iwai wrote:
> On Thu, 27 Jun 2019 18:58:53 +0200,
> Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Shifting the integer value 1 is evaluated using 32-bit
>> arithmetic and then used in an expression that expects a 64-bit
>> value, so there is potentially an integer overflow. Fix this
>> by using the BIT_ULL macro to perform the shift.
>>
>> Addresses-Coverity: ("Unintentional integer overflow")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Thank you for you patch,
Oleksandr
> The fix is correct, but luckily we didn't hit the integer overflow, as
> all passed values are less than 32bit.
>
> In anyway, applied now.  Thanks.
>
>
> Takashi
>
>> ---
>>   sound/xen/xen_snd_front_alsa.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
>> index b14ab512c2ce..e01631959ed8 100644
>> --- a/sound/xen/xen_snd_front_alsa.c
>> +++ b/sound/xen/xen_snd_front_alsa.c
>> @@ -196,7 +196,7 @@ static u64 to_sndif_formats_mask(u64 alsa_formats)
>>   	mask = 0;
>>   	for (i = 0; i < ARRAY_SIZE(ALSA_SNDIF_FORMATS); i++)
>>   		if (pcm_format_to_bits(ALSA_SNDIF_FORMATS[i].alsa) & alsa_formats)
>> -			mask |= 1 << ALSA_SNDIF_FORMATS[i].sndif;
>> +			mask |= BIT_ULL(ALSA_SNDIF_FORMATS[i].sndif);
>>   
>>   	return mask;
>>   }
>> @@ -208,7 +208,7 @@ static u64 to_alsa_formats_mask(u64 sndif_formats)
>>   
>>   	mask = 0;
>>   	for (i = 0; i < ARRAY_SIZE(ALSA_SNDIF_FORMATS); i++)
>> -		if (1 << ALSA_SNDIF_FORMATS[i].sndif & sndif_formats)
>> +		if (BIT_ULL(ALSA_SNDIF_FORMATS[i].sndif) & sndif_formats)
>>   			mask |= pcm_format_to_bits(ALSA_SNDIF_FORMATS[i].alsa);
>>   
>>   	return mask;
>> -- 
>> 2.20.1
>>
>>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
