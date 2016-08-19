From: mengdong.lin@linux.intel.com
Subject: [PATCH 03/13] ASoC: topology: ABI - Define DPCM
	trigger ordering for PCM
Date: Fri, 19 Aug 2016 18:12:55 +0800
Message-ID: <24428c2714d09062f3ace5803679c743d36afb04.1471599648.git.mengdong.lin@linux.intel.com>
References: <cover.1471599648.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0917F266B76
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 12:07:03 +0200 (CEST)
In-Reply-To: <cover.1471599648.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, hardik.t.shah@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Definition of dynamic PCM trigger ordering is exposed to uapi asoc.h,
and topology allows user space to define the trigger ordering for PCM
(FE links).

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index 8060590..428ae95 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -52,19 +52,6 @@ enum snd_soc_dpcm_state {
 };
 
 /*
- * Dynamic PCM trigger ordering. Triggering flexibility is required as some
- * DSPs require triggering before/after their CPU platform and DAIs.
- *
- * i.e. some clients may want to manually order this call in their PCM
- * trigger() whilst others will just use the regular core ordering.
- */
-enum snd_soc_dpcm_trigger {
-	SND_SOC_DPCM_TRIGGER_PRE		= 0,
-	SND_SOC_DPCM_TRIGGER_POST,
-	SND_SOC_DPCM_TRIGGER_BESPOKE,
-};
-
-/*
  * Dynamic PCM link
  * This links together a FE and BE DAI at runtime and stores the link
  * state information and the hw_params configuration.
diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 33d00a4..db0edfb 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -131,6 +131,19 @@
 #define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
 
 /*
+ * Dynamic PCM trigger ordering. Triggering flexibility is required as some
+ * DSPs require triggering before/after their CPU platform and DAIs.
+ *
+ * i.e. some clients may want to manually order this call in their PCM
+ * trigger() whilst others will just use the regular core ordering.
+ */
+enum snd_soc_dpcm_trigger {
+	SND_SOC_DPCM_TRIGGER_PRE		= 0,
+	SND_SOC_DPCM_TRIGGER_POST,
+	SND_SOC_DPCM_TRIGGER_BESPOKE,
+};
+
+/*
  * Block Header.
  * This header precedes all object and object arrays below.
  */
@@ -440,6 +453,7 @@ struct snd_soc_tplg_pcm {
 	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* for DAI link */
 	__le32 num_streams;	/* number of streams */
 	struct snd_soc_tplg_stream_caps caps[2]; /* playback and capture for DAI */
+	__le32 trigger[2];	/* SND_SOC_DPCM_TRIGGER_ trigger flag for playback & capture */
 } __attribute__((packed));
 
 
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index b271248..6802151 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1645,6 +1645,9 @@ static int soc_tplg_link_create(struct soc_tplg *tplg,
 	link->dpcm_playback = pcm->playback;
 	link->dpcm_capture = pcm->capture;
 
+	link->trigger[0] = pcm->trigger[0];
+	link->trigger[1] = pcm->trigger[1];
+
 	/* pass control to component driver for optional further init */
 	ret = soc_tplg_dai_link_load(tplg, link);
 	if (ret < 0) {
-- 
2.5.0
