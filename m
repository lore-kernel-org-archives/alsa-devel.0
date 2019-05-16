From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH V3] ASoC: cs42xx8: Add reset gpio handling
Date: Thu, 16 May 2019 11:12:15 +0000
Message-ID: <ae2e50f838ad1990b1ae20a75cfc573d29369cff.1558004881.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <77F5604BA7571D4DB7E6178C79B79A9F@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "brian.austin@cirrus.com" <brian.austin@cirrus.com>, "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Handle the reset GPIO and reset the device every time we
start it.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
Changes in v3
- update binding document.

Changes in v2
- use devm_gpiod_get_optional instead of of_get_named_gpio

 Documentation/devicetree/bindings/sound/cs42xx8.txt |  6 ++++++
 sound/soc/codecs/cs42xx8.c                          | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cs42xx8.txt b/Document=
ation/devicetree/bindings/sound/cs42xx8.txt
index 8619a156d038..ab8f54095269 100644
--- a/Documentation/devicetree/bindings/sound/cs42xx8.txt
+++ b/Documentation/devicetree/bindings/sound/cs42xx8.txt
@@ -14,6 +14,11 @@ Required properties:
   - VA-supply, VD-supply, VLS-supply, VLC-supply: power supplies for the d=
evice,
     as covered in Documentation/devicetree/bindings/regulator/regulator.tx=
t
=20
+Optional properties:
+
+  - reset-gpio : a GPIO spec to define which pin is connected to the chip'=
s
+    !RESET pin
+
 Example:
=20
 cs42888: codec@48 {
@@ -25,4 +30,5 @@ cs42888: codec@48 {
 	VD-supply =3D <&reg_audio>;
 	VLS-supply =3D <&reg_audio>;
 	VLC-supply =3D <&reg_audio>;
+	reset-gpio =3D <&pca9557_b 1 1>;
 };
diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index 28a4ac36c4f8..b377cddaf2e6 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <sound/pcm_params.h>
@@ -45,6 +46,7 @@ struct cs42xx8_priv {
 	bool slave_mode;
 	unsigned long sysclk;
 	u32 tx_channels;
+	struct gpio_desc *gpiod_reset;
 };
=20
 /* -127.5dB to 0dB with step of 0.5dB */
@@ -467,6 +469,13 @@ int cs42xx8_probe(struct device *dev, struct regmap *r=
egmap)
 		return -EINVAL;
 	}
=20
+	cs42xx8->gpiod_reset =3D devm_gpiod_get_optional(dev, "reset",
+							GPIOD_OUT_HIGH);
+	if (IS_ERR(cs42xx8->gpiod_reset))
+		return PTR_ERR(cs42xx8->gpiod_reset);
+
+	gpiod_set_value_cansleep(cs42xx8->gpiod_reset, 0);
+
 	cs42xx8->clk =3D devm_clk_get(dev, "mclk");
 	if (IS_ERR(cs42xx8->clk)) {
 		dev_err(dev, "failed to get the clock: %ld\n",
@@ -547,6 +556,8 @@ static int cs42xx8_runtime_resume(struct device *dev)
 		return ret;
 	}
=20
+	gpiod_set_value_cansleep(cs42xx8->gpiod_reset, 0);
+
 	ret =3D regulator_bulk_enable(ARRAY_SIZE(cs42xx8->supplies),
 				    cs42xx8->supplies);
 	if (ret) {
@@ -586,6 +597,8 @@ static int cs42xx8_runtime_suspend(struct device *dev)
 	regulator_bulk_disable(ARRAY_SIZE(cs42xx8->supplies),
 			       cs42xx8->supplies);
=20
+	gpiod_set_value_cansleep(cs42xx8->gpiod_reset, 1);
+
 	clk_disable_unprepare(cs42xx8->clk);
=20
 	return 0;
--=20
2.21.0
