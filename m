From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v6 1/3] clk: x86: Add Atom PMC platform
 clocks
Date: Fri, 16 Dec 2016 08:57:16 -0600
Message-ID: <07206bf1-2fab-0bbe-6e1b-762e55f62363@linux.intel.com>
References: <1481306510-7471-1-git-send-email-irina.tirdea@intel.com>
 <1481306510-7471-2-git-send-email-irina.tirdea@intel.com>
 <CAHp75Vdaw4yvTPP2JZc+ti-AVNsisRQ+WG=JxPQ1jv-r7DADQA@mail.gmail.com>
 <20161213232524.GQ5423@codeaurora.org>
 <32235fb3-0d54-211d-28f4-4655e4bc7812@linux.intel.com>
 <CAHp75Vf7Sfq3_mSb6xf0NHutq8tO1y7Rhi7opDkomu+-vQZCYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vf7Sfq3_mSb6xf0NHutq8tO1y7Rhi7opDkomu+-vQZCYw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Irina Tirdea <irina.tirdea@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, "x86@kernel.org" <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>, platform-driver-x86@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, linux-clk@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On 12/16/16 2:46 AM, Andy Shevchenko wrote:
> On Fri, Dec 16, 2016 at 7:15 AM, Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>> Hi Stephen,
>>
>> can you elaborate on the last comment?
>
> Please don't do top posting.
>
>>>> devm_kasprintf()
>>>
>>> Please no.
>
> That's why I used modal verb "might" instead of "would".
>
>>> It's all local to this function, devm isn't helping anything.
>>> Having one kfree() would be good though. And using init.name for
>>> the clkdev lookup is probably wrong and should be replaced with
>>> something more generic along with an associated device name.
>>
>> I am not sure I understand this last comment.
>> init.name is not a constant, it's made of the "pmc_plt_clk_" string
>> concatenated with an id which directly maps to which hardware clock is
>> registered. Clients use devm_clk_get() with a "pmc_plt_clk_<n>" argument.
>
> Giving more thoughts about design and use of this I would propose to
> do the following.
>
> 1. Create under clock framework something like clk-pmc-atom clock
> driver (see, for example, clk-fractional-divider, though this one
> should indeed go under x86 folder).

apart from the name the current code already does this with code in 
drivers/clk/x86

> 2. In real provider, i.e. pmc_atom, create the necessary clock tree
> with *names*.
>
> Scheme with ID is fragile, imagine another version of PMC where
> ordering would be mixed up? It's not hypothetical since we used to
> have this already in pmc_atom for some registers and bits.

I don't want to deal with hypothetical stuff happening to legacy 
hardware. If there is a problem at some point, it's no big deal to add a 
platform-dependent lookup table and change the registers being accessed.



