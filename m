From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec: use enable pin to control dmic
	start and stop" to the asoc tree
Date: Thu, 17 Aug 2017 18:13:20 +0100
Message-ID: <E1diOMC-0008Sl-RK@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 25593266F7A
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 19:13:23 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lin Huang <hl@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec: use enable pin to control dmic start and stop

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 23c7159a799f3364720b3d250f57bc8e26b17287 Mon Sep 17 00:00:00 2001
From: huang lin <hl@rock-chips.com>
Date: Thu, 17 Aug 2017 10:24:44 +0800
Subject: [PATCH] ASoC: codec: use enable pin to control dmic start and stop

on some board use enable pin to control dmic start and stop,
so add this feature in dmic driver.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig |  2 +-
 sound/soc/codecs/dmic.c  | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6c78b0b49b81..952c44dd5e90 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -71,7 +71,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_DA732X if I2C
 	select SND_SOC_DA9055 if I2C
 	select SND_SOC_DIO2125
-	select SND_SOC_DMIC
+	select SND_SOC_DMIC if GPIOLIB
 	select SND_SOC_ES8316 if I2C
 	select SND_SOC_ES8328_SPI if SPI_MASTER
 	select SND_SOC_ES8328_I2C if I2C
diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index d50f142e2972..b88a1ee66f80 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -19,6 +19,8 @@
  *
  */
 
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -27,6 +29,34 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 
+static int dmic_daiops_trigger(struct snd_pcm_substream *substream,
+		int cmd, struct snd_soc_dai *dai)
+{
+	struct gpio_desc *dmic_en = snd_soc_dai_get_drvdata(dai);
+
+	if (!dmic_en)
+		return 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		gpiod_set_value(dmic_en, 1);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		gpiod_set_value(dmic_en, 0);
+		break;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops dmic_dai_ops = {
+	.trigger	= dmic_daiops_trigger,
+};
+
 static struct snd_soc_dai_driver dmic_dai = {
 	.name = "dmic-hifi",
 	.capture = {
@@ -38,8 +68,23 @@ static struct snd_soc_dai_driver dmic_dai = {
 			| SNDRV_PCM_FMTBIT_S24_LE
 			| SNDRV_PCM_FMTBIT_S16_LE,
 	},
+	.ops    = &dmic_dai_ops,
 };
 
+static int dmic_codec_probe(struct snd_soc_codec *codec)
+{
+	struct gpio_desc *dmic_en;
+
+	dmic_en = devm_gpiod_get_optional(codec->dev,
+					"dmicen", GPIOD_OUT_LOW);
+	if (IS_ERR(dmic_en))
+		return PTR_ERR(dmic_en);
+
+	snd_soc_codec_set_drvdata(codec, dmic_en);
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget dmic_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_OUT("DMIC AIF", "Capture", 0,
 			     SND_SOC_NOPM, 0, 0),
@@ -50,7 +95,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"DMIC AIF", NULL, "DMic"},
 };
 
-static struct snd_soc_codec_driver soc_dmic = {
+static const struct snd_soc_codec_driver soc_dmic = {
+	.probe = dmic_codec_probe,
 	.component_driver = {
 		.dapm_widgets		= dmic_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(dmic_dapm_widgets),
-- 
2.13.3
