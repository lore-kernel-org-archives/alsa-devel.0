From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand@free-electrons.com>
Subject: [PATCH 11/14] ARM: dts: sun8i: Add analog codec on prcm node
Date: Tue,  4 Oct 2016 11:46:24 +0200
Message-ID: <b845d118ae8443227f8537f539ada0a485ff0ec3.1475571575.git.mylene.josserand@free-electrons.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1475569400.git.mylene.josserand@free-electrons.com>
In-Reply-To: <cover.1475571575.git.mylene.josserand@free-electrons.com>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, maxime.ripard@free-electrons.com, wens@csie.org, mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lee.jones@linaro.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-sunxi@googlegroups.com, thomas.petazzoni@free-electrons.com, mylene.josserand@free-electrons.com, alexandre.belloni@free-electrons.com
List-Id: alsa-devel@alsa-project.org

The analog codec for sun8i used PRCM registers so it should be added
in the device tree as a subnode of the prcm entry.

Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 48fc24f..5197812 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -549,6 +549,13 @@
 				compatible = "allwinner,sun6i-a31-clock-reset";
 				#reset-cells = <1>;
 			};
+
+			codec_analog: codec_analog {
+				compatible = "allwinner,sun8i-codec-analog";
+				interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+				clock-names = "apb", "codec";
+			};
 		};
 
 		cpucfg@01f01c00 {
-- 
2.9.3
