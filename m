From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 1/3] clk: x86: Add Atom PMC platform clocks
Date: Tue, 13 Dec 2016 03:16:05 +0200
Message-ID: <CAHp75VfW3T=GC2nY6jSa-vF841AeML_job603AAUm97vFb59cg@mail.gmail.com>
References: <1481306510-7471-1-git-send-email-irina.tirdea@intel.com>
 <1481306510-7471-2-git-send-email-irina.tirdea@intel.com> <CAHp75Vdaw4yvTPP2JZc+ti-AVNsisRQ+WG=JxPQ1jv-r7DADQA@mail.gmail.com>
 <1a98dcda-a662-958e-307f-5fe3f281ed9f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1a98dcda-a662-958e-307f-5fe3f281ed9f@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Irina Tirdea <irina.tirdea@intel.com>, linux-clk@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>, platform-driver-x86@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 13, 2016 at 2:15 AM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>>> +#include <linux/platform_data/x86/clk-byt-plt.h>
>
>
> This was a suggestion of Darren Hart in agreement with Thomas Gleixner.
> see
> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-October/113936.html
>
> Darren, did we get your proposal right?
>
>> Is it indeed platform data? I would not create platform_data/x86
>> without strong argument.
>> Perhaps include/linux/clk/x86_pmc.h? (Yes, I know about clk-lpss.h
>> which is old enough and was basically first try of clk stuff on x86)

Looking more into the patch I got another question. Do we really need
a platform driver for that?

That's what I think motivated me for the header location. And that's
why I asked about use of the driver/clock provider in the latter
patch.

If the answer is yes, then I doubt which location is preferable,
otherwise include/clk/x86_*.h looks appropriate.

Sorry if I wasn't clear in the first place.

-- 
With Best Regards,
Andy Shevchenko
