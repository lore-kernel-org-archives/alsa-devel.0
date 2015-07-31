From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [alsa-devel] [PATCH] ALSA: hda - Add pin quirk for the headset
 mic jack detection on Dell laptop
Date: Fri, 31 Jul 2015 09:54:55 +0800
Message-ID: <55BAD56F.2060309@canonical.com>
References: <1437993271-12992-1-git-send-email-woodrow.shen@canonical.com> <s5hvbd5x47z.wl-tiwai@suse.de> <55B9F834.6080607@canonical.com> <s5hfv45rbnj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5hfv45rbnj.wl-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: 1478497@bugs.launchpad.net, alsa-devel@alsa-project.org, woodrow.shen@canonical.com, david.henningsson@canonical.com, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 07/30/2015 09:57 PM, Takashi Iwai wrote:
> On Thu, 30 Jul 2015 12:11:00 +0200,
> Hui Wang wrote:
>> On 07/27/2015 06:52 PM, Takashi Iwai wrote:
>>> On Mon, 27 Jul 2015 12:34:31 +0200,
>>> woodrow.shen@canonical.com wrote:
>>>> From: Woodrow Shen <woodrow.shen@canonical.com>
>>>>
>>>> The new Dell laptop with codec 256 can't detect headset mic when headset was
>>>> inserted on the machine. From alsa-info, we check init_pin_configs and need to
>>>> define the new register value for pin 0x1d & 0x1e because the original macro
>>>> ALC256_STANDARD_PINS can't match pin definition. Also, the macro ALC256_STANDARD_PINS
>>>> is simplified by removing them. This makes headset mic works on laptop.
>>>>
>>>> Codec: Realtek ALC256
>>>> Vendor Id: 0x10ec0256
>>>> Subsystem Id: 0x102806f2
>>>>
>>>> BugLink: https://bugs.launchpad.net/bugs/1478497
>>>> Signed-off-by: Woodrow Shen <woodrow.shen@canonical.com>
>>> I applied this as is now.  But the code there is already messy, and I
>>> wonder whether we should treat all 0x4xxxxxxx equally.  So far, all
>>> pincfgs are regarded as a kind of fingerprint.  But, judging from the
>>> actual values, the difference of 0x4xxxxxxx might be just a leftover
>>> of wastes by BIOS programmers.
>>>
>>> I don't mind any other way, but a sane cleanup would be appreciated.
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>> Something like below?
>>
>> remove all 0x4xxxxxxx from pin quirk table
>> rewrite the pin_config_match()
>>    - first, compare all pins in a quirk table with the corresponding pin
>> on the machine, if all pins get a matching,
>>    - second, compare all pins on the machine with the corresponding pin
>> in the quirk table
>>            if the pin is non-0x4xxxxxxx, it needs match a corresponding
>> pin in the quirk table, otherwise, it return false
>>            if the pin is 0x4xxxxxxx, the corresponding pin in the quirk
>> table is 0x4xxxxxxxx as well, it matches; if the corresponding pin in
>> the quirk table is non-0x4xxxxxxx, it return false
>>            if the pin is 0x4xxxxxxx, and can't find the corresponding pin
>> in the quirk table, it matches.
> Yes, something like that.  But I think the first loop can be
> reduced.
If the first loop is removed, there is some situation the second one 
can't handle.

e.g.

a quirk table has:
{0x12, 0x9xxxxxxx},
{0x14, 0x9xxxxxxx},
{0x21, 0x02xxxxxx}

while a machine only has
{0x12, 0x9xxxxxxx},
{0x21, 0x02xxxxxx}
and the NID 0x14 on the machine is a [Vendor Defined Widget] instead of 
a [pin complex].

In this situation, only the first loop can detect they are not matching.


