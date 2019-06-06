From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: mpc8610_hpcd/p1022_ds/p1022_rdk:
	use modern dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:32 +0100 (BST)
Message-ID: <20190606212632.32EE2440046@finisterre.sirena.org.uk>
References: <875zpjicrx.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12CF9F89740
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:33 +0200 (CEST)
In-Reply-To: <875zpjicrx.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: fsl: mpc8610_hpcd/p1022_ds/p1022_rdk: use modern dai_link style

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

>From 6aa7b4091d0bd3866d42e368ef32674aa1c155cc Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:15:25 +0900
Subject: [PATCH] ASoC: fsl: mpc8610_hpcd/p1022_ds/p1022_rdk: use modern
 dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

mpc8610_hpcd/p1022_ds/p1022_rdk are sharing fsl_asoc_get_dma_channel()
which setups platform. We need to update these by 1 patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_utils.c    |  2 +-
 sound/soc/fsl/mpc8610_hpcd.c | 33 ++++++++++++++++++++++++++++-----
 sound/soc/fsl/p1022_ds.c     | 36 ++++++++++++++++++++++++++++++------
 sound/soc/fsl/p1022_rdk.c    | 35 +++++++++++++++++++++++++++++------
 4 files changed, 88 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/fsl_utils.c b/sound/soc/fsl/fsl_utils.c
index 040d06b89f00..9bab202569af 100644
--- a/sound/soc/fsl/fsl_utils.c
+++ b/sound/soc/fsl/fsl_utils.c
@@ -57,7 +57,7 @@ int fsl_asoc_get_dma_channel(struct device_node *ssi_np,
 		of_node_put(dma_channel_np);
 		return ret;
 	}
-	snprintf((char *)dai->platform_name, DAI_NAME_SIZE, "%llx.%pOFn",
+	snprintf((char *)dai->platforms->name, DAI_NAME_SIZE, "%llx.%pOFn",
 		 (unsigned long long) res.start, dma_channel_np);
 
 	iprop = of_get_property(dma_channel_np, "cell-index", NULL);
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index f6261a3eeb0f..23617eb09ba1 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -189,6 +189,7 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	struct device_node *np = ssi_pdev->dev.of_node;
 	struct device_node *codec_np = NULL;
 	struct mpc8610_hpcd_data *machine_data;
+	struct snd_soc_dai_link_component *comp;
 	int ret = -ENODEV;
 	const char *sprop;
 	const u32 *iprop;
@@ -206,14 +207,36 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 		goto error_alloc;
 	}
 
-	machine_data->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
+	comp = devm_kzalloc(&pdev->dev, 6 * sizeof(*comp), GFP_KERNEL);
+	if (!comp) {
+		ret = -ENOMEM;
+		goto error_alloc;
+	}
+
+	machine_data->dai[0].cpus	= &comp[0];
+	machine_data->dai[0].codecs	= &comp[1];
+	machine_data->dai[0].platforms	= &comp[2];
+
+	machine_data->dai[0].num_cpus		= 1;
+	machine_data->dai[0].num_codecs		= 1;
+	machine_data->dai[0].num_platforms	= 1;
+
+	machine_data->dai[1].cpus	= &comp[3];
+	machine_data->dai[1].codecs	= &comp[4];
+	machine_data->dai[1].platforms	= &comp[5];
+
+	machine_data->dai[1].num_cpus		= 1;
+	machine_data->dai[1].num_codecs		= 1;
+	machine_data->dai[1].num_platforms	= 1;
+
+	machine_data->dai[0].cpus->dai_name = dev_name(&ssi_pdev->dev);
 	machine_data->dai[0].ops = &mpc8610_hpcd_ops;
 
 	/* ASoC core can match codec with device node */
-	machine_data->dai[0].codec_of_node = codec_np;
+	machine_data->dai[0].codecs->of_node = codec_np;
 
 	/* The DAI name from the codec (snd_soc_dai_driver.name) */
-	machine_data->dai[0].codec_dai_name = "cs4270-hifi";
+	machine_data->dai[0].codecs->dai_name = "cs4270-hifi";
 
 	/* We register two DAIs per SSI, one for playback and the other for
 	 * capture.  Currently, we only support codecs that have one DAI for
@@ -306,7 +329,7 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	}
 
 	/* Find the playback DMA channel to use. */
