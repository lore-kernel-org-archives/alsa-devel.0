From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 01/10] imx-ssi: Fix AC97 rates
Date: Tue, 12 Mar 2013 18:52:26 +0000
Message-ID: <20130312185225.GS19942@opensource.wolfsonmicro.com>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2269780330286167394=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1362940391-8338-2-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============2269780330286167394==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZmeoGP/RI+eIV+cU"
Content-Disposition: inline


--ZmeoGP/RI+eIV+cU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2013 at 07:33:02PM +0100, Markus Pargmann wrote:
> From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>=20
> This device supports multiple rates as described in later AC97
> standards. This patch allows playback of different sample frequencies
> without conversion.

Applied, but some notes about why this is already supported would be
useful and *always* use subject lines appropriate for the subsystem.

--ZmeoGP/RI+eIV+cU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRP3lfAAoJELSic+t+oim9xBoQAJe3rLMGLA2jyoSuiZ963G9w
wcx7qnAtUO69Q8IY+KD0taZ2jNTesExE89/TV3xLAbDuy2royWFui1awjyhbE7pS
/t5fESe5H5UHLxZOY/kXdKDA0eaH1Ow8dKr92CAMZA31P0womMO4yUA4Wh5UEED1
/eOlwXdmFT25ee5j9AcmjcXJxwRCbqNa6l0Ym8Yf2V1dnQyGYsEgNfl8oPMAavxD
2OkvA4GlDP/+75dfaTVPMrqXF8BYUvw2a6ghv96qiy+9xwDtnL9RAmi5qmMQLqJ+
8XJTRaC8BA3h+0sYYNPWTrojx2dEHOvoPevqBOoHKXw5UsjeHHoXugqO+wMSytPN
60P9dygcC6/n0xqUDgVudmcBRY0T79tdk2SvleN8DIRiFfQlVx+UoLlr8Vco6pq9
UABGyA2X4ml09V2mWo2U7rkBhquiq8F6f+WK76Lr8iA+PduSVGUhFeBsmX0MhXbO
k0VIAmSfU1mF8XyXBT7M1iY+WZBIsL6wZFwhu7z+IGvX2YXGG7hC33OIOxqaq1ga
fQtqWBBwYGorcFdF0X8V4R+gO9G08ukYJIsy15D4sug1XAp6Zq5lz194twYY0VqA
c85IOjTvhIZ5QFLwgXaZ87orjyDwzvTqm0lPRuWfvDR38T/aZGboKVS+N/VK0Psj
Xww9zVtiHO4+xX4IJHPZ
=dIv+
-----END PGP SIGNATURE-----

--ZmeoGP/RI+eIV+cU--

--===============2269780330286167394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2269780330286167394==--
