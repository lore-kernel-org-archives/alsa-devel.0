Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 671722610AE
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 15:52:59 +0200 (CEST)
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
 by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id s76DqwIl006582
 for <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:58 -0500
Received: from DLEE71.ent.ti.com (dlee71.ent.ti.com [157.170.170.114])
 by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id s76DqwOH003479
 for <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:58 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])	by
 dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id s76DqvFH026362	for
 <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:58 -0500
From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 6 Aug 2014 16:52:44 +0300
Message-ID: <d4658f1184b0838ebc4b358333d9e303d0fda4b1.1407332062.git.jsarha@ti.com>
In-Reply-To: <cover.1407332062.git.jsarha@ti.com>
References: <cover.1407332062.git.jsarha@ti.com>
MIME-Version: 1.0
Subject: [alsa-devel] [PATCH 7/9] ARM: dts: am335x-boneblack: Add HDMI audio
	support
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-ID: <alsa-devel@alsa-project.org>

Adds mcasp0_pins, clk_mcasp0_fixed, clk_mcasp0, mcasp0, hdmi_audio,
and sound nodes.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am335x-boneblack.dts |   54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 305975d..c3c4618 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -59,12 +59,50 @@
 			0x1b0 0x03      /* xdma_event_intr0, OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
 		>;
 	};
+
+	mcasp0_pins: mcasp0_pins {
+		pinctrl-single,pins = <
+			0x1ac (PIN_INPUT_PULLUP | MUX_MODE0)	/* mcasp0_ahclkx.mcasp0_ahclkx */
+			0x19c (PIN_OUTPUT_PULLDOWN | MUX_MODE2) /* mcasp0_ahclkr.mcasp0_axr2 */
+			0x194 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* mcasp0_fsx.mcasp0_fsx */
+			0x190 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclkx */
+			0x06c (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a11.GPIO1_27 */
+		>;
+	};
 };
 
 &lcdc {
 	status = "okay";
 };
 
+&mcasp0	{
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcasp0_pins>;
+	status = "okay";
+	op-mode = <0>;	/* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	serial-dir = <	/* 0: INACTIVE, 1: TX, 2: RX */
+			0 0 1 0
+		>;
+	tx-num-evt = <1>;
+	rx-num-evt = <1>;
+};
+
+&ext_clocks {
+	clk_mcasp0_fixed: clk_mcasp0_fixed {
+	      #clock-cells = <0>;
+	      compatible = "fixed-clock";
+	      clock-frequency = <24576000>;
+	};
+
+	clk_mcasp0: clk_mcasp0 {
+	      #clock-cells = <0>;
+	      compatible = "gpio-clock";
+	      clocks = <&clk_mcasp0_fixed>;
+	      enable-gpios = <&gpio1 27 0>; /* BeagleBone Black Clk enable on GPIO1_27 */
+	};
+};
+
 / {
 	hdmi {
 		compatible = "ti,tilcdc,slave";
@@ -74,4 +112,20 @@
 		pinctrl-1 = <&nxp_hdmi_bonelt_off_pins>;
 		status = "okay";
 	};
+
+	hdmi_audio: hdmi_audio@0 {
+	       compatible = "linux,hdmi-audio";
+	       status = "okay";
+	};
+
+	sound {
+		compatible = "ti,am335x-beaglebone-black-audio";
+		ti,model = "TI BeagleBone Black";
+		ti,audio-codec = <&hdmi_audio>;
+		ti,mcasp-controller = <&mcasp0>;
+		ti,audio-routing =
+			"HDMI Out",	"TX";
+		clocks = <&clk_mcasp0>;
+		clock-names = "mclk";
+	};
 };
-- 
1.7.9.5

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
