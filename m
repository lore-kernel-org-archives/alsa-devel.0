From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: ak5558: Add bindings for AK5558 ADC" to the asoc tree
Date: Fri, 16 Feb 2018 12:16:19 +0000
Message-ID: <E1emew7-0006lX-7w@debutante>
References: <1517850115-24340-3-git-send-email-daniel.baluta@nxp.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1517850115-24340-3-git-send-email-daniel.baluta-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shengjiu.wang-3arQi8VN3Tc@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, cosmin.samoila-3arQi8VN3Tc@public.gmane.org, daniel.baluta-3arQi8VN3Tc@public.gmane.org, mihai.serban-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak5558: Add bindings for AK5558 ADC

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

>From af0424e44c180d66c2ddfb0a99c52382de8f69f8 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>
Date: Tue, 13 Feb 2018 16:29:34 +0200
Subject: [PATCH] ASoC: ak5558: Add bindings for AK5558 ADC

Document the bindings for AK5558 ADC.

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/ak5558.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt

diff --git a/Documentation/devicetree/bindings/sound/ak5558.txt b/Documentation/devicetree/bindings/sound/ak5558.txt
new file mode 100644
index 000000000000..7d67ca6ced80
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ak5558.txt
@@ -0,0 +1,22 @@
+AK5558 8 channel differential 32-bit delta-sigma ADC
+
+This device supports I2C mode only.
+
+Required properties:
+
+- compatible : "asahi-kasei,ak5558"
+- reg : The I2C address of the device.
+
+Optional properties:
+
+- reset-gpios: A GPIO specifier for the power down & reset pin.
+
+Example:
+
+&i2c {
+	ak5558: adc@10 {
+		compatible = "asahi-kasei,ak5558";
+		reg = <0x10>;
+		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+	};
+};
-- 
2.16.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
