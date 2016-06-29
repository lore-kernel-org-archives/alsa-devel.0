From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: dapm: support user-defined
 stop condition in dai_get_connected_widgets
Date: Wed, 29 Jun 2016 18:34:38 +0100
Message-ID: <20160629173438.GE6247@sirena.org.uk>
References: <1467203559-28979-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3288064708262253337=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B117A265EBA
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 19:34:55 +0200 (CEST)
In-Reply-To: <1467203559-28979-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3288064708262253337==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 29, 2016 at 01:32:38PM +0100, Piotr Stankiewicz wrote:
> Certain situations may warrant examining DAPM paths only to a certain
> arbitrary point, as opposed to always following them to the end. For
> instance, when establishing a connection between a front-end DAI link

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdAasAAoJECTWi3JdVIfQuf0H/3PsXbUkQBLPPogxy3qD/ZKw
rduFqRYAKcQMMDWxKujxAdrJzg8wuK3/2oLaZkWR8lp19wd8hZHfEKoarRPyAdUR
Bztmw/hp6ZDQ6tsK3M1GIf6lklIAppJg6lNxerUjUuhWm6l3oacECXkH84WhgvNp
7tFf6gDfR/pjpHjrc06dOk3llafj4E7UwkAmFcTWrXnPNdcgVTOlm4vtXurMofPt
PHeCnmV/rYuJpj3kpi8E2CJbMD9uyA9AgvLuU4xknYEb0SqYCqF+t7i8yYizyaBI
QK1DU/W8FHchYwHhTWqYZ1lJ5LPXi6CQRkRBgK80AJ1eRnW7KG3b2Eb3vHyBcQg=
=QQtD
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--

--===============3288064708262253337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3288064708262253337==--
