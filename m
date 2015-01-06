From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 2/2] misc: sram: switch to ioremap_wc from
	ioremap
Date: Tue, 06 Jan 2015 17:54:39 +0100
Message-ID: <1420563279.3719.15.camel@pengutronix.de>
References: <1418266726-12004-1-git-send-email-a.kesavan@samsung.com>
 <1418266726-12004-2-git-send-email-a.kesavan@samsung.com>
 <1418292513.3188.4.camel@pengutronix.de> <20141211103919.GA6067@arm.com>
 <1418298046.3188.10.camel@pengutronix.de>
 <20141211145849.GH31456@e104818-lin.cambridge.arm.com>
 <CAM4voakdfiTecW8YH0znnyB-dTnX_fsrRcH2McABwdk3T9drkQ@mail.gmail.com>
 <20150105181823.GG4081@atomide.com>
 <CAM4voa=xoM4AuGxwk0TpLnGz9jbZ02awFOrY_KgWCSzROJR6cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 09AB32604D1
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 17:55:13 +0100 (CET)
In-Reply-To: <CAM4voa=xoM4AuGxwk0TpLnGz9jbZ02awFOrY_KgWCSzROJR6cA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "heiko@sntech.de" <heiko@sntech.de>, "padma.v@samsung.com" <padma.v@samsung.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "arnd@arndb.de" <arnd@arndb.de>, "shc_work@mail.ru" <shc_work@mail.ru>, "corbet@lwn.net" <corbet@lwn.net>, linux-rockchip@lists.infradead.org, "kgene@kernel.org" <kgene@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Pawel Moll <Pawel.Moll@arm.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "shawn.guo@freescale.com" <shawn.guo@freescale.com>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Abhilash,

Am Dienstag, den 06.01.2015, 19:57 +0530 schrieb Abhilash Kesavan:
> >> From the existing dts files, omap, imx, rockchip and exynos seem to be
> >> the only users of the sram allocator code. I have tested this on
> >> Exynos5420, Exynos5800 and Exynos7; there is no change in behavior
> >> seen on these boards. Tested-by for other SoCs would be appreciated.
> >
> > Sorry for the delay, these seems to boot OK on omap4, so from that
> > point of view:
> >
> > Tested-by: Tony Lindgren <tony@atomide.com>
> 
> Thanks a lot for testing this. If someone with imx and rockchip boards
> could help test this out, then we could look to get this in.

This shouldn't be a problem on i.MX, the coda driver doesn't access SRAM
from the CPU at all.

regards
Philipp
