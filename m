From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix SPI driver binding for WM8987
Date: Wed,  3 Aug 2011 18:11:01 +0900
Message-ID: <1312362661-4544-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8751724643
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Aug 2011 11:11:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

As we had no id_table only the driver name would be matched against
meaning that WM8987 devices wouldn't be bound.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8750.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 6cbf51b..2bb7bea 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -779,11 +779,18 @@ static int __devexit wm8750_spi_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct spi_device_id wm8750_spi_ids[] = {
+	{ "wm8750", 0 },
+	{ "wm8987", 0 },
+};
+MODULE_DEVICE_TABLE(spi, wm8750_spi_id);
+
 static struct spi_driver wm8750_spi_driver = {
 	.driver = {
-		.name	= "wm8750-codec",
+		.name	= "wm8750",
 		.owner	= THIS_MODULE,
 	},
+	.id_table	= wm8750_spi_ids,
 	.probe		= wm8750_spi_probe,
 	.remove		= __devexit_p(wm8750_spi_remove),
 };
-- 
1.7.5.4
