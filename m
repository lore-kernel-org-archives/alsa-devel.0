From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 064/112] ALSA: hda - Avoid access of amp cache
	element outside mutex
Date: Tue,  8 Jan 2013 12:38:57 +0100
Message-ID: <1357645185-7645-65-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 39B072651FF
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 52E6AA52F2
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

The access to a cache array element could be invalid outside the
mutex, so copy locally for the later references.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 48591ab..9eb73b0 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1807,7 +1807,7 @@ update_amp_hash(struct hda_codec *codec, hda_nid_t nid, int ch,
 /*
  * write the current volume in info to the h/w
  */
-static void put_vol_mute(struct hda_codec *codec, struct hda_amp_info *info,
+static void put_vol_mute(struct hda_codec *codec, unsigned int amp_caps,
 			 hda_nid_t nid, int ch, int direction, int index,
 			 int val)
 {
@@ -1816,8 +1816,8 @@ static void put_vol_mute(struct hda_codec *codec, struct hda_amp_info *info,
 	parm = ch ? AC_AMP_SET_RIGHT : AC_AMP_SET_LEFT;
 	parm |= direction == HDA_OUTPUT ? AC_AMP_SET_OUTPUT : AC_AMP_SET_INPUT;
 	parm |= index << AC_AMP_SET_INDEX_SHIFT;
-	if ((val & HDA_AMP_MUTE) && !(info->amp_caps & AC_AMPCAP_MUTE) &&
-	    (info->amp_caps & AC_AMPCAP_MIN_MUTE))
+	if ((val & HDA_AMP_MUTE) && !(amp_caps & AC_AMPCAP_MUTE) &&
+	    (amp_caps & AC_AMPCAP_MIN_MUTE))
 		; /* set the zero value as a fake mute */
 	else
 		parm |= val;
@@ -1854,6 +1854,7 @@ static int codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
 			    bool init_only)
 {
 	struct hda_amp_info *info;
+	unsigned int caps;
 	unsigned int cache_only;
 
 	if (snd_BUG_ON(mask & ~0xff))
@@ -1873,9 +1874,10 @@ static int codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
 	}
 	info->vol[ch] = val;
 	cache_only = info->head.dirty = codec->cached_write;
+	caps = info->amp_caps;
 	mutex_unlock(&codec->hash_mutex);
 	if (!cache_only)
-		put_vol_mute(codec, info, nid, ch, direction, idx, val);
+		put_vol_mute(codec, caps, nid, ch, direction, idx, val);
 	return 1;
 }
 
@@ -1967,23 +1969,25 @@ void snd_hda_codec_resume_amp(struct hda_codec *codec)
 		u32 key;
 		hda_nid_t nid;
 		unsigned int idx, dir, ch;
+		struct hda_amp_info info;
 
 		buffer = snd_array_elem(&codec->amp_cache.buf, i);
 		if (!buffer->head.dirty)
 			continue;
 		buffer->head.dirty = 0;
-		key = buffer->head.key;
+		info = *buffer;
+		key = info.head.key;
 		if (!key)
 			continue;
 		nid = key & 0xff;
 		idx = (key >> 16) & 0xff;
 		dir = (key >> 24) & 0xff;
 		for (ch = 0; ch < 2; ch++) {
-			if (!(buffer->head.val & INFO_AMP_VOL(ch)))
+			if (!(info.head.val & INFO_AMP_VOL(ch)))
 				continue;
 			mutex_unlock(&codec->hash_mutex);
-			put_vol_mute(codec, buffer, nid, ch, dir, idx,
-				     buffer->vol[ch]);
+			put_vol_mute(codec, info.amp_caps, nid, ch, dir, idx,
+				     info.vol[ch]);
 			mutex_lock(&codec->hash_mutex);
 		}
 	}
-- 
1.8.0.1
