From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: sai: simplify dai driver
	initialisation" to the asoc tree
Date: Fri, 26 Apr 2019 11:03:07 +0100 (BST)
Message-ID: <20190426100307.D354E441D3B@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EFD61F896CC
 for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2019 12:03:15 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: sai: simplify dai driver initialisation

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

>From 8f8a54884dfd3d756693b7f174a06397bf19d8a5 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Tue, 23 Apr 2019 17:58:08 +0200
Subject: [PATCH] ASoC: stm32: sai: simplify dai driver initialisation

Suppress the useless dynamic allocation of the dai driver structure.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 43 ++++++++---------------------------
 1 file changed, 9 insertions(+), 34 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 3dd54bc54fa1..e3b021c9e8d0 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -109,7 +109,7 @@ struct stm32_sai_sub_data {
 	struct regmap *regmap;
 	const struct regmap_config *regmap_config;
 	struct snd_dmaengine_dai_dma_data dma_params;
-	struct snd_soc_dai_driver *cpu_dai_drv;
+	struct snd_soc_dai_driver cpu_dai_drv;
 	struct snd_soc_dai *cpu_dai;
 	struct snd_pcm_substream *substream;
 	struct stm32_sai_data *pdata;
@@ -1204,8 +1204,7 @@ static const struct snd_pcm_hardware stm32_sai_pcm_hw = {
 	.periods_max = 8,
 };
 
-static struct snd_soc_dai_driver stm32_sai_playback_dai[] = {
-{
+static struct snd_soc_dai_driver stm32_sai_playback_dai = {
 		.probe = stm32_sai_dai_probe,
 		.pcm_new = stm32_sai_pcm_new,
 		.id = 1, /* avoid call to fmt_single_name() */
@@ -1222,11 +1221,9 @@ static struct snd_soc_dai_driver stm32_sai_playback_dai[] = {
 				SNDRV_PCM_FMTBIT_S32_LE,
 		},
 		.ops = &stm32_sai_pcm_dai_ops,
-	}
 };
 
-static struct snd_soc_dai_driver stm32_sai_capture_dai[] = {
-{
+static struct snd_soc_dai_driver stm32_sai_capture_dai = {
 		.probe = stm32_sai_dai_probe,
 		.id = 1, /* avoid call to fmt_single_name() */
 		.capture = {
@@ -1242,7 +1239,6 @@ static struct snd_soc_dai_driver stm32_sai_capture_dai[] = {
 				SNDRV_PCM_FMTBIT_S32_LE,
 		},
 		.ops = &stm32_sai_pcm_dai_ops,
-	}
 };
 
 static const struct snd_dmaengine_pcm_config stm32_sai_pcm_config = {
@@ -1411,29 +1407,6 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 	return 0;
 }
 
-static int stm32_sai_sub_dais_init(struct platform_device *pdev,
-				   struct stm32_sai_sub_data *sai)
-{
-	sai->cpu_dai_drv = devm_kzalloc(&pdev->dev,
-					sizeof(struct snd_soc_dai_driver),
-					GFP_KERNEL);
-	if (!sai->cpu_dai_drv)
-		return -ENOMEM;
-
-	if (STM_SAI_IS_PLAYBACK(sai)) {
-		memcpy(sai->cpu_dai_drv, &stm32_sai_playback_dai,
-		       sizeof(stm32_sai_playback_dai));
-		sai->cpu_dai_drv->playback.stream_name = sai->cpu_dai_drv->name;
-	} else {
-		memcpy(sai->cpu_dai_drv, &stm32_sai_capture_dai,
-		       sizeof(stm32_sai_capture_dai));
-		sai->cpu_dai_drv->capture.stream_name = sai->cpu_dai_drv->name;
-	}
-	sai->cpu_dai_drv->name = dev_name(&pdev->dev);
-
-	return 0;
-}
-
 static int stm32_sai_sub_probe(struct platform_device *pdev)
 {
 	struct stm32_sai_sub_data *sai;
@@ -1465,9 +1438,11 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = stm32_sai_sub_dais_init(pdev, sai);
-	if (ret)
-		return ret;
+	if (STM_SAI_IS_PLAYBACK(sai))
+		sai->cpu_dai_drv = stm32_sai_playback_dai;
+	else
+		sai->cpu_dai_drv = stm32_sai_capture_dai;
+	sai->cpu_dai_drv.name = dev_name(&pdev->dev);
 
 	ret = devm_request_irq(&pdev->dev, sai->pdata->irq, stm32_sai_isr,
 			       IRQF_SHARED, dev_name(&pdev->dev), sai);
@@ -1477,7 +1452,7 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &stm32_component,
-					      sai->cpu_dai_drv, 1);
+					      &sai->cpu_dai_drv, 1);
 	if (ret)
 		return ret;
 
-- 
2.20.1
