From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/15] ALSA: hda/realtek - Call a common helper
	for alc_spec initialization
Date: Mon, 14 May 2012 17:31:52 +0200
Message-ID: <1337009526-26256-2-git-send-email-tiwai@suse.de>
References: <1337009526-26256-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 75C7224A27
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:18 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E58918C061
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:17 +0200 (CEST)
In-Reply-To: <1337009526-26256-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Just a clean up by calling the same helper function.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |  136 ++++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 75 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6dd1b74..ae9732c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4405,6 +4405,25 @@ static int alc_parse_auto_config(struct hda_codec *codec,
 	return 1;
 }
 
+/* common preparation job for alc_spec */
+static int alc_alloc_spec(struct hda_codec *codec, hda_nid_t mixer_nid)
+{
+	struct alc_spec *spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	int err;
+
+	if (!spec)
+		return -ENOMEM;
+	codec->spec = spec;
+	spec->mixer_nid = mixer_nid;
+
+	err = alc_codec_rename_from_preset(codec);
+	if (err < 0) {
+		kfree(spec);
+		return err;
+	}
+	return 0;
+}
+
 static int alc880_parse_auto_config(struct hda_codec *codec)
 {
 	static const hda_nid_t alc880_ignore[] = { 0x1d, 0 };
@@ -4786,13 +4805,11 @@ static int patch_alc880(struct hda_codec *codec)
 	struct alc_spec *spec;
 	int err;
 
-	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
-	if (spec == NULL)
-		return -ENOMEM;
-
-	codec->spec = spec;
+	err = alc_alloc_spec(codec, 0x0b);
+	if (err < 0)
+		return err;
 
-	spec->mixer_nid = 0x0b;
+	spec = codec->spec;
 	spec->need_dac_fix = 1;
 
 	alc_pick_fixup(codec, alc880_fixup_models, alc880_fixup_tbl,
@@ -4979,13 +4996,11 @@ static int patch_alc260(struct hda_codec *codec)
 	struct alc_spec *spec;
 	int err;
 
-	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
-	if (spec == NULL)
-		return -ENOMEM;
-
-	codec->spec = spec;
+	err = alc_alloc_spec(codec, 0x07);
+	if (err < 0)
+		return err;
 
-	spec->mixer_nid = 0x07;
+	spec = codec->spec;
 
 	alc_pick_fixup(codec, NULL, alc260_fixup_tbl, alc260_fixups);
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
@@ -5452,13 +5467,11 @@ static int patch_alc882(struct hda_codec *codec)
 	struct alc_spec *spec;
 	int err;
 
-	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
-	if (spec == NULL)
-		return -ENOMEM;
-
-	codec->spec = spec;
+	err = alc_alloc_spec(codec, 0x0b);
+	if (err < 0)
+		return err;
 
-	spec->mixer_nid = 0x0b;
+	spec = codec->spec;
 
 	switch (codec->vendor_id) {
 	case 0x10ec0882:
@@ -5470,10 +5483,6 @@ static int patch_alc882(struct hda_codec *codec)
 		break;
 	}
 
-	err = alc_codec_rename_from_preset(codec);
-	if (err < 0)
-		goto error;
-
 	alc_pick_fixup(codec, alc882_fixup_models, alc882_fixup_tbl,
 		       alc882_fixups);
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
@@ -5597,13 +5606,11 @@ static int patch_alc262(struct hda_codec *codec)
 	struct alc_spec *spec;
 	int err;
 
-	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
-	if (spec == NULL)
-		return -ENOMEM;
-
-	codec->spec = spec;
+	err = alc_alloc_spec(codec, 0x0b);
+	if (err < 0)
+		return err;
 
-	spec->mixer_nid = 0x0b;
+	spec = codec->spec;
 
 #if 0
 	/* pshou 07/11/05  set a zero PCM sample to DAC when FIFO is
@@ -5699,13 +5706,12 @@ static int patch_alc268(struct hda_codec *codec)
 	struct alc_spec *spec;
 	int i, has_beep, err;
 
-	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
-	if (spec == NULL)
-		return -ENOMEM;
-
-	codec->spec = spec;
-
 	/* ALC268 has no aa-loopback mixer */
+	err = alc_alloc_spec(codec, 0);
+	if (err < 0)
+		return err;
+
+	spec = codec->spec;
 
 	/* automatic parse from the BIOS config */
 	err = alc268_parse_auto_config(codec);
@@ -6216,19 +6222,13 @@ static void alc269_fill_coef(struct hda_codec *codec)
 static int patch_alc269(struct hda_codec *codec)
 {
 	struct alc_spec *spec;
-	int err = 0;
-
-	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
-	if (spec == NULL)
-		return -ENOMEM;
-
-	codec->spec = spec;
-
-	spec->mixer_nid = 0x0b;
+	int err;
 
-	err = alc_codec_rename_from_preset(codec);
+	err = alc_alloc_spec(codec, 0x0b);
 	if (err < 0)
-		goto error;
+		return err;
+
+	spec = codec->spec;
 
 	if (codec->vendor_id == 0x10ec0269) {
 		spec->codec_variant = ALC269_TYPE_ALC269VA;
@@ -6374,13 +6374,11 @@ static int patch_alc861(struct hda_codec *codec)
 	struct alc_spec *spec;
 	int err;
 
-	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
-	if (spec == NULL)
-		return -ENOMEM;
-
-	codec->spec = spec;
+	err = alc_alloc_spec(codec, 0x15);
+	if (err < 0)
+		return err;
 
-	spec->mixer_nid = 0x15;
+	spec = codec->spec;
 
 	alc_pick_fixup(codec, NULL, alc861_fixup_tbl, alc861_fixups);
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
@@ -6477,13 +6475,11 @@ static int patch_alc861vd(struct hda_codec *codec)
 	struct alc_spec *spec;
 	int err;
 
-	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
-	if (spec == NULL)
-		return -ENOMEM;
-
-	codec->spec = spec;
+	err = alc_alloc_spec(codec, 0x0b);
+	if (err < 0)
+		return err;
 
-	spec->mixer_nid = 0x0b;
+	spec = codec->spec;
 
 	alc_pick_fixup(codec, NULL, alc861vd_fixup_tbl, alc861vd_fixups);
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
@@ -6822,25 +6818,19 @@ static const struct alc_model_fixup alc662_fixup_models[] = {
 static int patch_alc662(struct hda_codec *codec)
 {
 	struct alc_spec *spec;
-	int err = 0;
-
-	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
-	if (!spec)
-		return -ENOMEM;
+	int err;
 
-	codec->spec = spec;
+	err = alc_alloc_spec(codec, 0x0b);
+	if (err < 0)
+		return err;
 
-	spec->mixer_nid = 0x0b;
+	spec = codec->spec;
 
 	/* handle multiple HPs as is */
 	spec->parse_flags = HDA_PINCFG_NO_HP_FIXUP;
 
 	alc_fix_pll_init(codec, 0x20, 0x04, 15);
 
-	err = alc_codec_rename_from_preset(codec);
-	if (err < 0)
-		goto error;
-
 	if ((alc_get_coef0(codec) & (1 << 14)) &&
 	    codec->bus->pci->subsystem_vendor == 0x1025 &&
 	    spec->cdefine.platform_type == 1) {
@@ -6903,16 +6893,12 @@ static int alc680_parse_auto_config(struct hda_codec *codec)
  */
 static int patch_alc680(struct hda_codec *codec)
 {
-	struct alc_spec *spec;
 	int err;
 
-	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
-	if (spec == NULL)
-		return -ENOMEM;
-
-	codec->spec = spec;
-
 	/* ALC680 has no aa-loopback mixer */
+	err = alc_alloc_spec(codec, 0);
+	if (err < 0)
+		return err;
 
 	/* automatic parse from the BIOS config */
 	err = alc680_parse_auto_config(codec);
-- 
1.7.9.2
