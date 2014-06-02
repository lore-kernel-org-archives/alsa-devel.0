From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-cache: Fix the return value of
 snd_soc_cache_init when reg_size is 0
Date: Mon, 2 Jun 2014 17:17:35 +0100
Message-ID: <20140602161735.GM31751@sirena.org.uk>
References: <1401719034-17204-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6290788249140470416=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E0C4265142
 for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2014 18:18:08 +0200 (CEST)
In-Reply-To: <1401719034-17204-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Li.Xiubo@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, jarkko.nikula@linux.intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6290788249140470416==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FxlYARId5dseejUu"
Content-Disposition: inline


--FxlYARId5dseejUu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2014 at 11:23:54AM -0300, Fabio Estevam wrote:
> Commit b59dce53ef6 (ASoC: cache: Fix possible ZERO_SIZE_PTR pointer=20
> dereferencing error.) caused the following probe error:
>=20
> wm8962 0-001a: customer id 0 revision D
> wm8962 0-001a: ASoC: Failed to set cache compression type: -22
> imx-wm8962 sound: snd_soc_register_card failed (-22)
> imx-wm8962: probe of sound failed with error -22

Thanks - I already wrote a patch for this before I saw this one, sorry.

--FxlYARId5dseejUu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTjKOWAAoJELSic+t+oim9vQEP/RZcGWqWK1JXGKbLAcLuA2d1
wEQfv1ldGrX9LJCu/P+cMdOoMzvrmaHxQHXPd/SzRXQlP/EmUjPcyWdvXGuPAD88
SrR504uF9KOz7ne9gEkV8+HRItm9vtRtS69aoQxbC4z3QcCJ+eih8rPhgi0+H05f
EbdYTNFFDRULKjA9rrs1EfInHslrC+REz4hnYU5ElXAWzB54Ezh3GyITUbDgqQV7
tCTR1OplwDVzym+mdVzPKiusTB4v+V+C0n8Vr2+9cJxb0VAZvwyTEXgcl7mfdf9n
zECptlXzqTazcXSPXUzm2Lf6B94qK6OXYIjr5WkzFRLDRIk1XgBh4HJKliNl1cC2
WsUGqb4M70layfjWMYWMJSIfQKJuQj6i8I3lTlJSLVF5j+sieNfUss97ExQ1+eux
BqphFYN5a03l31klO44XSbMqWeaZQEYTSVGytAcG1bTVabTGWXtWvtHKnmzyzgeC
HaJj63VVGEIKJh3Fmx56RLI1Gb3BK7eCnXaZE12DZnj3qmpgCSsw4ihrxeeqKNh4
Xx1Sy0WRMxS5T3rqND7Rq0S/FS/qBu8U8RuxcY2cjxJO5SDLZ2JCQg1gsRjQ9iLz
q4NfW3i4x99JEd4s1qIfODrGXEQ5gcZyWeQYUHmIx0kK5eY1aIk+V3qPmet230k+
bmx9abamy+rS6sBHwpVf
=IezE
-----END PGP SIGNATURE-----

--FxlYARId5dseejUu--

--===============6290788249140470416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6290788249140470416==--
