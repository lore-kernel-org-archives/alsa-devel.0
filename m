From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: linux-next: Tree for Jan 9 (sound/soc vs. drivers/misc)
Date: Mon, 09 Jan 2012 12:57:04 -0800
Message-ID: <4F0B54A0.20905@xenotime.net>
References: <20120109170457.4465dfc66a0eace4a2230fef@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20120109170457.4465dfc66a0eace4a2230fef@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/08/2012 10:04 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20120106:
> 
> This tree is still broken for sparc64 defconfig (at least).


AFAICT, all builds (on X86_32 or X86_64) have this kconfig warning:

drivers/misc/Kconfig:212:error: recursive dependency detected!
drivers/misc/Kconfig:212:	symbol ATMEL_SSC is selected by SND_ATMEL_SOC_SSC
sound/soc/atmel/Kconfig:9:	symbol SND_ATMEL_SOC_SSC is selected by SND_AT91_SOC_SAM9G20_WM8731
sound/soc/atmel/Kconfig:18:	symbol SND_AT91_SOC_SAM9G20_WM8731 depends on ATMEL_SSC


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
