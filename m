From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/8] ASoC: Add WM8510 SPI support
Date: Wed,  8 Oct 2008 10:37:55 +0100
Message-ID: <1223458680-9506-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081008093611.GA9425@rakim.wolfsonmicro.main>
	<1223458680-9506-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1223458680-9506-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 80139244C3
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Oct 2008 11:38:15 +0200 (CEST)
In-Reply-To: <1223458680-9506-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Implement SPI support for WM8510, cut'n'pasting from the support for
WM8731 contributed by Cliff Cai and Alan Horstmann since the wire format
is the same for both codecs.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8510.c |   70 +++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wm8510.h |    1 +
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 9a37c8d..16768a5 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -18,6 +18,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
+#include <linux/spi/spi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -747,6 +748,62 @@ err_driver:
 }
 #endif
 
+#if defined(CONFIG_SPI_MASTER)
+static int __devinit wm8510_spi_probe(struct spi_device *spi)
+{
+	struct snd_soc_device *socdev = wm8510_socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	int ret;
+
+	codec->control_data = spi;
+
+	ret = wm8510_init(socdev);
+	if (ret < 0)
+		dev_err(&spi->dev, "failed to initialise WM8510\n");
+
+	return ret;
+}
+
+static int __devexit wm8510_spi_remove(struct spi_device *spi)
+{
+	return 0;
+}
+
+static struct spi_driver wm8510_spi_driver = {
+	.driver = {
+		.name	= "wm8510",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= wm8510_spi_probe,
+	.remove		= __devexit_p(wm8510_spi_remove),
+};
+
+static int wm8510_spi_write(struct spi_device *spi, const char *data, int len)
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
+#endif /* CONFIG_SPI_MASTER */
+
 static int wm8510_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
@@ -772,8 +829,14 @@ static int wm8510_probe(struct platform_device *pdev)
 		codec->hw_write = (hw_write_t)i2c_master_send;
 		ret = wm8510_add_i2c_device(pdev, setup);
 	}
-#else
-	/* Add other interfaces here */
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	if (setup->spi) {
+		codec->hw_write = (hw_write_t)wm8510_spi_write;
+		ret = spi_register_driver(&wm8510_spi_driver);
+		if (ret != 0)
+			printk(KERN_ERR "can't add spi driver");
+	}
 #endif
 
 	if (ret != 0)
@@ -796,6 +859,9 @@ static int wm8510_remove(struct platform_device *pdev)
 	i2c_unregister_device(codec->control_data);
 	i2c_del_driver(&wm8510_i2c_driver);
 #endif
+#if defined(CONFIG_SPI_MASTER)
+	spi_unregister_driver(&wm8510_spi_driver);
+#endif
 	kfree(codec);
 
 	return 0;
diff --git a/sound/soc/codecs/wm8510.h b/sound/soc/codecs/wm8510.h
index c536839..bdefcf5 100644
--- a/sound/soc/codecs/wm8510.h
+++ b/sound/soc/codecs/wm8510.h
@@ -94,6 +94,7 @@
 #define WM8510_MCLKDIV_12	(7 << 5)
 
 struct wm8510_setup_data {
+	int spi;
 	int i2c_bus;
 	unsigned short i2c_address;
 };
-- 
1.5.6.5
