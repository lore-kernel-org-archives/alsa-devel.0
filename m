From: Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH] ASoC: AK4458: add regulator for ak4458
Date: Thu, 16 May 2019 13:00:48 +0000
Message-ID: <1558011640-7864-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <84B5814EB7C3584DB9AFC20C3093B2FF@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Colin Ian King <colin.king@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

Add regulator for ak4458.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 sound/soc/codecs/ak4458.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 7156215..06dcf13 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -12,6 +12,7 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
@@ -21,6 +22,12 @@
=20
 #include "ak4458.h"
=20
+#define AK4458_NUM_SUPPLIES 2
+static const char *ak4458_supply_names[AK4458_NUM_SUPPLIES] =3D {
+	"DVDD",
+	"AVDD",
+};
+
 struct ak4458_drvdata {
 	struct snd_soc_dai_driver *dai_drv;
 	const struct snd_soc_component_driver *comp_drv;
@@ -37,6 +44,7 @@ struct ak4458_priv {
 	int fmt;
 	int slots;
 	int slot_width;
+	struct regulator_bulk_data supplies[AK4458_NUM_SUPPLIES];
 };
=20
 static const struct reg_default ak4458_reg_defaults[] =3D {
@@ -666,7 +674,7 @@ static int ak4458_i2c_probe(struct i2c_client *i2c)
 {
 	struct ak4458_priv *ak4458;
 	const struct ak4458_drvdata *drvdata;
-	int ret;
+	int ret, i;
=20
 	ak4458 =3D devm_kzalloc(&i2c->dev, sizeof(*ak4458), GFP_KERNEL);
 	if (!ak4458)
@@ -691,6 +699,23 @@ static int ak4458_i2c_probe(struct i2c_client *i2c)
 	if (IS_ERR(ak4458->mute_gpiod))
 		return PTR_ERR(ak4458->mute_gpiod);
=20
+	for (i =3D 0; i < ARRAY_SIZE(ak4458->supplies); i++)
+		ak4458->supplies[i].supply =3D ak4458_supply_names[i];
+
+	ret =3D devm_regulator_bulk_get(ak4458->dev, ARRAY_SIZE(ak4458->supplies)=
,
+				      ak4458->supplies);
+	if (ret !=3D 0) {
+		dev_err(ak4458->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	ret =3D regulator_bulk_enable(ARRAY_SIZE(ak4458->supplies),
+				    ak4458->supplies);
+	if (ret !=3D 0) {
+		dev_err(ak4458->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
 	ret =3D devm_snd_soc_register_component(ak4458->dev, drvdata->comp_drv,
 					      drvdata->dai_drv, 1);
 	if (ret < 0) {
--=20
2.7.4
