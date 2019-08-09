From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: soundwire: add slave bindings
Date: Fri, 9 Aug 2019 09:25:00 +0100
Message-ID: <144f1ed7-c654-eaeb-066e-bf29d6e12d65@linaro.org>
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-2-srinivas.kandagatla@linaro.org>
 <d346b2af-f285-4c53-b706-46a129ab7951@linux.intel.com>
 <cdd2bded-551c-65f5-ca29-d2bb825bdaba@linaro.org>
 <20190808195216.GM3795@sirena.co.uk>
 <20190809045459.GG12733@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190809045459.GG12733@vkoul-mobl.Dlink>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, bgoswami@codeaurora.org, plai@codeaurora.org, robh+dt@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 09/08/2019 05:54, Vinod Koul wrote:
> On 08-08-19, 20:52, Mark Brown wrote:
>> On Thu, Aug 08, 2019 at 05:48:56PM +0100, Srinivas Kandagatla wrote:
>>> On 08/08/2019 16:58, Pierre-Louis Bossart wrote:
>>
>>>>> +- sdw-instance-id: Should be ('Instance ID') from SoundWire
>>>>> +          Enumeration Address. Instance ID is for the cases
>>>>> +          where multiple Devices of the same type or Class
>>>>> +          are attached to the bus.
>>
>>>> so it is actually required if you have a single Slave device? Or is it
>>>> only required when you have more than 1 device of the same type?
>>
>>> This is mandatory for any slave device!
>>
>> If it's mandatory the wording is a bit unclear.  How about something
>> like:
>>
>> 	Should be ('Instance ID') from the SoundWire Enumeration
>> 	Address.  This must always be provided, if multiple devices
>> 	with the same type or class or attached to the bus each
>> 	instance must have a distinct value.
> 
> That helps to make it clear.
> 
> Also the section of properties starts with Mandatory property, it should
> be made Mandatory Properties instead, like in other binding docs to make
> it clear that properties mentioned in the section are mandatory

Will update as suggested!

thanks,
srini
> 
