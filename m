From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 093/112] ALSA: hda - Add Loopback Mixing control
Date: Tue,  8 Jan 2013 12:39:26 +0100
Message-ID: <1357645185-7645-94-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 11C9626522A
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id C3184A538C
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

For codecs that have individual routes going through a loopback mixer
(like VIA codecs), we need to provide an explicit switch to choose
whether the output goes through mixer or directly from DAC.

This patch adds the check for such paths and creates "Loopback Mixing"
enum control when available.

It won't influence on codecs like Realtek or others where the loopback
mixer is connected independently from the primary output routes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 106 ++++++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_generic.h |   4 ++
 2 files changed, 110 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 774c092..5b30f9f 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1115,6 +1115,24 @@ static bool map_singles(struct hda_codec *codec, int outs,
 	return found;
 }
 
+/* create a new path including aamix if available, and return its index */
+static int check_aamix_out_path(struct hda_codec *codec, int path_idx)
+{
+	struct nid_path *path;
+
+	path = snd_hda_get_path_from_idx(codec, path_idx);
+	if (!path || !path->depth || path->with_aa_mix)
+		return 0;
+	path = snd_hda_add_new_path(codec, path->path[0],
+				    path->path[path->depth - 1],
+				    HDA_PARSE_ONLY_AAMIX);
+	if (!path)
+		return 0;
+	print_nid_path("output-aamix", path);
+	path->active = false; /* unused as default */
+	return snd_hda_get_path_idx(codec, path);
+}
+
 /* fill in the dac_nids table from the parsed pin configuration */
 static int fill_and_eval_dacs(struct hda_codec *codec,
 			      bool fill_hardwired,
@@ -1211,6 +1229,17 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 		badness += err;
 	}
 
+	if (spec->mixer_nid) {
+		spec->aamix_out_paths[0] =
+			check_aamix_out_path(codec, spec->out_paths[0]);
+		if (cfg->line_out_type != AUTO_PIN_HP_OUT)
+			spec->aamix_out_paths[1] =
+				check_aamix_out_path(codec, spec->hp_paths[0]);
+		if (cfg->line_out_type != AUTO_PIN_SPEAKER_OUT)
+			spec->aamix_out_paths[2] =
+				check_aamix_out_path(codec, spec->speaker_paths[0]);
+	}
+
 	if (cfg->hp_outs && cfg->line_out_type == AUTO_PIN_SPEAKER_OUT)
 		if (count_multiio_pins(codec, cfg->hp_pins[0]) >= 2)
 			spec->multi_ios = 1; /* give badness */
@@ -1728,6 +1757,80 @@ static int create_multi_channel_mode(struct hda_codec *codec)
 }
 
 /*
+ * aamix loopback enable/disable switch
+ */
+
+#define loopback_mixing_info	indep_hp_info
+
+static int loopback_mixing_get(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hda_gen_spec *spec = codec->spec;
+	ucontrol->value.enumerated.item[0] = spec->aamix_mode;
+	return 0;
+}
+
+static void update_aamix_paths(struct hda_codec *codec, bool do_mix,
+			       int nomix_path_idx, int mix_path_idx)
+{
+	struct nid_path *nomix_path, *mix_path;
+
+	nomix_path = snd_hda_get_path_from_idx(codec, nomix_path_idx);
+	mix_path = snd_hda_get_path_from_idx(codec, mix_path_idx);
+	if (!nomix_path || !mix_path)
+		return;
+	if (do_mix) {
+		snd_hda_activate_path(codec, nomix_path, false, true);
+		snd_hda_activate_path(codec, mix_path, true, true);
+	} else {
+		snd_hda_activate_path(codec, mix_path, false, true);
+		snd_hda_activate_path(codec, nomix_path, true, true);
+	}
+}
+
+static int loopback_mixing_put(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hda_gen_spec *spec = codec->spec;
+	unsigned int val = ucontrol->value.enumerated.item[0];
+
+	if (val == spec->aamix_mode)
+		return 0;
+	spec->aamix_mode = val;
+	update_aamix_paths(codec, val, spec->out_paths[0],
+			   spec->aamix_out_paths[0]);
+	update_aamix_paths(codec, val, spec->hp_paths[0],
+			   spec->aamix_out_paths[1]);
+	update_aamix_paths(codec, val, spec->speaker_paths[0],
+			   spec->aamix_out_paths[2]);
+	return 1;
+}
+
+static const struct snd_kcontrol_new loopback_mixing_enum = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Loopback Mixing",
+	.info = loopback_mixing_info,
+	.get = loopback_mixing_get,
+	.put = loopback_mixing_put,
+};
+
+static int create_loopback_mixing_ctl(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+
+	if (!spec->mixer_nid)
+		return 0;
+	if (!(spec->aamix_out_paths[0] || spec->aamix_out_paths[1] ||
+	      spec->aamix_out_paths[2]))
+		return 0;
+	if (!snd_hda_gen_add_kctl(spec, NULL, &loopback_mixing_enum))
+		return -ENOMEM;
+	return 0;
+}
+
+/*
  * shared headphone/mic handling
  */
 
@@ -3065,6 +3168,9 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 	err = create_indep_hp_ctls(codec);
 	if (err < 0)
 		return err;
+	err = create_loopback_mixing_ctl(codec);
+	if (err < 0)
+		return err;
 	err = create_shared_input(codec);
 	if (err < 0)
 		return err;
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index ba8de12..d4a8f6c 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -134,6 +134,7 @@ struct hda_gen_spec {
 	int out_paths[AUTO_CFG_MAX_OUTS];
 	int hp_paths[AUTO_CFG_MAX_OUTS];
 	int speaker_paths[AUTO_CFG_MAX_OUTS];
+	int aamix_out_paths[3];
 	int digout_paths[AUTO_CFG_MAX_OUTS];
 	int loopback_paths[HDA_MAX_NUM_INPUTS];
 	int digin_path;
@@ -169,6 +170,9 @@ struct hda_gen_spec {
 	unsigned int indep_hp:1; /* independent HP supported */
 	unsigned int indep_hp_enabled:1; /* independent HP enabled */
 
+	/* loopback mixing mode */
+	bool aamix_mode;
+
 	/* for virtual master */
 	hda_nid_t vmaster_nid;
 	struct hda_vmaster_mute_hook vmaster_mute;
-- 
1.8.0.1
