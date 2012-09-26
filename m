From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: wm0010: Allow slow GPIO for reset
Date: Wed, 26 Sep 2012 13:54:32 +0100
Message-ID: <1348664074-26928-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6D8722625E7
 for <alsa-devel@alsa-project.org>; Wed, 26 Sep 2012 14:54:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We never set the GPIO from atomic context so there's no reason why we
can't support a GPIO that needs to sleep when configuring.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm0010.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index f8d6c31..4722acf 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -168,7 +168,8 @@ static void wm0010_halt(struct snd_soc_codec *codec)
 	case WM0010_STAGE2:
 	case WM0010_FIRMWARE:
 		/* Remember to put chip back into reset */
-		gpio_set_value(wm0010->gpio_reset, wm0010->gpio_reset_value);
+		gpio_set_value_cansleep(wm0010->gpio_reset,
+					wm0010->gpio_reset_value);
 		/* Disable the regulators */
 		regulator_disable(wm0010->dbvdd);
 		regulator_bulk_disable(ARRAY_SIZE(wm0010->core_supplies),
@@ -387,7 +388,7 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 	}
 
 	/* Release reset */
-	gpio_set_value(wm0010->gpio_reset, !wm0010->gpio_reset_value);
+	gpio_set_value_cansleep(wm0010->gpio_reset, !wm0010->gpio_reset_value);
 	spin_lock_irqsave(&wm0010->irq_lock, flags);
 	wm0010->state = WM0010_OUT_OF_RESET;
 	spin_unlock_irqrestore(&wm0010->irq_lock, flags);
@@ -918,7 +919,8 @@ static int __devexit wm0010_spi_remove(struct spi_device *spi)
 
 	if (wm0010->gpio_reset) {
 		/* Remember to put chip back into reset */
-		gpio_set_value(wm0010->gpio_reset, wm0010->gpio_reset_value);
+		gpio_set_value_cansleep(wm0010->gpio_reset,
+					wm0010->gpio_reset_value);
 	}
 
 	if (wm0010->irq)
-- 
1.7.10.4
