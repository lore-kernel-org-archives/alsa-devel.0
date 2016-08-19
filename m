From: mengdong.lin@linux.intel.com
Subject: [PATCH 04/13] ASoC: topology: ABI - Add flags to PCM
Date: Fri, 19 Aug 2016 18:13:04 +0800
Message-ID: <b684ceea5d45876fba9b891da34c7dab98626255.1471599648.git.mengdong.lin@linux.intel.com>
References: <cover.1471599648.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 724EB266564
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 12:07:13 +0200 (CEST)
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

Add flags to PCM. These flags will be applied to FE (Front End) links.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index db0edfb..39be708 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -130,6 +130,10 @@
 #define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_CHANNELS      (1 << 1)
 #define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
 
+/* DAI link flags */
+#define SND_SOC_TPLG_LNK_FLGBIT_IGNORE_SUSPEND          (1 << 0)
+#define SND_SOC_TPLG_LNK_FLGBIT_IGNORE_POWERDOWN_TIME   (1 << 1)
+
 /*
  * Dynamic PCM trigger ordering. Triggering flexibility is required as some
  * DSPs require triggering before/after their CPU platform and DAIs.
@@ -454,6 +458,8 @@ struct snd_soc_tplg_pcm {
 	__le32 num_streams;	/* number of streams */
 	struct snd_soc_tplg_stream_caps caps[2]; /* playback and capture for DAI */
 	__le32 trigger[2];	/* SND_SOC_DPCM_TRIGGER_ trigger flag for playback & capture */
+	__le32 flag_mask;       /* bitmask of flags to configure */
+	__le32 flags;           /* SND_SOC_TPLG_LNK_FLGBIT_* flag value */
 } __attribute__((packed));
 
 
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 6802151..1f89a2a 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1621,6 +1621,18 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	return snd_soc_register_dai(tplg->comp, dai_drv);
 }
 
+static void set_link_flags(struct snd_soc_dai_link *link,
+		unsigned int flag_mask, unsigned int flags)
+{
+	if (flag_mask & SND_SOC_TPLG_LNK_FLGBIT_IGNORE_SUSPEND)
+		link->ignore_suspend =
+			flags & SND_SOC_TPLG_LNK_FLGBIT_IGNORE_SUSPEND ? 1 : 0;
+
+	if (flag_mask & SND_SOC_TPLG_LNK_FLGBIT_IGNORE_POWERDOWN_TIME)
+		link->ignore_pmdown_time =
+		flags & SND_SOC_TPLG_LNK_FLGBIT_IGNORE_POWERDOWN_TIME ? 1 : 0;
+}
+
 /* create the FE DAI link */
 static int soc_tplg_link_create(struct soc_tplg *tplg,
 	struct snd_soc_tplg_pcm *pcm)
@@ -1644,6 +1656,8 @@ static int soc_tplg_link_create(struct soc_tplg *tplg,
 	link->dynamic = 1;
 	link->dpcm_playback = pcm->playback;
 	link->dpcm_capture = pcm->capture;
+	if (pcm->flag_mask)
+		set_link_flags(link, pcm->flag_mask, pcm->flags);
 
 	link->trigger[0] = pcm->trigger[0];
 	link->trigger[1] = pcm->trigger[1];
-- 
2.5.0
