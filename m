From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/3 v2] ASoC: ak5386: add regulator consumer
	support
Date: Thu, 27 Mar 2014 21:42:14 +0100
Message-ID: <1395952936-10670-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f42.google.com (mail-ee0-f42.google.com [74.125.83.42])
 by alsa0.perex.cz (Postfix) with ESMTP id A5C9B265475
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 21:42:27 +0100 (CET)
Received: by mail-ee0-f42.google.com with SMTP id d17so3371961eek.1
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 13:42:27 -0700 (PDT)
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

The chip has two power supplies, VA and VDD. Enable them both as long
as the codec is in use.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/ak5386.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/sound/soc/codecs/ak5386.c b/sound/soc/codecs/ak5386.c
index 72e953b..a30be5c 100644
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
 
+static const char const *supply_names[] = {
+	"va", "vd"
+};
+
 struct ak5386_priv {
 	int reset_gpio;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
 };
 
 static const struct snd_soc_dapm_widget ak5386_dapm_widgets[] = {
@@ -32,7 +38,42 @@ static const struct snd_soc_dapm_route ak5386_dapm_routes[] = {
 	{ "Capture", NULL, "AINR" },
 };
 
+static int ak5386_soc_probe(struct snd_soc_codec *codec)
+{
+	struct ak5386_priv *priv = snd_soc_codec_get_drvdata(codec);
+	return regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
+}
+
+static int ak5386_soc_remove(struct snd_soc_codec *codec)
+{
+	struct ak5386_priv *priv = snd_soc_codec_get_drvdata(codec);
+	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int ak5386_soc_suspend(struct snd_soc_codec *codec)
+{
+	struct ak5386_priv *priv = snd_soc_codec_get_drvdata(codec);
+	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
+	return 0;
+}
+
+static int ak5386_soc_resume(struct snd_soc_codec *codec)
+{
+	struct ak5386_priv *priv = snd_soc_codec_get_drvdata(codec);
+	return regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
+}
+#else
+#define ak5386_soc_suspend	NULL
+#define ak5386_soc_resume	NULL
+#endif /* CONFIG_PM */
+
 static struct snd_soc_codec_driver soc_codec_ak5386 = {
+	.probe = ak5386_soc_probe,
+	.remove = ak5386_soc_remove,
+	.suspend = ak5386_soc_suspend,
+	.resume = ak5386_soc_resume,
 	.dapm_widgets = ak5386_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(ak5386_dapm_widgets),
 	.dapm_routes = ak5386_dapm_routes,
@@ -122,6 +163,7 @@ static int ak5386_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ak5386_priv *priv;
+	int ret, i;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -130,6 +172,14 @@ static int ak5386_probe(struct platform_device *pdev)
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
 	if (of_match_device(of_match_ptr(ak5386_dt_ids), dev))
 		priv->reset_gpio = of_get_named_gpio(dev->of_node,
 						      "reset-gpio", 0);
-- 
1.8.5.3
