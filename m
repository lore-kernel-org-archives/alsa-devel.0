From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RESEND PATCH v4 3/4] dt-bindings: ASoC: Add WSA881x bindings
Date: Tue, 27 Aug 2019 21:25:20 +0100
Message-ID: <81888350-9296-7db1-01b5-4594a3bd5d60@linaro.org>
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
 <20190822233759.12663-4-srinivas.kandagatla@linaro.org>
 <CAL_JsqLjgOy3TKrpuNYYkRxy-Ln+3FOoKVE9KweS0ycTxriWMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLjgOy3TKrpuNYYkRxy-Ln+3FOoKVE9KweS0ycTxriWMQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Vinod <vkoul@kernel.org>, spapothi@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>, Linux-ALSA <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for taking time to review!

On 27/08/2019 13:20, Rob Herring wrote:
> On Thu, Aug 22, 2019 at 6:38 PM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>> This patch adds bindings for WSA8810/WSA8815 Class-D Smart Speaker
>> Amplifier. This Amplifier also has a simple thermal sensor for
>> over temperature and speaker protection.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../bindings/sound/qcom,wsa881x.yaml          | 44 +++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
>> new file mode 100644
>> index 000000000000..ad718d75c660
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
>> @@ -0,0 +1,44 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/qcom,wsa881x.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Bindings for Qualcomm WSA8810/WSA8815 Class-D Smart Speaker Amplifier
>> +
>> +maintainers:
>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> +
>> +allOf:
>> +  - $ref: "soundwire-controller.yaml#"
> 
> This is not the controller, so this should not be included here. You
> should get lots of warnings from doing so. You did run 'make
> dt_binding_check', right?

no, I was not aware of this command! will run that before sending next 
version.


> 
>> +
>> +properties:
>> +  compatible:
>> +    const: sdw10217201000
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  pd-gpios:
> 
> powerdown-gpios is the standard name.
> 
sounds good to me, will change this in next version!

>> +    description: GPIO spec for Powerdown/Shutdown line to use
>> +    maxItems: 1
>> +
>> +  "#thermal-sensor-cells":
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - pd-gpios
>> +  - #thermal-sensor-cells
>> +
>> +examples:
>> +  - |
>> +    efuse@1c23800 {
>> +        compatible = "allwinner,sun4i-a10-sid";
> 
> Huh?

Opps! copy paste bugs!!! :-)

> 
>> +        reg = <0x01c23800 0x10>;
>> +        pd-gpios = <&wcdpinctrl 2 0>;
>> +        #thermal-sensor-cells = <0>;
>> +    };
>> +
>> +...
>> --
>> 2.21.0
>>
