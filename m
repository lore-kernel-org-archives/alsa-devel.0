From: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 2/3] ARM: at91: sama5d3xek/dt: use dt ids for wm8904
Date: Mon, 15 Dec 2014 11:31:12 +0800
Message-ID: <1418614273-2303-2-git-send-email-voice.shen@atmel.com>
References: <1418614273-2303-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418614273-2303-1-git-send-email-voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sound-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Morozov <linux-lCH5ugpmZSMox3rIn2DAYQ@public.gmane.org>, Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Alexander Morozov <linux-lCH5ugpmZSMox3rIn2DAYQ@public.gmane.org>

Using the wm8904 device tree compatible string.

Signed-off-by: Alexander Morozov <linux-lCH5ugpmZSMox3rIn2DAYQ@public.gmane.org>
Signed-off-by: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---

Changes in v2: None

 arch/arm/boot/dts/sama5d3xmb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index 49c10d3..2a1aa58 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -45,7 +45,7 @@
 			 */
 			i2c0: i2c@f0014000 {
 				wm8904: wm8904@1a {
-					compatible = "wm8904";
+					compatible = "wlf,wm8904";
 					reg = <0x1a>;
 					clocks = <&pck0>;
 					clock-names = "mclk";
-- 
2.1.0.24.g4109c28

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
