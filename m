From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Fixup speaker pass-through
 control for nid 0x14 on ALC225
Date: Thu, 25 Feb 2016 09:39:47 +0100
Message-ID: <56CEBDD3.9090608@canonical.com>
References: <1456388001-2640-1-git-send-email-david.henningsson@canonical.com>
 <s5hvb5dyyzp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D1A9261507
 for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2016 09:39:48 +0100 (CET)
In-Reply-To: <s5hvb5dyyzp.wl-tiwai@suse.de>
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
Cc: 1549660@bugs.launchpad.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2016-02-25 09:29, Takashi Iwai wrote:
> On Thu, 25 Feb 2016 09:13:21 +0100,
> David Henningsson wrote:
>>
>> On one of the machines we enable, we found that the actual speaker volume
>> did not always correspond to the volume set in alsamixer. This patch
>> fixes that problem.
>>
>> This patch was orginally written by Kailang @ Realtek, I've rebased it
>> to fit sound git master.
>>
>> BugLink: https://bugs.launchpad.net/bugs/1549660
>> Co-Authored-By: Kailang <kailang@realtek.com>
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>
> This conflicts with the latest for-linus branch right after I applied
> another fixup addition.  Could you again rebase to for-linus branch?

Ok, done now. Let me know when it's pushed out. Thanks!

> Also, I guess it deserves Cc to stable?

I guess so too, so added in v2. I'm always a bit scared to do so when
  1) we deal with machines that are not released yet
  2) there are verbs in there which only Kailang knows the true meaning 
of...



>
>
> thanks,
>
> Takashi
>
>> ---
>>   sound/pci/hda/patch_realtek.c | 23 +++++++++++++++++++++--
>>   1 file changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index efd4980..ab353b0 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -3801,6 +3801,10 @@ static void alc_headset_mode_mic_in(struct hda_codec *codec, hda_nid_t hp_pin,
>>
>>   static void alc_headset_mode_default(struct hda_codec *codec)
>>   {
>> +	static struct coef_fw coef0225[] = {
>> +		UPDATE_COEF(0x45, 0x3f<<10, 0x34<<10),
>> +		{}
>> +	};
>>   	static struct coef_fw coef0255[] = {
>>   		WRITE_COEF(0x45, 0xc089),
>>   		WRITE_COEF(0x45, 0xc489),
>> @@ -3842,6 +3846,9 @@ static void alc_headset_mode_default(struct hda_codec *codec)
>>   	};
>>
>>   	switch (codec->core.vendor_id) {
>> +	case 0x10ec0225:
>> +		alc_process_coef_fw(codec, coef0225);
>> +		break;
>>   	case 0x10ec0255:
>>   	case 0x10ec0256:
>>   		alc_process_coef_fw(codec, coef0255);
>> @@ -4749,6 +4756,7 @@ enum {
>>   	ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE,
>>   	ALC293_FIXUP_LENOVO_SPK_NOISE,
>>   	ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY,
>> +	ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
>>   };
>>
>>   static const struct hda_fixup alc269_fixups[] = {
>> @@ -5368,6 +5376,17 @@ static const struct hda_fixup alc269_fixups[] = {
>>   		.type = HDA_FIXUP_FUNC,
>>   		.v.func = alc233_fixup_lenovo_line2_mic_hotkey,
>>   	},
>> +	[ALC225_FIXUP_DELL1_MIC_NO_PRESENCE] = {
>> +		.type = HDA_FIXUP_VERBS,
>> +		.v.verbs = (const struct hda_verb[]) {
>> +			/* Disable pass-through path for FRONT 14h */
>> +			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x36 },
>> +			{ 0x20, AC_VERB_SET_PROC_COEF, 0x57d7 },
>> +			{}
>> +		},
>> +		.chained = true,
>> +		.chain_id = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE
>> +	},
>>   };
>>
>>   static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>> @@ -5638,10 +5657,10 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
>>   	{0x21, 0x03211020}
>>
>>   static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
>> -	SND_HDA_PIN_QUIRK(0x10ec0225, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
>> +	SND_HDA_PIN_QUIRK(0x10ec0225, 0x1028, "Dell", ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
>>   		ALC225_STANDARD_PINS,
>>   		{0x14, 0x901701a0}),
>> -	SND_HDA_PIN_QUIRK(0x10ec0225, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
>> +	SND_HDA_PIN_QUIRK(0x10ec0225, 0x1028, "Dell", ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
>>   		ALC225_STANDARD_PINS,
>>   		{0x14, 0x901701b0}),
>>   	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL2_MIC_NO_PRESENCE,
>> --
>> 1.9.1
>>
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
