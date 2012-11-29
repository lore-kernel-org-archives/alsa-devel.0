From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ALSA: hda - Refactor alc_kcontrol_new()
	usages
Date: Thu, 29 Nov 2012 16:21:29 +0100
Message-ID: <1354202489-12769-6-git-send-email-tiwai@suse.de>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1422C2650EE
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 16:21:46 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id DA49FA39CE
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 16:21:45 +0100 (CET)
In-Reply-To: <1354202489-12769-1-git-send-email-tiwai@suse.de>
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

Allocate the name string and assign the structure in
alc_kcontrol_new() itself to reduce the code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 54 +++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 95c5bc7..d3a4c2ca 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -913,22 +913,25 @@ static const struct snd_kcontrol_new alc_automute_mode_enum = {
 	.put = alc_automute_mode_put,
 };
 
-static struct snd_kcontrol_new *alc_kcontrol_new(struct alc_spec *spec)
+static struct snd_kcontrol_new *
+alc_kcontrol_new(struct alc_spec *spec, const char *name,
+		 const struct snd_kcontrol_new *temp)
 {
-	return snd_array_new(&spec->kctls);
+	struct snd_kcontrol_new *knew = snd_array_new(&spec->kctls);
+	if (!knew)
+		return NULL;
+	*knew = *temp;
+	knew->name = kstrdup(name, GFP_KERNEL);
+	if (!knew->name)
+		return NULL;
+	return knew;
 }
 
 static int alc_add_automute_mode_enum(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	struct snd_kcontrol_new *knew;
 
-	knew = alc_kcontrol_new(spec);
-	if (!knew)
-		return -ENOMEM;
-	*knew = alc_automute_mode_enum;
-	knew->name = kstrdup("Auto-Mute Mode", GFP_KERNEL);
-	if (!knew->name)
+	if (!alc_kcontrol_new(spec, "Auto-Mute Mode", &alc_automute_mode_enum))
 		return -ENOMEM;
 	return 0;
 }
@@ -1769,12 +1772,9 @@ static const struct snd_kcontrol_new alc_inv_dmic_sw = {
 static int alc_add_inv_dmic_mixer(struct hda_codec *codec, hda_nid_t nid)
 {
 	struct alc_spec *spec = codec->spec;
-	struct snd_kcontrol_new *knew = alc_kcontrol_new(spec);
-	if (!knew)
-		return -ENOMEM;
-	*knew = alc_inv_dmic_sw;
-	knew->name = kstrdup("Inverted Internal Mic Capture Switch", GFP_KERNEL);
-	if (!knew->name)
+
+	if (!alc_kcontrol_new(spec, "Inverted Internal Mic Capture Switch",
+			      &alc_inv_dmic_sw))
 		return -ENOMEM;
 	spec->inv_dmic_fixup = 1;
 	spec->inv_dmic_muted = 0;
@@ -2550,13 +2550,9 @@ static int add_control(struct alc_spec *spec, int type, const char *name,
 {
 	struct snd_kcontrol_new *knew;
 
-	knew = alc_kcontrol_new(spec);
+	knew = alc_kcontrol_new(spec, name, &alc_control_templates[type]);
 	if (!knew)
 		return -ENOMEM;
-	*knew = alc_control_templates[type];
-	knew->name = kstrdup(name, GFP_KERNEL);
-	if (!knew->name)
-		return -ENOMEM;
 	knew->index = cidx;
 	if (get_amp_nid_(val))
 		knew->subdevice = HDA_SUBDEV_AMP_FLAG;
@@ -3999,14 +3995,8 @@ static int alc_auto_add_multi_channel_mode(struct hda_codec *codec)
 	struct alc_spec *spec = codec->spec;
 
 	if (spec->multi_ios > 0) {
-		struct snd_kcontrol_new *knew;
-
-		knew = alc_kcontrol_new(spec);
-		if (!knew)
-			return -ENOMEM;
-		*knew = alc_auto_channel_mode_enum;
-		knew->name = kstrdup("Channel Mode", GFP_KERNEL);
-		if (!knew->name)
+		if (!alc_kcontrol_new(spec, "Channel Mode",
+				      &alc_auto_channel_mode_enum))
 			return -ENOMEM;
 	}
 	return 0;
@@ -6064,7 +6054,6 @@ static const struct snd_kcontrol_new alc221_shared_fmic_hp_mode_enum = {
 static int alc221_add_shared_fmic_hp_mode(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	struct snd_kcontrol_new *knew;
 	char name[22];
 
 	if (spec->autocfg.hp_outs != 1 || spec->am_num_entries != 2)
@@ -6074,12 +6063,7 @@ static int alc221_add_shared_fmic_hp_mode(struct hda_codec *codec)
 			      name, sizeof(name), NULL);
 	strlcat(name, " Jack Mode", sizeof(name));
 
-	knew = alc_kcontrol_new(spec);
-	if (!knew)
-		return -ENOMEM;
-	*knew = alc221_shared_fmic_hp_mode_enum;
-	knew->name = kstrdup(name, GFP_KERNEL);
-	if (!knew->name)
+	if (!alc_kcontrol_new(spec, name, &alc221_shared_fmic_hp_mode_enum))
 		return -ENOMEM;
 	spec->shared_fmic_hp_nid = spec->am_entry[1].pin;
 	spec->shared_fmic_hp_mode = 0;
-- 
1.8.0.1
