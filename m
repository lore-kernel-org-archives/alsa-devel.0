From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/7] ALSA: hda - Use regmap for amp accesses
Date: Fri, 27 Feb 2015 22:28:18 +0100
Message-ID: <1425072502-3204-4-git-send-email-tiwai@suse.de>
References: <1425072502-3204-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C9FA226516E
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 22:28:27 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 55E8BAB09
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 21:28:27 +0000 (UTC)
In-Reply-To: <1425072502-3204-1-git-send-email-tiwai@suse.de>
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

This patch converts the amp access functions to the regmap helpers.
The amp values were formerly cached in the own hash table.  Now it's
dropped by the regmap's cache.

The only tricky conversion is snd_hda_codec_amp_init().  This function
shouldn't do anything if the amp was already initialized.  For
achieving this behavior, a value is read once at first temporarily in
the cache-only mode.  Only if it returns an error,  i.e. the item
still doesn't exist in the cache, it proceeds to the update.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c     | 214 +++++-------------------------------------
 sound/pci/hda/hda_local.h     |  12 +--
 sound/pci/hda/patch_hdmi.c    |   2 +-
 sound/pci/hda/patch_realtek.c |   4 +-
 4 files changed, 33 insertions(+), 199 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 3a209e8b6130..3e6976b52231 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1793,139 +1793,6 @@ int snd_hda_override_pin_caps(struct hda_codec *codec, hda_nid_t nid,
 }
 EXPORT_SYMBOL_GPL(snd_hda_override_pin_caps);
 
