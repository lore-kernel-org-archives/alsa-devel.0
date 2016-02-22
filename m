From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] Revert "ASoC: fsl_ssi: remove explicit
	register defaults"
Date: Mon, 22 Feb 2016 11:59:30 +0900
Message-ID: <20160222025930.GO18327@sirena.org.uk>
References: <1456065300-23752-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0081074193942321487=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5323726057F
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 03:59:47 +0100 (CET)
In-Reply-To: <1456065300-23752-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, mail@maciej.szmigiero.name, mika.penttila@nextfour.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0081074193942321487==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XzwO5SPJOYU+7Pos"
Content-Disposition: inline


--XzwO5SPJOYU+7Pos
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 21, 2016 at 11:35:00AM -0300, Fabio Estevam wrote:

> From: Fabio Estevam <fabio.estevam@nxp.com>
>=20
> Commit 5c408fee2546 ("ASoC: fsl_ssi: remove explicit register defaults")
> causes the driver to fail to probe:

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

> As this currently breaks SSI on 4.5-rc we should better revert it for
> this cycle.

> We can then add it back to 4.7 when Mark's patch 3245d460a1eb55=20
> ("regmap: cache: Fall back to register by register read for cache default=
s")
> will be available and then the driver will work fine with your patch.

There's no problem adding it back for v4.6 for that matter, the changes
will all have long enough to soak (and have already been soaking for a
little while).  I'll do that.

--XzwO5SPJOYU+7Pos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWynmRAAoJECTWi3JdVIfQKu0H/ixvymRm5M2AKEuh3qX8bVl1
L/ngRZzF3/BeCnVJUR6p3ha/OjUalxyboLcI3GXHYOeAFkSoRe9t/z1DmttvsqkQ
hykP2NW1/mTBLrHmZ5faDduictkt7oUSfLfWAIlsT2XI5gVZ1n0zyLaLA86y709G
spzzd32gw8aPltW21pSVCmnhtjFsHuo8RqEzFRwaij4GuOHJDLNS0pcmQ1XTJ38Z
62vxzlUS5uURaVh5EqgoO53zPnn5gN5J7J3HVDkNSP1NAeKguMEpaI0IYwa1gloc
OEfdybdjXfI0I1piYmrZxP0BOXLz1NXx1pFEBSI63wBgoWi75B4gkhymMLz3YbE=
=1zX/
-----END PGP SIGNATURE-----

--XzwO5SPJOYU+7Pos--

--===============0081074193942321487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0081074193942321487==--
