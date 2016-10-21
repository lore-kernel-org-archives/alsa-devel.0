From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [alsa-devel] [PATCH] ALSA: hda - Fix headset mic detection
 problem for two Dell laptops
Date: Fri, 21 Oct 2016 10:04:17 +0800
Message-ID: <4aa638b0-a414-6b2b-da13-e65e6bde50c6@canonical.com>
References: <1476943413-7155-1-git-send-email-hui.wang@canonical.com>
 <s5hwph31h9v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5hwph31h9v.wl-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 10/20/2016 05:50 PM, Takashi Iwai wrote:
> On Thu, 20 Oct 2016 08:03:33 +0200,
> Hui Wang wrote:
>> They uses the codec ALC255, and have the different pin cfg definition
>> from the ones in the existing pin quirk table. Now adding them into
>> the table to fix the problem.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> Thanks, applied now.
>
> But judging from the increasing number of the table entries, we may
Yes, that is really a problem.
> rethink how to match the pattern in future.  The pincfg table was
> introduced as a kind of fingerprint to match with the deployed
> configuration.  Maybe the matching should be relaxed (e.g. doesn't
> care about the assoc#), so that we can reduce the table size.
I think it is a good idea, I will do some further investigation to 
verify if it is safe or not.

Thanks
Hui.

>
> Takashi
>
>> ---
>>   sound/pci/hda/patch_realtek.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index 8483fc2..b582d57 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -5857,11 +5857,19 @@ enum {
>>   		{0x1b, 0x02011020},
>>   		{0x21, 0x0221101f}),
>>   	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
>> +		{0x14, 0x90170110},
>> +		{0x1b, 0x01011020},
>> +		{0x21, 0x0221101f}),
>> +	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
>>   		{0x14, 0x90170130},
>>   		{0x1b, 0x01014020},
>>   		{0x21, 0x0221103f}),
>>   	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
>>   		{0x14, 0x90170130},
>> +		{0x1b, 0x01011020},
>> +		{0x21, 0x0221103f}),
>> +	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
>> +		{0x14, 0x90170130},
>>   		{0x1b, 0x02011020},
>>   		{0x21, 0x0221103f}),
>>   	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
>> -- 
>> 1.9.1
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
