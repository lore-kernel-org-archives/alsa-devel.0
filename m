From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix Kabylake machine driver
 for pops and clicks
Date: Wed, 26 Jul 2017 12:49:43 +0100
Message-ID: <20170726114943.dr4wktsn25vifcvb@sirena.org.uk>
References: <1501021659-8597-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5827463948523032576=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F1B872673F1
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 13:49:59 +0200 (CEST)
In-Reply-To: <1501021659-8597-1-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <harshapriya.n@intel.com>
Cc: tiwai@suse.de, vinod.koul@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5827463948523032576==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hwbgbx5wwfkzq7v5"
Content-Disposition: inline


--hwbgbx5wwfkzq7v5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 03:27:39PM -0700, Harsha Priya wrote:
> This patch adds fixes for the following issues in Kabylake machine driver
>=20
> 1. crackling noise in rt5663 headset codec=20
> 2. enabling 4 slot IV feedback for max98927 speaker amp codec=20
> 3. pop noise while recording from rt5514 dmic codec=20

This is three different fixes so I'd expect to see three different
patches and the changelog doesn't describe what the fixes actually do so
it's much harder to review.

--hwbgbx5wwfkzq7v5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll4gdcACgkQJNaLcl1U
h9A4Agf/cco2BmDji/ykYzx54C1LZ8DgvFAS6A1q/SoeLHt60wy7OaVrhApvLhmA
PVpOSi+avuYlxNTkxzWTYmKsp4GVYaNrvyL0iJ4NoVLU4FPQWk7AE4Jd1T4bnQWr
CKyrIVG+Pxu1X0a7vUbin80dKtk5HJXUjra7kY+P00CXg4OdsnB1F0yC5XIS2Lid
eFvgWBdDmHBzqe3CzDucN3gV4KW26PVcyQioBVqzO0nDO0dORWKT6P5VhVpKgXvK
VJvdxUaA/Vjh2T75Z+R4142wNcVIw5M0Znr7G4bMczoBSeZtDl95CoUxLo7/1Dv7
jqiNDyFZyri/6zdocoamRCsZFwXoGg==
=JaUy
-----END PGP SIGNATURE-----

--hwbgbx5wwfkzq7v5--

--===============5827463948523032576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5827463948523032576==--
