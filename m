From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 2/2] ASoC: wm8782: add support for regulators
Date: Wed,  3 Oct 2018 21:34:36 +0200
Message-ID: <20181003193436.5281-2-daniel@zonque.org>
References: <20181003193436.5281-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 98C15267819
 for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2018 21:34:42 +0200 (CEST)
In-Reply-To: <20181003193436.5281-1-daniel@zonque.org>
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
Cc: tiwai@suse.de, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Lookup regulators for Vdd and Vdda during probe, and enable them when the
component is linked.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/codecs/wm8782.c | 63 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index 317db9a149a7..cf2cdbece122 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
+#include <linux/regulator/consumer.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
@@ -50,7 +51,51 @@ static struct snd_soc_dai_driver wm8782_dai = {
 	},
 };
 
+/* regulator power supply names */
+static const char *supply_names[] = {
+	"Vdda", /* analog supply, 2.7V - 3.6V */
+	"Vdd",  /* digital supply, 2.7V - 5.5V */
+};
+
+struct wm8782_priv {
+	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
+};
+
+static int wm8782_soc_probe(struct snd_soc_component *component)
+{
+	struct wm8782_priv *priv = snd_soc_component_get_drvdata(component);
+	return regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
+}
+
+static void wm8782_soc_remove(struct snd_soc_component *component)
+{
+	struct wm8782_priv *priv = snd_soc_component_get_drvdata(component);
+	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
+}
+
+#ifdef CONFIG_PM
+static int wm8782_soc_suspend(struct snd_soc_component *component)
+{
+	struct wm8782_priv *priv = snd_soc_component_get_drvdata(component);
+	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
+	return 0;
+}
+
+static int wm8782_soc_resume(struct snd_soc_component *component)
+{
+	struct wm8782_priv *priv = snd_soc_component_get_drvdata(component);
+	return regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
+}
+#else
+#define wm8782_soc_suspend      NULL
+#define wm8782_soc_resume       NULL
+#endif /* CONFIG_PM */
+
 static const struct snd_soc_component_driver soc_component_dev_wm8782 = {
+	.probe			= wm8782_soc_probe,
+	.remove			= wm8782_soc_remove,
+	.suspend		= wm8782_soc_suspend,
+	.resume			= wm8782_soc_resume,
 	.dapm_widgets		= wm8782_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(wm8782_dapm_widgets),
 	.dapm_routes		= wm8782_dapm_routes,
@@ -63,6 +108,24 @@ static const struct snd_soc_component_driver soc_component_dev_wm8782 = {
 
 static int wm8782_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct wm8782_priv *priv;
+	int ret, i;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+
+	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
+		priv->supplies[i].supply = supply_names[i];
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(priv->supplies),
+				      priv->supplies);
+	if (ret < 0)
+		return ret;
+
 	return devm_snd_soc_register_component(&pdev->dev,
 			&soc_component_dev_wm8782, &wm8782_dai, 1);
 }
-- 
2.17.1
