From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/20] ALSA: hda - Add output jack mode enum
	controls
Date: Tue, 15 Jan 2013 12:05:41 +0100
Message-ID: <1358247947-13992-15-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DA2B0265330
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id AB2D5A5239
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

Add the enum controls for changing the headphone amp bits of output
jacks, such as "Headphone Jack Mode".  This feature isn't enabled as
default, so far, unless spec->add_out_jack_modes flag is set.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 110 ++++++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_generic.h |   1 +
 2 files changed, 111 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index fb4d843..55b7897 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1959,6 +1959,101 @@ static int create_shared_input(struct hda_codec *codec)
 	return 0;
 }
 
+/*
+ * output jack mode
+ */
+static int out_jack_mode_info(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info *uinfo)
+{
+	static const char * const texts[] = {
+		"Line Out", "Headphone Out",
+	};
+	return snd_hda_enum_helper_info(kcontrol, uinfo, 2, texts);
+}
+
+static int out_jack_mode_get(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	hda_nid_t nid = kcontrol->private_value;
+	if (snd_hda_codec_get_pin_target(codec, nid) == PIN_HP)
+		ucontrol->value.enumerated.item[0] = 1;
+	else
+		ucontrol->value.enumerated.item[0] = 0;
+	return 0;
+}
+
+static int out_jack_mode_put(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	hda_nid_t nid = kcontrol->private_value;
+	unsigned int val;
+
+	val = ucontrol->value.enumerated.item[0] ? PIN_HP : PIN_OUT;
+	if (snd_hda_codec_get_pin_target(codec, nid) == val)
+		return 0;
+	snd_hda_set_pin_ctl_cache(codec, nid, val);
+	return 1;
+}
+
+static const struct snd_kcontrol_new out_jack_mode_enum = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.info = out_jack_mode_info,
+	.get = out_jack_mode_get,
+	.put = out_jack_mode_put,
+};
+
+static bool find_kctl_name(struct hda_codec *codec, const char *name, int idx)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int i;
+
+	for (i = 0; i < spec->kctls.used; i++) {
+		struct snd_kcontrol_new *kctl = snd_array_elem(&spec->kctls, i);
+		if (!strcmp(kctl->name, name) && kctl->index == idx)
+			return true;
+	}
+	return false;
+}
+
+static void get_jack_mode_name(struct hda_codec *codec, hda_nid_t pin,
+			       char *name, size_t name_len)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int idx = 0;
+
+	snd_hda_get_pin_label(codec, pin, &spec->autocfg, name, name_len, &idx);
+	strlcat(name, " Jack Mode", name_len);
+
+	for (; find_kctl_name(codec, name, idx); idx++)
+		;
+}
+
+static int create_out_jack_modes(struct hda_codec *codec, int num_pins,
+				 hda_nid_t *pins)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int i;
+
+	for (i = 0; i < num_pins; i++) {
+		hda_nid_t pin = pins[i];
+		unsigned int pincap = snd_hda_query_pin_caps(codec, pin);
+		if ((pincap & AC_PINCAP_OUT) && (pincap & AC_PINCAP_HP_DRV)) {
+			struct snd_kcontrol_new *knew;
+			char name[44];
+			get_jack_mode_name(codec, pin, name, sizeof(name));
+			knew = snd_hda_gen_add_kctl(spec, name,
+						    &out_jack_mode_enum);
+			if (!knew)
+				return -ENOMEM;
+			knew->private_value = pin;
+		}
+	}
+
+	return 0;
+}
+
 
 /*
  * Parse input paths
@@ -3298,6 +3393,21 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 	if (err < 0)
 		return err;
 
+	if (spec->add_out_jack_modes) {
+		if (cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
+			err = create_out_jack_modes(codec, cfg->line_outs,
+						    cfg->line_out_pins);
+			if (err < 0)
+				return err;
+		}
+		if (cfg->line_out_type != AUTO_PIN_HP_OUT) {
+			err = create_out_jack_modes(codec, cfg->hp_outs,
+						    cfg->hp_pins);
+			if (err < 0)
+				return err;
+		}
+	}
+
  dig_only:
 	parse_digital(codec);
 
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 89683c7..bfa2d97 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -191,6 +191,7 @@ struct hda_gen_spec {
 	unsigned int indep_hp:1; /* independent HP supported */
 	unsigned int indep_hp_enabled:1; /* independent HP enabled */
 	unsigned int add_stereo_mix_input:1; /* add aamix as a capture src */
+	unsigned int add_out_jack_modes:1; /* add output jack mode enum ctls */
 
 	/* loopback mixing mode */
 	bool aamix_mode;
-- 
1.8.1
