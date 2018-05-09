From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: davinci-mcasp: Use
	'snd_pcm_format_t' type
Date: Wed, 9 May 2018 17:34:12 +0900
Message-ID: <20180509083412.GT13402@sirena.org.uk>
References: <1525621665-11022-1-git-send-email-festevam@gmail.com>
 <1525621665-11022-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4282295334805558625=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D79712676F2
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 18:29:21 +0200 (CEST)
In-Reply-To: <1525621665-11022-2-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4282295334805558625==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GPT5DIEyVHz5yXBV"
Content-Disposition: inline


--GPT5DIEyVHz5yXBV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2018 at 12:47:44PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>=20
> 'snd_pcm_format_t' type is better suited for iterating through the
> SNDRV_PCM_FORMAT members.
>=20
> Also, use SNDRV_PCM_FORMAT_FIRST for the first element.

Adding Peter.

>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  sound/soc/davinci/davinci-mcasp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinc=
i-mcasp.c
> index 03ba218..bde2252 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -1214,11 +1214,12 @@ static int davinci_mcasp_hw_rule_format(struct sn=
d_pcm_hw_params *params,
>  	struct snd_mask nfmt;
>  	int rate =3D params_rate(params);
>  	int slots =3D rd->mcasp->tdm_slots;
> -	int i, count =3D 0;
> +	snd_pcm_format_t i;
> +	int count =3D 0;
> =20
>  	snd_mask_none(&nfmt);
> =20
> -	for (i =3D 0; i <=3D SNDRV_PCM_FORMAT_LAST; i++) {
> +	for (i =3D SNDRV_PCM_FORMAT_FIRST; i <=3D SNDRV_PCM_FORMAT_LAST; i++) {
>  		if (snd_mask_test(fmt, i)) {
>  			uint sbits =3D snd_pcm_format_width(i);
>  			int ppm;
> --=20
> 2.7.4
>=20

--GPT5DIEyVHz5yXBV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrysoMACgkQJNaLcl1U
h9DMBwf+PlLWsKWNZkEr1x5KYnrPkOFd+MYz6In/0zDUorMgXctda/88+Vm069Il
putZU3TZ0QxK3UPrGJKtVwD17ZJdVQOrDkOJuHNOMRYZDnP6eyhoixmzrh738JWw
o9CKRiK+HJnQAFSwnT4CdIA4HbGb9jMzWsKBGNl1wzwT47QSFpqX9sTLs0n7YBp4
oxX1k9kRiy3cJXS5fdWuSfxAbDvtnJ7VuyEfgS3ZmRoNKpRNWY9ux+LPza1UokrT
8fx7m+Es3gR2Wjw8hIhUjmRRZI6dlq8RI3PiYuUXaLoKLy+aLC6t9pyc6g3ZWcVO
gK6a1v7kU4EeqaRWWyEMVU85iSiJPg==
=cpj5
-----END PGP SIGNATURE-----

--GPT5DIEyVHz5yXBV--

--===============4282295334805558625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4282295334805558625==--
