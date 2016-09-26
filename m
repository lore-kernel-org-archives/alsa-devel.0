From: libin.yang@linux.intel.com
Subject: [RFC PATCH 1/3] ALSA: hda - codec add DP MST support
	for connection list
Date: Mon, 26 Sep 2016 16:35:36 +0800
Message-ID: <1474878938-10260-2-git-send-email-libin.yang@linux.intel.com>
References: <1474878938-10260-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 722B1266D02
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 10:40:08 +0200 (CEST)
In-Reply-To: <1474878938-10260-1-git-send-email-libin.yang@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, mengdong.lin@intel.com, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

This patches adds the support of connection list for DP MST.
With this, hdmi driver in DP MST mode can easily reuse
the connection list mechanism.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/hda_codec.c      | 52 +++++++++++++++++++++++++++---------------
 sound/pci/hda/hda_codec.h      | 15 ++++++------
 sound/pci/hda/hda_generic.c    | 18 +++++++--------
 sound/pci/hda/hda_proc.c       |  2 +-
 sound/pci/hda/patch_analog.c   | 18 ++++++++-------
 sound/pci/hda/patch_hdmi.c     |  8 ++++---
 sound/pci/hda/patch_realtek.c  | 22 +++++++++---------
 sound/pci/hda/patch_sigmatel.c |  4 ++--
 sound/pci/hda/patch_via.c      | 10 ++++----
 9 files changed, 85 insertions(+), 64 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 9913be8..32e21e8 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -110,23 +110,24 @@ struct hda_conn_list {
 	struct list_head list;
 	int len;
 	hda_nid_t nid;
+	int dev_id;
 	hda_nid_t conns[0];
 };
 
 /* look up the cached results */
 static struct hda_conn_list *
-lookup_conn_list(struct hda_codec *codec, hda_nid_t nid)
+lookup_conn_list(struct hda_codec *codec, hda_nid_t nid, int dev_id)
 {
 	struct hda_conn_list *p;
 	list_for_each_entry(p, &codec->conn_list, list) {
-		if (p->nid == nid)
+		if ((p->nid == nid) && (p->dev_id == dev_id))
 			return p;
 	}
 	return NULL;
 }
 
-static int add_conn_list(struct hda_codec *codec, hda_nid_t nid, int len,
-			 const hda_nid_t *list)
+static int add_conn_list(struct hda_codec *codec, hda_nid_t nid,
+			 int dev_id, int len, const hda_nid_t *list)
 {
 	struct hda_conn_list *p;
 
@@ -135,6 +136,7 @@ static int add_conn_list(struct hda_codec *codec, hda_nid_t nid, int len,
 		return -ENOMEM;
 	p->len = len;
 	p->nid = nid;
+	p->dev_id = dev_id;
 	memcpy(p->conns, list, len * sizeof(hda_nid_t));
 	list_add(&p->list, &codec->conn_list);
 	return 0;
@@ -150,8 +152,13 @@ static void remove_conn_list(struct hda_codec *codec)
 	}
 }
 
-/* read the connection and add to the cache */
-static int read_and_add_raw_conns(struct hda_codec *codec, hda_nid_t nid)
+/*
+ * read the connection and add to the cache
+ * the caller should select the device entry by sending the
+ * corresponding verb if necessary before calling this function
+ */
+static int read_and_add_raw_conns(struct hda_codec *codec, hda_nid_t nid,
+				  int dev_id)
 {
 	hda_nid_t list[32];
 	hda_nid_t *result = list;
@@ -166,7 +173,8 @@ static int read_and_add_raw_conns(struct hda_codec *codec, hda_nid_t nid)
 		len = snd_hda_get_raw_connections(codec, nid, result, len);
 	}
 	if (len >= 0)
-		len = snd_hda_override_conn_list(codec, nid, len, result);
+		len = snd_hda_override_conn_list(codec, nid, dev_id,
+						 len, result);
 	if (result != list)
 		kfree(result);
 	return len;
