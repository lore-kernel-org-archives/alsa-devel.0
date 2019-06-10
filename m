From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 5/6] dt-bindings: soundwire: add bindings
 for Qcom controller
Date: Mon, 10 Jun 2019 08:58:55 -0500
Message-ID: <c6829f76-f119-31d5-c3eb-506e2d50f298@linux.intel.com>
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-6-srinivas.kandagatla@linaro.org>
 <20190610045150.GJ9160@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610045150.GJ9160@vkoul-mobl.Dlink>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, mark.rutland@arm.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


>> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,swr.txt b/Documentation/devicetree/bindings/soundwire/qcom,swr.txt
>> new file mode 100644
>> index 000000000000..eb84d0f4f36f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soundwire/qcom,swr.txt
>> @@ -0,0 +1,62 @@
>> +Qualcomm SoundWire Controller
>> +
>> +This binding describes the Qualcomm SoundWire Controller Bindings.
>> +
>> +Required properties:
>> +
>> +- compatible:		Must be "qcom,soundwire-v<MAJOR>.<MINOR>.<STEP>",
>> +	 		example:
>> +			"qcom,soundwire-v1.3.0"
>> +			"qcom,soundwire-v1.5.0"
>> +			"qcom,soundwire-v1.6.0"
>> +- reg:			SoundWire controller address space.
>> +- interrupts:		SoundWire controller interrupt.
>> +- clock-names:		Must contain "iface".
>> +- clocks:		Interface clocks needed for controller.
>> +- #sound-dai-cells:	Must be 1 for digital audio interfaces on the controllers.
>> +- #address-cells:	Must be 1 for SoundWire devices;
>> +- #size-cells:		Must be <0> as SoundWire addresses have no size component.
>> +- qcom,dout-ports: 	Must be count of data out ports
>> +- qcom,din-ports: 	Must be count of data in ports
> 
> On these I think we should have specified dpn properties as specified in
> DisCo, but then looking at spec we do not define that for master, but
> bus seems to have it.
> 
> Pierre do you why master does not have dpn properties in DisCo?

Because there are no DP0 or DPn registers defined for Masters in the 
SoundWire 1.x spec. DisCo is about specifying properties for standard 
registers, when they are not standard vendor extensions need to come 
into play.

> 
>> +- qcom,ports-offset1:	Must be frame offset1 of each data port.
>> +			Out followed by In. Used for Block size calculation.
>> +- qcom,ports-offset2: 	Must be frame offset2 of each data port.
>> +			Out followed by In. Used for Block size calculation.
>> +- qcom,ports-sinterval-low: Must be sample interval low of each data port.
>> +			Out followed by In. Used for Sample Interval calculation.
> 
> These are software so do not belong here

Not necessarily. They define the allocation expected on that link and I 
see no problem specifying those values here. It's the moral equivalent 
of specifying which TDM slots and the bit depth of one slot you'd use 
for DSP_A/B.
And if you push back, then what would be your alternate proposal on 
where those values might be stored? This is a very specific usage of the 
link and it makes sense to me to have the information in firmware - 
exposed with properties - rather than hard-coded in a pretend bus 
allocation routine in the kernel. Either the allocation is fully dynamic 
and it's handled by the kernel or it's static and it's better to store 
it in firmware to deal with platform-to-platform variations.
