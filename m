From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFT v3 1/3] ASoC: core: Add helpers for dai link
 and aux dev init
Date: Thu, 24 Apr 2014 13:24:21 +0100
Message-ID: <20140424122421.GT12304@sirena.org.uk>
References: <1398340906-5017-1-git-send-email-bcousson@baylibre.com>
 <1398340906-5017-2-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7894336144844738401=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E580026526D
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 14:24:33 +0200 (CEST)
In-Reply-To: <1398340906-5017-2-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Fabien Parent <fparent@baylibre.com>, misael.lopez@ti.com, lars@metafoo.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7894336144844738401==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9APspXjoD87987I4"
Content-Disposition: inline


--9APspXjoD87987I4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2014 at 02:01:44PM +0200, Benoit Cousson wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
>=20
> Separate DAI link and aux dev initialization in preparation for
> DAI multicodec support.
> Since aux dev will remain using single codecs but DAI links
> will be able to support multiple codecs.

Applied, thanks.

--9APspXjoD87987I4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWQJyAAoJELSic+t+oim9oC4QAI14cqXWpfhXVkziBDsO3rqA
nvk9DOrtVFu9xdbGyt+VHRuqQQnznDmXwYmyJ/sY43nujwuZI89F99DdG7tENN98
BHV58ZygzNU1yfWvNj/8S/gKMCPl4tYGRid3iWhidzfacUm4OH01DtuIG/9iIKyE
eKVuvq7VvX0n4cQC2FxDBHjwTF2Fu5CojY+1fqAGDnOAE1h7OWlkjNcs8F92uRUV
2CQIq79i8jctugT3YmPVJLimoVYIApRspkwYGInEiw7p9MWlkldGQ5rASU4PmArc
VGFGeIPSozcva+0I6D16t4CL9AYxlXczRudIowiCSavjqbHpgFlPfGq4AabpouQ3
MKgbEyQljLmX7eQmZDb8sfo8H+4FNo1pMI/Ia98NEG+6HGpLIOUMbQVdi1UWMPcU
1/Mo77LbIH76u3qomzNmdUhJYxd6yQNMmmyUDV4c36yWPLwPoFlkvwnpptw8YAjB
NrC/OEMB3a0EO9LhilGN99STHbIrZ1OdA2E6v7ucNz4fmzvNulbqYMIv7vb8/Mti
EsfDFNjy+Vp/s0ThqX6YeXWiyoMTMeT684+dqEdqfRk23dooxh5xpm4ZZHgPKG4e
IJ6AKU02NFY3KBNIW9+AEdG6601gkQB7QeAjoClVUOV9bDAqiKVzokHL8VHx0yo0
IchridrToaywwN1PHrQF
=IzCr
-----END PGP SIGNATURE-----

--9APspXjoD87987I4--

--===============7894336144844738401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7894336144844738401==--
