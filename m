From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 9/9] arm64: dts: allwinner: a64: Enable sound
	on Pine64 and SoPine
Date: Sun,  3 Dec 2017 12:41:57 -0800
Message-ID: <20171203204157.20829-10-anarsoul@gmail.com>
References: <20171203204157.20829-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 07285267321
 for <alsa-devel@alsa-project.org>; Sun,  3 Dec 2017 21:42:11 +0100 (CET)
Received: by mail-pg0-f66.google.com with SMTP id k15so6746241pgr.7
 for <alsa-devel@alsa-project.org>; Sun, 03 Dec 2017 12:42:11 -0800 (PST)
In-Reply-To: <20171203204157.20829-1-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Marcus Cooper <codekipper@gmail.com>, =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

This commit enables I2S, digital and analog parts of audiocodec on
Pine64 and SoPine boards.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts      | 16 ++++++++++++++++
 .../boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts   | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 806442d3e846..369d9b749521 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -64,6 +64,18 @@
 	};
 };
 
+&codec {
+	status = "okay";
+};
+
+&codec_analog {
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -229,6 +241,10 @@
 	regulator-name = "vcc-rtc";
 };
 
+&sound {
+	status = "okay";
+};
+
 /* On Exp and Euler connectors */
 &uart0 {
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 0eb2acedf8c3..9de5ddcc3656 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -69,6 +69,18 @@
 	};
 };
 
+&codec {
+	status = "okay";
+};
+
+&codec_analog {
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -133,6 +145,10 @@
 	regulator-name = "vcc-wifi";
 };
 
+&sound {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.15.0
