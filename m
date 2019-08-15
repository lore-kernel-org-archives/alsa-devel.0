From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/4] ASoC: SOF: topology: initial support for
	Intel ALH DAI type
Date: Thu, 15 Aug 2019 10:50:31 -0500
Message-ID: <20190815155032.29181-4-pierre-louis.bossart@linux.intel.com>
References: <20190815155032.29181-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D680F805F5
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 17:55:59 +0200 (CEST)
In-Reply-To: <20190815155032.29181-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The Audio Link Hub DAI does not require any static configuration from
topology for now. We still need to pass the frame rate and format to
firmware.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/topology.c | 42 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index a215bf58b138..28a7a6e06a53 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -346,6 +346,7 @@ static const struct sof_dai_types sof_dais[] = {
 	{"SSP", SOF_DAI_INTEL_SSP},
 	{"HDA", SOF_DAI_INTEL_HDA},
 	{"DMIC", SOF_DAI_INTEL_DMIC},
+	{"ALH", SOF_DAI_INTEL_ALH},
 	{"SAI", SOF_DAI_IMX_SAI},
 	{"ESAI", SOF_DAI_IMX_ESAI},
 };
@@ -2763,6 +2764,40 @@ static int sof_link_hda_load(struct snd_soc_component *scomp, int index,
 	return ret;
 }
 
+static int sof_link_alh_load(struct snd_soc_component *scomp, int index,
+			     struct snd_soc_dai_link *link,
+			     struct snd_soc_tplg_link_config *cfg,
+			     struct snd_soc_tplg_hw_config *hw_config,
+			     struct sof_ipc_dai_config *config)
+{
+	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
+	struct sof_ipc_reply reply;
+	u32 size = sizeof(*config);
+	int ret;
+
+	/* init IPC */
+	config->hdr.size = size;
+
+	/* send message to DSP */
+	ret = sof_ipc_tx_message(sdev->ipc,
+				 config->hdr.cmd, config, size, &reply,
+				 sizeof(reply));
+
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: failed to set DAI config for ALH %d\n",
+			config->dai_index);
+		return ret;
+	}
+
+	/* set config for all DAI's with name matching the link name */
+	ret = sof_set_dai_config(sdev, size, link, config);
+	if (ret < 0)
+		dev_err(sdev->dev, "error: failed to save DAI config for ALH %d\n",
+			config->dai_index);
+
+	return ret;
+}
+
 /* DAI link - used for any driver specific init */
 static int sof_link_load(struct snd_soc_component *scomp, int index,
 			 struct snd_soc_dai_link *link,
@@ -2859,6 +2894,10 @@ static int sof_link_load(struct snd_soc_component *scomp, int index,
 		ret = sof_link_hda_load(scomp, index, link, cfg, hw_config,
 					&config);
 		break;
+	case SOF_DAI_INTEL_ALH:
+		ret = sof_link_alh_load(scomp, index, link, cfg, hw_config,
+					&config);
+		break;
 	case SOF_DAI_IMX_SAI:
 		ret = sof_link_sai_load(scomp, index, link, cfg, hw_config,
 					&config);
@@ -2924,7 +2963,8 @@ static int sof_link_unload(struct snd_soc_component *scomp,
 	switch (sof_dai->dai_config->type) {
 	case SOF_DAI_INTEL_SSP:
 	case SOF_DAI_INTEL_DMIC:
-		/* no resource needs to be released for SSP and DMIC */
+	case SOF_DAI_INTEL_ALH:
+		/* no resource needs to be released for SSP, DMIC and ALH */
 		break;
 	case SOF_DAI_INTEL_HDA:
 		ret = sof_link_hda_unload(sdev, link);
-- 
2.20.1