Regards,
Hui.
>
> thanks,
>
> Takashi
>
>>
>>
>>
>> diff --git a/sound/pci/hda/hda_auto_parser.c
>> b/sound/pci/hda/hda_auto_parser.c
>> index 03b7399..2639fc3 100644
>> --- a/sound/pci/hda/hda_auto_parser.c
>> +++ b/sound/pci/hda/hda_auto_parser.c
>> @@ -887,11 +887,38 @@ EXPORT_SYMBOL_GPL(snd_hda_apply_fixup);
>>    static bool pin_config_match(struct hda_codec *codec,
>>                                const struct hda_pintbl *pins)
>>    {
>> -       for (; pins->nid; pins++) {
>> -               u32 def_conf = snd_hda_codec_get_pincfg(codec, pins->nid);
>> -               if (pins->val != def_conf)
>> +       const struct hda_pintbl *t_pins = pins;
>> +       int i;
>> +
>> +       for (; t_pins->nid; t_pins++) {
>> +               u32 def_conf = snd_hda_codec_get_pincfg(codec, t_pins->nid);
>> +               if (t_pins->val != def_conf)
>> +                       return false;
>> +       }
>> +
>> +       for (i = 0; i < codec->init_pins.used; i++) {
>> +               struct hda_pincfg *pin =
>> snd_array_elem(&codec->init_pins, i);
>> +               hda_nid_t nid = pin->nid;
>> +               u32 cfg = pin->cfg;
>> +               int found;
>> +
>> +               t_pins = pins;
>> +               found = 0;
>> +               for (; t_pins->nid; t_pins++) {
>> +                       if (t_pins->nid == nid) {
>> +                               found = 1;
>> +                               if (t_pins->val == cfg)
>> +                                       break;
>> +                               else if ((cfg & 0xf0000000) ==
>> 0x40000000 && (t_pins->val & 0xf0000000) == 0x40000000)
>> +                                       break;
>> +                               else
>> +                                       return false;
>> +                       }
>> +               }
>> +               if (!found && (cfg & 0xf0000000) != 0x40000000)
>>                           return false;
>>           }
>> +
>>           return true;
>>    }
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index 18ae17e..0fda442 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -5386,399 +5386,207 @@ static const struct hda_model_fixup
>> alc269_fixup_models[] = {
>>           {}
>>    };
>>
>> -#define ALC255_STANDARD_PINS \
>> -       {0x18, 0x411111f0}, \
>> -       {0x19, 0x411111f0}, \
>> -       {0x1a, 0x411111f0}, \
>> -       {0x1b, 0x411111f0}, \
>> -       {0x1e, 0x411111f0}
>> -
>>    #define ALC256_STANDARD_PINS \
>>           {0x12, 0x90a60140}, \
>>           {0x14, 0x90170110}, \
>> -       {0x19, 0x411111f0}, \
>> -       {0x1a, 0x411111f0}, \
>> -       {0x1b, 0x411111f0}, \
>>           {0x21, 0x02211020}
>>
>>    #define ALC282_STANDARD_PINS \
>> -       {0x14, 0x90170110}, \
>> -       {0x18, 0x411111f0}, \
>> -       {0x1a, 0x411111f0}, \
>> -       {0x1b, 0x411111f0}, \
>> -       {0x1e, 0x411111f0}
>> -
>> -#define ALC288_STANDARD_PINS \
>> -       {0x17, 0x411111f0}, \
>> -       {0x18, 0x411111f0}, \
>> -       {0x19, 0x411111f0}, \
>> -       {0x1a, 0x411111f0}, \
>> -       {0x1e, 0x411111f0}
>> +       {0x14, 0x90170110}
>>
>>    #define ALC290_STANDARD_PINS \
>> -       {0x12, 0x99a30130}, \
>> -       {0x13, 0x40000000}, \
>> -       {0x16, 0x411111f0}, \
>> -       {0x17, 0x411111f0}, \
>> -       {0x19, 0x411111f0}, \
>> -       {0x1b, 0x411111f0}, \
>> -       {0x1e, 0x411111f0}
>> +       {0x12, 0x99a30130}
>>
>>    #define ALC292_STANDARD_PINS \
>>           {0x14, 0x90170110}, \
>> -       {0x15, 0x0221401f}, \
>> -       {0x1a, 0x411111f0}, \
>> -       {0x1b, 0x411111f0}, \
>> -       {0x1d, 0x40700001}
>> -
>> -#define ALC298_STANDARD_PINS \
>> -       {0x18, 0x411111f0}, \
>> -       {0x19, 0x411111f0}, \
>> -       {0x1a, 0x411111f0}, \
>> -       {0x1e, 0x411111f0}, \
>> -       {0x1f, 0x411111f0}
>> +       {0x15, 0x0221401f}
>>
>>    static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
>>           SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell",
>> ALC255_FIXUP_DELL2_MIC_NO_PRESENCE,
>> -               ALC255_STANDARD_PINS,
>> -               {0x12, 0x40300000},
>>                   {0x14, 0x90170110},
>> -               {0x17, 0x411111f0},
>> -               {0x1d, 0x40538029},
>>                   {0x21, 0x02211020}),
>>           SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell",
>> ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
>> -               ALC255_STANDARD_PINS,
>>                   {0x12, 0x90a60140},
>>                   {0x14, 0x90170110},
>> -               {0x17, 0x40000000},
>> -               {0x1d, 0x40700001},
>>                   {0x21, 0x02211020}),
>>           SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell",
>> ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
>> -               ALC255_STANDARD_PINS,
>>                   {0x12, 0x90a60160},
>>                   {0x14, 0x90170120},
>> -               {0x17, 0x40000000},
>> -               {0x1d, 0x40700001},
>>                   {0x21, 0x02211030}),
>>           SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell",
>> ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
>> -               {0x12, 0x40000000},
>>                   {0x14, 0x90170130},
>> -               {0x17, 0x411111f0},
>> -               {0x18, 0x411111f0},
>> -               {0x19, 0x411111f0},
>> -               {0x1a, 0x411111f0},
>>                   {0x1b, 0x01014020},
>> -               {0x1d, 0x4054c029},
>> -               {0x1e, 0x411111f0},
>>                   {0x21, 0x0221103f}),
>>           SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell",
>> ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
>> -               {0x12, 0x40000000},
>>                   {0x14, 0x90170150},
>> -               {0x17, 0x411111f0},
>> -               {0x18, 0x411111f0},
>> -               {0x19, 0x411111f0},
>> -               {0x1a, 0x411111f0},
>>                   {0x1b, 0x02011020},
>> -               {0x1d, 0x4054c029},
>> -               {0x1e, 0x411111f0},
>>                   {0x21, 0x0221105f}),
>> ..........
>>
>>
>>
>>>> ---
>>>>    sound/pci/hda/patch_realtek.c | 15 +++++++++++----
>>>>    1 file changed, 11 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>>>> index d94c0e3..4ae877c 100644
>>>> --- a/sound/pci/hda/patch_realtek.c
>>>> +++ b/sound/pci/hda/patch_realtek.c
>>>> @@ -5398,8 +5398,6 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
>>>>    	{0x19, 0x411111f0}, \
>>>>    	{0x1a, 0x411111f0}, \
>>>>    	{0x1b, 0x411111f0}, \
>>>> -	{0x1d, 0x40700001}, \
>>>> -	{0x1e, 0x411111f0}, \
>>>>    	{0x21, 0x02211020}
>>>>    
>>>>    #define ALC282_STANDARD_PINS \
>>>> @@ -5556,10 +5554,19 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
>>>>    		{0x21, 0x02211030}),
>>>>    	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
>>>>    		ALC256_STANDARD_PINS,
>>>> -		{0x13, 0x40000000}),
>>>> +		{0x13, 0x40000000},
>>>> +		{0x1d, 0x40700001},
>>>> +		{0x1e, 0x411111f0}),
>>>>    	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
>>>>    		ALC256_STANDARD_PINS,
>>>> -		{0x13, 0x411111f0}),
>>>> +		{0x13, 0x411111f0},
>>>> +		{0x1d, 0x40700001},
>>>> +		{0x1e, 0x411111f0}),
>>>> +	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
>>>> +		ALC256_STANDARD_PINS,
>>>> +		{0x13, 0x411111f0},
>>>> +		{0x1d, 0x4077992d},
>>>> +		{0x1e, 0x411111ff}),
>>>>    	SND_HDA_PIN_QUIRK(0x10ec0280, 0x103c, "HP", ALC280_FIXUP_HP_GPIO4,
>>>>    		{0x12, 0x90a60130},
>>>>    		{0x13, 0x40000000},
>>>> -- 
>>>> 2.1.4
>>>>
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
