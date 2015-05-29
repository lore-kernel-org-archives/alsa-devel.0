From: gianluca <gianlucarenzi@eurekelettronica.it>
Subject: Still have problems/issues using SGTL5000 with i.MX28
	CPU
Date: Fri, 29 May 2015 09:55:55 +0200
Message-ID: <55681B8B.6010700@eurekelettronica.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx3.acantho.net (mx3.acantho.net [213.174.182.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 15C9D260417
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 09:56:15 +0200 (CEST)
Received: (from root@localhost)
 by mx3.acantho.net (8.14.3/8.13.4/Debian-3sarge1) id t4T7uET8005581
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 09:56:14 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: fabio.estevam@freescale.com
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Peter Chen <peter.chen@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello everybody!

I put all those people on Cc: because of I think every guy can be able 
to handle the issue for its side easly.

I started a discussion in FreeScale Community website:

https://community.freescale.com/thread/356362

Basically I designed 4 boards using the IMX28EVK board as reference.
Usually the audio section was a buzzer (pwm), or simply using a SGTL5000 
as playback only.

Now we need to record some sounds as soon as the SGTL5000 has the SAIF1 
line used for caputure (line in / mic in).

In alsamixer I can see all those stuff, and actually it works (for 
example if I bypass the ADC part to listen any MIC or LINE-IN into 
headphones directly) so I can safely exclude some alsa misprogramming 
code or whatever.

I tested my bootlets, barebox bootloader, linux kernel 3.12.1 and Debian 
Wheezy 7.8 in both boards:

* my board (namely EK340)
* IMX28VK board.

Both bootcodes and barebox bootloader are almost the same in both boards 
(some uart definitions differ).

The linux kernel _IS_ the same. The device-tree blob are quite similar:

Here is the IMX28EVK dts:

> /*
>  * Copyright 2012 Freescale Semiconductor, Inc.
>  *
>  * The code contained herein is licensed under the GNU General Public
>  * License. You may obtain a copy of the GNU General Public License
>  * Version 2 or later at the following locations:
>  *
>  * http://www.opensource.org/licenses/gpl-license.html
>  * http://www.gnu.org/copyleft/gpl.html
>  */
>
> /dts-v1/;
> #include "imx28.dtsi"
>
> / {
> 	/*
> 	 * Try to keep the name of the board unique (no slash, underscore,
> 	 * no fancy characters, no spaces, no dots...) in the second
> 	 * field of the model name. It will be used as board name.
> 	 */
> 	model = "Freescale IMX28EVK Evaluation Kit";
> 	compatible = "fsl,imx28-evk", "fsl,imx28";
>
> 	memory {
> 		reg = <0x40000000 0x08000000>;
> 	};
>
> 	apb@80000000 {
> 		apbh@80000000 {
> 			ssp0: ssp@80010000 {
> 				compatible = "fsl,imx28-mmc";
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&mmc0_8bit_pins
> 					&mmc0_sck_cfg>;
> 				bus-width = <8>;
> 				wp-gpios = <&gpio2 12 0>;
> 				vmmc-supply = <&reg_vddio_sd0>;
> 				non-removable;
> 				status = "okay";
> 			};
>
> 			ssp1: ssp@80012000 {
> 				compatible = "fsl,imx28-mmc";
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&mmc1_4bit_pins
> 					&mmc1_cd_cfg &mmc1_sck_cfg>;
> 				bus-width = <4>;
> 				wp-gpios = <&gpio0 28 0>;
> 				vmmc-supply = <&reg_vddio_sd0>;
> 				status = "okay";
> 			};
>
> 			pinctrl@80018000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&hog_pins_a>;
>
> 				hog_pins_a: hog@0 {
> 					reg = <0>;
> 					fsl,pinmux-ids = <
> 						0x20d3 /* MX28_PAD_SSP1_CMD__GPIO_2_13 */
> 						0x20f3 /* MX28_PAD_SSP1_DATA3__GPIO_2_15 */
> 						0x40d3 /* MX28_PAD_ENET0_RX_CLK__GPIO_4_13 */
> 						0x20c3 /* MX28_PAD_SSP1_SCK__GPIO_2_12 */
> 						0x31c3 /* MX28_PAD_PWM3__GPIO_3_28 */
> 						0x31e3 /* MX28_PAD_LCD_RESET__GPIO_3_30 */
> 						0x3083 /* MX28_PAD_AUART2_RX__GPIO_3_8 */
> 						0x3093 /* MX28_PAD_AUART2_TX__GPIO_3_9 */
> 					>;
> 					fsl,drive-strength = <0>;
> 					fsl,voltage = <1>;
> 					fsl,pull-up = <0>;
> 				};
>
> 				rs485_tx_en: rx485-tx-en {
> 					fsl,pinmux-ids = <
> 						0x3053 /* MX28_PAD_AUART1_TX__GPIO_3_5 */
> 					>;
> 					fsl,drive-strength = <0>;
> 					fsl,pull-up = <0>;
> 				};
>
> 				mmc0_8bit_pins: mmc0-8bit@0 {
> 					reg = <0>;
> 					fsl,pinmux-ids = <
> 						0x2000 /* MX28_PAD_SSP0_DATA0__SSP0_D0 */
> 						0x2010 /* MX28_PAD_SSP0_DATA1__SSP0_D1 */
> 						0x2020 /* MX28_PAD_SSP0_DATA2__SSP0_D2 */
> 						0x2030 /* MX28_PAD_SSP0_DATA3__SSP0_D3 */
> 						0x2040 /* MX28_PAD_SSP0_DATA4__SSP0_D4 */
> 						0x2050 /* MX28_PAD_SSP0_DATA5__SSP0_D5 */
> 						0x2060 /* MX28_PAD_SSP0_DATA6__SSP0_D6 */
> 						0x2070 /* MX28_PAD_SSP0_DATA7__SSP0_D7 */
> 						0x2080 /* MX28_PAD_SSP0_CMD__SSP0_CMD */
> 						0x20a0 /* MX28_PAD_SSP0_SCK__SSP0_SCK */
> 					>;
> 					fsl,drive-strength = <1>;
> 					fsl,voltage = <1>;
> 					fsl,pull-up = <1>;
> 				};
>
> 				mmc1_4bit_pins: mmc1-4bit@0 {
> 					reg = <0>;
> 					fsl,pinmux-ids = <
> 						0x0001 /* MX28_PAD_GPMI_D00__SSP1_D0 */
> 						0x0011 /* MX28_PAD_GPMI_D01__SSP1_D1 */
> 						0x0021 /* MX28_PAD_GPMI_D02__SSP1_D2 */
> 						0x0031 /* MX28_PAD_GPMI_D03__SSP1_D3 */
> 						0x0141 /* MX28_PAD_GPMI_RDY0__SSP1_CARD_DETECT */
> 						0x0151 /* MX28_PAD_GPMI_RDY1__SSP1_CMD */
> 						0x0191 /* MX28_PAD_GPMI_WRN__SSP1_SCK */
> 					>;
> 					fsl,drive-strength = <1>;
> 					fsl,voltage = <1>;
> 					fsl,pull-up = <1>;
> 				};
>
> 				mmc1_sck_cfg: mmc1-sck-cfg {
> 					fsl,pinmux-ids = <
> 						0x0191 /* MX28_PAD_GPMI_WRN__SSP1_SCK */
> 					>;
> 					fsl,drive-strength = <1>;
> 					fsl,pull-up = <0>;
> 				};
>
> 				mmc1_cd_cfg: mmc1-cd-cfg {
> 					fsl,pinmux-ids = <
> 						0x0141 /* MX28_PAD_GPMI_RDY0__SSP1_CARD_DETECT */
> 					>;
> 					fsl,pull-up = <0>;
> 				};
>
> 				lcdif_pins_evk: lcdif-evk@0 {
> 					reg = <0>;
> 					fsl,pinmux-ids = <
> 						0x1181 /* MX28_PAD_LCD_RD_E__LCD_VSYNC */
> 						0x1191 /* MX28_PAD_LCD_WR_RWN__LCD_HSYNC */
> 						0x11a1 /* MX28_PAD_LCD_RS__LCD_DOTCLK */
> 						0x11b1 /* MX28_PAD_LCD_CS__LCD_ENABLE */
> 					>;
> 					fsl,drive-strength = <0>;
> 					fsl,voltage = <1>;
> 					fsl,pull-up = <0>;
> 				};
>
> 				usb0_id_pins: usb0id@0 {
> 					reg = <0>;
> 					fsl,pinmux-ids = <
> 						0x3071 /* MX28_PAD_AUART1_RTS__USB0_ID */
> 					>;
> 					fsl,drive-strength = <2>;
> 					fsl,voltage = <1>;
> 					fsl,pull-up = <1>;
> 				};
>
> 			};
>
> 			lcdif@80030000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&lcdif_24bit_pins_a
> 					     &lcdif_pins_evk>;
> 				lcd-supply = <&reg_lcd_3v3>;
> 				display = <&display>;
> 				status = "okay";
>
> 				display: display {
> 					bits-per-pixel = <32>;
> 					bus-width = <24>;
>
> 					display-timings {
> 						native-mode = <&timing0>;
> 						timing0: timing0 {
> 							clock-frequency = <33500000>;
> 							hactive = <800>;
> 							vactive = <480>;
> 							hback-porch = <89>;
> 							hfront-porch = <164>;
> 							vback-porch = <23>;
> 							vfront-porch = <10>;
> 							hsync-len = <10>;
> 							vsync-len = <10>;
> 							hsync-active = <0>;
> 							vsync-active = <0>;
> 							de-active = <1>;
> 							pixelclk-active = <0>;
> 						};
> 					};
> 				};
> 			};
>
> 			can0: can@80032000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&can0_pins_a>;
> 				xceiver-supply = <&reg_can_3v3>;
> 				status = "okay";
> 			};
>
> 			can1: can@80034000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&can1_pins_a>;
> 				xceiver-supply = <&reg_can_3v3>;
> 				status = "okay";
> 			};
> 		};
>
> 		apbx@80040000 {
> 			saif0: saif@80042000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&saif0_pins_a>;
> 				status = "okay";
> 			};
>
> 			saif1: saif@80046000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&saif1_pins_a>;
> 				fsl,saif-master = <&saif0>;
> 				status = "okay";
> 			};
>
> 			lradc@80050000 {
> 				fsl,lradc-touchscreen-wires = <4>;
> 				status = "okay";
> 			};
>
> 			i2c0: i2c@80058000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&i2c0_pins_a>;
> 				clock-frequency = <400000>;
> 				status = "okay";
>
> 				sgtl5000: codec@0a {
> 					compatible = "fsl,sgtl5000";
> 					reg = <0x0a>;
> 					VDDA-supply = <&reg_3p3v>;
> 					VDDIO-supply = <&reg_3p3v>;
> 					clocks = <&saif0>;
> 				};
>
> 				at24@51 {
> 					compatible = "at24,24c32";
> 					pagesize = <32>;
> 					reg = <0x51>;
> 				};
> 			};
>
> 			pwm: pwm@80064000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&pwm2_pins_a>;
> 				status = "okay";
> 			};
>
> 			duart: serial@80074000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&duart_pins_a>;
> 				status = "okay";
> 			};
>
> 			auart0: serial@8006a000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&auart0_pins_a>;
> 				fsl,uart-has-rtscts;
> 				status = "okay";
> 			};
>
> 			auart3: serial@80070000 {
> 				compatible = "fsl,imx28-ekuart";
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&auart3_2pins_b
> 					&rs485_tx_en>;
> 				rs485-rts-active-high;
> 				rts-gpio = <&gpio3 5 0>;
> 				linux,rs485-enabled-at-boot-time;
> 				rs485-rts-delay = <0 0>;
> 				status = "okay";
> 			};
>
> 			usbphy0: usbphy@8007c000 {
> 				status = "okay";
> 			};
>
> 			usbphy1: usbphy@8007e000 {
> 				status = "okay";
> 			};
> 		};
> 	};
>
> 	ahb@80080000 {
> 		usb0: usb@80080000 {
> 			pinctrl-names = "default";
> 			pinctrl-0 = <&usb0_id_pins
> 					&usbphy0_pins_b>;
> 			vbus-supply = <&reg_usb0_vbus>;
> 			dr_mode = "otg";
> 			status = "okay";
> 		};
>
> 		usb1: usb@80090000 {
> 			pinctrl-names = "default";
> 			pinctrl-0 = <&usbphy1_pins_a>;
> 			vbus-supply = <&reg_usb1_vbus>;
> 			dr_mode = "host";
> 			status = "okay";
> 		};
>
> 		mac0: ethernet@800f0000 {
> 			phy-mode = "rmii";
> 			pinctrl-names = "default";
> 			pinctrl-0 = <&mac0_pins_a>;
> 			phy-supply = <&reg_fec_3v3>;
> 			phy-reset-gpios = <&gpio4 13 0>;
> 			phy-reset-duration = <100>;
> 			status = "okay";
> 		};
>
> 		mac1: ethernet@800f4000 {
> 			phy-mode = "rmii";
> 			pinctrl-names = "default";
> 			pinctrl-0 = <&mac1_pins_a>;
> 			status = "okay";
> 		};
> 	};
>
> 	regulators {
> 		compatible = "simple-bus";
>
> 		reg_3p3v: 3p3v {
> 			compatible = "regulator-fixed";
> 			regulator-name = "3P3V";
> 			regulator-min-microvolt = <3300000>;
> 			regulator-max-microvolt = <3300000>;
> 			regulator-always-on;
> 		};
>
> 		reg_vddio_sd0: vddio-sd0 {
> 			compatible = "regulator-fixed";
> 			regulator-name = "vddio-sd0";
> 			regulator-min-microvolt = <3300000>;
> 			regulator-max-microvolt = <3300000>;
> 			gpio = <&gpio3 28 0>;
> 		};
>
> 		reg_fec_3v3: fec-3v3 {
> 			compatible = "regulator-fixed";
> 			regulator-name = "fec-3v3";
> 			regulator-min-microvolt = <3300000>;
> 			regulator-max-microvolt = <3300000>;
> 			gpio = <&gpio2 15 0>;
> 		};
>
> 		reg_usb0_vbus: usb0_vbus {
> 			compatible = "regulator-fixed";
> 			regulator-name = "usb0_vbus";
> 			regulator-min-microvolt = <5000000>;
> 			regulator-max-microvolt = <5000000>;
> 			gpio = <&gpio3 9 0>;
> 			enable-active-high;
> 		};
>
> 		reg_usb1_vbus: usb1_vbus {
> 			compatible = "regulator-fixed";
> 			regulator-name = "usb1_vbus";
> 			regulator-min-microvolt = <5000000>;
> 			regulator-max-microvolt = <5000000>;
> 			gpio = <&gpio3 8 0>;
> 			enable-active-high;
> 		};
>
> 		reg_lcd_3v3: lcd-3v3 {
> 			compatible = "regulator-fixed";
> 			regulator-name = "lcd-3v3";
> 			regulator-min-microvolt = <3300000>;
> 			regulator-max-microvolt = <3300000>;
> 			gpio = <&gpio3 30 0>;
> 			enable-active-high;
> 		};
>
> 		reg_can_3v3: can-3v3 {
> 			compatible = "regulator-fixed";
> 			regulator-name = "can-3v3";
> 			regulator-min-microvolt = <3300000>;
> 			regulator-max-microvolt = <3300000>;
> 			gpio = <&gpio2 13 0>;
> 			enable-active-high;
> 		};
>
> 	};
>
> 	sound {
> 		compatible = "fsl,imx28-evk-sgtl5000",
> 			     "fsl,mxs-audio-sgtl5000";
> 		model = "imx28-evk-sgtl5000";
> 		saif-controllers = <&saif0 &saif1>;
> 		audio-codec = <&sgtl5000>;
> 	};
>
> 	backlight {
> 		compatible = "pwm-backlight";
> 		pwms = <&pwm 2 5000000>;
> 		brightness-levels = <0 4 8 16 32 64 128 255>;
> 		default-brightness-level = <6>;
> 	};
> };


