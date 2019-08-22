From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: soundwire: add slave bindings
Date: Thu, 22 Aug 2019 13:56:05 +0100
Message-ID: <90b9fa33-3a49-c414-4352-66e26673a05d@linaro.org>
References: <20190809133407.25918-1-srinivas.kandagatla@linaro.org>
 <20190809133407.25918-2-srinivas.kandagatla@linaro.org>
 <20190821214436.GA13936@bogus>
 <0272eafd-0aa5-f695-64e4-f6ad7157a3a6@linaro.org>
 <CAL_JsqJJCJB9obR_Jn3hmn4gq+RQjY-8M+xkdYA185Uaw0MHcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJJCJB9obR_Jn3hmn4gq+RQjY-8M+xkdYA185Uaw0MHcw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Vinod <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



On 22/08/2019 13:36, Rob Herring wrote:
>>>> +soundwire@c2d0000 {
>>>> +    compatible = "qcom,soundwire-v1.5.0"
>>>> +    reg = <0x0c2d0000 0x2000>;
>>>> +
>>>> +    spkr_left:wsa8810-left{
>>>> +            compatible = "sdw0110217201000";
>>>> +            ...
>>>> +    };
>>>> +
>>>> +    spkr_right:wsa8810-right{
>>>> +            compatible = "sdw0120217201000";
>>> The normal way to distinguish instances is with 'reg'. So I think you
>>> need 'reg' with Instance ID moved there at least. Just guessing, but
>>> perhaps Link ID, too? And for 2 different classes of device is that
>>> enough?
>> In previous bindings (https://lists.gt.net/linux/kernel/3403276  ) we
>> did have instance-id as different property, however Pierre had some good
>> suggestion to make it align with _ADR encoding as per MIPI DisCo spec.
>>
>> Do you still think that we should split the instance id to reg property?
> Assuming you could have more than 1 of the same device on the bus,
> then you need some way to distinguish them and the way that's done for
> DT is unit-address/reg. And compatible strings should be constant for
> each instance.
That is a good point!
Okay that makes more sense keep compatible string constant.
Class ID would be constant for given functionality that the driver will 
provide.

So we will end up with some thing like this:

soundwire@c2d0000 {
	compatible = "qcom,soundwire-v1.5.0"
	reg = <0x0c2d0000 0x2000>;	
         #address-cells = <1>;
         #size-cells = <0>;

	spkr_left:skpr@1{
		compatible = "sdw10217201000";
		reg = <0x1>
		sdw-link-id = <0>;
		...
	};

	spkr_right:spkr@2{
		compatible = "sdw10217201000";
		reg = <0x2>
		sdw-link-id = <0>;
	};
};

I will spin this in next version!

Thanks,
srini

> 
> Rob
