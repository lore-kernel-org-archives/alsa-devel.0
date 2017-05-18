From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: Document STM32 I2S
	bindings
Date: Thu, 18 May 2017 13:29:03 +0000
Message-ID: <827a2860-1f2e-0296-d58c-4c8686858549@st.com>
References: <1494495904-18898-1-git-send-email-olivier.moysan@st.com>
 <1494495904-18898-2-git-send-email-olivier.moysan@st.com>
 <20170513001753.hygunrcjqejpbwl6@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id EA7E9267019
 for <alsa-devel@alsa-project.org>; Thu, 18 May 2017 15:29:07 +0200 (CEST)
In-Reply-To: <20170513001753.hygunrcjqejpbwl6@rob-hp-laptop>
Content-Language: en-US
Content-ID: <522EEE913D323E48BF1E987B2B9AF569@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, Benjamin GAIGNARD <benjamin.gaignard@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@stlinux.com" <kernel@stlinux.com>
List-Id: alsa-devel@alsa-project.org

Hello Rob,

Thanks for your comment.

On 05/13/2017 02:17 AM, Rob Herring wrote:
> On Thu, May 11, 2017 at 11:45:02AM +0200, olivier moysan wrote:
>> Add documentation of device tree bindings for STM32 SPI/I2S.
>>
>> Signed-off-by: olivier moysan <olivier.moysan@st.com>
>> ---
>>  .../devicetree/bindings/sound/st,stm32-i2s.txt     | 68 ++++++++++++++++++++++
>>  1 file changed, 68 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-i2s.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.txt b/Documentation/devicetree/bindings/sound/st,stm32-i2s.txt
>> new file mode 100644
>> index 0000000..67b854a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.txt
>> @@ -0,0 +1,68 @@
>> +STMicroelectronics STM32 SPI/I2S Controller
>> +
>> +The SPI/I2S block supports I2S/PCM protocols when configured on I2S mode.
>> +Only some SPI instances support I2S.
>> +
>> +Required properties:
>> +  - compatible: Must be "st,stm32h7-i2s"
>> +  - reg: Offset and length of the device's register set.
>> +  - interrupts: Must contain the interrupt line id.
>> +  - clocks: Must contain phandle and clock specifier pairs for each entry
>> +	in clock-names.
>> +  - clock-names: Must contain "i2sclk", "pclk", "x8k" and "x11k".
>> +	"i2sclk": clock which feeds the internal clock generator
>> +	"pclk": clock which feeds the peripheral bus interface
>> +	"x8k": I2S parent clock for sampling rates multiple of 8kHz.
>> +	"x11k": I2S parent clock for sampling rates multiple of 11.025kHz.
>> +  - dmas: DMA specifiers for tx and rx dma.
>> +    See Documentation/devicetree/bindings/dma/stm32-dma.txt.
>> +  - dma-names: Identifier for each DMA request line. Must be "tx" and "rx".
>> +  - pinctrl-names: should contain only value "default"
>> +  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt
>> +
>> +Optional properties:
>> +  - resets: Reference to a reset controller asserting the reset controller
>> +
>> +The device node should contain one 'port' child node with one child 'endpoint'
>> +node, according to the bindings defined in Documentation/devicetree/bindings/
>> +graph.txt.
>> +
>> +Example:
>> +sound_card {
>> +	compatible = "audio-graph-card";
>> +	dais = <&i2s2_port 0>;
>
> What is the 0 representing?
>

This is no more relevant, so to be removed.

>> +};
>> +
>> +i2s2: audio-controller@40003800 {
>> +	compatible = "st,stm32h7-i2s";
>> +	#sound-dai-cells = <0>;
>
> Should be dropped.
>

ok

>> +	reg = <0x40003800 0x400>;
>> +	interrupts = <36>;
>> +	clocks = <&rcc PCLK1>, <&rcc SPI2_CK>, <&rcc PLL1_Q>, <&rcc PLL2_P>;
>> +	clock-names = "pclk", "i2sclk",  "x8k", "x11k";
>> +	dmas = <&dmamux2 2 39 0x400 0x1>,
>> +           <&dmamux2 3 40 0x400 0x1>;
>> +	dma-names = "rx", "tx";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2s2>;
>> +
>> +	i2s2_port: port@0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>
> This shouldn't even compile. You don't need these because because you
> have no reg property in the endpoint.
>
> You have a unit-address here w/o a reg property. You don't need a reg
> prop because you only have 1 port.
>

ok.

>> +
>> +		cpu_endpoint: endpoint {
>> +			remote-endpoint = <&codec_endpoint>;
>> +			format = "i2s";
>> +			bitclock-master = <&codec_endpoint>;
>> +			frame-master = <&codec_endpoint>;
>> +		};
>> +	};
>> +};
>> +
>> +audio-codec {
>> +		codec_port: port@0 {
>> +			codec_endpoint: endpoint {
>> +				remote-endpoint = <&cpu_endpoint>;
>> +		};
>> +	};
>> +};
>> --
>> 1.9.1
>>

BRs
Olivier
