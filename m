From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 33/38] ALSA: hda/realtek - Parse aa-loopback
	items dynamically
Date: Fri, 24 Feb 2012 17:36:26 +0100
Message-ID: <1330101391-8788-34-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AC8710B8BE
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id ABCBA9290E
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
In-Reply-To: <1330101391-8788-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Similarly in patch_via.c, parse the active analog-loopback connections
and create a list dynamically rather than static arrays.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |  104 +++++++++--------------------------------
 1 files changed, 22 insertions(+), 82 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c5216b5..eba50df 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -200,6 +200,8 @@ struct alc_spec {
 	hda_nid_t vmaster_nid;
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	struct hda_loopback_check loopback;
+	int num_loopbacks;
+	struct hda_amp_list loopback_list[8];
 #endif
 
 	/* for PLL fix */
@@ -2690,6 +2692,25 @@ static const char *alc_get_line_out_pfx(struct alc_spec *spec, int ch,
 	return channel_name[ch];
 }
 
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+/* add the powersave loopback-list entry */
+static void add_loopback_list(struct alc_spec *spec, hda_nid_t mix, int idx)
+{
+	struct hda_amp_list *list;
+
+	if (spec->num_loopbacks >= ARRAY_SIZE(spec->loopback_list) - 1)
+		return;
+	list = spec->loopback_list + spec->num_loopbacks;
+	list->nid = mix;
+	list->dir = HDA_INPUT;
+	list->idx = idx;
+	spec->num_loopbacks++;
+	spec->loopback.amplist = spec->loopback_list;
+}
+#else
+#define add_loopback_list(spec, mix, idx) /* NOP */
+#endif
+
 /* create input playback/capture controls for the given pin */
 static int new_analog_input(struct alc_spec *spec, hda_nid_t pin,
 			    const char *ctlname, int ctlidx,
@@ -2705,6 +2726,7 @@ static int new_analog_input(struct alc_spec *spec, hda_nid_t pin,
 			  HDA_COMPOSE_AMP_VAL(mix_nid, 3, idx, HDA_INPUT));
 	if (err < 0)
 		return err;
+	add_loopback_list(spec, mix_nid, idx);
 	return 0;
 }
 
@@ -4430,17 +4452,6 @@ static int alc880_parse_auto_config(struct hda_codec *codec)
 	return alc_parse_auto_config(codec, alc880_ignore, alc880_ssids);
 }
 
-#ifdef CONFIG_SND_HDA_POWER_SAVE
-static const struct hda_amp_list alc880_loopbacks[] = {
-	{ 0x0b, HDA_INPUT, 0 },
-	{ 0x0b, HDA_INPUT, 1 },
-	{ 0x0b, HDA_INPUT, 2 },
-	{ 0x0b, HDA_INPUT, 3 },
-	{ 0x0b, HDA_INPUT, 4 },
-	{ } /* end */
-};
-#endif
-
 /*
  * ALC880 fix-ups
  */
@@ -4851,10 +4862,6 @@ static int patch_alc880(struct hda_codec *codec)
 
 	codec->patch_ops = alc_patch_ops;
 	spec->init_hook = alc_auto_init_std;
-#ifdef CONFIG_SND_HDA_POWER_SAVE
-	if (!spec->loopback.amplist)
-		spec->loopback.amplist = alc880_loopbacks;
-#endif
 
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
 
@@ -4876,17 +4883,6 @@ static int alc260_parse_auto_config(struct hda_codec *codec)
 	return alc_parse_auto_config(codec, alc260_ignore, alc260_ssids);
 }
 
-#ifdef CONFIG_SND_HDA_POWER_SAVE
-static const struct hda_amp_list alc260_loopbacks[] = {
-	{ 0x07, HDA_INPUT, 0 },
-	{ 0x07, HDA_INPUT, 1 },
-	{ 0x07, HDA_INPUT, 2 },
-	{ 0x07, HDA_INPUT, 3 },
-	{ 0x07, HDA_INPUT, 4 },
-	{ } /* end */
-};
-#endif
-
 /*
  * Pin config fixes
  */
@@ -5032,10 +5028,6 @@ static int patch_alc260(struct hda_codec *codec)
 	codec->patch_ops = alc_patch_ops;
 	spec->init_hook = alc_auto_init_std;
 	spec->shutup = alc_eapd_shutup;
-#ifdef CONFIG_SND_HDA_POWER_SAVE
-	if (!spec->loopback.amplist)
-		spec->loopback.amplist = alc260_loopbacks;
-#endif
 
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
 
@@ -5058,9 +5050,6 @@ static int patch_alc260(struct hda_codec *codec)
  * In addition, an independent DAC for the multi-playback (not used in this
  * driver yet).
  */
