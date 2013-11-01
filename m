From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 2/8] ARM: dts: Add Freescale SAI ALSA SoC Digital Audio Interface node for VF610.
Date: Fri, 1 Nov 2013 15:04:49 +0800
Message-ID: <1383289495-24523-3-git-send-email-Li.Xiubo@freescale.com>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: r65073@freescale.com, timur@tabi.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: r64188@freescale.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, linux@arm.linux.org.uk, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, fabio.estevam@freescale.com, LW@KARO-electronics.de, oskar@scara.com, shawn.guo@linaro.org, b42378@freescale.com, b18965@freescale.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Jingchang Lu <b35083@freescale.com>
List-Id: alsa-devel@alsa-project.org

This patch add the SAI's edma mux Tx and Rx support.

Signed-off-by: Jingchang Lu <b35083@freescale.com>
Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/vf610.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 18e3a4c..391f180 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -151,9 +151,11 @@
 			sai2: sai@40031000 {
 				compatible = "fsl,vf610-sai";
 				reg = <0x40031000 0x1000>;
-				interrupts = <0 86 0x04>;
 				clocks = <&clks VF610_CLK_SAI2>;
 				clock-names = "sai";
+				dma-names = "tx", "rx";
+				dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
+					<&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
 				status = "disabled";
 			};
 
-- 
1.8.4
