From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_spdif: fix return value check in
 fsl_spdif_probe()
Date: Sat, 26 Oct 2013 21:34:12 +0100
Message-ID: <20131026203412.GC6362@sirena.org.uk>
References: <CAPgLHd-2d+RLDq1U=wXR72nAEH1Hr6FDcWp0eAyEkrNmfjrEaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1057235542725374029=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5850A261A57
 for <alsa-devel@alsa-project.org>; Sat, 26 Oct 2013 22:34:25 +0200 (CEST)
In-Reply-To: <CAPgLHd-2d+RLDq1U=wXR72nAEH1Hr6FDcWp0eAyEkrNmfjrEaA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, timur@tabi.org, rob.herring@calxeda.com, yongjun_wei@trendmicro.com.cn, grant.likely@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============1057235542725374029==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2013 at 05:29:25PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> In case of error, the function platform_get_resource() returns NULL
> pointer not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.

Applied, thanks.

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSbCdBAAoJELSic+t+oim9tXoP/R8vKktz5XS1Z9dhDYcNtlAw
fgsVHr0oSIqCXIO7vtLQH+HkFJoP80gWfP0DWAAmE24ho7AccKfohsTHSkYecuxd
rhnDRfQa22p8WTTGEcn6A01bm3dtOpGs3xw/claxRaGZEafaCXRFJaAwcdEWd/6N
gbhx2/v7vdNVxRWbL5BUFcVvNRo+DNN2rA5KugeK3e68KriCl6eg5iUrGhZKH0PB
tF3zr4bRslzVVEuUNic9VPjaiE9VzNmCTab0pHR8c3Na4NcoBANHnCBN/dGLkGwW
zF0kzAY6SLvgSCNSIqZIyvFXqMfsjEbiC4aikMtMw5ONdCqvBYb6ob5RP2r6GrD0
EzBaAnsLKgr2Nf5xNO40VAy8qYcnYPS4ATIzUYvO1WhOEkEINjjNBwBMNyBGi08M
rdhv8hiafQOKJsp3zibHCq0SbNbe3J0RPwF9cAz0qOErIWUT8JaFcGgeHaaVJ5f8
COsD1N805PCxT+tdGUNBo99x0cogG5vutUVB+hU9pX2GUDtjPudLP56PlUG7+K1J
fxCPVGk63iFhA7QcW5tYYR0671WjDgxMKNXEgtLve5ccoOJXgkrgYNYDt5vPMm8v
LBOL91XXIGW/7IGKddRniybriv7+/2hBdWbhPvWFMV5iC39X/z/C0eESdW/+k39E
fpEU/rQOWEhnq0AqTjvK
=UNV2
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--

--===============1057235542725374029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1057235542725374029==--
