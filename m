From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/5] ALSA: hda - More generic auto-mic
 switching for Realtek codecs
Date: Fri, 30 Nov 2012 01:11:51 +0100
Message-ID: <50B7F9C7.9040801@canonical.com>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
 <1354202489-12769-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 70BD326536D
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2012 01:11:54 +0100 (CET)
In-Reply-To: <1354202489-12769-3-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/29/2012 04:21 PM, Takashi Iwai wrote:
> Instead of limiting the automatic input-source selection only to the
> mics (internal, external and dock mics), allow it for generic inputs,
> e.g. switching between the rear line-in and the front mic.
>
> It's been a frequent demand from desktop machines, and we already do
> it for the headphone auto-mute, so no reason to avoid it now.
>
> The logic is to check the attribute and location of input pins, and
> enable the automatic selection feature only if all such pins are in
> different locations (e.g. internal, front, rear, etc) and line-in or
> mic pins.  That is, if multiple input pins are assigned to a single
> location, the feature isn't enabled because we don't know the
> priority.

Hmm, I'm a bit worried about this, partially because it makes things 
inconsistent between codecs (and kernel versions, too).

In current PulseAudio, we disable the internal mic if any other mic is 
being detected as plugged in.
But if there are other switches, say "front mic" and "rear mic", we 
don't do such disabling. Now you're disabling one of them automatically 
in the kernel, but for one codec only.

So my point is, when both "Front mic" and "Rear mic" are plugged in, we 
don't know whether to present to the user to choose between "Front Mic" 
and "Rear Mic", or to disable one of them.

One could possibly argue that the absence of a "Input Source" and 
"Capture Source" would indicate some form of auto-switch, but I wonder 
if this would really be a safe indicator...


