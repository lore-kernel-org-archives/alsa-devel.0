From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] mfd: arizona: Add support for CS47L24
Date: Tue, 18 Nov 2014 11:34:01 +0000
Message-ID: <20141118113401.GW24004@x1>
References: <20141111165227.GA24344@opensource.wolfsonmicro.com>
 <20141111171532.GA26106@opensource.wolfsonmicro.com>
 <20141113101228.GE24004@x1>
 <20141113164017.GA12443@opensource.wolfsonmicro.com>
 <20141117121648.GP24004@x1>
 <20141117125433.GA29518@opensource.wolfsonmicro.com>
 <20141117150107.GF2722@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141117150107.GF2722@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linus.walleij@linaro.org, gnurou@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Nov 2014, Mark Brown wrote:

> On Mon, Nov 17, 2014 at 12:54:33PM +0000, Richard Fitzgerald wrote:
> > On Mon, Nov 17, 2014 at 12:16:48PM +0000, Lee Jones wrote:
>=20
> > > Looks like I was a little hasty with my comments.  However 8000 l=
ines
> > > over 4 platforms just to describe which registers are readable is=
 all
> > > a little bit grim.  Is there any way you can use ranges instead o=
f
> > > listing every single register on the chip?  How many gaps are the=
re?=20
>=20
> > It's debatable. Ranges would be possible but there are a lot of gap=
s.
> > Personally, speaking as someone who has to maintain these drivers, =
I
> > like that fact that I can look at this file and see exactly which r=
egisters
> > are readable and volatile because they are all explicitly listed. I=
t's also
> > useful that the files are searchable for specific registers.
>=20
> > I'll point Charles at this to get his opinion.
>=20
> It's probably also worth pointing out that while ranges do compress t=
he
> data a bit they make it harder to answer questions like "is this
> register mapped properly" since the question becomes "is the numeric
> value of this symbol between the numeric values of any of these other
> pairs of symbols we have listed here".  I generally find it harder to
> review drivers using ranges since when checking that things are mappe=
d
> voatile or whatever you have to do lookups like that.

Very well, thanks Mark and Charles.

How about we go back to my original idea then and chucking all of
these massive tables into a nice header file in include?

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
