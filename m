From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 2/2] misc: sram: switch to ioremap_wc from
	ioremap
Date: Tue, 6 Jan 2015 11:27:41 -0600
Message-ID: <CAL_JsqJwdr7WvzLqPmui3N4H-wVgSURN6wYD=dm1HyU2HUmXOg@mail.gmail.com>
References: <1418266726-12004-1-git-send-email-a.kesavan@samsung.com>
 <1418266726-12004-2-git-send-email-a.kesavan@samsung.com>
 <1418292513.3188.4.camel@pengutronix.de>
 <20141211103919.GA6067@arm.com> <1418298046.3188.10.camel@pengutronix.de>
 <20141211145849.GH31456@e104818-lin.cambridge.arm.com>
 <CAM4voakdfiTecW8YH0znnyB-dTnX_fsrRcH2McABwdk3T9drkQ@mail.gmail.com>
 <20150105181823.GG4081@atomide.com>
 <CAM4voa=xoM4AuGxwk0TpLnGz9jbZ02awFOrY_KgWCSzROJR6cA@mail.gmail.com>
 <1420563279.3719.15.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id E120F2604F2
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 18:28:01 +0100 (CET)
Received: by mail-wg0-f42.google.com with SMTP id k14so29984148wgh.29
 for <alsa-devel@alsa-project.org>; Tue, 06 Jan 2015 09:28:01 -0800 (PST)
In-Reply-To: <1420563279.3719.15.camel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "heiko@sntech.de" <heiko@sntech.de>, "padma.v@samsung.com" <padma.v@samsung.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Pawel Moll <Pawel.Moll@arm.com>, "shc_work@mail.ru" <shc_work@mail.ru>, "corbet@lwn.net" <corbet@lwn.net>, linux-rockchip@lists.infradead.org, "kgene@kernel.org" <kgene@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "arnd@arndb.de" <arnd@arndb.de>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "shawn.guo@freescale.com" <shawn.guo@freescale.com>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, S
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 6, 2015 at 10:54 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Hi Abhilash,
>
> Am Dienstag, den 06.01.2015, 19:57 +0530 schrieb Abhilash Kesavan:
>> >> From the existing dts files, omap, imx, rockchip and exynos seem to be
>> >> the only users of the sram allocator code. I have tested this on
>> >> Exynos5420, Exynos5800 and Exynos7; there is no change in behavior
>> >> seen on these boards. Tested-by for other SoCs would be appreciated.
>> >
>> > Sorry for the delay, these seems to boot OK on omap4, so from that
>> > point of view:
>> >
>> > Tested-by: Tony Lindgren <tony@atomide.com>
>>
>> Thanks a lot for testing this. If someone with imx and rockchip boards
>> could help test this out, then we could look to get this in.
>
> This shouldn't be a problem on i.MX, the coda driver doesn't access SRAM
> from the CPU at all.

Audio buffers are typically (perhaps not in mainline) in SRAM on i.MX
chips which are accessed by CPU and probably mmap'ed to userspace.
That could cause a mismatch in mappings although I would not expect
both the kernel and user space to touch the buffer. That being said, I
don't think this change should cause problems for i.MX (from what I
can remember).

Rob
