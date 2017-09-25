From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98927: Added support for DSP_A and
	DSP_B format" to the asoc tree
Date: Mon, 25 Sep 2017 20:48:48 +0100 (BST)
Message-ID: <20170925194848.39C3F440055@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 443D926705F
 for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2017 21:49:21 +0200 (CEST)
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
To: Ryan Lee <ryans.lee@maximintegrated.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98927: Added support for DSP_A and DSP_B format

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

>From 4eee20246c0fa77a7a7b189ac806d5f78d675546 Mon Sep 17 00:00:00 2001
From: Ryan Lee <ryans.lee@maximintegrated.com>
Date: Thu, 14 Sep 2017 17:30:38 -0700
Subject: [PATCH] ASoC: max98927: Added support for DSP_A and DSP_B format

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98927.c | 35 ++++++++++++++++++++---------------
 sound/soc/codecs/max98927.h |  6 ++++--
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index d9dbbe72f8ad..6f7b3ef48e25 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -1,7 +1,7 @@
 /*
  * max98927.c  --  MAX98927 ALSA Soc Audio driver
  *
- * Copyright (C) 2016 Maxim Integrated Products
+ * Copyright (C) 2016-2017 Maxim Integrated Products
  * Author: Ryan Lee <ryans.lee@maximintegrated.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
@@ -146,6 +146,7 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
 	unsigned int mode = 0;
 	unsigned int format = 0;
+	bool use_pdm = false;
 	unsigned int invert = 0;
 
 	dev_dbg(codec->dev, "%s: fmt 0x%08X\n", __func__, fmt);
@@ -187,22 +188,27 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		max98927->iface |= SND_SOC_DAIFMT_I2S;
 		format = MAX98927_PCM_FORMAT_I2S;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
-		max98927->iface |= SND_SOC_DAIFMT_LEFT_J;
 		format = MAX98927_PCM_FORMAT_LJ;
 		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		format = MAX98927_PCM_FORMAT_TDM_MODE1;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		format = MAX98927_PCM_FORMAT_TDM_MODE0;
+		break;
 	case SND_SOC_DAIFMT_PDM:
-		max98927->iface |= SND_SOC_DAIFMT_PDM;
+		use_pdm = true;
 		break;
 	default:
 		return -EINVAL;
 	}
+	max98927->iface = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 
-	/* pcm channel configuration */
-	if (max98927->iface & (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J)) {
+	if (!use_pdm) {
+		/* pcm channel configuration */
 		regmap_update_bits(max98927->regmap,
 			MAX98927_R0018_PCM_RX_EN_A,
 			MAX98927_PCM_RX_CH0_EN | MAX98927_PCM_RX_CH1_EN,
@@ -217,13 +223,11 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 			MAX98927_R003B_SPK_SRC_SEL,
 			MAX98927_SPK_SRC_MASK, 0);
 
-	} else
 		regmap_update_bits(max98927->regmap,
-			MAX98927_R0018_PCM_RX_EN_A,
-			MAX98927_PCM_RX_CH0_EN | MAX98927_PCM_RX_CH1_EN, 0);
-
-	/* pdm channel configuration */
-	if (max98927->iface & SND_SOC_DAIFMT_PDM) {
+			MAX98927_R0035_PDM_RX_CTRL,
+			MAX98927_PDM_RX_EN_MASK, 0);
+	} else {
+		/* pdm channel configuration */
 		regmap_update_bits(max98927->regmap,
 			MAX98927_R0035_PDM_RX_CTRL,
 			MAX98927_PDM_RX_EN_MASK, 1);
@@ -231,10 +235,11 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		regmap_update_bits(max98927->regmap,
 			MAX98927_R003B_SPK_SRC_SEL,
 			MAX98927_SPK_SRC_MASK, 3);
-	} else
+
 		regmap_update_bits(max98927->regmap,
-			MAX98927_R0035_PDM_RX_CTRL,
-			MAX98927_PDM_RX_EN_MASK, 0);
+			MAX98927_R0018_PCM_RX_EN_A,
+			MAX98927_PCM_RX_CH0_EN | MAX98927_PCM_RX_CH1_EN, 0);
+	}
 	return 0;
 }
 
diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
index ece6a608cbe1..bf7a6f92562a 100644
--- a/sound/soc/codecs/max98927.h
+++ b/sound/soc/codecs/max98927.h
@@ -1,7 +1,7 @@
 /*
  * max98927.h  --  MAX98927 ALSA Soc Audio driver
  *
- * Copyright 2013-15 Maxim Integrated Products
+ * Copyright (C) 2016-2017 Maxim Integrated Products
  * Author: Ryan Lee <ryans.lee@maximintegrated.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
@@ -161,7 +161,9 @@
 #define MAX98927_PCM_MODE_CFG_FORMAT_SHIFT (3)
 #define MAX98927_PCM_FORMAT_I2S (0x0 << 0)
 #define MAX98927_PCM_FORMAT_LJ (0x1 << 0)
-
+#define MAX98927_PCM_FORMAT_TDM_MODE0 (0x3 << 0)
+#define MAX98927_PCM_FORMAT_TDM_MODE1 (0x4 << 0)
+#define MAX98927_PCM_FORMAT_TDM_MODE2 (0x5 << 0)
 #define MAX98927_PCM_MODE_CFG_CHANSZ_MASK (0x3 << 6)
 #define MAX98927_PCM_MODE_CFG_CHANSZ_16 (0x1 << 6)
 #define MAX98927_PCM_MODE_CFG_CHANSZ_24 (0x2 << 6)
-- 
2.14.1
