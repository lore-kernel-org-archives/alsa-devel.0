From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/3] ALSA: hda - Make the inv dmic handling for
	Realtek use generic parser
Date: Tue,  7 Oct 2014 10:18:42 +0200
Message-ID: <1412669922-10056-3-git-send-email-david.henningsson@canonical.com>
References: <1412669922-10056-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8724F260393
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 10:18:44 +0200 (CEST)
In-Reply-To: <1412669922-10056-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>From what I can see, the generic parser is now good enough to handle
Realtek's inverted dmic handling, so let's remove the special handling
and use the generic parser instead.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 158 +++---------------------------------------
 1 file changed, 8 insertions(+), 150 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 82ea50e..69d1236 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -90,11 +90,6 @@ struct alc_spec {
 	struct alc_customize_define cdefine;
 	unsigned int parse_flags; /* flag for snd_hda_parse_pin_defcfg() */
 
-	/* inverted dmic fix */
-	unsigned int inv_dmic_fixup:1; /* has inverted digital-mic workaround */
-	unsigned int inv_dmic_muted:1; /* R-ch of inv d-mic is muted? */
-	hda_nid_t inv_dmic_pin;
-
 	/* mute LED for HP laptops, see alc269_fixup_mic_mute_hook() */
 	int mute_led_polarity;
 	hda_nid_t mute_led_nid;
@@ -625,147 +620,12 @@ static void alc_ssid_check(struct hda_codec *codec, const hda_nid_t *ports)
 /*
  */
 
-static hda_nid_t get_adc_nid(struct hda_codec *codec, int adc_idx, int imux_idx)
-{
-	struct hda_gen_spec *spec = codec->spec;
-	if (spec->dyn_adc_switch)
-		adc_idx = spec->dyn_adc_idx[imux_idx];
-	return spec->adc_nids[adc_idx];
-}
-
-static void alc_inv_dmic_sync_adc(struct hda_codec *codec, int adc_idx)
-{
-	struct alc_spec *spec = codec->spec;
-	struct hda_input_mux *imux = &spec->gen.input_mux;
-	struct nid_path *path;
-	hda_nid_t nid;
-	int i, dir, parm;
-	unsigned int val;
-
-	for (i = 0; i < imux->num_items; i++) {
-		if (spec->gen.imux_pins[i] == spec->inv_dmic_pin)
-			break;
-	}
-	if (i >= imux->num_items)
-		return;
-
-	path = snd_hda_get_nid_path(codec, spec->inv_dmic_pin,
-				    get_adc_nid(codec, adc_idx, i));
-	val = path->ctls[NID_PATH_MUTE_CTL];
-	if (!val)
-		return;
-	nid = get_amp_nid_(val);
-	dir = get_amp_direction_(val);
-	parm = AC_AMP_SET_RIGHT |
-		(dir == HDA_OUTPUT ? AC_AMP_SET_OUTPUT : AC_AMP_SET_INPUT);
-
-	/* flush all cached amps at first */
-	snd_hda_codec_flush_cache(codec);
-
-	/* we care only right channel */
-	val = snd_hda_codec_amp_read(codec, nid, 1, dir, 0);
-	if (val & 0x80) /* if already muted, we don't need to touch */
-		return;
-	val |= 0x80;
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE,
-			    parm | val);
-}
-
-/*
- * Inverted digital-mic handling
- *
- * First off, it's a bit tricky.  The "Inverted Internal Mic Capture Switch"
- * gives the additional mute only to the right channel of the digital mic
- * capture stream.  This is a workaround for avoiding the almost silence
- * by summing the stereo stream from some (known to be ForteMedia)
- * digital mic unit.
- *
- * The logic is to call alc_inv_dmic_sync() after each action (possibly)
- * modifying ADC amp.  When the mute flag is set, it mutes the R-channel
- * without caching so that the cache can still keep the original value.
- * The cached value is then restored when the flag is set off or any other
- * than d-mic is used as the current input source.
- */
-static void alc_inv_dmic_sync(struct hda_codec *codec, bool force)
-{
-	struct alc_spec *spec = codec->spec;
-	int src, nums;
-
-	if (!spec->inv_dmic_fixup)
-		return;
-	if (!spec->inv_dmic_muted && !force)
-		return;
-	nums = spec->gen.dyn_adc_switch ? 1 : spec->gen.num_adc_nids;
-	for (src = 0; src < nums; src++) {
-		bool dmic_fixup = false;
-
-		if (spec->inv_dmic_muted &&
-		    spec->gen.imux_pins[spec->gen.cur_mux[src]] == spec->inv_dmic_pin)
-			dmic_fixup = true;
-		if (!dmic_fixup && !force)
-			continue;
-		alc_inv_dmic_sync_adc(codec, src);
-	}
-}
-
-static void alc_inv_dmic_hook(struct hda_codec *codec,
-			      struct snd_kcontrol *kcontrol,
-			      struct snd_ctl_elem_value *ucontrol)
-{
-	alc_inv_dmic_sync(codec, false);
-}
-
-static int alc_inv_dmic_sw_get(struct snd_kcontrol *kcontrol,
-			       struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct alc_spec *spec = codec->spec;
-
-	ucontrol->value.integer.value[0] = !spec->inv_dmic_muted;
-	return 0;
-}
-
-static int alc_inv_dmic_sw_put(struct snd_kcontrol *kcontrol,
-			       struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct alc_spec *spec = codec->spec;
-	unsigned int val = !ucontrol->value.integer.value[0];
-
-	if (val == spec->inv_dmic_muted)
-		return 0;
-	spec->inv_dmic_muted = val;
-	alc_inv_dmic_sync(codec, true);
-	return 0;
-}
-
-static const struct snd_kcontrol_new alc_inv_dmic_sw = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "Inverted Internal Mic Capture Switch",
-	.info = snd_ctl_boolean_mono_info,
-	.get = alc_inv_dmic_sw_get,
-	.put = alc_inv_dmic_sw_put,
-};
-
-static int alc_add_inv_dmic_mixer(struct hda_codec *codec, hda_nid_t nid)
+static void alc_fixup_inv_dmic(struct hda_codec *codec,
+			       const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
 
-	if (!snd_hda_gen_add_kctl(&spec->gen, NULL, &alc_inv_dmic_sw))
-		return -ENOMEM;
-	spec->inv_dmic_fixup = 1;
-	spec->inv_dmic_muted = 0;
-	spec->inv_dmic_pin = nid;
-	spec->gen.cap_sync_hook = alc_inv_dmic_hook;
-	return 0;
-}
-
-/* typically the digital mic is put at node 0x12 */
-static void alc_fixup_inv_dmic_0x12(struct hda_codec *codec,
-				    const struct hda_fixup *fix, int action)
-{
-	if (action == HDA_FIXUP_ACT_PROBE)
-		alc_add_inv_dmic_mixer(codec, 0x12);
+	spec->gen.inv_dmic_split = 1;
 }
 
 
