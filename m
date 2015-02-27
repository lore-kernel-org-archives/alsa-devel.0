From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/7] ALSA: hda - Use regmap for parameter
	caches, too
Date: Fri, 27 Feb 2015 22:28:19 +0100
Message-ID: <1425072502-3204-5-git-send-email-tiwai@suse.de>
References: <1425072502-3204-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C885A2612CC
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 22:28:27 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 617E6AC47
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

The amp hash table was used for recording the cached reads of some
capability values like pin caps or amp caps.  Now all these are moved
to regmap as well.

One addition to the regmap helper is codec->caps_overwriting flag.
This is set in override_parameters(), and the regmap helper accepts
any register while this flag is set, so that it can overwrite even the
read-only verb like AC_VERB_PARAMETERS.  The flag is cleared
immediately in override_parameters(), as it's a once-off flag.

Along with these changes, the no longer needed amp hash and relevant
fields are removed from hda_codec struct now.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c  | 133 ++++++++-------------------------------------
 sound/pci/hda/hda_codec.h  |   8 +--
 sound/pci/hda/hda_local.h  |  19 ++++++-
 sound/pci/hda/hda_regmap.c |   8 +++
 4 files changed, 51 insertions(+), 117 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 3e6976b52231..8781632dff96 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1158,7 +1158,6 @@ static void snd_hda_codec_free(struct hda_codec *codec)
 	codec->bus->caddr_tbl[codec->addr] = NULL;
 	clear_bit(codec->addr, &codec->bus->codec_powered);
 	snd_hda_sysfs_clear(codec);
-	free_hda_cache(&codec->amp_cache);
 	free_hda_cache(&codec->cmd_cache);
 	kfree(codec->vendor_name);
 	kfree(codec->chip_name);
