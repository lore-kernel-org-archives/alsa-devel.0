From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap3pandora: Fix compilation error
Date: Wed, 6 Mar 2013 12:49:22 +0800
Message-ID: <20130306044920.GC4896@opensource.wolfsonmicro.com>
References: <1362493456-6674-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1439902527458805084=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C9596265311
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 05:50:05 +0100 (CET)
In-Reply-To: <1362493456-6674-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, notasas@gmail.com, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============1439902527458805084==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2013 at 03:24:16PM +0100, Peter Ujfalusi wrote:
> Fixes:
> sound/soc/omap/omap3pandora.c: In function =E2=80=98omap3pandora_dac_even=
t=E2=80=99:
> sound/soc/omap/omap3pandora.c:92:19: error: request for member =E2=80=98d=
ev=E2=80=99 in something not a structure or union
> make[3]: *** [sound/soc/omap/omap3pandora.o] Error 1

Applied, thanks.

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRNspjAAoJELSic+t+oim9f/YP/iUVNOR9WANszGqyzxn4SJko
mjgKpwdpfg9RByb5Eet1HdK6kTMyDCCxgclk2jIQsoKO9h7K3tvisdArciPYRCWe
16B69Ty7ESLQP2NyxSLEjndA76kuHUDzDtyGEhzNokEso90fUqu+LicmxoPVg564
UywD178H0U1vivCgfdYJTAU7ukvlzYsoaV7vj3oGBVHw8QnE/K71WQDxo9hjZkJ0
PWPS1bRy+BI0sRZI0FqiI+S+bp1Lj6Jt7MLQC1zWkY/8QU8DBzEs/QBaX7LHjkHF
j1uv5sNNk+h3EZAmy0I7LeyJLWHlJe2jRuXvN3zlhpCowWvW4/H+oZGWECD+9rwf
hrPtAjN19CcFRWApZWF1pdG77aKUmyE/mvgAOJHkUWr6bgakwJJQk0c90nVtfRZj
knrPIBGnf7cgJfiNKT91zxHmOQFB80ZvkeR5aWU7sSi1ViVDggbAV0sepsxP3b5W
R3SIDcViK/1bnxwTnt0LwrtdrOmYYtdYTVDazuWszB4hRebUsp9RXic65La0K+KO
YLRtJHKTVvOdUxokNzO/fOAd8zNd9hpNqZrw7geM+HGrm1H75zQGRHUvoNnNVjbD
CtyA1VrPs0ZEPDTYM1UshiGIcPBSh/kHPLhvDQvEtxDiLErevihE+3J0WYHqMACT
BxW4b4SEUd8u3knB1Tkp
=U5Qh
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--

--===============1439902527458805084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1439902527458805084==--