@@ -874,7 +734,6 @@ static int alc_resume(struct hda_codec *codec)
 	codec->patch_ops.init(codec);
 	snd_hda_codec_resume_amp(codec);
 	snd_hda_codec_resume_cache(codec);
-	alc_inv_dmic_sync(codec, true);
 	hda_call_check_power_status(codec, 0x01);
 	return 0;
 }
@@ -2217,7 +2076,7 @@ static const struct hda_fixup alc882_fixups[] = {
 	},
 	[ALC882_FIXUP_INV_DMIC] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc_fixup_inv_dmic_0x12,
+		.v.func = alc_fixup_inv_dmic,
 	},
 	[ALC882_FIXUP_NO_PRIMARY_HP] = {
 		.type = HDA_FIXUP_FUNC,
@@ -2468,7 +2327,7 @@ static const struct hda_fixup alc262_fixups[] = {
 	},
 	[ALC262_FIXUP_INV_DMIC] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc_fixup_inv_dmic_0x12,
+		.v.func = alc_fixup_inv_dmic,
 	},
 	[ALC262_FIXUP_INTEL_BAYLEYBAY] = {
 		.type = HDA_FIXUP_FUNC,
@@ -2581,7 +2440,7 @@ enum {
 static const struct hda_fixup alc268_fixups[] = {
 	[ALC268_FIXUP_INV_DMIC] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc_fixup_inv_dmic_0x12,
+		.v.func = alc_fixup_inv_dmic,
 	},
 	[ALC268_FIXUP_HP_EAPD] = {
 		.type = HDA_FIXUP_VERBS,
@@ -3167,7 +3026,6 @@ static int alc269_resume(struct hda_codec *codec)
 
 	snd_hda_codec_resume_amp(codec);
 	snd_hda_codec_resume_cache(codec);
-	alc_inv_dmic_sync(codec, true);
 	hda_call_check_power_status(codec, 0x01);
 
 	/* on some machine, the BIOS will clear the codec gpio data when enter
@@ -4520,7 +4378,7 @@ static const struct hda_fixup alc269_fixups[] = {
 	},
 	[ALC269_FIXUP_INV_DMIC] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc_fixup_inv_dmic_0x12,
+		.v.func = alc_fixup_inv_dmic,
 	},
 	[ALC269_FIXUP_NO_SHUTUP] = {
 		.type = HDA_FIXUP_FUNC,
@@ -5980,7 +5838,7 @@ static const struct hda_fixup alc662_fixups[] = {
 	},
 	[ALC662_FIXUP_INV_DMIC] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc_fixup_inv_dmic_0x12,
+		.v.func = alc_fixup_inv_dmic,
 	},
 	[ALC668_FIXUP_DELL_XPS13] = {
 		.type = HDA_FIXUP_FUNC,
-- 
1.9.1
