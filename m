From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/14] ASoC: cs4271: Fix wrong value
 references for boolean kctl
Date: Tue, 10 Mar 2015 20:14:04 +0000
Message-ID: <20150310201404.GK28806@sirena.org.uk>
References: <1425987556-569-1-git-send-email-tiwai@suse.de>
 <1425987556-569-4-git-send-email-tiwai@suse.de>
 <000f424d.62f04d674689d696@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4792492217081972903=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DAE842605A2
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 21:14:29 +0100 (CET)
In-Reply-To: <000f424d.62f04d674689d696@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "lars@metafoo.de" <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============4792492217081972903==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/cYA8VCGycg41AiS"
Content-Disposition: inline


--/cYA8VCGycg41AiS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2015 at 01:14:49PM +0000, Handrigan, Paul wrote:
>=20
>=20
> ------ Original message------
>=20
> From: Takashi Iwai

Dunno what your mail client is doing here Paul but it's pretty
spectacular...!

>=20
> Date: Tue, Mar 10, 2015 6:39 AM
>=20
> To: Mark Brown;
>=20
> Cc: Liam Girdwood;Lars-Peter Clausen;Austin, Brian;Handrigan, Paul;Charle=
s Keepax;alsa-devel@alsa-project.org<mailto:;alsa-devel@alsa-project.org>;
>=20
> Subject:[PATCH 03/14] ASoC: cs4271: Fix wrong value references for boolea=
n kctl
>=20
>=20
> The correct values referred by a boolean control are
> value.integer.va<http://value.integer.va>lue[], not value.enumerated.it<h=
ttp://value.enumerated.it>em[].
> The former is long while the latter is int, so it's even incompatible
> on 64bit architectures.
>=20
> Cc: ><mailto:<stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai ><mailto:<tiwai@suse.de>
> ---
>  sound/soc/codecs/cs4271.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
> index 79a4efcb894c..7d3a6accaf9a 100644
> --- a/sound/soc/codecs/cs4271.c
> +++ b/sound/soc/codecs/cs4271.c
>=20
> Thanks!
>=20
> Acked-by: Paul Handrigan ><mailto:<Paul.Handrigan@cirrus.com>
>=20

--/cYA8VCGycg41AiS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/1CLAAoJECTWi3JdVIfQGb0H/2M8novG5Gu/ZFWgldTMfHlS
sOsmEshWJHMyglKfrJVIcsoCx5Pl2GLBAJDh6hG+b8TkROp1XrSdVSqz+k3qd7Pg
BmR/Zsscbz5shRMyFLzRQDhgbfJNP8eJZr51XrqcdkjD2rRZ9BWhAQaHUwpEBpf0
EoaOF5EdiIpH950yf2QzTd6ZgMJbYIJviMCAuhxrBY2/Z9rbIp/R54n5w9LeeELh
3xh2D+hXrjqFJcHtqYXQC4bONoAM0JOo9Uvx7Gn2twRmCk/qjy6WlUeA9fMVQn/V
pAOIaeZicsGrNeFgJmjEHkroA3x+F2PUtKB7OYogB3eeN+BYd9Ko+rt4ERwebVE=
=10NU
-----END PGP SIGNATURE-----

--/cYA8VCGycg41AiS--

--===============4792492217081972903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4792492217081972903==--
