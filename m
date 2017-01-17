From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH v3 4/4] arm: dts: Add support for ES8388 to the
	Radxa Rock 2
Date: Tue, 17 Jan 2017 09:17:05 +0100
Message-ID: <20170117081705.14107-5-romain.perier@collabora.com>
References: <20170117081705.14107-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 1987D26683E
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 09:17:32 +0100 (CET)
In-Reply-To: <20170117081705.14107-1-romain.perier@collabora.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Romain Perier <romain.perier@collabora.com>
List-Id: alsa-devel@alsa-project.org

This commit adds the DT definition of the es8388 i2c device
found at address 0x10. It also adds the definition for connecting
the Rockchip I2S to the es8388 analog output.

This commit is based on the initial work that was done by Sjoerd Simons
<sjoerd.simons@collabora.com> with some improvements.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rk3288-rock2-square.dts | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
index dd3ad2e..82d20fd 100644
--- a/arch/arm/boot/dts/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -86,6 +86,17 @@
 		#sound-dai-cells = <0>;
 	};
 
+	sound_es8388 {
+		compatible = "rockchip,rockchip-audio-es8388";
+		rockchip,model = "Analog audio output";
+		rockchip,i2s-controller = <&i2s>;
+		rockchip,audio-codec = <&es8388>;
+		rockchip,hp-en-gpios = <&gpio8 0 GPIO_ACTIVE_HIGH>;
+		rockchip,hp-det-gpios = <&gpio7 7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&headphone>;
+	};
+
 	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&hym8563>;
@@ -173,10 +184,29 @@
 	};
 };
 
+&i2c2 {
+	status = "okay";
+
+	es8388: es8388@10 {
+		compatible = "everest,es8388", "everest,es8328";
+		reg = <0x10>;
+		AVDD-supply = <&vcca_codec>;
+		DVDD-supply = <&vcca_codec>;
+		HPVDD-supply = <&vcca_codec>;
+		PVDD-supply = <&vcca_codec>;
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
@@ -190,6 +220,13 @@
 		};
 	};
 
+	sound {
+		headphone: headphone {
+			rockchip,pins = <8 0 RK_FUNC_GPIO &pcfg_pull_up>,
+					<7 7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	usb {
 		host_vbus_drv: host-vbus-drv {
 			rockchip,pins = <0 14 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.9.3
