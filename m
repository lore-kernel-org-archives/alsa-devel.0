From: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv8][ 5/5] ARM: dts: mbimxsd53: Add sound support.
Date: Wed, 27 Nov 2013 16:54:24 +0100
Message-ID: <1385567664-758-5-git-send-email-denis@eukrea.com>
References: <1385567664-758-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385567664-758-1-git-send-email-denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Eric B=C3=A9nard <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
---
ChangeLog v7->v8:
- New patch.
---
 .../boot/dts/imx53-eukrea-mbimxsd53-baseboard.dts  |   43 ++++++++++++=
++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard.dts b/a=
rch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard.dts
index 95929aa..b14cc3d 100644
--- a/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard.dts
+++ b/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard.dts
@@ -51,8 +51,21 @@
 		regulator-max-microvolt =3D <3300000>;
 		regulator-always-on;
 	};
+
+	sound {
+		compatible =3D "eukrea,asoc-tlv320";
+		eukrea,model =3D "imx53-eukrea-tlv320aic23";
+		ssi-controller =3D <&ssi2>;
+		fsl,mux-int-port =3D <2>;
+		fsl,mux-ext-port =3D <4>;
+	};
 };
=20
+&audmux {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_audmux>;
+	status =3D "okay";
+};
=20
 &esdhc1 {
 	pinctrl-names =3D "default";
@@ -63,8 +76,28 @@
 	status =3D "okay";
 };
=20
+&i2c2 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_i2c2>;
+	status =3D "okay";
+
+	tlv320aic23: codec@1a {
+		compatible =3D "ti,tlv320aic23";
+		clocks =3D <&clks IMX5_CLK_SSI_EXT1_GATE>;
+		reg =3D <0x1a>;
+	};
+};
+
 &iomuxc {
 	imx53-eukrea {
+		pinctrl_hog: hoggrp {
+			fsl,pins =3D <MX53_PAD_PATA_DA_0__GPIO7_6 0x80000000>;
+		};
+
+		pinctrl_audmux: audmuxgrp {
+			fsl,pins =3D <MX53_AUDMUX_PINGRP2>;
+		};
+
 		pinctrl_esdhc1: esdhc1 {
 			fsl,pins =3D <MX53_ESDHC1_PINGRP1>;
 		};
@@ -81,6 +114,10 @@
 			fsl,pins =3D <MX53_PAD_KEY_ROW4__GPIO4_15 0x80000000>;
 		};
=20
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins =3D <MX53_I2C2_PINGRP1>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins =3D <MX53_UART1_PINGRP2>;
 		};
@@ -91,6 +128,12 @@
 	};
 };
=20
+&ssi2 {
+	codec-handle =3D <&tlv320aic23>;
+	fsl,mode =3D "i2s-slave";
+	status =3D "okay";
+};
+
 &uart1 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_uart1>;
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
