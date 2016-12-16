From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 1/3] clk: x86: Add Atom PMC platform clocks
Date: Fri, 16 Dec 2016 20:49:13 +0200
Message-ID: <CAHp75Ve-3WXr05uvPQDfFDzxLc09+1ZSYpsuw02ab+x0enJtQg@mail.gmail.com>
References: <1481306510-7471-1-git-send-email-irina.tirdea@intel.com>
 <1481306510-7471-2-git-send-email-irina.tirdea@intel.com> <CAHp75Vdaw4yvTPP2JZc+ti-AVNsisRQ+WG=JxPQ1jv-r7DADQA@mail.gmail.com>
 <1a98dcda-a662-958e-307f-5fe3f281ed9f@linux.intel.com> <CAHp75VccDyiLhWxZYg+d0usrwhfa_hiZAJCKPXXVRod=tB803g@mail.gmail.com>
 <20161216183607.GB44199@f23x64.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20161216183607.GB44199@f23x64.localdomain>
Sender: linux-clk-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Irina Tirdea <irina.tirdea@intel.com>, linux-clk@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>, platform-driver-x86@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 16, 2016 at 8:36 PM, Darren Hart <dvhart@infradead.org> wrote:
> On Tue, Dec 13, 2016 at 02:26:21AM +0200, Andy Shevchenko wrote:
>> On Tue, Dec 13, 2016 at 2:15 AM, Pierre-Louis Bossart
>> <pierre-louis.bossart@linux.intel.com> wrote:

>> For clock I would suggest include/linux/clk/ with x86_ prefix.
>> For the rest I have no strong opinion except trying to avoid
>> platform_data wording in the path as much as possible.
>>
>> As an example I could recall DMA engine subsystem where we have
>>
>> include/linux/platform_data/dma-*.h
>>
>> and
>>
>> include/linux/dma/*.h
>>
>> So, this sounds more to me as
>>
>> include/linux/x86/pmc_atom.h
>
> There should really be some Documentation about how to choose an include
> directory :-)

So true!

> My understanding is include/linux should be more generic, rather than platform
> specific headers. So while platform_data may refer specifically to the platform
> bus drivers, it's the closest thing we have to include/platform, which would be
> ideal. I would prefer to stick with include/platform_data because:
>
> 1) Semantically, it's the closest thing there is
> 2) include/linux should be for more generic headers related to the OS or
>    subsystems
> 3) It doesn't make sense to create a separate include/platform directory for a
>    single header.
> 4) We don't want to rename platform_data to platform now and change all the
>    drivers, but it could be changed later.

My understanding that part like P-Unit, PMIC, PMC, SCU, whatever we
have inside SoC is platform from hardware prospective, but from
software (driver) it doesn't use platform data since it's quite SoC
specific (like CPU model to differentiate). That's why something in
the middle between arch/x86/include/asm and
include/linux/platform_data.

I assume I would be not good in naming schemes, though platform_data
for file which doesn't contain platform data for platform device
sounds a bit confusing to me. Like someone already noticed
include/platform_data is already messy. This might just add another
level of it.

So, what is exactly confuses me is mixing data for *platform devices*
(as represented via *platform driver* -- struct platform_driver)  and
for SoC devices (no struct platform_driver per se).
Maybe I misunderstood something...

-- 
With Best Regards,
Andy Shevchenko
