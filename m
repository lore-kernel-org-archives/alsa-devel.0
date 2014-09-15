From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC v2 3/7] ALSA: hda - Make
	snd_hda_jack_detect_enable_callback() returning the jack object
Date: Mon, 15 Sep 2014 14:48:19 +0200
Message-ID: <1410785303-19454-4-git-send-email-tiwai@suse.de>
References: <1410785303-19454-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 51BA2261692
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 14:48:27 +0200 (CEST)
In-Reply-To: <1410785303-19454-1-git-send-email-tiwai@suse.de>
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

STAC/IDT driver calls snd_hda_jack_tbl_get() again after calling
snd_hda_jack_detect_enable_callback().  For simplifying this, let's
make snd_hda_jack_detect_enable_callback() returning the pointer while
handling the error with the standard IS_ERR() & co.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_jack.c       | 24 +++++++++++++++++-------
 sound/pci/hda/hda_jack.h       |  5 +++--
 sound/pci/hda/patch_sigmatel.c | 14 ++++++--------
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 7f332794993f..a5fe1b428015 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -214,29 +214,39 @@ EXPORT_SYMBOL_GPL(snd_hda_jack_detect_state);
 
 /**
  * snd_hda_jack_detect_enable - enable the jack-detection
+ *
+ * In the case of error, the return value will be a pointer embedded with
+ * errno.  Check and handle the return value appropriately with standard
+ * macros such as @IS_ERR() and @PTR_ERR().
  */
-int snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
-					hda_jack_callback cb)
+struct hda_jack_tbl *
+snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
+				    hda_jack_callback cb)
 {
 	struct hda_jack_tbl *jack = snd_hda_jack_tbl_new(codec, nid);
+	int err;
+
 	if (!jack)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	if (jack->jack_detect)
-		return 0; /* already registered */
+		return jack; /* already registered */
 	jack->jack_detect = 1;
 	if (cb)
 		jack->callback = cb;
 	if (codec->jackpoll_interval > 0)
-		return 0; /* No unsol if we're polling instead */
-	return snd_hda_codec_write_cache(codec, nid, 0,
+		return jack; /* No unsol if we're polling instead */
+	err = snd_hda_codec_write_cache(codec, nid, 0,
 					 AC_VERB_SET_UNSOLICITED_ENABLE,
 					 AC_USRSP_EN | jack->tag);
+	if (err < 0)
+		return ERR_PTR(err);
+	return jack;
 }
 EXPORT_SYMBOL_GPL(snd_hda_jack_detect_enable_callback);
 
 int snd_hda_jack_detect_enable(struct hda_codec *codec, hda_nid_t nid)
 {
-	return snd_hda_jack_detect_enable_callback(codec, nid, NULL);
+	return PTR_ERR_OR_ZERO(snd_hda_jack_detect_enable_callback(codec, nid, NULL));
 }
 EXPORT_SYMBOL_GPL(snd_hda_jack_detect_enable);
 
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index 67f42db9c89c..668669ce3e52 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -47,8 +47,9 @@ void snd_hda_jack_tbl_clear(struct hda_codec *codec);
 void snd_hda_jack_set_dirty_all(struct hda_codec *codec);
 
 int snd_hda_jack_detect_enable(struct hda_codec *codec, hda_nid_t nid);
-int snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
-					hda_jack_callback cb);
+struct hda_jack_tbl *
+snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
+				    hda_jack_callback cb);
 
 int snd_hda_jack_set_gating_jack(struct hda_codec *codec, hda_nid_t gated_nid,
 				 hda_nid_t gating_nid);
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index bc371cfb5d84..4b338beb9449 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -3019,10 +3019,9 @@ static void stac92hd71bxx_fixup_hp_m4(struct hda_codec *codec,
 	/* Enable VREF power saving on GPIO1 detect */
 	snd_hda_codec_write_cache(codec, codec->afg, 0,
 				  AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x02);
-	snd_hda_jack_detect_enable_callback(codec, codec->afg,
-					    stac_vref_event);
-	jack = snd_hda_jack_tbl_get(codec, codec->afg);
-	if (jack)
+	jack = snd_hda_jack_detect_enable_callback(codec, codec->afg,
+						   stac_vref_event);
+	if (!IS_ERR(jack))
 		jack->private_data = 0x02;
 
 	spec->gpio_mask |= 0x02;
@@ -4042,10 +4041,9 @@ static void stac9205_fixup_dell_m43(struct hda_codec *codec,
 		/* Enable unsol response for GPIO4/Dock HP connection */
 		snd_hda_codec_write_cache(codec, codec->afg, 0,
 			AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x10);
-		snd_hda_jack_detect_enable_callback(codec, codec->afg,
-						    stac_vref_event);
-		jack = snd_hda_jack_tbl_get(codec, codec->afg);
-		if (jack)
+		jack = snd_hda_jack_detect_enable_callback(codec, codec->afg,
+							   stac_vref_event);
+		if (!IS_ERR(jack))
 			jack->private_data = 0x01;
 
 		spec->gpio_dir = 0x0b;
-- 
2.1.0
