From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] mfd: arizona: Add support for CS47L24
Date: Mon, 17 Nov 2014 15:01:07 +0000
Message-ID: <20141117150107.GF2722@sirena.org.uk>
References: <20141111165227.GA24344@opensource.wolfsonmicro.com>
 <20141111171532.GA26106@opensource.wolfsonmicro.com>
 <20141113101228.GE24004@x1>
 <20141113164017.GA12443@opensource.wolfsonmicro.com>
 <20141117121648.GP24004@x1>
 <20141117125433.GA29518@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tpXFRyzAyQ/GSAaD"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141117125433.GA29518@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linus.walleij@linaro.org, gnurou@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--tpXFRyzAyQ/GSAaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2014 at 12:54:33PM +0000, Richard Fitzgerald wrote:
> On Mon, Nov 17, 2014 at 12:16:48PM +0000, Lee Jones wrote:

> > Looks like I was a little hasty with my comments.  However 8000 lines
> > over 4 platforms just to describe which registers are readable is all
> > a little bit grim.  Is there any way you can use ranges instead of
> > listing every single register on the chip?  How many gaps are there?=20

> It's debatable. Ranges would be possible but there are a lot of gaps.
> Personally, speaking as someone who has to maintain these drivers, I
> like that fact that I can look at this file and see exactly which registe=
rs
> are readable and volatile because they are all explicitly listed. It's al=
so
> useful that the files are searchable for specific registers.

> I'll point Charles at this to get his opinion.

It's probably also worth pointing out that while ranges do compress the
data a bit they make it harder to answer questions like "is this
register mapped properly" since the question becomes "is the numeric
value of this symbol between the numeric values of any of these other
pairs of symbols we have listed here".  I generally find it harder to
review drivers using ranges since when checking that things are mapped
voatile or whatever you have to do lookups like that.

--tpXFRyzAyQ/GSAaD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUag2zAAoJECTWi3JdVIfQj9IH/RfsSZ31HTZyYtkLxwYCIgMl
HfpJmvqcetgJ97wRq1FP5D13TSK5fhaVlCyFGo+7dTfj5aXs72kQetTmE+vCAQWu
WbEcsjERgvy3B1bXe5gfD38b+MEKdlCo8ybdWl/lXkpO//ADGSm/0m0wNxLUKujG
W2FOLARqxc903kJgP1RaKMXXsNGY0ybKjx2MoSoLuq1Arl4kzoBEIJDS6UYxfoD3
VD2PrmjHfkFswbvtVPQ1zpChT9hIM4Lkj5zLEi/oL5QM6Qi2VGt9jvE0X4HZsxXd
fLRcNjEGXCsIPfb5RG1oxUblfD7OkaKJY0j61xmy0ge8IBl4Mw1VP28HNbZvXKs=
=RIr5
-----END PGP SIGNATURE-----

--tpXFRyzAyQ/GSAaD--
