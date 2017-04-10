From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: Document STM32 I2S
	bindings
Date: Mon, 10 Apr 2017 14:48:32 -0500
Message-ID: <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
References: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
 <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F985266C13
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 21:48:35 +0200 (CEST)
Received: by mail-oi0-f67.google.com with SMTP id o83so1383413oik.1
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 12:48:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: olivier moysan <olivier.moysan@st.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, alexandre.torgue@st.com, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, mcoquelin.stm32@gmail.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 06, 2017 at 05:40:35PM +0200, olivier moysan wrote:
> Add documentation of device tree bindings for STM32 SPI/I2S.
> 
> Signed-off-by: olivier moysan <olivier.moysan@st.com>
> ---
>  .../devicetree/bindings/sound/st,stm32h7-i2s.txt   | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32h7-i2s.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/st,stm32h7-i2s.txt b/Documentation/devicetree/bindings/sound/st,stm32h7-i2s.txt
> new file mode 100644
> index 0000000..b99467a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/st,stm32h7-i2s.txt
> @@ -0,0 +1,71 @@
> +STMicroelectronics STM32 SPI/I2S Controller
> +
> +The SPI/I2S block supports I2S/PCM protocols when configured on I2S mode.
> +Only some SPI instances support I2S.
> +
> +Required properties:
> +  - compatible: Must be "st,stm32h7-i2s"
> +  - #sound-dai-cells: Must be 1. (one parameter)
> +    This parameter allows to specify CPU DAI index in soundcard CPU dai link.
> +	index 0: playback DAI
> +	index 1: capture DAI
> +	index 2: full duplex DAI

Is this still needed for graph-card?

> +  - reg: Offset and length of the device's register set.
> +  - interrupts: Must contain the interrupt line id.
> +  - clocks: Must contain phandle and clock specifier pairs for each entry
> +	in clock-names.
> +  - clock-names: Must contain "i2sclk", "pclk", "x8k" and "x11k".
> +	"i2sclk": clock which feeds the internal clock generator
> +	"pclk": clock which feeds the peripheral bus interface
> +	"x8k": I2S parent clock for sampling rates multiple of 8kHz.
> +	"x11k": I2S parent clock for sampling rates multiple of 11.025kHz.
> +  - dmas: DMA specifiers for tx and rx dma.
> +    See Documentation/devicetree/bindings/dma/stm32-dma.txt.
> +  - dma-names: Identifier for each DMA request line. Must be "tx" and "rx".
> +  - pinctrl-names: should contain only value "default"
> +  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt
> +
> +Optional properties:
> +  - resets: Reference to a reset controller asserting the reset controller
> +
> +Example:
> +sound_card {
> +	compatible = "audio-graph-card";
> +	dais = <&i2s2_port 0>;
> +};
> +
> +i2s2: audio-controller@40003800 {
> +	compatible = "st,stm32h7-i2s";
> +	#sound-dai-cells = <1>;
> +	reg = <0x40003800 0x400>;
> +	interrupts = <36>;
> +	clocks = <&rcc PCLK1>, <&rcc SPI2_CK>, <&rcc PLL1_Q>, <&rcc PLL2_P>;
> +	clock-names = "pclk", "i2sclk",  "x8k", "x11k";
> +	dmas = <&dmamux2 2 39 0x400 0x1>,
> +		       <&dmamux2 3 40 0x400 0x1>;
> +	dma-names = "rx", "tx";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2s2>;
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2s2_port: port@0 {
> +			reg = <0>;
> +			cpu_endpoint: endpoint {
> +				remote-endpoint = <&codec_endpoint>;
> +				audio-graph-card,format = "i2s";
> +				audio-graph-card,bitclock-master = <&codec_endpoint>;
> +				audio-graph-card,frame-master = <&codec_endpoint>;

The 'audio-graph-card,' part has been dropped.

> +			};
> +		};
> +};
> +
> +audio-codec {
> +		codec_port: port {
> +			codec_endpoint: endpoint {
> +				remote-endpoint = <&cpu_endpoint>;
> +		};
> +	};
> +};
> -- 
> 1.9.1
> 
