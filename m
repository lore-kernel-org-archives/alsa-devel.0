From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [RESEND PATCH v4 1/4] dt-bindings: soundwire: add
 slave bindings
Date: Sat, 24 Aug 2019 10:28:09 +0100
Message-ID: <7ee47f26-12f8-6028-cb83-7f59e669979f@linaro.org>
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
 <20190822233759.12663-2-srinivas.kandagatla@linaro.org>
 <7da8aa89-2119-21d1-0e29-8894a8d40bf0@linux.intel.com>
 <37be6b6d-7e7f-2cd6-f9e9-f0cac48791ad@linaro.org>
 <d538238d-25d8-f179-c900-90be50ce814d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d538238d-25d8-f179-c900-90be50ce814d@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, spapothi@codeaurora.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 23/08/2019 17:44, Pierre-Louis Bossart wrote:
> 
> 
> On 8/23/19 10:57 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 23/08/2019 16:41, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 8/22/19 6:37 PM, Srinivas Kandagatla wrote:
>>>> This patch adds bindings for Soundwire Slave devices that includes how
>>>> SoundWire enumeration address and Link ID are used to represented in
>>>> SoundWire slave device tree nodes.
>>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> ---
>>>>   .../soundwire/soundwire-controller.yaml       | 75 
>>>> +++++++++++++++++++
>>>>   1 file changed, 75 insertions(+)
>>>>   create mode 100644 
>>>> Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>>>>
>>>> diff --git 
>>>> a/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml 
>>>> b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>>>> new file mode 100644
>>>> index 000000000000..91aa6c6d6266
>>>> --- /dev/null
>>>> +++ 
>>>> b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>>>> @@ -0,0 +1,75 @@
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: 
>>>> http://devicetree.org/schemas/soundwire/soundwire-controller.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: SoundWire Controller Generic Binding
>>>> +
>>>> +maintainers:
>>>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> +
>>>> +description: |
>>>> +  SoundWire busses can be described with a node for the SoundWire 
>>>> controller
>>>> +  device and a set of child nodes for each SoundWire slave on the bus.
>>>> +
>>>> +properties:
>>>> +  $nodename:
>>>> +    pattern: "^soundwire(@.*|-[0-9a-f])*$"
> 
> re-reading this, it looks like you are defining the controller bindings, 
> but there are no real controller-level properties except for the fact 
> that they include slave bindings?
> 
Yes, Each vendor specific master can have there specific properties 
here, this is just to represent how slave nodes represented w.r.t to 
master nodes.

> In MIPI the notion of controller is that it can deal with multiple 
> links, each of which having specific properties (clock speed, clock stop 
> properties, etc).
> 
>>>> +
>>>> +  "#address-cells":
>>>> +    const: 2
>>>> +
>>>> +  "#size-cells":
>>>> +    const: 0
>>>> +
>>>> +patternProperties:
>>>> +  "^.*@[0-9a-f]+$":
>>>> +    type: object
>>>> +
>>>> +    properties:
>>>> +      compatible:
>>>> +      pattern: "^sdw[0-9][0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
>>>
>>> So is this a 64-bit value, as in the MIPI spec, or is this part of 
>>> the _ADR description?
>>
>> Rob did not like encoding compatible string exactly like _ADR encoding.
>>
>> https://lkml.org/lkml/2019/8/22/490
> 
> Wondering if we are talking about different concepts?
> 
> Rob's point was about the InstanceID
> 
> "Assuming you could have more than 1 of the same device on the bus,
> then you need some way to distinguish them and the way that's done for
> DT is unit-address/reg. And compatible strings should be constant for
> each instance."
> 
> You can use the MIPI encoding *except* for the InstanceID, that'd be 
> fine. It'll just be a bit weird since the Slave device will report the 
> 48 bits that include the Instance ID, so you'll have to special case 
> this field, but if this is a DT requirement then fine.
> 
> Rob's point does not apply to the link ID - which is used when you have 
> multiple masters in your controller. The Slave device is attached in one 
> location and will never move, so that is a constant value.

Point is that this compatible is for slave device, it should not matter 
where and how the slave is connected, compatible should be constant 
irrespective of Link ID.
Lets say for example if WSA881x slave device is connected to a 
single-Link Controller and the same device is connected to a 
MultiLink-controller then we would endup in more than one compatible 
string for WSA881x driver.


 From Disco Specic it clearly says that LinkID values are relative
to the immediate parent Device. So having LinkID in compatible string is 
very fragile.

> 
>>
>>> I also don't get why the first item in in base10?
>>>
>>
>> As this corresponds to Soundwire Version, and I have no visibility of 
>> version number encoding after reaching number 9 in this field.
>>
>> This can be updated once we have more info on how the Version encoding 
>> will look like in future.
>>
>> Idea of limiting regex to [0-9] for version is to enforce some checking!
> 
> the version is a 4 bit value starting at 1 for SoundWire 1.0. There is 
> nothing in the spec that talks about a limit to 9.
> 
> It's unlikely we'll ever reach that but you are interpreting a spec 
> here. plus just below you mention all fields as being hexadecimal.
> 
Am happy to change this to

pattern: "^sdw[0-9a-f][0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"

if you are okay with rest of the stuff.

thanks,
srini
>>
>> --srini
>>
>>>
>>>> +      description:
>>>> +      Is the textual representation of SoundWire Enumeration
>>>> +      address. compatible string should contain SoundWire Version ID,
>>>> +      Manufacturer ID, Part ID and Class ID in order and shall be in
>>>> +      lower-case hexadecimal with leading zeroes.
>>>> +      Valid sizes of these fields are
>>>> +      Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
>>>> +      and '0x2' represents SoundWire 1.1 and so on.
>>>> +      MFD is 4 nibbles
>>>> +      PID is 4 nibbles
>>>> +      CID is 2 nibbles
>>>> +      More Information on detail of encoding of these fields can be
>>>> +      found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
>>>> +
>>>> +      reg:
>>>> +        maxItems: 1
>>>> +        description:
>>>> +          Instance ID and Link ID of SoundWire Device Address.
>>>> +
>>>> +    required:
>>>> +      - compatible
>>>> +      - reg
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    soundwire@c2d0000 {
>>>> +        #address-cells = <2>;
>>>> +        #size-cells = <0>;
>>>> +        compatible = "qcom,soundwire-v1.5.0";
>>>> +        reg = <0x0c2d0000 0x2000>;
>>>> +
>>>> +        speaker@1 {
>>>> +            compatible = "sdw10217201000";
>>>> +            reg = <1 0>;
>>>> +        };
>>>> +
>>>> +        speaker@2 {
>>>> +            compatible = "sdw10217201000";
>>>> +            reg = <2 0>;
>>>> +        };
>>>> +    };
>>>> +
>>>> +...
>>>>
