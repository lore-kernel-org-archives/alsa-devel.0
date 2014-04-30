From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - add headset mic detect quirk
	for a Dell laptop
Date: Wed, 30 Apr 2014 17:32:04 +0200
Message-ID: <53611774.3070601@canonical.com>
References: <1398827160-20348-1-git-send-email-hui.wang@canonical.com>
 <s5h7g67je6v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 81710265177
 for <alsa-devel@alsa-project.org>; Wed, 30 Apr 2014 17:32:04 +0200 (CEST)
In-Reply-To: <s5h7g67je6v.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Hui Wang <hui.wang@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(Drop stable from cc)

On 2014-04-30 12:37, Takashi Iwai wrote:
> At Wed, 30 Apr 2014 11:06:00 +0800,
> Hui Wang wrote:
>>
>> When we plug a 3-ring headset on the Dell machine (VID: 0x10ec0255,
>> SID: 0x1028067e), the headset mic can't be detected, after apply this
>> patch, the headset mic can work well.
>>
>> BugLink: https://bugs.launchpad.net/bugs/1297581
>> Cc: David Henningsson <david.henningsson@canonical.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>
> Thanks, applied.
>
> But now I'm slowly thinking of cleaning these messes; can't we detect
> this a bit more elegantly?

I've been thinking of that too. I'm wondering if the combination of 
vendor (Dell), codec (e g ALC255), and pin config could be wise here? I 
e, if all of the pin configuration default values are exactly the same, 
then we should be reasonably sure that it is to be used in the same way.

So, essentially have a quirk table with PCI Subvendor + codec + pin 
config as key? What do you think of that?

>
>
> Takashi
>
>> ---
>>   sound/pci/hda/patch_realtek.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index e96ab33..b60de0d 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -4711,6 +4711,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>>   	SND_PCI_QUIRK(0x1028, 0x0668, "Dell", ALC255_FIXUP_DELL2_MIC_NO_PRESENCE),
>>   	SND_PCI_QUIRK(0x1028, 0x0669, "Dell", ALC255_FIXUP_DELL2_MIC_NO_PRESENCE),
>>   	SND_PCI_QUIRK(0x1028, 0x0674, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
>> +	SND_PCI_QUIRK(0x1028, 0x067e, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
>>   	SND_PCI_QUIRK(0x1028, 0x067f, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
>>   	SND_PCI_QUIRK(0x1028, 0x15cc, "Dell X5 Precision", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
>>   	SND_PCI_QUIRK(0x1028, 0x15cd, "Dell X5 Precision", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
>> --
>> 1.8.1.2
>>
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
