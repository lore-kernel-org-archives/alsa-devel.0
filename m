From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v11 7/8] ASoC: fsl-ssi: imx-pcm-fiq bugfix
Date: Thu, 22 Aug 2013 11:10:52 +0100
Message-ID: <20130822101052.GX26118@sirena.org.uk>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
 <1376924761-4054-8-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6170446650934352816=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1376924761-4054-8-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Michael Grzeschik <m.grzeschik@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6170446650934352816==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yYeq/WQYi/kuVVbm"
Content-Disposition: inline


--yYeq/WQYi/kuVVbm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2013 at 05:06:00PM +0200, Markus Pargmann wrote:
> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
>=20
> imx-pcm-fiq is checking for TE RE bits, so enable them only if
> necessary.

Applied, thanks.

--yYeq/WQYi/kuVVbm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSFeOoAAoJELSic+t+oim9aDAP/Rq6P0EDqqb9FaP7z5PhDN9x
Lu66/9CZpQB3EQADX8bj1vRPPV9DqCWqkLdsds3B/oIuEZ0EDK7RbE/qOQg7tz7v
LELoDd4fEOFPZAioeyOydiCQzg6nhtyRWvZxr/7AgSzPap1F6LbkbJ1Q5W26BTxm
1MuBI/4leO15Y4AUR12Z1AtgdF5QDFoQfFN9NxeMpsWkrMRxCvuOuyWgBqZIk2cc
DmKzqx1xauT8LAinEojRyANMJRdBU6U9Xf2fTzuwNCXJTnKhBRzT2fO8CgPaiu/W
hJ5cyAAtWrvdx0tci1yjR8zQ66NQc3qiuBfqzpzZBRfVg9doxyzkxoN2FL7dOz/0
zRGRebjeEu8GOnvHmTSNNy7Dh1pOBwOP/w4ClimFjC+eu1SxqNVEHkSC7jGriidM
n+4GFakMKmTnYSrUr+Ew1HEjxJM5cu2+N4wUodCc+eXI3AT5wTP05SgfBXkvZ9wO
LU57gx1LRLSGDcxZ1ux3BjbuyF9PoEGVAgpH61Avz+vyF2Skcd9Ygzd3wNIQuyL9
GYQ//IUK/NdPaeqNAs53Ns9uwZAzzDTGlhu8B/48sFVNAUopo524PDQSLfTRZZge
yUyYAmSOgUSSYT3LIx/TzAY2WJ+UJAeOVXTWm56nOzwwnsxDGsFUmU4Z+hAQXSeQ
/PHGLr82TRPOTD+hFvfn
=MkAJ
-----END PGP SIGNATURE-----

--yYeq/WQYi/kuVVbm--


--===============6170446650934352816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6170446650934352816==--
