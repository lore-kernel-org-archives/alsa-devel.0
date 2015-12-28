From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [alsa-devel] [PATCH 2/2] ALSA: hda - Add keycode map for alc
 input device
Date: Mon, 28 Dec 2015 11:04:18 +0800
Message-ID: <5680A6B2.7020707@canonical.com>
References: <1450928798-31191-1-git-send-email-hui.wang@canonical.com>
 <1450928798-31191-2-git-send-email-hui.wang@canonical.com>
 <s5hd1tvufs6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5hd1tvufs6.wl-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Got it, will address them in the V2.
Thanks.


On 12/25/2015 03:51 PM, Takashi Iwai wrote:
> On Thu, 24 Dec 2015 04:46:38 +0100,
> Hui Wang wrote:
>> Then users can remap the keycode from userspace. If without the remap,
>> the input device will pass KEY_MICMUTE to userspace, but in X11 layer,
>> it uses KEY_F20 rather than KEY_MICMUTE for XF86AudioMicMute. After
>> adding the keycode map, users can remap the keycode to any value users
>> want.
>>
>> And there are two places to register the input device, to make the
>> code simple and clean, we move the two same code sections into a
>> function.
> Having this change at first would be better.  Then you can avoid a
> build-and-scratch sequence but just use the new helper from the
> beginning.
>
> Also...
>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>>   sound/pci/hda/patch_realtek.c | 68 +++++++++++++++++++++++++------------------
>>   1 file changed, 40 insertions(+), 28 deletions(-)
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index 8adff4f..97f22ad 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -67,6 +67,14 @@ enum {
>>   	ALC_HEADSET_TYPE_OMTP,
>>   };
>>   
>> +enum {
>> +	ALC_KEY_MICMUTE_INDEX,
>> +};
>> +
>> +static u8 alc_mute_keycode_map[] = {
>> +	KEY_MICMUTE,	/* index=0, microphone mute key code */
>> +};
> You're sharing this array, and remapping will overwrite this.
> For example, if the codec is once unbound and bound again, the
> modified keymap will be passed to the new instance.  Use an array in
> alc_spec instead.
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
