From: Yakir Yang <ykk@rock-chips.com>
Subject: [PATCH 6/6] ARM: dts: rockchip: add hdmi audio nodes
Date: Mon, 15 Dec 2014 10:56:14 +0800
Message-ID: <1418612174-19784-1-git-send-email-ykk@rock-chips.com>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ykk@rock-chips.com
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, Zubair.Kakakhel@imgtec.com, Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, dri-devel@lists.freedesktop.org, Daniel Kurtz <djkurtz@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, Dylan Reid <dgreid@chromium.org>, Xu Jianqun <jay.xu@rock-chips.com>, =?UTF-8?q?St=A8=A6phane=20Marchesin?= <marcheu@chromium.org>, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Max Filippov <jcmvbkbc@gmail.com>, Oder Chiou <oder_chiou@realtek.com>, devicetree@vger.kernel.org, linux-kernel@vger.ker
List-Id: alsa-devel@alsa-project.org

Add hdmi_audio to rk3288.dtsi, enable hdmi_audio in rk3288-evb.dts

Signed-off-by: Yakir Yang <ykk@rock-chips.com>

series-cc: Dominik Behr <dbehr@chromium.org>

---

 arch/arm/boot/dts/rk3288-evb.dtsi | 11 +++++++++++
 arch/arm/boot/dts/rk3288.dtsi     |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 3e067dd..53115d4 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -120,6 +120,17 @@
 	status = "okay";
 };
 
+&i2s {
+	status = "okay";
+	clock-names = "i2s_hclk", "i2s_clk", "i2s_clk_out";
+	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>,
+		 <&cru SCLK_I2S0_OUT>;
+};
+
+&hdmi_audio {
+	status = "okay";
+};
+
 &wdt {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index fd19f00..3eeba16 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -588,6 +588,14 @@
 		interrupts = <GIC_PPI 9 0xf04>;
 	};
 
+	hdmi_audio: hdmi_audio {
+		compatible = "rockchip,rk3288-hdmi-audio";
+		cpu-of-node = <&i2s>;
+		codec-name = "dw-hdmi-audio";
+		codec-dai-name = "dw-hdmi-hifi";
+		status = "disable";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3288-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.1.2
