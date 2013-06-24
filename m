From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: hda - Add auto_mute_via_amp flag to
	generic parser
Date: Mon, 24 Jun 2013 16:32:56 +0200
Message-ID: <1372084377-14431-3-git-send-email-tiwai@suse.de>
References: <1372084377-14431-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DC01265272
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 16:32:14 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E48DEA5230
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 16:32:11 +0200 (CEST)
In-Reply-To: <1372084377-14431-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add a new flag, auto_mute_via_amp, to determine the behavior of the
headphone / line-out auto-mute.  When this flag is set, the generic
driver mutes the speaker and line outputs via the amp mute of each
pin, instead of changing the pin control values.

This is introduced for devices that don't work expectedly with the pin
control values; for example, some devices are known to keep enabling
the speaker outputs no matter which pin control values are set on the
speaker pins.

The driver doesn't check actually whether the pins have the output amp
caps, but assumes that the proper mixer (mute) controls are created on
all these pins.  If not the case, you can't use this flag for your
device.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 47 ++++++++++++++++++++++++++++++++++++++++++++-
 sound/pci/hda/hda_generic.h |  4 ++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 4b1524a..4649473 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -133,6 +133,9 @@ static void parse_user_hints(struct hda_codec *codec)
 	val = snd_hda_get_bool_hint(codec, "line_in_auto_switch");
 	if (val >= 0)
 		spec->line_in_auto_switch = !!val;
+	val = snd_hda_get_bool_hint(codec, "auto_mute_via_amp");
+	if (val >= 0)
+		spec->auto_mute_via_amp = !!val;
 	val = snd_hda_get_bool_hint(codec, "need_dac_fix");
 	if (val >= 0)
 		spec->need_dac_fix = !!val;
@@ -808,6 +811,9 @@ static void resume_path_from_idx(struct hda_codec *codec, int path_idx)
  * Helper functions for creating mixer ctl elements
  */
 
+static int hda_gen_mixer_mute_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol);
+
 enum {
 	HDA_CTL_WIDGET_VOL,
 	HDA_CTL_WIDGET_MUTE,
@@ -815,7 +821,15 @@ enum {
 };
 static const struct snd_kcontrol_new control_templates[] = {
 	HDA_CODEC_VOLUME(NULL, 0, 0, 0),
-	HDA_CODEC_MUTE(NULL, 0, 0, 0),
+	/* only the put callback is replaced for handling the special mute */
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.subdevice = HDA_SUBDEV_AMP_FLAG,
+		.info = snd_hda_mixer_amp_switch_info,
+		.get = snd_hda_mixer_amp_switch_get,
+		.put = hda_gen_mixer_mute_put, /* replaced */
+		.private_value = HDA_COMPOSE_AMP_VAL(0, 3, 0, 0),
+	},
 	HDA_BIND_MUTE(NULL, 0, 0, 0),
 };
 
@@ -922,6 +936,23 @@ static int add_stereo_sw(struct hda_codec *codec, const char *pfx,
 	return add_sw_ctl(codec, pfx, cidx, chs, path);
 }
 
+/* playback mute control with the software mute bit check */
+static int hda_gen_mixer_mute_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hda_gen_spec *spec = codec->spec;
+
+	if (spec->auto_mute_via_amp) {
+		hda_nid_t nid = get_amp_nid(kcontrol);
+		bool enabled = !((spec->mute_bits >> nid) & 1);
+		ucontrol->value.integer.value[0] &= enabled;
+		ucontrol->value.integer.value[1] &= enabled;
+	}
+
+	return snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
+}
+
 /* any ctl assigned to the path with the given index? */
 static bool path_has_mixer(struct hda_codec *codec, int path_idx, int ctl_type)
 {
@@ -3719,6 +3750,16 @@ static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
 		unsigned int val, oldval;
 		if (!nid)
 			break;
+
+		if (spec->auto_mute_via_amp) {
+			if (mute)
+				spec->mute_bits |= (1ULL << nid);
+			else
+				spec->mute_bits &= ~(1ULL << nid);
+			set_pin_eapd(codec, nid, !mute);
+			continue;
+		}
+
 		oldval = snd_hda_codec_get_pin_target(codec, nid);
 		if (oldval & PIN_IN)
 			continue; /* no mute for inputs */
@@ -3786,6 +3827,10 @@ static void call_update_outputs(struct hda_codec *codec)
 		spec->automute_hook(codec);
 	else
 		snd_hda_gen_update_outputs(codec);
+
+	/* sync the whole vmaster slaves to reflect the new auto-mute status */
+	if (spec->auto_mute_via_amp && !codec->bus->shutdown)
+		snd_ctl_sync_vmaster(spec->vmaster_mute.sw_kctl);
 }
 
 /* standard HP-automute helper */
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 7620031..e199a85 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -209,6 +209,7 @@ struct hda_gen_spec {
 	unsigned int master_mute:1;	/* master mute over all */
 	unsigned int keep_vref_in_automute:1; /* Don't clear VREF in automute */
 	unsigned int line_in_auto_switch:1; /* allow line-in auto switch */
+	unsigned int auto_mute_via_amp:1; /* auto-mute via amp instead of pinctl */
 
 	/* parser behavior flags; set before snd_hda_gen_parse_auto_config() */
 	unsigned int suppress_auto_mute:1; /* suppress input jack auto mute */
@@ -237,6 +238,9 @@ struct hda_gen_spec {
 	unsigned int have_aamix_ctl:1;
 	unsigned int hp_mic_jack_modes:1;
 
+	/* additional mute flags (only effective with auto_mute_via_amp=1) */
+	u64 mute_bits;
+
 	/* badness tables for output path evaluations */
 	const struct badness_table *main_out_badness;
 	const struct badness_table *extra_out_badness;
-- 
1.8.3.1