@@ -176,6 +184,7 @@ static int read_and_add_raw_conns(struct hda_codec *codec, hda_nid_t nid)
  * snd_hda_get_conn_list - get connection list
  * @codec: the HDA codec
  * @nid: NID to parse
+ * @dev_id: device entry id
  * @listp: the pointer to store NID list
  *
  * Parses the connection list of the given widget and stores the pointer
@@ -188,7 +197,7 @@ static int read_and_add_raw_conns(struct hda_codec *codec, hda_nid_t nid)
  * concurrently, protect with a mutex appropriately.
  */
 int snd_hda_get_conn_list(struct hda_codec *codec, hda_nid_t nid,
-			  const hda_nid_t **listp)
+			  int dev_id, const hda_nid_t **listp)
 {
 	bool added = false;
 
@@ -197,7 +206,7 @@ int snd_hda_get_conn_list(struct hda_codec *codec, hda_nid_t nid,
 		const struct hda_conn_list *p;
 
 		/* if the connection-list is already cached, read it */
-		p = lookup_conn_list(codec, nid);
+		p = lookup_conn_list(codec, nid, dev_id);
 		if (p) {
 			if (listp)
 				*listp = p->conns;
@@ -206,7 +215,7 @@ int snd_hda_get_conn_list(struct hda_codec *codec, hda_nid_t nid,
 		if (snd_BUG_ON(added))
 			return -EINVAL;
 
-		err = read_and_add_raw_conns(codec, nid);
+		err = read_and_add_raw_conns(codec, nid, dev_id);
 		if (err < 0)
 			return err;
 		added = true;
@@ -218,6 +227,7 @@ EXPORT_SYMBOL_GPL(snd_hda_get_conn_list);
  * snd_hda_get_connections - copy connection list
  * @codec: the HDA codec
  * @nid: NID to parse
+ * @dev_id: device entry id
  * @conn_list: connection list array; when NULL, checks only the size
  * @max_conns: max. number of connections to store
  *
@@ -227,10 +237,11 @@ EXPORT_SYMBOL_GPL(snd_hda_get_conn_list);
  * Returns the number of connections, or a negative error code.
  */
 int snd_hda_get_connections(struct hda_codec *codec, hda_nid_t nid,
-			    hda_nid_t *conn_list, int max_conns)
+			    int dev_id, hda_nid_t *conn_list,
+			    int max_conns)
 {
 	const hda_nid_t *list;
-	int len = snd_hda_get_conn_list(codec, nid, &list);
+	int len = snd_hda_get_conn_list(codec, nid, dev_id, &list);
 
 	if (len > 0 && conn_list) {
 		if (len > max_conns) {
@@ -249,6 +260,7 @@ EXPORT_SYMBOL_GPL(snd_hda_get_connections);
  * snd_hda_override_conn_list - add/modify the connection-list to cache
  * @codec: the HDA codec
  * @nid: NID to parse
+ * @dev_id: device entry id
  * @len: number of connection list entries
  * @list: the list of connection entries
  *
@@ -257,18 +269,18 @@ EXPORT_SYMBOL_GPL(snd_hda_get_connections);
  *
  * Returns zero or a negative error code.
  */
-int snd_hda_override_conn_list(struct hda_codec *codec, hda_nid_t nid, int len,
-			       const hda_nid_t *list)
+int snd_hda_override_conn_list(struct hda_codec *codec, hda_nid_t nid,
+			       int dev_id, int len, const hda_nid_t *list)
 {
 	struct hda_conn_list *p;
 
-	p = lookup_conn_list(codec, nid);
+	p = lookup_conn_list(codec, nid, dev_id);
 	if (p) {
 		list_del(&p->list);
 		kfree(p);
 	}
 
-	return add_conn_list(codec, nid, len, list);
+	return add_conn_list(codec, nid, dev_id, len, list);
 }
 EXPORT_SYMBOL_GPL(snd_hda_override_conn_list);
 
@@ -277,6 +289,7 @@ EXPORT_SYMBOL_GPL(snd_hda_override_conn_list);
  * @codec: the HDA codec
  * @mux: NID containing the list
  * @nid: NID to select
+ * @dev_id: device entry id
  * @recursive: 1 when searching NID recursively, otherwise 0
  *
  * Parses the connection list of the widget @mux and checks whether the
@@ -284,12 +297,12 @@ EXPORT_SYMBOL_GPL(snd_hda_override_conn_list);
  * Otherwise it returns -1.
  */
 int snd_hda_get_conn_index(struct hda_codec *codec, hda_nid_t mux,
-			   hda_nid_t nid, int recursive)
+			   hda_nid_t nid, int dev_id, int recursive)
 {
 	const hda_nid_t *conn;
 	int i, nums;
 
-	nums = snd_hda_get_conn_list(codec, mux, &conn);
+	nums = snd_hda_get_conn_list(codec, mux, dev_id, &conn);
 	for (i = 0; i < nums; i++)
 		if (conn[i] == nid)
 			return i;
@@ -304,7 +317,8 @@ int snd_hda_get_conn_index(struct hda_codec *codec, hda_nid_t mux,
 		unsigned int type = get_wcaps_type(get_wcaps(codec, conn[i]));
 		if (type == AC_WID_PIN || type == AC_WID_AUD_OUT)
 			continue;
-		if (snd_hda_get_conn_index(codec, conn[i], nid, recursive) >= 0)
+		if (snd_hda_get_conn_index(codec, conn[i], nid, dev_id,
+					   recursive) >= 0)
 			return i;
 	}
 	return -1;
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 373fcad..4852c1a 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -329,11 +329,12 @@ snd_hda_codec_write(struct hda_codec *codec, hda_nid_t nid, int flags,
 #define snd_hda_get_sub_nodes(codec, nid, start_nid) \
 	snd_hdac_get_sub_nodes(&(codec)->core, nid, start_nid)
 int snd_hda_get_connections(struct hda_codec *codec, hda_nid_t nid,
-			    hda_nid_t *conn_list, int max_conns);
+			    int dev_id, hda_nid_t *conn_list,
+			    int max_conns);
 static inline int
-snd_hda_get_num_conns(struct hda_codec *codec, hda_nid_t nid)
+snd_hda_get_num_conns(struct hda_codec *codec, hda_nid_t nid, int dev_id)
 {
-	return snd_hda_get_connections(codec, nid, NULL, 0);
+	return snd_hda_get_connections(codec, nid, dev_id, NULL, 0);
 }
 
 #define snd_hda_get_raw_connections(codec, nid, list, max_conns) \
@@ -341,12 +342,12 @@ snd_hda_get_num_conns(struct hda_codec *codec, hda_nid_t nid)
 #define snd_hda_get_num_raw_conns(codec, nid) \
 	snd_hdac_get_connections(&(codec)->core, nid, NULL, 0);
 
-int snd_hda_get_conn_list(struct hda_codec *codec, hda_nid_t nid,
+int snd_hda_get_conn_list(struct hda_codec *codec, hda_nid_t nid, int dev_id,
 			  const hda_nid_t **listp);
-int snd_hda_override_conn_list(struct hda_codec *codec, hda_nid_t nid, int nums,
-			  const hda_nid_t *list);
+int snd_hda_override_conn_list(struct hda_codec *codec, hda_nid_t nid,
+			       int dev_id, int nums, const hda_nid_t *list);
 int snd_hda_get_conn_index(struct hda_codec *codec, hda_nid_t mux,
-			   hda_nid_t nid, int recursive);
+			   hda_nid_t nid, int dev_id, int recursive);
 int snd_hda_get_devices(struct hda_codec *codec, hda_nid_t nid,
 			u8 *dev_list, int max_devices);
 
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index e7c8f4f..9a6e67b 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -338,7 +338,7 @@ static bool is_reachable_path(struct hda_codec *codec,
 {
 	if (!from_nid || !to_nid)
 		return false;
-	return snd_hda_get_conn_index(codec, to_nid, from_nid, true) >= 0;
+	return snd_hda_get_conn_index(codec, to_nid, from_nid, 0, true) >= 0;
 }
 
 /* nid, dir and idx */
@@ -397,7 +397,7 @@ static bool __parse_nid_path(struct hda_codec *codec,
 	else if (to_nid == (hda_nid_t)(-anchor_nid))
 		return false; /* hit the exclusive nid */
 
-	nums = snd_hda_get_conn_list(codec, to_nid, &conn);
+	nums = snd_hda_get_conn_list(codec, to_nid, 0, &conn);
 	for (i = 0; i < nums; i++) {
 		if (conn[i] != from_nid) {
 			/* special case: when from_nid is 0,
@@ -696,9 +696,9 @@ static bool is_stereo_amps(struct hda_codec *codec, hda_nid_t nid, int dir)
 		return true;
 	if (dir != HDA_INPUT || get_wcaps_type(wcaps) != AC_WID_AUD_MIX)
 		return false;
-	if (snd_hda_get_num_conns(codec, nid) != 1)
+	if (snd_hda_get_num_conns(codec, nid, 0) != 1)
 		return false;
-	if (snd_hda_get_connections(codec, nid, &conn, 1) < 0)
+	if (snd_hda_get_connections(codec, nid, 0, &conn, 1) < 0)
 		return false;
 	return !!(get_wcaps(codec, conn) & AC_WCAP_STEREO);
 }
@@ -791,7 +791,7 @@ static void activate_amp_in(struct hda_codec *codec, struct nid_path *path,
 	int type;
 	hda_nid_t nid = path->path[i];
 
-	nums = snd_hda_get_conn_list(codec, nid, &conn);
+	nums = snd_hda_get_conn_list(codec, nid, 0, &conn);
 	type = get_wcaps_type(get_wcaps(codec, nid));
 	if (type == AC_WID_PIN ||
 	    (type == AC_WID_AUD_IN && codec->single_adc_amp)) {
@@ -1060,7 +1060,7 @@ static int add_sw_ctl(struct hda_codec *codec, const char *pfx, int cidx,
 	val = amp_val_replace_channels(val, chs);
 	if (get_amp_direction_(val) == HDA_INPUT) {
 		hda_nid_t nid = get_amp_nid_(val);
-		int nums = snd_hda_get_num_conns(codec, nid);
+		int nums = snd_hda_get_num_conns(codec, nid, 0);
 		if (nums > 1) {
 			type = HDA_CTL_BIND_MUTE;
 			val |= nums << 19;
@@ -3002,7 +3002,7 @@ static bool look_for_mix_leaf_ctls(struct hda_codec *codec, hda_nid_t mix_nid,
 	const hda_nid_t *list;
 	hda_nid_t nid;
 
-	idx = snd_hda_get_conn_index(codec, mix_nid, pin, true);
+	idx = snd_hda_get_conn_index(codec, mix_nid, pin, 0, true);
 	if (idx < 0)
 		return false;
 
@@ -3015,7 +3015,7 @@ static bool look_for_mix_leaf_ctls(struct hda_codec *codec, hda_nid_t mix_nid,
 		return true;
 
 	/* check leaf node */
-	num_conns = snd_hda_get_conn_list(codec, mix_nid, &list);
+	num_conns = snd_hda_get_conn_list(codec, mix_nid, 0, &list);
 	if (num_conns < idx)
 		return false;
 	nid = list[idx];
@@ -4760,7 +4760,7 @@ static void mute_all_mixer_nid(struct hda_codec *codec, hda_nid_t mix)
 	const hda_nid_t *conn;
 	bool has_amp;
 
-	nums = snd_hda_get_conn_list(codec, mix, &conn);
+	nums = snd_hda_get_conn_list(codec, mix, 0, &conn);
 	has_amp = nid_has_mute(codec, mix, HDA_INPUT);
 	for (i = 0; i < nums; i++) {
 		if (has_amp)
diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 033aa84..c747183 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -636,7 +636,7 @@ static void print_conn_list(struct snd_info_buffer *buffer,
 	}
 
 	/* Get Cache connections info */
-	cache_len = snd_hda_get_conn_list(codec, nid, &list);
+	cache_len = snd_hda_get_conn_list(codec, nid, 0, &list);
 	if (cache_len >= 0 && (cache_len != conn_len ||
 			      memcmp(list, conn, conn_len) != 0)) {
 		snd_iprintf(buffer, "  In-driver Connection: %d\n", cache_len);
diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index e0fb8c6..6f007ff 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -466,7 +466,7 @@ static int ad1983_auto_smux_enum_info(struct snd_kcontrol *kcontrol,
 	static const char * const texts2[] = { "PCM", "ADC" };
 	static const char * const texts3[] = { "PCM", "ADC1", "ADC2" };
 	hda_nid_t dig_out = spec->gen.multiout.dig_out_nid;
-	int num_conns = snd_hda_get_num_conns(codec, dig_out);
+	int num_conns = snd_hda_get_num_conns(codec, dig_out, 0);
 
 	if (num_conns == 2)
 		return snd_hda_enum_helper_info(kcontrol, uinfo, 2, texts2);
@@ -493,7 +493,7 @@ static int ad1983_auto_smux_enum_put(struct snd_kcontrol *kcontrol,
 	struct ad198x_spec *spec = codec->spec;
 	unsigned int val = ucontrol->value.enumerated.item[0];
 	hda_nid_t dig_out = spec->gen.multiout.dig_out_nid;
-	int num_conns = snd_hda_get_num_conns(codec, dig_out);
+	int num_conns = snd_hda_get_num_conns(codec, dig_out, 0);
 
 	if (val >= num_conns)
 		return -EINVAL;
@@ -521,7 +521,7 @@ static int ad1983_add_spdif_mux_ctl(struct hda_codec *codec)
 
 	if (!dig_out)
 		return 0;
-	num_conns = snd_hda_get_num_conns(codec, dig_out);
+	num_conns = snd_hda_get_num_conns(codec, dig_out, 0);
 	if (num_conns != 2 && num_conns != 3)
 		return 0;
 	if (!snd_hda_gen_add_kctl(&spec->gen, NULL, &ad1983_auto_smux_mixer))
@@ -546,8 +546,10 @@ static int patch_ad1983(struct hda_codec *codec)
 	set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
 
 	/* limit the loopback routes not to confuse the parser */
-	snd_hda_override_conn_list(codec, 0x0c, ARRAY_SIZE(conn_0c), conn_0c);
-	snd_hda_override_conn_list(codec, 0x0d, ARRAY_SIZE(conn_0d), conn_0d);
+	snd_hda_override_conn_list(codec, 0x0c, 0, ARRAY_SIZE(conn_0c),
+				   conn_0c);
+	snd_hda_override_conn_list(codec, 0x0d, 0, ARRAY_SIZE(conn_0d),
+				   conn_0d);
 
 	err = ad198x_parse_auto_config(codec, false);
 	if (err < 0)
@@ -745,7 +747,7 @@ static int ad1988_auto_smux_enum_info(struct snd_kcontrol *kcontrol,
 	static const char * const texts[] = {
 		"PCM", "ADC1", "ADC2", "ADC3",
 	};
-	int num_conns = snd_hda_get_num_conns(codec, 0x0b) + 1;
+	int num_conns = snd_hda_get_num_conns(codec, 0x0b, 0) + 1;
 	if (num_conns > 4)
 		num_conns = 4;
 	return snd_hda_enum_helper_info(kcontrol, uinfo, num_conns, texts);
@@ -768,7 +770,7 @@ static int ad1988_auto_smux_enum_put(struct snd_kcontrol *kcontrol,
 	struct ad198x_spec *spec = codec->spec;
 	unsigned int val = ucontrol->value.enumerated.item[0];
 	struct nid_path *path;
-	int num_conns = snd_hda_get_num_conns(codec, 0x0b) + 1;
+	int num_conns = snd_hda_get_num_conns(codec, 0x0b, 0) + 1;
 
 	if (val >= num_conns)
 		return -EINVAL;
@@ -856,7 +858,7 @@ static int ad1988_add_spdif_mux_ctl(struct hda_codec *codec)
 	    get_wcaps_type(get_wcaps(codec, 0x1d)) != AC_WID_AUD_MIX)
 		return 0;
 
-	num_conns = snd_hda_get_num_conns(codec, 0x0b) + 1;
+	num_conns = snd_hda_get_num_conns(codec, 0x0b, 0) + 1;
 	if (num_conns != 3 && num_conns != 4)
 		return 0;
 
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index cf9bc042..8a20cf4 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1198,7 +1198,7 @@ static int hdmi_read_pin_conn(struct hda_codec *codec, int pin_idx)
 		return -EINVAL;
 	}
 
-	per_pin->num_mux_nids = snd_hda_get_connections(codec, pin_nid,
+	per_pin->num_mux_nids = snd_hda_get_connections(codec, pin_nid, 0,
 							per_pin->mux_nids,
 							HDA_MAX_CONNECTIONS);
 
@@ -2224,14 +2224,16 @@ static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
 	hda_nid_t conns[4];
 	int nconns;
 
-	nconns = snd_hda_get_connections(codec, nid, conns, ARRAY_SIZE(conns));
+	nconns = snd_hda_get_connections(codec, nid, 0, conns,
+					 ARRAY_SIZE(conns));
 	if (nconns == spec->num_cvts &&
 	    !memcmp(conns, spec->cvt_nids, spec->num_cvts * sizeof(hda_nid_t)))
 		return;
 
 	/* override pins connection list */
 	codec_dbg(codec, "hdmi: haswell: override pin connection 0x%x\n", nid);
-	snd_hda_override_conn_list(codec, nid, spec->num_cvts, spec->cvt_nids);
+	snd_hda_override_conn_list(codec, nid, 0, spec->num_cvts,
+				   spec->cvt_nids);
 }
 
 #define INTEL_VENDOR_NID 0x08
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1fe8750..51240d6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1861,17 +1861,17 @@ static void alc889_fixup_dac_route(struct hda_codec *codec,
 		/* fake the connections during parsing the tree */
 		hda_nid_t conn1[2] = { 0x0c, 0x0d };
 		hda_nid_t conn2[2] = { 0x0e, 0x0f };
-		snd_hda_override_conn_list(codec, 0x14, 2, conn1);
-		snd_hda_override_conn_list(codec, 0x15, 2, conn1);
-		snd_hda_override_conn_list(codec, 0x18, 2, conn2);
-		snd_hda_override_conn_list(codec, 0x1a, 2, conn2);
+		snd_hda_override_conn_list(codec, 0x14, 0, 2, conn1);
+		snd_hda_override_conn_list(codec, 0x15, 0, 2, conn1);
+		snd_hda_override_conn_list(codec, 0x18, 0, 2, conn2);
+		snd_hda_override_conn_list(codec, 0x1a, 0, 2, conn2);
 	} else if (action == HDA_FIXUP_ACT_PROBE) {
 		/* restore the connections */
 		hda_nid_t conn[5] = { 0x0c, 0x0d, 0x0e, 0x0f, 0x26 };
-		snd_hda_override_conn_list(codec, 0x14, 5, conn);
-		snd_hda_override_conn_list(codec, 0x15, 5, conn);
-		snd_hda_override_conn_list(codec, 0x18, 5, conn);
-		snd_hda_override_conn_list(codec, 0x1a, 5, conn);
+		snd_hda_override_conn_list(codec, 0x14, 0, 5, conn);
+		snd_hda_override_conn_list(codec, 0x15, 0, 5, conn);
+		snd_hda_override_conn_list(codec, 0x18, 0, 5, conn);
+		snd_hda_override_conn_list(codec, 0x1a, 0, 5, conn);
 	}
 }
 
@@ -4684,8 +4684,8 @@ static void alc290_fixup_mono_speakers(struct hda_codec *codec,
 		   make sure 0x14 (front speaker) and 0x15 (headphones) use the
 		   stereo DAC, while leaving 0x17 (bass speaker) for node 0x03. */
 		hda_nid_t conn1[2] = { 0x0c };
-		snd_hda_override_conn_list(codec, 0x14, 1, conn1);
-		snd_hda_override_conn_list(codec, 0x15, 1, conn1);
+		snd_hda_override_conn_list(codec, 0x14, 0, 1, conn1);
+		snd_hda_override_conn_list(codec, 0x15, 0, 1, conn1);
 	}
 }
 
@@ -4701,7 +4701,7 @@ static void alc298_fixup_speaker_volume(struct hda_codec *codec,
 		   speaker's volume now. */
 
 		hda_nid_t conn1[1] = { 0x0c };
-		snd_hda_override_conn_list(codec, 0x17, 1, conn1);
+		snd_hda_override_conn_list(codec, 0x17, 0, 1, conn1);
 	}
 }
 
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 37b70f8..5bff793 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -984,7 +984,7 @@ static int stac_create_spdif_mux_ctls(struct hda_codec *codec)
 	if (cfg->dig_outs < 1)
 		return 0;
 
-	num_cons = snd_hda_get_num_conns(codec, cfg->dig_out_pins[0]);
+	num_cons = snd_hda_get_num_conns(codec, cfg->dig_out_pins[0], 0);
 	if (num_cons <= 1)
 		return 0;
 
@@ -4543,7 +4543,7 @@ static int patch_stac92hd73xx(struct hda_codec *codec)
 	spec->gen.mixer_nid = 0x1d;
 	spec->have_spdif_mux = 1;
 
-	num_dacs = snd_hda_get_num_conns(codec, 0x0a) - 1;
+	num_dacs = snd_hda_get_num_conns(codec, 0x0a, 0) - 1;
 	if (num_dacs < 3 || num_dacs > 5) {
 		codec_warn(codec,
 			   "Could not determine number of channels defaulting to DAC count\n");
diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index fc30d1e..14d9010 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -867,7 +867,7 @@ static int add_secret_dac_path(struct hda_codec *codec)
 
 	if (!spec->gen.mixer_nid)
 		return 0;
-	nums = snd_hda_get_connections(codec, spec->gen.mixer_nid, conn,
+	nums = snd_hda_get_connections(codec, spec->gen.mixer_nid, 0, conn,
 				       ARRAY_SIZE(conn) - 1);
 	for (i = 0; i < nums; i++) {
 		if (get_wcaps_type(get_wcaps(codec, conn[i])) == AC_WID_AUD_OUT)
@@ -882,7 +882,7 @@ static int add_secret_dac_path(struct hda_codec *codec)
 			conn[nums++] = nid;
 			return snd_hda_override_conn_list(codec,
 							  spec->gen.mixer_nid,
-							  nums, conn);
+							  0, nums, conn);
 		}
 	}
 	return 0;
@@ -1082,8 +1082,10 @@ static void fix_vt1802_connections(struct hda_codec *codec)
 	static hda_nid_t conn_24[] = { 0x14, 0x1c };
 	static hda_nid_t conn_33[] = { 0x1c };
 
-	snd_hda_override_conn_list(codec, 0x24, ARRAY_SIZE(conn_24), conn_24);
-	snd_hda_override_conn_list(codec, 0x33, ARRAY_SIZE(conn_33), conn_33);
+	snd_hda_override_conn_list(codec, 0x24, 0, ARRAY_SIZE(conn_24),
+				   conn_24);
+	snd_hda_override_conn_list(codec, 0x33, 0, ARRAY_SIZE(conn_33),
+				   conn_33);
 }
 
 /* patch for vt2002P */
-- 
1.9.1
