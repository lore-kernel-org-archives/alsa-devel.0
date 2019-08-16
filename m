From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: topology: initial support for
	Intel ALH DAI type" to the asoc tree
Date: Fri, 16 Aug 2019 13:14:52 +0100 (BST)
Message-ID: <20190816121452.7971627430F0@ypsilon.sirena.org.uk>
References: <20190815192018.30570-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f100.google.com (mail-ed1-f100.google.com
 [209.85.208.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74266F8011F
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2019 14:14:53 +0200 (CEST)
Received: by mail-ed1-f100.google.com with SMTP id s15so4973711edx.0
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2019 05:14:53 -0700 (PDT)
In-Reply-To: <20190815192018.30570-4-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: topology: initial support for Intel ALH DAI type

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 4d6bbf1a015c84ba05af9d8c59dd9c55cad4e668 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 15 Aug 2019 14:20:17 -0500
Subject: [PATCH] ASoC: SOF: topology: initial support for Intel ALH DAI type

The Audio Link Hub DAI does not require any static configuration from
topology for now. We still need to pass the frame rate and format to
firmware.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190815192018.30570-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
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
