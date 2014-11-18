From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] mfd: arizona: Add support for CS47L24
Date: Tue, 18 Nov 2014 13:10:44 +0000
Message-ID: <20141118131044.GA20203@opensource.wolfsonmicro.com>
References: <20141111165227.GA24344@opensource.wolfsonmicro.com> <20141111171532.GA26106@opensource.wolfsonmicro.com> <20141113101228.GE24004@x1> <20141113164017.GA12443@opensource.wolfsonmicro.com> <20141117121648.GP24004@x1> <20141117125433.GA29518@opensource.wolfsonmicro.com> <20141117150107.GF2722@sirena.org.uk> <20141118113401.GW24004@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141118113401.GW24004@x1>
Sender: linux-gpio-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linus.walleij@linaro.org, gnurou@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 18, 2014 at 11:34:01AM +0000, Lee Jones wrote:
> On Mon, 17 Nov 2014, Mark Brown wrote:
>=20
> > On Mon, Nov 17, 2014 at 12:54:33PM +0000, Richard Fitzgerald wrote:
> > > On Mon, Nov 17, 2014 at 12:16:48PM +0000, Lee Jones wrote:
> >=20
> > > > Looks like I was a little hasty with my comments.  However 8000=
 lines
> > > > over 4 platforms just to describe which registers are readable =
is all
> > > > a little bit grim.  Is there any way you can use ranges instead=
 of
> > > > listing every single register on the chip?  How many gaps are t=
here?=20
> >=20
> > > It's debatable. Ranges would be possible but there are a lot of g=
aps.
> > > Personally, speaking as someone who has to maintain these drivers=
, I
> > > like that fact that I can look at this file and see exactly which=
 registers
> > > are readable and volatile because they are all explicitly listed.=
 It's also
> > > useful that the files are searchable for specific registers.
> >=20
> > > I'll point Charles at this to get his opinion.
> >=20
> > It's probably also worth pointing out that while ranges do compress=
 the
> > data a bit they make it harder to answer questions like "is this
> > register mapped properly" since the question becomes "is the numeri=
c
> > value of this symbol between the numeric values of any of these oth=
er
> > pairs of symbols we have listed here".  I generally find it harder =
to
> > review drivers using ranges since when checking that things are map=
ped
> > voatile or whatever you have to do lookups like that.
>=20
> Very well, thanks Mark and Charles.
>=20
> How about we go back to my original idea then and chucking all of
> these massive tables into a nice header file in include?
>=20

I think perhaps the problem here is that because we group these all as
"arizona" and the tables look similar, there's an assumption that they
all share most of a core set of registers which we could factor out and
be left with only a few trivial differences between chips. Actually
the arizona platform is just a collection of IP blocks from which devic=
es
can be built, any device can contain any selection of these blocks.
There's blocks that appear on most devices but nothing that could be
called "core" set - even the shared blocks are actually slightly
different across the different chips that use them. Also the address
map is sparse to allow IP blocks to grow, or have different groups of
registers on different chips, without having to move its address around=
,
which is why ranges won't reduce the code size much.

There's a lot of similarity between the tables but also lots of
differences. If we moved it to a header file it just means we move 8000=
+
lines from .c to .h and then the .c #includes them all back again.

In the end, these big files aren't aesthetically pleasing, but ease
of maintenance is important and they aren't total duplicates.


> --=20
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
