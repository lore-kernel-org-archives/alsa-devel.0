From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: io: Remove SPI support
Date: Sun, 16 Feb 2014 10:05:09 +0800
Message-ID: <1392516309-3327-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D64182619FF
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2014 03:28:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

All ASoC CODEC drivers that use SPI have now been converted to use regmap
so we can delete SND_SOC_SPI, preventing any new users being added.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 include/sound/soc.h | 1 -
 sound/soc/soc-io.c  | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 21d025e..21038e0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -356,7 +356,6 @@ extern struct snd_ac97_bus_ops *soc_ac97_ops;
 
 enum snd_soc_control_type {
 	SND_SOC_I2C = 1,
-	SND_SOC_SPI,
 	SND_SOC_REGMAP,
 };
 
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index aa886cc..3a0d99e 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -106,13 +106,6 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 		break;
 #endif
 
-#if IS_ENABLED(CONFIG_REGMAP_SPI)
-	case SND_SOC_SPI:
-		codec->control_data = regmap_init_spi(to_spi_device(codec->dev),
-						      &config);
-		break;
-#endif
-
 	case SND_SOC_REGMAP:
 		/* Device has made its own regmap arrangements */
 		codec->using_regmap = true;
-- 
1.9.0.rc3
