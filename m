From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/3 v2] ASoC: ak4104: add regulator consumer
	support
Date: Thu, 27 Mar 2014 21:42:15 +0100
Message-ID: <1395952936-10670-2-git-send-email-zonque@gmail.com>
References: <1395952936-10670-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f49.google.com (mail-ee0-f49.google.com [74.125.83.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 045CF26547C
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 21:42:28 +0100 (CET)
Received: by mail-ee0-f49.google.com with SMTP id c41so3297568eek.22
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 13:42:28 -0700 (PDT)
In-Reply-To: <1395952936-10670-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The AK4104 has only one power supply, called VDD. Enable it as long as
the codec is in use.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/ak4104.c | 62 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index 10adf25..1fd7f72 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -11,13 +11,14 @@
 
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <sound/core.h>
-#include <sound/soc.h>
-#include <sound/initval.h>
 #include <linux/spi/spi.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <linux/regulator/consumer.h>
 #include <sound/asoundef.h>
+#include <sound/core.h>
+#include <sound/soc.h>
+#include <sound/initval.h>
 
 /* AK4104 registers addresses */
 #define AK4104_REG_CONTROL1		0x00
@@ -47,6 +48,7 @@
 
 struct ak4104_private {
 	struct regmap *regmap;
+	struct regulator *regulator;
 };
 
 static const struct snd_soc_dapm_widget ak4104_dapm_widgets[] = {
@@ -174,20 +176,30 @@ static int ak4104_probe(struct snd_soc_codec *codec)
 	struct ak4104_private *ak4104 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
+	ret = regulator_enable(ak4104->regulator);
+	if (ret < 0) {
+		dev_err(codec->dev, "Unable to enable regulator: %d\n", ret);
+		return ret;
+	}
+
 	/* set power-up and non-reset bits */
 	ret = regmap_update_bits(ak4104->regmap, AK4104_REG_CONTROL1,
 				 AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN,
 				 AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN);
 	if (ret < 0)
-		return ret;
+		goto exit_disable_regulator;
 
 	/* enable transmitter */
 	ret = regmap_update_bits(ak4104->regmap, AK4104_REG_TX,
 				 AK4104_TX_TXE, AK4104_TX_TXE);
 	if (ret < 0)
-		return ret;
+		goto exit_disable_regulator;
 
 	return 0;
+
+exit_disable_regulator:
+	regulator_disable(ak4104->regulator);
+	return ret;
 }
 
 static int ak4104_remove(struct snd_soc_codec *codec)
@@ -196,13 +208,42 @@ static int ak4104_remove(struct snd_soc_codec *codec)
 
 	regmap_update_bits(ak4104->regmap, AK4104_REG_CONTROL1,
 			   AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN, 0);
+	regulator_disable(ak4104->regulator);
 
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int ak4104_soc_suspend(struct snd_soc_codec *codec)
+{
+	struct ak4104_private *priv = snd_soc_codec_get_drvdata(codec);
+
+	regulator_disable(priv->regulator);
+
+	return 0;
+}
+
+static int ak4104_soc_resume(struct snd_soc_codec *codec)
+{
+	struct ak4104_private *priv = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	ret = regulator_enable(priv->regulator);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+#else
+#define ak4104_soc_suspend	NULL
+#define ak4104_soc_resume	NULL
+#endif /* CONFIG_PM */
+
 static struct snd_soc_codec_driver soc_codec_device_ak4104 = {
-	.probe =	ak4104_probe,
-	.remove =	ak4104_remove,
+	.probe = ak4104_probe,
+	.remove = ak4104_remove,
+	.suspend = ak4104_soc_suspend,
+	.resume = ak4104_soc_resume,
 
 	.dapm_widgets = ak4104_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(ak4104_dapm_widgets),
@@ -239,6 +280,13 @@ static int ak4104_spi_probe(struct spi_device *spi)
 	if (ak4104 == NULL)
 		return -ENOMEM;
 
+	ak4104->regulator = devm_regulator_get(&spi->dev, "vdd");
+	if (IS_ERR(ak4104->regulator)) {
+		ret = PTR_ERR(ak4104->regulator);
+		dev_err(&spi->dev, "Unable to get Vdd regulator: %d\n", ret);
+		return ret;
+	}
+
 	ak4104->regmap = devm_regmap_init_spi(spi, &ak4104_regmap);
 	if (IS_ERR(ak4104->regmap)) {
 		ret = PTR_ERR(ak4104->regmap);
-- 
1.8.5.3
