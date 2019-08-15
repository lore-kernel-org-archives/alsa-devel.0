From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/3] ASoC: SOF: topology: Add dummy support for
	i.MX8 DAIs
Date: Thu, 15 Aug 2019 10:45:00 -0500
Message-ID: <20190815154500.29090-4-pierre-louis.bossart@linux.intel.com>
References: <20190815154500.29090-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F01BF80274
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 17:45:21 +0200 (CEST)
In-Reply-To: <20190815154500.29090-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Daniel Baluta <daniel.baluta@nxp.com>

Add dummy support for SAI/ESAI digital audio interface
IPs found on i.MX8 boards.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof/dai.h         |  2 ++
 include/uapi/sound/sof/tokens.h |  8 ++++++++
 sound/soc/sof/topology.c        | 30 ++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/include/sound/sof/dai.h b/include/sound/sof/dai.h
index 5b8de1b1983c..7a84f7fb460a 100644
--- a/include/sound/sof/dai.h
+++ b/include/sound/sof/dai.h
@@ -50,6 +50,8 @@ enum sof_ipc_dai_type {
 	SOF_DAI_INTEL_DMIC,		/**< Intel DMIC */
 	SOF_DAI_INTEL_HDA,		/**< Intel HD/A */
 	SOF_DAI_INTEL_SOUNDWIRE,	/**< Intel SoundWire */
+	SOF_DAI_IMX_SAI,		/**< i.MX SAI */
+	SOF_DAI_IMX_ESAI,		/**< i.MX ESAI */
 };
 
 /* general purpose DAI configuration */
diff --git a/include/uapi/sound/sof/tokens.h b/include/uapi/sound/sof/tokens.h
index 6435240cef13..8f996857fb24 100644
--- a/include/uapi/sound/sof/tokens.h
+++ b/include/uapi/sound/sof/tokens.h
@@ -106,4 +106,12 @@
 /* for backward compatibility */
 #define SOF_TKN_EFFECT_TYPE	SOF_TKN_PROCESS_TYPE
 
+/* SAI */
+#define SOF_TKN_IMX_SAI_FIRST_TOKEN		1000
+/* TODO: Add SAI tokens */
+
+/* ESAI */
+#define SOF_TKN_IMX_ESAI_FIRST_TOKEN		1100
+/* TODO: Add ESAI tokens */
+
 #endif
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 9cffea142395..a215bf58b138 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -346,6 +346,8 @@ static const struct sof_dai_types sof_dais[] = {
 	{"SSP", SOF_DAI_INTEL_SSP},
 	{"HDA", SOF_DAI_INTEL_HDA},
 	{"DMIC", SOF_DAI_INTEL_DMIC},
+	{"SAI", SOF_DAI_IMX_SAI},
+	{"ESAI", SOF_DAI_IMX_ESAI},
 };
 
 static enum sof_ipc_dai_type find_dai(const char *name)
@@ -2513,6 +2515,26 @@ static int sof_link_ssp_load(struct snd_soc_component *scomp, int index,
 	return ret;
 }
 
+static int sof_link_sai_load(struct snd_soc_component *scomp, int index,
+			     struct snd_soc_dai_link *link,
+			     struct snd_soc_tplg_link_config *cfg,
+			     struct snd_soc_tplg_hw_config *hw_config,
+			     struct sof_ipc_dai_config *config)
+{
+	/*TODO: Add implementation */
+	return 0;
+}
+
+static int sof_link_esai_load(struct snd_soc_component *scomp, int index,
+			      struct snd_soc_dai_link *link,
+			      struct snd_soc_tplg_link_config *cfg,
+			      struct snd_soc_tplg_hw_config *hw_config,
+			      struct sof_ipc_dai_config *config)
+{
+	/*TODO: Add implementation */
+	return 0;
+}
+
 static int sof_link_dmic_load(struct snd_soc_component *scomp, int index,
 			      struct snd_soc_dai_link *link,
 			      struct snd_soc_tplg_link_config *cfg,
@@ -2837,6 +2859,14 @@ static int sof_link_load(struct snd_soc_component *scomp, int index,
 		ret = sof_link_hda_load(scomp, index, link, cfg, hw_config,
 					&config);
 		break;
+	case SOF_DAI_IMX_SAI:
+		ret = sof_link_sai_load(scomp, index, link, cfg, hw_config,
+					&config);
+		break;
+	case SOF_DAI_IMX_ESAI:
+		ret = sof_link_esai_load(scomp, index, link, cfg, hw_config,
+					 &config);
+		break;
 	default:
 		dev_err(sdev->dev, "error: invalid DAI type %d\n", config.type);
 		ret = -EINVAL;
-- 
2.20.1
