From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Add multifunction jack support
	for ALC255
Date: Fri, 08 Nov 2013 11:10:48 +0100
Message-ID: <527CB8A8.4010603@canonical.com>
References: <1383829721-3220-1-git-send-email-david.henningsson@canonical.com>
 <s5hob5wtkhs.wl%tiwai@suse.de> <527B9667.4010404@canonical.com>
 <C48D0657F2504A4FB2CE22E130F7A77A@realtek.com.tw>
 <527C7CBA.3020508@canonical.com>
 <18BB75C648E74F1492FD24591C5C354F@realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 798372617A4
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 11:10:53 +0100 (CET)
In-Reply-To: <18BB75C648E74F1492FD24591C5C354F@realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kailang <kailang@realtek.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, 1248949@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 11/08/2013 09:19 AM, Kailang wrote:
> Hi David,
> 
> I modified as attach patch.
> It included coef_idx to use coefex_idx.
> 
> BR,
> Kailang

Thanks!

@Takashi, does this new patch look good enough for you?

> 
> 
>> Hi Kailang,
>>
>> It does not matter. Choose what works best for you and I'll sort it out
>> before sending to Takashi.
>>
>> // David
>>
>> On 11/08/2013 06:48 AM, Kailang wrote:
>>> Hi David,
>>>
>>> Could I add commemts for belowing context?
>>> Or I create new patch for it.
>>>
>>> BR,
>>> Kailang
>>>
>>>> Hi,
>>>>
>>>> I can certainly rewrite coef_idx to use coefef_idx (I think that's a
>>>> good idea), but for the comments, I know as little as you do about
>>>> these
>>>> verbs.
>>>>
>>>> Kailang, is it possible for you to add more comments to your patch
>>>> so it
>>>> can be applied upstream?
>>>>
>>>> Thanks,
>>>>  David
>>>>
>>>> On 11/07/2013 02:22 PM, Takashi Iwai wrote:
>>>>> At Thu,  7 Nov 2013 14:08:41 +0100,
>>>>> David Henningsson wrote:
>>>>>>
>>>>>> From: Kailang Yang <kailang@realtek.com>
>>>>>>
>>>>>> The new codec ALC255 needs its own set of verbs to enable
>>>>>> multifunction jacks.
>>>>>>
>>>>>> (Context and whitespace adjustments by David Henningsson)
>>>>>>
>>>>>> BugLink: https://bugs.launchpad.net/bugs/1248949
>>>>>> Tested-by: Doro Wu <doro.wu@canonical.com>
>>>>>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>>>>>> ---
>>>>>>  sound/pci/hda/patch_realtek.c |   91
>>>>>> +++++++++++++++++++++++++++++++++++++++++
>>>>>>  1 file changed, 91 insertions(+)
>>>>>>
>>>>>> diff --git a/sound/pci/hda/patch_realtek.c
>>>>>> b/sound/pci/hda/patch_realtek.c
>>>>>> index daf7205..ceadd65 100644
>>>>>> --- a/sound/pci/hda/patch_realtek.c
>>>>>> +++ b/sound/pci/hda/patch_realtek.c
>>>>>> @@ -588,6 +588,18 @@ static int alc_read_coef_idx(struct hda_codec
>>>>>> *codec,
>>>>>>  return val;
>>>>>>  }
>>>>>>
>>>>>> +static int alc_read_coefex_idx(struct hda_codec *codec,
>>>>>> + hda_nid_t nid,
>>>>>> + unsigned int coef_idx)
>>>>>> +{
>>>>>> + unsigned int val;
>>>>>> + snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX,
>>>>>> +     coef_idx);
>>>>>> + val = snd_hda_codec_read(codec, nid, 0,
>>>>>> + AC_VERB_GET_PROC_COEF, 0);
>>>>>> + return val;
>>>>>> +}
>>>>>
>>>>> Rewrite alc_read_coef_idx() using this new function, too, e.g.
>>>>>
>>>>> #define alc_write_coef_idx(codec, idx, val) \
>>>>> alc_read_coefex_idx(codec, 0x20, idx, val)
>>>>>
>>>>>>  static void alc_write_coef_idx(struct hda_codec *codec, unsigned
>>>>>> int coef_idx,
>>>>>>  unsigned int coef_val)
>>>>>>  {
>>>>>> @@ -597,6 +609,15 @@ static void alc_write_coef_idx(struct hda_codec
>>>>>> *codec, unsigned int coef_idx,
>>>>>>      coef_val);
>>>>>>  }
>>>>>>
>>>>>> +static void alc_write_coefex_idx(struct hda_codec *codec, hda_nid_t
>>>>>> nid,
>>>>>> + unsigned int coef_idx, unsigned int coef_val)
>>>>>> +{
>>>>>> + snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX,
>>>>>> +     coef_idx);
>>>>>> + snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_PROC_COEF,
>>>>>> +     coef_val);
>>>>>> +}
>>>>>
>>>>> Ditto.
>>>>>
>>>>>> +
>>>>>>  /* a special bypass for COEF 0; read the cached value at the second
>>>>>> time */
>>>>>>  static unsigned int alc_get_coef0(struct hda_codec *codec)
>>>>>>  {
>>>>>> @@ -3109,6 +3130,14 @@ static void alc_headset_mode_unplugged(struct
>>>>>> hda_codec *codec)
>>>>>>  int val;
>>>>>>
>>>>>>  switch (codec->vendor_id) {
>>>>>> + case 0x10ec0255:
>>>>>> + alc_write_coef_idx(codec, 0x1b, 0x0c0b);
>>>>>> + alc_write_coef_idx(codec, 0x45, 0xd089);
>>>>>> + val = alc_read_coefex_idx(codec, 0x57, 0x05);
>>>>>> + alc_write_coefex_idx(codec, 0x57, 0x05, val & ~(1<<14));
>>>>>> + alc_write_coef_idx(codec, 0x06, 0x6104);
>>>>>> + alc_write_coefex_idx(codec, 0x57, 0x03, 0x8aa6);
>>>>>
>>>>> Try to comment what these actually do.  Not necessarily too detailed,
>>>>> but we need to have some ideas.
>>>>>
>>>>> I regret to have merged the former Realtek headset patches that have
>>>>> lots of such verbs without certain comments.
>>>>>
>>>>>
>>>>> thanks,
>>>>>
>>>>> Takashi
>>>>>
>>>>
>>>>
>>>>
>>>> -- 
>>>> David Henningsson, Canonical Ltd.
>>>> https://launchpad.net/~diwic
>>>>
>>>> ------Please consider the environment before printing this e-mail.
>>>
>>
>>
>>
>> -- 
>> David Henningsson, Canonical Ltd.
>> https://launchpad.net/~diwic 



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
