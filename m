From: mengdong.lin@intel.com
Subject: [PATCH v2 1/8] ASoC: topology: ABI - Add PCM Support
	and bump ABI version to 4
Date: Wed, 30 Sep 2015 17:28:47 +0800
Message-ID: <1b22262b0a1cbcd146f7bc2fbeb0389824a9965c.1443605139.git.mengdong.lin@intel.com>
References: <cover.1443605139.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C79B265A8C
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 11:14:37 +0200 (CEST)
In-Reply-To: <cover.1443605139.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@intel.com, vedang.patel@intel.com, subhransu.s.prusty@intel.com, vinod.koul@intel.com, jeeja.kp@intel.com
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vedang Patel <vedang.patel@intel.com>

The struct snd_soc_tplg_pcm_dai is renamed to snd_soc_tplg_pcm.
This struct will now be used to handle data related to PCMs
(FE DAI & DAI links). It's not for BE, because BE DAI mappings will be
provided by ACPI/FDT data.

Remove the unused struct snd_soc_tplg_pcm_cfg_caps. We are using
snd_soc_tplg_stream and snd_soc_stream_caps instead.

Bump ABI version to 4.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 247c50b..2aa081c 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -83,7 +83,7 @@
 #define SND_SOC_TPLG_NUM_TEXTS		16
 
 /* ABI version */
-#define SND_SOC_TPLG_ABI_VERSION	0x3
+#define SND_SOC_TPLG_ABI_VERSION	0x4
 
 /* Max size of TLV data */
 #define SND_SOC_TPLG_TLV_SIZE		32
@@ -378,30 +378,29 @@ struct snd_soc_tplg_dapm_widget {
 	 */
 } __attribute__((packed));
 
-struct snd_soc_tplg_pcm_cfg_caps {
-	struct snd_soc_tplg_stream_caps caps;
-	struct snd_soc_tplg_stream_config configs[SND_SOC_TPLG_STREAM_CONFIG_MAX];
-	__le32 num_configs;	/* number of configs */
-} __attribute__((packed));
 
 /*
- * Describes SW/FW specific features of PCM or DAI link.
+ * Describes SW/FW specific features of PCM (FE DAI & DAI link).
  *
- * File block representation for PCM/DAI-Link :-
+ * File block representation for PCM :-
  * +-----------------------------------+-----+
  * | struct snd_soc_tplg_hdr           |  1  |
  * +-----------------------------------+-----+
- * | struct snd_soc_tplg_dapm_pcm_dai  |  N  |
+ * | struct snd_soc_tplg_pcm           |  N  |
  * +-----------------------------------+-----+
  */
-struct snd_soc_tplg_pcm_dai {
+struct snd_soc_tplg_pcm {
 	__le32 size;		/* in bytes of this structure */
-	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	__le32 id;			/* unique ID - used to match */
-	__le32 playback;		/* supports playback mode */
-	__le32 capture;			/* supports capture mode */
-	__le32 compress;		/* 1 = compressed; 0 = PCM */
-	struct snd_soc_tplg_pcm_cfg_caps capconf[2];	/* capabilities and configs */
+	char pcm_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	char dai_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	__le32 pcm_id;		/* unique ID - used to match */
+	__le32 dai_id;		/* unique ID - used to match */
+	__le32 playback;	/* supports playback mode */
+	__le32 capture;		/* supports capture mode */
+	__le32 compress;	/* 1 = compressed; 0 = PCM */
+	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* for DAI link */
+	__le32 num_streams;	/* number of streams */
+	struct snd_soc_tplg_stream_caps caps[2]; /* playback and capture for DAI */
 } __attribute__((packed));
 
 #endif
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 69d01cd..8d7ec80 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1558,7 +1558,7 @@ static int soc_tplg_pcm_dai_elems_load(struct soc_tplg *tplg,
 	pcm_dai = (struct snd_soc_tplg_pcm_dai *)tplg->pos;
 
 	if (soc_tplg_check_elem_count(tplg,
-		sizeof(struct snd_soc_tplg_pcm_dai), count,
+		sizeof(struct snd_soc_tplg_pcm), count,
 		hdr->payload_size, "PCM DAI")) {
 		dev_err(tplg->dev, "ASoC: invalid count %d for PCM DAI elems\n",
 			count);
@@ -1566,7 +1566,7 @@ static int soc_tplg_pcm_dai_elems_load(struct soc_tplg *tplg,
 	}
 
 	dev_dbg(tplg->dev, "ASoC: adding %d PCM DAIs\n", count);
-	tplg->pos += sizeof(struct snd_soc_tplg_pcm_dai) * count;
+	tplg->pos += sizeof(struct snd_soc_tplg_pcm) * count;
 
 	dobj = kzalloc(sizeof(struct snd_soc_dobj), GFP_KERNEL);
 	if (dobj == NULL)
-- 
1.9.1