@@ -1262,7 +1261,6 @@ int snd_hda_codec_new(struct hda_bus *bus,
 	mutex_init(&codec->spdif_mutex);
 	mutex_init(&codec->control_mutex);
 	mutex_init(&codec->hash_mutex);
-	init_hda_cache(&codec->amp_cache, sizeof(struct hda_amp_info));
 	init_hda_cache(&codec->cmd_cache, sizeof(struct hda_cache_head));
 	snd_array_init(&codec->mixers, sizeof(struct hda_nid_item), 32);
 	snd_array_init(&codec->nids, sizeof(struct hda_nid_item), 32);
@@ -1630,65 +1628,20 @@ static struct hda_cache_head  *get_alloc_hash(struct hda_cache_rec *cache,
 	return info;
 }
 
-/* query and allocate an amp hash entry */
-static inline struct hda_amp_info *
-get_alloc_amp_hash(struct hda_codec *codec, u32 key)
+/* override the parameter */
+static int override_parameter(struct hda_codec *codec, hda_nid_t nid,
+			      unsigned int parm, unsigned int val)
 {
-	return (struct hda_amp_info *)get_alloc_hash(&codec->amp_cache, key);
-}
-
-/* overwrite the value with the key in the caps hash */
-static int write_caps_hash(struct hda_codec *codec, u32 key, unsigned int val)
-{
-	struct hda_amp_info *info;
+	unsigned int verb = (AC_VERB_PARAMETERS << 8) | (nid << 20) | parm;
+	int err;
 
-	mutex_lock(&codec->hash_mutex);
-	info = get_alloc_amp_hash(codec, key);
-	if (!info) {
-		mutex_unlock(&codec->hash_mutex);
+	if (!codec->regmap)
 		return -EINVAL;
-	}
-	info->amp_caps = val;
-	info->head.val |= INFO_AMP_CAPS;
-	mutex_unlock(&codec->hash_mutex);
-	return 0;
-}
-
-/* query the value from the caps hash; if not found, fetch the current
- * value from the given function and store in the hash
- */
-static unsigned int
-query_caps_hash(struct hda_codec *codec, hda_nid_t nid, int dir, u32 key,
-		unsigned int (*func)(struct hda_codec *, hda_nid_t, int))
-{
-	struct hda_amp_info *info;
-	unsigned int val;
 
-	mutex_lock(&codec->hash_mutex);
-	info = get_alloc_amp_hash(codec, key);
-	if (!info) {
-		mutex_unlock(&codec->hash_mutex);
-		return 0;
-	}
-	if (!(info->head.val & INFO_AMP_CAPS)) {
-		mutex_unlock(&codec->hash_mutex); /* for reentrance */
-		val = func(codec, nid, dir);
-		write_caps_hash(codec, key, val);
-	} else {
-		val = info->amp_caps;
-		mutex_unlock(&codec->hash_mutex);
-	}
-	return val;
-}
-
-static unsigned int read_amp_cap(struct hda_codec *codec, hda_nid_t nid,
-				 int direction)
-{
-	if (!(get_wcaps(codec, nid) & AC_WCAP_AMP_OVRD))
-		nid = codec->afg;
-	return snd_hda_param_read(codec, nid,
-				  direction == HDA_OUTPUT ?
-				  AC_PAR_AMP_OUT_CAP : AC_PAR_AMP_IN_CAP);
+	codec->caps_overwriting = true;
+	err = snd_hda_reg_raw_write(codec, verb, val);
+	codec->caps_overwriting = false;
+	return err;
 }
 
 /**
@@ -1705,9 +1658,11 @@ static unsigned int read_amp_cap(struct hda_codec *codec, hda_nid_t nid,
  */
 u32 query_amp_caps(struct hda_codec *codec, hda_nid_t nid, int direction)
 {
-	return query_caps_hash(codec, nid, direction,
-			       HDA_HASH_KEY(nid, direction, 0),
-			       read_amp_cap);
+	if (!(get_wcaps(codec, nid) & AC_WCAP_AMP_OVRD))
+		nid = codec->afg;
+	return snd_hda_param_read(codec, nid,
+				  direction == HDA_OUTPUT ?
+				  AC_PAR_AMP_OUT_CAP : AC_PAR_AMP_IN_CAP);
 }
 EXPORT_SYMBOL_GPL(query_amp_caps);
 
@@ -1748,33 +1703,14 @@ EXPORT_SYMBOL_GPL(snd_hda_check_amp_caps);
 int snd_hda_override_amp_caps(struct hda_codec *codec, hda_nid_t nid, int dir,
 			      unsigned int caps)
 {
-	return write_caps_hash(codec, HDA_HASH_KEY(nid, dir, 0), caps);
-}
-EXPORT_SYMBOL_GPL(snd_hda_override_amp_caps);
-
-static unsigned int read_pin_cap(struct hda_codec *codec, hda_nid_t nid,
-				 int dir)
-{
-	return snd_hda_param_read(codec, nid, AC_PAR_PIN_CAP);
-}
+	unsigned int parm;
 
-/**
- * snd_hda_query_pin_caps - Query PIN capabilities
- * @codec: the HD-auio codec
- * @nid: the NID to query
- *
- * Query PIN capabilities for the given widget.
- * Returns the obtained capability bits.
- *
- * When cap bits have been already read, this doesn't read again but
- * returns the cached value.
- */
-u32 snd_hda_query_pin_caps(struct hda_codec *codec, hda_nid_t nid)
-{
-	return query_caps_hash(codec, nid, 0, HDA_HASH_PINCAP_KEY(nid),
-			       read_pin_cap);
+	snd_hda_override_wcaps(codec, nid,
+			       get_wcaps(codec, nid) | AC_WCAP_AMP_OVRD);
+	parm = dir == HDA_OUTPUT ? AC_PAR_AMP_OUT_CAP : AC_PAR_AMP_IN_CAP;
+	return override_parameter(codec, nid, parm, caps);
 }
-EXPORT_SYMBOL_GPL(snd_hda_query_pin_caps);
+EXPORT_SYMBOL_GPL(snd_hda_override_amp_caps);
 
 /**
  * snd_hda_override_pin_caps - Override the pin capabilities
@@ -1789,7 +1725,7 @@ EXPORT_SYMBOL_GPL(snd_hda_query_pin_caps);
 int snd_hda_override_pin_caps(struct hda_codec *codec, hda_nid_t nid,
 			      unsigned int caps)
 {
-	return write_caps_hash(codec, HDA_HASH_PINCAP_KEY(nid), caps);
+	return override_parameter(codec, nid, AC_PAR_PIN_CAP, caps);
 }
 EXPORT_SYMBOL_GPL(snd_hda_override_pin_caps);
 
@@ -2303,9 +2239,7 @@ int snd_hda_codec_reset(struct hda_codec *codec)
 	snd_hda_jack_tbl_clear(codec);
 	codec->proc_widget_hook = NULL;
 	codec->spec = NULL;
-	free_hda_cache(&codec->amp_cache);
 	free_hda_cache(&codec->cmd_cache);
-	init_hda_cache(&codec->amp_cache, sizeof(struct hda_amp_info));
 	init_hda_cache(&codec->cmd_cache, sizeof(struct hda_cache_head));
 	/* free only driver_pins so that init_pins + user_pins are restored */
 	snd_array_free(&codec->driver_pins);
@@ -3767,11 +3701,6 @@ static void hda_mark_cmd_cache_dirty(struct hda_codec *codec)
 		cmd = snd_array_elem(&codec->cmd_cache.buf, i);
 		cmd->dirty = 1;
 	}
