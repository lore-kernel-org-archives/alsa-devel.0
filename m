From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC 5/5] DT: sti: add audio HDMI dai link in audio
	card
Date: Mon, 21 Sep 2015 15:19:56 +0200
Message-ID: <1442841596-1323-6-git-send-email-arnaud.pouliquen@st.com>
References: <1442841596-1323-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 6EDC126147A
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 15:21:20 +0200 (CEST)
In-Reply-To: <1442841596-1323-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: moinejf@free.fr, linux@arm.linux.org.uk, Takashi Iwai <tiwai@suse.de>, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, airlied@linux.ie, tony@atomide.com, broonie@kernel.org, bcousson@baylibre.com
List-Id: alsa-devel@alsa-project.org

Add the HDMI dai link to support audio for HDMi output

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 arch/arm/boot/dts/stih410.dtsi       |  4 ++--
 arch/arm/boot/dts/stihxxx-b2120.dtsi | 21 +++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig  |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index 7ee7dc0..3881016 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -186,8 +186,9 @@
 							 <&clk_s_d2_quadfs 0>;
 			};
 
-				sti-hdmi@8d04000 {
+				sti_hdmi: sti-hdmi@8d04000 {
 					compatible = "st,stih407-hdmi";
+					#sound-dai-cells = <0>;
 					reg = <0x8d04000 0x1000>;
 					reg-names = "hdmi-reg";
 					interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
@@ -210,7 +211,6 @@
 					reset-names = "hdmi";
 					resets = <&softreset STIH407_HDMI_TX_PHY_SOFTRESET>;
 					ddc = <&hdmiddc>;
-
 				};
 
 				sti-hda@8d02000 {
diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index 3ad9c82..80fed19 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -81,6 +81,9 @@
 		audio_controller: sti-asoc-platform {
 			status = "okay";
 		};
+		sti_uni_player0: sti-uni-player@0 {
+			status = "okay";
+		};
 		sti_uni_player2: sti-uni-player@2 {
 			status = "okay";
 		};
@@ -93,6 +96,12 @@
 		sti_uni_reader1: sti-uni-reader@1 {
 			status = "okay";
 		};
+
+		sti-display-subsystem {
+			sti_hdmi: sti-hdmi@8d04000 {
+				status = "okay";
+			};
+		};
 	};
 
 	sound {
@@ -125,6 +134,18 @@
 				sound-dai = <&sti_sasg_codec 0>;
 			};
 		};
+		simple-audio-card,dai-link@2 {
+			/* HDMI */
+			format = "i2s";
+			mclk-fs = <128>;
+			cpu {
+				sound-dai = <&sti_uni_player0>;
+			};
+
+			codec {
+				sound-dai = <&sti_hdmi>;
+			};
+		};
 	};
 
 };
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2a44694..6f43666 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -461,6 +461,7 @@ CONFIG_SND_ATMEL_SOC=m
 CONFIG_SND_ATMEL_SOC_WM8904=m
 CONFIG_SND_SOC_SH4_FSI=m
 CONFIG_SND_SOC_RCAR=m
+CONFIG_SND_SOC_HDMI_DRM_CODEC=y
 CONFIG_SND_SOC_STI=y
 CONFIG_SND_SOC_STI_SAS=y
 CONFIG_SND_SOC_TEGRA=m
-- 
1.9.1
