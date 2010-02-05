From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH -next] ASoC: pandora: Add DAC regulator support
Date: Fri,  5 Feb 2010 15:13:32 +0200
Message-ID: <1265375612-9079-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D92D1038BA
	for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2010 14:13:39 +0100 (CET)
Received: by ewy23 with SMTP id 23so183260ewy.4
	for <alsa-devel@alsa-project.org>; Fri, 05 Feb 2010 05:13:38 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

Pandora's external DAC is connected to VSIM TWL4030 supply, so let's
start switching it too to save more power.

Also DAC got it's own DAPM handler and the delay was removed
(it gave on audible improvement).

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 sound/soc/omap/omap3pandora.c |   37 +++++++++++++++++++++++++++++++------
 1 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index 68980c1..b978411 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -22,7 +22,7 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
-#include <linux/delay.h>
+#include <linux/regulator/consumer.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -40,6 +40,8 @@
 
 #define PREFIX "ASoC omap3pandora: "
 
+static struct regulator *omap3pandora_dac_reg;
+
 static int omap3pandora_cmn_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, unsigned int fmt)
 {
@@ -106,21 +108,31 @@ static int omap3pandora_in_hw_params(struct snd_pcm_substream *substream,
 					  SND_SOC_DAIFMT_CBS_CFS);
 }
 
-static int omap3pandora_hp_event(struct snd_soc_dapm_widget *w,
+static int omap3pandora_dac_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *k, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		regulator_enable(omap3pandora_dac_reg);
 		gpio_set_value(OMAP3_PANDORA_DAC_POWER_GPIO, 1);
-		gpio_set_value(OMAP3_PANDORA_AMP_POWER_GPIO, 1);
 	} else {
-		gpio_set_value(OMAP3_PANDORA_AMP_POWER_GPIO, 0);
-		mdelay(1);
 		gpio_set_value(OMAP3_PANDORA_DAC_POWER_GPIO, 0);
+		regulator_disable(omap3pandora_dac_reg);
 	}
 
 	return 0;
 }
 
+static int omap3pandora_hp_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *k, int event)
+{
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		gpio_set_value(OMAP3_PANDORA_AMP_POWER_GPIO, 1);
+	else
+		gpio_set_value(OMAP3_PANDORA_AMP_POWER_GPIO, 0);
+
+	return 0;
+}
+
 /*
  * Audio paths on Pandora board:
  *
@@ -130,7 +142,9 @@ static int omap3pandora_hp_event(struct snd_soc_dapm_widget *w,
  *  |P| <--- TWL4030 <--------- Line In and MICs
  */
 static const struct snd_soc_dapm_widget omap3pandora_out_dapm_widgets[] = {
-	SND_SOC_DAPM_DAC("PCM DAC", "HiFi Playback", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC_E("PCM DAC", "HiFi Playback", SND_SOC_NOPM,
+			   0, 0, omap3pandora_dac_event,
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_PGA_E("Headphone Amplifier", SND_SOC_NOPM,
 			   0, 0, NULL, 0, omap3pandora_hp_event,
 			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
@@ -306,8 +320,18 @@ static int __init omap3pandora_soc_init(void)
 		goto fail2;
 	}
 
+	omap3pandora_dac_reg = regulator_get(&omap3pandora_snd_device->dev, "vcc");
+	if (IS_ERR(omap3pandora_dac_reg)) {
+		pr_err(PREFIX "Failed to get DAC regulator from %s: %ld\n",
+			dev_name(&omap3pandora_snd_device->dev),
+			PTR_ERR(omap3pandora_dac_reg));
+		goto fail3;
+	}
+
 	return 0;
 
+fail3:
+	platform_device_del(omap3pandora_snd_device);
 fail2:
 	platform_device_put(omap3pandora_snd_device);
 fail1:
@@ -320,6 +344,7 @@ module_init(omap3pandora_soc_init);
 
 static void __exit omap3pandora_soc_exit(void)
 {
+	regulator_put(omap3pandora_dac_reg);
 	platform_device_unregister(omap3pandora_snd_device);
 	gpio_free(OMAP3_PANDORA_AMP_POWER_GPIO);
 	gpio_free(OMAP3_PANDORA_DAC_POWER_GPIO);
-- 
1.6.3.3
