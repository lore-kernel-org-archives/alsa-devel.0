From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: ak4458: Add bindings for AK4458 DAC" to the asoc tree
Date: Fri, 16 Feb 2018 12:04:20 +0000
Message-ID: <E1emekW-00053C-Hz@debutante>
References: <1518614467-20613-3-git-send-email-cosmin.samoila@nxp.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1518614467-20613-3-git-send-email-cosmin.samoila-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cosmin-Gabriel Samoila <cosmin.samoila-3arQi8VN3Tc@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shegjiu.wang-3arQi8VN3Tc@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, daniel.baluta-3arQi8VN3Tc@public.gmane.org, mihai.serban-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4458: Add bindings for AK4458 DAC

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 17e2304f0ad31d3f9bba4285b7024bf3c3626600 Mon Sep 17 00:00:00 2001
From: Cosmin-Gabriel Samoila <cosmin.samoila-3arQi8VN3Tc@public.gmane.org>
Date: Wed, 14 Feb 2018 15:21:07 +0200
Subject: [PATCH] ASoC: ak4458: Add bindings for AK4458 DAC

Document the bindings for AK4458 DAC

Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/ak4458.txt | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4458.txt

diff --git a/Documentation/devicetree/bindings/sound/ak4458.txt b/Documentation/devicetree/bindings/sound/ak4458.txt
new file mode 100644
index 000000000000..7839be78448d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ak4458.txt
@@ -0,0 +1,23 @@
+AK4458 audio DAC
+
+This device supports I2C mode.
+
+Required properties:
+
+- compatible : "asahi-kasei,ak4458"
+- reg : The I2C address of the device for I2C
+
+Optional properties:
+- reset-gpios: A GPIO specifier for the power down & reset pin
+- mute-gpios: A GPIO specifier for the soft mute pin
+
+Example:
+
+&i2c {
+	ak4458: dac@10 {
+		compatible = "asahi-kasei,ak4458";
+		reg = <0x10>;
+		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>
+		mute-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>
+	};
+};
-- 
2.16.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
