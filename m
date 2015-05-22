From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 01/10] ASoC: qcom: make lpass driver depend on OF
Date: Fri, 22 May 2015 14:50:50 +0100
Message-ID: <555F343A.3040009@linaro.org>
References: <1432245125-8939-1-git-send-email-srinivas.kandagatla@linaro.org> <2534276.hIjFJK74Zh@wuerfel> <555F18C8.8090902@linaro.org> <2125335.kSmCnV68xe@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <2125335.kSmCnV68xe@wuerfel>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 22/05/15 14:21, Arnd Bergmann wrote:
> On Friday 22 May 2015 12:53:44 Srinivas Kandagatla wrote:
>> Thanks for looking at this patch.
>>
>> On 22/05/15 08:24, Arnd Bergmann wrote:
>>> On Thursday 21 May 2015 22:52:41 Srinivas Kandagatla wrote:
>>>>
>>>>    config SND_SOC_LPASS_CPU
>>>>           tristate
>>>> +       depends on OF
>>>>           select REGMAP_MMIO
>>>>
>>>>    config SND_SOC_LPASS_PLATFORM
>>>>           tristate
>>>> +       depends on OF
>>>>           select REGMAP_MMIO
>>>>
>>>>    config SND_SOC_LPASS_IPQ806X
>>>>
>>>
>>> Could you instead make the drivers compile without OF being set?
>>>
>>> I see that patch 7 and 8 introduces another two options doing
>>>
>>>
>>> +config SND_SOC_LPASS_APQ8016
>>> +       tristate
>>> +       depends on SND_SOC_QCOM
>>> +       select SND_SOC_LPASS_CPU
>>> +       select SND_SOC_LPASS_PLATFORM
>>> +
>>>
>>> +config SND_SOC_APQ8016_SBC
>>> +       tristate "SoC Audio support for APQ8016 SBC platforms"
>>> +       depends on (ARCH_QCOM && SND_SOC_QCOM) || COMPILE_TEST
>>> +       select SND_SOC_LPASS_APQ8016
>>> +       help
>>>
>>> so you get an obvious build failure here when SND_SOC_APQ8016_SBC
>>> gets selected with COMPILE_TEST on a platform that does not support OF.
>>>
>>
>> Yes, this would fail.
>> I think moving of_device_id structures in drivers under #ifdef CONFIG_OF
>> and removing the depends on OF would fix it.
>>
>
> Why?

Yes, you are correct we don't need the ifdef's anymore. I will send a 
fixup patch on top of what Mark has already applied.

--srini
>
> 	Arnd
>
>
