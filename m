From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v3 5/6] ARM: dts: sun6i: hummingbird: Enable internal audio codec
Date: Mon,  7 Nov 2016 18:07:02 +0800
Message-ID: <20161107100703.5586-6-wens@csie.org>
References: <20161107100703.5586-1-wens@csie.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161107100703.5586-1-wens-jdAy2FN1RRM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The Hummingbird A31 has headset and line in audio jacks and an onboard
mic routed to the pins for the SoC's internal codec. The line out pins
are routed to an onboard speaker amp, whose output is available on a
pin header.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 9a74637f677f..4e0516026596 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -69,6 +69,19 @@
 	};
 };
 
+&codec {
+	allwinner,audio-routing =
+		"Headphone", "HP",
+		"Speaker", "LINEOUT",
+		"LINEIN", "Line In",
+		"MIC1", "Mic",
+		"MIC2", "Headset Mic",
+		"Mic",	"MBIAS",
+		"Headset Mic", "HBIAS";
+	allwinner,pa-gpios = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&reg_dcdc3>;
 };
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
