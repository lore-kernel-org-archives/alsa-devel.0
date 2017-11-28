From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: Re: [PATCH 2/3] ALSA: usb-audio: Fix return value check for usb_string()
Date: Tue, 28 Nov 2017 16:32:13 +0900
Message-ID: <CAL6iAa+LzV6YM5nx9EZzt4MEshqj79bzrBOymEUnGMnP61WQzA@mail.gmail.com>
References: <1511829388-5245-1-git-send-email-climbbb.kim@gmail.com>
 <1511829388-5245-3-git-send-email-climbbb.kim@gmail.com> <s5hpo82lxo6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5hpo82lxo6.wl-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, stable <stable@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2017-11-28 15:33 GMT+09:00 Takashi Iwai <tiwai@suse.de>:
> On Tue, 28 Nov 2017 01:36:27 +0100,
> Jaejoong Kim wrote:
>>
>> In case of failure, the usb_string() can return a negative number. Therefore,
>> the return value of snd_usb_copy_string_desc() and get_term_name() can also
>> be negative.
>>
>> Check the return values for these functions as follows:
>>
>>   len = snd_usb_copy_string_desc();
>>   if (!len) ...
>>
>> If len is negative, the if-statement is false and fails to handle exceptions.
>> So, we need to change it to a value less than or equal to zero.
>>
>> Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
>
> In that case, an easier (and likely safer) solution is to limit
> snd_usb_copy_string_desc() not to return a negative value.
> That is, at the first patch, instead of return len for a negative
> value, return 0.  Then the second patch can be dropped.

I agree. Just return 0 is more simple way.
>
> The drawback is that the caller can't know of the error, but the
> current code doesn't differentiate between error and zero length.
> And dealing such an error (e.g. EINVAL) as zero-length isn't bad,
> either, as it just indicates the invalid string, not a fatal error.
>

Right. The current code does not distinguish between errors and zero length.

I will resend patch1 and patch 3 with your suggestion.

Thanks for your feedback.

jaejoong

>
> thanks,
>
> Takashi
>
>> ---
>>  sound/usb/mixer.c | 27 +++++++++++++++------------
>>  1 file changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
>> index da7cbe7..8a434b7 100644
>> --- a/sound/usb/mixer.c
>> +++ b/sound/usb/mixer.c
>> @@ -1235,7 +1235,7 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
>>  {
>>       struct uac_feature_unit_descriptor *desc = raw_desc;
>>       struct usb_feature_control_info *ctl_info;
>> -     unsigned int len = 0;
>> +     int len = 0;
>>       int mapped_name = 0;
>>       int nameid = uac_feature_unit_iFeature(desc);
>>       struct snd_kcontrol *kctl;
>> @@ -1313,14 +1313,14 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
>>                * - if the connected output can be determined, use it.
>>                * - otherwise, anonymous name.
>>                */
>> -             if (!len) {
>> +             if (len <= 0) {
>>                       len = get_term_name(state, iterm, kctl->id.name,
>>                                           sizeof(kctl->id.name), 1);
>> -                     if (!len)
>> +                     if (len <= 0)
>>                               len = get_term_name(state, &state->oterm,
>>                                                   kctl->id.name,
>>                                                   sizeof(kctl->id.name), 1);
>> -                     if (!len)
>> +                     if (len <= 0)
>>                               snprintf(kctl->id.name, sizeof(kctl->id.name),
>>                                        "Feature %d", unitid);
>>               }
>> @@ -1343,7 +1343,7 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
>>                               " Switch" : " Volume");
>>               break;
>>       default:
>> -             if (!len)
>> +             if (len <= 0)
>>                       strlcpy(kctl->id.name, audio_feature_info[control-1].name,
>>                               sizeof(kctl->id.name));
>>               break;
>> @@ -1610,7 +1610,8 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
>>  {
>>       struct usb_mixer_elem_info *cval;
>>       unsigned int num_outs = uac_mixer_unit_bNrChannels(desc);
>> -     unsigned int i, len;
>> +     unsigned int i;
>> +     int len;
>>       struct snd_kcontrol *kctl;
>>       const struct usbmix_name_map *map;
>>
>> @@ -1649,7 +1650,7 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
>>       if (!len)
>>               len = get_term_name(state, iterm, kctl->id.name,
>>                                   sizeof(kctl->id.name), 0);
>> -     if (!len)
>> +     if (len <= 0)
>>               len = sprintf(kctl->id.name, "Mixer Source %d", in_ch + 1);
>>       append_ctl_name(kctl, " Volume");
>>
>> @@ -1947,7 +1948,7 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
>>                               len = snd_usb_copy_string_desc(state, nameid,
>>                                                              kctl->id.name,
>>                                                              sizeof(kctl->id.name));
>> -                     if (!len)
>> +                     if (len <= 0)
>>                               strlcpy(kctl->id.name, name, sizeof(kctl->id.name));
>>               }
>>               append_ctl_name(kctl, " ");
>> @@ -2077,7 +2078,8 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
>>                                    void *raw_desc)
>>  {
>>       struct uac_selector_unit_descriptor *desc = raw_desc;
>> -     unsigned int i, nameid, len;
>> +     unsigned int i, nameid;
>> +     int len;
>>       int err;
>>       struct usb_mixer_elem_info *cval;
>>       struct snd_kcontrol *kctl;
>> @@ -2138,9 +2140,10 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
>>               }
>>               len = check_mapped_selector_name(state, unitid, i, namelist[i],
>>                                                MAX_ITEM_NAME_LEN);
>> -             if (! len && check_input_term(state, desc->baSourceID[i], &iterm) >= 0)
>> +             if (!len && check_input_term(state, desc->baSourceID[i], &iterm) >= 0)
>>                       len = get_term_name(state, &iterm, namelist[i], MAX_ITEM_NAME_LEN, 0);
>> -             if (! len)
>> +
>> +             if (len <= 0)
>>                       sprintf(namelist[i], "Input %u", i);
>>       }
>>
>> @@ -2164,7 +2167,7 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
>>       else {
>>               len = get_term_name(state, &state->oterm,
>>                                   kctl->id.name, sizeof(kctl->id.name), 0);
>> -             if (!len)
>> +             if (len <= 0)
>>                       strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
>>
>>               if (desc->bDescriptorSubtype == UAC2_CLOCK_SELECTOR)
>> --
>> 2.7.4
>>
