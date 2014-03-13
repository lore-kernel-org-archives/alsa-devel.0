From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 07/12] ASoC: davinci-evm: Register
 machine level DAPM elements with the card
Date: Thu, 13 Mar 2014 19:11:32 +0000
Message-ID: <20140313191132.GI366@sirena.org.uk>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
 <1394634460-15889-8-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2622247434456601133=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 80CB72654AB
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 20:11:48 +0100 (CET)
In-Reply-To: <1394634460-15889-8-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Ryan Mallon <rmallon@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <daniel-gl@gmx.net>, Benoit Cousson <bcousson@baylibre.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============2622247434456601133==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R0UoHh4jwSc8qXKC"
Content-Disposition: inline


--R0UoHh4jwSc8qXKC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 03:27:35PM +0100, Lars-Peter Clausen wrote:
> Machine level DAPM widgets and routes should be registered in the card's DAPM
> context, rather than in the CODEC's context.

Applied, thanks.

--R0UoHh4jwSc8qXKC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIgLgAAoJELSic+t+oim9KYQP/0X+AqeB2ZOV+LRWr4EPbNE/
W44nogCscb/fv1MEmoeuSWlferDkL/gEdfUWms8WzxjYDyHmDZkhvtW6PC7sz4qu
JgwPOdEzjAJgbLpEPDJ7AFzSGq09F59O2MHn10vqhGF4QLVf8crJtkJJAnsgBm9O
m7RiFY4kXwDh0xw5aZ4Kt4/jooxH7NxOw+MbpH1RRRPEuNbevS/ykTgQf+EUB0Db
IS5LxxyFWhZWwsqfQt/U2mtYZMtRmqq08/A6uvdYjoNPZPrUZH3w1Hu13mx4+Hyj
ouXXdFg8gddzuiRvH6i780ygtOB15uTQQ4msh/EOGVJdNrGsVGRnuZBMsYlO7H7B
dx6et7jA7seWKj8/OFqTGGThi52thMCakX2SzIdn9Ex+ygif1Mm9EicLJdc6HgOj
/CKzqll29Wk9VL+LThfnF/9niYAoRo/mzxY5QsrXarx8pnp3ohKHbSbF9ouT3fUp
ozUw2kqI/a2hEQNIjblmmfKoaCv0lSEJhLymV1i+TZ+Eif4sgUzVyx0a18JqtXHW
Mf0JtO1YDqkPZV7vC+zeyU3ikLtzP1rNSFT+dTEevW4AbJB3LiheKNUk6PdDuwIk
bvEktwExXfJlNFh4YAtO2CuQxP1NjDYDKYAfgZTXEk+/ceGwwXgcolM1npgbCqsU
EXjrpzuGGheIFy1+nT0H
=c1j6
-----END PGP SIGNATURE-----

--R0UoHh4jwSc8qXKC--

--===============2622247434456601133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2622247434456601133==--
