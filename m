From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 10/13] ASoC: dt-bindings: Add WCD9335 MBHC specific
 properties
Date: Wed, 12 Sep 2018 08:44:01 +0100
Message-ID: <7de84d92-bc35-d0ea-217c-403ff2f28ee7@linaro.org>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
 <20180904102500.30318-11-srinivas.kandagatla@linaro.org>
 <20180910200652.GA20896@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910200652.GA20896@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: lee.jones@linaro.org, broonie@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for your review,

On 10/09/18 21:06, Rob Herring wrote:
> On Tue, Sep 04, 2018 at 11:24:57AM +0100, Srinivas Kandagatla wrote:
>> This patch add new bindings required to support MBHC
>> (Multi Button Headset Control) block in the codec.
>> This block is used for jack insert/removal detection,
>> headset type detection and 8 button press/release events.
>>
>> All these properties are very much specific to board.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../bindings/sound/qcom,wcd9335.txt           | 20 +++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
>> index 5d6ea66a863f..4d56c3ca9fa8 100644
>> --- a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
>> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
>> @@ -55,6 +55,26 @@ Required properties with SLIMbus Interface:
>>   	Value type: <string>
>>   	Definition: Must contain "mclk", "mclk2" and "slimbus" strings.
>>   
>> +- o qcom,mbhc-vthreshold:
> 
> Needs unit suffix.

Make sense, I will modify it

qcom,mbhc-vthreshold-millivolt

 >
> 
>> +	Usage: Optional, only required if headset button support required.
>> +	Value type: <u32 array>
>> +	Definition: Must contain an array of 8 threshold voltages in mV for
>> +		 8 buttons detection on headset.
>> +
>> +- qcom,hphl-jack-type-normally-open:
>> +	Usage: Optional, only required if headset button support required.
> 
> It's not required if the pin is NC, right?


> 
>> +	Value type: <boolean>
>> +	Definition: present if hphl pin on jack is a NO (Normally Open).
>> +		If not specified, then its assumed that hphl pin on jack
>> +		is NC (Normally Closed).
> 
> Is the not specified case the more common case? If not, it should be.
Yes, that is correct. In normal uscases we do not need these properties.
> 
>> +
>> +- qcom,gnd-jack-type-normally-open:
>> +	Usage: Optional, only required if headset button support required.
> 
> Same here.

> 
>> +	Value type: <boolean>
>> +	Definition: present if gnd pin on jack is NO (Normally Open).
>> +		 If not specified, then its assumed that gnd pin on
>> +		 jack is NC  (Normally Closed).
>> +
>>   - vdd-buck-supply:
>>   	Usage: required
>>   	Value type: <phandle>
>> -- 
>> 2.18.0
>>
