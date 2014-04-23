From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] ASoC: jz4740: Improve build test coverage
Date: Wed, 23 Apr 2014 12:19:15 +0100
Message-ID: <20140423111915.GR12304@sirena.org.uk>
References: <1398199596-23649-1-git-send-email-lars@metafoo.de>
 <1398199596-23649-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="48tF7E/GPXHbtDSk"
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1398199596-23649-6-git-send-email-lars@metafoo.de>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--48tF7E/GPXHbtDSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 10:46:36PM +0200, Lars-Peter Clausen wrote:
> Allow the jz4740 audio drivers to be build when CONFIG_COMPILE_TEST is selected.
> This should improve the build test coverage. There is one small piece of
> platform dependent code in the jz4740-i2s driver. It uses the DMA request type
> constants which are defined in a platform specific header. We can solve this by
> moving them from the platform specific header to the I2S driver.

Applied, thanks.

--48tF7E/GPXHbtDSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTV6GvAAoJELSic+t+oim9QNQP/3BJUmwUr6o+uu3krdMj9UTm
IbSLTXq9cT0JwG4IL2y+9vvy7zNiLIcRSgQTGbUAVCtftRGz/NnK+twD5idGCtDW
iU4esKJSM148DGfE6qExe7Ng8l/MhzPn/BvzTtKRGx4OwU7EcD3+qiHn2gL/Xjf0
4GYq6Ns/Ra2nkwNdFGB6bQ9aeWHbrQoGalpZpBvVR6NKLVbXeqQyG1U2x+GBJ01z
e2OEDEnR4IlGqlAChmiSF3JFgOl/tHz7krumHUFpaS943lUNvy3FK6r1AccXRvu2
/ipi6B8ebHS0DAF1lmAGOrdgdVwGhpCeZE0q1QH8oyWhnv+KqKw4x/9OJ1Xyo12j
JCG9WYMuaEDYzOMXhhQOd3bOK5KxEXr92M8X8hhQIS+biVGDmQfarhX+UwF19qlh
/6LQP2xwdsJCTPt4yZ3g+wLOl1mEtPqv39O0N6lk4u3w3KjtFo1W8vRvdlUjz0VG
yQobhiNZA73yOpw2fffTsnfluoLkVqpyKbsTxP8mzLDwEsKAkWesfChbJx/QNJSS
wemUnVIPTErMnVvxVJS7p2iH+2r3BiLQc/WlQulqhvq1y+QMn34RkeG3qtF68MUD
w/190gd5ElSuU5yQC+6ZiwYnlAhRr0hHgMojXapgt8F9aiLHSe7SO1uDIJ+xDwFD
FN39iOjLAaG4DzmNm+gN
=AmXx
-----END PGP SIGNATURE-----

--48tF7E/GPXHbtDSk--
