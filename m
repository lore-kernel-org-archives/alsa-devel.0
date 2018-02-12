From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: asrc: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:29:45 +0000
Message-ID: <E1elDEv-000391-43@debutante>
References: <871sivgav2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 26D6126758A
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:29:49 +0100 (CET)
In-Reply-To: <871sivgav2.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: asrc: replace platform to component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 7f1106616ab634c6b827ce7abf1331a2a817de40 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:46:46 +0000
Subject: [PATCH] ASoC: fsl: asrc: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_asrc.c     | 10 ----------
 sound/soc/fsl/fsl_asrc.h     |  3 ++-
 sound/soc/fsl/fsl_asrc_dma.c | 14 +++++++++-----
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 806d39927318..adfb8135d739 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -582,10 +582,6 @@ static struct snd_soc_dai_driver fsl_asrc_dai = {
 	.ops = &fsl_asrc_dai_ops,
 };
 
-static const struct snd_soc_component_driver fsl_asrc_component = {
-	.name = "fsl-asrc-dai",
-};
-
 static bool fsl_asrc_readable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -927,12 +923,6 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_snd_soc_register_platform(&pdev->dev, &fsl_asrc_platform);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register ASoC platform\n");
-		return ret;
-	}
-
 	return 0;
 }
 
diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index 2c5856ac5bc3..d558dd5499a5 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -462,6 +462,7 @@ struct fsl_asrc {
 	u32 regcache_cfg;
 };
 
-extern struct snd_soc_platform_driver fsl_asrc_platform;
+#define DRV_NAME "fsl-asrc-dai"
+extern struct snd_soc_component_driver fsl_asrc_component;
 struct dma_chan *fsl_asrc_get_dma_channel(struct fsl_asrc_pair *pair, bool dir);
 #endif /* _FSL_ASRC_H */
diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index e1b97e59275a..565e16d8fe85 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -64,7 +64,8 @@ static int fsl_asrc_dma_prepare_and_submit(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_asrc_pair *pair = runtime->private_data;
-	struct device *dev = rtd->platform->dev;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct device *dev = component->dev;
 	unsigned long flags = DMA_CTRL_ACK;
 
 	/* Prepare and submit Front-End DMA channel */
@@ -137,12 +138,13 @@ static int fsl_asrc_dma_hw_params(struct snd_pcm_substream *substream,
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	struct snd_dmaengine_dai_dma_data *dma_params_fe = NULL;
 	struct snd_dmaengine_dai_dma_data *dma_params_be = NULL;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_asrc_pair *pair = runtime->private_data;
 	struct fsl_asrc *asrc_priv = pair->asrc_priv;
 	struct dma_slave_config config_fe, config_be;
 	enum asrc_pair_index index = pair->index;
-	struct device *dev = rtd->platform->dev;
+	struct device *dev = component->dev;
 	int stream = substream->stream;
 	struct imx_dma_data *tmp_data;
 	struct snd_soc_dpcm *dpcm;
@@ -274,7 +276,8 @@ static int fsl_asrc_dma_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct device *dev = rtd->platform->dev;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct device *dev = component->dev;
 	struct fsl_asrc *asrc_priv = dev_get_drvdata(dev);
 	struct fsl_asrc_pair *pair;
 
@@ -381,9 +384,10 @@ static void fsl_asrc_dma_pcm_free(struct snd_pcm *pcm)
 	}
 }
 
-struct snd_soc_platform_driver fsl_asrc_platform = {
+struct snd_soc_component_driver fsl_asrc_component = {
+	.name		= DRV_NAME,
 	.ops		= &fsl_asrc_dma_pcm_ops,
 	.pcm_new	= fsl_asrc_dma_pcm_new,
 	.pcm_free	= fsl_asrc_dma_pcm_free,
 };
-EXPORT_SYMBOL_GPL(fsl_asrc_platform);
+EXPORT_SYMBOL_GPL(fsl_asrc_component);
-- 
2.16.1