-#ifdef CONFIG_SND_HDA_POWER_SAVE
-#define alc882_loopbacks	alc880_loopbacks
-#endif
 
 /*
  * Pin config fixes
@@ -5507,11 +5496,6 @@ static int patch_alc882(struct hda_codec *codec)
 	codec->patch_ops = alc_patch_ops;
 	spec->init_hook = alc_auto_init_std;
 
-#ifdef CONFIG_SND_HDA_POWER_SAVE
-	if (!spec->loopback.amplist)
-		spec->loopback.amplist = alc882_loopbacks;
-#endif
-
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
 
 	return 0;
@@ -5608,10 +5592,6 @@ static const struct snd_pci_quirk alc262_fixup_tbl[] = {
 };
 
 
-#ifdef CONFIG_SND_HDA_POWER_SAVE
-#define alc262_loopbacks	alc880_loopbacks
-#endif
-
 /*
  */
 static int patch_alc262(struct hda_codec *codec)
@@ -5671,11 +5651,6 @@ static int patch_alc262(struct hda_codec *codec)
 	spec->init_hook = alc_auto_init_std;
 	spec->shutup = alc_eapd_shutup;
 
-#ifdef CONFIG_SND_HDA_POWER_SAVE
-	if (!spec->loopback.amplist)
-		spec->loopback.amplist = alc262_loopbacks;
-#endif
-
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
 
 	return 0;
@@ -5793,10 +5768,6 @@ static int patch_alc268(struct hda_codec *codec)
 /*
  * ALC269
  */
-#ifdef CONFIG_SND_HDA_POWER_SAVE
-#define alc269_loopbacks	alc880_loopbacks
-#endif
-
 static const struct hda_pcm_stream alc269_44k_pcm_analog_playback = {
 	.substreams = 1,
 	.channels_min = 2,
@@ -6336,8 +6307,6 @@ static int patch_alc269(struct hda_codec *codec)
 	spec->shutup = alc269_shutup;
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE
-	if (!spec->loopback.amplist)
-		spec->loopback.amplist = alc269_loopbacks;
 	if (alc269_mic2_for_mute_led(codec))
 		codec->patch_ops.check_power_status = alc269_mic2_mute_check_ps;
 #endif
@@ -6362,17 +6331,6 @@ static int alc861_parse_auto_config(struct hda_codec *codec)
 	return alc_parse_auto_config(codec, alc861_ignore, alc861_ssids);
 }
 
-#ifdef CONFIG_SND_HDA_POWER_SAVE
-static const struct hda_amp_list alc861_loopbacks[] = {
-	{ 0x15, HDA_INPUT, 0 },
-	{ 0x15, HDA_INPUT, 1 },
-	{ 0x15, HDA_INPUT, 2 },
-	{ 0x15, HDA_INPUT, 3 },
-	{ } /* end */
-};
-#endif
-
-
 /* Pin config fixes */
 enum {
 	ALC861_FIXUP_FSC_AMILO_PI1505,
@@ -6486,8 +6444,6 @@ static int patch_alc861(struct hda_codec *codec)
 	spec->init_hook = alc_auto_init_std;
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	spec->power_hook = alc_power_eapd;
-	if (!spec->loopback.amplist)
-		spec->loopback.amplist = alc861_loopbacks;
 #endif
 
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
@@ -6506,10 +6462,6 @@ static int patch_alc861(struct hda_codec *codec)
  *
  * In addition, an independent DAC
  */
-#ifdef CONFIG_SND_HDA_POWER_SAVE
-#define alc861vd_loopbacks	alc880_loopbacks
-#endif
-
 static int alc861vd_parse_auto_config(struct hda_codec *codec)
 {
 	static const hda_nid_t alc861vd_ignore[] = { 0x1d, 0 };
@@ -6610,10 +6562,6 @@ static int patch_alc861vd(struct hda_codec *codec)
 
 	spec->init_hook = alc_auto_init_std;
 	spec->shutup = alc_eapd_shutup;
-#ifdef CONFIG_SND_HDA_POWER_SAVE
-	if (!spec->loopback.amplist)
-		spec->loopback.amplist = alc861vd_loopbacks;
-#endif
 
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
 
@@ -6635,9 +6583,6 @@ static int patch_alc861vd(struct hda_codec *codec)
  * In addition, an independent DAC for the multi-playback (not used in this
  * driver yet).
  */
-#ifdef CONFIG_SND_HDA_POWER_SAVE
-#define alc662_loopbacks	alc880_loopbacks
-#endif
 
 /*
  * BIOS auto configuration
@@ -6999,11 +6944,6 @@ static int patch_alc662(struct hda_codec *codec)
 	spec->init_hook = alc_auto_init_std;
 	spec->shutup = alc_eapd_shutup;
 
-#ifdef CONFIG_SND_HDA_POWER_SAVE
-	if (!spec->loopback.amplist)
-		spec->loopback.amplist = alc662_loopbacks;
-#endif
-
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
 
 	return 0;
-- 
1.7.9
