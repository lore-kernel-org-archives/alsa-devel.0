From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdmi: Remove obsolete dummy HDMI codec"
	to the asoc tree
Date: Sat, 19 Sep 2015 17:13:02 -0700
Message-ID: <E1ZdSFa-0003ys-Dz@finisterre>
References: <1432666751-24794-3-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2273B26063F
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:13:34 +0200 (CEST)
In-Reply-To: <1432666751-24794-3-git-send-email-jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdmi: Remove obsolete dummy HDMI codec

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

>From 9529138276c852297967b5d3cc2f6dda3ddb9526 Mon Sep 17 00:00:00 2001
From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 18 Sep 2015 14:06:38 +0300
Subject: [PATCH] ASoC: hdmi: Remove obsolete dummy HDMI codec

The hdmi stub codec has not been used since refactoring of OMAP HDMI
audio support.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig  |   4 --
 sound/soc/codecs/Makefile |   2 -
 sound/soc/codecs/hdmi.c   | 109 ----------------------------------------------
 3 files changed, 115 deletions(-)
 delete mode 100644 sound/soc/codecs/hdmi.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0c9733e..0142396 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -79,7 +79,6 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX9877 if I2C
 	select SND_SOC_MC13783 if MFD_MC13XXX
 	select SND_SOC_ML26124 if I2C
-	select SND_SOC_HDMI_CODEC
 	select SND_SOC_PCM1681 if I2C
 	select SND_SOC_PCM1792A if SPI_MASTER
 	select SND_SOC_PCM3008
@@ -442,9 +441,6 @@ config SND_SOC_BT_SCO
 config SND_SOC_DMIC
 	tristate
 
-config SND_SOC_HDMI_CODEC
-       tristate "HDMI stub CODEC"
-
 config SND_SOC_ES8328
 	tristate "Everest Semi ES8328 CODEC"
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 4a32077..7d7cc1b 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -72,7 +72,6 @@ snd-soc-max98925-objs := max98925.o
 snd-soc-max9850-objs := max9850.o
 snd-soc-mc13783-objs := mc13783.o
 snd-soc-ml26124-objs := ml26124.o
-snd-soc-hdmi-codec-objs := hdmi.o
 snd-soc-pcm1681-objs := pcm1681.o
 snd-soc-pcm1792a-codec-objs := pcm1792a.o
 snd-soc-pcm3008-objs := pcm3008.o
@@ -264,7 +263,6 @@ obj-$(CONFIG_SND_SOC_MAX98925)	+= snd-soc-max98925.o
 obj-$(CONFIG_SND_SOC_MAX9850)	+= snd-soc-max9850.o
 obj-$(CONFIG_SND_SOC_MC13783)	+= snd-soc-mc13783.o
 obj-$(CONFIG_SND_SOC_ML26124)	+= snd-soc-ml26124.o
-obj-$(CONFIG_SND_SOC_HDMI_CODEC) += snd-soc-hdmi-codec.o
 obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
 obj-$(CONFIG_SND_SOC_PCM1792A)	+= snd-soc-pcm1792a-codec.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
diff --git a/sound/soc/codecs/hdmi.c b/sound/soc/codecs/hdmi.c
deleted file mode 100644
index bd42ad3..0000000
--- a/sound/soc/codecs/hdmi.c
+++ /dev/null
@@ -1,109 +0,0 @@
-/*
- * ALSA SoC codec driver for HDMI audio codecs.
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
- * Author: Ricardo Neri <ricardo.neri@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-#include <linux/module.h>
-#include <sound/soc.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-
-#define DRV_NAME "hdmi-audio-codec"
-
-static const struct snd_soc_dapm_widget hdmi_widgets[] = {
-	SND_SOC_DAPM_INPUT("RX"),
-	SND_SOC_DAPM_OUTPUT("TX"),
-};
-
-static const struct snd_soc_dapm_route hdmi_routes[] = {
-	{ "Capture", NULL, "RX" },
-	{ "TX", NULL, "Playback" },
-};
-
-static struct snd_soc_dai_driver hdmi_codec_dai = {
-	.name = "hdmi-hifi",
-	.playback = {
-		.stream_name = "Playback",
-		.channels_min = 2,
-		.channels_max = 8,
-		.rates = SNDRV_PCM_RATE_32000 |
-			SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-			SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
-			SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE |
-			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
-		.sig_bits = 24,
-	},
-	.capture = {
-		.stream_name = "Capture",
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_32000 |
-			SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-			SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
-			SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE |
-			SNDRV_PCM_FMTBIT_S24_LE,
-	},
-
-};
-
-#ifdef CONFIG_OF
-static const struct of_device_id hdmi_audio_codec_ids[] = {
-	{ .compatible = "linux,hdmi-audio", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, hdmi_audio_codec_ids);
-#endif
-
-static struct snd_soc_codec_driver hdmi_codec = {
-	.dapm_widgets = hdmi_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(hdmi_widgets),
-	.dapm_routes = hdmi_routes,
-	.num_dapm_routes = ARRAY_SIZE(hdmi_routes),
-	.ignore_pmdown_time = true,
-};
-
-static int hdmi_codec_probe(struct platform_device *pdev)
-{
-	return snd_soc_register_codec(&pdev->dev, &hdmi_codec,
-			&hdmi_codec_dai, 1);
-}
-
-static int hdmi_codec_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-	return 0;
-}
-
-static struct platform_driver hdmi_codec_driver = {
-	.driver		= {
-		.name	= DRV_NAME,
-		.of_match_table = of_match_ptr(hdmi_audio_codec_ids),
-	},
-
-	.probe		= hdmi_codec_probe,
-	.remove		= hdmi_codec_remove,
-};
-
-module_platform_driver(hdmi_codec_driver);
-
-MODULE_AUTHOR("Ricardo Neri <ricardo.neri@ti.com>");
-MODULE_DESCRIPTION("ASoC generic HDMI codec driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.5.0
