From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH 2/4] ASoc: kirkwood: simplify probe error
Date: Thu, 25 Jul 2013 11:13:57 +0200
Message-ID: <20130725111357.7c976963@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The function kirkwood_i2s_dev_remove() may be used when probe fails.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 44 +++++++++++++++++++------------=
--------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kir=
kwood-i2s.c
index 4c9dad3..d3e50af 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -455,6 +455,21 @@ static const struct snd_soc_component_driver kirkw=
ood_i2s_component =3D {
 	.name		=3D DRV_NAME,
 };
=20
+static int kirkwood_i2s_dev_remove(struct platform_device *pdev)
+{
+	struct kirkwood_dma_data *priv =3D dev_get_drvdata(&pdev->dev);
+
+	snd_soc_unregister_component(&pdev->dev);
+
+	if (!IS_ERR(priv->extclk)) {
+		clk_disable_unprepare(priv->extclk);
+		clk_put(priv->extclk);
+	}
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
 static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct kirkwood_asoc_platform_data *data =3D pdev->dev.platform_data;
@@ -525,34 +540,17 @@ static int kirkwood_i2s_dev_probe(struct platform=
_device *pdev)
=20
 	err =3D snd_soc_register_component(&pdev->dev, &kirkwood_i2s_componen=
t,
 					 soc_dai, 1);
-	if (!err)
-		return 0;
-	dev_err(&pdev->dev, "snd_soc_register_component failed\n");
-
-	if (!IS_ERR(priv->extclk)) {
-		clk_disable_unprepare(priv->extclk);
-		clk_put(priv->extclk);
+	if (err) {
+		dev_err(&pdev->dev, "snd_soc_register_component failed\n");
+		goto fail;
 	}
-	clk_disable_unprepare(priv->clk);
+	return 0;
=20
+fail:
+	kirkwood_i2s_dev_remove(pdev);
 	return err;
 }
=20
-static int kirkwood_i2s_dev_remove(struct platform_device *pdev)
-{
-	struct kirkwood_dma_data *priv =3D dev_get_drvdata(&pdev->dev);
-
-	snd_soc_unregister_component(&pdev->dev);
-
-	if (!IS_ERR(priv->extclk)) {
-		clk_disable_unprepare(priv->extclk);
-		clk_put(priv->extclk);
-	}
-	clk_disable_unprepare(priv->clk);
-
-	return 0;
-}
-
 static struct platform_driver kirkwood_i2s_driver =3D {
 	.probe  =3D kirkwood_i2s_dev_probe,
 	.remove =3D kirkwood_i2s_dev_remove,
--=20
1.8.3.2



--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
