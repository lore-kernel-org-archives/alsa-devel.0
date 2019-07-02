From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 1/5] dt-bindings: soundwire: add slave bindings
Date: Tue, 2 Jul 2019 09:22:01 +0100
Message-ID: <ce1e445e-3254-1308-8752-2cb56a7e0cc6@linaro.org>
References: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
 <20190611104043.22181-2-srinivas.kandagatla@linaro.org>
 <20190701061155.GJ2911@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190701061155.GJ2911@vkoul-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, bgoswami@quicinc.com
List-Id: alsa-devel@alsa-project.org

Thanks Vinod for taking time to review,

On 01/07/2019 07:11, Vinod Koul wrote:
> On 11-06-19, 11:40, Srinivas Kandagatla wrote:
>> This patch adds bindings for Soundwire Slave devices which includes how
>> SoundWire enumeration address is represented in SoundWire slave device
>> tree nodes.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../devicetree/bindings/soundwire/bus.txt     | 48 +++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soundwire/bus.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soundwire/bus.txt b/Documentation/devicetree/bindings/soundwire/bus.txt
>> new file mode 100644
>> index 000000000000..19a672b0d528
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soundwire/bus.txt
> 
> The bindings are for slave right and the file is bus.txt?

I tried to follow what I have done for SLIMBus.
Do you prefer them to be documented in slave.txt?

> 
>> @@ -0,0 +1,48 @@
>> +SoundWire bus bindings.
>> +
>> +SoundWire is a 2-pin multi-drop interface with data and clock line.
>> +It facilitates development of low cost, efficient, high performance systems.
>> +
>> +SoundWire controller bindings are very much specific to vendor.
>> +
>> +Child nodes(SLAVE devices):
>> +Every SoundWire controller node can contain zero or more child nodes
>> +representing slave devices on the bus. Every SoundWire slave device is
>> +uniquely determined by the enumeration address containing 5 fields:
>> +SoundWire Version, Instance ID, Manufacturer ID, Part ID and Class ID
>> +for a device. Addition to below required properties, child nodes can
>> +have device specific bindings.
>> +
>> +Required property for SoundWire child node if it is present:
>> +- compatible:	 "sdwVER,MFD,PID,CID". The textual representation of
>> +		  SoundWire Enumeration address comprising SoundWire
>> +		  Version, Manufacturer ID, Part ID and Class ID,
>> +		  shall be in lower-case hexadecimal with leading
>> +		  zeroes suppressed.
>> +		  Version number '0x10' represents SoundWire 1.0
>> +		  Version number '0x11' represents SoundWire 1.1
>> +		  ex: "sdw10,0217,2010,0"
> 
> any reason why we want to code version number and not say sdw,1.0,...
> and so on?

For consistency reasons, as other info in hex.

> 
>> +
>> +- sdw-instance-id: Should be ('Instance ID') from SoundWire
>> +		  Enumeration Address. Instance ID is for the cases
>> +		  where multiple Devices of the same type or Class
>> +		  are attached to the bus.
> 
> instance id is part of the 48bit device id, so wont it make sense to add
> that to compatible as well?
> 
So we could have multiple instance of same IP, so adding this to 
compatible string does not make sense! As driver has to list all the 
possible compatible strings.

>> +
>> +SoundWire example for Qualcomm's SoundWire controller:
>> +
>> +soundwire@c2d0000 {
>> +	compatible = "qcom,soundwire-v1.5.0"
>> +	reg = <0x0c2d0000 0x2000>;
>> +
>> +	spkr_left:wsa8810-left{
>> +		compatible = "sdw10,0217,2010,0";
>> +		sdw-instance-id = <1>;
>> +		...
>> +	};
>> +
>> +	spkr_right:wsa8810-right{
>> +		compatible = "sdw10,0217,2010,0";
>> +		sdw-instance-id = <2>;
>> +		...
>> +	};
>> +};
>> -- 
>> 2.21.0
> 
