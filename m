From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000
	machine driver
Date: Wed, 13 Jul 2011 17:58:21 +0200
Message-ID: <20110713155821.GL1928@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3279104683025163842=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id E0BFC24377
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 17:58:23 +0200 (CEST)
In-Reply-To: <1310483085-31442-4-git-send-email-b29396@freescale.com>
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


--===============3279104683025163842==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eMP3JyRexyk9c0Bv"
Content-Disposition: inline


--eMP3JyRexyk9c0Bv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 12, 2011 at 11:04:38PM +0800, Dong Aisheng wrote:
> The driver only supports playback firstly.
> For recording, as we have to use two saif instances to implement full
> duplex (playback & recording) due to hardware limitation, we need to
> figure out a good design to fit in ASoC.
>=20
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  sound/soc/mxs/mxs-sgtl5000.c |  170 ++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 170 insertions(+), 0 deletions(-)
>=20
> diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
> new file mode 100644
> index 0000000..be9b5d5
> --- /dev/null
> +++ b/sound/soc/mxs/mxs-sgtl5000.c
> @@ -0,0 +1,170 @@
> +/*
> + * Copyright 2011 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, write to the Free Software Foundation, Inc=
=2E,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>

No parameters here, drop it.

> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/fsl_devices.h>
> +#include <linux/gpio.h>

The last three, too.

> +#include <sound/core.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> +#include <sound/jack.h>
> +#include <sound/soc-dapm.h>
> +#include <asm/mach-types.h>
> +
> +#include "../codecs/sgtl5000.h"
> +#include "mxs-saif.h"
> +
> +static int mxs_sgtl5000_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> +	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
> +	struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
> +	unsigned int rate =3D params_rate(params);

Here you initialize 'rate'...

> +	u32 dai_format, mclk;
> +	int ret;
> +
> +	/* sgtl5000 does not support 512*rate when in 96000 fs */
> +	rate =3D params_rate(params);

=2E..so this line can go.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--eMP3JyRexyk9c0Bv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4dwJ0ACgkQD27XaX1/VRv9uQCffeq4gq541YBwifNTJRTs6w0S
pVAAnjqYzQMxSEk8YOILytV+GhRClFf3
=4UBa
-----END PGP SIGNATURE-----

--eMP3JyRexyk9c0Bv--

--===============3279104683025163842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3279104683025163842==--