and here the EK340 dts:

> /*
>  * Copyright 2014 Eurek Elettronica S.r.l.
>  *
>  * The code contained herein is licensed under the GNU General Public
>  * License. You may obtain a copy of the GNU General Public License
>  * Version 2 or later at the following locations:
>  *
>  * http://www.opensource.org/licenses/gpl-license.html
>  * http://www.gnu.org/copyleft/gpl.html
>  */
>
> /dts-v1/;
> #include "imx28.dtsi"
>
> / {
> 	model = "Eurek EK340 i.MX286";
> 	compatible = "eurek,ek340", "fsl,imx28";
>
> 	memory {
> 		reg = <0x40000000 0x08000000>;
> 	};
>
> 	apb@80000000 {
> 		apbh@80000000 {
> 			ssp0: ssp@80010000 {
> 				compatible = "fsl,imx28-mmc";
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&mmc0_8bit_pins
> 					&mmc0_sck_cfg>;
> 				bus-width = <8>;
> 				vmmc-supply = <&reg_3p3v>;
> 				non-removable;
> 				status = "okay";
> 			};
>
> 			ssp1: ssp@80012000 {
> 				compatible = "fsl,imx28-mmc";
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&mmc1_4bit_pins
> 					&mmc1_cd_cfg &mmc1_sck_cfg>;
> 				bus-width = <4>;
> 				vmmc-supply = <&reg_vddio_sd1>;
> 				status = "okay";
> 			};
>
> 			ssp3: ssp@80016000 {
> 				compatible = "fsl,imx28-sdio";
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&mmc3_4bit_pins
> 					&mmc3_sck_cfg>;
> 				bus-width = <4>;
> 				non-removable;
> 				max-frequency = <25000000>;
> 				status = "okay";
> 			};
>
> 			pinctrl@80018000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&hog_pins_a>;
>
> 				hog_pins_a: hog@0 {
> 					reg = <0>;
> 					fsl,pinmux-ids = <
> 						0x0073 /* MX28_PAD_GPMI_D07__GPIO_0_7 LED */
> 						0x0063 /* MX28_PAD_GPMI_D06__GPIO_0_6 WIFI PWREN */
> 						0x31e3 /* MX28_PAD_LCD_RESET__GPIO_3_30 FACT_RST */
> 						0x2093 /* MX28_PAD_SSP0_DETECT__GPIO_2_9 MMC_nRST */
> 						0x0043 /* MX28_PAD_GPMI_D04__GPIO_0_4 USB0_PWREN */
> 						0x0123 /* MX28_PAD_GPMI_CE2N__GPIO_0_18 USB1_PWREN */
> 						0x3013 /* MX28_PAD_AUART0_TX__GPIO_3_1 ENET_nRST */
> 						0x3003 /* MX28_PAD_AUART0_RX__GPIO_3_0 ENET_INT */
> 						0x0053 /* MX28_PAD_GPMI_D05__GPIO_0_5 LCD_PCI */
> 						0x31b3 /* MX28_PAD_SPDIF__GPIO_3_27 BL_EN (I2C_INT) */
> 						0x2123 /* MX28_PAD_SSP2_MISO__GPIO_2_18 EXT_INT */
> 					>;
> 					fsl,drive-strength = <0>;
> 					fsl,voltage = <1>;
> 					fsl,pull-up = <0>;
> 				};
>
> 				rs485_tx_en: rx485-tx-en {
> 					fsl,pinmux-ids = <
> 						0x2133 /* MX28_PAD_SSP2_SS0__GPIO_2_19 UART2_DIR */
> 					>;
> 					fsl,drive-strength = <0>;
> 					fsl,pull-up = <1>;
> 				};
>
> 				powerfail_pin: powerfail-pin {
> 					fsl,pinmux-ids = <
> 						0x0133 /* MX28_PAD_GPMI_CE3N__GPIO_0_19 PWR_FAIL */
> 					>;
> 					fsl,drive-strength = <0>;
> 					fsl,pull-up = <0>;
> 				};
>
> 				mmc0_8bit_pins: mmc0-8bit@0 {
> 					reg = <0>;
> 					fsl,pinmux-ids = <
> 						0x2000 /* MX28_PAD_SSP0_DATA0__SSP0_D0 */
> 						0x2010 /* MX28_PAD_SSP0_DATA1__SSP0_D1 */
> 						0x2020 /* MX28_PAD_SSP0_DATA2__SSP0_D2 */
> 						0x2030 /* MX28_PAD_SSP0_DATA3__SSP0_D3 */
> 						0x2040 /* MX28_PAD_SSP0_DATA4__SSP0_D4 */
> 						0x2050 /* MX28_PAD_SSP0_DATA5__SSP0_D5 */
> 						0x2060 /* MX28_PAD_SSP0_DATA6__SSP0_D6 */
> 						0x2070 /* MX28_PAD_SSP0_DATA7__SSP0_D7 */
> 						0x2080 /* MX28_PAD_SSP0_CMD__SSP0_CMD */
> 						0x20a0 /* MX28_PAD_SSP0_SCK__SSP0_SCK */
> 					>;
> 					fsl,drive-strength = <1>;
> 					fsl,voltage = <1>;
> 					fsl,pull-up = <1>;
> 				};
>
> 				mmc1_4bit_pins: mmc1-4bit@0 {
> 					reg = <0>;
> 					fsl,pinmux-ids = <
> 						0x0001 /* MX28_PAD_GPMI_D00__SSP1_D0 */
> 						0x0011 /* MX28_PAD_GPMI_D01__SSP1_D1 */
> 						0x0021 /* MX28_PAD_GPMI_D02__SSP1_D2 */
> 						0x0031 /* MX28_PAD_GPMI_D03__SSP1_D3 */
> 						0x0141 /* MX28_PAD_GPMI_RDY0__SSP1_CARD_DETECT */
> 						0x0151 /* MX28_PAD_GPMI_RDY1__SSP1_CMD */
> 						0x0191 /* MX28_PAD_GPMI_WRN__SSP1_SCK */
> 					>;
> 					fsl,drive-strength = <1>;
> 					fsl,voltage = <1>;
> 					fsl,pull-up = <1>;
> 				};
>
> 				mmc1_sck_cfg: mmc1-sck-cfg {
> 					fsl,pinmux-ids = <
> 						0x0191 /* MX28_PAD_GPMI_WRN__SSP1_SCK */
> 					>;
> 					fsl,drive-strength = <2>;
> 					fsl,pull-up = <0>;
> 				};
>
> 				mmc1_cd_cfg: mmc1-cd-cfg {
> 					fsl,pinmux-ids = <
> 						0x0141 /* MX28_PAD_GPMI_RDY0__SSP1_CARD_DETECT */
> 					>;
> 					fsl,pull-up = <0>;
> 				};
>
> 				mmc3_4bit_pins: mmc3-4bit@0 {
> 					reg = <0>;
> 					fsl,pinmux-ids = <
> 						0x0101 /* MX28_PAD_GPMI_CE0N__SSP3_D0 */
> 						0x01a1 /* MX28_PAD_GPMI_ALE__SSP3_D1 */
> 						0x01b1 /* MX28_PAD_GPMI_CLE__SSP3_D2 */
> 						0x0111 /* MX28_PAD_GPMI_CE1N__SSP3_D3 */
> 						0x01c1 /* MX28_PAD_GPMI_RESETN__SSP3_CMD */
> 						0x0181 /* MX28_PAD_GPMI_RDN__SSP3_SCK */
> 					>;
> 					fsl,drive-strength = <1>;
> 					fsl,voltage = <1>;
> 					fsl,pull-up = <1>;
> 				};
>
> 				mmc3_sck_cfg: mmc3-sck-cfg {
> 					fsl,pinmux-ids = <
> 						0x0181 /* MX28_PAD_GPMI_RDN__SSP3_SCK */
> 					>;
> 					fsl,drive-strength = <2>;
> 					fsl,pull-up = <0>;
> 				};
>
> 				usb0_id_pins_b: usb0_id@1 {
> 					reg = <0>;
> 					fsl,pinmux-ids = <
> 						0x3121 /* MX28_PAD_PWM2__USB0_ID */
> 					>;
> 					fsl,drive-strength = <2>;
> 					fsl,voltage = <1>;
> 					fsl,pull-up = <1>;
> 				};
>
> 				lcdif_pins_ek340: lcdif-ek340@0 {
> 					reg = <0>;
> 					fsl,pinmux-ids = <
> 						0x1181 /* MX28_PAD_LCD_RD_E__LCD_VSYNC */
> 						0x1191 /* MX28_PAD_LCD_WR_RWN__LCD_HSYNC */
> 						0x11a1 /* MX28_PAD_LCD_RS__LCD_DOTCLK */
> 						0x11b1 /* MX28_PAD_LCD_CS__LCD_ENABLE */
> 					>;
> 					fsl,drive-strength = <0>;
> 					fsl,voltage = <1>;
> 					fsl,pull-up = <0>;
> 				};
> 			};
>
> 			lcdif@80030000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&lcdif_24bit_pins_a
> 					     &lcdif_pins_ek340>;
> 				lcd-supply = <&reg_lcd_3v3>;
>
> 				display = <&display16>;
> 				status = "okay";
>
> 				display16: display16 {
> 					bits-per-pixel = <16>;
> 					bus-width = <16>;
>
> 					display-timings {
> 						native-mode = <&lms700kf23>;
>
> 						/* DISPLAY 800x480 SAMSUNG LMS700KF23 */
> 						lms700kf23: lms700kf23 {
> 							clock-frequency = <24500000>;
> 							hactive = <800>;
> 							vactive = <480>;
> 							hback-porch = <16>;
> 							hfront-porch = <8>;
> 							vback-porch = <8>;
> 							vfront-porch = <5>;
> 							hsync-len = <1>;
> 							vsync-len = <1>;
> 							hsync-active = <0>;
> 							vsync-active = <0>;
> 							de-active = <1>;
> 							pixelclk-active = <0>;
> 						};
>
> 						/* DISPLAY 480x272 AMPIRE AM-480272Q */
> 						am480272q: am480272q {
> 							clock-frequency = <9200000>;
> 							hactive = <480>;
> 							vactive = <272>;
> 							hback-porch = <43>;
> 							hfront-porch = <8>;
> 							vback-porch = <12>;
> 							vfront-porch = <4>;
> 							hsync-len = <10>;
> 							vsync-len = <41>;
> 							hsync-active = <0>;
> 							vsync-active = <0>;
> 							de-active = <1>;
> 							pixelclk-active = <0>;
> 						};
> 						/* DISPLAY 1024x600 AMPIRE AM-1024600LTM LVDS */
> 						am1024600l: am1024600l {
> 							clock-frequency = <51200000>;
> 							hactive = <1024>;
> 							vactive = <600>;
> 							hback-porch = <0>;
> 							hfront-porch = <320>;
> 							vback-porch = <0>;
> 							vfront-porch = <35>;
> 							hsync-len = <1>;
> 							vsync-len = <1>;
> 							hsync-active = <0>;
> 							vsync-active = <0>;
> 							de-active = <1>;
> 							pixelclk-active = <0>;
> 						};
> 					};
> 				};
>
> 				display24: display24 {
> 					bits-per-pixel = <32>;
> 					bus-width = <24>;
> 					/* Timings for 24bit display go here... */
> 				};
>
> 			};
>
> 			can0: can@80032000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&can0_pins_a>;
> 				xceiver-supply = <&reg_3p3v>;
> 				status = "okay";
> 			};
> 		};
>
>
> 		apbx@80040000 {
> 			saif0: saif@80042000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&saif0_pins_a>;
> 				status = "okay";
> 			};
>
> 			saif1: saif@80046000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&saif1_pins_a>;
> 				fsl,saif-master = <&saif0>;
> 				status = "okay";
> 			};
>
> 			lradc@80050000 {
> 				fsl,lradc-touchscreen-wires = <4>;
> 				status = "okay";
> 			};
>
> 			i2c0: i2c@80058000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&i2c0_pins_a>;
> 				clock-frequency = <400000>;
> 				status = "okay";
>
> 				sgtl5000: codec@0a {
> 					compatible = "fsl,sgtl5000";
> 					reg = <0x0a>;
> 					VDDA-supply = <&reg_3p3v>;
> 					VDDIO-supply = <&reg_3p3v>;
> 					clocks = <&saif0>;
> 				};
>
> 				at24@50 {
> 					compatible = "at24,24c64";
> 					pagesize = <64>;
> 					reg = <0x50>;
> 				};
>
> 				pcf8563: rtc@51 {
> 					compatible = "phg,pcf8563";
> 					reg = <0x51>;
> 				};
>
> /*
>  * ------------------------------------------------
>  * There is no need to bind those devices to Linux
>  * Kernel space. They are usable with i2c tools and
>  * custom i2c userspace drivers anyway.
>  * !! Dangerous !!
>  * ------------------------------------------------
> 				pca9536: pca9536@41 {
> 					compatible = "nxp,pca9536";
> 					gpio-controller;
> 					reg = <0x41>;
> 				};
>
> 				at24@54 {
> 					compatible = "at24,24c64";
> 					pagesize = <64>;
> 					reg = <0x54>;
> 				};
>
> 				lm48100@7c {
> 					compatible = "alsa-volume-ctrl";
> 					volume-controller;
> 					reg = <0x7c>;
> 				};
>  * ------------------------------------------------
>  */
> 			};
>
> 			i2c1: i2c@8005a000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&i2c1_pins_a>;
> 				clock-frequency = <100000>;
> 				status = "okay";
> 			};
>
> 			pwm: pwm@80064000 {
> 				compatible = "imx28-ek-pwm";
> 				reg = <0x80064000 0x2000>;
> 				clocks = <&clks 44>;
> 				#pwm-cells = <2>;
> 				fsl,pwm-number = <8>;
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&pwm4_pins_a
> 					&powerfail_pin>;
> 				powerfail-active-low;
> 				powerfail-gpio = <&gpio0 19 1>;
> 				status = "okay";
> 			};
>
> 			duart: serial@80074000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&duart_pins_b>;
> 				status = "okay";
> 			};
>
> 			auart1: serial@8006c000 {
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&auart1_2pins_a>;
> 				status = "okay";
> 			};
>
> 			auart2: serial@8006e000 {
> 				compatible = "fsl,imx28-ekuart";
> 				pinctrl-names = "default";
> 				pinctrl-0 = <&auart2_2pins_a
> 					&rs485_tx_en>;
> 				rs485-rts-active-low;
> 				rts-gpio = <&gpio2 19 1>;
> 				linux,rs485-enabled-at-boot-time;
> 				rs485-rts-delay = <0 0>;
> 				status = "okay";
> 			};
>
> 			usbphy0: usbphy@8007c000 {
> 				status = "okay";
> 			};
>
> 			usbphy1: usbphy@8007e000 {
> 				status = "okay";
> 			};
> 		};
> 	};
>
> 	ahb@80080000 {
> 		usb0: usb@80080000 {
> 			pinctrl-names = "default";
> 			pinctrl-0 = <&usb0_id_pins_b
> 					&usbphy0_pins_a>;
> 			vbus-supply = <&reg_usb0_vbus>;
> 			dr_mode = "otg";
> 			status = "okay";
> 		};
>
> 		usb1: usb@80090000 {
> 			pinctrl-names = "default";
> 			pinctrl-0 = <&usbphy1_pins_a>;
> 			vbus-supply = <&reg_usb1_vbus>;
> 			dr_mode = "host";
> 			status = "okay";
> 		};
>
> 		mac0: ethernet@800f0000 {
> 			phy-mode = "rmii";
> 			pinctrl-names = "default";
> 			pinctrl-0 = <&mac0_pins_a>;
> 			phy-supply = <&reg_3p3v>;
> 			phy-reset-gpios = <&gpio3 1 0>;
> 			phy-reset-duration = <100>;
> 			status = "okay";
> 		};
> 	};
>
> 	regulators {
> 		compatible = "simple-bus";
>
> 		reg_3p3v: 3p3v {
> 			compatible = "regulator-fixed";
> 			regulator-name = "3P3V";
> 			regulator-min-microvolt = <3300000>;
> 			regulator-max-microvolt = <3300000>;
> 			regulator-always-on;
> 		};
>
> 		reg_vddio_sd1: vddio-sd1 {
> 			compatible = "regulator-fixed";
> 			regulator-name = "vddio-sd1";
> 			regulator-min-microvolt = <3300000>;
> 			regulator-max-microvolt = <3300000>;
> 			gpio = <&gpio3 28 0>;
> 		};
>
> 		reg_usb0_vbus: usb0_vbus {
> 			compatible = "regulator-fixed";
> 			regulator-name = "usb0_vbus";
> 			regulator-min-microvolt = <5000000>;
> 			regulator-max-microvolt = <5000000>;
> 			gpio = <&gpio0 4 0>;
> 			enable-active-low;
> 		};
>
> 		reg_usb1_vbus: usb1_vbus {
> 			compatible = "regulator-fixed";
> 			regulator-name = "usb1_vbus";
> 			regulator-min-microvolt = <5000000>;
> 			regulator-max-microvolt = <5000000>;
> 			gpio = <&gpio0 18 0>;
> 			enable-active-low;
> 		};
>
> 		reg_lcd_3v3: lcd-3v3 {
> 			compatible = "regulator-fixed";
> 			regulator-name = "lcd-3v3";
> 			regulator-min-microvolt = <3300000>;
> 			regulator-max-microvolt = <3300000>;
> 			gpio = <&gpio0 5 0>;
> 			enable-active-high;
> 		};
> 	};
>
> 	sound {
> 		compatible = "fsl,imx28-evk-sgtl5000",
> 			     "fsl,mxs-audio-sgtl5000";
> 		model = "imx28-evk-sgtl5000";
> 		saif-controllers = <&saif0 &saif1>;
> 		audio-codec = <&sgtl5000>;
> 	};
>
> 	backlight {
> 		compatible = "pwm-backlight";
> 		pwms = <&pwm 4 5000000>;
> 		brightness-levels = <0 4 8 16 32 64 128 255>;
> 		default-brightness-level = <6>;
> 	};
>
> };


