From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: wm8750: Fix missing braces around initializer warning
Date: Sat, 13 Aug 2011 11:45:14 +0800
Message-ID: <1313207114.29596.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Richard Purdie <richard@openedhand.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix below warning:
  CC      sound/soc/codecs/wm8750.o
sound/soc/codecs/wm8750.c:784: warning: missing braces around initializer
sound/soc/codecs/wm8750.c:784: warning: (near initialization for 'wm8750_spi_ids[2].name')

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8750.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 82ac5fc..8983ab1 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -781,7 +781,7 @@ static int __devexit wm8750_spi_remove(struct spi_device *spi)
 static const struct spi_device_id wm8750_spi_ids[] = {
 	{ "wm8750", 0 },
 	{ "wm8987", 0 },
-	{ 0, 0 },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, wm8750_spi_ids);
 
-- 
1.7.4.1
