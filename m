From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: tfa9879: Add device tree bindings" to the asoc tree
Date: Wed, 20 Sep 2017 04:42:05 -0700 (PDT)
Message-ID: <20170920114205.46A284400D3@finisterre.ee.mobilebroadband>
References: <1505861944-32447-1-git-send-email-festevam@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1505861944-32447-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lukma-ynQEQJNshbs@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tfa9879: Add device tree bindings

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3d345b5f7b2f613b6965fc3fc68de9f439752ffe Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Date: Tue, 19 Sep 2017 19:59:04 -0300
Subject: [PATCH] ASoC: tfa9879: Add device tree bindings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Even though the tfa9879 driver can probe via device tree trough the
I2C core code, it is preferable to have explicit device tree
bindings instead [1], so add this support.

[1] https://www.spinics.net/lists/devicetree/msg195176.html

Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Reviewed-by: Łukasz Majewski <lukma-ynQEQJNshbs@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/sound/tfa9879.txt          | 23 ++++++++++++++++++++++
 sound/soc/codecs/tfa9879.c                         |  6 ++++++
 2 files changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tfa9879.txt

diff --git a/Documentation/devicetree/bindings/sound/tfa9879.txt b/Documentation/devicetree/bindings/sound/tfa9879.txt
new file mode 100644
index 000000000000..23ba522d9e2b
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
index 95e0a7abeb7a..f8dd67ca0744 100644
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
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
