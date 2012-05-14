From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/15] ALSA: hda - Fix concurrent hash accesses
Date: Mon, 14 May 2012 17:32:04 +0200
Message-ID: <1337009526-26256-14-git-send-email-tiwai@suse.de>
References: <1337009526-26256-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id A925A24A2F
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:18 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 06F2F90B96
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 17:32:18 +0200 (CEST)
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

The amp and caps hashes aren't protected properly for concurrent
accesses.  Protect them via a new mutex now.

But it can't be so simple as originally thought: since the update of a
hash table entry itself might trigger the power-up sequence which
again accesses the hash table, we can't cover the whole function
simply via mutex.  Thus the update part has to be split from the mutex
and revalidated.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c |  201 +++++++++++++++++++++++++++------------------
 sound/pci/hda/hda_codec.h |    1 +
 2 files changed, 121 insertions(+), 81 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 5e7c4bf..7a621f5 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1255,6 +1255,7 @@ int /*__devinit*/ snd_hda_codec_new(struct hda_bus *bus,
 	codec->addr = codec_addr;
 	mutex_init(&codec->spdif_mutex);
 	mutex_init(&codec->control_mutex);
+	mutex_init(&codec->hash_mutex);
 	init_hda_cache(&codec->amp_cache, sizeof(struct hda_amp_info));
 	init_hda_cache(&codec->cmd_cache, sizeof(struct hda_cache_head));
 	snd_array_init(&codec->mixers, sizeof(struct hda_nid_item), 32);
@@ -1605,6 +1606,60 @@ get_alloc_amp_hash(struct hda_codec *codec, u32 key)
 	return (struct hda_amp_info *)get_alloc_hash(&codec->amp_cache, key);
 }
 
+/* overwrite the value with the key in the caps hash */
+static int write_caps_hash(struct hda_codec *codec, u32 key, unsigned int val)
+{
+	struct hda_amp_info *info;
+
+	mutex_lock(&codec->hash_mutex);
+	info = get_alloc_amp_hash(codec, key);
+	if (!info) {
+		mutex_unlock(&codec->hash_mutex);
+		return -EINVAL;
+	}
+	info->amp_caps = val;
+	info->head.val |= INFO_AMP_CAPS;
+	mutex_unlock(&codec->hash_mutex);
+	return 0;
+}
+
+/* query the value from the caps hash; if not found, fetch the current
+ * value from the given function and store in the hash
+ */
+static unsigned int
+query_caps_hash(struct hda_codec *codec, hda_nid_t nid, int dir, u32 key,
+		unsigned int (*func)(struct hda_codec *, hda_nid_t, int))
+{
+	struct hda_amp_info *info;
+	unsigned int val;
+
+	mutex_lock(&codec->hash_mutex);
+	info = get_alloc_amp_hash(codec, key);
+	if (!info) {
+		mutex_unlock(&codec->hash_mutex);
+		return 0;
+	}
+	if (!(info->head.val & INFO_AMP_CAPS)) {
+		mutex_unlock(&codec->hash_mutex); /* for reentrance */
+		val = func(codec, nid, dir);
+		write_caps_hash(codec, key, val);
+	} else {
+		val = info->amp_caps;
+		mutex_unlock(&codec->hash_mutex);
+	}
+	return val;
+}
+
+static unsigned int read_amp_cap(struct hda_codec *codec, hda_nid_t nid,
+				 int direction)
+{
+	if (!(get_wcaps(codec, nid) & AC_WCAP_AMP_OVRD))
+		nid = codec->afg;
+	return snd_hda_param_read(codec, nid,
+				  direction == HDA_OUTPUT ?
+				  AC_PAR_AMP_OUT_CAP : AC_PAR_AMP_IN_CAP);
+}
+
 /**
  * query_amp_caps - query AMP capabilities
  * @codec: the HD-auio codec
@@ -1619,22 +1674,9 @@ get_alloc_amp_hash(struct hda_codec *codec, u32 key)
  */
 u32 query_amp_caps(struct hda_codec *codec, hda_nid_t nid, int direction)
 {
-	struct hda_amp_info *info;
-
-	info = get_alloc_amp_hash(codec, HDA_HASH_KEY(nid, direction, 0));
-	if (!info)
-		return 0;
-	if (!(info->head.val & INFO_AMP_CAPS)) {
-		if (!(get_wcaps(codec, nid) & AC_WCAP_AMP_OVRD))
-			nid = codec->afg;
-		info->amp_caps = snd_hda_param_read(codec, nid,
-						    direction == HDA_OUTPUT ?
-						    AC_PAR_AMP_OUT_CAP :
-						    AC_PAR_AMP_IN_CAP);
-		if (info->amp_caps)
-			info->head.val |= INFO_AMP_CAPS;
-	}
-	return info->amp_caps;
+	return query_caps_hash(codec, nid, direction,
+			       HDA_HASH_KEY(nid, direction, 0),
+			       read_amp_cap);
 }
 EXPORT_SYMBOL_HDA(query_amp_caps);
 
