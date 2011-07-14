From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V2 01/10] ASoc: mxs: add mxs-pcm driver
Date: Thu, 14 Jul 2011 14:31:06 +0200
Message-ID: <20110714123106.GB1904@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-2-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0848534485850926245=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id E94E81039E1
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jul 2011 14:31:08 +0200 (CEST)
In-Reply-To: <1310483085-31442-2-git-send-email-b29396@freescale.com>
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


--===============0848534485850926245==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> +static struct snd_pcm_hardware snd_mxs_hardware =3D {
> +	.info			=3D SNDRV_PCM_INFO_MMAP |
> +				  SNDRV_PCM_INFO_MMAP_VALID |
> +				  SNDRV_PCM_INFO_PAUSE |
> +				  SNDRV_PCM_INFO_RESUME |
> +				  SNDRV_PCM_INFO_INTERLEAVED,
> +	.formats		=3D SNDRV_PCM_FMTBIT_S16_LE |
> +				  SNDRV_PCM_FMTBIT_S20_3LE |
> +				  SNDRV_PCM_FMTBIT_S24_LE |
> +				  SNDRV_PCM_FMTBIT_S32_LE,
> +	.channels_min		=3D 2,
> +	.channels_max		=3D 2,
> +	.period_bytes_min	=3D 32,
> +	.period_bytes_max	=3D 8192,
> +	.periods_min		=3D 1,
> +	.periods_max		=3D 255,

When using madplay (for MP3) instead of aplay, I get

[ 3310.010000] mxs-dma mxs-dma-apbx: maximum number of sg exceeded: 128 > 53
[ 3310.020000] dma dma1chan4: cannot prepare slave dma

So, the mxs-dma limit should be taken into account here.

> +	.buffer_bytes_max	=3D 64 * 1024,
> +	.fifo_size		=3D 32,
> +
> +};

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4e4YoACgkQD27XaX1/VRvKsQCfb/cNAGA+YUveRe1Maglugkd3
XJsAn3B7zQPRvdxp1dzZ5Ss1JqY8hwqh
=1KwA
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--

--===============0848534485850926245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0848534485850926245==--
