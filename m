From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ASoC: tfa9879: Add device tree bindings
Date: Tue, 19 Sep 2017 19:59:04 -0300
Message-ID: <1505861944-32447-1-git-send-email-festevam@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, lukma-ynQEQJNshbs@public.gmane.org, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>

Even though the tfa9879 driver can probe via device tree trough the
I2C core code, it is preferable to have explicit device tree
bindings instead [1], so add this support.

[1] https://www.spinics.net/lists/devicetree/msg195176.html

Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
---
Hi Lukasz,

Could you please test this on your hardware?

 .../devicetree/bindings/sound/tfa9879.txt          | 23 ++++++++++++++++++++++
 sound/soc/codecs/tfa9879.c                         |  6 ++++++
 2 files changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tfa9879.txt

diff --git a/Documentation/devicetree/bindings/sound/tfa9879.txt b/Documentation/devicetree/bindings/sound/tfa9879.txt
new file mode 100644
index 0000000..731ffe8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tfa9879.txt
@@ -0,0 +1,23 @@
+NXP TFA9879 class-D audio amplifier
+
+Required properties:
+
+- compatible : "nxp,tfa9879"
+
+- reg : the I2C address of the device
+
+Example:
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	codec: tfa9879@6c {
+		#sound-dai-cells = <0>;
+		compatible = "nxp,tfa9879";
+		reg = <0x6c>;
+        };
+};
+
diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index 95e0a7a..f8dd67c 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -312,9 +312,15 @@ static const struct i2c_device_id tfa9879_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, tfa9879_i2c_id);
 
+static const struct of_device_id tfa9879_of_match[] = {
+	{ .compatible = "nxp,tfa9879", },
+	{ }
+};
+
 static struct i2c_driver tfa9879_i2c_driver = {
 	.driver = {
 		.name = "tfa9879",
+		.of_match_table = tfa9879_of_match,
 	},
 	.probe = tfa9879_i2c_probe,
 	.remove = tfa9879_i2c_remove,
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
