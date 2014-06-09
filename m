From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sigmadsp: Split regmap and I2C
 support into separate modules
Date: Mon, 9 Jun 2014 21:24:44 +0100
Message-ID: <20140609202444.GY5099@sirena.org.uk>
References: <1402056557-31348-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6700432593298692605=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BA4F126567A
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 22:25:02 +0200 (CEST)
In-Reply-To: <1402056557-31348-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org


--===============6700432593298692605==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0Yt18YowHM3Aoknw"
Content-Disposition: inline


--0Yt18YowHM3Aoknw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 06, 2014 at 02:09:17PM +0200, Lars-Peter Clausen wrote:
> When the SigmaDSP module is built-in, but the I2C core is build as a module
> we'll get a undefined reference:

Applied, thanks.

--0Yt18YowHM3Aoknw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTlhgJAAoJELSic+t+oim9ZwEP/3s2ZzY8K9PQkv4pSguJyZbv
Tl2iY615N0aPaamC7XAN4kHMuW5zlTcbTXfbDAM+M/QUN3aee8i81xt5jpKNXUWE
JZyefv5vg8PlmwOj4laK3TrC6WI7sHwDYWhDfKtHvsKqReP+xFSExtHh94gJmIXz
hsCVot3YjpKZl6B2UbpKegZ/fUOaMGRsvoqvK+W9gjtmJll2i2aZ1fqBUPbZ9Uhh
QewJJDQ2XJ+G5IoaF0xUP2fej2MYgdc4pNt68lFYimPfg43/ukN/1P45YYqK6wtg
o+QxSkI5dCGE888Lw7ZlAaKFVKt7a15F2JJ+TiNf5dl0mYzfBE1sM3BwUpnhl7Ih
2xqdYcW+7COwXyZoYtgRfypaw2vts/ua/nH6hsaST1nx6MYqLkYn1zEI0csZhr4R
JNvnhHZNfAl+lZC+ejmlxl7WKpdUrLrKPODTRNibljIsSupX4wA7R8GMGhRJfG9j
pJ8QD1FMlcYg3ky/s3VnOymENPGwJXDQMnQdAduAnqtatWGY7AF8Z+uVg+tKjUti
GvaSW3hA/i/y5JNoyUM8uW0er93Iqe+JE1v05yRjxt+rzkybcunnYJIgNCJ+4I/M
M2eJeXV3Y220KhufOkANOVu58+G/4YAl3JKRyBX2LJFjmYUSuBNTuV4NG5CUEtXM
Xuzh60ew9Vgsw67cEj95
=6p2b
-----END PGP SIGNATURE-----

--0Yt18YowHM3Aoknw--

--===============6700432593298692605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6700432593298692605==--
