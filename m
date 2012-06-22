From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] Inverted internal mic
Date: Fri, 22 Jun 2012 12:46:55 +0200
Message-ID: <4FE44D1F.1060903@canonical.com>
References: <4F4C9714.1080307@canonical.com> <s5haa43ux7u.wl%tiwai@suse.de>
	<4F4CA438.90103@canonical.com> <s5hvcmrp7ji.wl%tiwai@suse.de>
	<4F4CD1AF.2050409@canonical.com> <s5hboojozx7.wl%tiwai@suse.de>
	<4F4CE264.7040008@canonical.com>
	<loom.20120619T050139-760@post.gmane.org>
	<4FE02D8B.7050201@canonical.com> <s5htxy6f6tt.wl%tiwai@suse.de>
	<4FE275AF.4080004@canonical.com> <s5hhau4esiu.wl%tiwai@suse.de>
	<4FE31BEC.20708@canonical.com> <s5hbokcerax.wl%tiwai@suse.de>
	<4FE32E74.1040902@canonical.com> <s5h62aj4rov.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 6682A1044A5
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2012 12:46:51 +0200 (CEST)
In-Reply-To: <s5h62aj4rov.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

On 06/22/2012 11:33 AM, Takashi Iwai wrote:
> At Thu, 21 Jun 2012 16:23:48 +0200,
> David Henningsson wrote:
>>
>> On 06/21/2012 03:19 PM, Takashi Iwai wrote:
>>> At Thu, 21 Jun 2012 15:04:44 +0200,
>>> David Henningsson wrote:
>>>>
>>>> On 06/21/2012 02:52 PM, Takashi Iwai wrote:
>>>>> At Thu, 21 Jun 2012 03:15:27 +0200,
>>>>> David Henningsson wrote:
>>>>>>
>>>>>> On 06/20/2012 03:31 PM, Takashi Iwai wrote:
>>>>>>> At Tue, 19 Jun 2012 09:43:07 +0200,
>>>>>>> David Henningsson wrote:
>>>>>>>>
>>>>>>>> On 06/19/2012 05:07 AM, Eliot Blennerhassett wrote:
>>>>>>>>> David Henningsson<david.henningsson<at>      canonical.com>      writes:
>>>>>>>>>> On 02/28/2012 02:22 PM, Takashi Iwai wrote:
>>>>>>>>>>> At Tue, 28 Feb 2012 14:07:59 +0100,
>>>>>>>>>>> David Henningsson wrote:
>>>>>>>>>>> Is there a way we can
>>>>>>>>>>>> know the corresponding processing coefficients to set for ALC268 and
>>>>>>>>>>>> ALC272X as well?
>>>>>>>>>>>
>>>>>>>>>>> AFAIK, no, it was specific to the codec model.
>>>>>>>>>>
>>>>>>>>>> Ok, then we can only hope for Kailang to supply this information if
>>>>>>>>>> possible. And if not possible we could attempt the workaround (when/if
>>>>>>>>>> we agree on it...) for these devices as well?
>>>>>>>>>
>>>>>>>>> Greetings,
>>>>>>>>>
>>>>>>>>> Any chance that there has been any progress on this?
>>>>>>>>> I have a machine with dmic and ALC272X (details below) that exhibits this
>>>>>>>>> problem, and can test any proposed patch.
>>>>>>>>
>>>>>>>> We have a patch in for the Thinkpad U300s, but that one had a Conexant
>>>>>>>> codec.
>>>>>>>> I haven't had time to start working on kernel patches for the Realtek
>>>>>>>> ones yet, but meanwhile, I'm tracking known machines here:
>>>>>>>>
>>>>>>>> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1002978
>>>>>>>
>>>>>>> Looking at the codec, it's not so trivial to port the inverted switch
>>>>>>> to Realtek.  In the input path of Realtek codecs, there is no
>>>>>>> individual capture volume/switch but only a central ADC volume and a
>>>>>>> MUX (or a mixer).
>>>>>>
>>>>>> Yeah, that's part of why I haven't done it myself yet ;-)
>>>>>>
>>>>>>     >    I can think of a new boolean switch or an enum to choose whether to
>>>>>>     >    shut off the right channel of the input-mux and the loopback volume.
>>>>>>     >    But it's feasible only if it make sense to PA.
>>>>>>
>>>>>> It seems possible that for ALC269 [1], you could switch path entirely
>>>>>> (including ADC). I e, the internal mic would go 0x12 ->    0x23 ->    0x08 and
>>>>>> the external mic would go 0x18 ->    0x24 ->    0x07. That way you could then
>>>>>> label the volume control on 0x08 "Internal Mic Capture Volume" and
>>>>>> "Inverted Internal Mic Capture Volume".
>>>>>>
>>>>>> Do you think this is a good strategy, or would it lead to other problems
>>>>>> (i e, what happens when you plug your mic in while actively recording)?
>>>>>
>>>>> If the i-mic is the only user for ADC 0x08, this would work.
>>>>> But when ADC 0x09 has multiple sources like e-mic and line-in,
>>>>> ADC 0x09 would be named as "Capture" (because it's not only "Mic"),
>>>>> and this becomes exclusive with "Internal Mic Capture".  It's a bit
>>>>> confusing, IMO.
>>>>
>>>> Yes, this logic can only be used when there are two inputs - mic and
>>>> internal mic. That is, the same conditions we today have for determining
>>>> when to have auto-switching on plug/unplug.
>>>>
>>>> Then 0x08 would have "Internal Mic Capture Volume|Switch" and 0x09 would
>>>> be "Mic Capture Volume|Switch". "Capture Volume|Switch" cannot be used
>>>> (unless we try to implement some kind of vmaster on the input side, but
>>>> I don't think that would be necessary).
>>>>
>>>> The alsa-info's I've looked at so far all have had one internal mic and
>>>> one external mic on the input side. At least the Realtek ones.
>>>
>>> Well, it's a bit risky to bet that.  I won't be surprised by any
>>> largish machines with one more jack for supporting 5.1 output and a
>>> digital built-in mic, for example.
>>
>> It is always difficult to bet on the future, but sure, that's a
>> drawback. So what were you suggesting instead, in a little more detail?
>
> Well, I thought of a mixer switch or enum to specify the inverted mic
> right-channel on/off.  If right channel is off, the ADC right channel
> mute is set autotmatically when the d-mic is selected as the input
> source.

Ok. I think this approach is okay.

>
> A test patch is below.  It seems working with hda-emu.

Thanks for the patch. I haven't tested it, but just read it through, see 
comments below.

>
> (Actually in the case of ALC662 / ALC272x, it could be done in the
>   mixer widget; but it's more generic to fiddle with ADC mute.)
>
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 41475ae..dcc77d0 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -170,6 +170,7 @@ struct alc_spec {
>   	hda_nid_t imux_pins[HDA_MAX_NUM_INPUTS];
>   	unsigned int dyn_adc_idx[HDA_MAX_NUM_INPUTS];
>   	int int_mic_idx, ext_mic_idx, dock_mic_idx; /* for auto-mic */
> +	hda_nid_t inv_dmic_pin;
>
>   	/* hooks */
>   	void (*init_hook)(struct hda_codec *codec);
> @@ -201,6 +202,8 @@ struct alc_spec {
>   	unsigned int vol_in_capsrc:1; /* use capsrc volume (ADC has no vol) */
>   	unsigned int parse_flags; /* passed to snd_hda_parse_pin_defcfg() */
>   	unsigned int shared_mic_hp:1; /* HP/Mic-in sharing */
> +	unsigned int inv_dmic_fixup:1;
> +	unsigned int inv_dmic_enabled:1;
>
>   	/* auto-mute control */
>   	int automute_mode;
> @@ -298,6 +301,7 @@ static inline hda_nid_t get_capsrc(struct alc_spec *spec, int idx)
>   }
>
>   static void call_update_outputs(struct hda_codec *codec);
> +static void alc_inv_dmic_sync(struct hda_codec *codec, bool force);
>
>   /* select the given imux item; either unmute exclusively or select the route */
>   static int alc_mux_select(struct hda_codec *codec, unsigned int adc_idx,
> @@ -368,6 +372,7 @@ static int alc_mux_select(struct hda_codec *codec, unsigned int adc_idx,
>   					  AC_VERB_SET_CONNECT_SEL,
>   					  imux->items[idx].index);
>   	}
> +	alc_inv_dmic_sync(codec, true);
>   	return 1;
>   }
>
> @@ -1556,14 +1561,14 @@ typedef int (*getput_call_t)(struct snd_kcontrol *kcontrol,
>
>   static int alc_cap_getput_caller(struct snd_kcontrol *kcontrol,
>   				 struct snd_ctl_elem_value *ucontrol,
> -				 getput_call_t func, bool check_adc_switch)
> +				 getput_call_t func, bool is_put)
>   {
>   	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
>   	struct alc_spec *spec = codec->spec;
>   	int i, err = 0;
>
>   	mutex_lock(&codec->control_mutex);
> -	if (check_adc_switch&&  spec->dyn_adc_switch) {
> +	if (is_put&&  spec->dyn_adc_switch) {
>   		for (i = 0; i<  spec->num_adc_nids; i++) {
>   			kcontrol->private_value =
>   				HDA_COMPOSE_AMP_VAL(spec->adc_nids[i],
> @@ -1584,6 +1589,8 @@ static int alc_cap_getput_caller(struct snd_kcontrol *kcontrol,
>   						    3, 0, HDA_INPUT);
>   		err = func(kcontrol, ucontrol);
>   	}
> +	if (err>= 0&&  is_put)
> +		alc_inv_dmic_sync(codec, false);
>    error:
>   	mutex_unlock(&codec->control_mutex);
>   	return err;
> @@ -1676,6 +1683,93 @@ DEFINE_CAPMIX_NOSRC(2);
>   DEFINE_CAPMIX_NOSRC(3);
>
>   /*
> + * Inverted digital-mic handling
> + */
> +static void alc_inv_dmic_sync(struct hda_codec *codec, bool force)
> +{
> +	struct alc_spec *spec = codec->spec;
> +	int i;
> +
> +	if (!spec->inv_dmic_fixup)
> +		return;
> +	if (spec->inv_dmic_enabled&&  !force)
> +		return;
> +	for (i = 0; i<  spec->num_adc_nids; i++) {
> +		int src = spec->dyn_adc_switch ? 0 : i;
> +		bool dmic_fixup = false;
> +		hda_nid_t nid;
> +		int parm, dir, v;
> +
> +		if (!spec->inv_dmic_enabled&&
> +		    spec->imux_pins[spec->cur_mux[src]] == spec->inv_dmic_pin)
> +			dmic_fixup = true;
> +		if (!dmic_fixup&&  !force)
> +			continue;
> +		if (spec->vol_in_capsrc) {
> +			nid = spec->capsrc_nids[i];
> +			parm = AC_AMP_SET_RIGHT | AC_AMP_SET_OUTPUT;
> +			dir = HDA_OUTPUT;
> +		} else {
> +			nid = spec->adc_nids[i];
> +			parm = AC_AMP_SET_RIGHT | AC_AMP_SET_INPUT;
> +			dir = HDA_INPUT;
> +		}
> +		v = snd_hda_codec_amp_read(codec, nid, 1, dir, 0);
> +		if (v&  0x80) /* if already muted, we don't need to touch */
> +			continue;
> +		if (dmic_fixup) /* mute for d-mic required */
> +			v |= 0x80;

This seems strange. Won't you need to manually unmute in some cases (if 
the "Inverted Capture" is manually turned on, or external mic is inserted)?

Maybe you mean like this:

new_value = dmic_fixup ? (v | 0x80) : (v & ~0x80);
if (new_value == v)
	continue;

But then, what if you turn "Inverted Capture" on while "Capture Switch" 
is off...?

> +		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE,
> +				    parm | v);
> +	}
> +}
> +
> +static int alc_inv_dmic_sw_get(struct snd_kcontrol *kcontrol,
> +			       struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct alc_spec *spec = codec->spec;
> +	
> +	ucontrol->value.integer.value[0] = spec->inv_dmic_enabled;
> +	return 0;
> +}
> +
> +static int alc_inv_dmic_sw_put(struct snd_kcontrol *kcontrol,
> +			       struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct alc_spec *spec = codec->spec;
> +	unsigned int val = !!ucontrol->value.integer.value[0];
> +
> +	if (val == spec->inv_dmic_enabled)
> +		return 0;
> +	spec->inv_dmic_enabled = val;
> +	alc_inv_dmic_sync(codec, true);
> +	return 0;
> +}
> +
> +static const struct snd_kcontrol_new alc_inv_dmic_sw = {
> +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> +	.info = snd_ctl_boolean_mono_info,
> +	.get = alc_inv_dmic_sw_get,
> +	.put = alc_inv_dmic_sw_put,
> +};
> +
> +static int alc_add_inv_dmic_mixer(struct hda_codec *codec, hda_nid_t nid)
> +{
> +	struct alc_spec *spec = codec->spec;
> +	struct snd_kcontrol_new *knew = alc_kcontrol_new(spec);
> +	if (!knew)
> +		return -ENOMEM;
> +	*knew = alc_inv_dmic_sw;
> +	knew->name = kstrdup("Inverted Mic Capture Switch", GFP_KERNEL);

It should be "Inverted Internal Mic Capture Switch" (missing word 
"Internal").

> +	spec->inv_dmic_fixup = 1;
> +	spec->inv_dmic_enabled = 1;
> +	spec->inv_dmic_pin = nid;
> +	return 0;
> +}
> +
> +/*
>    * virtual master controls
>    */
>
> @@ -2316,6 +2410,7 @@ static int alc_resume(struct hda_codec *codec)
>   	codec->patch_ops.init(codec);
>   	snd_hda_codec_resume_amp(codec);
>   	snd_hda_codec_resume_cache(codec);
> +	alc_inv_dmic_sync(codec, true);
>   	hda_call_check_power_status(codec, 0x01);
>   	return 0;
>   }
> @@ -6424,6 +6519,13 @@ static void alc272_fixup_mario(struct hda_codec *codec,
>   		       "hda_codec: failed to override amp caps for NID 0x2\n");
>   }
>
> +static void alc662_fixup_inv_dmic(struct hda_codec *codec,
> +				  const struct alc_fixup *fix, int action)
> +{
> +	if (action == ALC_FIXUP_ACT_PROBE)
> +		alc_add_inv_dmic_mixer(codec, 0x12);
> +}
> +
>   enum {
>   	ALC662_FIXUP_ASPIRE,
>   	ALC662_FIXUP_IDEAPAD,
> @@ -6441,6 +6543,7 @@ enum {
>   	ALC662_FIXUP_ASUS_MODE8,
>   	ALC662_FIXUP_NO_JACK_DETECT,
>   	ALC662_FIXUP_ZOTAC_Z68,
> +	ALC662_FIXUP_INV_DMIC,
>   };
>
>   static const struct alc_fixup alc662_fixups[] = {
> @@ -6597,12 +6700,17 @@ static const struct alc_fixup alc662_fixups[] = {
>   			{ }
>   		}
>   	},
> +	[ALC662_FIXUP_INV_DMIC] = {
> +		.type = ALC_FIXUP_FUNC,
> +		.v.func = alc662_fixup_inv_dmic,
> +	},
>   };
>
>   static const struct snd_pci_quirk alc662_fixup_tbl[] = {
>   	SND_PCI_QUIRK(0x1019, 0x9087, "ECS", ALC662_FIXUP_ASUS_MODE2),
>   	SND_PCI_QUIRK(0x1025, 0x0308, "Acer Aspire 8942G", ALC662_FIXUP_ASPIRE),
>   	SND_PCI_QUIRK(0x1025, 0x031c, "Gateway NV79", ALC662_FIXUP_SKU_IGNORE),
> +	SND_PCI_QUIRK(0x1025, 0x0349, "eMachines eM250", ALC662_FIXUP_INV_DMIC),
>   	SND_PCI_QUIRK(0x1025, 0x038b, "Acer Aspire 8943G", ALC662_FIXUP_ASPIRE),
>   	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
>   	SND_PCI_QUIRK(0x1043, 0x8469, "ASUS mobo", ALC662_FIXUP_NO_JACK_DETECT),
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
