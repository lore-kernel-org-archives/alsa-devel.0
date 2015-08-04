From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] topology: Add element ID so we can look up
	references by name.
Date: Tue,  4 Aug 2015 18:09:12 +0100
Message-ID: <1438708152-16223-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 03EC5260532
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 19:09:28 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Mengdong Lin <mengdong.lin@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Jin Yao <yao.jin@linux.intel.com>

Add support to lookup elements by name. This is in preparation for adding
some new API calls that will allow building topology data using a C API. This
will allow applications to build thier own topology data directly.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
---
 src/topology/ctl.c        |  9 ++++-----
 src/topology/dapm.c       |  2 +-
 src/topology/data.c       |  2 +-
 src/topology/elem.c       | 15 +++++++++++----
 src/topology/pcm.c        | 10 +++++-----
 src/topology/text.c       |  2 +-
 src/topology/tplg_local.h |  2 +-
 7 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index 9c1333c..aa06ff6 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -264,7 +264,7 @@ int tplg_parse_tlv(snd_tplg_t *tplg, snd_config_t *cfg,
 	int err = 0;
 	struct tplg_elem *elem;
 
-	elem = tplg_elem_new_common(tplg, cfg, OBJECT_TYPE_TLV);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_TLV);
 	if (!elem)
 		return -ENOMEM;
 
@@ -298,7 +298,7 @@ int tplg_parse_control_bytes(snd_tplg_t *tplg,
 	const char *id, *val = NULL;
 	int err;
 
-	elem = tplg_elem_new_common(tplg, cfg, OBJECT_TYPE_BYTES);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_BYTES);
 	if (!elem)
 		return -ENOMEM;
 
@@ -403,11 +403,10 @@ int tplg_parse_control_enum(snd_tplg_t *tplg, snd_config_t *cfg,
 	const char *id, *val = NULL;
 	int err, j;
 
-	elem = tplg_elem_new_common(tplg, cfg, OBJECT_TYPE_ENUM);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_ENUM);
 	if (!elem)
 		return -ENOMEM;
 
-	/* init new mixer */
 	ec = elem->enum_ctrl;
 	elem_copy_text(ec->hdr.name, elem->id, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 	ec->hdr.type = SND_SOC_TPLG_TYPE_ENUM;
@@ -501,7 +500,7 @@ int tplg_parse_control_mixer(snd_tplg_t *tplg,
 	const char *id, *val = NULL;
 	int err, j;
 
-	elem = tplg_elem_new_common(tplg, cfg, OBJECT_TYPE_MIXER);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_MIXER);
 	if (!elem)
 		return -ENOMEM;
 
diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index 1da82ad..7e26ea0 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -420,7 +420,7 @@ int tplg_parse_dapm_widget(snd_tplg_t *tplg,
 	const char *id, *val = NULL;
 	int widget_type, err;
 
-	elem = tplg_elem_new_common(tplg, cfg, OBJECT_TYPE_DAPM_WIDGET);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_DAPM_WIDGET);
 	if (!elem)
 		return -ENOMEM;
 
diff --git a/src/topology/data.c b/src/topology/data.c
index 13e1e2b..c768bc5 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -268,7 +268,7 @@ int tplg_parse_data(snd_tplg_t *tplg, snd_config_t *cfg,
 	int err = 0;
 	struct tplg_elem *elem;
 
-	elem = tplg_elem_new_common(tplg, cfg, OBJECT_TYPE_DATA);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_DATA);
 	if (!elem)
 		return -ENOMEM;
 
diff --git a/src/topology/elem.c b/src/topology/elem.c
index d7a1fd7..7fee653 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -103,20 +103,27 @@ struct tplg_elem *tplg_elem_lookup(struct list_head *base, const char* id,
 
 /* create a new common element and object */
 struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
-	snd_config_t *cfg, enum object_type type)
+	snd_config_t *cfg, const char *name, enum object_type type)
 {
 	struct tplg_elem *elem;
 	const char *id;
 	int obj_size = 0;
 	void *obj;
 
+	if (!cfg && !name)
+		return NULL;
+
 	elem = tplg_elem_new();
 	if (!elem)
 		return NULL;
 
-	snd_config_get_id(cfg, &id);
-	strncpy(elem->id, id, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
-	elem->id[SNDRV_CTL_ELEM_ID_NAME_MAXLEN - 1] = 0;
+	/* do we get name from cfg */
+	if (cfg) {
+		snd_config_get_id(cfg, &id);
+		elem_copy_text(elem->id, id, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+		elem->id[SNDRV_CTL_ELEM_ID_NAME_MAXLEN - 1] = 0;
+	} else if (name != NULL)
+		elem_copy_text(elem->id, name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 
 	switch (type) {
 	case OBJECT_TYPE_DATA:
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 8f23a6f..deae47b 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -228,7 +228,7 @@ int tplg_parse_pcm_config(snd_tplg_t *tplg,
 	const char *id;
 	int err;
 
-	elem = tplg_elem_new_common(tplg, cfg, OBJECT_TYPE_STREAM_CONFIG);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_STREAM_CONFIG);
 	if (!elem)
 		return -ENOMEM;
 
@@ -294,7 +294,7 @@ int tplg_parse_pcm_caps(snd_tplg_t *tplg,
 	char *s;
 	int err;
 
-	elem = tplg_elem_new_common(tplg, cfg, OBJECT_TYPE_STREAM_CAPS);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_STREAM_CAPS);
 	if (!elem)
 		return -ENOMEM;
 
@@ -461,7 +461,7 @@ int tplg_parse_pcm(snd_tplg_t *tplg,
 	const char *id, *val = NULL;
 	int err;
 
-	elem = tplg_elem_new_common(tplg, cfg, OBJECT_TYPE_PCM);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_PCM);
 	if (!elem)
 		return -ENOMEM;
 
@@ -524,7 +524,7 @@ int tplg_parse_be(snd_tplg_t *tplg,
 	const char *id, *val = NULL;
 	int err;
 
-	elem = tplg_elem_new_common(tplg, cfg, OBJECT_TYPE_BE);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_BE);
 	if (!elem)
 		return -ENOMEM;
 
@@ -587,7 +587,7 @@ int tplg_parse_cc(snd_tplg_t *tplg,
 	const char *id, *val = NULL;
 	int err;
 
-	elem = tplg_elem_new_common(tplg, cfg, OBJECT_TYPE_CC);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_CC);
 	if (!elem)
 		return -ENOMEM;
 
diff --git a/src/topology/text.c b/src/topology/text.c
index ebb6e38..7128056 100644
--- a/src/topology/text.c
+++ b/src/topology/text.c
@@ -64,7 +64,7 @@ int tplg_parse_text(snd_tplg_t *tplg, snd_config_t *cfg,
 	int err = 0;
 	struct tplg_elem *elem;
 
-	elem = tplg_elem_new_common(tplg, cfg, OBJECT_TYPE_TEXT);
+	elem = tplg_elem_new_common(tplg, cfg, NULL, OBJECT_TYPE_TEXT);
 	if (!elem)
 		return -ENOMEM;
 
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 688c78f..62788e4 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -216,7 +216,7 @@ struct tplg_elem *tplg_elem_lookup(struct list_head *base,
 				const char* id,
 				unsigned int type);
 struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
-	snd_config_t *cfg, enum object_type type);
+	snd_config_t *cfg, const char *name, enum object_type type);
 
 static inline void elem_copy_text(char *dest, const char *src, int len)
 {
-- 
2.1.4
