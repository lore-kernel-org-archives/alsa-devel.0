From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 20/20] ALSA: hda - Allow user to give hints for
	codec parser behavior
Date: Tue, 15 Jan 2013 12:05:47 +0100
Message-ID: <1358247947-13992-21-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E26FB265334
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id BB87FA524D
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:48 +0100 (CET)
In-Reply-To: <1358247947-13992-1-git-send-email-tiwai@suse.de>
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

Through the hints via sysfs or patch, user can set specific behavior
flags for the generic parser now.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c |  3 ++
 sound/pci/hda/hda_generic.c     | 70 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 55ed857..33b3ece 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -126,6 +126,9 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 	struct auto_out_pin hp_out[ARRAY_SIZE(cfg->hp_pins)];
 	int i;
 
+	if (!snd_hda_get_int_hint(codec, "parser_flags", &i))
+		cond_flags = i;
+
 	memset(cfg, 0, sizeof(*cfg));
 
 	memset(line_out, 0, sizeof(line_out));
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 55b7897..4bc4cd9 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -84,6 +84,74 @@ void snd_hda_gen_spec_free(struct hda_gen_spec *spec)
 EXPORT_SYMBOL_HDA(snd_hda_gen_spec_free);
 
 /*
+ * store user hints
+ */
+static void parse_user_hints(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int val;
+
+	val = snd_hda_get_bool_hint(codec, "jack_detect");
+	if (val >= 0)
+		codec->no_jack_detect = !val;
+	val = snd_hda_get_bool_hint(codec, "inv_jack_detect");
+	if (val >= 0)
+		codec->inv_jack_detect = !!val;
+	val = snd_hda_get_bool_hint(codec, "trigger_sense");
+	if (val >= 0)
+		codec->no_trigger_sense = !val;
+	val = snd_hda_get_bool_hint(codec, "inv_eapd");
+	if (val >= 0)
+		codec->inv_eapd = !!val;
+	val = snd_hda_get_bool_hint(codec, "pcm_format_first");
+	if (val >= 0)
+		codec->pcm_format_first = !!val;
+	val = snd_hda_get_bool_hint(codec, "sticky_stream");
+	if (val >= 0)
+		codec->no_sticky_stream = !val;
+	val = snd_hda_get_bool_hint(codec, "spdif_status_reset");
+	if (val >= 0)
+		codec->spdif_status_reset = !!val;
+	val = snd_hda_get_bool_hint(codec, "pin_amp_workaround");
+	if (val >= 0)
+		codec->pin_amp_workaround = !!val;
+	val = snd_hda_get_bool_hint(codec, "single_adc_amp");
+	if (val >= 0)
+		codec->single_adc_amp = !!val;
+
+	val = snd_hda_get_bool_hint(codec, "auto_mic");
+	if (val >= 0)
+		spec->suppress_auto_mic = !val;
+	val = snd_hda_get_bool_hint(codec, "line_in_auto_switch");
+	if (val >= 0)
+		spec->line_in_auto_switch = !!val;
+	val = snd_hda_get_bool_hint(codec, "need_dac_fix");
+	if (val >= 0)
+		spec->need_dac_fix = !!val;
+	val = snd_hda_get_bool_hint(codec, "primary_hp");
+	if (val >= 0)
+		spec->no_primary_hp = !val;
+	val = snd_hda_get_bool_hint(codec, "multi_cap_vol");
+	if (val >= 0)
+		spec->multi_cap_vol = !!val;
+	val = snd_hda_get_bool_hint(codec, "inv_dmic_split");
+	if (val >= 0)
+		spec->inv_dmic_split = !!val;
+	val = snd_hda_get_bool_hint(codec, "indep_hp");
+	if (val >= 0)
+		spec->indep_hp = !!val;
+	val = snd_hda_get_bool_hint(codec, "add_stereo_mix_input");
+	if (val >= 0)
+		spec->add_stereo_mix_input = !!val;
+	val = snd_hda_get_bool_hint(codec, "add_out_jack_modes");
+	if (val >= 0)
+		spec->add_out_jack_modes = !!val;
+
+	if (!snd_hda_get_int_hint(codec, "mixer_nid", &val))
+		spec->mixer_nid = val;
+}
+
+/*
  * pin control value accesses
  */
 
@@ -3304,6 +3372,8 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 	struct hda_gen_spec *spec = codec->spec;
 	int err;
 
+	parse_user_hints(codec);
+
 	if (cfg != &spec->autocfg) {
 		spec->autocfg = *cfg;
 		cfg = &spec->autocfg;
-- 
1.8.1
