From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/7] ASoC: Intel: Skylake: Add
	skl_tplg_be_get_cpr_module() helper
Date: Fri,  5 Feb 2016 12:19:06 +0530
Message-ID: <1454654950-23091-4-git-send-email-vinod.koul@intel.com>
References: <1454654950-23091-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 225142659FB
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 07:45:51 +0100 (CET)
In-Reply-To: <1454654950-23091-1-git-send-email-vinod.koul@intel.com>
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
Cc: "Dharageswari.R" <dharageswari.r@intel.com>, tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: "Dharageswari.R" <dharageswari.r@intel.com>

An I2S port can be connected to multiple BE pipes, get module config
only for the active BE pipe.

This helpers helps to do that and is used in subsequent patches

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 60 ++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.h |  2 ++
 2 files changed, 62 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 50e193e9eb56..696a8becb803 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1091,6 +1091,66 @@ skl_tplg_fe_get_cpr_module(struct snd_soc_dai *dai, int stream)
 	return NULL;
 }
 
+static struct skl_module_cfg *skl_get_mconfig_pb_cpr(
+		struct snd_soc_dai *dai, struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dapm_path *p;
+	struct skl_module_cfg *mconfig = NULL;
+
+	snd_soc_dapm_widget_for_each_source_path(w, p) {
+		if (w->endpoints[SND_SOC_DAPM_DIR_OUT] > 0) {
+			if (p->connect &&
+				    (p->sink->id == snd_soc_dapm_aif_out) &&
+				    p->source->priv) {
+				mconfig = p->source->priv;
+				return mconfig;
+			}
+			mconfig = skl_get_mconfig_pb_cpr(dai, p->source);
+			if (mconfig)
+				return mconfig;
+		}
+	}
+	return mconfig;
+}
+
+static struct skl_module_cfg *skl_get_mconfig_cap_cpr(
+		struct snd_soc_dai *dai, struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dapm_path *p;
+	struct skl_module_cfg *mconfig = NULL;
+
+	snd_soc_dapm_widget_for_each_sink_path(w, p) {
+		if (w->endpoints[SND_SOC_DAPM_DIR_IN] > 0) {
+			if (p->connect &&
+				    (p->source->id == snd_soc_dapm_aif_in) &&
+				    p->sink->priv) {
+				mconfig = p->sink->priv;
+				return mconfig;
+			}
+			mconfig = skl_get_mconfig_cap_cpr(dai, p->sink);
+			if (mconfig)
+				return mconfig;
+		}
+	}
+	return mconfig;
+}
+
+struct skl_module_cfg *
+skl_tplg_be_get_cpr_module(struct snd_soc_dai *dai, int stream)
+{
+	struct snd_soc_dapm_widget *w;
+	struct skl_module_cfg *mconfig;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		w = dai->playback_widget;
+		mconfig = skl_get_mconfig_pb_cpr(dai, w);
+	} else {
+		w = dai->capture_widget;
+		mconfig = skl_get_mconfig_cap_cpr(dai, w);
+	}
+	return mconfig;
+}
+
 static u8 skl_tplg_be_link_type(int dev_type)
 {
 	int ret;
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 9aa2a2b6598a..5f0707cf1f54 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -345,5 +345,7 @@ int skl_set_module_params(struct skl_sst *ctx, u32 *params, int size,
 int skl_get_module_params(struct skl_sst *ctx, u32 *params, int size,
 			  u32 param_id, struct skl_module_cfg *mcfg);
 
+struct skl_module_cfg *skl_tplg_be_get_cpr_module(struct snd_soc_dai *dai,
+								int stream);
 enum skl_bitdepth skl_get_bit_depth(int params);
 #endif
-- 
1.9.1
