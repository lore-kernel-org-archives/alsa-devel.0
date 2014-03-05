From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: io: Remove hw_read() operation
Date: Wed, 5 Mar 2014 09:25:04 +0800
Message-ID: <20140305012504.GO13126@sirena.org.uk>
References: <1393924251-6754-1-git-send-email-broonie@kernel.org>
 <53159AD0.5000800@metafoo.de>
 <20140304092723.GH13126@sirena.org.uk>
 <5315A0CB.1020300@metafoo.de>
 <20140304101135.GJ13126@sirena.org.uk>
 <5315B847.3040203@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7378460425587050507=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 10B3426582E
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 02:25:15 +0100 (CET)
In-Reply-To: <5315B847.3040203@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7378460425587050507==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iEWWOZ/QYGWEaBRW"
Content-Disposition: inline


--iEWWOZ/QYGWEaBRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 04, 2014 at 12:25:59PM +0100, Lars-Peter Clausen wrote:

> Yes, it's only used in the core. There is still snd_soc_write(codec)
> and friends which wraps them like
> snd_soc_component_write(&codec->component). But on the long run I'd
> like to see all snd_soc_writes be removed from driver code.

I'm not entirely sure there - the repeated indirections we have aren't
always the most pretty bit of the code we have, helpers wrapping the
lookups can be useful.

--iEWWOZ/QYGWEaBRW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFnzsAAoJELSic+t+oim9pmYP/1K73ygKJP5VpaYIZePiVoQE
eDaCgdb570Wxghrim6oa8IdTeq7MBZYUY0QcI0RgS2e65MCqsSv58Ul4X9OmiLFv
3rmcwNFW4EfJryX/oOvUFoT+lwh0Tw/56t1mtpDv80rU3wh56Q3mx/bvdM5Lf9JU
5GOyrwOpfyLekVgOxdKo8TKtj7EyA1OR8c4/GkeDrWuFb+krR1xYE2yR5C50IBbG
eMshEqB9aNxTiLpaluAxYhaVNZ5nd8qnR9a2h0iCyo9L5ggGwt5g0qMm1dlzr1rM
Nz6wPSoGNCROHrV/CvxBaGx/JHP2OXJtEGIIzqQcpABWvqINM1H1OdRKIgh+xErT
SQlLVctO/oYuIoY1gpv9QL5lYy9OWDrjfG/1LisOnWla8GY9IbPROBN9I13Xo/jd
Fi7nUiO3nUocpbil7ydPt5nh8HPaeegBCSOZ5z/SaVSF8jSNitx3rckieGpRBdDd
reQHN1sVK+o0Ux0GlPB5cnGzRBoC4spGSyTj3B9jG0aBKQ2oy15jQcPvYtoMX4pu
f4sHgXpBM3AB6Ly1FGB8qDQxh7wD7SidjLdvT94ipwivrbUE5j+M8bAZbLaRsULz
q8fQt8GNXy3RaTMca3NKUIIDSo5J7KVc0KjBKl2m6Inpz9CDFnGonWceKu/J8uCV
XH5r1mOtD94acHiBNjNy
=2l98
-----END PGP SIGNATURE-----

--iEWWOZ/QYGWEaBRW--

--===============7378460425587050507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7378460425587050507==--
