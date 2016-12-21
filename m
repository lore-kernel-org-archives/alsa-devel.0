From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH v6 1/3] clk: x86: Add Atom PMC platform
 clocks
Date: Wed, 21 Dec 2016 15:05:57 -0800
Message-ID: <20161221230557.GK5423@codeaurora.org>
References: <1481306510-7471-1-git-send-email-irina.tirdea@intel.com>
 <1481306510-7471-2-git-send-email-irina.tirdea@intel.com>
 <CAHp75Vdaw4yvTPP2JZc+ti-AVNsisRQ+WG=JxPQ1jv-r7DADQA@mail.gmail.com>
 <20161213232524.GQ5423@codeaurora.org>
 <32235fb3-0d54-211d-28f4-4655e4bc7812@linux.intel.com>
 <20161217013337.GW5423@codeaurora.org>
 <CAHp75Vdn_8_fCQzkG7CPrnDZzhC7WUpGM1cyvfNRz0u_sc7RKA@mail.gmail.com>
 <7f3d03dc-24fe-ec3f-4a3b-926c28f0ac86@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7f3d03dc-24fe-ec3f-4a3b-926c28f0ac86@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, linux-clk@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, Michael Turquette <mturquette@baylibre.com>, "x86@kernel.org" <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Darren Hart <dvhart@infradead.org>, Takashi Iwai <tiwai@suse.com>, platform-driver-x86@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 12/19, Pierre-Louis Bossart wrote:
> On 12/17/16 7:57 AM, Andy Shevchenko wrote:
> >On Sat, Dec 17, 2016 at 3:33 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> >>On 12/15, Pierre-Louis Bossart wrote:
> >
> >>>Clients use devm_clk_get() with a "pmc_plt_clk_<n>"
> >>>argument.
> >>
> >>This is the problem. Clients should be calling clk_get() like:
> >>
> >>        clk_get(dev, "signal name in datasheet")
> >>
> >>where the first argument is the device and the second argument is
> >>some string that is meaningful to the device, not the system as a
> >>whole. The way clkdev is intended is so that the dev argument's
> >>dev_name() is combined with the con_id that matches some signale
> >>name in the datasheet. This way when the same IP is put into some
> >>other chip, the globally unique name doesn't need to change, just
> >>the device name that's registered with the lookup. Obviously this
> >>breaks down quite badly when dev_name() isn't stable. Is that
> >>happening here?
> >
> >PMC Atom is a PCI device and thus each platform would have different
> >dev_name(). Do you want to list all in each consumer if consumer wants
> >to work on all of them or I missed something?
> >
> >So, the question is how clock getting will look like to work on
> >currently both CherryTrail and BayTrail.
> 
> The name pmc_plt_clk_<n> follows the data sheet specification, where
> this convention is suggested:
>   PLT_CLK[2:0] - Camera
>   PLT_CLK[3] - Audio Codec
>   PLT_CLK[4] -
>   PLT_CLK[5] - COMMs
> 
> These clocks are not internal but are made available to external
> components through dedicated physical pins on the package, this
> external visibility limits the scope for confusions, variations. I
> have not seen any skews where these clocks and pins were changed at
> all.

Ok, by clkdev design if a device is passed but there isn't a
match in the lookup table it allows it to match based solely on
the connection id. Given that the connection id is globally
unique this will work.

Hopefully we don't have two of these devices with pmc_plt_clk_<n>
signals in a single system though. Then having the device name
would help differentiate between the two. And then it may make
sense to have some sort of ACPI lookup system, similar to how we
have lookups for clks in DT.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
