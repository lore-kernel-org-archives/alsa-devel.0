From: Julian Wollrath <jwollrath@web.de>
Subject: Re: Grey noise with HDA Intel PCH
Date: Thu, 14 Aug 2014 18:29:19 +0200
Message-ID: <20140814182919.03b49822@saldaea>
References: <20140814114003.7b0019f3@saldaea> <53EC8D5B.5020709@ladisch.de>
 <20140814124616.65991d7e@saldaea> <s5hoavnnu38.wl-tiwai@suse.de>
 <20140814160737.0e8fc283@saldaea> <s5h7g2bnowg.wl-tiwai@suse.de>
 <20140814163914.08e9a851@saldaea> <s5h38cznn59.wl-tiwai@suse.de>
 <20140814170459.31428e0b@saldaea> <s5hwqabm7h7.wl-tiwai@suse.de>
 <20140814172658.75bd122f@saldaea> <s5hppg3xeag.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 64A44261600
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 18:29:22 +0200 (CEST)
In-Reply-To: <s5hppg3xeag.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

> > > > > Thanks.  The setup looks OK, the path is:
> > > > >   DAC (0x02) -> mixer (0x0c) -> mixer (0x14)
> > > > > and the mixer mutes the loopback path (index 1).
> > > > > 
> > > > > Is it the state where you still hear the static noise?
> > > > Yes, the alsa-info.sh script was executed, while hearing the
> > > > static noise.
> > > 
> > > OK.  And if you mute "Speaker" or "Headphone", the noise is gone,
> > > too, right?
> > No, if I mute "Speaker" (the internal laptop speaker) it is not
> > gone. It is only gone, if I mute "Master" or have a headphone
> > plugged in and mute "Headphone" or "Master".
> 
> Interesting.  The "Speaker" mute changes "Speaker Playback Switch",
> and as you can see in alsa-info.sh output, this toggles the mute of
> the speaker pin NID 0x14, i.e. the endpoint.  If "Master" influences,
> it means to mute *both* Headphone and Speaker mutes would work.
> Could you check this?
Muting both Headphone and Speaker does not work for the static noise on
the speaker.

> > More fascinating, it is not present, if the speaker is not muted
> > and I disable powersaving via "echo '0' >
> > '/sys/module/snd_hda_intel/parameters/power_save'" but even then,
> > it is still present on the headphone.
> 
> Hm.  Is the noise audible when you playback a PCM stream, too?
> For example, you can play a silent stream.
Yes, then it is audible.

> > > > > Also, what if you use the module option for snd-hda-intel
> > > > > model=nofixup or model=generic?
> > > > That did not change anything either. Passing the "mixer_nid = 0"
> > > > hint also did not get rid of the static noise, when loading
> > > > snd-hda-intel with model=nofixup resp. model=generic.
> > > 
> > > Did you reboot with setting the option in /etc/modprobe.d/*?
> > > Reloading the module might not work for such a problem.
> > No, I just unloaded every sound-related module and than loaded the
> > module via "modprobe snd-hda-intel model=..." again.
> 
> Then always test with reboot.  The problem is about the
> vendor-specific setups, and it's often sticky unless the cold boot.
> At best, do the cold boot.  The warm boot doesn't cure always.
Ok, I tested with a reboot but that did not help.

> > > In either way, there should be some difference in alsa-info.sh
> > > output, e.g. more (or less) mixer items with the model option.
> > The difference is their, all the "Dock ..." entries were missing,
> > when loading with the model="..." option.
> 
> Yes, and you should also see the difference in the kernel messages.
> 
> Another thing to check is to swap the DAC assignment.  There was a
> similar problem on some Sony laptops, and we had to swap the DAC
> assignment since the hardware seems to have some implicit assumption
> of the DAC.  A test patch is below.
Thanks, but sadly the patch did not help.

Cheers,
Julian
> 
> 
> Takashi
> 
> ---
> diff --git a/sound/pci/hda/patch_realtek.c
> b/sound/pci/hda/patch_realtek.c index 6b38ec3c6e57..10c47a0e6c70
> 100644 --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -3280,6 +3280,22 @@ static void
> alc269_fixup_pincfg_no_hp_to_lineout(struct hda_codec *codec,
> spec->parse_flags = HDA_PINCFG_NO_HP_FIXUP; }
>  
> +static void alc269_fixup_thinkpad_dac_bind(struct hda_codec *codec,
> +					   const struct hda_fixup
> *fix,
> +					   int action)
> +{
> +	struct alc_spec *spec = codec->spec;
> +	static hda_nid_t preferred_pairs[] = {
> +		0x15, 0x02,
> +		0x1b, 0x02,
> +		0x14, 0x03,
> +		0,
> +	};
> +
> +	if (action == HDA_FIXUP_ACT_PRE_PROBE)
> +		spec->gen.preferred_dacs = preferred_pairs;
> +}
> +
>  static void alc269_fixup_hweq(struct hda_codec *codec,
>  			       const struct hda_fixup *fix, int
> action) {
> @@ -4358,6 +4374,7 @@ enum {
>  	ALC269_FIXUP_HP_LINE1_MIC1_LED,
>  	ALC269_FIXUP_INV_DMIC,
>  	ALC269_FIXUP_LENOVO_DOCK,
> +	ALC269_FIXUP_THINKPAD_DAC_BIND,
>  	ALC269_FIXUP_NO_SHUTUP,
>  	ALC286_FIXUP_SONY_MIC_NO_PRESENCE,
>  	ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT,
> @@ -4576,6 +4593,12 @@ static const struct hda_fixup alc269_fixups[]
> = { .chained = true,
>  		.chain_id = ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT
>  	},
> +	[ALC269_FIXUP_THINKPAD_DAC_BIND] = {
> +		.type = HDA_FIXUP_FUNC,
> +		.v.func = alc269_fixup_thinkpad_dac_bind,
> +		.chained = true,
> +		.chain_id = ALC269_FIXUP_LENOVO_DOCK,
> +	},
>  	[ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT] = {
>  		.type = HDA_FIXUP_FUNC,
>  		.v.func = alc269_fixup_pincfg_no_hp_to_lineout,
> @@ -5044,7 +5067,7 @@ static const struct snd_pci_quirk
> alc269_fixup_tbl[] = { SND_PCI_QUIRK(0x17aa, 0x21ca, "Thinkpad L412",
> ALC269_FIXUP_SKU_IGNORE), SND_PCI_QUIRK(0x17aa, 0x21e9, "Thinkpad
> Edge 15", ALC269_FIXUP_SKU_IGNORE), SND_PCI_QUIRK(0x17aa, 0x21f6,
> "Thinkpad T530", ALC269_FIXUP_LENOVO_DOCK),
> -	SND_PCI_QUIRK(0x17aa, 0x21fa, "Thinkpad X230",
> ALC269_FIXUP_LENOVO_DOCK),
> +	SND_PCI_QUIRK(0x17aa, 0x21fa, "Thinkpad X230",
> ALC269_FIXUP_THINKPAD_DAC_BIND), SND_PCI_QUIRK(0x17aa, 0x21f3,
> "Thinkpad T430", ALC269_FIXUP_LENOVO_DOCK), SND_PCI_QUIRK(0x17aa,
> 0x21fb, "Thinkpad T430s", ALC269_FIXUP_LENOVO_DOCK),
> SND_PCI_QUIRK(0x17aa, 0x2203, "Thinkpad X230 Tablet",
> ALC269_FIXUP_LENOVO_DOCK),
> _______________________________________________ Alsa-devel mailing
> list Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
