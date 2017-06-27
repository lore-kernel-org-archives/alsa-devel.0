From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH 1/2] dt-bindings: Document the STM32
	SPDIFRX interface
Date: Tue, 27 Jun 2017 15:23:08 +0000
Message-ID: <b74e1d76-de2c-9eb3-4ea1-f63d3e8c82b7@st.com>
References: <1497621452-615-1-git-send-email-olivier.moysan@st.com>
 <1497621452-615-2-git-send-email-olivier.moysan@st.com>
 <20170623185514.nc3jqq6ikvwwv6sn@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0803F266838
 for <alsa-devel@alsa-project.org>; Tue, 27 Jun 2017 17:23:12 +0200 (CEST)
In-Reply-To: <20170623185514.nc3jqq6ikvwwv6sn@rob-hp-laptop>
Content-Language: en-US
Content-ID: <CEAD4BC86887F942ABB7DA2A4E2AF39F@st.com>
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

On 06/23/2017 08:55 PM, Rob Herring wrote:
> On Fri, Jun 16, 2017 at 03:57:31PM +0200, olivier moysan wrote:
>> This adds documentation of device tree bindings for the
>> STM32 SPDIFRX interface.
>>
>> Signed-off-by: olivier moysan <olivier.moysan@st.com>
>> ---
>>   .../devicetree/bindings/sound/st,stm32-spdifrx.txt | 56 ++++++++++++++++++++++
>>   1 file changed, 56 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt b/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
>> new file mode 100644
>> index 0000000..33826f2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
>> @@ -0,0 +1,56 @@
>> +STMicroelectronics STM32 S/PDIF receiver (SPDIFRX).
>> +
>> +The SPDIFRX peripheral, is designed to receive an S/PDIF flow compliant with
>> +IEC-60958 and IEC-61937.
>> +
>> +Required properties:
>> +  - compatible: should be "st,stm32h7-spdifrx"
>> +  - reg: cpu DAI IP base address and size
>> +  - clocks: must contain an entry for kclk (used as S/PDIF signal reference)
>> +  - clock-names: must contain "kclk"
>> +  - interrupts: cpu DAI interrupt line
>> +  - dmas: DMA specifiers for audio data DMA and iec control flow DMA
>> +    See STM32 DMA bindings, Documentation/devicetree/bindings/dma/stm32-dma.txt
>> +  - dma-names: two dmas have to be defined, "rx" and "rx-ctrl"
>> +
>> +Optional properties:
>> +  - resets: Reference to a reset controller asserting the SPDIFRX
>> +
>> +The device node should contain one 'port' child node with one child 'endpoint'
>> +node, according to the bindings defined in Documentation/devicetree/bindings/
>> +graph.txt.
>> +
>> +Example:
>> +spdifrx: spdifrx@40004000 {
>> +	compatible = "st,stm32h7-spdifrx";
>> +	reg = <0x40004000 0x400>;
>> +	clocks = <&rcc SPDIFRX_CK>;
>> +	clock-names = "kclk";
>> +	interrupts = <97>;
>> +	dmas = <&dmamux1 2 93 0x400 0x0>,
>> +	       <&dmamux1 3 94 0x400 0x0>;
>> +	dma-names = "rx", "rx-ctrl";
>> +	pinctrl-0 = <&spdifrx_pins>;
>> +	pinctrl-names = "default";
>> +
>> +	spdifrx_port: port {
>> +		cpu_endpoint: endpoint {
>> +			remote-endpoint = <&codec_endpoint>;
>> +		};
>> +	};
>> +};
>> +
>> +spdif_in: spdif-in {
>> +	compatible = "linux,spdif-dir";
> 
> What is this? It should go.
> 
> Rob
> 

This is the ASoC spdif stub codec. This is relevant in DT when
spdif interface is wired to a connector.
I will remove it from bindings.

BRs
olivier
