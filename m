From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/6] ALSA: hda/realtek - Optimize
	alc888_coef_init()
Date: Mon, 18 Aug 2014 17:30:30 +0200
Message-ID: <1408375833-22957-4-git-send-email-tiwai@suse.de>
References: <1408375833-22957-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E502265761
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 17:30:36 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DDB95AD2F
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 15:30:35 +0000 (UTC)
In-Reply-To: <1408375833-22957-1-git-send-email-tiwai@suse.de>
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

Just a refactoring using the existing helper functions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 91 +++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 51 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b32ce086d2e0..35f5012fc419 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -129,6 +129,43 @@ struct alc_spec {
 };
 
 /*
+ * COEF access helper functions
+ */
+
+static int alc_read_coefex_idx(struct hda_codec *codec, hda_nid_t nid,
+			       unsigned int coef_idx)
+{
+	unsigned int val;
+
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX, coef_idx);
+	val = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_PROC_COEF, 0);
+	return val;
+}
+
+#define alc_read_coef_idx(codec, coef_idx) \
+	alc_read_coefex_idx(codec, 0x20, coef_idx)
+
+static void alc_write_coefex_idx(struct hda_codec *codec, hda_nid_t nid,
+				 unsigned int coef_idx, unsigned int coef_val)
+{
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX, coef_idx);
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_PROC_COEF, coef_val);
+}
+
+#define alc_write_coef_idx(codec, coef_idx, coef_val) \
+	alc_write_coefex_idx(codec, 0x20, coef_idx, coef_val)
+
+/* a special bypass for COEF 0; read the cached value at the second time */
+static unsigned int alc_get_coef0(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (!spec->coef0)
+		spec->coef0 = alc_read_coef_idx(codec, 0);
+	return spec->coef0;
+}
+
+/*
  * Append the given mixer and verb elements for the later use
  * The mixer array is referred in build_controls(), and init_verbs are
  * called in init().
@@ -231,19 +268,12 @@ static void alc880_unsol_event(struct hda_codec *codec, unsigned int res)
 /* additional initialization for ALC888 variants */
 static void alc888_coef_init(struct hda_codec *codec)
 {
-	unsigned int tmp;
-
-	snd_hda_codec_write(codec, 0x20, 0, AC_VERB_SET_COEF_INDEX, 0);
-	tmp = snd_hda_codec_read(codec, 0x20, 0, AC_VERB_GET_PROC_COEF, 0);
-	snd_hda_codec_write(codec, 0x20, 0, AC_VERB_SET_COEF_INDEX, 7);
-	if ((tmp & 0xf0) == 0x20)
+	if (alc_get_coef0(codec) == 0x20)
 		/* alc888S-VC */
-		snd_hda_codec_read(codec, 0x20, 0,
-				   AC_VERB_SET_PROC_COEF, 0x830);
+		alc_write_coef_idx(codec, 7, 0x830);
 	 else
 		 /* alc888-VB */
-		 snd_hda_codec_read(codec, 0x20, 0,
-				    AC_VERB_SET_PROC_COEF, 0x3030);
+		alc_write_coef_idx(codec, 7, 0x3030);
 }
 
 /* additional initialization for ALC889 variants */
@@ -587,47 +617,6 @@ static void alc_ssid_check(struct hda_codec *codec, const hda_nid_t *ports)
 }
 
 /*
- * COEF access helper functions
- */
-
-static int alc_read_coefex_idx(struct hda_codec *codec,
-					hda_nid_t nid,
-					unsigned int coef_idx)
-{
-	unsigned int val;
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX,
-		    		coef_idx);
-	val = snd_hda_codec_read(codec, nid, 0,
-			 	AC_VERB_GET_PROC_COEF, 0);
-	return val;
-}
-
-#define alc_read_coef_idx(codec, coef_idx) \
-	alc_read_coefex_idx(codec, 0x20, coef_idx)
-
-static void alc_write_coefex_idx(struct hda_codec *codec, hda_nid_t nid,
-							unsigned int coef_idx,
-							unsigned int coef_val)
-{
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX,
-			    coef_idx);
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_PROC_COEF,
-			    coef_val);
-}
-
-#define alc_write_coef_idx(codec, coef_idx, coef_val) \
-	alc_write_coefex_idx(codec, 0x20, coef_idx, coef_val)
-
-/* a special bypass for COEF 0; read the cached value at the second time */
-static unsigned int alc_get_coef0(struct hda_codec *codec)
-{
-	struct alc_spec *spec = codec->spec;
-	if (!spec->coef0)
-		spec->coef0 = alc_read_coef_idx(codec, 0);
-	return spec->coef0;
-}
-
-/*
  */
 
 static hda_nid_t get_adc_nid(struct hda_codec *codec, int adc_idx, int imux_idx)
-- 
2.0.4
