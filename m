From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-amplifier: rename dio2125 to
	simple-amplifer" to the asoc tree
Date: Wed, 27 Jun 2018 12:30:23 +0100 (BST)
Message-ID: <20180627113023.E45B3440070@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3372654991165719734=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E1163267985
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 13:30:25 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

--===============3372654991165719734==
Content-Type: text/plain

The patch

   ASoC: simple-amplifier: rename dio2125 to simple-amplifer

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

>From 8d881bb6216d28896112bdc0b42f1f21eb6cd4ee Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 26 Jun 2018 14:11:27 +0200
Subject: [PATCH] ASoC: simple-amplifier: rename dio2125 to simple-amplifer
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The dio2125 is simple enough that we can make it a generic component.
Just rename and sed the dio2125 amplifier driver to simple_amplifier.

Suggested-by: Nicolò Veronese <nicveronese@gmail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig                      | 10 ++---
 sound/soc/codecs/Makefile                     |  4 +-
 .../codecs/{dio2125.c => simple-amplifier.c}  | 41 ++++++++++---------
 3 files changed, 28 insertions(+), 27 deletions(-)
 rename sound/soc/codecs/{dio2125.c => simple-amplifier.c} (69%)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f6b8d4bf8796..53c2d726bedf 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -74,7 +74,6 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_DA7219 if I2C
 	select SND_SOC_DA732X if I2C
 	select SND_SOC_DA9055 if I2C
-	select SND_SOC_DIO2125
 	select SND_SOC_DMIC if GPIOLIB
 	select SND_SOC_ES8316 if I2C
 	select SND_SOC_ES8328_SPI if SPI_MASTER
@@ -144,6 +143,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_RT5682 if I2C
 	select SND_SOC_SGTL5000 if I2C
 	select SND_SOC_SI476X if MFD_SI476X_CORE
+	select SND_SOC_SIMPLE_AMPLIFIER
 	select SND_SOC_SIRF_AUDIO_CODEC
 	select SND_SOC_SPDIF
 	select SND_SOC_SSM2305
@@ -573,10 +573,6 @@ config SND_SOC_DA732X
 config SND_SOC_DA9055
 	tristate
 
-config SND_SOC_DIO2125
-	tristate "Dioo DIO2125 Amplifier"
-	select GPIOLIB
-
 config SND_SOC_DMIC
 	tristate
 
@@ -897,6 +893,10 @@ config SND_SOC_SIGMADSP_REGMAP
 	tristate
 	select SND_SOC_SIGMADSP
 
+config SND_SOC_SIMPLE_AMPLIFIER
+	tristate "Simple Audio Amplifier"
+	select GPIOLIB
+
 config SND_SOC_SIRF_AUDIO_CODEC
 	tristate "SiRF SoC internal audio codec"
 	select REGMAP_MMIO
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index e43d99a039d3..f26ded89a1e5 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -250,9 +250,9 @@ snd-soc-wm9713-objs := wm9713.o
 snd-soc-wm-hubs-objs := wm_hubs.o
 snd-soc-zx-aud96p22-objs := zx_aud96p22.o
 # Amp
-snd-soc-dio2125-objs := dio2125.o
 snd-soc-max9877-objs := max9877.o
 snd-soc-max98504-objs := max98504.o
+snd-soc-simple-amplifier-objs := simple-amplifier.o
 snd-soc-tpa6130a2-objs := tpa6130a2.o
 snd-soc-tas2552-objs := tas2552.o
 
@@ -509,7 +509,7 @@ obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
 obj-$(CONFIG_SND_SOC_ZX_AUD96P22) += snd-soc-zx-aud96p22.o
 
 # Amp
-obj-$(CONFIG_SND_SOC_DIO2125)	+= snd-soc-dio2125.o
 obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
 obj-$(CONFIG_SND_SOC_MAX98504)	+= snd-soc-max98504.o
+obj-$(CONFIG_SND_SOC_SIMPLE_AMPLIFIER)	+= snd-soc-simple-amplifier.o
 obj-$(CONFIG_SND_SOC_TPA6130A2)	+= snd-soc-tpa6130a2.o
