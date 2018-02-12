From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: txx9aclc: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:28:20 +0000
Message-ID: <E1elDDY-0002uc-4S@debutante>
References: <87efmvew2f.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C62A1267351
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:28:24 +0100 (CET)
In-Reply-To: <87efmvew2f.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: txx9aclc: replace platform to component

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

>From e049cf4e6adcb14e34c37123a67158a7e671d000 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:51:26 +0000
Subject: [PATCH] ASoC: txx9aclc: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/txx9/txx9aclc.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index a2bb68fea5a3..8d31fe628e2f 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -23,6 +23,8 @@
 #include <sound/soc.h>
 #include "txx9aclc.h"
 
+#define DRV_NAME "txx9aclc"
+
 static struct txx9aclc_soc_device {
 	struct txx9aclc_dmadata dmadata[2];
 } txx9aclc_soc_device;
@@ -53,6 +55,7 @@ static int txx9aclc_pcm_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
 	struct txx9aclc_dmadata *dmadata = runtime->private_data;
 	int ret;
 
@@ -60,13 +63,13 @@ static int txx9aclc_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	dev_dbg(rtd->platform->dev,
+	dev_dbg(component->dev,
 		"runtime->dma_area = %#lx dma_addr = %#lx dma_bytes = %zd "
 		"runtime->min_align %ld\n",
 		(unsigned long)runtime->dma_area,
 		(unsigned long)runtime->dma_addr, runtime->dma_bytes,
 		runtime->min_align);
-	dev_dbg(rtd->platform->dev,
+	dev_dbg(component->dev,
 		"periods %d period_bytes %d stream %d\n",
 		params_periods(params), params_period_bytes(params),
 		substream->stream);
@@ -287,7 +290,8 @@ static int txx9aclc_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	struct snd_card *card = rtd->card->snd_card;
 	struct snd_soc_dai *dai = rtd->cpu_dai;
 	struct snd_pcm *pcm = rtd->pcm;
-	struct platform_device *pdev = to_platform_device(rtd->platform->dev);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct platform_device *pdev = to_platform_device(component->dev);
 	struct txx9aclc_soc_device *dev;
 	struct resource *r;
 	int i;
@@ -371,15 +375,15 @@ static int txx9aclc_dma_init(struct txx9aclc_soc_device *dev,
 	return 0;
 }
 
-static int txx9aclc_pcm_probe(struct snd_soc_platform *platform)
+static int txx9aclc_pcm_probe(struct snd_soc_component *component)
 {
-	snd_soc_platform_set_drvdata(platform, &txx9aclc_soc_device);
+	snd_soc_component_set_drvdata(component, &txx9aclc_soc_device);
 	return 0;
 }
 
-static int txx9aclc_pcm_remove(struct snd_soc_platform *platform)
+static void txx9aclc_pcm_remove(struct snd_soc_component *component)
 {
-	struct txx9aclc_soc_device *dev = snd_soc_platform_get_drvdata(platform);
+	struct txx9aclc_soc_device *dev = snd_soc_component_get_drvdata(component);
 	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_drvdata;
 	void __iomem *base = drvdata->base;
 	int i;
@@ -400,10 +404,10 @@ static int txx9aclc_pcm_remove(struct snd_soc_platform *platform)
 		}
 		dev->dmadata[i].dma_chan = NULL;
 	}
-	return 0;
 }
 
-static const struct snd_soc_platform_driver txx9aclc_soc_platform = {
+static const struct snd_soc_component_driver txx9aclc_soc_component = {
+	.name		= DRV_NAME,
 	.probe		= txx9aclc_pcm_probe,
 	.remove		= txx9aclc_pcm_remove,
 	.ops		= &txx9aclc_pcm_ops,
@@ -412,8 +416,8 @@ static const struct snd_soc_platform_driver txx9aclc_soc_platform = {
 
 static int txx9aclc_soc_platform_probe(struct platform_device *pdev)
 {
-	return devm_snd_soc_register_platform(&pdev->dev,
-					      &txx9aclc_soc_platform);
+	return devm_snd_soc_register_component(&pdev->dev,
+					&txx9aclc_soc_component, NULL, 0);
 }
 
 static struct platform_driver txx9aclc_pcm_driver = {
-- 
2.16.1
