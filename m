From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v8 4/5] platform/x86: Enable Atom PMC platform clocks
Date: Mon, 10 Jul 2017 12:19:23 +0200
Message-ID: <CAFqH_52JO5eWa9sZk+1OcmfFjsydLk+ajajqTnLprSJfCCSM7g@mail.gmail.com>
References: <1485194865-10400-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1485194865-10400-5-git-send-email-pierre-louis.bossart@linux.intel.com> <20170127002344.GZ8801@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170127002344.GZ8801@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, alsa-devel@alsa-project.org, Irina Tirdea <irina.tirdea@intel.com>, Michael Turquette <mturquette@baylibre.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi all,

2017-01-27 1:23 GMT+01:00 Stephen Boyd <sboyd@codeaurora.org>:
> On 01/23, Pierre-Louis Bossart wrote:
>> From: Irina Tirdea <irina.tirdea@intel.com>
>>
>> The BayTrail and CherryTrail platforms provide platform clocks
>> through their Power Management Controller (PMC).
>>
>> The SoC supports up to 6 clocks (PMC_PLT_CLK[0..5]) with a
>> frequency of either 19.2 MHz (PLL) or 25 MHz (XTAL) for BayTrail
>> and a frequency of 19.2 MHz (XTAL) for CherryTrail. These clocks
>> are available for general system use, where appropriate. For example,
>> the usage for platform clocks suggested in the datasheet is the
>> following:
>>   PLT_CLK[0..2] - Camera
>>   PLT_CLK[3] - Audio Codec
>>   PLT_CLK[4] -
>>   PLT_CLK[5] - COMMs
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
>> ---
>
> Applied to clk-next
>

I just noticed that I need to revert this patch on kernel 4.12 to get
audio working again on my Acer C200 (Baytrail). Any clue on what could
be wrong?

Thanks in advance,
 Enric


> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
