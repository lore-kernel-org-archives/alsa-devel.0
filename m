From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 038/112] ALSA: hda/realtek - Allow passing
	name=NULL to alc_kcontrol_new()
Date: Tue,  8 Jan 2013 12:38:31 +0100
Message-ID: <1357645185-7645-39-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EC662651B9
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id BAF1BA5234
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
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

This prevents stupid typos.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7f4ad78..4253b9a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -862,7 +862,10 @@ alc_kcontrol_new(struct alc_spec *spec, const char *name,
 	if (!knew)
 		return NULL;
 	*knew = *temp;
-	knew->name = kstrdup(name, GFP_KERNEL);
+	if (name)
+		knew->name = kstrdup(name, GFP_KERNEL);
+	else if (knew->name)
+		knew->name = kstrdup(knew->name, GFP_KERNEL);
 	if (!knew->name)
 		return NULL;
 	return knew;
@@ -872,7 +875,7 @@ static int alc_add_automute_mode_enum(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 
-	if (!alc_kcontrol_new(spec, "Auto-Mute Mode", &alc_automute_mode_enum))
+	if (!alc_kcontrol_new(spec, NULL, &alc_automute_mode_enum))
 		return -ENOMEM;
 	return 0;
 }
@@ -1556,6 +1559,7 @@ static int alc_inv_dmic_sw_put(struct snd_kcontrol *kcontrol,
 
 static const struct snd_kcontrol_new alc_inv_dmic_sw = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Inverted Internal Mic Capture Switch",
 	.info = snd_ctl_boolean_mono_info,
 	.get = alc_inv_dmic_sw_get,
 	.put = alc_inv_dmic_sw_put,
@@ -1565,8 +1569,7 @@ static int alc_add_inv_dmic_mixer(struct hda_codec *codec, hda_nid_t nid)
 {
 	struct alc_spec *spec = codec->spec;
 
-	if (!alc_kcontrol_new(spec, "Inverted Internal Mic Capture Switch",
-			      &alc_inv_dmic_sw))
+	if (!alc_kcontrol_new(spec, NULL, &alc_inv_dmic_sw))
 		return -ENOMEM;
 	spec->inv_dmic_fixup = 1;
 	spec->inv_dmic_muted = 0;
@@ -2555,7 +2558,7 @@ static int create_capture_mixers(struct hda_codec *codec)
 		nums = spec->num_adc_nids;
 
 	if (!spec->auto_mic && imux->num_items > 1) {
-		knew = alc_kcontrol_new(spec, "Input Source", &cap_src_temp);
+		knew = alc_kcontrol_new(spec, NULL, &cap_src_temp);
 		if (!knew)
 			return -ENOMEM;
 		knew->count = nums;
@@ -2579,8 +2582,7 @@ static int create_capture_mixers(struct hda_codec *codec)
 		}
 
 		if (vol) {
-			knew = alc_kcontrol_new(spec, "Capture Volume",
-						&cap_vol_temp);
+			knew = alc_kcontrol_new(spec, NULL, &cap_vol_temp);
 			if (!knew)
 				return -ENOMEM;
 			knew->index = n;
@@ -2588,8 +2590,7 @@ static int create_capture_mixers(struct hda_codec *codec)
 			knew->subdevice = HDA_SUBDEV_AMP_FLAG;
 		}
 		if (sw) {
-			knew = alc_kcontrol_new(spec, "Capture Switch",
-						&cap_sw_temp);
+			knew = alc_kcontrol_new(spec, NULL, &cap_sw_temp);
 			if (!knew)
 				return -ENOMEM;
 			knew->index = n;
@@ -4106,8 +4107,7 @@ static int alc_auto_add_multi_channel_mode(struct hda_codec *codec)
 	struct alc_spec *spec = codec->spec;
 
 	if (spec->multi_ios > 0) {
-		if (!alc_kcontrol_new(spec, "Channel Mode",
-				      &alc_auto_channel_mode_enum))
+		if (!alc_kcontrol_new(spec, NULL, &alc_auto_channel_mode_enum))
 			return -ENOMEM;
 	}
 	return 0;
-- 
1.8.0.1
