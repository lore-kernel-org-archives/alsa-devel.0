From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH 2/2] arm: dts: Add support for ES8323 to the
	Firefly-RK3288
Date: Tue, 17 Jan 2017 10:12:10 +0100
Message-ID: <20170117091210.6837-3-romain.perier@collabora.com>
References: <20170117091210.6837-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id A3DEC266718
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 10:12:26 +0100 (CET)
In-Reply-To: <20170117091210.6837-1-romain.perier@collabora.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: Romain Perier <romain.perier@collabora.com>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This commit adds the DT definition of the es8388 i2c device found at
address 0x10. It also adds the definition for connecting the Rockchip
I2S to the es8388 analog output.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 44935af..bbe2d67 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -103,6 +103,16 @@
 		};
 	};
 
+	sound_es8323 {
+		compatible = "rockchip,rockchip-audio-es8388";
+		rockchip,model = "Analog audio output";
+		rockchip,i2s-controller = <&i2s>;
+		rockchip,audio-codec = <&es8323>;
+		/* tsadc and headphone use the same pins */
+		rockchip,hp-en-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_HIGH>;
+		rockchip,hp-det-gpios = <&gpio7 RK_PB7 GPIO_ACTIVE_HIGH>;
+	};
+
 	vbat_wl: vcc_sys: vsys-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
@@ -371,6 +381,17 @@
 
 &i2c2 {
 	status = "okay";
+
+	es8323: es8323@10 {
+		compatible = "everest,es8323", "everest,es8328";
+		reg = <0x10>;
+		AVDD-supply = <&vcca_33>;
+		DVDD-supply = <&vcca_33>;
+		HPVDD-supply = <&vcca_33>;
+		PVDD-supply = <&vcca_33>;
+		clocks = <&cru SCLK_I2S0_OUT>;
+		clock-names = "i2s_clk_out";
+	};
 };
 
 &i2c4 {
@@ -381,6 +402,10 @@
 	status = "okay";
 };
 
+&i2s {
+	status = "okay";
+};
+
 &io_domains {
 	status = "okay";
 
-- 
2.9.3
