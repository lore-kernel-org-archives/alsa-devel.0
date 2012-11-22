From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH 02/10] ASoC: wm8753: remove invalid free of devm_ allocated data
Date: Thu, 22 Nov 2012 09:38:34 +0530
Message-ID: <1353557322-25353-3-git-send-email-tushar.behera@linaro.org>
References: <1353557322-25353-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353557322-25353-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
Cc: broonie@opensource.wolfsonmicro.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Fixes following warning.
sound/soc/codecs/wm8753.c:1594:1-6: WARNING: invalid free of devm_ allocated data

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 sound/soc/codecs/wm8753.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 2e4a775..9914215 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1591,7 +1591,6 @@ static int __devexit wm8753_spi_remove(struct spi_device *spi)
 
 	snd_soc_unregister_codec(&spi->dev);
 	regmap_exit(wm8753->regmap);
-	kfree(wm8753);
 	return 0;
 }
 
-- 
1.7.4.1
