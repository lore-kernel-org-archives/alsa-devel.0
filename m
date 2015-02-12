From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch] ASoC: codec: Add missing deps/hdrs to MAX98357A
Date: Thu, 12 Feb 2015 02:35:54 -0800
Message-ID: <1423737354-27150-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

For the max98357a codec driver:
  - Add missing build dependancy to GPIOLIB in
    Kconfig.
  - Add header files to avoid implicit declarations
    and indirect inclusions.
  - Remove use of DRV_NAME constant.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
---
for topic/max98357a branch

 sound/soc/codecs/Kconfig     |  2 +-
 sound/soc/codecs/max98357a.c | 23 +++++++++++++++--------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6ecac1e4428eafc491d6cfc25110f6b3dbf699ed..0500b3ed5fa5ac4d45663ad659da9db3003bc5a3 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -69,7 +69,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX98088 if I2C
 	select SND_SOC_MAX98090 if I2C
 	select SND_SOC_MAX98095 if I2C
-	select SND_SOC_MAX98357A
+	select SND_SOC_MAX98357A if GPIOLIB
 	select SND_SOC_MAX9850 if I2C
 	select SND_SOC_MAX9768 if I2C
 	select SND_SOC_MAX9877 if I2C
diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index 1806333ea29e5a6b49e2a0adb8c58257d34b7508..4ee23fbc4e1237268ae104319a9cfe4fc369934e 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -12,11 +12,19 @@
  * max98357a.c -- MAX98357A ALSA SoC Codec driver
  */
 
-#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <sound/pcm.h>
 #include <sound/soc.h>
-
-#define DRV_NAME "max98357a"
+#include <sound/soc-dai.h>
+#include <sound/soc-dapm.h>
 
 static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
 		int cmd, struct snd_soc_dai *dai)
@@ -77,9 +85,9 @@ static struct snd_soc_dai_ops max98357a_dai_ops = {
 };
 
 static struct snd_soc_dai_driver max98357a_dai_driver = {
-	.name = DRV_NAME,
+	.name = "max98357a",
 	.playback = {
-		.stream_name	= DRV_NAME "-playback",
+		.stream_name	= "max98357a-playback",
 		.formats	= SNDRV_PCM_FMTBIT_S16 |
 					SNDRV_PCM_FMTBIT_S24 |
 					SNDRV_PCM_FMTBIT_S32,
@@ -117,7 +125,7 @@ static int max98357a_platform_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id max98357a_device_id[] = {
-	{ .compatible = "maxim," DRV_NAME, },
+	{ .compatible = "maxim,max98357a" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, max98357a_device_id);
@@ -125,7 +133,7 @@ MODULE_DEVICE_TABLE(of, max98357a_device_id);
 
 static struct platform_driver max98357a_platform_driver = {
 	.driver = {
-		.name = DRV_NAME,
+		.name = "max98357a",
 		.of_match_table = of_match_ptr(max98357a_device_id),
 	},
 	.probe	= max98357a_platform_probe,
@@ -135,4 +143,3 @@ module_platform_driver(max98357a_platform_driver);
 
 MODULE_DESCRIPTION("Maxim MAX98357A Codec Driver");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
