From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: wm0010: Initialise chip state before
	we register the interrupt
Date: Wed, 26 Sep 2012 13:54:34 +0100
Message-ID: <1348664074-26928-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1348664074-26928-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6F2B92625EA
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

The interrupt handler uses the chip state.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm0010.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 780110a..99afc00 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -810,7 +810,6 @@ static int wm0010_probe(struct snd_soc_codec *codec)
 
 static int __devinit wm0010_spi_probe(struct spi_device *spi)
 {
-	unsigned long flags;
 	unsigned long gpio_flags;
 	int ret;
 	int trigger;
@@ -877,6 +876,8 @@ static int __devinit wm0010_spi_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
+	wm0010->state = WM0010_POWER_OFF;
+
 	irq = spi->irq;
 	if (wm0010->pdata.irq_flags)
 		trigger = wm0010->pdata.irq_flags;
@@ -898,10 +899,6 @@ static int __devinit wm0010_spi_probe(struct spi_device *spi)
 	else
 		wm0010->board_max_spi_speed = 0;
 
-	spin_lock_irqsave(&wm0010->irq_lock, flags);
-	wm0010->state = WM0010_POWER_OFF;
-	spin_unlock_irqrestore(&wm0010->irq_lock, flags);
-
 	ret = snd_soc_register_codec(&spi->dev,
 				     &soc_codec_dev_wm0010, wm0010_dai,
 				     ARRAY_SIZE(wm0010_dai));
-- 
1.7.10.4
