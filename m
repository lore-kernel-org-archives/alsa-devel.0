From: olivier moysan <olivier.moysan@st.com>
Subject: [PATCH 1/7] dt-bindings: stm32: sai: fix DT example
Date: Fri, 16 Jun 2017 14:15:28 +0200
Message-ID: <1497615334-7156-2-git-send-email-olivier.moysan@st.com>
References: <1497615334-7156-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C2C72674CF
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 14:16:05 +0200 (CEST)
In-Reply-To: <1497615334-7156-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Correct the device tree example.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 .../devicetree/bindings/sound/st,stm32-sai.txt     | 25 +++++++++-------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
index c59a3d7..a0feeed 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -36,6 +36,10 @@ SAI subnodes required properties:
   - pinctrl-names: should contain only value "default"
   - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt
 
+The device node should contain one 'port' child node with one child 'endpoint'
+node, according to the bindings defined in Documentation/devicetree/bindings/
+graph.txt.
+
 Example:
 sound_card {
 	compatible = "audio-graph-card";
@@ -46,16 +50,15 @@ sai1: sai1@40015800 {
 	compatible = "st,stm32f4-sai";
 	#address-cells = <1>;
 	#size-cells = <1>;
-	ranges;
+	ranges = <0 0x40015800 0x400>;
 	reg = <0x40015800 0x4>;
 	clocks = <&rcc 1 CLK_SAIQ_PDIV>, <&rcc 1 CLK_I2SQ_PDIV>;
 	clock-names = "x8k", "x11k";
 	interrupts = <87>;
 
 	sai1b: audio-controller@40015824 {
-		#sound-dai-cells = <0>;
 		compatible = "st,stm32-sai-sub-b";
-		reg = <0x40015824 0x1C>;
+		reg = <0x24 0x1C>;
 		clocks = <&rcc 1 CLK_SAI2>;
 		clock-names = "sai_ck";
 		dmas = <&dma2 5 0 0x400 0x0>;
@@ -63,18 +66,10 @@ sai1: sai1@40015800 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_sai1b>;
 
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			sai1b_port: port@0 {
-				reg = <0>;
-				cpu_endpoint: endpoint {
-					remote-endpoint = <&codec_endpoint>;
-					audio-graph-card,format = "i2s";
-					audio-graph-card,bitclock-master = <&codec_endpoint>;
-					audio-graph-card,frame-master = <&codec_endpoint>;
-				};
+		sai1b_port: port {
+			cpu_endpoint: endpoint {
+				remote-endpoint = <&codec_endpoint>;
+				format = "i2s";
 			};
 		};
 	};
-- 
1.9.1
