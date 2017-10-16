From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [Patch v6 3/7] slimbus: qcom: Add Qualcomm Slimbus controller
 driver
Date: Mon, 16 Oct 2017 10:28:17 +0100
Message-ID: <a6bc9ce9-4e08-41e5-4c3f-e8fb46bafa1c@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-4-srinivas.kandagatla@linaro.org>
 <20171013191747.o7bvb5urs5jt2x4l@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171013191747.o7bvb5urs5jt2x4l@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, gong.chen@linux.intel.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kheitke@audience.com, linux-arm-msm@vger.kernel.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org



On 13/10/17 20:17, Rob Herring wrote:
> On Fri, Oct 06, 2017 at 05:51:32PM +0200, srinivas.kandagatla@linaro.org wrote:
>> From: Sagar Dharia <sdharia@codeaurora.org>
>>
>> This controller driver programs manager, interface, and framer
>> devices for Qualcomm's slimbus HW block.
>> Manager component currently implements logical address setting,
>> and messaging interface.
>> Interface device reports bus synchronization information, and framer
>> device clocks the bus from the time it's woken up, until clock-pause
>> is executed by the manager device.
>>
>> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../devicetree/bindings/slimbus/slim-qcom-ctrl.txt |  43 ++
> 
> Version 6 and this is the first I see it? Where's the version history?

Its been a very long time (18 months) from v5-v6, I will try see if I 
can pull up some version history from past few year patches :-) before i 
send next version. If it helps review process.

> 
> Please split to separate patch.

Will do that in next version.

> 
>>   drivers/slimbus/Kconfig                            |   9 +
>>   drivers/slimbus/Makefile                           |   3 +
>>   drivers/slimbus/slim-qcom-ctrl.c                   | 594 +++++++++++++++++++++
>>   drivers/slimbus/slim-qcom.h                        |  63 +++
>>   5 files changed, 712 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
>>   create mode 100644 drivers/slimbus/slim-qcom-ctrl.c
>>   create mode 100644 drivers/slimbus/slim-qcom.h
>>
>> diff --git a/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
>> new file mode 100644
>> index 0000000..081110d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
>> @@ -0,0 +1,43 @@
>> +Qualcomm SLIMBUS controller
>> +This controller is used if applications processor driver controls slimbus
>> +master component.
>> +
>> +Required properties:
>> +
>> + - #address-cells - refer to Documentation/devicetree/bindings/slimbus/bus.txt
>> + - #size-cells	- refer to Documentation/devicetree/bindings/slimbus/bus.txt
>> +
>> + - reg : Offset and length of the register region(s) for the device
>> + - reg-names : Register region name(s) referenced in reg above
>> +	 Required register resource entries are:
>> +	 "ctrl": Physical adderess of controller register blocks
>> + - compatible : should be "qcom,<SOC-NAME>-slim" for SOC specific compatible or
>> + 		"qcom,slim" if using generic qcom SLIM IP.
> 
> No such thing as generic IP.Yep, i though I removed such instances, but it looks like there are 
still in more places, I will rescan for them before sending next version.
> 
> Fine as a fallback, but not by itself.
> 
>> + - interrupts : Interrupt number used by this controller
>> + - clocks : Interface and core clocks used by this slimbus controller
>> + - clock-names : Required clock-name entries are:
>> +	"iface_clk" : Interface clock for this controller
>> +	"core_clk" : Interrupt for controller core's BAM
> 
> _clk is redundant.
I agree, I will remove this suffixes in next version.

> 
>> +
>> +
>> +Optional property:
>> + - reg entry for slew rate : If slew rate control register is provided, this
>> +	entry should be used.
>> + - reg-name for slew rate: "slew"
> 
> Pointless to have -name when there is only one.
> 
I agree if it was just one.

Slew is optional resource, but as a whole there are 2 resources for the 
controller, so we need -name as there are 2 resources.

>> +
>> +Example:
>> +	slim@28080000 {
>> +		compatible = "qcom,slim";
>> +		#address-cells = <4>;
>> +		#size-cells = <0>;
>> +		reg = <0x28080000 0x2000>, <0x80207C 4>;
>> +		reg-names = "ctrl", "slew";
>> +		interrupts = <0 33 0>;
>> +		clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
>> +		clock-names = "iface_clk", "core_clk";
>> +
>> +		codec: wcd9310@1{
>> +			compatible = "slim217,60";
>> +			reg = <1 0>;
> 
> This would not compile. You don't have 4 cells here.

Yep, the example needs fixing.. address cells are actually 2.

> 
>> +		};
>> +	};
