From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH 4/4 v2] ASoc: kirkwood: add DT support
Date: Thu, 25 Jul 2013 20:40:37 +0200
Message-ID: <20130725204037.6ffc62d5@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The kirkwood audio driver is used without DT in the Kirkwood machine.
This patch adds a DT compatible definition for use in other Marvell
machines as the Armada 88AP510 (Dove).

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
v2
	fix compilation error
---
 Documentation/devicetree/bindings/sound/kirkwood-i2s.txt | 29 ++++++++=
++++++++++
 sound/soc/kirkwood/kirkwood-i2s.c                        | 35 ++++++++=
+++++++-------
 2 files changed, 53 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/kirkwood-i2=
s.txt

diff --git a/Documentation/devicetree/bindings/sound/kirkwood-i2s.txt b=
/Documentation/devicetree/bindings/sound/kirkwood-i2s.txt
new file mode 100644
index 0000000..015a769
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/kirkwood-i2s.txt
@@ -0,0 +1,29 @@
+* mvebu (Kirkwood, Dove, Armada 370) I2S controller
+
+Required properties:
+
+- compatible: "marvell,mvebu-i2s"
+
+- reg: physical base address of the controller and length of memory ma=
pped
+  region.
+
+- interrupts: list of two irq numbers.
+  The first irq is used for data flow and the second one is used for e=
rrors.
+
+- clocks: one or two phandles.
+  The first one is mandatory and defines the internal clock.
+  The second one is optional and defines an external clock.
+
+- clock-names: names associated to the clocks:
+	"internal" for the internal clock
+	"external" for the external clock
+
+Example:
+
+i2s1: audio-controller@b4000 {
+	compatible =3D "marvell,mvebu-i2s";
+	reg =3D <0xb4000 0x2210>;
+	interrupts =3D <21>, <22>;
+	clocks =3D <&gate_clk 13>;
+	clock-names =3D "internal";
+};
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/home/jef/kernel/sound/=
soc/kirkwood/kirkwood-i2s.c.new
index a1037e2..26c2f74 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/home/jef/kernel/sound/soc/kirkwood/kirkwood-i2s.c.new
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
@@ -477,6 +478,7 @@ static int kirkwood_i2s_dev_probe(struct platform_d=
evice *pdev)
 	struct snd_soc_dai_driver *soc_dai =3D &kirkwood_i2s_dai;
 	struct kirkwood_dma_data *priv;
 	struct resource *mem;
+	struct device_node *np =3D pdev->dev.of_node;
 	int err;
=20
 	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -497,16 +499,18 @@ static int kirkwood_i2s_dev_probe(struct platform=
_device *pdev)
 		return -ENXIO;
 	}
=20
-	if (!data) {
-		dev_err(&pdev->dev, "no platform data ?!\n");
-		return -EINVAL;
-	}
-
-	priv->burst =3D data->burst;
+	if (np) {
+		priv->burst =3D 128;		/* might be 32 or 128 */
+	} else if (data) {
+		priv->burst =3D data->burst;
+	} else {
+		dev_err(&pdev->dev, "no DT nor platform data ?!\n");
+ 		return -EINVAL;
+ 	}
=20
-	priv->clk =3D devm_clk_get(&pdev->dev, NULL);
+	priv->clk =3D devm_clk_get(&pdev->dev, "internal");
 	if (IS_ERR(priv->clk)) {
-		dev_err(&pdev->dev, "no clock\n");
+		dev_err(&pdev->dev, "no internal clock\n");
 		return PTR_ERR(priv->clk);
 	}
=20
@@ -514,7 +518,7 @@ static int kirkwood_i2s_dev_probe(struct platform_d=
evice *pdev)
 	if (err < 0)
 		return err;
=20
-	priv->extclk =3D clk_get(&pdev->dev, "extclk");
+	priv->extclk =3D clk_get(&pdev->dev, "external");
 	if (!IS_ERR(priv->extclk)) {
 		if (priv->extclk =3D=3D priv->clk) {
 			clk_put(priv->extclk);
@@ -531,7 +535,7 @@ static int kirkwood_i2s_dev_probe(struct platform_d=
evice *pdev)
 	priv->ctl_rec =3D KIRKWOOD_RECCTL_SIZE_24;
=20
 	/* Select the burst size */
-	if (data->burst =3D=3D 32) {
+	if (priv->burst =3D=3D 32) {
 		priv->ctl_play |=3D KIRKWOOD_PLAYCTL_BURST_32;
 		priv->ctl_rec |=3D KIRKWOOD_RECCTL_BURST_32;
 	} else {
@@ -557,12 +561,21 @@ fail:
 	return err;
 }
=20
+#ifdef CONFIG_OF
+static struct of_device_id kirkwood_i2s_of_match[] =3D {
+	{ .compatible =3D "marvell,mvebu-i2s" },
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
1.8.3.2



--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
