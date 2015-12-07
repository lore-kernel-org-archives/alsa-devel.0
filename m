From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Fixing speaker noise on two
 thinkpad machines
Date: Mon, 7 Dec 2015 22:38:05 +0800
Message-ID: <566599CD.7030900@canonical.com>
References: <1449498712-21498-1-git-send-email-hui.wang@canonical.com>
 <s5hh9jumim3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CECB260420
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 15:38:10 +0100 (CET)
In-Reply-To: <s5hh9jumim3.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/07/2015 10:35 PM, Takashi Iwai wrote:
> On Mon, 07 Dec 2015 15:31:52 +0100,
> Hui Wang wrote:
>> Disable the aamix can fix this problem.
> Which codec do these machines have?

Codec: Realtek ALC293
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0293

>
> Takashi
>
>> Cc: stable@vger.kernel.org
>> BugLink: https://bugs.launchpad.net/bugs/1523517
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>>   sound/pci/hda/patch_realtek.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index ebc5362..49b1d36 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -4596,6 +4596,7 @@ enum {
>>   	ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
>>   	ALC275_FIXUP_DELL_XPS,
>>   	ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE,
>> +	ALC293_FIXUP_LENOVO_SPK_NOISE,
>>   };
>>   
>>   static const struct hda_fixup alc269_fixups[] = {
>> @@ -5187,6 +5188,12 @@ static const struct hda_fixup alc269_fixups[] = {
>>   		.chained = true,
>>   		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE
>>   	},
>> +	[ALC293_FIXUP_LENOVO_SPK_NOISE] = {
>> +		.type = HDA_FIXUP_FUNC,
>> +		.v.func = alc_fixup_disable_aamix,
>> +		.chained = true,
>> +		.chain_id = ALC269_FIXUP_THINKPAD_ACPI
>> +	},
>>   };
>>   
>>   static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>> @@ -5334,6 +5341,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>>   	SND_PCI_QUIRK(0x17aa, 0x2215, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>>   	SND_PCI_QUIRK(0x17aa, 0x2223, "ThinkPad T550", ALC292_FIXUP_TPT440_DOCK),
>>   	SND_PCI_QUIRK(0x17aa, 0x2226, "ThinkPad X250", ALC292_FIXUP_TPT440_DOCK),
>> +	SND_PCI_QUIRK(0x17aa, 0x2233, "Thinkpad", ALC293_FIXUP_LENOVO_SPK_NOISE),
>>   	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
>>   	SND_PCI_QUIRK(0x17aa, 0x3978, "IdeaPad Y410P", ALC269_FIXUP_NO_SHUTUP),
>>   	SND_PCI_QUIRK(0x17aa, 0x5013, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>> @@ -5343,6 +5351,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>>   	SND_PCI_QUIRK(0x17aa, 0x5034, "Thinkpad T450", ALC292_FIXUP_TPT440_DOCK),
>>   	SND_PCI_QUIRK(0x17aa, 0x5036, "Thinkpad T450s", ALC292_FIXUP_TPT440_DOCK),
>>   	SND_PCI_QUIRK(0x17aa, 0x503c, "Thinkpad L450", ALC292_FIXUP_TPT440_DOCK),
>> +	SND_PCI_QUIRK(0x17aa, 0x504b, "Thinkpad", ALC293_FIXUP_LENOVO_SPK_NOISE),
>>   	SND_PCI_QUIRK(0x17aa, 0x5109, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>>   	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
>>   	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
>> -- 
>> 1.9.1
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