diff --git a/sound/soc/codecs/dio2125.c b/sound/soc/codecs/simple-amplifier.c
similarity index 69%
rename from sound/soc/codecs/dio2125.c
rename to sound/soc/codecs/simple-amplifier.c
index 09451cd44f9b..6c27d4afaf3a 100644
--- a/sound/soc/codecs/dio2125.c
+++ b/sound/soc/codecs/simple-amplifier.c
@@ -21,9 +21,9 @@
 #include <linux/module.h>
 #include <sound/soc.h>
 
-#define DRV_NAME "dio2125"
+#define DRV_NAME "simple-amplifier"
 
-struct dio2125 {
+struct simple_amp {
 	struct gpio_desc *gpiod_enable;
 };
 
@@ -31,7 +31,7 @@ static int drv_event(struct snd_soc_dapm_widget *w,
 		     struct snd_kcontrol *control, int event)
 {
 	struct snd_soc_component *c = snd_soc_dapm_to_component(w->dapm);
-	struct dio2125 *priv = snd_soc_component_get_drvdata(c);
+	struct simple_amp *priv = snd_soc_component_get_drvdata(c);
 	int val;
 
 	switch (event) {
@@ -51,7 +51,7 @@ static int drv_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static const struct snd_soc_dapm_widget dio2125_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget simple_amp_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("INL"),
 	SND_SOC_DAPM_INPUT("INR"),
 	SND_SOC_DAPM_OUT_DRV_E("DRV", SND_SOC_NOPM, 0, 0, NULL, 0, drv_event,
@@ -60,24 +60,24 @@ static const struct snd_soc_dapm_widget dio2125_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("OUTR"),
 };
 
-static const struct snd_soc_dapm_route dio2125_dapm_routes[] = {
+static const struct snd_soc_dapm_route simple_amp_dapm_routes[] = {
 	{ "DRV", NULL, "INL" },
 	{ "DRV", NULL, "INR" },
 	{ "OUTL", NULL, "DRV" },
 	{ "OUTR", NULL, "DRV" },
 };
 
-static const struct snd_soc_component_driver dio2125_component_driver = {
-	.dapm_widgets		= dio2125_dapm_widgets,
-	.num_dapm_widgets	= ARRAY_SIZE(dio2125_dapm_widgets),
-	.dapm_routes		= dio2125_dapm_routes,
-	.num_dapm_routes	= ARRAY_SIZE(dio2125_dapm_routes),
+static const struct snd_soc_component_driver simple_amp_component_driver = {
+	.dapm_widgets		= simple_amp_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(simple_amp_dapm_widgets),
+	.dapm_routes		= simple_amp_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(simple_amp_dapm_routes),
 };
 
-static int dio2125_probe(struct platform_device *pdev)
+static int simple_amp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct dio2125 *priv;
+	struct simple_amp *priv;
 	int err;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -93,28 +93,29 @@ static int dio2125_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	return devm_snd_soc_register_component(dev, &dio2125_component_driver,
+	return devm_snd_soc_register_component(dev,
+					       &simple_amp_component_driver,
 					       NULL, 0);
 }
 
 #ifdef CONFIG_OF
-static const struct of_device_id dio2125_ids[] = {
+static const struct of_device_id simple_amp_ids[] = {
 	{ .compatible = "dioo,dio2125", },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, dio2125_ids);
+MODULE_DEVICE_TABLE(of, simple_amp_ids);
 #endif
 
-static struct platform_driver dio2125_driver = {
+static struct platform_driver simple_amp_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.of_match_table = of_match_ptr(dio2125_ids),
+		.of_match_table = of_match_ptr(simple_amp_ids),
 	},
-	.probe = dio2125_probe,
+	.probe = simple_amp_probe,
 };
 
-module_platform_driver(dio2125_driver);
+module_platform_driver(simple_amp_driver);
 
-MODULE_DESCRIPTION("ASoC DIO2125 output driver");
+MODULE_DESCRIPTION("ASoC Simple Audio Amplifier driver");
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
 MODULE_LICENSE("GPL");
-- 
2.17.1


--===============3372654991165719734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3372654991165719734==--
