From: Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 3/3] MIPS: jz4780: DTS: Probe the jz4740-i2s driver from devicetree
Date: Wed,  6 Jun 2018 21:38:10 +0200
Message-ID: <20180606193811.16007-3-malat@debian.org>
References: <20180606193811.16007-1-malat@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606193811.16007-1-malat@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <jhogan@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since commit 967beb2e8777 ("ASoC: jz4740: Add jz4780 support"), jz4740-i2s
driver supports jz4780 hardware. Use proper compatible string.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index ae57976bc016..308079ee8dd3 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -57,6 +57,18 @@
 		clock-names = "rtc";
 	};
 
+	i2s: i2s@10020000 {
+		compatible = "ingenic,jz4780-i2s";
+		reg = <0x10020000 0x94>;
+
+		clocks = <&cgu JZ4780_CLK_AIC>, <&cgu JZ4780_CLK_I2SPLL>;
+		clock-names = "aic", "i2s";
+
+		dmas = <&dma 0 JZ4780_DMA_I2S0_RX 0xffffffff>,
+		       <&dma JZ4780_DMA_I2S0_TX 0 0xffffffff>;
+		dma-names = "rx" , "tx";
+	};
+
 	pinctrl: pin-controller@10010000 {
 		compatible = "ingenic,jz4780-pinctrl";
 		reg = <0x10010000 0x600>;
-- 
2.11.0
