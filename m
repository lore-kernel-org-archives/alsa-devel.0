From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH 2/2] misc: sram: switch to ioremap_wc from
	ioremap
Date: Tue, 6 Jan 2015 19:57:44 +0530
Message-ID: <CAM4voa=xoM4AuGxwk0TpLnGz9jbZ02awFOrY_KgWCSzROJR6cA@mail.gmail.com>
References: <1418266726-12004-1-git-send-email-a.kesavan@samsung.com>
 <1418266726-12004-2-git-send-email-a.kesavan@samsung.com>
 <1418292513.3188.4.camel@pengutronix.de>
 <20141211103919.GA6067@arm.com>
 <1418298046.3188.10.camel@pengutronix.de>
 <20141211145849.GH31456@e104818-lin.cambridge.arm.com>
 <CAM4voakdfiTecW8YH0znnyB-dTnX_fsrRcH2McABwdk3T9drkQ@mail.gmail.com>
 <20150105181823.GG4081@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f50.google.com (mail-qg0-f50.google.com
 [209.85.192.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 15A032610B1
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 15:27:45 +0100 (CET)
Received: by mail-qg0-f50.google.com with SMTP id z60so17002590qgd.9
 for <alsa-devel@alsa-project.org>; Tue, 06 Jan 2015 06:27:44 -0800 (PST)
In-Reply-To: <20150105181823.GG4081@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>, linux-rockchip@lists.infradead.org
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pawel Moll <Pawel.Moll@arm.com>, "heiko@sntech.de" <heiko@sntech.de>, "shc_work@mail.ru" <shc_work@mail.ru>, "corbet@lwn.net" <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, "kgene@kernel.org" <kgene@kernel.org>, "padma.v@samsung.com" <padma.v@samsung.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "shawn.guo@freescale.com" <shawn.guo@freescale.com>, Philipp Zabel <p.zabel@pengutronix.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>kern
List-Id: alsa-devel@alsa-project.org

Hi Tony,

On Mon, Jan 5, 2015 at 11:48 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Abhilash Kesavan <kesavan.abhilash@gmail.com> [141217 04:37]:
>> Hi,
>>
>> On Thu, Dec 11, 2014 at 8:28 PM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>> > On Thu, Dec 11, 2014 at 11:40:46AM +0000, Philipp Zabel wrote:
>> >> Hi Will,
>> >>
>> >> Am Donnerstag, den 11.12.2014, 10:39 +0000 schrieb Will Deacon:
>> >> > On Thu, Dec 11, 2014 at 10:08:33AM +0000, Philipp Zabel wrote:
>> >> > > Hi Abhilash,
>> >> > >
>> >> > > Am Donnerstag, den 11.12.2014, 08:28 +0530 schrieb Abhilash Kesavan:
>> >> > > > Currently, the SRAM allocator returns device memory via ioremap.
>> >> > > > This causes issues on ARM64 when the internal SoC SRAM allocated by
>> >> > > > the generic sram driver is used for audio playback. The destination
>> >> > > > buffer address (which is ioremapped SRAM) is not 64-bit aligned for
>> >> > > > certain streams (e.g. 44.1k sampling rate). In such cases we get
>> >> > > > unhandled alignment faults. Use ioremap_wc in place of ioremap which
>> >> > > > gives us normal non-cacheable memory instead of device memory.
>> >> > >
>> >> > > Could this break the omap_bus_sync() implementation in
>> >> > > arch/arm/mach-omap2/omap4-common.c?
>> >> > >
>> >> > >     void omap_bus_sync(void)
>> >> > >     {
>> >> > >             if (dram_sync && sram_sync) {
>> >> > >                     writel_relaxed(readl_relaxed(dram_sync), dram_sync);
>> >> > >                     writel_relaxed(readl_relaxed(sram_sync), sram_sync);
>> >> > >                     isb();
>> >> > >             }
>> >> > >     }
>> >> > >
>> >> > > It is used in wmb() and omap_do_wfi() to drain interconnect write
>> >> > > buffers on omap4/5. If sram_sync is mapped with write-combining, could
>> >> > > the last write to sram_sync stay stuck in the write-combining buffer
>> >> > > until after the function returns?
>> >> >
>> >> > I think you have that issue anyway, since you can get an early write
>> >> > response even if you use ioremap. Does the write to sram_sync have
>> >> > side-effects that we need to wait for?
>> >>
>> >> [Added Tony Lindgren and Santosh Shilimkar to Cc:]
>> >> I don't know.
>> >
>> > In addition to Will's question, do you care about the access size?
>> > ioremap() returns Device memory which is bufferable (early
>> > acknowledgement) but it guarantees the access size. With write
>> > combining, you may get a different access size than requested.
>>
>> From the existing dts files, omap, imx, rockchip and exynos seem to be
>> the only users of the sram allocator code. I have tested this on
>> Exynos5420, Exynos5800 and Exynos7; there is no change in behavior
>> seen on these boards. Tested-by for other SoCs would be appreciated.
>
> Sorry for the delay, these seems to boot OK on omap4, so from that
> point of view:
>
> Tested-by: Tony Lindgren <tony@atomide.com>

Thanks a lot for testing this. If someone with imx and rockchip boards
could help test this out, then we could look to get this in.

Regards,
Abhilash
