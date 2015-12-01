From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] ASoC: sun4i: Implement MIC1 capture
Date: Tue, 1 Dec 2015 10:14:00 +0100
Message-ID: <20151201091400.GD29263@lukather>
References: <1448897867-22320-1-git-send-email-maxime.ripard@free-electrons.com>
 <20151130161705.GY1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4224653019808756891=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F3F5265A39
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 10:14:01 +0100 (CET)
In-Reply-To: <20151130161705.GY1929@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============4224653019808756891==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 30, 2015 at 04:17:05PM +0000, Mark Brown wrote:
> On Mon, Nov 30, 2015 at 04:37:47PM +0100, Maxime Ripard wrote:
>=20
> A couple of minor issues below but I'll apply this - please send
> followup patches.
>=20
> > +static void sun4i_codec_start_capture(struct sun4i_codec *scodec)
> > +{
> > +	/*
> > +	 * FIXME: according to the BSP, we might need to drive a PA
> > +	 *        GPIO high here on some boards
> > +	 */
>=20
> That's not something this driver needs to worry about, that's something
> the machine driver will do - the whole purpose is to glue all the
> different components on the board together.

Indeed, I'll remove the comment.

>=20
> > +	if (clk_set_rate(scodec->clk_module, clk_freq))
> > +		return -EINVAL;
>=20
> It'd be better to pass back the error code from clk_set_rate().

Ack, I'll send a patch.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXWTYAAoJEBx+YmzsjxAgWssP/1kyjTK0nwVuMANvcLVZogq4
jlvUM+2JjbFdUyOxZ5rNPWZedvTMqpd0BiF9W/KYKF3Fx1UgMxU96BAVHeIipLBI
YntKeVyt8/XzvbaH2LphrA+udlYRdhmdqapCdd6cdo+upWn7+HyB39ePw9rNCWtB
k/R75FX3dKMXXU7sOKtFPgeZ4gmJrW64LYoza7aMdln4Rr1ntIc2Z5o0hjblF9X+
8bvesNGODeXTjQJquS44xGZsb1IAbz8p+jksmyVI38/G2O/Jnyx0W0RrIOZ5lN8x
Yb7aTC/iCKTKo1BxBE+SgRyGRGb0t2fHb54jb15up772cn2e+Zq/Z87Zp5iKvxzo
i2E7AX2rBfdCWK6zdUJB0xjBpfGerP6ly2KxJssOqtTQY5H4lZdU91o2a9pO8UGO
zHmg/ffubdPW38mfvousckBxywA6haOEjargEBDUluy/FpgRRcmJFt/E7aHtclYv
lgUgd4y0/p/pKTkL7c3zvu+goZtDXXfZtzanxdODOWTESVxuc8M60DNmouekOVVd
6xRga8G81av6+xYUPmImUvZ5lw6lgvi/pEIopAKYXok9BQbKTBR/vReq29qLR7TE
dOqWoji7ebsaODvD6GHsEi8vxbPF69cB/FnEeTwZFlr2EAmzSrETEUhZ2Z75RYZZ
aaFStoY3i0lYWfAkzZ5B
=hkK9
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--

--===============4224653019808756891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4224653019808756891==--
