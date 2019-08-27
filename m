From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RESEND PATCH v4 1/4] dt-bindings: soundwire: add slave bindings
Date: Tue, 27 Aug 2019 21:28:56 +0100
Message-ID: <ccc90c56-f776-0c1c-df6b-cb661aa5ea97@linaro.org>
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
 <20190822233759.12663-2-srinivas.kandagatla@linaro.org>
 <20190823065340.GD2672@vkoul-mobl> <20190827202022.GA7783@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827202022.GA7783@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: broonie@kernel.org, spapothi@codeaurora.org, bgoswami@codeaurora.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

thanks for reviewing the patch!

On 27/08/2019 21:20, Rob Herring wrote:
> On Fri, Aug 23, 2019 at 12:23:40PM +0530, Vinod Koul wrote:
>> On 23-08-19, 00:37, Srinivas Kandagatla wrote:
>>> This patch adds bindings for Soundwire Slave devices that includes how
>>> SoundWire enumeration address and Link ID are used to represented in
>>> SoundWire slave device tree nodes.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> ---
>>>   .../soundwire/soundwire-controller.yaml       | 75 +++++++++++++++++++
>>>   1 file changed, 75 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>>> new file mode 100644
>>> index 000000000000..91aa6c6d6266
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>>> @@ -0,0 +1,75 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/soundwire/soundwire-controller.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: SoundWire Controller Generic Binding
>>
>> Controller does not make sense here, why not use spec terminology and
>> say "SoundWire Slave Generic Binding"
> 
> It's both IMO. It's describing the structure of child devices of a
> controller (aka a bus).
> 
>>
>>> +
>>> +maintainers:
>>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> +
>>> +description: |
>>> +  SoundWire busses can be described with a node for the SoundWire controller
>>> +  device and a set of child nodes for each SoundWire slave on the bus.
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    pattern: "^soundwire(@.*|-[0-9a-f])*$"
> 
> '-[0-9a-f]' was to handle cases like spi-gpio or i2c-gpio. Would a
> bit banged interface be possible here?

Highly unlikely!


> 
>>> +
>>> +  "#address-cells":
>>> +    const: 2
>>> +
>>> +  "#size-cells":
>>> +    const: 0
>>> +
>>> +patternProperties:
>>> +  "^.*@[0-9a-f]+$":
> 
> If there are distinct fields in the address, they are typically comma
> separated in the unit-address.

okay, will fix that in next version!


> 
>>> +    type: object
>>> +
>>> +    properties:
>>> +      compatible:
>>> +      pattern: "^sdw[0-9][0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
>>> +      description:
>>> +	  Is the textual representation of SoundWire Enumeration
>>> +	  address. compatible string should contain SoundWire Version ID,
>>> +	  Manufacturer ID, Part ID and Class ID in order and shall be in
>>> +	  lower-case hexadecimal with leading zeroes.
>>> +	  Valid sizes of these fields are
>>> +	  Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
>>> +	  and '0x2' represents SoundWire 1.1 and so on.
>>> +	  MFD is 4 nibbles
>>> +	  PID is 4 nibbles
>>> +	  CID is 2 nibbles
>>> +	  More Information on detail of encoding of these fields can be
>>> +	  found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
>>> +
>>> +      reg:
>>> +        maxItems: 1
>>> +        description:
>>> +          Instance ID and Link ID of SoundWire Device Address.
>>
>> This looks better :) Thanks.
>>
>> Apart from the minor nit above this looks good to me, I can merge the
>> sdw parts if Rob is fine with them.
>>
>> Thanks
>>
>>> +
>>> +    required:
>>> +      - compatible
>>> +      - reg
>>> +
>>> +examples:
>>> +  - |
>>> +    soundwire@c2d0000 {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <0>;
>>> +        compatible = "qcom,soundwire-v1.5.0";
> 
> This will probably change once I review it. :)

:-)

thanks,
srini
> 
>>> +        reg = <0x0c2d0000 0x2000>;
>>> +
>>> +        speaker@1 {
>>> +            compatible = "sdw10217201000";
>>> +            reg = <1 0>;
>>> +        };
>>> +
>>> +        speaker@2 {
>>> +            compatible = "sdw10217201000";
>>> +            reg = <2 0>;
>>> +        };
>>> +    };
>>> +
>>> +...
>>> -- 
>>> 2.21.0
>>
>> -- 
>> ~Vinod