>
> (You may wonder why this restriction doesn't exist for the headphone
>   automute.  The reason is that the output case is different from the
>   input: the input source is an exclusive selection while the output
>   can be multiplexed.)
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/pci/hda/patch_realtek.c | 137 +++++++++++++++++++++++-------------------
>   1 file changed, 74 insertions(+), 63 deletions(-)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index c7369a6..c5cc47b 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -28,6 +28,7 @@
>   #include <linux/slab.h>
>   #include <linux/pci.h>
>   #include <linux/module.h>
> +#include <linux/sort.h>
>   #include <sound/core.h>
>   #include <sound/jack.h>
>   #include "hda_codec.h"
> @@ -98,6 +99,13 @@ enum {
>   #define ALC_FIXUP_ACT_INIT	HDA_FIXUP_ACT_INIT
>   #define ALC_FIXUP_ACT_BUILD	HDA_FIXUP_ACT_BUILD
>
> +#define MAX_AUTO_MIC_PINS	3
> +
> +struct alc_automic_entry {
> +	hda_nid_t pin;		/* pin */
> +	int idx;		/* imux index, -1 = invalid */
> +	unsigned int attr;	/* pin attribute (INPUT_PIN_ATTR_*) */
> +};
>
>   struct alc_spec {
>   	struct hda_gen_spec gen;
> @@ -145,9 +153,6 @@ struct alc_spec {
>   	unsigned int num_mux_defs;
>   	const struct hda_input_mux *input_mux;
>   	unsigned int cur_mux[3];
> -	hda_nid_t ext_mic_pin;
> -	hda_nid_t dock_mic_pin;
> -	hda_nid_t int_mic_pin;
>
>   	/* channel model */
>   	const struct hda_channel_mode *channel_mode;
> @@ -169,9 +174,12 @@ struct alc_spec {
>   	hda_nid_t private_capsrc_nids[AUTO_CFG_MAX_OUTS];
>   	hda_nid_t imux_pins[HDA_MAX_NUM_INPUTS];
>   	unsigned int dyn_adc_idx[HDA_MAX_NUM_INPUTS];
> -	int int_mic_idx, ext_mic_idx, dock_mic_idx; /* for auto-mic */
>   	hda_nid_t inv_dmic_pin;
>
> +	/* auto-mic stuff */
> +	int am_num_entries;
> +	struct alc_automic_entry am_entry[MAX_AUTO_MIC_PINS];
> +
>   	/* hooks */
>   	void (*init_hook)(struct hda_codec *codec);
>   #ifdef CONFIG_PM
> @@ -632,22 +640,20 @@ static void alc_line_automute(struct hda_codec *codec, struct hda_jack_tbl *jack
>   static void alc_mic_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
>   {
>   	struct alc_spec *spec = codec->spec;
> -	hda_nid_t *pins = spec->imux_pins;
> +	int i;
>
>   	if (!spec->auto_mic || !spec->auto_mic_valid_imux)
>   		return;
>   	if (snd_BUG_ON(!spec->adc_nids))
>   		return;
> -	if (snd_BUG_ON(spec->int_mic_idx < 0 || spec->ext_mic_idx < 0))
> -		return;
>
> -	if (snd_hda_jack_detect(codec, pins[spec->ext_mic_idx]))
> -		alc_mux_select(codec, 0, spec->ext_mic_idx, false);
> -	else if (spec->dock_mic_idx >= 0 &&
> -		   snd_hda_jack_detect(codec, pins[spec->dock_mic_idx]))
> -		alc_mux_select(codec, 0, spec->dock_mic_idx, false);
> -	else
> -		alc_mux_select(codec, 0, spec->int_mic_idx, false);
> +	for (i = spec->am_num_entries - 1; i > 0; i--) {
> +		if (snd_hda_jack_detect(codec, spec->am_entry[i].pin)) {
> +			alc_mux_select(codec, 0, spec->am_entry[i].idx, false);
> +			return;
> +		}
> +	}
> +	alc_mux_select(codec, 0, spec->am_entry[0].idx, false);
>   }
>
>   /* update the master volume per volume-knob's unsol event */
> @@ -1053,6 +1059,7 @@ static bool alc_auto_mic_check_imux(struct hda_codec *codec)
>   {
>   	struct alc_spec *spec = codec->spec;
>   	const struct hda_input_mux *imux;
> +	int i;
>
>   	if (!spec->auto_mic)
>   		return false;
> @@ -1066,21 +1073,20 @@ static bool alc_auto_mic_check_imux(struct hda_codec *codec)
>   	}
>
>   	imux = spec->input_mux;
> -	spec->ext_mic_idx = find_idx_in_nid_list(spec->ext_mic_pin,
> -					spec->imux_pins, imux->num_items);
> -	spec->int_mic_idx = find_idx_in_nid_list(spec->int_mic_pin,
> -					spec->imux_pins, imux->num_items);
> -	spec->dock_mic_idx = find_idx_in_nid_list(spec->dock_mic_pin,
> -					spec->imux_pins, imux->num_items);
> -	if (spec->ext_mic_idx < 0 || spec->int_mic_idx < 0) {
> -		spec->auto_mic = 0;
> -		return false; /* no corresponding imux */
> +	for (i = 0; i < spec->am_num_entries; i++) {
> +		spec->am_entry[i].idx =
> +			find_idx_in_nid_list(spec->am_entry[i].pin,
> +					     spec->imux_pins, imux->num_items);
> +		if (spec->am_entry[i].idx < 0) {
> +			spec->auto_mic = 0;
> +			return false; /* no corresponding imux */
> +		}
>   	}
>
> -	snd_hda_jack_detect_enable_callback(codec, spec->ext_mic_pin,
> -					    ALC_MIC_EVENT, alc_mic_automute);
> -	if (spec->dock_mic_pin)
> -		snd_hda_jack_detect_enable_callback(codec, spec->dock_mic_pin,
> +	/* we don't need the jack detection for the first pin */
> +	for (i = 1; i < spec->am_num_entries; i++)
> +		snd_hda_jack_detect_enable_callback(codec,
> +						    spec->am_entry[i].pin,
>   						    ALC_MIC_EVENT,
>   						    alc_mic_automute);
>
> @@ -1089,6 +1095,13 @@ static bool alc_auto_mic_check_imux(struct hda_codec *codec)
>   	return true;
>   }
>
> +static int compare_attr(const void *ap, const void *bp)
> +{
> +	const struct alc_automic_entry *a = ap;
> +	const struct alc_automic_entry *b = bp;
> +	return (int)(a->attr - b->attr);
> +}
> +
>   /*
>    * Check the availability of auto-mic switch;
>    * Set up if really supported
> @@ -1097,67 +1110,63 @@ static void alc_init_auto_mic(struct hda_codec *codec)
>   {
>   	struct alc_spec *spec = codec->spec;
>   	struct auto_pin_cfg *cfg = &spec->autocfg;
> -	hda_nid_t fixed, ext, dock;
> -	int i;
> +	unsigned int types;
> +	int i, num_pins;
>
>   	if (spec->shared_mic_hp)
>   		return; /* no auto-mic for the shared I/O */
>
> -	spec->ext_mic_idx = spec->int_mic_idx = spec->dock_mic_idx = -1;
> +	types = 0;
> +	num_pins = 0;
>
> -	fixed = ext = dock = 0;
>   	for (i = 0; i < cfg->num_inputs; i++) {
>   		hda_nid_t nid = cfg->inputs[i].pin;
> -		unsigned int defcfg;
> -		defcfg = snd_hda_codec_get_pincfg(codec, nid);
> -		switch (snd_hda_get_input_pin_attr(defcfg)) {
> +		unsigned int attr;
> +		attr = snd_hda_codec_get_pincfg(codec, nid);
> +		attr = snd_hda_get_input_pin_attr(attr);
> +		if (types & (1 << attr))
> +			return; /* already occupied */
> +		switch (attr) {
>   		case INPUT_PIN_ATTR_INT:
> -			if (fixed)
> -				return; /* already occupied */
>   			if (cfg->inputs[i].type != AUTO_PIN_MIC)
>   				return; /* invalid type */
> -			fixed = nid;
>   			break;
>   		case INPUT_PIN_ATTR_UNUSED:
>   			return; /* invalid entry */
> -		case INPUT_PIN_ATTR_DOCK:
> -			if (dock)
> -				return; /* already occupied */
> -			if (cfg->inputs[i].type > AUTO_PIN_LINE_IN)
> -				return; /* invalid type */
> -			dock = nid;
> -			break;
>   		default:
> -			if (ext)
> -				return; /* already occupied */
> -			if (cfg->inputs[i].type != AUTO_PIN_MIC)
> +			if (cfg->inputs[i].type > AUTO_PIN_LINE_IN)
>   				return; /* invalid type */
> -			ext = nid;
> +			if (!is_jack_detectable(codec, nid))
> +				return; /* no unsol support */
>   			break;
>   		}
> +		if (num_pins >= MAX_AUTO_MIC_PINS)
> +			return;
> +		types |= (1 << attr);
> +		spec->am_entry[num_pins].pin = nid;
> +		spec->am_entry[num_pins].attr = attr;
> +		num_pins++;
>   	}
> -	if (!ext && dock) {
> -		ext = dock;
> -		dock = 0;
> -	}
> -	if (!ext || !fixed)
> +
> +	if (num_pins < 2)
>   		return;
> -	if (!is_jack_detectable(codec, ext))
> -		return; /* no unsol support */
> -	if (dock && !is_jack_detectable(codec, dock))
> -		return; /* no unsol support */
>
> -	/* check imux indices */
> -	spec->ext_mic_pin = ext;
> -	spec->int_mic_pin = fixed;
> -	spec->dock_mic_pin = dock;
> +	spec->am_num_entries = num_pins;
> +	/* sort the am_entry in the order of attr so that the pin with a
> +	 * higher attr will be selected when the jack is plugged.
> +	 */
> +	sort(spec->am_entry, num_pins, sizeof(spec->am_entry[0]),
> +	     compare_attr, NULL);
>
> +	/* check imux indices */
>   	spec->auto_mic = 1;
>   	if (!alc_auto_mic_check_imux(codec))
>   		return;
>
>   	snd_printdd("realtek: Enable auto-mic switch on NID 0x%x/0x%x/0x%x\n",
> -		    ext, fixed, dock);
> +		    spec->am_entry[0].pin,
> +		    spec->am_entry[1].pin,
> +		    spec->am_entry[2].pin);
>   }
>
>   /* check the availabilities of auto-mute and auto-mic switches */
> @@ -6019,8 +6028,10 @@ static void alc271_hp_gate_mic_jack(struct hda_codec *codec,
>   {
>   	struct alc_spec *spec = codec->spec;
>
> +	if (snd_BUG_ON(!spec->am_entry[1].pin || !spec->autocfg.hp_pins[0]))
> +		return;
>   	if (action == ALC_FIXUP_ACT_PROBE)
> -		snd_hda_jack_set_gating_jack(codec, spec->ext_mic_pin,
> +		snd_hda_jack_set_gating_jack(codec, spec->am_entry[1].pin,
>   					     spec->autocfg.hp_pins[0]);
>   }
>
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
