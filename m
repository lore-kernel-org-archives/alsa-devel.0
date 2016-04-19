From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH] Documentation: sti-asoc-card: update tdm mode
Date: Tue, 19 Apr 2016 11:24:45 +0200
Message-ID: <1461057885-20597-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F5F126581B
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 11:24:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arnaud.pouliquen@st.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

- Add "TDM" in the st,mode property list
- st,mode property is also mandatory for reader
- add tdm playback dai-link example

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---

I forgot to include this patch into "[PATCH v2] ASoC: sti: unip tdm mode" serie
that has been applied.

This patch is the same than the one previously sent in
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/106392.html

 .../devicetree/bindings/sound/st,sti-asoc-card.txt | 44 +++++++++++++++++++---
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
index f546dd9..4d9a83d 100644
--- a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
@@ -37,17 +37,18 @@ Required properties:
 
   - dai-name: DAI name that describes the IP.
 
+  - IP mode: IP working mode depending on associated codec.
+	"HDMI" connected to HDMI codec and support IEC HDMI formats (player only).
+	"SPDIF" connected to SPDIF codec and support SPDIF formats (player only).
+	"PCM" PCM standard mode for I2S or TDM bus.
+	"TDM" TDM mode for TDM bus.
+
 Required properties ("st,sti-uni-player" compatibility only):
   - clocks: CPU_DAI IP clock source, listed in the same order than the
 	    CPU_DAI properties.
 
   - uniperiph-id: internal SOC IP instance ID.
 
-  - IP mode: IP working mode depending on associated codec.
-	"HDMI" connected to HDMI codec IP and IEC HDMI formats.
-	"SPDIF"connected to SPDIF codec and support SPDIF formats.
-	"PCM"  PCM standard mode for I2S or TDM bus.
-
 Optional properties:
   - pinctrl-0: defined for CPU_DAI@1 and CPU_DAI@4 to describe I2S PIOs for
 	       external codecs connection.
@@ -56,6 +57,22 @@ Optional properties:
 
 Example:
 
+	sti_uni_player1: sti-uni-player@1 {
+		compatible = "st,sti-uni-player";
+		status = "okay";
+		#sound-dai-cells = <0>;
+		st,syscfg = <&syscfg_core>;
+		clocks = <&clk_s_d0_flexgen CLK_PCM_1>;
+		reg = <0x8D81000 0x158>;
+		interrupts = <GIC_SPI 85 IRQ_TYPE_NONE>;
+		dmas = <&fdma0 3 0 1>;
+		st,dai-name = "Uni Player #1 (I2S)";
+		dma-names = "tx";
+		st,uniperiph-id = <1>;
+		st,version = <5>;
+		st,mode = "TDM";
+	};
+
 	sti_uni_player2: sti-uni-player@2 {
 		compatible = "st,sti-uni-player";
 		status = "okay";
@@ -99,6 +116,7 @@ Example:
 		dma-names = "rx";
 		dai-name = "Uni Reader #1 (HDMI RX)";
 		version = <3>;
+		st,mode = "PCM";
 	};
 
 2) sti-sas-codec: internal audio codec IPs driver
@@ -152,4 +170,20 @@ Example of audio card declaration:
 				sound-dai = <&sti_sasg_codec 0>;
 			};
 		};
+		simple-audio-card,dai-link@2 {
+			/* TDM playback  */
+			format = "left_j";
+			frame-inversion = <1>;
+			cpu {
+				sound-dai = <&sti_uni_player1>;
+				dai-tdm-slot-num = <16>;
+				dai-tdm-slot-width = <16>;
+				dai-tdm-slot-tx-mask =
+					<1 1 1 1 0 0 0 0 0 0 1 1 0 0 1 1>;
+			};
+
+			codec {
+				sound-dai = <&sti_sasg_codec 3>;
+			};
+		};
 	};
-- 
1.9.1
