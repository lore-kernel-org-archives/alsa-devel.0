From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: soundwire: add slave bindings
Date: Thu, 22 Aug 2019 11:12:07 +0100
Message-ID: <0272eafd-0aa5-f695-64e4-f6ad7157a3a6@linaro.org>
References: <20190809133407.25918-1-srinivas.kandagatla@linaro.org>
 <20190809133407.25918-2-srinivas.kandagatla@linaro.org>
 <20190821214436.GA13936@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190821214436.GA13936@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: vkoul@kernel.org, broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org, pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 21/08/2019 22:44, Rob Herring wrote:
> On Fri, Aug 09, 2019 at 02:34:04PM +0100, Srinivas Kandagatla wrote:
>> This patch adds bindings for Soundwire Slave devices that includes how
>> SoundWire enumeration address and Link ID are used to represented in
>> SoundWire slave device tree nodes.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../devicetree/bindings/soundwire/slave.txt   | 51 +++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soundwire/slave.txt
> 
> Can you convert this to DT schema given it is a common binding.
> 

I will give that a go in next version!

> What does the host controller look like? You need to define the node
> hierarchy. Bus controller schemas should then include the bus schema.
> See spi-controller.yaml.

Host controller is always parent of these devices which is represented 
in the example.

In my previous patches, i did put this slave bindings in bus.txt, but 
Vinod suggested to move it to slave.txt.

Are you suggesting to add two yamls here, one for slave and one for bus
Or just document this in one bus bindings?


> 
>>
>> diff --git a/Documentation/devicetree/bindings/soundwire/slave.txt b/Documentation/devicetree/bindings/soundwire/slave.txt
>> new file mode 100644
>> index 000000000000..201f65d2fafa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soundwire/slave.txt
>> @@ -0,0 +1,51 @@
>> +SoundWire slave device bindings.
>> +
>> +SoundWire is a 2-pin multi-drop interface with data and clock line.
>> +It facilitates development of low cost, efficient, high performance systems.
>> +
>> +SoundWire slave devices:
>> +Every SoundWire controller node can contain zero or more child nodes
>> +representing slave devices on the bus. Every SoundWire slave device is
>> +uniquely determined by the enumeration address containing 5 fields:
>> +SoundWire Version, Instance ID, Manufacturer ID, Part ID
>> +and Class ID for a device. Addition to below required properties,
>> +child nodes can have device specific bindings.
>> +
>> +Required properties:
>> +- compatible:	 "sdw<LinkID><VersionID><InstanceID><MFD><PID><CID>".
>> +		  Is the textual representation of SoundWire Enumeration
>> +		  address along with Link ID. compatible string should contain
>> +		  SoundWire Link ID, SoundWire Version ID, Instance ID,
>> +		  Manufacturer ID, Part ID and Class ID in order
>> +		  represented as above and shall be in lower-case hexadecimal
>> +		  with leading zeroes. Vaild sizes of these fields are
>> +		  LinkID is 1 nibble,
>> +		  Version ID is 1 nibble
>> +		  Instance ID in 1 nibble
>> +		  MFD in 4 nibbles
>> +		  PID in 4 nibbles
>> +		  CID is 2 nibbles
>> +
>> +		  Version number '0x1' represents SoundWire 1.0
>> +		  Version number '0x2' represents SoundWire 1.1
> 
> This can all be a regex.
> 
>> +		  ex: "sdw0110217201000" represents 0 LinkID,
>> +		  SoundWire 1.0 version slave with Instance ID 1.
>> +		  More Information on detail of encoding of these fields can be
>> +		  found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
>> +
>> +SoundWire example for Qualcomm's SoundWire controller:
>> +
>> +soundwire@c2d0000 {
>> +	compatible = "qcom,soundwire-v1.5.0"
>> +	reg = <0x0c2d0000 0x2000>;
>> +
>> +	spkr_left:wsa8810-left{
>> +		compatible = "sdw0110217201000";
>> +		...
>> +	};
>> +
>> +	spkr_right:wsa8810-right{
>> +		compatible = "sdw0120217201000";
> 
> The normal way to distinguish instances is with 'reg'. So I think you
> need 'reg' with Instance ID moved there at least. Just guessing, but
> perhaps Link ID, too? And for 2 different classes of device is that
> enough?

In previous bindings ( https://lists.gt.net/linux/kernel/3403276 ) we 
did have instance-id as different property, however Pierre had some good 
suggestion to make it align with _ADR encoding as per MIPI DisCo spec.

Do you still think that we should split the instance id to reg property?

Thanks,
srini

> 
> Rob
> 
