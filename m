From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 1/7] ASoC: sti: add binding for ASoc driver
Date: Tue, 14 Apr 2015 15:35:25 +0200
Message-ID: <1429018531-29025-2-git-send-email-arnaud.pouliquen@st.com>
References: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 139A72614A6
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 15:37:20 +0200 (CEST)
In-Reply-To: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Add Asoc driver bindings documentation.
Describe the required properties for each of the hardware IPs drivers.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 .../devicetree/bindings/sound/st,sti-asoc-card.txt | 176 +++++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt

diff --git a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
new file mode 100644
index 0000000..aafc3b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
@@ -0,0 +1,176 @@
+STMicroelectronics sti ASOC cards
+
+The sti ASoC Sound Card can be used, for all sti SoCs using internal sti-sas
+codec or external codecs.
+
+sti sound drivers allows to expose sti SOC audio interface through the
+generic ASOC simple card. For details about sound card declaration please refer to
+Documentation/devicetree/bindings/sound/simple-card.txt.
+
+-sti-asoc-platform: audio platform engine.
+Required properties:
+  - compatible: "st,sti-audio-platform".
+  - st,syscfg: phandle to boot-device system configuration registers
+  - clocks: CPU_DAI IP clock source, listed in the same order than the
+	    CPU_DAI properties.
+  - clock-names: name of the clocks listed in clocks property in the same order
+  - reg: CPU DAI IP Base address and size entries, listed  in same
+	 order than the CPU_DAI properties.
+  - reg-names: names of the mapped memory regions listed in regs property in
+	       the same order.
+  - interrupts: CPU_DAI interrupt line, listed in the same order than the
+		CPU_DAI properties.
+  - dma: CPU_DAI DMA controller phandle and DMA request line, listed in the same
+	 order than the CPU_DAI properties.
+  - dma-names: identifier string for each DMA request line in the dmas property.
+
+- cpu-dai: sti-asoc-platform subnode that describes properties for a CPU-DAI instance.
+Required properties:
+  - dai-name: DAI name that describes the IP.
+  - dai-type: DAI functionality.
+	"uni-player" for playback.
+	"uni-reader" for capture.
+  - uniperiph-id: internal SOC IP instance ID.
+  - version: IP version integrated in SOC.
+  - IP mode: IP working mode depending on associated codec.
+	"HDMI" connected to HDMI codec IP and IEC HDMI formats.
+	"SPDIF"connected to SPDIF codec and support SPDIF formats.
+	"PCM"  PCM standard mode for I2S or TDM bus.
+
+Optional properties:
+  - standby:  standby mode activation deactivation. this mode is specific to
+	      Uni player IP and allows to transmit bus clock and a pattern data
+	      while audio stream is stopped or paused.
+  - auto-suspend-delay: runtime auto suspend delay (in ms) before deactivating
+			stanby mode. Equivalent to the DAPM mechanism but for
+			CPU DAI.
+  - pinctrl-0: defined for CPU_DAI@1 and CPU_DAI@4 to describe I2S PIOs for
+	       external codecs connection.
+  - pinctrl-names: should contain only one value - "default".
+
+- sti-sas-codec: internal audio codec IPs driver
+Required properties:
+  - compatible: "st,sti<chip>-sas-codec" .
+	Should be chip "st,sti416-sas-codec" or "st,sti417-sas-codec"
+  - st,syscfg: phandle to boot-device system configuration registers.
+  - pinctrl-0: SPDIF PIO description.
+  - pinctrl-names: should contain only one value - "default".
+
+audio_controller: sti-asoc-platform {
+		#sound-dai-cells = <1>;
+		compatible = "st,sti-audio-platform";
+		st,syscfg = <&syscfg_core>;
+		clocks = <&clk_s_d0_flexgen CLK_PCM_0>, /*UPP 0*/
+			 <&clk_s_d0_flexgen CLK_PCM_1>, /*UPP 1*/
+			 <&clk_s_d0_flexgen CLK_PCM_2>, /*UPP 2*/
+			 <&clk_s_d0_flexgen CLK_SPDIFF>, /*UPP 3 */
+			 <0>, /*UPR 0: no clock*/
+			 <0>; /*UPR 1: no clock */
+		clock-names = "uni_p0", "uni_p1", "uni_p2", "uni_p3",
+			      "no_clock", "no_clock";
+		reg = <0x8D80000 0x158>, <0x8D81000  0x158>,
+		      <0x8D82000  0x158>, <0x8D85000  0x158>,
+		      <0x8D83000  0x158>, <0x8D84000  0x158>;
+		interrupts = <GIC_SPI 84 IRQ_TYPE_NONE>,
+			     <GIC_SPI 85 IRQ_TYPE_NONE>,
+			     <GIC_SPI 86 IRQ_TYPE_NONE>,
+			     <GIC_SPI 89 IRQ_TYPE_NONE>,
+			     <GIC_SPI 87 IRQ_TYPE_NONE>,
+			     <GIC_SPI 88 IRQ_TYPE_NONE>;
+
+		dmas = <&fdma0 2 0 1>, <&fdma0 3 0 1>,
+		       <&fdma0 4 0 1>, <&fdma0 7 0 1>,
+		       <&fdma0 5 0 1>, <&fdma0 6 0 1>;
+
+		dma-names = "tx-0", "tx-1",
+			    "tx-2", "tx-3",
+			    "rx-4", "rx-5";
+		cpu-dai@0 {
+				dai-name = "Uni Player #0 (HDMI)";
+				dai-type = "uni-player";
+				uniperiph-id = <0>;
+				version = <5>;
+				mode = "HDMI";
+				standby = <1>;
+				auto-suspend-delay = <5000>;
+		};
+
+		cpu-dai@1 {
+				dai-name = "Uni Player #1 (PIO)";
+				dai-type = "uni-player";
+				uniperiph-id = <1>;
+				version = <5>;
+				mode = "PCM";
+				standby = <1>;
+				auto-suspend-delay = <5000>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2s_8ch_out>;
+		};
+		cpu-dai@2 {
+				dai-name = "Uni Player #2 (DAC)";
+				dai-type = "uni-player";
+				uniperiph-id = <2>;
+				version = <5>;
+				mode = "PCM";
+				standby = <1>;
+				auto-suspend-delay = <5000>;
+		};
+		cpu-dai@3 {
+				dai-name = "Uni Player #3 (SPDIF)";
+				dai-type = "uni-player";
+				uniperiph-id = <3>;
+				version = <5>;
+				mode = "SPDIF";
+				standby = <1>;
+				auto-suspend-delay = <5000>;
+		};
+		cpu-dai@4 {
+				dai-name = "Uni Reader #0 (PCM IN)";
+				dai-type = "uni-reader";
+				version = <3>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2s_8ch_in>;
+		};
+		cpu-dai@5 {
+				dai-name = "Uni Reader #1 (HDMI)";
+				dai-type = "uni-reader";
+				version = <3>;
+				channels = <8>;
+		};
+	};
+
+	sti_sas_codec: sti-sas-codec {
+		compatible = "st,stih407-sas-codec";
+		#sound-dai-cells = <1>;
+		st,reg_audio = <&syscfg_core>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_spdif_out >;
+	};
+
+Example of audio card declaration:
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sti audio card";
+		status = "okay";
+
+		simple-audio-card,dai-link@0 {	/* DAC */
+			format = "i2s";
+			cpu {
+				sound-dai = <&audio_controller 2>;
+			};
+
+			codec {
+				sound-dai = <&sti_sasg_codec 1>;
+			};
+		};
+		simple-audio-card,dai-link@1 {	/* SPDIF */
+			format = "left_j";
+			cpu {
+				sound-dai = <&audio_controller 3>;
+			};
+
+			codec {
+				sound-dai = <&sti_sasg_codec 0>;
+			};
+		};
+	};
-- 
1.9.1
