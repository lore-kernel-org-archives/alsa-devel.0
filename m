From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 02/11] soc-io.c: Use IS_ENABLED() macro
Date: Wed, 20 Nov 2013 15:37:42 -0200
Message-ID: <1384969072-25906-3-git-send-email-festevam@gmail.com>
References: <1384969072-25906-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f52.google.com (mail-yh0-f52.google.com
 [209.85.213.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 98F0D261ADA
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 18:38:06 +0100 (CET)
Received: by mail-yh0-f52.google.com with SMTP id i72so2369969yha.25
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 09:38:05 -0800 (PST)
In-Reply-To: <1384969072-25906-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Using the IS_ENABLED() macro can make the code shorter and simpler.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/soc-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 4f11d23..aa886cc 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -99,14 +99,14 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 	config.val_bits = data_bits;
 
 	switch (control) {
-#if defined(CONFIG_REGMAP_I2C) || defined(CONFIG_REGMAP_I2C_MODULE)
+#if IS_ENABLED(CONFIG_REGMAP_I2C)
 	case SND_SOC_I2C:
 		codec->control_data = regmap_init_i2c(to_i2c_client(codec->dev),
 						      &config);
 		break;
 #endif
 
-#if defined(CONFIG_REGMAP_SPI) || defined(CONFIG_REGMAP_SPI_MODULE)
+#if IS_ENABLED(CONFIG_REGMAP_SPI)
 	case SND_SOC_SPI:
 		codec->control_data = regmap_init_spi(to_spi_device(codec->dev),
 						      &config);
-- 
1.8.1.2
