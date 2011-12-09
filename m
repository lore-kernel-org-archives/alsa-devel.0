From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: Make WM8770 SPI usage unconditional
Date: Fri,  9 Dec 2011 20:27:18 +0800
Message-ID: <1323433640-29538-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1323433640-29538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 19D7124346
	for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2011 13:27:30 +0100 (CET)
In-Reply-To: <1323433640-29538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The device only supports SPI.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8770.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index c23aa14..19374a9 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -690,7 +690,6 @@ static const struct of_device_id wm8770_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, wm8770_of_match);
 
-#if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8770_spi_probe(struct spi_device *spi)
 {
 	struct wm8770_priv *wm8770;
@@ -725,28 +724,23 @@ static struct spi_driver wm8770_spi_driver = {
 	.probe = wm8770_spi_probe,
 	.remove = __devexit_p(wm8770_spi_remove)
 };
-#endif
 
 static int __init wm8770_modinit(void)
 {
 	int ret = 0;
 
-#if defined(CONFIG_SPI_MASTER)
 	ret = spi_register_driver(&wm8770_spi_driver);
 	if (ret) {
 		printk(KERN_ERR "Failed to register wm8770 SPI driver: %d\n",
 		       ret);
 	}
-#endif
 	return ret;
 }
 module_init(wm8770_modinit);
 
 static void __exit wm8770_exit(void)
 {
-#if defined(CONFIG_SPI_MASTER)
 	spi_unregister_driver(&wm8770_spi_driver);
-#endif
 }
 module_exit(wm8770_exit);
 
-- 
1.7.7.3
