From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH RFC V2 5/5] DT: sti: add audio HDMI dai link in
	audio card
Date: Thu, 1 Oct 2015 18:50:21 +0200
Message-ID: <1443718221-5120-6-git-send-email-arnaud.pouliquen@st.com>
References: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C26EA2667EC
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 18:51:06 +0200 (CEST)
In-Reply-To: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: moinejf@free.fr, linux@arm.linux.org.uk, bcousson@baylibre.com, David Airlie <airlied@linux.ie>, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, peter.ujfalusi@ti.com, Takashi Iwai <tiwai@suse.de>, tony@atomide.com, broonie@kernel.org, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add the HDMI dai link to support audio for HDMi output

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 arch/arm/boot/dts/stih410.dtsi       |  6 +++++-
 arch/arm/boot/dts/stihxxx-b2120.dtsi | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index 7ee7dc0..dfc61a9 100644
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
@@ -211,6 +212,9 @@
 					resets = <&softreset STIH407_HDMI_TX_PHY_SOFTRESET>;
 					ddc = <&hdmiddc>;
 
+					sound-dai {
+						format = "spdif";
+					};
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
-- 
1.9.1
