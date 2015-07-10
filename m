From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: add binding for ASoC driver" to
	the asoc tree
Date: Fri, 10 Jul 2015 19:08:34 +0100
Message-ID: <E1ZDciw-0006qX-VN@debutante>
References: <1434983473-25092-2-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A1F826048C
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 20:08:43 +0200 (CEST)
In-Reply-To: <1434983473-25092-2-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: add binding for ASoC driver

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 05e85d4e0180dbbce823e19d81388e60ac924be1 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Mon, 22 Jun 2015 16:31:05 +0200
Subject: [PATCH] ASoC: sti: add binding for ASoC driver

Add ASoC driver bindings documentation.
Describe the required properties for each of the hardware IPs drivers.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/st,sti-asoc-card.txt | 155 +++++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt

diff --git a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
new file mode 100644
index 000000000000..028fa1c82f50
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
@@ -0,0 +1,155 @@
+STMicroelectronics sti ASoC cards
+
+The sti ASoC Sound Card can be used, for all sti SoCs using internal sti-sas
+codec or external codecs.
+
+sti sound drivers allows to expose sti SoC audio interface through the
+generic ASoC simple card. For details about sound card declaration please refer to
+Documentation/devicetree/bindings/sound/simple-card.txt.
+
+1) sti-uniperiph-dai: audio dai device.
+---------------------------------------
+
+Required properties:
+  - compatible: "st,sti-uni-player" or "st,sti-uni-reader"
+
+  - st,syscfg: phandle to boot-device system configuration registers
+
+  - clock-names: name of the clocks listed in clocks property in the same order
+
+  - reg: CPU DAI IP Base address and size entries, listed  in same
+	 order than the CPU_DAI properties.
+
+  - reg-names: names of the mapped memory regions listed in regs property in
+	       the same order.
+
+  - interrupts: CPU_DAI interrupt line, listed in the same order than the
+		CPU_DAI properties.
+
+  - dma: CPU_DAI DMA controller phandle and DMA request line, listed in the same
+	 order than the CPU_DAI properties.
+
+  - dma-names: identifier string for each DMA request line in the dmas property.
+	"tx" for "st,sti-uni-player" compatibility
+	"rx" for "st,sti-uni-reader" compatibility
+
+  - version: IP version integrated in SOC.
+
+  - dai-name: DAI name that describes the IP.
+
+Required properties ("st,sti-uni-player" compatibility only):
+  - clocks: CPU_DAI IP clock source, listed in the same order than the
+	    CPU_DAI properties.
+
+  - uniperiph-id: internal SOC IP instance ID.
+
+  - IP mode: IP working mode depending on associated codec.
+	"HDMI" connected to HDMI codec IP and IEC HDMI formats.
+	"SPDIF"connected to SPDIF codec and support SPDIF formats.
+	"PCM"  PCM standard mode for I2S or TDM bus.
+
+Optional properties:
+  - pinctrl-0: defined for CPU_DAI@1 and CPU_DAI@4 to describe I2S PIOs for
+	       external codecs connection.
+
+  - pinctrl-names: should contain only one value - "default".
+
+Example:
+
+	sti_uni_player2: sti-uni-player@2 {
+		compatible = "st,sti-uni-player";
+		status = "okay";
+		#sound-dai-cells = <0>;
+		st,syscfg = <&syscfg_core>;
+		clocks = <&clk_s_d0_flexgen CLK_PCM_2>;
+		reg = <0x8D82000 0x158>;
+		interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
+		dmas = <&fdma0 4 0 1>;
+		dai-name = "Uni Player #1 (DAC)";
+		dma-names = "tx";
+		uniperiph-id = <2>;
+		version = <5>;
+		mode = "PCM";
+	};
+
+	sti_uni_player3: sti-uni-player@3 {
+		compatible = "st,sti-uni-player";
+		status = "okay";
+		#sound-dai-cells = <0>;
+		st,syscfg = <&syscfg_core>;
+		clocks = <&clk_s_d0_flexgen CLK_SPDIFF>;
+		reg = <0x8D85000 0x158>;
+		interrupts = <GIC_SPI 89 IRQ_TYPE_NONE>;
+		dmas = <&fdma0 7 0 1>;
+		dma-names = "tx";
+		dai-name = "Uni Player #1 (PIO)";
+		uniperiph-id = <3>;
+		version = <5>;
+		mode = "SPDIF";
+	};
+
+	sti_uni_reader1: sti-uni-reader@1 {
+		compatible = "st,sti-uni-reader";
+		status = "disabled";
+		#sound-dai-cells = <0>;
+		st,syscfg = <&syscfg_core>;
+		reg = <0x8D84000 0x158>;
+		interrupts = <GIC_SPI 88 IRQ_TYPE_NONE>;
+		dmas = <&fdma0 6 0 1>;
+		dma-names = "rx";
+		dai-name = "Uni Reader #1 (HDMI RX)";
+		version = <3>;
+	};
+
+2) sti-sas-codec: internal audio codec IPs driver
+-------------------------------------------------
+
+Required properties:
+  - compatible: "st,sti<chip>-sas-codec" .
+	Should be chip "st,stih416-sas-codec" or "st,stih407-sas-codec"
+
+  - st,syscfg: phandle to boot-device system configuration registers.
+
+  - pinctrl-0: SPDIF PIO description.
+
+  - pinctrl-names: should contain only one value - "default".
+
+Example:
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
+		simple-audio-card,dai-link@0 {
+			/* DAC */
+			format = "i2s";
+			dai-tdm-slot-width = <32>;
+			cpu {
+				sound-dai = <&sti_uni_player2>;
+			};
+
+			codec {
+				sound-dai = <&sti_sasg_codec 1>;
+			};
+		};
+		simple-audio-card,dai-link@1 {
+			/* SPDIF */
+			format = "left_j";
+			cpu {
+				sound-dai = <&sti_uni_player3>;
+			};
+
+			codec {
+				sound-dai = <&sti_sasg_codec 0>;
+			};
+		};
+	};
-- 
2.1.4
