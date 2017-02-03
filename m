From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH v8 4/4] arm: dts: Add support for ES8388 to the
	Radxa Rock 2
Date: Fri,  3 Feb 2017 15:38:00 +0100
Message-ID: <20170203143800.23859-5-romain.perier@collabora.com>
References: <20170203143800.23859-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 714E5266B17
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2017 15:38:16 +0100 (CET)
In-Reply-To: <20170203143800.23859-1-romain.perier@collabora.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Romain Perier <romain.perier@collabora.com>
List-Id: alsa-devel@alsa-project.org

This commit adds the DT definition of the es8388 i2c device
found at address 0x10. It also adds the definition for connecting
the Rockchip I2S to the es8388 analog output.

This commit is based on the initial work that was done by Sjoerd Simons
<sjoerd.simons@collabora.com> with some improvements.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---

Changes in v8: None
Changes in v7:
 - Added a new label for vccio_codec
 - Use vccio_codec instead of vcca_codec
 - Splitted headphone pins into hp_det and phone_ctl 
Changes in v6: None
Changes in v5: None
Changes in v4:
 - Updated to the new DT binding
 - Added the property 'rockchip,routing'
 - Renamed the node sound_es8388 to sound_i2s
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rk3288-rock2-som.dtsi   |  2 +-
 arch/arm/boot/dts/rk3288-rock2-square.dts | 42 +++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-rock2-som.dtsi b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
index b25ba80..c4d320c 100644
--- a/arch/arm/boot/dts/rk3288-rock2-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
@@ -136,7 +136,7 @@
 				regulator-always-on;
 			};
 
-			vcc_io: REG2 {
+			vcc_io: vccio_codec: REG2 {
 				regulator-name = "VCC_IO";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
index dd3ad2e..f693c39 100644
--- a/arch/arm/boot/dts/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -86,6 +86,19 @@
 		#sound-dai-cells = <0>;
 	};
 
+	sound_i2s {
+		compatible = "rockchip,rk3288-hdmi-analog";
+		rockchip,model = "I2S";
+		rockchip,i2s-controller = <&i2s>;
+		rockchip,audio-codec = <&es8388>;
+		rockchip,routing = "Analog", "LOUT2",
+				   "Analog", "ROUT2";
+		rockchip,hp-en-gpios = <&gpio8 0 GPIO_ACTIVE_HIGH>;
+		rockchip,hp-det-gpios = <&gpio7 7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&phone_ctl>, <&hp_det>;
+	};
+
 	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&hym8563>;
@@ -173,10 +186,29 @@
 	};
 };
 
+&i2c2 {
+	status = "okay";
+
+	es8388: es8388@10 {
+		compatible = "everest,es8388", "everest,es8328";
+		reg = <0x10>;
+		AVDD-supply = <&vccio_codec>;
+		DVDD-supply = <&vccio_codec>;
+		HPVDD-supply = <&vccio_codec>;
+		PVDD-supply = <&vccio_codec>;
+		clocks = <&cru SCLK_I2S0_OUT>;
+		clock-names = "i2s_clk_out";
+	};
+};
+
 &i2c5 {
 	status = "okay";
 };
 
+&i2s {
+	status = "okay";
+};
+
 &pinctrl {
 	ir {
 		ir_int: ir-int {
@@ -190,6 +222,16 @@
 		};
 	};
 
+	headphone {
+		hp_det: hp-det {
+			rockchip,pins = <7 7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		phone_ctl: phone-ctl {
+			rockchip,pins = <8 0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	usb {
 		host_vbus_drv: host-vbus-drv {
 			rockchip,pins = <0 14 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.9.3