-	for (i = 0; i < codec->amp_cache.buf.used; i++) {
-		struct hda_amp_info *amp;
-		amp = snd_array_elem(&codec->amp_cache.buf, i);
-		amp->head.dirty = 1;
-	}
 }
 
 /*
@@ -4049,8 +3978,7 @@ unsigned int snd_hda_calc_stream_format(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_hda_calc_stream_format);
 
-static unsigned int get_pcm_param(struct hda_codec *codec, hda_nid_t nid,
-				  int dir)
+static unsigned int query_pcm_param(struct hda_codec *codec, hda_nid_t nid)
 {
 	unsigned int val = 0;
 	if (nid != codec->afg &&
@@ -4063,14 +3991,7 @@ static unsigned int get_pcm_param(struct hda_codec *codec, hda_nid_t nid,
 	return val;
 }
 
-static unsigned int query_pcm_param(struct hda_codec *codec, hda_nid_t nid)
-{
-	return query_caps_hash(codec, nid, 0, HDA_HASH_PARPCM_KEY(nid),
-			       get_pcm_param);
-}
-
-static unsigned int get_stream_param(struct hda_codec *codec, hda_nid_t nid,
-				     int dir)
+static unsigned int query_stream_param(struct hda_codec *codec, hda_nid_t nid)
 {
 	unsigned int streams = snd_hda_param_read(codec, nid, AC_PAR_STREAM);
 	if (!streams || streams == -1)
@@ -4080,12 +4001,6 @@ static unsigned int get_stream_param(struct hda_codec *codec, hda_nid_t nid,
 	return streams;
 }
 
-static unsigned int query_stream_param(struct hda_codec *codec, hda_nid_t nid)
-{
-	return query_caps_hash(codec, nid, 0, HDA_HASH_PARSTR_KEY(nid),
-			       get_stream_param);
-}
-
 /**
  * snd_hda_query_supported_pcm - query the supported PCM rates and formats
  * @codec: the HDA codec
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index db310e9c53ff..953625c85ee4 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -212,12 +212,6 @@ struct hda_cache_head {
 	u16 next;
 };
 
-struct hda_amp_info {
-	struct hda_cache_head head;
-	u32 amp_caps;		/* amp capabilities */
-	u16 vol[2];		/* current volume & mute */
-};
-
 struct hda_cache_rec {
 	u16 hash[64];			/* hash table for index */
 	struct snd_array buf;		/* record entries */
@@ -319,7 +313,6 @@ struct hda_codec {
 	struct snd_array mixers;	/* list of assigned mixer elements */
 	struct snd_array nids;		/* list of mapped mixer elements */
 
-	struct hda_cache_rec amp_cache;	/* cache for amp access */
 	struct hda_cache_rec cmd_cache;	/* cache for other commands */
 
 	struct list_head conn_list;	/* linked-list of connection-list */
@@ -405,6 +398,7 @@ struct hda_codec {
 
 	/* regmap */
 	struct regmap *regmap;
+	bool caps_overwriting; /* caps overwrite being in process */
 };
 
 #define dev_to_hda_codec(_dev)	container_of(_dev, struct hda_codec, dev)
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index be0654173d45..0da5796b4690 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -554,7 +554,24 @@ static inline void snd_hda_override_wcaps(struct hda_codec *codec,
 u32 query_amp_caps(struct hda_codec *codec, hda_nid_t nid, int direction);
 int snd_hda_override_amp_caps(struct hda_codec *codec, hda_nid_t nid, int dir,
 			      unsigned int caps);
-u32 snd_hda_query_pin_caps(struct hda_codec *codec, hda_nid_t nid);
+/**
+ * snd_hda_query_pin_caps - Query PIN capabilities
+ * @codec: the HD-auio codec
+ * @nid: the NID to query
+ *
+ * Query PIN capabilities for the given widget.
+ * Returns the obtained capability bits.
+ *
+ * When cap bits have been already read, this doesn't read again but
+ * returns the cached value.
+ */
+static inline u32
+snd_hda_query_pin_caps(struct hda_codec *codec, hda_nid_t nid)
+{
+	return snd_hda_param_read(codec, nid, AC_PAR_PIN_CAP);
+
+}
+
 int snd_hda_override_pin_caps(struct hda_codec *codec, hda_nid_t nid,
 			      unsigned int caps);
 bool snd_hda_check_amp_caps(struct hda_codec *codec, hda_nid_t nid,
diff --git a/sound/pci/hda/hda_regmap.c b/sound/pci/hda/hda_regmap.c
index 715d770901b5..8f12c23f3489 100644
--- a/sound/pci/hda/hda_regmap.c
+++ b/sound/pci/hda/hda_regmap.c
@@ -33,8 +33,12 @@
 
 static bool hda_writeable_reg(struct device *dev, unsigned int reg)
 {
+	struct hda_codec *codec = dev_to_hda_codec(dev);
 	unsigned int verb = get_verb(reg);
 
+	if (codec->caps_overwriting)
+		return true;
+
 	switch (verb & 0xf00) {
 	case AC_VERB_GET_STREAM_FORMAT:
 	case AC_VERB_GET_AMP_GAIN_MUTE:
@@ -70,8 +74,12 @@ static bool hda_writeable_reg(struct device *dev, unsigned int reg)
 
 static bool hda_readable_reg(struct device *dev, unsigned int reg)
 {
+	struct hda_codec *codec = dev_to_hda_codec(dev);
 	unsigned int verb = get_verb(reg);
 
+	if (codec->caps_overwriting)
+		return true;
+
 	switch (verb) {
 	case AC_VERB_PARAMETERS:
 	case AC_VERB_GET_CONNECT_LIST:
-- 
2.3.0
