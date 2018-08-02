From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 01/10] ASoC: dt-bindings: add dt bindings for wcd9335
 audio codec
Date: Thu, 2 Aug 2018 08:33:47 +0100
Message-ID: <4c821ce9-6268-150f-2ab0-358f5b312ec0@linaro.org>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-2-srinivas.kandagatla@linaro.org>
 <20180731204315.GA5265@rob-hp-laptop>
 <53a4e82c-7270-fdbd-a2ea-efbfc2d747a2@linaro.org>
 <CAL_JsqKcxB2NZR94BP9-Qc8AAFsySPoADm2UA_ZV8V7JdP8-wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKcxB2NZR94BP9-Qc8AAFsySPoADm2UA_ZV8V7JdP8-wQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Banajit Goswami <bgoswami@codeaurora.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vinod <vkoul@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks for review,

On 01/08/18 23:20, Rob Herring wrote:
>>>> +- qcom,ifd:
>>>> +    Usage: required
>>>> +    Value type: <phandle>
>>>> +    Definition: SLIM interface device
>>> Wouldn't this be the parent?
>>>
>> No, Interface device is just like other slim device and is part of
>> SLIMbus Component and has a unique address. Every SLIMbus component has
>> one interface device.
> I still don't understand what this means. If this is SLIMbus specific,
> then maybe it should be named that way? Or it is QCom specific?

It is SLIMbus specific, I will rename this to "slim,ifd" in next version 
which makes it clear!

thanks,
srini
