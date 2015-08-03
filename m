From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [alsa-devel] [PATCH] ALSA: hda - Add pin quirk for the headset
 mic jack detection on Dell laptop
Date: Mon, 03 Aug 2015 09:11:47 +0800
Message-ID: <55BEBFD3.6010507@canonical.com>
References: <1437993271-12992-1-git-send-email-woodrow.shen@canonical.com> <s5hvbd5x47z.wl-tiwai@suse.de> <55B9F834.6080607@canonical.com> <s5hfv45rbnj.wl-tiwai@suse.de> <55BAD56F.2060309@canonical.com> <s5htwsib1ls.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5htwsib1ls.wl-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: woodrow.shen@canonical.com, alsa-devel@alsa-project.org, 1478497@bugs.launchpad.net, stable@vger.kernel.org, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

On 08/02/2015 03:17 PM, Takashi Iwai wrote:
> On Fri, 31 Jul 2015 03:54:55 +0200,
> Hui Wang wrote:
>> On 07/30/2015 09:57 PM, Takashi Iwai wrote:
>>> On Thu, 30 Jul 2015 12:11:00 +0200,
>>> Hui Wang wrote:
>>>> On 07/27/2015 06:52 PM, Takashi Iwai wrote:
>>>>> On Mon, 27 Jul 2015 12:34:31 +0200,
>>>>> woodrow.shen@canonical.com wrote:
>>>>>> From: Woodrow Shen <woodrow.shen@canonical.com>
>>>>>>
>>>>>> The new Dell laptop with codec 256 can't detect headset mic when headset was
>>>>>> inserted on the machine. From alsa-info, we check init_pin_configs and need to
>>>>>> define the new register value for pin 0x1d & 0x1e because the original macro
>>>>>> ALC256_STANDARD_PINS can't match pin definition. Also, the macro ALC256_STANDARD_PINS
>>>>>> is simplified by removing them. This makes headset mic works on laptop.
>>>>>>
>>>>>> Codec: Realtek ALC256
>>>>>> Vendor Id: 0x10ec0256
>>>>>> Subsystem Id: 0x102806f2
>>>>>>
>>>>>> BugLink: https://bugs.launchpad.net/bugs/1478497
>>>>>> Signed-off-by: Woodrow Shen <woodrow.shen@canonical.com>
>>>>> I applied this as is now.  But the code there is already messy, and I
>>>>> wonder whether we should treat all 0x4xxxxxxx equally.  So far, all
>>>>> pincfgs are regarded as a kind of fingerprint.  But, judging from the
>>>>> actual values, the difference of 0x4xxxxxxx might be just a leftover
>>>>> of wastes by BIOS programmers.
>>>>>
>>>>> I don't mind any other way, but a sane cleanup would be appreciated.
>>>>>
>>>>>
>>>>> thanks,
>>>>>
>>>>> Takashi
>>>> Something like below?
>>>>
>>>> remove all 0x4xxxxxxx from pin quirk table
>>>> rewrite the pin_config_match()
>>>>     - first, compare all pins in a quirk table with the corresponding pin
>>>> on the machine, if all pins get a matching,
>>>>     - second, compare all pins on the machine with the corresponding pin
>>>> in the quirk table
>>>>             if the pin is non-0x4xxxxxxx, it needs match a corresponding
>>>> pin in the quirk table, otherwise, it return false
>>>>             if the pin is 0x4xxxxxxx, the corresponding pin in the quirk
>>>> table is 0x4xxxxxxxx as well, it matches; if the corresponding pin in
>>>> the quirk table is non-0x4xxxxxxx, it return false
>>>>             if the pin is 0x4xxxxxxx, and can't find the corresponding pin
>>>> in the quirk table, it matches.
>>> Yes, something like that.  But I think the first loop can be
>>> reduced.
>> If the first loop is removed, there is some situation the second one
>> can't handle.
>>
>> e.g.
>>
>> a quirk table has:
>> {0x12, 0x9xxxxxxx},
>> {0x14, 0x9xxxxxxx},
>> {0x21, 0x02xxxxxx}
>>
>> while a machine only has
>> {0x12, 0x9xxxxxxx},
>> {0x21, 0x02xxxxxx}
>> and the NID 0x14 on the machine is a [Vendor Defined Widget] instead of
>> a [pin complex].
> Hm, OK, then it's a problem.  Does it happen actually -- i.e. the same
> codec ID / revision, but containing have different widget types?
>
>
> Takashi
In practice, I have never seen this situation before. I will remove the 
first loop and send a patch to review.

Thanks,
Hui.
>> In this situation, only the first loop can detect they are not matching.
>>
>>