-	machine_data->dai[0].platform_name = machine_data->platform_name[0];
+	machine_data->dai[0].platforms->name = machine_data->platform_name[0];
 	ret = fsl_asoc_get_dma_channel(np, "fsl,playback-dma",
 				       &machine_data->dai[0],
 				       &machine_data->dma_channel_id[0],
@@ -317,7 +340,7 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	}
 
 	/* Find the capture DMA channel to use. */
-	machine_data->dai[1].platform_name = machine_data->platform_name[1];
+	machine_data->dai[1].platforms->name = machine_data->platform_name[1];
 	ret = fsl_asoc_get_dma_channel(np, "fsl,capture-dma",
 				       &machine_data->dai[1],
 				       &machine_data->dma_channel_id[1],
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 80384f70878d..6114b01b90f7 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -199,6 +199,7 @@ static int p1022_ds_probe(struct platform_device *pdev)
 	struct device_node *np = ssi_pdev->dev.of_node;
 	struct device_node *codec_np = NULL;
 	struct machine_data *mdata;
+	struct snd_soc_dai_link_component *comp;
 	int ret = -ENODEV;
 	const char *sprop;
 	const u32 *iprop;
@@ -216,11 +217,34 @@ static int p1022_ds_probe(struct platform_device *pdev)
 		goto error_put;
 	}
 
-	mdata->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
+	comp = devm_kzalloc(&pdev->dev, 6 * sizeof(*comp), GFP_KERNEL);
+	if (!comp) {
+		ret = -ENOMEM;
+		goto error_put;
+	}
+
+	mdata->dai[0].cpus	= &comp[0];
+	mdata->dai[0].codecs	= &comp[1];
+	mdata->dai[0].platforms	= &comp[2];
+
+	mdata->dai[0].num_cpus		= 1;
+	mdata->dai[0].num_codecs	= 1;
+	mdata->dai[0].num_platforms	= 1;
+
+	mdata->dai[1].cpus	= &comp[3];
+	mdata->dai[1].codecs	= &comp[4];
+	mdata->dai[1].platforms	= &comp[5];
+
+	mdata->dai[1].num_cpus		= 1;
+	mdata->dai[1].num_codecs	= 1;
+	mdata->dai[1].num_platforms	= 1;
+
+
+	mdata->dai[0].cpus->dai_name = dev_name(&ssi_pdev->dev);
 	mdata->dai[0].ops = &p1022_ds_ops;
 
 	/* ASoC core can match codec with device node */
-	mdata->dai[0].codec_of_node = codec_np;
+	mdata->dai[0].codecs->of_node = codec_np;
 
 	/* We register two DAIs per SSI, one for playback and the other for
 	 * capture.  We support codecs that have separate DAIs for both playback
@@ -229,8 +253,8 @@ static int p1022_ds_probe(struct platform_device *pdev)
 	memcpy(&mdata->dai[1], &mdata->dai[0], sizeof(struct snd_soc_dai_link));
 
 	/* The DAI names from the codec (snd_soc_dai_driver.name) */
-	mdata->dai[0].codec_dai_name = "wm8776-hifi-playback";
-	mdata->dai[1].codec_dai_name = "wm8776-hifi-capture";
+	mdata->dai[0].codecs->dai_name = "wm8776-hifi-playback";
+	mdata->dai[1].codecs->dai_name = "wm8776-hifi-capture";
 
 	/* Get the device ID */
 	iprop = of_get_property(np, "cell-index", NULL);
@@ -316,7 +340,7 @@ static int p1022_ds_probe(struct platform_device *pdev)
 	}
 
 	/* Find the playback DMA channel to use. */
-	mdata->dai[0].platform_name = mdata->platform_name[0];
+	mdata->dai[0].platforms->name = mdata->platform_name[0];
 	ret = fsl_asoc_get_dma_channel(np, "fsl,playback-dma", &mdata->dai[0],
 				       &mdata->dma_channel_id[0],
 				       &mdata->dma_id[0]);
@@ -326,7 +350,7 @@ static int p1022_ds_probe(struct platform_device *pdev)
 	}
 
 	/* Find the capture DMA channel to use. */
