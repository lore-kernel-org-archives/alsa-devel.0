From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Regression for Lenovo X240 sound in 3.18
Date: Mon, 09 Feb 2015 13:15:07 +0100
Message-ID: <54D8A4CB.3000701@canonical.com>
References: <alpine.LSU.2.11.1412291303200.30351@nerf08.vanv.qr>
 <s5h387xi2yp.wl-tiwai@suse.de>
 <alpine.LSU.2.11.1412301629280.1813@nerf08.vanv.qr>
 <s5h1tnhi1jx.wl-tiwai@suse.de> <s5hr3vhgldi.wl-tiwai@suse.de>
 <alpine.LSU.2.11.1412301907120.5263@nerf08.vanv.qr>
 <s5hmw64gq1f.wl-tiwai@suse.de>
 <alpine.LSU.2.11.1501101213460.22151@nerf60.vanv.qr>
 <s5h4mqvv0m5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id CBAEB2605C3
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 13:15:08 +0100 (CET)
In-Reply-To: <s5h4mqvv0m5.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jan Engelhardt <jengelh@inai.de>
Cc: "taihsiang.ho@canonical.com >> Taihsiang Ho" <taihsiang.ho@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, mr.bobukas@gmail.com
List-Id: alsa-devel@alsa-project.org

X240? Sounds interesting. Taihshiang is currently investigating why the 
external/headset mic does not work on the X240. Is this something you 
experience as well?

// David

On 2015-02-09 11:29, Takashi Iwai wrote:
> At Sat, 10 Jan 2015 13:10:30 +0100 (CET),
> Jan Engelhardt wrote:
>>
>>
>> On Wednesday 2014-12-31 09:51, Takashi Iwai wrote:
>>>>>
>>>>> Ah, I see you disable the automute.  So the headphone plug shouldn't
>>>>> matter.
>>>>
>>>> Changing the "Auto-Mute" control does not do anything; the system always
>>>> exhibits Automute behavior (if that's a bug, it's one which I did not
>>>> care about so far).
>>>
>>> Oh, that's really interesting.  I didn't expect such a
>>> hardware-controlled automute nowadays.  We need to investigate this
>>> more.
>>> [...]
>>> [Volumes] On 3.19, this was renamed differently, so that "PCM" can
>>> appear again by a softvol item like before.
>>
>> On 3.19-rc3+ [eb74926920cfa756087a82e0b081df837177cb95] I confirm
>> all the volume bars/switches that went missing for me are back again.
>>
>> In particular, 3.19 shows a new "Speaker+LO" no-switch volume bar
>> control, and a "Speaker" no-volume switch control. Works for me,
>> though I wonder if the change was necessary. (In 3.17, the switch and
>> volume were combined in one control.)
>>
>> As said, all is fine here.
>
> Sorry, I've forgotten this pending issue.
> Could you confirm that the patch below works for you?  Then I'll queue
> up for 3.20-rc1 and backport appropriately.
>
>
> thanks,
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Fix lost sound on Thinkpad X240
>
> The commit [7c21539c45ea: ALSA: hda - Add ultra dock support for
> Thinkpad X240] caused a regression, the sound got lost.  The machine
> seems requiring the fixed binding between DACs and pins, and the
> commit above resulted in the change of binding.  As a fix, this patch
> adds the binding list to ensure to connect to the correct DAC.
>
> Reported-by: Jan Engelhardt <jengelh@inai.de>
> Fixes: 7c21539c45ea ('ALSA: hda - Add ultra dock support for Thinkpad X240.')
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/pci/hda/patch_realtek.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 040306194e6d..dba31bafcd1c 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -4226,6 +4226,22 @@ static void alc269_fixup_limit_int_mic_boost(struct hda_codec *codec,
>   	}
>   }
>
> +/* TP X240 seems to need fixed DAC binding; otherwise sound gets lost */
> +static void alc_fixup_tpx240_dacs(struct hda_codec *codec,
> +				  const struct hda_fixup *fix, int action)
> +{
> +	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
> +		static hda_nid_t preferred_pairs[] = {
> +			0x14, 0x03,
> +			0x15, 0x02,
> +			0x16, 0x02,
> +			0
> +		};
> +		struct alc_spec *spec = codec->spec;
> +		spec->gen.preferred_dacs = preferred_pairs;
> +	}
> +}
> +
>   static void alc283_hp_automute_hook(struct hda_codec *codec,
>   				    struct hda_jack_callback *jack)
>   {
> @@ -4411,6 +4427,7 @@ enum {
>   	ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC,
>   	ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
>   	ALC292_FIXUP_TPT440_DOCK,
> +	ALC292_FIXUP_TPX240_DOCK,
>   	ALC283_FIXUP_BXBT2807_MIC,
>   	ALC255_FIXUP_DELL_WMI_MIC_MUTE_LED,
>   	ALC282_FIXUP_ASPIRE_V5_PINS,
> @@ -4856,6 +4873,12 @@ static const struct hda_fixup alc269_fixups[] = {
>   		.chained = true,
>   		.chain_id = ALC269_FIXUP_LIMIT_INT_MIC_BOOST
>   	},
> +	[ALC292_FIXUP_TPX240_DOCK] = {
> +		.type = HDA_FIXUP_FUNC,
> +		.v.func = alc_fixup_tpx240_dacs,
> +		.chained = true,
> +		.chain_id = ALC292_FIXUP_TPT440_DOCK,
> +	},
>   	[ALC283_FIXUP_BXBT2807_MIC] = {
>   		.type = HDA_FIXUP_PINS,
>   		.v.pins = (const struct hda_pintbl[]) {
> @@ -5026,7 +5049,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>   	SND_PCI_QUIRK(0x17aa, 0x220e, "Thinkpad T440p", ALC292_FIXUP_TPT440_DOCK),
>   	SND_PCI_QUIRK(0x17aa, 0x2210, "Thinkpad T540p", ALC292_FIXUP_TPT440_DOCK),
>   	SND_PCI_QUIRK(0x17aa, 0x2212, "Thinkpad T440", ALC292_FIXUP_TPT440_DOCK),
> -	SND_PCI_QUIRK(0x17aa, 0x2214, "Thinkpad X240", ALC292_FIXUP_TPT440_DOCK),
> +	SND_PCI_QUIRK(0x17aa, 0x2214, "Thinkpad X240", ALC292_FIXUP_TPX240_DOCK),
>   	SND_PCI_QUIRK(0x17aa, 0x2215, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
>   	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
>   	SND_PCI_QUIRK(0x17aa, 0x3978, "IdeaPad Y410P", ALC269_FIXUP_NO_SHUTUP),
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
