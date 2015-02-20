From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Avoid unnecessary power-up at
	mixer amp changes
Date: Fri, 20 Feb 2015 10:41:08 +0100
Message-ID: <1424425268-7541-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 98AEE26056B
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 10:41:10 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 52057ABF1
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 09:41:10 +0000 (UTC)
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

When the mixer amp is touched by control elements, we don't have to
power up always; if the codec was suspended at the time, we can just
update the amp cache and it's reflected to the hardware upon resume.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 0734cb35887d..5e755eb6f19a 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2148,11 +2148,10 @@ EXPORT_SYMBOL_GPL(snd_hda_codec_amp_read);
 
 static int codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
 			    int direction, int idx, int mask, int val,
-			    bool init_only)
+			    bool init_only, bool cache_only)
 {
 	struct hda_amp_info *info;
 	unsigned int caps;
-	unsigned int cache_only;
 
 	if (snd_BUG_ON(mask & ~0xff))
 		mask &= 0xff;
@@ -2170,7 +2169,7 @@ static int codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
 		return 0;
 	}
 	info->vol[ch] = val;
-	cache_only = info->head.dirty = codec->cached_write;
+	info->head.dirty |= cache_only;
 	caps = info->amp_caps;
 	mutex_unlock(&codec->hash_mutex);
 	if (!cache_only)
@@ -2194,7 +2193,8 @@ static int codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
 int snd_hda_codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
 			     int direction, int idx, int mask, int val)
 {
-	return codec_amp_update(codec, nid, ch, direction, idx, mask, val, false);
+	return codec_amp_update(codec, nid, ch, direction, idx, mask, val,
+				false, codec->cached_write);
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_amp_update);
 
@@ -2241,7 +2241,8 @@ EXPORT_SYMBOL_GPL(snd_hda_codec_amp_stereo);
 int snd_hda_codec_amp_init(struct hda_codec *codec, hda_nid_t nid, int ch,
 			   int dir, int idx, int mask, int val)
 {
-	return codec_amp_update(codec, nid, ch, dir, idx, mask, val, true);
+	return codec_amp_update(codec, nid, ch, dir, idx, mask, val, true,
+				codec->cached_write);
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_amp_init);
 
@@ -2383,8 +2384,8 @@ update_amp_value(struct hda_codec *codec, hda_nid_t nid,
 	maxval = get_amp_max_value(codec, nid, dir, 0);
 	if (val > maxval)
 		val = maxval;
-	return snd_hda_codec_amp_update(codec, nid, ch, dir, idx,
-					HDA_AMP_VOLMASK, val);
+	return codec_amp_update(codec, nid, ch, dir, idx, HDA_AMP_VOLMASK, val,
+				false, !hda_codec_is_power_on(codec));
 }
 
 /**
@@ -2434,14 +2435,12 @@ int snd_hda_mixer_amp_volume_put(struct snd_kcontrol *kcontrol,
 	long *valp = ucontrol->value.integer.value;
 	int change = 0;
 
-	snd_hda_power_up(codec);
 	if (chs & 1) {
 		change = update_amp_value(codec, nid, 0, dir, idx, ofs, *valp);
 		valp++;
 	}
 	if (chs & 2)
 		change |= update_amp_value(codec, nid, 1, dir, idx, ofs, *valp);
-	snd_hda_power_down(codec);
 	return change;
 }
 EXPORT_SYMBOL_GPL(snd_hda_mixer_amp_volume_put);
@@ -3109,19 +3108,19 @@ int snd_hda_mixer_amp_switch_put(struct snd_kcontrol *kcontrol,
 	long *valp = ucontrol->value.integer.value;
 	int change = 0;
 
-	snd_hda_power_up(codec);
 	if (chs & 1) {
-		change = snd_hda_codec_amp_update(codec, nid, 0, dir, idx,
-						  HDA_AMP_MUTE,
-						  *valp ? 0 : HDA_AMP_MUTE);
+		change = codec_amp_update(codec, nid, 0, dir, idx,
+					  HDA_AMP_MUTE,
+					  *valp ? 0 : HDA_AMP_MUTE, false,
+					  !hda_codec_is_power_on(codec));
 		valp++;
 	}
 	if (chs & 2)
-		change |= snd_hda_codec_amp_update(codec, nid, 1, dir, idx,
-						   HDA_AMP_MUTE,
-						   *valp ? 0 : HDA_AMP_MUTE);
+		change |= codec_amp_update(codec, nid, 1, dir, idx,
+					   HDA_AMP_MUTE,
+					   *valp ? 0 : HDA_AMP_MUTE, false,
+					   !hda_codec_is_power_on(codec));
 	hda_call_check_power_status(codec, nid);
-	snd_hda_power_down(codec);
 	return change;
 }
 EXPORT_SYMBOL_GPL(snd_hda_mixer_amp_switch_put);
-- 
2.3.0
