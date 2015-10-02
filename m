From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: ABI - Add PCM Support and
	bump ABI version to 4" to the asoc tree
Date: Fri, 02 Oct 2015 18:13:53 +0100
Message-ID: <E1Zi3u5-00087I-R3@finisterre>
References: <1b22262b0a1cbcd146f7bc2fbeb0389824a9965c.1443602494.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A3E3D26697D
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 19:13:59 +0200 (CEST)
In-Reply-To: <1b22262b0a1cbcd146f7bc2fbeb0389824a9965c.1443602494.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vedang Patel <vedang.patel@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: ABI - Add PCM Support and bump ABI version to 4

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 5b2688a59af686f7c0a80edc49d7f190365ac090 Mon Sep 17 00:00:00 2001
From: Vedang Patel <vedang.patel@intel.com>
Date: Wed, 30 Sep 2015 17:28:47 +0800
Subject: [PATCH] ASoC: topology: ABI - Add PCM Support and bump ABI version to
 4

The struct snd_soc_tplg_pcm_dai is renamed to snd_soc_tplg_pcm.
This struct will now be used to handle data related to PCMs
(FE DAI & DAI links). It's not for BE, because BE DAI mappings will be
provided by ACPI/FDT data.

Remove the unused struct snd_soc_tplg_pcm_cfg_caps. We are using
snd_soc_tplg_stream and snd_soc_stream_caps instead.

Bump ABI version to 4.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 31 +++++++++++++++----------------
 sound/soc/soc-topology.c  |  4 ++--
 2 files changed, 17 insertions(+), 18 deletions(-)

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
2.5.0
