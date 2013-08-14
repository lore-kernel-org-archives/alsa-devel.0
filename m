From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v5 1/1] ASoc: kirkwood: add DT support to the mvebu audio
 subsystem
Date: Wed, 14 Aug 2013 12:27:33 +0200
Message-ID: <20130814122733.5c0fd2cb@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patch adds DT support to the audio subsystem of the mvebu family
(Kirkwood, Dove, Armada 370).

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
This patch does not add any new function as S/PDIF or DPCM support.
---
 .../devicetree/bindings/sound/mvebu-audio.txt      | 29 ++++++++++++++=
++++++++
 sound/soc/kirkwood/kirkwood-i2s.c                  | 26 ++++++++++++++=
+++-----
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mvebu-audio.txt b/=
Documentation/devicetree/bindings/sound/mvebu-audio.txt
new file mode 100644
index 0000000..7e5fd37
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
@@ -0,0 +1,29 @@
+* mvebu (Kirkwood, Dove, Armada 370) audio controller
+
+Required properties:
+
+- compatible: "marvell,mvebu-audio"
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
+	"extclk" for the external clock
+
+Example:
+
+i2s1: audio-controller@b4000 {
+	compatible =3D "marvell,mvebu-audio";
+	reg =3D <0xb4000 0x2210>;
+	interrupts =3D <21>, <22>;
+	clocks =3D <&gate_clk 13>;
+	clock-names =3D "internal";
+};
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c.next b/sound/soc/kirkwoo=
d/kirkwood-i2s.c
index e5f3f7a..a4170b4 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c.next
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -22,6 +22,8 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <linux/platform_data/asoc-kirkwood.h>
+#include <linux/of.h>
+
 #include "kirkwood.h"
=20
 #define DRV_NAME	"mvebu-audio"
@@ -453,6 +455,7 @@ static int kirkwood_i2s_dev_probe(struct platform_d=
evice *pdev)
 	struct snd_soc_dai_driver *soc_dai =3D &kirkwood_i2s_dai;
 	struct kirkwood_dma_data *priv;
 	struct resource *mem;
+	struct device_node *np =3D pdev->dev.of_node;
 	int err;
=20
 	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -473,14 +476,16 @@ static int kirkwood_i2s_dev_probe(struct platform=
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
@@ -507,7 +512,7 @@ static int kirkwood_i2s_dev_probe(struct platform_d=
evice *pdev)
 	priv->ctl_rec =3D KIRKWOOD_RECCTL_SIZE_24;
=20
 	/* Select the burst size */
-	if (data->burst =3D=3D 32) {
+	if (priv->burst =3D=3D 32) {
 		priv->ctl_play |=3D KIRKWOOD_PLAYCTL_BURST_32;
 		priv->ctl_rec |=3D KIRKWOOD_RECCTL_BURST_32;
 	} else {
@@ -552,12 +557,21 @@ static int kirkwood_i2s_dev_remove(struct platfor=
m_device *pdev)
 	return 0;
 }
=20
+#ifdef CONFIG_OF
+static struct of_device_id mvebu_audio_of_match[] =3D {
+	{ .compatible =3D "marvell,mvebu-audio" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mvebu_audio_of_match);
+#endif
+
 static struct platform_driver kirkwood_i2s_driver =3D {
 	.probe  =3D kirkwood_i2s_dev_probe,
 	.remove =3D kirkwood_i2s_dev_remove,
 	.driver =3D {
 		.name =3D DRV_NAME,
 		.owner =3D THIS_MODULE,
+		.of_match_table =3D of_match_ptr(mvebu_audio_of_match),
 	},
 };
=20

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
