From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 2/2] ASoC: soc-io: Fix CONFIG_REGMAP_I2C/SPI
	guards to support regmap modules
Date: Thu, 11 Aug 2011 11:59:11 -0600
Message-ID: <1313085551-26125-2-git-send-email-swarren@nvidia.com>
References: <1313085551-26125-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F6D02434C
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 19:59:21 +0200 (CEST)
In-Reply-To: <1313085551-26125-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

When CONFIG_REGMAP_I2C/SPI are m, CONFIG_REGMAP_I2C_MODULE is set in the
pre-processor instead of CONFIG_REGMAP_I2C. This removes SND_SOC_I2C as a
valid option for snd_soc_codec_set_cache_io()'s control parameter, and
causes any ASoC regmap-using codec built as a module to fail to initialize.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/soc-io.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index be5aac3..22b6431 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -122,14 +122,14 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 	config.val_bits = data_bits;
 
 	switch (control) {
-#ifdef CONFIG_REGMAP_I2C
+#if defined(CONFIG_REGMAP_I2C) || defined(CONFIG_REGMAP_I2C_MODULE)
 	case SND_SOC_I2C:
 		codec->control_data = regmap_init_i2c(to_i2c_client(codec->dev),
 						      &config);
 		break;
 #endif
 
-#ifdef CONFIG_REGMAP_SPI
+#if defined(CONFIG_REGMAP_SPI) || defined(CONFIG_REGMAP_SPI_MODULE)
 	case SND_SOC_SPI:
 		codec->control_data = regmap_init_spi(to_spi_device(codec->dev),
 						      &config);
-- 
1.7.0.4
