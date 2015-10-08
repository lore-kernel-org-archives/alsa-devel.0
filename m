From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: [PATCH v4 7/8] ARM: dts: rockchip: Add SPDIF optical out on Radxa Rock2 Square
Date: Thu,  8 Oct 2015 15:31:18 +0200
Message-ID: <1444311079-2892-8-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-rockchip@lists.infradead.org
Cc: Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Enable the SPDIF optical output on Radxa Rock2 square boards

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rk3288-rock2-square.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
index bce50cd..1756d04 100644
--- a/arch/arm/boot/dts/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -49,6 +49,20 @@
 		stdout-path = "serial2:115200n8";
 	};
 
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "SPDIF";
+		simple-audio-card,dai-link@1 {  /* S/PDIF - S/PDIF */
+			cpu { sound-dai = <&spdif>; };
+			codec { sound-dai = <&spdif_out>; };
+		};
+	};
+
+	spdif_out: spdif-out {
+		compatible = "linux,spdif-dit";
+		#sound-dai-cells = <0>;
+	};
+
 	vcc_usb_host: vcc-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -136,6 +150,10 @@
 	};
 };
 
+&spdif {
+	status = "okay";
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
2.6.1
