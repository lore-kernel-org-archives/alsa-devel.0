From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 2/8] ASoC: da9055: Add DT support for CODEC
Date: Wed, 5 Feb 2014 17:48:33 +0000
Message-ID: <9ec36c0633ae8291267be6802a34a469a34ae292.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.149])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C80C265049
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 18:48:35 +0100 (CET)
In-Reply-To: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Alessandro Zummo <a.zummo@towertech.it>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.netg>, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 Documentation/devicetree/bindings/sound/da9055.txt |   22 ++++++++++++++++++++
 sound/soc/codecs/da9055.c                          |    8 +++++++
 2 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/da9055.txt

diff --git a/Documentation/devicetree/bindings/sound/da9055.txt b/Documentation/devicetree/bindings/sound/da9055.txt
new file mode 100644
index 0000000..ed1b7cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/da9055.txt
@@ -0,0 +1,22 @@
+* Dialog DA9055 Audio CODEC
+
+DA9055 provides Audio CODEC support (I2C only).
+
+The Audio CODEC device in DA9055 has it's own I2C address which is configurable,
+so the device is instantiated separately from the PMIC (MFD) device.
+
+For details on accompanying PMIC I2C device, see the following:
+Documentation/devicetree/bindings/mfd/da9055.txt
+
+Required properties:
+
+  - compatible: "dlg,da9055-codec"
+  - reg: Specifies the I2C slave address
+
+
+Example:
+
+	codec: da9055-codec@1a {
+		compatible = "dlg,da9055-codec";
+		reg = <0x1a>;
+	};
diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index 4228126..be31f3c 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -18,6 +18,8 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -1536,11 +1538,17 @@ static const struct i2c_device_id da9055_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, da9055_i2c_id);

+static const struct of_device_id da9055_of_match[] = {
+	{ .compatible = "dlg,da9055-codec", },
+	{ }
+};
+
 /* I2C codec control layer */
 static struct i2c_driver da9055_i2c_driver = {
 	.driver = {
 		.name = "da9055-codec",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(da9055_of_match),
 	},
 	.probe		= da9055_i2c_probe,
 	.remove		= da9055_remove,
--
1.7.0.4
