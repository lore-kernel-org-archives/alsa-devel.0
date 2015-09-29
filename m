From: Caleb Crome <caleb@crome.org>
Subject: Re: Kernel Device Tree entries for simple-audio-card
Date: Mon, 28 Sep 2015 23:42:35 -0700
Message-ID: <CAG5mAdyOSDt7F5czW_9EBvo3uBCW9834-1VZsXG0mvYiB1LM8g@mail.gmail.com>
References: <4D7C68FE-B884-489C-91DD-395FE7CE181D@latencyzero.com>
 <CAG5mAdxc5-UuTnz24zByA64ZsrB4qnfMKF57GBVeFfWvY44xsw@mail.gmail.com>
 <4D1E67E6-437D-490D-A577-35EB7E474A3A@latencyzero.com>
 <CAG5mAdxnjZUBiOFU6+MBn0znUCBaGpeVQ-RaYhXch=-4n7J4uw@mail.gmail.com>
 <F3A7E580-2E91-45D0-9C27-2FD190110686@latencyzero.com>
 <CAG5mAdxgTzGjnvwno0D_Jo9_53stmGfsc9OQS05f3thrSFKpkw@mail.gmail.com>
 <BE1F1488-2A4D-4EE6-A538-931DD0B34CD8@latencyzero.com>
 <CAG5mAdzg2BSGKiaBJVSgZvL=9wxffxv_3LMiruS2-kcuTKO+xQ@mail.gmail.com>
 <D8BC8B49-E32C-43EE-B181-60510C7B3E8E@latencyzero.com>
 <CAG5mAdxaAapawiaaR_zasVhQKL33MHEHP1yyUCSLv0wswZ9Law@mail.gmail.com>
 <7CCA3F5A-844A-43FF-9A4E-C0A9FB65D926@latencyzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 9491026058D
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 08:42:55 +0200 (CEST)
Received: by wiclk2 with SMTP id lk2so528090wic.1
 for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2015 23:42:55 -0700 (PDT)
In-Reply-To: <7CCA3F5A-844A-43FF-9A4E-C0A9FB65D926@latencyzero.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rick Mann <rmann@latencyzero.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> Could you send me your DTS?

Yes, but I have modified a bit of stuff in the davinci-evm.c to make
my multi-codec setup work right.

I turned off HDMI with this:

