From: Rob Herring <robh@kernel.org>
Subject: Re: [RESEND PATCH v2 1/2] ASoC: stm32: add bindings
	for SAI
Date: Sat, 18 Mar 2017 15:43:35 -0500
Message-ID: <CAL_JsqKXZFyWV7uPYLBP-Gzen0Cu=wv5Z-1fdkBdPfNOk1Bp3Q@mail.gmail.com>
References: <1488879872-7839-1-git-send-email-olivier.moysan@st.com>
 <1488879872-7839-2-git-send-email-olivier.moysan@st.com>
 <20170315174606.rrvhuuzplzwwucph@rob-hp-laptop>
 <ecc50cac-46a6-5e89-d07c-05f34a12d997@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by alsa0.perex.cz (Postfix) with ESMTP id BE004266AF1
 for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2017 21:44:02 +0100 (CET)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id DA86320481
 for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2017 20:43:58 +0000 (UTC)
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com
 [209.85.161.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4EBC120443
 for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2017 20:43:56 +0000 (UTC)
Received: by mail-yw0-f169.google.com with SMTP id v198so71138639ywc.2
 for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2017 13:43:56 -0700 (PDT)
In-Reply-To: <ecc50cac-46a6-5e89-d07c-05f34a12d997@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olivier MOYSAN <olivier.moysan@st.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 16, 2017 at 5:50 AM, Olivier MOYSAN <olivier.moysan@st.com> wrote:
> Hello Rob,
>
> Thanks for your feedback.
>
> On 03/15/2017 06:46 PM, Rob Herring wrote:
>> On Tue, Mar 07, 2017 at 10:44:31AM +0100, olivier moysan wrote:
>>> This patch adds documentation of device tree bindings for the
>>> STM32 SAI ASoC driver.
>>>
>>> Signed-off-by: olivier moysan <olivier.moysan@st.com>
>>> ---
>>>  .../devicetree/bindings/sound/st,stm32-sai.txt     | 79 ++++++++++++++++++++++
>>>  1 file changed, 79 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
>>> new file mode 100644
>>> index 0000000..b3be26d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
>>> @@ -0,0 +1,79 @@
>>> +STMicroelectronics STM32 Serial Audio Interface (SAI).
>>> +
>>> +The SAI interface (Serial Audio Interface) offers a wide set of audio protocols
>>> +as I2S standards, LSB or MSB-justified, PCM/DSP, TDM, and AC'97.
>>> +The SAI contains two independent audio sub-blocks. Each sub-block has
>>> +its own clock generator and I/O lines controller.
>>> +
>>> +Required properties:
>>> +  - compatible: Should be "st,stm32f4-sai"
>>> +  - reg: Base address and size of SAI common register set.
>>> +  - clocks: Must contain phandle and clock specifier pairs for each entry
>>> +    in clock-names.
>>> +  - clock-names: Must contain "clk_x8k" and "clk_x11k"
>>> +    "clk_x8k": SAI parent clock for sampling rates multiple of 8kHz.
>>> +    "clk_x11k": SAI parent clock for sampling rates multiple of 11.025kHz.
>>
>> clk_ is redundant.
>>
>
> Do you mean, removing clk_ prefix ?

Yes.

>
>>> +  - interrupts: cpu DAI interrupt line shared by SAI sub-blocks
>>> +
>>> +Note: Each SAI controller should have an alias correctly numbered
>>> +in "aliases" node, to provide explicit name to CPU DAI.
>>
>> No, it shouldn't. Why do you need that?
>>
>
> Yes, this is not mandatory. This is convenient to identify sai
> controller, as we may have up to 8 instances.
> I can make it optional, or remove it if you think it is not relevant.

Remove it.

>
>>
>>> +
>>> +Optional properties:
>>> +  - resets: Reference to a reset controller asserting the SAI
>>> +
>>> +SAI subnodes:
>>> +Two subnodes corresponding to SAI sub-block instances A et B can be defined.
>>> +Subnode can be omitted for unsused sub-block.
>>> +
>>> +SAI subnodes required properties:
>>> +  - compatible: Should be "st,stm32-sai-sub-a" or "st,stm32-sai-sub-b"
>>> +    for SAI sub-block A or B respectively.
>>> +  - reg: Base address and size of SAI sub-block register set.
>>> +  - clocks: Must contain one phandle and clock specifier pair
>>> +    for sai_ck which feeds the internal clock generator.
>>> +  - clock-names: Must contain "sai_ck".
>>> +  - dmas: see Documentation/devicetree/bindings/dma/stm32-dma.txt
>>> +  - dma-names: identifier string for each DMA request line
>>> +    "tx": if sai sub-block is configured as playback DAI
>>> +    "rx": if sai sub-block is configured as capture DAI
>>> +  - pinctrl-names: should contain only value "default"
>>> +  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt
>>> +
>>> +Example:
>>> +sai1: sai1@40015800 {
>>> +    compatible = "st,stm32f4-sai";
>>> +    reg = <0x40015800 0x400>;
>
>         reg = <0x40015800 0x4>;
>
>>> +    clocks = <&rcc 1 CLK_SAIQ_PDIV>, <&rcc 1 CLK_I2SQ_PDIV>;
>>> +    clock-names = "clk_x8k", "clk_x11k";
>>> +    interrupts = <87>;
>>> +    resets = <&rcc 310>;
>>> +
>>> +    sai1b: sai@1 {
>>
>> unit address needs a reg property.
>>
>> audio-controller@1
>>
>
> Right. This needs to be updated as follows:
>         sai1b: sai1b@40015824 {

audio-controller@...

>                 ...
>                 reg = <0x40015824 0x1C>;
>                 ...
>         };
>
>>> +            #sound-dai-cells = <0>;
>>> +            compatible = "st,stm32-sai-sub-b";
>>> +            clocks = <&rcc 1 CLK_SAI2>;
>>> +            clock-names = "sai_ck";
>>> +            dmas = <&dma2 5 0 0x400 0x1>;
>>> +            dma-names = "tx";
>>> +    };
>>> +};
>>> +
>>> +sound {
>>> +    compatible = "simple-audio-card";
>>
>> Perhaps you want to use the graph-card here. It's getting close to
>> merging.
>>
>
> mclk-fs property is required when SAI is configured as master.
> It seems that mclk-fs is not supported in current version
> of audio graph card. So I thing I should keep simple card for the time
> being. Anyway, I plan further updates for SAI, so I will
> have opportunity to change to graph card at that time.

Well, it's not easy to switch later and maintain compatibility. Is it
complicated to add mclk-fs property? The intent is graph-card supports
everything simple-card supports.

Rob
