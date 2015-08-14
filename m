From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: ics43432: Add codec driver for
 InvenSense ICS-43432
Date: Fri, 14 Aug 2015 17:07:31 +0100
Message-ID: <20150814160731.GS10748@sirena.org.uk>
References: <alpine.DEB.2.02.1508141106040.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3460188384829468007=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AAD712665C0
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:13:25 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1508141106040.27635@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3460188384829468007==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tTvAEuyWWbMF5UF4"
Content-Disposition: inline


--tTvAEuyWWbMF5UF4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2015 at 11:10:10AM +0200, Ricard Wanderlof wrote:
>=20
> V2: Update after comments from Lars-Peter yesterday: set rate to=20
> CONTINUOUS and let ALSA figure out the details, also removing hw_params a=
s=20
> it is then not needed.

Please add any non-changelog content like this after the --- as covered
in SubmittingPatches.

> +static int ics43432_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fm=
t)
> +{
> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {

This still seems redundant (IIRC Lars mentioned this...).

--tTvAEuyWWbMF5UF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzhJCAAoJECTWi3JdVIfQVS8H/3qcalHwqmUhodD2oRwP1WNx
/EqlK63UEHbuv6jDJ5ybi28FDq5EUmL3607n7vWN4HTqMqY2WiauJKLYmUZJ90tK
BcDj9fX7IcYsceptKc051BXlKVvwdK51V1yy+/OJOWJtEM8/1ZkgvCHZvrRLw57l
GaQHfwJ1sLkZTq26yhK93GRFmr1qrQRa+jE41WkDFeFZk4eXAmJjo7796nln3YFr
VbXhUHLDYB13/Q2jgwNFdpa065E3/crXruK0PeJGcG5NNQ9oM+RqsRQWZ9PlzLg8
Uiyyj72fBwe7lU0elyDKldMYrIeUdbDetI3uxv9GXLlgQFiDtK3PEikI60jSyL0=
=N5Dd
-----END PGP SIGNATURE-----

--tTvAEuyWWbMF5UF4--

--===============3460188384829468007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3460188384829468007==--
