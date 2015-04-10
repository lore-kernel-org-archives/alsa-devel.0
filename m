From: Koro Chen <koro.chen@mediatek.com>
Subject: [RESEND RFC PATCH 1/3] ASoC: mediatek: Add binding
	support for AFE driver
Date: Fri, 10 Apr 2015 16:14:07 +0800
Message-ID: <1428653649-38200-2-git-send-email-koro.chen@mediatek.com>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id D90BD265DA0
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 10:15:02 +0200 (CEST)
In-Reply-To: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: robh+dt@kernel.org, matthias.bgg@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de
Cc: devicetree@vger.kernel.org, koro.chen@mediatek.com, srv_heupstream@mediatek.com, s.hauer@pengutronix.de, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, galak@codeaurora.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Add documentation and header file to support binding of Mediatek's AFE driver

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../devicetree/bindings/sound/mtk-afe-pcm.txt      | 105 +++++++++++++++++++++
 include/dt-bindings/sound/mtk-afe.h                |  36 +++++++
 2 files changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mtk-afe-pcm.txt
 create mode 100644 include/dt-bindings/sound/mtk-afe.h

diff --git a/Documentation/devicetree/bindings/sound/mtk-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mtk-afe-pcm.txt
new file mode 100644
index 0000000..11fc8ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mtk-afe-pcm.txt
@@ -0,0 +1,105 @@
+Mediatek AFE PCM controller
+
+The AFE unit can be illustrated by this figure:
+
+| MEMIF    |      AFE      |     IO     |
+           *****************
+DL1------> *I5           O3* <----I2S--->
+           *I6           O4*
+           *             I3*
+           *             I4*
+           *             O0* <--2ndI2S-->
+           *             O1*
+           *             I0*
+           *             I1*
+AWB<------ *O5             * <--MTKIF--->
+           *O6             *
+VUL<------ *O9             * <---HDMI--->
+           *O10            *
+           *      AFE      *
+HDMI-----> * inter-connect *
+           *****************
+AFE comprises several memory interfaces (DL1, DL2, VUL, DAI, AWB, MOD_DAI
+and HDMI) that communicate with CPU, a multi input multi output digital audio
+interconnect, and several external interfaces (I2S, proprietary MTKIF, HDMI).
+Each external interface (called "IO" in this driver) is presented as a
+DAI to ASoC. An IO must be connected via the interconnect to a memif.
+The connection paths are configured through the device tree.
+
+Required properties:
+- compatible = "mediatek,mt8173-afe-pcm";
+- reg: array of register and sram location and size:
+       <register base address, size>,
+       <sram base address, size>;
+- interrupts: Should contain AFE interrupt
+- clock-names: should have these clock names:
+		"infra_sys_audio_clk",
+		"top_pdn_audio",
+		"top_pdn_aud_intbus",
+		"bck0",
+		"bck1",
+		"i2s0_m",
+		"i2s1_m",
+		"i2s2_m",
+		"i2s3_m",
+		"i2s3_b";
+
+DAI subnodes:
+  A DAI subnode describes which io connects to which memif.
+
+Required subnode properties:
+- io: which I/O to be used
+      (defined in include/dt-bindings/sound/mtk-afe.h)
+- connections: AFE connection pairs definition of this dai
+	       For example, <5 3 6 4> means I5->O3, I6->O4
+	       check SoC datasheet for a complete description
+- mem-interface-playback:
+  mem-interface-capture: property of memif, format is: <memif irq use_sram>;
+	                 memif: which memif to be used
+			        (defined in include/dt-bindings/sound/mtk-afe.h)
+		         irq: which irq to be used
+			      (defined in include/dt-bindings/sound/mtk-afe.h)
+		         use_sram: 1 is yes, 0 is no
+
+  Each DAI should describes at least playback or capture
+
+Example:
+
+	afe: mt8173-afe-pcm@11220000  {
+		compatible = "mediatek,mt8173-afe-pcm";
+		reg = <0 0x11220000 0 0x1000>,
+		      <0 0x11221000 0 0x9000>;
+		interrupts = <GIC_SPI 134 IRQ_TYPE_EDGE_FALLING>;
+		clocks = <&infracfg INFRA_AUDIO>,
+			<&topckgen TOP_AUDIO_SEL>,
+			<&topckgen TOP_AUD_INTBUS_SEL>,
+			<&topckgen TOP_APLL1_DIV0>,
+			<&topckgen TOP_APLL2_DIV0>,
+			<&topckgen TOP_I2S0_M_CK_SEL>,
+			<&topckgen TOP_I2S1_M_CK_SEL>,
+			<&topckgen TOP_I2S2_M_CK_SEL>,
+			<&topckgen TOP_I2S3_M_CK_SEL>,
+			<&topckgen TOP_I2S3_B_CK_SEL>;
+		clock-names = "infra_sys_audio_clk",
+				"top_pdn_audio",
+				"top_pdn_aud_intbus",
+				"bck0",
+				"bck1",
+				"i2s0_m",
+				"i2s1_m",
+				"i2s2_m",
+				"i2s3_m",
+				"i2s3_b";
+		dai@0 {
+			io = <MTK_AFE_IO_I2S>;
+			connections = <5 3 6 4 3 9 4 10>;
+			mem-interface-playback = <MTK_AFE_MEMIF_DL1 MTK_AFE_IRQ_1 1>;
+			mem-interface-capture = <MTK_AFE_MEMIF_VUL MTK_AFE_IRQ_2 0>;
+		};
+
+		dai@1 {
+			io = <MTK_AFE_IO_HDMI>;
+			connections = <36 36 37 37 34 32 35 33 32 34 33 35 30 30 31 31>;
+			mem-interface-playback = <MTK_AFE_MEMIF_HDMI MTK_AFE_IRQ_5 0>;
+		};
+	};
diff --git a/include/dt-bindings/sound/mtk-afe.h b/include/dt-bindings/sound/mtk-afe.h
new file mode 100644
index 0000000..e6da18e
--- /dev/null
+++ b/include/dt-bindings/sound/mtk-afe.h
@@ -0,0 +1,36 @@
+#ifndef __DT_MTK_AFE_H
+#define __DT_MTK_AFE_H
+
+#define MTK_AFE_MEMIF_DL1		0
+#define MTK_AFE_MEMIF_DL2		1
+#define MTK_AFE_MEMIF_VUL		2
+#define MTK_AFE_MEMIF_DAI		3
+#define MTK_AFE_MEMIF_AWB		4
+#define MTK_AFE_MEMIF_MOD_DAI		5
+#define MTK_AFE_MEMIF_HDMI		6
+#define MTK_AFE_MEMIF_NUM		7
+
+#define MTK_AFE_IO_MOD_PCM1		0 /* connection to int main modem */
+#define MTK_AFE_IO_MOD_PCM2		1 /* connection to extrt/int modem */
+#define MTK_AFE_IO_PMIC		2 /* MTKIF for DAC and ADC */
+#define MTK_AFE_IO_I2S			3 /* I2S */
+#define MTK_AFE_IO_2ND_I2S		4 /* 2nd I2S */
+#define MTK_AFE_IO_HW_GAIN1		5 /* HW gain control */
+#define MTK_AFE_IO_HW_GAIN2		6
+#define MTK_AFE_IO_MRG_O		7 /* merge interface */
+#define MTK_AFE_IO_MRG_I		8
+#define MTK_AFE_IO_DAIBT		9
+#define MTK_AFE_IO_HDMI		10
+#define MTK_AFE_IO_NUM			11
+
+#define MTK_AFE_IRQ_1			0
+#define MTK_AFE_IRQ_2			1
+#define MTK_AFE_IRQ_3			2
+#define MTK_AFE_IRQ_4			3
+#define MTK_AFE_IRQ_5			4
+#define MTK_AFE_IRQ_6			5
+#define MTK_AFE_IRQ_7			6
+#define MTK_AFE_IRQ_8			7
+#define MTK_AFE_IRQ_NUM			8
+
+#endif /* __DT_MTK_AFE_H */
-- 
1.8.1.1.dirty
