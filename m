From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Add simplfied device registration
	for Atmel SSC devices
Date: Wed, 18 Aug 2010 16:30:42 +0100
Message-ID: <1282145442-32678-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1282145442-32678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 969EA24133
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 17:30:44 +0200 (CEST)
In-Reply-To: <1282145442-32678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since the SSC is already being registered as a device under arch and
the DMA and SSC hardware are pretty much the same provide a simplified
device registration function for the Atmel SSC which will add the
ASoC-specific devices within the ASoC code, parenting the SSC device
off the actual SSC device. Also use it in the sam9g20-ek driver.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/atmel_ssc_dai.c  |   57 ++++++++++++++++++++++++++++++++++++--
 sound/soc/atmel/atmel_ssc_dai.h  |    2 +
 sound/soc/atmel/sam9g20_wm8731.c |    6 ++++
 3 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index eabf66a..5d230ce 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -789,13 +789,14 @@ static struct snd_soc_dai_driver atmel_ssc_dai[NUM_SSC_DEVICES] = {
 
 static __devinit int asoc_ssc_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_dais(&pdev->dev, atmel_ssc_dai,
-			ARRAY_SIZE(atmel_ssc_dai));
+	BUG_ON(pdev->id < 0);
+	BUG_ON(pdev->id >= ARRAY_SIZE(atmel_ssc_dai));
+	return snd_soc_register_dai(&pdev->dev, &atmel_ssc_dai[pdev->id]);
 }
 
 static int __devexit asoc_ssc_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(atmel_ssc_dai));
+	snd_soc_unregister_dai(&pdev->dev);
 	return 0;
 }
 
@@ -809,6 +810,56 @@ static struct platform_driver asoc_ssc_driver = {
 	.remove = __devexit_p(asoc_ssc_remove),
 };
 
+/**
+ * atmel_ssc_set_audio - Allocate the specified SSC for audio use.
+ */
+int atmel_ssc_set_audio(int ssc_id)
+{
+	struct ssc_device *ssc;
+	static struct platform_device *dma_pdev;
+	struct platform_device *ssc_pdev;
+	int ret;
+
+	if (ssc_id < 0 || ssc_id >= ARRAY_SIZE(atmel_ssc_dai))
+		return -EINVAL;
+
+	/* Allocate a dummy device for DMA if we don't have one already */
+	if (!dma_pdev) {
+		dma_pdev = platform_device_alloc("atmel-pcm-audio", -1);
+		if (!dma_pdev)
+			return -ENOMEM;
+
+		ret = platform_device_add(dma_pdev);
+		if (ret < 0) {
+			platform_device_put(dma_pdev);
+			dma_pdev = NULL;
+			return ret;
+		}
+	}
+
+	ssc_pdev = platform_device_alloc("atmel-ssc-dai", ssc_id);
+	if (!ssc_pdev) {
+		ssc_free(ssc);
+		return -ENOMEM;
+	}
+
+	/* If we can grab the SSC briefly to parent the DAI device off it */
+	ssc = ssc_request(ssc_id);
+	if (IS_ERR(ssc))
+		pr_warn("Unable to parent ASoC SSC DAI on SSC: %ld\n",
+			PTR_ERR(ssc));
+	else
+		ssc_pdev->dev.parent = &(ssc->pdev->dev);
+	ssc_free(ssc);
+
+	ret = platform_device_add(ssc_pdev);
+	if (ret < 0)
+		platform_device_put(ssc_pdev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(atmel_ssc_set_audio);
+
 static int __init snd_atmel_ssc_init(void)
 {
 	return platform_driver_register(&asoc_ssc_driver);
diff --git a/sound/soc/atmel/atmel_ssc_dai.h b/sound/soc/atmel/atmel_ssc_dai.h
index 392a469..5d4f0f9 100644
--- a/sound/soc/atmel/atmel_ssc_dai.h
+++ b/sound/soc/atmel/atmel_ssc_dai.h
@@ -117,4 +117,6 @@ struct atmel_ssc_info {
 	struct atmel_ssc_state ssc_state;
 };
 
+int atmel_ssc_set_audio(int ssc);
+
 #endif /* _AT91_SSC_DAI_H */
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index cf029a8..293569d 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -205,6 +205,12 @@ static int __init at91sam9g20ek_init(void)
 	if (!(machine_is_at91sam9g20ek() || machine_is_at91sam9g20ek_2mmc()))
 		return -ENODEV;
 
+	ret = atmel_ssc_set_audio(0);
+	if (ret != 0) {
+		pr_err("Failed to set SSC 0 for audio: %d\n", ret);
+		return ret;
+	}
+
 	/*
 	 * Codec MCLK is supplied by PCK0 - set it up.
 	 */
-- 
1.7.1
