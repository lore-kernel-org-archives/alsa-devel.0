From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH v2 4/4] ASoC: tegra: Harmony: Support the
	internal speaker
Date: Wed, 19 Jan 2011 13:50:05 -0700
Message-ID: <1295470205-26501-5-git-send-email-swarren@nvidia.com>
References: <1295470205-26501-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id E1F09103897
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 21:50:20 +0100 (CET)
In-Reply-To: <1295470205-26501-1-git-send-email-swarren@nvidia.com>
In-Reply-To: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Add DAPM widget definitions, and code to control the speaker amplifier
GPIO to the Harmony machine driver. Currently, this path is always enabled,
while playback is active, since jack detection isn't yet implemented.

The driver initialization path has been reworked a little, and a new
driver/device introduced, in order to allow platform data to be passed in,
currently containing just the speaker enable GPIO ID.

The GPIO is only requested during _init, since that's the first time it is
guaranteed that the WM8903 module is loaded, probed, and hence has exported
its GPIO chip.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/harmony.c |   89 +++++++++++++++++++++++++++++++++++++++------
 1 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
index b160b71..0e44dd6 100644
--- a/sound/soc/tegra/harmony.c
+++ b/sound/soc/tegra/harmony.c
@@ -2,7 +2,7 @@
  * harmony.c - Harmony machine ASoC driver
  *
  * Author: Stephen Warren <swarren@nvidia.com>
- * Copyright (C) 2010 - NVIDIA, Inc.
+ * Copyright (C) 2010-2011 - NVIDIA, Inc.
  *
  * Based on code copyright/by:
  *
@@ -29,7 +29,14 @@
  */
 
 #include <asm/mach-types.h>
+
+#include <linux/gpio.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <mach/harmony_audio.h>
+
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -40,9 +47,12 @@
 #include "tegra_pcm.h"
 #include "tegra_asoc_utils.h"
 
-#define PREFIX "ASoC Harmony: "
+#define DRV_NAME "tegra-snd-harmony"
+#define PREFIX DRV_NAME ": "
 
+static struct harmony_audio_platform_data *pdata;
 static struct platform_device *harmony_snd_device;
+static int gpio_spkr_en_requested;
 
 static int harmony_asoc_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
@@ -107,7 +117,19 @@ static struct snd_soc_ops harmony_asoc_ops = {
 	.hw_params = harmony_asoc_hw_params,
 };
 
+static int harmony_event_int_spk(struct snd_soc_dapm_widget *w,
+					struct snd_kcontrol *k, int event)
+{
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		gpio_set_value_cansleep(pdata->gpio_spkr_en, 1);
+	else
+		gpio_set_value_cansleep(pdata->gpio_spkr_en, 0);
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget harmony_dapm_widgets[] = {
+	SND_SOC_DAPM_SPK("Int Spk", harmony_event_int_spk),
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Mic Jack", NULL),
 };
@@ -115,6 +137,10 @@ static const struct snd_soc_dapm_widget harmony_dapm_widgets[] = {
 static const struct snd_soc_dapm_route harmony_audio_map[] = {
 	{"Headphone Jack", NULL, "HPOUTR"},
 	{"Headphone Jack", NULL, "HPOUTL"},
+	{"Int Spk", NULL, "ROP"},
+	{"Int Spk", NULL, "RON"},
+	{"Int Spk", NULL, "LOP"},
+	{"Int Spk", NULL, "LON"},
 	{"Mic Bias", NULL, "Mic Jack"},
 	{"IN1L", NULL, "Mic Bias"},
 };
@@ -123,6 +149,7 @@ static int harmony_asoc_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	int ret;
 
 	snd_soc_dapm_new_controls(dapm, harmony_dapm_widgets,
 					ARRAY_SIZE(harmony_dapm_widgets));
@@ -131,9 +158,19 @@ static int harmony_asoc_init(struct snd_soc_pcm_runtime *rtd)
 				ARRAY_SIZE(harmony_audio_map));
 
 	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
+	snd_soc_dapm_enable_pin(dapm, "Int Spk");
 	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
 	snd_soc_dapm_sync(dapm);
 
+	ret = gpio_request(pdata->gpio_spkr_en, "spkr_en");
+	if (ret) {
+		pr_err(PREFIX "cannot get spkr_en gpio\n");
+		return ret;
+	}
+	gpio_spkr_en_requested = 1;
+
+	gpio_direction_output(pdata->gpio_spkr_en, 0);
+
 	return 0;
 }
 
@@ -154,13 +191,19 @@ static struct snd_soc_card snd_soc_harmony = {
 	.num_links = 1,
 };
 
-static int __init harmony_soc_modinit(void)
+static __devinit int tegra_snd_harmony_probe(struct platform_device *pdev)
 {
 	int ret;
 
-	if (!machine_is_harmony()) {
-		pr_err(PREFIX "Not running on Tegra Harmony!\n");
-		return -ENODEV;
+	if (pdev->id != 0) {
+		dev_err(&pdev->dev, "ID %d out of range\n", pdev->id);
+		return -EINVAL;
+	}
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data supplied\n");
+		return -EINVAL;
 	}
 
 	ret = tegra_asoc_utils_init();
@@ -173,7 +216,7 @@ static int __init harmony_soc_modinit(void)
 	 */
 	harmony_snd_device = platform_device_alloc("soc-audio", -1);
 	if (harmony_snd_device == NULL) {
-		pr_err(PREFIX "platform_device_alloc failed\n");
+		dev_err(&pdev->dev, "platform_device_alloc failed\n");
 		ret = -ENOMEM;
 		goto err_clock_utils;
 	}
@@ -182,7 +225,7 @@ static int __init harmony_soc_modinit(void)
 
 	ret = platform_device_add(harmony_snd_device);
 	if (ret) {
-		pr_err(PREFIX "platform_device_add failed (%d)\n",
+		dev_err(&pdev->dev, "platform_device_add failed (%d)\n",
 			ret);
 		goto err_device_put;
 	}
@@ -195,15 +238,39 @@ err_clock_utils:
 	tegra_asoc_utils_fini();
 	return ret;
 }
-module_init(harmony_soc_modinit);
 
-static void __exit harmony_soc_modexit(void)
+static int __devexit tegra_snd_harmony_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(harmony_snd_device);
 
+	if (gpio_spkr_en_requested)
+		gpio_free(pdata->gpio_spkr_en);
+
 	tegra_asoc_utils_fini();
+
+	return 0;
+}
+
+static struct platform_driver tegra_snd_harmony_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+	},
+	.probe = tegra_snd_harmony_probe,
+	.remove = __devexit_p(tegra_snd_harmony_remove),
+};
+
+static int __init snd_tegra_harmony_init(void)
+{
+	return platform_driver_register(&tegra_snd_harmony_driver);
+}
+module_init(snd_tegra_harmony_init);
+
+static void __exit snd_tegra_harmony_exit(void)
+{
+	platform_driver_unregister(&tegra_snd_harmony_driver);
 }
-module_exit(harmony_soc_modexit);
+module_exit(snd_tegra_harmony_exit);
 
 MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
 MODULE_DESCRIPTION("Harmony machine ASoC driver");
-- 
1.7.1
