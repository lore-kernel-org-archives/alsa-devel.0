From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/8] ASoC: AMD: add AMD ASoC ACP 2.x DMA driver
Date: Tue, 5 Jan 2016 18:51:59 +0000
Message-ID: <20160105185159.GM6588@sirena.org.uk>
References: <1450897275-17152-1-git-send-email-alexander.deucher@amd.com>
 <1450897275-17152-6-git-send-email-alexander.deucher@amd.com>
 <20160105184343.GL6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1723893635=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160105184343.GL6588@sirena.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, rajeevkumar.linux@gmail.com, Alex Deucher <alexander.deucher@amd.com>, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============1723893635==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x38akuY2VS0PywU3"
Content-Disposition: inline


--x38akuY2VS0PywU3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 05, 2016 at 06:43:43PM +0000, Mark Brown wrote:
> On Wed, Dec 23, 2015 at 02:01:13PM -0500, Alex Deucher wrote:

> > +#include "include/acp_2_2_d.h"
> > +#include "include/acp_2_2_sh_mask.h"

> I can't find these headers anywhere in the kernel tree or earlier in
> this patch series, this will break the build.  The fact that they've got
> include in the filename is also a bit interesting...

Ugh, your cover letter says (after pages of changelog) that they're in a
patch 5 which you didn't send :(  Please don't do this, I can't apply or
review code that isn't sent to me.

--x38akuY2VS0PywU3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWjBDOAAoJECTWi3JdVIfQ+6AH/RetH8uM4zwNhp4FbN2AbzmG
q5ezcSPpmkUj6ZZXKslcx9DazXnBN4tquU4h0fheRNI+ElrYeKlj8DYsLuWLEzEm
kxYC8lnX5FIw3R+xQeGYKdIlWvbVdXREmFWVUd0mBCgnyAwVSLeH49bUIsRA0AXv
UfXOstAdLtGIA9dDL3Si9O0LLBlS3H3WZI0lnccsZWzYqk8v3jWjkvljMa/XzhT9
iVFFtUEyf4rM5xYOAHkBuoRngtmKeeTpsPuFasOquHL7ox/BTPVpArXfxQBUlktV
1Y7Fqgqmt/bJqf8kE8nqKihi9u6enrlQ/FpFsrCODC7372CXiLVsjIC0/SniUS8=
=gXRF
-----END PGP SIGNATURE-----

--x38akuY2VS0PywU3--

--===============1723893635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============1723893635==--
