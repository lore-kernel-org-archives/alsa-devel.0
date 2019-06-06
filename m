From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sof: use modern dai_link style" to the
	asoc tree
Date: Thu,  6 Jun 2019 22:26:13 +0100 (BST)
Message-ID: <20190606212613.73D2F440046@finisterre.sirena.org.uk>
References: <87sgsnfjge.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F4EBF89751
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:14 +0200 (CEST)
In-Reply-To: <87sgsnfjge.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sof: use modern dai_link style

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 7ba06110de2628137554cf4da849ef08f255f385 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:19:24 +0900
Subject: [PATCH] ASoC: sof: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/nocodec.c  | 21 +++++++++++++++++----
 sound/soc/sof/topology.c | 20 +++++++++-----------
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/sound/soc/sof/nocodec.c b/sound/soc/sof/nocodec.c
index f84b4344dcc3..3d128e5a132c 100644
--- a/sound/soc/sof/nocodec.c
+++ b/sound/soc/sof/nocodec.c
@@ -21,6 +21,7 @@ static int sof_nocodec_bes_setup(struct device *dev,
 				 struct snd_soc_dai_link *links,
 				 int link_num, struct snd_soc_card *card)
 {
+	struct snd_soc_dai_link_component *dlc;
 	int i;
 
 	if (!ops || !links || !card)
@@ -28,17 +29,29 @@ static int sof_nocodec_bes_setup(struct device *dev,
 
 	/* set up BE dai_links */
 	for (i = 0; i < link_num; i++) {
+		dlc = devm_kzalloc(dev, 3 * sizeof(*dlc), GFP_KERNEL);
+		if (!dlc)
+			return -ENOMEM;
+
 		links[i].name = devm_kasprintf(dev, GFP_KERNEL,
 					       "NoCodec-%d", i);
 		if (!links[i].name)
 			return -ENOMEM;
 
+		links[i].cpus = &dlc[0];
+		links[i].codecs = &dlc[1];
+		links[i].platforms = &dlc[2];
+
+		links[i].num_cpus = 1;
+		links[i].num_codecs = 1;
+		links[i].num_platforms = 1;
+
 		links[i].id = i;
 		links[i].no_pcm = 1;
-		links[i].cpu_dai_name = ops->drv[i].name;
-		links[i].platform_name = dev_name(dev);
-		links[i].codec_dai_name = "snd-soc-dummy-dai";
-		links[i].codec_name = "snd-soc-dummy";
+		links[i].cpus->dai_name = ops->drv[i].name;
+		links[i].platforms->name = dev_name(dev);
+		links[i].codecs->dai_name = "snd-soc-dummy-dai";
+		links[i].codecs->name = "snd-soc-dummy";
 		links[i].dpcm_playback = 1;
 		links[i].dpcm_capture = 1;
 	}
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index b969686f954f..a13233ae6d0e 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -2639,7 +2639,6 @@ static int sof_link_hda_load(struct snd_soc_component *scomp, int index,
 			     struct sof_ipc_dai_config *config)
 {
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
-	struct snd_soc_dai_link_component dai_component;
 	struct snd_soc_tplg_private *private = &cfg->priv;
 	struct snd_soc_dai *dai;
 	u32 size = sizeof(*config);
@@ -2650,7 +2649,6 @@ static int sof_link_hda_load(struct snd_soc_component *scomp, int index,
 	int ret;
 
 	/* init IPC */
-	memset(&dai_component, 0, sizeof(dai_component));
 	memset(&config->hda, 0, sizeof(struct sof_ipc_dai_hda_params));
 	config->hdr.size = size;
 
@@ -2664,11 +2662,10 @@ static int sof_link_hda_load(struct snd_soc_component *scomp, int index,
 		return ret;
 	}
 
-	dai_component.dai_name = link->cpu_dai_name;
-	dai = snd_soc_find_dai(&dai_component);
+	dai = snd_soc_find_dai(link->cpus);
 	if (!dai) {
 		dev_err(sdev->dev, "error: failed to find dai %s in %s",
-			dai_component.dai_name, __func__);
+			link->cpus->dai_name, __func__);
 		return -EINVAL;
 	}
 
@@ -2708,7 +2705,11 @@ static int sof_link_load(struct snd_soc_component *scomp, int index,
 	int ret;
 	int i = 0;
 
-	link->platform_name = dev_name(sdev->dev);
+	if (!link->platforms) {
+		dev_err(sdev->dev, "error: no platforms\n");
+		return -EINVAL;
+	}
+	link->platforms->name = dev_name(sdev->dev);
 
 	/*
 	 * Set nonatomic property for FE dai links as their trigger action
@@ -2801,16 +2802,13 @@ static int sof_link_load(struct snd_soc_component *scomp, int index,
 static int sof_link_hda_unload(struct snd_sof_dev *sdev,
 			       struct snd_soc_dai_link *link)
 {
-	struct snd_soc_dai_link_component dai_component;
 	struct snd_soc_dai *dai;
 	int ret = 0;
 
-	memset(&dai_component, 0, sizeof(dai_component));
-	dai_component.dai_name = link->cpu_dai_name;
-	dai = snd_soc_find_dai(&dai_component);
+	dai = snd_soc_find_dai(link->cpus);
 	if (!dai) {
 		dev_err(sdev->dev, "error: failed to find dai %s in %s",
-			dai_component.dai_name, __func__);
+			link->cpus->dai_name, __func__);
 		return -EINVAL;
 	}
 
-- 
2.20.1
