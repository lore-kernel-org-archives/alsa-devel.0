From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 2/3] arch/x86/platform/atom: Move pmc_atom to drivers/platform/x86
Date: Fri, 16 Dec 2016 20:39:01 +0200
Message-ID: <CAHp75Vc9qkaHkpvcH+24ivF=5HsuKwSbRggo7ZC_3=ckJLMzcQ@mail.gmail.com>
References: <1481306510-7471-1-git-send-email-irina.tirdea@intel.com>
 <1481306510-7471-3-git-send-email-irina.tirdea@intel.com> <CAHp75VfCgTgWnNmgcY9mp9n-1e_mSci=3dGyrtDquMtTT3OoYw@mail.gmail.com>
 <20161216182045.GA44199@f23x64.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20161216182045.GA44199@f23x64.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Irina Tirdea <irina.tirdea@intel.com>, linux-clk@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>, platform-driver-x86@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 16, 2016 at 8:20 PM, Darren Hart <dvhart@infradead.org> wrote:
> On Tue, Dec 13, 2016 at 01:43:31AM +0200, Andy Shevchenko wrote:
>> I have been told I have to send my comments here instead of our
>> internal ML. I didn't fast enough to comment that during v5. So do it
>> right now.

>> >  {arch/x86/include/asm => include/linux/platform_data/x86}/pmc_atom.h | 0
>>
>> No, it's not a *platform data*.
>>
>> Other that that looks good to me.
>
> Where would you recommend instead? It needs a place to serve both acpi_lpss.c
> and pmc_atom.c. The include/linux/platform_data/x86 location doesn't seem too
> strange as it supports a "platform" driver in the sense that pmc_atom is a
> platform driver.

include/linux/x86 ?

-- 
With Best Regards,
Andy Shevchenko
