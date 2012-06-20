From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: [PATCH 2/2 v2] asoc: add i2s dai driver for bf6xx soc
Date: Wed, 20 Jun 2012 17:00:31 -0400
Message-ID: <1340226031-19930-2-git-send-email-scott.jiang.linux@gmail.com>
References: <1340226031-19930-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe005.messaging.microsoft.com [216.32.180.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E93A10437A
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2012 10:36:03 +0200 (CEST)
In-Reply-To: <1340226031-19930-1-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, uclinux-dist-devel@blackfin.uclinux.org
Cc: Scott Jiang <scott.jiang.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

This driver enables i2s mode support on blackfin bf6xx platform.
We reuse bf5xx-i2s-pcm.c as its i2s pcm driver because it's the same
for both bf5xx and bf6xx soc.

Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
---
 sound/soc/blackfin/Kconfig     |   11 ++-
 sound/soc/blackfin/Makefile    |    2 +
 sound/soc/blackfin/bf6xx-i2s.c |  234 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/blackfin/bf6xx-i2s.c

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 0374a39..16b88f5 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -10,12 +10,14 @@ config SND_BF5XX_I2S
 	  You will also need to select the audio interfaces to support below.
 
 config SND_BF5XX_SOC_SSM2602
-	tristate "SoC SSM2602 Audio support for BF52x ezkit"
+	tristate "SoC SSM2602 Audio Codec Add-On Card support"
 	depends on SND_BF5XX_I2S && (SPI_MASTER || I2C)
-	select SND_BF5XX_SOC_I2S
+	select SND_BF5XX_SOC_I2S if !BF60x
+	select SND_BF6XX_SOC_I2S if BF60x
 	select SND_SOC_SSM2602
 	help
-	  Say Y if you want to add support for SoC audio on BF527-EZKIT.
+	  Say Y if you want to add support for the Analog Devices
+	  SSM2602 Audio Codec Add-On Card.
 
 config SND_SOC_BFIN_EVAL_ADAU1701
 	tristate "Support for the EVAL-ADAU1701MINIZ board on Blackfin eval boards"
@@ -169,6 +171,9 @@ config SND_BF6XX_SOC_SPORT
 config SND_BF5XX_SOC_I2S
 	tristate
 
+config SND_BF6XX_SOC_I2S
+	tristate
+
 config SND_BF5XX_SOC_TDM
 	tristate
 
diff --git a/sound/soc/blackfin/Makefile b/sound/soc/blackfin/Makefile
index 13b0922..6fea1f4 100644
--- a/sound/soc/blackfin/Makefile
+++ b/sound/soc/blackfin/Makefile
@@ -6,6 +6,7 @@ snd-soc-bf5xx-sport-objs := bf5xx-sport.o
 snd-soc-bf6xx-sport-objs := bf6xx-sport.o
 snd-soc-bf5xx-ac97-objs := bf5xx-ac97.o
 snd-soc-bf5xx-i2s-objs := bf5xx-i2s.o
+snd-soc-bf6xx-i2s-objs := bf6xx-i2s.o
 snd-soc-bf5xx-tdm-objs := bf5xx-tdm.o
 
 obj-$(CONFIG_SND_BF5XX_AC97) += snd-bf5xx-ac97.o
@@ -15,6 +16,7 @@ obj-$(CONFIG_SND_BF5XX_SOC_SPORT) += snd-soc-bf5xx-sport.o
 obj-$(CONFIG_SND_BF6XX_SOC_SPORT) += snd-soc-bf6xx-sport.o
 obj-$(CONFIG_SND_BF5XX_SOC_AC97) += snd-soc-bf5xx-ac97.o
 obj-$(CONFIG_SND_BF5XX_SOC_I2S) += snd-soc-bf5xx-i2s.o
+obj-$(CONFIG_SND_BF6XX_SOC_I2S) += snd-soc-bf6xx-i2s.o
 obj-$(CONFIG_SND_BF5XX_SOC_TDM) += snd-soc-bf5xx-tdm.o
 
 # Blackfin Machine Support
diff --git a/sound/soc/blackfin/bf6xx-i2s.c b/sound/soc/blackfin/bf6xx-i2s.c
new file mode 100644
index 0000000..c3c2466
--- /dev/null
+++ b/sound/soc/blackfin/bf6xx-i2s.c
@@ -0,0 +1,234 @@
+/*
+ * bf6xx-i2s.c - Analog Devices BF6XX i2s interface driver
+ *
+ * Copyright (c) 2012 Analog Devices Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include "bf6xx-sport.h"
+
+struct sport_params param;
+
+static int bfin_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
+		unsigned int fmt)
+{
+	struct sport_device *sport = snd_soc_dai_get_drvdata(cpu_dai);
+	struct device *dev = &sport->pdev->dev;
+	int ret = 0;
+
+	param.spctl &= ~(SPORT_CTL_OPMODE | SPORT_CTL_CKRE | SPORT_CTL_FSR
+			| SPORT_CTL_LFS | SPORT_CTL_LAFS);
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		param.spctl |= SPORT_CTL_OPMODE | SPORT_CTL_CKRE
+			| SPORT_CTL_LFS;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		param.spctl |= SPORT_CTL_FSR;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		param.spctl |= SPORT_CTL_OPMODE | SPORT_CTL_LFS
+			| SPORT_CTL_LAFS;
+		break;
+	default:
+		dev_err(dev, "%s: Unknown DAI format type\n", __func__);
+		ret = -EINVAL;
+		break;
+	}
+
+	param.spctl &= ~(SPORT_CTL_ICLK | SPORT_CTL_IFS);
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_CBM_CFS:
+	case SND_SOC_DAIFMT_CBS_CFM:
+		ret = -EINVAL;
+		break;
+	default:
+		dev_err(dev, "%s: Unknown DAI master type\n", __func__);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int bfin_i2s_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
+	struct device *dev = &sport->pdev->dev;
+	int ret = 0;
+
+	param.spctl &= ~SPORT_CTL_SLEN;
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		param.spctl |= 0x70;
+		sport->wdsize = 1;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		param.spctl |= 0xf0;
+		sport->wdsize = 2;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		param.spctl |= 0x170;
+		sport->wdsize = 3;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		param.spctl |= 0x1f0;
+		sport->wdsize = 4;
+		break;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		ret = sport_set_tx_params(sport, &param);
+		if (ret) {
+			dev_err(dev, "SPORT tx is busy!\n");
+			return ret;
+		}
+	} else {
+		ret = sport_set_rx_params(sport, &param);
+		if (ret) {
+			dev_err(dev, "SPORT rx is busy!\n");
+			return ret;
+		}
+	}
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int bfin_i2s_suspend(struct snd_soc_dai *dai)
+{
+	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
+
+	if (dai->capture_active)
+		sport_rx_stop(sport);
+	if (dai->playback_active)
+		sport_tx_stop(sport);
+	return 0;
+}
+
+static int bfin_i2s_resume(struct snd_soc_dai *dai)
+{
+	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
+	struct device *dev = &sport->pdev->dev;
+	int ret;
+
+	ret = sport_set_tx_params(sport, &param);
+	if (ret) {
+		dev_err(dev, "SPORT tx is busy!\n");
+		return ret;
+	}
+	ret = sport_set_rx_params(sport, &param);
+	if (ret) {
+		dev_err(dev, "SPORT rx is busy!\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+#else
+#define bfin_i2s_suspend NULL
+#define bfin_i2s_resume NULL
+#endif
+
+#define BFIN_I2S_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
+		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | \
+		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 | \
+		SNDRV_PCM_RATE_96000)
+
+#define BFIN_I2S_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE | \
+		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_ops bfin_i2s_dai_ops = {
+	.hw_params	= bfin_i2s_hw_params,
+	.set_fmt	= bfin_i2s_set_dai_fmt,
+};
+
+static struct snd_soc_dai_driver bfin_i2s_dai = {
+	.suspend = bfin_i2s_suspend,
+	.resume = bfin_i2s_resume,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = BFIN_I2S_RATES,
+		.formats = BFIN_I2S_FORMATS,
+	},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = BFIN_I2S_RATES,
+		.formats = BFIN_I2S_FORMATS,
+	},
+	.ops = &bfin_i2s_dai_ops,
+};
+
+static int __devinit bfin_i2s_probe(struct platform_device *pdev)
+{
+	struct sport_device *sport;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	sport = sport_create(pdev);
+	if (!sport)
+		return -ENODEV;
+
+	/* register with the ASoC layers */
+	ret = snd_soc_register_dai(dev, &bfin_i2s_dai);
+	if (ret) {
+		dev_err(dev, "Failed to register DAI: %d\n", ret);
+		sport_delete(sport);
+		return ret;
+	}
+	platform_set_drvdata(pdev, sport);
+
+	return 0;
+}
+
+static int __devexit bfin_i2s_remove(struct platform_device *pdev)
+{
+	struct sport_device *sport = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_dai(&pdev->dev);
+	sport_delete(sport);
+
+	return 0;
+}
+
+static struct platform_driver bfin_i2s_driver = {
+	.probe  = bfin_i2s_probe,
+	.remove = __devexit_p(bfin_i2s_remove),
+	.driver = {
+		.name = "bfin-i2s",
+		.owner = THIS_MODULE,
+	},
+};
+
+module_platform_driver(bfin_i2s_driver);
+
+MODULE_DESCRIPTION("Analog Devices BF6XX i2s interface driver");
+MODULE_AUTHOR("Scott Jiang <Scott.Jiang.Linux@gmail.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.0.4
