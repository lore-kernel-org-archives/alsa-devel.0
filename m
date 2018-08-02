From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 03/10] mfd: wcd9335: add wcd irq support
Date: Thu, 2 Aug 2018 11:07:29 +0100
Message-ID: <26123a18-ad12-b654-c3bf-4faba0aa0646@linaro.org>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-4-srinivas.kandagatla@linaro.org>
 <20180802080525.GM4662@dell>
 <74081a83-abcf-5529-babb-83a7b5242f68@linaro.org>
 <20180802100117.GQ4662@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180802100117.GQ4662@dell>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 02/08/18 11:01, Lee Jones wrote:
>>> Any particular reason for separating out IRQ handling?
>> No particular reason, I tried to follow what other codecs like wm8994,
>> wm8350 and 14 others do.
> I haven't look at them in a while, but maybe theirs are optional?
> 
> Either way, I don't think you need to do it.
Sure, I can merge them into core in next version.
> 
>>>>    include/dt-bindings/mfd/wcd9335.h   |  43 +++++++++
>>>>    include/linux/mfd/wcd9335/wcd9335.h |   3 +
>>>>    5 files changed, 228 insertions(+), 1 deletion(-)
>>>>    create mode 100644 drivers/mfd/wcd9335-irq.c
>>>>    create mode 100644 include/dt-bindings/mfd/wcd9335.h
>>>>
>>>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>>>> index a4697370640b..210875afe78a 100644
>>>> --- a/drivers/mfd/Makefile
>>>> +++ b/drivers/mfd/Makefile
>>>> @@ -58,7 +58,7 @@ obj-$(CONFIG_MFD_ARIZONA)	+= cs47l24-tables.o
>>>>    endif
>>>>    obj-$(CONFIG_MFD_WCD9335)	+= wcd9335.o
>>>> -wcd9335-objs			:= wcd9335-core.o
>>>> +wcd9335-objs			:= wcd9335-core.o wcd9335-irq.o
>>>>    obj-$(CONFIG_MFD_WM8400)	+= wm8400-core.o
>>>>    wm831x-objs			:= wm831x-core.o wm831x-irq.o wm831x-otp.o
>>>> diff --git a/drivers/mfd/wcd9335-core.c b/drivers/mfd/wcd9335-core.c
>>>> index 8f746901f4e9..6299dfb63aca 100644
>>>> --- a/drivers/mfd/wcd9335-core.c
>>>> +++ b/drivers/mfd/wcd9335-core.c
>>>> @@ -243,12 +243,20 @@ static int wcd9335_slim_status(struct slim_device *sdev,
>>>>    		return ret;
>>>>    	}
>>>> +	wcd9335_irq_init(wcd);
>>> Why don't you check the return value?
>>>
>>> What happens if it defers?
>>>
>> It would not defer here as the regmaps are already setup in probe and the
>> status callback is only invoked when the SLIMbus device is up.
> I guess now you have seen my comment below, you know that it can
> defer, right?

Yes, I see it can defer on gpios.

> 
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +// Copyright (c) 2018, Linaro Limited
>>>> +//
>>> Blank line?
>>>
>> Yep.
> Does "yep" mean, "I'll fix it"?
Yes, I mean I agree with you and will fix this in next version.

--srini
> 
> -- 
