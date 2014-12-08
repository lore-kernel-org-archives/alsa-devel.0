From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm512x: Trigger auto-increment of
 register addresses on i2c
Date: Mon, 8 Dec 2014 20:46:32 +0000
Message-ID: <20141208204632.GE11764@sirena.org.uk>
References: <1418052791-4257-1-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5239891657700652109=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A146F2604CA
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 21:46:51 +0100 (CET)
In-Reply-To: <1418052791-4257-1-git-send-email-peda@lysator.liu.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@lysator.liu.se>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============5239891657700652109==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TXtjXAp+Y+VkYOQB"
Content-Disposition: inline


--TXtjXAp+Y+VkYOQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2014 at 04:33:11PM +0100, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
>=20
> When the codec is connected using i2c, it will only auto-increment
> register addresses if msb (0x80) of the register address byte is set.

Applied, thanks.

--TXtjXAp+Y+VkYOQB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhg4nAAoJECTWi3JdVIfQBFsH/jgZKWh1oR94M7ImgAm7YCet
3P2ZpHql2rGjNFwilWNr93NnrNxvXuo41ZwzERjBWwbhGndbCQMeDGAKEo6ZQEOr
zv2MiAd0PXMOhffTBFmn0tT/PLSMPJbxiY7k2Fb9xaeekbt3yoNLP5LLVKZQSFHq
uWfpTXJ/Reip0O3gQtste63c4WzXyNwimnbHuEb+bnezSi1lw9xLiZFLD2cpR/US
S0AQf0xSCAriDHblAExVTXgAfK0IVBW+/HAT9o7XP3yTlzfIiueexBzYlt1NWoPQ
1wQQnfZ25ewnxuImp7q5o8Y0pmSkB1Vhe5n5HeLTSd2XdOOTlN4vIAjve597lq0=
=KhOD
-----END PGP SIGNATURE-----

--TXtjXAp+Y+VkYOQB--

--===============5239891657700652109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5239891657700652109==--
