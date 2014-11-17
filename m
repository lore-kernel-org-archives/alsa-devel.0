From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] mfd: arizona: Add support for CS47L24
Date: Mon, 17 Nov 2014 12:16:48 +0000
Message-ID: <20141117121648.GP24004@x1>
References: <20141111165227.GA24344@opensource.wolfsonmicro.com>
 <20141111171532.GA26106@opensource.wolfsonmicro.com>
 <20141113101228.GE24004@x1>
 <20141113164017.GA12443@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141113164017.GA12443@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 13 Nov 2014, Charles Keepax wrote:

> On Thu, Nov 13, 2014 at 10:12:28AM +0000, Lee Jones wrote:
> > On Tue, 11 Nov 2014, Richard Fitzgerald wrote:
> >=20
> > > Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com=
>
> > > ---
> > >  drivers/mfd/Kconfig              |    6 +
> > >  drivers/mfd/Makefile             |    3 +
> > >  drivers/mfd/arizona-core.c       |   91 ++-
> > >  drivers/mfd/arizona-irq.c        |   42 +-
> > >  drivers/mfd/arizona-spi.c        |    9 +
> > >  drivers/mfd/arizona.h            |    5 +
> > >  drivers/mfd/cs47l24-tables.c     | 1632 ++++++++++++++++++++++++=
++++++++++++++
> >=20
> > No chance.
> >=20
> > Please resend with these in a header file (like all of the others).
> >=20
> > I'd also like Charles' Reviewed-by before accepting.
>=20
> This looks good to me. I don't quite follow what you are
> requesting with the header file? This still uses the header file
> for the registers but just defining which are available on this
> chip.

Looks like I was a little hasty with my comments.  However 8000 lines
over 4 platforms just to describe which registers are readable is all
a little bit grim.  Is there any way you can use ranges instead of
listing every single register on the chip?  How many gaps are there?=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
