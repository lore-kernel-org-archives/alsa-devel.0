From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add rt5665 codec driver
Date: Tue, 1 Nov 2016 14:14:33 -0600
Message-ID: <20161101201433.4l2ruiczhbveaeif@sirena.org.uk>
References: <1477903079-11883-1-git-send-email-bardliao@realtek.com>
 <20161031181933.vya7yy5fniaimxvw@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7011D28D9@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3945226004146254901=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CC35266917
 for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2016 21:14:51 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D7011D28D9@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============3945226004146254901==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gj4yb45rra3ddzhl"
Content-Disposition: inline


--gj4yb45rra3ddzhl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2016 at 03:16:02AM +0000, Bard Liao wrote:

> > These aren't really done properly - they're squashing all the data path=
s down
> > into one.  Ideally there'd be a separate AIF widget for each channel.  =
It's not
> > super urgent right now since it won't make a practical difference.

> I will modify that. Something like below, right?
> SND_SOC_DAPM_AIF_OUT("AIFOUTL", "Capture", 0, SND_SOC_NOPM, 0, 0),
> SND_SOC_DAPM_AIF_OUT("AIFOUTR", "Capture", 1, SND_SOC_NOPM, 0, 0),

Yes, exactly

> > > +	regulator_3v3 =3D devm_regulator_get_optional(&i2c->dev,
> > > +						rt5665->pdata.regulator_3v3);
> >=20
> > > +	regulator_5v =3D devm_regulator_get_optional(&i2c->dev,
> > > +						rt5665->pdata.regulator_5v);

> > I also just don't believe that *all* of the regulators the device has a=
re optional.

> That is because we don't know how customers design their schematic.
> All regulators can be connected by hardware pin. It means we don't
> need to use a regular to supply it.

No, that's something the regulator API will handle for you - individual
drivers should be written with sensible error handling, the regulator
API will handle stubbing out things that are needed.

--gj4yb45rra3ddzhl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYGPemAAoJECTWi3JdVIfQYsMH+gI2O9zILrbLefD4bS/p7hPd
YLD3jHILszwRSO9CQYWaQFjgTnNcPDJPpbwiewgMdm9DNIQ6GE60X93CSJHB0tdj
PMkPFjfi27LwXHBM8054voj3WKCvmYpEefRqkwSndvW0lH8wkMig0qWFPZebt9Tm
/KSWebFxEgQ3De0wQ1E9As/CQ5Mub9TtNXbVjwBz74oKoiB6XVCtqKJNg/iOdgBN
0uSPY62blJ0X1ikwy1SbbhEzEa0/9s/FOMEe26BoWw8EPGRLtGbvWagpXZmxPvr/
ABsgFAXA9s5uch/c3nd8kKQzHCWxseBwaq4b7edsIfBSqxdio4/3/gL5Wg6HvNA=
=74oT
-----END PGP SIGNATURE-----

--gj4yb45rra3ddzhl--

--===============3945226004146254901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3945226004146254901==--
