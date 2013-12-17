From: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCHv3 2/7] ARM: dts: Add Freescale SAI ALSA SoC Digital Audio Interface node for VF610.
Date: Tue, 17 Dec 2013 11:24:39 +0800
Message-ID: <1387250684-23406-3-git-send-email-Li.Xiubo@freescale.com>
References: <1387250684-23406-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387250684-23406-1-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org
Cc: r64188-KZfg59tc24xl57MIdRCFDg@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org, oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch adds the SAI's edma mux Tx and Rx support.

Signed-off-by: Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 arch/arm/boot/dts/vf610.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index e84d84c..2d6ddd0 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -166,6 +166,9 @@
 				interrupts = <0 86 0x04>;
 				clocks = <&clks VF610_CLK_SAI2>;
 				clock-names = "sai";
+				dma-names = "tx", "rx";
+				dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
+					<&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
 				status = "disabled";
 			};
 
-- 
1.8.4


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
