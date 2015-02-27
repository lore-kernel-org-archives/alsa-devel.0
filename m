From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/7] ALSA: hda - Use regmap for command verb
	caches, too
Date: Fri, 27 Feb 2015 22:28:21 +0100
Message-ID: <1425072502-3204-7-git-send-email-tiwai@suse.de>
References: <1425072502-3204-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 104B12651AF
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 22:28:28 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 79852ADB8
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

Like the previous patches, this patch converts also to the regmap, at
this time, the cached verb writes are the target.  But this conversion
needs a bit more caution than before.

- In the old code, we just record any verbs as is, and restore them at
  resume.  For the regmap scheme, this doesn't work, since a few verbs
  like AMP or DIGI_CONVERT are asymmetrical.  Such verbs are converted
  either to the dedicated function (snd_hda_regmap_xxx_amp()) or
  changed to the unified verb.

- Some verbs have to be declared as vendor-specific ones before
  accessing via regmap.

Also, the minor optimization with codec->cached_write flag is dropped
in a few places, as this would confuse the operation.  Further
optimizations will be brought in the later patches, if any.

This conversion ends up with a drop of significant amount of codes,
mostly the helper codes that are no longer used.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_beep.c       |   3 +-
 sound/pci/hda/hda_codec.c      | 276 +++++------------------------------------
 sound/pci/hda/hda_codec.h      |  27 ----
 sound/pci/hda/hda_generic.c    |  32 ++---
 sound/pci/hda/hda_jack.c       |   6 +-
 sound/pci/hda/patch_analog.c   |  30 ++---
 sound/pci/hda/patch_conexant.c |  12 +-
 sound/pci/hda/patch_hdmi.c     |  22 ++--
 sound/pci/hda/patch_realtek.c  |   7 +-
 sound/pci/hda/patch_si3054.c   |   5 +-
 sound/pci/hda/patch_sigmatel.c |  38 +++---
 11 files changed, 98 insertions(+), 360 deletions(-)

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index e98438e95e79..45a3d7ae6f56 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -226,8 +226,7 @@ int snd_hda_attach_beep_device(struct hda_codec *codec, int nid)
 	snprintf(beep->phys, sizeof(beep->phys),
 		"card%d/codec#%d/beep0", codec->bus->card->number, codec->addr);
 	/* enable linear scale */
-	snd_hda_codec_write_cache(codec, nid, 0,
-		AC_VERB_SET_DIGI_CONVERT_2, 0x01);
+	snd_hda_regmap_write(codec, nid, AC_VERB_SET_DIGI_CONVERT_2, 0x01);
 
 	beep->nid = nid;
 	beep->codec = codec;
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 8781632dff96..26d45268647d 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1092,10 +1092,6 @@ static void hda_jackpoll_work(struct work_struct *work)
 			   codec->jackpoll_interval);
 }
 
