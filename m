From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 2/3] ASoC: topology: Move v4 manifest header
	data structures to uapi
Date: Thu, 24 May 2018 12:49:22 -0700
Message-ID: <1527191363-21021-2-git-send-email-linux@roeck-us.net>
References: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F4E8267646
 for <alsa-devel@alsa-project.org>; Thu, 24 May 2018 21:49:29 +0200 (CEST)
In-Reply-To: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-kernel@vger.kernel.org, Chintan Patel <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org

From: Guenter Roeck <groeck@chromium.org>

Topology manifest v4 is still part of the ABI. Move its data structures
into the uapi header file.

No functional change.

Signed-off-by: Guenter Roeck <groeck@chromium.org>
---
v2: Added patch to series

 include/uapi/sound/asoc.h | 57 +++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-topology.c  | 56 --------------------------------------
 2 files changed, 57 insertions(+), 56 deletions(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 69c37ecbff7e..a9df4900789c 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -552,4 +552,61 @@ struct snd_soc_tplg_dai {
 	__le32 flags;           /* SND_SOC_TPLG_DAI_FLGBIT_* */
 	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
+
+/*
+ * Old version of ABI structs, supported for backward compatibility.
+ */
+
+/* Manifest v4 */
+struct snd_soc_tplg_manifest_v4 {
+	__le32 size;		/* in bytes of this structure */
+	__le32 control_elems;	/* number of control elements */
+	__le32 widget_elems;	/* number of widget elements */
+	__le32 graph_elems;	/* number of graph elements */
+	__le32 pcm_elems;	/* number of PCM elements */
+	__le32 dai_link_elems;	/* number of DAI link elements */
+	struct snd_soc_tplg_private priv;
+} __packed;
+
+/* Stream Capabilities v4 */
+struct snd_soc_tplg_stream_caps_v4 {
+	__le32 size;		/* in bytes of this structure */
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	__le64 formats;	/* supported formats SNDRV_PCM_FMTBIT_* */
+	__le32 rates;		/* supported rates SNDRV_PCM_RATE_* */
+	__le32 rate_min;	/* min rate */
+	__le32 rate_max;	/* max rate */
+	__le32 channels_min;	/* min channels */
+	__le32 channels_max;	/* max channels */
+	__le32 periods_min;	/* min number of periods */
+	__le32 periods_max;	/* max number of periods */
+	__le32 period_size_min;	/* min period size bytes */
+	__le32 period_size_max;	/* max period size bytes */
+	__le32 buffer_size_min;	/* min buffer size bytes */
+	__le32 buffer_size_max;	/* max buffer size bytes */
+} __packed;
+
+/* PCM v4 */
+struct snd_soc_tplg_pcm_v4 {
+	__le32 size;		/* in bytes of this structure */
+	char pcm_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	char dai_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	__le32 pcm_id;		/* unique ID - used to match with DAI link */
+	__le32 dai_id;		/* unique ID - used to match */
+	__le32 playback;	/* supports playback mode */
+	__le32 capture;		/* supports capture mode */
+	__le32 compress;	/* 1 = compressed; 0 = PCM */
+	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* for DAI link */
+	__le32 num_streams;	/* number of streams */
+	struct snd_soc_tplg_stream_caps_v4 caps[2]; /* playback and capture for DAI */
+} __packed;
+
+/* Physical link config v4 */
+struct snd_soc_tplg_link_config_v4 {
+	__le32 size;            /* in bytes of this structure */
+	__le32 id;              /* unique ID - used to match */
+	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* supported configs playback and captrure */
+	__le32 num_streams;     /* number of streams */
+} __packed;
+
 #endif
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index d66b2e5ccd67..40753c6a2554 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -54,62 +54,6 @@
 #define SOC_TPLG_PASS_START	SOC_TPLG_PASS_MANIFEST
 #define SOC_TPLG_PASS_END	SOC_TPLG_PASS_LINK
 
-/*
- * Old version of ABI structs, supported for backward compatibility.
- */
-
-/* Manifest v4 */
-struct snd_soc_tplg_manifest_v4 {
-	__le32 size;		/* in bytes of this structure */
-	__le32 control_elems;	/* number of control elements */
-	__le32 widget_elems;	/* number of widget elements */
-	__le32 graph_elems;	/* number of graph elements */
-	__le32 pcm_elems;	/* number of PCM elements */
-	__le32 dai_link_elems;	/* number of DAI link elements */
-	struct snd_soc_tplg_private priv;
-} __packed;
-
-/* Stream Capabilities v4 */
-struct snd_soc_tplg_stream_caps_v4 {
-	__le32 size;		/* in bytes of this structure */
-	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	__le64 formats;	/* supported formats SNDRV_PCM_FMTBIT_* */
-	__le32 rates;		/* supported rates SNDRV_PCM_RATE_* */
-	__le32 rate_min;	/* min rate */
-	__le32 rate_max;	/* max rate */
-	__le32 channels_min;	/* min channels */
-	__le32 channels_max;	/* max channels */
-	__le32 periods_min;	/* min number of periods */
-	__le32 periods_max;	/* max number of periods */
-	__le32 period_size_min;	/* min period size bytes */
-	__le32 period_size_max;	/* max period size bytes */
-	__le32 buffer_size_min;	/* min buffer size bytes */
-	__le32 buffer_size_max;	/* max buffer size bytes */
-} __packed;
-
-/* PCM v4 */
-struct snd_soc_tplg_pcm_v4 {
-	__le32 size;		/* in bytes of this structure */
-	char pcm_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	char dai_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	__le32 pcm_id;		/* unique ID - used to match with DAI link */
-	__le32 dai_id;		/* unique ID - used to match */
-	__le32 playback;	/* supports playback mode */
-	__le32 capture;		/* supports capture mode */
-	__le32 compress;	/* 1 = compressed; 0 = PCM */
-	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* for DAI link */
-	__le32 num_streams;	/* number of streams */
-	struct snd_soc_tplg_stream_caps_v4 caps[2]; /* playback and capture for DAI */
-} __packed;
-
-/* Physical link config v4 */
-struct snd_soc_tplg_link_config_v4 {
-	__le32 size;            /* in bytes of this structure */
-	__le32 id;              /* unique ID - used to match */
-	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* supported configs playback and captrure */
-	__le32 num_streams;     /* number of streams */
-} __packed;
-
 /* topology context */
 struct soc_tplg {
 	const struct firmware *fw;
-- 
2.17.0.441.gb46fe60e1d-goog
