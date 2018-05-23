From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] slimbus: ngd: dt-bindings: Add slim ngd dt bindings
Date: Wed, 23 May 2018 18:17:23 +0100
Message-ID: <94271b39-37f4-16c5-db35-782bbbc9d851@linaro.org>
References: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
 <20180516165118.16551-2-srinivas.kandagatla@linaro.org>
 <20180523164023.GA24671@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180523164023.GA24671@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: gregkh@linuxfoundation.org, kramasub@codeaurora.org, sdharia@quicinc.com, girishm@quicinc.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Rob for review,

On 23/05/18 17:40, Rob Herring wrote:
> On Wed, May 16, 2018 at 05:51:17PM +0100, Srinivas Kandagatla wrote:
>> This patch adds bindings for Qualcomm SLIMBus NGD controller found in
>> all new SoCs starting from B family.
>> SLIMBus NGD controller is a light-weight driver responsible for
>> communicating with SLIMBus slaves directly over the bus using messaging
>> interface and communicating with master component residing on ADSP for
>> bandwidth and data-channel management
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        | 70 ++++++++++++++++++++++
>>   1 file changed, 70 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
>>
>> diff --git a/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
>> new file mode 100644
>> index 000000000000..c948fb098819
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
>> @@ -0,0 +1,70 @@
>> +Qualcomm SLIMBus Non Generic Device (NGD) Controller binding
>> +
>> +SLIMBus NGD controller is a light-weight driver responsible for communicating
>> +with SLIMBus slaves directly over the bus using messaging interface and
>> +communicating with master component residing on ADSP for bandwidth and
>> +data-channel management
>> +
>> +Please refer to slimbus/bus.txt for details of the common SLIMBus bindings.
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,slim-ngd"
> 
> SoC specific compatible needed.

Yes, I will add that in v2.
> 
>> +
>> +- reg:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: must specify the base address and size of the controller
>> +		    register blocks.
> 
> blocks? Is there more than one? If so, how many?
Its just one. I will fix the text to reflect this.

> 
>> +
>> +- reg-names:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "ctrl"
> 
> reg-names is pointless when there is only 1.
> 
>> +
>> +- qcom,ngd-id
>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: ngd instance id in the controller
> 
> Why do you need this?
I have removed this totally in my next version, which I will be posting 
soon.

Thanks,
srini