@@ -1654,34 +1696,12 @@ EXPORT_SYMBOL_HDA(query_amp_caps);
 int snd_hda_override_amp_caps(struct hda_codec *codec, hda_nid_t nid, int dir,
 			      unsigned int caps)
 {
-	struct hda_amp_info *info;
-
-	info = get_alloc_amp_hash(codec, HDA_HASH_KEY(nid, dir, 0));
-	if (!info)
-		return -EINVAL;
-	info->amp_caps = caps;
-	info->head.val |= INFO_AMP_CAPS;
-	return 0;
+	return write_caps_hash(codec, HDA_HASH_KEY(nid, dir, 0), caps);
 }
 EXPORT_SYMBOL_HDA(snd_hda_override_amp_caps);
 
-static unsigned int
-query_caps_hash(struct hda_codec *codec, hda_nid_t nid, u32 key,
-		unsigned int (*func)(struct hda_codec *, hda_nid_t))
-{
-	struct hda_amp_info *info;
-
-	info = get_alloc_amp_hash(codec, key);
-	if (!info)
-		return 0;
-	if (!info->head.val) {
-		info->head.val |= INFO_AMP_CAPS;
-		info->amp_caps = func(codec, nid);
-	}
-	return info->amp_caps;
-}
-
-static unsigned int read_pin_cap(struct hda_codec *codec, hda_nid_t nid)
+static unsigned int read_pin_cap(struct hda_codec *codec, hda_nid_t nid,
+				 int dir)
 {
 	return snd_hda_param_read(codec, nid, AC_PAR_PIN_CAP);
 }
