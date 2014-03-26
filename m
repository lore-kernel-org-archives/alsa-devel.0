From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/3] ASoC: ak5386: add regulator consumer
	support
Date: Wed, 26 Mar 2014 11:22:56 +0100
Message-ID: <1395829378-13055-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f54.google.com (mail-bk0-f54.google.com
 [209.85.214.54])
 by alsa0.perex.cz (Postfix) with ESMTP id ED36C265130
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 11:23:05 +0100 (CET)
Received: by mail-bk0-f54.google.com with SMTP id 6so453035bkj.13
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 03:23:05 -0700 (PDT)
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

The chip has two power supplies, VA and VDD. Register and enable them
both.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/ak5386.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ak5386.c b/sound/soc/codecs/ak5386.c
index 72e953b..99fb5db 100644
--- a/sound/soc/codecs/ak5386.c
+++ b/sound/soc/codecs/ak5386.c
@@ -14,12 +14,18 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/of_device.h>
+#include <linux/regulator/consumer.h>
 #include <sound/soc.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
 
+static const char *supply_names[] = {
+	"va", "vd"
+};
+
 struct ak5386_priv {
 	int reset_gpio;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
 };
 
 static const struct snd_soc_dapm_widget ak5386_dapm_widgets[] = {
@@ -122,6 +128,7 @@ static int ak5386_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ak5386_priv *priv;
+	int ret, i;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -130,6 +137,19 @@ static int ak5386_probe(struct platform_device *pdev)
 	priv->reset_gpio = -EINVAL;
 	dev_set_drvdata(dev, priv);
 
+	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
+		priv->supplies[i].supply = supply_names[i];
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(priv->supplies),
+				      priv->supplies);
+	if (ret < 0)
+		return ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies),
+				    priv->supplies);
+	if (ret < 0)
+		return ret;
+
 	if (of_match_device(of_match_ptr(ak5386_dt_ids), dev))
 		priv->reset_gpio = of_get_named_gpio(dev->of_node,
 						      "reset-gpio", 0);
@@ -140,13 +160,22 @@ static int ak5386_probe(struct platform_device *pdev)
 					  "AK5386 Reset"))
 			priv->reset_gpio = -EINVAL;
 
-	return snd_soc_register_codec(dev, &soc_codec_ak5386,
-				      &ak5386_dai, 1);
+	ret = snd_soc_register_codec(dev, &soc_codec_ak5386,
+				     &ak5386_dai, 1);
+	if (ret < 0)
+		regulator_bulk_disable(ARRAY_SIZE(priv->supplies),
+				       priv->supplies);
+	return ret;
 }
 
 static int ak5386_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_codec(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct ak5386_priv *priv = dev_get_drvdata(dev);
+
+	snd_soc_unregister_codec(dev);
+	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
+
 	return 0;
 }
 
-- 
1.8.5.3
