From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: max98090: read micbias from
	device property
Date: Thu, 28 May 2015 10:28:59 +0100
Message-ID: <20150528092859.GR21577@sirena.org.uk>
References: <1432684686-14460-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1691773747862388948=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 218DF2604EA
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 11:29:05 +0200 (CEST)
In-Reply-To: <1432684686-14460-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, praveen.k.jain@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============1691773747862388948==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5hPnlvMVk0oUI7Ca"
Content-Disposition: inline


--5hPnlvMVk0oUI7Ca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2015 at 04:58:04PM -0700, yang.a.fang@intel.com wrote:
> From: "Fang, Yang A" <yang.a.fang@intel.com>
>=20
> This patch reads max98090 micbias from acpi or dt

This is adding a new DT binding, the DT binding needs to be documented.

--5hPnlvMVk0oUI7Ca
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZt/bAAoJECTWi3JdVIfQ+TQIAIEvh1pibkEOce5dVt5iLRNM
aHxY7+32BzsWOuMUZ29S0L01eCfHA1yu2YzSxNJ+gk4sEfYOv9BqyuUDIm6wWzfn
TEqpOzUWzE4IrvlSkN+/wtS9xlozPFWeyP7nxClqjpgekV2zLZ99pInfshzUfeEl
CQTjZURlauTR1seAMtfDcmAo7d+Ngtv5hv1zb4hrza6g+P83lsIbFc9CCLrWBKUb
RNUT4ZimydHIEv6nWKHPSVU5FCdLxrZWjDC32B9WZJw+jEiuiSKOOcg6+4WWLvwb
Q60YZSmPaReWU+MFcx2FAC5LUBuVUxbQG0KbbUnCl/c/uctsnoYc/fJOmci9Xhc=
=jjL+
-----END PGP SIGNATURE-----

--5hPnlvMVk0oUI7Ca--

--===============1691773747862388948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1691773747862388948==--
