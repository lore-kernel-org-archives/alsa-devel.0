From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: rt5659: Add mclk controls
Date: Fri, 29 Jul 2016 21:45:21 +0530
Message-ID: <20160729161521.GL9681@localhost>
References: <1469660568-3511-1-git-send-email-nicoleotsuka@gmail.com>
 <20160728155732.GG11806@sirena.org.uk>
 <20160728181419.GA4742@Asurada-Nvidia>
 <20160728185510.GK11806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160728185510.GK11806@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, bardliao@realtek.com, oder_chiou@realtek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Darren Hart <dvhart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 28, 2016 at 07:55:10PM +0100, Mark Brown wrote:
> On Thu, Jul 28, 2016 at 11:14:20AM -0700, Nicolin Chen wrote:
> > On Thu, Jul 28, 2016 at 04:57:32PM +0100, Mark Brown wrote:
>=20
> > > This device seems to be used on x86 systems so we'll need to ensure t=
hat
> > > they register clocks for this.  They really should set this up using
> > > quirks keyed off DMI information or similar so it's hidden from other
> > > systems.
>=20
> > Hmm..the change defines this mclk as a optional property so I'm
> > not sure how it would affect x86 systems. (Would love to refine
>=20
> Ah, clk_prepare_enable() silently ignores NULL as an argument?  It is a
> bit messy to do things that way but might be the most practical thing.
>=20
> > it to make it impactless.) Since it's literally hidden, any way
> > that I can manually ensure it? Or just wait for an ack from x86
> > developers?
>=20
> Hopefully they'll speak up - we're in the merge window anyway so it'll
> be just over a week before this can go into -next.

Yeah I am not aware of any plan to have clks on x86. For audio we are not
going to use much. ACPI and controller w/ firmware does the job.

I have added Darren, he oversee platform things so might know if clocks
would be there in future..

Thanks
--=20
~Vinod

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXm4EYAAoJEHwUBw8lI4NHyKAQAJKbJjjg/5TkhnsomEV11g7H
WP5n9T/fPVtjEK3GMxzGmuhxmHmZ3IlqGVGM9wkyd5eqFRi1JhFcHn64/kzG8Kg1
NvoRCY+OBFuej1/FEVQCe1W1xMby190T5GgufJIVxICqbV0cAv3/7imzBzoesayv
k1yLfXCeZqkUbjnSEphiQjxkXEEqlQi2meehkMDW2+r1ktF5A4eVztfLis5PpkNo
Admol6L2sIudpjrF7l3nh6cu/hypPuSAGhgnoHcF2y3hBznLuOz3Gtnqo2Na0dWV
s8ysxQnAZuUrlcZz43ElbH1l4vh6+P6ABgyxQZQ02AbXNNqvPxvbbwxGQBAofCRk
WN5a1cjZ/HofOKUoH4OqKFtyvd1wd9qFamaaFvl+U8aAhafzsnlIYP7iwbkOeKQj
hzBvO8joy8YgO7qV0HUfhV/cxn+QDySedjRjTNIQwTPmOWmHnb+TfGinojjG8e8w
XJKtp0HSrkOYBoN1oqMsuzaRG2ILR1Vu1qvYcaK5BQBTl38xNJIraoCojbG3rh/a
6NGrPAlIfhBqKQ/o5Ddk+Xi2tDU4GkFXioCU5k97kn401YecrSMNGjAokxFXtir3
pfdZT34+da+W6JNUyYRoI0Rnuj5rQMDKqx2nLX3jwT7EbY678MMSfTBBQfnKHXiV
48bxTNWD6jQYPE8jZbSB
=U1cq
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--
