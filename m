From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 07/23] ASoC: au1x: psc-ac97.c: use
 devm_snd_soc_register_component()
Date: Tue, 2 Jul 2019 13:39:10 +0100
Message-ID: <20190702123910.GJ2793@sirena.org.uk>
References: <87blyitky2.wl-kuninori.morimoto.gx@renesas.com>
 <871rzetkuo.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1879959332006279851=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F370F800C5
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2019 14:39:12 +0200 (CEST)
In-Reply-To: <871rzetkuo.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============1879959332006279851==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VIOdPewhitSMo36n"
Content-Disposition: inline


--VIOdPewhitSMo36n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2019 at 01:08:34PM +0900, Kuninori Morimoto wrote:

> @@ -426,8 +426,6 @@ static int au1xpsc_ac97_drvremove(struct platform_dev=
ice *pdev)
>  {
>  	struct au1xpsc_audio_data *wd =3D platform_get_drvdata(pdev);
> =20
> -	snd_soc_unregister_component(&pdev->dev);
> -
>  	/* disable PSC completely */
>  	__raw_writel(0, AC97_CFG(wd));
>  	wmb(); /* drain writebuffer */

I don't think this is 100% safe - with this change we will turn
off the hardware block before we unregister the component which
means that we might try to interact with it.  If we're converting
to devm then we need to be careful the ordering of the removal
won't be affected.

--VIOdPewhitSMo36n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0bUG0ACgkQJNaLcl1U
h9BAFwf8DW6cBSudo2opgcNsGeY8xGFnPbqd0ajz/RRPlbykaiH8TlHNBVomjtZM
LFyZFlyfUUzwOQZqozrWjSmrB+bzLL3owLqG8ndtIPJla4YWOYSZuDdLNFyhaMpx
bvifOcYwsxBq2lZS6SLmW0BH+dIMm67g8pbf9LIStNLZxKtLZhYoT+rJJilWHVhQ
aVEUvipsP//JSEmZkA2jlfryks+Oz6FdLI6yWm8tshGVKUPe00SmdvRLAgwY4Ifm
FjMhLKZ2sefEZk70vCu9kg+WISRvKRTQQoebVYwKdUwlCeyIX23Gpmoprt4vM15I
T06e2uN40XC6wDU/jya5b43WqUxZfA==
=Vu+5
-----END PGP SIGNATURE-----

--VIOdPewhitSMo36n--

--===============1879959332006279851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1879959332006279851==--
