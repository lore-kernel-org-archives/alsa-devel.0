From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: sglt5000: Provide the
	reg_stride field
Date: Fri, 5 Jul 2013 10:45:21 +0100
Message-ID: <20130705094521.GP27646@sirena.org.uk>
References: <1372978863-4872-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2386238031807308739=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F7222625FF
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 11:45:25 +0200 (CEST)
In-Reply-To: <1372978863-4872-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, oskar@scara.com
List-Id: alsa-devel@alsa-project.org


--===============2386238031807308739==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DXIptbhQMTEAc6oN"
Content-Disposition: inline


--DXIptbhQMTEAc6oN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2013 at 08:01:01PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> sgtl5000 has 16-bit registers, and only even numbers are valid for its re=
gisters
> addresses.

Applied, but note that it's only the second bit of that that makes any
diffrence - the registers could be any size.

--DXIptbhQMTEAc6oN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1pWuAAoJELSic+t+oim9ljYP+gJg6iM3xlWOJCiOXYYSUsf4
emkEnBp/8GlBuHYE05jPF1qVwjSwhWBRx2UkbjAyzkaO24pGDGF/zoI/oVI6zBVs
j2PuZtXqb7S1XO4F9oVoa5Jb3r/TZn1NcgyKHgoBHF8cSrMdLduANERJ0SS9OhRs
Ld1fwleVCnoT4HlyAsbHTBMvznr+kSpjQm/95KCuduB4IQbYFq4mUQvCsobTN1Yh
1EvYBqAfelwt5ptCqLHUdBk9Z0Afqu3UzNrHXGFNPALbWZfvMW9X9cKoK1/hyGAS
indPU1gqI9DuoL7ei7gg5Gnhphfje+pw8Og/LmF01K8rTzYj0PkGJHhuRJXhT9Z9
hShm1zkBwpEsI3XerVyq7CImXOExFWK5Y3HnFKA76zgfHa7eXgmZkq/v0Y7TTl3C
k2LRXLJ5aClOlLOOsvLNycbYiu665DNhEMyHUO9/s01tWmiVev+7160j9qrq08kG
Cyep8sseUkGEIQL4oM6JSdjSmr2WjCdM7ptpj6jErkX/2Hsbo2kRKTASM1kBhw6d
ge7MxeYimKSFP5UkPOkKNPhQ9tdlZuqxOieDqO3+N1NbkK9OyZOaJpqoIfyKxjrg
76aAO9/bebYi/cjwkjJnda3IldetZMQUnqWFSOI1OipVwHTyoy63Pt8ZmWNMxmiD
geJtfdQXZYfTPRvNb1/R
=yWqb
-----END PGP SIGNATURE-----

--DXIptbhQMTEAc6oN--

--===============2386238031807308739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2386238031807308739==--
