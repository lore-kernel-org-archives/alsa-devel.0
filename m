From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 7/7] ASoC: Intel: bytcr_rt5651: Add quirk
	for PoV TAB-P1006W-232 (v1.0) tablet
Date: Sun, 30 Dec 2018 00:00:25 +0100
Message-ID: <20181229230025.21949-8-hdegoede@redhat.com>
References: <20181229230025.21949-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 117B1267B52
 for <alsa-devel@alsa-project.org>; Sun, 30 Dec 2018 00:00:44 +0100 (CET)
In-Reply-To: <20181229230025.21949-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, flove@realtek.com, shumingf@realtek.com, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add a DMI quirk for the Point of View TAB-P1006W-232 (v1.0) tablet, this
tablet is special in a number of ways:

1) It uses the 2nd GPIO resource in the ACPI tables for jack-detect rather
then using the rt5651 codec's builtin jack-detect functionality

2) It uses the 3th GPIO resource in the ACPI tables to control the
external amplifier rather then the usual first non GpioInt resource and
the GPIO is active-low.

3) It is a BYTCR device, without a CHAN package and it uses SSP0-AIF1
rather then the default SSP0-AIF2.

4) Its internal mic is a digital mic (the first x86 rt5651 device that
I'm aware of which does this), combined with having its headset-mic
connected to IN2.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 48 ++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 9a2ee9080897..b618d984e2d5 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -95,6 +95,8 @@ struct byt_rt5651_private {
 	struct snd_soc_jack jack;
 };
 
+static const struct acpi_gpio_mapping *byt_rt5651_gpios;
+
 /* Default: jack-detect on JD1_1, internal mic on in2, headsetmic on in3 */
 static unsigned long byt_rt5651_quirk = BYT_RT5651_DEFAULT_QUIRKS |
 					BYT_RT5651_IN2_MAP;
@@ -365,6 +367,22 @@ static int byt_rt5651_aif1_hw_params(struct snd_pcm_substream *substream,
 	return byt_rt5651_prepare_and_enable_pll1(codec_dai, rate, bclk_ratio);
 }
 
+static const struct acpi_gpio_params pov_p1006w_hp_detect = { 1, 0, false };
+static const struct acpi_gpio_params pov_p1006w_ext_amp_en = { 2, 0, true };
+
+static const struct acpi_gpio_mapping byt_rt5651_pov_p1006w_gpios[] = {
+	{ "hp-detect-gpios", &pov_p1006w_hp_detect, 1, },
+	{ "ext-amp-enable-gpios", &pov_p1006w_ext_amp_en, 1, },
+	{ },
+};
+
+static int byt_rt5651_pov_p1006w_quirk_cb(const struct dmi_system_id *id)
+{
+	byt_rt5651_quirk = (unsigned long)id->driver_data;
+	byt_rt5651_gpios = byt_rt5651_pov_p1006w_gpios;
+	return 1;
+}
+
 static int byt_rt5651_quirk_cb(const struct dmi_system_id *id)
 {
 	byt_rt5651_quirk = (unsigned long)id->driver_data;
@@ -440,6 +458,23 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
 					BYT_RT5651_IN1_MAP),
 	},
+	{
+		/* Point of View mobii wintab p1006w (v1.0) */
+		.callback = byt_rt5651_pov_p1006w_quirk_cb,
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "BayTrail"),
+			/* Note 105b is Foxcon's USB/PCI vendor id */
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "105B"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "0E57"),
+		},
+		.driver_data = (void *)(BYT_RT5651_DMIC_MAP |
+					BYT_RT5651_OVCD_TH_2000UA |
+					BYT_RT5651_OVCD_SF_0P75 |
+					BYT_RT5651_DMIC_EN |
+					BYT_RT5651_MCLK_EN |
+					BYT_RT5651_SSP0_AIF1),
+	},
 	{
 		/* VIOS LTH17 */
 		.callback = byt_rt5651_quirk_cb,
@@ -848,7 +883,7 @@ static int snd_byt_rt5651_acpi_resource(struct acpi_resource *ares, void *arg)
 	return 0;
 }
 
-static void snd_byt_rt5651_mc_add_amp_en_gpio_mapping(struct device *codec)
+static void snd_byt_rt5651_mc_pick_amp_en_gpio_mapping(struct device *codec)
 {
 	struct byt_rt5651_acpi_resource_data data = { 0, -1 };
 	LIST_HEAD(resources);
@@ -866,10 +901,10 @@ static void snd_byt_rt5651_mc_add_amp_en_gpio_mapping(struct device *codec)
 
 	switch (data.gpio_int_idx) {
 	case 0:
-		devm_acpi_dev_add_driver_gpios(codec, byt_rt5651_amp_en_second);
+		byt_rt5651_gpios = byt_rt5651_amp_en_second;
 		break;
 	case 1:
-		devm_acpi_dev_add_driver_gpios(codec, byt_rt5651_amp_en_first);
+		byt_rt5651_gpios = byt_rt5651_amp_en_first;
 		break;
 	default:
 		dev_warn(codec, "Unknown GpioInt index %d, not adding external amplifier GPIO mapping\n",
@@ -1001,8 +1036,11 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	}
 
 	/* Cherry Trail devices use an external amplifier enable gpio */
-	if (x86_match_cpu(cherrytrail_cpu_ids)) {
-		snd_byt_rt5651_mc_add_amp_en_gpio_mapping(codec_dev);
+	if (x86_match_cpu(cherrytrail_cpu_ids) && !byt_rt5651_gpios)
+		snd_byt_rt5651_mc_pick_amp_en_gpio_mapping(codec_dev);
+
+	if (byt_rt5651_gpios) {
+		devm_acpi_dev_add_driver_gpios(codec_dev, byt_rt5651_gpios);
 		priv->ext_amp_gpio = devm_fwnode_get_index_gpiod_from_child(
 						&pdev->dev, "ext-amp-enable", 0,
 						codec_dev->fwnode,
-- 
2.20.1