As you can see the audio section _IS_ almost equal.

In both boards (IMX28EVK and EK340) the VDDD pin is left floating so it 
uses the internal ldo voltage regulator.

In IMX28EVK and in EK340 the VDDIO is from the VDDIO_3V3 from the SoC pin.

In IMX28EVK the VDDA in tied/coupled with a choke (L2 470Ohm) to VDDIO, 
but in EK340 is using an external 3V3 voltage regulator that is 
triggered by VDDIO_3V3 to obtain the 3V3 voltage to the VDDA, so I can 
assume it is _almost_ the same. The same voltage regulator is used as 
power supply to all i2c stuff (RTC, EEPROM, GPIO Expander,...). 
VDDIO_3V3 from Soc is quite limited as current output so I choose to use 
an external 3V3 regulator.

If I run:

> arecord -t wav -d 5 -d hw:0,1 -f S16_LE -c 2 /tmp/sample.wav

in the IMX28EVK it works as expected (I can clearly see I2C lines moving 
and SAIF1 lines moving too...)

in the EK340 I can see the same lines moving (I2C and SAIF1) _BUT_ it 
hangs for 10 seconds and fails with an error:

> arecord: pcm_read:1801: read error: Input/output error

and the only thing it writes it is the WAV HEADER (44 bytes).

I saw all stuff regarding SGTL5000 issues on the FSL Community:

> https://community.freescale.com/thread/300291

> https://community.freescale.com/message/328708#328708

> https://community.freescale.com/thread/307611#331003

and this morning I found this too:

> https://community.freescale.com/message/496426#496426

Now I can check this out too, but I am very UNCONFIDENT it will NO 
USEFUL to me, as in the EVK everything is working, meanwhile in EK340 it 
does not work for record, but only for playback... :-(

Last but not least the boards are different by SoC version:

IMX28EVK is using i.MX287
EK340    is using i.MX286

Any help, clue or whatever I can check and try to find out this problem???

Thank you in advance,

Gianluca Renzi
-- 
Eurek s.r.l.                          |
Electronic Engineering                | http://www.eurek.it
via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212
