From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 3/4] sound/soc/mxs/mxs-saif.c: add missing
	kfree
Date: Sat, 20 Aug 2011 15:44:39 +0200
Message-ID: <20110820134439.GA2266@pengutronix.de>
References: <1313820761-12042-3-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0494039541360951376=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 48719243A9
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Aug 2011 15:44:49 +0200 (CEST)
In-Reply-To: <1313820761-12042-3-git-send-email-julia@diku.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia@diku.dk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Dong Aisheng <b29396@freescale.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0494039541360951376==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 20, 2011 at 08:12:40AM +0200, Julia Lawall wrote:

> diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
> index 0b3adae..4a17bc8 100644
> --- a/sound/soc/mxs/mxs-saif.c
> +++ b/sound/soc/mxs/mxs-saif.c
> @@ -523,8 +523,10 @@ static int mxs_saif_probe(struct platform_device *pd=
ev)
>  	if (!saif)
>  		return -ENOMEM;
> =20
> -	if (pdev->id >=3D ARRAY_SIZE(mxs_saif))
> -		return -EINVAL;
> +	if (pdev->id >=3D ARRAY_SIZE(mxs_saif)) {
> +		ret =3D -EINVAL;
> +		goto failed;
> +	}
>  	mxs_saif[pdev->id] =3D saif;

Thanks, Julia. May I suggest to simple move the id-check before the
allocation?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5PukcACgkQD27XaX1/VRs7/gCglf5+sIRVoH2jDAqCqjEVVzTh
UX0AoKRND9QLZLtDrUYLrtJ1bczyZx3y
=Fu0f
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

--===============0494039541360951376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0494039541360951376==--
