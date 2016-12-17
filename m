From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [alsa-devel] [PATCH v6 1/3] clk: x86: Add Atom PMC platform clocks
Date: Sat, 17 Dec 2016 15:57:27 +0200
Message-ID: <CAHp75Vdn_8_fCQzkG7CPrnDZzhC7WUpGM1cyvfNRz0u_sc7RKA@mail.gmail.com>
References: <1481306510-7471-1-git-send-email-irina.tirdea@intel.com>
 <1481306510-7471-2-git-send-email-irina.tirdea@intel.com> <CAHp75Vdaw4yvTPP2JZc+ti-AVNsisRQ+WG=JxPQ1jv-r7DADQA@mail.gmail.com>
 <20161213232524.GQ5423@codeaurora.org> <32235fb3-0d54-211d-28f4-4655e4bc7812@linux.intel.com>
 <20161217013337.GW5423@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20161217013337.GW5423@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Irina Tirdea <irina.tirdea@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, "x86@kernel.org" <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>, platform-driver-x86@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, linux-clk@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 17, 2016 at 3:33 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 12/15, Pierre-Louis Bossart wrote:

>>Clients use devm_clk_get() with a "pmc_plt_clk_<n>"
>> argument.
>
> This is the problem. Clients should be calling clk_get() like:
>
>         clk_get(dev, "signal name in datasheet")
>
> where the first argument is the device and the second argument is
> some string that is meaningful to the device, not the system as a
> whole. The way clkdev is intended is so that the dev argument's
> dev_name() is combined with the con_id that matches some signale
> name in the datasheet. This way when the same IP is put into some
> other chip, the globally unique name doesn't need to change, just
> the device name that's registered with the lookup. Obviously this
> breaks down quite badly when dev_name() isn't stable. Is that
> happening here?

PMC Atom is a PCI device and thus each platform would have different
dev_name(). Do you want to list all in each consumer if consumer wants
to work on all of them or I missed something?

So, the question is how clock getting will look like to work on
currently both CherryTrail and BayTrail.

-- 
With Best Regards,
Andy Shevchenko
