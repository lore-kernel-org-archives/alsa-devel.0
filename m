From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] ASoC: amd: dma driver changes for BT
 I2S controller instance
Date: Mon, 16 Apr 2018 18:22:33 +0100
Message-ID: <20180416172233.GG20726@sirena.org.uk>
References: <1522355994-32039-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7950581420060845935=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C5E202673D2
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 19:22:34 +0200 (CEST)
In-Reply-To: <1522355994-32039-1-git-send-email-Vijendar.Mukunda@amd.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, Akshu Agrawal <akshu.agrawal@amd.com>, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org


--===============7950581420060845935==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VACxsDaSTfeluoxK"
Content-Disposition: inline


--VACxsDaSTfeluoxK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2018 at 02:09:54AM +0530, Vijendar Mukunda wrote:

> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> v1->v2: fixed kbuild errors
> ---

Please put inter-version changelogs after the --- as covered in
SubmittingPatches.

> +#ifdef CONFIG_SND_DESIGNWARE_PCM
> +		adata->i2s_capture_instance =3D dev->i2s_instance;
> +#else
> +		adata->i2s_capture_instance =3D I2S_SP_INSTANCE;
> +#endif

These ifdefs aren't great - we should be able to build a single kernel
image that works on all systems so if we've got configuration options
based on the presence of other drivers then presumably existing systems
are going to be disrupted here.  On the other hand if all systems are
able to use the Designware driver then we should just do that
unconditionally.

This will also break in cases where the Designware driver gets built as
a module. =20

--VACxsDaSTfeluoxK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrU29gACgkQJNaLcl1U
h9DucAf/cuXGoWKFNo0rzvd/l/VuIl2v+BLLLM3S7Z12aSKSFGN0pZgx/JelVnQv
XoGgRqsleqHjhN+U0bKENGjCNMqlroVrcRWrM3X+YRTiJajBQpSuPXOk5Rm/8IC5
Isp3QOiB+sAAc5om+VYQC76kicqod+9s64Qne48JURLXoN/mOCYknSBrdmVx4AkK
G/YprU4SB0PGrp5YYwgsetEIYbgX+QENxft7S44rG+VaocqaMr2gaxXCrGk9enHm
J+jti9sJ4Q2zgI3kWc/aEZLXAluMM0sQyGFlEvsv1yM8NM5Rk7YAYIfmkJSjg5Wa
klqrpM+X43YzRxUr2oHxtPwEJFOMoQ==
=n+/5
-----END PGP SIGNATURE-----

--VACxsDaSTfeluoxK--

--===============7950581420060845935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7950581420060845935==--
