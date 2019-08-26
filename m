From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RESEND PATCH v4 1/4] dt-bindings: soundwire: add
 slave bindings
Date: Mon, 26 Aug 2019 11:22:00 -0500
Message-ID: <e5b184be-02f1-faa4-94fa-79bda8936d9d@linux.intel.com>
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
 <20190822233759.12663-2-srinivas.kandagatla@linaro.org>
 <7da8aa89-2119-21d1-0e29-8894a8d40bf0@linux.intel.com>
 <37be6b6d-7e7f-2cd6-f9e9-f0cac48791ad@linaro.org>
 <d538238d-25d8-f179-c900-90be50ce814d@linux.intel.com>
 <7ee47f26-12f8-6028-cb83-7f59e669979f@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7ee47f26-12f8-6028-cb83-7f59e669979f@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, spapothi@codeaurora.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


>>>>> +title: SoundWire Controller Generic Binding
>>>>> +
>>>>> +maintainers:
>>>>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>> +
>>>>> +description: |
>>>>> +  SoundWire busses can be described with a node for the SoundWire 
>>>>> controller
>>>>> +  device and a set of child nodes for each SoundWire slave on the 
>>>>> bus.
>>>>> +
>>>>> +properties:
>>>>> +  $nodename:
>>>>> +    pattern: "^soundwire(@.*|-[0-9a-f])*$"
>>
>> re-reading this, it looks like you are defining the controller 
>> bindings, but there are no real controller-level properties except for 
>> the fact that they include slave bindings?
>>
> Yes, Each vendor specific master can have there specific properties 
> here, this is just to represent how slave nodes represented w.r.t to 
> master nodes.

I am not clear on how a vendor would document those controller 
properties then?

And the number of links doesn't seem like a vendor-specific definition, 
if you include the linkID in the register information below it'd help to 
known how many links can be enabled, which ones are used (if there is 
any pin-mux) and check if the configurations are correct.

> 
>> In MIPI the notion of controller is that it can deal with multiple 
>> links, each of which having specific properties (clock speed, clock 
>> stop properties, etc).
>>
>>>>> +
>>>>> +  "#address-cells":
>>>>> +    const: 2
>>>>> +
>>>>> +  "#size-cells":
>>>>> +    const: 0
>>>>> +
>>>>> +patternProperties:
>>>>> +  "^.*@[0-9a-f]+$":
>>>>> +    type: object
>>>>> +
>>>>> +    properties:
>>>>> +      compatible:
>>>>> +      pattern: "^sdw[0-9][0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
>>>>
>>>> So is this a 64-bit value, as in the MIPI spec, or is this part of 
>>>> the _ADR description?
>>>
>>> Rob did not like encoding compatible string exactly like _ADR encoding.
>>>
>>> https://lkml.org/lkml/2019/8/22/490
>>
>> Wondering if we are talking about different concepts?
>>
>> Rob's point was about the InstanceID
>>
>> "Assuming you could have more than 1 of the same device on the bus,
>> then you need some way to distinguish them and the way that's done for
>> DT is unit-address/reg. And compatible strings should be constant for
>> each instance."
>>
>> You can use the MIPI encoding *except* for the InstanceID, that'd be 
>> fine. It'll just be a bit weird since the Slave device will report the 
>> 48 bits that include the Instance ID, so you'll have to special case 
>> this field, but if this is a DT requirement then fine.
>>
>> Rob's point does not apply to the link ID - which is used when you 
>> have multiple masters in your controller. The Slave device is attached 
>> in one location and will never move, so that is a constant value.
> 
> Point is that this compatible is for slave device, it should not matter 
> where and how the slave is connected, compatible should be constant 
> irrespective of Link ID.
> Lets say for example if WSA881x slave device is connected to a 
> single-Link Controller and the same device is connected to a 
> MultiLink-controller then we would endup in more than one compatible 
> string for WSA881x driver. >
> 
>  From Disco Specic it clearly says that LinkID values are relative
> to the immediate parent Device. So having LinkID in compatible string is 
> very fragile.

ok, fine then.

> 
>>
>>>
>>>> I also don't get why the first item in in base10?
>>>>
>>>
>>> As this corresponds to Soundwire Version, and I have no visibility of 
>>> version number encoding after reaching number 9 in this field.
>>>
>>> This can be updated once we have more info on how the Version 
>>> encoding will look like in future.
>>>
>>> Idea of limiting regex to [0-9] for version is to enforce some checking!
>>
>> the version is a 4 bit value starting at 1 for SoundWire 1.0. There is 
>> nothing in the spec that talks about a limit to 9.
>>
>> It's unlikely we'll ever reach that but you are interpreting a spec 
>> here. plus just below you mention all fields as being hexadecimal.
>>
> Am happy to change this to
> 
> pattern: "^sdw[0-9a-f][0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
> 
> if you are okay with rest of the stuff.

yes, ok.

> 
> thanks,
> srini
>>>
>>> --srini
>>>
>>>>
>>>>> +      description:
>>>>> +      Is the textual representation of SoundWire Enumeration
>>>>> +      address. compatible string should contain SoundWire Version ID,
>>>>> +      Manufacturer ID, Part ID and Class ID in order and shall be in
>>>>> +      lower-case hexadecimal with leading zeroes.
>>>>> +      Valid sizes of these fields are
>>>>> +      Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
>>>>> +      and '0x2' represents SoundWire 1.1 and so on.
>>>>> +      MFD is 4 nibbles
>>>>> +      PID is 4 nibbles
>>>>> +      CID is 2 nibbles
>>>>> +      More Information on detail of encoding of these fields can be
>>>>> +      found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
>>>>> +
>>>>> +      reg:
>>>>> +        maxItems: 1
>>>>> +        description:
>>>>> +          Instance ID and Link ID of SoundWire Device Address.

maybe put link first and make it clear that both are required.

>>>>> +
>>>>> +    required:
>>>>> +      - compatible
>>>>> +      - reg
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    soundwire@c2d0000 {
>>>>> +        #address-cells = <2>;
>>>>> +        #size-cells = <0>;
>>>>> +        compatible = "qcom,soundwire-v1.5.0";
>>>>> +        reg = <0x0c2d0000 0x2000>;
>>>>> +
>>>>> +        speaker@1 {
>>>>> +            compatible = "sdw10217201000";
>>>>> +            reg = <1 0>;
>>>>> +        };
>>>>> +
>>>>> +        speaker@2 {
>>>>> +            compatible = "sdw10217201000";
>>>>> +            reg = <2 0>;
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +...
>>>>>
