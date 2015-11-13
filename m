From: Mark Brown <broonie@kernel.org>
Subject: Re: multi-codec support for arizona-ldo1 was Re: System with
 multiple arizona (wm5102) codecs
Date: Fri, 13 Nov 2015 22:53:55 +0000
Message-ID: <20151113225355.GU12392@sirena.org.uk>
References: <20150914115439.GA29646@amd>
 <20150914115255.GE11200@ck-lbox>
 <20151012090045.GA7448@amd>
 <20151012154715.GF4238@sirena.org.uk>
 <20151012201137.GA7317@amd>
 <20151013115355.GC14956@sirena.org.uk>
 <20151113215812.GA19020@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JcGvecxLhm+LytDG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151113215812.GA19020@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--JcGvecxLhm+LytDG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2015 at 10:58:12PM +0100, Pavel Machek wrote:
> On Tue 2015-10-13 12:53:55, Mark Brown wrote:
> > On Mon, Oct 12, 2015 at 10:11:38PM +0200, Pavel Machek wrote:

> > > > No, you definitely shouldn't be doing this - the regulator names sh=
ould
> > > > reflect the names the device has in the datasheet to aid people in =
going
> > > > from software to the hardware and back again.  They shouldn't be
> > > > dynamically generated at runtime.  If you need to namespace by
> > > device

> Ok. But I'd still like to get it working.

So as I've been saying use the existing interfaces, or extend them as
needed.

> Now... I got up-to v4.2 kernel, and it seems that it has support for
> multiple sources with same name (but on different chips):

> [    1.125485] Adding alias for supply MICVDD,(null) -> MICVDD,spi32766.1
> [    1.285470] Adding alias for supply MICVDD,(null) -> MICVDD,spi32766.2

> ...but it does not look like I can use those aliases from the ALSA side:

> [    2.734198] wm5102-codec.1 supply MICVDD,spi32766.1 not found, using d=
ummy regulator
> [    3.170912] wm5102-codec.2 supply MICVDD,spi32766.2 not found, using d=
ummy regulator

> I tried to do this:

> SND_SOC_DAPM_REGULATOR_SUPPLY("MICVDD,spi32766.1", 0, SND_SOC_DAPM_REGULA=
TOR_BYPASS),

You're attempting to put a system specific string into a generic driver,
this will break all other users which is clearly not OK.

> Any idea what I did wrong, or what needs to be fixed?

Well, if we look at the code that prints the alias message you pasted
above:

        pr_info("Adding alias for supply %s,%s -> %s,%s\n",
                id, dev_name(dev), alias_id, dev_name(alias_dev));

we can see that it's not just rewriting a string here but is rather
mapping one supply, device tuple to another.  You shouldn't find any
places where the device and supply are concatenated into a single
strong, including the interface used to request regulators, so
attempting to rewrite the name of the supply is not going to get
anywhere.

> > > > provide an interface which explicitly namespaces by device rather t=
han
> > > > hacking it into another interface, the usual thing is to use the st=
ruct
> > > > device as the context.

> > > I'll need some more help here. I need to use it from ALSA, so I don't
> > > think I can influence that interface easily.

> > Sorry?  If this is going into the userspace ABI there's something
> > seriously wrong...

> It is exposed to the ALSA. If ALSA exposes it to userspace, I'm not sure.=
=20

So if it's not exposed to userspace (and it *really* shouldn't be) why
would it not be possible to influence whatever interface you're thinking
of here?  I'm really confused by what you're saying here.

> > > What is currently in tree _does not work_, as there are two arizona
> > > chips, and two "LDO1" regulators. (Doable) suggestions how to fix that
> > > are welcome.

> > To repeat what I said above, provide an interface which namespaces by
> > device (as we normally do when we need to distinguish between multiple
> > instances of the same device).  Given that everything is part of the
> > same device it's very easy to discover which device so it's clearly no
> > problem when mapping the supplies.

> I'm afraid I don't know how to do this. See above.

Look at how we resolve supplies when we do lookups, then look at how we
create aliases for the MFD cells to map supplies into the function
devices and figure out why those mappings aren't being found.  The NULL
you're seeing above seems like a bit of a warning sign here - where did
that come from?

--JcGvecxLhm+LytDG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWRmoDAAoJECTWi3JdVIfQAfIH/3NTr7XhYrp5w+0xnenx20z8
BqthA6iiCTTVDmepg+b4a9GU+d+l3qMIhsDq6Od1o3/nY//7HVmDidm8l6lEmYYT
c8rDhIN5hVZ6ixJS3o0+JiPsKKBIAk6PmKGRAqhPaE1zfMc/yzOdzu2Mpyeysi2n
Fqw/4n4siSI3ZKTeY4v0IVgpp1Hl2XYDk41X+IXVtrJ602b1U76c3ZhaE3IKDHUQ
NJZl8BEZFpapjaDGYu7k2jF4+qabL6zpslRgW3VjMBtStGsRZtvuKf6qiPGmUYvX
/xAlCncCtnJEyQyV+0gz8ymyrO9s6YRjiz7q9IBmZ68lHkq9Bio/fLOpizdy1ns=
=57s7
-----END PGP SIGNATURE-----

--JcGvecxLhm+LytDG--
