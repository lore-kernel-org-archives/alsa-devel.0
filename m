From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Disable Headphone Mic boost
	for ALC662
Date: Thu, 28 May 2015 09:25:41 +0200
Message-ID: <5566C2F5.2090705@canonical.com>
References: <1432797346-2742-1-git-send-email-david.henningsson@canonical.com>
 <s5h4mmxcgq7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DC41260459
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 09:25:42 +0200 (CEST)
In-Reply-To: <s5h4mmxcgq7.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, 1454235@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org



On 2015-05-28 09:18, Takashi Iwai wrote:
> At Thu, 28 May 2015 09:15:46 +0200,
> David Henningsson wrote:
>>
>> When headphone mic boost is above zero, some 10 - 20 second delay
>> might occur before the headphone mic is operational.
>> Therefore disable the headphone mic boost control (recording gain is
>> sufficient even without it).
>>
>> (Note: this patch is not about the headset mic, it's about the less
>> common mic-in only mode.)
>>
>> BugLink: https://bugs.launchpad.net/bugs/1454235
>> Suggested-by: Kailang Yang <kailang@realtek.com>
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>> ---
>>   sound/pci/hda/patch_realtek.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index d0fa455..87605fc 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -4240,6 +4240,10 @@ static void alc_fixup_headset_mode_alc662(struct hda_codec *codec,
>>   	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
>>   		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
>>   		spec->gen.hp_mic = 1; /* Mic-in is same pin as headphone */
>> +
>> +		/* Disable boost for mic-in permanently */
>> +		snd_hda_codec_write(codec, 0x1b, 0, AC_VERB_SET_AMP_GAIN_MUTE, 0x7000);
>> +		snd_hda_override_wcaps(codec, 0x1b, get_wcaps(codec, 0x1b) & ~AC_WCAP_IN_AMP);
>
> Can we really hard-code NID 0x1b here...?

alc_fixup_headset_mode_alc662 is currently only called from a pin fixup 
quirk (via ALC662_FIXUP_DELL_MIC_NO_PRESENCE), and that pin quirk has 
headphone at 0x1b, so yes.

It would we better if we could make it more generic, but I think doing 
this at HDA_FIXUP_PROBE instead would be too late (the boost control, 
paths, etc, would already be created)...?

Do you have a better suggestion?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
