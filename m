From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/11] ASoC: mop500_ab8500: Staticize non
 exported functions
Date: Wed, 15 May 2013 08:52:18 +0400
Message-ID: <20130515045218.GG24524@sirena.org.uk>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
 <1368562797-10440-8-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9015591087590837030=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 10CE726109E
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 06:52:24 +0200 (CEST)
In-Reply-To: <1368562797-10440-8-git-send-email-lars@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Fabio Baltieri <fabio.baltieri@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============9015591087590837030==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hTiIB9CRvBOLTyqY"
Content-Disposition: inline


--hTiIB9CRvBOLTyqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2013 at 10:19:54PM +0200, Lars-Peter Clausen wrote:
> The mop500_ab8500_startup(), the mop500_ab8500_shutdown() and the
> mop500_ab8500_hw_params() function are not used outside of mop500_ab8500, so
> make them static.

Applied, thanks.

--hTiIB9CRvBOLTyqY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkxR/AAoJELSic+t+oim9JCQP/Ri0X7BMRUYS3A1/esu7WOoQ
eU/XC/YWMeq8/aAaNpXSpgdTFbsiZRi3nCtwMt3TVh5S6COSH6dYxP78Xx6tIYAy
cb0RLFiuF9WzlCpKKuDqoJi6G/Lr3D8P29m/KZW2a6TqYf7H684JonAFKXjAb4Zv
s8dGRSKRAIpKdC6tu4OPRaLE/6kS2hcolN9Y+uE5LMh3UKHku0ODjwjqmLsAFfrO
0aUNb1QqXUmHBoj0sNmqptApQj5xQ0fRjOPRhyIUOopGwPgkkbogwBsUl8iQwpGZ
o6quuZGtopEmMNb526rcLpkKSOJf6PajTIp4EXB+83AU95YWr7B3q9Q2yf20QmzV
d7rTF0X3lpHDMoc3PQ8ut0Cl95oJSr+epduwD5SFrHgfbRLDdFTPbiUs4ao6dQxD
CxBfKJzC2ogI5d/uMos9HVeIphzDpLU0qd8wS0i9vbhCFif4BTuWr/YwL3cpT7LE
afIusLUIzFHyMAmFm4IryuZ9j0lfxscJ1GyHG9WKN3QjhZWIalzFESsN3E1S9LcR
o7Xiidqvhvlzs27ZoxibFWnf1DBymoAXhd4tc8e3WIrv9zPVLU5OvWZPySdy9knr
SGAke8j9YN7bhlASMkt2g/Pm9Bc11Hz9DVtPJ5UNzhvV1lZEsg4XVgD5lOT3sL8l
MHW/V9C3aoZR0qoKFhxr
=pmLw
-----END PGP SIGNATURE-----

--hTiIB9CRvBOLTyqY--

--===============9015591087590837030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9015591087590837030==--