-	mdata->dai[1].platform_name = mdata->platform_name[1];
+	mdata->dai[1].platforms->name = mdata->platform_name[1];
 	ret = fsl_asoc_get_dma_channel(np, "fsl,capture-dma", &mdata->dai[1],
 				       &mdata->dma_channel_id[1],
 				       &mdata->dma_id[1]);
diff --git a/sound/soc/fsl/p1022_rdk.c b/sound/soc/fsl/p1022_rdk.c
index 1c32c2d8c6b0..72687235c0ae 100644
--- a/sound/soc/fsl/p1022_rdk.c
+++ b/sound/soc/fsl/p1022_rdk.c
@@ -203,6 +203,7 @@ static int p1022_rdk_probe(struct platform_device *pdev)
 	struct device_node *np = ssi_pdev->dev.of_node;
 	struct device_node *codec_np = NULL;
 	struct machine_data *mdata;
+	struct snd_soc_dai_link_component *comp;
 	const u32 *iprop;
 	int ret;
 
@@ -219,11 +220,33 @@ static int p1022_rdk_probe(struct platform_device *pdev)
 		goto error_put;
 	}
 
-	mdata->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
+	comp = devm_kzalloc(&pdev->dev, 6 * sizeof(*comp), GFP_KERNEL);
+	if (!comp) {
+		ret = -ENOMEM;
+		goto error_put;
+	}
+
+	mdata->dai[0].cpus	= &comp[0];
+	mdata->dai[0].codecs	= &comp[1];
+	mdata->dai[0].platforms	= &comp[2];
+
+	mdata->dai[0].num_cpus		= 1;
+	mdata->dai[0].num_codecs	= 1;
+	mdata->dai[0].num_platforms	= 1;
+
+	mdata->dai[1].cpus	= &comp[3];
+	mdata->dai[1].codecs	= &comp[4];
+	mdata->dai[1].platforms	= &comp[5];
+
+	mdata->dai[1].num_cpus		= 1;
+	mdata->dai[1].num_codecs	= 1;
+	mdata->dai[1].num_platforms	= 1;
+
+	mdata->dai[0].cpus->dai_name = dev_name(&ssi_pdev->dev);
 	mdata->dai[0].ops = &p1022_rdk_ops;
 
 	/* ASoC core can match codec with device node */
-	mdata->dai[0].codec_of_node = codec_np;
+	mdata->dai[0].codecs->of_node = codec_np;
 
 	/*
 	 * We register two DAIs per SSI, one for playback and the other for
@@ -233,8 +256,8 @@ static int p1022_rdk_probe(struct platform_device *pdev)
 	memcpy(&mdata->dai[1], &mdata->dai[0], sizeof(struct snd_soc_dai_link));
 
 	/* The DAI names from the codec (snd_soc_dai_driver.name) */
-	mdata->dai[0].codec_dai_name = "wm8960-hifi";
-	mdata->dai[1].codec_dai_name = mdata->dai[0].codec_dai_name;
+	mdata->dai[0].codecs->dai_name = "wm8960-hifi";
+	mdata->dai[1].codecs->dai_name = mdata->dai[0].codecs->dai_name;
 
 	/*
 	 * Configure the SSI for I2S slave mode.  Older device trees have
@@ -266,7 +289,7 @@ static int p1022_rdk_probe(struct platform_device *pdev)
 	}
 
 	/* Find the playback DMA channel to use. */
-	mdata->dai[0].platform_name = mdata->platform_name[0];
+	mdata->dai[0].platforms->name = mdata->platform_name[0];
 	ret = fsl_asoc_get_dma_channel(np, "fsl,playback-dma", &mdata->dai[0],
 				       &mdata->dma_channel_id[0],
 				       &mdata->dma_id[0]);
@@ -277,7 +300,7 @@ static int p1022_rdk_probe(struct platform_device *pdev)
 	}
 
 	/* Find the capture DMA channel to use. */
-	mdata->dai[1].platform_name = mdata->platform_name[1];
+	mdata->dai[1].platforms->name = mdata->platform_name[1];
 	ret = fsl_asoc_get_dma_channel(np, "fsl,capture-dma", &mdata->dai[1],
 				       &mdata->dma_channel_id[1],
 				       &mdata->dma_id[1]);
-- 
2.20.1
