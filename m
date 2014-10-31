From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/9] ASoC: Intel: add shim save context and
 restore routines
Date: Fri, 31 Oct 2014 16:58:56 +0000
Message-ID: <20141031165856.GE18557@sirena.org.uk>
References: <1414666312-4657-1-git-send-email-vinod.koul@intel.com>
 <1414666312-4657-9-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1882411304480764184=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F41612606DC
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 17:59:25 +0100 (CET)
In-Reply-To: <1414666312-4657-9-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1882411304480764184==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oKQo6H1tQBaoPMj5"
Content-Disposition: inline


--oKQo6H1tQBaoPMj5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2014 at 04:21:51PM +0530, Vinod Koul wrote:
> From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
>=20
> Some ACPI platform require the driver to save the shim register content a=
nd
> restore them after resume, so add the routines for these
> The APCI patch will use these routines

Applied everything up to here - this one doesn't apply, probably due to
some interaction with one of the other serieses.

--oKQo6H1tQBaoPMj5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU7/PAAoJECTWi3JdVIfQWWAH/1DMeB19d2boe8431p+Qz69i
f6eWw1iAea7s9Q1ikiI9eCF+CYjf+07Yj9hodO+iL8npYRZLbuHzi/V4Tj589H8v
v1Be22JiLpRUM/Och5MZz7Zhht8r2igZt7cGOnFOu/6tXVlVmbnqNVNPs3y9wvNd
zMqIIbUSBFLtTheG/ZzTu0koGq6QonjQw4fAH0AAbW2NkBiuhAM+bBWIozBsXDXE
bLXylJ/iz/BlqyTF1f4fG0K4dW2ff7IzPbQMZCpyZlDPlVrWt5+Uw56LEz5uejtp
u35Qaq2JKpN96rGVRZrtFtn1msOsK5Lk8xwqOq/rv1lmrJbJTOaOq996LnOXHO4=
=hcIQ
-----END PGP SIGNATURE-----

--oKQo6H1tQBaoPMj5--

--===============1882411304480764184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1882411304480764184==--