-static void init_hda_cache(struct hda_cache_rec *cache,
-			   unsigned int record_size);
-static void free_hda_cache(struct hda_cache_rec *cache);
-
 /* release all pincfg lists */
 static void free_init_pincfgs(struct hda_codec *codec)
 {
@@ -1158,7 +1154,6 @@ static void snd_hda_codec_free(struct hda_codec *codec)
 	codec->bus->caddr_tbl[codec->addr] = NULL;
 	clear_bit(codec->addr, &codec->bus->codec_powered);
 	snd_hda_sysfs_clear(codec);
-	free_hda_cache(&codec->cmd_cache);
 	kfree(codec->vendor_name);
 	kfree(codec->chip_name);
 	kfree(codec->modelname);
@@ -1260,8 +1255,6 @@ int snd_hda_codec_new(struct hda_bus *bus,
 	codec->addr = codec_addr;
 	mutex_init(&codec->spdif_mutex);
 	mutex_init(&codec->control_mutex);
-	mutex_init(&codec->hash_mutex);
-	init_hda_cache(&codec->cmd_cache, sizeof(struct hda_cache_head));
 	snd_array_init(&codec->mixers, sizeof(struct hda_nid_item), 32);
 	snd_array_init(&codec->nids, sizeof(struct hda_nid_item), 32);
 	snd_array_init(&codec->init_pins, sizeof(struct hda_pincfg), 16);
@@ -1568,66 +1561,6 @@ static void hda_cleanup_all_streams(struct hda_codec *codec)
  * amp access functions
  */
 
-/* FIXME: more better hash key? */
-#define HDA_HASH_KEY(nid, dir, idx) (u32)((nid) + ((idx) << 16) + ((dir) << 24))
-#define HDA_HASH_PINCAP_KEY(nid) (u32)((nid) + (0x02 << 24))
-#define HDA_HASH_PARPCM_KEY(nid) (u32)((nid) + (0x03 << 24))
-#define HDA_HASH_PARSTR_KEY(nid) (u32)((nid) + (0x04 << 24))
-#define INFO_AMP_CAPS	(1<<0)
-#define INFO_AMP_VOL(ch)	(1 << (1 + (ch)))
-
-/* initialize the hash table */
-static void init_hda_cache(struct hda_cache_rec *cache,
-				     unsigned int record_size)
-{
-	memset(cache, 0, sizeof(*cache));
-	memset(cache->hash, 0xff, sizeof(cache->hash));
-	snd_array_init(&cache->buf, record_size, 64);
-}
-
-static void free_hda_cache(struct hda_cache_rec *cache)
-{
-	snd_array_free(&cache->buf);
-}
-
-/* query the hash.  allocate an entry if not found. */
-static struct hda_cache_head  *get_hash(struct hda_cache_rec *cache, u32 key)
-{
-	u16 idx = key % (u16)ARRAY_SIZE(cache->hash);
-	u16 cur = cache->hash[idx];
-	struct hda_cache_head *info;
-
-	while (cur != 0xffff) {
-		info = snd_array_elem(&cache->buf, cur);
-		if (info->key == key)
-			return info;
-		cur = info->next;
-	}
-	return NULL;
-}
-
-/* query the hash.  allocate an entry if not found. */
-static struct hda_cache_head  *get_alloc_hash(struct hda_cache_rec *cache,
-					      u32 key)
-{
-	struct hda_cache_head *info = get_hash(cache, key);
-	if (!info) {
-		u16 idx, cur;
-		/* add a new hash entry */
-		info = snd_array_new(&cache->buf);
-		if (!info)
-			return NULL;
-		cur = snd_array_index(&cache->buf, info);
-		info->key = key;
-		info->val = 0;
-		info->dirty = 0;
-		idx = key % (u16)ARRAY_SIZE(cache->hash);
-		info->next = cache->hash[idx];
-		cache->hash[idx] = cur;
-	}
-	return info;
-}
-
 /* override the parameter */
 static int override_parameter(struct hda_codec *codec, hda_nid_t nid,
 			      unsigned int parm, unsigned int val)
@@ -2239,8 +2172,6 @@ int snd_hda_codec_reset(struct hda_codec *codec)
 	snd_hda_jack_tbl_clear(codec);
 	codec->proc_widget_hook = NULL;
 	codec->spec = NULL;
-	free_hda_cache(&codec->cmd_cache);
-	init_hda_cache(&codec->cmd_cache, sizeof(struct hda_cache_head));
 	/* free only driver_pins so that init_pins + user_pins are restored */
 	snd_array_free(&codec->driver_pins);
 	snd_array_free(&codec->cvt_setups);
@@ -2908,25 +2839,36 @@ static unsigned int convert_to_spdif_status(unsigned short val)
 
 /* set digital convert verbs both for the given NID and its slaves */
 static void set_dig_out(struct hda_codec *codec, hda_nid_t nid,
-			int verb, int val)
+			int mask, int val)
 {
 	const hda_nid_t *d;
 
-	snd_hda_codec_write_cache(codec, nid, 0, verb, val);
+	snd_hda_regmap_update_bits(codec, nid, AC_VERB_SET_DIGI_CONVERT_1,
+				   mask, val);
 	d = codec->slave_dig_outs;
 	if (!d)
 		return;
 	for (; *d; d++)
-		snd_hda_codec_write_cache(codec, *d, 0, verb, val);
+		snd_hda_regmap_update_bits(codec, nid,
+					   AC_VERB_SET_DIGI_CONVERT_1,
+					   mask, val);
 }
 
 static inline void set_dig_out_convert(struct hda_codec *codec, hda_nid_t nid,
 				       int dig1, int dig2)
 {
-	if (dig1 != -1)
-		set_dig_out(codec, nid, AC_VERB_SET_DIGI_CONVERT_1, dig1);
-	if (dig2 != -1)
-		set_dig_out(codec, nid, AC_VERB_SET_DIGI_CONVERT_2, dig2);
+	unsigned int mask = 0;
+	unsigned int val = 0;
+
+	if (dig1 != -1) {
+		mask |= 0xff;
+		val = dig1;
+	}
+	if (dig2 != -1) {
+		mask |= 0xff00;
+		val |= dig2 << 8;
+	}
+	set_dig_out(codec, nid, mask, val);
 }
 
 static int snd_hda_spdif_default_put(struct snd_kcontrol *kcontrol,
@@ -3059,6 +3001,7 @@ int snd_hda_create_dig_out_ctls(struct hda_codec *codec,
 	struct snd_kcontrol *kctl;
 	struct snd_kcontrol_new *dig_mix;
 	int idx = 0;
+	int val = 0;
 	const int spdif_index = 16;
 	struct hda_spdif_out *spdif;
 	struct hda_bus *bus = codec->bus;
@@ -3099,8 +3042,8 @@ int snd_hda_create_dig_out_ctls(struct hda_codec *codec,
 			return err;
 	}
 	spdif->nid = cvt_nid;
-	spdif->ctls = snd_hda_codec_read(codec, cvt_nid, 0,
-					 AC_VERB_GET_DIGI_CONVERT_1, 0);
+	snd_hda_regmap_read(codec, cvt_nid, AC_VERB_GET_DIGI_CONVERT_1, &val);
+	spdif->ctls = val;
 	spdif->status = convert_to_spdif_status(spdif->ctls);
 	return 0;
 }
@@ -3244,8 +3187,8 @@ static int snd_hda_spdif_in_switch_put(struct snd_kcontrol *kcontrol,
 	change = codec->spdif_in_enable != val;
 	if (change) {
 		codec->spdif_in_enable = val;
-		snd_hda_codec_write_cache(codec, nid, 0,
-					  AC_VERB_SET_DIGI_CONVERT_1, val);
+		snd_hda_regmap_write(codec, nid,
+				     AC_VERB_SET_DIGI_CONVERT_1, val);
 	}
 	mutex_unlock(&codec->spdif_mutex);
 	return change;
@@ -3256,10 +3199,10 @@ static int snd_hda_spdif_in_status_get(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	hda_nid_t nid = kcontrol->private_value;
-	unsigned short val;
+	unsigned int val;
 	unsigned int sbits;
 
-	val = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_DIGI_CONVERT_1, 0);
+	snd_hda_regmap_read(codec, nid, AC_VERB_GET_DIGI_CONVERT_1, &val);
 	sbits = convert_to_spdif_status(val);
 	ucontrol->value.iec958.status[0] = sbits;
 	ucontrol->value.iec958.status[1] = sbits >> 8;
@@ -3325,154 +3268,6 @@ int snd_hda_create_spdif_in_ctls(struct hda_codec *codec, hda_nid_t nid)
 }
 EXPORT_SYMBOL_GPL(snd_hda_create_spdif_in_ctls);
 
-/*
- * command cache
- */
-
-/* build a 31bit cache key with the widget id and the command parameter */
-#define build_cmd_cache_key(nid, verb)	((verb << 8) | nid)
-#define get_cmd_cache_nid(key)		((key) & 0xff)
-#define get_cmd_cache_cmd(key)		(((key) >> 8) & 0xffff)
-
-/**
- * snd_hda_codec_write_cache - send a single command with caching
- * @codec: the HDA codec
- * @nid: NID to send the command
- * @flags: optional bit flags
- * @verb: the verb to send
- * @parm: the parameter for the verb
- *
- * Send a single command without waiting for response.
- *
- * Returns 0 if successful, or a negative error code.
- */
-int snd_hda_codec_write_cache(struct hda_codec *codec, hda_nid_t nid,
-			      int flags, unsigned int verb, unsigned int parm)
-{
-	int err;
-	struct hda_cache_head *c;
-	u32 key;
-	unsigned int cache_only;
-
-	cache_only = codec->cached_write;
-	if (!cache_only) {
-		err = snd_hda_codec_write(codec, nid, flags, verb, parm);
-		if (err < 0)
-			return err;
-	}
-
-	/* parm may contain the verb stuff for get/set amp */
-	verb = verb | (parm >> 8);
-	parm &= 0xff;
-	key = build_cmd_cache_key(nid, verb);
-	mutex_lock(&codec->bus->cmd_mutex);
-	c = get_alloc_hash(&codec->cmd_cache, key);
-	if (c) {
-		c->val = parm;
-		c->dirty = cache_only;
-	}
-	mutex_unlock(&codec->bus->cmd_mutex);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_hda_codec_write_cache);
-
-/**
- * snd_hda_codec_update_cache - check cache and write the cmd only when needed
- * @codec: the HDA codec
- * @nid: NID to send the command
- * @flags: optional bit flags
- * @verb: the verb to send
- * @parm: the parameter for the verb
- *
- * This function works like snd_hda_codec_write_cache(), but it doesn't send
- * command if the parameter is already identical with the cached value.
- * If not, it sends the command and refreshes the cache.
- *
- * Returns 0 if successful, or a negative error code.
- */
-int snd_hda_codec_update_cache(struct hda_codec *codec, hda_nid_t nid,
-			       int flags, unsigned int verb, unsigned int parm)
-{
-	struct hda_cache_head *c;
-	u32 key;
-
-	/* parm may contain the verb stuff for get/set amp */
-	verb = verb | (parm >> 8);
-	parm &= 0xff;
-	key = build_cmd_cache_key(nid, verb);
-	mutex_lock(&codec->bus->cmd_mutex);
-	c = get_hash(&codec->cmd_cache, key);
-	if (c && c->val == parm) {
-		mutex_unlock(&codec->bus->cmd_mutex);
-		return 0;
-	}
-	mutex_unlock(&codec->bus->cmd_mutex);
-	return snd_hda_codec_write_cache(codec, nid, flags, verb, parm);
-}
-EXPORT_SYMBOL_GPL(snd_hda_codec_update_cache);
-
-/**
- * snd_hda_codec_resume_cache - Resume the all commands from the cache
- * @codec: HD-audio codec
- *
- * Execute all verbs recorded in the command caches to resume.
- */
-void snd_hda_codec_resume_cache(struct hda_codec *codec)
-{
-	int i;
-
-	mutex_lock(&codec->hash_mutex);
-	codec->cached_write = 0;
-	for (i = 0; i < codec->cmd_cache.buf.used; i++) {
-		struct hda_cache_head *buffer;
-		u32 key;
-
-		buffer = snd_array_elem(&codec->cmd_cache.buf, i);
-		key = buffer->key;
-		if (!key)
-			continue;
-		if (!buffer->dirty)
-			continue;
-		buffer->dirty = 0;
-		mutex_unlock(&codec->hash_mutex);
-		snd_hda_codec_write(codec, get_cmd_cache_nid(key), 0,
-				    get_cmd_cache_cmd(key), buffer->val);
-		mutex_lock(&codec->hash_mutex);
-	}
-	mutex_unlock(&codec->hash_mutex);
-}
-EXPORT_SYMBOL_GPL(snd_hda_codec_resume_cache);
-
-/**
- * snd_hda_sequence_write_cache - sequence writes with caching
- * @codec: the HDA codec
- * @seq: VERB array to send
- *
- * Send the commands sequentially from the given array.
- * Thte commands are recorded on cache for power-save and resume.
- * The array must be terminated with NID=0.
- */
-void snd_hda_sequence_write_cache(struct hda_codec *codec,
-				  const struct hda_verb *seq)
-{
-	for (; seq->nid; seq++)
-		snd_hda_codec_write_cache(codec, seq->nid, 0, seq->verb,
-					  seq->param);
-}
-EXPORT_SYMBOL_GPL(snd_hda_sequence_write_cache);
-
-/**
- * snd_hda_codec_flush_cache - Execute all pending (cached) amps / verbs
- * @codec: HD-audio codec
- */
-void snd_hda_codec_flush_cache(struct hda_codec *codec)
-{
-	if (codec->regmap)
-		regcache_sync(codec->regmap);
-	snd_hda_codec_resume_cache(codec);
-}
-EXPORT_SYMBOL_GPL(snd_hda_codec_flush_cache);
-
 /**
  * snd_hda_codec_set_power_to_all - Set the power state to all widgets
  * @codec: the HDA codec
@@ -3692,17 +3487,6 @@ static unsigned int hda_call_codec_suspend(struct hda_codec *codec)
 	return state;
 }
 
-/* mark all entries of cmd and amp caches dirty */
-static void hda_mark_cmd_cache_dirty(struct hda_codec *codec)
-{
-	int i;
-	for (i = 0; i < codec->cmd_cache.buf.used; i++) {
-		struct hda_cache_head *cmd;
-		cmd = snd_array_elem(&codec->cmd_cache.buf, i);
-		cmd->dirty = 1;
-	}
-}
-
 /*
  * kick up codec; used both from PM and power-save
  */
@@ -3713,7 +3497,6 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 	trace_hda_power_up(codec);
 	if (codec->regmap)
 		regcache_mark_dirty(codec->regmap);
-	hda_mark_cmd_cache_dirty(codec);
 
 	codec->power_jiffies = jiffies;
 
@@ -3728,7 +3511,6 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 			codec->patch_ops.init(codec);
 		if (codec->regmap)
 			regcache_sync(codec->regmap);
-		snd_hda_codec_resume_cache(codec);
 	}
 
 	if (codec->jackpoll_interval)
@@ -4660,8 +4442,8 @@ int snd_hda_input_mux_put(struct hda_codec *codec,
 		idx = imux->num_items - 1;
 	if (*cur_val == idx)
 		return 0;
-	snd_hda_codec_write_cache(codec, nid, 0, AC_VERB_SET_CONNECT_SEL,
-				  imux->items[idx].index);
+	snd_hda_regmap_write(codec, nid, AC_VERB_SET_CONNECT_SEL,
+			     imux->items[idx].index);
 	*cur_val = idx;
 	return 1;
 }
@@ -5103,8 +4885,8 @@ int _snd_hda_set_pin_ctl(struct hda_codec *codec, hda_nid_t pin,
 	val = snd_hda_correct_pin_ctl(codec, pin, val);
 	snd_hda_codec_set_pin_target(codec, pin, val);
 	if (cached)
-		return snd_hda_codec_update_cache(codec, pin, 0,
-				AC_VERB_SET_PIN_WIDGET_CONTROL, val);
+		return snd_hda_regmap_write(codec, pin,
+					    AC_VERB_SET_PIN_WIDGET_CONTROL, val);
 	else
 		return snd_hda_codec_write(codec, pin, 0,
 					   AC_VERB_SET_PIN_WIDGET_CONTROL, val);
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 8cf7b2870dd1..634d07c2634b 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -204,19 +204,6 @@ struct hda_codec_ops {
 	void (*reboot_notify)(struct hda_codec *codec);
 };
 
-/* record for amp information cache */
-struct hda_cache_head {
-	u32 key:31;		/* hash key */
-	u32 dirty:1;
-	u16 val;		/* assigned value */
-	u16 next;
-};
-
-struct hda_cache_rec {
-	u16 hash[64];			/* hash table for index */
-	struct snd_array buf;		/* record entries */
-};
-
 /* PCM callbacks */
 struct hda_pcm_ops {
 	int (*open)(struct hda_pcm_stream *info, struct hda_codec *codec,
@@ -313,13 +300,10 @@ struct hda_codec {
 	struct snd_array mixers;	/* list of assigned mixer elements */
 	struct snd_array nids;		/* list of mapped mixer elements */
 
-	struct hda_cache_rec cmd_cache;	/* cache for other commands */
-
 	struct list_head conn_list;	/* linked-list of connection-list */
 
 	struct mutex spdif_mutex;
 	struct mutex control_mutex;
-	struct mutex hash_mutex;
 	struct snd_array spdif_out;
 	unsigned int spdif_in_enable;	/* SPDIF input enable? */
 	const hda_nid_t *slave_dig_outs; /* optional digital out slave widgets */
@@ -470,17 +454,6 @@ void snd_hda_sequence_write(struct hda_codec *codec,
 /* unsolicited event */
 int snd_hda_queue_unsol_event(struct hda_bus *bus, u32 res, u32 res_ex);
 
-/* cached write */
-int snd_hda_codec_write_cache(struct hda_codec *codec, hda_nid_t nid,
-			      int flags, unsigned int verb, unsigned int parm);
-void snd_hda_sequence_write_cache(struct hda_codec *codec,
-				  const struct hda_verb *seq);
-int snd_hda_codec_update_cache(struct hda_codec *codec, hda_nid_t nid,
-			      int flags, unsigned int verb, unsigned int parm);
-void snd_hda_codec_resume_cache(struct hda_codec *codec);
-/* both for cmd & amp caches */
-void snd_hda_codec_flush_cache(struct hda_codec *codec);
-
 /* the struct for codec->pin_configs */
 struct hda_pincfg {
 	hda_nid_t nid;
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 947d1a50f384..33de31c83d6e 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -203,8 +203,7 @@ static void parse_user_hints(struct hda_codec *codec)
  */
 
 #define update_pin_ctl(codec, pin, val) \
-	snd_hda_codec_update_cache(codec, pin, 0, \
-				   AC_VERB_SET_PIN_WIDGET_CONTROL, val)
+	snd_hda_regmap_write(codec, pin, AC_VERB_SET_PIN_WIDGET_CONTROL, val)
 
 /* restore the pinctl based on the cached value */
 static inline void restore_pin_ctl(struct hda_codec *codec, hda_nid_t pin)
@@ -802,9 +801,9 @@ void snd_hda_activate_path(struct hda_codec *codec, struct nid_path *path,
 						    AC_PWRST_D0);
 		}
 		if (enable && path->multi[i])
-			snd_hda_codec_update_cache(codec, nid, 0,
-					    AC_VERB_SET_CONNECT_SEL,
-					    path->idx[i]);
+			snd_hda_regmap_write(codec, nid,
+					     AC_VERB_SET_CONNECT_SEL,
+					     path->idx[i]);
 		if (has_amp_in(codec, path, i))
 			activate_amp_in(codec, path, i, enable, add_aamix);
 		if (has_amp_out(codec, path, i))
@@ -855,9 +854,8 @@ static void set_pin_eapd(struct hda_codec *codec, hda_nid_t pin, bool enable)
 		return;
 	if (codec->inv_eapd)
 		enable = !enable;
-	snd_hda_codec_update_cache(codec, pin, 0,
-				   AC_VERB_SET_EAPD_BTLENABLE,
-				   enable ? 0x02 : 0x00);
+	snd_hda_regmap_write(codec, pin, AC_VERB_SET_EAPD_BTLENABLE,
+			     enable ? 0x02 : 0x00);
 }
 
 /* re-initialize the path specified by the given path index */
@@ -3313,11 +3311,6 @@ static int cap_put_caller(struct snd_kcontrol *kcontrol,
 	imux = &spec->input_mux;
 	adc_idx = kcontrol->id.index;
 	mutex_lock(&codec->control_mutex);
-	/* we use the cache-only update at first since multiple input paths
-	 * may shared the same amp; by updating only caches, the redundant
-	 * writes to hardware can be reduced.
-	 */
-	codec->cached_write = 1;
 	for (i = 0; i < imux->num_items; i++) {
 		path = get_input_path(codec, adc_idx, i);
 		if (!path || !path->ctls[type])
@@ -3325,12 +3318,9 @@ static int cap_put_caller(struct snd_kcontrol *kcontrol,
 		kcontrol->private_value = path->ctls[type];
 		err = func(kcontrol, ucontrol);
 		if (err < 0)
-			goto error;
+			break;
 	}
- error:
-	codec->cached_write = 0;
 	mutex_unlock(&codec->control_mutex);
-	snd_hda_codec_flush_cache(codec); /* flush the updates */
 	if (err >= 0 && spec->cap_sync_hook)
 		spec->cap_sync_hook(codec, kcontrol, ucontrol);
 	return err;
@@ -5401,8 +5391,8 @@ static void clear_unsol_on_unused_pins(struct hda_codec *codec)
 		hda_nid_t nid = pin->nid;
 		if (is_jack_detectable(codec, nid) &&
 		    !snd_hda_jack_tbl_get(codec, nid))
-			snd_hda_codec_update_cache(codec, nid, 0,
-					AC_VERB_SET_UNSOLICITED_ENABLE, 0);
+			snd_hda_regmap_write(codec, nid,
+					     AC_VERB_SET_UNSOLICITED_ENABLE, 0);
 	}
 }
 
@@ -5421,8 +5411,6 @@ int snd_hda_gen_init(struct hda_codec *codec)
 
 	snd_hda_apply_verbs(codec);
 
-	codec->cached_write = 1;
-
 	init_multi_out(codec);
 	init_extra_out(codec);
 	init_multi_io(codec);
@@ -5436,7 +5424,7 @@ int snd_hda_gen_init(struct hda_codec *codec)
 	/* call init functions of standard auto-mute helpers */
 	update_automute_all(codec);
 
-	snd_hda_codec_flush_cache(codec);
+	regcache_sync(codec->regmap);
 
 	if (spec->vmaster_mute.sw_kctl && spec->vmaster_mute.hook)
 		snd_hda_sync_vmaster_hook(&spec->vmaster_mute);
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index e664307617bd..2e933783c83f 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -269,9 +269,9 @@ snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
 	jack->jack_detect = 1;
 	if (codec->jackpoll_interval > 0)
 		return callback; /* No unsol if we're polling instead */
-	err = snd_hda_codec_write_cache(codec, nid, 0,
-					 AC_VERB_SET_UNSOLICITED_ENABLE,
-					 AC_USRSP_EN | jack->tag);
+	err = snd_hda_regmap_write(codec, nid,
+				   AC_VERB_SET_UNSOLICITED_ENABLE,
+				   AC_USRSP_EN | jack->tag);
 	if (err < 0)
 		return ERR_PTR(err);
 	return callback;
diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index af4c7be86c27..628f479abb4f 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -148,9 +148,9 @@ static void ad_vmaster_eapd_hook(void *private_data, int enabled)
 		return;
 	if (codec->inv_eapd)
 		enabled = !enabled;
-	snd_hda_codec_update_cache(codec, spec->eapd_nid, 0,
-				   AC_VERB_SET_EAPD_BTLENABLE,
-				   enabled ? 0x02 : 0x00);
+	snd_hda_regmap_write(codec, spec->eapd_nid,
+			     AC_VERB_SET_EAPD_BTLENABLE,
+			     enabled ? 0x02 : 0x00);
 }
 
 /*
@@ -501,8 +501,7 @@ static int ad1983_auto_smux_enum_put(struct snd_kcontrol *kcontrol,
 	if (spec->cur_smux == val)
 		return 0;
 	spec->cur_smux = val;
-	snd_hda_codec_write_cache(codec, dig_out, 0,
-				  AC_VERB_SET_CONNECT_SEL, val);
+	snd_hda_regmap_write(codec, dig_out, AC_VERB_SET_CONNECT_SEL, val);
 	return 1;
 }
 
@@ -777,7 +776,6 @@ static int ad1988_auto_smux_enum_put(struct snd_kcontrol *kcontrol,
 		return 0;
 
 	mutex_lock(&codec->control_mutex);
-	codec->cached_write = 1;
 	path = snd_hda_get_path_from_idx(codec,
 					 spec->smux_paths[spec->cur_smux]);
 	if (path)
@@ -786,9 +784,7 @@ static int ad1988_auto_smux_enum_put(struct snd_kcontrol *kcontrol,
 	if (path)
 		snd_hda_activate_path(codec, path, true, true);
 	spec->cur_smux = val;
-	codec->cached_write = 0;
 	mutex_unlock(&codec->control_mutex);
-	snd_hda_codec_flush_cache(codec); /* flush the updates */
 	return 1;
 }
 
@@ -995,27 +991,25 @@ static void ad1884_vmaster_hp_gpio_hook(void *private_data, int enabled)
 
 	if (spec->eapd_nid)
 		ad_vmaster_eapd_hook(private_data, enabled);
-	snd_hda_codec_update_cache(codec, 0x01, 0,
-				   AC_VERB_SET_GPIO_DATA,
-				   enabled ? 0x00 : 0x02);
+	snd_hda_regmap_write(codec, 0x01, AC_VERB_SET_GPIO_DATA,
+			     enabled ? 0x00 : 0x02);
 }
 
 static void ad1884_fixup_hp_eapd(struct hda_codec *codec,
 				 const struct hda_fixup *fix, int action)
 {
 	struct ad198x_spec *spec = codec->spec;
-	static const struct hda_verb gpio_init_verbs[] = {
-		{0x01, AC_VERB_SET_GPIO_MASK, 0x02},
-		{0x01, AC_VERB_SET_GPIO_DIRECTION, 0x02},
-		{0x01, AC_VERB_SET_GPIO_DATA, 0x02},
-		{},
-	};
 
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
 		spec->gen.vmaster_mute.hook = ad1884_vmaster_hp_gpio_hook;
 		spec->gen.own_eapd_ctl = 1;
-		snd_hda_sequence_write_cache(codec, gpio_init_verbs);
+		snd_hda_regmap_write(codec, 0x01,
+				     AC_VERB_SET_GPIO_MASK, 0x02);
+		snd_hda_regmap_write(codec, 0x01,
+				     AC_VERB_SET_GPIO_DIRECTION, 0x02);
+		snd_hda_regmap_write(codec, 0x01,
+				     AC_VERB_SET_GPIO_DATA, 0x02);
 		break;
 	case HDA_FIXUP_ACT_PROBE:
 		if (spec->gen.autocfg.line_out_type == AUTO_PIN_SPEAKER_OUT)
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 15a0a7d38c35..382b71cd28dc 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -278,10 +278,10 @@ static void cxt_update_headset_mode(struct hda_codec *codec)
 		}
 
 	if (mic_mode) {
-		snd_hda_codec_write_cache(codec, 0x1c, 0, 0x410, 0x7c); /* enable merged mode for analog int-mic */
+		snd_hda_regmap_write(codec, 0x1c, 0x410, 0x7c); /* enable merged mode for analog int-mic */
 		spec->gen.hp_jack_present = false;
 	} else {
-		snd_hda_codec_write_cache(codec, 0x1c, 0, 0x410, 0x54); /* disable merged mode for analog int-mic */
+		snd_hda_regmap_write(codec, 0x1c, 0x410, 0x54); /* disable merged mode for analog int-mic */
 		spec->gen.hp_jack_present = snd_hda_jack_detect(codec, spec->gen.autocfg.hp_pins[0]);
 	}
 
@@ -303,6 +303,7 @@ static void cxt_fixup_headphone_mic(struct hda_codec *codec,
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
 		spec->parse_flags |= HDA_PINCFG_HEADPHONE_MIC;
+		snd_hda_regmap_add_vendor_verb(codec, 0x410);
 		break;
 	case HDA_FIXUP_ACT_PROBE:
 		spec->gen.cap_sync_hook = cxt_update_headset_mode_hook;
@@ -324,8 +325,7 @@ static void cxt_fixup_headphone_mic(struct hda_codec *codec,
  * control. */
 
 #define update_mic_pin(codec, nid, val)					\
-	snd_hda_codec_update_cache(codec, nid, 0,			\
-				   AC_VERB_SET_PIN_WIDGET_CONTROL, val)
+	snd_hda_regmap_write(codec, nid, AC_VERB_SET_PIN_WIDGET_CONTROL, val)
 
 static const struct hda_input_mux olpc_xo_dc_bias = {
 	.num_items = 3,
@@ -410,15 +410,11 @@ static void olpc_xo_automic(struct hda_codec *codec,
 			    struct hda_jack_callback *jack)
 {
 	struct conexant_spec *spec = codec->spec;
-	int saved_cached_write = codec->cached_write;
 
-	codec->cached_write = 1;
 	/* in DC mode, we don't handle automic */
 	if (!spec->dc_enable)
 		snd_hda_gen_mic_autoswitch(codec, jack);
 	olpc_xo_update_mic_pins(codec);
-	snd_hda_codec_flush_cache(codec);
-	codec->cached_write = saved_cached_write;
 	if (spec->dc_enable)
 		olpc_xo_update_mic_boost(codec);
 }
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index a930408d2bb8..78f8c2ed86f9 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1375,9 +1375,8 @@ static void intel_verify_pin_cvt_connect(struct hda_codec *codec,
 	curr = snd_hda_codec_read(codec, pin_nid, 0,
 					  AC_VERB_GET_CONNECT_SEL, 0);
 	if (curr != mux_idx)
-		snd_hda_codec_write_cache(codec, pin_nid, 0,
-					    AC_VERB_SET_CONNECT_SEL,
-					    mux_idx);
+		snd_hda_regmap_write(codec, pin_nid,
+				     AC_VERB_SET_CONNECT_SEL, mux_idx);
 }
 
 /* Intel HDMI workaround to fix audio routing issue:
@@ -1423,9 +1422,9 @@ static void intel_not_share_assigned_cvt(struct hda_codec *codec,
 				codec_dbg(codec,
 					  "choose cvt %d for pin nid %d\n",
 					cvt_idx, nid);
-				snd_hda_codec_write_cache(codec, nid, 0,
-					    AC_VERB_SET_CONNECT_SEL,
-					    cvt_idx);
+				snd_hda_regmap_write(codec, nid,
+						     AC_VERB_SET_CONNECT_SEL,
+						     cvt_idx);
 				break;
 			}
 		}
@@ -1464,9 +1463,8 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 	per_pin->cvt_nid = per_cvt->cvt_nid;
 	hinfo->nid = per_cvt->cvt_nid;
 
-	snd_hda_codec_write_cache(codec, per_pin->pin_nid, 0,
-			    AC_VERB_SET_CONNECT_SEL,
-			    mux_idx);
+	snd_hda_regmap_write(codec, per_pin->pin_nid,
+			     AC_VERB_SET_CONNECT_SEL, mux_idx);
 
 	/* configure unused pins to choose other converters */
 	if (is_haswell_plus(codec) || is_valleyview_plus(codec))
@@ -2221,7 +2219,6 @@ static int generic_hdmi_resume(struct hda_codec *codec)
 
 	codec->patch_ops.init(codec);
 	regcache_sync(codec->regmap);
-	snd_hda_codec_resume_cache(codec);
 
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
 		struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
@@ -2308,8 +2305,9 @@ static void intel_haswell_fixup_enable_dp12(struct hda_codec *codec)
 
 	/* enable DP1.2 mode */
 	vendor_param |= INTEL_EN_DP12;
-	snd_hda_codec_write_cache(codec, INTEL_VENDOR_NID, 0,
-				INTEL_SET_VENDOR_VERB, vendor_param);
+	snd_hda_regmap_add_vendor_verb(codec, INTEL_VENDOR_NID);
+	snd_hda_regmap_write(codec, INTEL_VENDOR_NID,
+			     INTEL_SET_VENDOR_VERB, vendor_param);
 }
 
 /* Haswell needs to re-issue the vendor-specific verbs before turning to D0.
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3b495ec41e33..f035ed376c23 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -800,7 +800,6 @@ static int alc_resume(struct hda_codec *codec)
 		msleep(150); /* to avoid pop noise */
 	codec->patch_ops.init(codec);
 	regcache_sync(codec->regmap);
-	snd_hda_codec_resume_cache(codec);
 	hda_call_check_power_status(codec, 0x01);
 	return 0;
 }
@@ -3100,7 +3099,6 @@ static int alc269_resume(struct hda_codec *codec)
 	}
 
 	regcache_sync(codec->regmap);
-	snd_hda_codec_resume_cache(codec);
 	hda_call_check_power_status(codec, 0x01);
 
 	/* on some machine, the BIOS will clear the codec gpio data when enter
@@ -3520,8 +3518,9 @@ static void alc280_fixup_hp_gpio2_mic_hotkey(struct hda_codec *codec,
 		}
 
 		snd_hda_add_verbs(codec, gpio_init);
-		snd_hda_codec_write_cache(codec, codec->afg, 0,
-					  AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x04);
+		snd_hda_regmap_write(codec, codec->afg,
+				     AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK,
+				     0x04);
 		snd_hda_jack_detect_enable_callback(codec, codec->afg,
 						    gpio2_mic_hotkey_event);
 
diff --git a/sound/pci/hda/patch_si3054.c b/sound/pci/hda/patch_si3054.c
index 38a477333321..3179479d1f43 100644
--- a/sound/pci/hda/patch_si3054.c
+++ b/sound/pci/hda/patch_si3054.c
@@ -78,7 +78,7 @@
 #define GET_REG(codec,reg) (snd_hda_codec_read(codec,reg,0,SI3054_VERB_READ_NODE,0))
 #define SET_REG(codec,reg,val) (snd_hda_codec_write(codec,reg,0,SI3054_VERB_WRITE_NODE,val))
 #define SET_REG_CACHE(codec,reg,val) \
-	snd_hda_codec_write_cache(codec,reg,0,SI3054_VERB_WRITE_NODE,val)
+	snd_hda_regmap_write(codec, reg, SI3054_VERB_WRITE_NODE, val)
 
 
 struct si3054_spec {
@@ -223,6 +223,9 @@ static int si3054_init(struct hda_codec *codec)
 	unsigned wait_count;
 	u16 val;
 
+	if (snd_hda_regmap_add_vendor_verb(codec, SI3054_VERB_WRITE_NODE))
+		return -ENOMEM;
+
 	snd_hda_codec_write(codec, AC_NODE_ROOT, 0, AC_VERB_SET_CODEC_RESET, 0);
 	snd_hda_codec_write(codec, codec->mfg, 0, AC_VERB_SET_STREAM_FORMAT, 0);
 	SET_REG(codec, SI3054_LINE_RATE, 9600);
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 2956a6ba6bf0..124e40256e6c 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -634,8 +634,8 @@ static int stac_aloopback_put(struct snd_kcontrol *kcontrol,
 		dac_mode &= ~idx_val;
 	}
 
-	snd_hda_codec_write_cache(codec, codec->afg, 0,
-		kcontrol->private_value >> 16, dac_mode);
+	snd_hda_regmap_write(codec, codec->afg,
+			     kcontrol->private_value >> 16, dac_mode);
 
 	return 1;
 }
@@ -1048,12 +1048,9 @@ static const struct hda_verb stac92hd71bxx_core_init[] = {
 	{}
 };
 
-static const struct hda_verb stac92hd71bxx_unmute_core_init[] = {
+static const hda_nid_t stac92hd71bxx_unmute_nids[] = {
 	/* unmute right and left channels for nodes 0x0f, 0xa, 0x0d */
-	{ 0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{ 0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{ 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{}
+	0x0f, 0x0a, 0x0d, 0
 };
 
 static const struct hda_verb stac925x_core_init[] = {
@@ -3031,8 +3028,8 @@ static void stac92hd71bxx_fixup_hp_m4(struct hda_codec *codec,
 		return;
 
 	/* Enable VREF power saving on GPIO1 detect */
-	snd_hda_codec_write_cache(codec, codec->afg, 0,
-				  AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x02);
+	snd_hda_regmap_write(codec, codec->afg,
+			     AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x02);
 	jack = snd_hda_jack_detect_enable_callback(codec, codec->afg,
 						   stac_vref_event);
 	if (!IS_ERR(jack))
@@ -4053,8 +4050,9 @@ static void stac9205_fixup_dell_m43(struct hda_codec *codec,
 		snd_hda_apply_pincfgs(codec, dell_9205_m43_pin_configs);
 
 		/* Enable unsol response for GPIO4/Dock HP connection */
-		snd_hda_codec_write_cache(codec, codec->afg, 0,
-			AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x10);
+		snd_hda_regmap_write(codec, codec->afg,
+				     AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK,
+				     0x10);
 		jack = snd_hda_jack_detect_enable_callback(codec, codec->afg,
 							   stac_vref_event);
 		if (!IS_ERR(jack))
@@ -4261,6 +4259,10 @@ static int stac_parse_auto_config(struct hda_codec *codec)
 
 	if (spec->aloopback_ctl &&
 	    snd_hda_get_bool_hint(codec, "loopback") == 1) {
+		unsigned int wr_verb =
+			spec->aloopback_ctl->private_value >> 16;
+		if (snd_hda_regmap_add_vendor_verb(codec, wr_verb))
+			return -ENOMEM;
 		if (!snd_hda_gen_add_kctl(&spec->gen, NULL, spec->aloopback_ctl))
 			return -ENOMEM;
 	}
@@ -4674,7 +4676,7 @@ static int patch_stac92hd95(struct hda_codec *codec)
 static int patch_stac92hd71bxx(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec;
-	const struct hda_verb *unmute_init = stac92hd71bxx_unmute_core_init;
+	const hda_nid_t *unmute_nids = stac92hd71bxx_unmute_nids;
 	int err;
 
 	err = alloc_stac_spec(codec);
@@ -4698,7 +4700,7 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)
 	switch (codec->vendor_id) {
 	case 0x111d76b6: /* 4 Port without Analog Mixer */
 	case 0x111d76b7:
-		unmute_init++;
+		unmute_nids++;
 		break;
 	case 0x111d7608: /* 5 Port with Analog Mixer */
 		if ((codec->revision_id & 0xf) == 0 ||
@@ -4706,7 +4708,7 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)
 			spec->stream_delay = 40; /* 40 milliseconds */
 
 		/* disable VSW */
-		unmute_init++;
+		unmute_nids++;
 		snd_hda_codec_set_pincfg(codec, 0x0f, 0x40f000f0);
 		snd_hda_codec_set_pincfg(codec, 0x19, 0x40f000f3);
 		break;
@@ -4720,8 +4722,12 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)
 	if (get_wcaps_type(get_wcaps(codec, 0x28)) == AC_WID_VOL_KNB)
 		snd_hda_add_verbs(codec, stac92hd71bxx_core_init);
 
-	if (get_wcaps(codec, 0xa) & AC_WCAP_IN_AMP)
-		snd_hda_sequence_write_cache(codec, unmute_init);
+	if (get_wcaps(codec, 0xa) & AC_WCAP_IN_AMP) {
+		const hda_nid_t *p;
+		for (p = unmute_nids; *p; p++)
+			snd_hda_codec_amp_init_stereo(codec, *p, HDA_INPUT, 0,
+						      0xff, 0x00);
+	}
 
 	spec->aloopback_ctl = &stac92hd71bxx_loopback;
 	spec->aloopback_mask = 0x50;
-- 
2.3.0
