From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v3 3/4] ASoc: kirkwood: add DT support
Date: Wed, 31 Jul 2013 08:18:32 +0200
Message-ID: <20130731081832.54212b76@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The kirkwood audio driver is used without DT in the Kirkwood machine.
This patch adds a DT compatible definition for use in other Marvell
machines such as the Armada 88AP510 (Dove).

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/kirkwood/kirkwood-i2s.c        | 27 ++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kir=
kwood-i2s.c
index a13fffb..234b5a1 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -12,7 +12,6 @@
=20
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/mbus.h>
@@ -22,6 +21,8 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <linux/platform_data/asoc-kirkwood.h>
+#include <linux/of.h>
+
 #include "kirkwood.h"
=20
 #define DRV_NAME	"kirkwood-i2s"
@@ -469,6 +470,7 @@ static int kirkwood_i2s_dev_probe(struct platform_d=
evice *pdev)
 	struct snd_soc_dai_driver *soc_dai =3D &kirkwood_i2s_dai;
 	struct kirkwood_dma_data *priv;
 	struct resource *mem;
+	struct device_node *np =3D pdev->dev.of_node;
 	int err;
=20
 	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -489,14 +491,16 @@ static int kirkwood_i2s_dev_probe(struct platform=
_device *pdev)
 		return -ENXIO;
 	}
=20
-	if (!data) {
-		dev_err(&pdev->dev, "no platform data ?!\n");
+	if (np) {
+		priv->burst =3D 128;		/* might be 32 or 128 */
+	} else if (data) {
+		priv->burst =3D data->burst;
+	} else {
+		dev_err(&pdev->dev, "no DT nor platform data ?!\n");
 		return -EINVAL;
 	}
=20
-	priv->burst =3D data->burst;
-
-	priv->clk =3D devm_clk_get(&pdev->dev, NULL);
+	priv->clk =3D devm_clk_get(&pdev->dev, np ? "internal" : NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev, "no clock\n");
 		return PTR_ERR(priv->clk);
@@ -523,7 +527,7 @@ static int kirkwood_i2s_dev_probe(struct platform_d=
evice *pdev)
 	priv->ctl_rec =3D KIRKWOOD_RECCTL_SIZE_24;
=20
 	/* Select the burst size */
-	if (data->burst =3D=3D 32) {
+	if (priv->burst =3D=3D 32) {
 		priv->ctl_play |=3D KIRKWOOD_PLAYCTL_BURST_32;
 		priv->ctl_rec |=3D KIRKWOOD_RECCTL_BURST_32;
 	} else {
@@ -549,12 +553,21 @@ fail:
 	return err;
 }
=20
+#ifdef CONFIG_OF
+static struct of_device_id kirkwood_i2s_of_match[] =3D {
+	{ .compatible =3D "marvell,kirkwood-i2s" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, kirkwood_i2s_of_match);
+#endif
+
 static struct platform_driver kirkwood_i2s_driver =3D {
 	.probe  =3D kirkwood_i2s_dev_probe,
 	.remove =3D kirkwood_i2s_dev_remove,
 	.driver =3D {
 		.name =3D DRV_NAME,
 		.owner =3D THIS_MODULE,
+		.of_match_table =3D of_match_ptr(kirkwood_i2s_of_match),
 	},
 };
=20

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
