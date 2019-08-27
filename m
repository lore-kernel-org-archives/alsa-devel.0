From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [RESEND PATCH v4 1/4] dt-bindings: soundwire: add
 slave bindings
Date: Tue, 27 Aug 2019 22:21:10 +0100
Message-ID: <aaf1a8f6-9be5-2d42-9f92-4fd75986424d@linaro.org>
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
 <20190822233759.12663-2-srinivas.kandagatla@linaro.org>
 <7da8aa89-2119-21d1-0e29-8894a8d40bf0@linux.intel.com>
 <37be6b6d-7e7f-2cd6-f9e9-f0cac48791ad@linaro.org>
 <d538238d-25d8-f179-c900-90be50ce814d@linux.intel.com>
 <7ee47f26-12f8-6028-cb83-7f59e669979f@linaro.org>
 <e5b184be-02f1-faa4-94fa-79bda8936d9d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e5b184be-02f1-faa4-94fa-79bda8936d9d@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, spapothi@codeaurora.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 26/08/2019 17:22, Pierre-Louis Bossart wrote:
>>>>>
>>>>>> +      description:
>>>>>> +      Is the textual representation of SoundWire Enumeration
>>>>>> +      address. compatible string should contain SoundWire Version 
>>>>>> ID,
>>>>>> +      Manufacturer ID, Part ID and Class ID in order and shall be in
>>>>>> +      lower-case hexadecimal with leading zeroes.
>>>>>> +      Valid sizes of these fields are
>>>>>> +      Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
>>>>>> +      and '0x2' represents SoundWire 1.1 and so on.
>>>>>> +      MFD is 4 nibbles
>>>>>> +      PID is 4 nibbles
>>>>>> +      CID is 2 nibbles
>>>>>> +      More Information on detail of encoding of these fields can be
>>>>>> +      found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
>>>>>> +
>>>>>> +      reg:
>>>>>> +        maxItems: 1
>>>>>> +        description:
>>>>>> +          Instance ID and Link ID of SoundWire Device Address.
> 
> maybe put link first and make it clear that both are required.
Okay, I will give that a go in next version!

thanks,
srini
