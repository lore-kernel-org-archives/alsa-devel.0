From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 2/5] ASoC: fsl: add imx-tlv320aic3x machine
 driver
Date: Wed, 10 Sep 2014 16:27:40 +0200
Message-ID: <20140910142740.GC16489@pengutronix.de>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410356809-26179-3-git-send-email-d.lavnikevich@sam-solutions.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2330164236089872305=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id C1BC3262606
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 16:28:09 +0200 (CEST)
In-Reply-To: <1410356809-26179-3-git-send-email-d.lavnikevich@sam-solutions.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tiwai@suse.de, Li.Xiubo@freescale.com, linux-kernel@vger.kernel.org, timur@tabi.org, nicoleotsuka@gmail.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, galak@codeaurora.org, grant.likely@linaro.org, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org


--===============2330164236089872305==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 10, 2014 at 04:46:46PM +0300, Dmitry Lavnikevich wrote:
> This is driver for i.MX6 boards with tlv320aic3x audio codecs.
>=20
> Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
> ---
>  .../bindings/sound/fsl,imx-audio-tlv320aic3x.txt   |  27 ++++
>  sound/soc/fsl/Kconfig                              |  13 ++
>  sound/soc/fsl/Makefile                             |   2 +
>  sound/soc/fsl/imx-tlv320aic3x.c                    | 177 +++++++++++++++=
++++++
>  4 files changed, 219 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-audio=
-tlv320aic3x.txt
>  create mode 100644 sound/soc/fsl/imx-tlv320aic3x.c

Is it possible to use the simple-card
(Documentation/devicetree/bindings/sound/simple-card.txt) instead of
adding a new audio card driver? There are also DT bindings for the imx
audiomultiplexer (imx-audmux.txt).

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUEF/bAAoJEEpcgKtcEGQQ8FUP/1T8kBw9DpI+zwwwpLSehGQm
6Ji7FrbHkdebaT67xrOD4mtqepsmRdIdJ/Nj3epWLwwNjJMJOYtzPGOQzYvZxMiT
3PwhyRMmWrU86fFoZlK1rO8/mY/ZF0VmAjzMnvO6fQpO9f/sl+z+bTYJbzTzfp3Y
i2MQ/FF4CGCEOUZtFpu8Tth1YyKhAkI6HQd/px4JJ+PmuEy54xRZuu9k7COYvogH
faVBV0qaYGhBhMLN5UPVEuRjlaphc+WyD0dq9/F4HCODhhQK/Apsz0fDoFr3p5A4
isfxF05I9iQGOFbdx45vqUW87NXjXiqtfHgdt2W3cZjC80IVd469pbSTBkfW8ncb
nzoMV1wswMGTPcr5pVorVoOesj2DQ5H+lebem2aO4c82g9JF2nAZjVCcph5RSjoU
ZxzcWzjEkWBMZxXyP7n20pL8VjOVwOe6Qi64LYIQXxlFRn4ivlzLj69HC3wOMtG5
aP6J3pcoH9+2yOMEWxkSrhjcY72GY9Q3Nqe9U7unFtond/AM7/MAvOEe/kwrsYfr
1SK2o5InF4C07Twla6gV6xnJcx03OCEQsGfqHoSxyaXmS+XWtQ/pbUOoSV7Mm7DM
gDjPsz+8MQmCmhlWp7Q7OS52Ky55EPS7r9Hq9Hcvx9D7+ybb9HnxP5XFHY+n/Fm1
VDG9BEJrmQ5mKC4SHwip
=/Noa
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--

--===============2330164236089872305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2330164236089872305==--