@@ -1699,7 +1719,7 @@ static unsigned int read_pin_cap(struct hda_codec *codec, hda_nid_t nid)
  */
 u32 snd_hda_query_pin_caps(struct hda_codec *codec, hda_nid_t nid)
 {
-	return query_caps_hash(codec, nid, HDA_HASH_PINCAP_KEY(nid),
+	return query_caps_hash(codec, nid, 0, HDA_HASH_PINCAP_KEY(nid),
 			       read_pin_cap);
 }
 EXPORT_SYMBOL_HDA(snd_hda_query_pin_caps);
@@ -1717,41 +1737,47 @@ EXPORT_SYMBOL_HDA(snd_hda_query_pin_caps);
 int snd_hda_override_pin_caps(struct hda_codec *codec, hda_nid_t nid,
 			      unsigned int caps)
 {
-	struct hda_amp_info *info;
-	info = get_alloc_amp_hash(codec, HDA_HASH_PINCAP_KEY(nid));
-	if (!info)
-		return -ENOMEM;
-	info->amp_caps = caps;
-	info->head.val |= INFO_AMP_CAPS;
-	return 0;
+	return write_caps_hash(codec, HDA_HASH_PINCAP_KEY(nid), caps);
 }
 EXPORT_SYMBOL_HDA(snd_hda_override_pin_caps);
 
-/*
- * read the current volume to info
- * if the cache exists, read the cache value.
+/* read or sync the hash value with the current value;
+ * call within hash_mutex
  */
-static unsigned int get_vol_mute(struct hda_codec *codec,
-				 struct hda_amp_info *info, hda_nid_t nid,
-				 int ch, int direction, int index)
+static struct hda_amp_info *
+update_amp_hash(struct hda_codec *codec, hda_nid_t nid, int ch,
+		int direction, int index)
 {
-	u32 val, parm;
-
-	if (info->head.val & INFO_AMP_VOL(ch))
-		return info->vol[ch];
+	struct hda_amp_info *info;
+	unsigned int parm, val = 0;
+	bool val_read = false;
 
-	parm = ch ? AC_AMP_GET_RIGHT : AC_AMP_GET_LEFT;
-	parm |= direction == HDA_OUTPUT ? AC_AMP_GET_OUTPUT : AC_AMP_GET_INPUT;
-	parm |= index;
-	val = snd_hda_codec_read(codec, nid, 0,
+ retry:
+	info = get_alloc_amp_hash(codec, HDA_HASH_KEY(nid, direction, index));
+	if (!info)
+		return NULL;
+	if (!(info->head.val & INFO_AMP_VOL(ch))) {
+		if (!val_read) {
+			mutex_unlock(&codec->hash_mutex);
+			parm = ch ? AC_AMP_GET_RIGHT : AC_AMP_GET_LEFT;
+			parm |= direction == HDA_OUTPUT ?
+				AC_AMP_GET_OUTPUT : AC_AMP_GET_INPUT;
+			parm |= index;
+			val = snd_hda_codec_read(codec, nid, 0,
 				 AC_VERB_GET_AMP_GAIN_MUTE, parm);
-	info->vol[ch] = val & 0xff;
-	info->head.val |= INFO_AMP_VOL(ch);
-	return info->vol[ch];
+			val &= 0xff;
+			val_read = true;
+			mutex_lock(&codec->hash_mutex);
+			goto retry;
+		}
+		info->vol[ch] = val;
+		info->head.val |= INFO_AMP_VOL(ch);
+	}
+	return info;
 }
 
 /*
- * write the current volume in info to the h/w and update the cache
+ * write the current volume in info to the h/w
  */
 static void put_vol_mute(struct hda_codec *codec, struct hda_amp_info *info,
 			 hda_nid_t nid, int ch, int direction, int index,
@@ -1768,7 +1794,6 @@ static void put_vol_mute(struct hda_codec *codec, struct hda_amp_info *info,
 	else
 		parm |= val;
 	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE, parm);
-	info->vol[ch] = val;
 }
 
 /**
@@ -1785,10 +1810,14 @@ int snd_hda_codec_amp_read(struct hda_codec *codec, hda_nid_t nid, int ch,
 			   int direction, int index)
 {
 	struct hda_amp_info *info;
-	info = get_alloc_amp_hash(codec, HDA_HASH_KEY(nid, direction, index));
-	if (!info)
-		return 0;
-	return get_vol_mute(codec, info, nid, ch, direction, index);
+	unsigned int val = 0;
+
+	mutex_lock(&codec->hash_mutex);
+	info = update_amp_hash(codec, nid, ch, direction, index);
+	if (info)
+		val = info->vol[ch];
+	mutex_unlock(&codec->hash_mutex);
+	return val;
 }
 EXPORT_SYMBOL_HDA(snd_hda_codec_amp_read);
 
@@ -1810,15 +1839,23 @@ int snd_hda_codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
 {
 	struct hda_amp_info *info;
 
-	info = get_alloc_amp_hash(codec, HDA_HASH_KEY(nid, direction, idx));
-	if (!info)
-		return 0;
 	if (snd_BUG_ON(mask & ~0xff))
 		mask &= 0xff;
 	val &= mask;
-	val |= get_vol_mute(codec, info, nid, ch, direction, idx) & ~mask;
-	if (info->vol[ch] == val)
+
+	mutex_lock(&codec->hash_mutex);
+	info = update_amp_hash(codec, nid, ch, direction, idx);
+	if (!info) {
+		mutex_unlock(&codec->hash_mutex);
+		return 0;
+	}
+	val |= info->vol[ch] & ~mask;
+	if (info->vol[ch] == val) {
+		mutex_unlock(&codec->hash_mutex);
 		return 0;
+	}
+	info->vol[ch] = val;
+	mutex_unlock(&codec->hash_mutex);
 	put_vol_mute(codec, info, nid, ch, direction, idx, val);
 	return 1;
 }
@@ -3693,7 +3730,8 @@ unsigned int snd_hda_calc_stream_format(unsigned int rate,
 }
 EXPORT_SYMBOL_HDA(snd_hda_calc_stream_format);
 
-static unsigned int get_pcm_param(struct hda_codec *codec, hda_nid_t nid)
+static unsigned int get_pcm_param(struct hda_codec *codec, hda_nid_t nid,
+				  int dir)
 {
 	unsigned int val = 0;
 	if (nid != codec->afg &&
@@ -3708,11 +3746,12 @@ static unsigned int get_pcm_param(struct hda_codec *codec, hda_nid_t nid)
 
 static unsigned int query_pcm_param(struct hda_codec *codec, hda_nid_t nid)
 {
-	return query_caps_hash(codec, nid, HDA_HASH_PARPCM_KEY(nid),
+	return query_caps_hash(codec, nid, 0, HDA_HASH_PARPCM_KEY(nid),
 			       get_pcm_param);
 }
 
-static unsigned int get_stream_param(struct hda_codec *codec, hda_nid_t nid)
+static unsigned int get_stream_param(struct hda_codec *codec, hda_nid_t nid,
+				     int dir)
 {
 	unsigned int streams = snd_hda_param_read(codec, nid, AC_PAR_STREAM);
 	if (!streams || streams == -1)
@@ -3724,7 +3763,7 @@ static unsigned int get_stream_param(struct hda_codec *codec, hda_nid_t nid)
 
 static unsigned int query_stream_param(struct hda_codec *codec, hda_nid_t nid)
 {
-	return query_caps_hash(codec, nid, HDA_HASH_PARSTR_KEY(nid),
+	return query_caps_hash(codec, nid, 0, HDA_HASH_PARSTR_KEY(nid),
 			       get_stream_param);
 }
 
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index fce30b4..29a311b 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -827,6 +827,7 @@ struct hda_codec {
 
 	struct mutex spdif_mutex;
 	struct mutex control_mutex;
+	struct mutex hash_mutex;
 	struct snd_array spdif_out;
 	unsigned int spdif_in_enable;	/* SPDIF input enable? */
 	const hda_nid_t *slave_dig_outs; /* optional digital out slave widgets */
-- 
1.7.9.2
