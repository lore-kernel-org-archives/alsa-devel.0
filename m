From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC 14/17] ARM: omap5-uevm.dts: Add hdmi audio related nodes
Date: Sat, 26 Apr 2014 00:16:52 +0300
Message-ID: <18a1ee24519e560020919bbee64e85aa2d951aa7.1398453425.git.jsarha@ti.com>
References: <cover.1398453425.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1398453425.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Adds a simple-card sound node for HDMI audio, the associated
hdmi-codec node, and sound-dai-cells propeties to the DAI nodes.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap5-uevm.dts |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index f625a87..42d625b 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -561,6 +561,24 @@
 			};
 		};
 	};
+
+	sound@0 {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,cpu {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi_audio>;
+		};
+	};
+
+	hdmi_audio: hdmi_audio@0 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,hdmi-audio";
+		status = "okay";
+	};
 };
 
 &dss {
@@ -568,6 +586,7 @@
 };
 
 &hdmi {
+	#sound-dai-cells = <0>;
 	status = "ok";
 	vdda-supply = <&ldo4_reg>;
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
