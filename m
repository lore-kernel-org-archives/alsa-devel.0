From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH v6 1/3] clk: x86: Add Atom PMC platform
 clocks
Date: Thu, 22 Dec 2016 10:29:07 -0800
Message-ID: <08b66c14-eb0d-4b3e-7b10-906e10bc1454@codeaurora.org>
References: <1481306510-7471-1-git-send-email-irina.tirdea@intel.com>
 <1481306510-7471-2-git-send-email-irina.tirdea@intel.com>
 <CAHp75Vdaw4yvTPP2JZc+ti-AVNsisRQ+WG=JxPQ1jv-r7DADQA@mail.gmail.com>
 <20161213232524.GQ5423@codeaurora.org>
 <32235fb3-0d54-211d-28f4-4655e4bc7812@linux.intel.com>
 <20161217013337.GW5423@codeaurora.org>
 <CAHp75Vdn_8_fCQzkG7CPrnDZzhC7WUpGM1cyvfNRz0u_sc7RKA@mail.gmail.com>
 <7f3d03dc-24fe-ec3f-4a3b-926c28f0ac86@linux.intel.com>
 <20161221230557.GK5423@codeaurora.org>
 <cd6044f5-6c79-b2d6-902d-52e27c217e78@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <cd6044f5-6c79-b2d6-902d-52e27c217e78@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, linux-clk@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, Michael Turquette <mturquette@baylibre.com>, "x86@kernel.org" <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Darren Hart <dvhart@infradead.org>, Takashi Iwai <tiwai@suse.com>, platform-driver-x86@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 12/21/2016 05:07 PM, Pierre-Louis Bossart wrote:
> On 12/21/16 5:05 PM, Stephen Boyd wrote:
>>
>> Ok, by clkdev design if a device is passed but there isn't a
>> match in the lookup table it allows it to match based solely on
>> the connection id. Given that the connection id is globally
>> unique this will work.
>>
>> Hopefully we don't have two of these devices with pmc_plt_clk_<n>
>> signals in a single system though. Then having the device name
>> would help differentiate between the two. And then it may make
>> sense to have some sort of ACPI lookup system, similar to how we
>> have lookups for clks in DT.
>
> So in short we keep the existing solution for now and will only use
> the device name if and when the pmc_plt_clk_<n> identifier is no
> longer unique due to hardware changes. Did I get this right?

Ok.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