-/* read or sync the hash value with the current value;
- * call within hash_mutex
- */
-static struct hda_amp_info *
-update_amp_hash(struct hda_codec *codec, hda_nid_t nid, int ch,
-		int direction, int index, bool init_only)
-{
-	struct hda_amp_info *info;
-	unsigned int parm, val = 0;
-	bool val_read = false;
-
- retry:
-	info = get_alloc_amp_hash(codec, HDA_HASH_KEY(nid, direction, index));
-	if (!info)
-		return NULL;
-	if (!(info->head.val & INFO_AMP_VOL(ch))) {
-		if (!val_read) {
-			mutex_unlock(&codec->hash_mutex);
-			parm = ch ? AC_AMP_GET_RIGHT : AC_AMP_GET_LEFT;
-			parm |= direction == HDA_OUTPUT ?
-				AC_AMP_GET_OUTPUT : AC_AMP_GET_INPUT;
-			parm |= index;
-			val = snd_hda_codec_read(codec, nid, 0,
-				 AC_VERB_GET_AMP_GAIN_MUTE, parm);
-			val &= 0xff;
-			val_read = true;
-			mutex_lock(&codec->hash_mutex);
-			goto retry;
-		}
-		info->vol[ch] = val;
-		info->head.val |= INFO_AMP_VOL(ch);
-	} else if (init_only)
-		return NULL;
-	return info;
-}
-
-/*
- * write the current volume in info to the h/w
- */
-static void put_vol_mute(struct hda_codec *codec, unsigned int amp_caps,
-			 hda_nid_t nid, int ch, int direction, int index,
-			 int val)
-{
-	u32 parm;
-
-	parm = ch ? AC_AMP_SET_RIGHT : AC_AMP_SET_LEFT;
-	parm |= direction == HDA_OUTPUT ? AC_AMP_SET_OUTPUT : AC_AMP_SET_INPUT;
-	parm |= index << AC_AMP_SET_INDEX_SHIFT;
-	if ((val & HDA_AMP_MUTE) && !(amp_caps & AC_AMPCAP_MUTE) &&
-	    (amp_caps & AC_AMPCAP_MIN_MUTE))
-		; /* set the zero value as a fake mute */
-	else
-		parm |= val;
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE, parm);
-}
-
-/**
- * snd_hda_codec_amp_read - Read AMP value
- * @codec: HD-audio codec
- * @nid: NID to read the AMP value
- * @ch: channel (left=0 or right=1)
- * @direction: #HDA_INPUT or #HDA_OUTPUT
- * @index: the index value (only for input direction)
- *
- * Read AMP value.  The volume is between 0 to 0x7f, 0x80 = mute bit.
- */
-int snd_hda_codec_amp_read(struct hda_codec *codec, hda_nid_t nid, int ch,
-			   int direction, int index)
-{
-	struct hda_amp_info *info;
-	unsigned int val = 0;
-
-	mutex_lock(&codec->hash_mutex);
-	info = update_amp_hash(codec, nid, ch, direction, index, false);
-	if (info)
-		val = info->vol[ch];
-	mutex_unlock(&codec->hash_mutex);
-	return val;
-}
-EXPORT_SYMBOL_GPL(snd_hda_codec_amp_read);
-
-static int codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
-			    int direction, int idx, int mask, int val,
-			    bool init_only, bool cache_only)
-{
-	struct hda_amp_info *info;
-	unsigned int caps;
-
-	if (snd_BUG_ON(mask & ~0xff))
-		mask &= 0xff;
-	val &= mask;
-
-	mutex_lock(&codec->hash_mutex);
-	info = update_amp_hash(codec, nid, ch, direction, idx, init_only);
-	if (!info) {
-		mutex_unlock(&codec->hash_mutex);
-		return 0;
-	}
-	val |= info->vol[ch] & ~mask;
-	if (info->vol[ch] == val) {
-		mutex_unlock(&codec->hash_mutex);
-		return 0;
-	}
-	info->vol[ch] = val;
-	info->head.dirty |= cache_only;
-	caps = info->amp_caps;
-	mutex_unlock(&codec->hash_mutex);
-	if (!cache_only)
-		put_vol_mute(codec, caps, nid, ch, direction, idx, val);
-	return 1;
-}
-
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
-{
-	return codec_amp_update(codec, nid, ch, direction, idx, mask, val,
-				false, codec->cached_write);
-}
-EXPORT_SYMBOL_GPL(snd_hda_codec_amp_update);
-
 /**
  * snd_hda_codec_amp_stereo - update the AMP stereo values
  * @codec: HD-audio codec
@@ -1969,8 +1836,16 @@ EXPORT_SYMBOL_GPL(snd_hda_codec_amp_stereo);
 int snd_hda_codec_amp_init(struct hda_codec *codec, hda_nid_t nid, int ch,
 			   int dir, int idx, int mask, int val)
 {
-	return codec_amp_update(codec, nid, ch, dir, idx, mask, val, true,
-				codec->cached_write);
+	int orig;
+
+	if (!codec->regmap)
+		return -EINVAL;
+	regcache_cache_only(codec->regmap, true);
+	orig = snd_hda_regmap_amp_get(codec, nid, ch, dir, idx);
+	regcache_cache_only(codec->regmap, false);
+	if (orig >= 0)
+		return 0;
+	return snd_hda_regmap_amp_update(codec, nid, ch, dir, idx, mask, val);
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_amp_init);
 
@@ -1999,49 +1874,6 @@ int snd_hda_codec_amp_init_stereo(struct hda_codec *codec, hda_nid_t nid,
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_amp_init_stereo);
 
-/**
- * snd_hda_codec_resume_amp - Resume all AMP commands from the cache
- * @codec: HD-audio codec
- *
- * Resume the all amp commands from the cache.
- */
-void snd_hda_codec_resume_amp(struct hda_codec *codec)
-{
-	int i;
-
-	mutex_lock(&codec->hash_mutex);
-	codec->cached_write = 0;
-	for (i = 0; i < codec->amp_cache.buf.used; i++) {
-		struct hda_amp_info *buffer;
-		u32 key;
-		hda_nid_t nid;
-		unsigned int idx, dir, ch;
-		struct hda_amp_info info;
-
-		buffer = snd_array_elem(&codec->amp_cache.buf, i);
-		if (!buffer->head.dirty)
-			continue;
-		buffer->head.dirty = 0;
-		info = *buffer;
-		key = info.head.key;
-		if (!key)
-			continue;
-		nid = key & 0xff;
-		idx = (key >> 16) & 0xff;
-		dir = (key >> 24) & 0xff;
-		for (ch = 0; ch < 2; ch++) {
-			if (!(info.head.val & INFO_AMP_VOL(ch)))
-				continue;
-			mutex_unlock(&codec->hash_mutex);
-			put_vol_mute(codec, info.amp_caps, nid, ch, dir, idx,
-				     info.vol[ch]);
-			mutex_lock(&codec->hash_mutex);
-		}
-	}
-	mutex_unlock(&codec->hash_mutex);
-}
-EXPORT_SYMBOL_GPL(snd_hda_codec_resume_amp);
-
 static u32 get_amp_max_value(struct hda_codec *codec, hda_nid_t nid, int dir,
 			     unsigned int ofs)
 {
@@ -2112,8 +1944,8 @@ update_amp_value(struct hda_codec *codec, hda_nid_t nid,
 	maxval = get_amp_max_value(codec, nid, dir, 0);
 	if (val > maxval)
 		val = maxval;
-	return codec_amp_update(codec, nid, ch, dir, idx, HDA_AMP_VOLMASK, val,
-				false, !hda_codec_is_power_on(codec));
+	return snd_hda_regmap_amp_update(codec, nid, ch, dir, idx,
+					 HDA_AMP_VOLMASK, val);
 }
 
 /**
@@ -2832,17 +2664,15 @@ int snd_hda_mixer_amp_switch_put(struct snd_kcontrol *kcontrol,
 	int change = 0;
 
 	if (chs & 1) {
-		change = codec_amp_update(codec, nid, 0, dir, idx,
-					  HDA_AMP_MUTE,
-					  *valp ? 0 : HDA_AMP_MUTE, false,
-					  !hda_codec_is_power_on(codec));
+		change = snd_hda_regmap_amp_update(codec, nid, 0, dir, idx,
+						   HDA_AMP_MUTE,
+						   *valp ? 0 : HDA_AMP_MUTE);
 		valp++;
 	}
 	if (chs & 2)
-		change |= codec_amp_update(codec, nid, 1, dir, idx,
-					   HDA_AMP_MUTE,
-					   *valp ? 0 : HDA_AMP_MUTE, false,
-					   !hda_codec_is_power_on(codec));
+		change |= snd_hda_regmap_amp_update(codec, nid, 1, dir, idx,
+						    HDA_AMP_MUTE,
+						    *valp ? 0 : HDA_AMP_MUTE);
 	hda_call_check_power_status(codec, nid);
 	return change;
 }
@@ -3703,7 +3533,8 @@ EXPORT_SYMBOL_GPL(snd_hda_sequence_write_cache);
  */
 void snd_hda_codec_flush_cache(struct hda_codec *codec)
 {
-	snd_hda_codec_resume_amp(codec);
+	if (codec->regmap)
+		regcache_sync(codec->regmap);
 	snd_hda_codec_resume_cache(codec);
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_flush_cache);
@@ -3951,6 +3782,8 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 	atomic_inc(&codec->in_pm);
 
 	trace_hda_power_up(codec);
+	if (codec->regmap)
+		regcache_mark_dirty(codec->regmap);
 	hda_mark_cmd_cache_dirty(codec);
 
 	codec->power_jiffies = jiffies;
@@ -3964,7 +3797,8 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 	else {
 		if (codec->patch_ops.init)
 			codec->patch_ops.init(codec);
-		snd_hda_codec_resume_amp(codec);
+		if (codec->regmap)
+			regcache_sync(codec->regmap);
 		snd_hda_codec_resume_cache(codec);
 	}
 
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 8588813163e3..be0654173d45 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -23,6 +23,8 @@
 #ifndef __SOUND_HDA_LOCAL_H
 #define __SOUND_HDA_LOCAL_H
 
+#include "hda_regmap.h"
+
 /* We abuse kcontrol_new.subdev field to pass the NID corresponding to
  * the given new control.  If id.subdev has a bit flag HDA_SUBDEV_NID_FLAG,
  * snd_hda_ctl_add() takes the lower-bit subdev value as a valid NID.
@@ -127,18 +129,16 @@ int snd_hda_mixer_amp_switch_put_beep(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol);
 #endif
 /* lowlevel accessor with caching; use carefully */
-int snd_hda_codec_amp_read(struct hda_codec *codec, hda_nid_t nid, int ch,
-			   int direction, int index);
-int snd_hda_codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
-			     int direction, int idx, int mask, int val);
+#define snd_hda_codec_amp_read(codec, nid, ch, dir, idx) \
+	snd_hda_regmap_amp_get(codec, nid, ch, dir, idx)
+#define snd_hda_codec_amp_update(codec, nid, ch, dir, idx, mask, val) \
+	snd_hda_regmap_amp_update(codec, nid, ch, dir, idx, mask, val)
 int snd_hda_codec_amp_stereo(struct hda_codec *codec, hda_nid_t nid,
 			     int dir, int idx, int mask, int val);
 int snd_hda_codec_amp_init(struct hda_codec *codec, hda_nid_t nid, int ch,
 			   int direction, int idx, int mask, int val);
 int snd_hda_codec_amp_init_stereo(struct hda_codec *codec, hda_nid_t nid,
 				  int dir, int idx, int mask, int val);
