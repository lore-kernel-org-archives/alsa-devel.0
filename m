From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_asrc: add protection for the
 asrc of older version
Date: Fri, 1 Mar 2019 12:38:08 +0000
Message-ID: <20190301123808.GD7429@sirena.org.uk>
References: <1551407560-29950-1-git-send-email-shengjiu.wang@nxp.com>
 <20190301025356.GA1371@Asurada-Nvidia.nvidia.com>
 <VI1PR0402MB339254C31997242633511D12E3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7152685344975657058=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15FE4F896C0
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2019 13:38:16 +0100 (CET)
In-Reply-To: <VI1PR0402MB339254C31997242633511D12E3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org


--===============7152685344975657058==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Content-Disposition: inline


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2019 at 06:55:25AM +0000, S.j. Wang wrote:

> > Alternatively, I feel instead of error-out at here, should we add a HW
> > constraint or at least fence it off at the beginning of the hw_params()=
? This
> > is actually nothing specific to the pair-request function but a hardware
> > constraint.

> How about add constraint in startup?
> static int fsl_asrc_dai_startup(struct snd_pcm_substream *substream,
>                                struct snd_soc_dai *dai)
> {
>        struct fsl_asrc *asrc_priv =3D snd_soc_dai_get_drvdata(dai);
>=20
>        if (asrc_priv->channel_bits =3D=3D 3) {
>                snd_pcm_hw_constraint_step(substream->runtime, 0,
>                                           SNDRV_PCM_HW_PARAM_CHANNELS, 2);
>        }
>=20
>        return 0;
> }

Yes, that's definitely good - the general idea is that we should never
need to return an error from hw_params() as the constraints code will
have filtered out any invalid configurations before they get that far.

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx5J7AACgkQJNaLcl1U
h9DsGQf/bJGiExAa++xw/8QvG1DHS0vZLwlo/TnEygG+NNpXo3DdaJAVVoESwF8e
tz0uKNgBgt9QIx2ZRxRiebIjBA+bpOavCudSOlNwitOoiulffqVLbzQ9aZwo8uJJ
LksiHyYasvA7lW+6dw+DjOTv0yctUyWOfMPoj5V9GaxT41fBbCMd80XO6jxS6Y4v
tHe5BNXH2fgX8M4gZFdDXlC6XOw2/lYvONyHsPPR0ZSFYHii8SSu2yaZYJdjudrX
5hAp3F5ivklIxRhMVdpev8yBclbrHgJPrGeRD/nNa59Myh8Lml3UDs8KBOEV2n2U
nh/gUw6MTouDYI+PKZ3VEZyRIMbqIw==
=MsFr
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--

--===============7152685344975657058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7152685344975657058==--
