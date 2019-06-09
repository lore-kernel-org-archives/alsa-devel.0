From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [RFC PATCH 5/6] dt-bindings: soundwire: add bindings
 for Qcom controller
Date: Sun, 9 Jun 2019 13:16:09 +0100
Message-ID: <7cde3f3b-5b42-5939-1ee8-8e1d57e9ec9f@linaro.org>
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-6-srinivas.kandagatla@linaro.org>
 <f2ea97b2-935d-0c7d-cb55-6e16a19c2060@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f2ea97b2-935d-0c7d-cb55-6e16a19c2060@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, broonie@kernel.org, vkoul@kernel.org
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, mark.rutland@arm.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for taking time to review,

On 07/06/2019 13:50, Pierre-Louis Bossart wrote:
> On 6/7/19 3:56 AM, Srinivas Kandagatla wrote:
>> This patch adds bindings for Qualcomm soundwire controller.
>>
>> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
>> either integrated as part of WCD audio codecs via slimbus or
>> as part of SOC I/O.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../bindings/soundwire/qcom,swr.txt           | 62 +++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/soundwire/qcom,swr.txt
> 
> you seem to use the 'swr' prefix in this patch. Most implementers use 
> 'sdw', and that's the default also used in the MIPI DisCo spec for 
> properties. Can we align on the same naming conventions?
> 
>>
>> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,swr.txt 
>> b/Documentation/devicetree/bindings/soundwire/qcom,swr.txt
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
>> +- compatible:        Must be "qcom,soundwire-v<MAJOR>.<MINOR>.<STEP>",
>> +             example:
>> +            "qcom,soundwire-v1.3.0"
>> +            "qcom,soundwire-v1.5.0"
>> +            "qcom,soundwire-v1.6.0"
>> +- reg:            SoundWire controller address space.
>> +- interrupts:        SoundWire controller interrupt.
>> +- clock-names:        Must contain "iface".
>> +- clocks:        Interface clocks needed for controller.
>> +- #sound-dai-cells:    Must be 1 for digital audio interfaces on the 
>> controllers.
>> +- #address-cells:    Must be 1 for SoundWire devices;
>> +- #size-cells:        Must be <0> as SoundWire addresses have no size 
>> component.
>> +- qcom,dout-ports:     Must be count of data out ports
>> +- qcom,din-ports:     Must be count of data in ports
>> +- qcom,ports-offset1:    Must be frame offset1 of each data port.
>> +            Out followed by In. Used for Block size calculation.
>> +- qcom,ports-offset2:     Must be frame offset2 of each data port.
>> +            Out followed by In. Used for Block size calculation.
>> +- qcom,ports-sinterval-low: Must be sample interval low of each data 
>> port.
>> +            Out followed by In. Used for Sample Interval calculation.
> 
> These definitions are valid only for specific types of ports, I believe 
> here it's a 'reduced' port since offset2 is not required for simpler 
> ports and you don't have Hstart/Hstop.
> 
Yes, this version of the controller which am working on does not have 
DPN_SampleCtrl2 register for SampleIntervalHigh Field and has registers 
for programming offset2 does indeed indicate that these ports are 
reduced ports.

However looks like new versions of the this controller does support full 
data ports.

I can add more flexibility in bindings by adding qcom,dport-type field 
indicating this in next version.

> so if you state that all of these properties are required, you are 
> explicitly ruling out future implementations of simple ports or will 
> have to redefine them later.
> 
> Also the definition 'frame offset1/2' is incorrect. the offset is 
> defined within each Payload Transport Window - not each frame - and its 
> definition depends on the packing mode used, which isn't defined or 
> stated here.

Yep, BlockPackingMode is missing. 1.3 version of this controller only 
supports Block Per Port Block mode.

I guess this can be derived with in the driver by using compatible 
string, I can add some notes in the binding to make this more explicit.
I will also reword offset1/2 description to include transport window 
within frame

> 
> And last it looks like you assume a fixed frame shape - likely 50 rows 
> by 8 columns, it might be worth adding a note on the max values for 
> offset1/2 implied by this frame shape.

Its 48x16 in this case.


Thanks,
srini
