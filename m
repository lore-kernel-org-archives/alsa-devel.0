From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] Enable internal mic on a Thinkpad machine
Date: Mon, 30 Sep 2013 16:30:33 +0200
Message-ID: <52498B09.50605@canonical.com>
References: <1380280225-19108-1-git-send-email-david.henningsson@canonical.com>
 <s5h4n968nt6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B858E261A79
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 16:30:32 +0200 (CEST)
In-Reply-To: <s5h4n968nt6.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, kailang@realtek.com, 1231931@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 09/27/2013 02:13 PM, Takashi Iwai wrote:
> At Fri, 27 Sep 2013 13:10:25 +0200,
> David Henningsson wrote:
>>
>> From: Kailang <kailang@realtek.com>
>>
>> More thorough testing showed that these verbs were necessary to
>> improve quality of the internal mic. Patch originally from Realtek.
>>
>> Cc: stable@kernel.org (3.11)
>> BugLink: https://bugs.launchpad.net/bugs/1231931
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>> ---
> 
> Applied it now, but dropped the Cc to stable, since this can't be
> applied cleanly without your former patch, which wasn't merged to
> stable either.  If you'd like to move them to Cc, please inform the
> all necessary upstream commit ids.

Ah, I thought the other fixup made it into 3.11. Thanks for checking.
I'll talk to stable if I need it backported to 3.11.

> 
> 
> thanks,
> 
> Takashi
> 
>>  sound/pci/hda/patch_realtek.c |   13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index bc07d36..c4d54a9 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -3531,6 +3531,7 @@ enum {
>>  	ALC269VB_FIXUP_ORDISSIMO_EVE2,
>>  	ALC283_FIXUP_CHROME_BOOK,
>>  	ALC282_FIXUP_ASUS_TX300,
>> +	ALC283_FIXUP_INT_MIC,
>>  };
>>  
>>  static const struct hda_fixup alc269_fixups[] = {
>> @@ -3790,6 +3791,16 @@ static const struct hda_fixup alc269_fixups[] = {
>>  		.type = HDA_FIXUP_FUNC,
>>  		.v.func = alc282_fixup_asus_tx300,
>>  	},
>> +	[ALC283_FIXUP_INT_MIC] = {
>> +		.type = HDA_FIXUP_VERBS,
>> +		.v.verbs = (const struct hda_verb[]) {
>> +			{0x20, AC_VERB_SET_COEF_INDEX, 0x1a},
>> +			{0x20, AC_VERB_SET_PROC_COEF, 0x0011},
>> +			{ }
>> +		},
>> +	.chained = true,
>> +	.chain_id = ALC269_FIXUP_LIMIT_INT_MIC_BOOST
>> +	},
>>  };
>>  
>>  static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>> @@ -3874,7 +3885,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>>  	SND_PCI_QUIRK(0x17aa, 0x2214, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>>  	SND_PCI_QUIRK(0x17aa, 0x2215, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>>  	SND_PCI_QUIRK(0x17aa, 0x5013, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>> -	SND_PCI_QUIRK(0x17aa, 0x501a, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>> +	SND_PCI_QUIRK(0x17aa, 0x501a, "Thinkpad", ALC283_FIXUP_INT_MIC),
>>  	SND_PCI_QUIRK(0x17aa, 0x5026, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>>  	SND_PCI_QUIRK(0x17aa, 0x5109, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>>  	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
>> -- 
>> 1.7.9.5
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
