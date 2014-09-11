From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH RFC 4/7] ALSA: hda - Allow multiple
	callbacks for jack
Date: Thu, 11 Sep 2014 17:01:01 +0200
Message-ID: <5411B92D.4070307@canonical.com>
References: <1410445157-23198-1-git-send-email-tiwai@suse.de>
 <1410445157-23198-5-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id CEFDE265710
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 17:01:01 +0200 (CEST)
In-Reply-To: <1410445157-23198-5-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2014-09-11 16:19, Takashi Iwai wrote:
> So far, hda_jack infrastructure allows only one callback per jack, and
> this makes things slightly complicated when a driver wants to assign
> multiple tasks to a jack, e.g. the standard auto-mute with a power
> up/down sequence.  This can be simplified if the hda_jack accepts
> multiple callbacks.
>
> This patch is such an extension: the callback-specific part (the
> function and private_data) is split to another struct from
> hda_jack_tbl, and multiple such objects can be assigned to a single
> hda_jack_tbl entry.
>
> The new struct hda_jack_callback is passed to each callback function
> now, thus the patch became bigger than expected.  But these changes
> are mostly trivial.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/pci/hda/hda_generic.c    | 19 ++++++++++++-------
>   sound/pci/hda/hda_generic.h    | 12 ++++++------
>   sound/pci/hda/hda_jack.c       | 43 +++++++++++++++++++++++++++++-------------
>   sound/pci/hda/hda_jack.h       | 17 ++++++++++++-----
>   sound/pci/hda/patch_cirrus.c   |  2 +-
>   sound/pci/hda/patch_conexant.c |  3 ++-
>   sound/pci/hda/patch_hdmi.c     | 14 ++++++++++----
>   sound/pci/hda/patch_realtek.c  | 12 +++++++-----
>   sound/pci/hda/patch_sigmatel.c | 24 +++++++++++------------
>   sound/pci/hda/patch_via.c      | 11 +++++++----
>   10 files changed, 99 insertions(+), 58 deletions(-)
>
> diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
> index 4d605e4ac41c..32a85f9cac4b 100644
> --- a/sound/pci/hda/hda_generic.c
> +++ b/sound/pci/hda/hda_generic.c
> @@ -2032,7 +2032,8 @@ static int create_speaker_out_ctls(struct hda_codec *codec)
>    * independent HP controls
>    */
>
> -static void call_hp_automute(struct hda_codec *codec, struct hda_jack_tbl *jack);
> +static void call_hp_automute(struct hda_codec *codec,
> +			     struct hda_jack_callback *jack);
>   static int indep_hp_info(struct snd_kcontrol *kcontrol,
>   			 struct snd_ctl_elem_info *uinfo)
>   {
> @@ -3948,7 +3949,8 @@ static void call_update_outputs(struct hda_codec *codec)
>   }
>
>   /* standard HP-automute helper */
> -void snd_hda_gen_hp_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
> +void snd_hda_gen_hp_automute(struct hda_codec *codec,
> +			     struct hda_jack_callback *jack)
>   {
>   	struct hda_gen_spec *spec = codec->spec;
>   	hda_nid_t *pins = spec->autocfg.hp_pins;
> @@ -3968,7 +3970,8 @@ void snd_hda_gen_hp_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
>   EXPORT_SYMBOL_GPL(snd_hda_gen_hp_automute);
>
>   /* standard line-out-automute helper */
> -void snd_hda_gen_line_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
> +void snd_hda_gen_line_automute(struct hda_codec *codec,
> +			       struct hda_jack_callback *jack)
>   {
>   	struct hda_gen_spec *spec = codec->spec;
>
> @@ -3988,7 +3991,8 @@ void snd_hda_gen_line_automute(struct hda_codec *codec, struct hda_jack_tbl *jac
>   EXPORT_SYMBOL_GPL(snd_hda_gen_line_automute);
>
>   /* standard mic auto-switch helper */
> -void snd_hda_gen_mic_autoswitch(struct hda_codec *codec, struct hda_jack_tbl *jack)
> +void snd_hda_gen_mic_autoswitch(struct hda_codec *codec,
> +				struct hda_jack_callback *jack)
>   {
>   	struct hda_gen_spec *spec = codec->spec;
>   	int i;
> @@ -4011,7 +4015,8 @@ void snd_hda_gen_mic_autoswitch(struct hda_codec *codec, struct hda_jack_tbl *ja
>   EXPORT_SYMBOL_GPL(snd_hda_gen_mic_autoswitch);
>
>   /* call appropriate hooks */
> -static void call_hp_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
> +static void call_hp_automute(struct hda_codec *codec,
> +			     struct hda_jack_callback *jack)
>   {
>   	struct hda_gen_spec *spec = codec->spec;
>   	if (spec->hp_automute_hook)
> @@ -4021,7 +4026,7 @@ static void call_hp_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
>   }
>
>   static void call_line_automute(struct hda_codec *codec,
> -			       struct hda_jack_tbl *jack)
> +			       struct hda_jack_callback *jack)
>   {
>   	struct hda_gen_spec *spec = codec->spec;
>   	if (spec->line_automute_hook)
> @@ -4031,7 +4036,7 @@ static void call_line_automute(struct hda_codec *codec,
>   }
>
>   static void call_mic_autoswitch(struct hda_codec *codec,
> -				struct hda_jack_tbl *jack)
> +				struct hda_jack_callback *jack)
>   {
>   	struct hda_gen_spec *spec = codec->spec;
>   	if (spec->mic_autoswitch_hook)
> diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
> index 72f5624125fb..61dd5153f512 100644
> --- a/sound/pci/hda/hda_generic.h
> +++ b/sound/pci/hda/hda_generic.h
> @@ -284,11 +284,11 @@ struct hda_gen_spec {
>
>   	/* automute / autoswitch hooks */
>   	void (*hp_automute_hook)(struct hda_codec *codec,
> -				 struct hda_jack_tbl *tbl);
> +				 struct hda_jack_callback *cb);
>   	void (*line_automute_hook)(struct hda_codec *codec,
> -				   struct hda_jack_tbl *tbl);
> +				   struct hda_jack_callback *cb);
>   	void (*mic_autoswitch_hook)(struct hda_codec *codec,
> -				    struct hda_jack_tbl *tbl);
> +				    struct hda_jack_callback *cb);
>   };
>
>   int snd_hda_gen_spec_init(struct hda_gen_spec *spec);
> @@ -320,11 +320,11 @@ int snd_hda_gen_build_pcms(struct hda_codec *codec);
>
>   /* standard jack event callbacks */
>   void snd_hda_gen_hp_automute(struct hda_codec *codec,
> -			     struct hda_jack_tbl *jack);
> +			     struct hda_jack_callback *jack);
>   void snd_hda_gen_line_automute(struct hda_codec *codec,
> -			       struct hda_jack_tbl *jack);
> +			       struct hda_jack_callback *jack);
>   void snd_hda_gen_mic_autoswitch(struct hda_codec *codec,
> -				struct hda_jack_tbl *jack);
> +				struct hda_jack_callback *jack);
>   void snd_hda_gen_update_outputs(struct hda_codec *codec);
>
>   #ifdef CONFIG_PM
> diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
> index 27fccd2c8d41..13a9e6796379 100644
> --- a/sound/pci/hda/hda_jack.c
> +++ b/sound/pci/hda/hda_jack.c
> @@ -117,8 +117,13 @@ void snd_hda_jack_tbl_clear(struct hda_codec *codec)
>   		struct hda_jack_tbl *jack = codec->jacktbl.list;
>   		int i;
>   		for (i = 0; i < codec->jacktbl.used; i++, jack++) {
> +			struct hda_jack_callback *cb, *next;
>   			if (jack->jack)
>   				snd_device_free(codec->bus->card, jack->jack);
> +			for (cb = jack->callback; cb; cb = next) {
> +				next = cb->next;
> +				kfree(cb);
> +			}
>   		}
>   	}
>   #endif
> @@ -215,28 +220,36 @@ EXPORT_SYMBOL_GPL(snd_hda_jack_detect_state);
>   /**
>    * snd_hda_jack_detect_enable - enable the jack-detection
>    */
> -struct hda_jack_tbl *
> +struct hda_jack_callback *
>   snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
> -				    hda_jack_callback cb)
> +				    hda_jack_callback_fn func)
>   {
> -	struct hda_jack_tbl *jack = snd_hda_jack_tbl_new(codec, nid);
> +	struct hda_jack_tbl *jack;
> +	struct hda_jack_callback *callback = NULL;
>   	int err;
>
> +	jack = snd_hda_jack_tbl_new(codec, nid);
>   	if (!jack)
>   		return ERR_PTR(-ENOMEM);

> -	if (jack->jack_detect)
> -		return jack; /* already registered */

This check is an optimisation (do not write unsol verbs to the codec 
more than once, even if many callbacks are added) and should not be 
removed. The "if (func) " part should just move above the check.

> +	if (func) {
> +		callback = kzalloc(sizeof(*callback), GFP_KERNEL);
> +		if (!callback)
> +			return ERR_PTR(-ENOMEM);
> +		callback->func = func;
> +		callback->tbl = jack;
> +		callback->next = jack->callback;
> +		jack->callback = callback;
> +	}
> +
>   	jack->jack_detect = 1;
> -	if (cb)
> -		jack->callback = cb;
>   	if (codec->jackpoll_interval > 0)
> -		return jack; /* No unsol if we're polling instead */
> +		return callback; /* No unsol if we're polling instead */
>   	err = snd_hda_codec_write_cache(codec, nid, 0,
>   					 AC_VERB_SET_UNSOLICITED_ENABLE,
>   					 AC_USRSP_EN | jack->tag);
>   	if (err < 0)
>   		return ERR_PTR(err);
> -	return jack;
> +	return callback;
>   }
>   EXPORT_SYMBOL_GPL(snd_hda_jack_detect_enable_callback);
>
> @@ -499,13 +512,17 @@ EXPORT_SYMBOL_GPL(snd_hda_jack_add_kctls);
>   static void call_jack_callback(struct hda_codec *codec,
>   			       struct hda_jack_tbl *jack)
>   {
> -	if (jack->callback)
> -		jack->callback(codec, jack);
> +	struct hda_jack_callback *cb;
> +
> +	for (cb = jack->callback; cb; cb = cb->next)
> +		cb->func(codec, cb);
>   	if (jack->gated_jack) {
>   		struct hda_jack_tbl *gated =
>   			snd_hda_jack_tbl_get(codec, jack->gated_jack);
> -		if (gated && gated->callback)
> -			gated->callback(codec, gated);
> +		if (gated) {
> +			for (cb = gated->callback; cb; cb = cb->next)
> +				cb->func(codec, cb);
> +		}
>   	}
>   }
>
> diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
> index 668669ce3e52..b41e0a3ea1fb 100644
> --- a/sound/pci/hda/hda_jack.h
> +++ b/sound/pci/hda/hda_jack.h
> @@ -14,14 +14,21 @@
>
>   struct auto_pin_cfg;
>   struct hda_jack_tbl;
> +struct hda_jack_callback;
>
> -typedef void (*hda_jack_callback) (struct hda_codec *, struct hda_jack_tbl *);
> +typedef void (*hda_jack_callback_fn) (struct hda_codec *, struct hda_jack_callback *);
> +
> +struct hda_jack_callback {
> +	struct hda_jack_tbl *tbl;
> +	hda_jack_callback_fn func;
> +	unsigned int private_data;	/* arbitrary data */
> +	struct hda_jack_callback *next;
> +};
>
>   struct hda_jack_tbl {
>   	hda_nid_t nid;
>   	unsigned char tag;		/* unsol event tag */
> -	unsigned int private_data;	/* arbitrary data */
> -	hda_jack_callback callback;
> +	struct hda_jack_callback *callback;
>   	/* jack-detection stuff */
>   	unsigned int pin_sense;		/* cached pin-sense value */
>   	unsigned int jack_detect:1;	/* capable of jack-detection? */
> @@ -47,9 +54,9 @@ void snd_hda_jack_tbl_clear(struct hda_codec *codec);
>   void snd_hda_jack_set_dirty_all(struct hda_codec *codec);
>
>   int snd_hda_jack_detect_enable(struct hda_codec *codec, hda_nid_t nid);
> -struct hda_jack_tbl *
> +struct hda_jack_callback *
>   snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
> -				    hda_jack_callback cb);
> +				    hda_jack_callback_fn cb);
>
>   int snd_hda_jack_set_gating_jack(struct hda_codec *codec, hda_nid_t gated_nid,
>   				 hda_nid_t gating_nid);
> diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
> index 69b0ffc55a51..1589c9bcce3e 100644
> --- a/sound/pci/hda/patch_cirrus.c
> +++ b/sound/pci/hda/patch_cirrus.c
> @@ -982,7 +982,7 @@ static void cs4210_pinmux_init(struct hda_codec *codec)
>   }
>
>   static void cs4210_spdif_automute(struct hda_codec *codec,
> -				  struct hda_jack_tbl *tbl)
> +				  struct hda_jack_callback *tbl)
>   {
>   	struct cs_spec *spec = codec->spec;
>   	bool spdif_present = false;
> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
> index e0c5bc1d671b..d5b0582daaf0 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -393,7 +393,8 @@ static void olpc_xo_update_mic_pins(struct hda_codec *codec)
>   }
>
>   /* mic_autoswitch hook */
> -static void olpc_xo_automic(struct hda_codec *codec, struct hda_jack_tbl *jack)
> +static void olpc_xo_automic(struct hda_codec *codec,
> +			    struct hda_jack_callback *jack)
>   {
>   	struct conexant_spec *spec = codec->spec;
>   	int saved_cached_write = codec->cached_write;
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 8f94527f1890..39862e98551c 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1163,17 +1163,23 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
>
>   static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll);
>
> -static void jack_callback(struct hda_codec *codec, struct hda_jack_tbl *jack)
> +static void check_presence_and_report(struct hda_codec *codec, hda_nid_t nid)
>   {
>   	struct hdmi_spec *spec = codec->spec;
> -	int pin_idx = pin_nid_to_pin_index(codec, jack->nid);
> +	int pin_idx = pin_nid_to_pin_index(codec, nid);
> +
>   	if (pin_idx < 0)
>   		return;
> -
>   	if (hdmi_present_sense(get_pin(spec, pin_idx), 1))
>   		snd_hda_jack_report_sync(codec);
>   }
>
> +static void jack_callback(struct hda_codec *codec,
> +			  struct hda_jack_callback *jack)
> +{
> +	check_presence_and_report(codec, jack->tbl->nid);
> +}
> +
>   static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
>   {
>   	int tag = res >> AC_UNSOL_RES_TAG_SHIFT;
> @@ -1190,7 +1196,7 @@ static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
>   		codec->addr, jack->nid, dev_entry, !!(res & AC_UNSOL_RES_IA),
>   		!!(res & AC_UNSOL_RES_PD), !!(res & AC_UNSOL_RES_ELDV));
>
> -	jack_callback(codec, jack);
> +	check_presence_and_report(codec, jack->nid);
>   }
>
>   static void hdmi_non_intrinsic_event(struct hda_codec *codec, unsigned int res)
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index ac00420e59ff..a109fdb085f9 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -264,7 +264,8 @@ static void alc_fix_pll_init(struct hda_codec *codec, hda_nid_t nid,
>   }
>
>   /* update the master volume per volume-knob's unsol event */
> -static void alc_update_knob_master(struct hda_codec *codec, struct hda_jack_tbl *jack)
> +static void alc_update_knob_master(struct hda_codec *codec,
> +				   struct hda_jack_callback *jack)
>   {
>   	unsigned int val;
>   	struct snd_kcontrol *kctl;
> @@ -276,7 +277,7 @@ static void alc_update_knob_master(struct hda_codec *codec, struct hda_jack_tbl
>   	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
>   	if (!uctl)
>   		return;
> -	val = snd_hda_codec_read(codec, jack->nid, 0,
> +	val = snd_hda_codec_read(codec, jack->tbl->nid, 0,
>   				 AC_VERB_GET_VOLUME_KNOB_CONTROL, 0);
>   	val &= HDA_AMP_VOLMASK;
>   	uctl->value.integer.value[0] = val;
> @@ -3272,7 +3273,7 @@ static void alc269_fixup_quanta_mute(struct hda_codec *codec,
>   }
>
>   static void alc269_x101_hp_automute_hook(struct hda_codec *codec,
> -					 struct hda_jack_tbl *jack)
> +					 struct hda_jack_callback *jack)
>   {
>   	struct alc_spec *spec = codec->spec;
>   	int vref;
> @@ -3926,7 +3927,8 @@ static void alc_update_headset_mode_hook(struct hda_codec *codec,
>   	alc_update_headset_mode(codec);
>   }
>
> -static void alc_update_headset_jack_cb(struct hda_codec *codec, struct hda_jack_tbl *jack)
> +static void alc_update_headset_jack_cb(struct hda_codec *codec,
> +				       struct hda_jack_callback *jack)
>   {
>   	struct alc_spec *spec = codec->spec;
>   	spec->current_headset_type = ALC_HEADSET_TYPE_UNKNOWN;
> @@ -4166,7 +4168,7 @@ static void alc269_fixup_limit_int_mic_boost(struct hda_codec *codec,
>   }
>
>   static void alc283_hp_automute_hook(struct hda_codec *codec,
> -				    struct hda_jack_tbl *jack)
> +				    struct hda_jack_callback *jack)
>   {
>   	struct alc_spec *spec = codec->spec;
>   	int vref;
> diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
> index 4b338beb9449..3193529607f2 100644
> --- a/sound/pci/hda/patch_sigmatel.c
> +++ b/sound/pci/hda/patch_sigmatel.c
> @@ -481,7 +481,7 @@ static void stac_toggle_power_map(struct hda_codec *codec, hda_nid_t nid,
>
>   /* update power bit per jack plug/unplug */
>   static void jack_update_power(struct hda_codec *codec,
> -			      struct hda_jack_tbl *jack)
> +			      struct hda_jack_callback *jack)
>   {
>   	struct sigmatel_spec *spec = codec->spec;
>   	int i;
> @@ -489,9 +489,9 @@ static void jack_update_power(struct hda_codec *codec,
>   	if (!spec->num_pwrs)
>   		return;
>
> -	if (jack && jack->nid) {
> -		stac_toggle_power_map(codec, jack->nid,
> -				      snd_hda_jack_detect(codec, jack->nid),
> +	if (jack && jack->tbl->nid) {
> +		stac_toggle_power_map(codec, jack->tbl->nid,
> +				      snd_hda_jack_detect(codec, jack->tbl->nid),
>   				      true);
>   		return;
>   	}
> @@ -499,8 +499,7 @@ static void jack_update_power(struct hda_codec *codec,
>   	/* update all jacks */
>   	for (i = 0; i < spec->num_pwrs; i++) {
>   		hda_nid_t nid = spec->pwr_nids[i];
> -		jack = snd_hda_jack_tbl_get(codec, nid);
> -		if (!jack)
> +		if (!snd_hda_jack_tbl_get(codec, nid))
>   			continue;
>   		stac_toggle_power_map(codec, nid,
>   				      snd_hda_jack_detect(codec, nid),
> @@ -512,27 +511,28 @@ static void jack_update_power(struct hda_codec *codec,
>   }
>
>   static void stac_hp_automute(struct hda_codec *codec,
> -				 struct hda_jack_tbl *jack)
> +				 struct hda_jack_callback *jack)
>   {
>   	snd_hda_gen_hp_automute(codec, jack);
>   	jack_update_power(codec, jack);
>   }
>
>   static void stac_line_automute(struct hda_codec *codec,
> -				   struct hda_jack_tbl *jack)
> +				   struct hda_jack_callback *jack)
>   {
>   	snd_hda_gen_line_automute(codec, jack);
>   	jack_update_power(codec, jack);
>   }
>
>   static void stac_mic_autoswitch(struct hda_codec *codec,
> -				struct hda_jack_tbl *jack)
> +				struct hda_jack_callback *jack)
>   {
>   	snd_hda_gen_mic_autoswitch(codec, jack);
>   	jack_update_power(codec, jack);
>   }
>
> -static void stac_vref_event(struct hda_codec *codec, struct hda_jack_tbl *event)
> +static void stac_vref_event(struct hda_codec *codec,
> +			    struct hda_jack_callback *event)
>   {
>   	unsigned int data;
>
> @@ -3011,7 +3011,7 @@ static void stac92hd71bxx_fixup_hp_m4(struct hda_codec *codec,
>   				      const struct hda_fixup *fix, int action)
>   {
>   	struct sigmatel_spec *spec = codec->spec;
> -	struct hda_jack_tbl *jack;
> +	struct hda_jack_callback *jack;
>
>   	if (action != HDA_FIXUP_ACT_PRE_PROBE)
>   		return;
> @@ -4033,7 +4033,7 @@ static void stac9205_fixup_dell_m43(struct hda_codec *codec,
>   				    const struct hda_fixup *fix, int action)
>   {
>   	struct sigmatel_spec *spec = codec->spec;
> -	struct hda_jack_tbl *jack;
> +	struct hda_jack_callback *jack;
>
>   	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
>   		snd_hda_apply_pincfgs(codec, dell_9205_m43_pin_configs);
> diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
> index 2a8be5a5da15..8d234ab9f06b 100644
> --- a/sound/pci/hda/patch_via.c
> +++ b/sound/pci/hda/patch_via.c
> @@ -118,7 +118,7 @@ static void via_playback_pcm_hook(struct hda_pcm_stream *hinfo,
>   				  struct hda_codec *codec,
>   				  struct snd_pcm_substream *substream,
>   				  int action);
> -static void via_hp_automute(struct hda_codec *codec, struct hda_jack_tbl *tbl);
> +static void via_hp_automute(struct hda_codec *codec, struct hda_jack_callback *tbl);
>
>   static struct via_spec *via_new_spec(struct hda_codec *codec)
>   {
> @@ -575,19 +575,22 @@ static const struct snd_kcontrol_new vt1708_jack_detect_ctl[] = {
>   	{} /* terminator */
>   };
>
> -static void via_hp_automute(struct hda_codec *codec, struct hda_jack_tbl *tbl)
> +static void via_hp_automute(struct hda_codec *codec,
> +			    struct hda_jack_callback *tbl)
>   {
>   	set_widgets_power_state(codec);
>   	snd_hda_gen_hp_automute(codec, tbl);
>   }
>
> -static void via_line_automute(struct hda_codec *codec, struct hda_jack_tbl *tbl)
> +static void via_line_automute(struct hda_codec *codec,
> +			      struct hda_jack_callback *tbl)
>   {
>   	set_widgets_power_state(codec);
>   	snd_hda_gen_line_automute(codec, tbl);
>   }
>
> -static void via_jack_powerstate_event(struct hda_codec *codec, struct hda_jack_tbl *tbl)
> +static void via_jack_powerstate_event(struct hda_codec *codec,
> +				      struct hda_jack_callback *tbl)
>   {
>   	set_widgets_power_state(codec);
>   }
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
