From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 2/3] arch/x86/platform/atom: Move pmc_atom to drivers/platform/x86
Date: Tue, 13 Dec 2016 01:43:31 +0200
Message-ID: <CAHp75VfCgTgWnNmgcY9mp9n-1e_mSci=3dGyrtDquMtTT3OoYw@mail.gmail.com>
References: <1481306510-7471-1-git-send-email-irina.tirdea@intel.com> <1481306510-7471-3-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1481306510-7471-3-git-send-email-irina.tirdea@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: linux-clk@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>, platform-driver-x86@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

I have been told I have to send my comments here instead of our
internal ML. I didn't fast enough to comment that during v5. So do it
right now.

On Fri, Dec 9, 2016 at 8:01 PM, Irina Tirdea <irina.tirdea@intel.com> wrote:
> The pmc_atom driver does not contain any architecture specific
> code. It only enables the SOC Power Management Controller Driver

SOC -> SoC
Driver -> driver

> for BayTrail and CherryTrail platforms.
>
> Move the pmc_atom driver from arch/x86/platform/atom to
> drivers/platform/x86.
>
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> ---
>  arch/x86/Kconfig                                                     | 4 ----
>  arch/x86/platform/atom/Makefile                                      | 1 -
>  drivers/acpi/acpi_lpss.c                                             | 2 +-
>  drivers/platform/x86/Kconfig                                         | 4 ++++
>  drivers/platform/x86/Makefile                                        | 1 +
>  {arch/x86/platform/atom => drivers/platform/x86}/pmc_atom.c          | 3 +--

>  {arch/x86/include/asm => include/linux/platform_data/x86}/pmc_atom.h | 0

No, it's not a *platform data*.

Other that that looks good to me.

-- 
With Best Regards,
Andy Shevchenko
