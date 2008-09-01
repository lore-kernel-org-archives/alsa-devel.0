From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/8] ASoC: Add SPI support for WM8731
Date: Mon,  1 Sep 2008 18:47:03 +0100
Message-ID: <1220291224-11269-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1220291224-11269-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220291224-11269-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220291224-11269-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220291224-11269-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220291224-11269-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220291224-11269-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 374CC1037FD
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 19:47:07 +0200 (CEST)
In-Reply-To: <1220291224-11269-6-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

[Modified to allow runtime selection between I2C and SPI and to select
SPI_MASTER for all codecs build so this is included. -- broonie]

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig  |    1 +
 sound/soc/codecs/wm8731.c |   71 +++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wm8731.h |    1 +
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 13ae4fd..cceac73 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -2,6 +2,7 @@ config SND_SOC_ALL_CODECS
 	tristate "Build all ASoC CODEC drivers"
 	depends on I2C
 	select SPI
+	select SPI_MASTER
 	select SND_SOC_AK4535
 	select SND_SOC_UDA1380
 	select SND_SOC_WM8510
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 5814f9b..975befd 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -19,6 +19,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
+#include <linux/spi/spi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -652,6 +653,61 @@ err_driver:
 }
 #endif
 
+#if defined(CONFIG_SPI_MASTER)
+static int __devinit wm8731_spi_probe(struct spi_device *spi)
+{
+	struct snd_soc_device *socdev = wm8731_socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	int ret;
+
+	codec->control_data = spi;
+
+	ret = wm8731_init(socdev);
+	if (ret < 0)
+		dev_err(&spi->dev, "failed to initialise WM8731\n");
+
+	return ret;
+}
+
+static int __devexit wm8731_spi_remove(struct spi_device *spi)
+{
+	return 0;
+}
+
+static struct spi_driver wm8731_spi_driver = {
+	.driver = {
+		.name	= "wm8731",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= wm8731_spi_probe,
+	.remove		= __devexit_p(wm8731_spi_remove),
+};
+
+static int wm8731_spi_write(struct spi_device *spi, const char *data, int len)
+{
+	struct spi_transfer t;
+	struct spi_message m;
+	u16 msg[2];
+
+	if (len <= 0)
+		return 0;
+
+	msg[0] = (data[0] << 8) + data[1];
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
 static int wm8731_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
@@ -680,13 +736,21 @@ static int wm8731_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
 	wm8731_socdev = socdev;
+	ret = -ENODEV;
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
 		codec->hw_write = (hw_write_t)i2c_master_send;
 		ret = wm8731_add_i2c_device(pdev, setup);
 	}
-#else
-	/* Add other interfaces here */
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	if (setup->spi) {
+		codec->hw_write = (hw_write_t)wm8731_spi_write;
+		ret = spi_register_driver(&wm8731_spi_driver);
+		if (ret != 0)
+			printk(KERN_ERR "can't add spi driver");
+	}
 #endif
 
 	if (ret != 0) {
@@ -711,6 +775,9 @@ static int wm8731_remove(struct platform_device *pdev)
 	i2c_unregister_device(codec->control_data);
 	i2c_del_driver(&wm8731_i2c_driver);
 #endif
+#if defined(CONFIG_SPI_MASTER)
+	spi_unregister_driver(&wm8731_spi_driver);
+#endif
 	kfree(codec->private_data);
 	kfree(codec);
 
diff --git a/sound/soc/codecs/wm8731.h b/sound/soc/codecs/wm8731.h
index 0f81239..95190e9 100644
--- a/sound/soc/codecs/wm8731.h
+++ b/sound/soc/codecs/wm8731.h
@@ -35,6 +35,7 @@
 #define WM8731_DAI		0
 
 struct wm8731_setup_data {
+	int            spi;
 	int            i2c_bus;
 	unsigned short i2c_address;
 };
-- 
1.5.6.5