-void snd_hda_codec_resume_amp(struct hda_codec *codec);
-
 void snd_hda_set_vmaster_tlv(struct hda_codec *codec, hda_nid_t nid, int dir,
 			     unsigned int *tlv);
 struct snd_kcontrol *snd_hda_find_mixer_ctl(struct hda_codec *codec,
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index f1812aabd63e..a930408d2bb8 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2220,7 +2220,7 @@ static int generic_hdmi_resume(struct hda_codec *codec)
 	int pin_idx;
 
 	codec->patch_ops.init(codec);
-	snd_hda_codec_resume_amp(codec);
+	regcache_sync(codec->regmap);
 	snd_hda_codec_resume_cache(codec);
 
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 70808f92276a..3b495ec41e33 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -799,7 +799,7 @@ static int alc_resume(struct hda_codec *codec)
 	if (!spec->no_depop_delay)
 		msleep(150); /* to avoid pop noise */
 	codec->patch_ops.init(codec);
-	snd_hda_codec_resume_amp(codec);
+	regcache_sync(codec->regmap);
 	snd_hda_codec_resume_cache(codec);
 	hda_call_check_power_status(codec, 0x01);
 	return 0;
@@ -3099,7 +3099,7 @@ static int alc269_resume(struct hda_codec *codec)
 		msleep(200);
 	}
 
-	snd_hda_codec_resume_amp(codec);
+	regcache_sync(codec->regmap);
 	snd_hda_codec_resume_cache(codec);
 	hda_call_check_power_status(codec, 0x01);
 
-- 
2.3.0
