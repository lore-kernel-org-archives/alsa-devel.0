From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 5/7] arm64: dts: allwinner: Add SPDIF node
 for Allwinner H6
Date: Mon, 27 May 2019 22:06:25 +0200
Message-ID: <20190527200627.8635-6-peron.clem@gmail.com>
References: <20190527200627.8635-1-peron.clem@gmail.com>
Reply-To: peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCELXIX7UICBBK4IWHTQKGQEGP3OPXA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190527200627.8635-1-peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The Allwinner H6 has a SPDIF controller called OWA (One Wire Audio).

Only one pinmuxing is available so set it as default.

Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot=
/dts/allwinner/sun50i-h6.dtsi
index f4ea596c82ce..e0ca23704719 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -83,6 +83,24 @@
 		method =3D "smc";
 	};
=20
+	sound-spdif {
+		compatible =3D "simple-audio-card";
+		simple-audio-card,name =3D "On-board SPDIF";
+
+		simple-audio-card,cpu {
+			sound-dai =3D <&spdif>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai =3D <&spdif_out>;
+		};
+	};
+
+	spdif_out: spdif-out {
+		#sound-dai-cells =3D <0>;
+		compatible =3D "linux,spdif-dit";
+	};
+
 	timer {
 		compatible =3D "arm,armv8-timer";
 		interrupts =3D <GIC_PPI 13
@@ -273,6 +291,11 @@
 				bias-pull-up;
 			};
=20
+			spdif_tx_pin: spdif-tx-pin {
+				pins =3D "PH7";
+				function =3D "spdif";
+			};
+
 			uart0_ph_pins: uart0-ph-pins {
 				pins =3D "PH0", "PH1";
 				function =3D "uart0";
@@ -402,6 +425,21 @@
 			};
 		};
=20
+		spdif: spdif@5093000 {
+			#sound-dai-cells =3D <0>;
+			compatible =3D "allwinner,sun50i-h6-spdif";
+			reg =3D <0x05093000 0x400>;
+			interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&ccu CLK_BUS_SPDIF>, <&ccu CLK_SPDIF>;
+			clock-names =3D "apb", "spdif";
+			resets =3D <&ccu RST_BUS_SPDIF>;
+			dmas =3D <&dma 2>;
+			dma-names =3D "tx";
+			pinctrl-names =3D "default";
+			pinctrl-0 =3D <&spdif_tx_pin>;
+			status =3D "disabled";
+		};
+
 		usb2otg: usb@5100000 {
 			compatible =3D "allwinner,sun50i-h6-musb",
 				     "allwinner,sun8i-a33-musb";
--=20
2.20.1

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/20190527200627.8635-6-peron.clem%40gmail.com.
For more options, visit https://groups.google.com/d/optout.
