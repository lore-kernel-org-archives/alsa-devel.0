From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8782: add support for regulators" to
	the asoc tree
Date: Mon,  8 Oct 2018 14:57:05 +0100 (BST)
Message-ID: <20181008135705.73B071122339@debutante.sirena.org.uk>
References: <20181003193436.5281-2-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 36FA126778A
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2018 15:57:06 +0200 (CEST)
In-Reply-To: <20181003193436.5281-2-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: tiwai@suse.de, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8782: add support for regulators

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7454a21c13f7ce9bf1a4f9b639039b78462cec09 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Wed, 3 Oct 2018 21:34:36 +0200
Subject: [PATCH] ASoC: wm8782: add support for regulators

Lookup regulators for Vdd and Vdda during probe, and enable them when the
component is linked.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2
