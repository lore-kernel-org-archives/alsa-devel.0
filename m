From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH v6 1/3] clk: x86: Add Atom PMC platform
 clocks
Date: Fri, 16 Dec 2016 17:33:37 -0800
Message-ID: <20161217013337.GW5423@codeaurora.org>
References: <1481306510-7471-1-git-send-email-irina.tirdea@intel.com>
 <1481306510-7471-2-git-send-email-irina.tirdea@intel.com>
 <CAHp75Vdaw4yvTPP2JZc+ti-AVNsisRQ+WG=JxPQ1jv-r7DADQA@mail.gmail.com>
 <20161213232524.GQ5423@codeaurora.org>
 <32235fb3-0d54-211d-28f4-4655e4bc7812@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <32235fb3-0d54-211d-28f4-4655e4bc7812@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Irina Tirdea <irina.tirdea@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, "x86@kernel.org" <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>, platform-driver-x86@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, linux-clk@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On 12/15, Pierre-Louis Bossart wrote:
> I am not sure I understand this last comment.
> init.name is not a constant, it's made of the "pmc_plt_clk_" string
> concatenated with an id which directly maps to which hardware clock
> is registered.

That's all fine. We need globally unique strings for clk names in
the framework so things work.

>Clients use devm_clk_get() with a "pmc_plt_clk_<n>"
> argument.

This is the problem. Clients should be calling clk_get() like:

	clk_get(dev, "signal name in datasheet")

where the first argument is the device and the second argument is
some string that is meaningful to the device, not the system as a
whole. The way clkdev is intended is so that the dev argument's
dev_name() is combined with the con_id that matches some signale
name in the datasheet. This way when the same IP is put into some
other chip, the globally unique name doesn't need to change, just
the device name that's registered with the lookup. Obviously this
breaks down quite badly when dev_name() isn't stable. Is that
happening here?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
