From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: amd: added error checks in dma driver
Date: Tue, 28 Nov 2017 11:52:10 +0000
Message-ID: <20171128115210.n3lp3s2ryygx2m3v@sirena.org.uk>
References: <1511844224-32404-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4552880152109763911=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9381B266B0F
 for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2017 12:52:12 +0100 (CET)
In-Reply-To: <1511844224-32404-1-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org


--===============4552880152109763911==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vzvdiw5dgntn7l5w"
Content-Disposition: inline


--vzvdiw5dgntn7l5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2017 at 10:13:44AM +0530, Vijendar Mukunda wrote:

> -	acp_init(audio_drv_data->acp_mmio, audio_drv_data->asic_type);
> +	status =3D acp_init(audio_drv_data->acp_mmio, audio_drv_data->asic_type=
);
> +	if (status) {
> +		dev_err(&pdev->dev, "ACP Init failed\n");
> +		return status;
> +	}
> =20

Better to print the error code to help people see what went wrong.

>  static int acp_audio_remove(struct platform_device *pdev)
>  {
> +	int status;
>  	struct audio_drv_data *adata =3D dev_get_drvdata(&pdev->dev);
> =20
> -	acp_deinit(adata->acp_mmio);
> +	status =3D acp_deinit(adata->acp_mmio);
> +	if (status) {
> +		dev_err(&pdev->dev, "ACP Deinit failed\n");
> +		return status;
> +	}
>  	snd_soc_unregister_platform(&pdev->dev);

Remove operations can't meaningfully fail, better to just log the error
and carry on.

--vzvdiw5dgntn7l5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlodTecACgkQJNaLcl1U
h9B+oAf/Yu/LTK7xxSOEYlKwd6lo5PosdmH08qlURPKyIMayCqTRL68hg4yx532F
l1T4+PNZT3UXMxQDQP0G51IM7PQFVLk4TlMdJrwbVP55TeYBz6vHpTLjCkHrU/nB
mh7LDB6sPjF1dtabmLYy5TJgmpF0zP6ZAmK+OuQ48tahF1diz2rV/GeXmIk1/bHD
k4WPj8KE8yyx8A6O7dVLcrgvOBwEIWTLabHZx4LtOnKzScLqNpPw8/ocaPWVLLEx
/eJRrk1FQFPULsf5+fvU0Ay9mpWIFBcgw9LxNjCdg6+X3LMVdTDiRNzgjWnlep3x
QkUV1QbGZMcs7JsoyrYhLUwFXzay0Q==
=U1Jk
-----END PGP SIGNATURE-----

--vzvdiw5dgntn7l5w--

--===============4552880152109763911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4552880152109763911==--
