From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 101/112] ALSA: hda - Add snd_hda_gen_free() and
	snd_hda_gen_check_power_status()
Date: Tue,  8 Jan 2013 12:39:34 +0100
Message-ID: <1357645185-7645-102-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FE7D265233
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id F366AA5394
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

Just to remove duplicated codes.
Also fixed EXPORT_SYMBOL() in hda_generic.c.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c   | 33 ++++++++++++++++++---------------
 sound/pci/hda/hda_generic.h   |  5 +++++
 sound/pci/hda/patch_realtek.c | 12 +-----------
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index a041032..78f210d 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3937,36 +3937,39 @@ int snd_hda_gen_init(struct hda_codec *codec)
 	hda_call_check_power_status(codec, 0x01);
 	return 0;
 }
-EXPORT_SYMBOL(snd_hda_gen_init);
+EXPORT_SYMBOL_HDA(snd_hda_gen_init);
 
 
-/*
- * the generic codec support
- */
+void snd_hda_gen_free(struct hda_codec *codec)
+{
+	snd_hda_gen_spec_free(codec->spec);
+	kfree(codec->spec);
+	codec->spec = NULL;
+}
+EXPORT_SYMBOL_HDA(snd_hda_gen_free);
 
 #ifdef CONFIG_PM
-static int generic_check_power_status(struct hda_codec *codec, hda_nid_t nid)
+int snd_hda_gen_check_power_status(struct hda_codec *codec, hda_nid_t nid)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	return snd_hda_check_amp_list_power(codec, &spec->loopback, nid);
 }
+EXPORT_SYMBOL_HDA(snd_hda_gen_check_power_status);
 #endif
 
-static void generic_free(struct hda_codec *codec)
-{
-	snd_hda_gen_spec_free(codec->spec);
-	kfree(codec->spec);
-	codec->spec = NULL;
-}
+
+/*
+ * the generic codec support
+ */
 
 static const struct hda_codec_ops generic_patch_ops = {
 	.build_controls = snd_hda_gen_build_controls,
 	.build_pcms = snd_hda_gen_build_pcms,
 	.init = snd_hda_gen_init,
-	.free = generic_free,
+	.free = snd_hda_gen_free,
 	.unsol_event = snd_hda_jack_unsol_event,
 #ifdef CONFIG_PM
-	.check_power_status = generic_check_power_status,
+	.check_power_status = snd_hda_gen_check_power_status,
 #endif
 };
 
@@ -3993,7 +3996,7 @@ int snd_hda_parse_generic_codec(struct hda_codec *codec)
 	return 0;
 
 error:
-	generic_free(codec);
+	snd_hda_gen_free(codec);
 	return err;
 }
-EXPORT_SYMBOL(snd_hda_parse_generic_codec);
+EXPORT_SYMBOL_HDA(snd_hda_parse_generic_codec);
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 7e84c22..00a1eab 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -218,6 +218,7 @@ int snd_hda_gen_spec_init(struct hda_gen_spec *spec);
 void snd_hda_gen_spec_free(struct hda_gen_spec *spec);
 
 int snd_hda_gen_init(struct hda_codec *codec);
+void snd_hda_gen_free(struct hda_codec *codec);
 
 struct nid_path *snd_hda_get_nid_path(struct hda_codec *codec,
 				      hda_nid_t from_nid, hda_nid_t to_nid);
@@ -257,4 +258,8 @@ void snd_hda_gen_mic_autoswitch(struct hda_codec *codec,
 				struct hda_jack_tbl *jack);
 void snd_hda_gen_update_outputs(struct hda_codec *codec);
 
+#ifdef CONFIG_PM
+int snd_hda_gen_check_power_status(struct hda_codec *codec, hda_nid_t nid);
+#endif
+
 #endif /* __SOUND_HDA_GENERIC_H */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1c343f2..ac0937f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -808,14 +808,6 @@ static int alc_init(struct hda_codec *codec)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int alc_check_power_status(struct hda_codec *codec, hda_nid_t nid)
-{
-	struct alc_spec *spec = codec->spec;
-	return snd_hda_check_amp_list_power(codec, &spec->gen.loopback, nid);
-}
-#endif
-
 static inline void alc_shutup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -876,10 +868,8 @@ static const struct hda_codec_ops alc_patch_ops = {
 	.unsol_event = snd_hda_jack_unsol_event,
 #ifdef CONFIG_PM
 	.resume = alc_resume,
-#endif
-#ifdef CONFIG_PM
 	.suspend = alc_suspend,
-	.check_power_status = alc_check_power_status,
+	.check_power_status = snd_hda_gen_check_power_status,
 #endif
 	.reboot_notify = alc_shutup,
 };
-- 
1.8.0.1
