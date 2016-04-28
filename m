From: mengdong.lin@linux.intel.com
Subject: [PATCH 2/6] topology: Refactor functions to parse and
	build streams
Date: Thu, 28 Apr 2016 16:41:41 +0800
Message-ID: <a71fc549150c814a833b1827312a752601fa7637.1461831763.git.mengdong.lin@linux.intel.com>
References: <cover.1461831763.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id DC90F2665E0
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 10:38:43 +0200 (CEST)
In-Reply-To: <cover.1461831763.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@intel.com, hardik.t.shah@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Previously these functions are only used by pcm elements (front-end DAI
& DAI link) to parse stream capablities. Now refactor them to be reused
by back-end DAI elements later.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/parser.c b/src/topology/parser.c
index 84117c3..f6fc944 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -119,7 +119,7 @@ static int tplg_parse_config(snd_tplg_t *tplg, snd_config_t *cfg)
 
 		if (strcmp(id, "SectionPCMCapabilities") == 0) {
 			err = tplg_parse_compound(tplg, n,
-				tplg_parse_pcm_caps, NULL);
+				tplg_parse_stream_caps, NULL);
 			if (err < 0)
 				return err;
 			continue;
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index d75aad8..1df4f54 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -40,9 +40,9 @@ struct tplg_elem *lookup_pcm_dai_stream(struct list_head *base, const char* id)
 	return NULL;
 }
 
-/* copy referenced caps to the pcm */
-static void copy_pcm_caps(const char *id, struct snd_soc_tplg_stream_caps *caps,
-	struct tplg_elem *ref_elem)
+/* copy referenced caps to the parent (pcm or be dai) */
+static void copy_stream_caps(const char *id,
+	struct snd_soc_tplg_stream_caps *caps, struct tplg_elem *ref_elem)
 {
 	struct snd_soc_tplg_stream_caps *ref_caps = ref_elem->stream_caps;
 
@@ -52,24 +52,19 @@ static void copy_pcm_caps(const char *id, struct snd_soc_tplg_stream_caps *caps,
 	*caps =  *ref_caps;
 }
 
-/* check referenced config and caps for a pcm */
-static int tplg_build_pcm_caps(snd_tplg_t *tplg, struct tplg_elem *elem)
+/* find and copy the referenced stream caps */
+static int tplg_build_stream_caps(snd_tplg_t *tplg,
+	const char *id, struct snd_soc_tplg_stream_caps *caps)
 {
 	struct tplg_elem *ref_elem = NULL;
-	struct snd_soc_tplg_pcm *pcm;
-	struct snd_soc_tplg_stream_caps *caps;
 	unsigned int i;
 
-	pcm = elem->pcm;
-
 	for (i = 0; i < 2; i++) {
-		caps = &pcm->caps[i];
-
 		ref_elem = tplg_elem_lookup(&tplg->pcm_caps_list,
-			caps->name, SND_TPLG_TYPE_STREAM_CAPS);
+			caps[i].name, SND_TPLG_TYPE_STREAM_CAPS);
 
 		if (ref_elem != NULL)
-			copy_pcm_caps(elem->id, caps, ref_elem);
+			copy_stream_caps(id, &caps[i], ref_elem);
 	}
 
 	return 0;
@@ -91,7 +86,7 @@ int tplg_build_pcm(snd_tplg_t *tplg, unsigned int type)
 			return -EINVAL;
 		}
 
-		err = tplg_build_pcm_caps(tplg, elem);
+		err = tplg_build_stream_caps(tplg, elem->id, elem->pcm->caps);
 		if (err < 0)
 			return err;
 
@@ -184,8 +179,8 @@ static int split_format(struct snd_soc_tplg_stream_caps *caps, char *str)
 	return 0;
 }
 
-/* Parse pcm Capabilities */
-int tplg_parse_pcm_caps(snd_tplg_t *tplg,
+/* Parse pcm stream capabilities */
+int tplg_parse_stream_caps(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED)
 {
 	struct snd_soc_tplg_stream_caps *sc;
@@ -263,29 +258,40 @@ int tplg_parse_pcm_caps(snd_tplg_t *tplg,
 	return 0;
 }
 
-/* Parse the caps of a pcm stream */
-int tplg_parse_stream_caps(snd_tplg_t *tplg, snd_config_t *cfg,
+/* Parse the caps and config of a pcm stream */
+static int tplg_parse_streams(snd_tplg_t *tplg, snd_config_t *cfg,
 	void *private)
 {
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
 	struct tplg_elem *elem = private;
 	struct snd_soc_tplg_pcm *pcm;
+	unsigned int *playback, *capture;
+	struct snd_soc_tplg_stream_caps *caps;
 	const char *id, *value;
 	int stream;
 
-	pcm = elem->pcm;
-
 	snd_config_get_id(cfg, &id);
 
 	tplg_dbg("\t%s:\n", id);
 
+	switch (elem->type) {
+	case SND_TPLG_TYPE_PCM:
+		pcm = elem->pcm;
+		playback = &pcm->playback;
+		capture = &pcm->capture;
+		caps = pcm->caps;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	if (strcmp(id, "playback") == 0) {
 		stream = SND_SOC_TPLG_STREAM_PLAYBACK;
-		pcm->playback = 1;
+		*playback = 1;
 	} else if (strcmp(id, "capture") == 0) {
 		stream = SND_SOC_TPLG_STREAM_CAPTURE;
-		pcm->capture = 1;
+		*capture = 1;
 	} else
 		return -EINVAL;
 
@@ -300,8 +306,10 @@ int tplg_parse_stream_caps(snd_tplg_t *tplg, snd_config_t *cfg,
 		if (strcmp(id, "capabilities") == 0) {
 			if (snd_config_get_string(n, &value) < 0)
 				continue;
-
-			elem_copy_text(pcm->caps[stream].name, value,
+			/* store stream caps name, to find and merge
+			 * the caps in building phase.
+			 */
+			elem_copy_text(caps[stream].name, value,
 				SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 
 			tplg_dbg("\t\t%s\n\t\t\t%s\n", id, value);
@@ -312,7 +320,7 @@ int tplg_parse_stream_caps(snd_tplg_t *tplg, snd_config_t *cfg,
 	return 0;
 }
 
-/* Parse pcm */
+/* Parse pcm (for front end DAI & DAI link) */
 int tplg_parse_pcm(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED)
 {
@@ -365,7 +373,7 @@ int tplg_parse_pcm(snd_tplg_t *tplg,
 
 		if (strcmp(id, "pcm") == 0) {
 			err = tplg_parse_compound(tplg, n,
-				tplg_parse_stream_caps, elem);
+				tplg_parse_streams, elem);
 			if (err < 0)
 				return err;
 			continue;
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 4c601d4..9239aef 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -210,7 +210,7 @@ int tplg_parse_dapm_graph(snd_tplg_t *tplg, snd_config_t *cfg,
 int tplg_parse_dapm_widget(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
 
-int tplg_parse_pcm_caps(snd_tplg_t *tplg,
+int tplg_parse_stream_caps(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
 
 int tplg_parse_pcm(snd_tplg_t *tplg,
-- 
2.5.0
