From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH] ASoC: imx-spdif: Use snd-soc-dummy CODEC
	driver to link card
Date: Mon, 23 Dec 2013 17:28:53 +0800
Message-ID: <1387790933-29232-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 by alsa0.perex.cz (Postfix) with ESMTP id A60622607B6
 for <alsa-devel@alsa-project.org>; Mon, 23 Dec 2013 10:28:59 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, linux@arm.linux.org.uk
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This is a quick fix for the below two issues when building spdif as modules.

1) If modprobing modules in order: (Step 1) snd-soc-fsl-spdif -> (Step 2)
snd-soc-imx-spdif -> (Step 3) snd-soc-spdif-tx/rx, we will fail to create
imx-spdif card and dai link unless we rmmod snd-soc-imx-spdif and modprobe
it again due to the execution platform_driver_unregister() in probe() when
meeting -EPROBE_DEFER at Step 2.

2) After "imx-spdif sound-spdif.17: dit-hifi <-> 2004000.spdif mapping ok",
'rmmod snd-soc-imx-spdif' would cause kernel dump with warning:
WARNING: CPU: 0 PID: 1301 at /home/rmk/git/linux-rmk/fs/sysfs/dir.c:915 sysfs_hash_and_remove+0x84/0x90()
sysfs: can not remove 'dapm_widget', no directory
This should be caused by disordered resourse releasing of the whole link.
And trying to unregister the card and then CODEC dev can't fix this issue.

Thus this patch just provides a simple fix to these two bugs by using the
snd-soc-dummy in the core instead of seperate snd-soc-spdif-tx/rx so that
there's no need to handle the registering and unregistering of CODEC or
CODEC dai any more.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/Kconfig     |  1 -
 sound/soc/fsl/imx-spdif.c | 84 ++++++++++++-----------------------------------
 2 files changed, 21 insertions(+), 64 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index bb4ab96..1c7b3b7 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -201,7 +201,6 @@ config SND_SOC_IMX_SPDIF
 	tristate "SoC Audio support for i.MX boards with S/PDIF"
 	select SND_SOC_IMX_PCM_DMA
 	select SND_SOC_FSL_SPDIF
-	select SND_SOC_SPDIF
 	select REGMAP_MMIO
 	help
 	  SoC Audio support for i.MX boards with S/PDIF
diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
index 980dd1f..e1dc401 100644
--- a/sound/soc/fsl/imx-spdif.c
+++ b/sound/soc/fsl/imx-spdif.c
@@ -14,17 +14,15 @@
 #include <sound/soc.h>
 
 struct imx_spdif_data {
-	struct snd_soc_dai_link dai[2];
+	struct snd_soc_dai_link dai;
 	struct snd_soc_card card;
-	struct platform_device *txdev;
-	struct platform_device *rxdev;
 };
 
 static int imx_spdif_audio_probe(struct platform_device *pdev)
 {
 	struct device_node *spdif_np, *np = pdev->dev.of_node;
 	struct imx_spdif_data *data;
-	int ret = 0, num_links = 0;
+	int ret = 0;
 
 	spdif_np = of_parse_phandle(np, "spdif-controller", 0);
 	if (!spdif_np) {
@@ -39,69 +37,42 @@ static int imx_spdif_audio_probe(struct platform_device *pdev)
 		goto end;
 	}
 
-	if (of_property_read_bool(np, "spdif-out")) {
-		data->dai[num_links].name = "S/PDIF TX";
-		data->dai[num_links].stream_name = "S/PDIF PCM Playback";
-		data->dai[num_links].codec_dai_name = "dit-hifi";
-		data->dai[num_links].codec_name = "spdif-dit";
-		data->dai[num_links].cpu_of_node = spdif_np;
-		data->dai[num_links].platform_of_node = spdif_np;
-		num_links++;
-
-		data->txdev = platform_device_register_simple("spdif-dit", -1, NULL, 0);
-		if (IS_ERR(data->txdev)) {
-			ret = PTR_ERR(data->txdev);
-			dev_err(&pdev->dev, "register dit failed: %d\n", ret);
-			goto end;
-		}
-	}
+	data->dai.name = "S/PDIF PCM";
+	data->dai.stream_name = "S/PDIF PCM";
+	data->dai.codec_dai_name = "snd-soc-dummy-dai";
+	data->dai.codec_name = "snd-soc-dummy";
+	data->dai.cpu_of_node = spdif_np;
+	data->dai.platform_of_node = spdif_np;
+	data->dai.playback_only = true;
+	data->dai.capture_only = true;
 
-	if (of_property_read_bool(np, "spdif-in")) {
-		data->dai[num_links].name = "S/PDIF RX";
-		data->dai[num_links].stream_name = "S/PDIF PCM Capture";
-		data->dai[num_links].codec_dai_name = "dir-hifi";
-		data->dai[num_links].codec_name = "spdif-dir";
-		data->dai[num_links].cpu_of_node = spdif_np;
-		data->dai[num_links].platform_of_node = spdif_np;
-		num_links++;
-
-		data->rxdev = platform_device_register_simple("spdif-dir", -1, NULL, 0);
-		if (IS_ERR(data->rxdev)) {
-			ret = PTR_ERR(data->rxdev);
-			dev_err(&pdev->dev, "register dir failed: %d\n", ret);
-			goto error_dit;
-		}
-	}
+	if (of_property_read_bool(np, "spdif-out"))
+		data->dai.capture_only = false;
+
+	if (of_property_read_bool(np, "spdif-in"))
+		data->dai.playback_only = false;
 
-	if (!num_links) {
+	if (data->dai.playback_only && data->dai.capture_only) {
 		dev_err(&pdev->dev, "no enabled S/PDIF DAI link\n");
-		goto error_dir;
+		goto end;
 	}
 
 	data->card.dev = &pdev->dev;
-	data->card.num_links = num_links;
-	data->card.dai_link = data->dai;
+	data->card.dai_link = &data->dai;
+	data->card.num_links = 1;
 
 	ret = snd_soc_of_parse_card_name(&data->card, "model");
 	if (ret)
-		goto error_dir;
+		goto end;
 
 	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed: %d\n", ret);
-		goto error_dir;
+		goto end;
 	}
 
 	platform_set_drvdata(pdev, data);
 
-	goto end;
-
-error_dir:
-	if (data->rxdev)
-		platform_device_unregister(data->rxdev);
-error_dit:
-	if (data->txdev)
-		platform_device_unregister(data->txdev);
 end:
 	if (spdif_np)
 		of_node_put(spdif_np);
@@ -109,18 +80,6 @@ end:
 	return ret;
 }
 
-static int imx_spdif_audio_remove(struct platform_device *pdev)
-{
-	struct imx_spdif_data *data = platform_get_drvdata(pdev);
-
-	if (data->rxdev)
-		platform_device_unregister(data->rxdev);
-	if (data->txdev)
-		platform_device_unregister(data->txdev);
-
-	return 0;
-}
-
 static const struct of_device_id imx_spdif_dt_ids[] = {
 	{ .compatible = "fsl,imx-audio-spdif", },
 	{ /* sentinel */ }
@@ -134,7 +93,6 @@ static struct platform_driver imx_spdif_driver = {
 		.of_match_table = imx_spdif_dt_ids,
 	},
 	.probe = imx_spdif_audio_probe,
-	.remove = imx_spdif_audio_remove,
 };
 
 module_platform_driver(imx_spdif_driver);
-- 
1.8.4
