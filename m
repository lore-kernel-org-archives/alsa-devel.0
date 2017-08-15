From: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] ASoC: mediatek: Correct the interrupt property
Date: Tue, 15 Aug 2017 16:07:02 +0800
Message-ID: <43a7fb98e7252d0b7b73cdabf1eedd0bf896d68c.1502784169.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Garlic Tseng <garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch update interrupt property since we only use ASYS IRQ
in the driver, and this may confuse people.

Signed-off-by: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
CC: Garlic Tseng <garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
index 9800a56..9d7b6dc 100644
--- a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
+++ b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
@@ -3,7 +3,7 @@ Mediatek AFE PCM controller for mt2701
 Required properties:
 - compatible = "mediatek,mt2701-audio";
 - reg: register location and size
-- interrupts: Should contain AFE interrupt
+- interrupts: Should contain ASYS interrupt
 - power-domains: should define the power domain
 - clock-names: should have these clock names:
 		"infra_sys_audio_clk",
@@ -57,8 +57,7 @@ Example:
 		compatible = "mediatek,mt2701-audio";
 		reg = <0 0x11220000 0 0x2000>,
 		      <0 0x112A0000 0 0x20000>;
-		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
 		clocks = <&infracfg CLK_INFRA_AUDIO>,
 			 <&topckgen CLK_TOP_AUD_MUX1_SEL>,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
