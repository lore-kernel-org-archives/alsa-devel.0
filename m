From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 1/7] MFD: add bindings for STM32 DFSDM driver
Date: Mon, 23 Jan 2017 17:32:19 +0100
Message-ID: <1485189145-29576-2-git-send-email-arnaud.pouliquen@st.com>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: arnaud.pouliquen@st.com, Alexandre Torgue <alexandre.torgue@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add bindings information for STM32 Digital Filter for Sigma Delta modulators MFD driver

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 .../devicetree/bindings/mfd/stm32-dfsdm.txt        | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/stm32-dfsdm.txt

diff --git a/Documentation/devicetree/bindings/mfd/stm32-dfsdm.txt b/Documentation/devicetree/bindings/mfd/stm32-dfsdm.txt
new file mode 100644
index 0000000..e0b45ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/stm32-dfsdm.txt
@@ -0,0 +1,68 @@
+STMicroelectronics STM32 Digital Filter for Sigma Delta Modulator (DFSDM)
+ulti-function device.
+
+The STM32 DFSDM device is a multifunction device that handles the DFSDM IP.
+
+The DFSDM IP allows to add processing on Sigma Delta ADC based on SinC filters.
+For this, a pool of m filters can be connected to a pool of n channels.
+For STM32H7 : m = 4, n = 8.
+
+Each channel n is assigned to the SPI or Manchester interface n or n + 1.
+Channels 0 to 2 can also be connected to ADC IP instance 1 to 3.
+Filtering result is stored in a left aligned register, with 8 LSB reserved for
+the input channel ID.
+
+Each filter instance supports two contexts to manage conversions, each one has
+its own configurable sequence and trigger:
+- regular conversion: used for single or continuous conversion.
+- injected conversions: used for triggered conversion.
+
+Interfaces supported:
+- sigma delta ADCs trough IIO framework.
+- PDM microphones through ASoC framework.
+
+Required properties:
+- compatible:	Must be "st,stm32h7-dfsdm".
+- reg:		Specifies the DFSDM block register address and length.
+- interrupts:	IRQ lines connected to each DFSDM filter instance.
+- clocks:	IP and serial interfaces clocking. Should be set according
+		to rcc clock ID and "clock-names".
+- clock-names:	Input clock name "dfsdm_clk" must be defined,
+		"audio_clk" is optional. If defined CLKOUT is based on the audio
+		clock, else "dfsdm_clk" is used.
+
+Optional properties:
+- st,clkout-freq: clkout clock frequency (Hz).This clock must be set according
+		  to "clock" property. Frequency must be a multiple of the rcc
+		  clock frequency. If not, clkout frequency will not be
+		  accurate.
+- pinctrl-names:  set to "default".
+- pinctrl-0:	  List of phandles pointing to pin configuration nodes for DFSDM
+		  module.
+		  For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
+Example :
+	dfsdm: dfsdm@4400D000 {
+		compatible = "st,stm32h7-dfsdm";
+		reg = <0x40017000 0x400>;
+		interrupts = <110>, <111>, <112>, <113>;
+		clocks = <&timer_clk>;
+		clock-names = "dfsdm_clk";
+		pinctrl-0 = <&dfsdm_ch0 &dfsdm_ch1>;
+		pinctrl-names = "default";
+		st,clkout-freq = <2480000>;
+
+		iio_dfsdm0: iio-dfsdm@0 {
+			compatible = "st,stm32-dfsdm-adc";
+			#io-channel-cells = <1>;
+			reg = <0>;
+			status = "disabled";
+		};
+		dai_dfsdm0: dfsdm-audio@0 {
+			compatible = "st,stm32-dfsdm-audio";
+			#sound-dai-cells = <0>;
+			reg = <0>;
+			dmas = <&dmamux1 101 0x400 0x00>;
+			dma-names = "rx";
+			status = "disabled";
+		};
+	};
-- 
1.9.1
