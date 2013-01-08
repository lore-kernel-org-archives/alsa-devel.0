From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 048/112] ALSA: hda - Export
	snd_hda_gen_add_kctl()
Date: Tue,  8 Jan 2013 12:38:41 +0100
Message-ID: <1357645185-7645-49-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A83672651C8
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 0A2F6A5271
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

It may be used in other codec drivers, so let it free.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 19 ++++++++++---------
 sound/pci/hda/hda_generic.h |  4 ++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 31c5677..49e968c 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -43,9 +43,9 @@ int snd_hda_gen_spec_init(struct hda_gen_spec *spec)
 }
 EXPORT_SYMBOL_HDA(snd_hda_gen_spec_init);
 
-static struct snd_kcontrol_new *
-add_kctl(struct hda_gen_spec *spec, const char *name,
-	 const struct snd_kcontrol_new *temp)
+struct snd_kcontrol_new *
+snd_hda_gen_add_kctl(struct hda_gen_spec *spec, const char *name,
+		     const struct snd_kcontrol_new *temp)
 {
 	struct snd_kcontrol_new *knew = snd_array_new(&spec->kctls);
 	if (!knew)
@@ -59,6 +59,7 @@ add_kctl(struct hda_gen_spec *spec, const char *name,
 		return NULL;
 	return knew;
 }
+EXPORT_SYMBOL_HDA(snd_hda_gen_add_kctl);
 
 static void free_kctls(struct hda_gen_spec *spec)
 {
@@ -548,7 +549,7 @@ static int add_control(struct hda_gen_spec *spec, int type, const char *name,
 {
 	struct snd_kcontrol_new *knew;
 
-	knew = add_kctl(spec, name, &control_templates[type]);
+	knew = snd_hda_gen_add_kctl(spec, name, &control_templates[type]);
 	if (!knew)
 		return -ENOMEM;
 	knew->index = cidx;
@@ -1527,7 +1528,7 @@ static int create_multi_channel_mode(struct hda_codec *codec)
 	struct hda_gen_spec *spec = codec->spec;
 
 	if (spec->multi_ios > 0) {
-		if (!add_kctl(spec, NULL, &channel_mode_enum))
+		if (!snd_hda_gen_add_kctl(spec, NULL, &channel_mode_enum))
 			return -ENOMEM;
 	}
 	return 0;
@@ -2086,7 +2087,7 @@ static int create_bind_cap_vol_ctl(struct hda_codec *codec, int idx,
 	struct snd_kcontrol_new *knew;
 
 	if (vol_ctl) {
-		knew = add_kctl(spec, NULL, &cap_vol_temp);
+		knew = snd_hda_gen_add_kctl(spec, NULL, &cap_vol_temp);
 		if (!knew)
 			return -ENOMEM;
 		knew->index = idx;
@@ -2094,7 +2095,7 @@ static int create_bind_cap_vol_ctl(struct hda_codec *codec, int idx,
 		knew->subdevice = HDA_SUBDEV_AMP_FLAG;
 	}
 	if (sw_ctl) {
-		knew = add_kctl(spec, NULL, &cap_sw_temp);
+		knew = snd_hda_gen_add_kctl(spec, NULL, &cap_sw_temp);
 		if (!knew)
 			return -ENOMEM;
 		knew->index = idx;
@@ -2171,7 +2172,7 @@ static int create_capture_mixers(struct hda_codec *codec)
 
 	if (!spec->auto_mic && imux->num_items > 1) {
 		struct snd_kcontrol_new *knew;
-		knew = add_kctl(spec, NULL, &cap_src_temp);
+		knew = snd_hda_gen_add_kctl(spec, NULL, &cap_src_temp);
 		if (!knew)
 			return -ENOMEM;
 		knew->count = nums;
@@ -2592,7 +2593,7 @@ static int add_automute_mode_enum(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
 
-	if (!add_kctl(spec, NULL, &automute_mode_enum))
+	if (!snd_hda_gen_add_kctl(spec, NULL, &automute_mode_enum))
 		return -ENOMEM;
 	return 0;
 }
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 9c00bd5..d71e86d 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -192,6 +192,10 @@ snd_hda_add_new_path(struct hda_codec *codec, hda_nid_t from_nid,
 void snd_hda_activate_path(struct hda_codec *codec, struct nid_path *path,
 			   bool enable, bool add_aamix);
 
+struct snd_kcontrol_new *
+snd_hda_gen_add_kctl(struct hda_gen_spec *spec, const char *name,
+		     const struct snd_kcontrol_new *temp);
+
 int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 				  const hda_nid_t *ignore_nids);
 int snd_hda_gen_build_controls(struct hda_codec *codec);
-- 
1.8.0.1
