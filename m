From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 5/5] ARM: tegra: nyan: specify gpio-audio-jack
	device
Date: Fri, 22 May 2015 15:09:23 -0700
Message-ID: <1432332563-15447-6-git-send-email-dgreid@chromium.org>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f201.google.com (mail-ob0-f201.google.com
 [209.85.214.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FC0C2604A4
 for <alsa-devel@alsa-project.org>; Sat, 23 May 2015 00:10:56 +0200 (CEST)
Received: by obcwm4 with SMTP id wm4so1840822obc.0
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 15:10:55 -0700 (PDT)
In-Reply-To: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: lars@metafoo.de, zhengxing@rock-chips.com, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

Model the audio jack as a headset jack using the new gpio-audio-jack
device.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index a9aec23..ec33110 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -1,4 +1,5 @@
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/audio-jack-events.h>
 #include "tegra124.dtsi"
 
 / {
@@ -661,6 +662,23 @@
 		};
 	};
 
+	audio_jack: gpio-audio-jack {
+		compatible = "gpio-audio-jack";
+		gpio-audio-jack,jack-name = "Headset Jack";
+		gpio-audio-jack,sw-det-gpios =
+				<&gpio TEGRA_GPIO(I, 7) GPIO_ACTIVE_HIGH>,
+				<&gpio TEGRA_GPIO(R, 7) GPIO_ACTIVE_LOW>;
+		gpio-audio-jack,gpio-names =
+				"Headphones",
+				"Mic Jack";
+		gpio-audio-jack,report-masks =
+				<JACK_HEADPHONE>,
+				<JACK_MICROPHONE>;
+		gpio-audio-jack,debounce-times =
+				<150>,
+				<150>;
+	};
+
 	sound {
 		nvidia,audio-routing =
 			"Headphones", "HPR",
@@ -674,15 +692,13 @@
 
 		nvidia,i2s-controller = <&tegra_i2s1>;
 		nvidia,audio-codec = <&acodec>;
+		nvidia,headset-dev = <&audio_jack>;
 
 		clocks = <&tegra_car TEGRA124_CLK_PLL_A>,
 			 <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
 			 <&tegra_car TEGRA124_CLK_EXTERN1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 
-		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(I, 7) GPIO_ACTIVE_HIGH>;
-		nvidia,mic-det-gpios =
-				<&gpio TEGRA_GPIO(R, 7) GPIO_ACTIVE_HIGH>;
 	};
 
 	gpio-restart {
-- 
2.2.1.62.g3f15098
