From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: davinci-mcasp: Improved
	suspend/resume support
Date: Wed, 1 Oct 2014 17:02:40 +0100
Message-ID: <20141001160240.GC4273@sirena.org.uk>
References: <1412168532-31091-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9073028681934511731=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 36C0D261489
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 18:02:48 +0200 (CEST)
In-Reply-To: <1412168532-31091-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============9073028681934511731==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SfqqZ2zU93BLT28p"
Content-Disposition: inline


--SfqqZ2zU93BLT28p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2014 at 04:02:10PM +0300, Peter Ujfalusi wrote:
> Hi,
>=20
> With this series the McASP will continue to work after deep sleep during =
audio
> activity.
> Without these changes the ongoing audio will not resume and it will time =
out,
> but streams started after resume were worked correctly.

Applied both, thanks.  Might be worth converting to regmap and using the
cache code?

--SfqqZ2zU93BLT28p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULCWfAAoJECTWi3JdVIfQQVYH/0d8rvPIHqdd1Wwe4TKO1M+A
+TqikH3Mkk8lHGTqW8ATeGsUm0uSAHUC2G+MathFMLxVNRoP7k9PClNTpzvuUukF
2ZHyIt+Ni8D0StllDtz6EUsHn00+t6U6i0oV93zTTf4+nBuHmttPd/yftQTIyepv
bjmPLO4g4utgDvXwZ8Q2nCCwY+DwTh13rFbkic++Gbx9zEWO42dCTuR+KTa47QTZ
DGjR+Ls6QilPHcSBcx48Fhcf3wr+QP1Zz2pGGD9zVZfyXs16a3982iPr0x0b/D09
vDq1pE7LT3jeWoxeKy4wM3uZubiX7NanY9bJzfJHgpEqS7SSBLIQ2weGdj9qw7M=
=c8QX
-----END PGP SIGNATURE-----

--SfqqZ2zU93BLT28p--

--===============9073028681934511731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9073028681934511731==--
