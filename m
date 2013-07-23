From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH] ARM: kirkwood: extend the kirkwood pcm/dma driver for DT
 usage
Date: Tue, 23 Jul 2013 10:46:41 +0200
Message-ID: <20130723104641.6ee0b9ec@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree-discuss@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The kirkwood pcm/dma driver is used without DT in the Kirkwood machine.
This patch adds a DT compatible definition for use in other Marvell
machines as the Armada 88AP510 (Dove).

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 Documentation/devicetree/bindings/sound/kirkwood-dma.txt | 11 ++++++++=
+++
 sound/soc/kirkwood/kirkwood-dma.c                        | 11 ++++++++=
+++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/kirkwood-dma.txt b=
/Documentation/devicetree/bindings/sound/kirkwood-dma.txt
new file mode 100644
index 0000000..9dd2989
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/kirkwood-dma.txt
@@ -0,0 +1,11 @@
+* mvebu (Kirkwood, Dove, Armada 370) PCM/DMA controller
+
+Required properties:
+
+- compatible: "marvell,mvebu-pcm-audio"
+
+Example:
+
+pcm: pcm {
+	compatible =3D "marvell,mvebu-pcm-audio";
+};
diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kir=
kwood-dma.c
index a9f1453..b91045a 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -19,6 +19,8 @@
 #include <linux/dma-mapping.h>
 #include <linux/mbus.h>
 #include <sound/soc.h>
+#include <linux/of.h>
+
 #include "kirkwood.h"
=20
 #define KIRKWOOD_RATES \
@@ -383,10 +385,19 @@ static int kirkwood_soc_platform_remove(struct pl=
atform_device *pdev)
 	return 0;
 }
=20
+#ifdef CONFIG_OF
+static struct of_device_id kirkwood_pcm_of_match[] =3D {
+	{ .compatible =3D "marvell,mvebu-pcm-audio" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, kirkwood_pcm_of_match);
+#endif
+
 static struct platform_driver kirkwood_pcm_driver =3D {
 	.driver =3D {
 			.name =3D "kirkwood-pcm-audio",
 			.owner =3D THIS_MODULE,
+		.of_match_table =3D of_match_ptr(kirkwood_pcm_of_match),
 	},
=20
 	.probe =3D kirkwood_soc_platform_probe,


--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
