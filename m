From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 01/10] ASoC: dt-bindings: add dt bindings for wcd9335
 audio codec
Date: Wed, 1 Aug 2018 09:56:59 +0100
Message-ID: <53a4e82c-7270-fdbd-a2ea-efbfc2d747a2@linaro.org>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-2-srinivas.kandagatla@linaro.org>
 <20180731204315.GA5265@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731204315.GA5265@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: lee.jones@linaro.org, broonie@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review.

On 31/07/18 21:43, Rob Herring wrote:
>> +
>> +- reset-gpio:
> reset-gpios
> 
Yep, reset-gpios makes more inline with others!
>> +	Usage: required
>> +	Value type: <String Array>
>> +	Definition: Reset gpio line
>> +
>> +- qcom,ifd:
>> +	Usage: required
>> +	Value type: <phandle>
>> +	Definition: SLIM interface device
> Wouldn't this be the parent?
> 
No, Interface device is just like other slim device and is part of 
SLIMbus Component and has a unique address. Every SLIMbus component has 
one interface device.
...
>> +
>> +codec@1{
> audio-codec@1
> 
Yep, I will fix this in next version.

>> +	compatible = "slim217,1a0";
>> +	reg  = <1 0>;

Thanks,
srini
