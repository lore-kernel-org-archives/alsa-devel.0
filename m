From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 014/112] ALSA: hda - Introduce cache & flush
	cmd / amp writes
Date: Tue,  8 Jan 2013 12:38:07 +0100
Message-ID: <1357645185-7645-15-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A360265180
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 2EC6FA5200
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

For optimizing the verb executions, a new mechanism to cache the verbs
and amp update commands is introduced.  With the new "write to cache
and flush" way, you can reduce the same verbs that have been written
multiple times.

When codec->cached_write flag is set, the further
snd_hda_codec_write_cache() and snd_hda_codec_amp_stereo() calls will
be performed only on the command or amp cache table, but not sent to
the hardware yet.  Once after you call all commands and update amps,
call snd_hda_codec_resume_amp() and snd_hda_codec_resume_cache().
Then all cached writes and amp updates will be written to the
hardware, and the dirty flags are cleared.

In this implementation, the existing cache table is reused, so
actually no big code change is seen here.  Each cache entry has a new
dirty flag now (so the cache key is now reduced to 31bit).

As a good side-effect by this change, snd_hda_codec_resume_*() will no
longer execute verbs that have been already issued during the resume
phase by checking the dirty flags.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 74 +++++++++++++++++++++++++++++++++++++----------
 sound/pci/hda/hda_codec.h | 12 +++-----
 sound/pci/hda/hda_local.h |  2 --
 3 files changed, 63 insertions(+), 25 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index b8fb0a5..3aa20dc 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1610,6 +1610,7 @@ static struct hda_cache_head  *get_alloc_hash(struct hda_cache_rec *cache,
 		cur = snd_array_index(&cache->buf, info);
 		info->key = key;
 		info->val = 0;
+		info->dirty = 0;
 		idx = key % (u16)ARRAY_SIZE(cache->hash);
 		info->next = cache->hash[idx];
 		cache->hash[idx] = cur;
@@ -1873,8 +1874,11 @@ int snd_hda_codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
 		return 0;
 	}
 	info->vol[ch] = val;
+	if (codec->cached_write)
+		info->head.dirty = 1;
 	mutex_unlock(&codec->hash_mutex);
-	put_vol_mute(codec, info, nid, ch, direction, idx, val);
+	if (!codec->cached_write)
+		put_vol_mute(codec, info, nid, ch, direction, idx, val);
 	return 1;
 }
 EXPORT_SYMBOL_HDA(snd_hda_codec_amp_update);
@@ -1905,7 +1909,6 @@ int snd_hda_codec_amp_stereo(struct hda_codec *codec, hda_nid_t nid,
 }
 EXPORT_SYMBOL_HDA(snd_hda_codec_amp_stereo);
 
-#ifdef CONFIG_PM
 /**
  * snd_hda_codec_resume_amp - Resume all AMP commands from the cache
  * @codec: HD-audio codec
@@ -1914,13 +1917,17 @@ EXPORT_SYMBOL_HDA(snd_hda_codec_amp_stereo);
  */
 void snd_hda_codec_resume_amp(struct hda_codec *codec)
 {
-	struct hda_amp_info *buffer = codec->amp_cache.buf.list;
 	int i;
 
-	for (i = 0; i < codec->amp_cache.buf.used; i++, buffer++) {
-		u32 key = buffer->head.key;
+	mutex_lock(&codec->hash_mutex);
+	for (i = 0; i < codec->amp_cache.buf.used; i++) {
+		struct hda_amp_info *buffer;
+		u32 key;
 		hda_nid_t nid;
 		unsigned int idx, dir, ch;
+
+		buffer = snd_array_elem(&codec->amp_cache.buf, i);
+		key = buffer->head.key;
 		if (!key)
 			continue;
 		nid = key & 0xff;
@@ -1929,13 +1936,18 @@ void snd_hda_codec_resume_amp(struct hda_codec *codec)
 		for (ch = 0; ch < 2; ch++) {
 			if (!(buffer->head.val & INFO_AMP_VOL(ch)))
 				continue;
+			if (!buffer->head.dirty)
+				continue;
+			buffer->head.dirty = 0;
+			mutex_unlock(&codec->hash_mutex);
 			put_vol_mute(codec, buffer, nid, ch, dir, idx,
 				     buffer->vol[ch]);
+			mutex_lock(&codec->hash_mutex);
 		}
 	}
+	mutex_unlock(&codec->hash_mutex);
 }
 EXPORT_SYMBOL_HDA(snd_hda_codec_resume_amp);
-#endif /* CONFIG_PM */
 
 static u32 get_amp_max_value(struct hda_codec *codec, hda_nid_t nid, int dir,
 			     unsigned int ofs)
@@ -3375,12 +3387,11 @@ int snd_hda_create_spdif_in_ctls(struct hda_codec *codec, hda_nid_t nid)
 }
 EXPORT_SYMBOL_HDA(snd_hda_create_spdif_in_ctls);
 
