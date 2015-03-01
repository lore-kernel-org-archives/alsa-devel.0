From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [alsa-devel] [PATCH v2 0/3] Switch to ioremap_wc in the SRAM
 allocator code
Date: Sun, 1 Mar 2015 08:43:36 -0800
Message-ID: <20150301164336.GD29474@kroah.com>
References: <1423230328-6721-1-git-send-email-a.kesavan@samsung.com>
 <20150206154411.GF23190@e104818-lin.cambridge.arm.com>
 <CAM4voamxLkhPOtbWhjv_ZcRwxtRH1ybvPGrScEQ6ME2n2NuTwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAM4voamxLkhPOtbWhjv_ZcRwxtRH1ybvPGrScEQ6ME2n2NuTwA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "heiko@sntech.de" <heiko@sntech.de>, "shc_work@mail.ru" <shc_work@mail.ru>, "padma.v@samsung.com" <padma.v@samsung.com>, "tony@atomide.com" <tony@atomide.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "kgene@kernel.org" <kgene@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "hirokazu.takata.wj@renesas.com" <hirokazu.takata.wj@renesas.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Catalin Marinas <catalin.marinas@arm.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 01, 2015 at 10:00:37PM +0530, Abhilash Kesavan wrote:
> Hi Greg,
> 
> On Fri, Feb 6, 2015 at 9:14 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Feb 06, 2015 at 01:45:25PM +0000, Abhilash Kesavan wrote:
> >> Fix alignment faults seen during play-back of files with specific
> >> sampling rates such as 44.1K. This is based on the discussion here:
> >> http://www.spinics.net/lists/arm-kernel/msg384647.html
> >>
> >> Patch 1 is needed as m32r arch does not define ioremap_wc. Patch 2 adds a
> >> resource managed helper function for ioremap_wc which is used in patch 3.
> >>
> >> Changes since v1:
> >>       - Fix the compilation error with m32r due to missing ioremap_wc
> >>       definition.
> >>       - Fixed minor indentation issues.
> >>
> >> Note: Other architectures either have ioremap_wc defined or are including
> >> generic "io.h"/"iomap.h". c6x arch is the only one I am not sure of.
> >>
> >> Abhilash Kesavan (3):
> >>   m32r: add definition of ioremap_wc to io.h
> >>   lib: devres: add a helper function for ioremap_wc
> >>   misc: sram: switch to ioremap_wc from ioremap
> >>
> >>  Documentation/driver-model/devres.txt |    1 +
> >>  arch/m32r/include/asm/io.h            |    1 +
> >>  drivers/misc/sram.c                   |   17 ++++++++++++++---
> >>  include/linux/io.h                    |    2 ++
> >>  lib/devres.c                          |   28 ++++++++++++++++++++++++++++
> >>  5 files changed, 46 insertions(+), 3 deletions(-)
> >
> > For the series:
> >
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> These patches still apply cleanly on linux-next and have been ack'ed
> by Catalin and Philipp. Would you like me to collect the tags and
> resend the series or can they be applied as is ?

I can take them as-is, thanks.

greg k-h
