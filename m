From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 040/112] ALSA: hda/realtek - Add conexant-style
	inverted dmic handling
Date: Tue,  8 Jan 2013 12:38:33 +0100
Message-ID: <1357645185-7645-41-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E83B2651C0
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id C1A52A5239
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

To make the parser more generic, a few codes to handle the inverted
stereo dmic in a way Conexant parser does is added in this patch.

The caller should set spec->inv_dmic_split flag appropriately.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2295389..558bd6d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -184,6 +184,7 @@ struct alc_spec {
 	int int_mic_idx, ext_mic_idx, dock_mic_idx; /* for auto-mic */
 	hda_nid_t inv_dmic_pin;
 	hda_nid_t shared_mic_vref_pin;
+	int inv_dmic_split_idx;	/* used internally for inv_dmic_split */
 
 	/* DAC list */
 	int num_all_dacs;
@@ -222,6 +223,7 @@ struct alc_spec {
 	unsigned int inv_dmic_muted:1; /* R-ch of inv d-mic is muted? */
 	unsigned int no_primary_hp:1; /* Don't prefer HP pins to speaker pins */
 	unsigned int multi_cap_vol:1; /* allow multiple capture xxx volumes */
+	unsigned int inv_dmic_split:1; /* inverted dmic w/a for conexant */
 
 	unsigned int parse_flags; /* passed to snd_hda_parse_pin_defcfg() */
 
@@ -2550,6 +2552,8 @@ static int parse_capvol_in_path(struct hda_codec *codec, struct nid_path *path)
 	return 0;
 }
 
+static unsigned int amp_val_replace_channels(unsigned int val, unsigned int chs);
+
 static int add_single_cap_ctl(struct hda_codec *codec, const char *label,
 			      int idx, bool is_switch, unsigned int ctl)
 {
@@ -2557,17 +2561,37 @@ static int add_single_cap_ctl(struct hda_codec *codec, const char *label,
 	char tmpname[44];
 	int type = is_switch ? ALC_CTL_WIDGET_MUTE : ALC_CTL_WIDGET_VOL;
 	const char *sfx = is_switch ? "Switch" : "Volume";
+	unsigned int chs;
+	int err;
 
 	if (!ctl)
 		return 0;
 
+	if (idx == spec->inv_dmic_split_idx)
+		chs = 1;
+	else
+		chs = 3;
+
 	if (label)
 		snprintf(tmpname, sizeof(tmpname),
 			 "%s Capture %s", label, sfx);
 	else
 		snprintf(tmpname, sizeof(tmpname),
 			 "Capture %s", sfx);
-	return add_control(spec, type, tmpname, idx, ctl);
+	err = add_control(spec, type, tmpname, idx,
+			  amp_val_replace_channels(ctl, chs));
+	if (err < 0 || chs == 3)
+		return err;
+
+	/* Make independent right kcontrol */
+	if (label)
+		snprintf(tmpname, sizeof(tmpname),
+			 "Inverted %s Capture %s", label, sfx);
+	else
+		snprintf(tmpname, sizeof(tmpname),
+			 "Inverted Capture %s", sfx);
+	return add_control(spec, type, tmpname, idx,
+			   amp_val_replace_channels(ctl, 2));
 }
 
 /* create single (and simple) capture volume and switch controls */
@@ -2730,6 +2754,7 @@ static int alc_auto_create_input_ctls(struct hda_codec *codec)
 	if (num_adcs < 0)
 		return 0;
 
+	spec->inv_dmic_split_idx = -1;
 	for (i = 0; i < cfg->num_inputs; i++) {
 		hda_nid_t pin;
 		const char *label;
@@ -2783,6 +2808,14 @@ static int alc_auto_create_input_ctls(struct hda_codec *codec)
 				imux_added = true;
 			}
 		}
+
+		if (spec->inv_dmic_split) {
+			if (cfg->inputs[i].type == AUTO_PIN_MIC) {
+				unsigned int def_conf = snd_hda_codec_get_pincfg(codec, pin);
+				if (snd_hda_get_input_pin_attr(def_conf) == INPUT_PIN_ATTR_INT)
+					spec->inv_dmic_split_idx = i;
+			}
+		}
 	}
 
 	return 0;
-- 
1.8.0.1
