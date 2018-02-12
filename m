From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514-spi: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:30:26 +0000
Message-ID: <E1elDFa-0003ED-8R@debutante>
References: <878td3gazl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FFED26753E
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:30:30 +0100 (CET)
In-Reply-To: <878td3gazl.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514-spi: replace platform to component

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

>From 9fe3b2bac02c6d06724d526b0245568bca49349f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:45:13 +0000
Subject: [PATCH] ASoC: rt5514-spi: replace platform to component

Now platform can be replaced to component, let's do it.
This patch merges rt5514_spi_dai_component into rt5514_spi_component

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514-spi.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 2144edca97b0..84184d90385b 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -35,6 +35,8 @@
 
 #include "rt5514-spi.h"
 
+#define DRV_NAME "rt5514-spi"
+
 static struct spi_device *rt5514_spi;
 
 struct rt5514_dsp {
@@ -211,8 +213,9 @@ static int rt5514_spi_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
 	struct rt5514_dsp *rt5514_dsp =
-			snd_soc_platform_get_drvdata(rtd->platform);
+		snd_soc_component_get_drvdata(component);
 	int ret;
 	u8 buf[8];
 
@@ -235,8 +238,9 @@ static int rt5514_spi_hw_params(struct snd_pcm_substream *substream,
 static int rt5514_spi_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
 	struct rt5514_dsp *rt5514_dsp =
-			snd_soc_platform_get_drvdata(rtd->platform);
+		snd_soc_component_get_drvdata(component);
 
 	mutex_lock(&rt5514_dsp->dma_lock);
 	rt5514_dsp->substream = NULL;
@@ -252,8 +256,9 @@ static snd_pcm_uframes_t rt5514_spi_pcm_pointer(
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
 	struct rt5514_dsp *rt5514_dsp =
-		snd_soc_platform_get_drvdata(rtd->platform);
+		snd_soc_component_get_drvdata(component);
 
 	return bytes_to_frames(runtime, rt5514_dsp->dma_offset);
 }
@@ -267,18 +272,18 @@ static const struct snd_pcm_ops rt5514_spi_pcm_ops = {
 	.page		= snd_pcm_lib_get_vmalloc_page,
 };
 
-static int rt5514_spi_pcm_probe(struct snd_soc_platform *platform)
+static int rt5514_spi_pcm_probe(struct snd_soc_component *component)
 {
 	struct rt5514_dsp *rt5514_dsp;
 	int ret;
 
-	rt5514_dsp = devm_kzalloc(platform->dev, sizeof(*rt5514_dsp),
+	rt5514_dsp = devm_kzalloc(component->dev, sizeof(*rt5514_dsp),
 			GFP_KERNEL);
 
 	rt5514_dsp->dev = &rt5514_spi->dev;
 	mutex_init(&rt5514_dsp->dma_lock);
 	INIT_DELAYED_WORK(&rt5514_dsp->copy_work, rt5514_spi_copy_work);
-	snd_soc_platform_set_drvdata(platform, rt5514_dsp);
+	snd_soc_component_set_drvdata(component, rt5514_dsp);
 
 	if (rt5514_spi->irq) {
 		ret = devm_request_threaded_irq(&rt5514_spi->dev,
@@ -296,15 +301,12 @@ static int rt5514_spi_pcm_probe(struct snd_soc_platform *platform)
 	return 0;
 }
 
-static const struct snd_soc_platform_driver rt5514_spi_platform = {
+static const struct snd_soc_component_driver rt5514_spi_component = {
+	.name  = DRV_NAME,
 	.probe = rt5514_spi_pcm_probe,
 	.ops = &rt5514_spi_pcm_ops,
 };
 
-static const struct snd_soc_component_driver rt5514_spi_dai_component = {
-	.name		= "rt5514-spi-dai",
-};
-
 /**
  * rt5514_spi_burst_read - Read data from SPI by rt5514 address.
  * @addr: Start address.
@@ -445,14 +447,8 @@ static int rt5514_spi_probe(struct spi_device *spi)
 
 	rt5514_spi = spi;
 
-	ret = devm_snd_soc_register_platform(&spi->dev, &rt5514_spi_platform);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Failed to register platform.\n");
-		return ret;
-	}
-
 	ret = devm_snd_soc_register_component(&spi->dev,
-					      &rt5514_spi_dai_component,
+					      &rt5514_spi_component,
 					      &rt5514_spi_dai, 1);
 	if (ret < 0) {
 		dev_err(&spi->dev, "Failed to register component.\n");
-- 
2.16.1
