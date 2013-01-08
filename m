From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 015/112] ALSA: hda - Introduce
	snd_hda_codec_amp_init*()
Date: Tue,  8 Jan 2013 12:38:08 +0100
Message-ID: <1357645185-7645-16-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B6F5226518A
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 315DEA5202
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

The new function snd_hda_codec_amp_init() (and the stereo variant)
initializes the amp value only once at the first access.  If the amp
was already initialized or updated, this won't do anything more.

It's useful for initializing the input amps that are in the part of
the path but never used.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 71 ++++++++++++++++++++++++++++++++++-------------
 sound/pci/hda/hda_local.h |  4 +++
 2 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 3aa20dc..7383746 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1765,7 +1765,7 @@ EXPORT_SYMBOL_HDA(snd_hda_override_pin_caps);
  */
 static struct hda_amp_info *
 update_amp_hash(struct hda_codec *codec, hda_nid_t nid, int ch,
-		int direction, int index)
+		int direction, int index, bool init_only)
 {
 	struct hda_amp_info *info;
 	unsigned int parm, val = 0;
@@ -1791,7 +1791,8 @@ update_amp_hash(struct hda_codec *codec, hda_nid_t nid, int ch,
 		}
 		info->vol[ch] = val;
 		info->head.val |= INFO_AMP_VOL(ch);
-	}
+	} else if (init_only)
+		return NULL;
 	return info;
 }
 
@@ -1832,7 +1833,7 @@ int snd_hda_codec_amp_read(struct hda_codec *codec, hda_nid_t nid, int ch,
 	unsigned int val = 0;
 
 	mutex_lock(&codec->hash_mutex);
-	info = update_amp_hash(codec, nid, ch, direction, index);
+	info = update_amp_hash(codec, nid, ch, direction, index, false);
 	if (info)
 		val = info->vol[ch];
 	mutex_unlock(&codec->hash_mutex);
@@ -1840,21 +1841,9 @@ int snd_hda_codec_amp_read(struct hda_codec *codec, hda_nid_t nid, int ch,
 }
 EXPORT_SYMBOL_HDA(snd_hda_codec_amp_read);
 
-/**
- * snd_hda_codec_amp_update - update the AMP value
- * @codec: HD-audio codec
- * @nid: NID to read the AMP value
- * @ch: channel (left=0 or right=1)
- * @direction: #HDA_INPUT or #HDA_OUTPUT
- * @idx: the index value (only for input direction)
- * @mask: bit mask to set
- * @val: the bits value to set
- *
- * Update the AMP value with a bit mask.
- * Returns 0 if the value is unchanged, 1 if changed.
- */
-int snd_hda_codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
-			     int direction, int idx, int mask, int val)
+static int codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
+			    int direction, int idx, int mask, int val,
+			    bool init_only)
 {
 	struct hda_amp_info *info;
 
@@ -1863,7 +1852,7 @@ int snd_hda_codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
 	val &= mask;
 
 	mutex_lock(&codec->hash_mutex);
-	info = update_amp_hash(codec, nid, ch, direction, idx);
+	info = update_amp_hash(codec, nid, ch, direction, idx, init_only);
 	if (!info) {
 		mutex_unlock(&codec->hash_mutex);
 		return 0;
@@ -1881,6 +1870,25 @@ int snd_hda_codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
 		put_vol_mute(codec, info, nid, ch, direction, idx, val);
 	return 1;
 }
+
+/**
+ * snd_hda_codec_amp_update - update the AMP value
+ * @codec: HD-audio codec
+ * @nid: NID to read the AMP value
+ * @ch: channel (left=0 or right=1)
+ * @direction: #HDA_INPUT or #HDA_OUTPUT
+ * @idx: the index value (only for input direction)
+ * @mask: bit mask to set
+ * @val: the bits value to set
+ *
+ * Update the AMP value with a bit mask.
+ * Returns 0 if the value is unchanged, 1 if changed.
+ */
+int snd_hda_codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
+			     int direction, int idx, int mask, int val)
+{
+	return codec_amp_update(codec, nid, ch, direction, idx, mask, val, false);
+}
 EXPORT_SYMBOL_HDA(snd_hda_codec_amp_update);
 
 /**
@@ -1909,6 +1917,31 @@ int snd_hda_codec_amp_stereo(struct hda_codec *codec, hda_nid_t nid,
 }
 EXPORT_SYMBOL_HDA(snd_hda_codec_amp_stereo);
 
+/* Works like snd_hda_codec_amp_update() but it writes the value only at
+ * the first access.  If the amp was already initialized / updated beforehand,
+ * this does nothing.
+ */
+int snd_hda_codec_amp_init(struct hda_codec *codec, hda_nid_t nid, int ch,
+			   int dir, int idx, int mask, int val)
+{
+	return codec_amp_update(codec, nid, ch, dir, idx, mask, val, true);
+}
+EXPORT_SYMBOL_HDA(snd_hda_codec_amp_init);
+
+int snd_hda_codec_amp_init_stereo(struct hda_codec *codec, hda_nid_t nid,
+				  int dir, int idx, int mask, int val)
+{
+	int ch, ret = 0;
+
+	if (snd_BUG_ON(mask & ~0xff))
+		mask &= 0xff;
+	for (ch = 0; ch < 2; ch++)
+		ret |= snd_hda_codec_amp_init(codec, nid, ch, dir,
+					      idx, mask, val);
+	return ret;
+}
+EXPORT_SYMBOL_HDA(snd_hda_codec_amp_init_stereo);
+
 /**
  * snd_hda_codec_resume_amp - Resume all AMP commands from the cache
  * @codec: HD-audio codec
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index f765296..e38519b 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -133,6 +133,10 @@ int snd_hda_codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
 			     int direction, int idx, int mask, int val);
 int snd_hda_codec_amp_stereo(struct hda_codec *codec, hda_nid_t nid,
 			     int dir, int idx, int mask, int val);
+int snd_hda_codec_amp_init(struct hda_codec *codec, hda_nid_t nid, int ch,
+			   int direction, int idx, int mask, int val);
+int snd_hda_codec_amp_init_stereo(struct hda_codec *codec, hda_nid_t nid,
+				  int dir, int idx, int mask, int val);
 void snd_hda_codec_resume_amp(struct hda_codec *codec);
 
 void snd_hda_set_vmaster_tlv(struct hda_codec *codec, hda_nid_t nid, int dir,
-- 
1.8.0.1
