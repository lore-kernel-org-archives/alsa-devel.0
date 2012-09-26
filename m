From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: wm0010: Don't check if reset GPIO is
	defined when removing
Date: Wed, 26 Sep 2012 13:54:33 +0100
Message-ID: <1348664074-26928-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1348664074-26928-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6BA872625E6
 for <alsa-devel@alsa-project.org>; Wed, 26 Sep 2012 14:54:37 +0200 (CEST)
In-Reply-To: <1348664074-26928-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

We will fail to probe without one.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm0010.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 4722acf..780110a 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -917,11 +917,8 @@ static int __devexit wm0010_spi_remove(struct spi_device *spi)
 
 	snd_soc_unregister_codec(&spi->dev);
 
-	if (wm0010->gpio_reset) {
-		/* Remember to put chip back into reset */
-		gpio_set_value_cansleep(wm0010->gpio_reset,
-					wm0010->gpio_reset_value);
-	}
+	gpio_set_value_cansleep(wm0010->gpio_reset,
+				wm0010->gpio_reset_value);
 
 	if (wm0010->irq)
 		free_irq(wm0010->irq, wm0010);
-- 
1.7.10.4
