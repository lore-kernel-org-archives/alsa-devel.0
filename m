From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: ASoC: Intel: sst: Missing IRQ at index 5 on BYT-T
 device
Date: Mon, 17 Dec 2018 20:13:36 -0600
Message-ID: <86b92282-5bc1-b8de-93e7-97e7ee17db4b@linux.intel.com>
References: <20181216185429.GA20408@gerhold.net>
 <3b96d716-1d9f-a569-2afa-82b386e752e4@linux.intel.com>
 <20181217181729.GB845@gerhold.net>
 <b3cf2bc5-bde3-3c3d-fd6a-ff426281563c@linux.intel.com>
 <20181217191054.GA10938@gerhold.net>
 <d5755c1c-f9d6-5bed-73ee-00a24d36fccc@linux.intel.com>
 <20181217203242.GB10938@gerhold.net> <20181217204320.GC10938@gerhold.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 80D942678D4
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 03:13:41 +0100 (CET)
In-Reply-To: <20181217204320.GC10938@gerhold.net>
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
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


>>>> The quirks to get sound working with bytcr-rt5640 on that device are:
>>>> BYT_RT5640_SSP0_AIF1 | BYT_RT5640_IN1_MAP | BYT_RT5640_MCLK_EN
>>>>
>>>> I guess this means that SSP0 is being used?
>>> Yes indeed, and that makes me think we should force this device to look like
>>> Baytrail-CR.
>>>
>>> You can do this with a DMI-based quirk (preferably in is_byt_cr directly so
>>> that I can reuse the code when I move it to a helper at some point).
>> Okay - thanks! One last question:
>> I was looking at the ACPI DSDT tables of some similar devices and have
>> found two others that look the same (only one IRQ listed). In this case,
>> the BYT-T acpi_ipc_irq_index = 5 will never work, and we will definitely
>> have a better chances with trying Baytrail-CR.
>>
>> One of them actually had a similar patch proposed at [1] (although they
>> did it in a weird way and also need an extra machine driver).
>>
>> We could also detect this situation in a generic way with something like
>>
>>    if (platform_irq_count(pdev) == 1) {
>>    	*bytcr = true;
>> 	return 0;
>>    }
>>
>> ... instead of a DMI quirk. What do you think?
>>
> To avoid confusion: The existing PMIC-type based is_byt_cr() detection
> would be used in all other cases (i.e. if irq_count != 1), so it won't
> make any difference for the devices that are already working fine.
> (Most BYT-CR devices seem to have 5 IRQs listed)
>
> So it's more like
>
>    if (platform_irq_count(pdev) == 1) {
>    	*bytcr = true;
>    } else {
>    	// pmic-type based detection...
>    }
>
> with platform_irq_count == 1 as condition for the "quirk".

The solution seems appealing but

1) does it really work? I am not sure an index=5 means there are 5 
interrupts.

2) the test would affect all existing devices, and there's so much 
hardware proliferation that proving this change in harmless might be 
difficult. I personally only have one BYT-T (ASus T100) device left and 
it's not very reliable. Hans seems to have a ton of devices but they are 
mostly Byt-Cr?