commit 7f20ffd56de6921bc5f8e2fee8da75d743d57847
Author: Caleb Crome <caleb@signalessence.com>
Date:   Wed Sep 9 13:33:36 2015 -0700

    turn off hdmi from boneblack

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts
b/arch/arm/boot/dts/am335x-boneblack.dts
index 5c42d25..6335072 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -34,51 +34,9 @@
 };

 &am33xx_pinmux {
- nxp_hdmi_bonelt_pins: nxp_hdmi_bonelt_pins {
- pinctrl-single,pins = <
- 0x1b0 0x03      /* xdma_event_intr0, OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
- 0xa0 0x08       /* lcd_data0.lcd_data0, OMAP_MUX_MODE0 |
AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
- 0xa4 0x08       /* lcd_data1.lcd_data1, OMAP_MUX_MODE0 |
AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
- 0xa8 0x08       /* lcd_data2.lcd_data2, OMAP_MUX_MODE0 |
AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
- 0xac 0x08       /* lcd_data3.lcd_data3, OMAP_MUX_MODE0 |
AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
- 0xb0 0x08       /* lcd_data4.lcd_data4, OMAP_MUX_MODE0 |
AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
- 0xb4 0x08       /* lcd_data5.lcd_data5, OMAP_MUX_MODE0 |
AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
- 0xb8 0x08       /* lcd_data6.lcd_data6, OMAP_MUX_MODE0 |
AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
- 0xbc 0x08       /* lcd_data7.lcd_data7, OMAP_MUX_MODE0 |
AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
- 0xc0 0x08       /* lcd_data8.lcd_data8, OMAP_MUX_MODE0 |
AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
- 0xc4 0x08       /* lcd_data9.lcd_data9, OMAP_MUX_MODE0 |
AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
- 0xc8 0x08       /* lcd_data10.lcd_data10, OMAP_MUX_MODE0 |
AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
- 0xcc 0x08       /* lcd_data11.lcd_data11, OMAP_MUX_MODE0 |
AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
- 0xd0 0x08       /* lcd_data12.lcd_data12, OMAP_MUX_MODE0 |
AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
- 0xd4 0x08       /* lcd_data13.lcd_data13, OMAP_MUX_MODE0 |
AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
- 0xd8 0x08       /* lcd_data14.lcd_data14, OMAP_MUX_MODE0 |
AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
- 0xdc 0x08       /* lcd_data15.lcd_data15, OMAP_MUX_MODE0 |
AM33XX_PIN_OUTPUT | AM33XX_PULL_DISA */
- 0xe0 0x00       /* lcd_vsync.lcd_vsync, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT */
- 0xe4 0x00       /* lcd_hsync.lcd_hsync, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT */
- 0xe8 0x00       /* lcd_pclk.lcd_pclk, OMAP_MUX_MODE0 | AM33XX_PIN_OUTPUT */
- 0xec 0x00       /* lcd_ac_bias_en.lcd_ac_bias_en, OMAP_MUX_MODE0 |
AM33XX_PIN_OUTPUT */
- >;
- };
- nxp_hdmi_bonelt_off_pins: nxp_hdmi_bonelt_off_pins {
- pinctrl-single,pins = <
- 0x1b0 0x03      /* xdma_event_intr0, OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
- >;
- };
-};
-
-&lcdc {
- status = "okay";
 };

 / {
- hdmi {
- compatible = "ti,tilcdc,slave";
- i2c = <&i2c0>;
- pinctrl-names = "default", "off";
- pinctrl-0 = <&nxp_hdmi_bonelt_pins>;
- pinctrl-1 = <&nxp_hdmi_bonelt_off_pins>;
- status = "okay";
- };
 };

 &rtc {



And here's the added bit:

Index: KERNEL/arch/arm/boot/dts/am335x-boneblack.dts
===================================================================
--- KERNEL.orig/arch/arm/boot/dts/am335x-boneblack.dts 2015-09-21
17:23:14.961343604 -0700
+++ KERNEL/arch/arm/boot/dts/am335x-boneblack.dts 2015-09-22
09:35:49.308278239 -0700
@@ -5,11 +5,25 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+
+
+
+/*
+   * MCASP pin mapping
+   *                          ball   BBB
+   * MCASP0_ACLKX             A13    P9.31
+   * MCASP0_AFSX              B13    P9.29
+   * MCASP0_AXR2  (mcasp OUT) C12    P9.28
+   * MCASP0_AXR3  (mcasp IN)  A14    P9.25
+*/
+
 /dts-v1/;

 #include "am33xx.dtsi"
 #include "am335x-bone-common.dtsi"

+
+
 / {
  model = "TI AM335x BeagleBone Black";
  compatible = "ti,am335x-bone-black", "ti,am335x-bone", "ti,am33xx";
@@ -34,9 +48,119 @@
 };

 &am33xx_pinmux {
+ i2c2_pins_default: i2c2_pins_default {
+        pinctrl-single,pins = <
+                0x17c ( PIN_INPUT_PULLUP | MUX_MODE3 ) /* (D17)
uart1_rtsn.I2C2_SCL */
+                0x178 ( PIN_INPUT_PULLUP | MUX_MODE3 ) /* (D18)
uart1_ctsn.I2C2_SDA */
+        >;
+ };
+
+
+ i2c1_pins_default: pinmux_i2c1_pins {
+                       pinctrl-single,pins = <
+                               0x158 0x72      /*
uart1_ctsn.i2c2_sda, SLEWCTRL_SLOW | INPUT_PULLUP | MODE2 */
+                               0x15c 0x72      /*
uart1_rtsn.i2c2_scl, SLEWCTRL_SLOW | INPUT_PULLUP | MODE2 */
+                       >;
+        };
+
+ mcasp_0_pins_default: mcasp_0_pins_default {
+ pinctrl-single,pins = <
+ 0x190 ( PIN_INPUT | MUX_MODE0 ) /* (A13) mcasp0_aclkx.mcasp0_aclkx */
+ 0x194 ( PIN_INPUT | MUX_MODE0 ) /* (B13) mcasp0_fsx.mcasp0_fsx */
+ 0x19c ( PIN_OUTPUT | MUX_MODE2 ) /* (C12) mcasp0_ahclkr.mcasp0_axr2 */
+ 0x1ac ( PIN_INPUT | MUX_MODE2 ) /* (A14) mcasp0_ahclkx.mcasp0_axr3 */
+ >;
+ };
+};
+
+
+&i2c1 {
+ clock-frequency = <100000>;
+ status = "okay";
+ pinctrl-names = "default";
+ pinctrl-0 = <&i2c1_pins_default>;
+ status="okay";
+
+ tlv320aic3x_a: tlv320aic3x@18 {
+ compatible = "ti,tlv320aic3x";
+ reg = <0x18>;
+ tdm-offset = <0>;
+ status = "okay";
+ };
+
+ tlv320aic3x_b: tlv320aic3x@19 {
+ compatible = "ti,tlv320aic3x";
+ reg = <0x19>;
+ tdm-offset = <32>;
+ status = "okay";
+ };
+
+ tlv320aic3x_c: tlv320aic3x@1a {
+ compatible = "ti,tlv320aic3x";
+ reg = <0x1a>;
+ tdm-offset = <64>;
+ status = "okay";
+ };
+
+ tlv320aic3x_d: tlv320aic3x@1b {
+ compatible = "ti,tlv320aic3x";
+ reg = <0x1b>;
+ tdm-offset = <96>;
+ status = "okay";
+ };
+
 };

+&mcasp0 {
+ pinctrl-names = "default";
+ pinctrl-0 = <&mcasp_0_pins_default>;
+ status = "okay";
+
+ op-mode = <0>;          /* MCASP_IIS_MODE */
+ tdm-slots = <16>;
+ num-serializer = <16>;
+ serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+ 0 0 1 2
+ 0 0 0 0
+ 0 0 0 0
+ 0 0 0 0
+ >;
+ tx-num-evt = <1>;
+ rx-num-evt = <1>;
+};
+
+
 / {
+ sound {
+ compatible = "ti,da830-evm-audio";
+ ti,model = "PUPPY-AUDIO";
+ ti,audio-codec = <
+       &tlv320aic3x_a
+       &tlv320aic3x_b
+       &tlv320aic3x_c
+       &tlv320aic3x_d
+       >;
+ ti,mcasp-controller = <&mcasp0>;
+ ti,codec-clock-rate = <12288000>;
+ ti,audio-routing =
+ "Headphone Jack",       "a HPLOUT",
+ "Headphone Jack",       "a HPROUT",
+ "Headphone Jack",       "b HPLOUT",
+ "Headphone Jack",       "b HPROUT",
+ "Headphone Jack",       "c HPLOUT",
+ "Headphone Jack",       "c HPROUT",
+ "Headphone Jack",       "d HPLOUT",
+ "Headphone Jack",       "d HPROUT",
+ "a LINE1L",               "Line In",
+ "a LINE1R",               "Line In",
+ "b LINE1L",               "Line In",
+ "b LINE1R",               "Line In",
+ "c LINE1L",               "Line In",
+ "c LINE1R",               "Line In",
+ "d LINE1L",               "Line In",
+ "d LINE1R",               "Line In";
+ status="okay";
+ };
 };

 &rtc {
