From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 2/2] misc: sram: switch to ioremap_wc from ioremap
Date: Thu, 11 Dec 2014 12:40:46 +0100
Message-ID: <1418298046.3188.10.camel@pengutronix.de>
References: <1418266726-12004-1-git-send-email-a.kesavan@samsung.com>
	 <1418266726-12004-2-git-send-email-a.kesavan@samsung.com>
	 <1418292513.3188.4.camel@pengutronix.de> <20141211103919.GA6067@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141211103919.GA6067@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Abhilash Kesavan <a.kesavan@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "heiko@sntech.de" <heiko@sntech.de>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "shc_work@mail.ru" <shc_work@mail.ru>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, "padma.v@samsung.com" <padma.v@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "shawn.guo@freescale.com" <shawn.guo@freescale.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>"tony@atomide.com" <tony@atomide.com>
List-Id: alsa-devel@alsa-project.org

Hi Will,

Am Donnerstag, den 11.12.2014, 10:39 +0000 schrieb Will Deacon:
> On Thu, Dec 11, 2014 at 10:08:33AM +0000, Philipp Zabel wrote:
> > Hi Abhilash,
> > 
> > Am Donnerstag, den 11.12.2014, 08:28 +0530 schrieb Abhilash Kesavan:
> > > Currently, the SRAM allocator returns device memory via ioremap.
> > > This causes issues on ARM64 when the internal SoC SRAM allocated by
> > > the generic sram driver is used for audio playback. The destination
> > > buffer address (which is ioremapped SRAM) is not 64-bit aligned for
> > > certain streams (e.g. 44.1k sampling rate). In such cases we get
> > > unhandled alignment faults. Use ioremap_wc in place of ioremap which
> > > gives us normal non-cacheable memory instead of device memory.
> > 
> > Could this break the omap_bus_sync() implementation in
> > arch/arm/mach-omap2/omap4-common.c?
> > 
> >     void omap_bus_sync(void)
> >     {
> >             if (dram_sync && sram_sync) {
> >                     writel_relaxed(readl_relaxed(dram_sync), dram_sync);
> >                     writel_relaxed(readl_relaxed(sram_sync), sram_sync);
> >                     isb();
> >             }
> >     }
> > 
> > It is used in wmb() and omap_do_wfi() to drain interconnect write
> > buffers on omap4/5. If sram_sync is mapped with write-combining, could
> > the last write to sram_sync stay stuck in the write-combining buffer
> > until after the function returns?
> 
> I think you have that issue anyway, since you can get an early write
> response even if you use ioremap. Does the write to sram_sync have
> side-effects that we need to wait for?

[Added Tony Lindgren and Santosh Shilimkar to Cc:]
I don't know.

regards
Philipp
