From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: RE: [PATCH v2 3/3] arm: mxs: disable clock-gates when setting
	saif-clocks
Date: Thu, 8 Sep 2011 08:24:47 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F77223E983@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1315403858-9904-1-git-send-email-b29396@freescale.com>
	<1315403858-9904-4-git-send-email-b29396@freescale.com>
	<20110907182442.GZ28816@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110907182442.GZ28816@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Uwe Kleine-K=F6nig [mailto:u.kleine-koenig@pengutronix.de]
> Sent: Thursday, September 08, 2011 2:25 AM
> To: Dong Aisheng-B29396
> Cc: alsa-devel@alsa-project.org; s.hauer@pengutronix.de;
> broonie@opensource.wolfsonmicro.com; lrg@ti.com; linux-arm-
> kernel@lists.infradead.org; w.sang@pengutronix.de
> Subject: Re: [PATCH v2 3/3] arm: mxs: disable clock-gates when setting
> saif-clocks
> =

> On Wed, Sep 07, 2011 at 09:57:38PM +0800, Dong Aisheng wrote:
> > From: Wolfram Sang <w.sang@pengutronix.de>
> >
> > New divides should only be written when gates are off.
> >
> > Reported-by: Dong Aisheng <b29396@freescale.com>
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> >
> > ---
> > Changes since v1:
> >  * Fix author name. It should be Wolfram Sang. :)
> >
> > BTW, i did a minus change based on wolfram's patch or the saif will
> > not work.
> >
> > Change
> > +       __raw_writel(clkgate, CLKCTRL_BASE_ADDR +
> > + HW_CLKCTRL_##rs##_SET); \
> > to
> > +       __raw_writel(reg & ~clkgate,					\
> > 			CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
> IMHO this is worth to be noted in the commit log.
Yes.

> > It seemed HW_CLKCTRL_##rs##_SET did not work well.
> > (i did not find HW_CLKCTRL_SAIFx_SET in spec).
> > ---
> >  arch/arm/mach-mxs/clock-mx28.c        |    7 +++++--
> >  arch/arm/mach-mxs/regs-clkctrl-mx28.h |    2 ++
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-mxs/clock-mx28.c
> > b/arch/arm/mach-mxs/clock-mx28.c index 33cc2ff..c9d0548 100644
> > --- a/arch/arm/mach-mxs/clock-mx28.c
> > +++ b/arch/arm/mach-mxs/clock-mx28.c
> > @@ -476,7 +476,7 @@ _CLK_SET_RATE1(xbus_clk, XBUS)
> >  static int name##_set_rate(struct clk *clk, unsigned long rate)
> 	\
> >  {									\
> >  	u16 div;							\
> > -	u32 reg;							\
> > +	u32 reg, clkgate;						\
> >  	u64 lrate;							\
> >  	unsigned long parent_rate;					\
> >  	int i;								\
> > @@ -493,7 +493,8 @@ static int name##_set_rate(struct clk *clk,
> unsigned long rate)		\
> >  		return -EINVAL;						\
> >  									\
> >  	reg =3D __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
> > -	reg &=3D ~BM_CLKCTRL_##rs##_DIV;					\
> > +	clkgate =3D reg & BM_CLKCTRL_##rs##_CLKGATE;			\
> > +	reg &=3D ~(BM_CLKCTRL_##rs##_DIV | BM_CLKCTRL_##rs##_CLKGATE);	\
> >  	reg |=3D div << BP_CLKCTRL_##rs##_DIV;				\
> >  	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
> >  									\
> > @@ -506,6 +507,8 @@ static int name##_set_rate(struct clk *clk,
> unsigned long rate)		\
> >  		return -ETIMEDOUT;					\
> >  	}								\
> >  									\
> > +	__raw_writel(reg & ~clkgate,					\
> > +			CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
> >  	return 0;							\
> >  }
> >
> > diff --git a/arch/arm/mach-mxs/regs-clkctrl-mx28.h
> > b/arch/arm/mach-mxs/regs-clkctrl-mx28.h
> > index 7d1b061..08749b3 100644
> > --- a/arch/arm/mach-mxs/regs-clkctrl-mx28.h
> > +++ b/arch/arm/mach-mxs/regs-clkctrl-mx28.h
> > @@ -285,6 +285,7 @@
> >  		(((v) << 0) & BM_CLKCTRL_EMI_DIV_EMI)
> >
> >  #define HW_CLKCTRL_SAIF0	(0x00000100)
> > +#define HW_CLKCTRL_SAIF0_SET	(0x00000104)
> Is this still needed?
No, we may not need this.

For this patch, as discussed with Wolfram before, since we also find
Some other devices have the same issue as SAIF(e.g. SSP),
it looks we may have further work to do on clock-mx28.c.

However the original purpose of sending this patch is for
poeple to easily test.

Regards
Dong Aisheng
