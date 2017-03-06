From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es7134: add es7134 DAC driver" to the
	asoc tree
Date: Mon, 06 Mar 2017 11:46:17 +0100
Message-ID: <E1ckq9h-0002Ng-89@finisterre>
References: <20170227154724.13724-2-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 13FFA266D8B
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 11:46:29 +0100 (CET)
In-Reply-To: <20170227154724.13724-2-jbrunet@baylibre.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es7134: add es7134 DAC driver

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

>From 9000b59d7a12503ece61414fff3ce58773ebf033 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 27 Feb 2017 16:47:23 +0100
Subject: [PATCH] ASoC: es7134: add es7134 DAC driver

The es7134 is 24bit, 192Khz i2s DA converter for PCM audio.
Datasheet is available here : http://www.everest-semi.com/pdf/ES7134LV%20DS.pdf

This driver is also compatible with the es7144, which is the same as the
es7134, with 2 additional pins for filtering capacitors.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig  |   4 ++
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/es7134.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 sound/soc/codecs/es7134.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index e49e9da7f1f6..7c7c2e96b836 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -72,6 +72,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_DMIC
 	select SND_SOC_ES8328_SPI if SPI_MASTER
 	select SND_SOC_ES8328_I2C if I2C
+	select SND_SOC_ES7134
 	select SND_SOC_GTM601
 	select SND_SOC_HDAC_HDMI
 	select SND_SOC_ICS43432
@@ -525,6 +526,9 @@ config SND_SOC_HDMI_CODEC
 	select SND_PCM_IEC958
 	select HDMI
 
+config SND_SOC_ES7134
+       tristate "Everest Semi ES7134 CODEC"
+
 config SND_SOC_ES8328
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 1796cb987e71..b65868c963c9 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -63,6 +63,7 @@ snd-soc-da7219-objs := da7219.o da7219-aad.o
 snd-soc-da732x-objs := da732x.o
 snd-soc-da9055-objs := da9055.o
 snd-soc-dmic-objs := dmic.o
+snd-soc-es7134-objs := es7134.o
 snd-soc-es8328-objs := es8328.o
 snd-soc-es8328-i2c-objs := es8328-i2c.o
 snd-soc-es8328-spi-objs := es8328-spi.o
@@ -293,6 +294,7 @@ obj-$(CONFIG_SND_SOC_DA7219)	+= snd-soc-da7219.o
 obj-$(CONFIG_SND_SOC_DA732X)	+= snd-soc-da732x.o
 obj-$(CONFIG_SND_SOC_DA9055)	+= snd-soc-da9055.o
 obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
+obj-$(CONFIG_SND_SOC_ES7134)	+= snd-soc-es7134.o
 obj-$(CONFIG_SND_SOC_ES8328)	+= snd-soc-es8328.o
 obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
 obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
diff --git a/sound/soc/codecs/es7134.c b/sound/soc/codecs/es7134.c
new file mode 100644
index 000000000000..25ede825d349
--- /dev/null
+++ b/sound/soc/codecs/es7134.c
@@ -0,0 +1,116 @@
+/*
+ * Copyright (c) 2017 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * The full GNU General Public License is included in this distribution
+ * in the file called COPYING.
+ */
+
+#include <linux/module.h>
+#include <sound/soc.h>
+
+/*
+ * The everest 7134 is a very simple DA converter with no register
+ */
+
+static int es7134_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	fmt &= (SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK |
+		SND_SOC_DAIFMT_MASTER_MASK);
+
+	if (fmt != (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		    SND_SOC_DAIFMT_CBS_CFS)) {
+		dev_err(codec_dai->dev, "Invalid DAI format\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops es7134_dai_ops = {
+	.set_fmt	= es7134_set_fmt,
+};
+
+static struct snd_soc_dai_driver es7134_dai = {
+	.name = "es7134-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = (SNDRV_PCM_FMTBIT_S16_LE  |
+			    SNDRV_PCM_FMTBIT_S18_3LE |
+			    SNDRV_PCM_FMTBIT_S20_3LE |
+			    SNDRV_PCM_FMTBIT_S24_3LE |
+			    SNDRV_PCM_FMTBIT_S24_LE),
+	},
+	.ops = &es7134_dai_ops,
+};
+
+static const struct snd_soc_dapm_widget es7134_dapm_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("AOUTL"),
+	SND_SOC_DAPM_OUTPUT("AOUTR"),
+	SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_dapm_route es7134_dapm_routes[] = {
+	{ "AOUTL", NULL, "DAC" },
+	{ "AOUTR", NULL, "DAC" },
+};
+
+static struct snd_soc_codec_driver es7134_codec_driver = {
+	.component_driver = {
+		.dapm_widgets		= es7134_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(es7134_dapm_widgets),
+		.dapm_routes		= es7134_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(es7134_dapm_routes),
+	},
+};
+
+static int es7134_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev,
+				      &es7134_codec_driver,
+				      &es7134_dai, 1);
+}
+
+static int es7134_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id es7134_ids[] = {
+	{ .compatible = "everest,es7134", },
+	{ .compatible = "everest,es7144", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, es7134_ids);
+#endif
+
+static struct platform_driver es7134_driver = {
+	.driver = {
+		.name = "es7134",
+		.of_match_table = of_match_ptr(es7134_ids),
+	},
+	.probe = es7134_probe,
+	.remove = es7134_remove,
+};
+
+module_platform_driver(es7134_driver);
+
+MODULE_DESCRIPTION("ASoC ES7134 audio codec driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL");
-- 
2.11.0