-#ifdef CONFIG_PM
 /*
  * command cache
  */
 
-/* build a 32bit cache key with the widget id and the command parameter */
+/* build a 31bit cache key with the widget id and the command parameter */
 #define build_cmd_cache_key(nid, verb)	((verb << 8) | nid)
 #define get_cmd_cache_nid(key)		((key) & 0xff)
 #define get_cmd_cache_cmd(key)		(((key) >> 8) & 0xffff)
@@ -3400,12 +3411,16 @@ EXPORT_SYMBOL_HDA(snd_hda_create_spdif_in_ctls);
 int snd_hda_codec_write_cache(struct hda_codec *codec, hda_nid_t nid,
 			      int direct, unsigned int verb, unsigned int parm)
 {
-	int err = snd_hda_codec_write(codec, nid, direct, verb, parm);
+	int err;
 	struct hda_cache_head *c;
 	u32 key;
 
-	if (err < 0)
-		return err;
+	if (!codec->cached_write) {
+		err = snd_hda_codec_write(codec, nid, direct, verb, parm);
+		if (err < 0)
+			return err;
+	}
+
 	/* parm may contain the verb stuff for get/set amp */
 	verb = verb | (parm >> 8);
 	parm &= 0xff;
@@ -3414,6 +3429,8 @@ int snd_hda_codec_write_cache(struct hda_codec *codec, hda_nid_t nid,
 	c = get_alloc_hash(&codec->cmd_cache, key);
 	if (c)
 		c->val = parm;
+	if (codec->cached_write)
+		c->dirty = 1;
 	mutex_unlock(&codec->bus->cmd_mutex);
 	return 0;
 }
@@ -3462,16 +3479,26 @@ EXPORT_SYMBOL_HDA(snd_hda_codec_update_cache);
  */
 void snd_hda_codec_resume_cache(struct hda_codec *codec)
 {
-	struct hda_cache_head *buffer = codec->cmd_cache.buf.list;
 	int i;
 
-	for (i = 0; i < codec->cmd_cache.buf.used; i++, buffer++) {
-		u32 key = buffer->key;
+	mutex_lock(&codec->hash_mutex);
+	for (i = 0; i < codec->cmd_cache.buf.used; i++) {
+		struct hda_cache_head *buffer;
+		u32 key;
+
+		buffer = snd_array_elem(&codec->cmd_cache.buf, i);
+		key = buffer->key;
 		if (!key)
 			continue;
+		if (!buffer->dirty)
+			continue;
+		buffer->dirty = 0;
+		mutex_unlock(&codec->hash_mutex);
 		snd_hda_codec_write(codec, get_cmd_cache_nid(key), 0,
 				    get_cmd_cache_cmd(key), buffer->val);
+		mutex_lock(&codec->hash_mutex);
 	}
+	mutex_unlock(&codec->hash_mutex);
 }
 EXPORT_SYMBOL_HDA(snd_hda_codec_resume_cache);
 
@@ -3492,7 +3519,6 @@ void snd_hda_sequence_write_cache(struct hda_codec *codec,
 					  seq->param);
 }
 EXPORT_SYMBOL_HDA(snd_hda_sequence_write_cache);
-#endif /* CONFIG_PM */
 
 void snd_hda_codec_set_power_to_all(struct hda_codec *codec, hda_nid_t fg,
 				    unsigned int power_state,
@@ -3640,6 +3666,22 @@ static unsigned int hda_call_codec_suspend(struct hda_codec *codec, bool in_wq)
 	return state;
 }
 
+/* mark all entries of cmd and amp caches dirty */
+static void hda_mark_cmd_cache_dirty(struct hda_codec *codec)
+{
+	int i;
+	for (i = 0; i < codec->cmd_cache.buf.used; i++) {
+		struct hda_cache_head *cmd;
+		cmd = snd_array_elem(&codec->cmd_cache.buf, i);
+		cmd->dirty = 1;
+	}
+	for (i = 0; i < codec->amp_cache.buf.used; i++) {
+		struct hda_amp_info *amp;
+		amp = snd_array_elem(&codec->cmd_cache.buf, i);
+		amp->head.dirty = 1;
+	}
+}
+
 /*
  * kick up codec; used both from PM and power-save
  */
@@ -3647,6 +3689,8 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 {
 	codec->in_pm = 1;
 
+	hda_mark_cmd_cache_dirty(codec);
+
 	/* set as if powered on for avoiding re-entering the resume
 	 * in the resume / power-save sequence
 	 */
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 8665540..cab39b2 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -719,9 +719,10 @@ struct hda_codec_ops {
 
 /* record for amp information cache */
 struct hda_cache_head {
-	u32 key;		/* hash key */
+	u32 key:31;		/* hash key */
+	u32 dirty:1;
 	u16 val;		/* assigned value */
-	u16 next;		/* next link; -1 = terminal */
+	u16 next;
 };
 
 struct hda_amp_info {
@@ -867,6 +868,7 @@ struct hda_codec {
 	unsigned int no_jack_detect:1;	/* Machine has no jack-detection */
 	unsigned int pcm_format_first:1; /* PCM format must be set first */
 	unsigned int epss:1;		/* supporting EPSS? */
+	unsigned int cached_write:1;	/* write only to caches */
 #ifdef CONFIG_PM
 	unsigned int power_on :1;	/* current (global) power-state */
 	unsigned int d3_stop_clk:1;	/* support D3 operation without BCLK */
@@ -952,7 +954,6 @@ void snd_hda_sequence_write(struct hda_codec *codec,
 int snd_hda_queue_unsol_event(struct hda_bus *bus, u32 res, u32 res_ex);
 
 /* cached write */
-#ifdef CONFIG_PM
 int snd_hda_codec_write_cache(struct hda_codec *codec, hda_nid_t nid,
 			      int direct, unsigned int verb, unsigned int parm);
 void snd_hda_sequence_write_cache(struct hda_codec *codec,
@@ -960,11 +961,6 @@ void snd_hda_sequence_write_cache(struct hda_codec *codec,
 int snd_hda_codec_update_cache(struct hda_codec *codec, hda_nid_t nid,
 			      int direct, unsigned int verb, unsigned int parm);
 void snd_hda_codec_resume_cache(struct hda_codec *codec);
-#else
-#define snd_hda_codec_write_cache	snd_hda_codec_write
-#define snd_hda_codec_update_cache	snd_hda_codec_write
-#define snd_hda_sequence_write_cache	snd_hda_sequence_write
-#endif
 
 /* the struct for codec->pin_configs */
 struct hda_pincfg {
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 4b40a5e..f765296 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -133,9 +133,7 @@ int snd_hda_codec_amp_update(struct hda_codec *codec, hda_nid_t nid, int ch,
 			     int direction, int idx, int mask, int val);
 int snd_hda_codec_amp_stereo(struct hda_codec *codec, hda_nid_t nid,
 			     int dir, int idx, int mask, int val);
-#ifdef CONFIG_PM
 void snd_hda_codec_resume_amp(struct hda_codec *codec);
-#endif
 
 void snd_hda_set_vmaster_tlv(struct hda_codec *codec, hda_nid_t nid, int dir,
 			     unsigned int *tlv);
-- 
1.8.0.1
