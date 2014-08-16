From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH/RFC] ASoC: Drop const from struct snd_soc_dai_link
 *of_node members
Date: Sat, 16 Aug 2014 15:57:07 +0100
Message-ID: <20140816145707.GR28623@sirena.org.uk>
References: <1402929226-5547-1-git-send-email-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="foM9DbudB2CcldhH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402929226-5547-1-git-send-email-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--foM9DbudB2CcldhH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2014 at 04:33:46PM +0200, Sylwester Nawrocki wrote:
> Dropping the const qualifiers prevents "passing argument 1 of =E2=80=98of=
_node_put=E2=80=99
> discards =E2=80=98const=E2=80=99 qualifier from pointer target type" type=
 warnings when
> compiling the code dropping reference to cpu_of_node, codec_of_node or
> platform_of_node with with an of_node_put() function call.

Applied, thanks.

--foM9DbudB2CcldhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT73FAAAoJELSic+t+oim92bYP/0Jns5uTQ0QWpKiaF18M5fQh
ZvOiuTTNbAL/oRQGupUdfPeFgn+HE3d9/xDVyyrC9z8PmipbHi6usi+HPEmZhPHK
CZDmluJB7kgIp6R1g6F5XLNUF7MtV/89FJenBcz8x1NZFNOOGl9WmtLf+iqG3UJ9
x2gWThfS+cybhtuQfYYOxouLativGetHcovPN3gBi+nHVst3/s39J1z5oSjm29Rx
MWiw0R7zFx3h+UCOqvKHyDBDJE06o/jd+R7z2gITAN+LBUuUxOnEnlDqzbMUY7fk
PBp56fL6LZIcNQtq76+k91nvd7TkMz3wpRw5n8ORsfhXb8HOKH/VLd0njV+nd3y1
A9hZB4tVUZe7VmOgSnV8DJJZgETAXDnW4NeG0OYShQ92s/m6K6T3v7krOEcjLcS/
nZUbeHGfoD1iZrYVw8I41sFVG492XEWqgbg91hxhJVHTtF1VhWXAykH9tL5UU5Gz
jQMZdqTiICzRu1Uim6SINSUzQWT3T1dpsbdpDH7DWq4aOhdiSfkE2Hh4Qb6NhCcJ
MLzZ2OmdWKw19Mdo8VKnQeQ2vhaAtJLZI8QYIruyzUPUi77gLW/BhUD1Z2xHyToh
rkIfqX+XuLY4N19NJpAIV7A4FnKtdpxGxZSfDjK1k/uhEAqh8uEOxBtL5DjQjEEJ
PXOvfoGbKW8mugp98wCn
=K6qL
-----END PGP SIGNATURE-----

--foM9DbudB2CcldhH--
