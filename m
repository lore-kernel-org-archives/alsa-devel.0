From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [alsa-devel] [PATCH v6 1/3] clk: x86: Add Atom PMC platform clocks
Date: Thu, 22 Dec 2016 20:42:37 +0200
Message-ID: <CAHp75VfJU3613euahjW-s92_XEz8hK70ZgRi53Lpo+2TWqPscA@mail.gmail.com>
References: <1481306510-7471-1-git-send-email-irina.tirdea@intel.com>
 <1481306510-7471-2-git-send-email-irina.tirdea@intel.com> <CAHp75Vdaw4yvTPP2JZc+ti-AVNsisRQ+WG=JxPQ1jv-r7DADQA@mail.gmail.com>
 <20161213232524.GQ5423@codeaurora.org> <32235fb3-0d54-211d-28f4-4655e4bc7812@linux.intel.com>
 <20161217013337.GW5423@codeaurora.org> <CAHp75Vdn_8_fCQzkG7CPrnDZzhC7WUpGM1cyvfNRz0u_sc7RKA@mail.gmail.com>
 <7f3d03dc-24fe-ec3f-4a3b-926c28f0ac86@linux.intel.com> <20161221230557.GK5423@codeaurora.org>
 <cd6044f5-6c79-b2d6-902d-52e27c217e78@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cd6044f5-6c79-b2d6-902d-52e27c217e78@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, linux-clk@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, Michael Turquette <mturquette@baylibre.com>, "x86@kernel.org" <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Darren Hart <dvhart@infradead.org>, Takashi Iwai <tiwai@suse.com>, platform-driver-x86@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 22, 2016 at 3:07 AM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 12/21/16 5:05 PM, Stephen Boyd wrote:

>>> The name pmc_plt_clk_<n> follows the data sheet specification, where
>>> this convention is suggested:
>>>   PLT_CLK[2:0] - Camera
>>>   PLT_CLK[3] - Audio Codec
>>>   PLT_CLK[4] -
>>>   PLT_CLK[5] - COMMs

By the way, would I suggest to use same prefix as provider, i.e.
pmc_atom_plt_clk_%d ?

-- 
With Best Regards,
Andy Shevchenko
