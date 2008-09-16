From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: Add WM8750 SPI support
Date: Tue, 16 Sep 2008 13:49:32 +0100
Message-ID: <1221569372-15516-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080916124851.GA15445@rakim.wolfsonmicro.main>
	<1221569372-15516-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1221569372-15516-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 139CD24411
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Sep 2008 14:49:34 +0200 (CEST)
In-Reply-To: <1221569372-15516-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Implement SPI support for WM8750, cut'n'pasting from the support for
WM8731 contributed by Cliff Cai and Alan Horstmann since the wire format
is the same for both codecs.

Also fix a cut'n'pasted comment in the I2C side of the driver (which was
clearly written in the same way) while we're at it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8750.c |   70 ++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wm8750.h |    1 +
 2 files changed, 70 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 9847aa0..4892e39 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -19,6 +19,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
+#include <linux/spi/spi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -841,7 +842,7 @@ static struct snd_soc_device *wm8750_socdev;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 
 /*
- * WM8731 2 wire address is determined by GPIO5
+ * WM8750 2 wire address is determined by GPIO5
  * state during powerup.
  *    low  = 0x1a
  *    high = 0x1b
@@ -928,6 +929,62 @@ err_driver:
 }
 #endif
 
+#if defined(CONFIG_SPI_MASTER)
+static int __devinit wm8750_spi_probe(struct spi_device *spi)
+{
+	struct snd_soc_device *socdev = wm8750_socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	int ret;
+
+	codec->control_data = spi;
+
+	ret = wm8750_init(socdev);
+	if (ret < 0)
+		dev_err(&spi->dev, "failed to initialise WM8750\n");
+
+	return ret;
+}
+
+static int __devexit wm8750_spi_remove(struct spi_device *spi)
+{
+	return 0;
+}
+
+static struct spi_driver wm8750_spi_driver = {
+	.driver = {
+		.name	= "wm8750",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= wm8750_spi_probe,
+	.remove		= __devexit_p(wm8750_spi_remove),
+};
+
+static int wm8750_spi_write(struct spi_device *spi, const char *data, int len)
+{
+	struct spi_transfer t;
+	struct spi_message m;
+	u8 msg[2];
+
+	if (len <= 0)
+		return 0;
+
+	msg[0] = data[0];
+	msg[1] = data[1];
+
+	spi_message_init(&m);
+	memset(&t, 0, (sizeof t));
+
+	t.tx_buf = &msg[0];
+	t.len = len;
+
+	spi_message_add_tail(&t, &m);
+	spi_sync(spi, &m);
+
+	return len;
+}
+#endif
+
 static int wm8750_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
@@ -963,6 +1020,14 @@ static int wm8750_probe(struct platform_device *pdev)
 		ret = wm8750_add_i2c_device(pdev, setup);
 	}
 #endif
+#if defined(CONFIG_SPI_MASTER)
+	if (setup->spi) {
+		codec->hw_write = (hw_write_t)wm8750_spi_write;
+		ret = spi_register_driver(&wm8750_spi_driver);
+		if (ret != 0)
+			printk(KERN_ERR "can't add spi driver");
+	}
+#endif
 
 	if (ret != 0) {
 		kfree(codec->private_data);
@@ -1005,6 +1070,9 @@ static int wm8750_remove(struct platform_device *pdev)
 	i2c_unregister_device(codec->control_data);
 	i2c_del_driver(&wm8750_i2c_driver);
 #endif
+#if defined(CONFIG_SPI_MASTER)
+	spi_unregister_driver(&wm8750_spi_driver);
+#endif
 	kfree(codec->private_data);
 	kfree(codec);
 
diff --git a/sound/soc/codecs/wm8750.h b/sound/soc/codecs/wm8750.h
index fe6c80f..1dc100e 100644
--- a/sound/soc/codecs/wm8750.h
+++ b/sound/soc/codecs/wm8750.h
@@ -58,6 +58,7 @@
 #define WM8750_SYSCLK	0
 
 struct wm8750_setup_data {
+	int spi;
 	int i2c_bus;
 	unsigned short i2c_address;
 };
-- 
1.5.6.5
