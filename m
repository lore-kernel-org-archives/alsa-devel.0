From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [Patch v6 1/7] slimbus: Device management on
	SLIMbus
Date: Mon, 16 Oct 2017 10:28:13 +0100
Message-ID: <4c9a34a7-d865-b363-d899-348e06e6c113@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-2-srinivas.kandagatla@linaro.org>
 <20171013192643.lw6w2qs2bcs66hyx@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id BA08D266DCF
 for <alsa-devel@alsa-project.org>; Mon, 16 Oct 2017 11:28:16 +0200 (CEST)
Received: by mail-wm0-f51.google.com with SMTP id m72so1095780wmc.1
 for <alsa-devel@alsa-project.org>; Mon, 16 Oct 2017 02:28:16 -0700 (PDT)
In-Reply-To: <20171013192643.lw6w2qs2bcs66hyx@rob-hp-laptop>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, andreas.noever@gmail.com, gong.chen@linux.intel.com, arnd@arndb.de, kheitke@audience.com, treding@nvidia.com, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, broonie@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, bp@suse.de, mathieu.poirier@linaro.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, jkosina@suse.cz, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org



On 13/10/17 20:26, Rob Herring wrote:
> On Fri, Oct 06, 2017 at 05:51:30PM +0200, srinivas.kandagatla@linaro.org wrote:
>> From: Sagar Dharia <sdharia@codeaurora.org>
>>
>> SLIMbus (Serial Low Power Interchip Media Bus) is a specification
>> developed by MIPI (Mobile Industry Processor Interface) alliance.
>> SLIMbus is a 2-wire implementation, which is used to communicate with
>> peripheral components like audio-codec.
>> SLIMbus uses Time-Division-Multiplexing to accommodate multiple data
>> channels, and control channel. Control channel has messages to do
>> device-enumeration, messages to send/receive control-data to/from
>> slimbus devices, messages for port/channel management, and messages to
>> do bandwidth allocation.
>> The framework supports multiple instances of the bus (1 controller per
>> bus), and multiple slave devices per controller.
>>
>> This patch does device enumeration, logical address assignment,
>> informing device when the device reports present/absent etc.
>> Reporting present may need the driver to do the needful (e.g. turning
>> on voltage regulators powering the device). Additionally device is
>> probed when it reports present if that device doesn't need any such
>> steps mentioned above.
>>
>> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/slimbus/bus.txt |  57 ++
> 
> Split to separate patch.

Will do this in next patch.
It was suggested by Arnd in v5, may be just of_parse code can be merged 
in this patch and the bindings made as separate patch.


> 
>>   Documentation/slimbus/summary                     | 109 ++++
>>   drivers/Kconfig                                   |   2 +
>>   drivers/Makefile                                  |   1 +
>>   drivers/slimbus/Kconfig                           |  11 +
>>   drivers/slimbus/Makefile                          |   5 +
>>   drivers/slimbus/slim-core.c                       | 695 ++++++++++++++++++++++
>>   include/linux/mod_devicetable.h                   |  13 +
>>   include/linux/slimbus.h                           | 299 ++++++++++
>>   9 files changed, 1192 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt
>>   create mode 100644 Documentation/slimbus/summary
>>   create mode 100644 drivers/slimbus/Kconfig
>>   create mode 100644 drivers/slimbus/Makefile
>>   create mode 100644 drivers/slimbus/slim-core.c
>>   create mode 100644 include/linux/slimbus.h
>>
>> diff --git a/Documentation/devicetree/bindings/slimbus/bus.txt b/Documentation/devicetree/bindings/slimbus/bus.txt
>> new file mode 100644
>> index 0000000..cb658bb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/slimbus/bus.txt
>> @@ -0,0 +1,57 @@
>> +SLIM(Serial Low Power Interchip Media Bus) bus
>> +
>> +SLIMbus is a 2-wire bus, and is used to communicate with peripheral
>> +components like audio-codec.
>> +
>> +Controller is a normal device using binding for whatever bus it is
>> +on (e.g. platform bus).
> 
> I can't have a PCI based slimbus controller? "platform bus" is a
> Linuxism.
I agree, Will remove this Linuxism from the bindings.

> 
>> +Required property for SLIMbus controller node:
>> +- compatible	- name of SLIMbus controller following generic names
>> +		recommended practice.
> 
> generic names aren't recommended. Allowed with some conditons, yes.
> 
>> +- #address-cells - should be 2
> 
> You used 4 for your controller.

It should be actually 2. I will fix such mismatches in the other patches.

> 
>> +- #size-cells	- should be 0
>> +
>> +No other properties are required in the SLIMbus controller bus node.
> 
> That's not a useful statement. Almost every controller probably has
> other required properties.
Yep, will get rid of this in next patch.
> 
>> +
>> +Child nodes:
>> +Every SLIMbus controller node can contain zero or more child nodes
>> +representing slave devices on the bus. Every SLIMbus slave device is
>> +uniquely determined by the enumeration address containing 4 fields:
>> +Manufacturer ID, Product code, Device index, and Instance value for
>> +the device.
>> +If child node is not present and it is instantiated after device
>> +discovery (slave device reporting itself present).
>> +
>> +In some cases it may be necessary to describe non-probeable device
>> +details such as non-standard ways of powering up a device. In
>> +such cases, child nodes for those devices will be present as
>> +slaves of the slimbus-controller, as detailed below.
>> +
>> +Required property for SLIMbus child node if it is present:
>> +- reg		- Is Duplex (Device index, Instance ID) from Enumeration
>> +		  Address.
>> +		  Device Index Uniquely identifies multiple Devices within
>> +		  a single Component.
>> +		  Instance ID Is for the cases where multiple Devices of the
>> +		  same type or Class are attached to the bus.
>> +
>> +- compatible	-"slimMID,PID". The textual representation of Manufacturer ID,
>> +	 	  Product Code, shall be in lower case hexadecimal with leading
>> +		  zeroes suppressed
>> +
>> +SLIMbus example for Qualcomm's slimbus manager component:
>> +
>> +	slim@28080000 {
>> +		compatible = "qcom,slim-msm";
>> +		reg = <0x28080000 0x2000>,
>> +		interrupts = <0 33 0>;
>> +		clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
>> +		clock-names = "iface_clk", "core_clk";
>> +		#address-cells = <2>;
>> +		#size-cells = <0>;
>> +
>> +		codec: wcd9310@1{
> 
> Is '1' by itself unique enough because you have 2 address cells. The
> unit-address is typically split up into fields with commas unless it's
> just a memory address. Anyway, you need to define the unit address
> format in this doc.
> 
Yep, this examples should be fixed with proper unit address which is 
formed by "device-id,instance-id"

device id + Instance ID makes it unique, I though I already added 
details the reg property.




>> +			compatible = "slim217,60"";
>> +			reg = <1 0>;
>> +		};
>> +	};
