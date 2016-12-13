From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v6 1/3] clk: x86: Add Atom PMC platform clocks
Date: Mon, 12 Dec 2016 18:15:09 -0600
Message-ID: <1a98dcda-a662-958e-307f-5fe3f281ed9f@linux.intel.com>
References: <1481306510-7471-1-git-send-email-irina.tirdea@intel.com>
 <1481306510-7471-2-git-send-email-irina.tirdea@intel.com>
 <CAHp75Vdaw4yvTPP2JZc+ti-AVNsisRQ+WG=JxPQ1jv-r7DADQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vdaw4yvTPP2JZc+ti-AVNsisRQ+WG=JxPQ1jv-r7DADQA@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>
Cc: linux-clk@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>, platform-driver-x86@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


> Thanks for an update I will comment all the patches.
> Here we start.

Thanks Andy for the review. Two quick comments before going further in 
the details later.

>
>> The BayTrail and CherryTrail platforms provide platform clocks
>> through their Power Management Controller (PMC).
>>
>> The SoC supports up to 6 clocks (PMC_PLT_CLK[5:0]) with a
>> frequency of either 19.2 MHz (PLL) or 25 MHz (XTAL) for BayTrail
>> and a frequency of 19.2 MHz (XTAL) for CherryTrail. These clocks
>> are available for general system use, where appropriate, and each
>> have Control & Frequency register fields associated with them.
>>
>> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>
> Who is the actual author? SoB I guess should be either the author, or
> 1st, 2nd, ..., last one who is submitter.

I ported the initial code from Android legacy stuff and Irina ported the 
functionality to the clk framework. It seems appropriate to have both 
signed-offs?

[snip]
>
>> +#include <linux/platform_data/x86/clk-byt-plt.h>

This was a suggestion of Darren Hart in agreement with Thomas Gleixner.
see 
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-October/113936.html

Darren, did we get your proposal right?

>
> Is it indeed platform data? I would not create platform_data/x86
> without strong argument.
> Perhaps include/linux/clk/x86_pmc.h? (Yes, I know about clk-lpss.h
> which is old enough and was basically first try of clk stuff on x86)


