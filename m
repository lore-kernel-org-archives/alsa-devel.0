From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/2] ALSA: hda - Fix microphone for Sony VAIO Pro 13 (Haswell
 model)
Date: Thu, 10 Oct 2013 15:26:03 +0200
Message-ID: <5256AAEB.6060300@canonical.com>
References: <1381400364-6067-1-git-send-email-david.henningsson@canonical.com>	<1381400364-6067-2-git-send-email-david.henningsson@canonical.com> <s5hmwmh8jd2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5hmwmh8jd2.wl%tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, 1227093@bugs.launchpad.net, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 10/10/2013 01:18 PM, Takashi Iwai wrote:
> At Thu, 10 Oct 2013 12:19:24 +0200,
> David Henningsson wrote:
>>
>> The external mic showed up with a precense detect of "always present",
>> essentially disabling the internal mic. Therefore turn off presence
>> detection for this pin.
>>
>> Note: The external mic seems not yet working, but an internal mic is
>> certainly better than no mic at all.
>>
>> Cc: stable@vger.kernel.org
>> BugLink: https://bugs.launchpad.net/bugs/1227093
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>> ---
>>  sound/pci/hda/patch_realtek.c |   11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> Note: when doing stable backports, the two lines ".chained = true" and
>> ".chain_id = ALC269_FIXUP_HEADSET_MIC" can be dropped.
> 
> Then better to split the patch to two, one just for disabling the dead
> ext mic pin, and another for adding the headset mic chain.  The former
> can go to stable while the latter goes to next together with the
> previous ALC269_FIXUP_HEADSET_MIC patch.

The problem here is somewhat lack of testers. We have only one person
with a headset (with alias Yuv) and that person reports that it does not
work. However, the problem might be with that person's headset so I
probably don't want to completely disable it, just remove its jack
detection. Especially as this would go to stable too.

But ok, I can make three patches, one for headset mic model, one for
sony, and a third that adds the connection between them.

> If adding a new fixup entry for stable, put to somewhere in the middle
> so that git cherry-pick would work.  Appending to the tail is
> problematic because of a few previous fixups aren't merged to stable,
> thus the new entry cannot be applied cleanly.

Hmm, but maybe middle will have same problem if we end up changing the
policy. Maybe random position will be better? Or put all stable first
and all non-stable last?

> 
> 
> thanks,
> 
> Takashi
> 
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index 8cb3350..ec47681 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -3556,6 +3556,7 @@ enum {
>>  	ALC282_FIXUP_ASUS_TX300,
>>  	ALC283_FIXUP_INT_MIC,
>>  	ALC290_FIXUP_MONO_SPEAKERS,
>> +	ALC286_FIXUP_SONY_MIC_NO_PRESENCE,
>>  };
>>  
>>  static const struct hda_fixup alc269_fixups[] = {
>> @@ -3844,6 +3845,15 @@ static const struct hda_fixup alc269_fixups[] = {
>>  		.chained = true,
>>  		.chain_id = ALC269_FIXUP_DELL3_MIC_NO_PRESENCE,
>>  	},
>> +	[ALC286_FIXUP_SONY_MIC_NO_PRESENCE] = {
>> +		.type = HDA_FIXUP_PINS,
>> +		.v.pins = (const struct hda_pintbl[]) {
>> +			{ 0x18, 0x01a1913c }, /* use as headset mic, without its own jack detect */
>> +			{ }
>> +		},
>> +		.chained = true,
>> +		.chain_id = ALC269_FIXUP_HEADSET_MIC,
>> +	},
>>  };
>>  
>>  static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>> @@ -3908,6 +3918,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>>  	SND_PCI_QUIRK(0x1043, 0x8398, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
>>  	SND_PCI_QUIRK(0x1043, 0x83ce, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
>>  	SND_PCI_QUIRK(0x1043, 0x8516, "ASUS X101CH", ALC269_FIXUP_ASUS_X101),
>> +	SND_PCI_QUIRK(0x104d, 0x90b6, "Sony VAIO Pro 13", ALC286_FIXUP_SONY_MIC_NO_PRESENCE),
>>  	SND_PCI_QUIRK(0x104d, 0x9073, "Sony VAIO", ALC275_FIXUP_SONY_VAIO_GPIO2),
>>  	SND_PCI_QUIRK(0x104d, 0x907b, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
>>  	SND_PCI_QUIRK(0x104d, 0x9084, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
>> -- 
>> 1.7.9.5
>>
> 



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
