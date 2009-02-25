From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/7] ASoC: Only unregister drivers we
	registered for WM8753
Date: Wed, 25 Feb 2009 10:48:17 +0000
Message-ID: <1235558902-20314-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090225104701.GA20221@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F353A2443D
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 11:48:23 +0100 (CET)
In-Reply-To: <20090225104701.GA20221@rakim.wolfsonmicro.main>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8753.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 180ec94..93c22c4 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1845,6 +1845,7 @@ static int wm8753_remove(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->card->codec;
+	struct wm8753_setup_data *setup = socdev->codec_data;
 
 	if (codec->control_data)
 		wm8753_set_bias_level(codec, SND_SOC_BIAS_OFF);
@@ -1852,11 +1853,14 @@ static int wm8753_remove(struct platform_device *pdev)
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	i2c_unregister_device(codec->control_data);
-	i2c_del_driver(&wm8753_i2c_driver);
+	if (setup->i2c_address) {
+		i2c_unregister_device(codec->control_data);
+		i2c_del_driver(&wm8753_i2c_driver);
+	}
 #endif
 #if defined(CONFIG_SPI_MASTER)
-	spi_unregister_driver(&wm8753_spi_driver);
+	if (setup->spi)
+		spi_unregister_driver(&wm8753_spi_driver);
 #endif
 	kfree(codec->private_data);
 	kfree(codec);
-- 
1.6.1.3
