From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [PATCH v10 08/13] regmap: add SLIMbus support
Date: Thu, 14 Dec 2017 13:16:13 +0000
Message-ID: <682e689d-d196-fe38-fc6f-e51a981ee18e@linaro.org>
References: <20171211234307.14465-1-srinivas.kandagatla@linaro.org>
 <20171211234307.14465-9-srinivas.kandagatla@linaro.org>
 <20171213092537.GB12631@kroah.com> <20171213160611.GO6416@sirena.org.uk>
 <20171214051739.GV18649@localhost> <s5h6099yb4p.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h6099yb4p.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org, j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, pombredanne@nexb.com, sdharia@codeaurora.org
List-Id: alsa-devel@alsa-project.org



On 14/12/17 08:19, Takashi Iwai wrote:
> On Thu, 14 Dec 2017 06:17:39 +0100,
> Vinod Koul wrote:
>>
>> On Wed, Dec 13, 2017 at 04:06:11PM +0000, Mark Brown wrote:
>>>> On Mon, Dec 11, 2017 at 11:43:02PM +0000, srinivas.kandagatla@linaro.org wrote:
>>>
>>>> Mark, can I get an Ack for this patch so I can take it through my tree
>>>> with the other patches in this series?
>>>
>>> I'm actually not seeing a direct dependency here (there's a depends in
>>> place stopping the regmap code building if the Slimbus core isn't
>>> enabled) so if you want you can go ahead and apply the main stuff and I
>>> can apply the regmap change separately, it'll avoid Makefile/Kconfig
>>> conflicts anyway.
>>
>> + Takashi
>>
>> FWIW, since this is another MIPI Audio specfic bus, would it make sense for
>> this series to go thru sound/ tree? I have discussed with Takashi and Greg
>> for soundwire and we are taking sound path.
>>
>> Would that be okay here too? Either ways I dont mind :)
> 
> Me too, I don't mind who takes what.
> Just let me know.
> 

It was implied early that Greg would pick up the main stuff and Mark can 
apply regmap separately to avoid Makefile/Kconfig conflicts.

Lets keep it that way to avoid anymore confusion.

Thanks,
srini


> 
> thanks,
> 
> Takashi
> 
