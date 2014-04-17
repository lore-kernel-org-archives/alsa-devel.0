From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: [PATCH 3/5] ARM: Kirkwood: DT: Add missing #sound-dai-cells property
Date: Thu, 17 Apr 2014 17:53:12 +0200
Message-ID: <1397749994-24983-4-git-send-email-andrew@lunn.ch>
References: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397749994-24983-1-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The sound node is missing a #sound-dai-cells property. Add it, so that
the sounds node can be used in combination with the simple-audio-card
binding.

Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
---
 arch/arm/boot/dts/kirkwood.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 90384587c278..919d1f7f2eef 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -314,6 +314,7 @@
 
 		audio0: audio-controller@a0000 {
 			compatible = "marvell,kirkwood-audio";
+			#sound-dai-cells = <0>;
 			reg = <0xa0000 0x2210>;
 			interrupts = <24>;
 			clocks = <&gate_clk 9>;
-- 
1.9.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
