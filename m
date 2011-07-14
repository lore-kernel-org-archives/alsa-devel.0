From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2 10/10] ARM: mxs-dma: include
	<linux/dmaengine.h>
Date: Thu, 14 Jul 2011 16:17:37 +0200
Message-ID: <20110714141737.GE1904@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310528454-25178-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1551701100176804994=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 8637A1039F0
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jul 2011 16:17:39 +0200 (CEST)
In-Reply-To: <1310528454-25178-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1551701100176804994==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Content-Disposition: inline


--7CZp05NP8/gJM8Cl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 13, 2011 at 11:40:54AM +0800, Dong Aisheng wrote:
> Other files using dma.h may fail to compile as follows:
> In file included from sound/soc/mxs/mxs-pcm.h:22,
>                  from sound/soc/mxs/mxs-saif.h:112,
>                  from sound/soc/mxs/mxs-sgtl5000.c:34:
> arch/arm/mach-mxs/include/mach/dma.h:16: warning: 'struct dma_chan' decla=
red inside parameter list
> arch/arm/mach-mxs/include/mach/dma.h:16: warning: its scope is only this =
definition or declaration, which is probably not what you want
> arch/arm/mach-mxs/include/mach/dma.h: In function 'mxs_dma_is_apbh':
> arch/arm/mach-mxs/include/mach/dma.h:18: error: dereferencing pointer to =
incomplete type
> arch/arm/mach-mxs/include/mach/dma.h: At top level:
> arch/arm/mach-mxs/include/mach/dma.h:21: warning: 'struct dma_chan' decla=
red inside parameter list
> arch/arm/mach-mxs/include/mach/dma.h: In function 'mxs_dma_is_apbx':
> arch/arm/mach-mxs/include/mach/dma.h:23: error: dereferencing pointer to =
incomplete type
> make[3]: *** [sound/soc/mxs/mxs-sgtl5000.o] Error 1
> make[2]: *** [sound/soc/mxs] Error 2
> make[1]: *** [sound/soc] Error 2
> make: *** [sound] Error 2
>=20
> It seems it's better for dma.h to include dmaengine.h himself.
>=20
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Sascha, maybe we can pick this one up already?

> ---
>  arch/arm/mach-mxs/include/mach/dma.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-mxs/include/mach/dma.h b/arch/arm/mach-mxs/inc=
lude/mach/dma.h
> index 7f4aeea..203d7c4 100644
> --- a/arch/arm/mach-mxs/include/mach/dma.h
> +++ b/arch/arm/mach-mxs/include/mach/dma.h
> @@ -9,6 +9,8 @@
>  #ifndef __MACH_MXS_DMA_H__
>  #define __MACH_MXS_DMA_H__
> =20
> +#include <linux/dmaengine.h>
> +
>  struct mxs_dma_data {
>  	int chan_irq;
>  };
> --=20
> 1.7.0.4
>=20
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4e+oEACgkQD27XaX1/VRvVMgCgl5fbfJzescCi3H02ZZunuoDC
ZIgAoK6z5CR5x3eY+vAb5/tfBiAmKPW8
=QV8U
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--

--===============1551701100176804994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1551701100176804994==--
