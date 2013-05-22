From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add ssm2518 support
Date: Wed, 22 May 2013 17:07:56 -0500
Message-ID: <20130522220756.GF1627@sirena.org.uk>
References: <1369242013-27672-1-git-send-email-lars@metafoo.de>
 <20130522175705.GU1627@sirena.org.uk> <519D0B84.70307@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4945488481126624509=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A15E5261692
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 00:13:14 +0200 (CEST)
In-Reply-To: <519D0B84.70307@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Grant Likely <grant.likely@linaro.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============4945488481126624509==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+5X6wed+orjucm7J"
Content-Disposition: inline


--+5X6wed+orjucm7J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2013 at 08:16:36PM +0200, Lars-Peter Clausen wrote:
> On 05/22/2013 07:57 PM, Mark Brown wrote:

> >> +	if (slots =3D=3D 0) {
> >> +		return regmap_update_bits(ssm2518->regmap,
> >> +			SSM2518_REG_SAI_CTRL1, SSM2518_SAI_CTRL1_SAI_MASK,
> >> +			SSM2518_SAI_CTRL1_SAI_I2S);
> >> +	}

> > You've got quite a few single statement if () blocks with { } which
> > shouldn't be there.
> >=20

> I prefer to only do this for single single-line statements.

That's not the kernel coding style and I have to say these examples were
all jumping out at me as weird, I was looking for an else clause or
something.

--+5X6wed+orjucm7J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRnUG5AAoJELSic+t+oim95xgP/1KTrB2KGotNi+F2baTbJ3bG
fmSTQhhQUitoN46ugYxGD3warq1ZVwIMcf0a3oehToy3eKacDHER2aWhMTwpRQ4X
jRIWV3xhS2aToDylha0NTA+dGLwJNUmkNFaLfd83En7NzUMsq6vsJAYoiPI1R1aG
zvtRctoy4JL4IcsZ+RMUBptW6Dwk0RwLb9lqs2romOmQEhCGpVkbc9Kv/ouBXuD5
bjJImEL8wlt4H5I7p082Va1VGxfrjrFsxpJ9IvOvduxHrHTUrDTjGlZlQKjT26DO
/1HVCPhcczFsY2yhmDS5hCEVd6s3+Zc29YU78KureHnxJbQ4cs14zgqv0ZUPAdUQ
c/tPDTiBDYGQykByeuSbi96kf4o7MmammVCHul1/sY7dTD7+rNY3O3z3x1iEIAUN
tLkyfvIGQ1ocyiPXj0rfbhK8+vuJdQZdfBRoQwsA8JHyzy+fwdfaBe9C+sK0d11V
KKpsJFBO2RFTbWBR+0CTu8vYpioVLC16kz9KDDZrFK+DmlCA+/FxxqwtsdJP0rPC
2Q23cmlpFlKYlznWQCu48xhPlWlxiLQZL3gRGRr+3ruw5uTMVnbltQTQyG/pgzxe
CC3mc33XhrJupsJy4OwDOe+3JgEk8V2we7EsHizDnW8MdVLN1cDZqtxHSy/gPXq1
fPVkGcqzzlQNJ6euSP1F
=XQto
-----END PGP SIGNATURE-----

--+5X6wed+orjucm7J--

--===============4945488481126624509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4945488481126624509==--
