From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix check for pdata usage
 before dereference.
Date: Mon, 5 May 2014 12:42:09 -0700
Message-ID: <20140505194209.GU22111@sirena.org.uk>
References: <1399292423-4675-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3204894240199859661=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 52153261AA1
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 02:58:41 +0200 (CEST)
In-Reply-To: <1399292423-4675-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3204894240199859661==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5M2fOMh7RWu7idz2"
Content-Disposition: inline


--5M2fOMh7RWu7idz2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2014 at 01:20:23PM +0100, Liam Girdwood wrote:
> This patch fixes the following dereference check ordering.
>=20
>  sound/soc/intel/sst-haswell-pcm.c:749 hsw_pcm_probe() warn: variable der=
eferenced before check 'pdata' (see line 746)

Applied, thanks.

--5M2fOMh7RWu7idz2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZ+mOAAoJELSic+t+oim9YL0P/1Ina4yzn0mx8SxMgOSBLu2l
Egh3FYn4gPMvAr4KQKurevZ2g7NgxWsDUpXCv+lhNtAhiqe5i9NQg1FYKUozbsjA
j86SUg1Hr1J7TVo1X8Lp78Yt682PMwnkSQyyBNyeCbl267NM4R2iXoDn7jhJa+4H
wIU/KtFq+Cj4jfEeuSQmArLpyYlwbgxpHhmaFstAsx8CJl7IWFakBgejaiClPAw5
ixivuCuwCXRp+WtA3DgUArjHaagxmtL9rLfCga/4gTX2mQWLVWGr++wNlTWNwZhX
+w/m2/KkS+2wYlcnSANzFUTx5Ya/k9RGhno57MhAqRaRJ0m2mNbwIjNd3uZ1SbJs
phnbLDlcZRg32kiAWyA0FGn9JUINCPtkQTLYqvLiFg480hj6bdTFHN5n4pP1SLuU
KhI9AUZXGlnbfnYu/KKhrWMi4q6d5KzGM0+BIlODeaizGlIfHz5dQPWLAeJGRrS6
2gSnFTarZr0BHr2vStw9CLS24VRLJb9CSveg8aB09YpQFDah49vTEwx8K6DGCwi+
yu77il8b8CgZiFV3UIc+xAI7RTGBD5mvfjbaTZngHlZt7LqEp6ff20Ng4GqAhMA+
CU5GKSqheDuUFPWg9+lrs3jUHx9/SiVVQxuR6N+KLB5tCqC15XRyBoVjCXkZpubF
tLXIEWfz2Bdzb0Bm1tLs
=78K1
-----END PGP SIGNATURE-----

--5M2fOMh7RWu7idz2--

--===============3204894240199859661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3204894240199859661==--
