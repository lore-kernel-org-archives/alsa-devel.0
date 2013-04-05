From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/8] ASoC: ep93xx_pcm: Fix compile error
Date: Fri, 5 Apr 2013 11:25:47 +0100
Message-ID: <20130405102546.GG6597@opensource.wolfsonmicro.com>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
 <1364979607-15286-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5818757857583461578=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7337E265F8E
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 12:25:49 +0200 (CEST)
In-Reply-To: <1364979607-15286-2-git-send-email-lars@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============5818757857583461578==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HKEL+t8MFpg/ASTE"
Content-Disposition: inline


--HKEL+t8MFpg/ASTE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2013 at 11:00:00AM +0200, Lars-Peter Clausen wrote:
> Commit 453807f3 ("ASoC: ep93xx: Use ep93xx_dma_params instead of
> ep93xx_pcm_dma_params") introduced a small compile error by not updating the
> name of the 'dma_port' field to 'port'. This patch fixes it.

Applied, thanks.

--HKEL+t8MFpg/ASTE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXqafAAoJELSic+t+oim9o7cP/jgFMtQ45v/i9cj+58btCixf
e6IEvIhSdtCQIQ08Fu/a2HA4ugpSstMEBY/b7zrUDgOgRUdlC3YpNqipJAa6Ifi5
MJpnGRnzCpY3ywtf94EQUIzqH5y2DlFJaPQbutL/PTtlT0U0m0pQgJiLnA4H9AYk
2POBLoJRyadd9Lto4D3kEAwZkaGXXv57+vBI9pxpchaFHiqnBaw3fMFyJ2Od8l9M
SGqCdjgZ0MuK/Bmby6rS/fhQWCeH0OjlYIiFqpUb3I8bTMhKcCTvN1zne7MkNHB2
RnJSFv9Lb9cFL+1+Xrj31UdwpGb5YM1MuTRov6wSD/sLlkfIjR6DdQ6zdtRB8Hcd
isLUKQQFRRiVg6jDnbNFlNMbbNzmrGab5HEc1iot8VfaHi2dscVw6tA2/f6m3RqZ
5Dabt1KP3wH2up6EcoiSR+sKvzc04gW1uFpjZxCQlOBgCM4x11FfrfZhYoJwERck
q6TynNN4lStYdnIeTEB2F4sI3wDzNhysJEVtxuB4nBmmh2r/D1G/jzop/rsj88/T
74cRPi5q7wqcRSzFaCxkGmlVPj+CRMbTZyglou+VPvm/MEFZwC4TFLdvGRZkG4YI
ANppHPpb34JI56zNBBcA0Qsz4/H5ZMLANsg3KrkMpR+E5lFfyybuM1Eta5xu9jCI
zt4lYOR4B6UR9Cy9vh4H
=UD/p
-----END PGP SIGNATURE-----

--HKEL+t8MFpg/ASTE--

--===============5818757857583461578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5818757857583461578==--
